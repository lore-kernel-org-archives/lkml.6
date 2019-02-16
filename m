Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE97C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 17:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944982192B
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 17:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+GytP2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbfBPRCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 12:02:42 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35065 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731595AbfBPRCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 12:02:41 -0500
Received: by mail-lf1-f67.google.com with SMTP id v7so9426700lfd.2;
        Sat, 16 Feb 2019 09:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d66NTYpUHKYH4AvbeCuVhy5rB603YUFHdvFoxuVqcSw=;
        b=O+GytP2kEpWd+hEtSCXpwgsMn+5qrapRBhIGjJTXoqvDFZvrp5eBqHjNugTaVydtss
         kHgP9TiQHXl+MxhKjafndMgAcPi9pLNvDhaFMHvfzuZ7KUoW843Fdb88kwtcJ8/SPO19
         95PeNXpcvpQd16HVOW2tugMOhDX/y11oTbcsg/QR4+bTyD2ZrlIKfAy1D25PuGdNVjtQ
         nophOXORXMRyxKLZiB+5lkbSGs/f76DYF8gvIjJJyfGjoObX/MX8zJ4tsWmZ4ornRtk1
         rK0Rl9Om/7t6NqL7baVnSerKVnkig94w3SSeCt0+7291xn4F5bY7gGnXTDOZNDhsP5uR
         bX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d66NTYpUHKYH4AvbeCuVhy5rB603YUFHdvFoxuVqcSw=;
        b=SiE+LJjVks0PKU5JwpD9hmr5WKHQcAWbP5S222jcCVIK2F5Qfs+mPJWRogqIo9VqJm
         U3ixm/XNTbWjX7Z9hJWRCuuyiM3Pgw897Dlpf4xotY8sbcSrGt9ctVervbqPag7AmTeM
         u+GzYxDkCkFxxI9JSqwjbT1bWg0Oee2cWfoAGqUxJmgERlF8+VZyKI51vS3SMbwE1A0I
         leaHmPIEdvYSXZgFQzjFKEuuCCvDQjIMeHzvcBZJXiUWi+zI2uXiGLzYT+ei2Q+6JSLV
         BDt29M7dD93PJp2CK76Crkzh2GGgTWvuJbi2vo7Xs/Mu/tbDYqLominJBFJ0HjED1r+U
         OGtg==
X-Gm-Message-State: AHQUAuZu0KISg4NvinCu2oQa8WKK1zhfiUPrCflddk2B4aSZWKnXYeCV
        AXvTeg4pQZ9Nt1+OfhReQT37/G5c
X-Google-Smtp-Source: AHgI3IYs2g0CUJWp7599O5rP6hEVtAGUPZuFm5JKqW9gYynqmN4gyNq0rzve6vvKV0l36pWYqzFyIA==
X-Received: by 2002:a19:f508:: with SMTP id j8mr8864817lfb.87.1550336558059;
        Sat, 16 Feb 2019 09:02:38 -0800 (PST)
Received: from [192.168.1.18] (chk159.neoplus.adsl.tpnet.pl. [83.31.8.159])
        by smtp.gmail.com with ESMTPSA id p3sm1204337ljj.14.2019.02.16.09.02.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 09:02:37 -0800 (PST)
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
To:     Hans de Goede <hdegoede@redhat.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190212205901.13037-1-jekhor@gmail.com>
 <20190212205901.13037-2-jekhor@gmail.com>
 <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com> <20190213230731.GA8557@amd>
 <42078a81-e32e-81b7-528f-d1adb60d31c3@redhat.com>
 <20190213233806.GA11867@amd>
 <562e2acd-a60a-2aea-4050-6d9414d23a4e@redhat.com> <20190214111423.GE6132@amd>
 <92cf09b8-726d-4f1b-94ba-368a66af2246@redhat.com>
 <2b6faaa5-b21e-a512-de7d-ca21be5045fc@gmail.com> <20190214230307.GA17358@amd>
 <2a5e2002-e5f1-6da3-8a43-317801b69657@redhat.com>
 <3d5407a7-9458-f071-a1d5-511b09678e20@gmail.com>
 <87a21c4e-8e5e-c180-2ff3-eb8170746e71@redhat.com>
 <80971bc3-1193-83ed-913a-12f6217016c8@gmail.com>
 <b15fd048-8206-4057-a354-07dc14ca15e3@redhat.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <8a263266-a41f-c916-e990-02d04de9b5d0@gmail.com>
