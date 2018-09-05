Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610AEC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139192075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UuP7SJIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139192075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeIEWxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:53:09 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41118 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeIEWxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:53:09 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w85ILjt6051832;
        Wed, 5 Sep 2018 13:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536171705;
        bh=3ZhCp9cHQ7DgfNDjiUyv9kjziR8fmXt1AcxDL8/wmOA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UuP7SJIl9xnUQyj8kfuFgs2gh2IIcJG+SuIZw88rxYJJf/6O94mttcaCtrbgXn1Og
         HDi5/QkFWf4S8kQ/Soz6kj9MEDg/qqC6IopSCBCCvqPUGs03b63kIes6XXYXNExU1W
         DlIEe3EIg1JGkviUJ9y70I7rgo8Wgd3IyoDm33jQ=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w85ILjKi001595;
        Wed, 5 Sep 2018 13:21:45 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 5 Sep
 2018 13:21:45 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 5 Sep 2018 13:21:45 -0500
Received: from [172.22.166.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w85ILi06017428;
        Wed, 5 Sep 2018 13:21:45 -0500
Subject: Re: [PATCH v5 1/2] dt-bindings: leds: Add bindings for lm3697 driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20180817151528.21623-1-dmurphy@ti.com>
 <20180824095515.GB4045@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <01a8f463-67c9-740c-5001-ac63e4a3dc4e@ti.com>
Date:   Wed, 5 Sep 2018 13:21:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824095515.GB4045@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 08/24/2018 04:55 AM, Pavel Machek wrote:
> On Fri 2018-08-17 10:15:27, Dan Murphy wrote:
>> Add the device tree bindings for the lm3697
>> LED driver for backlighting and display.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> Some nits are below.
> 
>> +The LM3697 11-bit LED driver provides high-
>> +performance backlight dimming for 1, 2, or 3 series
>> +LED strings while delivering up to 90% efficiency.
> 
> LED core is 8-bit only... so full dynamic range can not be currently
> used in linux -- right? Is there any plan to change/fix that?
> 

Jacek answered this.

>> +This device is suitable for Display and Keypad Lighting
> 
> "display and keypad lighting."
> 

Ack

>> +Optional properties:
>> +	- enable-gpios : gpio pin to enable/disable the device.
> 
> Remove "." at end of sentence, for consistency. "GPIO"?
> 
>> +All HVLED strings controlled by control bank A
> 
> ":"?

Not sure what you are asking for here.

> 
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
> 


-- 
------------------
Dan Murphy
