Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2614C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7192145D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2nBBqQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeL2S2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 13:28:11 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38688 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbeL2S2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 13:28:11 -0500
Received: by mail-lf1-f66.google.com with SMTP id p86so16341575lfg.5;
        Sat, 29 Dec 2018 10:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/uJVrO/oD9j5GaAE7tjC/102A37Tl8IsBrZaSnclqXo=;
        b=G2nBBqQaC5kp8etIy5qj464pzByfWoA3VPr0SN6GAFn1V7Bj+9/fuBOxD2PQEnhaB5
         gjn57Vagp6aTbSezHqbCrnl0x3w+0gyTE222b/wmr1WxG+N/A5F5h6HF4hbkKoctH9os
         zX+MLTdAwS3821PydGzEgYC8/OP6yxbRqv8iU0g9C8tSVw7CDUFQUqgbnR5iCUeS3DFp
         DiAFuYDTR8SNQprpG5yKQy2tl1H46cVGoVAdwcgnz1MNXOkWoluFrTrNvxiwaQHiVfxU
         XSpWTiKWoAiilm7yKkPBGSULw+0ATmVcAkBQz8V//Rw3Kx4uoMx61/UZxuOx0JrPyq60
         8lTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/uJVrO/oD9j5GaAE7tjC/102A37Tl8IsBrZaSnclqXo=;
        b=hM/Wp0CdbI8u9OMQenRhq8iF5ZKQtyXER9Ey9DuO9ntfT/DaxRkcdBb4Dn9AEYB29P
         JcVwQKmY7HBE9TOq1jNK7TU5EpjWMOTlE/UcIZTC/4/ZHjVMt8GRgbJ30i4PJUh4NMxs
         yMFCfYb9uSMXI1Fg4pEJVoPFqYFHSekdcmns6D3IpVFlq2zBzqiqYI49WFjAK0ihL/Ff
         J7MMzVD97botAfoHoXAertqGHxyLn3s7UrUcLUUns2ty4MaLwHy3QPAisHrpxDvxFB4+
         tG1aCPib+fU8h9/o+91L/UP4iBYkNUi36nl7B5oSnuCNBhuzSGXbCaRzfYiKRPkGoXVa
         IBDg==
X-Gm-Message-State: AA+aEWY6PYmDKpf4MQRZ9Vwu+IVoKrp5/ma4xN/0FfMSNV3oN5qzlnTn
        x4+jtfWXMYoNi/h7dqc/RsRPkiDb
X-Google-Smtp-Source: AFSGD/XHfR3v1QtTW18W7exud2116cXX6M+JfFaB5uc8+uPcXMp//biFHUHjO+aORFMuRa1Gr0pDWQ==
X-Received: by 2002:a19:a086:: with SMTP id j128mr15206979lfe.93.1546108087259;
        Sat, 29 Dec 2018 10:28:07 -0800 (PST)
Received: from [192.168.1.18] (dkj55.neoplus.adsl.tpnet.pl. [83.24.13.55])
        by smtp.gmail.com with ESMTPSA id x24-v6sm10164739ljc.54.2018.12.29.10.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 10:28:06 -0800 (PST)
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
 <71d3ac12-5beb-0a26-71e1-5eae798e7b9f@gmail.com>
 <2bca210b-76ad-d5a9-906c-4151695050c3@gmail.com>
 <45ce01f0-af6e-1cc6-5126-fb557c7d2a82@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <b7c69135-1641-48cb-1770-c4c77a989efe@gmail.com>
