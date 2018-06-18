Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF026C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8417E20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9Qh8OfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8417E20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934358AbeFRLJp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:09:45 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:46154 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932762AbeFRLJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:09:42 -0400
Received: by mail-ot0-f194.google.com with SMTP id v24-v6so9448798otk.13;
        Mon, 18 Jun 2018 04:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XJeVJWotpo8Lza/TyQQsPiKVM+5edAJ17SvCrI6NUV0=;
        b=M9Qh8OfYlAjbLfNUwXCaitHzj5+ChaNcKIe6SJ9L/T+u+r4PUm18lIjeeACbiCXl8k
         hYugxaYNBSyGbXMAggdx3k8YK+xNAAO/lf7WfkOpYLrht1F51ikiXcCp2QO1n3MIAycN
         7EILPGg3VQ3cAumSPPhDL2BbGiXV3GdLiPM7BJMq/5rKK20KJXG4pf4ls7xM7zYguIWs
         hvgLSGFTnXD1P0riIFoY116Az21F+yTO826kuUZL1ZjvgWdS9KRUN6oSpGa+QI+FaU0o
         bLoPfeGNJ7ZGqUJYnur73q4sWJ4lZnEbUWoQT7OirgfYOKcRgQJuvmvYgIY/ojlp8xuG
         wiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XJeVJWotpo8Lza/TyQQsPiKVM+5edAJ17SvCrI6NUV0=;
        b=G7gT170Z4k8osSpvScDilYbQzOfvgNbT4X2aq0d6pcOYC/CuBSR9ckWqh/JFkUBtYa
         LLFFf1v55OmFtFmf7i8ku2u4NDi+pOih+j7lqX1a+FCT68a5zNgfj55mVurba4bVA/KL
         3ef/OaVqT/IbZhMOSdV0Uw7uYS7q1E7VOI3+7oXpQTbGfhVFFPBttleTUDjI1aW5uFlF
         /WXS+J1gQM7gutEaiLKNErh4wDtunISJ5BRrhXQdUXxmViSaASbt5ElYKjoE1OV8aM6t
         fWcf8iuROvMlYdQoZ4R671Hbu2xMy8J/3Zo6T1a2V0Mx3jvwYKq3YSLwPF+Yp1cy7CSB
         4dDA==
X-Gm-Message-State: APt69E3woF7BbXO96hUAjPKpAjjNqCXgSa41oA2lWzK7bRCRKlftNFS8
        8Nhxc5tX+ESkYxgpnKoWxAAsB8JhemRnwtI334o=
X-Google-Smtp-Source: ADUXVKK3r/uei9EOzY1yiFnzdP9CYae7fwG3dtoQDyQtI3Xi2BarzGzLxcTOoxC+8dux77juwrEBsCq0C66dOZAr63A=
X-Received: by 2002:a9d:9d3:: with SMTP id 19-v6mr6938161otz.324.1529320181358;
 Mon, 18 Jun 2018 04:09:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:5b3b:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 04:09:20
 -0700 (PDT)
In-Reply-To: <20180530164922.31851-1-krzk@kernel.org>
References: <20180530164922.31851-1-krzk@kernel.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 18 Jun 2018 16:39:20 +0530
Message-ID: <CANAwSgSv4yWD6p4OTQV+Ua9PuL=M4KYAgOtwdXCD8S0X-cx+tw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: Add missing CPU clocks to secondary
 CPUs on Exynos542x
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,


On 30 May 2018 at 22:19, Krzysztof Kozlowski <krzk@kernel.org> wrote:
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
[snip]

Actually cpufreq module have more clock to be enabled below is example
from clk_summary.

    fout_kpll                             0            0  1400000000
       0 0
       mout_kpll                          0            0  1400000000
       0 0
          kfcclk                          0            0  1400000000
       0 0
          sclk_kpll                       0            0   350000000
       0 0
          mout_kfc                        0            0  1400000000
       0 0
             div_kfc                      0            0  1400000000
       0 0

    fout_apll                             0            0  2000000000
       0 0
       mout_apll                          0            0  2000000000
       0 0
          armclk                          0            0  2000000000
       0 0
          sclk_apll                       0            0   500000000
       0 0
          mout_cpu                        0            0  2000000000
       0 0
             div_arm                      0            0  2000000000
       0 0
                armclk2                   0            0  2000000000
       0 0

Best Regards
-Anand
