Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tqjJEQQ6Gls+IAAAmS7hNA
	; Fri, 08 Jun 2018 08:11:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C676A607DC; Fri,  8 Jun 2018 08:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528445467;
	bh=EoEBDdBF9/dfug+pGiMgFg9/StK2i0egtLbTpkqy/k4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=I6E8oSe2PydNJywEpSTXYeh6Ggw5lEG5phrToDHgNDBU9Qb2jFBQy89dume6NXH7L
	 Coz9oW7NoymVMd/DImObdVMWXoU9KOeHLTBE7CyHRbA1gY7pYe2aXwuEpiV8+nHVe2
	 /yJLVOfSwE+D+lsnsIG6tUs5AJDUt8e7tdqBjkQk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7ABE1602FC;
	Fri,  8 Jun 2018 08:11:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L46Lj0JP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z/l2g3uq"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7ABE1602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbeFHILD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:11:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57178 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeFHIK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:10:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 71014607A4; Fri,  8 Jun 2018 08:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528445457;
        bh=EoEBDdBF9/dfug+pGiMgFg9/StK2i0egtLbTpkqy/k4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L46Lj0JP3wEs6eHjrfy/XK6xq9sqQXlJO+Ir5CBxsgCepd3eaKeYXIs8V+V2GQMa3
         Xn1FowVmVGkj+mKNQlQnR6QbZDcmPiXxlcttxo/oZQWSQL3/gdo9BzYAUPdXP00VmT
         Ituy1l65N3YjtoGgvE9b9TDd7o877pY0GM9RKyHM=
Received: from [10.79.40.128] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 54718602FC;
        Fri,  8 Jun 2018 08:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528445455;
        bh=EoEBDdBF9/dfug+pGiMgFg9/StK2i0egtLbTpkqy/k4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Z/l2g3uqkk8/rif8NrdKQxmdXhkwPNa6hB9oLKyksGNA1NPRFmKmYnLVdHsJbYi1W
         lLLlSxddb83ldq9mKdwgSGbCa1sttBDiRQAFNVnH+L3Frt4JwI19yE0aWB0/gDDzho
         wdI4tIqPqV4+vGZhGUoX5eTSrHOxsaBSBULy3TJs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54718602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v6 2/3] phy: Add QMP phy based UFS phy support for sdm845
To: Can Guo <cang@codeaurora.org>, subhashj@codeaurora.org,
        asutoshd@codeaurora.org, mgautam@codeaurora.org, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20180529043751.10580-1-cang@codeaurora.org>
 <20180529043751.10580-3-cang@codeaurora.org>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <ed3f30e6-cce4-d702-b44b-4795bc4bc839@codeaurora.org>
Date: Fri, 8 Jun 2018 13:40:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529043751.10580-3-cang@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Can,


