Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAB7C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D76E72085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ialySUgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732868AbfAaNsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:48:47 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47606 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfAaNsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:48:46 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0VDmcW1058002;
        Thu, 31 Jan 2019 07:48:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548942518;
        bh=b7ClCYLjRO6htyWQy/FfafviVLfSSUyOIiAp+1zqPTo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ialySUgwIEaWlaVmKMh8aIr0Y/gw4fI0tJMdAvZ/NMhg3mimkohfGRDsGpN4MVrvE
         AgX5qI3wC4CqBgBgxBMx9EaqyLazmdnrLkusPAtNgUVlcHVfZktFsL/41It2KJfVuy
         R3O9VAds5hKTz1N/5FD7wCf67gk48P7h9fSgFouU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0VDmcrG094093
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 07:48:38 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 31
 Jan 2019 07:48:38 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 31 Jan 2019 07:48:38 -0600
Received: from [172.22.112.72] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0VDmbWv027075;
        Thu, 31 Jan 2019 07:48:38 -0600
Subject: Re: [RFC PATCH] leds: multicolor: Add sysfs interface definition
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <robh+dt@kernel.org>, <pavel@ucw.cz>
CC:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20190130183005.833-1-dmurphy@ti.com>
 <f3792d44-1a43-318b-1b12-d6d69275c3a8@gmail.com>
 <333a146a-a469-5b72-5e81-ff7f522dc598@ti.com>
 <c65ca84d-8054-2244-1899-e4a9cb0842da@gmail.com>
 <138450e2-9082-6986-a89b-0028dca0d365@ti.com>
 <8b701a97-f945-488d-8bf3-d2efe400e30c@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <385e4fc9-91cc-176c-730b-c27628027e2e@ti.com>
Date:   Thu, 31 Jan 2019 07:48:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <8b701a97-f945-488d-8bf3-d2efe400e30c@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 1/30/19 4:14 PM, Jacek Anaszewski wrote:
> Dan,
> 
> On 1/30/19 10:07 PM, Dan Murphy wrote:
>> Jacek
>>
>> On 1/30/19 2:20 PM, Jacek Anaszewski wrote:
>>> Dan,
>>>
>>> On 1/30/19 8:59 PM, Dan Murphy wrote:
>>>> Jacek
>>>>
>>>> On 1/30/19 1:37 PM, Jacek Anaszewski wrote:
>>>>> Hi Dan,
>>>>>
>>>>> Thank you for the RFC.
>>>>>
>>>>> One vital thing is missing - documentation of brightness file must
>>>>> be updated to define its semantics for LED multi color class.
>>>>>
>>>>> Either we need brightness-model file returning only "onoff" option
>>>>> available, or, for time being, fix the max_brightness for LED multi
>>>>> color class to 1 (which will map to max intensity level for each color).
>>>>>
>>>>
>>>> I can make max_brightness default to 1 if not set by the LED driver.
>>>>
>>>> But the LP50xx has brightness controls so setting max_brightness from the driver should over ride
>>>> the max of 1 in the upper level.
>>>
>>> Yes, so the max_brightness should be updated basing on current
>>> brightness-model. For LEDn_BRIGHTNESS of LP50xx we could have
>>> "hw" or maybe even better just "lp50xx-linear" and "lp50xx-logarithmic"
>>> - I just forgot about that capability of the device.
>>>
>>
>> OK maybe "hw" would make sense as there may be other devices that have dedicated brightness controls
>> over color controls.
> 
> Single "hw" doesn't address both linear and logarithmic.
> This is device specific, so I don't see anything wrong in
> "lp50xx-*", provided that it will be documented.
> 

OK.  This would need to be lp50xx specific.

>> Probably need to create a model for non-modeled cases like "rgb-independent".  Dumb name but I could not
>> think of anything better.
> 
> There is no point in having any rgb* brightness model since increasing
> rgb in an arbitrary way will not give the impression of increasing color
> intensity (lightness of the same hue). With DT defined hsl-<color>
> ranges there is no way to verify that levels arrangement makes sense
> with regard to preserving hue, this is a matter of trust. But we should
> state that it is highly recommended to obey this constraint so as to
> not mislead users.
> 

OK.  I will document this in v2 for discussion

>>>> For devices that do not support brightness as a separate control we can create a file called
>>>> max_brightness_<color> that defines the max that a specific color can be set to.  If max_brightness
>>>> is set to 1 then create max_brightness_<color>.  If max_brightness > 1 then do not create the files.
>>>
>>> Right. We will need dedicated max_brightness for each color.
>>> They should be placed also in the colors directory, next to the color
>>> files.
>>>
>>
>> OK will document this.
>>
>>>> I don't think we have fully vetted the brightness-model yet so I prefer to omit
>>>> it and possibly introduce that later.
>>>
>>> We need to start from something. It will give better overview of the
>>> whole idea.
>>>
>>
>> OK.  Don't get me wrong I don't oppose this idea I am just trying to figure out how the user space would
>> know what models and brightness levels are available.
> 
> $ cat brightness-model
> lp50xx-linear lp50xx-logarithmic onoff hsl-green hsl=blue
> 
> max_brightness will return available number of brightness levels
> for each brightness model.
> 

So max_brightness here would be dynamic?
Or could we read hsl-<color> and get the number of levels and not mess with the max_brightness definition?

Or should that be the current level?

> I'd not bother with presenting whole range of available color
> presets. Userspace can verify the brightness->color mapping
> by reading colors/<color> files after setting given brightness
> level.
> 

Userspace would have to have knowledge of the values set in order to verify the
color values.

> However, I'm not sure how useful it will be. This is a gist
> of this whole discussion - we cannot be certain about exact
> color effect produced with given settings.
> 
>> I mean we can read the brightness-models and present the available models but then how does the user know
>> what and how many levels are in each model?  And how do we govern putting them in the right order?
> 
> `cat max_brightness` will return number of levels for the model
> currently set. Regarding the order - we must rely on the DT array
> arrangement. In case of hardware originated brightness model we
> must trust hardware implementation.
> 

Another question on this is what is the proposed definition of the DT value?

is it supposed to be 0xrrggbb?  What about other colors like Amber?
This was demonstrated in one of the videos you sent.

Maybe it should be rgb-<color> and not hsl-<color> because these values are not hsl values
but instead RGB values.

>> The DT file can get messed up, per the previous example
>> rgb-green = <0x277c33 0x37b048 0x47e45d>;
>>
>> This is assumed to be from dimmest to brightest.  But that is just an assumption
>>
>> What if the entry looked like this?
>> rgb-green = <0x37b048 0x277c33 0x47e45d>;
> 
> We can do nothing. It is just the cost of leaving some decisions to DT.
> 

<snip>

> 
> I intended that brightness-model location would be the main LED class
> device directory.
> 
> And the whole concept is simple. We allow to set what we get from DT
> or from the hardware. Without verification exceeding beyond
> max_brightness values defined per iout.
> 

Yes this is simple will put some documentation around it for discussion

Dan

-- 
------------------
Dan Murphy
