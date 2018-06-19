Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F9AC5AE59
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B87720850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6kBITtY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B87720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937201AbeFSCq2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 22:46:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937030AbeFSCq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 22:46:27 -0400
Received: from dragon (unknown [45.56.152.47])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A88152075E;
        Tue, 19 Jun 2018 02:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529376386;
        bh=+iW8ci5FskJTVm7I+P5P16Bn5+qBWGAU519rNZK4qjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N6kBITtYjf1kMwE3FguO4yTP5UQMDxlGGP7zd8bY3oSM0dwEJ6Ke4DlsRERWYS1It
         OUvIYrikcBUps3sfMcKnApVn5XezMU9cjzB4v5D2RyYr5FJDmWzUOVYq+h6HQoyKNp
         68hpj8cUdS9+R0zFP9rPn1uYw24z4RKncLWdxi+o=
Date:   Tue, 19 Jun 2018 10:45:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio maggi <fabio.mauri@bticino.it>, lamiaposta71@gmail.com,
        Andrea CORTESE <andrea.cortese@bticino.it>,
        "davide . bonfanti" <davide.bonfanti@bticino.it>,
        Shyam Saini <shyam.saini@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Simone CIANNI <simone.cianni@bticino.it>,
        Raffaele RECALCATI <raffaele.recalcati@bticino.it>
Subject: Re: [PATCH v2 4/4] ARM: dts: i.MX6: imx6dl-mamoj: Add usb host and
 device support
Message-ID: <20180619024528.GZ16091@dragon>
References: <20180607134748.2970-1-jagan@amarulasolutions.com>
 <20180607134748.2970-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607134748.2970-3-jagan@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 07:17:48PM +0530, Jagan Teki wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> Add USB host and device support for BTicino i.MX6DL Mamoj board.
> 
> Signed-off-by: Simone CIANNI <simone.cianni@bticino.it>
> Signed-off-by: Raffaele RECALCATI <raffaele.recalcati@bticino.it>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Changes for v2:
> - collect Fabio r-w-b tag
> 
>  arch/arm/boot/dts/imx6dl-mamoj.dts | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-mamoj.dts b/arch/arm/boot/dts/imx6dl-mamoj.dts
> index 5034b086035f..a727e1471006 100644
> --- a/arch/arm/boot/dts/imx6dl-mamoj.dts
> +++ b/arch/arm/boot/dts/imx6dl-mamoj.dts
> @@ -134,6 +134,17 @@
>  		vin-supply = <&reg_lcd_vgl>;
>  	};
>  
> +	reg_usb_host: regulator-usb-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usbhost-vbus";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usbhost>;
> +		regulator-min-microvolt = <50000000>;
> +		regulator-max-microvolt = <50000000>;
> +		gpio = <&gpio6 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
>  	reg_wl18xx_vmmc:  regulator-wl18xx-vmcc {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vwl1807";
> @@ -297,6 +308,16 @@
>  	status = "okay";
>  };
>  
> +&usbh1 {
> +	vbus-supply = <&reg_usb_host>;
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> +
>  &usdhc1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usdhc1>;
> @@ -428,6 +449,12 @@
>  		>;
>  	};
>  
> +	pinctrl_usbhost: usbhost {

usbhostgrp.

Shawn

> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_A23__GPIO6_IO06		0x4001b0b0
> +		>;
> +	};
> +
>  	pinctrl_usdhc1: usdhc1grp {
>  		fsl,pins = <
>  			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17069
> -- 
> 2.14.3
> 
