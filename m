Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeEQX2I (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 19:28:08 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:28962 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbeEQX2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 19:28:06 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180517232803epoutp04d0abdd9d0f080442050cd49d6344814e~vklL9-a5n2864028640epoutp04e
X-AuditID: b6c32a38-70fff7000000105c-ae-5afe0ffc5b52
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5AFE0FFB.6050408@samsung.com>
Date: Fri, 18 May 2018 08:27:55 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] PM / devfreq: Fix handling of min/max_freq == 0
In-reply-to: <20180517223255.211918-1-mka@chromium.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7bCmge4f/n9RBsu+mlhs+vie1eLssoNs
        Fmeb3rBbXN41h83ic+8RRovPGx4zWtxuXMHmwO4xu+Eii0ffllWMHp83yQUwR6XaZKQmpqQW
        KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAtV1IoS8wpBQoFJBYX
        K+nb2RTll5akKmTkF5fYKkUbGhrpGRqY6xkZAWnjWCsjU6CShNSM54+3MhWckak4Of0cYwPj
        ErEuRk4OCQETib8bTrB2MXJxCAnsYJTY37GTHcL5zijx/PYRNpiqJU/ms0AkNjBKfHn7mxUk
        wSsgKPFj8j2gBAcHs4C8xJFL2SBhZgFNia2710MNusso8bDhFAtEvZbEwv17wHpZBFQlvn1r
        BrPZgOL7X9wAW8YvoChx9cdjRhBbVCBCYuf8b+wg80UE6iRWfKkHmcks0M8osbFxEVivsICL
        xK477WDzOQXMJc43TwF7R0LgAJvEm8fzWCA+cJFYcPIWO4QtLPHq+BawoRIC0hKXjtpC1Lcz
        SrTvnccM4UxhlDh3/R4TRIOxxLOFXUwQr/FJvPvawwrRzCvR0SYEUeIh8XTlH2YI21GiqXkl
        G8T3XYwSnb9+sU1glJuFFGCzEAE2CynAFjAyr2IUSy0ozk1PLTYsMNErTswtLs1L10vOz93E
        CE5vWhY7GPec8znEKMDBqMTD+2Li3ygh1sSy4srcQ4wSHMxKIrx+lUAh3pTEyqrUovz4otKc
        1OJDjKbA8J7ILCWanA9MvXkl8YamRsbGxhYmhmamhoZK4rxzlL5GCQmkJ5akZqemFqQWwfQx
        cXBKNTDub7MJ6Qk+eaLy2aJHTf9jUpfef9ET9H7Xj9Px2ptrQ10+ibWfyL+dcqLNVHeZ8LxC
        y7PeW24dOe9xhfOazgl9U/n7M2IVy/yWCEdulebM65koKpoveSzTzvYor5DDy0/ed9kS1J0+
        6kj8vTe9au2+F1dNBe7NerS3/5P2pzLLXRu/+vTmymUpsRRnJBpqMRcVJwIAPbMqW4UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsVy+t9jQd3f/P+iDI4dVrLY9PE9q8XZZQfZ
        LM42vWG3uLxrDpvF594jjBafNzxmtLjduILNgd1jdsNFFo++LasYPT5vkgtgjuKySUnNySxL
        LdK3S+DKeP54K1PBGZmKk9PPMTYwLhHrYuTkkBAwkVjyZD5LFyMXh5DAOkaJY9PPsIAkeAUE
        JX5Mvgdkc3AwC8hLHLmUDRJmFlCXmDRvETNE/X1GiTtNMPVaEgv372EFsVkEVCW+fWsGs9mA
        4vtf3GADsfkFFCWu/njMCDJTVCBCovtEJcgcEYEGRonGV7PZQBxmgYmMEldX3QNrFhZwkdh1
        px3quh5GiYXTD4Jt4xQwlzjfPIV1AqPALCTHzkI4dhaSYxcwMq9ilEwtKM5Nzy02KjDMSy3X
        K07MLS7NS9dLzs/dxAgM7W2Htfp2MN5fEn+IUYCDUYmH98XEv1FCrIllxZW5hxglOJiVRHj9
        KoFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeW/nHYsUEkhPLEnNTk0tSC2CyTJxcEo1MDJten3x
        8IS0g8cmykSuaNS7eGjhxultRYKeqnN1nvzxP7fpxbOJNbMTdFO1le648LUyJuSd3Tttu8+p
        KGPNxl0yFkIdh12K2qLl9rMz8+8+taD/eN1B69fPHxnl80lM+bPmlCL3kY9ZDBOXbZL8l97k
        lf7tm4mW0aSlX7Zetfyz6VQ5M+8kbyElluKMREMt5qLiRACN/Gp+aQIAAA==
