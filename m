Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA06C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3452120851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGF9msVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3452120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbeKTAKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:10:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:60662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728295AbeKTAKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:10:30 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E015320831;
        Mon, 19 Nov 2018 13:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542635209;
        bh=e1TlM0Py7t0g8q7mddqGWSQqdhnpmqUTSdE3yU7v/Xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGF9msVgq88I4LEbRcSl+4dgqI2WdeigpCuBkjaVQB3NNroM4q1X16SbuoQkRRVV/
         fsS9AOS/ZVCrYd0aEs9+XNui26qZdDACJGcEP+GtdRTBz4ISBN3cY/72ODIMH6itms
         52lBFLQi+kHmB4VPidz8i5kKiWL2t3J+sRlPVV2A=
Date:   Mon, 19 Nov 2018 21:46:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2] ARM: dts: imx7d-sdb: add rev-a board support
Message-ID: <20181119134624.GT5829@dragon>
References: <1541726525-19544-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541726525-19544-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 01:27:10AM +0000, Anson Huang wrote:
> Current imx7d-sdb.dts has some incorrect settings about
> Rev-A and Rev-B boards, some of the settings are based on
> Rev-A board but some are based on Rev-B board, clean up it
> by adding i.MX7D SDB Rev-A board support, make default
> imx7d-sdb.dts for Rev-B board as usual, and introduce
> imx7d-sdb-reva.dts for Rev-A board. Below are the affected
> differences of Rev-A and Rev-B board:
> 
>                 Rev-A           Rev-B
> USB_OTG2_PWR:   UART3_CTS_B     GPIO1_IO07
> ENET_EN_B:      None            GPIO1_IO04
> TP_INT_B:       EPDC_DATA13     EPDC_BDR1
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> change since V1:
> 	remove "pinctrl-assert-gpios" which is unused in upstream, and use phy-supply
> to control fec2's enable pin, model the enable pin as GPIO regulator.
>  arch/arm/boot/dts/Makefile           |  1 +
>  arch/arm/boot/dts/imx7d-sdb-reva.dts | 39 ++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx7d-sdb.dts      | 29 +++++++++++++++++++++++++--
>  3 files changed, 67 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx7d-sdb-reva.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ef9ffa4..6d133b9 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -572,6 +572,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
>  	imx7d-pico-pi.dtb \
>  	imx7d-sbc-imx7.dtb \
>  	imx7d-sdb.dtb \
> +	imx7d-sdb-reva.dtb \
>  	imx7d-sdb-sht11.dtb \
>  	imx7s-colibri-eval-v3.dtb \
>  	imx7s-warp.dtb
> diff --git a/arch/arm/boot/dts/imx7d-sdb-reva.dts b/arch/arm/boot/dts/imx7d-sdb-reva.dts
> new file mode 100644
> index 0000000..7741eaa
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx7d-sdb-reva.dts
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +//
> +// Copyright (C) 2015 Freescale Semiconductor, Inc.
> +
> +/dts-v1/;
> +
> +#include "imx7d-sdb.dts"
> +
> +/ {
> +	reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
> +		gpio = <&gpio4 7 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&fec2 {
> +	/delete-property/phy-supply;
> +};
> +
> +&iomuxc {
> +	imx7d-sdb {
> +		pinctrl_tsc2046_pendown: tsc2046_pendown {
> +			fsl,pins = <
> +				MX7D_PAD_EPDC_DATA13__GPIO2_IO13	0x59
> +			>;
> +		};
> +
> +		pinctrl_hog: hoggrp {
> +			fsl,pins = <
> +				MX7D_PAD_UART3_CTS_B__GPIO4_IO7		0x14
> +				MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x34  /* bt reg on */
> +			>;
> +		};
> +	};
> +};
> +
> +&iomuxc_lpsr {
> +	/delete-property/pinctrl-names;
> +	/delete-property/pinctrl-0;
> +};
> diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
> index f1bafda..8385b9b 100644
> --- a/arch/arm/boot/dts/imx7d-sdb.dts
> +++ b/arch/arm/boot/dts/imx7d-sdb.dts
> @@ -73,7 +73,7 @@
>  		regulator-name = "usb_otg2_vbus";
>  		regulator-min-microvolt = <5000000>;
>  		regulator-max-microvolt = <5000000>;
> -		gpio = <&gpio4 7 GPIO_ACTIVE_HIGH>;
> +		gpio = <&gpio1 7 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  	};
>  
> @@ -114,6 +114,16 @@
>  		gpio = <&gpio2 14 GPIO_ACTIVE_LOW>;
>  	};
>  
> +	reg_fec2_3v3: regulator-fec2-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fec2-3v3";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_enet2_reg>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio1 4 GPIO_ACTIVE_LOW>;
> +	};
> +
>  	backlight: backlight {
>  		compatible = "pwm-backlight";
>  		pwms = <&pwm1 0 5000000 0>;
> @@ -210,6 +220,7 @@
>  	assigned-clock-rates = <0>, <100000000>;
>  	phy-mode = "rgmii";
>  	phy-handle = <&ethphy1>;
> +	phy-supply = <&reg_fec2_3v3>;
>  	fsl,magic-packet;
>  	status = "okay";
>  };
> @@ -491,6 +502,12 @@
>  			>;
>  		};
>  
> +		pinctrl_enet2_reg: enet2reggrp {
> +			fsl,pins = <
> +				MX7D_PAD_LPSR_GPIO1_IO04__GPIO1_IO4	0x14
> +			>;
> +		};
> +
>  		pinctrl_flexcan2: flexcan2grp {
>  			fsl,pins = <
>  				MX7D_PAD_GPIO1_IO14__FLEXCAN2_RX	0x59
> @@ -513,7 +530,6 @@
>  
>  		pinctrl_hog: hoggrp {
>  			fsl,pins = <
> -				MX7D_PAD_UART3_CTS_B__GPIO4_IO7		0x14
>  				MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x34  /* bt reg on */
>  			>;
>  		};
> @@ -724,6 +740,9 @@
>  };
>  
>  &iomuxc_lpsr {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog_2>;
> +
>  	pinctrl_wdog: wdoggrp {
>  		fsl,pins = <
>  			MX7D_PAD_LPSR_GPIO1_IO00__WDOG1_WDOG_B		0x74
> @@ -735,4 +754,10 @@
>  			MX7D_PAD_LPSR_GPIO1_IO01__PWM1_OUT		0x30
>  		>;
>  	};
> +
> +	pinctrl_hog_2: hoggrp-2 {
> +		fsl,pins = <
> +			MX7D_PAD_LPSR_GPIO1_IO07__GPIO1_IO7	  0x14

Instead of using hog group, this should be defined by pinctrl entry to
be referred by the fixed regulator that uses this GPIO?

Shawn

> +		>;
> +	};
>  };
> -- 
> 2.7.4
> 
