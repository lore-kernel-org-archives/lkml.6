Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753720AbeDSW6j (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 18:58:39 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36619 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753571AbeDSW6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 18:58:37 -0400
X-Google-Smtp-Source: AIpwx4+8PnsqmnPIFmqvUG0KlNiVhaE24jTras1iCMRZ3ZNASx36hy6VrXl0cmrgDYihGrsaOPDGZw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180327160154.1938-1-bjorn.andersson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Imran Khan <kimran@codeaurora.org>,
        Joonwoo Park <joonwoop@codeaurora.org>, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180327160154.1938-1-bjorn.andersson@linaro.org>
Message-ID: <152417871558.46528.12974380945707201990@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] arm64: dts: Add msm8998 SoC and MTP board support
Date: Thu, 19 Apr 2018 15:58:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3JMwlTZ005488

Quoting Bjorn Andersson (2018-03-27 09:01:53)
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> new file mode 100644
> index 000000000000..0f2f0e0de74f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2016, The Linux Foundation. All rights reserved. */
> +
> +#include "msm8998.dtsi"
> +
> +/ {
> +       aliases {
> +               serial0 = &blsp2_uart1;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0";

Plus :115200n8?

> +       };
> +};
> +
> +&soc {
> +       serial@0c1b0000 {
> +               status = "okay";
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> new file mode 100644
> index 000000000000..9e2c0ff7457f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2016, The Linux Foundation. All rights reserved. */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,gcc-msm8998.h>
> +
> +/ {
> +       model = "Qualcomm Technologies, Inc. MSM 8998";
> +
> +       interrupt-parent = <&intc>;
> +
> +       qcom,msm-id = <292 0x0>;

Sadface.

> +
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
[...]
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

Is this accurate? Or it's describing the power hierarchy?

> +               };
> +       };
> +
> +       timer {
> +               compatible = "arm,armv8-timer";
> +               interrupts = <1 1 0xf08>,
> +                            <1 2 0xf08>,
> +                            <1 3 0xf08>,
> +                            <1 0 0xf08>;

Are these 0xf08 things accurate?

> +               clock-frequency = <19200000>;

Drop? Should come from hardware.

> +       };
> +
> +       clocks {
> +               xo_board {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <19200000>;
> +                       clock-output-names = "xo_board";

The output names aren't needed.

> +               };
> +
> +               sleep_clk {
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
> +       soc: soc {};
> +};
> +
> +&soc {

Ok!

> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       ranges = <0 0 0 0xffffffff>;
> +       compatible = "simple-bus";
> +
> +       intc: interrupt-controller@17a00000 {
> +               compatible = "arm,gic-v3";
> +               reg = <0x17a00000 0x10000>,       /* GICD */
> +                     <0x17b00000 0x100000>;      /* GICR * 8 */
> +               #interrupt-cells = <3>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +               interrupt-controller;
> +               #redistributor-regions = <1>;
> +               redistributor-stride = <0x0 0x20000>;

Was this stride stuff needed still?

> +               interrupts = <1 9 4>;

Use special GIC flags?

> +       };
> +
> +       gcc: clock-controller@100000 {
> +               compatible = "qcom,gcc-msm8998";
> +               #clock-cells = <1>;
> +               #reset-cells = <1>;
> +               #power-domain-cells = <1>;
> +               reg = <0x100000 0xb0000>;
> +       };
> +
> +       blsp2_uart1: serial@0c1b0000 {

Drop leading zeroes please.

> +               compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +               reg = <0xc1b0000 0x1000>;
> +               interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>,
> +                        <&gcc GCC_BLSP2_AHB_CLK>;
> +               clock-names = "core", "iface";
> +               status = "disabled";
> +       };
> +
> +       timer@17920000 {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +               compatible = "arm,armv7-timer-mem";
> +               reg = <0x17920000 0x1000>;
> +               clock-frequency = <19200000>;

Read from hardware instead?
