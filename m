Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04FFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DAE21852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w1LhwOqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733164AbeLTN4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:56:17 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54430 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbeLTN4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:56:16 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBKDu9An046283;
        Thu, 20 Dec 2018 07:56:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545314169;
        bh=yD6AFayeEc4vrT8frBD2q5iA5krkiVtL6hZUamAhHR0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=w1LhwOqStppM1xrDJou9wMxjuArQi5RqftvmJjcqmHXISIn4BWKK2Ox+ggMmfD0DS
         SGs6FS8dmL3Gz11OFjJWXSr34CcL2gzL4CwDQr3lz4eXa8nqWOspxvwptO0siHL+ca
         9Ff31Aoy1OgoUX1dC856bhxfJ1PApLJx+LVC4JbY=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBKDu9q3059158
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Dec 2018 07:56:09 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 20
 Dec 2018 07:56:09 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 20 Dec 2018 07:56:09 -0600
Received: from [172.22.89.160] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBKDu8O2022016;
        Thu, 20 Dec 2018 07:56:08 -0600
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20181219162626.12297-3-dmurphy@ti.com> <20181219193455.GA21159@amd>
 <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com> <20181219201047.GA23448@amd>
 <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
 <a72c11c0-949b-bdbc-df2c-4490e04a1065@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <74cc0ef0-20f8-c422-9a15-af74d0fc0fba@ti.com>
Date:   Thu, 20 Dec 2018 07:56:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a72c11c0-949b-bdbc-df2c-4490e04a1065@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vesa

On 12/20/2018 06:40 AM, Vesa Jääskeläinen wrote:
> Hi All,
> 
> On 19/12/2018 23.50, Dan Murphy wrote:
>> On 12/19/2018 03:36 PM, Jacek Anaszewski wrote:
>>> Hi Dan and Pavel,
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
>>
>> Shouldn't the color be done via user space and not dt?
>>
>> Especially if they want to change the color real time?
>>
>> Dan
>>
>>> Please refer to [0] for the details.
>>>
>>> [0] https://lkml.org/lkml/2018/11/9/938
>>>
> 
> Idea was to define preset colors in device tree as an example when you are dealing with multi-color LEDs without PWM. In that case you only have GPIOs to control and then have a problem what does those GPIO's mean.
> 
> With preset definitions one can use color names to act as a shortcut to configure GPIO's to proper state for that particular color.
> 
> For more flexible setups where you have PWM or such control you have larger space of available colors. In this case you need to somehow define also meaning of those controls.
> 
> Also we may not have LED with only red, green and blue elements. There might in example be amber, ultraviolet, white elements.
> 
> This is where device tree is concerned. It helps us craft the logical definition for LED so that we can control it from user space in common way.
> 
> Now the next problem then is how does user space work then.
> 
> For multi-color LEDs it it important to change the color atomically so that no wrong colors are being shown as user space got interrupted when controlling it.
> 
> Also we have brightness setting that would be useful for PWM controlled LEDs.
> 
> Setting color is easy when you use preset names then you only need to deal with brightness value (eg. RGB -> HSV * brightness -> RGB). Of course here additional problem is other color elements are they then scaled according to brightness value?.
> 
> Setting color as "raw" values is then next problem. In order to do it atomically it needs to be one atomic activation and could be eg. one write to "color" sysfs entry with combination of all color elements and perhaps additionally also brightness value. Next question is then what is the format for such entry then? What are the value ranges? In here we can utilize device tree definition to help define what kind of LED we do have and what kind of capabilities it does have.
> 
> Additional problem risen also in discussion was non-linearity of some control mechanisms vs. perceived color. So there might be a need for curve mapping similarly what is with backlight control and that would be defined either in device tree and possibly in user space if there is a need for that. I suppose golden curve definition in device tree should be good enough.
> 
> Then there was additional discussion about possible animation support but I would leave that for future design as that would then be utilizing the same framework.
> 
> I suppose color space handling and that kind of stuff should be in some led core functionality and then raw control should be part of physical led driver.
> 
> I was planning to play with it during holiday season but lets see how it goes. Feel free to also experiment with the idea.
> 

Again I don't think device tree should be used to set color policy.
This is to restricting it may be good for GPIO fixed current RGB LEDs but for variable RGB LEDs it would be very restricting.

I believe this needs to be part of the LED framework and leave the device tree to define the HW and not define the product.

Maybe a new devm_rgb_register call that exposes the color palette and can consolidate the 3 LEDs into a single sysfs node.

Dan


> Thanks,
> Vesa Jääskeläinen


-- 
------------------
Dan Murphy
