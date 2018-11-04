Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D91C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 07:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822F720854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 07:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x2H8Xhj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822F720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbeKDQrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 11:47:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbeKDQrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 11:47:12 -0500
Received: from tiger (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B86B32081C;
        Sun,  4 Nov 2018 07:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541316792;
        bh=qpa9I/qI2zC67HLnY01sxP9BpqwkQm+kfdEsO38oN50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x2H8Xhj9+8wV4YRyO4XXFO82+zKVPdloQwBSxCWpARLn7joYWricZUejPwxvyIUMz
         xkuBxNKwcM+dWHSgjIOy+HMhBAoP7j3K/fr8x8svyS9BZkNvAQ17cmeY7hxjBr6NcD
         wRMjiXWkHOHQJUOGXv+x3ceCJzrUcAsTmmHJhNbs=
Date:   Sun, 4 Nov 2018 15:32:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alex Gonzalez <alex.gonzalez@digi.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] ARM: dts: imx6ul: ccimx6ulsom: Add support for
 wireless SOM variant
Message-ID: <20181104073249.GB26016@tiger>
References: <1540200443-24773-1-git-send-email-alex.gonzalez@digi.com>
 <1540200443-24773-2-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540200443-24773-2-git-send-email-alex.gonzalez@digi.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 11:27:23AM +0200, Alex Gonzalez wrote:
> The wireless variants of the ConnecCore 6UL SOM include a Qualcomm
> QCA6564 wireless chip with dual WiFi and Bluetooth.
> 
> Both the ConnectCore 6UL SBC Express and Pro boards fit a wireless SOM.
> 
> The Wifi is connected through the SDIO interface on usdhc1 and the
> Bluetooth is connected via uart1.
> 
> Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
> ---
>  arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi | 64 +++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
> index c71a84da1af0..23bbcd4c71d1 100644
> --- a/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
> +++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
> @@ -161,6 +161,25 @@
>  	};
>  };
>  
> +/* UART1 (Bluetooth) */
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +/* USDHC1 (Wireless) */
> +&usdhc1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_wifibt_ctrl>;
> +	pinctrl-1 = <&pinctrl_usdhc1_sleep &pinctrl_wifibt_ctrl_sleep>;
> +	non-removable;
> +	no-1-8-v;
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
>  &iomuxc {
>  	pinctrl_gpmi_nand: gpmigrp {
>  		fsl,pins = <
> @@ -188,6 +207,51 @@
>  			MX6UL_PAD_UART4_RX_DATA__I2C1_SDA 0x4001b8b0
>  			>;
>  		};

The existing indentation for gpmigrp and i2c1grp is problematic.

> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX   0x1b0b1
> +			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX   0x1b0b1
> +			MX6UL_PAD_UART1_RTS_B__UART1_DCE_RTS    0x1b0b1
> +			MX6UL_PAD_UART1_CTS_B__UART1_DCE_CTS    0x1b0b1
> +		>;
> +	};

This indentation is what we want ...

> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD           0x17059
> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK           0x17051
> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0       0x17059
> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1       0x17059
> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2       0x17059
> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3       0x17059
> +			 >;
> +		};
> +

... so please follow uart1grp style for all entries you are adding.

Shawn

> +	pinctrl_usdhc1_sleep: usdhc1grp-sleep {
> +		fsl,pins = <
> +			MX6UL_PAD_SD1_CMD__GPIO2_IO16           0x3000
> +			MX6UL_PAD_SD1_CLK__GPIO2_IO17           0x3000
> +			MX6UL_PAD_SD1_DATA0__GPIO2_IO18         0x3000
> +			MX6UL_PAD_SD1_DATA1__GPIO2_IO19         0x3000
> +			MX6UL_PAD_SD1_DATA2__GPIO2_IO20         0x3000
> +			MX6UL_PAD_SD1_DATA3__GPIO2_IO21         0x3000
> +			 >;
> +	};
> +
> +	pinctrl_wifibt_ctrl: wifibt-ctrl-grp {
> +		fsl,pins = <
> +			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00      0x08a0
> +			MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09      0x08a0
> +			  >;
> +	};
> +
> +	pinctrl_wifibt_ctrl_sleep: wifibt-ctrl-grp-sleep {
> +		fsl,pins = <
> +			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00      0x3000
> +			MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09      0x3000
> +			 >;
> +	};
>  };
>  
>  &reg_arm {
