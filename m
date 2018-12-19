Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10AEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6405220866
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 21:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L0u2KNl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbeLSVuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 16:50:44 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50390 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbeLSVun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 16:50:43 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJLoblt051435;
        Wed, 19 Dec 2018 15:50:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545256237;
        bh=GdFz/SJL+ZBdweB0zYTFvVZ55s3zQDMIbxl3H9oIGcw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=L0u2KNl8uIL4qoraPMyEsm7pnyKU9qSEMTBqAolpGqM/l2CRWeRRDHcRgvFhhYoy3
         sceMYhvkApqn0v2HY5x4JzxwmxkPMugZixlycvqI7WeA4H0+i/1gMYlfuSAa8UzAHH
         YWKVh3kZ4619DX2BwAfQRzxWcfV+4XRKqy9hZqkM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJLobFO093111
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Dec 2018 15:50:37 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 15:50:37 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 15:50:37 -0600
Received: from [172.22.106.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJLobLe000514;
        Wed, 19 Dec 2018 15:50:37 -0600
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
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
Date:   Wed, 19 Dec 2018 15:50:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/2018 03:36 PM, Jacek Anaszewski wrote:
> Hi Dan and Pavel,
> 
> On 12/19/18 9:41 PM, Dan Murphy wrote:
>> Pavel
>>
>> On 12/19/2018 02:10 PM, Pavel Machek wrote:
>>> On Wed 2018-12-19 13:41:18, Dan Murphy wrote:
>>>> Pavel
>>>>
>>>> Thanks for the review.
>>>>
>>>> On 12/19/2018 01:34 PM, Pavel Machek wrote:
>>>>> Hi!
>>>>>
>>>>>> +static DEVICE_ATTR_WO(ctrl_bank_a_mix);
>>>>>> +static DEVICE_ATTR_WO(ctrl_bank_b_mix);
>>>>>> +static DEVICE_ATTR_WO(ctrl_bank_c_mix);
>>>>>> +
>>>>>> +static struct attribute *lp5024_ctrl_bank_attrs[] = {
>>>>>> +    &dev_attr_ctrl_bank_a_mix.attr,
>>>>>> +    &dev_attr_ctrl_bank_b_mix.attr,
>>>>>> +    &dev_attr_ctrl_bank_c_mix.attr,
>>>>>> +    NULL
>>>>>> +};
>>>>>> +ATTRIBUTE_GROUPS(lp5024_ctrl_bank);
>>>>>
>>>>> ...
>>>>>> +
>>>>>> +static DEVICE_ATTR_WO(led1_mix);
>>>>>> +static DEVICE_ATTR_WO(led2_mix);
>>>>>> +static DEVICE_ATTR_WO(led3_mix);
>>>>>> +
>>>>>> +static struct attribute *lp5024_led_independent_attrs[] = {
>>>>>> +    &dev_attr_led1_mix.attr,
>>>>>> +    &dev_attr_led2_mix.attr,
>>>>>> +    &dev_attr_led3_mix.attr,
>>>>>> +    NULL
>>>>>> +};
>>>>>> +ATTRIBUTE_GROUPS(lp5024_led_independent);
>>>>>
>>>>> Ok, so you are adding new sysfs files. Are they _really_ neccessary?
>>>>> We'd like to have uniform interfaces for the leds.
>>>>
>>>> Yes I am adding these for this driver.
>>>> They adjust the individual brightness of each LED connected (what the HW guys called mixing).
>>>>
>>>> The standard brightness sysfs adjusts all 3 LEDs simultaneously so that all 3 LEDs brightness are
>>>> uniform.
>>>
>>> 1 LED, 1 brightness file... that's what we do. Why should this one be different?
>>>
>>
>> Yes I understand this and 1 DT child node per LED out but...
>>
>> This device has a single register to control 3 LEDs brightness as a group and individual brightness
>> registers to control the LEDs independently to mix the LEDs to a specific color.
>>
>> There needs to be a way to control both so that developers can mix and adjust the individual RGB and
>> then control the brightness of the group during run time without touching the "mixing" value.
>>
>> I don't think a user needs nor would want to have 24 different LED nodes with 24 different brightness files.
>> Or with the LP5036 that would have 36 LED nodes.
>>
>> Table 1 in the data sheet shows how the outputs map to the control banks to the LED registers.
> 
> Some time ago we had discussion with Vesa Jääskeläinen about possible
> approaches to RGB LEDs [0]. What seemed to be the most suitable
> variation of the discussed out-of-tree approach was the "color" property
> and array of color triplets defined in Device Tree per each color.
> 

Why does Device tree define the color?

Rob indicated that Device tree is supposed to define the hardware.
This thread seems to be defining the operation.

Shouldn't the color be done via user space and not dt?

Especially if they want to change the color real time?

Dan

> Please refer to [0] for the details.
> 
> [0] https://lkml.org/lkml/2018/11/9/938
> 


-- 
------------------
Dan Murphy
