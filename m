Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7450C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE8421773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfBSNj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:39:58 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46922 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfBSNj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:39:58 -0500
Received: by mail-ed1-f67.google.com with SMTP id f2so16724263edy.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 05:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4TCOOQnNrunOzdT4CIjdaWmMrJhWc1K/FihzMPlENWU=;
        b=tjaIKqyzAKIZGSohKa88FGr+gTnh13y3JQPOx4f/qPyPZbyIR32STKcMVJHfFqNl16
         QI13T0yTHZmFoVQwQASOWoRiwS5/NeQd1Slprdfna3CgZC3/qgmmHEi0DfjKJsyJdsFa
         QurNdlR8mSf//hT9waFqR2R51BCBWvF3gjKcBwoal+JpGLhqtABI+2mTDoCu864Yin2k
         3ypEES2RiXvWemUR2NtgRgTDk5PmHUPNdrCpdCg3T+myY30AvNLiNP27H03D5L1qhoBR
         7uJ5q+asduyvl6VKAXfdG2lOuVGR3NeAPpJyt92+9DTXcbzNGaG9MPXv0QBYdiwn54CP
         zzwQ==
X-Gm-Message-State: AHQUAubL3y+bS8xO00b5CDAM+yM1ZwlSesitOh0FunXUOTwtJ/ZDLFso
        QbaU/cr55VnaAgj5KzL+t9fa6g==
X-Google-Smtp-Source: AHgI3Ia4/1jTuz+ANwg48Euosy0Wp8+iKzRrkHvWeSHnl2ZPukVuKnPSqm9vm+CC3CgqWcoQXtB86g==
X-Received: by 2002:a17:906:52d0:: with SMTP id w16mr5869812ejn.6.1550583596586;
        Tue, 19 Feb 2019 05:39:56 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id gx5sm276931ejb.37.2019.02.19.05.39.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 05:39:55 -0800 (PST)
Subject: Re: [PATCH 2/2] extcon intel-cht-wc: Enable external charger
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20190210203649.21691-1-jekhor@gmail.com>
 <20190210203649.21691-3-jekhor@gmail.com>
 <1b2f04fc-05a0-4f09-c84e-dc7adc63ec63@redhat.com>
 <20190215063250.GB30250@jeknote.loshitsa1.net>
 <20190217215242.GA12656@jeknote.loshitsa1.net>
 <416a0e12-aa0e-e781-2ef2-f11b97ba77a0@redhat.com>
 <CAKWEGV7r_026NhT96AiXJUT_9WOTy_=DC3Kx9qVNRfjWmMkEBA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8e3d9949-4bd3-f229-ace4-196a5f08fad3@redhat.com>
Date:   Tue, 19 Feb 2019 14:39:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAKWEGV7r_026NhT96AiXJUT_9WOTy_=DC3Kx9qVNRfjWmMkEBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18-02-19 16:07, Yauhen Kharuzhy wrote:
> пн, 18 февр. 2019 г. в 12:24, Hans de Goede <hdegoede@redhat.com>:
<snip>

>>> So, I propose:
>>>
>>> 1) save initial value of CHGDIS register for restoring it at driver
>>> remove (because the extcon-intel-cht-wc driver restores HW control in
>>> cht_wc_extcon_remove()).
>>> 2) at driver start, enable SW control of CHGDIS and set its value to 0.
>>> 3) at driver removing, restore the saved state.
>>
>> This sounds good to me, note I believe the extcon code should not touch
>> bit 4 (open-drain,vs regular), but since we disable the charger state-machine
>> we should obviously then switch the pin to sw mode and drive the pin low
>> so that the charger still works.
> 
> 
> Agree.
> 
>>
>>
>> I believe that on the GPD win / GPD pocket the chgdis pin of the PMIC
>> is not connected to the charger, since writing different values to reg
>> 5e2f has no effect there.
>>
>> I do wonder how this interacts with inserting an otg-host cable into
>> the micro-usb, I mean a cable like this:
>>
>> https://alexnld.com/wp-content/uploads/2013/11/S-UDC-103.jpg
>>
>> A cable like this will short the id-pin to ground and at this point
>> we should disable the charger and enable a 5V boost converter to
>> supply 5V to the device connected to the USB-A connector.
>>
>> On the GPD win / GPD pocket this is controlled through the Type-C
>> framework and the V5 boost converter is actually part of the
>> charger-IC, so charging gets disabled automatically when we tell
>> the charger-IC to do enable its 5V boost converter.
>>
>> Do you already have an idea how to deal with this, it might be good
>> to have at least an idea how we want to handle 5V boost before we
>> merge the patch to control the CHGDIS pin, since we may need to
>> disable the charger when the id-pin is connected to GND, so that
>> the charger does not try to charge from the output of the 5V boost
>> converter, which happens when an external 5v boost converter is used.
> 
>   I implemented this in external charger driver by sending extcon
> notifications to it.
> The BQ25892 charger provides boost converter for OTG and doesn't try to charge
> from its own VBUS output. But additional disabling of charging via CHGDIS pin
> shouldn't break anything.

Ok.

>> I also wonder if you've considered just disabling the extcon driver
>> for the PMIC leaving it in automatic mode. Unlike the GPD win / pocket
>> with their Type-C connector, your device seems to actually be using
>> the PMIC as it was designed, so the automatic mode might just work
>> and not touching the PMIC at all might be best.
> 
> Hm. We need to detect charger type (which can be kind of ACA) and set charging
> limit properly, control OTG boost converter of the charger, request
> hi-voltage charging etc.
> I am not sure that this is possible without of software intervention.
> Mixing of software
> events handling with hardware charging control will be a source of
> errors and instability.
> So, no, I didn't think about HW-controlled charging when Linux is
> running. But this may
> be subject of future investigation.

Ok, I was hoping that the CCSM hardware would automatically do charger-type
detection and set the input-current-limit accordingly.

>>> Q: In theory, enabling of 'charge enable' output without of properly
>>> configuration of external charger can cause some problems (USB overload,
>>> battery overcurrent etc.). I think that there are no such stupidly
>>> designed devices exist but we cannot be sure. What should we do with this?
>>
>> This should not be a problem, the input-current-limit of the charger
>> will already be setup by the firmware at boot and if a charger gets
>> plugged in later then the input-current-limit will reset to 500mA.
>>
>> Likewise the max charging current for the battery should already
>> be configured properly by the firmware (this must be the case since
>> the device will also charge while off) and we don't even know what
>> the max charging current for the battery is, so we just have to rely
>> on the firmware/BIOS here.
> 
> In the Lenovo Yoga Book the firmware seems to set safe input current limit
> only (500 mA). Fast charging can be enabled by software and exactly value
> of limits for this are known from Lenovo's sources only...

The input-current-limit only specifies how much current the charger may
draw from the micro-usb for both supplying the laptop as well as for
charging the battery combined. You can safely set this as high as
the charger can handle (2A for a dedicated charger).

The BQ25892 should have a *separate* setting for the max current to
use while charging the battery (assuming that the input current allows
drawing enough current in the first place). I would hope that those bits
have some sane value set from the firmware...

ON the BQ24292i datasheet the charge current limit is in a register
called "REG02 Charge Current Control Register" and the bits are described
as controlling the "FAST CHARGE CURRENT LIMIT" aka ICHG.

Where as the input current limit is in "REG00 Input Source Control Register"
and the bits are described as "INPUT CURRENT LIMIT" ala INLIM.

Regards,

Hans

