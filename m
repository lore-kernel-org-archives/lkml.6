Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06630C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BC621A13
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D6F+A1Zv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BC621A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbeHHXEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:04:23 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58842 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHHXEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:04:23 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w78KgudT004232;
        Wed, 8 Aug 2018 15:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533760976;
        bh=LCRw/yvHorbL2CCCMrR7szqDJWTZ/DVI7kunGJa6SMg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=D6F+A1ZvZTe46xgGAH4JRPwHjerIMo60LqJiFSDoNOpjwB1yNHM0LAHj5s+uV4EWf
         t1xJp532kYF6UJnxMihRFrbExqQQwylYXHqpxrBDuuTiqNVHjcHUafPa7EpZAUKsfd
         t/xRgbVdgS6Gy8APekZd/awWoUr7FOibMwxsoKD4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w78KguDK031972;
        Wed, 8 Aug 2018 15:42:56 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 8 Aug
 2018 15:42:55 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 8 Aug 2018 15:42:55 -0500
Received: from [172.22.156.167] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w78Kgtpg012974;
        Wed, 8 Aug 2018 15:42:55 -0500
Subject: Re: [PATCH v2 1/2] dt: bindings: lm3697: Add bindings for lm3697
 driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20180807160442.8937-1-dmurphy@ti.com>
 <20180808195903.GB20912@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <f6b3534b-2ee9-782e-35e5-e103c34528bc@ti.com>
Date:   Wed, 8 Aug 2018 15:42:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180808195903.GB20912@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

Thanks for the review

On 08/08/2018 02:59 PM, Pavel Machek wrote:
> On Tue 2018-08-07 11:04:41, Dan Murphy wrote:
>> Add the device tree bindings for the lm3697
>> led driver for backlighting and display.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>
>> v2 - Fixed subject and patch commit message - https://lore.kernel.org/patchwork/patch/971326/
>>
>>  .../devicetree/bindings/leds/leds-lm3697.txt  | 64 +++++++++++++++++++
>>  1 file changed, 64 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3697.txt b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
>> new file mode 100644
>> index 000000000000..7b8e490f1ea1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
>> @@ -0,0 +1,64 @@
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
>> +	- control-bank-cfg - : Indicates which sink is connected to which control bank
>> +		0 - All HVLED outputs are controlled by bank A
>> +		1 - HVLED1 is controlled bank B, HVLED2/3 are controlled by bank A
>> +		2 - HVLED2 is controlled bank B, HVLED1/3 are controlled by bank A
>> +		3 - HVLED1/2 are controlled by bank B, HVLED3 is controlled by bank A
>> +		4 - HVLED3 is controlled by bank B, HVLED1/2 are controlled by bank A
>> +		5 - HVLED1/3 is controlled by bank B, HVLED2 is controlled by bank A
>> +		6 - (default) HVLED1 is controlled by bank A, HVLED2/3 are controlled by bank B
>> +		7 - All HVLED outputs are controlled by bank B
> 
> This is quite long way to describe a bitmask, no? Could we make
> it so that control-bank-cfg is not needed?

The problem we have here is there is a potential to control
3 different LED string but only 2 sinks.  So control bank A can control 2 LED strings and control
bank b can control 1 LED string.  

These values represent device level control and configuration of the LED strings to a specific control bank.

I racked my brain trying to figure out how to configure the control banks and associated LED strings.
These values are for the device configuration itself and the reg below indicates which control bank the LED
node is assigned to.

> 
>> +Optional properties:
>> +	- enable-gpios : gpio pin to enable/disable the device.
>> +	- vled-supply : LED supply
>> +
>> +Required child properties:
>> +	- reg : 0 - LED is Controlled by bank A
>> +		1 - LED is Controlled by bank B
> 
> Can we compute control-bank-cfg from this?

Don't see how you could compute this.  There is no easy way to give indication to the driver which LED
node belongs to which control bank.  The control-bank-cfg is a device level property and the reg under the
child is a LED string level property denoting the Class node to control bank mapping.

Furthermore there are 2 device configurations that can be configured to only use 1 bank for all 3 LED strings.
This will be answered in your comments in the code.

> 
>> +Optional child properties:
>> +	- label : see Documentation/devicetree/bindings/leds/common.txt
>> +	- linux,default-trigger :
>> +	   see Documentation/devicetree/bindings/leds/common.txt
>> +
>> +Example:
>> +
>> +led-controller@36 {
>> +	compatible = "ti,lm3967";
>> +	reg = <0x36>;
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>> +	vled-supply = <&vbatt>;
>> +	control-bank-cfg = <0>;
>> +
>> +	led@0 {
>> +		reg = <0>;
>> +		label = "white:first_backlight_cluster";
>> +		linux,default-trigger = "backlight";
>> +	};
>> +
>> +	led@1 {
>> +		reg = <1>;
>> +		label = "white:second_backlight_cluster";
>> +		linux,default-trigger = "frontlight";
>> +	};
>> +}
> 
> Does the example show correct config? AFAICT all controls go to bank
> A according to control-bank-cfg, yet led@1 describes bank B...

This I can fix it should be a value between 1 and 6

> 
> 									Pavel
> 


-- 
------------------
Dan Murphy
