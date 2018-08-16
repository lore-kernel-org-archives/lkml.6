Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B846C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DDC2147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TKwbpiDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DDC2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbeHPVnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:43:40 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54812 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeHPVnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:43:39 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7GIhQUb050942;
        Thu, 16 Aug 2018 13:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1534445006;
        bh=uO4/h/n1JD/Vh1aNdFNOvckW59ctw8pZ1uHp684kGGM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TKwbpiDehJRkTipGByEbICrWVjavNI/r/yAzt6KFZ303lrHeN/hK+xY3l4HoGuD9w
         4hvMjG4NjmvTBTN6183/3Cnl3TV05uqOcPHpq9y7/jVZLP0icb7/dbNoDlhZ5bgtkg
         x2+AVrWSIy2WUNxWnwegf1+R66utN9cNt727gYwQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7GIhQ4I016373;
        Thu, 16 Aug 2018 13:43:26 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 16
 Aug 2018 13:43:26 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 16 Aug 2018 13:43:26 -0500
Received: from [172.22.174.92] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7GIhQG1013754;
        Thu, 16 Aug 2018 13:43:26 -0500
Subject: Re: [PATCH v4 1/2] dt-bindings: leds: Add bindings for lm3697 driver
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <robh+dt@kernel.org>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20180816172058.31700-1-dmurphy@ti.com>
 <aecaa2ff-e75c-2059-684a-908aedc20929@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <0c91fe1f-8ab4-8092-b8c2-a22f89f4b8ea@ti.com>
Date:   Thu, 16 Aug 2018 13:43:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <aecaa2ff-e75c-2059-684a-908aedc20929@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 08/16/2018 01:37 PM, Jacek Anaszewski wrote:
> Hi Dan,
> 
> Thanks for the update.
> 
> I have one remark below.
> 
> On 08/16/2018 07:20 PM, Dan Murphy wrote:
>> Add the device tree bindings for the lm3697
>> LED driver for backlighting and display.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>
>> v4 - Removed HVLED definition in favor of HVLED place definition - https://lore.kernel.org/patchwork/patch/974812/
>> v3 - Updated subject with prefered title - https://lore.kernel.org/patchwork/patch/972337/
>> v2 - Fixed subject and patch commit message - https://lore.kernel.org/patchwork/patch/971326/
>>
>>  .../devicetree/bindings/leds/leds-lm3697.txt  | 86 +++++++++++++++++++
>>  1 file changed, 86 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3697.txt b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
>> new file mode 100644
>> index 000000000000..bcd67d53c889
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
>> @@ -0,0 +1,86 @@
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
>> +	- led-sources : Indicates which HVLED string is associated to which
>> +			control bank.  Each element in the array is associated
>> +			with a specific HVLED string.  Element 0 is HVLED1,
>> +			element 1 is HVLED2 and element 2 HVLED3.
>> +			Additional information is contained
>> +			in Documentation/devicetree/bindings/leds/common.txt
>> +			0 - HVLED is not active in this control bank
>> +			1 - HVLED string is controlled by this control bank
>> +
>> +Optional child properties:
>> +	- label : see Documentation/devicetree/bindings/leds/common.txt
>> +	- linux,default-trigger :
>> +	   see Documentation/devicetree/bindings/leds/common.txt
>> +
>> +Example:
>> +
>> +HVLED string 1 and 2 controlled by control bank A and HVLED string controlled by
> 
> s/1 and 2/1 and 3/
> s/HVLED string controller/HVLED string 2 controlled/
> 

Thanks I will fix this up in v5 after the code review.

Dan

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
>> +		led-sources = <1 0 1>;
>> +		label = "white:first_backlight_cluster";
>> +		linux,default-trigger = "backlight";
>> +	};
>> +
>> +	led@1 {
>> +		reg = <1>;
>> +		led-sources = <0 1 0>;
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
>> +		led-sources = <1 1 1>;
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
