Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160E8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE69620652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fqrt3ACu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfARN6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:58:45 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41312 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfARN6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:58:45 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0IDwcwC039785;
        Fri, 18 Jan 2019 07:58:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547819918;
        bh=zt6HHLDOW9qbttLqimqGZq7HG+F8VLia1uXVYWDLyuY=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=fqrt3ACuQwb+D6iNjBlyjSkeS62T57I4SMpsAujX1DZKXJVeebytg7XxCwuHjjz25
         K+BRYP743GGa1APsCmpJf6a0jcpVp3UY3yMPkm2RKm2IL/by8sOBlNA7gHSxbOeUD3
         D41gpvL+9dhLQXhbDPXEedYziVv/39W6l21FxlyA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0IDwcxY004996
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jan 2019 07:58:38 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 18
 Jan 2019 07:58:38 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 18 Jan 2019 07:58:37 -0600
Received: from [172.22.105.109] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0IDwbID020084;
        Fri, 18 Jan 2019 07:58:37 -0600
Subject: Re: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX family of the RGB LED
 driver
From:   Dan Murphy <dmurphy@ti.com>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dachaac@gmail.com>,
        <robh+dt@kernel.org>
References: <20190114211723.11186-1-dmurphy@ti.com>
 <20190114211723.11186-2-dmurphy@ti.com>
 <ce911fdf-c7c2-63e8-5c7a-b0be965ab69b@gmail.com> <20190115222223.GA17363@amd>
 <79394d17-3124-75b2-ccac-dc1046499d14@ti.com> <20190116105537.GA1803@amd>
 <86299268-3202-814a-134b-04bd2170faab@ti.com>
 <8dfa2854-2814-6874-ab8e-1858e9a18acf@gmail.com>
 <9f87e1ac-be66-2998-578c-de2c1794a00a@ti.com>
