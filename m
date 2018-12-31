Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30F6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5E62073F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k5v22ypV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeLaSy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 13:54:29 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46210 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeLaSy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 13:54:28 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBVIsLp0003630;
        Mon, 31 Dec 2018 12:54:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546282462;
        bh=0tzeQxn3VzMeTkXtw2ASerrnRQStZJOHysmL3+sacaY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=k5v22ypVHT+UTpXAQJ4kAKn0rwb7/4ax2EIHzcYb9HBJog6v0alWdKwCYVFV0h8Qa
         n2iSZ5Ze1ggaFE84N8SJXoE8osd6iLeSc+iwsYJtziXi+tB5iUhlVSpha73ArWqE/X
         +iRH20pGyr7RsWXMP2Zy1SiPnbbim6z4kYTCl9Og=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBVIsLnE065361
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Dec 2018 12:54:21 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 31
 Dec 2018 12:54:21 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 31 Dec 2018 12:54:21 -0600
Received: from [172.22.106.176] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBVIsLHt019506;
        Mon, 31 Dec 2018 12:54:21 -0600
Subject: Re: [PATCH 1/2] dt: bindings: lp5024: Introduce the lp5024 and lp5018
 RGB driver
To:     Rob Herring <robh@kernel.org>
CC:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20181219162626.12297-2-dmurphy@ti.com> <20181228235333.GA13949@bogus>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <79f94c3b-046f-13d6-c304-85849e2324d4@ti.com>
Date:   Mon, 31 Dec 2018 12:54:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181228235333.GA13949@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob

On 12/28/18 5:53 PM, Rob Herring wrote:
> On Wed, Dec 19, 2018 at 10:26:25AM -0600, Dan Murphy wrote:
>> Introduce the bindings for the Texas Instruments LP5024 and the LP5018
>> RGB LED device driver.  The LP5024/18 can control RGB LEDs individually
>> or as part of a control bank group.  These devices have the ability
>> to adjust the mixing control for the RGB LEDs to obtain different colors
>> independent of the overall brightness of the LED grouping.
>>
>> Datasheet:
>> http://www.ti.com/lit/ds/symlink/lp5024.pdf
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>  .../devicetree/bindings/leds/leds-lp5024.txt  | 63 +++++++++++++++++++
>>  1 file changed, 63 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lp5024.txt
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-lp5024.txt b/Documentation/devicetree/bindings/leds/leds-lp5024.txt
>> new file mode 100644
>> index 000000000000..9567aa6f7813
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/leds-lp5024.txt
>> @@ -0,0 +1,63 @@
>> +* Texas Instruments - LP5024/18 RGB LED driver
>> +
>> +The LM3692x is an ultra-compact, highly efficient,
>> +white-LED driver designed for LCD display backlighting.
> 
> Leftover copy-n-paste?
> 

ACK
I have this updated for v2.

>> +
>> +The main difference between the LP5024 and L5018 is the number of
>> +RGB LEDs they support.  The LP5024 supports twenty four strings while the
>> +LP5018 supports eighteen strings.
>> +
>> +Required properties:
>> +	- compatible:
>> +		"ti,lp5018"
>> +		"ti,lp5024"
>> +	- reg :  I2C slave address
>> +	- #address-cells : 1
>> +	- #size-cells : 0
>> +
>> +Optional properties:
>> +	- enable-gpios : gpio pin to enable/disable the device.
>> +	- vled-supply : LED supply
>> +
>> +Required child properties:
>> +	- reg : Is the child node iteration.
>> +	- led-sources : LP5024 - 0 - 7
>> +			LP5018 - 0 - 5
>> +			Declares the LED string or strings that the child node
>> +			will control.  If ti,control-bank is set then this
>> +			property will contain multiple LED IDs.
>> +
>> +Optional child properties:
>> +	- label : see Documentation/devicetree/bindings/leds/common.txt
>> +	- linux,default-trigger :
>> +	   see Documentation/devicetree/bindings/leds/common.txt
>> +	- ti,control-bank : Indicates that the LED strings declared in the
>> +			    led-sources property are grouped within a control
>> +			    bank for brightness and mixing control.
>> +
>> +Example:
>> +
>> +led-controller@28 {
>> +	compatible = "ti,lp5024";
>> +	reg = <0x28>;
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
>> +	vled-supply = <&vbatt>;
>> +
>> +	led@0 {
>> +		reg = <0>;
>> +		led-sources = <1>;
>> +	};
>> +
>> +	led@1 {
>> +		reg = <1>;
>> +		led-sources = <0 6>;
>> +		ti,control-bank;
>> +	};
>> +
>> +}
>> +
>> +For more product information please see the link below:
>> +http://www.ti.com/lit/ds/symlink/lp5024.pdf
>> -- 
>> 2.20.0.rc2.7.g965798d1f2
>>


-- 
------------------
Dan Murphy
