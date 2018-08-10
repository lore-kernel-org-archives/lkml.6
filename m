Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91255C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2674521524
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDL+y67K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2674521524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeHJR5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:57:14 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33427 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbeHJR5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:57:13 -0400
Received: by mail-oi0-f66.google.com with SMTP id 8-v6so16507462oip.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 08:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ADk94k7ohkV1v/V3Cq257WZT9HdkiMiB3rhuUY3TQiA=;
        b=YDL+y67Kzkdvz9o/YMKns/aQz+vGvfKdYH7etwGkdRgNjfTTcKE52edt0itBwol3V/
         TuBVwUsnfU0F66m2xEx31LW/TMDVoW7QVurq7SiRa0Z9m/hUVY2GAAvXYzp6MHmpOc5g
         Cb0lVL8S7tMs26A7BcTMtWLM3pS+xNenxTgDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ADk94k7ohkV1v/V3Cq257WZT9HdkiMiB3rhuUY3TQiA=;
        b=SPXym2YdBjWiN2jlHeQebbMSYVY+AqFZGa/b0sdq5jjvLwp5FCCie6lLtMg2cgSrw/
         yKjmQv4rzi2ZxlTzwt8xqNklROpxijBNu50QiGBCA4UvK9+d0K0C+k2e4zS321dXGDFS
         oqy9fGWZohe1QwSEGs7tfpwMq2oKoLVKdkz1AMjuzhploX265NxModoHbESO84hVgXCW
         kJlDc+dIQ18t9un5796yYTG3yxrB75viKkrA2tHWauc6Oo9qJOseJEp8PIADZWteP1m9
         CX8LgYh1nS9EU5n/pO6H0ySF8Q+x34OVHyJIGNvBLJvQYzEWjuGZk6bCRcXZTDnIDUTs
         HdIw==
X-Gm-Message-State: AOUpUlGxTJiusojojIUYLqzNgiSW51ayPXzmu2uz3HfGpzc29zND8MXS
        5XqnNrbpMsF9jUqSODDWzL8aH2JypPwRA0Dw6wqcMw==
X-Google-Smtp-Source: AA+uWPz1fob+4FNOfIsvjegyM4yoMFS/BGQAf6ubPqGabFR/pW0ASE9pvwioPD1E9MYHPXJ8SOi/FtxRJjtBJ1LFIZM=
X-Received: by 2002:aca:5dc5:: with SMTP id r188-v6mr7305527oib.320.1533914814225;
 Fri, 10 Aug 2018 08:26:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 08:26:53
 -0700 (PDT)
In-Reply-To: <cc29be64-47a5-2bc1-f1be-64b4ad7e1a6d@gmail.com>
References: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
 <c18fd41f-831c-ab74-57e5-d4151f4b47cc@gmail.com> <CAMz4kuL8ufCqbqgegozJt3P7JON0AzA9KrbvcvOB15McA5S=zA@mail.gmail.com>
 <5d594e9b-9889-adc2-cc59-f4f45eea7ddb@gmail.com> <CAMz4kuJBT2m8YpsAFufiGQFOYCgBbyf9Rrhce+396pRoW802aw@mail.gmail.com>
 <cc29be64-47a5-2bc1-f1be-64b4ad7e1a6d@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 10 Aug 2018 23:26:53 +0800
