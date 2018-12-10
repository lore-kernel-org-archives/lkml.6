Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC0FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33BC2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SfIu7t2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33BC2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbeLJQa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:30:28 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46868 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbeLJQa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:30:26 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so10163561ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNExA1qjOhaQFybwbEuutPFOM9IdrQkQkV/9mCAHcLE=;
        b=SfIu7t2/1w+R7i/4EfTmPOyvfrhhGhwx4W1+XPv+6jBFL1EYGXuryzkTOr9t4Gh5yo
         bTk9xgNz3of9okfPPF5gtuHSpcCbwZgY+S+WNuNHgY4ZlTBmhOxk5SyBZOSSJ87OlDlh
         uHqmJ4HxxClBVAQxHVJWY6GokwSN+7xCybJQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNExA1qjOhaQFybwbEuutPFOM9IdrQkQkV/9mCAHcLE=;
        b=KNAiYpQuHQfyzA8cM1vH+HeSvVua8TrcV/xhW5l+/Z1N41iwCyPzQhAenP750ADgXQ
         Lp+DZn8XzKl6jABZ3hL9m96PIo5/oZiDOHKiFcvH7IoezkpMzxFRchLtiHcf8gpVvckC
         rYDk3Wlszk7hg+h+lBpOxJl1SPSiTpii+q/XFjuwjt0nal3HNS/A/QN68A3XaG935gPi
         pA7SBXBs7uGWQCjJ+4f/rFvGwfF55/mCSiCv+93IwfCz+Hj9YwejiPH803yatWTFQrBv
         Ti7+96s/rN5roW0dYPGf1zVeRQzqVUttwbvFdf7v1WBcsriI9WzozA4ktxxDfonpLYIF
         Mbpg==
X-Gm-Message-State: AA+aEWbfgXUomLeUgq1fMLpd1uzGTcPrjdcYJeiI2r24kauQfYf/Krct
        M4aLaUEzQsLBHlsBMJQ5YVTUxKREX4M=
X-Google-Smtp-Source: AFSGD/ULxbXgjwwFnfu/LRGaSrvgRC6Ug3E+t+CjLx+Qsnp0OY6Ch3skOnru3zAeQ5k5yiSYcVcfLg==
X-Received: by 2002:a2e:99d7:: with SMTP id l23-v6mr7363008ljj.165.1544459423367;
        Mon, 10 Dec 2018 08:30:23 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id q67sm2200191lfe.19.2018.12.10.08.30.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:30:22 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id v5so8453221lfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:30:22 -0800 (PST)
X-Received: by 2002:a19:1cb:: with SMTP id 194mr7097493lfb.61.1544459422097;
 Mon, 10 Dec 2018 08:30:22 -0800 (PST)
MIME-Version: 1.0
References: <20181206233205.193244-1-evgreen@chromium.org> <20181206233205.193244-3-evgreen@chromium.org>
 <CAFp+6iHj=Z=MQA0WJBLHb9_KyYPz_snxoYNXAgbGndiqEc_=YQ@mail.gmail.com> <55197846-2b93-9b94-d39e-361f67cf9503@ti.com>
In-Reply-To: <55197846-2b93-9b94-d39e-361f67cf9503@ti.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 10 Dec 2018 08:29:44 -0800
X-Gmail-Original-Message-ID: <CAE=gft75ej6bn4Z23b1+=9rjy9HfThkJagN20Jw9wZdhRWbfaw@mail.gmail.com>
Message-ID: <CAE=gft75ej6bn4Z23b1+=9rjy9HfThkJagN20Jw9wZdhRWbfaw@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] phy: qcom-qmp: Utilize fully-specified DT registers
To:     kishon@ti.com
Cc:     vivek.gautam@codeaurora.org, robh@kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        Doug Anderson <dianders@chromium.org>, swboyd@chromium.org,
        cang@codeaurora.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 7:52 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi,
