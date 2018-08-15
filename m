Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D68C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020DE208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJPammh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020DE208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeHOVCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:02:37 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38008 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeHOVCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:02:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id t25-v6so2071118wmi.3;
        Wed, 15 Aug 2018 11:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Oz8MWi4Ol2zKOmLjc2IK84RBK9xzSlNksSaIffpt+Oc=;
        b=JJPammh+g/wCGdzZUZ1+VcvlRsc1rbCfgNKhiXPDdVRoH/tiKBvOTjunac2AgwArku
         L8wKR7RUk1yh3KYhdAYBTqGx1SfNPj3unRAIk7TXmNQTTwPB0PgUtRFfNbz56pSeizoD
         wbrlY/xn9LIaWVAwGK1PJIiH8p8QXYc8DzOswcMqDPdYG3uggRAuDqCEVbGxLJX74Nu6
         8tP6YRLnucdaqWP2hSO7ssowK7wRkCgHSkBHaxjH4VddYPkmOErk8Tut0diI4qZ1+C6w
         0W2iAVfVONvDiWE/3zFwaLoZ0umHfKWecLywyreYQbpIXohpqdJrhpKGg9CbEa4/OrUj
         YaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Oz8MWi4Ol2zKOmLjc2IK84RBK9xzSlNksSaIffpt+Oc=;
        b=iCzfgZ7av9/hA8Esuh6wLQ0p4Yfn1zl4TIRrQYHm5N/IHblIYxW+SrRmYRcf+bIUvu
         z+SkuB39fxjj8SKBdfqu81e0jS6nDBuqcJ5x2700SWChWQs0tRUuc50N2o3jxUOsCpzT
         MS/lS9eJ+TDZDL5fSXUW0QXhImfqwV5DfftKhYThhIVH3NcbqN3TjnOvpbV5i12HLn4c
         LPY3ogJ1VRT7wy0TWi6HpnPTTubUNndSIFai2WGDPG19s8MjBVn6ccdkchZYGYJ+6VlH
         f0lXHFM7blO6LgYgbCYP1Rx250BKcz0jPvT3j4OOy3t/MqKHm3/guYaFWb28cSvCBGx5
         r7yg==
X-Gm-Message-State: AOUpUlHNZcrd9Bw5AxKrPvOQptbi5u3Pk81kbOn7jZA9ratMRGII42Qf
        /xNs4HSUVyeFWDcvoaMBvbN0PD6y
X-Google-Smtp-Source: AA+uWPwxdmKRyyqi6N2VYNqGAGDl/xVW7QU0Tkory+Iz3mXtwepKZ34O14EGftn2h8CaKlilR2AWAg==
X-Received: by 2002:a1c:2d54:: with SMTP id t81-v6mr14973705wmt.31.1534356562872;
        Wed, 15 Aug 2018 11:09:22 -0700 (PDT)
Received: from [192.168.1.18] (dkl176.neoplus.adsl.tpnet.pl. [83.24.15.176])
        by smtp.gmail.com with ESMTPSA id u14-v6sm25280488wrs.57.2018.08.15.11.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 11:09:22 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: Add bindings for lm3697 driver
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20180815161734.18159-1-dmurphy@ti.com>
 <e278d4f2-7848-d156-01ec-3cd77803e4de@gmail.com>
 <e855cda3-4314-645c-f6b9-a86aceafbd0b@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <77f11321-8876-2e34-f05e-dd855d62095c@gmail.com>
