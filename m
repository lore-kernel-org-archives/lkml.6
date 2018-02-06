Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753440AbeBFUbb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 15:31:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751632AbeBFUba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 15:31:30 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58AD6217AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AH8x225jbC8nqihtf32tEpOon67zMg5uT+LyGdtGeBBOpA77k7BoDCESwNKVeS702IgiekAquHjkmecxSJpVHgMtn1A=
MIME-Version: 1.0
In-Reply-To: <20180125163216.29018-2-rnayak@codeaurora.org>
References: <20180125163216.29018-1-rnayak@codeaurora.org> <20180125163216.29018-2-rnayak@codeaurora.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 6 Feb 2018 14:31:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLb4PQ+NkA_RBAgB-5MzFKd+6wBvfCjXvoH-i8pGzzdTg@mail.gmail.com>
Message-ID: <CAL_JsqLb4PQ+NkA_RBAgB-5MzFKd+6wBvfCjXvoH-i8pGzzdTg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2018 at 10:32 AM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> Add a skeletal sdm845 SoC dtsi and MTP board dts/dtsi files
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile        |   1 +
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts  |  13 ++
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dtsi |  11 ++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi     | 308 +++++++++++++++++++++++++++++++
>  4 files changed, 333 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 55ec5ee7f7e8..c57701bed084 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -6,3 +6,4 @@ dtb-$(CONFIG_ARCH_QCOM) += msm8916-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8992-bullhead-rev-101.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8994-angler-rev-101.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8996-mtp.dtb
> +dtb-$(CONFIG_ARCH_QCOM) += sdm845-mtp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> new file mode 100644
> index 000000000000..95e41e42bee1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "sdm845-mtp.dtsi"
> +
> +/ {
> +       model = "Qualcomm Technologies, Inc. SDM845 MTP";
> +       compatible = "qcom,sdm845-mtp";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dtsi b/arch/arm64/boot/dts/qcom/sdm845-mtp.dtsi
> new file mode 100644
> index 000000000000..5b1022c20bad
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dtsi
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include "sdm845.dtsi"
> +
> +/ {
> +       soc {
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> new file mode 100644
> index 000000000000..a21f4912b3e2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -0,0 +1,308 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +       model = "Qualcomm Technologies, Inc. SDM845";

This should only be in the board level file.

> +
> +       interrupt-parent = <&intc>;
> +
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       chosen { };
> +
> +       memory {
> +               device_type = "memory";
> +               /* We expect the bootloader to fill in the reg */

The start address is variable? If not you should populate the base and
have a unit-address.

> +               reg = <0 0 0 0>;
> +       };
> +
> +       cpus {
> +               #address-cells = <2>;
> +               #size-cells = <0>;
> +
> +               CPU0: cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "qcom,kryo";
> +                       reg = <0x0 0x0>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&L2_0>;
> +                       L2_0: l2-cache {
> +                               compatible = "cache";
> +                               next-level-cache = <&L3_0>;
> +                               L3_0: l3-cache {
> +                                     compatible = "cache";
> +                               };
> +                       };
> +               };
> +
> +               CPU1: cpu@100 {
> +                       device_type = "cpu";
> +                       compatible = "qcom,kryo";
> +                       reg = <0x0 0x100>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&L2_100>;
> +                       L2_100: l2-cache {
> +                               compatible = "cache";
> +                               next-level-cache = <&L3_0>;
> +                       };
> +               };
> +
> +               CPU2: cpu@200 {
> +                       device_type = "cpu";
> +                       compatible = "qcom,kryo";
> +                       reg = <0x0 0x200>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&L2_200>;
> +                       L2_200: l2-cache {
> +                               compatible = "cache";
> +                               next-level-cache = <&L3_0>;
> +                       };
> +               };
> +
> +               CPU3: cpu@300 {
> +                       device_type = "cpu";
> +                       compatible = "qcom,kryo";
> +                       reg = <0x0 0x300>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&L2_300>;
> +                       L2_300: l2-cache {
> +                               compatible = "cache";
> +                               next-level-cache = <&L3_0>;
> +                       };
> +               };
> +
> +               CPU4: cpu@400 {
> +                       device_type = "cpu";
> +                       compatible = "qcom,kryo";
> +                       reg = <0x0 0x400>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&L2_400>;
> +                       L2_400: l2-cache {
> +                               compatible = "cache";
> +                               next-level-cache = <&L3_0>;
> +                       };
> +               };
> +
> +               CPU5: cpu@500 {
> +                       device_type = "cpu";
> +                       compatible = "qcom,kryo";
> +                       reg = <0x0 0x500>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&L2_500>;
> +                       L2_500: l2-cache {
> +                               compatible = "cache";
> +                               next-level-cache = <&L3_0>;
> +                       };
> +               };
> +
> +               CPU6: cpu@600 {
> +                       device_type = "cpu";
> +                       compatible = "qcom,kryo";
> +                       reg = <0x0 0x600>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&L2_600>;
> +                       L2_600: l2-cache {
> +                               compatible = "cache";
> +                               next-level-cache = <&L3_0>;
> +                       };
> +               };
> +
> +               CPU7: cpu@700 {
> +                       device_type = "cpu";
> +                       compatible = "qcom,kryo";
> +                       reg = <0x0 0x700>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&L2_700>;
> +                       L2_700: l2-cache {
> +                               compatible = "cache";
> +                               next-level-cache = <&L3_0>;
> +                       };
> +               };
> +
> +               cpu-map {
> +                       cluster0 {
> +                               core0 {
> +                                       cpu = <&CPU0>;
> +                               };
> +
> +                               core1 {
> +                                       cpu = <&CPU1>;
> +                               };
> +
> +                               core2 {
> +                                       cpu = <&CPU2>;
> +                               };
> +
> +                               core3 {
> +                                       cpu = <&CPU3>;
> +                               };
> +                       };
> +
> +                       cluster1 {
> +                               core0 {
> +                                       cpu = <&CPU4>;
> +                               };
> +
> +                               core1 {
> +                                       cpu = <&CPU5>;
> +                               };
> +
> +                               core2 {
> +                                       cpu = <&CPU6>;
> +                               };
> +
> +                               core3 {
> +                                       cpu = <&CPU7>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       timer {
> +               compatible = "arm,armv8-timer";
> +               interrupts = <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +                            <GIC_PPI 0 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +       };
> +
> +       clocks {
> +               xo_board: xo_board {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <19200000>;
> +                       clock-output-names = "xo_board";
> +               };
> +
> +               sleep_clk: sleep_clk {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <32764>;
> +                       clock-output-names = "sleep_clk";
> +               };
> +       };
> +
> +       psci {
> +               compatible = "arm,psci-1.0";
> +               method = "smc";
> +       };
> +
> +       soc: soc {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges = <0 0 0 0xffffffff>;
> +               compatible = "simple-bus";
> +
> +               intc: interrupt-controller@17a00000 {
> +                       compatible = "arm,gic-v3";
> +                       #interrupt-cells = <3>;
> +                       interrupt-controller;
> +                       #redistributor-regions = <1>;
> +                       redistributor-stride = <0x0 0x20000>;
> +                       reg = <0x17a00000 0x10000>,     /* GICD */
> +                             <0x17a60000 0x100000>;    /* GICR * 8 */
> +                       interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +               };
> +
> +               gcc: clock-controller@100000 {
> +                       compatible = "qcom,gcc-sdm845";

sdm845-gcc is the preferred order.

> +                       reg = <0x100000 0x1f0000>;
> +                       #clock-cells = <1>;
> +                       #reset-cells = <1>;
> +               };
> +
> +               tlmm: pinctrl@03400000 {
> +                       compatible = "qcom,sdm845-pinctrl";
> +                       reg = <0x03400000 0xc00000>;
> +                       interrupts = <GIC_SPI 208 IRQ_TYPE_NONE>;
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +
> +               timer@17C90000 {
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +                       compatible = "arm,armv7-timer-mem";
> +                       reg = <0x17C90000 0x1000>;
> +                       clock-frequency = <19200000>;
> +
> +                       frame@17CA0000 {
> +                               frame-number = <0>;
> +                               interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +                                            <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +                               reg = <0x17CA0000 0x1000>,
> +                                     <0x17CB0000 0x1000>;
> +                       };
> +
> +                       frame@17cc0000 {
> +                               frame-number = <1>;
> +                               interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> +                               reg = <0x17cc0000 0x1000>;
> +                               status = "disabled";
> +                       };
> +
> +                       frame@17cd0000 {
> +                               frame-number = <2>;
> +                               interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +                               reg = <0x17cd0000 0x1000>;
> +                               status = "disabled";
> +                       };
> +
> +                       frame@17ce0000 {
> +                               frame-number = <3>;
> +                               interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +                               reg = <0x17ce0000 0x1000>;
> +                               status = "disabled";
> +                       };
> +
> +                       frame@17cf0000 {
> +                               frame-number = <4>;
> +                               interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +                               reg = <0x17cf0000 0x1000>;
> +                               status = "disabled";
> +                       };
> +
> +                       frame@17d00000 {
> +                               frame-number = <5>;
> +                               interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +                               reg = <0x17d00000 0x1000>;
> +                               status = "disabled";
> +                       };
> +
> +                       frame@17d10000 {
> +                               frame-number = <6>;
> +                               interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +                               reg = <0x17d10000 0x1000>;
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               spmi_bus: qcom,spmi@c440000 {

spmi@...

> +                       compatible = "qcom,spmi-pmic-arb";
> +                       reg = <0xc440000 0x1100>,
> +                             <0xc600000 0x2000000>,
> +                             <0xe600000 0x100000>,
> +                             <0xe700000 0xa0000>,
> +                             <0xc40a000 0x26000>;
> +                       reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
> +                       interrupt-names = "periph_irq";
> +                       interrupts = <GIC_SPI 481 IRQ_TYPE_NONE>;
> +                       qcom,ee = <0>;
> +                       qcom,channel = <0>;
> +                       #address-cells = <2>;
> +                       #size-cells = <0>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <4>;
> +                       cell-index = <0>;
> +               };
> +
> +       };
> +};
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
