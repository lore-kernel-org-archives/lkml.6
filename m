Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD48C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 01:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495442081C
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 01:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUFf2coB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495442081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731520AbeKNLgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 06:36:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34382 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeKNLgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 06:36:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id 17so6308325pgg.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 17:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gQvd9hsuChOZr2uqZiJ3OSXJcekmgdWGffcbGLSrkSQ=;
        b=RUFf2coBYbREPn6iG4VGWZsSEo9YJIkkBEZzKZ5elfdfCqZX3NLWanhqnAuEPsk2GS
         4WhFr1QbiHkbe5H+Te4Tn/uWiXR4xU/eG7TfJ02y17QjKN7kpvHcx2nyxyrEqc16fdV8
         4CMd3HvsnLNasN/gcVR2y30Z3Wc6J94tTi/p7E59tp35gxpzNC+LJPqqfF/9uSM5/Aj8
         w6U5lYPXzjh6jSXHJamoBixNcMCjbmp13zhD7knQaTQEaln3HKjZ/oKYJrYiMNLuLaZ5
         HvyRt/uOEjfJHK68M0k216/T9zYSQ81rf5EfnSGP1fxMtNEioaDyCxuqtw8y9i6BX42P
         1HuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gQvd9hsuChOZr2uqZiJ3OSXJcekmgdWGffcbGLSrkSQ=;
        b=i3sFfwXVP8xjvzOjpaEDGy4ZzfbwHiC9Y81bF9jkH4mm8P0OQH4NcMvZ6g96YM4cgp
         JTlcxBlaFkn3IZSUwS4I+2BEWdMZRjvyJQ/jfLbbJ+r8CbPrjNXzZcYZSfkJxaKGf1EX
         x469m9tKP/w2aNBhfAsKg7vF1YVCTjzRjOe0Mgv1gNjrIJy5xFkVlhGZJ5UJ9FGcDn0O
         THWTjOjlAa6Fp77nGDRei3AXNlC81w9pY4rxCrF1ClmZ4h3PHyx/xsw+JiAgL4SGWOud
         1cwctPWu/58qd1+0NATF1AgQa0rP29ZcI7aVdFX4+Hfa/CX6SjxNvrEIH28dcDwkQl/O
         XcUQ==
X-Gm-Message-State: AGRZ1gIIyOzlrur+noUI4rDsZAeAGoMt4s9u/qGyRx6c+RbGnhR1TJbO
        /mLJHmW+Bp2WHN2tts98P7c=
X-Google-Smtp-Source: AJdET5d65Ha2lATK0uTmK8YHtmTj9Fo0V51wHzuipZHenWjjO/NsD+ECeoXN5NOkEEQK4Hi0TKOnNw==
X-Received: by 2002:a63:d441:: with SMTP id i1-v6mr6884079pgj.31.1542159340578;
        Tue, 13 Nov 2018 17:35:40 -0800 (PST)
Received: from ?IPv6:2001:df0:0:200c:258c:e8b8:3f2:c132? ([2001:df0:0:200c:258c:e8b8:3f2:c132])
        by smtp.gmail.com with ESMTPSA id p11sm13969294pgn.60.2018.11.13.17.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 17:35:39 -0800 (PST)
Subject: Re: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
To:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Finn Thain <fthain@telegraphics.com.au>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
 <20181112083422.GA19695@infradead.org>
 <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
 <20181113092012.GI30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811140854280.371@nippy.intranet>
 <20181113234336.GP30658@n2100.armlinux.org.uk>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <d9be7418-cc4a-f92f-1aa8-d92a58cd68a4@gmail.com>
