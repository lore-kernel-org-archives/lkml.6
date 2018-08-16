Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F051AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A5D20C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly2k2RBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A5D20C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbeHPVhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:37:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43270 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbeHPVht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:37:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id b15-v6so4987781wrv.10;
        Thu, 16 Aug 2018 11:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ko94EtcnTTFWdT8rbBTWfqin0PckBNI75sE9SICxMmY=;
        b=ly2k2RBW5WQXbmKDZlX7Yo18qWtE+UiAdG3IT85IDH4iIuY+3ERpTRuSELcTYS63Yi
         BCXPucV7S8s8xkvVALyXmm5uHdZ8MWHMhDNDUrFle6dmGdmJt7GGMXwPB0d9/hNbZfwV
         Oc2AvNnjw+itngySRhHsbBeth/M4LBmMmNOLD5YK/HmWSSuIpjaTbauxyP/gyaC/M2Ke
         aSViEP3h3hfZ4UC/8XREIsb7bvISuWNlQMXXfXAEBCZY6rOIuzq65NfLVatBibY3ErkU
         udYpwp/8Zq+8vxT9Da16TKlODlzjTwbsIhKxbJI0Aq8ZSYGkIEbvmjuYEhdO5C6Ag0qM
         pzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ko94EtcnTTFWdT8rbBTWfqin0PckBNI75sE9SICxMmY=;
        b=XgWEDSvqXaHTwUCvHaaYpzgLcCnJxbAG2djL05YGXZF6jPYuR424Mzrk6Nqc9sFATq
         uc9pR9/b5TNM8s6OlQsKnsRc7u4Ge71oABECc7TZVLb2KGWYWBkLZ0UFSVEKBoGizthc
         NHpCSnQAMWgSvVrZOFb4iRXo5kSmfGc9c0QtqpPc1TcZqEFz5jLiMpMSHW6pNm2E7ZtG
         6dmP7UW8VUoVBZ4ZrZJPBgZFhggARPYV4GqcGjk8Zdrl3Vuz0+FMKnGgPYI9jAVxAFIy
         6JJJFMBAkI525/9WeUMFfInPSVmU5F6Uta7iGJHK3YkUp1/ldUuJMWPmcpxyVFoOlDmH
         vCsA==
X-Gm-Message-State: AOUpUlGQlM3kd8xUu/W7ZRYT9zWsGFLTii8O7pobYvLpDXszHccYAAdS
        7OnQ37CIdzy+MBxg/TxPwOaq2+5S
X-Google-Smtp-Source: AA+uWPzqaGbyfZTQ+pRXC9cbr9UaBY/J3su3l6YXqYhLBldMpKUFwVhSG67G1Fsx440Fty81kUQs7g==
X-Received: by 2002:adf:c612:: with SMTP id n18-v6mr19233546wrg.177.1534444661598;
        Thu, 16 Aug 2018 11:37:41 -0700 (PDT)
Received: from [192.168.1.18] (bkw170.neoplus.adsl.tpnet.pl. [83.28.190.170])
        by smtp.gmail.com with ESMTPSA id x16-v6sm4616wro.84.2018.08.16.11.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 11:37:40 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] dt-bindings: leds: Add bindings for lm3697 driver
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20180816172058.31700-1-dmurphy@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <aecaa2ff-e75c-2059-684a-908aedc20929@gmail.com>
Date:   Thu, 16 Aug 2018 20:37:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180816172058.31700-1-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thanks for the update.

I have one remark below.

On 08/16/2018 07:20 PM, Dan Murphy wrote:
> Add the device tree bindings for the lm3697
> LED driver for backlighting and display.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v4 - Removed HVLED definition in favor of HVLED place definition - https://lore.kernel.org/patchwork/patch/974812/
> v3 - Updated subject with prefered title - https://lore.kernel.org/patchwork/patch/972337/
> v2 - Fixed subject and patch commit message - https://lore.kernel.org/patchwork/patch/971326/
> 
>  .../devicetree/bindings/leds/leds-lm3697.txt  | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3697.txt b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
> new file mode 100644
> index 000000000000..bcd67d53c889
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
> @@ -0,0 +1,86 @@
> +* Texas Instruments - LM3697 Highly Efficient White LED Driver
> +
> +The LM3697 11-bit LED driver provides high-
> +performance backlight dimming for 1, 2, or 3 series
> +LED strings while delivering up to 90% efficiency.
> +
> +This device is suitable for Display and Keypad Lighting
> +
> +Required properties:
> +	- compatible:
> +		"ti,lm3967"
> +	- reg :  I2C slave address
> +	- #address-cells : 1
> +	- #size-cells : 0
> +
> +Optional properties:
> +	- enable-gpios : gpio pin to enable/disable the device.
> +	- vled-supply : LED supply
> +
> +Required child properties:
> +	- reg : 0 - LED is Controlled by bank A
> +		1 - LED is Controlled by bank B
> +	- led-sources : Indicates which HVLED string is associated to which
> +			control bank.  Each element in the array is associated
> +			with a specific HVLED string.  Element 0 is HVLED1,
> +			element 1 is HVLED2 and element 2 HVLED3.
> +			Additional information is contained
> +			in Documentation/devicetree/bindings/leds/common.txt
> +			0 - HVLED is not active in this control bank
> +			1 - HVLED string is controlled by this control bank
> +
> +Optional child properties:
> +	- label : see Documentation/devicetree/bindings/leds/common.txt
> +	- linux,default-trigger :
> +	   see Documentation/devicetree/bindings/leds/common.txt
> +
> +Example:
> +
> +HVLED string 1 and 2 controlled by control bank A and HVLED string controlled by

s/1 and 2/1 and 3/
s/HVLED string controller/HVLED string 2 controlled/

> +control bank B.
> +
> +led-controller@36 {
> +	compatible = "ti,lm3967";
> +	reg = <0x36>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> +	vled-supply = <&vbatt>;
> +
> +	led@0 {
> +		reg = <0>;
> +		led-sources = <1 0 1>;
> +		label = "white:first_backlight_cluster";
> +		linux,default-trigger = "backlight";
> +	};
> +
> +	led@1 {
> +		reg = <1>;
> +		led-sources = <0 1 0>;
> +		label = "white:second_backlight_cluster";
> +		linux,default-trigger = "backlight";
> +	};
> +}
> +
> +All HVLED strings controlled by control bank A
> +
> +led-controller@36 {
> +	compatible = "ti,lm3967";
> +	reg = <0x36>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> +	vled-supply = <&vbatt>;
> +
> +	led@0 {
> +		reg = <0>;
> +		led-sources = <1 1 1>;
> +		label = "white:backlight_cluster";
> +		linux,default-trigger = "backlight";
> +	};
> +}
> +
> +For more product information please see the link below:
> +http://www.ti.com/lit/ds/symlink/lm3697.pdf
> 

-- 
Best regards,
Jacek Anaszewski
