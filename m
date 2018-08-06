Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0906C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9B121A50
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PtehXRQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9B121A50
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732870AbeHFRmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:42:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45392 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbeHFRmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:42:09 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w76FWTFG111166;
        Mon, 6 Aug 2018 10:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533569549;
        bh=j+Ljk71wv6vcXaxDBCvkRGjMSYVGwhga86ETZOmhGUg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PtehXRQskFHDBTEGUPuTf848o1lcUhApFoScV2/ZVEzfkUOvw+FuZShC67Bl7fWjG
         ZbhCH8XB0E1X2diAuP2Y8UVOU5AaWbCfVQ8wmkm2FZ0pDMNMKSqXZJzZm4iHi1OEtW
         rozHL/k34Pz3MYeRbmsnWK6YVRsLuObszQLi1aR4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w76FWTYd016996;
        Mon, 6 Aug 2018 10:32:29 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 6 Aug
 2018 10:32:28 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 6 Aug 2018 10:32:29 -0500
Received: from [172.22.132.64] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w76FWSKa028732;
        Mon, 6 Aug 2018 10:32:28 -0500
Subject: Re: [PATCH 1/2] di: bindings: lm3697: Introduce the lm3697 driver
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20180803150231.7172-1-dmurphy@ti.com>
 <b22bf013-f83c-12c1-90e5-8b0dc4145834@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <044e6bb0-cdd0-a87f-05e8-4f56965c5fad@ti.com>
Date:   Mon, 6 Aug 2018 10:32:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b22bf013-f83c-12c1-90e5-8b0dc4145834@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

Thanks for the review

On 08/04/2018 07:22 AM, Jacek Anaszewski wrote:
> Hi Dan,
> 
> Thank you for the patch.
> 
> Typo in the patch title:
> 
> s/di: /dt-/
> 
> And maybe let's change the following text to:
> 
> "Add bindings for lm3697 LED driver"

Ack to the above.

> 
> Best regards,
> Jacek Anaszewski
> 
> On 08/03/2018 05:02 PM, Dan Murphy wrote:
>> Introduce the device tree bindings for the lm3697
>> led driver for backlighting and display.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
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
>> +
>> +Optional properties:
>> +	- enable-gpios : gpio pin to enable/disable the device.
>> +	- vled-supply : LED supply
>> +
>> +Required child properties:
>> +	- reg : 0 - LED is Controlled by bank A
>> +		1 - LED is Controlled by bank B
>> +
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
>> +
>> +For more product information please see the link below:
>> +http://www.ti.com/lit/ds/symlink/lm3697.pdf
>>


-- 
------------------
Dan Murphy
