Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73FEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F4A2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gcpk2gaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbeLSVgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:36:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38951 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeLSVgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:36:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so21012152wra.6;
        Wed, 19 Dec 2018 13:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UoJ3P8b83vU11FI+fVrZE63Gj+nIQDJHUS0bV4hCUnA=;
        b=Gcpk2gaF7WZjiCV62Oe6vuMTjFj4pzFBlTjZNrcIC5F5gJ6xPVj9/zrce7cBlkkK4Y
         PwMn4Y3KTImUhe54PlTSACeAJf35amYf36vI9cqEF/y+8mcy1IvO/glC0Mmp9E4KBHHs
         /m8yqGPCfUATl1fwiU/IO0mx+sE0GEVXPG/aQ5dvLj/o7sMu8wUPTMAaHAJsjBn7tdrq
         TjrPXvin3Xhmd5j7Tb3RlhVaRHtpNlipudaFq279d1CN28rQ3X/+YGKt2i4zfbk7Q94/
         Dd8bmaRwlHZKDthyZ565PALX0Uwd705zVb6lJgOlrIL8zc1jgEW3GhQAJjlHqJtvkpzN
         6jRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UoJ3P8b83vU11FI+fVrZE63Gj+nIQDJHUS0bV4hCUnA=;
        b=dc87//Kelj3VuRY1QEUKSmmz3QmVR8LM5S1XgoxBpAaB5Yj1j0kpFsIartPRQssy5R
         lHJXpfZWjd4G0srN+yeEXZm/AGU7/jV2yohirA5Ur5l3kIccMFLvUXgz+VWLOvVW4A3s
         qF1BCO1dHplJr+nKkmm0nwt5RMuWUYMWoNgjlm29vqfUmuF2abkYaW5dOsWq5nayxu+r
         lEN1wN5qSKPbzDbE6jG45nBLaNHx8Det5pR+0GrW0PWLfwnBlrT8Ok/i1pJUWHd5BImL
         xJlmJHfKgPaR8YBjQ6u/wQYO9zTbhuB8uX8v5tolLsTx6E4tcRH5e94cFmBh23xEna6H
         aggw==
X-Gm-Message-State: AA+aEWY69vOsNLZAeJFGeT4STpSRUNhnAbzjG/w95OZ3g/RHhysvVk22
        5wU8OOz4LnRacQlgi4LafdlJscim
X-Google-Smtp-Source: AFSGD/XFi+5XGCD9lb071jk9/rPUKPB/b7qkD79gOBHb5V/foKI4XB2FlVLwakUR4QMwxl/Nib5Xrw==
X-Received: by 2002:a5d:40c1:: with SMTP id b1mr21252413wrq.133.1545255372320;
        Wed, 19 Dec 2018 13:36:12 -0800 (PST)
Received: from [192.168.1.18] (chj170.neoplus.adsl.tpnet.pl. [83.31.7.170])
        by smtp.gmail.com with ESMTPSA id c65sm7042088wma.24.2018.12.19.13.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 13:36:11 -0800 (PST)
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20181219162626.12297-3-dmurphy@ti.com> <20181219193455.GA21159@amd>
 <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com> <20181219201047.GA23448@amd>
 <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
Date:   Wed, 19 Dec 2018 22:36:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan and Pavel,

On 12/19/18 9:41 PM, Dan Murphy wrote:
> Pavel
> 
> On 12/19/2018 02:10 PM, Pavel Machek wrote:
>> On Wed 2018-12-19 13:41:18, Dan Murphy wrote:
>>> Pavel
>>>
>>> Thanks for the review.
>>>
>>> On 12/19/2018 01:34 PM, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>> +static DEVICE_ATTR_WO(ctrl_bank_a_mix);
>>>>> +static DEVICE_ATTR_WO(ctrl_bank_b_mix);
>>>>> +static DEVICE_ATTR_WO(ctrl_bank_c_mix);
>>>>> +
>>>>> +static struct attribute *lp5024_ctrl_bank_attrs[] = {
>>>>> +	&dev_attr_ctrl_bank_a_mix.attr,
>>>>> +	&dev_attr_ctrl_bank_b_mix.attr,
>>>>> +	&dev_attr_ctrl_bank_c_mix.attr,
>>>>> +	NULL
>>>>> +};
>>>>> +ATTRIBUTE_GROUPS(lp5024_ctrl_bank);
>>>>
>>>> ...
>>>>> +
>>>>> +static DEVICE_ATTR_WO(led1_mix);
>>>>> +static DEVICE_ATTR_WO(led2_mix);
>>>>> +static DEVICE_ATTR_WO(led3_mix);
>>>>> +
>>>>> +static struct attribute *lp5024_led_independent_attrs[] = {
>>>>> +	&dev_attr_led1_mix.attr,
>>>>> +	&dev_attr_led2_mix.attr,
>>>>> +	&dev_attr_led3_mix.attr,
>>>>> +	NULL
>>>>> +};
>>>>> +ATTRIBUTE_GROUPS(lp5024_led_independent);
>>>>
>>>> Ok, so you are adding new sysfs files. Are they _really_ neccessary?
>>>> We'd like to have uniform interfaces for the leds.
>>>
>>> Yes I am adding these for this driver.
>>> They adjust the individual brightness of each LED connected (what the HW guys called mixing).
>>>
>>> The standard brightness sysfs adjusts all 3 LEDs simultaneously so that all 3 LEDs brightness are
>>> uniform.
>>
>> 1 LED, 1 brightness file... that's what we do. Why should this one be different?
>>
> 
> Yes I understand this and 1 DT child node per LED out but...
> 
> This device has a single register to control 3 LEDs brightness as a group and individual brightness
> registers to control the LEDs independently to mix the LEDs to a specific color.
> 
> There needs to be a way to control both so that developers can mix and adjust the individual RGB and
> then control the brightness of the group during run time without touching the "mixing" value.
> 
> I don't think a user needs nor would want to have 24 different LED nodes with 24 different brightness files.
> Or with the LP5036 that would have 36 LED nodes.
> 
> Table 1 in the data sheet shows how the outputs map to the control banks to the LED registers.

Some time ago we had discussion with Vesa J‰‰skel‰inen about possible
approaches to RGB LEDs [0]. What seemed to be the most suitable
variation of the discussed out-of-tree approach was the "color" property
and array of color triplets defined in Device Tree per each color.

Please refer to [0] for the details.

[0] https://lkml.org/lkml/2018/11/9/938

-- 
Best regards,
Jacek Anaszewski
