Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957E1C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1824120870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NRdOWVwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfAUN1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:27:39 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56000 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbfAUN1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:27:38 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0LDRWXp082462;
        Mon, 21 Jan 2019 07:27:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548077252;
        bh=/WNlEcTdi14qsxXyh9VDkPagnx6CnrH9s5+i3m50+7o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NRdOWVwdVzNijvLRBCcztYWMXGOO0XHZFV01HqZZ4f3ZnPWZoIc0qh4hO6w4adIt6
         6WoRIfKJmqmyysIGeSoYnNldbhX1IHuFPee0WlerJ+6ehzdVLU//c8KH0k/aNhjtuL
         UKdrzFdpghgvPEIPS5VEjlWIA5kv6MayuiNZ8ZmA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0LDRWO7031108
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 07:27:32 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 21
 Jan 2019 07:27:31 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 21 Jan 2019 07:27:31 -0600
Received: from [172.22.78.123] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0LDRVXf027542;
        Mon, 21 Jan 2019 07:27:31 -0600
Subject: Re: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX family of the RGB LED
 driver
To:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
References: <20190114211723.11186-1-dmurphy@ti.com>
 <20190114211723.11186-2-dmurphy@ti.com>
 <ce911fdf-c7c2-63e8-5c7a-b0be965ab69b@gmail.com> <20190115222223.GA17363@amd>
 <79394d17-3124-75b2-ccac-dc1046499d14@ti.com> <20190116105537.GA1803@amd>
 <efb4e1c1-0d13-bed7-d262-284fc1a0c9ab@gmail.com>
 <4115ad75-22f7-d9ae-c38f-e0ab61fb6655@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <275255f1-a552-1dc8-71b0-6575695c6ca7@ti.com>
Date:   Mon, 21 Jan 2019 07:27:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4115ad75-22f7-d9ae-c38f-e0ab61fb6655@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vesa

On 1/19/19 1:11 PM, Vesa Jääskeläinen wrote:
> Hi Jacek et al,
> 
> On 17/01/2019 23.08, Jacek Anaszewski wrote:
>> On 1/16/19 11:55 AM, Pavel Machek wrote:
>>> Hi!
>>>
>>>> On 1/15/19 4:22 PM, Pavel Machek wrote:
>>>>> Hi!
>>>>>
>>>>>>> +The 24-bit RGB value passed in follows the pattern 0xXXRRGGBB
>>>>>>> +XX - Do not care ignored by the driver
>>>>>>> +RR - is the 8 bit Red LED value
>>>>>>> +GG - is the 8 bit Green LED value
>>>>>>> +BB - is the 8 bit Blue LED value
>>>>>>> +
>>>>>>> +Example:
>>>>>>> +LED module output 4 of the LP5024 will be a yellow color:
>>>>>>> +echo 0xe6de00 > /sys/class/leds/lp5024\:led4_mod/color
>>>>>>> +
>>>>>>> +LED module output 4 of the LP5024 will be dimmed 50%:
>>>>>>> +echo 0x80 > /sys/class/leds/lp5024\:led4_mod/brightness
>>>>>>> +
>>>>>>> +LED banked RGBs of the LP5036 will be a white color:
>>>>>>> +echo 0xffffff > /sys/class/leds/lp5036\:led_banked/color
>>>>>>
>>>>>> This part with example cans remain in Documentation/leds if you
>>>>>>> like.
>>>>>
>>>>> Does it actually work like that on hardware?
>>>>
>>>> What?
>>>
>>> If you do echo 0xffffff > /sys/class/leds/lp5036\:led_banked/color,
>>> does it actually produce white? With all the different RGB modules
>>> manufacturers can use with lp5024P?
>>>
>>> If you do echo 0xe6de00 > /sys/class/leds/lp5024\:led4_mod/color, does
>>> it actually produce yellow, with all the different RGB modules
>>> manufacturers can use with lp5024P?
>>
>> Vesa proposed using icc-profiles to make the colors looking similar
>> on various LEDs. It was in reply to your message with requirements
>> for RGB LED class.
>>
>> For this device we can however do without it. Videos showing the
>> performance of this particular device with a reference design using
>> RGB LEDs prove it works nice.
>>
>>>>> Is it supposed to support "normal" RGB colors as seen on monitors?
>>>>
>>>> Monitors are not an application for this part.
>>>
>>> You did not answer the question. When you talk about yellow, is it
>>> same yellow the rest of world talks about?
>>>
>>>>> Because 100% PWM on all channels does not result in white on hardware
>>>>> I have.
>>>>
>>>> I don't know I am usually blinded by the light and have no diffuser over
>>>> the LEDs to disperse the light so when I look I see all 3 colors.
>>>
>>> How can we have useful discussion about colors when you don't see the
>>> colors?
>>>
>>> Place a piece of paper over the LEDs....
>>>
>>>>> But...
>>>>>
>>>>> I believe we should have a reasonable design before we do something
>>>>> like this. There's no guarantee someone will not use lp50xx with just
>>>>> the white LEDs for example. How will this work? Plus existing hardware
>>>>> already uses three separate LEDs for RGB LED. Why not provide same
>>>>> interface?
>>>>
>>>> Which existing hardware?  Are they using this part?
>>>
>>> Nokia N900. They are not using this part, but any interface we invent
>>> should work there, too.
>>>
>>>> <rant>
>>>> Why are we delaying getting the RGB framework or HSV in?
>>>> I would rather design against something you want instead of having
>>>> everyone complain about every implementation I post.
>>>> </rant>
>>>
>>> Because you insist on creating new kernel interfaces, when existing
>>> interfaces work, and are doing that badly.
>>>
>>> Because your patches are of lower quality than is acceptable for linux
>>> kernel.
>>
>> Lets keep things civil please.
>>
>> This sentence should look familiar to you - it's not the first time
>> you resort to this type of narration.
>>
>>> Because you don't seem to be reading the emails.
>>>
>>> I sent list of requirements for RGB led support. This does not meet
>>> them.
>>
>> And you didn't respond to the comments from Vesa. The requirements
>> has not been acclaimed.
>>
>>>> It is not a normal RGB driver.  The device collates the individual RGB
>>>> clusters into a single brightness register and you can modify the intensity of the individual
>>>> LEDs via other registers.  If brightness is 0 then the cluster is OFF regardless of the color
>>>> set in the individual registers.
>>>
>>> I understand that. So just set cluster brightness to 255 and you have
>>> normal RGB driver you can control with existing interfaces. You don't
>>> have to use every feature your hardware has.
>>
>> This feature is one of the core advantages of this device.
>>
>>> You did not answer the "what if someone uses this with all white LEDs"
>>> question.
>>>
>>> You know what? First, submit driver with similar functionality to
>>> existing RGB drivers, using same interface existing drivers are
>>> using. When that is accepted, we can talk about extending
>>> kernel<->user interfaces.
>>
>> This stands in contradiction with my request.
>>
>> Provided there will be no other NAKs, I am eager to accept the
>> interface with color and brightness files.
>>
>> Moreover, I think that RGB LED class with configurable
>> brightness-model, and with possible color range adjustments via
>> icc-profiles or something similar, is the best solution that has been proposed so far. It is just flexible.
>>
>> I'd like to capitalize on the ideas shared in this thread and have
>> finally LED RGB class materialized.
>>
> 
> I have now updated my github code with my understanding of the discussion:
> https://github.com/vesajaaskelainen/linux/tree/wip-multi-color-led
> 

