Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6730C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7849B214FA
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7849B214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389105AbeHGN6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:58:32 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:50727 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726902AbeHGN6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:58:31 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w77Bhqqg002107;
        Tue, 7 Aug 2018 13:44:12 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2knxjnadsc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 07 Aug 2018 13:44:12 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CC73431;
        Tue,  7 Aug 2018 11:44:11 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 94B1F2CE9;
        Tue,  7 Aug 2018 11:44:11 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.45) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 7 Aug
 2018 13:44:10 +0200
Subject: Re: [PATCH 2/3] ARM: dts: stm32: Fix DT dtc warnings for stm32f7
To:     <patrice.chotard@st.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <lee.jones@linaro.org>
CC:     <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1533639995-27047-1-git-send-email-patrice.chotard@st.com>
 <1533639995-27047-3-git-send-email-patrice.chotard@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <885922cf-0a95-d6e6-1061-8f934ca9dc44@st.com>
Date:   Tue, 7 Aug 2018 13:44:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1533639995-27047-3-git-send-email-patrice.chotard@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-07_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/07/2018 01:06 PM, patrice.chotard@st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> Fix the following DT dtc warnings for stm32f746 and stm32f769
> boards:
> 
> Warning (node_name_chars_strict): /soc/pin-controller/sdio_pins_a@0: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /soc/pin-controller/sdio_pins_od_a@0: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /soc/pin-controller/sdio_pins_b@0: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /soc/pin-controller/sdio_pins_od_b@0: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /gpio_keys: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /mmc_vcard: Character '_' not recommended in node name
> Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
> Warning (unit_address_vs_reg): /soc/pin-controller: node has a reg or ranges property, but no unit name
> Warning (unit_address_vs_reg): /soc/pin-controller/cec@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/usart1@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/i2c1@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/usbotg-hs@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/usbotg-hs@1: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/usbotg-fs@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/sdio_pins_a@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/sdio_pins_od_a@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/sdio_pins_b@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /soc/pin-controller/sdio_pins_od_b@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /gpio_keys/button@0: node has a unit name, but no reg property
> Warning (avoid_unnecessary_addr_size): /soc/timers@40001c00: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> Warning (avoid_unnecessary_addr_size): /soc/timers@40002000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> Warning (avoid_unnecessary_addr_size): /soc/timers@40014400: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> Warning (avoid_unnecessary_addr_size): /soc/timers@40014800: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>   arch/arm/boot/dts/stm32746g-eval.dts   |  9 ++++-----
>   arch/arm/boot/dts/stm32f7-pinctrl.dtsi | 24 ++++++++++++------------
>   arch/arm/boot/dts/stm32f746-disco.dts  |  6 +++---
>   arch/arm/boot/dts/stm32f746.dtsi       |  8 +++-----
>   arch/arm/boot/dts/stm32f769-disco.dts  | 11 +++++------
>   5 files changed, 27 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32746g-eval.dts b/arch/arm/boot/dts/stm32746g-eval.dts
> index 8c081eaf20fe..a2edf6fccc2c 100644
> --- a/arch/arm/boot/dts/stm32746g-eval.dts
> +++ b/arch/arm/boot/dts/stm32746g-eval.dts
> @@ -54,7 +54,7 @@
>   		stdout-path = "serial0:115200n8";
>   	};
>   
> -	memory {
> +	memory@c0000000 {
>   		reg = <0xc0000000 0x2000000>;
>   	};
>   
> @@ -73,12 +73,11 @@
>   		};
>   	};
>   
> -	gpio_keys {
> +	gpio-keys {
>   		compatible = "gpio-keys";
> -		#address-cells = <1>;
>   		#size-cells = <0>;
>   		autorepeat;
> -		button@0 {
> +		button {
>   			label = "Wake up";
>   			linux,code = <KEY_WAKEUP>;
>   			gpios = <&gpioc 13 0>;
> @@ -92,7 +91,7 @@
>   		clock-names = "main_clk";
>   	};
>   
> -	mmc_vcard: mmc_vcard {
> +	mmc_vcard: mmc-vcard {
>   		compatible = "regulator-fixed";
>   		regulator-name = "mmc_vcard";
>   		regulator-min-microvolt = <3300000>;
> diff --git a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
> index 9314128df185..702f1c12c22b 100644
> --- a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
> @@ -9,7 +9,7 @@
>   
>   / {
>   	soc {
> -		pinctrl: pin-controller {
> +		pinctrl: pin-controller@40020000 {
>   			#address-cells = <1>;
>   			#size-cells = <1>;
>   			ranges = <0 0x40020000 0x3000>;
> @@ -127,7 +127,7 @@
>   				st,bank-name = "GPIOK";
>   			};
>   
> -			cec_pins_a: cec@0 {
> +			cec_pins_a: cec {

IMO, you could used cec-0. It will avoid to rewrite this node if new cec 
pins groups is added.

>   				pins {
>   					pinmux = <STM32_PINMUX('A', 15, AF4)>; /* HDMI CEC */
>   					slew-rate = <0>;
> @@ -136,7 +136,7 @@
>   				};
>   			};
>   
> -			usart1_pins_a: usart1@0 {

You could use usart1-0

> +			usart1_pins_a: usart1-a {
>   				pins1 {
>   					pinmux = <STM32_PINMUX('A', 9, AF7)>; /* USART1_TX */
>   					bias-disable;
> @@ -149,7 +149,7 @@
>   				};
>   			};
>   
> -			usart1_pins_b: usart1@1 {

You could use usart1-1

> +			usart1_pins_b: usart1-b {
>   				pins1 {
>   					pinmux = <STM32_PINMUX('A', 9, AF7)>; /* USART1_TX */
>   					bias-disable;
> @@ -162,7 +162,7 @@
>   				};
>   			};
>   
> -			i2c1_pins_b: i2c1@0 {

ditto

> +			i2c1_pins_b: i2c1 {
>   				pins {
>   					pinmux = <STM32_PINMUX('B', 9, AF4)>, /* I2C1 SDA */
>   						 <STM32_PINMUX('B', 8, AF4)>; /* I2C1 SCL */
> @@ -172,7 +172,7 @@
>   				};
>   			};
>   
> -			usbotg_hs_pins_a: usbotg-hs@0 {

ditto

> +			usbotg_hs_pins_a: usbotg-hs-a {
>   				pins {
>   					pinmux = <STM32_PINMUX('H', 4, AF10)>, /* OTG_HS_ULPI_NXT */
>   						 <STM32_PINMUX('I', 11, AF10)>, /* OTG_HS_ULPI_DIR */
> @@ -192,7 +192,7 @@
>   				};
>   			};
>   
> -			usbotg_hs_pins_b: usbotg-hs@1 {

ditto

> +			usbotg_hs_pins_b: usbotg-hs-b {
>   				pins {
>   					pinmux = <STM32_PINMUX('H', 4, AF10)>, /* OTG_HS_ULPI_NXT */
>   						 <STM32_PINMUX('C', 2, AF10)>, /* OTG_HS_ULPI_DIR */
> @@ -212,7 +212,7 @@
>   				};
>   			};
>   
> -			usbotg_fs_pins_a: usbotg-fs@0 {

ditto

> +			usbotg_fs_pins_a: usbotg-fs {
>   				pins {
>   					pinmux = <STM32_PINMUX('A', 10, AF10)>, /* OTG_FS_ID */
>   						 <STM32_PINMUX('A', 11, AF10)>, /* OTG_FS_DM */
> @@ -223,7 +223,7 @@
>   				};
>   			};
>   
> -			sdio_pins_a: sdio_pins_a@0 {

ditto

> +			sdio_pins_a: sdio-pins-a {
>   				pins {
>   					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1 D0 */
>   						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1 D1 */
> @@ -236,7 +236,7 @@
>   				};
>   			};
>   
> -			sdio_pins_od_a: sdio_pins_od_a@0 {

ditto

> +			sdio_pins_od_a: sdio-pins-od-a {
>   				pins1 {
>   					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1 D0 */
>   						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1 D1 */
> @@ -254,7 +254,7 @@
>   				};
>   			};
>   
> -			sdio_pins_b: sdio_pins_b@0 {

ditto

> +			sdio_pins_b: sdio-pins-b {
>   				pins {
>   					pinmux = <STM32_PINMUX('G', 9, AF11)>, /* SDMMC2 D0 */
>   						 <STM32_PINMUX('G', 10, AF11)>, /* SDMMC2 D1 */
> @@ -267,7 +267,7 @@
>   				};
>   			};
>   
> -			sdio_pins_od_b: sdio_pins_od_b@0 {

you could use sdio_pins_od-0

> +			sdio_pins_od_b: sdio-pins-od-b {
>   				pins1 {
>   					pinmux = <STM32_PINMUX('G', 9, AF11)>, /* SDMMC2 D0 */
>   						 <STM32_PINMUX('G', 10, AF11)>, /* SDMMC2 D1 */
> diff --git a/arch/arm/boot/dts/stm32f746-disco.dts b/arch/arm/boot/dts/stm32f746-disco.dts
> index f9ad71f7c807..ccf9321926a4 100644
> --- a/arch/arm/boot/dts/stm32f746-disco.dts
> +++ b/arch/arm/boot/dts/stm32f746-disco.dts
> @@ -55,8 +55,8 @@
>   		stdout-path = "serial0:115200n8";
>   	};
>   
> -	memory {
> -		reg = <0xC0000000 0x800000>;
> +	memory@c0000000 {
> +		reg = <0xc0000000 0x800000>;
>   	};
>   
>   	aliases {
> @@ -78,7 +78,7 @@
>   		regulator-always-on;
>   	};
>   
> -	mmc_vcard: mmc_vcard {
> +	mmc_vcard: mmc-vcard {
>   		compatible = "regulator-fixed";
>   		regulator-name = "mmc_vcard";
>   		regulator-min-microvolt = <3300000>;
> diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
> index 1479e3eb05fa..18272dc4e2ca 100644
> --- a/arch/arm/boot/dts/stm32f746.dtsi
> +++ b/arch/arm/boot/dts/stm32f746.dtsi
> @@ -40,12 +40,14 @@
>    *     OTHER DEALINGS IN THE SOFTWARE.
>    */
>   
> -#include "skeleton.dtsi"
>   #include "armv7-m.dtsi"
>   #include <dt-bindings/clock/stm32fx-clock.h>
>   #include <dt-bindings/mfd/stm32f7-rcc.h>
>   
>   / {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
>   	clocks {
>   		clk_hse: clk-hse {
>   			#clock-cells = <0>;
> @@ -258,7 +260,6 @@
>   		};
>   
>   		timers13: timers@40001c00 {
> -			#address-cells = <1>;
>   			#size-cells = <0>;
>   			compatible = "st,stm32-timers";
>   			reg = <0x40001C00 0x400>;
> @@ -273,7 +274,6 @@
>   		};
>   
>   		timers14: timers@40002000 {
> -			#address-cells = <1>;
>   			#size-cells = <0>;
>   			compatible = "st,stm32-timers";
>   			reg = <0x40002000 0x400>;
> @@ -521,7 +521,6 @@
>   		};
>   
>   		timers10: timers@40014400 {
> -			#address-cells = <1>;
>   			#size-cells = <0>;
>   			compatible = "st,stm32-timers";
>   			reg = <0x40014400 0x400>;
> @@ -536,7 +535,6 @@
>   		};
>   
>   		timers11: timers@40014800 {
> -			#address-cells = <1>;
>   			#size-cells = <0>;
>   			compatible = "st,stm32-timers";
>   			reg = <0x40014800 0x400>;
> diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
> index 677276ba4dbe..d77300101e09 100644
> --- a/arch/arm/boot/dts/stm32f769-disco.dts
> +++ b/arch/arm/boot/dts/stm32f769-disco.dts
> @@ -55,8 +55,8 @@
>   		stdout-path = "serial0:115200n8";
>   	};
>   
> -	memory {
> -		reg = <0xC0000000 0x1000000>;
> +	memory@c0000000 {
> +		reg = <0xc0000000 0x1000000>;
>   	};
>   
>   	aliases {
> @@ -74,12 +74,11 @@
>   		};
>   	};
>   
> -	gpio_keys {
> +	gpio-keys {
>   		compatible = "gpio-keys";
> -		#address-cells = <1>;
>   		#size-cells = <0>;
>   		autorepeat;
> -		button@0 {
> +		button {
>   			label = "User";
>   			linux,code = <KEY_HOME>;
>   			gpios = <&gpioa 0 GPIO_ACTIVE_HIGH>;
> @@ -93,7 +92,7 @@
>   		clock-names = "main_clk";
>   	};
>   
> -	mmc_vcard: mmc_vcard {
> +	mmc_vcard: mmc-vcard {
>   		compatible = "regulator-fixed";
>   		regulator-name = "mmc_vcard";
>   		regulator-min-microvolt = <3300000>;
> 
