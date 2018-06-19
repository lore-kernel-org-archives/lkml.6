Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8C0C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041E820850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2S7Ezle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041E820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937154AbeFSCpi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 22:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755409AbeFSCpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 22:45:36 -0400
Received: from dragon (unknown [45.56.152.47])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E18E42075E;
        Tue, 19 Jun 2018 02:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529376336;
        bh=CiVUC8vkOMHgpugI7UsqEhNeLSqFfXzcmTO5lWcwQ28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o2S7EzleeD1gxGA6GdqJe63YloUtIqdW0YrNGBYh+S4jAvOa03pSDqeN2XYzW90lX
         RHvNVn3ptTHqHc9Qfy8djrurpM+051MfBezR6PfFq0KbaPljFsTYBRxSJBruIcq72a
         GIZ/CG0pLzQh8NvQTVMzx+RO4hWbuNq7ON72yC3U=
Date:   Tue, 19 Jun 2018 10:44:38 +0800
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
Subject: Re: [PATCH v2 3/4] ARM: dts: i.MX6: imx6dl-mamoj: Add Wifi support
Message-ID: <20180619024437.GY16091@dragon>
References: <20180607134748.2970-1-jagan@amarulasolutions.com>
 <20180607134748.2970-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607134748.2970-2-jagan@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 07:17:47PM +0530, Jagan Teki wrote:
> Add TI WL18XX Wifi for BTicino i.MX6DL board.
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
>  arch/arm/boot/dts/imx6dl-mamoj.dts | 53 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-mamoj.dts b/arch/arm/boot/dts/imx6dl-mamoj.dts
> index ed9050c5dbcc..5034b086035f 100644
> --- a/arch/arm/boot/dts/imx6dl-mamoj.dts
> +++ b/arch/arm/boot/dts/imx6dl-mamoj.dts
> @@ -133,6 +133,18 @@
>  		enable-active-high;
>  		vin-supply = <&reg_lcd_vgl>;
>  	};
> +
> +	reg_wl18xx_vmmc:  regulator-wl18xx-vmcc {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vwl1807";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_wlan>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		gpio = <&gpio6 21 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <70000>;
> +		enable-active-high;
> +	};
>  };
>  
>  &fec {
> @@ -285,6 +297,30 @@
>  	status = "okay";
>  };
>  
> +&usdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	bus-width = <4>;
> +	vmmc-supply = <&reg_wl18xx_vmmc>;
> +	no-1-8-v;
> +	non-removable;
> +	wakeup-source;
> +	keep-power-in-suspend;
> +	cap-power-off-card;
> +	max-frequency = <25000000>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	wlcore: wlcore@2 {
> +		compatible = "ti,wl1837";
> +		reg = <2>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
> +		tcxo-clock-frequency = <26000000>;
> +	};
> +};
> +
>  &usdhc3 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usdhc3>;
> @@ -392,6 +428,17 @@
>  		>;
>  	};
>  
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17069
> +			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10079
> +			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17069
> +			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17069
> +			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17069
> +			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17069
> +		>;
> +	};
> +
>  	pinctrl_usdhc3: usdhc3grp {
>  		fsl,pins = <
>  			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x17059
> @@ -406,4 +453,10 @@
>  			MX6QDL_PAD_SD3_DAT7__SD3_DATA7	0x17059
>  		>;
>  	};
> +
> +	pinctrl_wlan: wlan {

To be consistent on naming style, 'wlangrp' might be better.

Shawn

> +		fsl,pins = <
> +			MX6QDL_PAD_RGMII_TD1__GPIO6_IO21	0x4001b0b0
> +		>;
> +	};
>  };
> -- 
> 2.14.3
> 
