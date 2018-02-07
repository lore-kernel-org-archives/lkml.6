Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753956AbeBGLbr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:31:47 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:40167 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753796AbeBGLbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:31:44 -0500
X-Google-Smtp-Source: AH8x224NOxzHrBmsakn3eQdrLVh+tSxdGW+jBjni0H+YdRudxr39K6+P4vKvtYMHA2EfIdVhYZZDHg==
Subject: Re: [PATCH v2 04/16] arm64: dts: mt7622: add pinctrl related device
 nodes
To: sean.wang@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1517910489.git.sean.wang@mediatek.com>
 <98781a6d32fcc8d42e4646a183246e70d5139154.1517910489.git.sean.wang@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <7f7d3d94-7d4e-9b66-048a-e100a45a2137@gmail.com>
Date: Wed, 7 Feb 2018 12:31:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <98781a6d32fcc8d42e4646a183246e70d5139154.1517910489.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/06/2018 10:52 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> add pinctrl device nodes and rfb1 board, additionally include all pin
> groups possible being used on rfb1 board and available gpio keys.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 200 +++++++++++++++++++++++++++
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi     |   7 +
>  2 files changed, 207 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> index c08309d..bd1093a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
> @@ -7,6 +7,8 @@
>   */
>  
>  /dts-v1/;
> +#include <dt-bindings/input/input.h>
> +
>  #include "mt7622.dtsi"
>  
>  / {
> @@ -17,11 +19,209 @@
>  		bootargs = "console=ttyS0,115200n1";
>  	};
>  
> +	gpio-keys {
> +		compatible = "gpio-keys-polled";
> +		poll-interval = <100>;
> +
> +		factory {
> +			label = "factory";
> +			linux,code = <BTN_0>;
> +			gpios = <&pio 0 0>;
> +		};
> +
> +		wps {
> +			label = "wps";
> +			linux,code = <KEY_WPS_BUTTON>;
> +			gpios = <&pio 102 0>;
> +		};
> +	};
> +
>  	memory {
>  		reg = <0 0x40000000 0 0x3F000000>;
>  	};
>  };
>  
> +&pio {
> +	/* eMMC is shared pin with parallel NAND */
> +	emmc_pins_default: emmc-pins-default {
> +		mux {
> +			function = "emmc", "emmc_rst";
> +			groups = "emmc";
> +		};
> +	};
> +
> +	emmc_pins_uhs: emmc-pins-uhs {
> +		mux {
> +			function = "emmc";
> +			groups = "emmc";
> +		};
> +	};
> +
> +	eth_pins: eth-pins {
> +		mux {
> +			function = "eth";
> +			groups = "mdc_mdio", "rgmii_via_gmac2";
> +		};
> +	};
> +
> +	i2c1_pins: i2c1-pins {
> +		mux {
> +			function = "i2c";
> +			groups =  "i2c1_0";
> +		};
> +	};
> +
> +	i2c2_pins: i2c2-pins {
> +		mux {
> +			function = "i2c";
> +			groups =  "i2c2_0";
> +		};
> +	};
> +
> +	i2s1_pins: i2s1-pins {
> +		mux {
> +			function = "i2s";
> +			groups =  "i2s_out_bclk_ws_mclk",
> +				  "i2s1_in_data",
> +				  "i2s1_out_data";
> +		};
> +	};
> +
> +	irrx_pins: irrx-pins {
> +		mux {
> +			function = "ir";
> +			groups =  "ir_1_rx";
> +		};
> +	};
> +
> +	irtx_pins: irtx-pins {
> +		mux {
> +			function = "ir";
> +			groups =  "ir_1_tx";
> +		};
> +	};
> +
> +	/* Parallel nand is shared pin with eMMC */
> +	parallel_nand_pins: parallel-nand-pins {
> +		mux {
> +			function = "flash";
> +			groups = "par_nand";
> +		};
> +	};
> +
> +	pcie0_pins: pcie0-pins {
> +		mux {
> +			groups = "pcie0_pad_perst",
> +				 "pcie0_1_waken",
> +				 "pcie0_1_clkreq";
> +			function = "pcie";
> +		};
> +	};
> +
> +	pcie1_pins: pcie1-pins {
> +		mux {
> +			groups = "pcie1_pad_perst",
> +				 "pcie1_0_waken",
> +				 "pcie1_0_clkreq";
> +			function = "pcie";
> +		};
> +	};
> +
> +	pmic_bus_pins: pmic-bus-pins {
> +		mux {
> +			groups = "pmic_bus";
> +			function = "pmic";
> +		};
> +	};

Some bikeshedding here. Can you please add function before groups, so that it is
uniform through out the file?

Thanks,
Matthias

> +
> +	pwm7_pins: pwm1-2-pins {
> +		mux {
> +			function = "pwm";
> +			groups = "pwm_ch7_2";
> +		};
> +	};
> +
> +	wled_pins: wled-pins {
> +		mux {
> +			function = "led";
> +			groups = "wled";
> +		};
> +	};
> +
> +	sd0_pins_default: sd0-pins-default {
> +		mux {
> +			function = "sd";
> +			groups = "sd_0";
> +		};
> +	};
> +
> +	sd0_pins_uhs: sd0-pins-uhs {
> +		mux {
> +			function = "sd";
> +			groups = "sd_0";
> +		};
> +	};
> +
> +	/* Serial NAND is shared pin with SPI-NOR */
> +	serial_nand_pins: serial-nand-pins {
> +		mux {
> +			function = "flash";
> +			groups = "snfi";
> +		};
> +	};
> +
> +	spic0_pins: spic0-pins {
> +		mux {
> +			function = "spi";
> +			groups = "spic0_0";
> +		};
> +	};
> +
> +	spic1_pins: spic1-pins {
> +		mux {
> +			function = "spi";
> +			groups = "spic1_0";
> +		};
> +	};
> +
> +	/* SPI-NOR is shared pin with serial NAND */
> +	spi_nor_pins: spi-nor-pins {
> +		mux {
> +			function = "flash";
> +			groups = "spi_nor";
> +		};
> +	};
> +
> +	/* serial NAND is shared pin with SPI-NOR */
> +	serial_nand_pins: serial-nand-pins {
> +		mux {
> +			function = "flash";
> +			groups = "snfi";
> +		};
> +	};
> +
> +	uart0_pins: uart0-pins {
> +		mux {
> +			function = "uart";
> +			groups = "uart0_0_tx_rx" ;
> +		};
> +	};
> +
> +	uart2_pins: uart2-pins {
> +		mux {
> +			function = "uart";
> +			groups = "uart2_1_tx_rx" ;
> +		};
> +	};
> +
> +	watchdog_pins: watchdog-pins {
> +		mux {
> +			function = "watchdog";
> +			groups = "watchdog";
> +		};
> +	};
> +};
> +
>  &uart0 {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index 81207e6..8211bf7 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -147,6 +147,13 @@
>  		#clock-cells = <1>;
>  	};
>  
> +	pio: pinctrl@10211000 {
> +		compatible = "mediatek,mt7622-pinctrl";
> +		reg = <0 0x10211000 0 0x1000>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +
>  	gic: interrupt-controller@10300000 {
>  		compatible = "arm,gic-400";
>  		interrupt-controller;
> 
