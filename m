Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933048AbeCFOoQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:44:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932706AbeCFOoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:44:13 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213FE2178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AG47ELsh6FRJAhkTV3qbsKKEsd3ytyO1ONtbZyJgDItSCN9oNGz1+QY9ZaT2qR35aosPLmVVMBMrR3G89qKBYEZxL8I=
MIME-Version: 1.0
In-Reply-To: <9f7199f0027ef2382e5ccc61a5118d0a00fa2e63.1520340931.git.amit.kucheria@linaro.org>
References: <cover.1520340931.git.amit.kucheria@linaro.org> <9f7199f0027ef2382e5ccc61a5118d0a00fa2e63.1520340931.git.amit.kucheria@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 6 Mar 2018 08:43:51 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+QRTi6MnsnZeDVzUXsj5ya0OBROp8HeZ1cX+F=EGtoCA@mail.gmail.com>
Message-ID: <CAL_Jsq+QRTi6MnsnZeDVzUXsj5ya0OBROp8HeZ1cX+F=EGtoCA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: msm8916: Add cpu cooling maps
To: Amit Kucheria <amit.kucheria@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Viresh

On Tue, Mar 6, 2018 at 7:05 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> From: Rajendra Nayak <rnayak@codeaurora.org>
>
> Add cpu cooling maps for cpu passive trip points. The cpu cooling
> device states are mapped to cpufreq based scaling frequencies.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index e468277..acac9e3 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -15,6 +15,7 @@
>  #include <dt-bindings/clock/qcom,gcc-msm8916.h>
>  #include <dt-bindings/reset/qcom,gcc-msm8916.h>
>  #include <dt-bindings/clock/qcom,rpmcc.h>
> +#include <dt-bindings/thermal/thermal.h>
>
>  / {
>         model = "Qualcomm Technologies, Inc. MSM8916";
> @@ -115,6 +116,10 @@
>                         cpu-idle-states = <&CPU_SPC>;
>                         clocks = <&apcs 0>;
>                         operating-points-v2 = <&cpu_opp_table>;
> +                       /* cooling options */
> +                       cooling-min-level = <0>;
> +                       cooling-max-level = <7>;

Viresh is working on removing these from the binding...

> +                       #cooling-cells = <2>;
>                 };
>
>                 CPU1: cpu@1 {
