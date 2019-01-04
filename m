Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53033C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4A2218E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvdxlwwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfADTtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 14:49:13 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:37074 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfADTtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 14:49:12 -0500
Received: by mail-lj1-f176.google.com with SMTP id t18-v6so33338374ljd.4;
        Fri, 04 Jan 2019 11:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p630ZjgHiPDA3Dc87dRfef7i47wK7ls3bwvkClnRb6U=;
        b=qvdxlwwJJGCL3pV+unO7sVfZNi4gIUdWJu/Ru4vMPwhYnWNoZftIv58WD2YravZJZl
         2YMAbtqZ2pMJirQk+znRzKubYrjtk1TWoNbQW59D0DwU4tBGLr0Fr/n1Nr33bIvGQmkf
         aBryesvArTKTl8i3QBVoCmiMhC1oMh4+U1fSXr2WF0wY2JGoP4GT96ss6RNiP8nYoHKQ
         8Y+RKbXMaLMUT0uw4FajJ4ldig0nAFtyPc9UPTm39SXM154+4E9o6pLQ7OErWMtpdpTU
         UELeqxa5oTqJLZsbS0KCxJ49LsEIkRq2Sq2iU9Jp2OKRMX0zCHBfpFWK8rp3XOB3Lrnw
         SIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p630ZjgHiPDA3Dc87dRfef7i47wK7ls3bwvkClnRb6U=;
        b=T/s8+tNeFsr6CZLrGpXPWZz63LzRTwZvrlxKi8I/yo/CoEMH9S2BKE64OtMJ7nIFIA
         eav1ydaGcqdmZwndn/2ygMmPKmifRfF7vrKB5y+x/d0gRYHmSZwkfIk8oqpF4bAAVFhV
         WlhdiEVR8/SrYPjgGhQ78CKvfKwbZUsVGcqYXdVfI3X627OrjIJlzcdQ706k10NyIVOR
         Xu7crRxIyJN9SNrDRhxB6dPYKf/TayBHjvRx7X6ob2CuI+x4aYNjbKP3NAcYYX9lT+pF
         jPKO5zK/WBOtsUQDbhsI99J99odcm7+XhFQsjNGIcs/cmrUoBdjPlNS6870+3CTRNufY
         30nw==
X-Gm-Message-State: AJcUukf4KGHfsYxURP+Xfq6J9N2mrnO1mfDg0YBvHrvloIoNqhojaudO
        exI68KPVxlhV12oqna97Tv6o9eZQ2dk=
X-Google-Smtp-Source: AFSGD/U4YGc6jo7UZ5cGQyC2VjGiSUo22RHPLC6PjpeZ13xQ4/+KYoJH035vH+9YHkcSUaqgyZo9zQ==
X-Received: by 2002:a2e:8045:: with SMTP id p5-v6mr28657317ljg.87.1546631348647;
        Fri, 04 Jan 2019 11:49:08 -0800 (PST)
Received: from ?IPv6:2001:14ba:8017:3300:4da2:4604:cb6f:7dbe? (dtynxhycqzldylw7ss2-y-3.rev.dnainternet.fi. [2001:14ba:8017:3300:4da2:4604:cb6f:7dbe])
        by smtp.googlemail.com with ESMTPSA id a127sm11366172lfe.73.2019.01.04.11.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 11:49:07 -0800 (PST)
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20181219193455.GA21159@amd>
 <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com> <20181219201047.GA23448@amd>
 <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
 <a72c11c0-949b-bdbc-df2c-4490e04a1065@gmail.com>
 <986b5105-2fdb-bd25-7c8a-ca8fd1ade821@gmail.com>
 <7f205102-e854-f1cb-cc03-1307d1cddc87@gmail.com>
 <c9f8965a-90f4-b456-8225-c70694c9f071@gmail.com> <20190103233425.GA10071@amd>
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>
Message-ID: <e99036ea-ffb6-83ab-726b-824e2557d161@gmail.com>
Date:   Fri, 4 Jan 2019 21:49:06 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190103233425.GA10071@amd>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 04/01/2019 1.34, Pavel Machek wrote:
> Hi!
> 
>>> Regarding led_scale_color_elements() - I checked it in GIMP and
>>> the results are not satisfactory when increasing brightness.
>>> Even if we managed to fix it, the result would not be guaranteed
>>> to be the same across all devices.
>>
>> No and they will never be the same. I was told by our hardware expert that
>> it is rather impossible to get linearly behaving LED control without special
>> curve fitting trimmed for particular hardware and LED component in use. And
>> if you go and change LED component/vendor it would need to be "calibrated"
>> again if such accuracy would be required. Also LEDs age and that has also
>> effect on this.
> 
> Well, it is not possible to "perfectly" calibrate LCD monitors,
> either. Yet, color tables make sense for them.
> 
> And we should aim for the same thing.
> 
> And yes, it may mean re-doing calibration when vendor changes. And it
> will mean some math and some understanding of colors.
> 
> And... LEDs are linear-enough as it is. That is not a problem. But RGB
> does _not_ expect linear response. That's why colors are _way_ off currently.

