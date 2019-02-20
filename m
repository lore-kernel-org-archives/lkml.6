Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC58C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80132070B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfBTISu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:18:50 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34069 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBTISt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:18:49 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gwN5U-0005bz-1F; Wed, 20 Feb 2019 09:18:40 +0100
Message-ID: <c514dea5d45f6796120fd6b5a8a3c42803e8aabb.camel@pengutronix.de>
Subject: Re: [PATCH v3 5/5] arm64: dts: imx8mq-evk: Enable PCIE0 interface
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 20 Feb 2019 09:18:36 +0100
In-Reply-To: <20190220015857.7136-6-andrew.smirnov@gmail.com>
References: <20190220015857.7136-1-andrew.smirnov@gmail.com>
         <20190220015857.7136-6-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 19.02.2019, 17:58 -0800 schrieb Andrey Smirnov:
> Enable PCIE0 interface connected to BCM4356 WiFi/Bluetooth module.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 42 ++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index 64acccc4bfcb..226aeb9791a5 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -31,6 +31,12 @@
>  		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  	};
> +
> +	pcie0_refclk: pcie0-refclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +	};
>  };
>  
>  &fec1 {
> @@ -40,6 +46,17 @@
>  	status = "okay";
>  };
>  
> +&gpio5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wifi_reset>;
> +
> + 	wl-reg-on {
> +		gpio-hog;
> +		gpios = <29 GPIO_ACTIVE_HIGH>;
> +		output-high;
> +	};
> +};
> +
>  &i2c1 {
>  	clock-frequency = <100000>;
>  	pinctrl-names = "default";
> @@ -131,6 +148,18 @@
>  	};
>  };
>  
> +&pcie0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie0>;
> +	reset-gpio = <&gpio5 28 GPIO_ACTIVE_LOW>;
> +	clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
> +		 <&clk IMX8MQ_CLK_PCIE1_AUX>,
> +		 <&clk IMX8MQ_CLK_PCIE1_PHY>,
> +		 <&pcie0_refclk>;
> +	clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> +	status = "okay";
> +};
> +
>  &uart1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1>;
> @@ -195,6 +224,13 @@
>  		>;
>  	};
>  
> +	pinctrl_pcie0: pcie0grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B		0x76
> +			MX8MQ_IOMUXC_UART4_RXD_GPIO5_IO28		0x16
> +		>;
> +	};
> +
>  	pinctrl_reg_usdhc2: regusdhc2grpgpio {
>  		fsl,pins = <
>  			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x41
> @@ -300,4 +336,10 @@
>  			MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
>  		>;
>  	};
> +
> +	pinctrl_wifi_reset: wifiresetgrp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_UART4_TXD_GPIO5_IO29		0x16
> +		>;
> +	};
>  };

