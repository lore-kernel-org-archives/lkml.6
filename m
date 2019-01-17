Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046C5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA99520868
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u4efZNEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfAQVIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:08:14 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39373 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfAQVIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:08:13 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so9806528ljh.6;
        Thu, 17 Jan 2019 13:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A5v8RB4GhA4NSV52zaWxDiHor92dbSvHzODZw5uUhPs=;
        b=u4efZNEIE7xu4YgyOt0r5J5fhSLTOIyBputZxtNu42sGdA8irzUSH2UAff741u4dIR
         ty9eUsFSTPgac5bx3p+76tRExOqlTn+WYqfbdPmawVKeXXkcA7RFhwkBb4YUFKuOgbkY
         Tx6ZeEsboU7TuwbabNfvWZuaBUQ6z8taxdoEh6a1PxGzNqpW8YqujJGu1AXD0sSEq0U0
         IMdkpt4ASDuHTjImKBmrw2ypioSwfmuwR6OfxwqM9kILzPM2bwcFsxmRLkelQ6Av5fOZ
         t0P8wmY3uUzRBOHVEv6L93uBGeNuuyahdkHD69efZ7RyNkrN3zL+w7S01zoGeAY2YqJY
         myjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A5v8RB4GhA4NSV52zaWxDiHor92dbSvHzODZw5uUhPs=;
        b=pSDRx037pPPjz9OH3Z7eRbFyHIKboSHU9jFixYljsQHxSEoyQgLhB8bw/beS+Hxhv+
         JUN3el8Np8x4i48bDUAZgd9YKK/Fkflxbeal5Ju8eLQBqqHA+OiZAoWzKdLKwEVG3prF
         oyaR0yYS8EzdVe8W+N30xOA7OFaoHnM4k1vsfG9oSpYL2jIedcExXnS74i5RqWsdjKmi
         +5MDhUiCQzc5TGaKTKHqtInBelDW7aHLSfz7jUH2N3B6eLM6tnE7VsPsZSN+pxV59kYc
         KV0UPDgUkjPUFodSriMNdYuwYtxkMXIbfG4MuUBtbE+P9zVLQ6tYvsZhxroXjj6VgAsJ
         jJIw==
X-Gm-Message-State: AJcUukdpH2hWff79sjTcR4TJ0fJzmZSqkGfHWkWEKjNgSgnEoSygByIl
        vu8K6JIvRMsLIVpawqfWCjg=
X-Google-Smtp-Source: ALg8bN4uNV7NkrVk0E2AMQBiZHytqj4D9HcJzPhO8U5QkNuK/0uK/9Jfmvr9AQkmncjfBZEZuRefZw==
X-Received: by 2002:a2e:8643:: with SMTP id i3-v6mr9469994ljj.43.1547759290715;
        Thu, 17 Jan 2019 13:08:10 -0800 (PST)
Received: from [192.168.1.18] (dnm233.neoplus.adsl.tpnet.pl. [83.24.94.233])
        by smtp.gmail.com with ESMTPSA id a62sm480758lfa.37.2019.01.17.13.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 13:08:09 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX family of the RGB LED
 driver
To:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dachaac@gmail.com, robh+dt@kernel.org
References: <20190114211723.11186-1-dmurphy@ti.com>
 <20190114211723.11186-2-dmurphy@ti.com>
 <ce911fdf-c7c2-63e8-5c7a-b0be965ab69b@gmail.com> <20190115222223.GA17363@amd>
 <79394d17-3124-75b2-ccac-dc1046499d14@ti.com> <20190116105537.GA1803@amd>
