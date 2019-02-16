Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF46C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 22:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C3421B1C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 22:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733271AbfBPWDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 17:03:14 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36998 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfBPWDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 17:03:14 -0500
Received: by mail-ed1-f67.google.com with SMTP id m12so10719260edv.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 14:03:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6k7OWEmDF+10Mf8UcQUw4WI5cx+wInndK3Oe9GjJUuQ=;
        b=q0wY34Uv1AHmw1sL2XOpAUOSj2fm/igkaNIZnrQgUKkda+1hBt+IzrTEg8bB0iE0n7
         ES5BpBWMxHz3SllG+a4UvC8g5XKX6eGNpmPSSkoHcW0h0ufz9Ku/SjEY1/RUZ2iiG61v
         81DGBxhS9DFnsAFO9UadzFCMbRVNRgwR9jEEuSyRKI5uzJ0y65bTyC6eqvFk/07cxd46
         DrOTJpcLV5MSJ78B+Hoj0DSYtYyCkyx3TpwkMtw8x0kJ3hyg6rT2DkFr/8ToHdnkqUJE
         77CUnWmt/U2v2FvbVpeJ68rCe9mL9h6h2x+I6ocRJzJvJeeV4aCk9CXXhqw2AHhBLKpq
         W+wQ==
X-Gm-Message-State: AHQUAuawK5GMygVdkRHNT99p6VnKExoPBq34gntXzs2zhUwVLAmkG5HU
        GC7v7x6q1dcLw7iaUJkKAJZ9ew==
X-Google-Smtp-Source: AHgI3IZe6/SfxoUe9rro3qp3KXaNDWcmQtLuLinpGtNIn1z0zIvlZryrhyU0UhvasG/WypN4PAaJtg==
X-Received: by 2002:a17:906:3719:: with SMTP id d25mr11086521ejc.142.1550354591801;
        Sat, 16 Feb 2019 14:03:11 -0800 (PST)
Received: from localhost.localdomain ([2001:678:814:68:8573:4f61:f765:5d7e])
        by smtp.gmail.com with ESMTPSA id k26sm2059486ejv.63.2019.02.16.14.03.10
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 14:03:11 -0800 (PST)
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <92cf09b8-726d-4f1b-94ba-368a66af2246@redhat.com>
 <2b6faaa5-b21e-a512-de7d-ca21be5045fc@gmail.com> <20190214230307.GA17358@amd>
 <2a5e2002-e5f1-6da3-8a43-317801b69657@redhat.com>
 <3d5407a7-9458-f071-a1d5-511b09678e20@gmail.com>
 <87a21c4e-8e5e-c180-2ff3-eb8170746e71@redhat.com>
 <80971bc3-1193-83ed-913a-12f6217016c8@gmail.com>
 <b15fd048-8206-4057-a354-07dc14ca15e3@redhat.com>
 <8a263266-a41f-c916-e990-02d04de9b5d0@gmail.com>
 <af5bec7b-0da1-ee19-cdf4-0240f56221ad@redhat.com>
 <20190216193727.GA14305@amd> <2d5c6f50-c41f-655c-ab03-0c66aa911a27@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fc178a78-8e12-1892-3fde-21333e65667c@redhat.com>
