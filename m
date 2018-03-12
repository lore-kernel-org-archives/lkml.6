Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932231AbeCLPXM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:23:12 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43197 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbeCLPXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:23:10 -0400
X-Google-Smtp-Source: AG47ELs7k3GVh4CCS9YcBBbH7lH7D/gpkdvqWXn5zDsvZI5xT7zv3FFzTdkwFqa5FByIqr+mNeMZvhmDAMKC8w+064c=
MIME-Version: 1.0
In-Reply-To: <20180216024011.189157-3-brendanhiggins@google.com>
References: <20180216024011.189157-1-brendanhiggins@google.com> <20180216024011.189157-3-brendanhiggins@google.com>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Mon, 12 Mar 2018 17:23:08 +0200
Message-ID: <CAP6Zq1ioO6cGgEnH6niuYK0zP+aW05ykKUtkn8ckUKJvriu5wg@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] arm: dts: add Nuvoton NPCM750 device tree
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Avi Fishman <avifishman70@gmail.com>, julien.thierry@arm.com,
        pombredanne@nexb.com, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net,
        khilman@kernel.org, devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 February 2018 at 04:40, Brendan Higgins <brendanhiggins@google.com> wrote:
> Add a common device tree for all Nuvoton NPCM750 BMCs and a board
> specific device tree for the NPCM750 (Poleg) evaluation board.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>
> Reviewed-by: Avi Fishman <avifishman70@gmail.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Tested-by: Tomer Maimon <tmaimon77@gmail.com>
> Tested-by: Avi Fishman <avifishman70@gmail.com>
> Tested-by: Joel Stanley <joel@jms.id.au>
> ---
>  .../arm/cpu-enable-method/nuvoton,npcm750-smp |  42 +++++
>  .../devicetree/bindings/arm/npcm/npcm.txt     |   6 +
>  arch/arm/boot/dts/Makefile                    |   2 +
>  arch/arm/boot/dts/nuvoton-npcm750-evb.dts     |  35 ++++
>  arch/arm/boot/dts/nuvoton-npcm750.dtsi        | 165 ++++++++++++++++++
>  5 files changed, 250 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/cpu-enable-method/nuvoton,npcm750-smp
>  create mode 100644 Documentation/devicetree/bindings/arm/npcm/npcm.txt
>  create mode 100644 arch/arm/boot/dts/nuvoton-npcm750-evb.dts
>  create mode 100644 arch/arm/boot/dts/nuvoton-npcm750.dtsi
>
> diff --git a/Documentation/devicetree/bindings/arm/cpu-enable-method/nuvoton,npcm750-smp b/Documentation/devicetree/bindings/arm/cpu-enable-method/nuvoton,npcm750-smp
> new file mode 100644
> index 000000000000..8e043301e28e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cpu-enable-method/nuvoton,npcm750-smp
> @@ -0,0 +1,42 @@
Rob,

if will like to add new chip to enable the SMP (NPCM730).
what will be the best way to add it to the binding documentation file?

1. Do I need to add new binding file nuvoton,npcm730-smp?
2. Add nuvoton,npcm730-smp option to the current nuvoton,npcm750-smp file?
3. Modify the nuvoton,npcm750-smp binding name to nuvoton,npcm7xx-smp
and to describe both chips in it.