Message-ID: <CAMz4kuKs09P4_9k=_U1jYOpYz_8UHkHGpD_Wketpd35uqdBRoA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] leds: core: Introduce LED pattern trigger
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On 9 August 2018 at 21:21, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
> Hi Baolin,
>
> On 08/09/2018 07:48 AM, Baolin Wang wrote:
> [...]
>>>>>> +static int pattern_trig_start_pattern(struct pattern_trig_data *data,
>>>>>> +                                   struct led_classdev *led_cdev)
>>>>>> +{
>>>>>> +     if (!data->npatterns)
>>>>>> +             return 0;
>>>>>> +
>>>>>> +     if (led_cdev->pattern_set) {
>>>>>> +             return led_cdev->pattern_set(led_cdev, data->patterns,
>>>>>> +                                          data->npatterns, data->repeat);
>>>>>
>>>>> I think that it would be more flexible if software pattern fallback
>>>>> was applied in case of pattern_set failure. Otherwise, it would
>>>>> lead to the situation where LED class devices that support hardware
>>>>> blinking couldn't be applied the same set of patterns as LED class
>>>>> devices that don't implement pattern_set. The latter will always have to
>>>>> resort to using software pattern engine which will accept far greater
>>>>> amount of pattern combinations.
>>>>
>>>> Hmmm, I am not sure this is useful for hardware pattern, since the LED
>>>> hardware can be diverse which is hard to be compatible with software
>>>> pattern.
>>>>
>>>> For example, for our SC27XX LED, it only supports 4 hardware patterns
>>>> setting (low time, rising time, high time and falling time) to make it
>>>> work at breathing mode. If user provides 3 or 5 patterns values, it
>>>> will failed to issue pattern_set(). But at this time, we don't want to
>>>> use software pattern instead since it will be not the breathing mode
>>>> expected by user. I don't know if there are other special LED
>>>> hardware.
>>>
>>> Good point. So this is the issue we should dwell on, since the
>>> requested pattern effect should look similar on all devices.
>>> Of course in case of software pattern it will be often impossible
>>> to achieve the same fluency. Similarly as in case of rendering graphics
>>> with and without acceleration.
>>>
>>> In case of your device, I'd say that we'd need more complex description
>>> of breathing mode pattern. More complex than just four intervals.
>>> It should reflect all the intervals the hardware engine needs to perform
>>> to achieve the breathing effect. Can this information be inferred from
>>> the docs?
>>
>>>From our docs, it only provides registers to set the low time, rising
>> time, high time and falling time (value unit is 0.125s and max value
>> is 63 = 7.875s) to enable breathing mode. So each interval value can
>> be 1 ~ 63. But that is still hard for software pattern to simulate the
>> breathing mode performed by hardware pattern.
>
> Software fallback is not expected to show similar performance to the
> hardware engine on the whole span of the supported time range.
>
> Having min rise time value at 125ms, and given that max_brightness
> is 255, then we'd have 255 / 125 = 2.04 of brightness level rise per
> 1ms. So, the pattern for rising edge could look like (assuming we
> stop at 254):
>
> 0 1 2 1 4 1 6 1 8 1 10 1 ... 254 1

Right, maybe this can work, maybe not. Since we can met different
cases when failed to issue pattern_set(). Maybe the LED hardware
occurs some errors, in this case we should shutdown the LED, not
enable the software pattern instead, which still can not work. Maybe
driver can set NULL for pattern_set/clear interfaces to disable
hardware pattern, then next time user will perform the patterns with
software pattern mode.

For our SC27XX LED, like I said if user provides only 3 pattern values
which will failed to issue pattern_set(). But I still do not need use
software patterns to show similar performance, instead it will still
keep the last hardware pattern performance ( It did not overlap the
previous hardware pattern setting). Maybe different drivers have
different error handling, that's why I think we can leave driver to
choose the proper way to handle.

Honestly, can we keep this pattern trigger simple and easy at first?
If some drivers want to use software patterns to perform again once
their hardware patterns performed failed (IMHO our SC27XX LED do not
need), then we can add this feature, at that time we will have users
to test and optimize the feature. Maybe I am wrong:)

> Now, I'm starting to wonder if we shouldn't have specialized trigger
> for breathing patterns, that would accept brightness level change per
> time period. Pattern trigger needs more flexibility and inferring if the
> hardware can handle given series of pattern intervals would entail
> unnecessary code complexity.
>
> Such breathing trigger would require triplets comprised of
> start brightness, end brightness and a duration of the brightness
> transition.

But this is the only place we can set the hardware patterns according
to our previous discussion. Thanks.

-- 
Baolin Wang
Best Regards
