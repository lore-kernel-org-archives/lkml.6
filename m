Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934664AbeEJILZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 04:11:25 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41518 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934366AbeEJILQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 04:11:16 -0400
X-Google-Smtp-Source: AB8JxZre8iBJdUV2XDOVjTyrStoEFLQqbWHGmr5YCD+WWtgad8YytN6CUxqki68U0mdfc/vpalnNZhbqUQJbRq3FcSA=
MIME-Version: 1.0
In-Reply-To: <20180420103913.10133-1-thierry.escande@linaro.org>
References: <20180420103913.10133-1-thierry.escande@linaro.org>
From: Amit Kucheria <amit.kucheria@verdurent.com>
Date: Thu, 10 May 2018 11:11:14 +0300
Message-ID: <CAHLCerMcqVGNJpNc9RHH1_bkdRP6-FtenQWZ2Njoe_0BHLYEhA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: qcom-apq8064: fix gic_irq_domain_translate warnings
To: Thierry Escande <thierry.escande@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 1:39 PM, Thierry Escande
<thierry.escande@linaro.org> wrote:
> Remove the usage of IRQ_TYPE_NONE to fix loud warnings from
> patch (83a86fbb5b56b "irqchip/gic: Loudly complain about
> the use of IRQ_TYPE_NONE").
>
> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm/boot/dts/qcom-apq8064.dtsi | 52 ++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index 5341a39c0392..f26613ffc9e7 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -444,7 +444,7 @@
>                                 compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
>                                 reg = <0x12450000 0x100>,
>                                       <0x12400000 0x03>;
> -                               interrupts = <0 193 0x0>;
> +                               interrupts = <0 193 IRQ_TYPE_LEVEL_HIGH>;
>                                 clocks = <&gcc GSBI1_UART_CLK>, <&gcc GSBI1_H_CLK>;
>                                 clock-names = "core", "iface";
>                                 status = "disabled";
> @@ -456,7 +456,7 @@
>                                 pinctrl-1 = <&i2c1_pins_sleep>;
>                                 pinctrl-names = "default", "sleep";
>                                 reg = <0x12460000 0x1000>;
> -                               interrupts = <0 194 IRQ_TYPE_NONE>;
> +                               interrupts = <0 194 IRQ_TYPE_LEVEL_HIGH>;
>                                 clocks = <&gcc GSBI1_QUP_CLK>, <&gcc GSBI1_H_CLK>;
>                                 clock-names = "core", "iface";
>                                 #address-cells = <1>;
> @@ -484,7 +484,7 @@
>                                 pinctrl-0 = <&i2c2_pins>;
>                                 pinctrl-1 = <&i2c2_pins_sleep>;
>                                 pinctrl-names = "default", "sleep";
> -                               interrupts = <0 196 IRQ_TYPE_NONE>;
> +                               interrupts = <0 196 IRQ_TYPE_LEVEL_HIGH>;
>                                 clocks = <&gcc GSBI2_QUP_CLK>, <&gcc GSBI2_H_CLK>;
>                                 clock-names = "core", "iface";
>                                 #address-cells = <1>;
> @@ -508,7 +508,7 @@
>                                 pinctrl-1 = <&i2c3_pins_sleep>;
>                                 pinctrl-names = "default", "sleep";
>                                 reg = <0x16280000 0x1000>;
> -                               interrupts = <GIC_SPI 151 IRQ_TYPE_NONE>;
> +                               interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
>                                 clocks = <&gcc GSBI3_QUP_CLK>,
>                                          <&gcc GSBI3_H_CLK>;
>                                 clock-names = "core", "iface";
> @@ -534,7 +534,7 @@
>                                 pinctrl-1 = <&i2c4_pins_sleep>;
>                                 pinctrl-names = "default", "sleep";
>                                 reg = <0x16380000 0x1000>;
> -                               interrupts = <GIC_SPI 153 IRQ_TYPE_NONE>;
> +                               interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
>                                 clocks = <&gcc GSBI4_QUP_CLK>,
>                                          <&gcc GSBI4_H_CLK>;
>                                 clock-names = "core", "iface";
> @@ -556,7 +556,7 @@
>                                 compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
>                                 reg = <0x1a240000 0x100>,
>                                       <0x1a200000 0x03>;
> -                               interrupts = <0 154 0x0>;
> +                               interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
>                                 clocks = <&gcc GSBI5_UART_CLK>, <&gcc GSBI5_H_CLK>;
>                                 clock-names = "core", "iface";
>                                 status = "disabled";
> @@ -565,7 +565,7 @@
>                         gsbi5_spi: spi@1a280000 {
>                                 compatible = "qcom,spi-qup-v1.1.1";
>                                 reg = <0x1a280000 0x1000>;
> -                               interrupts = <0 155 0>;
> +                               interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
>                                 pinctrl-0 = <&spi5_default>;
>                                 pinctrl-1 = <&spi5_sleep>;
>                                 pinctrl-names = "default", "sleep";
> @@ -592,7 +592,7 @@
>                                 compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
>                                 reg = <0x16540000 0x100>,
>                                       <0x16500000 0x03>;
> -                               interrupts = <0 156 0x0>;
> +                               interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
>                                 clocks = <&gcc GSBI6_UART_CLK>, <&gcc GSBI6_H_CLK>;
>                                 clock-names = "core", "iface";
>                                 status = "disabled";
> @@ -604,7 +604,7 @@
>                                 pinctrl-1 = <&i2c6_pins_sleep>;
>                                 pinctrl-names = "default", "sleep";
>                                 reg = <0x16580000 0x1000>;
> -                               interrupts = <GIC_SPI 157 IRQ_TYPE_NONE>;
> +                               interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
>                                 clocks = <&gcc GSBI6_QUP_CLK>,
>                                          <&gcc GSBI6_H_CLK>;
>                                 clock-names = "core", "iface";
> @@ -628,7 +628,7 @@
>                                 compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
>                                 reg = <0x16640000 0x1000>,
>                                       <0x16600000 0x1000>;
> -                               interrupts = <0 158 0x0>;
> +                               interrupts = <0 158 IRQ_TYPE_LEVEL_HIGH>;
>                                 clocks = <&gcc GSBI7_UART_CLK>, <&gcc GSBI7_H_CLK>;
>                                 clock-names = "core", "iface";
>                                 status = "disabled";
> @@ -640,7 +640,7 @@
>                                 pinctrl-1 = <&i2c7_pins_sleep>;
>                                 pinctrl-names = "default", "sleep";
>                                 reg = <0x16680000 0x1000>;
> -                               interrupts = <GIC_SPI 159 IRQ_TYPE_NONE>;
> +                               interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
>                                 clocks = <&gcc GSBI7_QUP_CLK>,
>                                          <&gcc GSBI7_H_CLK>;
>                                 clock-names = "core", "iface";
> @@ -1056,7 +1056,7 @@
>                         compatible              = "qcom,apq8064-ahci", "generic-ahci";
>                         status                  = "disabled";
>                         reg                     = <0x29000000 0x180>;
> -                       interrupts              = <GIC_SPI 209 IRQ_TYPE_NONE>;
> +                       interrupts              = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
>
>                         clocks                  = <&gcc SFAB_SATA_S_H_CLK>,
>                                                 <&gcc SATA_H_CLK>,
> @@ -1082,7 +1082,7 @@
>                 sdcc1bam:dma@12402000{
>                         compatible = "qcom,bam-v1.3.0";
>                         reg = <0x12402000 0x8000>;
> -                       interrupts = <0 98 0>;
> +                       interrupts = <0 98 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks = <&gcc SDC1_H_CLK>;
>                         clock-names = "bam_clk";
>                         #dma-cells = <1>;
> @@ -1092,7 +1092,7 @@
>                 sdcc3bam:dma@12182000{
>                         compatible = "qcom,bam-v1.3.0";
>                         reg = <0x12182000 0x8000>;
> -                       interrupts = <0 96 0>;
> +                       interrupts = <0 96 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks = <&gcc SDC3_H_CLK>;
>                         clock-names = "bam_clk";
>                         #dma-cells = <1>;
> @@ -1102,7 +1102,7 @@
>                 sdcc4bam:dma@121c2000{
>                         compatible = "qcom,bam-v1.3.0";
>                         reg = <0x121c2000 0x8000>;
> -                       interrupts = <0 95 0>;
> +                       interrupts = <0 95 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks = <&gcc SDC4_H_CLK>;
>                         clock-names = "bam_clk";
>                         #dma-cells = <1>;
> @@ -1181,7 +1181,7 @@
>                         compatible = "qcom,adreno-3xx";
>                         reg = <0x04300000 0x20000>;
>                         reg-names = "kgsl_3d0_reg_memory";
> -                       interrupts = <GIC_SPI 80 0>;
> +                       interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
>                         interrupt-names = "kgsl_3d0_irq";
>                         clock-names =
>                             "core_clk",
> @@ -1281,7 +1281,7 @@
>                         label = "MDSS DSI CTRL->0";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> -                       interrupts = <GIC_SPI 82 0>;
> +                       interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
>                         reg = <0x04700000 0x200>;
>                         reg-names = "dsi_ctrl";
>
> @@ -1350,8 +1350,8 @@
>                             <&mmcc MDP_AXI_CLK>;
>                         reg = <0x07500000 0x100000>;
>                         interrupts =
> -                           <GIC_SPI 63 0>,
> -                           <GIC_SPI 64 0>;
> +                           <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
> +                           <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
>                         qcom,ncb = <2>;
>                 };
>
> @@ -1366,8 +1366,8 @@
>                             <&mmcc MDP_AXI_CLK>;
>                         reg = <0x07600000 0x100000>;
>                         interrupts =
> -                           <GIC_SPI 61 0>,
> -                           <GIC_SPI 62 0>;
> +                           <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
> +                           <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
>                         qcom,ncb = <2>;
>                 };
>
> @@ -1382,8 +1382,8 @@
>                             <&mmcc GFX3D_AXI_CLK>;
>                         reg = <0x07c00000 0x100000>;
>                         interrupts =
> -                           <GIC_SPI 69 0>,
> -                           <GIC_SPI 70 0>;
> +                           <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
> +                           <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
>                         qcom,ncb = <3>;
>                 };
>
> @@ -1398,8 +1398,8 @@
>                             <&mmcc GFX3D_AXI_CLK>;
>                         reg = <0x07d00000 0x100000>;
>                         interrupts =
> -                           <GIC_SPI 210 0>,
> -                           <GIC_SPI 211 0>;
> +                           <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
> +                           <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
>                         qcom,ncb = <3>;
>                 };
>
> @@ -1418,7 +1418,7 @@
>                         #size-cells = <2>;
>                         ranges = <0x81000000 0 0 0x0fe00000 0 0x00100000   /* I/O */
>                                   0x82000000 0 0 0x08000000 0 0x07e00000>; /* memory */
> -                       interrupts = <GIC_SPI 238 IRQ_TYPE_NONE>;
> +                       interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
>                         interrupt-names = "msi";
>                         #interrupt-cells = <1>;
>                         interrupt-map-mask = <0 0 0 0x7>;
> --
> 2.14.1
>
