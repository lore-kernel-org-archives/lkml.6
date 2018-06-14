Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E06EEC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AF0208D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AF0208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755206AbeFNMwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:52:33 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:34134 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755111AbeFNMwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:52:30 -0400
X-IronPort-AV: E=Sophos;i="5.51,222,1526367600"; 
   d="scan'208";a="14941671"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Jun 2018 05:52:29 -0700
Received: from [10.159.245.112] (10.10.76.4) by chn-sv-exch07.mchp-main.com
 (10.10.76.108) with Microsoft SMTP Server id 14.3.352.0; Thu, 14 Jun 2018
 05:52:28 -0700
Subject: Re: [PATCH 1/4] arm: dts: add support for Laird WB45N cpu module and
 DVK
To:     Ben Whitten <ben.whitten@gmail.com>, <devicetree@vger.kernel.org>
CC:     Ben Whitten <ben.whitten@lairdtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1528966340-23216-1-git-send-email-ben.whitten@lairdtech.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <03f0f635-3fc2-085b-20e0-e1fcaa9e8062@microchip.com>
Date:   Thu, 14 Jun 2018 14:52:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528966340-23216-1-git-send-email-ben.whitten@lairdtech.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2018 at 10:51, Ben Whitten wrote:
> Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
> ---
>   arch/arm/boot/dts/Makefile        |   3 +-
>   arch/arm/boot/dts/at91-wb45n.dts  |  66 +++++++++++++++
>   arch/arm/boot/dts/at91-wb45n.dtsi | 169 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 237 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/boot/dts/at91-wb45n.dts
>   create mode 100644 arch/arm/boot/dts/at91-wb45n.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7e24249..1ee94ee 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -42,7 +42,8 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
>   	at91sam9g25ek.dtb \
>   	at91sam9g35ek.dtb \
>   	at91sam9x25ek.dtb \
> -	at91sam9x35ek.dtb
> +	at91sam9x35ek.dtb \
> +	at91-wb45n.dtb
>   dtb-$(CONFIG_SOC_SAM_V7) += \
>   	at91-kizbox2.dtb \
>   	at91-nattis-2-natte-2.dtb \
> diff --git a/arch/arm/boot/dts/at91-wb45n.dts b/arch/arm/boot/dts/at91-wb45n.dts
> new file mode 100644
> index 0000000..4e88815
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-wb45n.dts
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * at91-wb45n.dts - Device Tree file for WB45NBT board
> + *
> + *  Copyright (C) 2018 Laird
> + *
> +*/
> +/dts-v1/;
> +#include "at91-wb45n.dtsi"
> +
> +/ {
> +	model = "Laird Workgroup Bridge 45N - Atmel AT91SAM (dt)";
> +	compatible = "laird,wb45n", "laird,wbxx", "atmel,at91sam9x5", "atmel,at91sam9";

"laird" prefix must be added to 
Documentation/devicetree/bindings/vendor-prefixes.txt before using it: 
you can do a little patch as a first patch of this series.
Otherwise it will trigger a warning message while running 
scripts/checkpatch.pl on top of your patch.


> +
> +	ahb {
> +		apb {
> +			watchdog@fffffe40 {
> +				status = "okay";
> +			};
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		irqbtn@pb18 {

I'm not sure that the @pb18 can be used like this. This address 
extension must be used in a "reg" property in the node. dtc used with 
warning switch on might trigger an error for this.

> +			label = "IRQBTN";
> +			linux,code = <99>;
> +			gpios = <&pioB 18 GPIO_ACTIVE_LOW>;
> +			gpio-key,wakeup = <1>;
> +		};
> +	};
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	status = "okay";
> +};
> +
> +&spi0 {
> +	status = "okay";
> +};
> +
> +&macb0 {
> +	status = "okay";
> +};
> +
> +&dbgu {
> +	status = "okay";
> +};
> +
> +&usart0 {
> +	status = "okay";
> +};
> +
> +&usart3 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/at91-wb45n.dtsi b/arch/arm/boot/dts/at91-wb45n.dtsi
> new file mode 100644
> index 0000000..2fa58e2
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-wb45n.dtsi
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * at91-wb45n.dtsi - Device Tree file for WB45NBT board
> + *
> + *  Copyright (C) 2018 Laird
> + *
> + */
> +
> +#include "at91sam9g25.dtsi"
> +
> +/ {
> +	model = "Laird Workgroup Bridge 45N - Atmel AT91SAM (dt)";
> +	compatible = "laird,wb45n", "laird,wbxx", "atmel,at91sam9x5", "atmel,at91sam9";
> +
> +	chosen {
> +		bootargs = "ubi.mtd=6 root=ubi0:rootfs rootfstype=ubifs rw";
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory {
> +		reg = <0x20000000 0x4000000>;
> +	};
> +
> +	ahb {
> +		apb {
> +			shdwc@fffffe10 {

I would advice you to take exactly the node name:
"shutdown-controller@fffffe10"; Anyway, it will go away after you use 
the label notation as advised by Alexandre.

> +				atmel,wakeup-mode = "low";
> +			};
> +
> +			pinctrl@fffff400 {
> +				usb2 {
> +					pinctrl_board_usb2: usb2-board {
> +						atmel,pins =
> +							<AT91_PIOB 11 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;		/* PB11 gpio vbus sense, deglitch */
> +					};
> +				};
> +			};
> +
> +			rstc@fffffe00 {
> +				compatible = "atmel,sama5d3-rstc";
> +			};

I don't think this node is needed.

> +
> +		};
> +	};
> +
> +	atheros {
> +		compatible = "atheros,ath6kl";
> +		atheros,board-id = "SD32";
> +	};
> +};
> +
> +&slow_xtal {
> +	clock-frequency = <32768>;
> +};
> +
> +&main_xtal {
> +	clock-frequency = <12000000>;
> +};
> +
> +&ebi {
> +	status = "okay";
> +	nand_controller: nand-controller {
> +		pinctrl-0 = <&pinctrl_nand_cs &pinctrl_nand_rb &pinctrl_nand_oe_we>;
> +		pinctrl-names = "default";
> +		status = "okay";
> +
> +		nand@3 {
> +			reg = <0x3 0x0 0x800000>;
> +			rb-gpios = <&pioD 5 GPIO_ACTIVE_HIGH>;
> +			cs-gpios = <&pioD 4 GPIO_ACTIVE_HIGH>;
> +			nand-bus-width = <8>;
> +			nand-ecc-mode = "hw";
> +			nand-ecc-strength = <4>;
> +			nand-ecc-step-size = <512>;
> +			nand-on-flash-bbt;
> +			label = "atmel_nand";
> +
> +			partitions {
> +				compatible = "fixed-partitions";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				at91bootstrap@0 {
> +					label = "at91bs";
> +					reg = <0x0 0x20000>;
> +				};
> +
> +				uboot@20000 {
> +					label = "u-boot";
> +					reg = <0x20000 0x80000>;
> +				};
> +
> +				ubootenv@a0000 {
> +					label = "u-boot-env";
> +					reg = <0xa0000 0x20000>;
> +				};
> +
> +				ubootenv@c0000 {
> +					label = "redund-env";
> +					reg = <0xc0000 0x20000>;
> +				};
> +
> +				kernel-a@e0000 {
> +					label = "kernel-a";
> +					reg = <0xe0000 0x280000>;
> +				};
> +
> +				kernel-b@360000 {
> +					label = "kernel-b";
> +					reg = <0x360000 0x280000>;
> +				};
> +
> +				rootfs-a@5e0000 {
> +					label = "rootfs-a";
> +					reg = <0x5e0000 0x2600000>;
> +				};
> +
> +				rootfs-b@2be0000 {
> +					label = "rootfs-b";
> +					reg = <0x2be0000 0x2600000>;
> +				};
> +
> +				user@51e0000 {
> +					label = "user";
> +					reg = <0x51e0000 0x2dc0000>;
> +				};
> +
> +				logs@7fa0000 {
> +					label = "logs";
> +					reg = <0x7fa0000 0x60000>;
> +				};
> +
> +			};
> +		};
> +	};
> +};
> +
> +&usb0 {

This must be &usb1 label, isn't it?
Because you are referring to ohci binding I suspect (found by having a 
look at: atmel,oc-gpio property...).

> +	num-ports = <2>;
> +	atmel,vbus-gpio = <
> +		&pioB 12 GPIO_ACTIVE_HIGH
> +		&pioA 31 GPIO_ACTIVE_HIGH
> +		>;
> +	atmel,oc-gpio = <&pioB 13 GPIO_ACTIVE_LOW>;
> +};
> +
> +&macb0 {
> +	phy-mode = "rmii";
> +};
> +
> +&spi0 {
> +	cs-gpios = <&pioA 14 0>, <&pioA 7 0>, <0>, <0>;
> +};
> +
> +&usb2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_board_usb2>;
> +	atmel,vbus-gpio = <&pioB 11 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&mmc0 {
> +	pinctrl-0 = <
> +		&pinctrl_mmc0_slot0_clk_cmd_dat0
> +		&pinctrl_mmc0_slot0_dat1_3>;
> +	slot@0 {
> +		reg = <0>;
> +		bus-width = <4>;
> +	};
> +};
> 


-- 
Nicolas Ferre
