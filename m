Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F3FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1956F20880
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjlmDym8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1956F20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeH2ASn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:18:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35628 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeH2ASn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:18:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so3302471wmc.0;
        Tue, 28 Aug 2018 13:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cKfumStJgyXizmqjzn0wvv8ZPeOb0xcmzBnWGdai1qA=;
        b=jjlmDym81JrzIR+ufADDyly0eT5il30xuS8sWYGcxApVzmXbT58aqIuxqMEOmBRP5J
         /74WURrHVDJpGfzPOm5cjdCWpfGlAM5eMGZBVkuKww99r+lYYcRwHn+uOTZsgwhKhcVD
         kDrCk9CmYDb1tU0T9LF4HlqiOECPlo39WEqCtYxgZBwdg9czQVUguxztH71cWv26Bemk
         s9+5Pe4ZGtGTVKMLOGJ3SHc6JgPplRqcRTNrQX/o6vuvYxGOquawDuaTKiPadY4nIwOF
         Y3uVNYzyAa0h1aZ6eotfz4z1GIeU3/ayWoWL8GqGsORtuIjFCrkuxVWAEgRrWQdUQwka
         it3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cKfumStJgyXizmqjzn0wvv8ZPeOb0xcmzBnWGdai1qA=;
        b=OOUzcSA2bBVG9SvowawL+9hc324FXiH0aDC7o+4L2tBLAurPrYjAYIu6EzPat9d6TS
         e0V3TRwk693jSN6JBolPvaS4meucgT64HqK8cfG9GXPYuTEgp/wAoqbBxA0Tjw3yfwRC
         VOrfesUmXF8Je/kunCwAbsCAfc+0Tqiwe5U/JJuEaDHYA/UUwRO7MFfqrl9vp5bPWMX0
         2m+ho8ZiHysrI2btKJgxqdoV6ziNLlMtO5UwW0OEWA1fmBS7SgbftGoN03zToVlCz3T3
         WuJz9sQD/th4A+heMxA/0pg2zbPYr1l8PnkjkwH8KlCxiS63ma3C9bwpRxN3iEetGZ7q
         qPbg==
X-Gm-Message-State: APzg51DMuQKTrALxMSO95Udz4gnZ2xHymxnBs93ELc9MVPfL/ZIMixra
        j4Nal0KorsaHWF1XaaWu8OMal2bA
X-Google-Smtp-Source: ANB0VdaSErKeAgjHwqxpePFqsppBEGnzragJyeLeogBn8QzP22unMdQ+4y1F7YVT/HuwWLaILGKg7g==
X-Received: by 2002:a1c:b49:: with SMTP id 70-v6mr2464013wml.149.1535487923774;
        Tue, 28 Aug 2018 13:25:23 -0700 (PDT)
Received: from [192.168.1.18] (bla118.neoplus.adsl.tpnet.pl. [83.28.194.118])
        by smtp.gmail.com with ESMTPSA id c10-v6sm4417863wrb.17.2018.08.28.13.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 13:25:22 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] leds: core: Introduce LED pattern trigger
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
 <c18fd41f-831c-ab74-57e5-d4151f4b47cc@gmail.com> <20180824101145.GA1510@amd>
 <9bb7ac19-36a6-d11a-6d46-fc65c2026201@gmail.com> <20180824201227.GB17146@amd>
 <f5046e2d-9f15-4b7e-083e-e97f7ca0693c@gmail.com>
 <CAMz4kuLubD6v1+zmjuKtBL4geBk4ofBdkMy+v8x0K5g_L0otqQ@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <52eb7b5f-a405-06d1-2758-f27401a3ce3b@gmail.com>
