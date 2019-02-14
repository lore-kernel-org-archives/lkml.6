Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA49C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 05:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8804D222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 05:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JXMwGF6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405579AbfBNFy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 00:54:57 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36146 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732648AbfBNFy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 00:54:57 -0500
Received: by mail-qk1-f196.google.com with SMTP id o125so2940225qkf.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 21:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ZZPTehRx0gCVAGAwGZLdRCyaQhXE0OghMtcZbWUN1k=;
        b=JXMwGF6sgy9y+WcZoNA2AWmObRpexqFbDrMQ/02+r6JQUTug17v90SxKPvh43Sr7wa
         0hHMJEDUNY2SA1ROLXAkc9lPs+Ei3Oqs5uXsXotW9nFwFYglLShE17cEyYFVz77CYfYv
         c71lTWzB4N8yWi0R+J9rta160kzE4DyOq1Zpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ZZPTehRx0gCVAGAwGZLdRCyaQhXE0OghMtcZbWUN1k=;
        b=NkzjvsImKMBOy61tvsB7wCCeuv9cI22xzsYX9PkuNmv1bvMEuQLFg2AlyQRCGh6yOF
         AbSyh9ivWNnwAeSpLao7C94fU0JjpEIw1DVtbq3ygObkcTmaGjaO1l2bcwTVllazUxsN
         LsXqfw4VyBWgZh/ApQnjgqTODtKLDFGE5yyusI1Xt9vLWVoniLujHOvb1CstW9Gt8k3R
         0WIRYQLmcH8wckz5yslVdC5TqcaO0rwTGOC4vmz3GR/5YA9UwwTgZgM7BsO67gcQSiGM
         Qz5gZJ/TmbntwCaeqEL8s/sdfUlO1J3FtUFcjh3z4NiEE/ei7DgJk9Zkmx8T8IQuZ8oJ
         Slgw==
X-Gm-Message-State: AHQUAuYdanTEOMJzS45lmfxdaUvQo4ey2U2xTVXNB41hSlJRZuMhCXzc
        aqZOCDxWrxIWanRXOJVilWOEguPqMr9wk2DqBYrDXg==
X-Google-Smtp-Source: AHgI3IamlS+2WnAogCdsL8ldHcyBN+PQiVASgbQh23/ApFCz870ErGq5WVsz2xgBC5rjuMBV8/5v3d6CFP3v4QEbJq4=
X-Received: by 2002:a37:7885:: with SMTP id t127mr1465362qkc.323.1550123695704;
 Wed, 13 Feb 2019 21:54:55 -0800 (PST)
MIME-Version: 1.0
References: <20190214044243.129920-1-jitao.shi@mediatek.com> <20190214044243.129920-3-jitao.shi@mediatek.com>
In-Reply-To: <20190214044243.129920-3-jitao.shi@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 14 Feb 2019 13:54:44 +0800
Message-ID: <CANMq1KBR-CpjAtj6qTEjK8PA2DUW3w_-OP_EyE7uoaojGLoGLg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/mediatek: add mt8183 dsi driver support
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, srv_heupstream@mediatek.com,
        Sascha Hauer <kernel@pengutronix.de>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        cawa cheng <cawa.cheng@mediatek.com>,
        =?UTF-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= 
        <bibby.hsieh@mediatek.com>, CK HU <ck.hu@mediatek.com>,
        stonea168@163.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:43 PM Jitao Shi <jitao.shi@mediatek.com> wrote:
>
> MT8183 dsi has two changes with mt8173.
> 1. Add the register double buffer control, but we no need it, So make
>    it default off.

Can you describe a little bit more what this is about? That's shadow
registers, right?

> 2. Add picture size control.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 80db02a25cb0..20cb53f05d42 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -78,6 +78,7 @@
>  #define DSI_VBP_NL             0x24
>  #define DSI_VFP_NL             0x28
>  #define DSI_VACT_NL            0x2C
> +#define DSI_SIZE_CON           0x38
>  #define DSI_HSA_WC             0x50
>  #define DSI_HBP_WC             0x54
>  #define DSI_HFP_WC             0x58
> @@ -131,7 +132,10 @@
>  #define VM_CMD_EN                      BIT(0)
>  #define TS_VFP_EN                      BIT(5)
>
> -#define DSI_CMDQ0              0x180

As I said earlier, move this to 2/3.

> +#define DSI_SHADOW_DEBUG       0x190U
> +#define FORCE_COMMIT           BIT(0)
> +#define BYPASS_SHADOW          BIT(1)
> +
>  #define CONFIG                         (0xff << 0)
>  #define SHORT_PACKET                   0
>  #define LONG_PACKET                    2
> @@ -158,6 +162,7 @@ struct phy;
>
>  struct mtk_dsi_driver_data {
>         const u32 reg_cmdq_off;
> +       bool has_size_ctl;
>  };
>
>  struct mtk_dsi {
> @@ -426,6 +431,9 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
>         writel(vm->vfront_porch, dsi->regs + DSI_VFP_NL);
>         writel(vm->vactive, dsi->regs + DSI_VACT_NL);
>
> +       if (dsi->driver_data->has_size_ctl)
> +               writel(vm->vactive << 16 | vm->hactive, dsi->regs + DSI_SIZE_CON);
> +
>         horizontal_sync_active_byte = (vm->hsync_len * dsi_tmp_buf_bpp - 10);
>
>         if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
> @@ -595,6 +603,9 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>         }
>
>         mtk_dsi_enable(dsi);
> +
> +       /* DSI no need this double buffer, disable it when writing register */

"DSI does not need double buffering, disable it when writing register"

> +       writel(FORCE_COMMIT | BYPASS_SHADOW, dsi->regs + DSI_SHADOW_DEBUG);

So you do this on all MT* variants, is that ok?

>         mtk_dsi_reset_engine(dsi);
>         mtk_dsi_phy_timconfig(dsi);
>
> @@ -1090,11 +1101,18 @@ static const struct mtk_dsi_driver_data mt2701_dsi_driver_data = {
>         .reg_cmdq_off = 0x180,
>  };
>
> +static const struct mtk_dsi_driver_data mt8183_dsi_driver_data = {
> +       .reg_cmdq_off = 0x200,
> +       .has_size_ctl = true,
> +};
> +
>  static const struct of_device_id mtk_dsi_of_match[] = {
>         { .compatible = "mediatek,mt2701-dsi",
>           .data = &mt2701_dsi_driver_data },
>         { .compatible = "mediatek,mt8173-dsi",
>           .data = &mt8173_dsi_driver_data },
> +       { .compatible = "mediatek,mt8183-dsi",
> +         .data = &mt8183_dsi_driver_data },
>         { },
>  };
>
> --
> 2.20.1
>
