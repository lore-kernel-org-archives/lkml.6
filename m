Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754217AbeDBJQY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 05:16:24 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33092 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbeDBJQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 05:16:21 -0400
X-Google-Smtp-Source: AIpwx4/ILoqWeeorc0USnA/vEI9qtdKvgsoeWtOk85fpXBKek6+dveUK+Kb89KJlFRJfLx+6FaPtvQ==
Date: Mon, 2 Apr 2018 14:46:17 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ilia Lin <ilialin@codeaurora.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net, lgirdwood@gmail.com,
        broonie@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: Re: [PATCH v4 08/14] dt: qcom: Add opp and thermal to the msm8996
Message-ID: <20180402091617.GA3572@vireshk-i7>
References: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org>
 <1522358807-10413-9-git-send-email-ilialin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522358807-10413-9-git-send-email-ilialin@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-03-18, 00:26, Ilia Lin wrote:
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 275 +++++++++++++++++++++++++++++++++-
>  1 file changed, 267 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 410ae78..a0792bd 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -14,6 +14,7 @@
>  #include <dt-bindings/clock/qcom,gcc-msm8996.h>
>  #include <dt-bindings/clock/qcom,mmcc-msm8996.h>
>  #include <dt-bindings/clock/qcom,rpmcc.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. MSM8996";
> @@ -97,6 +98,11 @@
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
> +			clocks = <&kryocc 0>;
> +			operating-points-v2 = <&cluster0_opp>;
> +			cooling-min-level = <0>;
> +			cooling-max-level = <15>;

The min/max properties are removed from DT documentation now. You don't need to
add them anymore.

> +	cluster0_opp: opp_table0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;

Is Kryo like krait where CPUs do DVFS independently ? If yes, then opp-shared
thing should be dropped.

> +
> +		opp-307200000 {
> +			opp-hz = /bits/ 64 <  307200000 >;

Why have you added spaces after < and before > here ?

-- 
viresh
