Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2C0C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A25720881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HKfjuc8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732598AbfA3VIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:08:01 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40074 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfA3VIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:08:01 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0UL7t0v007820;
        Wed, 30 Jan 2019 15:07:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548882475;
        bh=P6y8ZzdivQrFcyIG8Hlvhsbhj+aK4hRQ7FzxzYEFGD4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HKfjuc8mdiiEJuwYKJgL86vyr5EDbHz04wKD0PrMgy8+wviylV/N4u8iCQD9eftZS
         W43sL4zjdEKD+APSEEKCsuy3b/16iA7Q0tKXvjHaFwQ6Buy4zqDEIiztPUgRed+7/n
         WV9ad1RzVZUDkdwKpJdXnLua3i2ps1yR4TOuG+Dw=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0UL7tsl038157
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Jan 2019 15:07:55 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 30
 Jan 2019 15:07:54 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 30 Jan 2019 15:07:54 -0600
Received: from [172.22.83.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0UL7s7O010440;
        Wed, 30 Jan 2019 15:07:54 -0600
Subject: Re: [RFC PATCH] leds: multicolor: Add sysfs interface definition
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <robh+dt@kernel.org>, <pavel@ucw.cz>
CC:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20190130183005.833-1-dmurphy@ti.com>
 <f3792d44-1a43-318b-1b12-d6d69275c3a8@gmail.com>
 <333a146a-a469-5b72-5e81-ff7f522dc598@ti.com>
 <c65ca84d-8054-2244-1899-e4a9cb0842da@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <138450e2-9082-6986-a89b-0028dca0d365@ti.com>
Date:   Wed, 30 Jan 2019 15:07:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <c65ca84d-8054-2244-1899-e4a9cb0842da@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 1/30/19 2:20 PM, Jacek Anaszewski wrote:
> Dan,
> 
> On 1/30/19 8:59 PM, Dan Murphy wrote:
>> Jacek
>>
>> On 1/30/19 1:37 PM, Jacek Anaszewski wrote:
>>> Hi Dan,
>>>
>>> Thank you for the RFC.
>>>
>>> One vital thing is missing - documentation of brightness file must
>>> be updated to define its semantics for LED multi color class.
>>>
>>> Either we need brightness-model file returning only "onoff" option
>>> available, or, for time being, fix the max_brightness for LED multi
>>> color class to 1 (which will map to max intensity level for each color).
>>>
>>
>> I can make max_brightness default to 1 if not set by the LED driver.
>>
>> But the LP50xx has brightness controls so setting max_brightness from the driver should over ride
>> the max of 1 in the upper level.
> 
> Yes, so the max_brightness should be updated basing on current
> brightness-model. For LEDn_BRIGHTNESS of LP50xx we could have
> "hw" or maybe even better just "lp50xx-linear" and "lp50xx-logarithmic"
> - I just forgot about that capability of the device.
> 

OK maybe "hw" would make sense as there may be other devices that have dedicated brightness controls
over color controls.

Probably need to create a model for non-modeled cases like "rgb-independent".  Dumb name but I could not
think of anything better.

>> For devices that do not support brightness as a separate control we can create a file called
>> max_brightness_<color> that defines the max that a specific color can be set to.  If max_brightness
>> is set to 1 then create max_brightness_<color>.  If max_brightness > 1 then do not create the files.
> 
> Right. We will need dedicated max_brightness for each color.
> They should be placed also in the colors directory, next to the color
> files.
> 

OK will document this.

>> I don't think we have fully vetted the brightness-model yet so I prefer to omit
>> it and possibly introduce that later.
> 
> We need to start from something. It will give better overview of the
> whole idea.
> 

OK.  Don't get me wrong I don't oppose this idea I am just trying to figure out how the user space would
know what models and brightness levels are available.

I mean we can read the brightness-models and present the available models but then how does the user know
what and how many levels are in each model?  And how do we govern putting them in the right order?

The DT file can get messed up, per the previous example
rgb-green = <0x277c33 0x37b048 0x47e45d>; 

This is assumed to be from dimmest to brightest.  But that is just an assumption

What if the entry looked like this?
rgb-green = <0x37b048 0x277c33 0x47e45d>; 

Then echo 1 > brightness is not really a lower intensity then echo 2 > brightness.
I know this is a product level issue but this can be misused and there is no way for maintainers
or reviewers to really catch this error in code reviews.

The driver can map the brightness to the appropriate level requested by the class but again not
sure how the user space can know what is available.  And there is nothing from stopping a
definition of up to 2^32 brightness combinations.  This I know is unrealistic but the capability is there

I am wondering if there should be some sort of coefficient that can be defined that is 
applied to each color (no complex math).  I can see this working in a linear device but logrithimic
maybe an issue.

Like

rgb-green = <0x277c33>;  //Coefficient used to set the dimmest allowed brightness for the color model.

echo 1 > brightness

red = 0x27
green = 0x7c
blue = 0x33

echo 2 > brightness

red = 0x28
green = 0x7d
blue = 0x34

echo 3 > brightness

red = 0x29
green = 0x7e
blue = 0x35

This example would give you 132 different brightness levels. green is the brightest defined color so the step calculation is 

255-124+1 = 132 (zero based) as 0 is off.

There can be a file called rgb_green_max which can be read to indicate how many brightness levels can be achieved.
If the user goes beyond the steps then throw -EINVAL at them.

These brightness models probably should be put into a separate directory to isolate and not clutter the colors directory.
And writing brightness to these models would be immediate no sync involved.

Dan

> Best regards,
> Jacek Anaszewski
> 
>> Dan
>>

<snip>-- 
------------------
Dan Murphy
