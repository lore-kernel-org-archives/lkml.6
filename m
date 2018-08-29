Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D90C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D298520657
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSi7FM/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D298520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeH2XNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:13:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33570 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeH2XNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:13:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id i134-v6so45595wmf.0;
        Wed, 29 Aug 2018 12:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZqFyhqBBCB8lMHPYlSK3uSjfUmfyQ5ERXI223ZuuAGU=;
        b=GSi7FM/8WXN6wSjkFJV88uLShVyQDUgZLYdbnoISZBunwvnu++9vV0ueVR9WkwOSF1
         /OgmlLcJXOyH2jmsYETZ52/IgLX6KyK+MY5zAK9JERIIc1oBRmTuqmU7H5NXS8XGGeNG
         0mcAHQImE6NNJdx2jKtoYy05oBjFliyGxG7AbV3RXzAA2B+0AcRiVidXF8+e9mRnhDZr
         o8yiJYyoXgcb2QHjfJqNxftftq8GlR3BecJPB4drh18qdqK6xssm014BlG6p522qE8do
         NYYP2VN+01IvekAiotDEt7uWEJgLLMpiWk6eCF7/9DLYJmRHd5uf1jumcupuZy1uaR09
         yqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZqFyhqBBCB8lMHPYlSK3uSjfUmfyQ5ERXI223ZuuAGU=;
        b=Kg9AstrVKOmV6cI+a8TjtnigDZC2e46taY7di+zbu09R9U0Rt7u44X0JWTkrhkXaNy
         k7ce/vfANqDYNcbQ4+bYdhHQpbhnkvVSdAAVHSoOBykhENgQOnZ4YyTYKO54A/oUcHHx
         pQEO20QwMHLKmnLVrZlmxhlry+nKn/kgAxz5v5GFw/pSleWSla3VSs8xYY7Dv8+2IZ4C
         MPTnrTF4ImOwTvPdBGhUZg9mXxALEo3qhpW/+mBT6khf4EhklNQOyENOzGnphNyetxFS
         l2kRliQM9U/oyO1y9aza+K9hIcGdXCFDcq1ivIPgH+usc1/mwoLHgL9gCPenrwCTkaYG
         9Ztw==
X-Gm-Message-State: APzg51BowBgknZgPrPexsSXho4aug1DwJx/3g4UrB9iboHAs5kr1P/Fu
        ICcaVS0IR0DzSrPB/7A+e22RFd53
X-Google-Smtp-Source: ANB0VdYnqdTKUIg4gPBBIA39BfpI2zwIWtmhbx7s5Mpn1CF2FWMmvLtn2h46xneR9P7RnVdxy/QktQ==
X-Received: by 2002:a1c:2dc8:: with SMTP id t191-v6mr5294787wmt.94.1535570120228;
        Wed, 29 Aug 2018 12:15:20 -0700 (PDT)
Received: from [192.168.1.18] (bkz141.neoplus.adsl.tpnet.pl. [83.28.193.141])
        by smtp.gmail.com with ESMTPSA id 72-v6sm7232147wrb.48.2018.08.29.12.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 12:15:19 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] leds: core: Introduce LED pattern trigger
To:     Baolin Wang <baolin.wang@linaro.org>, Pavel Machek <pavel@ucw.cz>
Cc:     rteysseyre@gmail.com, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
 <c18fd41f-831c-ab74-57e5-d4151f4b47cc@gmail.com> <20180824101145.GA1510@amd>
 <9bb7ac19-36a6-d11a-6d46-fc65c2026201@gmail.com> <20180824201227.GB17146@amd>
 <f5046e2d-9f15-4b7e-083e-e97f7ca0693c@gmail.com>
 <CAMz4kuLubD6v1+zmjuKtBL4geBk4ofBdkMy+v8x0K5g_L0otqQ@mail.gmail.com>
 <52eb7b5f-a405-06d1-2758-f27401a3ce3b@gmail.com>
 <CAMz4ku+a5QT5CaonW3R6dfKzcpJgyeGLbD5tH-0K1QMLDdQpqQ@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <6d0881db-e02f-6bf4-2516-448bc4772cb8@gmail.com>
