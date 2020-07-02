function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%
C_cv = [0.01 0.03 0.1 0.3 1 3 10 30];
sigma_cv = [0.01 0.03 0.1 0.3 1 3 10 30];
Error = zeros(size(C_cv,2),size(sigma_cv,2));
for i = 1:size(C_cv,2)
  for j = 1:size(sigma_cv,2)
    
     model= svmTrain(X, y, C_cv(i), @(x1, x2) gaussianKernel(x1, x2, sigma_cv(j)));
     predictions = svmPredict(model, Xval);
     Error(i,j) = mean(double(predictions ~= yval));
    
  end
end

[C_cv_idx sigma_cv_idx] = ind2sub(size(Error),find(Error == min(min(Error))));
C = C_cv(C_cv_idx);
sigma = sigma_cv(sigma_cv_idx);



% =========================================================================

end