Date:   Wed, 15 Aug 2018 20:09:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e855cda3-4314-645c-f6b9-a86aceafbd0b@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 08/15/2018 07:30 PM, Dan Murphy wrote:
> Jacek
> 
> On 08/15/2018 11:56 AM, Jacek Anaszewski wrote:
>> Hi Dan,
>>
>> Thank you for the update.
>>
>> On 08/15/2018 06:17 PM, Dan Murphy wrote:
>>> Add the device tree bindings for the lm3697
>>> LED driver for backlighting and display.
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>>>
>>> v3 - Updated subject with prefered title - https://lore.kernel.org/patchwork/patch/972337/
>>> v2 - Fixed subject and patch commit message - https://lore.kernel.org/patchwork/patch/971326/
>>>
>>>  .../devicetree/bindings/leds/leds-lm3697.txt  | 89 +++++++++++++++++++
>>>  1 file changed, 89 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3697.txt b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
>>> new file mode 100644
>>> index 000000000000..34403a48a0ce
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
>>> @@ -0,0 +1,89 @@
>>> +* Texas Instruments - LM3697 Highly Efficient White LED Driver
>>> +
>>> +The LM3697 11-bit LED driver provides high-
>>> +performance backlight dimming for 1, 2, or 3 series
>>> +LED strings while delivering up to 90% efficiency.
>>> +
>>> +This device is suitable for Display and Keypad Lighting
>>> +
>>> +Required properties:
>>> +	- compatible:
>>> +		"ti,lm3967"
>>> +	- reg :  I2C slave address
>>> +	- #address-cells : 1
>>> +	- #size-cells : 0
>>> +
>>> +Optional properties:
>>> +	- enable-gpios : gpio pin to enable/disable the device.
>>> +	- vled-supply : LED supply
>>> +
>>> +Required child properties:
>>> +	- reg : 0 - LED is Controlled by bank A
>>> +		1 - LED is Controlled by bank B
>>> +	- led-sources - Indicates which HVLED string is associated to which
>>> +			control bank.  The HVLED string cannot be associated with
>>> +			two control banks.  This property is an array of 3 and
>>> +			all positions in the array must be populated.
>>> +			Additional information is contained
>>> +			in Documentation/devicetree/bindings/leds/common.txt
>>> +			0 - End of array if all 3 LEDs are not declared for a
>>> +			    single control bank.
>>
>> This is needless complication. I propose to define led-sources as
>> an array of three boolean values, whose state signifies which LED
>> strings are controlled by the bank defined by the reg property in the
>> given child node. I.e. <HVLED1 HVLED2 HVLED3>.
> 
> I struggled a bit with this definition.  Once I got it working it ended up producing
> an overly complex control bank algorithm.
> 
> I will take a look at implementing the suggestion but the complication comes in the
> numerous DT configurations we could encounter.  Part of the issue is that the user
> can connect to CTRL bank b only or CTRL bank a only or a combination of that
> 
> 2^3

I tried to play a bit with that and here is what I got (simplified
DT parsing):

int used_hvleds[3] = {0, 0 ,0};
int used_control_banks[2] = {0, 0};

int parse_child_node(struct fwnode_handle *child)
{
	int bank_hvleds[3];

	fwnode_property_read_u32_array(child, "led-sources",
		bank_hvleds, LM3697_MAX_LED_STRINGS);

	for (i = 0; i <= 3; i++) {
		if (bank_hvleds[i] && used_hvleds[i])
			return -EINVAL;
		used_hvleds[i] = 1;
	}

	return 0;
}

struct fwnode_handle *child = NULL;

device_for_each_child_node(priv->dev, child)
	fwnode_property_read_u32(child, "reg", &control_bank);
	if (used_control_banks[control_bank])
		goto err;
	used_control_banks[control_bank] = 1;
	if (parse_child_node(child))
		goto err;


>>
>> I modified your examples below accordingly.
>>
>>> +			1 - HVLED 1 string
>>> +			2 - HVLED 2 string
>>> +			3 - HVLED 3 string
>>> +
>>> +Optional child properties:
>>> +	- label : see Documentation/devicetree/bindings/leds/common.txt
>>> +	- linux,default-trigger :
>>> +	   see Documentation/devicetree/bindings/leds/common.txt
>>> +
>>> +Example:
>>> +
>>> +HVLED string 1 and 2 controlled by control bank A and HVLED string controlled by
>>> +control bank B.
>>> +
>>> +led-controller@36 {
>>> +	compatible = "ti,lm3967";
>>> +	reg = <0x36>;
>>> +	#address-cells = <1>;
>>> +	#size-cells = <0>;
>>> +
>>> +	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>>> +	vled-supply = <&vbatt>;
>>> +
>>> +	led@0 {
>>> +		reg = <0>;
>>> +		led-sources = <0x1 0x2 0x0>
>>
>> 		led-sources = <1 1 0>;
>> ;
>>> +		label = "white:first_backlight_cluster";
>>> +		linux,default-trigger = "backlight";
>>> +	};
>>> +
>>> +	led@1 {
>>> +		reg = <1>;
>>> +		led-sources = <0x3 0x0 0x0>;
>>
>> 		led-sources = <0 0 1>;
>>
>>> +		label = "white:second_backlight_cluster";
>>> +		linux,default-trigger = "backlight";
>>> +	};
>>> +}
>>> +
>>> +All HVLED strings controlled by control bank A
>>> +
>>> +led-controller@36 {
>>> +	compatible = "ti,lm3967";
>>> +	reg = <0x36>;
>>> +	#address-cells = <1>;
>>> +	#size-cells = <0>;
>>> +
>>> +	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>>> +	vled-supply = <&vbatt>;
>>> +
>>> +	led@0 {
>>> +		reg = <0>;
>>> +		led-sources = <0x1 0x2 0x3>;
>>
>> 		led-sources = <1 1 1>;
>>
>>> +		label = "white:backlight_cluster";
>>> +		linux,default-trigger = "backlight";
>>> +	};
>>> +}
>>> +
>>> +For more product information please see the link below:
>>> +http://www.ti.com/lit/ds/symlink/lm3697.pdf
>>>
>>
> 
> 

-- 
Best regards,
Jacek Anaszewski
