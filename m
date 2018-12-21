Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9A8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C944021903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCkjx3Lr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbeLUHcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:32:18 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33530 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeLUHcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:32:18 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so3853627ljd.0;
        Thu, 20 Dec 2018 23:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B34CNK7x1LTgS8Qg5Auf/bYgGHm67mhAgdUqBhqZR9w=;
        b=jCkjx3LrxrRXmJ6vfp/THLXpfRmj7sU+w1k/hVqBgkZsOhqw66q6EnC58qq/ZUq7cA
         IhCozUwiE8OdES7y3ZSRuoSMPirwa7pAXHJDNx6FP5zqVae0gBU9eXfZBGrUJi8ApWwy
         nYpabTfwa1QjmkdBpl9yqyw+Sf1UWQH8DZSlWgjWtT0jG7a0FFWSwMtxTz+JBEdCUDEm
         yD7l5TTwjvaqUHzrYuRNt0M9VBaFtTMpD2VJkl8cFDZBOw6FQMH84pRKNVxrbuEtLt/n
         xLp2wmxuFduKoAp+B0Q0RbNQRH6eEqGkucTggIG+qLJxnDTBJmm8ZAToe6+mv6crbgCd
         pQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B34CNK7x1LTgS8Qg5Auf/bYgGHm67mhAgdUqBhqZR9w=;
        b=McsXPau/9fUkKdubuDsrU49t+VdljZMTHXd3lNyjeme6XMSmnVC+71aE0C62Xy6qC7
         UgOS9dQL81VPzwWs9qEnN1jAehxTDugxjEGE8pZo/j08tzrrtixOC8i8AykP97ifcTms
         6uAuWg9eo6aEGZnwsaC++B6zgTTSuJuVtKI/uZVDQCemQ9eGuyZZwYP1WlnbeVaBKPuX
         MPvLWGdjauqamg4KxrBauNsu7sv4UeSA0CthqCV8jkuGrw/ECGRA3kFKmutl3eNkWXuk
         1wetWJS0Mynv0FaHEGj0NI1TfsM1+ResZwgPUqpczFJx+sOGt5+n0iUEJQRclws2T3N2
         gprg==
X-Gm-Message-State: AJcUukcPljsptktY92PPFPJtFkzZwRR+6x/+UUyb4FjshA2FNo38UCzi
        dDEmEq+4r4RZvHmG2b05wqCmqvI6
X-Google-Smtp-Source: ALg8bN67/l02ESYPXSgfRH3z73acnAgo20cBfcauSyqbdnBg4EttupAOnZKILxXkaecVznY5XEUvWw==
X-Received: by 2002:a2e:45d:: with SMTP id 90-v6mr836635lje.110.1545377534794;
        Thu, 20 Dec 2018 23:32:14 -0800 (PST)