On 5/29/2018 10:07 AM, Can Guo wrote:
> Add UFS PHY support to make SDM845 UFS work with common PHY framework.
>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp.c | 200 +++++++++++++++++++++++++++++++++---
>   drivers/phy/qualcomm/phy-qcom-qmp.h |  15 +++
>   2 files changed, 203 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index f779b0f..ee74dcd 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -156,6 +156,11 @@ enum qphy_reg_layout {
>   	[QPHY_PCS_LFPS_RXTERM_IRQ_STATUS] = 0x170,
>   };
>   
> +static const unsigned int sdm845_ufsphy_regs_layout[] = {
> +	[QPHY_START_CTRL]		= 0x00,
> +	[QPHY_PCS_READY_STATUS]		= 0x160,
> +};
> +
>   static const struct qmp_phy_init_tbl msm8996_pcie_serdes_tbl[] = {
>   	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x1c),
>   	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_ENABLE1, 0x10),
> @@ -601,6 +606,83 @@ enum qphy_reg_layout {
>   	QMP_PHY_INIT_CFG(QPHY_V3_PCS_REFGEN_REQ_CONFIG2, 0x60),
>   };
>   
> +static const struct qmp_phy_init_tbl sdm845_ufsphy_serdes_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYS_CLK_CTRL, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BG_TIMER, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_IVCO, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CMN_CONFIG, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYSCLK_EN_SEL, 0xd5),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_RESETSM_CNTRL, 0x20),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_HSCLK_SEL, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP_EN, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_CTRL, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CORE_CLK_EN, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_MAP, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SVS_MODE_CLK_SEL, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_INITVAL1, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_INITVAL2, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DEC_START_MODE0, 0x82),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CP_CTRL_MODE0, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_RCTRL_MODE0, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_CCTRL_MODE0, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN0_MODE0, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE1_MODE0, 0xda),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE2_MODE0, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP1_MODE0, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP2_MODE0, 0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DEC_START_MODE1, 0x98),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CP_CTRL_MODE1, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_RCTRL_MODE1, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_CCTRL_MODE1, 0x36),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN0_MODE1, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN1_MODE1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE1_MODE1, 0xc1),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE2_MODE1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP1_MODE1, 0x32),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP2_MODE1, 0x0f),
> +
> +	/* Rate B */
> +	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_MAP, 0x44),
> +};
> +
> +static const struct qmp_phy_init_tbl sdm845_ufsphy_tx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_RX, 0x07),
> +};
> +
> +static const struct qmp_phy_init_tbl sdm845_ufsphy_rx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_LVL, 0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_INTERFACE_MODE, 0x40),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_TERM_BW, 0x5b),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x1b),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN_HALF, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN_QUARTER, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x4b),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_PI_CONTROLS, 0x81),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_LOW, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x59),
> +};
> +
> +static const struct qmp_phy_init_tbl sdm845_ufsphy_pcs_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_CTRL2, 0x6e),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TX_LARGE_AMP_DRV_LVL, 0x0a),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TX_SMALL_AMP_DRV_LVL, 0x02),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SYM_RESYNC_CTRL, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_TX_MID_TERM_CTRL1, 0x43),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_CTRL1, 0x0f),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_MIN_HIBERN8_TIME, 0x9a),
> +	QMP_PHY_INIT_CFG(QPHY_V3_PCS_MULTI_LANE_CTRL1, 0x02),
> +};
>   
>   /* struct qmp_phy_cfg - per-PHY initialization config */
>   struct qmp_phy_cfg {
> @@ -649,9 +731,14 @@ struct qmp_phy_cfg {
>   
>   	/* true, if PHY has a separate DP_COM control block */
>   	bool has_phy_dp_com_ctrl;
> +	/* true, if PHY has secondary tx/rx lanes to be configured */
> +	bool is_dual_lane_phy;

Separate out this change to a new patch please.

>   	/* Register offset of secondary tx/rx lanes for USB DP combo PHY */
>   	unsigned int tx_b_lane_offset;
>   	unsigned int rx_b_lane_offset;
> +
> +	/* true, if PCS block has no separate SW_RESET register */
> +	bool no_pcs_sw_reset;
>   };
>   
>   /**
> @@ -748,6 +835,10 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
>   	"aux", "cfg_ahb", "ref", "com_aux",
>   };
>   
> +static const char * const sdm845_ufs_phy_clk_l[] = {
> +	"ref", "ref_aux",
> +};
> +
>   /* list of resets */
>   static const char * const msm8996_pciephy_reset_l[] = {
>   	"phy", "common", "cfg",
> @@ -758,7 +849,7 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
>   };
>   
>   /* list of regulators */
> -static const char * const msm8996_phy_vreg_l[] = {
> +static const char * const qmp_phy_vreg_l[] = {

These changes are not related to ufs, so better keep all these in a separate
patch, say 'cleanup', as mentioned above.

>   	"vdda-phy", "vdda-pll",
>   };
>   
> @@ -778,8 +869,8 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
>   	.num_clks		= ARRAY_SIZE(msm8996_phy_clk_l),
>   	.reset_list		= msm8996_pciephy_reset_l,
>   	.num_resets		= ARRAY_SIZE(msm8996_pciephy_reset_l),
> -	.vreg_list		= msm8996_phy_vreg_l,
> -	.num_vregs		= ARRAY_SIZE(msm8996_phy_vreg_l),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),

So this changes and other vreg changes in cfg goes to the separate patch.

>   	.regs			= pciephy_regs_layout,
>   
>   	.start_ctrl		= PCS_START | PLL_READY_GATE_EN,
> @@ -809,8 +900,8 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
>   	.num_clks		= ARRAY_SIZE(msm8996_phy_clk_l),
>   	.reset_list		= msm8996_usb3phy_reset_l,
>   	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
> -	.vreg_list		= msm8996_phy_vreg_l,
> -	.num_vregs		= ARRAY_SIZE(msm8996_phy_vreg_l),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>   	.regs			= usb3phy_regs_layout,
>   
>   	.start_ctrl		= SERDES_START | PCS_START,
> @@ -870,8 +961,8 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
>   	.num_clks		= ARRAY_SIZE(qmp_v3_phy_clk_l),
>   	.reset_list		= msm8996_usb3phy_reset_l,
>   	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
> -	.vreg_list		= msm8996_phy_vreg_l,
> -	.num_vregs		= ARRAY_SIZE(msm8996_phy_vreg_l),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>   	.regs			= qmp_v3_usb3phy_regs_layout,
>   
>   	.start_ctrl		= SERDES_START | PCS_START,
> @@ -883,6 +974,7 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
>   	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
>   
>   	.has_phy_dp_com_ctrl	= true,
> +	.is_dual_lane_phy	= true,

This too goes to the new patch.

>   	.tx_b_lane_offset	= 0x400,
>   	.rx_b_lane_offset	= 0x400,
>   };
> @@ -903,8 +995,8 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
>   	.num_clks		= ARRAY_SIZE(qmp_v3_phy_clk_l),
>   	.reset_list		= msm8996_usb3phy_reset_l,
>   	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
> -	.vreg_list		= msm8996_phy_vreg_l,
> -	.num_vregs		= ARRAY_SIZE(msm8996_phy_vreg_l),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
>   	.regs			= qmp_v3_usb3phy_regs_layout,
>   
>   	.start_ctrl		= SERDES_START | PCS_START,
> @@ -916,6 +1008,35 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
>   	.pwrdn_delay_max	= POWER_DOWN_DELAY_US_MAX,
>   };
>   
> +static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
> +	.type			= PHY_TYPE_UFS,
> +	.nlanes			= 2,
> +
> +	.serdes_tbl		= sdm845_ufsphy_serdes_tbl,
> +	.serdes_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_serdes_tbl),
> +	.tx_tbl			= sdm845_ufsphy_tx_tbl,
> +	.tx_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_tx_tbl),
> +	.rx_tbl			= sdm845_ufsphy_rx_tbl,
> +	.rx_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_rx_tbl),
> +	.pcs_tbl		= sdm845_ufsphy_pcs_tbl,
> +	.pcs_tbl_num		= ARRAY_SIZE(sdm845_ufsphy_pcs_tbl),
> +	.clk_list		= sdm845_ufs_phy_clk_l,
> +	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
> +	.vreg_list		= qmp_phy_vreg_l,
> +	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
> +	.regs			= sdm845_ufsphy_regs_layout,
> +
> +	.start_ctrl		= SERDES_START,
> +	.pwrdn_ctrl		= SW_PWRDN,
> +	.mask_pcs_ready		= PCS_READY,
> +
> +	.is_dual_lane_phy	= true,
> +	.tx_b_lane_offset	= 0x400,
> +	.rx_b_lane_offset	= 0x400,
> +
> +	.no_pcs_sw_reset	= true,
> +};
> +
>   static void qcom_qmp_phy_configure(void __iomem *base,
>   				   const unsigned int *regs,
>   				   const struct qmp_phy_init_tbl tbl[],
> @@ -938,7 +1059,9 @@ static void qcom_qmp_phy_configure(void __iomem *base,
>   static int qcom_qmp_phy_com_init(struct qcom_qmp *qmp)
>   {
>   	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	struct qmp_phy *qphy = qmp->phys[0];
>   	void __iomem *serdes = qmp->serdes;
> +	void __iomem *pcs = qphy->pcs;
>   	void __iomem *dp_com = qmp->dp_com;
>   	int ret, i;
>   
> @@ -1114,18 +1237,27 @@ static int qcom_qmp_phy_init(struct phy *phy)
>   	/* Tx, Rx, and PCS configurations */
>   	qcom_qmp_phy_configure(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num);
>   	/* Configuration for other LANE for USB-DP combo PHY */
> -	if (cfg->has_phy_dp_com_ctrl)
> +	if (cfg->is_dual_lane_phy)
>   		qcom_qmp_phy_configure(tx + cfg->tx_b_lane_offset, cfg->regs,
>   				       cfg->tx_tbl, cfg->tx_tbl_num);
>   
>   	qcom_qmp_phy_configure(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num);
> -	if (cfg->has_phy_dp_com_ctrl)
> +	if (cfg->is_dual_lane_phy)

And these couple of changes too to the new patch. This helps in 
bisecting in the
time of issue.

>   		qcom_qmp_phy_configure(rx + cfg->rx_b_lane_offset, cfg->regs,
>   				       cfg->rx_tbl, cfg->rx_tbl_num);
>   
>   	qcom_qmp_phy_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
>   
>   	/*
> +	 * UFS PHY requires the deassert of software reset before serdes start.
> +	 * For UFS PHY that has not software reset control bits in its address
> +	 * space, it should skip starting serdes here. UFS PHY Serdes shall
> +	 * start when UFS explicitly calls PHY power on.
> +	 */
> +	if ((cfg->type == PHY_TYPE_UFS) && cfg->no_pcs_sw_reset)
> +		goto out;
> +
> +	/*
>   	 * Pull out PHY from POWER DOWN state.
>   	 * This is active low enable signal to power-down PHY.
>   	 */
> @@ -1154,6 +1286,7 @@ static int qcom_qmp_phy_init(struct phy *phy)
>   	}
>   	qmp->phy_initialized = true;
>   
> +out:
>   	return ret;
>   
>   err_pcs_ready:
> @@ -1176,7 +1309,8 @@ static int qcom_qmp_phy_exit(struct phy *phy)
>   	clk_disable_unprepare(qphy->pipe_clk);
>   
>   	/* PHY reset */
> -	qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
> +	if (!cfg->no_pcs_sw_reset)
> +		qphy_setbits(qphy->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
>   
>   	/* stop SerDes and Phy-Coding-Sublayer */
>   	qphy_clrbits(qphy->pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
> @@ -1194,6 +1328,44 @@ static int qcom_qmp_phy_exit(struct phy *phy)
>   	return 0;
>   }
>   
> +static int qcom_qmp_phy_poweron(struct phy *phy)
> +{
> +	struct qmp_phy *qphy = phy_get_drvdata(phy);
> +	struct qcom_qmp *qmp = qphy->qmp;
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	void __iomem *pcs = qphy->pcs;
> +	void __iomem *status;
> +	unsigned int mask, val;
> +	int ret = 0;
> +
> +	if (cfg->type != PHY_TYPE_UFS)
> +		return 0;
> +
> +	/*
> +	 * For UFS PHY that has not software reset control, serdes start
> +	 * should only happen when UFS driver explicitly calls phy_power_on
> +	 * after it deasserts software reset.
> +	 */
> +	if (cfg->no_pcs_sw_reset && !qmp->phy_initialized &&
> +	    (qmp->init_count !=0)) {
> +		/* start SerDes and Phy-Coding-Sublayer */
> +		qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_ctrl);
> +
> +		status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
> +		mask = cfg->mask_pcs_ready;
> +
> +		ret = readl_poll_timeout(status, val, !(val & mask), 1,
> +					 PHY_INIT_COMPLETE_TIMEOUT);
> +		if (ret) {
> +			dev_err(qmp->dev, "phy initialization timed-out\n");
> +			return ret;
> +		}
> +		qmp->phy_initialized = true;
> +	}
> +
> +	return ret;
> +}
> +
>   static int qcom_qmp_phy_set_mode(struct phy *phy, enum phy_mode mode)
>   {
>   	struct qmp_phy *qphy = phy_get_drvdata(phy);
> @@ -1423,6 +1595,7 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
>   static const struct phy_ops qcom_qmp_phy_gen_ops = {
>   	.init		= qcom_qmp_phy_init,
>   	.exit		= qcom_qmp_phy_exit,
> +	.power_on	= qcom_qmp_phy_poweron,
>   	.set_mode	= qcom_qmp_phy_set_mode,
>   	.owner		= THIS_MODULE,
>   };
> @@ -1528,6 +1701,9 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
>   	}, {
>   		.compatible = "qcom,sdm845-qmp-usb3-uni-phy",
>   		.data = &qmp_v3_usb3_uniphy_cfg,
> +	}, {
> +		.compatible = "qcom,sdm845-qmp-ufs-phy",
> +		.data = &sdm845_ufsphy_cfg,
>   	},
>   	{ },
>   };
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
> index 5d78d43..d201cc3 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
> @@ -184,6 +184,8 @@
>   #define QSERDES_V3_COM_VCO_TUNE2_MODE0			0x0f8
>   #define QSERDES_V3_COM_VCO_TUNE1_MODE1			0x0fc
>   #define QSERDES_V3_COM_VCO_TUNE2_MODE1			0x100
> +#define QSERDES_V3_COM_VCO_TUNE_INITVAL1		0x104
> +#define QSERDES_V3_COM_VCO_TUNE_INITVAL2		0x108
>   #define QSERDES_V3_COM_VCO_TUNE_TIMER1			0x11c
>   #define QSERDES_V3_COM_VCO_TUNE_TIMER2			0x120
>   #define QSERDES_V3_COM_CLK_SELECT			0x138
> @@ -211,8 +213,13 @@
>   /* Only for QMP V3 PHY - RX registers */
>   #define QSERDES_V3_RX_UCDR_SO_GAIN_HALF			0x00c
>   #define QSERDES_V3_RX_UCDR_SO_GAIN			0x014
> +#define QSERDES_V3_RX_UCDR_SVS_SO_GAIN_HALF		0x024
> +#define QSERDES_V3_RX_UCDR_SVS_SO_GAIN_QUARTER		0x028
> +#define QSERDES_V3_RX_UCDR_SVS_SO_GAIN			0x02c
>   #define QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN		0x030
>   #define QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE	0x034
> +#define QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_LOW		0x03c
> +#define QSERDES_V3_RX_UCDR_PI_CONTROLS			0x044
>   #define QSERDES_V3_RX_RX_TERM_BW			0x07c
>   #define QSERDES_V3_RX_VGA_CAL_CNTRL1			0x0bc
>   #define QSERDES_V3_RX_VGA_CAL_CNTRL2			0x0c0
> @@ -239,6 +246,8 @@
>   #define QPHY_V3_PCS_TXMGN_V3				0x018
>   #define QPHY_V3_PCS_TXMGN_V4				0x01c
>   #define QPHY_V3_PCS_TXMGN_LS				0x020
> +#define QPHY_V3_PCS_TX_LARGE_AMP_DRV_LVL		0x02c
> +#define QPHY_V3_PCS_TX_SMALL_AMP_DRV_LVL		0x034
>   #define QPHY_V3_PCS_TXDEEMPH_M6DB_V0			0x024
>   #define QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0			0x028
>   #define QPHY_V3_PCS_TXDEEMPH_M6DB_V1			0x02c
> @@ -275,6 +284,12 @@
>   #define QPHY_V3_PCS_FLL_CNT_VAL_L			0x0cc
>   #define QPHY_V3_PCS_FLL_CNT_VAL_H_TOL			0x0d0
>   #define QPHY_V3_PCS_FLL_MAN_CODE			0x0d4
> +#define QPHY_V3_PCS_RX_SYM_RESYNC_CTRL			0x134
> +#define QPHY_V3_PCS_RX_MIN_HIBERN8_TIME			0x138
> +#define QPHY_V3_PCS_RX_SIGDET_CTRL1			0x13c
> +#define QPHY_V3_PCS_RX_SIGDET_CTRL2			0x140
> +#define QPHY_V3_PCS_TX_MID_TERM_CTRL1			0x1bc
> +#define QPHY_V3_PCS_MULTI_LANE_CTRL1			0x1c4
>   #define QPHY_V3_PCS_RX_SIGDET_LVL			0x1d8
>   #define QPHY_V3_PCS_REFGEN_REQ_CONFIG1			0x20c
>   #define QPHY_V3_PCS_REFGEN_REQ_CONFIG2			0x210
