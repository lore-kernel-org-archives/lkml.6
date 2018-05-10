Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934784AbeEJIRO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 04:17:14 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46040 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757018AbeEJIQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 04:16:29 -0400
X-Google-Smtp-Source: AB8JxZqGKcgzGCacWL9KUJeoSV4ac5QvaWOutcjSYbGRG/uPd9Bnv0TYmroPwiJMycxiri6afKCqxD6m3KcOkV9Ogk8=
MIME-Version: 1.0
In-Reply-To: <20180427061028.13192-1-thierry.escande@linaro.org>
References: <20180427061028.13192-1-thierry.escande@linaro.org>
From: Amit Kucheria <amit.kucheria@verdurent.com>
Date: Thu, 10 May 2018 11:16:28 +0300
Message-ID: <CAHLCerPCDbTEa3k=iz=frf4Sdn_-61z-S+rirCt1dPwbva4LUg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: msm8996: fix gic_irq_domain_translate warnings
To: Thierry Escande <thierry.escande@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 9:10 AM, Thierry Escande
<thierry.escande@linaro.org> wrote:
> Remove the usage of IRQ_TYPE_NONE to fix loud warnings from
> patch (83a86fbb5b56b "irqchip/gic: Loudly complain about
> the use of IRQ_TYPE_NONE").
>
> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>

(boot report here:
https://storage.kernelci.org/qcom-lt/integration-linux-qcomlt/v4.17-rc4-247-gbe94bee41bf6/arm64/defconfig/lab-bjorn/boot-apq8096-db820c.txt)

> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 410ae787ebb4..1aaf1fa2604e 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -437,7 +437,7 @@
>                 blsp2_i2c0: i2c@75b5000 {
>                         compatible = "qcom,i2c-qup-v2.2.1";
>                         reg = <0x075b5000 0x1000>;
> -                       interrupts = <GIC_SPI 101 0>;
> +                       interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks = <&gcc GCC_BLSP2_AHB_CLK>,
>                                 <&gcc GCC_BLSP2_QUP1_I2C_APPS_CLK>;
>                         clock-names = "iface", "core";
> @@ -468,7 +468,7 @@
>                 blsp2_i2c1: i2c@75b6000 {
>                         compatible = "qcom,i2c-qup-v2.2.1";
>                         reg = <0x075b6000 0x1000>;
> -                       interrupts = <GIC_SPI 102 0>;
> +                       interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks = <&gcc GCC_BLSP2_AHB_CLK>,
>                                 <&gcc GCC_BLSP2_QUP2_I2C_APPS_CLK>;
>                         clock-names = "iface", "core";
> @@ -493,7 +493,7 @@
>                 blsp1_i2c2: i2c@7577000 {
>                         compatible = "qcom,i2c-qup-v2.2.1";
>                         reg = <0x07577000 0x1000>;
> -                       interrupts = <GIC_SPI 97 0>;
> +                       interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks = <&gcc GCC_BLSP1_AHB_CLK>,
>                                 <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>;
>                         clock-names = "iface", "core";
> @@ -526,7 +526,8 @@
>                          reg = <0x74a4900 0x314>, <0x74a4000 0x800>;
>                          reg-names = "hc_mem", "core_mem";
>
> -                        interrupts = <0 125 0>, <0 221 0>;
> +                        interrupts = <0 125 IRQ_TYPE_LEVEL_HIGH>,
> +                                     <0 221 IRQ_TYPE_LEVEL_HIGH>;
>                          interrupt-names = "hc_irq", "pwr_irq";
>
>                          clock-names = "iface", "core", "xo";
> @@ -809,7 +810,7 @@
>                         dwc3@7600000 {
>                                 compatible = "snps,dwc3";
>                                 reg = <0x7600000 0xcc00>;
> -                               interrupts = <0 138 0>;
> +                               interrupts = <0 138 IRQ_TYPE_LEVEL_HIGH>;
>                                 phys = <&hsusb_phy2>;
>                                 phy-names = "usb2-phy";
>                         };
> @@ -838,7 +839,7 @@
>                         dwc3@6a00000 {
>                                 compatible = "snps,dwc3";
>                                 reg = <0x6a00000 0xcc00>;
> -                               interrupts = <0 131 0>;
> +                               interrupts = <0 131 IRQ_TYPE_LEVEL_HIGH>;
>                                 phys = <&hsusb_phy1>, <&ssusb_phy_0>;
>                                 phy-names = "usb2-phy", "usb3-phy";
>                         };
> @@ -872,7 +873,7 @@
>                                 ranges = <0x01000000 0x0 0x0c200000 0x0c200000 0x0 0x100000>,
>                                         <0x02000000 0x0 0x0c300000 0x0c300000 0x0 0xd00000>;
>
> -                               interrupts = <GIC_SPI 405 IRQ_TYPE_NONE>;
> +                               interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
>                                 interrupt-names = "msi";
>                                 #interrupt-cells = <1>;
>                                 interrupt-map-mask = <0 0 0 0x7>;
> @@ -927,7 +928,7 @@
>                                 ranges = <0x01000000 0x0 0x0d200000 0x0d200000 0x0 0x100000>,
>                                         <0x02000000 0x0 0x0d300000 0x0d300000 0x0 0xd00000>;
>
> -                               interrupts = <GIC_SPI 413 IRQ_TYPE_NONE>;
> +                               interrupts = <GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>;
>                                 interrupt-names = "msi";
>                                 #interrupt-cells = <1>;
>                                 interrupt-map-mask = <0 0 0 0x7>;
> @@ -980,7 +981,7 @@
>
>                                 device_type = "pci";
>
> -                               interrupts = <GIC_SPI 421 IRQ_TYPE_NONE>;
> +                               interrupts = <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>;
>                                 interrupt-names = "msi";
>                                 #interrupt-cells = <1>;
>                                 interrupt-map-mask = <0 0 0 0x7>;
> --
> 2.14.1
>