Received: from [192.168.1.18] (chj170.neoplus.adsl.tpnet.pl. [83.31.7.170])
        by smtp.gmail.com with ESMTPSA id h12-v6sm4486172ljb.80.2018.12.20.23.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 23:32:14 -0800 (PST)
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
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
Message-ID: <2bca210b-76ad-d5a9-906c-4151695050c3@gmail.com>
Date:   Fri, 21 Dec 2018 08:32:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <71d3ac12-5beb-0a26-71e1-5eae798e7b9f@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 9:31 PM, Jacek Anaszewski wrote:
> On 12/19/18 10:50 PM, Dan Murphy wrote:
>> On 12/19/2018 03:36 PM, Jacek Anaszewski wrote:
>>> Hi Dan and Pavel,
>>>
>>> On 12/19/18 9:41 PM, Dan Murphy wrote:
>>>> Pavel
>>>>
>>>> On 12/19/2018 02:10 PM, Pavel Machek wrote:
>>>>> On Wed 2018-12-19 13:41:18, Dan Murphy wrote:
>>>>>> Pavel
>>>>>>
>>>>>> Thanks for the review.
>>>>>>
>>>>>> On 12/19/2018 01:34 PM, Pavel Machek wrote:
>>>>>>> Hi!
>>>>>>>
>>>>>>>> +static DEVICE_ATTR_WO(ctrl_bank_a_mix);
>>>>>>>> +static DEVICE_ATTR_WO(ctrl_bank_b_mix);
>>>>>>>> +static DEVICE_ATTR_WO(ctrl_bank_c_mix);
>>>>>>>> +
>>>>>>>> +static struct attribute *lp5024_ctrl_bank_attrs[] = {
>>>>>>>> +    &dev_attr_ctrl_bank_a_mix.attr,
>>>>>>>> +    &dev_attr_ctrl_bank_b_mix.attr,
>>>>>>>> +    &dev_attr_ctrl_bank_c_mix.attr,
>>>>>>>> +    NULL
>>>>>>>> +};
>>>>>>>> +ATTRIBUTE_GROUPS(lp5024_ctrl_bank);
>>>>>>>
>>>>>>> ...
>>>>>>>> +
>>>>>>>> +static DEVICE_ATTR_WO(led1_mix);
>>>>>>>> +static DEVICE_ATTR_WO(led2_mix);
>>>>>>>> +static DEVICE_ATTR_WO(led3_mix);
>>>>>>>> +
>>>>>>>> +static struct attribute *lp5024_led_independent_attrs[] = {
>>>>>>>> +    &dev_attr_led1_mix.attr,
>>>>>>>> +    &dev_attr_led2_mix.attr,
>>>>>>>> +    &dev_attr_led3_mix.attr,
>>>>>>>> +    NULL
>>>>>>>> +};
>>>>>>>> +ATTRIBUTE_GROUPS(lp5024_led_independent);
>>>>>>>
>>>>>>> Ok, so you are adding new sysfs files. Are they _really_ neccessary?
>>>>>>> We'd like to have uniform interfaces for the leds.
>>>>>>
>>>>>> Yes I am adding these for this driver.
>>>>>> They adjust the individual brightness of each LED connected (what 
>>>>>> the HW guys called mixing).
>>>>>>
>>>>>> The standard brightness sysfs adjusts all 3 LEDs simultaneously so 
>>>>>> that all 3 LEDs brightness are
>>>>>> uniform.
>>>>>
>>>>> 1 LED, 1 brightness file... that's what we do. Why should this one 
>>>>> be different?
>>>>>
>>>>
>>>> Yes I understand this and 1 DT child node per LED out but...
>>>>
>>>> This device has a single register to control 3 LEDs brightness as a 
>>>> group and individual brightness
>>>> registers to control the LEDs independently to mix the LEDs to a 
>>>> specific color.
>>>>
>>>> There needs to be a way to control both so that developers can mix 
>>>> and adjust the individual RGB and
>>>> then control the brightness of the group during run time without 
>>>> touching the "mixing" value.
>>>>
>>>> I don't think a user needs nor would want to have 24 different LED 
>>>> nodes with 24 different brightness files.
>>>> Or with the LP5036 that would have 36 LED nodes.
>>>>
>>>> Table 1 in the data sheet shows how the outputs map to the control 
>>>> banks to the LED registers.
>>>
>>> Some time ago we had discussion with Vesa Jääskeläinen about possible
>>> approaches to RGB LEDs [0]. What seemed to be the most suitable
>>> variation of the discussed out-of-tree approach was the "color" property
>>> and array of color triplets defined in Device Tree per each color.
>>>
>>
>> Why does Device tree define the color?
>>
>> Rob indicated that Device tree is supposed to define the hardware.
>> This thread seems to be defining the operation.
> 
> Perceived colors produced by LEDs from different manufacturers may
> differ and this alone should be deemed a sufficient argument for having
> board specific color definitions.
> 
>> Shouldn't the color be done via user space and not dt?
> 
> I think that we should keep the userspace interface as simple
> as possible and backwards compatible with monochrome LEDs.
> 
> I also propose to avoid the introduction of a color sysfs
> property in favor of creating separate LED class devices
> for different "color ranges". The devices would drive the same
> LED but using different preset color levels.

On the other hand, scattering the control over the hardware
among multiple LED class devices would complicate extension
of pattern trigger with the support for RGB LEDs.

I looks like we will need the "color" sysfs file  anyway.

> We don't have to expose all device knobs to the userspace,
> but instead provide some predefined configurations. It would
> improve user experience by keeping LED class devices simple
> in use. It would be Device Tree designer's responsibility to
> provide color definitions that make sense for given RGB LED
> controller and RGB LED element configuration.
> 
> Registering color palette with devm_rgb_register() you proposed
> is also an option, but with one LED class device per color palette
> it would mean allowing for creation/destruction of LED class
> devices by any user having access to given LED's sysfs interface,
> which is really bad solution.

With the "color" sysfs file it will make more sense to allow for user
defined color palettes.

-- 
Best regards,
Jacek Anaszewski