Date:   Wed, 14 Nov 2018 14:35:29 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181113234336.GP30658@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/11/18 12:43 PM, Russell King - ARM Linux wrote:
> On Wed, Nov 14, 2018 at 08:55:37AM +1100, Finn Thain wrote:
>> On Tue, 13 Nov 2018, Russell King - ARM Linux wrote:
>>
>>> On Tue, Nov 13, 2018 at 02:39:00PM +1100, Finn Thain wrote:
>>>> You could remove the old arch_gettimeoffset API without dropping any
>>>> platforms.
>>>>
>>>> If no-one converts a given platform to the clocksource API it would mean
>>>> that the default 'jiffies' clocksource will get used on that platform.
>>>>
>>>> Clock resolution and timer precision would be degraded, but that might not
>>>> matter.
>>>>
>>>> Anyway, if someone who has this hardware is willing to test a clocksource
>>>> API conversion, they can let me know and I'll attempt that patch.
>>> There's reasons why that's not appropriate - such as not having two
>>> separate timers in order to supply a clocksource and separate clock
>>> event.
>>>
>>> Not all hardware is suited to the clocksource + clockevent idea.
>>>
>> Sorry, I don't follow.
>>
>> AFAIK, clocksources and clock event devices are orthogonal concepts. There
>> are platforms with !ARCH_USES_GETTIMEOFFSET && !GENERIC_CLOCKEVENTS (and
>> every other combination).
>>
>> A clocksource read method just provides a cycle count, and in this sense
>> arch_gettimeoffset() is equivalent to a clocksource.
> A clocksource provides a cycle counter that monotonically changes and
> does not wrap between clockevent events.
>
> A clock event is responsible for providing events to the system when
> some work is needing to be done, limited by the wrap interval of the
> clocksource.
>
> Each time the clock event triggers an interrupt, the clocksource is
> read to determine how much time has passed, using:
>
> 	count = (new_value - old_value) & available_bits
> 	nanosecs = count * scale >> shift;
>
> If you try to combine the clocksource and clockevent because you only
> have a single counter, and the counter has the behaviour of:
> - counting down towards zero
> - when reaching zero, triggers an interrupt, and reloads with N
>
> then this provides your clockevent, but you can't use this as a clock
> source, because each time you receive an interrupt and try to read the
> counter value, it will be approximately the same value.  This means
> that the above calculation fails to register the correct number of
> nanoseconds passing.  Hence, this does not work.

So we'd still have to use jiffies + interpolation from the current timer 
rundown counter as clocksource (since that will be monotonous and won't 
wrap)?

The way Finn did the clocksource for m68k, the clocksource counter does 
behave as it should (monotonous, doesn't wrap) at least so far as I've 
tested. Using the same timer for clocksource and clock events will 
degrade timekeeping based on timer events to jiffies resolution, as you 
point out. That would already have been the case before, so no gain in 
resolution. Other timekeeping would have worked at higher resolution 
before (interpolating through arch_gettimeoffset) just the same as now 
(interpolating through clocksource reads). Finn's clocksource read code 
essentially is arch_gettimeoffset under a new name.

Are you saying that's not possible on arm, because the current timer 
rundown counter can't be read while the timer is running?

If I were to run a second timer at higher rate for clocksource, but 
keeping the 10 ms timer as clock event (could easily do that by using 
timer D on Atari Falcon) - how would that improve my timekeeping? Clock 
events still only happen 10 ms apart ...

Cheers,

     Michael

>
> Also note where I said above that the clock event device must be able
> to provide an interrupt _before_ the clocksource wraps - clearly with
> such a timer, that is utterly impossible.
>
> The simple solution is to not use such a counter as the clocksource,
> which means you fall back to using the jiffies clocksource, and your
> timekeeping has jiffy resolution - so 10ms, or possibly 1ms if you
> want a 1kHz timer interval.  For most applications, that's simply way
> to coarse, as was realised in the very early days of Linux.
>
> If only there was a way to interpolate between timer interrupts...
> which is exactly what arch_gettimeoffset() does, and is a historical
> reminant of the pre-clocksource/clockevent days of the kernel - but
> it is the only way to get better resolution from this sort of setup.
>
