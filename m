Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeBAQq4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:46:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:44254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751526AbeBAQqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:46:54 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D292178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AH8x224fELFVghlj+4KTf9AUYgfXeKY1T6unuH4GlC1LuqFJ0yuN84aF0H1UyGd1D67Pjq5XfXHfB4nG07cFZthHngk=
MIME-Version: 1.0
In-Reply-To: <63760114db981535bf22c25be2daf0049f1b9709.1516366474.git.michal.simek@xilinx.com>
References: <cover.1516366474.git.michal.simek@xilinx.com> <63760114db981535bf22c25be2daf0049f1b9709.1516366474.git.michal.simek@xilinx.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 1 Feb 2018 10:46:31 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+N-_8s0d=jD=fMD4y7e76M=tT0kt2vsH0kbOqs-eQ95w@mail.gmail.com>
Message-ID: <CAL_Jsq+N-_8s0d=jD=fMD4y7e76M=tT0kt2vsH0kbOqs-eQ95w@mail.gmail.com>
Subject: Re: [PATCH 2/7] arm64: zynqmp: Add support for Xilinx zcu102
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
> This patch is adding revA, revB and rev1.0. There are also other
> revisions between which should be backward compatible with previous
> versions. Unfortunately all revs are still in use.

Similar comments to the 1st patch. I won't repeat them here.

