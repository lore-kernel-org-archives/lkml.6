Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FDDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B74218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389217AbfBMXZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:25:09 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46379 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfBMXZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:25:09 -0500
Received: by mail-ed1-f66.google.com with SMTP id f2so3444772edy.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 15:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z3bCF4dwgnGr5bE0pX1p1NrCG7Xdzd49vysm6Ms78Ko=;
        b=NEpx2Luejy6EMqyq86T1nNMHSkntnjnqKJnmuBRmBziDAdnD3Hn6qOrxV/22kt1VEx
         oBVQrMK8ColIuqOormLE/8FULNmzp6Z4ipj17/r+nrjgMxGNC1OxPIq6+AOThe1dWPS+
         /qb6i52qlK1dkhYDuYtTGAEigqvUaoPLpkgFqnQvAybTiZwyKr4qP+etrl8+UBeShtYd
         GKMH5fEFZRODYdxO2AlLcaLgCPjBIMhCsKuXmyAmxVQFVv1B5ysA149rKBcMyuYbFrBN
         C1INYvcVuTgdIqLzddYZNfOq3r25oPqumrT1ACdp3LrDXA24c4a6Q4yQNT583TCpUJGj
         hx+g==
X-Gm-Message-State: AHQUAuaHdYEkpQkq2mQcaL64ZPZsMXfy4tWNt15dRJ2bqa3SCi8oIm06
        fWqWR1f6MFJDP+giHkzcuqTQjg==
X-Google-Smtp-Source: AHgI3Ib3h5kRPnMVZrI9fP04P/ofyHgR7tVd/FjxiBtR2xlCtgqQ/+9hTa65lg5hr1Rp96AZJhHwbg==
X-Received: by 2002:aa7:d3c8:: with SMTP id o8mr504801edr.86.1550100307391;
        Wed, 13 Feb 2019 15:25:07 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id j22sm138124eja.42.2019.02.13.15.25.06
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 15:25:06 -0800 (PST)
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190212205901.13037-1-jekhor@gmail.com>
 <20190212205901.13037-2-jekhor@gmail.com>
 <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com> <20190213230731.GA8557@amd>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <42078a81-e32e-81b7-528f-d1adb60d31c3@redhat.com>
Date:   Thu, 14 Feb 2019 00:25:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190213230731.GA8557@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14-02-19 00:07, Pavel Machek wrote:
> Hi!
> 
>> On 12-02-19 21:59, Yauhen Kharuzhy wrote:
>>> Add support for LEDs connected to the Intel Cherry Trail Whiskey Cove
>>> PMIC. Charger and general-purpose leds are supported. Hardware blinking
>>> is implemented, breathing is not.
>>>
>>> This driver was tested with Lenovo Yoga Book notebook.
>>
>> Thank you for working on this. The CHT Whiskey Cove PMIC is
>> also used on the GPD win and GPD pocket devices and there LED1
>> by default indicates the charging status.
>>
>> Since your driver forces the LED into SWCTL mode on probe()
>> this means that any kernel with it enabled will break the
>> charging LEDs OOTB function, this is undesirable.
> 
> Agreed.
> 
>> I believe it would be best to add a custom "mode" attribute
>> to the led classdev, with "manual" and "on-when-charging"
>> modes, this would then control bits 0-1 of reg 0x5e1f and
>> by default these bits should be left as is when the driver
>> loads.
> 
> No. This is not first hardware when we have something like this, and
> we need something generic here.
> 
> One possibility would be magic "hardware drives this led"
> trigger. Hmm? (Jacek disliked this idea before, but maybe we can
> convince him).
> 
> Generic "is this driven by hardware or not" attribute might be
> possible, too... but its interaction with triggers/brightness/etc
> would be confusing.

In this case the interaction is not that tricky, but it will
likely be different per led controller, so I do not think that
we can ever come up with a truely generic solution.

Basically the charge led has 3 states:

1) Off
2) On
3) On when charging

And then when on it has 4 patterns:

1) Permanently off (so still not really on)
2) Permanently on
3) Blinking
4) Breathing

These 4 patterns can be selected when on, independent
of being perma-on or ondemand-on

And Yauhen seems to have discovered we can control
the brightness too (I did not find that out while
poking the hw myself).

So this means that we can control most aspects of the
LED even when it is in "On when charging" state


> 
>> Note that in my experience the "charging" mode only works
>> when bits 0-1 have the value 10. I've some written notes from
>> when I played with this myself and they say:
>>
>>     -CHT WC powerled control 0x5e1f: bits 0-1:
>>      0: ????
>>      1: Off
>>      2: On when charging
>>      3: On
>>     -CHT WC powerled pattern control 0x5e20: bits 1-2:
>>      0: Off
>>      1: On
>>      2: Blinking
>>      3: Glowing
>>
> 
>> As for the 0x5e20 settings, I believe another custom
>> sysfs attribute, called "breathing" would be a good idea to
>> export the breathing functionality.
> 
> We have "pattern" trigger that can do this kind of stuff in
> software. But I'm not sure if this is worth supporting.

The problem is that any changes made are permanent, they
survice reboots and the default is Breathing, so we need
a way to restore that which does not involve removing
the internal battery of these devices.

Regards,

Hans

