Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753408AbeEOSFs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753007AbeEOSFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:05:45 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180418000926.4998-1-bjorn.andersson@linaro.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20180418000926.4998-1-bjorn.andersson@linaro.org>
Message-ID: <152640754443.34267.2752714761157535255@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: qcom: Add some missing gcc clks for msm8996
Date: Tue, 15 May 2018 11:05:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FI6iSZ013431

Quoting Bjorn Andersson (2018-04-17 17:09:26)
> @@ -3350,6 +3522,7 @@ static struct clk_regmap *gcc_msm8996_clocks[] = {
>         [GCC_AGGRE0_CNOC_AHB_CLK] = &gcc_aggre0_cnoc_ahb_clk.clkr,
>         [GCC_SMMU_AGGRE0_AXI_CLK] = &gcc_smmu_aggre0_axi_clk.clkr,
>         [GCC_SMMU_AGGRE0_AHB_CLK] = &gcc_smmu_aggre0_ahb_clk.clkr,
> +       [GCC_AGGRE1_PNOC_AHB_CLK] = &gcc_aggre1_pnoc_ahb_clk.clkr,
>         [GCC_AGGRE2_UFS_AXI_CLK] = &gcc_aggre2_ufs_axi_clk.clkr,
>         [GCC_AGGRE2_USB3_AXI_CLK] = &gcc_aggre2_usb3_axi_clk.clkr,
>         [GCC_QSPI_AHB_CLK] = &gcc_qspi_ahb_clk.clkr,
> @@ -3360,6 +3533,19 @@ static struct clk_regmap *gcc_msm8996_clocks[] = {
>         [GCC_PCIE_CLKREF_CLK] = &gcc_pcie_clkref_clk.clkr,
>         [GCC_RX2_USB2_CLKREF_CLK] = &gcc_rx2_usb2_clkref_clk.clkr,
>         [GCC_RX1_USB2_CLKREF_CLK] = &gcc_rx1_usb2_clkref_clk.clkr,
> +       [GCC_HLOS1_VOTE_LPASS_CORE_SMMU_CLK] =
> +                                       &hlos1_vote_lpass_core_smmu_clk.clkr,

drivers/clk/qcom/gcc-msm8996.c:3512:10: warning: Initializer entry defined twice
drivers/clk/qcom/gcc-msm8996.c:3536:10: also defined here

Resend please, or at least let me know what to do here. It looks like
the one you sent has the parent chain setup properly so that the bus
rcgs are in the chain of clks, while the one that is already there
doesn't have the chain setup.
