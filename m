Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ADAECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3ED621486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mOUG2pTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3ED621486
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeJSTxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 15:53:39 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44016 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeJSTxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 15:53:38 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9JBlnFL054532;
        Fri, 19 Oct 2018 06:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539949670;
        bh=IKiJbUh/xxigwHfiLYtgyespnDsWOnrhaC06V7DQeQs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mOUG2pTvpLMxRvDq7hJ8hJDo2ASW4EHb+4VsCZIosBLucLAZ+miPdWdHnaByu5RES
         CSJIIntaZUEis8b60Wx4u08lr0HcWDcSiBtuELllJA/9QeSYisLPPaCEeOP4+hlXIn
         st05ABbmhOcKlMzxbXlrFbHmALb09R864089yDnM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9JBlneY015601;
        Fri, 19 Oct 2018 06:47:49 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 19
 Oct 2018 06:47:49 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 19 Oct 2018 06:47:49 -0500
Received: from [172.22.151.114] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9JBlnBZ019993;
        Fri, 19 Oct 2018 06:47:49 -0500
Subject: Re: [PATCH v3 4/9] dt-bindings: leds: Add bindings for lm3697 driver
To:     Rob Herring <robh@kernel.org>
CC:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <lee.jones@linaro.org>, <tony@atomide.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20181011165123.32198-1-dmurphy@ti.com>
 <20181011165123.32198-5-dmurphy@ti.com> <20181012162702.GA5672@bogus>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <3b96b65f-edd6-aa13-9f47-cdc58eac6c9d@ti.com>
Date:   Fri, 19 Oct 2018 06:47:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012162702.GA5672@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob

Thanks for the review.

On 10/12/2018 11:27 AM, Rob Herring wrote:
> On Thu, Oct 11, 2018 at 11:51:18AM -0500, Dan Murphy wrote:
>> Add the device tree bindings for the lm3697
>> LED driver for backlighting and display.
> 
> Bindings are for h/w, not drivers...
> 

ACK

Dan
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>  .../devicetree/bindings/leds/leds-lm3697.txt  | 98 +++++++++++++++++++
>>  1 file changed, 98 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3697.txt b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
>> new file mode 100644
>> index 000000000000..4bb2ed51025b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
>> @@ -0,0 +1,98 @@
>> +* Texas Instruments - LM3697 Highly Efficient White LED Driver
>> +
>> +The LM3697 11-bit LED driver provides high-
>> +performance backlight dimming for 1, 2, or 3 series
>> +LED strings while delivering up to 90% efficiency.
>> +
>> +This device is suitable for display and keypad Lighting
>> +
>> +Required properties:
>> +	- compatible:
>> +		"ti,lm3697"
>> +	- reg :  I2C slave address
>> +	- #address-cells : 1
>> +	- #size-cells : 0
>> +
>> +Optional properties:
>> +	- enable-gpios : GPIO pin to enable/disable the device
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
>> +	- runtime-ramp-up-msec: Current ramping from one brightness level to
>> +				the a higher brightness level.
>> +				Range from 2048 us - 117.44 s
>> +	- runtime-ramp-down-msec: Current ramping from one brightness level to
>> +				  the a lower brightness level.
>> +				  Range from 2048 us - 117.44 s
>> +	- label : see Documentation/devicetree/bindings/leds/common.txt
>> +	- linux,default-trigger :
>> +	   see Documentation/devicetree/bindings/leds/common.txt
>> +
>> +Example:
>> +
>> +HVLED string 1 and 3 are controlled by control bank A and HVLED 2 string is
>> +controlled by control bank B.
>> +
>> +led-controller@36 {
>> +	compatible = "ti,lm3697";
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
>> +		runtime-ramp-up-msec = <5000>;
>> +		runtime-ramp-down-msec = <1000>;
>> +		label = "white:first_backlight_cluster";
>> +		linux,default-trigger = "backlight";
>> +	};
>> +
>> +	led@1 {
>> +		reg = <1>;
>> +		led-sources = <0 1 0>;
>> +		runtime-ramp-up-msec = <500>;
>> +		runtime-ramp-down-msec = <1000>;
>> +		label = "white:second_backlight_cluster";
>> +		linux,default-trigger = "backlight";
>> +	};
>> +}
>> +
>> +All HVLED strings controlled by control bank A
>> +
>> +led-controller@36 {
>> +	compatible = "ti,lm3697";
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
>> +		runtime-ramp-up-msec = <500>;
>> +		runtime-ramp-down-msec = <1000>;
>> +		label = "white:backlight_cluster";
>> +		linux,default-trigger = "backlight";
>> +	};
>> +}
>> +
>> +For more product information please see the link below:
>> +http://www.ti.com/lit/ds/symlink/lm3697.pdf
>> -- 
>> 2.19.0
>>


-- 
------------------
Dan Murphy
