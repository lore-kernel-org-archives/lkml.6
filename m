Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14BEC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD0B20BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrHTr2D+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD0B20BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbeHOTtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:49:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44366 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbeHOTtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:49:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so1674771wrt.11;
        Wed, 15 Aug 2018 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Je89+tnS9qOJbI4jIE40X4c3YDyPPiI2vn4kmPMgkF4=;
        b=lrHTr2D+XBmWLzyd0b4BfR++Oi93QwfYPDY+WyD3alVZqQa9C2Kdt41pR0CbLL74Lu
         WIIpPFvb5kxZ4Xw772FF0kvKHqeZC/qOUe48hbLWi4qujKd1aEbYfPYYZIK50ABEeA7z
         VbvXwFy7tbsB8emaAIOQdm8nfUSXTrSwaH/3ZRhxQs3eTr9DiPNlFZYBAm9LuGQgG3mu
         0Pxf3SKg5ng8zxt74u6fGknYWdwNJ2LQKjegfoI79hmXYpWLTJr3T2iLcEIl4p9eslr2
         zv27uMuG3/AUiwW71n+Ce5AgJIqWWWXTrOyi+526EhIR6i/thSfEkrBTCawKQMjyKnOQ
         osMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Je89+tnS9qOJbI4jIE40X4c3YDyPPiI2vn4kmPMgkF4=;
        b=diSZlqhSJ0S6LqbNVogbPJm6rEmWwD+l4ZSEkH5zq7saubNELkHwWH9jBZoCPfg1Yw
         YDxATxxLaM9Ls2dLb7CwrNWjbEkyDlv0KahJEXMpfXio/ZqWhfg3MJamEWg0GyIjI1uJ
         6q1am/q3S9vE30q9LqqAy4Lx8XOJz2dsIg2JRyXqER1WiZ65rVXD5sA9smcTwdtcv/yC
         TfL2zfy72JEDghsGKrgww6D4hYZ8lWpSZuAcAZPWu5Eskk2Putc6haksp+uwdLYIJpvF
         yyLyhVplTubNCZ/uiwElvDjJjUJHSzh6Z42Ek6Qf/tT1KxFTF10I8YQOptJenH+GY4Tk
         auPg==
X-Gm-Message-State: AOUpUlE9wZ7Zn5lZzc4xSvkxd83RYjqy7iXdte7gFI1bxcOTTmEK2RdF
        X4C4e278360vagpTkYTDDFhhTpw5
X-Google-Smtp-Source: AA+uWPwSkKEXYBhN1fHiWV/fYu1Wtk2FHe9oc61K/BFFna3VrhHSZppIb1mmLdJ6orFTDVW/p581xw==
X-Received: by 2002:adf:9c93:: with SMTP id d19-v6mr16378931wre.11.1534352196745;
        Wed, 15 Aug 2018 09:56:36 -0700 (PDT)
Received: from [192.168.1.18] (dkl176.neoplus.adsl.tpnet.pl. [83.24.15.176])
        by smtp.gmail.com with ESMTPSA id e141-v6sm4633281wmd.32.2018.08.15.09.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 09:56:35 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: Add bindings for lm3697 driver
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20180815161734.18159-1-dmurphy@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <e278d4f2-7848-d156-01ec-3cd77803e4de@gmail.com>
Date:   Wed, 15 Aug 2018 18:56:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180815161734.18159-1-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thank you for the update.

On 08/15/2018 06:17 PM, Dan Murphy wrote:
> Add the device tree bindings for the lm3697
> LED driver for backlighting and display.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v3 - Updated subject with prefered title - https://lore.kernel.org/patchwork/patch/972337/
> v2 - Fixed subject and patch commit message - https://lore.kernel.org/patchwork/patch/971326/
> 
>  .../devicetree/bindings/leds/leds-lm3697.txt  | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3697.txt b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
> new file mode 100644
> index 000000000000..34403a48a0ce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
> @@ -0,0 +1,89 @@
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
> +	- led-sources - Indicates which HVLED string is associated to which
> +			control bank.  The HVLED string cannot be associated with
> +			two control banks.  This property is an array of 3 and
> +			all positions in the array must be populated.
> +			Additional information is contained
> +			in Documentation/devicetree/bindings/leds/common.txt
> +			0 - End of array if all 3 LEDs are not declared for a
> +			    single control bank.

This is needless complication. I propose to define led-sources as
an array of three boolean values, whose state signifies which LED
strings are controlled by the bank defined by the reg property in the
given child node. I.e. <HVLED1 HVLED2 HVLED3>.

I modified your examples below accordingly.

> +			1 - HVLED 1 string
> +			2 - HVLED 2 string
> +			3 - HVLED 3 string
> +
> +Optional child properties:
> +	- label : see Documentation/devicetree/bindings/leds/common.txt
> +	- linux,default-trigger :
> +	   see Documentation/devicetree/bindings/leds/common.txt
> +
> +Example:
> +
> +HVLED string 1 and 2 controlled by control bank A and HVLED string controlled by
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
> +		led-sources = <0x1 0x2 0x0>

		led-sources = <1 1 0>;
;
> +		label = "white:first_backlight_cluster";
> +		linux,default-trigger = "backlight";
> +	};
> +
> +	led@1 {
> +		reg = <1>;
> +		led-sources = <0x3 0x0 0x0>;

		led-sources = <0 0 1>;

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
> +		led-sources = <0x1 0x2 0x3>;

		led-sources = <1 1 1>;

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
