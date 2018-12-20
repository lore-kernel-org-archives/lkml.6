Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C4FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E27A20873
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gKBZskZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbeLTBb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 20:31:57 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42404 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbeLTBb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 20:31:57 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBK1VqTc062216;
        Wed, 19 Dec 2018 19:31:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545269512;
        bh=eIoAdc2+j0ZvbhRFjG7o37kjUwjN68GNoeTCcqQ43mg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gKBZskZAW9aoivT/+FwVzWH+ZnzpctRl+K27XIXv8DizihDiSJ/gGZSP+Dpa7qmQd
         ijlv9X95ddmOTVYFEf1X3nM0fKIA/82OY81dpSMIPq7AwcaXp0r2E49EFPIkr6FRQt
         Ilkov6LTmEgnqBCSj2B/8Rf4Uf3mNczMFgqiZdb0=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBK1VqXD060120
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Dec 2018 19:31:52 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 19:31:52 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 19:31:52 -0600
Received: from [172.22.106.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBK1Vp9F003357;
        Wed, 19 Dec 2018 19:31:51 -0600
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     <jacek.anaszewski@gmail.com>, <linux-leds@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20181219162626.12297-3-dmurphy@ti.com> <20181219193455.GA21159@amd>
 <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com> <20181219201047.GA23448@amd>
 <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com> <20181219220326.GA28244@amd>
 <a3214ab3-9281-19d6-7fcc-5abae9a60ebd@ti.com> <20181219222737.GB30496@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <d7edfd57-20df-bd83-b616-5b18e8bc2c64@ti.com>
Date:   Wed, 19 Dec 2018 19:31:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181219222737.GB30496@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

Thanks for trimming.

On 12/19/2018 04:27 PM, Pavel Machek wrote:
> Hi!
> 
> [cc list trimmed]
> 
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
>>>> Please refer to [0] for the details.
>>>>
>>>> [0] https://lkml.org/lkml/2018/11/9/938
>>>
>>> Yes, plus I also have the set of HSV patches somewhere... and they
>>> work, but I found out that HSV->RGB conversion results in loss of precision.
>>>
>>> We may want to do something like that.
>>>
>>> But we need to do it once, in a driver core. We obviously don't want
>>> each driver having different version of RGB support.
>>
>> True.  But the RGB driver really should not be defining the color palette.
>>
>> Maybe a "color capability" reported to user space so that the user space can make the decision.
>>
>> It can report
>>
>> For GPIO or constant current situations
>> static red
>> static blue
>> static green 
>>
>> For adjustable configurations it can report:
>> variable red
>> variable blue
>> variable green
>>
>> or even simpler "static" or "dynamic" as a return to report the RGB configuration.
>> The LED driver would just need to set the variable.
> 
> I'm not sure what static/variable is.

My suggestion is really based in opinion.  It is my opinion that the user space sets the policy
of the RGB.  The DT nor the driver should limit the capability of what the user would want to do.

But instead should let the user know what the driver and HW can do.  It seems that the suggestion made in the
email thread [0] https://lkml.org/lkml/2018/11/9/938 limits that capability via the DT by defining a specific color.

If I have a configurable current RGB combo then the palette is endless.  But in a GPIO fixed current situation the palette is
limited.  So I don't think I agree with the DT side of it.

There needs to be a way that the kernel can indicate to the user space "heres what I can do you need to let me know".
As each kernel driver just needs to interact with the HW and not set policy.

> 
> I have RGB leds here that can set any channel to 0-255, at
> runtime. They seem to be quite common at phones.

Yes I agree.  Android specifically likes to set these values in the lighting HAL.

But alternatively once the color is set the brightness can be controlled by PWM or an ALS.

> 
> Anyway, if your 36 channels can be set independently, I believe you
> just want them to export as 36 LEDs.

I am not sure that is what the "customers" would want to have to set 36 different nodes or even declare those 36 nodes.
That is 36 independent user space to kernel space calls that are very expensive just to set a LED color and brightness.

Now that is very unrealistic that there would be 36 calls happening.  But for this part it
would cut the calls to set the brightness to the kernel in runtime after init to 1/3.  Set the color and then only one call for the brightness.

Dan

> 
> Thanks,
> 									Pavel
> 


-- 
------------------
Dan Murphy