X-CMS-MailID: 20180517232755epcas1p129a2405bfc2d5e9e01576bc1bd015a11
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180517223318epcas3p2c4bf4ef6d2c1c4b097df92c309adafa6
X-RootMTR: 20180517223318epcas3p2c4bf4ef6d2c1c4b097df92c309adafa6
References: <CGME20180517223318epcas3p2c4bf4ef6d2c1c4b097df92c309adafa6@epcas3p2.samsung.com>
        <20180517223255.211918-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please resend the patch with related other patches.
It is hard to check the dependency/sequence of your patches.

On 2018년 05월 18일 07:32, Matthias Kaehlcke wrote:
> Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding the
> devfreq device") initializes df->min/max_freq with the min/max OPP when
> the device is added. Later commit f1d981eaecf8 ("PM / devfreq: Use the
> available min/max frequency") adds df->scaling_min/max_freq and the
> following to the frequency adjustment code:
> 
>   max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
> 
> With the current handling of min/max_freq this is incorrect:
> 
> Even though df->max_freq is now initialized to a value != 0 user space
> can still set it to 0, in this case max_freq would be 0 instead of
> df->scaling_max_freq as intended. In consequence the frequency adjustment
> is not performed:
> 
>   if (max_freq && freq > max_freq) {
> 	freq = max_freq;
> 
> To fix this set df->min/max freq to the min/max OPP in max/max_freq_store,
> when the user passes a value of 0. This also prevents df->max_freq from
> being set below the min OPP when df->min_freq is 0, and similar for
> min_freq. Since it is now guaranteed that df->min/max_freq can't be 0 the
> checks for this case can be removed.
> 
> Fixes: f1d981eaecf8 ("PM / devfreq: Use the available min/max frequency")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index fe2af6aa88fc..e007534297f7 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -283,11 +283,11 @@ int update_devfreq(struct devfreq *devfreq)
>  	max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
>  	min_freq = MAX(devfreq->scaling_min_freq, devfreq->min_freq);
>  
> -	if (min_freq && freq < min_freq) {
> +	if (freq < min_freq) {
>  		freq = min_freq;
>  		flags &= ~DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use GLB */
>  	}
> -	if (max_freq && freq > max_freq) {
> +	if (freq > max_freq) {
>  		freq = max_freq;
>  		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
>  	}
> @@ -1123,17 +1123,20 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>  	struct devfreq *df = to_devfreq(dev);
>  	unsigned long value;
>  	int ret;
> -	unsigned long max;
>  
>  	ret = sscanf(buf, "%lu", &value);
>  	if (ret != 1)
>  		return -EINVAL;
>  
>  	mutex_lock(&df->lock);
> -	max = df->max_freq;
> -	if (value && max && value > max) {
> -		ret = -EINVAL;
> -		goto unlock;
> +
> +	if (value) {
> +		if (value > df->max_freq) {
> +			ret = -EINVAL;
> +			goto unlock;
> +		}
> +	} else {
> +		value = df->profile->freq_table[df->profile->max_state - 1];
>  	}
>  
>  	df->min_freq = value;
> @@ -1158,17 +1161,20 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  	struct devfreq *df = to_devfreq(dev);
>  	unsigned long value;
>  	int ret;
> -	unsigned long min;
>  
>  	ret = sscanf(buf, "%lu", &value);
>  	if (ret != 1)
>  		return -EINVAL;
>  
>  	mutex_lock(&df->lock);
> -	min = df->min_freq;
> -	if (value && min && value < min) {
> -		ret = -EINVAL;
> -		goto unlock;
> +
> +	if (!value) {
> +		value = df->profile->freq_table[0];
> +	} else {
> +		if (value < df->min_freq) {
> +			ret = -EINVAL;
> +			goto unlock;
> +		}
>  	}
>  
>  	df->max_freq = value;
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
