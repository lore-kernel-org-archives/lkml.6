Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05C0C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1E0248ED
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKzLprWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1E0248ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752115AbeGAIZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 04:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751850AbeGAIZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 04:25:25 -0400
Received: from dragon (unknown [45.56.152.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC4B323FD4;
        Sun,  1 Jul 2018 08:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530433524;
        bh=ml/uWWSBU9/puT+ZYXGCXWVhBziW58smZL+bgr++HOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DKzLprWJLEhglpDROxjlheOAtP+S+nvYfJg+CRX/pU+vBNpRkzr1Pfh7Bn6NwzJy4
         1ub0+gEG//8z7dOnl8ZnGeBwBf0k2tEWZVQtp559GFeTC9hxmWLv3xChVpHPLVh06E
         kP3yTn+uT52grY5QJ5qng/rbckwxyIdnqg5Qj+h4=
Date:   Sun, 1 Jul 2018 16:25:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, cphealy@gmail.com,
        andrew.smirnov@gmail.com, l.stach@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ARM: dts: imx: add ZII SCU2 ESB board
Message-ID: <20180701082508.GI4348@dragon>
References: <1529603100-31958-1-git-send-email-andrey.gusakov@cogentembedded.com>
 <1529603100-31958-3-git-send-email-andrey.gusakov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529603100-31958-3-git-send-email-andrey.gusakov@cogentembedded.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 08:44:59PM +0300, Andrey Gusakov wrote:
> This adds support for the Zodiac Inflight Innovations SCU2 Ethernet
> Switch Board, which is based on the i.MX51.
> 
> Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> ---
>  arch/arm/boot/dts/Makefile               |   3 +-
>  arch/arm/boot/dts/imx51-zii-scu2-esb.dts | 178 +++++++++++++++++++++++++++++++
>  2 files changed, 180 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/imx51-zii-scu2-esb.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 37a3de7..d8900f4 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -358,7 +358,8 @@ dtb-$(CONFIG_SOC_IMX51) += \
>  	imx51-digi-connectcore-jsk.dtb \
>  	imx51-eukrea-mbimxsd51-baseboard.dtb \
>  	imx51-ts4800.dtb \
> -	imx51-zii-rdu1.dtb
> +	imx51-zii-rdu1.dtb \
> +	imx51-zii-scu2-esb.dtb
>  dtb-$(CONFIG_SOC_IMX53) += \
>  	imx53-ard.dtb \
>  	imx53-cx9020.dtb \
> diff --git a/arch/arm/boot/dts/imx51-zii-scu2-esb.dts b/arch/arm/boot/dts/imx51-zii-scu2-esb.dts
> new file mode 100644
> index 0000000..e052133
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx51-zii-scu2-esb.dts
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +// Copyright (C) 2018 Zodiac Inflight Innovations
> +
> +/dts-v1/;
> +#include "imx51-zii-common.dtsi"
> +
> +/ {
> +	model = "ZII SCU2 ESB board";
> +	compatible = "zii,imx51-scu2-esb", "fsl,imx51";
> +};
> +
> +&esdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_esdhc1_4bit &pinctrl_esdhc1_8bit>;
> +	bus-width = <8>;
> +};
> +
> +&fec {
> +	phy-reset-gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
> +
> +	fixed-link {
> +		speed = <100>;
> +		full-duplex;
> +	};
> +
> +	fec_mdio: mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "okay";
> +
> +		switch@0 {
> +			compatible = "marvell,mv88e6085";
> +			reg = <0>;
> +			dsa,member = <0 0>;
> +			eeprom-length = <512>;
> +			interrupt-parent = <&gpio4>;
> +			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					label = "port1";
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					label = "port2";
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +					label = "port3";
> +				};
> +
> +				port@3 {
> +					reg = <3>;
> +					label = "scu2scu";
> +				};
> +
> +				port@4 {
> +					reg = <4>;
> +					label = "esb2host";
> +				};

Please constantly have newline between nodes.

Shawn

> +				port@5 {
> +					reg = <5>;
> +					label = "esb2mezz";
> +					phy-mode = "sgmii";
> +
> +					fixed-link {
> +						speed = <1000>;
> +						full-duplex;
> +					};
> +				};
> +				port@6 {
> +					reg = <6>;
> +					label = "cpu";
> +					phy-mode = "mii";
> +					ethernet = <&fec>;
> +
> +					fixed-link {
> +						speed = <100>;
> +						full-duplex;
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	lm75@48 {
> +		compatible = "national,lm75";
> +		reg = <0x48>;
> +	};
> +};
> +
> +&i2c_gpio {
> +	gpios = <&gpio3 1 GPIO_ACTIVE_HIGH>, /* sda */
> +		<&gpio3 0 GPIO_ACTIVE_HIGH>; /* scl */
> +};
> +
> +&ipu {
> +	status = "disabled";
> +};
> +
> +&usb_vbus {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usb_mmc_reset>;
> +	gpio = <&gpio4 19 GPIO_ACTIVE_LOW>;
> +	startup-delay-us = <150000>;
> +};
> +
> +&iomuxc {
> +	pinctrl_fec: fecgrp {
> +		fsl,pins = <
> +			MX51_PAD_DISP2_DAT15__FEC_TDATA0	0x2004
> +			MX51_PAD_DISP2_DAT6__FEC_TDATA1		0x2004
> +			MX51_PAD_DISP2_DAT7__FEC_TDATA2		0x2004
> +			MX51_PAD_DISP2_DAT8__FEC_TDATA3		0x2004
> +			MX51_PAD_DISP2_DAT9__FEC_TX_EN		0x2004
> +			MX51_PAD_DISP2_DAT10__FEC_COL		0x0180
> +			MX51_PAD_DISP2_DAT11__FEC_RX_CLK	0x0180
> +			MX51_PAD_DISP2_DAT12__FEC_RX_DV		0x20a4
> +			MX51_PAD_DISP2_DAT13__FEC_TX_CLK	0x2180
> +			MX51_PAD_DISP2_DAT14__FEC_RDATA0	0x2180
> +			MX51_PAD_DI2_DISP_CLK__FEC_RDATA1	0x0085
> +			MX51_PAD_DI_GP4__FEC_RDATA2		0x0085
> +			MX51_PAD_DISP2_DAT0__FEC_RDATA3		0x0085
> +			MX51_PAD_DI2_PIN2__FEC_MDC		0x2004
> +			MX51_PAD_DI2_PIN3__FEC_MDIO		0x01f5
> +			MX51_PAD_DI2_PIN4__FEC_CRS		0x0180
> +			MX51_PAD_AUD3_BB_FS__GPIO4_21		0x0000
> +		>;
> +	};
> +
> +	pinctrl_swi2c: swi2cgrp {
> +		fsl,pins = <
> +			MX51_PAD_DI1_PIN11__GPIO3_0		0x100
> +			MX51_PAD_DI1_PIN12__GPIO3_1		0x100
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX51_PAD_UART1_RXD__UART1_RXD		0x1c5
> +			MX51_PAD_UART1_TXD__UART1_TXD		0x1c5
> +			MX51_PAD_UART1_RTS__UART1_RTS		0x1c5
> +			MX51_PAD_UART1_CTS__UART1_CTS		0x1c5
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX51_PAD_UART2_RXD__UART2_RXD		0x1c5
> +			MX51_PAD_UART2_TXD__UART2_TXD		0x1c5
> +			MX51_PAD_USBH1_DATA0__UART2_CTS		0x1c5
> +			MX51_PAD_USBH1_DATA3__UART2_RTS		0x1c5
> +		>;
> +	};
> +
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			MX51_PAD_UART3_RXD__UART3_RXD		0x1c5
> +			MX51_PAD_UART3_TXD__UART3_TXD		0x1c5
> +		>;
> +	};
> +
> +	pinctrl_usb_mmc_reset: usbmmcgrp {
> +		fsl,pins = <
> +			MX51_PAD_AUD3_BB_RXD__GPIO4_19		0x100
> +		>;
> +	};
> +};
> -- 
> 1.9.1
> 
