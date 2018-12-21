Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572ECC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1977921906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xKQMAZi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390550AbeLUNF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 08:05:29 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45894 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388218AbeLUNF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 08:05:28 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBLD5L2n043143;
        Fri, 21 Dec 2018 07:05:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545397521;
        bh=gB2yJmrE4OAlIVTBQkXc33KWS+50c0PALaIpz3gptWw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xKQMAZi3hywFGEBxpLx0BSW5L50PQb0+Um+TglZr5DSM9iJMSaZ9rgLVASoyG6Mvx
         niN+eOfvk9k3zQTC9a4eHABchQyvAsntN6nSnnmXHhSE+J+G1IycDFiywTxMB3Vqg6
         meTyezmtDH5vuUNY+z52zzsiNIoGy5wlgTYb8Wxs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBLD5Lw3036350
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Dec 2018 07:05:21 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 21
 Dec 2018 07:05:21 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 21 Dec 2018 07:05:21 -0600
Received: from [172.22.79.152] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBLD5Kxl024837;
        Fri, 21 Dec 2018 07:05:20 -0600
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20181219162626.12297-3-dmurphy@ti.com> <20181219193455.GA21159@amd>
 <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com> <20181219201047.GA23448@amd>
 <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
 <71d3ac12-5beb-0a26-71e1-5eae798e7b9f@gmail.com>
 <2bca210b-76ad-d5a9-906c-4151695050c3@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <45ce01f0-af6e-1cc6-5126-fb557c7d2a82@ti.com>
