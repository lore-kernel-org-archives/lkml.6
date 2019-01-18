Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D42C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767DD2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hZHZUIg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfARP5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:57:49 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33012 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfARP5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:57:49 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0IFvhTV074246;
        Fri, 18 Jan 2019 09:57:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547827063;
        bh=dYNgpu/5Hd+sUMmF8r74M3hoY8hUhbbxJu1xuWyZyeA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hZHZUIg2VZddgk2zshRBfgWlL4KgZOZje0DVnJjXj/Sc7nG8y45SBN0+BNOwj+K2/
         HaiOxFJHL7tfi3ujdfL672XTYKXwc3dY02IYTE5HZg+Gq5fc2m71RaeMc+qzHsgm6N
         YHuS3CKsMHSf+3ZK/aO//2tuoEB9Mq4+9tuQ2lys=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0IFvgr0041067
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jan 2019 09:57:43 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 18
 Jan 2019 09:57:42 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 18 Jan 2019 09:57:42 -0600
Received: from [172.22.105.109] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0IFvgW9015775;
        Fri, 18 Jan 2019 09:57:42 -0600
Subject: Re: RGB LED class Re: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX
 family of the RGB LED driver
To:     Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dachaac@gmail.com>,
        <robh+dt@kernel.org>
References: <20190114211723.11186-1-dmurphy@ti.com>
 <20190114211723.11186-2-dmurphy@ti.com>
 <ce911fdf-c7c2-63e8-5c7a-b0be965ab69b@gmail.com> <20190115222223.GA17363@amd>
 <79394d17-3124-75b2-ccac-dc1046499d14@ti.com> <20190116105537.GA1803@amd>
 <86299268-3202-814a-134b-04bd2170faab@ti.com>
 <8dfa2854-2814-6874-ab8e-1858e9a18acf@gmail.com> <20190118000235.GB27661@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <b7ee7c2b-0878-962c-71ee-3ef281f6de0f@ti.com>
Date:   Fri, 18 Jan 2019 09:57:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118000235.GB27661@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 1/17/19 6:02 PM, Pavel Machek wrote:
> Hi!
> 
> 
>>> I am willing to work with you on the HSV and adapting the LP50xx part to this framework.
>>> Or any RGB framework for that matter.  I still don't agree with the kernel needing to declare colors
>>>  maybe color capabilities but not specific colors.
>>
>> Dan, if you have a bandwidth for LED RGB class implementation
>> then please go ahead. It would be good to compare colors produced
>> by software HSV->RGB algorithm to what can be achieved with
>> LEDn_BRIGHTNESS feature.
> 
> Don't get me wrong, I'd like to see LED RGB class implementation. But
> it will delay merge of this driver.
> 
> If we want to do that, we should first discuss the requirements, and
> then come up with interface.. and only then we can talk about the
> driver code.
> 
> That's why I believe preferable way would be to merge the driver using
> the existing interface.
> 
> Of course, first designing RGB LED class and then merging the
> driver.. is okay with me. But lets not rush the class because there's
> driver waiting for it.
> 

We have been able to provide users a preliminary driver they can use to test
their hardware.  It is not the ideal driver but it helps them develop their
product.

The important thing here is that the driver is available to all from the Linux mainline
and not from a product repo.

>> The requirements for LED RGB class as I would see it:
>>
>> sysfs interface:
>>
>> brightness-model: space separated list of available options:
>> - rgb (default):
>>   - creates color file with "red green blue" decimal values
>>   - creates brightness file
>> 	a) for devices with hardware support for adjusting color
>>            intensity it maps to corresponding register
>>         b) for the rest writing any value greater than 0 will result
>>            in setting all color registers to max
>> - hsv:
>>   - creates color file with "h s v" values - it shall
>>     use software HSV->RGB algorithm for setting color registers
>>
>> - any other custom color ranges defined in DT, but it can be covered
>>   later
>> - other options?
> 
> First, I think we want to decide if RGB LED should be presented as
> 3 LEDs or as 1 LED... and what to do with existing RGB leds being
> presented as 3 LEDs.

