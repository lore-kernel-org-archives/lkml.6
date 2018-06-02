Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbeFBPkm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 11:40:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54462 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeFBPkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 11:40:40 -0400
X-Google-Smtp-Source: ADUXVKKr0zh2jEjflnhsBFfvC0yD9kBWvZ3E3xIROCWEj+I56ry5Vk0oOaB/YfiRd08oaoNwhJSrPDwBI1Dlqpnjn7I=
MIME-Version: 1.0
In-Reply-To: <20180530164922.31851-1-krzk@kernel.org>
References: <20180530164922.31851-1-krzk@kernel.org>
From: Alim Akhtar <alim.akhtar@gmail.com>
Date: Sat, 2 Jun 2018 21:09:58 +0530
Message-ID: <CAGOxZ506T5swFOoBB0RcbHKa45nJvFRnAZETM505-mi03o6cjg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: Add missing CPU clocks to secondary
 CPUs on Exynos542x
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, May 30, 2018 at 10:19 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Secondary CPUs should have the same information in DeviceTree as booting
> CPU from both correctness point of view and for possible hotplug
> scenarios.
>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos5420-cpus.dtsi | 6 ++++++
>  arch/arm/boot/dts/exynos5422-cpus.dtsi | 8 +++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

Tested on exynos5800 peach-pi, so feel free to add

Tested-by: Alim Akhtar <alim.akhtar@samsung.com>

>
> diff --git a/arch/arm/boot/dts/exynos5420-cpus.dtsi b/arch/arm/boot/dts/exynos5420-cpus.dtsi
> index a8e449471304..0ee6e92a3c29 100644
> --- a/arch/arm/boot/dts/exynos5420-cpus.dtsi
> +++ b/arch/arm/boot/dts/exynos5420-cpus.dtsi
> @@ -38,6 +38,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a15";
>                         reg = <0x1>;
> +                       clocks = <&clock CLK_ARM_CLK>;
>                         clock-frequency = <1800000000>;
>                         cci-control-port = <&cci_control1>;
>                         operating-points-v2 = <&cluster_a15_opp_table>;
> @@ -49,6 +50,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a15";
>                         reg = <0x2>;
> +                       clocks = <&clock CLK_ARM_CLK>;
>                         clock-frequency = <1800000000>;
>                         cci-control-port = <&cci_control1>;
>                         operating-points-v2 = <&cluster_a15_opp_table>;
> @@ -60,6 +62,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a15";
>                         reg = <0x3>;
> +                       clocks = <&clock CLK_ARM_CLK>;
>                         clock-frequency = <1800000000>;
>                         cci-control-port = <&cci_control1>;
>                         operating-points-v2 = <&cluster_a15_opp_table>;
> @@ -83,6 +86,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a7";
>                         reg = <0x101>;
> +                       clocks = <&clock CLK_KFC_CLK>;
>                         clock-frequency = <1000000000>;
>                         cci-control-port = <&cci_control0>;
>                         operating-points-v2 = <&cluster_a7_opp_table>;
> @@ -94,6 +98,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a7";
>                         reg = <0x102>;
> +                       clocks = <&clock CLK_KFC_CLK>;
>                         clock-frequency = <1000000000>;
>                         cci-control-port = <&cci_control0>;
>                         operating-points-v2 = <&cluster_a7_opp_table>;
> @@ -105,6 +110,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a7";
>                         reg = <0x103>;
> +                       clocks = <&clock CLK_KFC_CLK>;
>                         clock-frequency = <1000000000>;
>                         cci-control-port = <&cci_control0>;
>                         operating-points-v2 = <&cluster_a7_opp_table>;
> diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
> index 7c130a00d1a8..e4a5857c135f 100644
> --- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
> @@ -37,6 +37,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a7";
>                         reg = <0x101>;
> +                       clocks = <&clock CLK_KFC_CLK>;
>                         clock-frequency = <1000000000>;
>                         cci-control-port = <&cci_control0>;
>                         operating-points-v2 = <&cluster_a7_opp_table>;
> @@ -48,6 +49,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a7";
>                         reg = <0x102>;
> +                       clocks = <&clock CLK_KFC_CLK>;
>                         clock-frequency = <1000000000>;
>                         cci-control-port = <&cci_control0>;
>                         operating-points-v2 = <&cluster_a7_opp_table>;
> @@ -59,6 +61,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a7";
>                         reg = <0x103>;
> +                       clocks = <&clock CLK_KFC_CLK>;
>                         clock-frequency = <1000000000>;
>                         cci-control-port = <&cci_control0>;
>                         operating-points-v2 = <&cluster_a7_opp_table>;
> @@ -69,8 +72,8 @@
>                 cpu4: cpu@0 {
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a15";
> -                       clocks = <&clock CLK_ARM_CLK>;
>                         reg = <0x0>;
> +                       clocks = <&clock CLK_ARM_CLK>;
>                         clock-frequency = <1800000000>;
>                         cci-control-port = <&cci_control1>;
>                         operating-points-v2 = <&cluster_a15_opp_table>;
> @@ -82,6 +85,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a15";
>                         reg = <0x1>;
> +                       clocks = <&clock CLK_ARM_CLK>;
>                         clock-frequency = <1800000000>;
>                         cci-control-port = <&cci_control1>;
>                         operating-points-v2 = <&cluster_a15_opp_table>;
> @@ -93,6 +97,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a15";
>                         reg = <0x2>;
> +                       clocks = <&clock CLK_ARM_CLK>;
>                         clock-frequency = <1800000000>;
>                         cci-control-port = <&cci_control1>;
>                         operating-points-v2 = <&cluster_a15_opp_table>;
> @@ -104,6 +109,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a15";
>                         reg = <0x3>;
> +                       clocks = <&clock CLK_ARM_CLK>;
>                         clock-frequency = <1800000000>;
>                         cci-control-port = <&cci_control1>;
>                         operating-points-v2 = <&cluster_a15_opp_table>;
> --
> 2.14.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
