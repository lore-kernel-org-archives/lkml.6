Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C811CC07520
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 03:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747D120882
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 03:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HLPkITwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbeLYD5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 22:57:13 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37559 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeLYD5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 22:57:12 -0500
Received: by mail-qt1-f194.google.com with SMTP id t33so14335331qtt.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 19:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s5geiLs7kDycDhYNSL4q6vv2w/JxPB7NmvJkyHK8CYI=;
        b=HLPkITwjGl65iN8oUZFeOk3xzKurwM1QYWPHXLL+nDaL/SJ5hYTsGF3zJvv+ie6iOp
         hFylEVic3usbaWQ1r+5l53cioUWAXF6ql/rWeXdjX7PQ59MZ/vuEf8Yvnqab6gDdjOyO
         MJIa7MGBdrhfrPo4mAOxTijLmzElfVtK++NiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5geiLs7kDycDhYNSL4q6vv2w/JxPB7NmvJkyHK8CYI=;
        b=DaYMwcEQ+SRAv36Vvmfd7P+hGien+ePfSJqgGY2MsFaxlDtJa58+VCIPmwHYTm+faF
         UNEFPqM2E3/lazdWjWDgFIpYJcdn2U830NToFJgOv3WK8L1+4MyHzw3KIrQpuGnL0JbT
         lwABa/qK0up5KZnKMPQbkE5fEYFrwqWP3VavwIM5aAZC60JmYOmDp/CM42+sGCXHNS0Y
         slYSviQ6ME6fOkseY/BI9c0/77eccfu1e7kCRBbfWA6HQoPs9+KyDIfMntKz+rCUyxEs
         PzDCZoOMkahi0V9CQqN7535c1NZVq2Q4TMHwKBSDZtkbjr7K4fAwGstOWhX+t0XcfO4M
         lLAQ==
X-Gm-Message-State: AJcUukcbEm4cOpZxotV7YPMXIxloSEwJy5jIubEPDLpDrdpY/C6trx5K
        S4hmJvunp1HFpcEpa3BL3+5eSvntrjmqqPbKXX6KlA==
X-Google-Smtp-Source: ALg8bN6xgg47waxonnNSsErsFKqVr/MYeuvZGLAnjipVbD1FgXDfc5ueGpw0WOyMZbfxMhx//31nZiKbw9UC4+Mbwos=
X-Received: by 2002:a0c:d0d7:: with SMTP id b23mr14050872qvh.67.1545710231259;
 Mon, 24 Dec 2018 19:57:11 -0800 (PST)
MIME-Version: 1.0
References: <1545638931-24938-1-git-send-email-yongqiang.niu@mediatek.com> <1545638931-24938-4-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1545638931-24938-4-git-send-email-yongqiang.niu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 25 Dec 2018 11:57:00 +0800
Message-ID: <CANMq1KBTN61hmWy2K+rrx3NL0eR7AXhFQBkCpcHu5nhUw_6xjw@mail.gmail.com>
Subject: Re: [PATCH 03/18] drm/mediatek: redefine mtk_ddp_sout_sel
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 6:52 PM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> This patch redefine mtk_ddp_sout_sel

Can you describe a bit more why you are making this change?

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index adb37e4..592f852 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -405,21 +405,27 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
>         return value;
>  }
>
> -static void mtk_ddp_sout_sel(void __iomem *config_regs,
> -                            enum mtk_ddp_comp_id cur,
> -                            enum mtk_ddp_comp_id next)
> +static unsigned int mtk_ddp_sout_sel(void __iomem *config_regs,

You don't use config_regs anymore, drop it.

> +                                    enum mtk_ddp_comp_id cur,
> +                                    enum mtk_ddp_comp_id next,
> +                                    unsigned int *addr)
>  {
> +       unsigned int value;
> +
>         if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
> -               writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
> -                              config_regs + DISP_REG_CONFIG_OUT_SEL);
> +               *addr = DISP_REG_CONFIG_OUT_SEL;
> +               value = BLS_TO_DSI_RDMA1_TO_DPI1;

You can directly return BLS_TO_DSI_RDMA1_TO_DPI1.

>         } else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DPI0) {
> -               writel_relaxed(BLS_TO_DPI_RDMA1_TO_DSI,
> -                              config_regs + DISP_REG_CONFIG_OUT_SEL);
> -               writel_relaxed(DSI_SEL_IN_RDMA,
> -                              config_regs + DISP_REG_CONFIG_DSI_SEL);
> -               writel_relaxed(DPI_SEL_IN_BLS,
> -                              config_regs + DISP_REG_CONFIG_DPI_SEL);
> +               *addr = DISP_REG_CONFIG_OUT_SEL;
> +               value = BLS_TO_DPI_RDMA1_TO_DSI;

I (kind of) understand the change above, as you still end up writing
BLS_TO_DSI_RDMA1_TO_DPI1 in DISP_REG_CONFIG_OUT_SEL.

This changes the behaviour, as now you only write
BLS_TO_DPI_RDMA1_TO_DSI to DISP_REG_CONFIG_OUT_SEL, but the previous
revision of the code would also write to DISP_REG_CONFIG_DSI_SEL and
DISP_REG_CONFIG_DPI_SEL. Why?

> +       } else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI0) {
> +               *addr = DISP_REG_CONFIG_DSI_SEL;
> +               value = DSI_SEL_IN_RDMA;
> +       } else {
> +               value = 0;
>         }
> +
> +       return value;
>  }
>
>  void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
> @@ -434,7 +440,9 @@ void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
>                 writel_relaxed(reg, config_regs + addr);
>         }
>
> -       mtk_ddp_sout_sel(config_regs, cur, next);
> +       value = mtk_ddp_sout_sel(cur, next, &addr);
> +       if (value)
> +               writel_relaxed(value, config_regs + addr);

Why this change? I don't see mtk_ddp_sout_sel being used later in the
series, so I'm not sure why we don't directly write the value into the
register.



>         value = mtk_ddp_sel_in(cur, next, &addr);
>         if (value) {
> --
> 1.8.1.1.dirty
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
