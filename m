Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35897C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D340A20838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgIL5qHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D340A20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeJaQ2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 12:28:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbeJaQ2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 12:28:35 -0400
Received: from tiger (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40F88205F4;
        Wed, 31 Oct 2018 07:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540971098;
        bh=aXzD/q2fwEMPBBD/HVWFcIQyus3bu1HZUETvK1A9Tkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bgIL5qHZDXcF9UXR3v0NHIMs00f7idOXeHqGmqLzJzAnWXAnekvPH8ZxUx/UwANSN
         GU8PDJmBtlfTF6lLVaGGJfhCv37dMx+zefTkV/lpz3a30gDtIbsTE3VTGiXtJeFNZX
         X5KT+tIYXfVXprRsDdCZGSErmvevmV89gPViy/7g=
Date:   Wed, 31 Oct 2018 15:31:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>, peter.chen@nxp.com
Cc:     devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx: Add dummy PHYs for HSIC-only USB
 controllers
Message-ID: <20181031073112.GL10386@tiger>
References: <1539848729-27646-1-git-send-email-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539848729-27646-1-git-send-email-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 09:45:04AM +0200, Frieder Schrempf wrote:
> Some SOCs in the i.MX6 family have a USB host controller that is
> only capable of the HSIC interface and has no on-board PHY.
> 
> To be able to use these controllers, we need to add "usb-nop-xceiv"
> dummy PHYs.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

@Peter, looks good to you?

Shawn

> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 14 ++++++++++++++
>  arch/arm/boot/dts/imx6sl.dtsi  |  7 +++++++
>  arch/arm/boot/dts/imx6sx.dtsi  |  6 ++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 61d2d26..d3404d1 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -139,6 +139,16 @@
>  		interrupts = <0 94 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
> +	usbphynop1: usbphynop1 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
> +
> +	usbphynop2: usbphynop2 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
> +
>  	soc {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> @@ -981,6 +991,8 @@
>  				reg = <0x02184400 0x200>;
>  				interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clks IMX6QDL_CLK_USBOH3>;
> +				fsl,usbphy = <&usbphynop1>;
> +				phy_type = "hsic";
>  				fsl,usbmisc = <&usbmisc 2>;
>  				dr_mode = "host";
>  				ahb-burst-config = <0x0>;
> @@ -994,6 +1006,8 @@
>  				reg = <0x02184600 0x200>;
>  				interrupts = <0 42 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clks IMX6QDL_CLK_USBOH3>;
> +				fsl,usbphy = <&usbphynop2>;
> +				phy_type = "hsic";
>  				fsl,usbmisc = <&usbmisc 3>;
>  				dr_mode = "host";
>  				ahb-burst-config = <0x0>;
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 7a4f5da..81edcdc 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -110,6 +110,11 @@
>  		interrupts = <0 94 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
> +	usbphynop1: usbphynop1 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
> +
>  	soc {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> @@ -815,6 +820,8 @@
>  				reg = <0x02184400 0x200>;
>  				interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clks IMX6SL_CLK_USBOH3>;
> +				fsl,usbphy = <&usbphynop1>;
> +				phy_type = "hsic";
>  				fsl,usbmisc = <&usbmisc 2>;
>  				dr_mode = "host";
>  				ahb-burst-config = <0x0>;
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 844caa3..07ed417 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -159,6 +159,11 @@
>  		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
> +	usbphynop1: usbphynop1 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
> +
>  	soc {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> @@ -877,6 +882,7 @@
>  				reg = <0x02184400 0x200>;
>  				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clks IMX6SX_CLK_USBOH3>;
> +				fsl,usbphy = <&usbphynop1>;
>  				fsl,usbmisc = <&usbmisc 2>;
>  				phy_type = "hsic";
>  				fsl,anatop = <&anatop>;
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
