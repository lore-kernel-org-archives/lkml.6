Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACFFC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26E321EFB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYex1kqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26E321EFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbeHJUl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:41:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38883 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbeHJUl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:41:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id t25-v6so2765789wmi.3;
        Fri, 10 Aug 2018 11:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DYJbjv+2UpT5JiI/NNIDitdAmLDv9U2YEFQggIVuz44=;
        b=nYex1kqG2ZhPtGdFMWLslTgjlREeEgDumnCOpbhygPI3Li+U9x3xRSA9RkiPzJy+4F
         BpNf4yNWykXnJSd1Vq90rW5Gq+5cPlIBFlGxVsP2FO6vg9AeE2JKEGtvd5CjskWKziYY
         Nmg52/LaFS2ROXpYQ2Rw9cdYCPNQYm4kOTnQfmsiLte6hm1aIVBHs0X7rlf+tjJGOgTa
         omGFlYDzefeBPXv+DzeZlgd4OWQT46FJ+i5+S5DEpaz6u8C8wU/HJzlnYAOdnU6z9Fzb
         Kqju3sQfukl5JVBfPjMJKnbQnsA7wBU73DI9+CWwVy8IZitJe4uw/xGPckonLnzt7E8g
         btDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DYJbjv+2UpT5JiI/NNIDitdAmLDv9U2YEFQggIVuz44=;
        b=cTdh03XOkcgtNAprhfr1GHGX7nXAyYq2YGk1VyY8DDb75oEihVxb1V+wE3rAleKBUM
         NOPRZFwVXTLNtsRy5oqXXBCES91P7JkmTE2NySmt6R0f6eMr5NRLHxXH8TMhXMg/NXiT
         c5lx72zGQ99HvM59n3n0nFs6vBVUjgHNkvwW3CVX2pO2SqRILD9CM6tE3ndCSIiB86WT
         7QbvHeh3tjYusgWnGGTO6p5q5p1jMyt5UQ2qyXN3gyjweBLDoDc8ty0T5XPLzRyuX/1k
         FjefFk4CMQ2IbBX4N3MsITVxCsLck/N5XDgQETP0W/kKs01A1zAhHl43j3oTyO79Cen3
         YcnQ==
X-Gm-Message-State: AOUpUlGrBQMhGEwdd8/tpfrDAYavxKEM+q9k63Vc25p+Oqc0JtH/Ijnh
        TWmoAnNvlT3y0S3h4sWU9aQ=
X-Google-Smtp-Source: AA+uWPzv4LZI1Tf1uo5ZjsYnioeHY8wieZhbd+btdkJWxh+B7/MLCP4WHJtSUp8rDN2hF93c+BhScg==
X-Received: by 2002:a1c:e304:: with SMTP id a4-v6mr2232278wmh.0.1533924659855;
        Fri, 10 Aug 2018 11:10:59 -0700 (PDT)
Received: from [192.168.1.18] (cjm254.neoplus.adsl.tpnet.pl. [83.31.62.254])
        by smtp.gmail.com with ESMTPSA id 200-v6sm3699766wmv.6.2018.08.10.11.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 11:10:58 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] leds: core: Introduce LED pattern trigger
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
 <c18fd41f-831c-ab74-57e5-d4151f4b47cc@gmail.com>
 <CAMz4kuL8ufCqbqgegozJt3P7JON0AzA9KrbvcvOB15McA5S=zA@mail.gmail.com>
 <5d594e9b-9889-adc2-cc59-f4f45eea7ddb@gmail.com>
 <CAMz4kuJBT2m8YpsAFufiGQFOYCgBbyf9Rrhce+396pRoW802aw@mail.gmail.com>
 <cc29be64-47a5-2bc1-f1be-64b4ad7e1a6d@gmail.com>
 <CAMz4kuKs09P4_9k=_U1jYOpYz_8UHkHGpD_Wketpd35uqdBRoA@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <90e7f2b4-b706-4784-a7c6-30dba1614e67@gmail.com>
