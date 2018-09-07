Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D01CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F2C2086B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q4nig9QK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F2C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbeIGSdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:33:54 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42770 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbeIGSdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:33:53 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w87Dqh6D038835;
        Fri, 7 Sep 2018 08:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536328363;
        bh=Gb+ie19SrQWTdfmBW1Hohn2iBJAPS6+CcX0WTTsJBDo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=q4nig9QKEsY4lI+wasyUJPQMmPWb6H64Rr+tBVtYE/FEV26CD5YatpXidgcpY9tep
         +u+e0LYPyTZ0wedLcHbM4Ku++2oqpC07cRf+8I2Jr2MqHNPWHOLbk2WiCLLmHhCiRP
         rNwyCLds52UJZR0+cvimcT9qWGppG6LWZrYTQjV4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w87Dqhs6001942;
        Fri, 7 Sep 2018 08:52:43 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 7 Sep
 2018 08:52:43 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 7 Sep 2018 08:52:43 -0500
Received: from [172.22.180.93] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w87DqgwL008454;
        Fri, 7 Sep 2018 08:52:42 -0500
Subject: Re: [PATCH v6 1/2] dt-bindings: leds: Add bindings for lm3697 driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20180906135005.6718-1-dmurphy@ti.com>
 <20180906211617.GB16899@amd> <b8ac9d52-f16d-5fc4-0e9a-9246b9f984c5@ti.com>
 <20180907133228.GA16297@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <70f7506c-6a3d-3830-59a4-a246dc6163f7@ti.com>
Date:   Fri, 7 Sep 2018 08:52:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907133228.GA16297@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 09/07/2018 08:32 AM, Pavel Machek wrote:
> Hi!
> 
>>>> index 000000000000..3256dec21075
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
>>>> @@ -0,0 +1,86 @@
>>>> +* Texas Instruments - LM3697 Highly Efficient White LED Driver
>>>> +
>>>> +The LM3697 11-bit LED driver provides high-
>>>> +performance backlight dimming for 1, 2, or 3 series
>>>> +LED strings while delivering up to 90% efficiency.
>>>
>>> Hmm. We already have second set of bindings for 3697:
>>>
>>> ./devicetree/bindings/mfd/ti-lmu.txt
>>>
>>> (Sorry for not noticing that earlier). Advantage is that those have
>>> had discussion with device tree people and have acks:
>>>
>>> What to do there?
>>
>> UGH!  IMO this should have not been accepted without the support code.
>> I think this MFD driver is complete over kill to try to commonize features
>> into a MFD device.  The LM3631 and LM3632 seem to be the only true MFD devices
>> here since they provide regulator support.
> 
> They are not yet in mainline; but they have Rob's acknowledges.
> 
> ...but I see there are improvements possible.
> 
>> The LM3697 fault monitoring is only for test purposes according to the data
>> sheet.  Not sure the customer can trust this or they should be warned at boot
>> that the Fault monitoring is for test purposes only.
> 
> Ok, but that's topic for the driver, not for binding, right?

Well the binding indicates that there is fault monitoring for this device.
If fault monitoring is for test only then it probably should not be
exposed in the binding

	fault-monitor {
		compatible = "ti,lm3697-fault-monitor";
	};


> 
>> And I think Jacek pointed out that the bindings references in this bindings
>> don't even exist.
>>
>> I am thinking we need to deprecate this MFD driver and consolidate these drivers
>> in the LED directory as we indicated before.  I did not find any ti-lmu support
>> code.
>>
>> ti-lmu common core code and then the LED children appending the feature differentiation.
> 
>> Need some maintainer weigh in here.
> 
> Hehe. I'm maintnainer. Fun.

I know.  I want to see if there was any other opinion.  Especially for the LED driver.

> 
> Is there something obviously wrong with
> 287cce719d85311f61d1b6b7f7b0d93f7907cd46 +
> d774c7e447ac911e73a1b3c775e6d89f0422218c ?
> 
> If not, as it already had discussion/Acks so I'd prefer that one. We
> may move it to LEDs directory if neccessary, or something like that...