Date:   Sat, 16 Feb 2019 23:03:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2d5c6f50-c41f-655c-ab03-0c66aa911a27@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/16/19 10:54 PM, Jacek Anaszewski wrote:
> On 2/16/19 8:37 PM, Pavel Machek wrote:
>> Hi!
>>
>>>>>>> I think that should work fine, which means that we can use the timer and
>>>>>>> pattern trigger support for the blinking and breathing modes.
>>>>>>>
>>>>>>> That still leaves the switching between user and hw-control modes,
>>>>>>> as discussed the hw-controlled mode could be modelled as a new "hardware"
>>>>>>> trigger, but then we cannot choose between on/blink/breathing when
>>>>>>> in hw-controlled mode. As Pavel mentioned, that would require some
>>>>>>> sort of composed trigger, where we have both the hardware and
>>>>>>> timer triggers active for example.
>>>>>>>
>>>>>>> I think it might be easier to just allow turning on/off the hardware
>>>>>>> control mode through a special "hardware_control" sysfs attribute and
>>>>>>> then use the existing timer and pattern triggers for blinking / breathing.
>>>>>>
>>>>>> Pattern trigger exposes pattern file by default and hw_pattern if
>>>>>> pattern_set/get ops are provided. Writing them enables software and
>>>>>> hardware pattern respectively.
>>>>>
>>>>> This is not about software vs hardware pattern.
>>>>>
>>>>> There are 2 *orthogonal*, separate problems/challenges with this LED controller:
>>>>>
>>>>> 1) It has hardware blinking and breathing, as discussed this can be
>>>>> controlled through the timer and pattern triggers, so this problem
>>>>> is solved.
>>>>>
>>>>> 2) It has 2 operating modes:
>>>>>
>>>>> a) Automatic/hardware controlled, in this mode the LED is turned
>>>>> off or on (where on can be continues on, blinking or breathing)
>>>>> by the hardware itself, when in this mode we / userspace is not
>>>>> in control of the LED
>>>>>
>>>>> b) Manual/user controlled mode, in this mode we / userspace can
>>>>> control of the LED.
>>>>>
>>>>> Currently there is no API in the ledclass to switch a LED from
>>>>> automatic controlled to user controlled and back, This is what
>>>>> the proposed hardware trigger was for, to switch to automatic
>>>>> mode. A problem with this is that we still want to be able
>>>>> to chose between continues on, blinking or breathing (when on),
>>>>> configure the max brightness, etc.
>>>>
>>>> Yes, we do have the API to switch a LED from automatic (hardware
>>>> accelerated) control to software control and back. This is pattern
>>>> trigger, which exposes two files for setting pattern: pattern
>>>> and hw_pattern. Writing pattern file switches the device to software
>>>> control mode and writing hw_pattern switches it to the hardware control,
>>>> with the possibility of defining device specific ABI syntax to enable
>>>> particular pattern (blinking, breathing or event permanently on
>>>> in case of this device).
>>>
>>> OK, I see. So we would use the hw_pattern for this and the driver
>>> would implement the pattern_set led_classdev callback.
>>>
>>> The pattern_set callback would then expect 6 brightness/time tuples
>>> with the following meaning for the time part of each tupple
>>>
>>> tupple0: charging blinking_on_time
>>> tupple1: charging blinking_off_time
>>> tupple2: charging breathing_time
>>> tupple3: manual blinking_on_time
>>> tupple4: manual blinking_off_time
>>> tupple5: manual breathing_time
>>>
>>> Where only the times in tupple 0-2; or the times in 3-5 can be
>>> non-zero. Having non zero times for both some charging and some
>>> manual values is not allowed.
>>>
>>> If a breathing time is set, none of the other times may be non
>>> 0. If blinkig_on and blinking_off are used then breathing_time
>>> must be 0.
>>>
>>> When configured to blink then blinking_off must be either 0
>>> (continuously on); or it must be the same as blinking_on.
>>>
>>>
>>> I believe this will work, does this sound ok to you ?
>>
>> I don't pretend to fully understand it, _but_ hw_pattern should really
>> describe the pattern LED should do, not whether it reacts to charging
>> or not.
> 
> This is hardware specific and is supposed to have dedicated ABI
> documentation. There's no reason to introduce new mechanisms when
> existing ones fit. It will still describe a pattern but activated
> on some condition.

Right, but we can control the condition, so either we need to make
the condition part of the pattern as in my recent proposal with:

tupple0: charging blinking_on_time
tupple1: charging blinking_off_time
tupple2: charging breathing_time
tupple3: manual blinking_on_time
tupple4: manual blinking_off_time
tupple5: manual breathing_time

As hw_pattern ABI; or we need to add an extra sysfs file to
set the condition.

So do you prefer the driver to code the condition into the hw_pattern
(see above); or do you prefer a separate sysfs attribute for the condition?

Regards,

Hans

