Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73308C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFFB20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BBpehgEo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FgZI1AgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFFB20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbeLGIqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:46:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56130 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeLGIqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:46:16 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B18A7607DC; Fri,  7 Dec 2018 08:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544172374;
        bh=i0rXhwikrM1oWiIKXwp49pVJYatckWMLVx0I6XMKtVg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BBpehgEoxOl1T0OwTII9Ua6VnAHYjWaA9JmfZw9Gwy/9zj4prJ7XDGH1cCt0ubf8x
         HGQb0BYw1Z86GkGZh7CEHSFcQVT4IB10F+5NFFN+RGo7LgPBGLonu1P0yauYALgQPr
         dsX1mBhBtCDU/AeKDJVwbmHuFUl95XxpMLePH+Kw=
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A02860AD8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Dec 2018 08:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544172373;
        bh=i0rXhwikrM1oWiIKXwp49pVJYatckWMLVx0I6XMKtVg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FgZI1AgDOEauWmRNOsHOKmR6yTx+FI1thRuCx0pL1yOLaB89/DiYLGuNjtJ1sIMBG
         rGeJMhOx9PFq67OCqjUlz4K0Xm2tEtPtydcjiqMMkt9Y6KY7h6m0/XQIpX5zfcdDRB
         sG1Xcta4AKK4+1eQDcKr5WH9HITLmqoQ9TJDiaXI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A02860AD8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f176.google.com with SMTP id e5so3598465qtr.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 00:46:13 -0800 (PST)
X-Gm-Message-State: AA+aEWaAk+jvbkEpfY3KlkRgjg4TyyxtYCJ9LeqzgrNz8jewBvy4j/fg
        GYXZNKr48C8QsB0EQ2nJlG+sYBoQXxCSf4vPu70=
X-Google-Smtp-Source: AFSGD/Vvq1UMffw31LkgeIvqwDequFg450qwTKrXG14ztGlXRyto6zxriaQPEmZZ56FFfMeU1PeyA47fR0EIEbgzbCc=
X-Received: by 2002:ac8:3d8a:: with SMTP id v10mr1170066qtf.74.1544172372517;
 Fri, 07 Dec 2018 00:46:12 -0800 (PST)
MIME-Version: 1.0
References: <20181206233205.193244-1-evgreen@chromium.org> <20181206233205.193244-3-evgreen@chromium.org>
In-Reply-To: <20181206233205.193244-3-evgreen@chromium.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Fri, 7 Dec 2018 14:16:00 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHj=Z=MQA0WJBLHb9_KyYPz_snxoYNXAgbGndiqEc_=YQ@mail.gmail.com>
Message-ID: <CAFp+6iHj=Z=MQA0WJBLHb9_KyYPz_snxoYNXAgbGndiqEc_=YQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] phy: qcom-qmp: Utilize fully-specified DT registers
To:     evgreen@chromium.org
Cc:     Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        kishon <kishon@ti.com>, Doug Anderson <dianders@chromium.org>,
        swboyd@chromium.org, Grygorii Strashko <grygorii.strashko@ti.com>,
        Can Guo <cang@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 5:06 AM Evan Green <evgreen@chromium.org> wrote:
