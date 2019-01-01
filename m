Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237EBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 18:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F9D20675
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 18:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="swNNJcnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfAASLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 13:11:13 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42174 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfAASLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 13:11:13 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x01IB7M1003968;
        Tue, 1 Jan 2019 12:11:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546366267;
        bh=iHXfOHn0b0htqrssU0u5zis4BkHC1sIN5MGfElKSYZg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=swNNJcnrP/cGfyKdmbY5IycLIRp9Q/hEdOIu4RHtpPjEjjJRWNkpLOWbutGt6pz5I
         2UtzBsxdDLJOntGMfmG/TjbHrfrFY2gnjWpwkOX7vfWI2HILwwpBXw/FqxPdJ7NJCU
         uoZQPNHpY80uok4cCvO8+EJATgpusC1uUxTyCt60=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x01IB7Zj099766
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Jan 2019 12:11:07 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 1
 Jan 2019 12:11:07 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 1 Jan 2019 12:11:06 -0600
Received: from [172.22.103.226] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x01IB6qi011666;
        Tue, 1 Jan 2019 12:11:06 -0600
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20181219201047.GA23448@amd>
 <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
 <71d3ac12-5beb-0a26-71e1-5eae798e7b9f@gmail.com>
 <2bca210b-76ad-d5a9-906c-4151695050c3@gmail.com>
 <45ce01f0-af6e-1cc6-5126-fb557c7d2a82@ti.com>
 <b7c69135-1641-48cb-1770-c4c77a989efe@gmail.com> <20181229190726.GA29851@amd>
 <4b5a89ed-0c0b-3103-ca57-a0f97aa5ace9@gmail.com> <20181230173505.GA19593@amd>
 <7763a3ae-343c-0fbe-da88-afce8459e4c2@gmail.com>
 <9eafcf90-9083-ff42-e256-82d61991d610@gmail.com>
 <c687413a-863d-26eb-ca0b-b00a89a4ed44@ti.com>
 <482f143f-7c04-9d48-5c73-00a9ad4f254c@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <ab60b3ec-5111-997e-6832-33402d5cc08b@ti.com>
Date:   Tue, 1 Jan 2019 12:11:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <482f143f-7c04-9d48-5c73-00a9ad4f254c@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

Thanks for the reply!

All

Happy New Year!

