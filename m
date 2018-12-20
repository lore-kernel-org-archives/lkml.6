Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20D1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FA2218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3IHKK/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389580AbeLTUbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:31:09 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44052 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389520AbeLTUbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:31:08 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so2737292lji.11;
        Thu, 20 Dec 2018 12:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=igr2U5LqOQ3f35sZ3EDjhSbbWu9SCZgrqYm6Jm76laY=;
        b=d3IHKK/vFCRt4u+cnnxTJBNfRIW3aY35R3ys+H0agNbI1bNYdpQKppGJgWI2SfOFX9
         /7pb+KksMoXkRw9HVUnKDWVsVHEzG5EBGvwlNJBjHOLftJ+sKhHnxfpxIVwHaIBRQKu/
         LZtobmM/kXCeQ8lY1uyASADAtyjEyMRYDFqu6IcWzuPfQh77BVY8UxtnPNSnAbE2uxWi
         +B5877gShCAp/Ia5JKPlkCnEOfbb53tWAmr7AFxO50KUdOWpRsczYuym7zQib6Ps0Nzh
         oMWeh0zbVfXWi8sMHg7h4CahjG1IAqE2THaarfwF3/Ztwzvh4jiF54PTb3MQeir201nW
         NUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=igr2U5LqOQ3f35sZ3EDjhSbbWu9SCZgrqYm6Jm76laY=;
        b=fFpGlV7+G/2BYC7FfZGmc0XyIX2hujD2CxXQrxKz+3y+M5G3A3c3msPQ32osZVKBlf
         kBjlZQ6aqjsfrxV0xHs0AM65BUwq9X+In5YkUm8jd5OTaMN/OPJDceS2FO3750IYmQkt
         0CQVpAmZemytiJl+LaiWxmwDyY8LDpkL3oaC5r96vElsWr2xnNPA3hgHVi6eG+7wqlMW
         AF3D27X2bHlh1yaZB1VVuA2j/CbslXTj77VC23La/duuohWUmqf/Px8HcYL599lkwWfV
         gDjhFYV2LYwpzx4XumJJo5vfDu4TMYk4w3peeRZo1AF7eTIthfYyHr0NpxDY1+MjHbdd
         0s3w==
X-Gm-Message-State: AA+aEWbcrzNlc/ak2F2c3OGjATUX1WG6iDPwrqUaRjMVKPW2NPMGyZd7
        7iU66naITK8NlNHso840HlDEgf7z
X-Google-Smtp-Source: AFSGD/VRZ70dw+Knm20Z2H1CqJlXbOcNWHIzp4yrEB6ZfrSX9a+QuY1bYZG4J2YBs+hvaJqtlgRJQQ==
X-Received: by 2002:a2e:4784:: with SMTP id u126-v6mr8873853lja.124.1545337864123;
        Thu, 20 Dec 2018 12:31:04 -0800 (PST)
Received: from [192.168.1.18] (chj170.neoplus.adsl.tpnet.pl. [83.31.7.170])
        by smtp.gmail.com with ESMTPSA id q3sm4548477lff.42.2018.12.20.12.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 12:31:03 -0800 (PST)
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20181219162626.12297-3-dmurphy@ti.com> <20181219193455.GA21159@amd>
 <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com> <20181219201047.GA23448@amd>
 <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <71d3ac12-5beb-0a26-71e1-5eae798e7b9f@gmail.com>
