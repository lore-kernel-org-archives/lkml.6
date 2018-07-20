Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A32ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03DB20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03DB20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbeGTRus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:50:48 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:56039 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731305AbeGTRur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:50:47 -0400
Received: by mail-it0-f66.google.com with SMTP id 16-v6so15564090itl.5;
        Fri, 20 Jul 2018 10:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nvovDuUBI0eelqoIvkOoBh9gskIlKEBesvKovx7s98Q=;
        b=Oc2cwUO5iGxiWMoz8SiQKnLH2RkRyy0PFTSMmmFH3n+PqD1hEC+2Uo+v0wn/BmA5wX
         pbCcGzDm+rKbZ6q17BgKp4TCayd4zyWeZpvR1BjxZbSqvCp6GX9mtN6nfb7FLuSzW1iS
         OcGLrrWulGx3XpbVgdcvCnKKl+S8L2wwzA0A/DuAiRCBy7HZB59OjR9q/5ATmOd+eXnj
         NwdoteaPFz69875nV29hKlxEjtXAkYeCZM3uRA0Skm52tHq2iZeby7lg9B/GFpuXKUDJ
         LCT1r8cs1V11Minsbv2crZa3T9ZqFSX954h9l72aLVIYqQwM1UMrnOEkGChkBKSjSWqZ
         ZE+w==
X-Gm-Message-State: AOUpUlFmcUjJkMA74QxbrYnmL5Ab4OaLipuCkgsRVSm0GQmSup0TtBL7
        4nGOIg+NDEo+VY6C4Pn6lw==
X-Google-Smtp-Source: AAOMgpdr6N8pSqFtQQF3XWKe5bT5pd+NtIBn21QwGPnIHJ14NN6pjz620gburJP9kJk91CMbIEHPIQ==
X-Received: by 2002:a24:3997:: with SMTP id l145-v6mr2747774ita.134.1532106097752;
        Fri, 20 Jul 2018 10:01:37 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id x6-v6sm2293945ith.1.2018.07.20.10.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 10:01:37 -0700 (PDT)
Date:   Fri, 20 Jul 2018 11:01:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     cl@rock-chips.com
Cc:     heiko@sntech.de, mark.rutland@arm.com,
        klaus.goger@theobroma-systems.com, jagan@amarulasolutions.com,
        djw@t-chip.com.cn, jacob-chen@iotwrt.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        frank.wang@rock-chips.com, lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        yamada.masahiro@socionext.com, arnd@arndb.de,
        zhangqing@rock-chips.com, shawn.lin@rock-chips.com,
        kever.yang@rock-chips.com, david.wu@rock-chips.com,
        huangtao@rock-chips.com, tony.xie@rock-chips.com,
        sugar.zhang@rock-chips.com, huibin.hong@rock-chips.com,
        william.wu@rock-chips.com, sandy.huang@rock-chips.com
Subject: Re: [PATCH v1 7/7] arm64: dts: rockchip: add PX30 eavluation board
 devicetree
Message-ID: <20180720170136.GA12920@rob-hp-laptop>
References: <1531813747-8804-1-git-send-email-cl@rock-chips.com>
 <1531814334-9134-1-git-send-email-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531814334-9134-1-git-send-email-cl@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 03:58:54PM +0800, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