> +=========================================================
> +Secondary CPU enable-method "nuvoton,npcm750-smp" binding
> +=========================================================
> +
> +To apply to all CPUs, a single "nuvoton,npcm750-smp" enable method should be
> +defined in the "cpus" node.
> +
> +Enable method name:    "nuvoton,npcm750-smp"
> +Compatible machines:   "nuvoton,npcm750"
> +Compatible CPUs:       "arm,cortex-a9"
> +Related properties:    (none)
> +
> +Note:
> +This enable method needs valid nodes compatible with "arm,cortex-a9-scu" and
> +"nuvoton,npcm750-gcr".
> +
> +Example:
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               enable-method = "nuvoton,npcm750-smp";
> +
> +               cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a9";
> +                       clocks = <&clk NPCM7XX_CLK_CPU>;
> +                       clock-names = "clk_cpu";
> +                       reg = <0>;
> +                       next-level-cache = <&L2>;
> +               };
> +
> +               cpu@1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a9";
> +                       clocks = <&clk NPCM7XX_CLK_CPU>;
> +                       clock-names = "clk_cpu";
> +                       reg = <1>;
> +                       next-level-cache = <&L2>;
> +               };
> +       };
> +
> diff --git a/Documentation/devicetree/bindings/arm/npcm/npcm.txt b/Documentation/devicetree/bindings/arm/npcm/npcm.txt
> new file mode 100644
> index 000000000000..2d87d9ecea85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/npcm/npcm.txt
> @@ -0,0 +1,6 @@
> +NPCM Platforms Device Tree Bindings
> +-----------------------------------
> +NPCM750 SoC
> +Required root node properties:
> +       - compatible = "nuvoton,npcm750";
> +
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ade7a38543dc..eeab5dac50ab 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -304,6 +304,8 @@ dtb-$(CONFIG_ARCH_LPC18XX) += \
>  dtb-$(CONFIG_ARCH_LPC32XX) += \
>         lpc3250-ea3250.dtb \
>         lpc3250-phy3250.dtb
> +dtb-$(CONFIG_ARCH_NPCM750) += \
> +       nuvoton-npcm750-evb.dtb
>  dtb-$(CONFIG_MACH_MESON6) += \
>         meson6-atv1200.dtb
>  dtb-$(CONFIG_MACH_MESON8) += \
> diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
> new file mode 100644
> index 000000000000..cabde3d5be8a
> --- /dev/null
> +++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018 Nuvoton Technology corporation.
> +// Copyright 2018 Google, Inc.
> +
> +/dts-v1/;
> +#include "nuvoton-npcm750.dtsi"
> +
> +/ {
> +       model = "Nuvoton npcm750 Development Board (Device Tree)";
> +       compatible = "nuvoton,npcm750";
> +
> +       chosen {
> +               stdout-path = &serial3;
> +       };
> +
> +       memory {
> +               reg = <0 0x40000000>;
> +       };
> +};
> +
> +&serial0 {
> +       status = "okay";
> +};
> +
> +&serial1 {
> +       status = "okay";
> +};
> +
> +&serial2 {
> +       status = "okay";
> +};
> +
> +&serial3 {
> +       status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/nuvoton-npcm750.dtsi b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
> new file mode 100644
> index 000000000000..839e45cfd695
> --- /dev/null
> +++ b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018 Nuvoton Technology corporation.
> +// Copyright 2018 Google, Inc.
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       interrupt-parent = <&gic>;
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               enable-method = "nuvoton,npcm750-smp";
> +
> +               cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a9";
> +                       clocks = <&clk 10>;
> +                       clock-names = "clk_cpu";
> +                       reg = <0>;
> +                       next-level-cache = <&l2>;
> +               };
> +
> +               cpu@1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a9";
> +                       clocks = <&clk 10>;
> +                       clock-names = "clk_cpu";
> +                       reg = <1>;
> +                       next-level-cache = <&l2>;
> +               };
> +       };
> +
> +       /* external clock signal rg1refck, supplied by the phy */
> +       clk-rg1refck {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <125000000>;
> +       };
> +
> +       /* external clock signal rg2refck, supplied by the phy */
> +       clk-rg2refck {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <125000000>;
> +       };
> +
> +       clk-xin {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <50000000>;
> +       };
> +
> +       soc {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "simple-bus";
> +               interrupt-parent = <&gic>;
> +               ranges = <0x0 0xf0000000 0x00900000>;
> +
> +               gcr: gcr@800000 {
> +                       compatible = "nuvoton,npcm750-gcr", "syscon",
> +                               "simple-mfd";
> +                       reg = <0x800000 0x1000>;
> +               };
> +
> +               scu: scu@3fe000 {
> +                       compatible = "arm,cortex-a9-scu";
> +                       reg = <0x3fe000 0x1000>;
> +               };
> +
> +               l2: cache-controller@3fc000 {
> +                       compatible = "arm,pl310-cache";
> +                       reg = <0x3fc000 0x1000>;
> +                       interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +                       cache-unified;
> +                       cache-level = <2>;
> +                       clocks = <&clk 22>;
> +                       arm,shared-override;
> +               };
> +
> +               gic: interrupt-controller@3ff000 {
> +                       compatible = "arm,cortex-a9-gic";
> +                       interrupt-controller;
> +                       #interrupt-cells = <3>;
> +                       reg = <0x3ff000 0x1000>,
> +                           <0x3fe100 0x100>;
> +               };
> +
> +               timer@3fe600 {
> +                       compatible = "arm,cortex-a9-twd-timer";
> +                       reg = <0x3fe600 0x20>;
> +                       interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
> +                                                 IRQ_TYPE_LEVEL_HIGH)>;
> +                       clocks = <&clk 15>;
> +               };
> +       };
> +
> +       ahb {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "simple-bus";
> +               interrupt-parent = <&gic>;
> +               ranges;
> +
> +               clk: clock-controller@f0801000 {
> +                       compatible = "nuvoton,npcm750-clk";
> +                       #clock-cells = <1>;
> +                       reg = <0xf0801000 0x1000>;
> +               };
> +
> +               apb {
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       compatible = "simple-bus";
> +                       interrupt-parent = <&gic>;
> +                       ranges = <0x0 0xf0000000 0x00300000>;
> +
> +                       timer0: timer@8000 {
> +                               compatible = "nuvoton,npcm750-timer";
> +                               interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +                               reg = <0x8000 0x1000>;
> +                               clocks = <&clk 15>;
> +                       };
> +
> +                       serial0: serial@1000 {
> +                               compatible = "ns16550a";
> +                               reg = <0x1000 0x1000>;
> +                               clocks = <&clk 14>;
> +                               interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> +                               reg-shift = <2>;
> +                               status = "disabled";
> +                       };
> +
> +                       serial1: serial@2000 {
> +                               compatible = "ns16550a";
> +                               reg = <0x2000 0x1000>;
> +                               clocks = <&clk 14>;
> +                               interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> +                               reg-shift = <2>;
> +                               status = "disabled";
> +                       };
> +
> +                       serial2: serial@3000 {
> +                               compatible = "ns16550a";
> +                               reg = <0x3000 0x1000>;
> +                               clocks = <&clk 14>;
> +                               interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +                               reg-shift = <2>;
> +                               status = "disabled";
> +                       };
> +
> +                       serial3: serial@4000 {
> +                               compatible = "ns16550a";
> +                               reg = <0x4000 0x1000>;
> +                               clocks = <&clk 14>;
> +                               interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +                               reg-shift = <2>;
> +                               status = "disabled";
> +                       };
> +               };
> +       };
> +};
> --
> 2.16.1.291.g4437f3f132-goog
>

Thanks,

Tomer