Date:   Fri, 10 Aug 2018 20:10:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMz4kuKs09P4_9k=_U1jYOpYz_8UHkHGpD_Wketpd35uqdBRoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On 08/10/2018 05:26 PM, Baolin Wang wrote:
> Hi Jacek,
> 
> On 9 August 2018 at 21:21, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
>> Hi Baolin,
>>
>> On 08/09/2018 07:48 AM, Baolin Wang wrote:
>> [...]
>>>>>>> +static int pattern_trig_start_pattern(struct pattern_trig_data *data,
>>>>>>> +                                   struct led_classdev *led_cdev)
>>>>>>> +{
>>>>>>> +     if (!data->npatterns)
>>>>>>> +             return 0;
>>>>>>> +
>>>>>>> +     if (led_cdev->pattern_set) {
>>>>>>> +             return led_cdev->pattern_set(led_cdev, data->patterns,
>>>>>>> +                                          data->npatterns, data->repeat);
>>>>>>
>>>>>> I think that it would be more flexible if software pattern fallback
>>>>>> was applied in case of pattern_set failure. Otherwise, it would
>>>>>> lead to the situation where LED class devices that support hardware
>>>>>> blinking couldn't be applied the same set of patterns as LED class
>>>>>> devices that don't implement pattern_set. The latter will always have to
>>>>>> resort to using software pattern engine which will accept far greater
>>>>>> amount of pattern combinations.
>>>>>
>>>>> Hmmm, I am not sure this is useful for hardware pattern, since the LED
>>>>> hardware can be diverse which is hard to be compatible with software
>>>>> pattern.
>>>>>
>>>>> For example, for our SC27XX LED, it only supports 4 hardware patterns
>>>>> setting (low time, rising time, high time and falling time) to make it
>>>>> work at breathing mode. If user provides 3 or 5 patterns values, it
>>>>> will failed to issue pattern_set(). But at this time, we don't want to
>>>>> use software pattern instead since it will be not the breathing mode
>>>>> expected by user. I don't know if there are other special LED
>>>>> hardware.
>>>>
>>>> Good point. So this is the issue we should dwell on, since the
>>>> requested pattern effect should look similar on all devices.
>>>> Of course in case of software pattern it will be often impossible
>>>> to achieve the same fluency. Similarly as in case of rendering graphics
>>>> with and without acceleration.
>>>>
>>>> In case of your device, I'd say that we'd need more complex description
>>>> of breathing mode pattern. More complex than just four intervals.
>>>> It should reflect all the intervals the hardware engine needs to perform
>>>> to achieve the breathing effect. Can this information be inferred from
>>>> the docs?
>>>
>>> >From our docs, it only provides registers to set the low time, rising
>>> time, high time and falling time (value unit is 0.125s and max value
>>> is 63 = 7.875s) to enable breathing mode. So each interval value can
>>> be 1 ~ 63. But that is still hard for software pattern to simulate the
>>> breathing mode performed by hardware pattern.
>>
>> Software fallback is not expected to show similar performance to the
>> hardware engine on the whole span of the supported time range.
>>
>> Having min rise time value at 125ms, and given that max_brightness
>> is 255, then we'd have 255 / 125 = 2.04 of brightness level rise per
>> 1ms. So, the pattern for rising edge could look like (assuming we
>> stop at 254):
>>
>> 0 1 2 1 4 1 6 1 8 1 10 1 ... 254 1
> 
> Right, maybe this can work, maybe not. Since we can met different
> cases when failed to issue pattern_set(). Maybe the LED hardware
> occurs some errors, in this case we should shutdown the LED, not
> enable the software pattern instead, which still can not work. 

This is arguable. Timer trigger always resorts to using software
fallback if blink_set() fails.

> Maybe
> driver can set NULL for pattern_set/clear interfaces to disable
> hardware pattern, then next time user will perform the patterns with
> software pattern mode.

Resetting any ops after LED class driver is probed should be
deemed forbidden, since LED core can make some decisions basing on
whether given ops are initialized or not.

> For our SC27XX LED, like I said if user provides only 3 pattern values
> which will failed to issue pattern_set(). But I still do not need use
> software patterns to show similar performance, instead it will still
> keep the last hardware pattern performance ( It did not overlap the
> previous hardware pattern setting). Maybe different drivers have
> different error handling, that's why I think we can leave driver to
> choose the proper way to handle.

ABI semantics is generic, i.e. common for all drivers. Driver can
always log any problems occurred while setting pattern, but it shouldn't
necessarily need to prevent pattern trigger from using software
fallback.

> Honestly, can we keep this pattern trigger simple and easy at first?
> If some drivers want to use software patterns to perform again once
> their hardware patterns performed failed (IMHO our SC27XX LED do not
> need), then we can add this feature, at that time we will have users
> to test and optimize the feature. Maybe I am wrong:)

In other words you want to prevent users from exploiting the flexibility
of pattern trigger, and limit them to using always only breathing
scheme for SC27XX LED. What if someone would like to employ pattern
trigger for encoding morse message to report system errors?

And secondly, we cannot keep the interface simple at first and then
change it, because this is against Linux rule, which says that
interface cannot break existing users.

>> Now, I'm starting to wonder if we shouldn't have specialized trigger
>> for breathing patterns, that would accept brightness level change per
>> time period. Pattern trigger needs more flexibility and inferring if the
>> hardware can handle given series of pattern intervals would entail
>> unnecessary code complexity.
>>
>> Such breathing trigger would require triplets comprised of
>> start brightness, end brightness and a duration of the brightness
>> transition.
> 
> But this is the only place we can set the hardware patterns according
> to our previous discussion. Thanks.

Thinking more about it, introducing another trigger for something being
also a pattern is a bad idea.

Perhaps, as an alternative, we could allow for providing mathematical
formula to define the edge of brightness change.

I wonder what Pavel thinks.

-- 
Best regards,
Jacek Anaszewski
