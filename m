Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B12C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAD7208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Wf9UnIP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FAD7208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbeHOUXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:23:38 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33660 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeHOUXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:23:38 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7FHURJP007046;
        Wed, 15 Aug 2018 12:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1534354228;
        bh=/fx+aQiATWpEiYgLbQl0HmnzLPZq/vzL+p45hhzX3mA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Wf9UnIP3olQI/4OIa5DM0rQFdbhMLKW7n42y+UhIIRMFG/7ec29fUQP7pNKhTuhd7
         l7rRPBpaHcycfokAVk4ZpLB/IY7HeuCGUjfE+j1pnzpmzaMPpUery8cABjz3C3DpVy
         cXVBnKHzoEjdeEHtP5J0tAhZXxRz2gLOr2sPeSqQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7FHUREN020481;
        Wed, 15 Aug 2018 12:30:27 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 15
 Aug 2018 12:30:27 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 15 Aug 2018 12:30:27 -0500
Received: from [172.22.176.241] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7FHUR4w022895;
        Wed, 15 Aug 2018 12:30:27 -0500
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: Add bindings for lm3697 driver
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <robh+dt@kernel.org>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20180815161734.18159-1-dmurphy@ti.com>
 <e278d4f2-7848-d156-01ec-3cd77803e4de@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e855cda3-4314-645c-f6b9-a86aceafbd0b@ti.com>
Date:   Wed, 15 Aug 2018 12:30:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e278d4f2-7848-d156-01ec-3cd77803e4de@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 08/15/2018 11:56 AM, Jacek Anaszewski wrote:
> Hi Dan,
> 
> Thank you for the update.
> 
> On 08/15/2018 06:17 PM, Dan Murphy wrote:
>> Add the device tree bindings for the lm3697
>> LED driver for backlighting and display.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>
>> v3 - Updated subject with prefered title - https://lore.kernel.org/patchwork/patch/972337/
>> v2 - Fixed subject and patch commit message - https://lore.kernel.org/patchwork/patch/971326/
>>
>>  .../devicetree/bindings/leds/leds-lm3697.txt  | 89 +++++++++++++++++++
>>  1 file changed, 89 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3697.txt b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
>> new file mode 100644
>> index 000000000000..34403a48a0ce
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
>> @@ -0,0 +1,89 @@
>> +* Texas Instruments - LM3697 Highly Efficient White LED Driver
>> +
>> +The LM3697 11-bit LED driver provides high-
>> +performance backlight dimming for 1, 2, or 3 series
>> +LED strings while delivering up to 90% efficiency.
>> +
>> +This device is suitable for Display and Keypad Lighting
>> +
>> +Required properties:
>> +	- compatible:
>> +		"ti,lm3967"
>> +	- reg :  I2C slave address
>> +	- #address-cells : 1
>> +	- #size-cells : 0
>> +
>> +Optional properties:
>> +	- enable-gpios : gpio pin to enable/disable the device.
>> +	- vled-supply : LED supply
>> +
>> +Required child properties:
>> +	- reg : 0 - LED is Controlled by bank A
>> +		1 - LED is Controlled by bank B
>> +	- led-sources - Indicates which HVLED string is associated to which
>> +			control bank.  The HVLED string cannot be associated with
>> +			two control banks.  This property is an array of 3 and
>> +			all positions in the array must be populated.
>> +			Additional information is contained
>> +			in Documentation/devicetree/bindings/leds/common.txt
>> +			0 - End of array if all 3 LEDs are not declared for a
>> +			    single control bank.
> 
> This is needless complication. I propose to define led-sources as
> an array of three boolean values, whose state signifies which LED
> strings are controlled by the bank defined by the reg property in the
> given child node. I.e. <HVLED1 HVLED2 HVLED3>.

I struggled a bit with this definition.  Once I got it working it ended up producing
an overly complex control bank algorithm.

I will take a look at implementing the suggestion but the complication comes in the
numerous DT configurations we could encounter.  Part of the issue is that the user
can connect to CTRL bank b only or CTRL bank a only or a combination of that

2^3

Dan

> 
> I modified your examples below accordingly.
> 
>> +			1 - HVLED 1 string
>> +			2 - HVLED 2 string
>> +			3 - HVLED 3 string
>> +
>> +Optional child properties:
>> +	- label : see Documentation/devicetree/bindings/leds/common.txt
>> +	- linux,default-trigger :
>> +	   see Documentation/devicetree/bindings/leds/common.txt
>> +
>> +Example:
>> +
>> +HVLED string 1 and 2 controlled by control bank A and HVLED string controlled by
>> +control bank B.
>> +
>> +led-controller@36 {
>> +	compatible = "ti,lm3967";
>> +	reg = <0x36>;
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>> +	vled-supply = <&vbatt>;
>> +
>> +	led@0 {
>> +		reg = <0>;
>> +		led-sources = <0x1 0x2 0x0>
> 
> 		led-sources = <1 1 0>;
> ;
>> +		label = "white:first_backlight_cluster";
>> +		linux,default-trigger = "backlight";
>> +	};
>> +
>> +	led@1 {
>> +		reg = <1>;
>> +		led-sources = <0x3 0x0 0x0>;
> 
> 		led-sources = <0 0 1>;
> 
>> +		label = "white:second_backlight_cluster";
>> +		linux,default-trigger = "backlight";
>> +	};
>> +}
>> +
>> +All HVLED strings controlled by control bank A
>> +
>> +led-controller@36 {
>> +	compatible = "ti,lm3967";
>> +	reg = <0x36>;
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>> +	vled-supply = <&vbatt>;
>> +
>> +	led@0 {
>> +		reg = <0>;
>> +		led-sources = <0x1 0x2 0x3>;
> 
> 		led-sources = <1 1 1>;
> 
>> +		label = "white:backlight_cluster";
>> +		linux,default-trigger = "backlight";
>> +	};
>> +}
>> +
>> +For more product information please see the link below:
>> +http://www.ti.com/lit/ds/symlink/lm3697.pdf
>>
> 


-- 
------------------
Dan Murphy
