Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D42C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057E220883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0hI4HA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfAHUdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:33:55 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33201 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbfAHUdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:33:54 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so3973173lfc.0;
        Tue, 08 Jan 2019 12:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cg2zwOHXo9nVdkO+mTRJ4sMn6FqwaorZsoEMGlyaEMI=;
        b=M0hI4HA/7W0ZIfqCnluwn+1crn6InifbJ/o7oCvFBybqqv3McdkpY6Uy9o+dJSpuQ7
         cwd3dRSALtE/IKJvAywXQg7FidBmeXfrhT5Qr5Bi6eVOXHrAxd0JrBxWHLxWxefpjIJx
         w3Lyk2ss583jKeCjRmFq6Ui1dBjQ72CIQQ3MTkwAm5tCMB0aMuXios+sv6rrFo0aIjoS
         MfpkZlohr1JIMQQM55NyK4WQdmeBUnjvifM9FY+ptPHUi8CpN/1/YopD8/K7nVpZ9UFa
         jSX0h+oTVzRbRvrBJo+iM7fmC6aayF9OEUP4YAu/da3+LQF/VotoBG9VI2pEu243jouU
         Ty1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cg2zwOHXo9nVdkO+mTRJ4sMn6FqwaorZsoEMGlyaEMI=;
        b=faRW6dYsVRt4lZ/tyLUtd2YNSHLfuTDDRCh6cecfqnNNBsBJ7ZQTazTKT/BT7BscxD
         2W+oJDM5PWfRwQshiCQSwv8a5q30VO7Z5kKaPQqHULmmuEj4M6h16GQNipqTMpN8FefN
         sVw0YYmgjnwjuf27aywG34nwoHd758OLjlirW1rKN/EZgJQKADyboOANMDBWs4YV77IS
         +M6BlsyPnAKOpxrwiFE3sVKgvPI4yuHz6pneH016Xll98TeyXpQRGCI+fa45DdI5TzCN
         eJzxS2MHWmTfbsyIxToXKVX/FKsYxIVrFkv69oTU9r+PIRZuf6Cx+48Z7I3LCeFfnalR
         DXQg==
X-Gm-Message-State: AJcUukf+OgfpWDEbzgdJO7PlmP3E7zIU5ZcjyTgKiIPPgFD0bHrdSStI
        TfZo1XCKdkmbGL0tXlYNuLkQrDvd
X-Google-Smtp-Source: ALg8bN7cdlS28TeC9EFM+wk+AMRVIyt45PZ1PEO7w1OxFh+xsu/PC36OVv/FSAhh+/lPtZ978S97ow==
X-Received: by 2002:a19:d619:: with SMTP id n25mr1783275lfg.91.1546979630603;
        Tue, 08 Jan 2019 12:33:50 -0800 (PST)
Received: from [192.168.1.18] (dlx201.neoplus.adsl.tpnet.pl. [83.24.53.201])
        by smtp.gmail.com with ESMTPSA id r69sm13559224lfi.15.2019.01.08.12.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 12:33:49 -0800 (PST)
Subject: Re: [PATCH 1/2] dt: bindings: lp5024: Introduce the lp5024 and lp5018
 RGB driver
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20181219162626.12297-2-dmurphy@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <dc2283f9-db85-1eaf-f046-3fbbd4adcace@gmail.com>
Date:   Tue, 8 Jan 2019 21:33:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181219162626.12297-2-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 12/19/18 5:26 PM, Dan Murphy wrote:
> Introduce the bindings for the Texas Instruments LP5024 and the LP5018
> RGB LED device driver.  The LP5024/18 can control RGB LEDs individually
> or as part of a control bank group.  These devices have the ability
> to adjust the mixing control for the RGB LEDs to obtain different colors
> independent of the overall brightness of the LED grouping.
> 
> Datasheet:
> http://www.ti.com/lit/ds/symlink/lp5024.pdf
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>   .../devicetree/bindings/leds/leds-lp5024.txt  | 63 +++++++++++++++++++
>   1 file changed, 63 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/leds/leds-lp5024.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lp5024.txt b/Documentation/devicetree/bindings/leds/leds-lp5024.txt
> new file mode 100644
> index 000000000000..9567aa6f7813
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-lp5024.txt
> @@ -0,0 +1,63 @@
> +* Texas Instruments - LP5024/18 RGB LED driver
> +
> +The LM3692x is an ultra-compact, highly efficient,
> +white-LED driver designed for LCD display backlighting.
> +
> +The main difference between the LP5024 and L5018 is the number of
> +RGB LEDs they support.  The LP5024 supports twenty four strings while the
> +LP5018 supports eighteen strings.
> +
> +Required properties:
> +	- compatible:
> +		"ti,lp5018"
> +		"ti,lp5024"
> +	- reg :  I2C slave address
> +	- #address-cells : 1
> +	- #size-cells : 0
> +
> +Optional properties:
> +	- enable-gpios : gpio pin to enable/disable the device.
> +	- vled-supply : LED supply
> +
> +Required child properties:
> +	- reg : Is the child node iteration.
> +	- led-sources : LP5024 - 0 - 7
> +			LP5018 - 0 - 5
> +			Declares the LED string or strings that the child node
> +			will control.  If ti,control-bank is set then this
> +			property will contain multiple LED IDs.
> +
> +Optional child properties:
> +	- label : see Documentation/devicetree/bindings/leds/common.txt
> +	- linux,default-trigger :
> +	   see Documentation/devicetree/bindings/leds/common.txt
> +	- ti,control-bank : Indicates that the LED strings declared in the
> +			    led-sources property are grouped within a control
> +			    bank for brightness and mixing control.
> +
> +Example:
> +
> +led-controller@28 {
> +	compatible = "ti,lp5024";
> +	reg = <0x28>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> +	vled-supply = <&vbatt>;
> +
> +	led@0 {
> +		reg = <0>;
> +		led-sources = <1>;
> +	};
> +
> +	led@1 {
> +		reg = <1>;
> +		led-sources = <0 6>;
> +		ti,control-bank;

Do you really need ti,control-bank? Doesn't led-sources array size
greater than 1 mean that the node describes control bank?

Also, does it make sense to have only two LEDs in the bank?

> +	};
> +
> +}
> +
> +For more product information please see the link below:
> +http://www.ti.com/lit/ds/symlink/lp5024.pdf
> 

-- 
Best regards,
Jacek Anaszewski
