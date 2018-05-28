Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753470AbeE1Gh5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 02:37:57 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:29737 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeE1Ghx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 02:37:53 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180528063751epoutp02c66eef5c46589faa05271e5ace8792c1~yu5TmhaOJ1394513945epoutp02s
X-AuditID: b6c32a35-b89ff70000000fe2-d4-5b0ba3bb98b6
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5B0BA3BB.8060505@samsung.com>
Date: Mon, 28 May 2018 15:37:47 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 02/11] PM / devfreq: Fix handling of min/max_freq == 0
In-reply-to: <20180525203043.249193-3-mka@chromium.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUURTHuTu7M6O1dtteVyuzoSKX3JzdNifLiIoYtA+CFJHEOriDbu7D
        ZlbpQbGZr8xeFgRmrdqDEMPcXmaapGsPScOtSDT7EqWVqGUP016zO0Z+uv97+P0P5/w5JKYp
        wcNIi93JC3bOSuHBylstkbqouxemJEc3nIlkfpU8IBjPpyEV4/Z2qJj2y/dx5tCFGpxpzxkg
        mGf1ZTgzctQLmEsvOxXMyLU3gOk5eAVn8hq9xLqpbPX5asCOj5UA9qyrU8l6qg7jbNO5aoI9
        dqMKsCOe8ERiO78mnefMvBDB21MdZos9LY5KSDJtMBlXRtNR9ComhoqwczY+jtq4OTFqk8Uq
        TUpFZHPWLKmUyIkitXztGsGR5eQj0h2iM45Kpmm9jo6O0en10mvYEas3SkgKn1589Lkis2Lh
        7ovN54AL/A4tAkEkgitQd12esggEkxpYB1BH6w8gf74DVNNfqPpHXT/sVfi1Bl4DqLN3tV+r
        4XQ0euq15CZJDC5AXl+Gv4zBSHTzbg0h470A5TSYZVyLcttOBdoo4WL06k+L0q9xqd7U34X7
        9TS4EL0YfQP8ehbchu64vwX6zIRJqPzH08CgGPyqQPWD7gA0A8ajS13jAXMQjEF9Yy7MDyF4
        hEC1n924vMBG9L796cQyM9CHhzcI/9AIzkW+1jiZLwCooPH8hPm0FMXL1wrZYEDvKooU8moh
        aPBrsUo2q1FhvkZGWDTe6JtI7jZAx8uGiRNgfumkkEr/h1Q6KaRygFWB2XymaEvjRTqT1omc
        Tcyyp+lSHTYPCNyj1lgHTndsbgaQBNRUtWs8OFmj4rLFPbZmgEiMmqkOjpJKajO3Zy8vOExC
        lpUXm4FRCvkkFjYr1SFdt91poo16g8HArKBXGmmamqPOj/m9XQPTOCefwfOZvPDPpyCDwlwg
        hB4RPu50X3UvffbdnnF8S8fPnJS25QkHwgs+bk3N1YqeJN8tqIm3TZtffHN93aN27G1OJBuq
        FT/sr328ymHZ9bgy93ql7XL4OuJb7agpts/cvbfUUuIOHR7o7RnLKxyuzf785YmvvquhLSRl
        aN76ciuxCBvakr9VuMe17FtWvIRSiukcrcUEkfsL+cYTCaUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42I5/e+xoO7uxdzRBhfviVn8nXSM3WLTx/es
        FvOPnGO1OLvsIJtF8+L1bBZnm96wW1zeNYfN4nPvEUaLpdcvMll83vCY0eJ24wo2i9a9R9gd
        eDzWzFvD6PH71yRGj9kNF1k8Nq3qZPPYP3cNu0ffllWMHp83yQWwR3HZpKTmZJalFunbJXBl
        9PReYSpYqFix5NBcxgbGf5JdjJwcEgImEps7jzB1MXJxCAmsY5R4fvIBI0iCV0BQ4sfkeyxd
        jBwczALyEkcuZYOEmQXUJSbNW8QMYgsJ3GeUuHA8F6JcS6Ll1GQmEJtFQFXizv/DLCA2G1B8
        /4sbbCA2v4CixNUfjxlBRooKREh0n6gECYsIBEt8aO5hAzmBWeArk8Szv+1g84UFvCSW3vjN
        BnHbdkaJQ3M+sYMkOAXMJZ7/amCewCgwC8mpsxBOnYXk1AWMzKsYJVMLinPTc4uNCgzzUsv1
        ihNzi0vz0vWS83M3MQIjZtthrb4djPeXxB9iFOBgVOLhbfjNFS3EmlhWXJl7iFGCg1lJhJdL
        FyjEm5JYWZValB9fVJqTWnyIUZqDRUmc93besUghgfTEktTs1NSC1CKYLBMHp1QDo6v1Mv/t
        4Z+X98nFsyTMSbm5/wK79bJVt1KiF7/Trdo/+/VjCSb1q78nhAQt6fnfLbTgwLb+lVc8b6pq
        tWz+emp9ZKPM+sas/ace3BLsOLzuw4bfDz5dKTm3zsfM7XC/k+TENjkOxVzddbtnqrBtdHl6
        ZZXkMs9nB67/YPB8PCmFV+NT7E6+UiMlluKMREMt5qLiRABiJeeklAIAAA==
X-CMS-MailID: 20180528063747epcas1p28a9d477c132a23dc4cd0a5306e9a711e
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180525203323epcas4p45ba35c38413e227f76f68fe331011b19
References: <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203323epcas4p45ba35c38413e227f76f68fe331011b19@epcas4p4.samsung.com>
        <20180525203043.249193-3-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 05월 26일 05:30, Matthias Kaehlcke wrote:
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
> index 0057ef5b0a98..67da4e7b486b 100644
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

If you want to prevent that df->min_freq is zero, 
you should reinitialize 'value' as following.
Because freq_table must be in ascending order.
	value = df->profile->freq_table[0];


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

ditto.
	value = df->profile->freq_table[df->profile->max_state - 1];

> +	} else {
> +		if (value < df->min_freq) {
> +			ret = -EINVAL;
> +			goto unlock;
> +		}
>  	}
>  
>  	df->max_freq = value;
> 

Actually, min_freq_store() and max_freq_store() are very similar.
But, this patch changed the order of conditional statement as following:
If there is no special reason, you better to keep the same format
for the readability.


min_freq_store()
	if (value) {
		...
	} else {
		value = df->profile->freq_table[df->profile->max_state - 1];
	}


max_freq_store()
	if (!value) {
		value = df->profile->freq_table[0];
	} else {
		...

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
