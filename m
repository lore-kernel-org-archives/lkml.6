Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754051AbeBGM50 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 07:57:26 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39980 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753975AbeBGM5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 07:57:24 -0500
X-Google-Smtp-Source: AH8x226VP7nXolWikabeE22eJPGNJAOBd84vY2gsZEt1KAyot6AEEXHfQFXG6sgdA9b2C6N70gB2q92Lkzelz17N5hs=
MIME-Version: 1.0
In-Reply-To: <20180205144651.5934-4-georgi.djakov@linaro.org>
References: <20180205144651.5934-1-georgi.djakov@linaro.org> <20180205144651.5934-4-georgi.djakov@linaro.org>
From: Amit Kucheria <amit.kucheria@linaro.org>
Date: Wed, 7 Feb 2018 18:27:23 +0530
X-Google-Sender-Auth: uUXolWy_0Viq0dg1C2-zfVEF1cw
Message-ID: <CAHLCerN7Z1yUg_YtGei=BmLHLyobQLMy4d2hg3vv3xyL0Tsghg@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: msm8916: Add CPU frequency scaling support
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 8:16 PM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
> Add a CPU OPP table to allow CPU frequency scaling on msm8916 platforms.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

For this series, please feel free to add my

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>

It enables basic cpufreq on the DB410c in mainline after enabling
QCOM_APCS_IPC. I'll send out another patch to automatically select
this Kconfig option.

> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 4539571a36b2..e4682779eec7 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -113,6 +113,8 @@
>                         next-level-cache = <&L2_0>;
>                         enable-method = "psci";
>                         cpu-idle-states = <&CPU_SPC>;
> +                       clocks = <&apcs 0>;
> +                       operating-points-v2 = <&cpu_opp_table>;
>                 };
>
>                 CPU1: cpu@1 {
> @@ -122,6 +124,8 @@
>                         next-level-cache = <&L2_0>;
>                         enable-method = "psci";
>                         cpu-idle-states = <&CPU_SPC>;
> +                       clocks = <&apcs 0>;
> +                       operating-points-v2 = <&cpu_opp_table>;
>                 };
>
>                 CPU2: cpu@2 {
> @@ -131,6 +135,8 @@
>                         next-level-cache = <&L2_0>;
>                         enable-method = "psci";
>                         cpu-idle-states = <&CPU_SPC>;
> +                       clocks = <&apcs 0>;
> +                       operating-points-v2 = <&cpu_opp_table>;
>                 };
>
>                 CPU3: cpu@3 {
> @@ -140,6 +146,8 @@
>                         next-level-cache = <&L2_0>;
>                         enable-method = "psci";
>                         cpu-idle-states = <&CPU_SPC>;
> +                       clocks = <&apcs 0>;
> +                       operating-points-v2 = <&cpu_opp_table>;
>                 };
>
>                 L2_0: l2-cache {
> @@ -212,6 +220,24 @@
>
>         };
>
> +       cpu_opp_table: cpu_opp_table {
> +               compatible = "operating-points-v2";
> +               opp-shared;
> +
> +               opp-200000000 {
> +                       opp-hz = /bits/ 64 <200000000>;
> +               };
> +               opp-400000000 {
> +                       opp-hz = /bits/ 64 <400000000>;
> +               };
> +               opp-800000000 {
> +                       opp-hz = /bits/ 64 <800000000>;
> +               };
> +               opp-998400000 {
> +                       opp-hz = /bits/ 64 <998400000>;
> +               };
> +       };
> +
>         gpu_opp_table: opp_table {
>                 compatible = "operating-points-v2";
>
