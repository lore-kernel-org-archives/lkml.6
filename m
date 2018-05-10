Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756991AbeEJJDe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 05:03:34 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40767 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756831AbeEJJD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 05:03:29 -0400
X-Google-Smtp-Source: AB8JxZpo2JGp/SbPhYEJEMgGtHRb0SGitqH0FCEBNDHt8xMDQtR/pqD4A3bcqwSM7/OR9SL2dAAZvyH6Dr/0UY2ISb4=
MIME-Version: 1.0
In-Reply-To: <20180418163415.21646-1-srinivas.kandagatla@linaro.org>
References: <20180418163415.21646-1-srinivas.kandagatla@linaro.org>
From: Amit Kucheria <amit.kucheria@verdurent.com>
Date: Thu, 10 May 2018 12:03:27 +0300
Message-ID: <CAHLCerOZ3_A7PvD6i53WXLJXVPmUWcNakvA2gcwFYMT9f1iR0A@mail.gmail.com>
Subject: Re: [PATCH] arm64: msm8916: fix gic_irq_domain_translate warnings
To: srinivas.kandagatla@linaro.org
Cc: Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        linux-soc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        lakml <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 7:34 PM,  <srinivas.kandagatla@linaro.org> wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> Remove the usage of IRQ_TYPE_NONE to fix loud warnings from
> patch (83a86fbb5b56b "irqchip/gic: Loudly complain about
> the use of IRQ_TYPE_NONE").
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>

(boot report here:
https://storage.kernelci.org/qcom-lt/integration-linux-qcomlt/v4.17-rc4-247-gbe94bee41bf6/arm64/defconfig/lab-bjorn/boot-apq8016-sbc.txt)

> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index cfbd72186762..5d66a575c7e1 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -180,7 +180,7 @@
>
>         pmu {
>                 compatible = "arm,cortex-a53-pmu";
> -               interrupts = <GIC_PPI 7 GIC_CPU_MASK_SIMPLE(4)>;
> +               interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4)| IRQ_TYPE_LEVEL_HIGH)>;
>         };
>
>         thermal-zones {
> @@ -513,7 +513,7 @@
>                 blsp_i2c2: i2c@78b6000 {
>                         compatible = "qcom,i2c-qup-v2.2.1";
>                         reg = <0x078b6000 0x500>;
> -                       interrupts = <GIC_SPI 96 0>;
> +                       interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks = <&gcc GCC_BLSP1_AHB_CLK>,
>                                  <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
>                         clock-names = "iface", "core";
> @@ -528,7 +528,7 @@
>                 blsp_i2c4: i2c@78b8000 {
>                         compatible = "qcom,i2c-qup-v2.2.1";
>                         reg = <0x078b8000 0x500>;
> -                       interrupts = <GIC_SPI 98 0>;
> +                       interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks = <&gcc GCC_BLSP1_AHB_CLK>,
>                                  <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>;
>                         clock-names = "iface", "core";
> @@ -543,7 +543,7 @@
>                 blsp_i2c6: i2c@78ba000 {
>                         compatible = "qcom,i2c-qup-v2.2.1";
>                         reg = <0x078ba000 0x500>;
> -                       interrupts = <GIC_SPI 100 0>;
> +                       interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks = <&gcc GCC_BLSP1_AHB_CLK>,
>                                  <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>;
>                         clock-names = "iface", "core";
> @@ -575,7 +575,7 @@
>                                         "mi2s-bit-clk3";
>                         #sound-dai-cells = <1>;
>
> -                       interrupts = <0 160 0>;
> +                       interrupts = <0 160 IRQ_TYPE_LEVEL_HIGH>;
>                         interrupt-names = "lpass-irq-lpaif";
>                         reg = <0x07708000 0x10000>;
>                         reg-names = "lpass-lpaif";
> @@ -595,7 +595,7 @@
>                         reg = <0x07824900 0x11c>, <0x07824000 0x800>;
>                         reg-names = "hc_mem", "core_mem";
>
> -                       interrupts = <0 123 0>, <0 138 0>;
> +                       interrupts = <0 123 IRQ_TYPE_LEVEL_HIGH>, <0 138 IRQ_TYPE_LEVEL_HIGH>;
>                         interrupt-names = "hc_irq", "pwr_irq";
>                         clocks = <&gcc GCC_SDCC1_APPS_CLK>,
>                                  <&gcc GCC_SDCC1_AHB_CLK>,
> @@ -612,7 +612,7 @@
>                         reg = <0x07864900 0x11c>, <0x07864000 0x800>;
>                         reg-names = "hc_mem", "core_mem";
>
> -                       interrupts = <0 125 0>, <0 221 0>;
> +                       interrupts = <0 125 IRQ_TYPE_LEVEL_HIGH>, <0 221 IRQ_TYPE_LEVEL_HIGH>;
>                         interrupt-names = "hc_irq", "pwr_irq";
>                         clocks = <&gcc GCC_SDCC2_APPS_CLK>,
>                                  <&gcc GCC_SDCC2_AHB_CLK>,
> @@ -819,7 +819,7 @@
>                         iommu-ctx@2000 {
>                                 compatible = "qcom,msm-iommu-v1-ns";
>                                 reg = <0x2000 0x1000>;
> -                               interrupts = <GIC_SPI 242 0>;
> +                               interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
>                         };
>                 };
>
> @@ -864,7 +864,7 @@
>                                       "bus_clk",
>                                       "vsync_clk";
>
> -                       interrupts = <0 72 0>;
> +                       interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
>
>                         interrupt-controller;
>                         #interrupt-cells = <1>;
> --
> 2.16.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
