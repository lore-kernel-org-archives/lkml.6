Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75F3C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB9A20825
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MFG72qhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB9A20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeKRC1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:27:24 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39996 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeKRC1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:27:23 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAHG9YMJ042497;
        Sat, 17 Nov 2018 10:09:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542470974;
        bh=ZWMpME09oPr83NMhAgUlOViULzNAPjiWGWxaUnvK8CE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=MFG72qhwtRmjQuzzCgbAkRYynb8/uOMstTM1wTmvTM/paACVepQkuOF3tJw+hJz26
         X+ekgCvaBbYWc3sY9p/X0UQx+xcJqiDnnb8ar29J4UBjdneIRVa//7nPs4P3kGgJHr
         5cxC9mENwg45njgnBEXawlsvP+3I7VRPbp/CCzPQ=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAHG9YrO123443
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 17 Nov 2018 10:09:34 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sat, 17
 Nov 2018 10:09:34 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sat, 17 Nov 2018 10:09:34 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAHG9YDL011656;
        Sat, 17 Nov 2018 10:09:34 -0600
Date:   Sat, 17 Nov 2018 10:09:14 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh R <vigneshr@ti.com>
CC:     Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: ti: k3-am654-base-board: Add I2C nodes
Message-ID: <20181117160914.g7dqlplvzb5ggfkd@kahuna>
References: <20181113060111.16374-1-vigneshr@ti.com>
 <20181113060111.16374-5-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181113060111.16374-5-vigneshr@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:31-20181113, Vignesh R wrote:
> Add DT entries for I2C instances present in AM654 SoC.
> 

I2C does'nt really belong to a series introducing pinmux ;)... but yeah,
I get the dependency of pinmux.

> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 44 ++++++++++++
>  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       | 11 +++
>  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    | 11 +++
>  arch/arm64/boot/dts/ti/k3-am65.dtsi           |  6 ++
>  .../arm64/boot/dts/ti/k3-am654-base-board.dts | 70 +++++++++++++++++++
>  5 files changed, 142 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index f7c2a60d5c80..916434839603 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -85,4 +85,48 @@
>  		pinctrl-single,register-width = <32>;
>  		pinctrl-single,function-mask = <0xffffffff>;
>  	};
> +
> +	main_i2c0: i2c@2000000 {
> +		compatible = "ti,am654-i2c", "ti,omap4-i2c";
> +		reg = <0x0 0x2000000 0x0 0x100>;
> +		interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-names = "fck";
> +		clocks = <&k3_clks 110 1>;
> +		power-domains = <&k3_pds 110>;
> +	};
> +
> +	main_i2c1: i2c@2010000 {
> +		compatible = "ti,am654-i2c", "ti,omap4-i2c";
> +		reg = <0x0 0x2010000 0x0 0x100>;
> +		interrupts = <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-names = "fck";
> +		clocks = <&k3_clks 111 1>;
> +		power-domains = <&k3_pds 111>;
> +	};
> +
> +	main_i2c2: i2c@2020000 {
> +		compatible = "ti,am654-i2c", "ti,omap4-i2c";
> +		reg = <0x0 0x2020000 0x0 0x100>;
> +		interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-names = "fck";
> +		clocks = <&k3_clks 112 1>;
> +		power-domains = <&k3_pds 112>;
> +	};
> +
> +	main_i2c3: i2c@2030000 {
> +		compatible = "ti,am654-i2c", "ti,omap4-i2c";
> +		reg = <0x0 0x2030000 0x0 0x100>;
> +		interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-names = "fck";
> +		clocks = <&k3_clks 113 1>;
> +		power-domains = <&k3_pds 113>;
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index 8c611d16df44..1fd027748e1f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -15,4 +15,15 @@
>  			clock-frequency = <96000000>;
>  			current-speed = <115200>;
>  	};
> +
> +	mcu_i2c0: i2c@40b00000 {
> +		compatible = "ti,am654-i2c", "ti,omap4-i2c";
> +		reg = <0x0 0x40b00000 0x0 0x100>;
> +		interrupts = <GIC_SPI 564 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-names = "fck";
> +		clocks = <&k3_clks 114 1>;
> +		power-domains = <&k3_pds 114>;
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> index 19b46f40789b..9e8467ce7ad8 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> @@ -51,4 +51,15 @@
>  		clock-frequency = <48000000>;
>  		current-speed = <115200>;
>  	};
> +
> +	wkup_i2c0: i2c@42120000 {
> +		compatible = "ti,am654-i2c", "ti,omap4-i2c";
> +		reg = <0x42120000 0x100>;
> +		interrupts = <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-names = "fck";
> +		clocks = <&k3_clks 115 1>;
> +		power-domains = <&k3_pds 115>;
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> index 6fdfc7815811..50f4be2047a9 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> @@ -23,6 +23,12 @@
>  		serial2 = &main_uart0;
>  		serial3 = &main_uart1;
>  		serial4 = &main_uart2;
> +		i2c0 = &wkup_i2c0;
> +		i2c1 = &mcu_i2c0;
> +		i2c2 = &main_i2c0;
> +		i2c3 = &main_i2c1;
> +		i2c4 = &main_i2c2;
> +		i2c5 = &main_i2c3;
>  	};
>  
>  	chosen { };
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index cbf9d3dfeaa3..bd5a0069191d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -35,6 +35,15 @@
>  	};
>  };
>  
> +&wkup_pmx0 {
> +	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
> +		pinctrl-single,pins = <
> +			AM65X_WKUP_IOPAD(0x00e0, PIN_INPUT, 0) /* (AC7) WKUP_I2C0_SCL */
> +			AM65X_WKUP_IOPAD(0x00e4, PIN_INPUT, 0) /* (AD6) WKUP_I2C0_SDA */
> +		>;
> +	};
> +};
> +
>  &main_pmx0 {
>  	main_uart0_pins_default: main-uart0-pins-default {
>  		pinctrl-single,pins = <
> @@ -44,6 +53,29 @@
>  			AM65X_IOPAD(0x01f0, PIN_OUTPUT, 0)	/* (AD11) UART0_RTSn */
>  		>;
>  	};
> +
> +	main_i2c2_pins_default: main-i2c2-pins-default {
> +		pinctrl-single,pins = <
> +			AM65X_IOPAD(0x0074, PIN_INPUT, 5) /* (T27) GPMC0_CSn3.I2C2_SCL */
> +			AM65X_IOPAD(0x0070, PIN_INPUT, 5) /* (R25) GPMC0_CSn2.I2C2_SDA */
> +		>;
> +	};
> +};
> +
> +&main_pmx1 {
> +	main_i2c0_pins_default: main-i2c0-pins-default {
> +		pinctrl-single,pins = <
> +			AM65X_IOPAD(0x0000, PIN_INPUT, 0) /* (D20) I2C0_SCL */
> +			AM65X_IOPAD(0x0004, PIN_INPUT, 0) /* (C21) I2C0_SDA */
> +		>;
> +	};
> +
> +	main_i2c1_pins_default: main-i2c1-pins-default {
> +		pinctrl-single,pins = <
> +			AM65X_IOPAD(0x0008, PIN_INPUT, 0) /* (B21) I2C1_SCL */
> +			AM65X_IOPAD(0x000c, PIN_INPUT, 0) /* (E21) I2C1_SDA */
> +		>;
> +	};
>  };
>  
>  &wkup_uart0 {
> @@ -55,3 +87,41 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&main_uart0_pins_default>;
>  };
> +
> +&wkup_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wkup_i2c0_pins_default>;
> +	clock-frequency = <400000>;
> +
> +	pca9554: gpio@39 {
> +		compatible = "nxp,pca9554";
> +		reg = <0x39>;
> +		gpio-controller;
> +		#gpio-cells = <2>;

Do make sure that defconfig has the GPIO expander built as modules at
the very least.

> +	};
> +};
> +
> +&main_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c0_pins_default>;
> +	clock-frequency = <400000>;
> +
> +	pca9555: gpio@21 {
> +		compatible = "nxp,pca9555";
> +		reg = <0x21>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +};
> +
> +&main_i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c1_pins_default>;
> +	clock-frequency = <400000>;
> +};
> +
> +&main_i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c2_pins_default>;
> +	clock-frequency = <400000>;
> +};
> -- 
> 2.19.1
> 


Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
