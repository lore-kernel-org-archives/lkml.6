Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DD8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABE520840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fGXyTpaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfAPSmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:42:17 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60182 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfAPSmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:42:16 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0GIgAcn049318;
        Wed, 16 Jan 2019 12:42:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547664130;
        bh=OloFudqDrSDSDzwgIpRW5JxXh2nLkcgJsxwQBWNgvDA=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=fGXyTpaBjbSydNhIOoITwsNhYpRsbQw7kLRcWK3Qo4sRDLmJuXpCijERKUvLV6ff8
         Qgf1TjFzmWcz/mVXCRLu4up2nUeo3glbjri9UAoFm+c7Zx/hdLNoGdS7P9vH1NtNib
         v+Uoyjo7r8ewUFrLxmZtArKIK1MH2TFxKkAxS+h0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0GIgARF045313
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 12:42:10 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 12:42:09 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 12:42:09 -0600
Received: from [172.22.103.16] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0GIg9Nx002738;
        Wed, 16 Jan 2019 12:42:09 -0600
From:   Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX family of the RGB LED
 driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dachaac@gmail.com>,
        <robh+dt@kernel.org>
References: <20190114211723.11186-1-dmurphy@ti.com>
 <20190114211723.11186-2-dmurphy@ti.com>
 <ce911fdf-c7c2-63e8-5c7a-b0be965ab69b@gmail.com> <20190115222223.GA17363@amd>
 <79394d17-3124-75b2-ccac-dc1046499d14@ti.com> <20190116105537.GA1803@amd>
Message-ID: <86299268-3202-814a-134b-04bd2170faab@ti.com>
Date:   Wed, 16 Jan 2019 12:41:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190116105537.GA1803@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 1/16/19 4:55 AM, Pavel Machek wrote:
> Hi!
> 
>> On 1/15/19 4:22 PM, Pavel Machek wrote:
>>> Hi!
>>>
>>>>> +The 24-bit RGB value passed in follows the pattern 0xXXRRGGBB
>>>>> +XX - Do not care ignored by the driver
>>>>> +RR - is the 8 bit Red LED value
>>>>> +GG - is the 8 bit Green LED value
>>>>> +BB - is the 8 bit Blue LED value
>>>>> +
>>>>> +Example:
>>>>> +LED module output 4 of the LP5024 will be a yellow color:
>>>>> +echo 0xe6de00 > /sys/class/leds/lp5024\:led4_mod/color
>>>>> +
>>>>> +LED module output 4 of the LP5024 will be dimmed 50%:
>>>>> +echo 0x80 > /sys/class/leds/lp5024\:led4_mod/brightness
>>>>> +
>>>>> +LED banked RGBs of the LP5036 will be a white color:
>>>>> +echo 0xffffff > /sys/class/leds/lp5036\:led_banked/color
>>>>
>>>> This part with example cans remain in Documentation/leds if you
>>>>> like.
>>>
>>> Does it actually work like that on hardware?
>>
>> What?
> 
> If you do echo 0xffffff > /sys/class/leds/lp5036\:led_banked/color,
> does it actually produce white? With all the different RGB modules
> manufacturers can use with lp5024P?
> 
> If you do echo 0xe6de00 > /sys/class/leds/lp5024\:led4_mod/color, does
> it actually produce yellow, with all the different RGB modules
> manufacturers can use with lp5024P?
> 

I believe the answer to the general questions is no for any RGB cluster and driver out there.
Because if you set the same values on each and every RGB device out there you will get varying shades of the color.
But for this device yes the color does appear to be yellow to me versus what was displayed on my monitor by the HSL picker.
But everyone interprets colors differently.

If you write the same value for yellow or white on a droid 4 and the N900 do they produce the same color side by side?
Most probably not.

As you pointed out the PWM needs to be modified to obtain the correct white color to account for LED and other device constraints.

But we need to take into account the light pipe.  Pools nowadays have RGB LED spot lights in them.  It can
be set to white.  On my pool right off the lens the color has a purplish hue to it.  As the light is diffracted into
the pool the color becomes white.  The pool is clear.  When I add chemicals to the pool and make it cloudy
and turn on the lights the color off the lens is now white.  This is an example on a large scale but the issue
scales down to the hand helds and smart home applications.

If the cluster is piped through a flexible optic 0xffffff may produce the "white" you want on its output.

So an expectation of certain color without proper piping based on a single RGB value may be a little unreasonable.
There may need to be a way to attenuate the values based on the hardware aspect of the equation ie light pipe (or lack thereof) and LED vendor.
So if we write 0xffffff to the RGB driver the driver could adjust the intensity of the individual LEDs based on the diffraction
coefficients.

I also think that is an unreasonable expectation here that writing a single value to any LED RGB driver would produce
a "rest of the world" absolute color.  Maybe it can produce something similar but not identical.
As you indicated in the requirements there is more involved here then just the LED and the values written.
The colors should be close but may not be identical.

