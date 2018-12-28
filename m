Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1069C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5CA21019
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546041217;
	bh=fp/TycfUTkSrSuSRFoFFbAAh3TzTt4dsVe6jWUgLj+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T7F+pURMustaSowCNdrls2HYu2x+0a4wcQ/YgUn3Rk/WliwwUdtCPtFD7WisGnY8n
	 ji2yCKPgLC6XD2oca614up7XtOOxywMYokC6RonSlUJi0TxNina76mrdiVcvyNnv0E
	 cxlR5XBxcI2pv+w1jPaerWIo6NQJt36py2OOFK4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeL1Xxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 18:53:36 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54342 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbeL1Xxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 18:53:36 -0500
Received: by mail-it1-f193.google.com with SMTP id i145so30242705ita.4;
        Fri, 28 Dec 2018 15:53:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=97jZ8ZvKqzu6OC9ZwiLUTvDx9b8k2//w97e25B1JBv0=;
        b=WVfJ5Cy/Bfz9m+Ev2FLqyIjKAYYFJzp3RHomLWQgkVCP7IRTAn+0hmOpWW8WAlzRRN
         Clr4DK+niFoRE0RttB3e4wZPrjpa1Oe5xnHjtx4HHuQLI2tIHfWRRyWfIq+7SeDLAKhQ
         BKoxS4W/Y3J3mbNI67ET9AKHLl0+5zgsuyt2KjvAolIpYyyi6nmdjSEMgJ+E7fkBHcak
         Efvl0NPA6wGNaqkZlmUab9sbMeKHuNB2rwaP/S5gxC8eVD3h0eG9mDhHtA5yN1oDmXLG
         9ONyH9KwTzzH/Fa7OzFbupYZO1x89FHANkw6iPRVw0ND7iIuExD7p+03yqAUQSejwNZS
         w3dA==
X-Gm-Message-State: AA+aEWbxCjT+0xd2VGLW0BkcM6JzthmFJ04Vji4Lo9TTlR8cFMHNAxiM
        gLAcE+aVKt9vifYzbvrgZamABFQ=
X-Google-Smtp-Source: AFSGD/U6NcQxQh944A7ugUS6WK1QXEHNF8ahi0XzLZixP68ieZwDt8/C6QvvIm6R8Jxoq7MLVhmiYA==
X-Received: by 2002:a24:c601:: with SMTP id j1mr20497116itg.130.1546041215070;
        Fri, 28 Dec 2018 15:53:35 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id 81sm19827542itz.15.2018.12.28.15.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 15:53:34 -0800 (PST)
Date:   Fri, 28 Dec 2018 17:53:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH 1/2] dt: bindings: lp5024: Introduce the lp5024 and
 lp5018 RGB driver
Message-ID: <20181228235333.GA13949@bogus>
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20181219162626.12297-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219162626.12297-2-dmurphy@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 10:26:25AM -0600, Dan Murphy wrote:
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
>  .../devicetree/bindings/leds/leds-lp5024.txt  | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lp5024.txt
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

Leftover copy-n-paste?

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
> +	};
> +
> +}
> +
> +For more product information please see the link below:
> +http://www.ti.com/lit/ds/symlink/lp5024.pdf
> -- 
> 2.20.0.rc2.7.g965798d1f2
> 