Not finding d774c7e447ac911e73a1b3c775e6d89f0422218c in the tree.
I am still not in favor of this ti-lmu driver in the MFD directory.

It really does not do much.  It seems like a waste.

I will work on a new architecture and try to RFC next week.

Dan


> 
> Best regards,
> 
> 								Pavel
> 
>>> commit 287cce719d85311f61d1b6b7f7b0d93f7907cd46
>>> Author: Milo Kim <milo.kim@ti.com>
>>> Date:   Tue Feb 28 15:45:14 2017 +0900
>>>
>>>     dt-bindings: mfd: Add TI LMU device binding information
>>>
>>>     This patch describes overall binding for TI LMU MFD devices.
>>>
>>>     Signed-off-by: Milo Kim <milo.kim@ti.com>
>>>         Acked-by: Rob Herring <robh+dt@kernel.org>
>>> 	    Acked-by: Tony Lindgren <tony@atomide.com>
>>> 	        Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>> 		
>>>
>>> commit d774c7e447ac911e73a1b3c775e6d89f0422218c
>>> Author: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>>> Date:   Mon Aug 27 09:15:08 2018 -0700
>>>
>>>     dt-bindings: mfd: ti-lmu: update for backlight
>>>     
>>>     Update binding to integrate the backlight feature directly into
>>>     the main node, as suggested by Rob Herring.
>>>     
>>>     Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
>>> index c885cf8..b3433e9 100644
>>> --- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
>>> +++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
>>> @@ -28,10 +28,9 @@ Required properties:
>>>  
>>>  Optional property:
>>>    - enable-gpios: A GPIO specifier for hardware enable pin.
>>> -
>>> -Required node:
>>> -  - backlight: All LMU devices have backlight child nodes.
>>> -               For the properties, please refer to [1].
>>> +  - pwm-names: Should be either "lmu-backlight" or unset
>>> +  - pwm: This should be a PWM specifier following ../pwm/pwm.txt and must
>>> +         only be specified, if the backlight should be used in PWM mode.
>>>  
>>>  Optional nodes:
>>>    - fault-monitor: Hardware fault monitoring driver for LM3633 and LM3697.
>>> @@ -42,8 +41,31 @@ Optional nodes:
>>>    - leds: LED properties for LM3633. Please refer to [2].
>>>    - regulators: Regulator properties for LM3631 and LM3632.
>>>                  Please refer to [3].
>>> +  - bank0, bank1, bank2: This contains the backlight configuration
>>> +                         for each backlight control bank.
>>> +
>>> +Required properties in the bank subnodes:
>>> +  - label: A string describing the backlight. Should contain "keyboard"
>>> +           for a keyboard backlight and "lcd" for LCD panel backlights.
>>> +  - ti,led-sources: A list of channels, that should be driven. Each channel
>>> +                    should only be driven by one bank.
>>> +
>>> +Optional properties in the bank subnodes:
>>> +  - default-brightness-level: Backlight initial brightness value.
>>> +                              Type is <u32>. It is set as soon as backlight
>>> +			      device is created.
>>> +			      0 ~ 2047 = LM3631, LM3632, LM3633, LM3695 and
>>> +					 LM3697
>>> +			      0 ~ 255  = LM3532
>>> +  - ti,ramp-up-ms, ti,ramp-down-ms: Light dimming effect properties.
>>> +				    Type is <u32>. Unit is millisecond.
>>> +					0 ~ 65 ms    = LM3532
>>> +					0 ~ 4000 ms  = LM3631
>>> +					0 ~ 16000 ms = LM3633 and LM3697
>>> +  - pwm-period: PWM period. Only valid in PWM brightness mode.
>>> +                Type is <u32>. If this property is missing, then control
>>> +		mode is set to I2C by default.
>>>  
>>> -[1] ../leds/backlight/ti-lmu-backlight.txt
>>>  [2] ../leds/leds-lm3633.txt
>>>  [3] ../regulator/lm363x-regulator.txt
>>>  
>>> @@ -53,14 +75,11 @@ lm3532@38 {
>>>  
>>>  	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
>>>  
>>> -	backlight {
>>> -		compatible = "ti,lm3532-backlight";
>>> -
>>> -		lcd {
>>> -			led-sources = <0 1 2>;
>>> -			ramp-up-msec = <30>;
>>> -			ramp-down-msec = <0>;
>>> -		};
>>> +	bank0 {
>>> +		label = "lcd";
>>> +		led-sources = <0 1 2>;
>>> +		ramp-up-msec = <30>;
>>> +		ramp-down-msec = <0>;
>>>  	};
>>>  };
>>>  
>>> @@ -105,13 +124,10 @@ lm3631@29 {
>>>  		};
>>>  	};
>>>  
>>> -	backlight {
>>> -		compatible = "ti,lm3631-backlight";
>>> -
>>> -		lcd_bl {
>>> -			led-sources = <0 1>;
>>> -			ramp-up-msec = <300>;
>>> -		};
>>> +	bank0 {
>>> +		label = "lcd_bl";
>>> +		led-sources = <0 1>;
>>> +		ramp-up-msec = <300>;
>>>  	};
>>>  };
>>>  
>>> @@ -147,16 +163,13 @@ lm3632@11 {
>>>  		};
>>>  	};
>>>  
>>> -	backlight {
>>> -		compatible = "ti,lm3632-backlight";
>>> -
>>> -		pwms = <&pwm0 0 10000 0>; /* pwm number, period, polarity */
>>> -		pwm-names = "lmu-backlight";
>>> +	pwms = <&pwm0 0 10000 0>; /* pwm number, period, polarity */
>>> +	pwm-names = "lmu-backlight";
>>>  
>>> -		lcd {
>>> -			led-sources = <0 1>;
>>> -			pwm-period = <10000>;
>>> -		};
>>> +	bank0 {
>>> +		label = "lcd";
>>> +		led-sources = <0 1>;
>>> +		pwm-period = <10000>;
>>>  	};
>>>  };
>>>  
>>> @@ -166,22 +179,18 @@ lm3633@36 {
>>>  
>>>  	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
>>>  
>>> -	backlight {
>>> -		compatible = "ti,lm3633-backlight";
>>> -
>>> -		main {
>>> -			label = "main_lcd";
>>> -			led-sources = <1 2>;
>>> -			ramp-up-msec = <500>;
>>> -			ramp-down-msec = <500>;
>>> -		};
>>> +	bank0 {
>>> +		label = "main_lcd";
>>> +		led-sources = <1 2>;
>>> +		ramp-up-msec = <500>;
>>> +		ramp-down-msec = <500>;
>>> +	};
>>>  
>>> -		front {
>>> -			label = "front_lcd";
>>> -			led-sources = <0>;
>>> -			ramp-up-msec = <1000>;
>>> -			ramp-down-msec = <0>;
>>> -		};
>>> +	bank1 {
>>> +		label = "front_lcd";
>>> +		led-sources = <0>;
>>> +		ramp-up-msec = <1000>;
>>> +		ramp-down-msec = <0>;
>>>  	};
>>>  
>>>  	leds {
>>> @@ -211,13 +220,9 @@ lm3695@63 {
>>>  
>>>  	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
>>>  
>>> -	backlight {
>>> -		compatible = "ti,lm3695-backlight";
>>> -
>>> -		lcd {
>>> -			label = "bl";
>>> -			led-sources = <0 1>;
>>> -		};
>>> +	bank0 {
>>> +		label = "lcd_bl";
>>> +		led-sources = <0 1>;
>>>  	};
>>>  };
>>>  
>>> @@ -227,14 +232,10 @@ lm3697@36 {
>>>  
>>>  	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
>>>  
>>> -	backlight {
>>> -		compatible = "ti,lm3697-backlight";
>>> -
>>> -		lcd {
>>> -			led-sources = <0 1 2>;
>>> -			ramp-up-msec = <200>;
>>> -			ramp-down-msec = <200>;
>>> -		};
>>> +	bank0 {
>>> +		led-sources = <0 1 2>;
>>> +		ramp-up-msec = <200>;
>>> +		ramp-down-msec = <200>;
>>>  	};
>>>  
>>>  	fault-monitor {
>>>
>>
>>
> 


-- 
------------------
Dan Murphy
