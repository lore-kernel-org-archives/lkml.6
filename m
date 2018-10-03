Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFBBC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591F7213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hg50ZDra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591F7213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbeJCTfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:35:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41209 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbeJCTfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:35:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id x12-v6so5985666wru.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XXZeOq9gh3iq5DPdLmF/iQ3Zk9nUnd2tZx6d10eHQDo=;
        b=Hg50ZDraJUQsAW4ro8mpr1QTPPKtRY1N/1THO4bwOlxWs6XV98EWRobvd+8IhU2gW4
         Lywh8r95YbcAkKS2VgzMIfoxEZe8CBK7doNRPwW9992fRHvkvTWzs2xO1IXksivXZCOt
         HfkOEE3kk3+8bk9VWd4g/9F5C6HUkeubYxjgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XXZeOq9gh3iq5DPdLmF/iQ3Zk9nUnd2tZx6d10eHQDo=;
        b=uTyzks9czX+ZYgSxJnFBEoFtrBCaWXrA8F6AEOuP3VfMdx+bIWk934N/l1WqSltvjN
         nAoJY3Z6BOTv4NHWS4xzTMhXcInInVZWZY3sucz9+kRwGH86/vIBqKPa65vi2VMiAo4N
         uek7fwr23EImtJmMBwOeVrOx19vnPrO5J/a30EB9HvgSKo4GlanrtAexRYagdP1aPxBG
         ZfJ/AsrUSfmAMo8pfJZtFBniOJO7GVBbRyKO5XLrg1g4rCZEBOAYnnVF0zdDcbjWRLJR
         Qm7NNNR95TsPcLh+q9bMVvu6ceLQQ5TSe+tX0qvDEms55hFbJ09KHzJbB3ikh4gRT5Cd
         B1Tg==
X-Gm-Message-State: ABuFfoiaWcDGWCKS6CYEvLh9552se0j6s6jmHqJXp4/SEF8NHgv1rYMY
        EDxv2b1BOakCeSDwn1lpyX38rw==
X-Google-Smtp-Source: ACcGV6102QX/fVzouu1kcJ63LUGmKbHYT3l4t+ysTPl005Aq05AqKmfqAAgyIGGHNDil95Ui2x7zTA==
X-Received: by 2002:a5d:53c3:: with SMTP id a3-v6mr1171611wrw.191.1538570844544;
        Wed, 03 Oct 2018 05:47:24 -0700 (PDT)
Received: from [192.168.0.41] (84.152.136.77.rev.sfr.net. [77.136.152.84])
        by smtp.googlemail.com with ESMTPSA id s26-v6sm952763wmh.11.2018.10.03.05.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 05:47:23 -0700 (PDT)
Subject: Re: [PATCH v5 04/21] dt-bindings: Add doc for the Ingenic TCU drivers
To:     Paul Cercueil <paul@crapouillou.net>, robh@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-mips@linux-mips.org, Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
References: <5bb49c78.1c69fb81.4b6a9.fb44SMTPIN_ADDED_MISSING@mx.google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7c448bfb-b4a6-8a09-db3d-32c829d5ec78@linaro.org>
Date:   Wed, 3 Oct 2018 14:47:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5bb49c78.1c69fb81.4b6a9.fb44SMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2018 12:32, Paul Cercueil wrote:
> 
> Le 1 oct. 2018 10:48, Daniel Lezcano <daniel.lezcano@linaro.org> a
> écrit :
>> 
>> On 31/07/2018 00:01, Paul Cercueil wrote:
>> 
>> [ ... ]
>> 
>>>>> +- ingenic,timer-channel: Specifies the TCU channel that
>>>>> should be used as +  system timer. If not provided, the TCU
>>>>> channel 0 is used for the system timer. + +-
>>>>> ingenic,clocksource-channel: Specifies the TCU channel that 
>>>>> should be used +  as clocksource and sched_clock. It must be
>>>>> a different channel than the one +  used as system timer. If
>>>>> not provided, neither a clocksource nor a +  sched_clock is
>>>>> instantiated.
>>>> 
>>>> clocksource and sched_clock are Linux specific and don't belong
>>>> in DT. You should define properties of the hardware or use
>>>> existing properties like interrupts or clocks to figure out
>>>> which channel to use. For example, if some channels don't have
>>>> an interrupt, then use them for clocksource and not a
>>>> clockevent. Or you could have timers that run in low-power
>>>> modes or not. If all the channels are identical, then it 
>>>> shouldn't matter which ones the OS picks.
>> 
>> It can't work in this case because the pmw and the timer driver are
>> not communicating and the first one can stole a channel to the last
>> one.
> 
> In that particular case the timer driver will always request its
> channels first; with no timer set the system hangs before
> subsys_initcall, and the PWM driver is a subnode of the timer node,
> so is probed only after the timer probed.
> 
>>> We already talked about that. All the TCU channels can be used
>>> for PWM. The problem is I cannot know from the driver's scope
>>> which channels will be free and which channels will be requested
>>> for PWM. You suggested that I parse the devicetree for clients,
>>> and I did that in the V3/V4 patchset. But it only works for
>>> clients requesting through devicetree, not from platform code or
>>> even sysfs.
>>> 
>>> One thing I can try is to dynamically change the channels the
>>> system timer and clocksource are using when the current ones are
>>> requested for PWM. But that sounds hardcore...
>> 
>> Yes, it is :/
>> 
>> Sorry for letting you wasting time and effort to write an overkill
>> code not suitable for upstream.
>> 
>> A very gross thought, wouldn't be possible to "register" a channel
>> from the timer driver code in a shared data area (but well
>> self-encapsulated) and the pwm code will check such channel isn't
>> in use ?
> 
> Probably, but it's the contrary I need to do. The timer driver code
> can use any channel, and probes first. The PWM driver code must use
> specific channels, and probes last. So either the timer driver knows
> what channels it can't use, thanks to a device property, or it adapts
> itself when a channel in use is requested for PWM, which is what I
> tried in v7.

When you say "must use specific channels", where is coming this
information ?

> I think we could find a way to use a devicetree property that doesn't
> trigger Rob. That would still be the easiest and cleanest solution.
> 
> Maybe "ingenic,reserved-channels-mask", which would contain a mask of
> channels that can only be used by the timer driver. And what the
> timer driver does with these channels, would be specific to the
> implementation and would not appear in the bindings. I hope Rob can
> work with that.
> 
> -Paul
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