Date:   Fri, 21 Dec 2018 07:05:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2bca210b-76ad-d5a9-906c-4151695050c3@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/2018 01:32 AM, Jacek Anaszewski wrote:
> On 12/20/18 9:31 PM, Jacek Anaszewski wrote:
>> On 12/19/18 10:50 PM, Dan Murphy wrote:
>>> On 12/19/2018 03:36 PM, Jacek Anaszewski wrote:
>>>> Hi Dan and Pavel,
>>>>
>>>> On 12/19/18 9:41 PM, Dan Murphy wrote:
>>>>> Pavel
>>>>>
>>>>> On 12/19/2018 02:10 PM, Pavel Machek wrote:
>>>>>> On Wed 2018-12-19 13:41:18, Dan Murphy wrote:
>>>>>>> Pavel
>>>>>>>
>>>>>>> Thanks for the review.
>>>>>>>
>>>>>>> On 12/19/2018 01:34 PM, Pavel Machek wrote:
>>>>>>>> Hi!
>>>>>>>>
>>>>>>>>> +static DEVICE_ATTR_WO(ctrl_bank_a_mix);
>>>>>>>>> +static DEVICE_ATTR_WO(ctrl_bank_b_mix);
>>>>>>>>> +static DEVICE_ATTR_WO(ctrl_bank_c_mix);
>>>>>>>>> +
>>>>>>>>> +static struct attribute *lp5024_ctrl_bank_attrs[] = {
>>>>>>>>> +    &dev_attr_ctrl_bank_a_mix.attr,
>>>>>>>>> +    &dev_attr_ctrl_bank_b_mix.attr,
>>>>>>>>> +    &dev_attr_ctrl_bank_c_mix.attr,
>>>>>>>>> +    NULL
>>>>>>>>> +};
>>>>>>>>> +ATTRIBUTE_GROUPS(lp5024_ctrl_bank);
>>>>>>>>
>>>>>>>> ...
>>>>>>>>> +
>>>>>>>>> +static DEVICE_ATTR_WO(led1_mix);
>>>>>>>>> +static DEVICE_ATTR_WO(led2_mix);
>>>>>>>>> +static DEVICE_ATTR_WO(led3_mix);
>>>>>>>>> +
>>>>>>>>> +static struct attribute *lp5024_led_independent_attrs[] = {
>>>>>>>>> +    &dev_attr_led1_mix.attr,
>>>>>>>>> +    &dev_attr_led2_mix.attr,
>>>>>>>>> +    &dev_attr_led3_mix.attr,
>>>>>>>>> +    NULL
>>>>>>>>> +};
>>>>>>>>> +ATTRIBUTE_GROUPS(lp5024_led_independent);
>>>>>>>>
>>>>>>>> Ok, so you are adding new sysfs files. Are they _really_ neccessary?
>>>>>>>> We'd like to have uniform interfaces for the leds.
>>>>>>>
>>>>>>> Yes I am adding these for this driver.
>>>>>>> They adjust the individual brightness of each LED connected (what the HW guys called mixing).
>>>>>>>
>>>>>>> The standard brightness sysfs adjusts all 3 LEDs simultaneously so that all 3 LEDs brightness are
>>>>>>> uniform.
>>>>>>
>>>>>> 1 LED, 1 brightness file... that's what we do. Why should this one be different?
>>>>>>
>>>>>
>>>>> Yes I understand this and 1 DT child node per LED out but...
>>>>>
>>>>> This device has a single register to control 3 LEDs brightness as a group and individual brightness
>>>>> registers to control the LEDs independently to mix the LEDs to a specific color.
>>>>>
>>>>> There needs to be a way to control both so that developers can mix and adjust the individual RGB and
>>>>> then control the brightness of the group during run time without touching the "mixing" value.
>>>>>
>>>>> I don't think a user needs nor would want to have 24 different LED nodes with 24 different brightness files.
>>>>> Or with the LP5036 that would have 36 LED nodes.
>>>>>
>>>>> Table 1 in the data sheet shows how the outputs map to the control banks to the LED registers.
>>>>
>>>> Some time ago we had discussion with Vesa Jääskeläinen about possible
>>>> approaches to RGB LEDs [0]. What seemed to be the most suitable
>>>> variation of the discussed out-of-tree approach was the "color" property
>>>> and array of color triplets defined in Device Tree per each color.
>>>>
>>>
>>> Why does Device tree define the color?
>>>
>>> Rob indicated that Device tree is supposed to define the hardware.
>>> This thread seems to be defining the operation.
>>
>> Perceived colors produced by LEDs from different manufacturers may
>> differ and this alone should be deemed a sufficient argument for having
>> board specific color definitions.
>>
>>> Shouldn't the color be done via user space and not dt?
>>
>> I think that we should keep the userspace interface as simple
>> as possible and backwards compatible with monochrome LEDs.
>>
>> I also propose to avoid the introduction of a color sysfs
>> property in favor of creating separate LED class devices
>> for different "color ranges". The devices would drive the same
>> LED but using different preset color levels.
> 
> On the other hand, scattering the control over the hardware
> among multiple LED class devices would complicate extension
> of pattern trigger with the support for RGB LEDs.
> 
> I looks like we will need the "color" sysfs file  anyway.
> 
>> We don't have to expose all device knobs to the userspace,
>> but instead provide some predefined configurations. It would
>> improve user experience by keeping LED class devices simple
>> in use. It would be Device Tree designer's responsibility to
>> provide color definitions that make sense for given RGB LED
>> controller and RGB LED element configuration.
>>
>> Registering color palette with devm_rgb_register() you proposed
>> is also an option, but with one LED class device per color palette
>> it would mean allowing for creation/destruction of LED class
>> devices by any user having access to given LED's sysfs interface,
>> which is really bad solution.
> 
> With the "color" sysfs file it will make more sense to allow for user
> defined color palettes.
> 

I think defining these values in the device tree or acpi severely limits the devices
capabilities.  Especially in development phases.  If the knobs were exposed then the user space
can create new experiences.  The color definition should be an absolute color defined in the dt and
either the framework or user space needs to mix these appropriately.  IMO user space should set the policy
of the user experience and the dt/acpi needs to set the capabilities.

I do like Pavels idea on defining the more standard binding pattern to "group" leds into a single group.

Maybe the framework could take these groups and combine/group them into a single node with the groups colors.

Dan
-- 
------------------
Dan Murphy
