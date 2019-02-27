Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD7AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7318420C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbfB0NtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:49:04 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:29897 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730094AbfB0NtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:49:03 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id C6F4913F85F;
        Wed, 27 Feb 2019 14:48:42 +0100 (CET)
Subject: Re: [PATCH] phy: qcom: qmp: Add SDM845 PCIe QMP PHY support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <20190226065919.22218-1-bjorn.andersson@linaro.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <1e1074af-bdd1-3e0f-6f52-14b3057c73ba@free.fr>
Date:   Wed, 27 Feb 2019 14:48:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190226065919.22218-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2019 07:59, Bjorn Andersson wrote:

> +static const unsigned int sdm845_pciephy_regs_layout[] = {
> +	[QPHY_START_CTRL]		= 0x08,
> +	[QPHY_PCS_READY_STATUS]		= 0x174,
> +};
> +

Just use pciephy_regs_layout?

> +static const struct qmp_phy_cfg sdm845_pciephy_cfg = {
> +	.type = PHY_TYPE_PCIE,
> +	.nlanes = 1,
> +
> +	.serdes_tbl		= sdm845_pcie_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sdm845_pcie_serdes_tbl),
> +	.tx_tbl			= sdm845_pcie_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(sdm845_pcie_tx_tbl),
> +	.rx_tbl			= sdm845_pcie_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sdm845_pcie_rx_tbl),
> +	.pcs_tbl		= sdm845_pcie_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sdm845_pcie_pcs_tbl),
> +	.pcs_misc_tbl		= sdm845_pcie_pcs_misc_tbl,
> +	.pcs_misc_tbl_num	= ARRAY_SIZE(sdm845_pcie_pcs_misc_tbl),
> +	.clk_list		= sdm845_pciephy_clk_l,
> +	.num_clks		= ARRAY_SIZE(sdm845_pciephy_clk_l),
> +	.reset_list		= sdm845_pciephy_reset_l,
> +	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= sdm845_pciephy_regs_layout,

pciephy_regs_layout

> +
> +	.start_ctrl		= PCS_START | SERDES_START,
> +	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> +	.mask_com_pcs_ready	= PCS_READY,
> +
> +	.has_phy_com_ctrl	= false,
> +	.has_lane_rst		= false,

Obviously, false entries may be omitted.

> +	.has_pwrdn_delay	= true,
> +	.pwrdn_delay_min	= 995,		/* us */
> +	.pwrdn_delay_max	= 1005,		/* us */

I think you can drop this.

Regards.
