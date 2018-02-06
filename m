Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbeBFU0v (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 15:26:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752960AbeBFU0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 15:26:35 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96C8217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AH8x226qs5GaiiTfcf9mVY+B3XJCdH6C5XfuVtCGECIyeHrlVcSR4WPljPgRPQa9TR1GMZ86ZTu4GZug0NT2gIIMF+Q=
MIME-Version: 1.0
In-Reply-To: <20180126221501.GD28313@codeaurora.org>
References: <20180125163216.29018-1-rnayak@codeaurora.org> <20180125163216.29018-2-rnayak@codeaurora.org>
 <20180126221501.GD28313@codeaurora.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 6 Feb 2018 14:26:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ1xjQ5ZP-KXeZQ0s=ib8GTfvfYjFqyy+Zcub-akCs7Bw@mail.gmail.com>
Message-ID: <CAL_JsqJ1xjQ5ZP-KXeZQ0s=ib8GTfvfYjFqyy+Zcub-akCs7Bw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
To: Stephen Boyd <sboyd@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
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

On Fri, Jan 26, 2018 at 4:15 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 01/25, Rajendra Nayak wrote:
>>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dtsi
>
> Do we really need two files? Maybe collapse the two?
>
>>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845.dtsi
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> new file mode 100644
>> index 000000000000..a21f4912b3e2
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -0,0 +1,308 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +/ {
>> +     model = "Qualcomm Technologies, Inc. SDM845";
>> +
>> +     interrupt-parent = <&intc>;
>> +
>> +     #address-cells = <2>;
>> +     #size-cells = <2>;
>> +
>> +     chosen { };
>> +
>> +     memory {
>> +             device_type = "memory";
>> +             /* We expect the bootloader to fill in the reg */
>> +             reg = <0 0 0 0>;
>> +     };
>> +
>> +     cpus {
>> +             #address-cells = <2>;
>> +             #size-cells = <0>;
>> +
>> +             CPU0: cpu@0 {
>> +                     device_type = "cpu";
>> +                     compatible = "qcom,kryo";
>> +                     reg = <0x0 0x0>;
>> +                     enable-method = "psci";
>> +                     next-level-cache = <&L2_0>;
>> +                     L2_0: l2-cache {
>> +                             compatible = "cache";
>> +                             next-level-cache = <&L3_0>;
>> +                             L3_0: l3-cache {
>> +                                   compatible = "cache";
>> +                             };
>> +                     };
>> +             };
>> +
>> +             CPU1: cpu@100 {
>> +                     device_type = "cpu";
>> +                     compatible = "qcom,kryo";
>> +                     reg = <0x0 0x100>;
>> +                     enable-method = "psci";
>> +                     next-level-cache = <&L2_100>;
>> +                     L2_100: l2-cache {
>> +                             compatible = "cache";
>> +                             next-level-cache = <&L3_0>;
>> +                     };
>> +             };
>> +
>> +             CPU2: cpu@200 {
>> +                     device_type = "cpu";
>> +                     compatible = "qcom,kryo";
>> +                     reg = <0x0 0x200>;
>> +                     enable-method = "psci";
>> +                     next-level-cache = <&L2_200>;
>> +                     L2_200: l2-cache {
>> +                             compatible = "cache";
>> +                             next-level-cache = <&L3_0>;
>> +                     };
>> +             };
>> +
>> +             CPU3: cpu@300 {
>> +                     device_type = "cpu";
>> +                     compatible = "qcom,kryo";
>> +                     reg = <0x0 0x300>;
>> +                     enable-method = "psci";
>> +                     next-level-cache = <&L2_300>;
>> +                     L2_300: l2-cache {
>> +                             compatible = "cache";
>> +                             next-level-cache = <&L3_0>;
>> +                     };
>> +             };
>> +
>> +             CPU4: cpu@400 {
>> +                     device_type = "cpu";
>> +                     compatible = "qcom,kryo";
>> +                     reg = <0x0 0x400>;
>> +                     enable-method = "psci";
>> +                     next-level-cache = <&L2_400>;
>> +                     L2_400: l2-cache {
>> +                             compatible = "cache";
>> +                             next-level-cache = <&L3_0>;
>> +                     };
>> +             };
>> +
>> +             CPU5: cpu@500 {
>> +                     device_type = "cpu";
>> +                     compatible = "qcom,kryo";
>> +                     reg = <0x0 0x500>;
>> +                     enable-method = "psci";
>> +                     next-level-cache = <&L2_500>;
>> +                     L2_500: l2-cache {
>> +                             compatible = "cache";
>> +                             next-level-cache = <&L3_0>;
>> +                     };
>> +             };
>> +
>> +             CPU6: cpu@600 {
>> +                     device_type = "cpu";
>> +                     compatible = "qcom,kryo";
>> +                     reg = <0x0 0x600>;
>> +                     enable-method = "psci";
>> +                     next-level-cache = <&L2_600>;
>> +                     L2_600: l2-cache {
>> +                             compatible = "cache";
>> +                             next-level-cache = <&L3_0>;
>> +                     };
>> +             };
>> +
>> +             CPU7: cpu@700 {
>> +                     device_type = "cpu";
>> +                     compatible = "qcom,kryo";
>> +                     reg = <0x0 0x700>;
>> +                     enable-method = "psci";
>> +                     next-level-cache = <&L2_700>;
>> +                     L2_700: l2-cache {
>> +                             compatible = "cache";
>> +                             next-level-cache = <&L3_0>;
>> +                     };
>> +             };
>> +
>> +             cpu-map {
>> +                     cluster0 {
>> +                             core0 {
>> +                                     cpu = <&CPU0>;
>> +                             };
>> +
>> +                             core1 {
>> +                                     cpu = <&CPU1>;
>> +                             };
>> +
>> +                             core2 {
>> +                                     cpu = <&CPU2>;
>> +                             };
>> +
>> +                             core3 {
>> +                                     cpu = <&CPU3>;
>> +                             };
>> +                     };
>> +
>> +                     cluster1 {
>> +                             core0 {
>> +                                     cpu = <&CPU4>;
>> +                             };
>> +
>> +                             core1 {
>> +                                     cpu = <&CPU5>;
>> +                             };
>> +
>> +                             core2 {
>> +                                     cpu = <&CPU6>;
>> +                             };
>> +
>> +                             core3 {
>> +                                     cpu = <&CPU7>;
>> +                             };
>> +                     };
>> +             };
>
> From what I recall, this layout causes the kernel to spew
> warnings? I mean to say this is the power/performance view, but
> not the architectural view.
>
>> +     };
>> +
>> +     timer {
>> +             compatible = "arm,armv8-timer";
>> +             interrupts = <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>
> Are we supposed to use the GIC_CPU_MASK_SIMPLE macros still?
>
>> +                          <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +                          <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +                          <GIC_PPI 0 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
>> +     };
>> +
>> +     clocks {
>> +             xo_board: xo_board {
>> +                     compatible = "fixed-clock";
>> +                     #clock-cells = <0>;
>> +                     clock-frequency = <19200000>;
>> +                     clock-output-names = "xo_board";
>
> We can drop clock-output-names on these.
>
>> +             };
>> +
>> +             sleep_clk: sleep_clk {
>> +                     compatible = "fixed-clock";
>> +                     #clock-cells = <0>;
>> +                     clock-frequency = <32764>;
>> +                     clock-output-names = "sleep_clk";
>> +             };
>> +     };
>> +
>> +     psci {
>> +             compatible = "arm,psci-1.0";
>> +             method = "smc";
>> +     };
>> +
>> +     soc: soc {
>
> Will anyone use this phandle?
>
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             ranges = <0 0 0 0xffffffff>;
>> +             compatible = "simple-bus";
>> +
>> +             intc: interrupt-controller@17a00000 {
>> +                     compatible = "arm,gic-v3";
>> +                     #interrupt-cells = <3>;
>> +                     interrupt-controller;
>> +                     #redistributor-regions = <1>;
>> +                     redistributor-stride = <0x0 0x20000>;
>> +                     reg = <0x17a00000 0x10000>,     /* GICD */
>> +                           <0x17a60000 0x100000>;    /* GICR * 8 */
>> +                     interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>
> Can you also add the ITS node please and mark it as disabled?
> I'll send a patch to the list to skip status = "disabled" ones.
> We may want to support ITS on these SoCs if the firmware is
> different.
>
>> +             };
>> +
>> +             gcc: clock-controller@100000 {
>> +                     compatible = "qcom,gcc-sdm845";
>> +                     reg = <0x100000 0x1f0000>;
>> +                     #clock-cells = <1>;
>> +                     #reset-cells = <1>;
>> +             };
>> +
>> +             tlmm: pinctrl@03400000 {
>
> Drop leading zeroes please.

Build dtbs with W=2 and fix the warnings so reviewers don't have to
waste their time on these issues.

Rob