Date:   Thu, 20 Dec 2018 21:31:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/18 10:50 PM, Dan Murphy wrote:
> On 12/19/2018 03:36 PM, Jacek Anaszewski wrote:
>> Hi Dan and Pavel,
>>
>> On 12/19/18 9:41 PM, Dan Murphy wrote:
>>> Pavel
>>>
>>> On 12/19/2018 02:10 PM, Pavel Machek wrote:
>>>> On Wed 2018-12-19 13:41:18, Dan Murphy wrote:
>>>>> Pavel
>>>>>
>>>>> Thanks for the review.
>>>>>
>>>>> On 12/19/2018 01:34 PM, Pavel Machek wrote:
>>>>>> Hi!
>>>>>>
>>>>>>> +static DEVICE_ATTR_WO(ctrl_bank_a_mix);
>>>>>>> +static DEVICE_ATTR_WO(ctrl_bank_b_mix);
>>>>>>> +static DEVICE_ATTR_WO(ctrl_bank_c_mix);
>>>>>>> +
>>>>>>> +static struct attribute *lp5024_ctrl_bank_attrs[] = {
>>>>>>> +    &dev_attr_ctrl_bank_a_mix.attr,
>>>>>>> +    &dev_attr_ctrl_bank_b_mix.attr,
>>>>>>> +    &dev_attr_ctrl_bank_c_mix.attr,
>>>>>>> +    NULL
>>>>>>> +};
>>>>>>> +ATTRIBUTE_GROUPS(lp5024_ctrl_bank);
>>>>>>
>>>>>> ...
>>>>>>> +
>>>>>>> +static DEVICE_ATTR_WO(led1_mix);
>>>>>>> +static DEVICE_ATTR_WO(led2_mix);
>>>>>>> +static DEVICE_ATTR_WO(led3_mix);
>>>>>>> +
>>>>>>> +static struct attribute *lp5024_led_independent_attrs[] = {
>>>>>>> +    &dev_attr_led1_mix.attr,
>>>>>>> +    &dev_attr_led2_mix.attr,
>>>>>>> +    &dev_attr_led3_mix.attr,
>>>>>>> +    NULL
>>>>>>> +};
>>>>>>> +ATTRIBUTE_GROUPS(lp5024_led_independent);
>>>>>>
>>>>>> Ok, so you are adding new sysfs files. Are they _really_ neccessary?
>>>>>> We'd like to have uniform interfaces for the leds.
>>>>>
>>>>> Yes I am adding these for this driver.
>>>>> They adjust the individual brightness of each LED connected (what the HW guys called mixing).
>>>>>
>>>>> The standard brightness sysfs adjusts all 3 LEDs simultaneously so that all 3 LEDs brightness are
>>>>> uniform.
>>>>
>>>> 1 LED, 1 brightness file... that's what we do. Why should this one be different?
>>>>
>>>
>>> Yes I understand this and 1 DT child node per LED out but...
>>>
>>> This device has a single register to control 3 LEDs brightness as a group and individual brightness
>>> registers to control the LEDs independently to mix the LEDs to a specific color.
>>>
>>> There needs to be a way to control both so that developers can mix and adjust the individual RGB and
>>> then control the brightness of the group during run time without touching the "mixing" value.
>>>
>>> I don't think a user needs nor would want to have 24 different LED nodes with 24 different brightness files.
>>> Or with the LP5036 that would have 36 LED nodes.
>>>
>>> Table 1 in the data sheet shows how the outputs map to the control banks to the LED registers.
>>
>> Some time ago we had discussion with Vesa Jääskeläinen about possible
>> approaches to RGB LEDs [0]. What seemed to be the most suitable
>> variation of the discussed out-of-tree approach was the "color" property
>> and array of color triplets defined in Device Tree per each color.
>>
> 
> Why does Device tree define the color?
> 
> Rob indicated that Device tree is supposed to define the hardware.
> This thread seems to be defining the operation.

Perceived colors produced by LEDs from different manufacturers may
differ and this alone should be deemed a sufficient argument for having
board specific color definitions.

> Shouldn't the color be done via user space and not dt?

I think that we should keep the userspace interface as simple
as possible and backwards compatible with monochrome LEDs.

I also propose to avoid the introduction of a color sysfs
property in favor of creating separate LED class devices
for different "color ranges". The devices would drive the same
LED but using different preset color levels.

We don't have to expose all device knobs to the userspace,
but instead provide some predefined configurations. It would
improve user experience by keeping LED class devices simple
in use. It would be Device Tree designer's responsibility to
provide color definitions that make sense for given RGB LED
controller and RGB LED element configuration.

Registering color palette with devm_rgb_register() you proposed
is also an option, but with one LED class device per color palette
it would mean allowing for creation/destruction of LED class
devices by any user having access to given LED's sysfs interface,
which is really bad solution.

-- 
Best regards,
Jacek Anaszewski
