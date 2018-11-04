Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C61C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE7220854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPSfGhVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE7220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbeKDXm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:42:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:38540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbeKDXm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:42:26 -0500
Received: from tiger (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7C222082E;
        Sun,  4 Nov 2018 14:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541341633;
        bh=3O6kSj3K11OgWR0DUchTyygA/EfFIfHSdBJCdFYtROw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZPSfGhVFW18cPu9fm1DNOS1NIYzupLtF4ZvMoLs6JIMzE7flzuPG7XXW/T+BjrPeR
         pzLd7y+OlzIPbKyQsq0fjLVWP21xCTqkkBgDzCZOPHawk1yAYcrEhKVkXicT7+21Do
         F6EmzyldCcGUGH1xyIudJOW/pucJ7yLtxGlqTHHQ=
Date:   Sun, 4 Nov 2018 22:26:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>
Subject: Re: [PATCH V2 3/3] ARM: dts: sabreauto: Add flexcan support
Message-ID: <20181104142647.GH26016@tiger>
References: <20181030083954.26440-1-qiangqing.zhang@nxp.com>
 <20181030083954.26440-4-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030083954.26440-4-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 08:42:47AM +0000, Joakim Zhang wrote:
> From: Dong Aisheng <aisheng.dong@nxp.com>
> 
> The flexcan1 is pin conflict with fec. So we add a new dts file with
> flexcan1 enabled with fec disabled for user to use.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

We do not want to maintain a pile of DTS files for a single development
board with pin sharing among different devices.

Shawn

> ---
>  .../boot/dts/imx6dl-sabreauto-flexcan1.dts    | 14 ++++++
>  .../arm/boot/dts/imx6q-sabreauto-flexcan1.dts | 14 ++++++
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi      | 47 +++++++++++++++++++
>  3 files changed, 75 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-sabreauto-flexcan1.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-sabreauto-flexcan1.dts
> 
> diff --git a/arch/arm/boot/dts/imx6dl-sabreauto-flexcan1.dts b/arch/arm/boot/dts/imx6dl-sabreauto-flexcan1.dts
> new file mode 100644
> index 000000000000..4ebcc283f549
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-sabreauto-flexcan1.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2013 Freescale Semiconductor, Inc.
> +
> +#include "imx6dl-sabreauto.dts"
> +
> +&can1{
> +	status = "okay";
> +};
> +
> +&fec {
> +	/* pin conflict with flexcan1 */
> +	status = "disabled";
> +};
> diff --git a/arch/arm/boot/dts/imx6q-sabreauto-flexcan1.dts b/arch/arm/boot/dts/imx6q-sabreauto-flexcan1.dts
> new file mode 100644
> index 000000000000..e7e684656f09
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-sabreauto-flexcan1.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2013 Freescale Semiconductor, Inc.
> +
> +#include "imx6q-sabreauto.dts"
> +
> +&can1{
> +	status = "okay";
> +};
> +
> +&fec {
> +	/* pin conflict with flexcan1 */
> +	status = "disabled";
> +};
> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> index a10f0ad0bfb1..c1111b972b46 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -101,6 +101,25 @@
>  		enable-active-high;
>  	};
>  
> +	reg_can_en: regulator-can-en {
> +		compatible = "regulator-fixed";
> +		regulator-name = "can-en";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&max7310_b 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_can_stby: regulator-can-stby {
> +		compatible = "regulator-fixed";
> +		regulator-name = "can-stby";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&max7310_b 5 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		vin-supply = <&reg_can_en>;
> +	};
> +
>  	sound-cs42888 {
>  		compatible = "fsl,imx6-sabreauto-cs42888",
>  			"fsl,imx-audio-cs42888";
> @@ -279,6 +298,20 @@
>  	status = "okay";
>  };
>  
> +&can1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan1>;
> +	xceiver-supply = <&reg_can_stby>;
> +	status = "disabled"; /* pin conflict with fec */
> +};
> +
> +&can2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan2>;
> +	xceiver-supply = <&reg_can_stby>;
> +	status = "okay";
> +};
> +
>  &gpmi {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_gpmi_nand>;
> @@ -494,6 +527,20 @@
>  			>;
>  		};
>  
> +		pinctrl_flexcan1: flexcan1grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX        0x17059
> +				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x17059
> +			>;
> +		};
> +
> +		pinctrl_flexcan2: flexcan2grp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX	0x17059
> +				MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX	0x17059
> +			>;
> +		};
> +
>  		pinctrl_gpio_keys: gpiokeysgrp {
>  			fsl,pins = <
>  				MX6QDL_PAD_SD2_CMD__GPIO1_IO11		0x1b0b0
> -- 
> 2.17.1
> 
