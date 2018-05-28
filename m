Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753313AbeE1F2C (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 01:28:02 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:19404 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753137AbeE1F17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 01:27:59 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180528052757epoutp010f5b8fd2f525a695b50899aed896b9f2~yt8RM6b2f1090610906epoutp01W
X-AuditID: b6c32a35-ba1ff70000000fe2-38-5b0b935b4f6e
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5B0B935A.8010306@samsung.com>
Date: Mon, 28 May 2018 14:27:54 +0900
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
Subject: Re: [PATCH 03/11] PM / devfreq: Remove check for df->max_freq == 0
 from governors
In-reply-to: <20180525203043.249193-4-mka@chromium.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3bOzjlay6+V9WGU81BBgsuzNXcKl91ZZSAUEVmtkx42yW26
        s0kFwUq7mUnN6KK1FeEos4xpF6d2UTNI1NSiLCsqiu43s+ze2U5Rf33P+3y/F5735aUwZQkR
        Q2XZnLzDxmXTRCR+tmmiOiG9ZHB6Ym+TnP3haSHZwPu3ctbX3C5n2/yXCTb/aBXBtm16RbLd
        wYME27ezGbDltzplbN/px4C9u/EYwW5uaCanDzFWeiuB8dtXDzCWuTtxY6BiO2G8eKiSNBbX
        VABjX2BsGrmMT7bwXCbvUPG2DHtmls1soBcsMs0y6ZISmQRmCqunVTbOyhvo2alpCXOzssWk
        tCqPy3aJVhonCPSkackOu8vJqyx2wWmg0xlGo2YS9WqNRny1K6ZqdCKyirds/FiL53xVri0u
        sLhBcVQhiKAQnIzu+J/ICkEkpYTnAXpZdBKXis8ANeQ/xP5SpQX9f6g6gL4X1eGhDwUchgZK
        7ouaojAYi5q71oRsDE5EZ+qqSIm/B1BX2SWZxMejHbs9ZEjjcDx60loDQpoQ/YvPbhMhHQXj
        0M2Bx2E/Gi5Ftb5PYX4EXIQOf+kIp8NgvwwF3/jC0HC4HBU9uxEOFAH1yPurNwwhmE+ivSdP
        yaQRZqOHTU1A0sPRi6s1ZCg1gqNR1xWDxG8FaGuDF5OKPQC137r/p1mLnh4plEmzDUVv+ovk
        UrMCbduilBAj6r10XC6NfA4gT3kLvguMKf1vS6X/tlT635YOA6wCjORzBKuZF5gcRi1wVsFl
        M6sz7NYACB9kvO482NOe2gggBeghCve3yHSlnMsT1lkbAaIweoQiMkG0FJncuvW8w25yuLJ5
        oRHoxCXvxmKiM+zieducJkan0Wq17GQmSccw9CjFFv3PZUpo5pz8Gp7P4R1/+2RURIwbDL7g
        i0s9UKahNSlZz9mlJ45XkWNntsTm5VqmCfWqG+b6Y3AB9yjF71o5IUXVPb6zesP1ast8x+tW
        f/WM1TujLN6hBULgebefuZo0Orgw2HHXlPrzyK+ScQcHFnuvJfcsyXVPuBbsMezftynXg594
        wM1JnPcxdtDyD+XvfPoOuaecxgULx8RjDoH7DRbQB1ymAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42I5/e+xgG7UZO5og6kfFC3+TjrGbrHp43tW
        i/lHzrFanF12kM2iefF6NouzTW/YLS7vmsNm8bn3CKPF0usXmSw+b3jMaHG7cQWbReveI+wO
        PB5r5q1h9Pj9axKjx+yGiywem1Z1snnsn7uG3aNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgy
        Gr/sZCn4JVTR15LRwNjH38XIySEhYCIxq+UrUxcjF4eQwE5GiXlLtrCCJHgFBCV+TL7H0sXI
        wcEsIC9x5FI2SJhZQF1i0rxFzBD19xkl3j3qYYao15LonjiJHcRmEVCVeHp6CyOIzQYU3//i
        BhuIzS+gKHH1x2NGkJmiAhES3ScqQcIiAsESH5p72EBmMgt8ZZJ49rcdbKawQIxEz4srLBDL
        tjNKNFyewwKS4BQwl5j3/w7LBEaBWUhunYVw6ywkty5gZF7FKJlaUJybnltsVGCYl1quV5yY
        W1yal66XnJ+7iREYMdsOa/XtYLy/JP4QowAHoxIPb8Nvrmgh1sSy4srcQ4wSHMxKIrxcukAh
        3pTEyqrUovz4otKc1OJDjNIcLErivLfzjkUKCaQnlqRmp6YWpBbBZJk4OKUaGJuWhs89krG9
        1FLkiey1Eq1sz+M1jtIn5/bL27fJnvRb9voflxVP84X8TGYWlyjnczenf3j/pSjx2CPVMIv9
        VxxmL4wLV5wgFxcstk7bzTJ028+gWrm5USck95VFLp7/WHWz83be1aeXBLX9fr+Fzfv6tFPX
        Bb5Plt91mU1baeLkJUudkpSLrZRYijMSDbWYi4oTARwfsaKUAgAA
X-CMS-MailID: 20180528052754epcas1p31170d7395d9f194c67d812f6e9508634
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180525203351epcas2p1f22bcccf992edbc9ed76ba0bd42af752
References: <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203351epcas2p1f22bcccf992edbc9ed76ba0bd42af752@epcas2p1.samsung.com>
        <20180525203043.249193-4-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 05월 26일 05:30, Matthias Kaehlcke wrote:
> Commit "PM / devfreq: Fix handling of min/max_freq == 0" ensures that
> df->max_freq is not 0, remove unnecessary checks.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/governor_performance.c    | 5 +----
>  drivers/devfreq/governor_simpleondemand.c | 7 +++----
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
> index 4d23ecfbd948..1c990cb45098 100644
> --- a/drivers/devfreq/governor_performance.c
> +++ b/drivers/devfreq/governor_performance.c
> @@ -20,10 +20,7 @@ static int devfreq_performance_func(struct devfreq *df,
>  	 * target callback should be able to get floor value as
>  	 * said in devfreq.h
>  	 */
> -	if (!df->max_freq)
> -		*freq = UINT_MAX;
> -	else
> -		*freq = df->max_freq;
> +	*freq = df->max_freq;
>  	return 0;
>  }
>  
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index 28e0f2de7100..278964783fa6 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -27,7 +27,6 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  	unsigned int dfso_upthreshold = DFSO_UPTHRESHOLD;
>  	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
>  	struct devfreq_simple_ondemand_data *data = df->data;
> -	unsigned long max = (df->max_freq) ? df->max_freq : UINT_MAX;
>  
>  	err = devfreq_update_stats(df);
>  	if (err)
> @@ -47,7 +46,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  
>  	/* Assume MAX if it is going to be divided by zero */
>  	if (stat->total_time == 0) {
> -		*freq = max;
> +		*freq = df->max_freq;
>  		return 0;
>  	}
>  
> @@ -60,13 +59,13 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  	/* Set MAX if it's busy enough */
>  	if (stat->busy_time * 100 >
>  	    stat->total_time * dfso_upthreshold) {
> -		*freq = max;
> +		*freq = df->max_freq;
>  		return 0;
>  	}
>  
>  	/* Set MAX if we do not know the initial frequency */
>  	if (stat->current_frequency == 0) {
> -		*freq = max;
> +		*freq = df->max_freq;
>  		return 0;
>  	}
>  
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