What do we do with RGBW drivers?  Like the LP5562.  RGB can be grouped as a single
LED but does the white LED get grouped too or should it register as a new LED?

I am assuming the answer is that it would register as a new LED.

> 
> I don't think we want to support both RGB and HSV in the kernel. It is
> math, and not a nice one.
> 
> Yes, both have advantages and disadvantages, but having _both_ in
> kernel has disadvantages of both.
> 

I agree.  Beyond the math I think giving developers a choice may bring about
driver discussion of why the developer is using RGB over HSV or vice versa.

> One way I could imagine the interface:
> 
>     RGB LED presented as one LED.
> 

We would have to figure out a cluster schema that would group these LEDs.

Difficulty would come if you have different drivers driving different LEDs.
I personally have not seen this but the possibility is there.

We don't have to put that in the initial design and if a developer needs this
level of functionality they can submit a patch.

>     brightness -- controls brightness of whole RGB module.
> 

This would be nice assuming the product groups them.  They should also be
individual LEDs like we have today. 

>     pwm_channels -- "1000 240 300" -- "red part should be full on, green
>     should be pwm controlled to 240/1000, blue should be 300/1000"
> 

Why 1000?  Why not based on a duty cycle percentage and let the LED driver figure out
what that means to the device?

pwm_channels -- "100 24 30" -- red part is full on 100%, green is 24% duty cycle and
blue is 30% duty cycle.

>     pwm_white -- "1000 500 400" -- tells userspace what to write to PWM
>     channels to get approximately white color.
> 

Same as above on the duty cycle.

But I still am in disagreement with the kernel detailing what is white or how to
achieve white.

Based on my earlier email about light pipes and the LED vendors and aging I think product
developers will need to fine tune what is "white" on their product from user space or even a DT node.

Not sure that the driver needs to have that level of intelligence because it has no idea
what vendor or what shade of the LED it is driving or even if the LED it is driving is the
color defined.  All be it that the LP50xx data sheet does suggest that the LEDs be connected to
particular outputs but that does not mean they will.

Wondering if it would be better to set a DT node property like rgb-white that defines the values
the driver would need for the hardware to produce a white color.  Then the driver would register a
set_color_white call back and the driver would take the hardware property and set the color values as defined.

Then the user space can set either "color" to 0xff 0xff 0xff or pwm_channels to 100 100 100 and the framework
would call the set_color_white call back as opposed to the set_color call back.

If rbg-white does not exist in the dt node then no call back is set and the the set_color call back is only called.
rgb-white can be an optional child property. And this eliminates the need for a user ABI

Thoughts?


>     This would assume that RGB LEDs are always pwm controlled. That
>     seems to be true for hardware I seen.
> 

GPIO LEDs can be binary or use PWM depending on what is needed.

>     + no complex math in kernel

We can eliminate the math if we use the "color" file that was proposed and pass in absolute
hex/decimal numbers for color.

> 
>     + userspace knows enough to display arbitrary colors
> 
>     + userspace can use full range of available PWM intensities
> 

Do we need a pwm_max file to indicate to the user space what the max values of the pwm
is for each color?

>     + existing triggers will work nicely
> 
>     - userland needs to do non-trivial math to get colors it wants
> 

Could this be done via a DT node that exposes an attenuation constant for each LED?
Then user space can query and apply the attenuation to the associated LED.

Or userland may not care and this can be done in the driver.
It would be optional child property. And this eliminates the need for a user ABI

>     - not sure how to migrate existing devices
> 
> Thoughts? Other possible interfaces?

Userland would need to know what RGBs are available.  The product could use a green and blue
or red and green or whatever combo.  So userland can know that not all colors are available.


Dan

> 
> Best regards,
> 									Pavel
> 


-- 
------------------
Dan Murphy
