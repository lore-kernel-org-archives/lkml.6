Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeEQBoQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 21:44:16 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:39807 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbeEQBoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 21:44:14 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180517014412epoutp03c0e5ef1edb76f782a128bd9f18dc1002~vSyxoCZs10764807648epoutp03b
X-AuditID: b6c32a46-15dff70000001024-2c-5afcde697279
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5AFCDE68.6000804@samsung.com>
Date: Thu, 17 May 2018 10:44:08 +0900
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
Subject: Re: [PATCH] PM / devfreq: Remove redundant frequency adjustment
 from governors
In-reply-to: <20180516211051.78875-1-mka@chromium.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmhW7mvT9RBicatC02fXzPanF22UE2
        i7NNb9gtLu+aw2bxufcIo8XnDY8ZLW43rmBzYPeY3XCRxaNvyypGj8+b5AKYo1JtMlITU1KL
        FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
        lfTtbIryS0tSFTLyi0tslaINDY30DA3M9YyMgLRxrJWRKVBJQmrGvNd7WAr6lSqm32pjamA8
        Jt3FyMkhIWAiseH9DZYuRi4OIYEdjBIPmiexQjjfGSUWv13LClP15MBHNojEbkaJt3MnsoEk
        eAUEJX5MvgfUzsHBLCAvceRSNkiYWUBTYuvu9ewQ9XcZJT6/OMcEUa8lMevgQ7ChLAKqEseP
        7mQBsdmA4vtf3ACbyS+gKHH1x2NGEFtUIEJi5/xv7CDzRQTqJFZ8qQeZySzQzyixsXER2Bxh
        gUiJVX8Wg/VyCphJ3NvygxGkSELgAJvEhmmbGCE+cJFob5zHAmELS7w6voUdwpaWeLZqI1RD
        O6NE+955zBDOFEaJc9fvMUFUGUs8W9jFBPEbn0TH4b9gJ0kI8Ep0tAlBlHhIrNizjA3CdpTY
        vvElNBw7GSUOfbnCPoFRbhZSiM1ChNgspBBbwMi8ilEstaA4Nz212KjASK84Mbe4NC9dLzk/
        dxMjOMFpue1gXHLO5xCjAAejEg+vgN2fKCHWxLLiytxDjBIczEoivELdQCHelMTKqtSi/Pii
        0pzU4kOMpsAAn8gsJZqcD0y+eSXxhqZGxsbGFqbmlsYGlkrivGuUvkYJCaQnlqRmp6YWpBbB
        9DFxcEo1ME7ov/gqrX3iv+UK1y5oTN7Cymx59qZPxbmquYm3QsQcPs/8aO+72+rvknlntWzv
        3pLd637lYkvVtWef7E0ONGv15p57sT51qvPE09JNUmu8Xm288flt4oxr/Rky76Iaj1YGv4sN
        r2cwi39wX2qld83mg+vum6l9qDuvsDd28iODhBds1VO6E22UWIozEg21mIuKEwGORgcjhgMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsVy+t9jAd3Me3+iDHb5WGz6+J7V4uyyg2wW
        Z5vesFtc3jWHzeJz7xFGi88bHjNa3G5cwebA7jG74SKLR9+WVYwenzfJBTBHcdmkpOZklqUW
        6dslcGXMe72HpaBfqWL6rTamBsZj0l2MnBwSAiYSTw58ZOti5OIQEtjJKLH13kFmkASvgKDE
        j8n3WLoYOTiYBeQljlzKBgkzC6hLTJq3iBmi/j6jxPo1h1kh6rUkZh18CGazCKhKHD+6kwXE
        ZgOK739xgw3E5hdQlLj64zEjyExRgQiJ7hOVIHNEBBoYJRpfzQY7gllgIqPE1VX3wAYJC0RK
        3Lq5GmpbN6PEhNsHGEESnAJmEve2/GCcwCgwC8mxsxCOnYXk2AWMzKsYJVMLinPTc4uNCozy
        Usv1ihNzi0vz0vWS83M3MQIDe9thrf4djI+XxB9iFOBgVOLhFbD7EyXEmlhWXJl7iFGCg1lJ
        hFeoGyjEm5JYWZValB9fVJqTWnyIUZqDRUmclz//WKSQQHpiSWp2ampBahFMlomDU6qBcSUr
        9/47rJuWXl59dF+zsaeMSaGrytHnnRp7dDoiFcoeOuhNv/V27t5Vlx2fWxjfnpEc2XpLf/Gv
        TtcvWnrnrA5vkD/mInjy6rRfv8K7bJo2qb3uP6uUP8W978YZg4c61f7al4VY9huEBSVp226V
        Tore6G61RPzooUO+Vr+EC5IYZHtUCzwfKrEUZyQaajEXFScCABkGXzBoAgAA
