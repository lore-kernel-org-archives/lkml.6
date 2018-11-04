Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4447AC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 07:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A9B20866
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 07:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZJ3uY3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A9B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbeKDQl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 11:41:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:47204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbeKDQl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 11:41:59 -0500
Received: from tiger (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 199D02081C;
        Sun,  4 Nov 2018 07:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541316480;
        bh=WnBPXfx+6cvWy0N9Mz6bJc1HSwYuJPo+lUkOFkc6KRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DZJ3uY3gbImCwrqsH+GL2o6DS0non0H6mtL2o3agxMMZdtgiRNItzlCfopIxMCylt
         LBLPVBagm40RIV+Jzg8Dff+YYeT1qX3KHrlyGvb4I049EuOK3MZIJ1U9Er3tgQ5EZS
         H+VSFEDuO8Z/EQeS8UY1QNXlEKNU83Xt7tzz354I=
Date:   Sun, 4 Nov 2018 15:27:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/1] ARM: dts: imx6sx-sdb: Add flexcan support
Message-ID: <20181104072734.GA26016@tiger>
References: <20181020023318.21663-1-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181020023318.21663-1-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 02:35:36AM +0000, Joakim Zhang wrote:
> From: Dong Aisheng <aisheng.dong@nxp.com>
> 
> CAN transceiver is different on RevA and RevB board.
> It's active high on RevA while active low on Rev B.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sx-sdb-reva.dts | 12 ++++++++
>  arch/arm/boot/dts/imx6sx-sdb.dts      |  5 ++++
>  arch/arm/boot/dts/imx6sx-sdb.dtsi     | 42 +++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-sdb-reva.dts b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
> index 9cc6ff206aea..d98dcf00b9c4 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb-reva.dts
> +++ b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
> @@ -10,6 +10,18 @@
>  
>  / {
>  	model = "Freescale i.MX6 SoloX SDB RevA Board";
> +
> +	/* Transceiver EN/STBY is active high on RevA board */
> +	reg_can_en: regulator-can-en {
> +		gpio = <&gpio4 25 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};

Please use label node to make it easier for both yourself and readers.

&reg_can_en {
	...
};

Shawn

> +
> +	reg_can_stby: regulator-can-stby {
> +		gpio = <&gpio4 27 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		vin-supply = <&reg_can_en>;
> +	};
>  };
>  
>  &i2c1 {
> diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
> index 6dd9bebfe027..092b8de142a8 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb.dts
> +++ b/arch/arm/boot/dts/imx6sx-sdb.dts
> @@ -10,6 +10,11 @@
>  
>  / {
>  	model = "Freescale i.MX6 SoloX SDB RevB Board";
> +
> +	/* Transceiver EN/STBY is active low on RevB board */
> +	reg_can_stby: regulator-can-stby {
> +		gpio = <&gpio4 27 GPIO_ACTIVE_LOW>;
> +	};
>  };
>  
>  &i2c1 {
> diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
> index f8f31872fa14..e37ec4b396a2 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
> +++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
> @@ -136,6 +136,20 @@
>  		regulator-max-microvolt = <5000000>;
>  	};
>  
> +	reg_can_en: regulator-can-en {
> +		compatible = "regulator-fixed";
> +		regulator-name = "can-en";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	reg_can_stby: regulator-can-stby {
> +		compatible = "regulator-fixed";
> +		regulator-name = "can-stby";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
>  	sound {
>  		compatible = "fsl,imx6sx-sdb-wm8962", "fsl,imx-audio-wm8962";
>  		model = "wm8962-audio";
> @@ -202,6 +216,20 @@
>  	status = "okay";
>  };
>  
> +&flexcan1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan1>;
> +	xceiver-supply = <&reg_can_stby>;
> +	status = "okay";
> +};
> +
> +&flexcan2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan2>;
> +	xceiver-supply = <&reg_can_stby>;
> +	status = "okay";
> +};
> +
>  &i2c3 {
>  	clock-frequency = <100000>;
>  	pinctrl-names = "default";
> @@ -397,6 +425,20 @@
>  			>;
>  		};
>  
> +		pinctrl_flexcan1: flexcan1grp {
> +			fsl,pins = <
> +				MX6SX_PAD_QSPI1B_DQS__CAN1_TX		0x1b020
> +				MX6SX_PAD_QSPI1A_SS1_B__CAN1_RX		0x1b020
> +			>;
> +		};
> +
> +		pinctrl_flexcan2: flexcan2grp {
> +			fsl,pins = <
> +				MX6SX_PAD_QSPI1B_SS1_B__CAN2_RX		0x1b020
> +				MX6SX_PAD_QSPI1A_DQS__CAN2_TX		0x1b020
> +			>;
> +		};
> +
>  		pinctrl_gpio_keys: gpio_keysgrp {
>  			fsl,pins = <
>  				MX6SX_PAD_CSI_DATA04__GPIO1_IO_18 0x17059
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
