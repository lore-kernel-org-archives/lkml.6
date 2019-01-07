Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22318C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AA62085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ldGEaC4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfAGTgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:36:36 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55760 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbfAGTgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:36:35 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x07JaTWe017033;
        Mon, 7 Jan 2019 13:36:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546889789;
        bh=nqZzChcFNxk88VSkQJxqDD1rzOvOheIvqICzud/6JMs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ldGEaC4URhIVrVgAfU7ieqCHtQOhUnwH37MvwihoK1ERJJNm+P9OoYar96EZI5jiZ
         Wr4d5mFYQ13SM/ohPs38vIgiCKzfhgrVN+7NCBlIYfS7VL192PJyG8TGKwMPPaE/lS
         k4aqga2YyapWVIHZe6yppLHozFlUIFNFkScYYBnw=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x07JaTrj036698
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jan 2019 13:36:29 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 7
 Jan 2019 13:36:29 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 7 Jan 2019 13:36:29 -0600
Received: from [172.22.110.219] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x07JaSKw010722;
        Mon, 7 Jan 2019 13:36:28 -0600
Subject: Re: Generic RGB LED support was Re: [PATCH 2/2] leds: lp5024: Add the
 LP5024/18 RGB LED driver
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
CC:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <986b5105-2fdb-bd25-7c8a-ca8fd1ade821@gmail.com>
 <7f205102-e854-f1cb-cc03-1307d1cddc87@gmail.com>
 <c9f8965a-90f4-b456-8225-c70694c9f071@gmail.com>
 <cf6c0025-36e7-197b-b27a-1f31fb45cc38@gmail.com> <20190104201256.GA2931@amd>
 <a4e3a782-de76-ba91-3727-4db69cf27c3a@gmail.com> <20190104220726.GA12395@amd>
 <4cf79414-578e-eea7-4f46-fc8789206988@gmail.com> <20190105123146.GA16354@amd>
 <8044cdd9-b9b3-fddd-6106-184b906859e2@gmail.com> <20190105221254.GA22322@amd>
 <dac50714-9caf-2496-3208-fb62f886e31f@gmail.com>
 <70366f2a-aafd-174f-73ec-a8117133b7af@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <b027299c-a24a-abeb-8f92-97c32c13290b@ti.com>
