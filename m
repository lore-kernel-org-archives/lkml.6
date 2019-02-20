Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7125C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EDE2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfBTQme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:42:34 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35559 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfBTQmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:42:33 -0500
Received: by mail-ed1-f67.google.com with SMTP id g19so11445248edp.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 08:42:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1SFFZPOS24NOzmzoS8q3cd9X7WlHTcSBpDb9ez2earU=;
        b=dNuJy6s4gksnCoPO8p1ijaMcaJ2ygns4IF7XbZRJuysZpL/SJJS2ep1JteE+ZaLkiz
         zlipISanY+XSWcrudamGqDXc7F66X5W5Q9dV7ZUzlTMgkG0DU0jFgg6SKWBT2rh3pXzJ
         qr5NfydKD29el6p5rRs5ypInYxwhd8PFN/+W+u2AuPpSUBlDInOzR8iIjx6/fn91hDrM
         9xyetPUDT1iCzo8rJocc1bcWWGUqQP7fKkqhjSv3WYweu/ZSZFJgkxXCARNvmEa/PQk9
         00KMYPZNF383FtZkodWxsiVd+bZRW01gie52398xi3fJqDyP2eHSRw8ZdRP8/fHSkv5z
         STLg==
X-Gm-Message-State: AHQUAuaxA7IeYVqKQzTJHB2YzXtuFU9i2a5W6J6j6TuDtl6Rk/and3aw
        LlYWDdgynbtdU8FvAzQN33tSpA==
X-Google-Smtp-Source: AHgI3IYOKCArGUr7C3bsbtlD2JWp2jz6j1ZMnhSCkAGoATGQtUQOP0Y87Lr2JSuvNjCzUj2kZzFEeQ==
X-Received: by 2002:aa7:d795:: with SMTP id s21mr14684410edq.116.1550680951154;
        Wed, 20 Feb 2019 08:42:31 -0800 (PST)
Received: from localhost.localdomain ([62.140.137.49])
        by smtp.gmail.com with ESMTPSA id e3sm3781877ejl.49.2019.02.20.08.42.29
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 08:42:30 -0800 (PST)
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
 <8e3d9949-4bd3-f229-ace4-196a5f08fad3@redhat.com>
 <20190219202005.GA3699@jeknote.loshitsa1.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6a7be360-8da3-f1e6-6ca7-f55b3b2c60df@redhat.com>
Date:   Wed, 20 Feb 2019 17:42:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190219202005.GA3699@jeknote.loshitsa1.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/19/19 9:20 PM, Yauhen Kharuzhy wrote:
> On Tue, Feb 19, 2019 at 02:39:55PM +0100, Hans de Goede wrote:
>>>> I also wonder if you've considered just disabling the extcon driver
>>>> for the PMIC leaving it in automatic mode. Unlike the GPD win / pocket
>>>> with their Type-C connector, your device seems to actually be using
>>>> the PMIC as it was designed, so the automatic mode might just work
>>>> and not touching the PMIC at all might be best.
>>>
>>> Hm. We need to detect charger type (which can be kind of ACA) and set charging
>>> limit properly, control OTG boost converter of the charger, request
>>> hi-voltage charging etc.
>>> I am not sure that this is possible without of software intervention.
>>> Mixing of software
>>> events handling with hardware charging control will be a source of
>>> errors and instability.
>>> So, no, I didn't think about HW-controlled charging when Linux is
>>> running. But this may
>>> be subject of future investigation.
>>
>> Ok, I was hoping that the CCSM hardware would automatically do charger-type
>> detection and set the input-current-limit accordingly.
> 
> I have checked this. UEFI firmware configures PMIC to SW-controlled
> mode if no OTG cable connected at start. If change PMIC mode to
> HW-controlled, charging works but no IINLIM control by PMIC is observed
> (ILIM pin is disabled and 0x00 register value is not changed). When OTG
> cable is connected, bq25892 registers are not changed also (OTG boost
> converter is disabled).
> 
> So, I consider that this machine is designed for software charging and
> OTG mode control.

Ok, that is similar to my experience with the GPD devices with
TypeC connector.

>>>>> Q: In theory, enabling of 'charge enable' output without of properly
>>>>> configuration of external charger can cause some problems (USB overload,
>>>>> battery overcurrent etc.). I think that there are no such stupidly
>>>>> designed devices exist but we cannot be sure. What should we do with this?
>>>>
>>>> This should not be a problem, the input-current-limit of the charger
>>>> will already be setup by the firmware at boot and if a charger gets
>>>> plugged in later then the input-current-limit will reset to 500mA.
>>>>
>>>> Likewise the max charging current for the battery should already
>>>> be configured properly by the firmware (this must be the case since
>>>> the device will also charge while off) and we don't even know what
>>>> the max charging current for the battery is, so we just have to rely
>>>> on the firmware/BIOS here.
>>>
>>> In the Lenovo Yoga Book the firmware seems to set safe input current limit
>>> only (500 mA). Fast charging can be enabled by software and exactly value
>>> of limits for this are known from Lenovo's sources only...
>>
>> The input-current-limit only specifies how much current the charger may
>> draw from the micro-usb for both supplying the laptop as well as for
>> charging the battery combined. You can safely set this as high as
>> the charger can handle (2A for a dedicated charger).
>>
>> The BQ25892 should have a *separate* setting for the max current to
>> use while charging the battery (assuming that the input current allows
>> drawing enough current in the first place). I would hope that those bits
>> have some sane value set from the firmware...
> 
> Yes, the charger has separate battery current limit but firmware doesn't
> change its default value (2048 mA) while Lenovo's software driver does.
> It set battery charging limit to 4 A and input limit to 2 A (it makes
> sense because Lenovo adapter and BQ25892 both support voltage increasing
> upto 12V).

Hmm, I guess your device uses a separate power-barrel charging conector
then? 12v over micro-usb requires special negotiation which the Whiskey Cove
PMIC does not support AFAIK.

In either case if you want to increase the max battery current to 4A
in the kernel, then this will have to be guarded by a DMI check.

I beieve the way to do this wuld be throuh a device-property on the
charger which gets set from drivers/i2c/busses/i2c-cht-wc.c, but as
said this needs to be behind a DMI check, e cannot just g and boost
the max charge current to 4A everywhere.

Regards,

Hans
