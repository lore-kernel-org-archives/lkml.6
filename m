Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752144AbeFEOFy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751912AbeFEOFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:05:51 -0400
X-Google-Smtp-Source: ADUXVKIO17LuO2BW2BJfuuSz93O+5DORdoI5IVMrpHaXv+xf0J2Ur5WdGhGu6lBOGCkn8OOTclVhGo5aV+fFgKmBcNg=
MIME-Version: 1.0
In-Reply-To: <20180605060510.32473-1-nm@ti.com>
References: <20180605060510.32473-1-nm@ti.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 5 Jun 2018 09:05:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJusWTvr4A_-Bk81meYddMHBMJ4=Fch6L0MFoF7HfBW2w@mail.gmail.com>
Message-ID: <CAL_JsqJusWTvr4A_-Bk81meYddMHBMJ4=Fch6L0MFoF7HfBW2w@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] arm64: dts: ti: Add Support for AM654 SoC
To: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 1:05 AM, Nishanth Menon <nm@ti.com> wrote:
> The AM654 SoC is a lead device of the K3 Multicore SoC architecture
> platform, targeted for broad market and industrial control with aim to
> meet the complex processing needs of modern embedded products.
>
> Some highlights of this SoC are:
> * Quad ARMv8 A53 cores split over two clusters
> * GICv3 compliant GIC500
> * Configurable L3 Cache and IO-coherent architecture
> * Dual lock-step capable R5F uC for safety-critical applications
> * High data throughput capable distributed DMA architecture under NAVSS
> * Three Gigabit Industrial Communication Subsystems (ICSSG), each with dual
>   PRUs and dual RTUs
> * Hardware accelerator block containing AES/DES/SHA/MD5 called SA2UL
> * Centralized System Controller for Security, Power, and Resource
>   management.
> * Dual ADCSS, eQEP/eCAP, eHRPWM, dual CAN-FD
> * Flash subystem with OSPI and Hyperbus interfaces
> * Multimedia capability with CAL, DSS7-UL, SGX544, McASP
> * Peripheral connectivity including USB3, PCIE, MMC/SD, GPMC, I2C, SPI,
>   GPIO
>
> See AM65x Technical Reference Manual (SPRUID7, April 2018)
> for further details: http://www.ti.com/lit/pdf/spruid7
>
> We introduce the Kconfig symbol for the SoC along with this patch since
> it is logically relevant point, however the usage is in subsequent
> patches.
>
> NOTE: AM654 is the first of the device variants, hence we introduce a
> generic am6.dtsi.
>
> Signed-off-by: Benjamin Fair <b-fair@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  MAINTAINERS                          |   1 +
>  arch/arm64/boot/dts/ti/k3-am6.dtsi   | 144 +++++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am654.dtsi | 117 ++++++++++++++++++++++++++++
>  drivers/soc/ti/Kconfig               |  14 ++++
>  4 files changed, 276 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am654.dtsi
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cfb35b252ac7..5f5c4eddec7a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2092,6 +2092,7 @@ M:        Nishanth Menon <nm@ti.com>
>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:     Supported
>  F:     Documentation/devicetree/bindings/arm/ti/k3.txt
> +F:     arch/arm64/boot/dts/ti/k3-*
>
>  ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
>  M:     Santosh Shilimkar <ssantosh@kernel.org>
> diff --git a/arch/arm64/boot/dts/ti/k3-am6.dtsi b/arch/arm64/boot/dts/ti/k3-am6.dtsi
> new file mode 100644
> index 000000000000..cdfa12173aac
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am6.dtsi
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for AM6 SoC Family
> + *
> + * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +       model = "Texas Instruments K3 AM654 SoC";
> +       compatible = "ti,am654";
> +       interrupt-parent = <&gic>;
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       aliases {
> +               serial0 = &wkup_uart0;
> +               serial1 = &mcu_uart0;
> +               serial2 = &main_uart0;
> +               serial3 = &main_uart1;
> +               serial4 = &main_uart2;
> +       };
> +
> +       chosen { };
> +
> +       firmware {
> +               optee {
> +                       compatible = "linaro,optee-tz";
> +                       method = "smc";
> +               };
> +
> +               psci: psci {
> +                       compatible = "arm,psci-1.0";
> +                       method = "smc";
> +               };
> +       };
> +
> +       soc0: soc0 {
> +               compatible = "simple-bus";
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;

Really need 64-bit addresses and sizes? Use ranges to limit the
address space if possible.

> +
> +               a53_timer0: timer-cl0-cpu0 {
> +                       compatible = "arm,armv8-timer";
> +                       interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* cntpsirq */
> +                                    <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* cntpnsirq */
> +                                    <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* cntvirq */
> +                                    <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* cnthpirq */
> +               };
> +
> +               pmu: pmu {
> +                       compatible = "arm,armv8-pmuv3";
> +                       /* Recommendation from GIC500 TRM Table A.3 */
> +                       interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +               };

These 2 nodes aren't on the bus, so move them up a level.

> +
> +               gic: interrupt-controller@1800000 {
> +                       compatible = "arm,gic-v3";

gic-500?

> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       ranges;
> +                       #interrupt-cells = <3>;
> +                       interrupt-controller;
> +                       /*
> +                        * NOTE: we are NOT gicv2 backward compat, so no GICC,
> +                        * GICH or GICV

The compatible should imply this.

> +                        */
> +                       reg = <0x0 0x01800000 0x0 0x10000>,     /* GICD */
> +                             <0x0 0x01880000 0x0 0x90000>;     /* GICR */
> +
> +                       /*
> +                        * vcpumntirq:
> +                        * virtual CPU interface maintenance interrupt
> +                        */
> +                       interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +
> +                       gic_its: gic-its@1000000 {
> +                               compatible = "arm,gic-v3-its";
> +                               reg = <0x0 0x1820000 0x0 0x10000>;
> +                               msi-controller;
> +                               #msi-cells = <1>;
> +                       };
> +               };
> +
> +               wkup_uart0: serial@42300000 {
> +                       compatible = "ti,am654-uart", "ti,omap4-uart", "ns16550a";
> +                       reg = <0x0 0x42300000 0x0 0x100>;
> +                       reg-shift = <2>;
> +                       reg-io-width = <4>;
> +                       interrupts = <GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>;
> +                       clock-frequency = <48000000>;
> +                       current-speed = <115200>;
> +                       status = "disabled";
> +               };
> +
> +               mcu_uart0: serial@40a00000 {
> +                       compatible = "ti,am654-uart", "ti,omap4-uart", "ns16550a";
> +                       reg = <0x0 0x40a00000 0x0 0x100>;
> +                       reg-shift = <2>;
> +                       reg-io-width = <4>;
> +                       interrupts = <GIC_SPI 565 IRQ_TYPE_LEVEL_HIGH>;
> +                       clock-frequency = <96000000>;
> +                       current-speed = <115200>;
> +                       status = "disabled";
> +               };
> +
> +               main_uart0: serial@2800000 {
> +                       compatible = "ti,am654-uart", "ti,omap4-uart", "ns16550a";
> +                       reg = <0x0 0x02800000 0x0 0x100>;
> +                       reg-shift = <2>;
> +                       reg-io-width = <4>;
> +                       interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
> +                       clock-frequency = <48000000>;
> +                       current-speed = <115200>;
> +                       status = "disabled";
> +               };
> +
> +               main_uart1: serial@2810000 {
> +                       compatible = "ti,am654-uart", "ti,omap4-uart", "ns16550a";
> +                       reg = <0x0 0x02810000 0x0 0x100>;
> +                       reg-shift = <2>;
> +                       reg-io-width = <4>;
> +                       interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
> +                       clock-frequency = <48000000>;
> +                       current-speed = <115200>;
> +                       status = "disabled";
> +               };
> +
> +               main_uart2: serial@2820000 {
> +                       compatible = "ti,am654-uart", "ti,omap4-uart", "ns16550a";
> +                       reg = <0x0 0x02820000 0x0 0x100>;
> +                       reg-shift = <2>;
> +                       reg-io-width = <4>;
> +                       interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
> +                       clock-frequency = <48000000>;
> +                       current-speed = <115200>;
> +                       status = "disabled";
> +               };
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am654.dtsi b/arch/arm64/boot/dts/ti/k3-am654.dtsi
> new file mode 100644
> index 000000000000..d9b70081daba
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am654.dtsi
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for AM6 SoC family in Quad core configuration
> + *
> + * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#include "k3-am6.dtsi"
> +
> +/ {
> +       cpus: cpus {

Really need a label?

> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               cpu-map {

IIRC, this goes at the top level.

> +                       cluster0: cluster0 {
> +                               core0 {
> +                                       cpu = <&cpu0>;
> +                               };
> +
> +                               core1 {
> +                                       cpu = <&cpu1>;
> +                               };
> +                       };
> +
> +                       cluster1: cluster1 {
> +                               core0 {
> +                                       cpu = <&cpu2>;
> +                               };
> +
> +                               core1 {
> +                                       cpu = <&cpu3>;
> +                               };
> +                       };
> +               };
> +
> +               cpu0: cpu@0 {
> +                       compatible = "arm,cortex-a53","arm,armv8";

space between compatibles.

> +                       reg = <0x000>;
> +                       device_type = "cpu";
> +                       enable-method = "psci";

> +                       i-cache-size = <0x8000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <256>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;

All this should be discoverable.

> +                       next-level-cache = <&L2_0>;
> +               };
> +
> +               cpu1: cpu@1 {
> +                       compatible = "arm,cortex-a53","arm,armv8";
> +                       reg = <0x001>;
> +                       device_type = "cpu";
> +                       enable-method = "psci";
> +                       i-cache-size = <0x8000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <256>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       next-level-cache = <&L2_0>;
> +               };
> +
> +               cpu2: cpu@100 {
> +                       compatible = "arm,cortex-a53","arm,armv8";
> +                       reg = <0x100>;
> +                       device_type = "cpu";
> +                       enable-method = "psci";
> +                       i-cache-size = <0x8000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <256>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       next-level-cache = <&L2_1>;
> +               };
> +
> +               cpu3: cpu@101 {
> +                       compatible = "arm,cortex-a53","arm,armv8";
> +                       reg = <0x101>;
> +                       device_type = "cpu";
> +                       enable-method = "psci";
> +                       i-cache-size = <0x8000>;
> +                       i-cache-line-size = <64>;
> +                       i-cache-sets = <256>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <64>;
> +                       d-cache-sets = <128>;
> +                       next-level-cache = <&L2_1>;
> +               };
> +       };
> +};
> +
> +&soc0 {
> +       L2_0: l2-cache0 {
> +               compatible = "cache";

Is this documented?

> +               cache-level = <2>;
> +               cache-size = <0x80000>;
> +               cache-line-size = <64>;
> +               cache-sets = <512>;

Discoverable?

> +               next-level-cache = <&msmc_l3>;
> +       };
> +
> +       L2_1: l2-cache1 {
> +               compatible = "cache";
> +               cache-level = <2>;
> +               cache-size = <0x80000>;
> +               cache-line-size = <64>;
> +               cache-sets = <512>;
> +               next-level-cache = <&msmc_l3>;
> +       };
> +
> +       msmc_l3: l3-cache0 {
> +               compatible = "cache";

Is this something TI specific or follows the (ARM) architecture?

> +               cache-level = <3>;
> +       };
> +};
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index 92770d84a288..be4570baad96 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -1,3 +1,17 @@
> +# 64-bit ARM SoCs from TI
> +if ARM64
> +
> +if ARCH_K3
> +
> +config ARCH_K3_AM6_SOC

This should be in another patch (or dropped?).

> +       bool "K3 AM6 SoC"
> +       help
> +         Enable support for TI's AM6 SoC Family support
> +
> +endif
> +
> +endif
> +
>  #
>  # TI SOC drivers
>  #
> --
> 2.15.1
>