> 
> This patch add px30-evb.dts for PX30 evaluation board.
> Tested on PX30 evb.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
>  arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>  arch/arm64/boot/dts/rockchip/px30-evb.dts          | 539 +++++++++++++++++++++
>  3 files changed, 544 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/px30-evb.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
> index 1c1d62d..e33b23a 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
> @@ -158,6 +158,10 @@ Rockchip platforms device tree bindings
>      Required root node properties:
>        - compatible = "rockchip,rv1108-evb", "rockchip,rv1108";
>  
> +- Rockchip PX30 evb:
> +    Required root node properties:
> +      - compatible = "rockchip,px30-evb", "rockchip,px30";
> +
>  - Rockchip RK3368 evb:
>      Required root node properties:
>        - compatible = "rockchip,rk3368-evb-act8846", "rockchip,rk3368";
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 48a83f8..19aa9c6 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -14,3 +14,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-evb.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/px30-evb.dts b/arch/arm64/boot/dts/rockchip/px30-evb.dts
> new file mode 100644
> index 0000000..b481408
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
> @@ -0,0 +1,539 @@
> +/*
> + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)

This goes on the first line.

> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include "px30.dtsi"
> +
> +/ {
> +	model = "Rockchip PX30 EVB";
> +	compatible = "rockchip,px30-evb", "rockchip,px30";
> +
> +	adc-keys {
> +		compatible = "adc-keys";
> +		io-channels = <&saradc 2>;
> +		io-channel-names = "buttons";
> +		poll-interval = <100>;
> +		keyup-threshold-microvolt = <1800000>;
> +
> +		esc-key {
> +			linux,code = <KEY_ESC>;
> +			label = "esc";
> +			press-threshold-microvolt = <1310000>;
> +		};
> +
> +		home-key {
> +			linux,code = <KEY_HOME>;
> +			label = "home";
> +			press-threshold-microvolt = <624000>;
> +		};
> +
> +		menu-key {
> +			linux,code = <KEY_MENU>;
> +			label = "menu";
> +			press-threshold-microvolt = <987000>;
> +		};
> +
> +		vol-down-key {
> +			linux,code = <KEY_VOLUMEDOWN>;
> +			label = "volume down";
> +			press-threshold-microvolt = <300000>;
> +		};
> +
> +		vol-up-key {
> +			linux,code = <KEY_VOLUMEUP>;
> +			label = "volume up";
> +			press-threshold-microvolt = <17000>;
> +		};
> +	};
> +
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 25000 0>;
> +		brightness-levels = <
> +			  0   1   2   3   4   5   6   7

There's a property now so you don't need to list out every step.

> +			  8   9  10  11  12  13  14  15
> +			 16  17  18  19  20  21  22  23
> +			 24  25  26  27  28  29  30  31
> +			 32  33  34  35  36  37  38  39
> +			 40  41  42  43  44  45  46  47
> +			 48  49  50  51  52  53  54  55
> +			 56  57  58  59  60  61  62  63
> +			 64  65  66  67  68  69  70  71
> +			 72  73  74  75  76  77  78  79
> +			 80  81  82  83  84  85  86  87
> +			 88  89  90  91  92  93  94  95
> +			 96  97  98  99 100 101 102 103
> +			104 105 106 107 108 109 110 111
> +			112 113 114 115 116 117 118 119
> +			120 121 122 123 124 125 126 127
> +			128 129 130 131 132 133 134 135
> +			136 137 138 139 140 141 142 143
> +			144 145 146 147 148 149 150 151
> +			152 153 154 155 156 157 158 159
> +			160 161 162 163 164 165 166 167
> +			168 169 170 171 172 173 174 175
> +			176 177 178 179 180 181 182 183
> +			184 185 186 187 188 189 190 191
> +			192 193 194 195 196 197 198 199
> +			200 201 202 203 204 205 206 207
> +			208 209 210 211 212 213 214 215
> +			216 217 218 219 220 221 222 223
> +			224 225 226 227 228 229 230 231
> +			232 233 234 235 236 237 238 239
> +			240 241 242 243 244 245 246 247
> +			248 249 250 251 252 253 254 255>;
> +		default-brightness-level = <200>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS2,1500000n8";
> +	};
> +
> +	sdio_pwrseq: sdio-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		/*clocks = <&rk809 1>;*/
> +		/*clock-names = "ext_clock";*/