A 10 year old N900 should not be considered the gold standard for color production due to advancements in LED,
light pipe and LED driver technology.
The single package RGB clusters on the board I am testing is about the size of a single RGB LED from 10 years ago.

I agree that the interface developed should work on the device but the algorithm derived to obtain the color needs to have
a hardware aspect to the calculation.

>>> Is it supposed to support "normal" RGB colors as seen on monitors?
>>
>> Monitors are not an application for this part.
> 
> You did not answer the question. When you talk about yellow, is it
> same yellow the rest of world talks about?
> 

See above.  It is close to what was on my monitor displayed.

>>> Because 100% PWM on all channels does not result in white on hardware
>>> I have.
>>
>> I don't know I am usually blinded by the light and have no diffuser over
>> the LEDs to disperse the light so when I look I see all 3 colors.
> 
> How can we have useful discussion about colors when you don't see the
> colors?
> 
> Place a piece of paper over the LEDs....
> 

Good suggestion for a rough test.

>>> But...
>>>
>>> I believe we should have a reasonable design before we do something
>>> like this. There's no guarantee someone will not use lp50xx with just
>>> the white LEDs for example. How will this work? Plus existing hardware
>>> already uses three separate LEDs for RGB LED. Why not provide same
>>> interface?
>>
>> Which existing hardware?  Are they using this part?
> 
> Nokia N900. They are not using this part, but any interface we invent
> should work there, too.
> 

Yes a common interface would be nice with some sort of hardware tuning coefficient.

>> <rant>
>> Why are we delaying getting the RGB framework or HSV in?
>> I would rather design against something you want instead of having
>> everyone complain about every implementation I post.
>> </rant>
> 
> Because you insist on creating new kernel interfaces, when existing
> interfaces work, and are doing that badly.
> 
> Because your patches are of lower quality than is acceptable for linux
> kernel.
> 
> Because you don't seem to be reading the emails.
> 
> I sent list of requirements for RGB led support. This does not meet
> them.
> 

Sigh.  You did not answer my question.

Your requirements seem to be centered around monitors but that is only one application of the current
RGB LED landscape.

I am willing to work with you on the HSV and adapting the LP50xx part to this framework.
Or any RGB framework for that matter.  I still don't agree with the kernel needing to declare colors
 maybe color capabilities but not specific colors.

It was agreed to continue forward with this particular implementation.
At least thats what the email (I apparently did not read) stated.

I need to fix the code to use the space separated value as pointed out and shown by Vesa.
This will map nicely into this device with the color file as what I implemented is in theory
they same code except for the space separated values.

>> It is not a normal RGB driver.  The device collates the individual RGB
>> clusters into a single brightness register and you can modify the intensity of the individual
>> LEDs via other registers.  If brightness is 0 then the cluster is OFF regardless of the color
>> set in the individual registers.
> 
> I understand that. So just set cluster brightness to 255 and you have
> normal RGB driver you can control with existing interfaces. You don't
> have to use every feature your hardware has.
> 

The brightness file is available and adjusts the brightness of the RGB cluster.
I am not attempting to implement every feature the device has.  But I am attempting to use
the basic features that are available and useful.

> You did not answer the "what if someone uses this with all white LEDs"
> question.
> 

Are you asking what if someone places a white LED instead of a RGB on the hardware?
Well then they need to go back and have a review of the data sheet and what they are trying to
achieve.  That would be a misapplication of the LED driver itself and something software cannot fix.

But if they do determine they want to control these white LEDs with this device
then they can ignore the "color" file and control the cluster via the brightness file like we
do today.  The color file will only change the intensity of the single output (assuming LED module mode)
or the banked output.

If a user wants to place a RGB cluster down on the hardware and have white as the consistent color
well then that is fine as the RGB outputs are all set to 0xff and the intensity of the cluster is
controlled by the brightness file.  If they cannot achieve the "white" with the default settings then
on init they can set the color file once to obtain the "white" color and continue to use the brightness
file to control the overall brightness of the cluster.

It was determined in the email chain not to expose a brightness file per output as this device
does not lend itself to that convention.

> You know what? First, submit driver with similar functionality to
> existing RGB drivers, using same interface existing drivers are
> using. When that is accepted, we can talk about extending
> kernel<->user interfaces.
> 

I could do that but then there is no way for users to have any other color but "white" with this driver.
That defeats the purpose of the device itself.

This is why I would rather align the interfaces with what is being proposed so the interfaces won't change only
the engine underneath will.

I am not sure if you are aware of this or care but I found this recent blog on this effort:
https://www.phoronix.com/scan.php?page=news_item&px=Linux-RGB-LED-Interface
See some of the comments.

Dan

> Thanks,
> 									Pavel
> 


-- 
------------------
Dan Murphy
