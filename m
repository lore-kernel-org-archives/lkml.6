Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbeBAQlq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:41:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:43960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751526AbeBAQln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:41:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34232178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AH8x224wdFzSwtF5kYebzmyBW+4BAM4OurH/SSsf6mvkFWFHSbiHKoiVTGcbX1K0fepVgJqqUgvGgT+T45HZBRyVBgM=
MIME-Version: 1.0
In-Reply-To: <7dd5614c878adb30e38caf4002921c0ca995329c.1516366474.git.michal.simek@xilinx.com>
References: <cover.1516366474.git.michal.simek@xilinx.com> <7dd5614c878adb30e38caf4002921c0ca995329c.1516366474.git.michal.simek@xilinx.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 1 Feb 2018 10:41:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKdEdyQP8maUmM39fvsAUcrvf6=_g21aRiaXqyv-ZogBw@mail.gmail.com>
Message-ID: <CAL_JsqKdEdyQP8maUmM39fvsAUcrvf6=_g21aRiaXqyv-ZogBw@mail.gmail.com>
Subject: Re: [PATCH 1/7] arm64: zynqmp: Add support for Xilinx zcu100-revC
To: Michal Simek <michal.simek@xilinx.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2018 at 6:55 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> This board has 2GB of memory, i2c, sd, wifi sdio, spis, uarts, display
> port and usbs.
> Board is using fixed clocks because clock driver hasn't been merged yet.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/arm64/boot/dts/xilinx/Makefile               |   1 +
>  arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi        | 213 ++++++++++++++++
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 298 ++++++++++++++++++++++
>  3 files changed, 512 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>
> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
> index eba179b23b17..7266a6a9c0cd 100644
> --- a/arch/arm64/boot/dts/xilinx/Makefile
> +++ b/arch/arm64/boot/dts/xilinx/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-ep108.dtb
> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu100-revC.dtb
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
> new file mode 100644
> index 000000000000..9c09baca7dd7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
> @@ -0,0 +1,213 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Clock specification for Xilinx ZynqMP
> + *
> + * (C) Copyright 2015 - 2018, Xilinx, Inc.
> + *
> + * Michal Simek <michal.simek@xilinx.com>
> + */
> +
> +/ {
> +       clk100: clk100 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <100000000>;
> +       };
> +
> +       clk125: clk125 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <125000000>;
> +       };
> +
> +       clk200: clk200 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <200000000>;
> +       };
> +
> +       clk250: clk250 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <250000000>;
> +       };
> +
> +       clk300: clk300 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <300000000>;
> +       };
> +
> +       clk600: clk600 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <600000000>;
> +       };
> +
> +       dp_aclk: clock0 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <100000000>;
> +               clock-accuracy = <100>;
> +       };
> +
> +       dp_aud_clk: clock1 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <24576000>;
> +               clock-accuracy = <100>;
> +       };
> +
> +       dpdma_clk: dpdma_clk {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0x0>;
> +               clock-frequency = <533000000>;
> +       };
> +
> +       drm_clock: drm_clock {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0x0>;
> +               clock-frequency = <262750000>;
> +               clock-accuracy = <0x64>;
> +       };
> +};
> +
> +&can0 {
> +       clocks = <&clk100 &clk100>;
> +};
> +
> +&can1 {
> +       clocks = <&clk100 &clk100>;
> +};
> +
> +&fpd_dma_chan1 {
> +       clocks = <&clk600>, <&clk100>;
> +};
> +
> +&fpd_dma_chan2 {
> +       clocks = <&clk600>, <&clk100>;
> +};
> +
> +&fpd_dma_chan3 {
> +       clocks = <&clk600>, <&clk100>;
> +};
> +
> +&fpd_dma_chan4 {
> +       clocks = <&clk600>, <&clk100>;
> +};
> +
> +&fpd_dma_chan5 {
> +       clocks = <&clk600>, <&clk100>;
> +};
> +
> +&fpd_dma_chan6 {
> +       clocks = <&clk600>, <&clk100>;
> +};
> +
> +&fpd_dma_chan7 {
> +       clocks = <&clk600>, <&clk100>;
> +};
> +
> +&fpd_dma_chan8 {
> +       clocks = <&clk600>, <&clk100>;
> +};
> +
> +&lpd_dma_chan1 {
> +       clocks = <&clk600>, <&clk100>;
> +};
> +
> +&lpd_dma_chan2 {
> +       clocks = <&clk600>, <&clk100>;
> +};
> +
> +&lpd_dma_chan3 {
> +       clocks = <&clk600>, <&clk100>;
> +};
> +
> +&lpd_dma_chan4 {
> +       clocks = <&clk600>, <&clk100>;
> +};
> +
> +&lpd_dma_chan5 {
> +       clocks = <&clk600>, <&clk100>;
> +};
> +
> +&lpd_dma_chan6 {
> +       clocks = <&clk600>, <&clk100>;
> +};
> +
> +&lpd_dma_chan7 {
> +       clocks = <&clk600>, <&clk100>;
> +};
> +
> +&lpd_dma_chan8 {
> +       clocks = <&clk600>, <&clk100>;
> +};
> +
> +&gem0 {
> +       clocks = <&clk125>, <&clk125>, <&clk125>;
> +};
> +
> +&gem1 {
> +       clocks = <&clk125>, <&clk125>, <&clk125>;
> +};
> +
> +&gem2 {
> +       clocks = <&clk125>, <&clk125>, <&clk125>;
> +};
> +
> +&gem3 {
> +       clocks = <&clk125>, <&clk125>, <&clk125>;
> +};
> +
> +&gpio {
> +       clocks = <&clk100>;
> +};
> +
> +&i2c0 {
> +       clocks = <&clk100>;
> +};
> +
> +&i2c1 {
> +       clocks = <&clk100>;
> +};
> +
> +&sata {
> +       clocks = <&clk250>;
> +};
> +
> +&sdhci0 {
> +       clocks = <&clk200 &clk200>;
> +};
> +
> +&sdhci1 {
> +       clocks = <&clk200 &clk200>;
> +};
> +
> +&spi0 {
> +       clocks = <&clk200 &clk200>;
> +};
> +
> +&spi1 {
> +       clocks = <&clk200 &clk200>;
> +};
> +
> +&uart0 {
> +       clocks = <&clk100 &clk100>;
> +};
> +
> +&uart1 {
> +       clocks = <&clk100 &clk100>;
> +};
> +
> +&usb0 {
> +       clocks = <&clk250>, <&clk250>;
> +};
> +
> +&usb1 {
> +       clocks = <&clk250>, <&clk250>;
> +};
> +
> +&watchdog0 {
> +       clocks = <&clk250>;
> +};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> new file mode 100644
> index 000000000000..01f5f95806d3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -0,0 +1,298 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * dts file for Xilinx ZynqMP ZCU100 revC
> + *
> + * (C) Copyright 2016 - 2018, Xilinx, Inc.
> + *
> + * Michal Simek <michal.simek@xilinx.com>
> + * Nathalie Chan King Choy <nathalie@xilinx.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "zynqmp.dtsi"
> +#include "zynqmp-clk.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +       model = "ZynqMP ZCU100 RevC";
> +       compatible = "xlnx,zynqmp-zcu100-revC", "xlnx,zynqmp-zcu100", "xlnx,zynqmp";