X-CMS-MailID: 20180517014409epcas2p19de9205b121b2faa944e02a8bfdb721d
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180516211119epcas2p4370ceb0c9d959bd1441fa71493a9b0e0
X-RootMTR: 20180516211119epcas2p4370ceb0c9d959bd1441fa71493a9b0e0
References: <CGME20180516211119epcas2p4370ceb0c9d959bd1441fa71493a9b0e0@epcas2p4.samsung.com>
        <20180516211051.78875-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 05월 17일 06:10, Matthias Kaehlcke wrote:
> The performance, powersave, simpleondemand and userspace governors
> determine a target frequency and then adjust it according to the
> df->min/max_freq limits that might have been set by user space. This
> adjustment is redundant, it is done in update_devfreq() for any
> governor, right after governor->get_target_freq().
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/governor_performance.c    | 10 ++--------
>  drivers/devfreq/governor_powersave.c      |  5 -----
>  drivers/devfreq/governor_simpleondemand.c |  7 +------
>  drivers/devfreq/governor_userspace.c      | 16 ++++------------
>  4 files changed, 7 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
> index 4d23ecfbd948..31ee30622c00 100644
> --- a/drivers/devfreq/governor_performance.c
> +++ b/drivers/devfreq/governor_performance.c
> @@ -16,14 +16,8 @@
>  static int devfreq_performance_func(struct devfreq *df,
>  				    unsigned long *freq)
>  {
> -	/*
> -	 * target callback should be able to get floor value as
> -	 * said in devfreq.h
> -	 */
> -	if (!df->max_freq)
> -		*freq = UINT_MAX;
> -	else
> -		*freq = df->max_freq;
> +	*freq = UINT_MAX;
> +

It is difficult to understand why use UINT_MAX instead of df->max_freq.

Instead, after merged the commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq
when adding the devfreq device"), df->max/min_freq have the specific frequency
value always. So, we can change it as following without UINT_MAX. 

	*freq = df->max_freq;


>  	return 0;
>  }
>  
> diff --git a/drivers/devfreq/governor_powersave.c b/drivers/devfreq/governor_powersave.c
> index 0c42f23249ef..50a891f7c92d 100644
> --- a/drivers/devfreq/governor_powersave.c
> +++ b/drivers/devfreq/governor_powersave.c
> @@ -16,11 +16,6 @@
>  static int devfreq_powersave_func(struct devfreq *df,
>  				  unsigned long *freq)
>  {
> -	/*
> -	 * target callback should be able to get ceiling value as
> -	 * said in devfreq.h
> -	 */
> -	*freq = df->min_freq;
>  	return 0;

Each function have to keep their own function role.
Please keep '*freq = df->min_freq'.

>  }
>  
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index 28e0f2de7100..7ed733c528f4 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -27,7 +27,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  	unsigned int dfso_upthreshold = DFSO_UPTHRESHOLD;
>  	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
>  	struct devfreq_simple_ondemand_data *data = df->data;
> -	unsigned long max = (df->max_freq) ? df->max_freq : UINT_MAX;
> +	unsigned long max = UINT_MAX;

Use df->max_freq instead of UINT_MAX as following.

	unsigned long max = df->max_freq;

>  
>  	err = devfreq_update_stats(df);
>  	if (err)
> @@ -85,11 +85,6 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  	b = div_u64(b, (dfso_upthreshold - dfso_downdifferential / 2));
>  	*freq = (unsigned long) b;
>  
> -	if (df->min_freq && *freq < df->min_freq)
> -		*freq = df->min_freq;
> -	if (df->max_freq && *freq > df->max_freq)
> -		*freq = df->max_freq;
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index 080607c3f34d..378d84c011df 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -26,19 +26,11 @@ static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
>  {
>  	struct userspace_data *data = df->data;
>  
> -	if (data->valid) {
> -		unsigned long adjusted_freq = data->user_frequency;
> -
> -		if (df->max_freq && adjusted_freq > df->max_freq)
> -			adjusted_freq = df->max_freq;
> -
> -		if (df->min_freq && adjusted_freq < df->min_freq)
> -			adjusted_freq = df->min_freq;
> -
> -		*freq = adjusted_freq;
> -	} else {
> +	if (data->valid)
> +		*freq = data->user_frequency;
> +	else
>  		*freq = df->previous_freq; /* No user freq specified yet */
> -	}
> +
>  	return 0;
>  }
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