Date:   Mon, 7 Jan 2019 13:36:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <70366f2a-aafd-174f-73ec-a8117133b7af@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 1/7/19 1:13 PM, Jacek Anaszewski wrote:
> On 1/6/19 4:52 PM, Jacek Anaszewski wrote:
>> Hi Pavel,
>>
>> On 1/5/19 11:12 PM, Pavel Machek wrote:
>>> Hi!
>>>
>>>>> Grab yourself an RGB LED and play with it; you'll see what the
>>>>> problems are. It is hard to explain colors over email...
>>>>
>>>> Video [0] gives some overview of lp5024 capabilities.
>>>>
>>>> I don't see any problems in exposing separate red,green,blue
>>>> files and brightness for the devices with hardware support for
>>>> that.
>>>
>>> Well, that's what we do today, as three separate LEDs, right?
>>
>> No. It doesn't allow for setting color intensity by having
>> the color fixed beforehand. Below is relevant excerpt from
>> the lp5024 documentation. This is not something that can be
>> mapped to RGB color space, but rather to HSV/HSL, with the
>> reservation that the hardware implementation uses PWM
>> for setting color intensity.
>>
>> <quote>
>> 8.3.1.2 Independent Intensity Control Per RGB LED Module
>>
>> When color is fixed, the independent intensity-control is used to
>> achieve accurate and flexible dimming control for every RGB LED module.
>>
>> 8.3.1.2.1 Intensity-Control Register Configuration
>>
>> Every three consecutive output channels are assigned to their respective
>> intensity-control register (LEDx_BRIGHTNESS). For example, OUT0, OUT1,
>> and OUT2 are assigned to LED0_BRIGHTNESS, so it is recommended to
>> connect the RGB LEDs in the sequence as shown in Table 1. The LP50xx
>> device allows 256-step intensity control for each RGB LED module, which
>> helps achieve a smooth dimming effect.
>> </quote>
>>
>>> I don't have problem with that, either; other drivers already do
>>> that. He's free to use existing same interface.
>>>
>>> But that is insufficient, as it does not allow simple stuff, such as
>>> turning led "white".
>>>
>>> So... perhaps we should agree on requirements, first, and then we can
>>> discuss solutions?
>>>
>>> Requirements for RGB LED interface:
>>>
>>> 1) Userspace should be able to set the white color
>>>
>>> 2) Userspace should be able to arbitrary color from well known list
>>> and it should approximately match what would CRT, LCD or OLED monitor display
>>
>> The difference is that monitor display driver is pre-calibrated
>> for given display by the manufacturer. With the LED controllers the
>> manufacturer has no control over what LEDs will be connected to the
>> iouts. Therefore it should be not surprising that colors produced
>> by custom LEDs are not as user would expect when comparing to
>> the RGB color displayed on the monitor display.
>>
>> TI provides "Various LED Ring Lighting Patterns Reference Design" [0]
>> that show how to produce various patterns with use of the reference
>> board with LED ring built using sixteen 19-337/R6GHBHC-A01/2T LEDs [1].
>>
>> Document [0] mentions also specific "Design considerations" in the
>> chapter 2.2:
>>
>> <quote>
>> Several considerations are taken into account for this particular design:
>> • LED map (ring) for meeting the requirement of popular human-machine interaction style.
>> • LED size, numbers and the diffuse design for meeting lighting pattern uniformity.
>> • Analog dimming in the difference ambient light lux without losing dimming resolution in lighting pattern.
>>
>> These considerations apply to most human-machine interaction end equipment with day and night vision
>> designs in some way, but the designer must decide the particular considerations to take into account for a
>> specific design.
>> </quote>
>>
>> This renders your requirement 2) infeasible with use of custom LEDs
>> any fixed algorithm, since the final effect will always heavily depend
> 
> Typo here: s/any fixed/and fixed/
> 
>> on the LED circuit design.
>>
>>>
>>>      2a) LEDs probably slightly change color as they age. That's out of
>>>      scope, unless the variation is much greater than on monitors.
>>>
>>>      2b) Manufacturing differences cause small color variation. Again,
>>>      that's out of scope, unless the variation is much greater than on
>>>      monitors.
>>>
>>> Nice to have features:
>>>
>>> 3) Full range of available colors/intensities should be available to
>>> userspace
>>>
>>> 4) Interface should work well with existing triggers
>>>
>>> 5) It would be nice if userland knew how many lumens are produced at
>>> each wavelength for each setting (again, minus aging and manufacturing
>>> variations).
>>>
>>> 6) Complexity of math in kernel should be low, and preferably it
>>> should be integer or fixed point
>>>
>>> Problems:
>>>
>>> a) RGB LEDs are usually not balanced. Setting 100% PWM on
>>> red/green/blue channels will result in nothing close to white
>>> light. In fact, to get white light on N900, blue and green channel's
>>> PWM needs to be set pretty low, as in 5%.
>>>
>>> b) LED class does not define any relation between "brightness" in
>>> sysfs and ammount of light in lumens. Some drivers use close to linear
>>> relation, some use exponential relation. Human eyes percieve logarithm
>>> of lumens. RGB color model uses even more complex function.
>>>
>>> c) Except for white LEDs, LEDs are basically sources of single
>>> wavelength of light, while CRTs and LCDs produce broader
>>> spectrums.
>>>
>>> d) RG, RGBW and probably other LED combinations exist.
>>>
>>> e) Not all "red" LEDs will produce same wavelength. Similar
>>> differences will exist for other colors.
>>>
>>> f) We have existing RGB LEDs represented as three separate
>>> monochromatic LEDs in sysfs.
>>
>> One general question: do you have any solutions in store?
>>
>> [0] http://www.ti.com/lit/ug/tiduee6/tiduee6.pdf
>> [1] http://www.everlight.com/file/ProductFile/19-337-R6GHBHC-A01-2T.pdf
>>
> 

I just wanted to point out that there are 4 total devices right now that use the same mapping

LP5018, LP5024, LP5030 and the LP5036.

I can implement what ever we would like to I just need to know what to design against.

But keep in mind I still need to invest my time in the other TI-lmu patches on my list to complete.

Dan

-- 
------------------
Dan Murphy
