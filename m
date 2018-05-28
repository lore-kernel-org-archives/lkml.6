Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753581AbeE1G4r (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 02:56:47 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:56880 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753544AbeE1G4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 02:56:45 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180528065643epoutp034420f984d72a263b6131788e5095ea4d~yvJxQjlzu0098100981epoutp03Z
X-AuditID: b6c32a35-b89ff70000000fe2-88-5b0ba8283d26
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5B0BA828.4070903@samsung.com>
Date: Mon, 28 May 2018 15:56:40 +0900
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
Subject: Re: [PATCH 05/11] PM / devfreq: governors: Return device frequency
 limits instead of user limits
In-reply-to: <20180525203043.249193-6-mka@chromium.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe3a3e+fa9GlmPhiZXYlUcHm3Nq/RIijiRgUjIUozu+htytwL
        u9My+rCKfOtdpcBqGmKlWeZ8yRSzdNmnDHuxKDLCWBahhFlaZN27W9Sn5//8z+8czjkcJaat
        wmOU+Q4P53awBSSukncOJOqSE67Oz0x581VH/6wcJGj/50kFXRsYUtAPL9/D6SP1LTj98PAn
        gn7SfQGnp04EAN3wfFhGT90cA/SrQ1dx+mhvgFinZpp9zYD58b0SMOe9w3LG31SOM30Xmwnm
        ZHsTYKb8sRYig1uTx7G5nDuOc+Q4c/MdVjO5OT17fbbRlEIlU2l0KhnnYO2cmdywxZK8Mb9A
        6JSMK2ILCgXLwvI8uXLtGrez0MPF5Tl5j5nMpCi9jkpJ1en1wmvIWq03CsgeLq/0WhVwfYve
        P3h2WuYFjZEVIEyJ4CrUMPieELUWdgF052lCBVAJ+htAgWCT/C/0zl+FSYEegC42vgViQAMX
        oJmqUQFSKjG4FAUe20Qbg4moo6eFkPjXAM1VlsslPgl1NA7LRC2Hy9Fo4C0ualzw+8ZfhHQE
        XIaezYyF6kfBHeh27ddQdwthOqqbfSQXi2JwWoa6J2pDUCS0ofsfTilEHQZTUdu5NoUIIXiE
        EKoOKKQRNqC26rI/OhJ9fNBOiF0juBg9vm+W+FKASnt9mPSpBmjo+ahMSjCg4KUKmTRbOJqY
        Pq6QkjWorEQrIQzyfagH0si3AGodD4LTYEnNf1uq+belmv+2VAewJrCIc/F2K8dTLkrHs3a+
        0GHV5TjtfhA6yCRjF6ge2tIPoBKQao33hypTq2CL+GJ7P0BKjFyoUSULliaXLT7AuZ3Z7sIC
        ju8HRmHJZ7CYqByncN4OTzZl1BsMBnoVZTJSFBmtKUmdy9BCK+vhbBzn4tx/82TKsBgvyD+z
        e+aaacxaxHa3dm4Mn79S7+vZt+PgxNbhNGSJ7xuIPbvTue18ROBA8PicwtyihoGRyfGGtKFd
        L3O2h4+2f6kcsf10NW/SeU2Jd00r0tdHnlKX+JjBEidruRG/KPp7vbrzZPza2b3zgnzxr6wr
        1x+NqGwy87aEY3sHJmMd1d2knM9jqSTMzbO/AUQ43HimAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42I5/e+xgK7GCu5ogxcX5Sz+TjrGbrHp43tW
        i/lHzrFanF12kM2iefF6NouzTW/YLS7vmsNm8bn3CKPF0usXmSw+b3jMaHG7cQWbReveI+wO
        PB5r5q1h9Pj9axKjx+yGiywem1Z1snnsn7uG3aNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgy
        2ldPZiz4Ll5xbNpXpgbGlcJdjJwcEgImEk82TWbuYuTiEBLYySjx99FxFpAEr4CgxI/J94Bs
        Dg5mAXmJI5eyQcLMAuoSk+Ytgqq/zyix6/9LqHotia0rLzKB2CwCqhL3jjxkA7HZgOL7X9wA
        s/kFFCWu/njMCDJTVCBCovtEJUhYRCBY4kNzDxvITGaBr0wSz/62M4MkhAWyJY6+7GeFWLad
        UWLyhj6wBZwC5hKbp29mncAoMAvJrbMQbp2F5NYFjMyrGCVTC4pz03OLjQoM81LL9YoTc4tL
        89L1kvNzNzECY2bbYa2+HYz3l8QfYhTgYFTi4W34zRUtxJpYVlyZe4hRgoNZSYSXSxcoxJuS
        WFmVWpQfX1Sak1p8iFGag0VJnPd23rFIIYH0xJLU7NTUgtQimCwTB6dUA+O2isdbjlf3G/59
        OnXnpHc/Z5kFWm6dc0iWyWzPhTsqhtXBJtt6faTWTX/IfH/dTZ4EtZayBMt/zc4hoTlzHFVk
        kl45MKlut9+/Tuq6xIVruye5q6kfaPQ//3dd1ssZBs2/uRtSltcov4uZxaMkXbLd4s6VuXYH
        DzcIafAu+LjiZ83kdpEV9Y1KLMUZiYZazEXFiQC/9VN+lQIAAA==
X-CMS-MailID: 20180528065640epcas1p14d8921e00ea995c6c5e09952d57b1bff
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180525203310epcas4p34b5ad54243a2e93c7e5bff019ac9e627
References: <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203310epcas4p34b5ad54243a2e93c7e5bff019ac9e627@epcas4p3.samsung.com>
        <20180525203043.249193-6-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 05월 26일 05:30, Matthias Kaehlcke wrote:
> The performance, powersave and simpleondemand governors can return
> df->min/max_freq, which are the user defined frequency limits.
> update_devfreq() already takes care of adjusting the target frequency
> with the user limits if necessary, therefore we can return
> df->scaling_min/max_freq instead, which is the min/max frequency
> supported by the device at a given time (depending on the
> enabled/disabled OPPs)

As you mentioned on the description, update_devfreq() adjusts
the final target frequency. So, actually, there are no any
benefits when changing from max_freq/min_freq to scaling_max/min_freq.

I think that it is not necessary.

> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/governor_performance.c    | 2 +-
>  drivers/devfreq/governor_powersave.c      | 2 +-
>  drivers/devfreq/governor_simpleondemand.c | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
> index 1c990cb45098..a8e3478b3c43 100644
> --- a/drivers/devfreq/governor_performance.c
> +++ b/drivers/devfreq/governor_performance.c
> @@ -20,7 +20,7 @@ static int devfreq_performance_func(struct devfreq *df,
>  	 * target callback should be able to get floor value as
>  	 * said in devfreq.h
>  	 */
> -	*freq = df->max_freq;
> +	*freq = df->scaling_max_freq;
>  	return 0;
>  }
>  
> diff --git a/drivers/devfreq/governor_powersave.c b/drivers/devfreq/governor_powersave.c
> index 0c42f23249ef..8696efd32e5a 100644
> --- a/drivers/devfreq/governor_powersave.c
> +++ b/drivers/devfreq/governor_powersave.c
> @@ -20,7 +20,7 @@ static int devfreq_powersave_func(struct devfreq *df,
>  	 * target callback should be able to get ceiling value as
>  	 * said in devfreq.h
>  	 */
> -	*freq = df->min_freq;
> +	*freq = df->scaling_min_freq;
>  	return 0;
>  }
>  
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index 3da7554b4837..805fee09c754 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -46,7 +46,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  
>  	/* Assume MAX if it is going to be divided by zero */
>  	if (stat->total_time == 0) {
> -		*freq = df->max_freq;
> +		*freq = df->scaling_max_freq;
>  		return 0;
>  	}
>  
> @@ -59,13 +59,13 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  	/* Set MAX if it's busy enough */
>  	if (stat->busy_time * 100 >
>  	    stat->total_time * dfso_upthreshold) {
> -		*freq = df->max_freq;
> +		*freq = df->scaling_max_freq;
>  		return 0;
>  	}
>  
>  	/* Set MAX if we do not know the initial frequency */
>  	if (stat->current_frequency == 0) {
> -		*freq = df->max_freq;
> +		*freq = df->scaling_max_freq;
>  		return 0;
>  	}
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
