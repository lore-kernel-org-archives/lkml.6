Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4FAC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 13:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D3620854
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 13:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="izh+B+dU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D3620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeIIS21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 14:28:27 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46079 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbeIIS21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 14:28:27 -0400
Received: by mail-oi0-f68.google.com with SMTP id t68-v6so35313103oie.12
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 06:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HC1zs5IzIHuYzvbdzHtYGcnZ90chaRrMSZb0TvV0u7s=;
        b=izh+B+dUvr8VNeyRxhVTXQguvEr3yoU5DCMjrJm1bYPoYYS2RnijvNEFTG4NgqNjnr
         LAsSjkC2YRCQ9wkPAlOSkPK4g7L5N/72oNNV2JtmBXwGlxmBnhrRsrURLPdj/h4nRgmp
         XAFmzZjf2MVpDGUAgtlpHiCblyu8yjxM+08Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HC1zs5IzIHuYzvbdzHtYGcnZ90chaRrMSZb0TvV0u7s=;
        b=EHrnmjgKkkBLAxukdlJrM//FeGB1g0zadXTUFVGU4QOgZo/N3ISt9a7q08YXHPLebI
         sTltNga9I9NMOdYv/erLuraT0YJjudDQyte++Wqt1K74iAAnANfx08Rps/aUAUwCav6F
         AShnmZlIYOqzxQOz8l+t/ecQeA0EPZWlk2a1VC7dXqQUcbuk8r/3d7NIESdjfC3PcZ7r
         xtC/fT26vTfIQE82/jDjpwEYRqwh3Js8fNMCFMdqu3QwVg1w8xD8c6ATBEXr11D4i2Y7
         g/OZY+lVGyUqnXfdbeu2RAI8TFWK4R3YzCfgTw9cMNLju+lTQh1DQwfz6s3D9WzToH9U
         4iCg==
X-Gm-Message-State: APzg51BwB9qrJKU1JHS3Fl1b38U0hyJpT2v4CXMr8iQrEdAzK/4xDKSn
        RNW8a8YVoVqnN1KjBtkTo86umIM/YezjYQjtlyaPHg==
X-Google-Smtp-Source: ANB0VdYfFJJNAmUHpJuhDP5QS1obKwAT2oNbaDOme1FgcBuzuTyBLNkVmiaaCcH0Z9aEPpCZS340o8iB5XwusWS8a2E=
X-Received: by 2002:aca:e005:: with SMTP id x5-v6mr16988687oig.328.1536500322980;
 Sun, 09 Sep 2018 06:38:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3ec8:0:0:0:0:0 with HTTP; Sun, 9 Sep 2018 06:38:42 -0700 (PDT)
In-Reply-To: <0190dc10-99a3-abb7-b196-a537c49a2b6e@gmail.com>
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536027873.git.baolin.wang@linaro.org>
 <20180908050208.GY2523@minitux> <0190dc10-99a3-abb7-b196-a537c49a2b6e@gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Sun, 9 Sep 2018 21:38:42 +0800
Message-ID: <CAMz4kuK=t9t0nZaVHguv_BVH5WKTDvxPrxCjPrpws9=VV_57ag@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] leds: core: Introduce LED pattern trigger
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 September 2018 at 04:19, Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
> Hi Bjorn,
>
> On 09/08/2018 07:02 AM, Bjorn Andersson wrote:
>> On Tue 04 Sep 04:01 PDT 2018, Baolin Wang wrote:
>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
>> [..]
>>> +What:               /sys/class/leds/<led>/hw_pattern
>>> +Date:               September 2018
>>> +KernelVersion:      4.20
>>> +Description:
>>> +            Specify a hardware pattern for the LED, for LED hardware that
>>> +            supports autonomously controlling brightness over time, according
>>> +            to some preprogrammed hardware patterns.
>>> +
>>> +            Since different LED hardware can have different semantics of
>>> +            hardware patterns, each driver is expected to provide its own
>>> +            description for the hardware patterns in their ABI documentation
>>> +            file.
>>> +
>>
>> So, after a full circle we're back at drivers with support for hardware
>> patterns should have their own ABI for setting that pattern.
>>
>> The controls for my hardware is:
>> * a list of brightness values
>> * the rate of the pattern
>> * a flag to indicate that the pattern should be played from start
>>   to end, end to start or start to end to start
>> * a boolean indicating if the pattern should be played once or repeated
>>   indefinitely.
>>
>> Given that the interface now is hw specific, what benefit is there to
>> attempt to cram these 4 knobs into "hw_pattern"? Or am I allowed to
>> create additional files for the latter three?
>
> So this is an argument corroborating my concerns raised in [0].
> I really think that we should allow for custom pattern interfaces
> defined by LED class drivers.
>
>>> +What:               /sys/class/leds/<led>/repeat
>>> +Date:               September 2018
>>> +KernelVersion:      4.20
>>> +Description:
>>> +            Specify a pattern repeat number. 0 means repeat indefinitely.
>>> +
>>> +            This file will always return the originally written repeat
>>> +            number.
>>
>> I'm still convinced that this will confuse our users and to me it would
>> be more logical if this denotes the number of times the pattern should
>> be repeated, with e.g. negative numbers denoting infinite.
>
> Sounds reasonable. Let's change this semantics as you propose.
>
>> In particular I expect to have to explain why my driver expects that you
>> write 0 in the file named "repeat" to make it repeat and 1 to make it
>> not repeat.

Hm, so there are some cases we need to make clear.
1) If negative numbers present infinite, so what's the meaning of number 0?
2) What we should show for users if repeat number is negative, just
show negative numbers or one string "infinite"?

-- 
Baolin Wang
Best Regards
