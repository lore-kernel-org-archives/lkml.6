Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9176C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8794920865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oanj4V+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8794920865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeK0BbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:31:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:42558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbeK0BbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:31:02 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6D4F20817;
        Mon, 26 Nov 2018 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543243003;
        bh=2tdgbdnNKOCYYkZMNe2C5qf+MplydxQgplLj1+sVJEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oanj4V+lm6jMsp2i0LaL4b6/ZwkR4/SczGqdCW8le4Y3rLlrKW8nUfpbo8Y7Zcob9
         Z2jX+cblddTGfqpfyANX3+uPNftOUNPMyXjvCRtAwiuXh7IFL/QI+uG3Rm/VjMxrZb
         J1c4By+PnMJerdHyv6aO9h0TLG1J6dlxQeGRRnfQ=
Date:   Mon, 26 Nov 2018 22:36:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] ARM: dts: Provide support for reading ID code from MVB
 device (BK4)
Message-ID: <20181126143619.GB31334@dragon>
References: <20181113121213.14296-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113121213.14296-1-lukma@denx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 01:12:13PM +0100, Lukasz Majewski wrote:
> The procedure to read this ID value is as follows:
> 
> rmmod spi_fsl_dspi
> insmod spi-gpio.ko
> 
> echo 504 > /sys/class/gpio/export
> cat /sys/class/gpio/gpio504/value
> ...
> echo 511 > /sys/class/gpio/export
> cat /sys/class/gpio/gpio511/value
> 
> rmmod spi-gpio.ko
> insmod spi_fsl_dspi
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

A prefix like 'ARM: dts: vf610-bk4: ...' might be better.

> ---
>  arch/arm/boot/dts/vf610-bk4.dts | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610-bk4.dts b/arch/arm/boot/dts/vf610-bk4.dts
> index cab95714c058..f01c735807ae 100644
> --- a/arch/arm/boot/dts/vf610-bk4.dts
> +++ b/arch/arm/boot/dts/vf610-bk4.dts
> @@ -59,6 +59,29 @@
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
>  	};
> +
> +	spi_gpio {

We recommend hyphen rather than underscore be used in node name.

> +		compatible = "spi-gpio";
> +		pinctrl-0 = <&pinctrl_gpio_spi>;
> +		pinctrl-names = "default";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		/* PTD12 ->RPIO[91] */
> +		sck-gpios  = <&gpio2 27 GPIO_ACTIVE_LOW>;
> +		/* PTD10 ->RPIO[89] */
> +		miso-gpios = <&gpio2 25 GPIO_ACTIVE_HIGH>;
> +		num-chipselects = <0>;
> +
> +		72xx165@0 {

Please use a generic name for the node.

Shawn

> +			compatible = "pisosr-gpio";
> +			reg = <0>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			/* PTB18 -> RGPIO[40] */
> +			load-gpios  = <&gpio1 8 GPIO_ACTIVE_LOW>;
> +			spi-max-frequency = <100000>;
> +		};
> +	};
>  };
>  
>  &adc0 {
> @@ -430,6 +453,14 @@
>  		>;
>  	};
>  
> +	pinctrl_gpio_spi: pinctrl-gpio-spi {
> +		fsl,pins = <
> +			VF610_PAD_PTB18__GPIO_40        0x1183
> +			VF610_PAD_PTD10__GPIO_89        0x1183
> +			VF610_PAD_PTD12__GPIO_91        0x1183
> +		>;
> +	};
> +
>  	pinctrl_i2c2: i2c2grp {
>  		fsl,pins = <
>  			VF610_PAD_PTA22__I2C2_SCL               0x34df
> -- 
> 2.11.0
> 