Documented?

> +
> +       aliases {
> +               gpio0 = &gpio;

Drop this.

> +               i2c0 = &i2c1;
> +               rtc0 = &rtc;

Is there more than one?

> +               serial0 = &uart1;
> +               serial1 = &uart0;
> +               serial2 = &dcc;
> +               spi0 = &spi0;
> +               spi1 = &spi1;

> +               usb0 = &usb0;
> +               usb1 = &usb1;

Drop these.

> +               mmc0 = &sdhci0;
> +               mmc1 = &sdhci1;
> +       };
> +
> +       chosen {
> +               bootargs = "earlycon";
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       memory@0 {
> +               device_type = "memory";
> +               reg = <0x0 0x0 0x0 0x80000000>;
> +       };
> +
> +       gpio-keys {
> +               compatible = "gpio-keys";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               autorepeat;
> +               sw4 {
> +                       label = "sw4";
> +                       gpios = <&gpio 23 GPIO_ACTIVE_LOW>;
> +                       linux,code = <KEY_POWER>;
> +                       gpio-key,wakeup;
> +                       autorepeat;
> +               };
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +               ds2 {
> +                       label = "ds2";
> +                       gpios = <&gpio 20 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "heartbeat";
> +               };
> +
> +               ds3 {
> +                       label = "ds3";
> +                       gpios = <&gpio 19 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "phy0tx"; /* WLAN tx */
> +                       default-state = "off";
> +               };
> +
> +               ds4 {
> +                       label = "ds4";
> +                       gpios = <&gpio 18 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "phy0rx"; /* WLAN rx */
> +                       default-state = "off";
> +               };
> +
> +               ds5 {
> +                       label = "ds5";
> +                       gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "bluetooth-power";
> +               };
> +
> +               vbus_det { /* U5 USB5744 VBUS detection via MIO25 */
> +                       label = "vbus_det";
> +                       gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
> +                       default-state = "on";
> +               };
> +
> +               bt_power {
> +                       label = "bt_power";
> +                       gpios = <&gpio 8 GPIO_ACTIVE_HIGH>;
> +                       default-state = "on";
> +               };
> +       };
> +
> +       wmmcsdio_fixed: fixedregulator-mmcsdio {
> +               compatible = "regulator-fixed";
> +               regulator-name = "wmmcsdio_fixed";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               regulator-always-on;
> +               regulator-boot-on;
> +       };
> +
> +       sdio_pwrseq: sdio_pwrseq {
> +               compatible = "mmc-pwrseq-simple";
> +               reset-gpios = <&gpio 7 GPIO_ACTIVE_LOW>; /* WIFI_EN */
> +       };
> +};
> +
> +&dcc {
> +       status = "okay";
> +};
> +
> +&gpio {
> +       status = "okay";
> +       gpio-line-names = "UART1_TX", "UART1_RX", "UART0_RX", "UART0_TX", "I2C1_SCL",
> +                         "I2C1_SDA", "SPI1_SCLK", "WLAN_EN", "BT_EN", "SPI1_CS",
> +                         "SPI1_MISO", "SPI1_MOSI", "I2C_MUX_RESET", "SD0_DAT0", "SD0_DAT1",
> +                         "SD0_DAT2", "SD0_DAT3", "PS_LED3", "PS_LED2", "PS_LED1",
> +                         "PS_LED0", "SD0_CMD", "SD0_CLK", "GPIO_PB", "SD0_DETECT",
> +                         "VBUS_DET", "POWER_INT", "DP_AUX", "DP_HPD", "DP_OE",
> +                         "DP_AUX_IN", "INA226_ALERT", "PS_FP_PWR_EN", "PL_PWR_EN", "POWER_KILL",
> +                         "", "GPIO-A", "GPIO-B", "SPI0_SCLK", "GPIO-C",
> +                         "GPIO-D", "SPI0_CS", "SPI0_MISO", "SPI_MOSI", "GPIO-E",
> +                         "GPIO-F", "SD1_D0", "SD1_D1", "SD1_D2", "SD1_D3",
> +                         "SD1_CMD", "SD1_CLK", "USB0_CLK", "USB0_DIR", "USB0_DATA2",
> +                         "USB0_NXT", "USB0_DATA0", "USB0_DATA1", "USB0_STP", "USB0_DATA3",
> +                         "USB0_DATA4", "USB0_DATA5", "USB0_DATA6", "USB0_DATA7", "USB1_CLK",
> +                         "USB1_DIR", "USB1_DATA2", "USB1_NXT", "USB1_DATA0", "USB1_DATA1",
> +                         "USB1_STP", "USB1_DATA3", "USB1_DATA4", "USB1_DATA5", "USB1_DATA6",
> +                         "USB_DATA7", "WLAN_IRQ", "PMIC_IRQ", /* MIO end and EMIO start */
> +                         "", "",
> +                         "", "", "", "", "", "", "", "", "", "",
> +                         "", "", "", "", "", "", "", "", "", "",
> +                         "", "", "", "", "", "", "", "", "", "",
> +                         "", "", "", "", "", "", "", "", "", "",
> +                         "", "", "", "", "", "", "", "", "", "",
> +                         "", "", "", "", "", "", "", "", "", "",
> +                         "", "", "", "", "", "", "", "", "", "",
> +                         "", "", "", "", "", "", "", "", "", "",
> +                         "", "", "", "", "", "", "", "", "", "",
> +                         "", "", "", "";
> +};
> +
> +&i2c1 {
> +       status = "okay";
> +       clock-frequency = <100000>;
> +       i2cswitch@75 { /* u11 */

i2c-mux@75

> +               compatible = "nxp,pca9548";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x75>;
> +               i2csw_0: i2c@0 { /* i2c mw 75 0 1 */

Linux commands for comments aren't relevant to dts files.

> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0>;
> +                       /*
> +                        * LSEXP_I2C0

Is this a 96boards design? If so, using "label" and with defined names
is somewhat standard for defining low speed connector ports (and for
LEDs). That should also remove any need for using aliases for I2C and
SPI. Look at hikey or db410c.

> +                        */
> +               };
> +               i2csw_1: i2c@1 { /* i2c mw 75 0 2 */
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <1>;
> +                       /*
> +                        * LSEXP_I2C1
> +                        */
> +               };
> +               i2csw_2: i2c@2 { /* i2c mw 75 0 4 */
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <2>;
> +                       /*
> +                        * HSEXP_I2C2
> +                        */
> +               };
> +               i2csw_3: i2c@3 { /* i2c mw 75 0 8 */
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <3>;
> +                       /*
> +                        * HSEXP_I2C3
> +                        */
> +               };
> +               i2csw_4: i2c@4 { /* i2c mw 75 0 10 */
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x4>;
> +
> +                       pmic: tps65086x@5e { /* Custom TI PMIC u33 */

pmic@5e

> +                               compatible = "ti,tps65086";
> +                               reg = <0x5e>;
> +                               interrupt-parent = <&gpio>;
> +                               interrupts = <77 GPIO_ACTIVE_LOW>;
> +                               #gpio-cells = <2>;
> +                               gpio-controller;
> +                       };
> +               };
> +               i2csw_5: i2c@5 { /* i2c mw 75 0 20 */
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <5>;
> +                       /* PS_PMBUS */
> +                       ina226@40 { /* u35 */
> +                               compatible = "ti,ina226";
> +                               reg = <0x40>;
> +                               shunt-resistor = <10000>;
> +                               /* MIO31 is alert which should be routed to PMUFW */
> +                       };
> +               };
> +               i2csw_6: i2c@6 { /* i2c mw 75 0 40 */
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <6>;
> +                       /*
> +                        * Not Connected
> +                        */
> +               };
> +               i2csw_7: i2c@7 { /* i2c mw 75 0 80 */
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <7>;
> +                       /*
> +                        * usb5744 (DNP) - U5
> +                        * 100kHz - this is default freq for us
> +                        */
> +               };
> +       };
> +};
> +
> +&rtc {
> +       status = "okay";
> +};
> +
> +/* SD0 only supports 3.3V, no level shifter */
> +&sdhci0 {
> +       status = "okay";
> +       no-1-8-v;
> +       broken-cd; /* CD has to be enabled by default */
> +       disable-wp;
> +};
> +
> +&sdhci1 {
> +       status = "okay";
> +       bus-width = <0x4>;
> +       non-removable;
> +       disable-wp;
> +       cap-power-off-card;
> +       mmc-pwrseq = <&sdio_pwrseq>;
> +       vqmmc-supply = <&wmmcsdio_fixed>;
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       wlcore: wlcore@2 {

wifi@2

> +               compatible = "ti,wl1831";
> +               reg = <2>;
> +               interrupt-parent = <&gpio>;
> +               interrupts = <76 IRQ_TYPE_EDGE_RISING>; /* MIO76 WLAN_IRQ 1V8 */
> +       };
> +};
> +
> +&spi0 { /* Low Speed connector */
> +       status = "okay";
> +};
> +
> +&spi1 { /* High Speed connector */
> +       status = "okay";
> +};
> +
> +&uart0 {
> +       status = "okay";
> +};
> +
> +&uart1 {
> +       status = "okay";
> +
> +};
> +
> +/* ULPI SMSC USB3320 */
> +&usb0 {
> +       status = "okay";
> +};
> +
> +/* ULPI SMSC USB3320 */
> +&usb1 {
> +       status = "okay";
> +};
> +
> +&watchdog0 {
> +       status = "okay";
> +};
> --
> 1.9.1
>
