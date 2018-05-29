Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933171AbeE2LBF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:01:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52744 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932840AbeE2LBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:01:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79B18602A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
X-Google-Smtp-Source: ADUXVKL/j14ziPQi0s18FMvsZqqt9KWW05kILzU3hbSD8BasmrdDaxYftukkCMYrsSsh3tHTXvGjJhvDCmYS8FIBME0=
MIME-Version: 1.0
In-Reply-To: <20180525184525.355-1-bjorn.andersson@linaro.org>
References: <20180524223122.12601-1-bjorn.andersson@linaro.org> <20180525184525.355-1-bjorn.andersson@linaro.org>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Tue, 29 May 2018 16:31:00 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGAhOyC8pM57rGNyVS_zpi3XBoZzcExY=BYVrWRgt4GLQ@mail.gmail.com>
Message-ID: <CAFp+6iGAhOyC8pM57rGNyVS_zpi3XBoZzcExY=BYVrWRgt4GLQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: msm8996: Move UFS_GDSC to UFS HCD
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 12:15 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> The UFS_GDSC backs the resources needed by the UFS HCD, rather than the
> PHY. This results in the UFS HCD occationally failing to enable some of
> its clocks.
>
> Move the UFS_GDSC reference to the UFS HCD node instead, to correct
> this.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v1:
> - Dropped UFS_GDSC from phy node
>
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 380e14591686..8c7f9ca25b53 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -654,8 +654,6 @@
>                         clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
>                                  <&gcc GCC_UFS_CLKREF_CLK>;
>                         status = "disabled";
> -
> -                       power-domains = <&gcc UFS_GDSC>;
>                 };
>
>                 ufshc@624000 {
> @@ -674,6 +672,8 @@
>                         vccq-max-microamp = <450000>;
>                         vccq2-max-microamp = <450000>;
>
> +                       power-domains = <&gcc UFS_GDSC>;
> +

Looks good.
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Regards
Vivek
>                         clock-names =
>                                 "core_clk_src",
>                                 "core_clk",
> --
> 2.17.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
