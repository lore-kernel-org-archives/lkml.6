Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ED6C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C461920862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C461920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389006AbeGZTVA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:21:00 -0400
Received: from mailoutvs38.siol.net ([185.57.226.229]:51336 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730250AbeGZTVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:21:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 29B4752191F;
        Thu, 26 Jul 2018 20:03:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id chTs7eIqhMpd; Thu, 26 Jul 2018 20:03:02 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 17ED55219F0;
        Thu, 26 Jul 2018 20:03:02 +0200 (CEST)
Received: from jernej-laptop.localnet (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id 6EEAB521A95;
        Thu, 26 Jul 2018 20:03:01 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     linux-sunxi@googlegroups.com, icenowy@aosc.io
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [linux-sunxi] [PATCH v3.1 10/10] arm64: dts: allwinner: a64: Enable HDMI output on A64 boards w/ HDMI
Date:   Thu, 26 Jul 2018 20:03:00 +0200
Message-ID: <1571011.jY5lUBhtiX@jernej-laptop>
In-Reply-To: <20180726171257.6688-11-icenowy@aosc.io>
References: <20180726171257.6688-1-icenowy@aosc.io> <20180726171257.6688-11-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne četrtek, 26. julij 2018 ob 19:12:57 CEST je Icenowy Zheng napisal(a):
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> Enable all necessary device tree nodes and add connector node to device
> trees for all supported A64 boards with HDMI.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> [Icenowy: squash all board patches altogether and change supply name]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v3,1:
> - Squash all enablement patches altogether.
> - Change supply name to match DT binding & driver change.
> Changes for v3:
> - Enable all pipeline components
> Changes for v2:
> - none
> 
>  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 34 +++++++++++++++++++
>  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   | 34 +++++++++++++++++++
>  .../dts/allwinner/sun50i-a64-olinuxino.dts    | 34 +++++++++++++++++++
>  .../dts/allwinner/sun50i-a64-orangepi-win.dts | 34 +++++++++++++++++++
>  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 34 +++++++++++++++++++
>  .../allwinner/sun50i-a64-sopine-baseboard.dts | 34 +++++++++++++++++++
>  6 files changed, 204 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts index
> 094cfed13df9..0d8f5571d574 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> @@ -60,6 +60,17 @@
>  		stdout-path = "serial0:115200n8";
>  	};
> 
> +	connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
> 
> @@ -86,6 +97,10 @@
>  	};
>  };
> 
> +&de {
> +	status = "okay";
> +};
> +
>  &ehci0 {
>  	status = "okay";
>  };
> @@ -103,6 +118,17 @@
>  	status = "okay";
>  };
> 
> +&hdmi {
> +	hdmi-supply = <&reg_dldo1>;
> +	status = "okay";
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
>  &i2c1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c1_pins>;
> @@ -120,6 +146,10 @@
>  	};
>  };
> 
> +&mixer1 {
> +	status = "okay";
> +};
> +
>  &mmc0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc0_pins>;
> @@ -300,6 +330,10 @@
>  	vcc-hdmi-supply = <&reg_dldo1>;
>  };
> 
> +&tcon1 {
> +	status = "okay";
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pins_a>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts index
> 98dbff19f5cc..2bcf02f46366 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> @@ -57,6 +57,21 @@
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +};
> +
> +&de {
> +	status = "okay";
>  };
> 
>  &ehci0 {
> @@ -67,6 +82,17 @@
>  	status = "okay";
>  };
> 
> +&hdmi {
> +	hdmi-supply = <&reg_dldo1>;
> +	status = "okay";
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
>  /* i2c1 connected with gpio headers like pine64, bananapi */
>  &i2c1 {
>  	pinctrl-names = "default";
> @@ -78,6 +104,10 @@
>  	bias-pull-up;
>  };
> 
> +&mixer1 {
> +	status = "okay";
> +};
> +
>  &mmc0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc0_pins>;
> @@ -199,6 +229,10 @@
>  	vcc-hdmi-supply = <&reg_dldo1>;
>  };
> 
> +&tcon1 {
> +	status = "okay";
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pins_a>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts index
> 3f531393eaee..5445a7a1db51 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> @@ -58,12 +58,42 @@
>  		stdout-path = "serial0:115200n8";
>  	};
> 
> +	connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +
>  	wifi_pwrseq: wifi_pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
>  	};
>  };
> 
> +&de {
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	hdmi-supply = <&reg_dldo1>;
> +	status = "okay";
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
> +&mixer1 {
> +	status = "okay";
> +};
> +
>  &mmc0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc0_pins>;
> @@ -218,6 +248,10 @@
>  	vcc-hdmi-supply = <&reg_dldo1>;
>  };
> 
> +&tcon1 {
> +	status = "okay";
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pins_a>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts index
> 1221764f5719..81a8f92c6c35 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> @@ -57,12 +57,42 @@
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +};
> +
> +&de {
> +	status = "okay";
>  };
> 
>  &ehci1 {
>  	status = "okay";
>  };
> 
> +&hdmi {
> +	hdmi-supply = <&reg_dldo1>;
> +	status = "okay";
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
> +&mixer1 {
> +	status = "okay";
> +};
> +
>  &mmc0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc0_pins>;
> @@ -195,6 +225,10 @@
>  	vcc-hdmi-supply = <&reg_dldo1>;
>  };
> 
> +&tcon1 {
> +	status = "okay";
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pins_a>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts index
> 1b9b92e541d2..1b972bade9f6 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> @@ -62,6 +62,21 @@
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +};
> +
> +&de {
> +	status = "okay";
>  };
> 
>  &ehci0 {
> @@ -82,6 +97,17 @@
> 
>  };
> 
> +&hdmi {
> +	hdmi-supply = <&reg_dldo1>;
> +	status = "okay";
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
>  &i2c1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c1_pins>;
> @@ -99,6 +125,10 @@
>  	};
>  };
> 
> +&mixer1 {
> +	status = "okay";
> +};
> +
>  &mmc0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc0_pins>;
> @@ -238,6 +268,10 @@
>  	status = "disabled";
>  };
> 
> +&tcon1 {
> +	status = "okay";
> +};
> +
>  /* On Exp and Euler connectors */
>  &uart0 {
>  	pinctrl-names = "default";
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts index
> c21f2331add6..eff44b069b1d 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> @@ -61,6 +61,17 @@
>  		stdout-path = "serial0:115200n8";
>  	};
> 
> +	connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +
>  	reg_vcc1v8: vcc1v8 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc1v8";
> @@ -69,6 +80,10 @@
>  	};
>  };
> 
> +&de {
> +	status = "okay";
> +};
> +
>  &ehci0 {
>  	status = "okay";
>  };
> @@ -86,6 +101,17 @@
>  	status = "okay";
>  };
> 
> +&hdmi {
> +	hdmi-supply = <&reg_dldo1>;
> +	status = "okay";
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
>  &mdio {
>  	ext_rgmii_phy: ethernet-phy@1 {
>  		compatible = "ethernet-phy-ieee802.3-c22";
> @@ -93,6 +119,10 @@
>  	};
>  };
> 
> +&mixer1 {
> +	status = "okay";
> +};
> +
>  &mmc2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc2_pins>;
> @@ -138,6 +168,10 @@
>  	vcc-hdmi-supply = <&reg_dldo1>;

How is it possible to have vcc-hdmi-supply already defined? Did I miss some 
patch?

Best regards,
Jernej

>  };
> 
> +&tcon1 {
> +	status = "okay";
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pins_a>;