>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/arm64/boot/dts/xilinx/Makefile                |   3 +
>  .../arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts |  36 ++
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  | 556 +++++++++++++++++++++
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts  |  42 ++
>  4 files changed, 637 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
>
> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
> index 7266a6a9c0cd..24e3ce801304 100644
> --- a/arch/arm64/boot/dts/xilinx/Makefile
> +++ b/arch/arm64/boot/dts/xilinx/Makefile
> @@ -1,3 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-ep108.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu100-revC.dtb
> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revA.dtb
> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-revB.dtb
> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu102-rev1.0.dtb
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> new file mode 100644
> index 000000000000..4b7477795fbd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * dts file for Xilinx ZynqMP ZCU102 Rev1.0
> + *
> + * (C) Copyright 2016 - 2018, Xilinx, Inc.
> + *
> + * Michal Simek <michal.simek@xilinx.com>
> + */
> +
> +#include "zynqmp-zcu102-revB.dts"
> +
> +/ {
> +       model = "ZynqMP ZCU102 Rev1.0";
> +       compatible = "xlnx,zynqmp-zcu102-rev1.0", "xlnx,zynqmp-zcu102", "xlnx,zynqmp";

Documented?

> +};
> +
> +&eeprom {
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +
> +       board_sn: board_sn@0 {

Use '-' rather than '_' in node and property names.

> +               reg = <0x0 0x14>;
> +       };
> +
> +       eth_mac: eth_mac@20 {
> +               reg = <0x20 0x6>;
> +       };
> +
> +       board_name: board_name@d0 {
> +               reg = <0xd0 0x6>;
> +       };
> +
> +       board_revision: board_revision@e0 {
> +               reg = <0xe0 0x3>;
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> new file mode 100644
> index 000000000000..6a15aacf65ef
> --- /dev/null
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -0,0 +1,556 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * dts file for Xilinx ZynqMP ZCU102 RevA
> + *
> + * (C) Copyright 2015 - 2018, Xilinx, Inc.
> + *
> + * Michal Simek <michal.simek@xilinx.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "zynqmp.dtsi"
> +#include "zynqmp-clk.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +       model = "ZynqMP ZCU102 RevA";
> +       compatible = "xlnx,zynqmp-zcu102-revA", "xlnx,zynqmp-zcu102", "xlnx,zynqmp";
> +
> +       aliases {
> +               ethernet0 = &gem3;
> +               gpio0 = &gpio;
> +               i2c0 = &i2c0;
> +               i2c1 = &i2c1;
> +               mmc0 = &sdhci1;
> +               rtc0 = &rtc;
> +               serial0 = &uart0;
> +               serial1 = &uart1;
> +               serial2 = &dcc;
> +               usb0 = &usb0;
> +       };
> +
> +       chosen {
> +               bootargs = "earlycon";
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       memory@0 {
> +               device_type = "memory";
> +               reg = <0x0 0x0 0x0 0x80000000>, <0x8 0x00000000 0x0 0x80000000>;
> +       };
> +
> +       gpio-keys {
> +               compatible = "gpio-keys";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               autorepeat;
> +               sw19 {
> +                       label = "sw19";
> +                       gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
> +                       linux,code = <KEY_DOWN>;
> +                       gpio-key,wakeup;
> +                       autorepeat;
> +               };
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +               heartbeat_led {
> +                       label = "heartbeat";
> +                       gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
> +                       linux,default-trigger = "heartbeat";
> +               };
> +       };
> +};
> +
> +&can1 {
> +       status = "okay";
> +};
> +
> +&dcc {
> +       status = "okay";
> +};
> +
> +&fpd_dma_chan1 {
> +       status = "okay";
> +};
> +
> +&fpd_dma_chan2 {
> +       status = "okay";
> +};
> +
> +&fpd_dma_chan3 {
> +       status = "okay";
> +};
> +
> +&fpd_dma_chan4 {
> +       status = "okay";
> +};
> +
> +&fpd_dma_chan5 {
> +       status = "okay";
> +};
> +
> +&fpd_dma_chan6 {
> +       status = "okay";
> +};
> +
> +&fpd_dma_chan7 {
> +       status = "okay";
> +};
> +
> +&fpd_dma_chan8 {
> +       status = "okay";
> +};
> +
> +&gem3 {
> +       status = "okay";
> +       phy-handle = <&phy0>;
> +       phy-mode = "rgmii-id";
> +       phy0: phy@21 {
> +               reg = <21>;
> +               ti,rx-internal-delay = <0x8>;
> +               ti,tx-internal-delay = <0xa>;
> +               ti,fifo-depth = <0x1>;
> +       };
> +};
> +
> +&gpio {
> +       status = "okay";
> +};
> +
> +&i2c0 {
> +       status = "okay";
> +       clock-frequency = <400000>;
> +
> +       tca6416_u97: gpio@20 {
> +               /*
> +                * Enable all GTs to out from U-Boot
> +                * i2c mw 20 6 0  - setup IO to output
> +                * i2c mw 20 2 ef - setup output values on pins 0-7
> +                * i2c mw 20 3 ff - setup output values on pins 10-17
> +                */
> +               compatible = "ti,tca6416";
> +               reg = <0x20>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +               /*
> +                * IRQ not connected
> +                * Lines:
> +                * 0 - PS_GTR_LAN_SEL0
> +                * 1 - PS_GTR_LAN_SEL1
> +                * 2 - PS_GTR_LAN_SEL2
> +                * 3 - PS_GTR_LAN_SEL3
> +                * 4 - PCI_CLK_DIR_SEL
> +                * 5 - IIC_MUX_RESET_B
> +                * 6 - GEM3_EXP_RESET_B
> +                * 7, 10 - 17 - not connected
> +                */
> +
> +               gtr_sel0 {
> +                       gpio-hog;
> +                       gpios = <0 0>;
> +                       output-low; /* PCIE = 0, DP = 1 */
> +                       line-name = "sel0";
> +               };
> +               gtr_sel1 {
> +                       gpio-hog;
> +                       gpios = <1 0>;
> +                       output-high; /* PCIE = 0, DP = 1 */
> +                       line-name = "sel1";
> +               };
> +               gtr_sel2 {
> +                       gpio-hog;
> +                       gpios = <2 0>;
> +                       output-high; /* PCIE = 0, USB0 = 1 */
> +                       line-name = "sel2";
> +               };
> +               gtr_sel3 {
> +                       gpio-hog;
> +                       gpios = <3 0>;
> +                       output-high; /* PCIE = 0, SATA = 1 */
> +                       line-name = "sel3";
> +               };
> +       };
> +
> +       tca6416_u61: gpio@21 { /* enable it by i2c mw 21 6 0 */
> +               compatible = "ti,tca6416";
> +               reg = <0x21>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +               /*
> +                * IRQ not connected
> +                * Lines:
> +                * 0 - VCCPSPLL_EN
> +                * 1 - MGTRAVCC_EN
> +                * 2 - MGTRAVTT_EN
> +                * 3 - VCCPSDDRPLL_EN
> +                * 4 - MIO26_PMU_INPUT_LS
> +                * 5 - PL_PMBUS_ALERT
> +                * 6 - PS_PMBUS_ALERT
> +                * 7 - MAXIM_PMBUS_ALERT
> +                * 10 - PL_DDR4_VTERM_EN
> +                * 11 - PL_DDR4_VPP_2V5_EN
> +                * 12 - PS_DIMM_VDDQ_TO_PSVCCO_ON
> +                * 13 - PS_DIMM_SUSPEND_EN
> +                * 14 - PS_DDR4_VTERM_EN
> +                * 15 - PS_DDR4_VPP_2V5_EN
> +                * 16 - 17 - not connected
> +                */
> +       };
> +
> +       i2cswitch@75 { /* u60 */
> +               compatible = "nxp,pca9544";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x75>;
> +               i2c@0 { /* i2c mw 75 0 1 */
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0>;
> +                       /* PS_PMBUS */
> +                       ina226@40 { /* u76 */

Should be what the device does, not part numbers if possible. Standard
names are defined in the DT spec (additions welcome).

> +                               compatible = "ti,ina226";
> +                               reg = <0x40>;
> +                               shunt-resistor = <5000>;
> +                       };
> +                       ina226@41 { /* u77 */
> +                               compatible = "ti,ina226";
> +                               reg = <0x41>;
> +                               shunt-resistor = <5000>;
> +                       };
> +                       ina226@42 { /* u78 */
> +                               compatible = "ti,ina226";
> +                               reg = <0x42>;
> +                               shunt-resistor = <5000>;
> +                       };
> +                       ina226@43 { /* u87 */
> +                               compatible = "ti,ina226";
> +                               reg = <0x43>;
> +                               shunt-resistor = <5000>;
> +                       };
> +                       ina226@44 { /* u85 */
> +                               compatible = "ti,ina226";
> +                               reg = <0x44>;
> +                               shunt-resistor = <5000>;
> +                       };
> +                       ina226@45 { /* u86 */
> +                               compatible = "ti,ina226";
> +                               reg = <0x45>;
> +                               shunt-resistor = <5000>;
> +                       };
> +                       ina226@46 { /* u93 */
> +                               compatible = "ti,ina226";
> +                               reg = <0x46>;
> +                               shunt-resistor = <5000>;
> +                       };
> +                       ina226@47 { /* u88 */
> +                               compatible = "ti,ina226";
> +                               reg = <0x47>;
> +                               shunt-resistor = <5000>;
> +                       };
> +                       ina226@4a { /* u15 */
> +                               compatible = "ti,ina226";
> +                               reg = <0x4a>;
> +                               shunt-resistor = <5000>;
> +                       };
> +                       ina226@4b { /* u92 */
> +                               compatible = "ti,ina226";
> +                               reg = <0x4b>;
> +                               shunt-resistor = <5000>;
> +                       };
> +               };
> +               i2c@1 { /* i2c mw 75 0 1 */
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <1>;
> +                       /* PL_PMBUS */
> +                       ina226@40 { /* u79 */
> +                               compatible = "ti,ina226";
> +                               reg = <0x40>;
> +                               shunt-resistor = <2000>;
> +                       };
> +                       ina226@41 { /* u81 */
> +                               compatible = "ti,ina226";
> +                               reg = <0x41>;
> +                               shunt-resistor = <5000>;
> +                       };
> +                       ina226@42 { /* u80 */
> +                               compatible = "ti,ina226";
> +                               reg = <0x42>;
> +                               shunt-resistor = <5000>;
> +                       };
> +                       ina226@43 { /* u84 */
> +                               compatible = "ti,ina226";
> +                               reg = <0x43>;
> +                               shunt-resistor = <5000>;
> +                       };
> +                       ina226@44 { /* u16 */
> +                               compatible = "ti,ina226";
> +                               reg = <0x44>;
> +                               shunt-resistor = <5000>;
> +                       };
> +                       ina226@45 { /* u65 */
> +                               compatible = "ti,ina226";
> +                               reg = <0x45>;
> +                               shunt-resistor = <5000>;
> +                       };
> +                       ina226@46 { /* u74 */
> +                               compatible = "ti,ina226";
> +                               reg = <0x46>;
> +                               shunt-resistor = <5000>;
> +                       };
> +                       ina226@47 { /* u75 */
> +                               compatible = "ti,ina226";
> +                               reg = <0x47>;
> +                               shunt-resistor = <5000>;
> +                       };
> +               };
> +               i2c@2 { /* i2c mw 75 0 1 */
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <2>;
> +                       /* MAXIM_PMBUS - 00 */
> +                       max15301@a { /* u46 */
> +                               compatible = "maxim,max15301";
> +                               reg = <0xa>;
> +                       };
> +                       max15303@b { /* u4 */
> +                               compatible = "maxim,max15303";
> +                               reg = <0xb>;
> +                       };
> +                       max15303@10 { /* u13 */
> +                               compatible = "maxim,max15303";
> +                               reg = <0x10>;
> +                       };
> +                       max15301@13 { /* u47 */
> +                               compatible = "maxim,max15301";
> +                               reg = <0x13>;
> +                       };
> +                       max15303@14 { /* u7 */
> +                               compatible = "maxim,max15303";
> +                               reg = <0x14>;
> +                       };
> +                       max15303@15 { /* u6 */
> +                               compatible = "maxim,max15303";
> +                               reg = <0x15>;
> +                       };
> +                       max15303@16 { /* u10 */
> +                               compatible = "maxim,max15303";
> +                               reg = <0x16>;
> +                       };
> +                       max15303@17 { /* u9 */
> +                               compatible = "maxim,max15303";
> +                               reg = <0x17>;
> +                       };
> +                       max15301@18 { /* u63 */
> +                               compatible = "maxim,max15301";
> +                               reg = <0x18>;
> +                       };
> +                       max15303@1a { /* u49 */
> +                               compatible = "maxim,max15303";
> +                               reg = <0x1a>;
> +                       };
> +                       max15303@1d { /* u18 */
> +                               compatible = "maxim,max15303";
> +                               reg = <0x1d>;
> +                       };
> +                       max15303@20 { /* u8 */
> +                               compatible = "maxim,max15303";
> +                               status = "disabled"; /* unreachable */
> +                               reg = <0x20>;
> +                       };
> +
> +                       max20751@72 { /* u95 */
> +                               compatible = "maxim,max20751";
> +                               reg = <0x72>;
> +                       };
> +                       max20751@73 { /* u96 */
> +                               compatible = "maxim,max20751";
> +                               reg = <0x73>;
> +                       };
> +               };
> +               /* Bus 3 is not connected */
> +       };
> +};
> +
> +&i2c1 {
> +       status = "okay";
> +       clock-frequency = <400000>;
> +
> +       /* PL i2c via PCA9306 - u45 */
> +       i2cswitch@74 { /* u34 */
> +               compatible = "nxp,pca9548";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x74>;
> +               i2c@0 { /* i2c mw 74 0 1 */
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0>;
> +                       /*
> +                        * IIC_EEPROM 1kB memory which uses 256B blocks
> +                        * where every block has different address.
> +                        *    0 - 256B address 0x54
> +                        * 256B - 512B address 0x55
> +                        * 512B - 768B address 0x56
> +                        * 768B - 1024B address 0x57
> +                        */
> +                       eeprom: eeprom@54 { /* u23 */
> +                               compatible = "atmel,24c08";
> +                               reg = <0x54>;
> +                       };
> +               };
> +               i2c@1 { /* i2c mw 74 0 2 */
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <1>;
> +                       si5341: clock-generator1@36 { /* SI5341 - u69 */

Drop the 1 on clock-generator1.

> +                               reg = <0x36>;
> +                       };
> +
> +               };
> +               i2c@2 { /* i2c mw 74 0 4 */
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <2>;
> +                       si570_1: clock-generator2@5d { /* USER SI570 - u42 */
> +                               #clock-cells = <0>;
> +                               compatible = "silabs,si570";
> +                               reg = <0x5d>;
> +                               temperature-stability = <50>;
> +                               factory-fout = <300000000>;
> +                               clock-frequency = <300000000>;
> +                       };
> +               };
> +               i2c@3 { /* i2c mw 74 0 8 */
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <3>;
> +                       si570_2: clock-generator3@5d { /* USER MGT SI570 - u56 */
> +                               #clock-cells = <0>;
> +                               compatible = "silabs,si570";
> +                               reg = <0x5d>;
> +                               temperature-stability = <50>; /* copy from zc702 */
> +                               factory-fout = <156250000>;
> +                               clock-frequency = <148500000>;
> +                       };
> +               };
> +               i2c@4 { /* i2c mw 74 0 10 */
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <4>;
> +                       si5328: clock-generator4@69 {/* SI5328 - u20 */
> +                               reg = <0x69>;
> +                               /*
> +                                * Chip has interrupt present connected to PL
> +                                * interrupt-parent = <&>;
> +                                * interrupts = <>;
> +                                */
> +                       };
> +               };
> +               /* 5 - 7 unconnected */
> +       };
> +
> +       i2cswitch@75 {
> +               compatible = "nxp,pca9548"; /* u135 */
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x75>;
> +
> +               i2c@0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0>;
> +                       /* HPC0_IIC */
> +               };
> +               i2c@1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <1>;
> +                       /* HPC1_IIC */
> +               };
> +               i2c@2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <2>;
> +                       /* SYSMON */
> +               };
> +               i2c@3 { /* i2c mw 75 0 8 */
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <3>;
> +                       /* DDR4 SODIMM */
> +               };
> +               i2c@4 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <4>;
> +                       /* SEP 3 */
> +               };
> +               i2c@5 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <5>;
> +                       /* SEP 2 */
> +               };
> +               i2c@6 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <6>;
> +                       /* SEP 1 */
> +               };
> +               i2c@7 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <7>;
> +                       /* SEP 0 */
> +               };
> +       };
> +};
> +
> +&pcie {
> +       status = "okay";
> +};
> +
> +&rtc {
> +       status = "okay";
> +};
> +
> +&sata {
> +       status = "okay";
> +       /* SATA OOB timing settings */
> +       ceva,p0-cominit-params = /bits/ 8 <0x18 0x40 0x18 0x28>;
> +       ceva,p0-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
> +       ceva,p0-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
> +       ceva,p0-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
> +       ceva,p1-cominit-params = /bits/ 8 <0x18 0x40 0x18 0x28>;
> +       ceva,p1-comwake-params = /bits/ 8 <0x06 0x14 0x08 0x0E>;
> +       ceva,p1-burst-params = /bits/ 8 <0x13 0x08 0x4A 0x06>;
> +       ceva,p1-retry-params = /bits/ 16 <0x96A4 0x3FFC>;
> +};
> +
> +/* SD1 with level shifter */
> +&sdhci1 {
> +       status = "okay";
> +       no-1-8-v;
> +};
> +
> +&uart0 {
> +       status = "okay";
> +};
> +
> +&uart1 {
> +       status = "okay";
> +};
> +
> +/* ULPI SMSC USB3320 */
> +&usb0 {
> +       status = "okay";
> +};
> +
> +&watchdog0 {
> +       status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
> new file mode 100644
> index 000000000000..ed3cc684931f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * dts file for Xilinx ZynqMP ZCU102 RevB
> + *
> + * (C) Copyright 2016 - 2018, Xilinx, Inc.
> + *
> + * Michal Simek <michal.simek@xilinx.com>
> + */
> +
> +#include "zynqmp-zcu102-revA.dts"
> +
> +/ {
> +       model = "ZynqMP ZCU102 RevB";
> +       compatible = "xlnx,zynqmp-zcu102-revB", "xlnx,zynqmp-zcu102", "xlnx,zynqmp";
> +};
> +
> +&gem3 {
> +       phy-handle = <&phyc>;
> +       phyc: phy@c {
> +               reg = <0xc>;
> +               ti,rx-internal-delay = <0x8>;
> +               ti,tx-internal-delay = <0xa>;
> +               ti,fifo-depth = <0x1>;
> +       };
> +       /* Cleanup from RevA */
> +       /delete-node/ phy@21;
> +};
> +
> +/* Different qspi 512Mbit version */
> +
> +/* Fix collision with u61 */
> +&i2c0 {
> +       i2cswitch@75 {
> +               i2c@2 {
> +                       max15303@1b { /* u8 */
> +                               compatible = "maxim,max15303";
> +                               reg = <0x1b>;
> +                       };
> +                       /delete-node/ max15303@20;
> +               };
> +       };
> +};
> --
> 1.9.1
>