>
> Utilize the newly fixed up DT bindings to get the tx2 and rx2 register
> regions for the second lane of dual-lane PHYs. Before this change,
> the driver was simply using lane one's register region and adding
> 0x400, which reached well beyond the DT-specified register
> allocation. This would have been a crash were it not for the page size
> on ARM64. Fix the driver not to rely on the magic of virtual memory by
> using the newly specified DT register regions for tx2 and rx2.
>
> In order to support existing device trees, this change also contains a
> fallback mode for when those new register regions don't exist, which
> reverts to the original behavior of overreaching and prints a complaint.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> As Doug mentioned, this should land before the dts patches land, otherwise
> the old driver code will use the tx2 register region as pcs_misc.
>
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 51 +++++++++++++++++++++--------
>  1 file changed, 38 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 514db7248a5d0..8204d55e2d650 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -72,6 +72,9 @@
>
>  #define MAX_PROP_NAME                          32
>
> +/* Define the assumed distance between lanes for underspecified device trees. */
> +#define QMP_PHY_LEGACY_LANE_STRIDE             0x400
> +
>  struct qmp_phy_init_tbl {
>         unsigned int offset;
>         unsigned int val;
> @@ -733,9 +736,6 @@ struct qmp_phy_cfg {
>         bool has_phy_dp_com_ctrl;
>         /* true, if PHY has secondary tx/rx lanes to be configured */
>         bool is_dual_lane_phy;
> -       /* Register offset of secondary tx/rx lanes for USB DP combo PHY */
> -       unsigned int tx_b_lane_offset;
> -       unsigned int rx_b_lane_offset;
>
>         /* true, if PCS block has no separate SW_RESET register */
>         bool no_pcs_sw_reset;
> @@ -748,6 +748,8 @@ struct qmp_phy_cfg {
>   * @tx: iomapped memory space for lane's tx
>   * @rx: iomapped memory space for lane's rx
>   * @pcs: iomapped memory space for lane's pcs
> + * @tx2: iomapped memory space for second lane's tx (in dual lane PHYs)
> + * @rx2: iomapped memory space for second lane's rx (in dual lane PHYs)
>   * @pcs_misc: iomapped memory space for lane's pcs_misc
>   * @pipe_clk: pipe lock
>   * @index: lane index
> @@ -759,6 +761,8 @@ struct qmp_phy {
>         void __iomem *tx;
>         void __iomem *rx;
>         void __iomem *pcs;
> +       void __iomem *tx2;
> +       void __iomem *rx2;
>         void __iomem *pcs_misc;
>         struct clk *pipe_clk;
>         unsigned int index;
> @@ -975,8 +979,6 @@ static const struct qmp_phy_cfg qmp_v3_usb3phy_cfg = {
>
>         .has_phy_dp_com_ctrl    = true,
>         .is_dual_lane_phy       = true,
> -       .tx_b_lane_offset       = 0x400,
> -       .rx_b_lane_offset       = 0x400,
>  };
>
>  static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
> @@ -1031,9 +1033,6 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
>         .mask_pcs_ready         = PCS_READY,
>
>         .is_dual_lane_phy       = true,
> -       .tx_b_lane_offset       = 0x400,
> -       .rx_b_lane_offset       = 0x400,
> -
>         .no_pcs_sw_reset        = true,
>  };
>
> @@ -1238,12 +1237,12 @@ static int qcom_qmp_phy_init(struct phy *phy)
>         qcom_qmp_phy_configure(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num);
>         /* Configuration for other LANE for USB-DP combo PHY */
>         if (cfg->is_dual_lane_phy)
> -               qcom_qmp_phy_configure(tx + cfg->tx_b_lane_offset, cfg->regs,
> +               qcom_qmp_phy_configure(qphy->tx2, cfg->regs,
>                                        cfg->tx_tbl, cfg->tx_tbl_num);
>
>         qcom_qmp_phy_configure(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num);
>         if (cfg->is_dual_lane_phy)
> -               qcom_qmp_phy_configure(rx + cfg->rx_b_lane_offset, cfg->regs,
> +               qcom_qmp_phy_configure(qphy->rx2, cfg->regs,
>                                        cfg->rx_tbl, cfg->rx_tbl_num);
>
>         qcom_qmp_phy_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
> @@ -1615,8 +1614,9 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
>
>         /*
>          * Get memory resources for each phy lane:
> -        * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2; and
> -        * pcs_misc (optional) -> 3.
> +        * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
> +        * For dual lane PHYs: tx2 -> 3, rx2 -> 4, pcs_misc (optional) -> 5
> +        * For single lane PHYs: pcs_misc (optional) -> 3.
>          */
>         qphy->tx = of_iomap(np, 0);
>         if (!qphy->tx)
> @@ -1630,7 +1630,32 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
>         if (!qphy->pcs)
>                 return -ENOMEM;
>
> -       qphy->pcs_misc = of_iomap(np, 3);
> +       /*
> +        * If this is a dual-lane PHY, then there should be registers for the
> +        * second lane. Some old device trees did not specify this, so fall
> +        * back to old legacy behavior of assuming they can be reached at an
> +        * offset from the first lane.
> +        */
> +       if (qmp->cfg->is_dual_lane_phy) {
> +               qphy->tx2 = of_iomap(np, 3);
> +               qphy->rx2 = of_iomap(np, 4);
> +               if (!qphy->tx2 || !qphy->rx2) {
> +                       dev_warn(dev,
> +                                "Underspecified device tree, falling back to legacy register regions\n");
> +
> +                       /* In the old version, pcs_misc is at index 3. */
> +                       qphy->pcs_misc = qphy->tx2;
> +                       qphy->tx2 = qphy->tx + QMP_PHY_LEGACY_LANE_STRIDE;
> +                       qphy->rx2 = qphy->rx + QMP_PHY_LEGACY_LANE_STRIDE;
> +
> +               } else {
> +                       qphy->pcs_misc = of_iomap(np, 5);
> +               }
> +
> +       } else {
> +               qphy->pcs_misc = of_iomap(np, 3);
> +       }
> +
>         if (!qphy->pcs_misc)
>                 dev_vdbg(dev, "PHY pcs_misc-reg not used\n");
>
> --
> 2.18.1
>

Tested on db820c [1]. USB, PCIe come up.
Tested-by: Vivek Gautam <vivek.gautam@codeaurora.org>

[1] https://github.com/vivekgautam1/linux/tree/origin/v4.20-rc5/db820c

BRs

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
