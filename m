Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67653C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B26223DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PJJEqv10";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YyQZWku/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B26223DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752761AbeGBGmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 02:42:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52794 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752068AbeGBGmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 02:42:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 082BA606FC; Mon,  2 Jul 2018 06:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530513738;
        bh=n8bOhuB4DFBlB5Rxl2IIfr1KzPyl6lsX6Z1Y7ajB6Ng=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=PJJEqv10R9mNPTo3lStFMRODFC+P7ZjkzN7phj/8CXaiAwT9+Yopjt+1cvJHt2DZ6
         y1auSGs5bwsU0aKvaEFiyPktEj6JRaXB3sWjQWuaUJMbjAh3T6fuofVT0nzwWhZk+4
         iIHymv62jQLvFSMAgm9hnBumwut6Mz3IuQpAZy6I=
Received: from mail-qk0-f180.google.com (mail-qk0-f180.google.com [209.85.220.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 06C1660B10;
        Mon,  2 Jul 2018 06:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530513737;
        bh=n8bOhuB4DFBlB5Rxl2IIfr1KzPyl6lsX6Z1Y7ajB6Ng=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=YyQZWku/hEx0ozUiPFMoScmoKY1SKnNdrxZJsTeW2Gw+ZDRZB+nf23NNYFBzTwgwh
         8r8u9l9cg7SL1xvbAp97ypMMJESPw9DPThO3WWqB6cBKM3QwYaDZdkzK2ehbJ8eJ8Z
         IAqEavUCn9gGsHQkHnGDQ5DtP7i7h/pNEehVxDRM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06C1660B10
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk0-f180.google.com with SMTP id u62-v6so8126284qkf.9;
        Sun, 01 Jul 2018 23:42:16 -0700 (PDT)
X-Gm-Message-State: APt69E3O2DLhCaxn4M5s2QP8q98tyCUYRF2sVM3zVH5re/7q0edH0gBm
        mEB8c7M9Ddoa6QEz7rXc2ODWqRdzQhiongMZTCQ=
X-Google-Smtp-Source: AAOMgpdeJXz2mhnmJ1M/kDt174PfJoPVeCE+S7h2JZK6svRz1XTbSsDfgDKhxUcBqfqk1QSawrtGVjeZWtN9xMQMu54=
X-Received: by 2002:a37:7c45:: with SMTP id x66-v6mr20581844qkc.310.1530513736201;
 Sun, 01 Jul 2018 23:42:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:1082:0:0:0:0:0 with HTTP; Sun, 1 Jul 2018 23:42:15 -0700 (PDT)
In-Reply-To: <20180619083647.10116-3-cang@codeaurora.org>
References: <20180619083647.10116-1-cang@codeaurora.org> <20180619083647.10116-3-cang@codeaurora.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Mon, 2 Jul 2018 12:12:15 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEP7jvT_UZ-ui6BrYOkOUAYPen3bTEwKURJ9zZBnWa=MA@mail.gmail.com>
Message-ID: <CAFp+6iEP7jvT_UZ-ui6BrYOkOUAYPen3bTEwKURJ9zZBnWa=MA@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] phy: General struct and field cleanup
To:     Can Guo <cang@codeaurora.org>
Cc:     Subhash Jadavani <subhashj@codeaurora.org>,
        asutoshd@codeaurora.org, Manu Gautam <mgautam@codeaurora.org>,
        kishon <kishon@ti.com>, "robh+dt" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Can,


On Tue, Jun 19, 2018 at 2:06 PM, Can Guo <cang@codeaurora.org> wrote:
> Move MSM8996 specific PHY vreg list struct name to a genernal one as it is
> used by all PHYs. Add a specific field to handle dual lane situation.
>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index ccb8578..9be9754 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -649,6 +649,8 @@ struct qmp_phy_cfg {
>
>         /* true, if PHY has a separate DP_COM control block */
>         bool has_phy_dp_com_ctrl;
> +       /* true, if PHY has secondary tx/rx lanes to be configured */
> +       bool is_dual_lane_phy;
>         /* Register offset of secondary tx/rx lanes for USB DP combo PHY */
>         unsigned int tx_b_lane_offset;
>         unsigned int rx_b_lane_offset;
> @@ -758,7 +760,7 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
>  };
>
>  /* list of regulators */
> -static const char * const msm8996_phy_vreg_l[] = {
> +static const char * const qmp_phy_vreg_l[] = {
>         "vdda-phy", "vdda-pll",
>  };
>
> @@ -778,8 +780,8 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
>         .num_clks               = ARRAY_SIZE(msm8996_phy_clk_l),
>         .reset_list             = msm8996_pciephy_reset_l,
>         .num_resets             = ARRAY_SIZE(msm8996_pciephy_reset_l),
> -       .vreg_list              = msm8996_phy_vreg_l,
> -       .num_vregs              = ARRAY_SIZE(msm8996_phy_vreg_l),
> +       .vreg_list              = qmp_phy_vreg_l,
> +       .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
>         .regs                   = pciephy_regs_layout,
>
>         .start_ctrl             = PCS_START | PLL_READY_GATE_EN,
> @@ -809,8 +811,8 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
>         .num_clks               = ARRAY_SIZE(msm8996_phy_clk_l),
>         .reset_list             = msm8996_usb3phy_reset_l,
>         .num_resets             = ARRAY_SIZE(msm8996_usb3phy_reset_l),
> -       .vreg_list              = msm8996_phy_vreg_l,
> -       .num_vregs              = ARRAY_SIZE(msm8996_phy_vreg_l),
> +       .vreg_list              = qmp_phy_vreg_l,
> +       .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
>         .regs                   = usb3phy_regs_layout,
>
>         .start_ctrl             = SERDES_START | PCS_START,
> @@ -870,8 +872,8 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
>         .num_clks               = ARRAY_SIZE(qmp_v3_phy_clk_l),
>         .reset_list             = msm8996_usb3phy_reset_l,
>         .num_resets             = ARRAY_SIZE(msm8996_usb3phy_reset_l),
> -       .vreg_list              = msm8996_phy_vreg_l,
> -       .num_vregs              = ARRAY_SIZE(msm8996_phy_vreg_l),
> +       .vreg_list              = qmp_phy_vreg_l,
> +       .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
>         .regs                   = qmp_v3_usb3phy_regs_layout,
>
>         .start_ctrl             = SERDES_START | PCS_START,
> @@ -883,6 +885,7 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
>         .pwrdn_delay_max        = POWER_DOWN_DELAY_US_MAX,
>
>         .has_phy_dp_com_ctrl    = true,
> +       .is_dual_lane_phy       = true,
>         .tx_b_lane_offset       = 0x400,
>         .rx_b_lane_offset       = 0x400,
>  };
> @@ -903,8 +906,8 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
>         .num_clks               = ARRAY_SIZE(qmp_v3_phy_clk_l),
>         .reset_list             = msm8996_usb3phy_reset_l,
>         .num_resets             = ARRAY_SIZE(msm8996_usb3phy_reset_l),
> -       .vreg_list              = msm8996_phy_vreg_l,
> -       .num_vregs              = ARRAY_SIZE(msm8996_phy_vreg_l),
> +       .vreg_list              = qmp_phy_vreg_l,
> +       .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
>         .regs                   = qmp_v3_usb3phy_regs_layout,
>
>         .start_ctrl             = SERDES_START | PCS_START,
> @@ -1116,12 +1119,12 @@ static int qcom_qmp_phy_init(struct phy *phy)
>         /* Tx, Rx, and PCS configurations */
>         qcom_qmp_phy_configure(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num);
>         /* Configuration for other LANE for USB-DP combo PHY */
> -       if (cfg->has_phy_dp_com_ctrl)
> +       if (cfg->is_dual_lane_phy)
>                 qcom_qmp_phy_configure(tx + cfg->tx_b_lane_offset, cfg->regs,
>                                        cfg->tx_tbl, cfg->tx_tbl_num);
>
>         qcom_qmp_phy_configure(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num);
> -       if (cfg->has_phy_dp_com_ctrl)
> +       if (cfg->is_dual_lane_phy)
>                 qcom_qmp_phy_configure(rx + cfg->rx_b_lane_offset, cfg->regs,
>                                        cfg->rx_tbl, cfg->rx_tbl_num);
>

Thanks for the patch. Looks good to me now.
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Best regards
Vivek

> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
