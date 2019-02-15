Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C7CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADA121B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evbXKvZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392641AbfBOVnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:43:22 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40761 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbfBOVnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 16:43:22 -0500
Received: by mail-lf1-f66.google.com with SMTP id t14so8259170lfk.7;
        Fri, 15 Feb 2019 13:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qQRKjm70ceFVQjMi0SKinu0XzOBs8biV+YXhLrk1NHk=;
        b=evbXKvZEXrDq33PbWerbokcbC9fvibs4H2uCjfKLaB5Aqs0gnwQj+wMiK9QlvNPSjw
         QnzN7IMaPZSOOcbMwFIlQnUXbEmmeRhVVCrfxvS5LewMBp0B/LIJT3R+uZgnqhKs8VTj
         HAUcsZ1fLapaF84piHT0F/ka19rKcxDiqJywAV/UV/ijOPhp3Y/nqaLlU9tP7COUNoJD
         0ti90kVwcDOp4hsSTPyf368ICkPML7cq369UzT8weXZha2RaeWWRUUcS2A+x/QCYId6y
         AxRK0ujD7TCXgM81AqOGRf3Tn3ShdoxvYjaolg20ET+7GyL/Xr5XIX4etYFaBxnUcQkt
         VAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qQRKjm70ceFVQjMi0SKinu0XzOBs8biV+YXhLrk1NHk=;
        b=ZcdPeb0Efx7JnI2zltePWKs8RAbsUc7/WfDV3WpEQrVVl5+P17ZbUTrr+vrNjRJypk
         k5Tc0eRP0TM6sg82o2wqlOKYevRiF7UGmL+AhJtMW5Lis2hP3doOd8YsxNsKUL3erASM
         fKDHcsaRn/+XEDvV7IxL1gxFLhwSPPsuBTSr3ZPFhtHJkD8aDFptOKvJTFZPIpiFPtw5
         y8zDBKCR6+uG06j2Wzm3uu6yH/fUKAwFEFjAabdbKIVRp4ngcRs5B7FAB6L2FQGn/BiX
         XX1Xc8hKmgA5mhz4SZhFQlqqD6q2cqda30bm1rjdllWKU45QrI8BZzGljGrEfLT8goFF
         LXSw==
X-Gm-Message-State: AHQUAub04mHvGV3OSvKzNw/AYtSFrCHbxdjGD8Qb62SWBNqQ1pU1TLu4
        JGrbLihawi342doP6din7M5DjLsf
X-Google-Smtp-Source: AHgI3Ib9TNzC/9DPpEGh+pnu3aHEo7K+xKKOv1/kOZ1pwGmluoCfpz/57zzaL1z8oiOtA++NB7CrpQ==
X-Received: by 2002:a19:cfd5:: with SMTP id f204mr7177893lfg.65.1550266999242;
        Fri, 15 Feb 2019 13:43:19 -0800 (PST)
Received: from [192.168.1.18] (bkp179.neoplus.adsl.tpnet.pl. [83.28.183.179])
        by smtp.gmail.com with ESMTPSA id b20sm1616641lfg.94.2019.02.15.13.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 13:43:18 -0800 (PST)
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
To:     Yauhen Kharuzhy <jekhor@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190212205901.13037-2-jekhor@gmail.com>
 <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com> <20190213230731.GA8557@amd>
 <42078a81-e32e-81b7-528f-d1adb60d31c3@redhat.com>
 <20190213233806.GA11867@amd>
 <562e2acd-a60a-2aea-4050-6d9414d23a4e@redhat.com> <20190214111423.GE6132@amd>
 <92cf09b8-726d-4f1b-94ba-368a66af2246@redhat.com>
 <2b6faaa5-b21e-a512-de7d-ca21be5045fc@gmail.com> <20190214230307.GA17358@amd>
 <20190215072709.GD30250@jeknote.loshitsa1.net>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <a79807bb-7826-6f2c-0738-7bddcc66cc5e@gmail.com>
Date:   Fri, 15 Feb 2019 22:43:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215072709.GD30250@jeknote.loshitsa1.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yauhen,

On 2/15/19 8:27 AM, Yauhen Kharuzhy wrote:
> On Fri, Feb 15, 2019 at 12:03:07AM +0100, Pavel Machek wrote:
>> Hi!
>>
>>>>>> I suggest that we deal with this special case by adding 3 custom
>>>>>> sysfs attributes:
>>>>>>
>>>>>> 1) "mode" which when read, prints, e.g. :
>>>>>> manual [on-when-charging]
>>>>>
>>>>> While this allows _user on console_ to control everything using echo,
>>>>> it is not suitable for applications trying to control LEDs.
>>>>>
>>>>> As there's nothing special about the case here, I believe we should
>>>>> have generic solution here.
>>>>>
>>>>> My preffered solution would be "hardware" trigger that leaves the LED
>>>>> in hardware control.
>>>>
>>>> As you explained in the parts which I snipped, there are many
>>>> devices which have a similar choice for a LED being under hw or
>>>> user control. I can see how this looks like a trigger and how we
>>>> could use the trigger API for this.
>>>>
>>>> I believe though, that if we implement a "virtual" (for lack of
>>>> a better word) trigger for this, that this should be done in the
>>>> LED core. I can envision this working like this:
>>>>
>>>> 1) Add a:
>>>>
>>>> hw_control_set(struct led_classdev *led_cdev, bool enable_hw_control);
>>>
>>> Please note that we have support for hw patterns in the pattern trigger.
>>> (see how drivers/leds/leds-sc27xx-bltc.c makes use of it for its
>>> breathing pattern).
>>> We have also support for hw blinking in timer trigger via blink_set op.
>>>
>>> In addition to that there is brightness_hw_changed sysfs attribute
>>> with led_classdev_notify_brightness_hw_changed() LED API.
>>>
>>> Couldn't they be used in concert to support the specific features
>>> of the device in question?
>>
>> I believe main issue here is this:
>>
>> Hardware can automatically control the LED according to the charging
>> status, or it can be used as normal software-controlled LED.
>>
>> I believe we should use trigger to select if hardware controls it or
>> not (and then add driver-specific files to describe the
>> details). Other proposal is in the mail thread, too.
> 
> But there are two kinds of 'hardware control' here in discussion:
> 1:
> 	a) PMIC switching LED off/on/breathing/blinking reflected the charging
> 	state (charger is controlled by PMIC entirely without of
> 	software intervention) – 'hw controlled' mode

Can we detect when charging is activated?

> 	b) Software controls when LED is on/off/breathing/blinking but
> 	patterns are generated by PMIC – 'sw controlled' mode.
> 
> 2:
> 	a) parameters of lighting (continuous/blinking/breathing) are
> 	set in the PMIC and the PMIC generates patterns
> 	b) blinking/breathing patterns are generated by the software
> 	entirely.
> 
> It seems that we sometimes confuse this two kinds of hw control definitions
> in the discussion.
> 
> 
> The simple use case question: with this hardware and existing LED class
> API, what user/app should to do to make LED breathing with hw-generated
> pattern?
> 
> As I see, user should activate 'pattern' trigger and write to its hw_pattern attribute...
> hm... big pattern which describes every step of breathing? Some
> simplified pattern which should be interpreted as 'enable the breathing
> an set its frequency' by driver? Which level of simplification will be
> suitable? Which criteria of pattern rejection should be?

Please see my reply to Hans. We need some simplified device specific
syntax of hw_pattern for this device, similarly like in:
Documentation/ABI/testing/sysfs-class-led-driver-sc27xx

-- 
Best regards,
Jacek Anaszewski
