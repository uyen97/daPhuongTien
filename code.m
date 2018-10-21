[data, fs] = wavread('D:\orig_input.wav');
[rows colums] = size(data);
fs = 44100; % sampling frequency (Hz)
t = 0 : 1/fs : 5; % time axis (seconds)
f1 = 440; % frequency (Hz)
f2 = 2 * f1
f3 = 3 * f1;
f4 = 4 * f1;
A1 = 0.3; A2 = A1/2; A3 = A1/3; A4 = A1/4;
w = 0; % phase

y1 = A1 * sin( 2 * pi * f1 * t + w );
y2 = A2 * sin( 2 * pi * f2 * t + w );
y3 = A3 * sin( 2 * pi * f3 * t + w );
y4 = A4 * sin( 2 * pi * f4 * t + w );

y = [y4 y2 y3 y1];
melody = y(1:length(data));

for i = 1:colums
    for j = 1:rows
        melody(j+i) = data(j,i) + y(i+j);
        
    end
end

wavwrite(melody, fs, 'D:\melody.wav');

%fft
X=fft(melody);
N=fs; % number of FFT points
subplot(1,2,1);
plot(abs(X));
title('Figure 1');

transform = fft(melody,N)/N;
magTransform = abs(transform);
faxis = linspace(-fs/2,fs/2,N);

subplot(1,2,2);
plot(faxis,fftshift(magTransform));
title('Figure 2');
xlabel('Frequency (Hz)');

%spectrogram
win = 128 % window length in samples
% number of samples between overlapping windows:
hop = win/2            

nfft = win % width of each frequency bin 
spectrogram(melody,win,hop,nfft,fs,'yaxis')

% change the tick labels of the graph from scientific notation to floating point: 
yt = get(gca,'YTick');  
set(gca,'YTickLabel', sprintf('%.0f|',yt))