Remove these if not used.

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_enable_h>;
> +
> +		/*
> +		 * On the module itself this is one of these (depending
> +		 * on the actual card populated):
> +		 * - SDIO_RESET_L_WL_REG_ON
> +		 * - PDN (power down when low)
> +		 */
> +		reset-gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>; /* GPIO3_A4 */
> +	};
> +
> +	vcc_phy: vcc-phy-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_phy";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vcc5v0_sys: vccsys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +
> +&display_subsystem {
> +	status = "okay";
> +};
> +
> +&emmc {
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&gmac {
> +	phy-supply = <&vcc_phy>;
> +	clock_in_out = "output";
> +	snps,reset-gpio = <&gpio2 13 GPIO_ACTIVE_LOW>;
> +	snps,reset-active-low;
> +	snps,reset-delays-us = <0 50000 50000>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	rk809: pmic@20 {
> +		compatible = "rockchip,rk809";
> +		reg = <0x20>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default", "pmic-sleep",
> +				"pmic-power-off", "pmic-reset";
> +		pinctrl-0 = <&pmic_int>;
> +		pinctrl-1 = <&soc_slppin_slp>, <&rk817_slppin_slp>;
> +		pinctrl-2 = <&soc_slppin_gpio>, <&rk817_slppin_pwrdn>;
> +		pinctrl-3 = <&soc_slppin_rst>, <&rk817_slppin_rst>;
> +		rockchip,system-power-controller;
> +		wakeup-source;
> +		#clock-cells = <1>;
> +		clock-output-names = "rk808-clkout1", "rk808-clkout2";
> +		//fb-inner-reg-idxs = <2>;
> +		/* 1: rst regs (default in codes), 0: rst the pmic */
> +		pmic-reset-func = <1>;
> +
> +		vcc1-supply = <&vcc5v0_sys>;
> +		vcc2-supply = <&vcc5v0_sys>;
> +		vcc3-supply = <&vcc5v0_sys>;
> +		vcc4-supply = <&vcc5v0_sys>;
> +		vcc5-supply = <&vcc3v3_sys>;
> +		vcc6-supply = <&vcc3v3_sys>;
> +		vcc7-supply = <&vcc3v3_sys>;
> +		vcc8-supply = <&vcc3v3_sys>;
> +		vcc9-supply = <&vcc5v0_sys>;
> +
> +		pwrkey {
> +			status = "okay";
> +		};
> +
> +		pinctrl_rk8xx: pinctrl_rk8xx {

gpio or pinctrl for the node name.

> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +			rk817_slppin_null: rk817_slppin_null {
> +				pins = "gpio_slp";
> +				function = "pin_fun0";
> +			};
> +
> +			rk817_slppin_slp: rk817_slppin_slp {
> +				pins = "gpio_slp";
> +				function = "pin_fun1";
> +			};
> +
> +			rk817_slppin_pwrdn: rk817_slppin_pwrdn {
> +				pins = "gpio_slp";
> +				function = "pin_fun2";
> +			};
> +
> +			rk817_slppin_rst: rk817_slppin_rst {
> +				pins = "gpio_slp";
> +				function = "pin_fun3";
> +			};
> +		};
> +
> +		regulators {
> +			vdd_logic: DCDC_REG1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <950000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +				regulator-initial-mode = <0x2>;
> +				regulator-name = "vdd_logic";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <950000>;
> +				};
> +			};
> +
> +			vdd_arm: DCDC_REG2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <950000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +				regulator-initial-mode = <0x2>;
> +				regulator-name = "vdd_arm";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <950000>;
> +				};
> +			};
> +
> +			vcc_ddr: DCDC_REG3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-name = "vcc_ddr";
> +				regulator-initial-mode = <0x2>;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc_3v0: DCDC_REG4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-initial-mode = <0x2>;
> +				regulator-name = "vcc_3v0";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3000000>;
> +				};
> +			};
> +
> +			vcc_1v0: LDO_REG1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-name = "vcc_1v0";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1000000>;
> +				};
> +			};
> +
> +			vcc1v8_soc: LDO_REG2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-name = "vcc1v8_soc";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vdd1v0_soc: LDO_REG3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +
> +				regulator-name = "vcc1v0_soc";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1000000>;
> +				};
> +			};
> +
> +			vcc3v0_pmu: LDO_REG4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +
> +				regulator-name = "vcc3v0_pmu";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3000000>;
> +
> +				};
> +			};
> +
> +			vccio_sd: LDO_REG5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-name = "vccio_sd";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vcc_sd: LDO_REG6 {
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-name = "vcc_sd";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +
> +				};
> +			};
> +
> +			vcc2v8_dvp: LDO_REG7 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +
> +				regulator-name = "vcc2v8_dvp";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <2800000>;
> +				};
> +			};
> +
> +			vcc1v8_dvp: LDO_REG8 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-name = "vcc1v8_dvp";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vdd1v5_dvp: LDO_REG9 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1500000>;
> +				regulator-max-microvolt = <1500000>;
> +
> +				regulator-name = "vdd1v5_dvp";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +					regulator-suspend-microvolt = <1500000>;
> +				};
> +			};
> +
> +			vcc3v3_sys: DCDC_REG5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc3v3_sys";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vcc3v3_lcd: SWITCH_REG1 {
> +				regulator-boot-on;
> +				regulator-name = "vcc3v3_lcd";
> +			};
> +
> +			vcc5v0_host: SWITCH_REG2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-name = "vcc5v0_host";
> +			};
> +		};
> +	};
> +};
> +
> +&i2s1_2ch {
> +	status = "okay";
> +	#sound-dai-cells = <0>;
> +};
> +
> +&io_domains {
> +	status = "okay";
> +
> +	vccio1-supply = <&vcc1v8_soc>;
> +	vccio2-supply = <&vccio_sd>;
> +	vccio3-supply = <&vcc_3v0>;
> +	vccio4-supply = <&vcc3v0_pmu>;
> +	vccio5-supply = <&vcc_3v0>;
> +};
> +
> +&pinctrl {
> +	headphone {
> +		hp_det: hp-det {
> +			rockchip,pins = <2 RK_PB0 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +	};
> +
> +	pmic {
> +		pmic_int: pmic_int {
> +			rockchip,pins =
> +				<0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
> +		soc_slppin_gpio: soc_slppin_gpio {
> +			rockchip,pins =
> +				<0 RK_PA4 RK_FUNC_GPIO &pcfg_output_low>;
> +		};
> +
> +		soc_slppin_slp: soc_slppin_slp {
> +			rockchip,pins =
> +				<0 RK_PA4 RK_FUNC_1 &pcfg_pull_none>;
> +		};
> +
> +		soc_slppin_rst: soc_slppin_rst {
> +			rockchip,pins =
> +				<0 RK_PA4 RK_FUNC_2 &pcfg_pull_none>;
> +		};
> +	};
> +
> +	sdio-pwrseq {
> +		wifi_enable_h: wifi-enable-h {
> +			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +};
> +
> +&pmu_io_domains {
> +	status = "okay";
> +
> +	pmuio1-supply = <&vcc3v0_pmu>;
> +	pmuio2-supply = <&vcc3v0_pmu>;
> +};
> +
> +&pwm1 {
> +	status = "okay";
> +};
> +
> +&saradc {
> +	status = "okay";
> +	vref-supply = <&vcc1v8_soc>;
> +};
> +
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-mmc-highspeed;
> +	cap-sd-highspeed;
> +	card-detect-delay = <800>;
> +	/*cd-gpios = <&gpio2 4 GPIO_ACTIVE_HIGH>; [> CD GPIO <]*/
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	vqmmc-supply = <&vccio_sd>;
> +	vmmc-supply = <&vcc_sd>;
> +	status = "okay";
> +};
> +
> +&sdio {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	keep-power-in-suspend;
> +	non-removable;
> +	mmc-pwrseq = <&sdio_pwrseq>;
> +	sd-uhs-sdr104;
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_xfer &uart1_cts>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&usb20_otg {
> +	status = "okay";
> +};
> +
> +&usb_host0_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host0_ohci {
> +	status = "okay";
> +};
> +
> +&vopb {
> +	status = "okay";
> +};
> +
> +&vopb_mmu {
> +	status = "okay";
> +};
> +
> +&vopl {
> +	status = "okay";
> +};
> +
> +&vopl_mmu {
> +	status = "okay";
> +};
> -- 
> 1.9.1
> 
> 