Message-ID: <4a20b14c-9514-25b8-affe-20f9ede4d4d8@ti.com>
Date:   Fri, 18 Jan 2019 07:58:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9f87e1ac-be66-2998-578c-de2c1794a00a@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 1/18/19 7:45 AM, Dan Murphy wrote:
> Jacek
> 
> On 1/17/19 3:10 PM, Jacek Anaszewski wrote:
>> Hi Dan,
>>
>> On 1/16/19 7:41 PM, Dan Murphy wrote:
>>> Hello
>>>
>>> On 1/16/19 4:55 AM, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>> On 1/15/19 4:22 PM, Pavel Machek wrote:
>>>>>> Hi!
>>>>>>
>>>>>>>> +The 24-bit RGB value passed in follows the pattern 0xXXRRGGBB
>>>>>>>> +XX - Do not care ignored by the driver
>>>>>>>> +RR - is the 8 bit Red LED value
>>>>>>>> +GG - is the 8 bit Green LED value
>>>>>>>> +BB - is the 8 bit Blue LED value
>>>>>>>> +
>>>>>>>> +Example:
>>>>>>>> +LED module output 4 of the LP5024 will be a yellow color:
>>>>>>>> +echo 0xe6de00 > /sys/class/leds/lp5024\:led4_mod/color
>>>>>>>> +
>>>>>>>> +LED module output 4 of the LP5024 will be dimmed 50%:
>>>>>>>> +echo 0x80 > /sys/class/leds/lp5024\:led4_mod/brightness
>>>>>>>> +
>>>>>>>> +LED banked RGBs of the LP5036 will be a white color:
>>>>>>>> +echo 0xffffff > /sys/class/leds/lp5036\:led_banked/color
>>>>>>>
>>>>>>> This part with example cans remain in Documentation/leds if you
>>>>>>>> like.
>>>>>>
>>>>>> Does it actually work like that on hardware?
>>>>>
>>>>> What?
>>>>
>>>> If you do echo 0xffffff > /sys/class/leds/lp5036\:led_banked/color,
>>>> does it actually produce white? With all the different RGB modules
>>>> manufacturers can use with lp5024P?
>>>>
>>>> If you do echo 0xe6de00 > /sys/class/leds/lp5024\:led4_mod/color, does
>>>> it actually produce yellow, with all the different RGB modules
>>>> manufacturers can use with lp5024P?
>>>>
>>>
>>> I believe the answer to the general questions is no for any RGB cluster and driver out there.
>>> Because if you set the same values on each and every RGB device out there you will get varying shades of the color.
>>> But for this device yes the color does appear to be yellow to me versus what was displayed on my monitor by the HSL picker.
>>> But everyone interprets colors differently.
>>>
>>> If you write the same value for yellow or white on a droid 4 and the N900 do they produce the same color side by side?
>>> Most probably not.
>>>
>>> As you pointed out the PWM needs to be modified to obtain the correct white color to account for LED and other device constraints.
>>>
>>> But we need to take into account the light pipe.  Pools nowadays have RGB LED spot lights in them.  It can
>>> be set to white.  On my pool right off the lens the color has a purplish hue to it.  As the light is diffracted into
>>> the pool the color becomes white.  The pool is clear.  When I add chemicals to the pool and make it cloudy
>>> and turn on the lights the color off the lens is now white.  This is an example on a large scale but the issue
>>> scales down to the hand helds and smart home applications.
>>>
>>> If the cluster is piped through a flexible optic 0xffffff may produce the "white" you want on its output.
>>>
>>> So an expectation of certain color without proper piping based on a single RGB value may be a little unreasonable.
>>> There may need to be a way to attenuate the values based on the hardware aspect of the equation ie light pipe (or lack thereof) and LED vendor.
>>> So if we write 0xffffff to the RGB driver the driver could adjust the intensity of the individual LEDs based on the diffraction
>>> coefficients.
>>>
>>> I also think that is an unreasonable expectation here that writing a single value to any LED RGB driver would produce
>>> a "rest of the world" absolute color.  Maybe it can produce something similar but not identical.
>>> As you indicated in the requirements there is more involved here then just the LED and the values written.
>>> The colors should be close but may not be identical.
>>>
>>> A 10 year old N900 should not be considered the gold standard for color production due to advancements in LED,
>>> light pipe and LED driver technology.
>>> The single package RGB clusters on the board I am testing is about the size of a single RGB LED from 10 years ago.
>>>
>>> I agree that the interface developed should work on the device but the algorithm derived to obtain the color needs to have
>>> a hardware aspect to the calculation.
>>>
>>>>>> Is it supposed to support "normal" RGB colors as seen on monitors?
>>>>>
>>>>> Monitors are not an application for this part.
>>>>
>>>> You did not answer the question. When you talk about yellow, is it
>>>> same yellow the rest of world talks about?
>>>>
>>>
>>> See above.  It is close to what was on my monitor displayed.
>>>
>>>>>> Because 100% PWM on all channels does not result in white on hardware
>>>>>> I have.
>>>>>
>>>>> I don't know I am usually blinded by the light and have no diffuser over
>>>>> the LEDs to disperse the light so when I look I see all 3 colors.
>>>>
>>>> How can we have useful discussion about colors when you don't see the
>>>> colors?
>>>>
>>>> Place a piece of paper over the LEDs....
>>>>
>>>
>>> Good suggestion for a rough test.
>>>
>>>>>> But...
>>>>>>
>>>>>> I believe we should have a reasonable design before we do something
>>>>>> like this. There's no guarantee someone will not use lp50xx with just
>>>>>> the white LEDs for example. How will this work? Plus existing hardware
>>>>>> already uses three separate LEDs for RGB LED. Why not provide same
>>>>>> interface?
>>>>>
>>>>> Which existing hardware?  Are they using this part?
>>>>
>>>> Nokia N900. They are not using this part, but any interface we invent
>>>> should work there, too.
>>>>
>>>
>>> Yes a common interface would be nice with some sort of hardware tuning coefficient.
>>>
>>>>> <rant>
>>>>> Why are we delaying getting the RGB framework or HSV in?
>>>>> I would rather design against something you want instead of having
>>>>> everyone complain about every implementation I post.
>>>>> </rant>
>>>>
>>>> Because you insist on creating new kernel interfaces, when existing
>>>> interfaces work, and are doing that badly.
>>>>
>>>> Because your patches are of lower quality than is acceptable for linux
>>>> kernel.
>>>>
>>>> Because you don't seem to be reading the emails.
>>>>
>>>> I sent list of requirements for RGB led support. This does not meet
>>>> them.
>>>>
>>>
>>> Sigh.  You did not answer my question.
>>>
>>> Your requirements seem to be centered around monitors but that is only one application of the current
>>> RGB LED landscape.
>>>
>>> I am willing to work with you on the HSV and adapting the LP50xx part to this framework.
>>> Or any RGB framework for that matter.  I still don't agree with the kernel needing to declare colors
>>>   maybe color capabilities but not specific colors.
>>
>> Dan, if you have a bandwidth for LED RGB class implementation
>> then please go ahead. It would be good to compare colors produced
>> by software HSV->RGB algorithm to what can be achieved with
>> LEDn_BRIGHTNESS feature.
>>
>> The requirements for LED RGB class as I would see it:
>>
>> sysfs interface:
>>
>> brightness-model: space separated list of available options:
>> - rgb (default):
>>   - creates color file with "red green blue" decimal values
> 
> What about other colored LEDs?  Presenting RGB for an Amber LED does not seem right.
> Should the LED color come from the DT?
> 

I thought about this, other non-RGB LEDs would not use the RGB framework.
But should they have the same interfaces as RGB?

Should PWM control be a global interface?

Dan

<snip>
-- 
------------------
Dan Murphy