Date:   Tue, 28 Aug 2018 22:25:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMz4kuLubD6v1+zmjuKtBL4geBk4ofBdkMy+v8x0K5g_L0otqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/25/2018 09:51 AM, Baolin Wang wrote:
> On 25 August 2018 at 04:44, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
>> On 08/24/2018 10:12 PM, Pavel Machek wrote:
>>> On Fri 2018-08-24 21:49:50, Jacek Anaszewski wrote:
>>>> Hi Pavel,
>>>>
>>>> On 08/24/2018 12:11 PM, Pavel Machek wrote:
>>>>> Hi!
>>>>>
>>>>>> I think that it would be more flexible if software pattern fallback
>>>>>> was applied in case of pattern_set failure. Otherwise, it would
>>>>>> lead to the situation where LED class devices that support hardware
>>>>>> blinking couldn't be applied the same set of patterns as LED class
>>>>>> devices that don't implement pattern_set. The latter will always have to
>>>>>> resort to using software pattern engine which will accept far greater
>>>>>> amount of pattern combinations.
>>>>>>
>>>>>> In this case we need to discuss on what basis the decision will be
>>>>>> made on whether hardware or software engine will be used.
>>>>>>
>>>>>> Possible options coming to mind:
>>>>>> - an interface will be provided to determine max difference between
>>>>>>   the settings supported by the hardware and the settings requested by
>>>>>>   the user, that will result in aligning user's setting to the hardware
>>>>>>   capabilities
>>>>>> - the above alignment rate will be predefined instead
>>>>>> - hardware engine will be used only if user requests supported settings
>>>>>>   on the whole span of the requested pattern
>>>>>> - in each of the above cases it would be worth to think of the
>>>>>>   interface to show the scope of the settings supported by hardware
>>>>>
>>>>> I'd recommend keeping it simple. We use hardware engine if driver
>>>>> author thinks pattern is "close enough".
>>>>
>>>> The thing is that in the ledtrig-pattern v5 implementation there
>>>> is no option of using software fallback if pattern_set op
>>>> is initialized:
>>>>
>>>> +    if (led_cdev->pattern_set) {
>>>> +            return led_cdev->pattern_set(led_cdev, data->patterns,
>>>> +                                         data->npatterns, data->repeat);
>>>> +    }
>>>
>>> Yeah, that sounds wrong. (Sorry I did not pay enough attention).
>>>
>>> It pattern_set() returns special error code, it should just continue
>>> and use software pattern fallback.
>>
>> And now we can get back to the issue I was concerned about in the
>> email you replied to, i.e. what series of [brightness delta_t] tuples
>> should be written to the pattern file to enable hardware breathing
>> engine.
> 
> OK. So now we've made a consensus to use the software pattern fallback
> if failed to set hardware pattern. How about introduce one interface
> to convert hardware patterns to software patterns if necessary?
> 
> diff --git a/drivers/leds/trigger/ledtrig-pattern.c
> b/drivers/leds/trigger/ledtrig-pattern.c
> index 63b94a2..d46a641 100644
> --- a/drivers/leds/trigger/ledtrig-pattern.c
> +++ b/drivers/leds/trigger/ledtrig-pattern.c
> @@ -66,8 +66,15 @@ static int pattern_trig_start_pattern(struct
> pattern_trig_data *data,
>                 return 0;
> 
>         if (led_cdev->pattern_set) {
> -               return led_cdev->pattern_set(led_cdev, data->patterns,
> -                                            data->npatterns, data->repeat);
> +               ret = led_cdev->pattern_set(led_cdev, data->patterns,
> +                                           data->npatterns, data->repeat);
> +               if (!ret)
> +                       return 0;
> +
> +               dev_warn(led_cdev->dev, "Failed to set hardware pattern\n");
> +
> +               if (led_cdev->pattern_convert)
> +                       led_cdev->pattern_convert(led_cdev,

I can't see how it could help to assess if hw pattern
engine can launch given pattern, and with what accuracy.

Instead, I propose to add a means for defining whether the pattern
to be set is intended for hardware pattern engine or for software
fallback. It could be either separate sysfs file e.g. hw_pattern,
or a modifier to the pattern written to the pattern file, e,g,

echo "hw 100 2 200 3 100 2" > pattern

hw format expected by given driver would have to be described
in the per-driver ABI documentation. All patterns without
"hw" prefix would enable software pattern engine.

> data->patterns, &data->npatterns);
>         }
> 
>         data->curr = data->patterns;
> @@ -106,8 +113,7 @@ static ssize_t repeat_store(struct device *dev,
> struct device_attribute *attr,
>         if (err)
>                 return err;
> 
> -       if (!led_cdev->pattern_set)
> -               del_timer_sync(&data->timer);
> +       del_timer_sync(&data->timer);
> 
>         mutex_lock(&data->lock);
> 
> @@ -161,8 +167,7 @@ static ssize_t pattern_store(struct device *dev,
> struct device_attribute *attr,
>         struct pattern_trig_data *data = led_cdev->trigger_data;
>         int ccount, cr, offset = 0, err = 0;
> 
> -       if (!led_cdev->pattern_set)
> -               del_timer_sync(&data->timer);
> +       del_timer_sync(&data->timer);
> 
>         mutex_lock(&data->lock);
> 
> @@ -232,9 +237,8 @@ static void pattern_trig_deactivate(struct
> led_classdev *led_cdev)
> 
>         if (led_cdev->pattern_clear)
>                 led_cdev->pattern_clear(led_cdev);
> -       else
> -               del_timer_sync(&data->timer);
> 
> +       del_timer_sync(&data->timer);
>         led_set_brightness(led_cdev, LED_OFF);
>         kfree(data);
>         led_cdev->activated = false;
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index 74fc2c6..04f3eaf 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -93,6 +93,8 @@ struct led_classdev {
>                            struct led_pattern *pattern, int len,
>                            unsigned int repeat);
>         int (*pattern_clear)(struct led_classdev *led_cdev);
> +       int (*pattern_convert)(struct led_classdev *led_cdev,
> +                              struct led_pattern *pattern, int *len);
> 
>         struct device           *dev;
>         const struct attribute_group    **groups;
> 

-- 
Best regards,
Jacek Anaszewski