Date:   Wed, 29 Aug 2018 21:15:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMz4ku+a5QT5CaonW3R6dfKzcpJgyeGLbD5tH-0K1QMLDdQpqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On 08/29/2018 11:48 AM, Baolin Wang wrote:
> Hi Jacek,
> 
> On 29 August 2018 at 04:25, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
>> On 08/25/2018 09:51 AM, Baolin Wang wrote:
>>> On 25 August 2018 at 04:44, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
>>>> On 08/24/2018 10:12 PM, Pavel Machek wrote:
>>>>> On Fri 2018-08-24 21:49:50, Jacek Anaszewski wrote:
>>>>>> Hi Pavel,
>>>>>>
>>>>>> On 08/24/2018 12:11 PM, Pavel Machek wrote:
>>>>>>> Hi!
>>>>>>>
>>>>>>>> I think that it would be more flexible if software pattern fallback
>>>>>>>> was applied in case of pattern_set failure. Otherwise, it would
>>>>>>>> lead to the situation where LED class devices that support hardware
>>>>>>>> blinking couldn't be applied the same set of patterns as LED class
>>>>>>>> devices that don't implement pattern_set. The latter will always have to
>>>>>>>> resort to using software pattern engine which will accept far greater
>>>>>>>> amount of pattern combinations.
>>>>>>>>
>>>>>>>> In this case we need to discuss on what basis the decision will be
>>>>>>>> made on whether hardware or software engine will be used.
>>>>>>>>
>>>>>>>> Possible options coming to mind:
>>>>>>>> - an interface will be provided to determine max difference between
>>>>>>>>   the settings supported by the hardware and the settings requested by
>>>>>>>>   the user, that will result in aligning user's setting to the hardware
>>>>>>>>   capabilities
>>>>>>>> - the above alignment rate will be predefined instead
>>>>>>>> - hardware engine will be used only if user requests supported settings
>>>>>>>>   on the whole span of the requested pattern
>>>>>>>> - in each of the above cases it would be worth to think of the
>>>>>>>>   interface to show the scope of the settings supported by hardware
>>>>>>>
>>>>>>> I'd recommend keeping it simple. We use hardware engine if driver
>>>>>>> author thinks pattern is "close enough".
>>>>>>
>>>>>> The thing is that in the ledtrig-pattern v5 implementation there
>>>>>> is no option of using software fallback if pattern_set op
>>>>>> is initialized:
>>>>>>
>>>>>> +    if (led_cdev->pattern_set) {
>>>>>> +            return led_cdev->pattern_set(led_cdev, data->patterns,
>>>>>> +                                         data->npatterns, data->repeat);
>>>>>> +    }
>>>>>
>>>>> Yeah, that sounds wrong. (Sorry I did not pay enough attention).
>>>>>
>>>>> It pattern_set() returns special error code, it should just continue
>>>>> and use software pattern fallback.
>>>>
>>>> And now we can get back to the issue I was concerned about in the
>>>> email you replied to, i.e. what series of [brightness delta_t] tuples
>>>> should be written to the pattern file to enable hardware breathing
>>>> engine.
>>>
>>> OK. So now we've made a consensus to use the software pattern fallback
>>> if failed to set hardware pattern. How about introduce one interface
>>> to convert hardware patterns to software patterns if necessary?
>>>
>>> diff --git a/drivers/leds/trigger/ledtrig-pattern.c
>>> b/drivers/leds/trigger/ledtrig-pattern.c
>>> index 63b94a2..d46a641 100644
>>> --- a/drivers/leds/trigger/ledtrig-pattern.c
>>> +++ b/drivers/leds/trigger/ledtrig-pattern.c
>>> @@ -66,8 +66,15 @@ static int pattern_trig_start_pattern(struct
>>> pattern_trig_data *data,
>>>                 return 0;
>>>
>>>         if (led_cdev->pattern_set) {
>>> -               return led_cdev->pattern_set(led_cdev, data->patterns,
>>> -                                            data->npatterns, data->repeat);
>>> +               ret = led_cdev->pattern_set(led_cdev, data->patterns,
>>> +                                           data->npatterns, data->repeat);
>>> +               if (!ret)
>>> +                       return 0;
>>> +
>>> +               dev_warn(led_cdev->dev, "Failed to set hardware pattern\n");
>>> +
>>> +               if (led_cdev->pattern_convert)
>>> +                       led_cdev->pattern_convert(led_cdev,
>>
>> I can't see how it could help to assess if hw pattern
>> engine can launch given pattern, and with what accuracy.
>>
>> Instead, I propose to add a means for defining whether the pattern
>> to be set is intended for hardware pattern engine or for software
>> fallback. It could be either separate sysfs file e.g. hw_pattern,
>> or a modifier to the pattern written to the pattern file, e,g,
>>
>> echo "hw 100 2 200 3 100 2" > pattern
>>
>> hw format expected by given driver would have to be described
>> in the per-driver ABI documentation. All patterns without
>> "hw" prefix would enable software pattern engine.
> 
> OK. So I did some optimization based on v5 according to suggestion, if
> you think this is okay for you, then I will send out the formal v6
> patch set.
> 
> 1. echo "hw 100 2 200 3 100 2" > pattern
> Only for hardware pattern, if failed,  we will return error number.

After thinking more about it, I'd opt for a separate file
dedicated to hardware pattern, e.g. hw_pattern, which would
be created only if the LED class driver implemented pattern_set op.

> 2. echo "100 2 200 3 100 2" > pattern
> Will try to set hardware pattern firstly, if failed, will use software
> pattern instead.
> 
> diff --git a/drivers/leds/trigger/ledtrig-pattern.c
> b/drivers/leds/trigger/ledtrig-pattern.c
> index 63b94a2..f08e797 100644
> --- a/drivers/leds/trigger/ledtrig-pattern.c
> +++ b/drivers/leds/trigger/ledtrig-pattern.c
> @@ -26,6 +26,7 @@ struct pattern_trig_data {
>  	u32 repeat;
>  	u32 last_repeat;
>  	bool is_indefinite;
> +	bool is_hw_pattern;
>  	struct timer_list timer;
>  };
> 
> @@ -62,12 +63,21 @@ static void pattern_trig_timer_function(struct
> timer_list *t)
>  static int pattern_trig_start_pattern(struct pattern_trig_data *data,
>  				      struct led_classdev *led_cdev)
>  {
> +	int ret;
> +
>  	if (!data->npatterns)
>  		return 0;
> 
>  	if (led_cdev->pattern_set) {
> -		return led_cdev->pattern_set(led_cdev, data->patterns,
> +		ret = led_cdev->pattern_set(led_cdev, data->patterns,
>  					     data->npatterns, data->repeat);
> +		if (!ret)
> +			return 0;
> +
> +		dev_warn(led_cdev->dev, "Failed to set hardware patterns\n");
> +
> +		if (data->is_hw_pattern)
> +			return ret;

With separate pattern files we could get rid of this ambiguity and
attempt calling pattern_set only if requested via hw_pattern file.
No software fallback should be employed in case of failure then.

Similarly in case of requests originating from pattern file -
the software engine should be set up.

>  	}
> 
>  	data->curr = data->patterns;
> @@ -106,7 +116,7 @@ static ssize_t repeat_store(struct device *dev,
> struct device_attribute *attr,
>  	if (err)
>  		return err;
> 
> -	if (!led_cdev->pattern_set)
> +	if (!data->is_hw_pattern)
>  		del_timer_sync(&data->timer);
> 
>  	mutex_lock(&data->lock);
> @@ -159,19 +169,32 @@ static ssize_t pattern_store(struct device *dev,
> struct device_attribute *attr,
>  {
>  	struct led_classdev *led_cdev = dev_get_drvdata(dev);
>  	struct pattern_trig_data *data = led_cdev->trigger_data;
> -	int ccount, cr, offset = 0, err = 0;
> +	int ccount, cr, len, offset = 0, err = 0;
> +	const char *s;
> 
> -	if (!led_cdev->pattern_set)
> +	if (!data->is_hw_pattern)
>  		del_timer_sync(&data->timer);
> 
>  	mutex_lock(&data->lock);
> 
> +	s = strstr(buf, "hw");
> +	if (s && led_cdev->pattern_set) {
> +		data->is_hw_pattern = true;
> +		s += strlen("hw");
> +		len = strlen(s);
> +	} else {
> +		data->is_hw_pattern = false;
> +		s = buf;
> +		len = count;
> +	}
> +
>  	data->npatterns = 0;
> -	while (offset < count - 1 && data->npatterns < MAX_PATTERNS) {
> +	while (offset < len - 1 && data->npatterns < MAX_PATTERNS) {
>  		cr = 0;
> -		ccount = sscanf(buf + offset, "%d %d %n",
> +		ccount = sscanf(s + offset, "%d %d %n",
>  				&data->patterns[data->npatterns].brightness,
>  				&data->patterns[data->npatterns].delta_t, &cr);
>  		if (ccount != 2) {
>  			data->npatterns = 0;
>  			err = -EINVAL;
> @@ -232,7 +255,8 @@ static void pattern_trig_deactivate(struct
> led_classdev *led_cdev)
> 
>  	if (led_cdev->pattern_clear)
>  		led_cdev->pattern_clear(led_cdev);
> -	else
> +
> +	if (!data->is_hw_pattern)
>  		del_timer_sync(&data->timer);
> 
>  	led_set_brightness(led_cdev, LED_OFF);
> 
>>
>>> data->patterns, &data->npatterns);
>>>         }
>>>
>>>         data->curr = data->patterns;
>>> @@ -106,8 +113,7 @@ static ssize_t repeat_store(struct device *dev,
>>> struct device_attribute *attr,
>>>         if (err)
>>>                 return err;
>>>
>>> -       if (!led_cdev->pattern_set)
>>> -               del_timer_sync(&data->timer);
>>> +       del_timer_sync(&data->timer);
>>>
>>>         mutex_lock(&data->lock);
>>>
>>> @@ -161,8 +167,7 @@ static ssize_t pattern_store(struct device *dev,
>>> struct device_attribute *attr,
>>>         struct pattern_trig_data *data = led_cdev->trigger_data;
>>>         int ccount, cr, offset = 0, err = 0;
>>>
>>> -       if (!led_cdev->pattern_set)
>>> -               del_timer_sync(&data->timer);
>>> +       del_timer_sync(&data->timer);
>>>
>>>         mutex_lock(&data->lock);
>>>
>>> @@ -232,9 +237,8 @@ static void pattern_trig_deactivate(struct
>>> led_classdev *led_cdev)
>>>
>>>         if (led_cdev->pattern_clear)
>>>                 led_cdev->pattern_clear(led_cdev);
>>> -       else
>>> -               del_timer_sync(&data->timer);
>>>
>>> +       del_timer_sync(&data->timer);
>>>         led_set_brightness(led_cdev, LED_OFF);
>>>         kfree(data);
>>>         led_cdev->activated = false;
>>> diff --git a/include/linux/leds.h b/include/linux/leds.h
>>> index 74fc2c6..04f3eaf 100644
>>> --- a/include/linux/leds.h
>>> +++ b/include/linux/leds.h
>>> @@ -93,6 +93,8 @@ struct led_classdev {
>>>                            struct led_pattern *pattern, int len,
>>>                            unsigned int repeat);
>>>         int (*pattern_clear)(struct led_classdev *led_cdev);
>>> +       int (*pattern_convert)(struct led_classdev *led_cdev,
>>> +                              struct led_pattern *pattern, int *len);
>>>
>>>         struct device           *dev;
>>>         const struct attribute_group    **groups;
>>>
>>


-- 
Best regards,
Jacek Anaszewski
