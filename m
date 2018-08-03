Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B32C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AED208C1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uHSWc7lq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44AED208C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732600AbeHCB5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:57:09 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:28235 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732078AbeHCB5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:57:08 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180803000334epoutp0457dd557b64a5b1fd6d93c73c612fafbb~HNvLUx3Mo1726917269epoutp04T;
        Fri,  3 Aug 2018 00:03:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180803000334epoutp0457dd557b64a5b1fd6d93c73c612fafbb~HNvLUx3Mo1726917269epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533254614;
        bh=L5AQ3r38qbY25e0OFVH8qJA7mSUNuosyby7fMlzfSms=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=uHSWc7lqdZDSE8NnIFxlcf+mPZlZUerqlLAcIFvLmniBQH3OkVkUjK3z9fZ23oDj8
         wyW/VL61F5EUOJ1Cip+V/FGVw02fyjfBAcq/GLkqPl7k8ekwarfVJ6Z9i1CAy/qCPK
         91p+hFLPFN/JvsB2Rx81JKfBPik08C7ARK9w4zUo=
Received: from epsmges2p2.samsung.com (unknown [182.195.40.154]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180803000331epcas1p279d4a741f50aa118f1a65a475eacbf72~HNvIqc-Yu2556825568epcas1p2T;
        Fri,  3 Aug 2018 00:03:31 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.BD.04443.3DB936B5; Fri,  3 Aug 2018 09:03:31 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20180803000331epcas2p28f74502b096de7ebbbeaed3bfac6eb7c~HNvIPfvZr0260702607epcas2p2x;
        Fri,  3 Aug 2018 00:03:31 +0000 (GMT)
X-AuditID: b6c32a46-cf3ff7000000115b-2e-5b639bd31b8c
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.22.03824.3DB936B5; Fri,  3 Aug 2018 09:03:31 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PCU004UYYTUHI20@mmp1.samsung.com>; Fri, 03 Aug 2018 09:03:31 +0900 (KST)
Message-id: <5B639BD2.5050008@samsung.com>
Date:   Fri, 03 Aug 2018 09:03:30 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 03/12] PM / devfreq: Don't adjust to user limits in
 governors
In-reply-to: <20180802233600.GT68975@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCJsWRmVeSWpSXmKPExsWy7bCmue7l2cnRBhtP6Vn8nXSM3WL6k8ss
        Fps+vme1mH/kHKvF2WUH2SzW3D7EaNG8eD2bxdmmN+wW978eZbS4vGsOm8Xn3iOMFkuvX2Sy
        +LzhMaPF7cYVbBanrn9mszhz+hKrReveI+wWG796OAh5rJm3htHj969JjB6zGy6yeOy4u4TR
        Y9OqTjaPO9f2sHnsn7uG3ePKiSZWjy1X21k8+rasYvT4vEkugDsq1SYjNTEltUghNS85PyUz
        L91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6DUlhbLEnFKgUEBicbGSvp1NUX5p
        SapCRn5xia1StKGhkZ6hgbmekRGQNo61MjIFKklIzVj8/D1jwXzDiiXHfrE2MJ5Q72Lk4JAQ
        MJHY86uki5GLQ0hgB6NE18HDzBDOd0aJ3s9/mGCKNt53h4jvZpT4v2IiSxcjJwevgKDEj8n3
        WEBqmAXkJY5cygYJMwtoSrz4MokFov4uo8Sl2w+ZIOq1JPb2z2cFsVkEVCVerTzMCGKzAcX3
        v7jBBmLzCyhKXP3xGCwuKhAhsXP+N3YQW0QgWGLBz/NgQ5kFXrNILGz5DTZIWCBM4sre62DN
        nAIGEofbb7KCFEkInGKXeHauBexSCQEXifftz9khbGGJV8e3QNnSEs9WbWSEaGhnlPjyohmq
        ewKjxIdTm5kgqowlni3sYoJ4jk+i4/Bfdki48Ep0tAlBlHhIfPv9nR3u556Fs1gmMMrOQgqm
        WYhgmoUUTAsYmVcxiqUWFOempxYbFRjpFSfmFpfmpesl5+duYgSnYC23HYxLzvkcYhTgYFTi
        4b2gmhwtxJpYVlyZe4hRgoNZSYT3bSdQiDclsbIqtSg/vqg0J7X4EKMpMJQnMkuJJucD80Ne
        SbyhqZGxsbGFqbmlsYGlkjhvlV9wtJBAemJJanZqakFqEUwfEwenVAOjtK7h9aUG23lqn+wr
        sUo2Y37ML7Gqa18RT8jyR5P+qXqZf/+tL/7x+qI7c47GvQ6/Hznx6tNa7fobIYb+rFt4nix7
        u9DiE+/Tbxp8ic4vFqoHFwgzyBybXt//VdCcaeY+29aIOV6ROxULdK1vT7efdakwW0rQ0eTo
        iu8Ve45wr3aSDXBquMWmxFKckWioxVxUnAgAaoWvkNcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t9jAd3Ls5OjDS7sF7T4O+kYu8X0J5dZ
        LDZ9fM9qMf/IOVaLs8sOslmsuX2I0aJ58Xo2i7NNb9gt7n89ymhxedccNovPvUcYLZZev8hk
        8XnDY0aL240r2CxOXf/MZnHm9CVWi9a9R9gtNn71cBDyWDNvDaPH71+TGD1mN1xk8dhxdwmj
        x6ZVnWwed67tYfPYP3cNu8eVE02sHluutrN49G1ZxejxeZNcAHcUl01Kak5mWWqRvl0CV8bi
        5+8ZC+YbViw59ou1gfGEehcjB4eEgInExvvuXYxcHEICOxklGrZMZO9i5OTgFRCU+DH5HgtI
        DbOAvMSRS9kQprrElCm5EOX3GSWO/vjLBFGuJbG3fz4riM0ioCrxauVhRhCbDSi+/8UNNhCb
        X0BR4uqPx4wgc0QFIiS6T1SChEUEgiU+NPewgcxkFnjLIrH023+wXmGBMIkre6+zQSy7C7Ts
        4y6w2zgFDCQOt99kncAoMAvJqbMQTp2FcOoCRuZVjJKpBcW56bnFRgVGeanlesWJucWleel6
        yfm5mxiB8bjtsFb/DsbHS+IPMQpwMCrx8F5QTY4WYk0sK67MPcQowcGsJML7thMoxJuSWFmV
        WpQfX1Sak1p8iFGag0VJnJc//1ikkEB6YklqdmpqQWoRTJaJg1OqgTEpevHZf7bfhPYVep1V
        dbjfuPjsl+1NZjrvCp8/862aNGn5hL9G4mkZK/8cPf/t1ATGWH5eK5nPRfVfPOYqMl29V9my
        2pXTfP6VQzc2fyrVq68u3Gr5KviKxxfN4LUSr53+/HcufsjUslzhutBUra+zZHyXzip8dHfi
        6r2JBS/mHjn++ptb+Z9TSizFGYmGWsxFxYkASPrE78MCAAA=