Maybe I did not see it but a RFC to the list would be good for discussion points.

> Commits:
> - dt-bindings: leds: Introduce linux,default-brightness-model for all leds
> https://github.com/vesajaaskelainen/linux/commit/4ffb21d644056686096226bbede7c8c78b0254c2
> - drivers: leds: Add core support for multi color element LEDs
> https://github.com/vesajaaskelainen/linux/commit/627f38bb78cebc694b8e6d735fb088c87925435d
> - dt-bindings: leds: leds-pwm: Introduce multi color element leds support
> https://github.com/vesajaaskelainen/linux/commit/ef6c5730d621e79ea0b02470caa83bc39439536a
> - WIP: drivers: leds: leds-pwm: Add multi color element LED support.
> https://github.com/vesajaaskelainen/linux/commit/0430a27823d9162926424b32c23be1c53eb9cbe2
> 
> First two commits are common and could be taken before I am happy with the pwm led driver changes. This new conditional feature flag makes it a bit harder. Of course one option would be to require it to be enabled.
> 
> Current set of concepts:
> - brightness-model: hardware, onoff, linear

Seem to be missing logarithmic

>   - could be extended in future with other modes like hsv if wanted
> - led_common_setup_of: helper for setting up common parts of led class device from devicetree.
> - led_color_element_setup_of: helper for setting up color element parts of led class device from devicetree.
> - led_scale_color_elements: single point helper for handling brightness-model.
> - From user space point-of-view atomic changes for color elements and brightness.
> 
> Sysfs interfaces:
> - brightness_model: Change of brightness model on the fly. Similar if as trigger selection.
> - color: configuring all color element values as array of values with support for optional brightness entry as last value.
> - color_names: information for user space about color element values in 'color' array.
> - max_color: information for user space about maximum values for entries in 'color' array.
> 
> Example usage:
> 
> $ cd /sys/class/leds/status
> 
> $ ls
> brightness        brightness_model  color             color_names device            max_brightness    max_color         power subsystem         trigger           uevent
> 
> $ cat brightness_model
> hardware [onoff] linear
> $ cat color_names
> red green blue
> $ cat max_color
> 255 255 255
> $ cat brightness
> 0
> 

What happens if brightness is set?  Is that ignored?
What is the driver supposed to do?
The LP50xx can set brightness independent of color but other devices cannot do that.

> # Setting up color to not so bright purple with brightness set to 255
> $ echo "32 0 32 255" > color
> 
> # Setting up color to a bit brighter purple with brightness
> $ echo "128 0 128 255" > color
> 
> # Activate heartbeat blinking
> $ echo "heartbeat" > trigger
> 
> # Now led is blinking with purple color
> 
> # Change color to green
> $ echo "0 255 0" > color
> 
> # Now led is blinking with green color
> 
> And in devicetree I had now:
> 
> multi-color-leds {
>     compatible = "pwm-leds";
> 
>     status-led {
>         label = "status";
>         linux,default-brightness-model = "onoff";
> 
>         element-red {
>             pwms = <&ehrpwm0 0 100000 0>;
>         };
>         element-green {
>             pwms = <&ehrpwm1 0 100000 0>;
>         };
>         element-blue {
>             pwms = <&ehrpwm1 1 100000 0>;
>         };
>     };
> };
> 
> What do you think is this something we agree and could go forward?
> 
> If it is it would be a good idea to get feedback from Dan on how easy it is to use and other possible issues if he takes common commits and tries it out with his lp50xx driver.
> 

The LP50xx pwm is not standard.
It defines a PWM dithering mode which phase shifts the LED outputs and does not really control the PWM width of the LEDs.

I can try to stitch this together for testing.  I will need to go through this code and docs a bit more.

Dan

> Thanks,
> Vesa Jääskeläinen


-- 
------------------
Dan Murphy
