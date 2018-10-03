Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E543CC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1BE20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUibl2zs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1BE20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeJCTvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:51:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51543 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbeJCTvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:51:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id 143-v6so5622719wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 06:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A+aivF/32R1ktzeou5fE9ytY0sBoviKtCVouuPwcBio=;
        b=hUibl2zs39ZWGRNCDzgezwncyk2K6+SmPP5qussWgvUhtTj/4eymODGSZpVRTmBEvB
         vgBsNpOzgZeAQJk0zEaH4h8Zq/lNbBkPXMgsCDYCREtFRvAQCxjTrqq5ftAJUkPX4ROS
         tu8kkDM56XoKwkFwsvmFcHG89B0U0z1hzd1YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A+aivF/32R1ktzeou5fE9ytY0sBoviKtCVouuPwcBio=;
        b=Ohf/SZB/iY5yGlq3wRwdkFMgh6sMlkH3qV/ZT0rZjvzF2UvyecPj34AOk4YLlN7Vd6
         lIX0c17bzLqrHn+B78RzPY0i96knZCWbQpgzCvXJ4lalqt0/ceETFKxGua/QVxp50BoH
         H8oAI8kDQZYD79tYRVmO1u3ebctq98p6LOz2u9ovQyqrvpSc6FhzO0jlvCtlluGL/3f9
         XrGcHhiFnT8TLErrBJ3mr/VOTmBj3Tmje3i9iuySbrz4sNyJCCAzLB55f0Z7J+qTpKfE
         NS1CvacMGaNxobxYXzO9GXMcIWASrG4kx10PLqlikimPAHjzNxr1STWtRU/lYiV7FpJ7
         qILA==
X-Gm-Message-State: ABuFfojfDZzvOwPRGW/iDa22ZHCFHHNaIfsg2uOYlpP2tT3Q/qMhhy87
        gDPrB7EcjRuzzXTpvckulZSFzw==
X-Google-Smtp-Source: ACcGV63ogankSLUvImdLvYTQBlnfKCox3HBy5wg15/BEutwYe4tgE3TLg8IqIDvMApIxBg5z3wzrxA==
X-Received: by 2002:a1c:e4c6:: with SMTP id b189-v6mr1432893wmh.114.1538571763766;
        Wed, 03 Oct 2018 06:02:43 -0700 (PDT)
Received: from [192.168.0.41] (84.152.136.77.rev.sfr.net. [77.136.152.84])
        by smtp.googlemail.com with ESMTPSA id a105-v6sm2949592wrc.23.2018.10.03.06.02.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 06:02:42 -0700 (PDT)
Subject: Re: [PATCH v5 04/21] dt-bindings: Add doc for the Ingenic TCU drivers
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        linux-watchdog@vger.kernel.org, robh@kernel.org,
        linux-mips@linux-mips.org, Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
References: <5bb4bb5d.1c69fb81.ed9a6.adc6SMTPIN_ADDED_MISSING@mx.google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fa8dd794-3077-eb5c-5657-f62d1a6521b5@linaro.org>
Date:   Wed, 3 Oct 2018 15:02:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5bb4bb5d.1c69fb81.ed9a6.adc6SMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2018 14:51, Paul Cercueil wrote:
> 
> Le 3 oct. 2018 2:47 PM, Daniel Lezcano <daniel.lezcano@linaro.org> a
> écrit :
>> 
>> On 03/10/2018 12:32, Paul Cercueil wrote:
>>> 
>>> Le 1 oct. 2018 10:48, Daniel Lezcano <daniel.lezcano@linaro.org>
>>> a écrit :
>>>> 
>>>> On 31/07/2018 00:01, Paul Cercueil wrote:
>>>> 
>>>> [ ... ]
>>>> 
>>>>>>> +- ingenic,timer-channel: Specifies the TCU channel that
>>>>>>>  should be used as +  system timer. If not provided, the
>>>>>>> TCU channel 0 is used for the system timer. + +- 
>>>>>>> ingenic,clocksource-channel: Specifies the TCU channel
>>>>>>> that should be used +  as clocksource and sched_clock. It
>>>>>>> must be a different channel than the one +  used as
>>>>>>> system timer. If not provided, neither a clocksource nor
>>>>>>> a +  sched_clock is instantiated.
>>>>>> 
>>>>>> clocksource and sched_clock are Linux specific and don't
>>>>>> belong in DT. You should define properties of the hardware
>>>>>> or use existing properties like interrupts or clocks to
>>>>>> figure out which channel to use. For example, if some
>>>>>> channels don't have an interrupt, then use them for
>>>>>> clocksource and not a clockevent. Or you could have timers
>>>>>> that run in low-power modes or not. If all the channels are
>>>>>> identical, then it shouldn't matter which ones the OS
>>>>>> picks.
>>>> 
>>>> It can't work in this case because the pmw and the timer driver
>>>> are not communicating and the first one can stole a channel to
>>>> the last one.
>>> 
>>> In that particular case the timer driver will always request its
>>>  channels first; with no timer set the system hangs before 
>>> subsys_initcall, and the PWM driver is a subnode of the timer
>>> node, so is probed only after the timer probed.
>>> 
>>>>> We already talked about that. All the TCU channels can be
>>>>> used for PWM. The problem is I cannot know from the driver's
>>>>> scope which channels will be free and which channels will be
>>>>> requested for PWM. You suggested that I parse the devicetree
>>>>> for clients, and I did that in the V3/V4 patchset. But it
>>>>> only works for clients requesting through devicetree, not
>>>>> from platform code or even sysfs.
>>>>> 
>>>>> One thing I can try is to dynamically change the channels the
>>>>>  system timer and clocksource are using when the current ones
>>>>> are requested for PWM. But that sounds hardcore...
>>>> 
>>>> Yes, it is :/
>>>> 
>>>> Sorry for letting you wasting time and effort to write an
>>>> overkill code not suitable for upstream.
>>>> 
>>>> A very gross thought, wouldn't be possible to "register" a
>>>> channel from the timer driver code in a shared data area (but
>>>> well self-encapsulated) and the pwm code will check such
>>>> channel isn't in use ?
>>> 
>>> Probably, but it's the contrary I need to do. The timer driver
>>> code can use any channel, and probes first. The PWM driver code
>>> must use specific channels, and probes last. So either the timer
>>> driver knows what channels it can't use, thanks to a device
>>> property, or it adapts itself when a channel in use is requested
>>> for PWM, which is what I tried in v7.
>> 
>> When you say "must use specific channels", where is coming this 
>> information ?
> 
> If the backlight for the LCD is connected to the pin that corresponds
> to PWM1, then you must use the TCU channel 1. It's that simple.

Is it a runtime detection or is it hardcoded somewhere ?

(just trying to understand the whole picture)

>>> I think we could find a way to use a devicetree property that
>>> doesn't trigger Rob. That would still be the easiest and cleanest
>>> solution.
>>> 
>>> Maybe "ingenic,reserved-channels-mask", which would contain a
>>> mask of channels that can only be used by the timer driver. And
>>> what the timer driver does with these channels, would be specific
>>> to the implementation and would not appear in the bindings. I
>>> hope Rob can work with that.
>>> 
>>> -Paul


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