X-CMS-MailID: 20180803000331epcas2p28f74502b096de7ebbbeaed3bfac6eb7c
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180802233605epcas2p2fc6b1cef0dc773f6c7e59017721917bc
References: <20180703234705.227473-1-mka@chromium.org>
        <20180703234705.227473-4-mka@chromium.org>
        <CGME20180802233605epcas2p2fc6b1cef0dc773f6c7e59017721917bc@epcas2p2.samsung.com>
        <20180802233600.GT68975@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018년 08월 03일 08:36, Matthias Kaehlcke wrote:
> Hi Chanwoo,
> 
> this patch and "PM / devfreq: Fix handling of min/max_freq == 0"
> address issues not directly related with the throttler. It seems it
> could still take a while for the throttler to move forward, do you
> want me to spin out these two patches so that they can get merged
> independently from the rest of the series?

How about resend the devfreq patches(patch1/2/3/4/6) which don't depend on
throttler core with my reviewed tag? Maybe, it is easy to merge them through Myungjoo.

Regards,
Chanwoo Choi

> 
> Thanks
> 
> Matthias
> 
> On Tue, Jul 03, 2018 at 04:46:56PM -0700, Matthias Kaehlcke wrote:
>> Several governors use the user space limits df->min/max_freq to adjust
>> the target frequency. This is not necessary, since update_devfreq()
>> already takes care of this. Instead the governor can request the available
>> min/max frequency by setting the target frequency to DEVFREQ_MIN/MAX_FREQ
>> and let update_devfreq() take care of any adjustments.
>>
>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>> Reviewed-by: Brian Norris <briannorris@chromium.org>
>> ---
>> Changes in v5:
>> - none
>>
>> Changes in v4:
>> - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
>>
>> Changes in v3:
>> - none
>>
>> Changes in v2:
>> - squashed "PM / devfreq: Remove redundant frequency adjustment from governors"
>>   and "PM / devfreq: governors: Return device frequency limits instead of user
>>   limits"
>> - updated subject and commit message
>> - use DEVFREQ_MIN/MAX_FREQ instead of df->scaling_min/max_freq
>> ---
>>  drivers/devfreq/governor.h                |  3 +++
>>  drivers/devfreq/governor_performance.c    |  5 +----
>>  drivers/devfreq/governor_powersave.c      |  2 +-
>>  drivers/devfreq/governor_simpleondemand.c | 12 +++---------
>>  drivers/devfreq/governor_userspace.c      | 16 ++++------------
>>  5 files changed, 12 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
>> index cfc50a61a90d..b81700244ce3 100644
>> --- a/drivers/devfreq/governor.h
>> +++ b/drivers/devfreq/governor.h
>> @@ -25,6 +25,9 @@
>>  #define DEVFREQ_GOV_SUSPEND			0x4
>>  #define DEVFREQ_GOV_RESUME			0x5
>>  
>> +#define DEVFREQ_MIN_FREQ			0
>> +#define DEVFREQ_MAX_FREQ			ULONG_MAX
>> +
>>  /**
>>   * struct devfreq_governor - Devfreq policy governor
>>   * @node:		list node - contains registered devfreq governors
>> diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
>> index 4d23ecfbd948..ded429fd51be 100644
>> --- a/drivers/devfreq/governor_performance.c
>> +++ b/drivers/devfreq/governor_performance.c
>> @@ -20,10 +20,7 @@ static int devfreq_performance_func(struct devfreq *df,
>>  	 * target callback should be able to get floor value as
>>  	 * said in devfreq.h
>>  	 */
>> -	if (!df->max_freq)
>> -		*freq = UINT_MAX;
>> -	else
>> -		*freq = df->max_freq;
>> +	*freq = DEVFREQ_MAX_FREQ;
>>  	return 0;
>>  }
>>  
>> diff --git a/drivers/devfreq/governor_powersave.c b/drivers/devfreq/governor_powersave.c
>> index 0c42f23249ef..9e8897f5ac42 100644
>> --- a/drivers/devfreq/governor_powersave.c
>> +++ b/drivers/devfreq/governor_powersave.c
>> @@ -20,7 +20,7 @@ static int devfreq_powersave_func(struct devfreq *df,
>>  	 * target callback should be able to get ceiling value as
>>  	 * said in devfreq.h
>>  	 */
>> -	*freq = df->min_freq;
>> +	*freq = DEVFREQ_MIN_FREQ;
>>  	return 0;
>>  }
>>  
>> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
>> index 28e0f2de7100..c0417f0e081e 100644
>> --- a/drivers/devfreq/governor_simpleondemand.c
>> +++ b/drivers/devfreq/governor_simpleondemand.c
>> @@ -27,7 +27,6 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>>  	unsigned int dfso_upthreshold = DFSO_UPTHRESHOLD;
>>  	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
>>  	struct devfreq_simple_ondemand_data *data = df->data;
>> -	unsigned long max = (df->max_freq) ? df->max_freq : UINT_MAX;
>>  
>>  	err = devfreq_update_stats(df);
>>  	if (err)
>> @@ -47,7 +46,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>>  
>>  	/* Assume MAX if it is going to be divided by zero */
>>  	if (stat->total_time == 0) {
>> -		*freq = max;
>> +		*freq = DEVFREQ_MAX_FREQ;
>>  		return 0;
>>  	}
>>  
>> @@ -60,13 +59,13 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>>  	/* Set MAX if it's busy enough */
>>  	if (stat->busy_time * 100 >
>>  	    stat->total_time * dfso_upthreshold) {
>> -		*freq = max;
>> +		*freq = DEVFREQ_MAX_FREQ;
>>  		return 0;
>>  	}
>>  
>>  	/* Set MAX if we do not know the initial frequency */
>>  	if (stat->current_frequency == 0) {
>> -		*freq = max;
>> +		*freq = DEVFREQ_MAX_FREQ;
>>  		return 0;
>>  	}
>>  
>> @@ -85,11 +84,6 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>>  	b = div_u64(b, (dfso_upthreshold - dfso_downdifferential / 2));
>>  	*freq = (unsigned long) b;
>>  
>> -	if (df->min_freq && *freq < df->min_freq)
>> -		*freq = df->min_freq;
>> -	if (df->max_freq && *freq > df->max_freq)
>> -		*freq = df->max_freq;
>> -
>>  	return 0;
>>  }
>>  
>> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
>> index 080607c3f34d..378d84c011df 100644
>> --- a/drivers/devfreq/governor_userspace.c
>> +++ b/drivers/devfreq/governor_userspace.c
>> @@ -26,19 +26,11 @@ static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
>>  {
>>  	struct userspace_data *data = df->data;
>>  
>> -	if (data->valid) {
>> -		unsigned long adjusted_freq = data->user_frequency;
>> -
>> -		if (df->max_freq && adjusted_freq > df->max_freq)
>> -			adjusted_freq = df->max_freq;
>> -
>> -		if (df->min_freq && adjusted_freq < df->min_freq)
>> -			adjusted_freq = df->min_freq;
>> -
>> -		*freq = adjusted_freq;
>> -	} else {
>> +	if (data->valid)
>> +		*freq = data->user_frequency;
>> +	else
>>  		*freq = df->previous_freq; /* No user freq specified yet */
>> -	}
>> +
>>  	return 0;
>>  }
>>  
> 
> 

