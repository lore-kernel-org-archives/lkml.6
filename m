Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8484C07520
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661AB21B69
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DMPGJSJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbeLYEWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 23:22:53 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43186 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbeLYEWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 23:22:53 -0500
Received: by mail-qk1-f195.google.com with SMTP id r71so7759448qkr.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 20:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XyxR0p07RGp1qlnLQ+PYw01EN8P7tHAtKVYSKm8bAL4=;
        b=DMPGJSJtRdiZv99OCfBQos18OkHHDteY+guhhAdn1ZMq4HDXHgQ206cLCrMt3qf8nw
         8vfqD1vINezlalGqZWrBIQT7CXRAd+abfmlvESEKCCKOFQ/snvPpVXImYsAmln0e9aD2
         bHQW4i+yYIQQzYdR/WbmsSKxCPEaAFYdqN2l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyxR0p07RGp1qlnLQ+PYw01EN8P7tHAtKVYSKm8bAL4=;
        b=bx8oWiP04NODtlTS7Gri/tmfKWc2J31e2BSEsISJQPLcH40IPVrXjY+aIv1ruUe4Xn
         iZdti8BuZmE5+pcnx+8DajcCVw4lNVHVOtM9krwKG2VQJLm5W3/XjweX+j0SzCzhFTX6
         EMd7woXpr2WHuf5XV8yfSxgTu+2J5+aCzU1Pjy4m1nJQFwwbkaikzdivUAQiUrVcRLsQ
         FWRFeXpxrEVu5PUErKxSYZe9heQdHcYkOwakoOqwOdBv7DTMWaGO0VW2vpMvP0aFEznu
         heOUpcURPA2jXfkkp6YQkHh5k5Wi+wsW/H14uhqXsVSF99fl0RkibI/cm3TuCl5iOjAU
         jWHA==
X-Gm-Message-State: AJcUukeYabyAVvGVm8gOityN7tD9s6q96YeSnKkHc4ks7ch7Hir3MSIs
        VRNNrqHrdgCEyQY1Pr/7gVyAwVy8HV8iRXzHyU+VNwL+X3s/Ig==
X-Google-Smtp-Source: ALg8bN54nsGswSAzKhafoH8Zx/smpqhn+S5WbjR+AQZ8TyP/RYFXzsSuWTKn5IwKWvibC7uZMM/pf9JJ+QpWCq7TtnM=
X-Received: by 2002:a37:5107:: with SMTP id f7mr14268124qkb.124.1545711771863;
 Mon, 24 Dec 2018 20:22:51 -0800 (PST)
MIME-Version: 1.0
References: <1545638931-24938-1-git-send-email-yongqiang.niu@mediatek.com> <1545638931-24938-18-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1545638931-24938-18-git-send-email-yongqiang.niu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 25 Dec 2018 12:22:41 +0800
Message-ID: <CANMq1KBtkd8yMHppMDV1OYocB70L-UxrF0cnYiWMjQLA9NWbvQ@mail.gmail.com>
Subject: Re: [PATCH 17/18] drm/mediatek: add ovl0/ovl0_2l usecase
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
> This patch add ovl0/ovl0_2l usecase
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 38 ++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index a5af4be..25cf063 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -283,6 +283,15 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
>
>         for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
>                 struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[i];
> +               enum mtk_ddp_comp_id prev = DDP_COMPONENT_ID_MAX;
> +
> +               if (i > 0) {
> +                       struct mtk_ddp_comp *comp_prev;
> +
> +                       comp_prev = mtk_crtc->ddp_comp[i - 1];
> +                       prev = comp_prev->id;

Just

if (i > 0)
  prev = mtk_crtc->ddp_comp[i - 1]->id;
else
  prev = DDP_COMPONENT_ID_MAX;

> +               }
> +               mtk_ddp_comp_connect(comp, prev);
>
>                 mtk_ddp_comp_config(comp, width, height, vrefresh, bpc);
>                 mtk_ddp_comp_start(comp);
> @@ -292,10 +301,19 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
>         for (i = 0; i < mtk_crtc->layer_nr; i++) {
>                 struct drm_plane *plane = &mtk_crtc->planes[i];
>                 struct mtk_plane_state *plane_state;
> +               struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
> +               unsigned int comp_layer_nr = mtk_ddp_comp_layer_nr(comp);
> +               unsigned int local_layer = 0;

No need to init to 0.

>
>                 plane_state = to_mtk_plane_state(plane->state);
> -               mtk_ddp_comp_layer_config(mtk_crtc->ddp_comp[0], i,
> -                                         plane_state);
> +
> +               if (i >= comp_layer_nr) {
> +                       comp = mtk_crtc->ddp_comp[1];
> +                       local_layer = i - comp_layer_nr;
> +               } else {
> +                       local_layer = i;
> +               }
> +               mtk_ddp_comp_layer_config(comp, local_layer, plane_state);
>         }
>
>         return 0;
> @@ -340,6 +358,8 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
>         struct mtk_crtc_state *state = to_mtk_crtc_state(mtk_crtc->base.state);
>         struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
>         unsigned int i;
> +       unsigned int comp_layer_nr = mtk_ddp_comp_layer_nr(comp);
> +       unsigned int local_layer = 0;

ditto, don't init to 0.

>
>         /*
>          * TODO: instead of updating the registers here, we should prepare
> @@ -362,7 +382,15 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
>                         plane_state = to_mtk_plane_state(plane->state);
>
>                         if (plane_state->pending.config) {
> -                               mtk_ddp_comp_layer_config(comp, i, plane_state);
> +                               if (i >= comp_layer_nr) {
> +                                       comp = mtk_crtc->ddp_comp[1];
> +                                       local_layer = i - comp_layer_nr;
> +                               } else {
> +                                       local_layer = i;
> +                               }
> +
> +                               mtk_ddp_comp_layer_config(comp, local_layer,
> +                                                         plane_state);
>                                 plane_state->pending.config = false;
>                         }
>                 }
> @@ -604,6 +632,10 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>         }
>
>         mtk_crtc->layer_nr = mtk_ddp_comp_layer_nr(mtk_crtc->ddp_comp[0]);
> +       if (mtk_crtc->ddp_comp_nr > 1 &&
> +           mtk_ddp_comp_get_type(mtk_crtc->ddp_comp[1]->id) == MTK_DISP_OVL)
> +               mtk_crtc->layer_nr +=
> +               mtk_ddp_comp_layer_nr(mtk_crtc->ddp_comp[1]);
>         mtk_crtc->planes = devm_kcalloc(dev, mtk_crtc->layer_nr,
>                                         sizeof(struct drm_plane),
>                                         GFP_KERNEL);
> --
> 1.8.1.1.dirty
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