Date:   Sat, 16 Feb 2019 18:02:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b15fd048-8206-4057-a354-07dc14ca15e3@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 2/16/19 12:14 AM, Hans de Goede wrote:
> Hi,
> 
> On 2/15/19 11:31 PM, Jacek Anaszewski wrote:
>> On 2/15/19 11:26 PM, Hans de Goede wrote:
> 
> <snip>
> 
>>> I think that should work fine, which means that we can use the timer and
>>> pattern trigger support for the blinking and breathing modes.
>>>
>>> That still leaves the switching between user and hw-control modes,
>>> as discussed the hw-controlled mode could be modelled as a new 
>>> "hardware"
>>> trigger, but then we cannot choose between on/blink/breathing when
>>> in hw-controlled mode. As Pavel mentioned, that would require some
>>> sort of composed trigger, where we have both the hardware and
>>> timer triggers active for example.
>>>
>>> I think it might be easier to just allow turning on/off the hardware
>>> control mode through a special "hardware_control" sysfs attribute and
>>> then use the existing timer and pattern triggers for blinking / 
>>> breathing.
>>
>> Pattern trigger exposes pattern file by default and hw_pattern if
>> pattern_set/get ops are provided. Writing them enables software and
>> hardware pattern respectively.
> 
> This is not about software vs hardware pattern.
> 
> There are 2 *orthogonal*, separate problems/challenges with this LED 
> controller:
> 
> 1) It has hardware blinking and breathing, as discussed this can be
> controlled through the timer and pattern triggers, so this problem
> is solved.
> 
> 2) It has 2 operating modes:
> 
> a) Automatic/hardware controlled, in this mode the LED is turned
> off or on (where on can be continues on, blinking or breathing)
> by the hardware itself, when in this mode we / userspace is not
> in control of the LED
> 
> b) Manual/user controlled mode, in this mode we / userspace can
> control of the LED.
> 
> Currently there is no API in the ledclass to switch a LED from
> automatic controlled to user controlled and back, This is what
> the proposed hardware trigger was for, to switch to automatic
> mode. A problem with this is that we still want to be able
> to chose between continues on, blinking or breathing (when on),
> configure the max brightness, etc.

Yes, we do have the API to switch a LED from automatic (hardware
accelerated) control to software control and back. This is pattern
trigger, which exposes two files for setting pattern: pattern
and hw_pattern. Writing pattern file switches the device to software
control mode and writing hw_pattern switches it to the hardware control,
with the possibility of defining device specific ABI syntax to enable
particular pattern (blinking, breathing or event permanently on
in case of this device).

The hw_pattern is device specific, so the device specific ABI
documentation can state that when the pattern trigger is enabled
for this device in hw accelerated mode, then it will blink the
LED only when specific conditions are met - in this case it will
be activation of charging.

Since timer trigger does not allow to explicitly choose between
software and hardware timer engine, then I propose to not take
it into account for supporting hardware blinking offered by
this device. Enabling pattern trigger will just periodically
set brightness of the LED.

Since pattern trigger is a superset of timer, then it can handle
ordinary blinking as well.

> Since there cannot be more then 1 trigger active, with the
> hardware trigger solution we cannot say we want automatic
> control (hardware trigger) and blinking when the automatic
> mode says the LED should be on (timer trigger) as that
> would mean having 2 triggers active with the hardware
> trigger solution.
> 
> As such I think the switch between automatic and manual
> control would be best exported through a special "hardware_control"
> sysfs attribute and then use the existing timer and pattern
> triggers for blinking / breathing.
> 
> Regards,
> 
> Hans
> 

-- 
Best regards,
Jacek Anaszewski