>
> On 07/12/18 2:16 PM, Vivek Gautam wrote:
> > On Fri, Dec 7, 2018 at 5:06 AM Evan Green <evgreen@chromium.org> wrote:
> >>
> >> Utilize the newly fixed up DT bindings to get the tx2 and rx2 register
> >> regions for the second lane of dual-lane PHYs. Before this change,
> >> the driver was simply using lane one's register region and adding
> >> 0x400, which reached well beyond the DT-specified register
> >> allocation. This would have been a crash were it not for the page size
> >> on ARM64. Fix the driver not to rely on the magic of virtual memory by
> >> using the newly specified DT register regions for tx2 and rx2.
> >>
> >> In order to support existing device trees, this change also contains a
> >> fallback mode for when those new register regions don't exist, which
> >> reverts to the original behavior of overreaching and prints a complaint.
> >>
> >> Signed-off-by: Evan Green <evgreen@chromium.org>
> >> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >> ---
> >> As Doug mentioned, this should land before the dts patches land, otherwise
> >> the old driver code will use the tx2 register region as pcs_misc.
> >>
> >> Changes in v6: None
> >> Changes in v5: None
> >> Changes in v4: None
> >> Changes in v3: None
> >> Changes in v2: None
> >>
> >>  drivers/phy/qualcomm/phy-qcom-qmp.c | 51 +++++++++++++++++++++--------
> >>  1 file changed, 38 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> >> index 514db7248a5d0..8204d55e2d650 100644
> >> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> >> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> >> @@ -72,6 +72,9 @@
> >>
> >>  #define MAX_PROP_NAME                          32
> >>
> >> +/* Define the assumed distance between lanes for underspecified device trees. */
> >> +#define QMP_PHY_LEGACY_LANE_STRIDE             0x400
> >> +
> >>  struct qmp_phy_init_tbl {
> >>         unsigned int offset;
> >>         unsigned int val;
> >> @@ -733,9 +736,6 @@ struct qmp_phy_cfg {
> >>         bool has_phy_dp_com_ctrl;
> >>         /* true, if PHY has secondary tx/rx lanes to be configured */
> >>         bool is_dual_lane_phy;
> >> -       /* Register offset of secondary tx/rx lanes for USB DP combo PHY */
> >> -       unsigned int tx_b_lane_offset;
> >> -       unsigned int rx_b_lane_offset;
> >>
> >>         /* true, if PCS block has no separate SW_RESET register */
> >>         bool no_pcs_sw_reset;
> >> @@ -748,6 +748,8 @@ struct qmp_phy_cfg {
> >>   * @tx: iomapped memory space for lane's tx
> >>   * @rx: iomapped memory space for lane's rx
> >>   * @pcs: iomapped memory space for lane's pcs
> >> + * @tx2: iomapped memory space for second lane's tx (in dual lane PHYs)
> >> + * @rx2: iomapped memory space for second lane's rx (in dual lane PHYs)
> >>   * @pcs_misc: iomapped memory space for lane's pcs_misc
> >>   * @pipe_clk: pipe lock
> >>   * @index: lane index
> >> @@ -759,6 +761,8 @@ struct qmp_phy {
> >>         void __iomem *tx;
> >>         void __iomem *rx;
> >>         void __iomem *pcs;
> >> +       void __iomem *tx2;
> >> +       void __iomem *rx2;
> >>         void __iomem *pcs_misc;
> >>         struct clk *pipe_clk;
> >>         unsigned int index;
> >> @@ -975,8 +979,6 @@ static const struct qmp_phy_cfg qmp_v3_usb3phy_cfg = {
> >>
> >>         .has_phy_dp_com_ctrl    = true,
> >>         .is_dual_lane_phy       = true,
> >> -       .tx_b_lane_offset       = 0x400,
> >> -       .rx_b_lane_offset       = 0x400,
> >>  };
> >>
> >>  static const struct qmp_phy_cfg qmp_v3_usb3_uniphy_cfg = {
> >> @@ -1031,9 +1033,6 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
> >>         .mask_pcs_ready         = PCS_READY,
> >>
> >>         .is_dual_lane_phy       = true,
> >> -       .tx_b_lane_offset       = 0x400,
> >> -       .rx_b_lane_offset       = 0x400,
> >> -
> >>         .no_pcs_sw_reset        = true,
> >>  };
> >>
> >> @@ -1238,12 +1237,12 @@ static int qcom_qmp_phy_init(struct phy *phy)
> >>         qcom_qmp_phy_configure(tx, cfg->regs, cfg->tx_tbl, cfg->tx_tbl_num);
> >>         /* Configuration for other LANE for USB-DP combo PHY */
> >>         if (cfg->is_dual_lane_phy)
> >> -               qcom_qmp_phy_configure(tx + cfg->tx_b_lane_offset, cfg->regs,
> >> +               qcom_qmp_phy_configure(qphy->tx2, cfg->regs,
> >>                                        cfg->tx_tbl, cfg->tx_tbl_num);
> >>
> >>         qcom_qmp_phy_configure(rx, cfg->regs, cfg->rx_tbl, cfg->rx_tbl_num);
> >>         if (cfg->is_dual_lane_phy)
> >> -               qcom_qmp_phy_configure(rx + cfg->rx_b_lane_offset, cfg->regs,
> >> +               qcom_qmp_phy_configure(qphy->rx2, cfg->regs,
> >>                                        cfg->rx_tbl, cfg->rx_tbl_num);
> >>
> >>         qcom_qmp_phy_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
> >> @@ -1615,8 +1614,9 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
> >>
> >>         /*
> >>          * Get memory resources for each phy lane:
> >> -        * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2; and
> >> -        * pcs_misc (optional) -> 3.
> >> +        * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
> >> +        * For dual lane PHYs: tx2 -> 3, rx2 -> 4, pcs_misc (optional) -> 5
> >> +        * For single lane PHYs: pcs_misc (optional) -> 3.
> >>          */
> >>         qphy->tx = of_iomap(np, 0);
> >>         if (!qphy->tx)
> >> @@ -1630,7 +1630,32 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
> >>         if (!qphy->pcs)
> >>                 return -ENOMEM;
> >>
> >> -       qphy->pcs_misc = of_iomap(np, 3);
> >> +       /*
> >> +        * If this is a dual-lane PHY, then there should be registers for the
> >> +        * second lane. Some old device trees did not specify this, so fall
> >> +        * back to old legacy behavior of assuming they can be reached at an
> >> +        * offset from the first lane.
> >> +        */
> >> +       if (qmp->cfg->is_dual_lane_phy) {
> >> +               qphy->tx2 = of_iomap(np, 3);
> >> +               qphy->rx2 = of_iomap(np, 4);
> >> +               if (!qphy->tx2 || !qphy->rx2) {
> >> +                       dev_warn(dev,
> >> +                                "Underspecified device tree, falling back to legacy register regions\n");
> >> +
> >> +                       /* In the old version, pcs_misc is at index 3. */
> >> +                       qphy->pcs_misc = qphy->tx2;
> >> +                       qphy->tx2 = qphy->tx + QMP_PHY_LEGACY_LANE_STRIDE;
> >> +                       qphy->rx2 = qphy->rx + QMP_PHY_LEGACY_LANE_STRIDE;
> >> +
> >> +               } else {
> >> +                       qphy->pcs_misc = of_iomap(np, 5);
> >> +               }
> >> +
> >> +       } else {
> >> +               qphy->pcs_misc = of_iomap(np, 3);
> >> +       }
> >> +
> >>         if (!qphy->pcs_misc)
> >>                 dev_vdbg(dev, "PHY pcs_misc-reg not used\n");
> >>
> >> --
> >> 2.18.1
> >>
> >
> > Tested on db820c [1]. USB, PCIe come up.
> > Tested-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> >
> > [1] https://github.com/vivekgautam1/linux/tree/origin/v4.20-rc5/db820c
>
> Thank you Vivek.
> Evan, can you resend this series after rebasing to phy -next and also your
> other series?

Sure. The other series you're referring to is the #clock-cells one
here [1] I assume? I will resend both on top of phy-next.

-Evan

[1] https://lkml.org/lkml/2018/11/30/214