Example what I was given was some LEDs are off for let's say 20% of PWM 
linearity and then there is non-linear curve for PWM value vs. intensity 
(this was in context of white LCD backlight).

One case where we currently are interested in linear intensity is LCD 
background color. For that we have ramp defined in device tree. There 
would probably be simple fix to get that curve fitting to work better 
but let's keep that as another topic for now.

I was thinking that if we get "calibration" curve support in PWM LED 
brightness we could then just use that as one solution within kernel and 
let LCD PWM brightness support use same functionality from LED 
framework. (eg. LCD backlight would bind to PWM controlled mono color 
LED node)

Other case is that we need to dim LEDs in low light situations.

As such I have nothing against adding support for HSL or other color 
space based brightness calculations. It might just need to be 
configurable what kind of mode is being used based on hardware solution 
in place. HSL seem to need a bit of fixed point math. Got floating point 
version working already but that does not work with kernel space so one 
needs to adapt it to fixed point.

One problem here is to figure out is if user configures some color -- is 
it configured with 100% brightness eg. Should one calculate RGB->HSL and 
then scale L with brightness and calculate RGB back for setting color -- 
or does it mean replacing L with brightness value?

Additional problem is then if you have let's say yellow LED color 
element there. How would one scale that then? Linear is of course easy. 
If you need to configure this to some color space then how does one 
define the color in device tree so that such color space conversion is 
possible? One possible solution is to calibrate the curve (like what you 
do with LCD calibration) and then just assume brightness as linear 
brightness value in that case.

Or if you have multi-color LED with red and green but no other color 
elements. How does brightness scaling work with this one?

>>> I have another proposal, being a mix of what has been discussed so far:
>>>
>>>     RGB LED class will expose following files:
>>>     a) available by default:
>>>       - red, green, blue
>>>         Writing any of these file will result in writing corresponding
>>>         device register.
>>
>> Problem with this is that we are basically back at square one and one cannot
>> do "atomic" color change with this.
>>
>> In order to set or activate new values one would need "load values" file or
>> such that when writing to it would activate new values. However it becomes
>> quite clumsy interface at that point as you need to handle multiple writes
>> to multiple files and makes those operations rather slow.
> 
> If you don't like the interface, create an shared library. It may be
> neccessary, anyway, for the color operations.
> 
> You say it is "rather slow" to change all 3 colors. How long does it
> take, and how long do you need it to take?

Some times in embedded linux systems you can see "stalls" in operation 
of an application flow eg. time is spent in different places. I believe 
"slowest" CPU with embedded linux we are using is Atmel's AT91 series 
(ARM9) and executing code in there can at times be a bit time consuming.

I have seen delays like 18ms in TI's AM335x CPU series (Cortex-A8) and 
not even too high load situations (eg. breaking some serial protocols 
because of breaks in transmission in-between transfer without being a 
problem in application code as such). It is completely different story 
when there is a bit of load in system or some special situation in the 
kernel/OS.

Running high priority thread for configuring LEDs to avoid problems 
sounds like a wrong solution.

Co-worker of mine tried multi-color LED brightness sliding from user 
space with current PWM led driver and it was visible from eye that it 
was not timed smoothly.

For GPIO LED we decided to use out-of-tree solution for multi-color LEDs 
because we didn't want to see wrong colors in LEDs or sliding colors. 
For this we have color preset table in device tree and with it color 
change is more or less atomic. And also it supports kernel based LED 
blinking with whatever color you have configured there first.

For PWM controlled multi-color LEDs we don't yet have a solution. We 
need configurable color kernel based blinking.

With Jacek's proposed interface one could do kernel based blinking if 
brightness is simulated or calculated (if trigger's ON brightness can be 
configured). Only problem I suppose is color transition from A to B 
state and after that the blinking would work nicely as target color 
would already be known by driver.

If we could figure out acceptable solution for color transition problem 
then I suppose all parties would be happy?

Thanks,
Vesa Jääskeläinen