Date:   Sat, 29 Dec 2018 19:28:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <45ce01f0-af6e-1cc6-5126-fb557c7d2a82@ti.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/18 2:05 PM, Dan Murphy wrote:
> On 12/21/2018 01:32 AM, Jacek Anaszewski wrote:
>> On 12/20/18 9:31 PM, Jacek Anaszewski wrote:
>>> On 12/19/18 10:50 PM, Dan Murphy wrote:
>>>> On 12/19/2018 03:36 PM, Jacek Anaszewski wrote:
>>>>> Hi Dan and Pavel,
>>>>>
>>>>> On 12/19/18 9:41 PM, Dan Murphy wrote:
>>>>>> Pavel
>>>>>>
>>>>>> On 12/19/2018 02:10 PM, Pavel Machek wrote:
>>>>>>> On Wed 2018-12-19 13:41:18, Dan Murphy wrote:
>>>>>>>> Pavel
>>>>>>>>
>>>>>>>> Thanks for the review.
>>>>>>>>
>>>>>>>> On 12/19/2018 01:34 PM, Pavel Machek wrote:
>>>>>>>>> Hi!
>>>>>>>>>
>>>>>>>>>> +static DEVICE_ATTR_WO(ctrl_bank_a_mix);
>>>>>>>>>> +static DEVICE_ATTR_WO(ctrl_bank_b_mix);
>>>>>>>>>> +static DEVICE_ATTR_WO(ctrl_bank_c_mix);
>>>>>>>>>> +
>>>>>>>>>> +static struct attribute *lp5024_ctrl_bank_attrs[] = {
>>>>>>>>>> +    &dev_attr_ctrl_bank_a_mix.attr,
>>>>>>>>>> +    &dev_attr_ctrl_bank_b_mix.attr,
>>>>>>>>>> +    &dev_attr_ctrl_bank_c_mix.attr,
>>>>>>>>>> +    NULL
>>>>>>>>>> +};
>>>>>>>>>> +ATTRIBUTE_GROUPS(lp5024_ctrl_bank);
>>>>>>>>>
>>>>>>>>> ...
>>>>>>>>>> +
>>>>>>>>>> +static DEVICE_ATTR_WO(led1_mix);
>>>>>>>>>> +static DEVICE_ATTR_WO(led2_mix);
>>>>>>>>>> +static DEVICE_ATTR_WO(led3_mix);
>>>>>>>>>> +
>>>>>>>>>> +static struct attribute *lp5024_led_independent_attrs[] = {
>>>>>>>>>> +    &dev_attr_led1_mix.attr,
>>>>>>>>>> +    &dev_attr_led2_mix.attr,
>>>>>>>>>> +    &dev_attr_led3_mix.attr,
>>>>>>>>>> +    NULL
>>>>>>>>>> +};
>>>>>>>>>> +ATTRIBUTE_GROUPS(lp5024_led_independent);
>>>>>>>>>
>>>>>>>>> Ok, so you are adding new sysfs files. Are they _really_ neccessary?
>>>>>>>>> We'd like to have uniform interfaces for the leds.
>>>>>>>>
>>>>>>>> Yes I am adding these for this driver.
>>>>>>>> They adjust the individual brightness of each LED connected (what the HW guys called mixing).
>>>>>>>>
>>>>>>>> The standard brightness sysfs adjusts all 3 LEDs simultaneously so that all 3 LEDs brightness are
>>>>>>>> uniform.
>>>>>>>
>>>>>>> 1 LED, 1 brightness file... that's what we do. Why should this one be different?
>>>>>>>
>>>>>>
>>>>>> Yes I understand this and 1 DT child node per LED out but...
>>>>>>
>>>>>> This device has a single register to control 3 LEDs brightness as a group and individual brightness
>>>>>> registers to control the LEDs independently to mix the LEDs to a specific color.
>>>>>>
>>>>>> There needs to be a way to control both so that developers can mix and adjust the individual RGB and
>>>>>> then control the brightness of the group during run time without touching the "mixing" value.
>>>>>>
>>>>>> I don't think a user needs nor would want to have 24 different LED nodes with 24 different brightness files.
>>>>>> Or with the LP5036 that would have 36 LED nodes.
>>>>>>
>>>>>> Table 1 in the data sheet shows how the outputs map to the control banks to the LED registers.
>>>>>
>>>>> Some time ago we had discussion with Vesa Jääskeläinen about possible
>>>>> approaches to RGB LEDs [0]. What seemed to be the most suitable
>>>>> variation of the discussed out-of-tree approach was the "color" property
>>>>> and array of color triplets defined in Device Tree per each color.
>>>>>
>>>>
>>>> Why does Device tree define the color?
>>>>
>>>> Rob indicated that Device tree is supposed to define the hardware.
>>>> This thread seems to be defining the operation.
>>>
>>> Perceived colors produced by LEDs from different manufacturers may
>>> differ and this alone should be deemed a sufficient argument for having
>>> board specific color definitions.
>>>
>>>> Shouldn't the color be done via user space and not dt?
>>>
>>> I think that we should keep the userspace interface as simple
>>> as possible and backwards compatible with monochrome LEDs.
>>>
>>> I also propose to avoid the introduction of a color sysfs
>>> property in favor of creating separate LED class devices
>>> for different "color ranges". The devices would drive the same
>>> LED but using different preset color levels.
>>
>> On the other hand, scattering the control over the hardware
>> among multiple LED class devices would complicate extension
>> of pattern trigger with the support for RGB LEDs.
>>
>> I looks like we will need the "color" sysfs file  anyway.
>>
>>> We don't have to expose all device knobs to the userspace,
>>> but instead provide some predefined configurations. It would
>>> improve user experience by keeping LED class devices simple
>>> in use. It would be Device Tree designer's responsibility to
>>> provide color definitions that make sense for given RGB LED
>>> controller and RGB LED element configuration.
>>>
>>> Registering color palette with devm_rgb_register() you proposed
>>> is also an option, but with one LED class device per color palette
>>> it would mean allowing for creation/destruction of LED class
>>> devices by any user having access to given LED's sysfs interface,
>>> which is really bad solution.
>>
>> With the "color" sysfs file it will make more sense to allow for user
>> defined color palettes.
>>
> 
> I think defining these values in the device tree or acpi severely limits the devices
> capabilities.  Especially in development phases.  If the knobs were exposed then the user space
> can create new experiences.  The color definition should be an absolute color defined in the dt and
> either the framework or user space needs to mix these appropriately.  IMO user space should set the policy
> of the user experience and the dt/acpi needs to set the capabilities.
> 
> I do like Pavels idea on defining the more standard binding pattern to "group" leds into a single group.
> 
> Maybe the framework could take these groups and combine/group them into a single node with the groups colors.

There is still HSV approach [0] in store. One problem with proposed
implementation is fixed algorithm of RGB <-> HSV color space conversion.
Maybe allowing for some board specific adjustments in DT would add
more flexibility.

[0] https://lkml.org/lkml/2017/8/31/255

-- 
Best regards,
Jacek Anaszewski