On 1/1/19 8:42 AM, Jacek Anaszewski wrote:
> On 12/31/18 8:15 PM, Dan Murphy wrote:
>> On 12/31/18 9:47 AM, Jacek Anaszewski wrote:
>>> On 12/31/18 4:43 PM, Jacek Anaszewski wrote:
>>>> On 12/30/18 6:35 PM, Pavel Machek wrote:
>>>>> On Sun 2018-12-30 18:09:35, Jacek Anaszewski wrote:
>>>>>> On 12/29/18 8:07 PM, Pavel Machek wrote:
>>>>>>> Hi!
>>>>>>>
>>>>>>>>>> With the "color" sysfs file it will make more sense to allow for user
>>>>>>>>>> defined color palettes.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I think defining these values in the device tree or acpi severely limits the devices
>>>>>>>>> capabilities.  Especially in development phases.  If the knobs were exposed then the user space
>>>>>>>>> can create new experiences.  The color definition should be an absolute color defined in the dt and
>>>>>>>>> either the framework or user space needs to mix these appropriately.  IMO user space should set the policy
>>>>>>>>> of the user experience and the dt/acpi needs to set the capabilities.
>>>>>>>>>
>>>>>>>>> I do like Pavels idea on defining the more standard binding pattern to "group" leds into a single group.
>>>>>>>>>
>>>>>>>>> Maybe the framework could take these groups and combine/group them into a single node with the groups colors.
>>>>>>>>
>>>>>>>> There is still HSV approach [0] in store. One problem with proposed
>>>>>>>> implementation is fixed algorithm of RGB <-> HSV color space conversion.
>>>>>>>> Maybe allowing for some board specific adjustments in DT would add
>>>>>>>> more flexibility.
>>>>>>>>
>>>>>>>> [0] https://lkml.org/lkml/2017/8/31/255
>>>>>>>
>>>>>>> Yes we could do HSV. Problem is that that we do not really have RGB
>>>>>>> available. We do have integers for red, green and blue, but they do
>>>>>>> not correspond to RGB colorspace.
>>>>>>
>>>>>> OK, so conversion from HSV to RGB would only increase the aberration.
>>>>>> So, let's stick to RGB - we've got to have some stable ground and this
>>>>>> is something that the hardware at least pretends to be compliant
>>>>>> with.
>>>>>
>>>>> I'm not saying that we should stick to RGB. I'm just saying that
>>>>> problem is complex.
>>>>>
>>>>> And no, hardware does not even pretend to be compliant with RGB color
>>>>> model ( https://en.wikipedia.org/wiki/RGB_color_model ). In
>>>>> particular, in RGB there is non-linear brightness curve.
>>>>
>>>> Quotation from the wiki page you referred to:
>>>>
>>>> "RGB is a device-dependent color model: different devices detect or
>>>> reproduce a given RGB value differently, since the color elements (such
>>>> as phosphors or dyes) and their response to the individual R, G, and B
>>>> levels vary from manufacturer to manufacturer, or even in the same
>>>> device over time. Thus an RGB value does not define the same color
>>>> across devices without some kind of color management"
>>>>
>>>> This claim alone leaves much room for the manufacturers to pretend that
>>>> their devices are compliant with RGB model.
>>>>
>>>> And the documentation of the hardware the discussed driver is for
>>>> also refers to RGB model in many places - e.g. see Table 1, page 15
>>>> in the document [0], where mapping of output triplets to an RGB module
>>>> is shown.
>>>>
>>>> One thing that I missed is that the discussed hardware provides
>>>> LEDn_BRIGHTNESS registers for each RGB LED module, that can be
>>>> configured to set color intensity in linear or logarithmic fashion.
>>>>
>>>> Actually this stands in contradiction with RGB model, since
>>>> change of "color intensity" means change of all RGB components.
>>>>
>>>> We could use brightness file as for monochrome LEDs for that,
>>>
>>> Here I mean brightness file in addition to the previously proposed
>>> red, green and blue files.
>>>
>>>> but we'd need to come up with consistent interface semantics
>>>> for all devices, also those which don't have corresponding
>>>> functionality. Probably this is the place where we could apply
>>>> some RGB<->HSV conversion, as color intensity feels something
>>>> more of HSV's saturation and value.
>>>>
>>>> It would be good to hear from Dan how that looks in reality
>>>> in case of lp5024 device.
>>
>> Sorry for the non-response I have had a passing in my family and have not been at my
>> computer for some time.
> 
> Sorry to hear that. In fact there was no delay, since I wrote that
> yesterday.
> 
>> I am not seeing how HSV will fit into this device.  Not sure what the V is in HSV.
> I meant RGB<->HSV conversion as a fallback for RGB LED
> controllers that don't have the functionality similar to
> LEDn_BRIGHTNESS. For lp5024 we'd use just what hardware offers.
> 
> You can get the flavor of the relationship between RGB and HSV using
> e.g. GIMP color editor. After that you could share a feedback if
> changing LEDn_BRIGHTNESS feels like changing saturation and value of
> HSV.
> 
> Remember that we're still talking about generic approach to the problem.
> 
>> I am still not a fan of defining colors in the kernel.  I think the user space needs to do this based
>> on information it is given.  When I look at Android the user space sets all the policies of the hardware
>> the kernel just provides the vehicle to hardware.  I think defining any set colors in the kernel for devices
>> that have a full color spectrum palette is very restricting.  The kernel should indicate the absolute colors
>> available and not the colors that are allowed.  So in this case we indicate that a Red, green and blue LED are
>> available or that the palette is variable.  Or in the case of a white LED driver we just say white.
> 
> HSV is in no way restrictive. But I'm not pushing for that.
> Vesa in his recent message mentions some difficulties in mapping all RGB
> combinations to HSV.
> 
> We just need something generic and don't want ledn_mix and
> ctrl_bank*mix sysfs files, which are device specific.

OK that makes sense.  I will have to think about how to map HSV to this device.  It becomes complex because
of the way this device groups the LEDs and has a single brightness control.  

If we had a version of the HSV->RGB framework that looks to be set for application then I can present a new version with that FW being used
on top of that patch?

Is that on linux-leds-next?


> 
>> In the case of this device there are RGB outputs that are grouped in clusters and controlled by the LEDn_BRIGHTNESS
>> register.  This is what the brightness file is mapped to.  Within that cluster the individual intensity of the RGB can
>> be modified via the OUTn_color register.  Not knowing what color LED is on what output means the sysfs node has to be left generic.
>>
>> So as Pavel pointed out white would need to be achieved through the RGB individual LEDs being set to certain values and
>> the difuser disfusing the light to achieve the color.  This was done on the original DROID device with a RGB and we
>> were able to get a "white" color but had to set the RGB LEDs to different values.  For this device, once the color is
>> achieved there may be no reason to adjust the color so adjusting the overall brightness of the LEDs without adjusting the
>> individual color can be done with a single write and look seamless to the user.
>> Or other colors can be tuned by setting the unneeded colors in the OUTn_color to 0.
>>
>> These RGB LED clusters can also be grouped into LED banks as well so that all LEDs of the same color within the group will have
>> the same color gradient and brightness.  This is achieved with the BANK_X_COLOR and BRIGHTNESS registers.
>>
>> Again I am not sure how the HSV would work for this device since there is no reason to create a node for each LED output.
>> As the overall brightness of the cluster or bank is controlled by a single brightness file.
> 
> I think that you misunderstood me. I didn't mention creating
> separate nodes for each LED output anywhere.
> 

No this was not something you indicated it was an earlier comment by Pavel, and it is which the LED file nodes are expected
as we have discussed in the past.

Dan
-- 
------------------
Dan Murphy