Message-ID: <efb4e1c1-0d13-bed7-d262-284fc1a0c9ab@gmail.com>
Date:   Thu, 17 Jan 2019 22:08:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190116105537.GA1803@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 11:55 AM, Pavel Machek wrote:
> Hi!
> 
>> On 1/15/19 4:22 PM, Pavel Machek wrote:
>>> Hi!
>>>
>>>>> +The 24-bit RGB value passed in follows the pattern 0xXXRRGGBB
>>>>> +XX - Do not care ignored by the driver
>>>>> +RR - is the 8 bit Red LED value
>>>>> +GG - is the 8 bit Green LED value
>>>>> +BB - is the 8 bit Blue LED value
>>>>> +
>>>>> +Example:
>>>>> +LED module output 4 of the LP5024 will be a yellow color:
>>>>> +echo 0xe6de00 > /sys/class/leds/lp5024\:led4_mod/color
>>>>> +
>>>>> +LED module output 4 of the LP5024 will be dimmed 50%:
>>>>> +echo 0x80 > /sys/class/leds/lp5024\:led4_mod/brightness
>>>>> +
>>>>> +LED banked RGBs of the LP5036 will be a white color:
>>>>> +echo 0xffffff > /sys/class/leds/lp5036\:led_banked/color
>>>>
>>>> This part with example cans remain in Documentation/leds if you
>>>>> like.
>>>
>>> Does it actually work like that on hardware?
>>
>> What?
> 
> If you do echo 0xffffff > /sys/class/leds/lp5036\:led_banked/color,
> does it actually produce white? With all the different RGB modules
> manufacturers can use with lp5024P?
> 
> If you do echo 0xe6de00 > /sys/class/leds/lp5024\:led4_mod/color, does
> it actually produce yellow, with all the different RGB modules
> manufacturers can use with lp5024P?

Vesa proposed using icc-profiles to make the colors looking similar
on various LEDs. It was in reply to your message with requirements
for RGB LED class.

For this device we can however do without it. Videos showing the
performance of this particular device with a reference design using
RGB LEDs prove it works nice.

>>> Is it supposed to support "normal" RGB colors as seen on monitors?
>>
>> Monitors are not an application for this part.
> 
> You did not answer the question. When you talk about yellow, is it
> same yellow the rest of world talks about?
> 
>>> Because 100% PWM on all channels does not result in white on hardware
>>> I have.
>>
>> I don't know I am usually blinded by the light and have no diffuser over
>> the LEDs to disperse the light so when I look I see all 3 colors.
> 
> How can we have useful discussion about colors when you don't see the
> colors?
> 
> Place a piece of paper over the LEDs....
> 
>>> But...
>>>
>>> I believe we should have a reasonable design before we do something
>>> like this. There's no guarantee someone will not use lp50xx with just
>>> the white LEDs for example. How will this work? Plus existing hardware
>>> already uses three separate LEDs for RGB LED. Why not provide same
>>> interface?
>>
>> Which existing hardware?  Are they using this part?
> 
> Nokia N900. They are not using this part, but any interface we invent
> should work there, too.
> 
>> <rant>
>> Why are we delaying getting the RGB framework or HSV in?
>> I would rather design against something you want instead of having
>> everyone complain about every implementation I post.
>> </rant>
> 
> Because you insist on creating new kernel interfaces, when existing
> interfaces work, and are doing that badly.
> 
> Because your patches are of lower quality than is acceptable for linux
> kernel.

Lets keep things civil please.

This sentence should look familiar to you - it's not the first time
you resort to this type of narration.

> Because you don't seem to be reading the emails.
> 
> I sent list of requirements for RGB led support. This does not meet
> them.

And you didn't respond to the comments from Vesa. The requirements
has not been acclaimed.

>> It is not a normal RGB driver.  The device collates the individual RGB
>> clusters into a single brightness register and you can modify the intensity of the individual
>> LEDs via other registers.  If brightness is 0 then the cluster is OFF regardless of the color
>> set in the individual registers.
> 
> I understand that. So just set cluster brightness to 255 and you have
> normal RGB driver you can control with existing interfaces. You don't
> have to use every feature your hardware has.

This feature is one of the core advantages of this device.

> You did not answer the "what if someone uses this with all white LEDs"
> question.
> 
> You know what? First, submit driver with similar functionality to
> existing RGB drivers, using same interface existing drivers are
> using. When that is accepted, we can talk about extending
> kernel<->user interfaces.

This stands in contradiction with my request.

Provided there will be no other NAKs, I am eager to accept the
interface with color and brightness files.

Moreover, I think that RGB LED class with configurable
brightness-model, and with possible color range adjustments via
icc-profiles or something similar, is the best solution that has been 
proposed so far. It is just flexible.

I'd like to capitalize on the ideas shared in this thread and have
finally LED RGB class materialized.

-- 
Best regards,
Jacek Anaszewski
