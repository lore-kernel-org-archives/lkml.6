Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8564C07520
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB59A21B69
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bp+/YmZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbeLYETq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 23:19:46 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46248 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbeLYETq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 23:19:46 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so14331996qtm.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 20:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hRltAEGdhdJSlbSLKF4x4jRfCNGMuHVTLWedpYRw1p8=;
        b=Bp+/YmZH2iQSQxajUYpcSgggriNdHEphMLv4FmM8sl+tDILAa49yg6uxlTVHTTqb2V
         q12YvoNFl/3/LjlCswoN8h6JJ1vJZt3mUffCtcn1vhMwOiRFuhxL6q97N2FuiVwQvis4
         R2xecFTAcGfwO1JiCfmO+CivlGDarR2DH9uIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRltAEGdhdJSlbSLKF4x4jRfCNGMuHVTLWedpYRw1p8=;
        b=gSL0piQxr0Fz+wYs9OVr644XG0fNwB+pOtjNV6CnvW4IE+HkkwLNZQO0Ujl+1BABi5
         Bm9jzlYr5BK7nNYOBcSF45Q4Jo0fxxGEbGt0LLk/icpR5Klknq2snJCwrLjpsD/RD5uP
         jmLylMU5Rj2cBSfk6yohiEMV51CT1s/akSAjMyGNTtCdLRoTABePIPJkdiwApUTGjRV2
         NSr2w6t81R3jng5Xnad8zatUYXvSMjYPumnEFx6CvMvjkOypL2GvastQNTRU9hTww1XM
         jr7yDAdCY/8Vmf1lkTfYHVbIQ41190vXy+3Pkazf9Q3cdEJhF6BsvKnXGRHwouzM/O5U
         zbpA==
X-Gm-Message-State: AA+aEWYIcT7DLVH0LbH6mW79qYSN0NiI1yylow9d1ZCfJxKCHQfVOFE2
        XRPPvZkARb1Md8ZrfLt3LvIn2zdTuzS4tI2RpGtLxA==
X-Google-Smtp-Source: AFSGD/WiWuKdqXnBY1d4PChmVEr/pLLqCS21n1XNZB6O7T15NrPJ7Tn+xv5ZUZLSR01Y4IPTEmTUVvoVRsFdMrqpUfs=
X-Received: by 2002:aed:3442:: with SMTP id w60mr14405639qtd.339.1545711585226;
 Mon, 24 Dec 2018 20:19:45 -0800 (PST)
MIME-Version: 1.0
References: <1545638931-24938-1-git-send-email-yongqiang.niu@mediatek.com> <1545638931-24938-17-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1545638931-24938-17-git-send-email-yongqiang.niu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 25 Dec 2018 12:19:34 +0800
Message-ID: <CANMq1KAerBM7Z+hNkfQj1R=Fou_Vcnsu5AStBuZeaH4vC6i2ag@mail.gmail.com>
Subject: Re: [PATCH 16/18] drm/mediatek: add function mtk_ddp_comp_get_type
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

On Mon, Dec 24, 2018 at 6:53 PM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> This patch add function mtk_ddp_comp_get_type
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 10 ++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  1 +
>  2 files changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 1c0f9cc..71b565c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -350,6 +350,16 @@ int mtk_ddp_comp_get_id(struct device_node *node,
>         return -EINVAL;
>  }
>
> +enum mtk_ddp_comp_type mtk_ddp_comp_get_type(enum mtk_ddp_comp_id comp_id)
> +{
> +       enum mtk_ddp_comp_type comp_type = MTK_DDP_COMP_TYPE_MAX;
> +
> +       if (comp_id < DDP_COMPONENT_ID_MAX)
> +               comp_type = mtk_ddp_matches[comp_id].type;

return mtk_ddp_matches[comp_id].type

> +
> +       return comp_type;

return MTK_DDP_COMP_TYPE_MAX

> +}
> +
>  int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
>                       struct mtk_ddp_comp *comp, enum mtk_ddp_comp_id comp_id,
>                       const struct mtk_ddp_comp_funcs *funcs)
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index b908172..599e293 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -198,5 +198,6 @@ void mtk_ddp_write_mask(unsigned int value,
>                         struct mtk_ddp_comp *comp,
>                         unsigned int offset,
>                         unsigned int mask);
> +enum mtk_ddp_comp_type mtk_ddp_comp_get_type(enum mtk_ddp_comp_id comp_id);
>
>  #endif /* MTK_DRM_DDP_COMP_H */
> --
> 1.8.1.1.dirty
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
