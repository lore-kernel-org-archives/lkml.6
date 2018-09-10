Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0F1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE13120866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KB+ZIMk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE13120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeIJIRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbeIJIRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:17:08 -0400
Received: from dragon (unknown [45.56.155.51])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 819F220870;
        Mon, 10 Sep 2018 00:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536541058;
        bh=8XiECl2J+m7zN6tRcqCgaJgcICGb3z8m25Vt5KITfV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KB+ZIMk2VQGUIEGgkB06hjhCNtO7nMdqa5N4W8PViErQ9FUVol4UBNtUPAROQ5PS5
         PIa7l57cgabI8q/iA5svplNZ2MR/kgU+/cadTnJineN/QyAFYQFmzeScD7b2ME1rOh
         DNM4nJp1KELlfnKu/mt+uOoF+q60sFQM9UYWSG9k=
Date:   Mon, 10 Sep 2018 08:56:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alex Gonzalez <alex.gonzalez@digi.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Pro
Message-ID: <20180910005604.GG21218@dragon>
References: <1536074909-8654-1-git-send-email-alex.gonzalez@digi.com>
 <1536074909-8654-2-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536074909-8654-2-git-send-email-alex.gonzalez@digi.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 05:28:29PM +0200, Alex Gonzalez wrote:
> The ConnectCore 6UL Single Board Computer (SBC) Pro contains the
> ConnectCore 6UL System-On-Module.
> 
> Its hardware specifications are:
> 
> * 256MB DDR3 memory
> * On module 256MB NAND flash
> * Dual 10/100 Ethernet
> * USB Host and USB OTG
> * Parallel RGB display header
> * LVDS display header
> * CSI camera
> * GPIO header
> * I2C, SPI, CAN headers
> * PCIe mini card and micro SIM slot
> * MicroSD external storage
> * On board 4GB eMMC flash
> * Audio headphone, line in/out, microphone lines
> 
> Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
> ---
>  arch/arm/boot/dts/Makefile                  |   1 +
>  arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts | 394 ++++++++++++++++++++++++++++
>  2 files changed, 395 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 6135d3dc381c..3f6f8983f6c6 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -534,6 +534,7 @@ dtb-$(CONFIG_SOC_IMX6SX) += \
>  dtb-$(CONFIG_SOC_IMX6UL) += \
>  	imx6ul-14x14-evk.dtb \
>  	imx6ul-ccimx6ulsbcexpress.dtb \
> +	imx6ul-ccimx6ulsbcpro.dtb \
>  	imx6ul-geam.dtb \
>  	imx6ul-isiot-emmc.dtb \
>  	imx6ul-isiot-nand.dtb \
> diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
> new file mode 100644
> index 000000000000..08d550baa684
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
> @@ -0,0 +1,394 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Digi International's ConnectCore6UL SBC Pro board device tree source
> + *
> + * Copyright 2018 Digi International, Inc.
> + *
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include "imx6ul.dtsi"
> +#include "imx6ul-ccimx6ulsom.dtsi"
> +
> +/ {
> +	model = "Digi International ConnectCore 6UL SBC Pro.";
> +	compatible = "digi,ccimx6ulsbcpro", "digi,ccimx6ulsom", "fsl,imx6ul";
> +
> +	lcd_backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm5 0 50000>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <6>;
> +		status = "okay";
> +	};
> +
> +	reg_usb_otg1_vbus: reg-usb-otg1 {

Please spell out 'regulator' in node name:

	reg_usb_otg1_vbus: regulator-usb-otg1 {
		...
	};

Shawn

> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_otg1_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio1 4 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +};
