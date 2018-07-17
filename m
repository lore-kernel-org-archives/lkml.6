Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80C9ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C53E20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C53E20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbeGQK7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:59:48 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:51538 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729718AbeGQK7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:59:47 -0400
Received: by mail-wm0-f44.google.com with SMTP id s12-v6so954401wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 03:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hX/4nWBLOv9cV571YboMDyHFje1lzsIY0N+Y+aoUQmw=;
        b=lFtwP/kf+g30De5Gk13svgkQCtK6qCYh+vajVRZt9IK+07GbVCRdGXIwyF8rPeAfBW
         se92uBf/4H0aJNBf8xUmaQtXy9V6gy8LDduAdPqHGG5EZbzNKFn3LrW8N7SXEaqlcOkM
         aedoaesgvw1iOwWwQHG9e6k7B+0hZCfKTgraGuehBZDPXWKMtazvF1lcqJpR1XGaGvYs
         un+neAH3tSfDwZ1RLTaExa0DR8HyWM2r3aQm0AHXftkdH64LRoxWIsBPo2tEhguGN5IY
         HozW9feY3zx1WdQo/SYjpTu1cGXQP8WGuEVtvqdtRPk0OEpZeBqLDPF145tuq3eNyYxa
         5Blg==
X-Gm-Message-State: AOUpUlELGC1aZkTnd4zWq/h6sUHwEEpL/ETO//yYGa3ROMNzDoH/3YVr
        T8Nvg/Mz2LeC6lDDZCOF6dSkoQ1+J8NnlbFwjcun3g==
X-Google-Smtp-Source: AAOMgpfdnAyjKUrh/CrVc/QUnIPSedyhkuCJa8/iauUymmJ44AUFWxkz/t9rofGbcZ89bhVjWsQJhjA0/IspEBF4TBw=
X-Received: by 2002:a1c:7408:: with SMTP id p8-v6mr931534wmc.118.1531823270322;
 Tue, 17 Jul 2018 03:27:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:28c2:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 03:27:49
 -0700 (PDT)
In-Reply-To: <20180712171356.10227-1-lyude@redhat.com>
References: <20180712171356.10227-1-lyude@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 17 Jul 2018 12:27:49 +0200
Message-ID: <CACO55tv2xQwpvL_KtXXj+UNAHnvuPSwhHZ5ny+LuWN892YR8Kw@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau: Don't forget to label dp_aux devices
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        Archit Taneja <architt@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <karolherbst@gmail.com>

2018-07-12 19:13 GMT+02:00 Lyude Paul <lyude@redhat.com>:
> This makes debugging with DP tracing a lot harder to interpret, so name
> each i2c based off the name of the encoder that it's for
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv04/disp.c     |  2 +-
>  drivers/gpu/drm/nouveau/dispnv50/disp.c     |  2 +-
>  drivers/gpu/drm/nouveau/nouveau_connector.c | 12 ++++++++++--
>  drivers/gpu/drm/nouveau/nouveau_connector.h |  3 ++-
>  4 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/disp.c b/drivers/gpu/drm/nouveau/dispnv04/disp.c
> index 501d2d290e9c..45ff1872d894 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/disp.c
> @@ -64,7 +64,7 @@ nv04_display_create(struct drm_device *dev)
>         for (i = 0; i < dcb->entries; i++) {
>                 struct dcb_output *dcbent = &dcb->entry[i];
>
> -               connector = nouveau_connector_create(dev, dcbent->connector);
> +               connector = nouveau_connector_create(dev, dcbent);
>                 if (IS_ERR(connector))
>                         continue;
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index 9382e99a0bc7..4f8d51590bbb 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -2198,7 +2198,7 @@ nv50_display_create(struct drm_device *dev)
>
>         /* create encoder/connector objects based on VBIOS DCB table */
>         for (i = 0, dcbe = &dcb->entry[0]; i < dcb->entries; i++, dcbe++) {
> -               connector = nouveau_connector_create(dev, dcbe->connector);
> +               connector = nouveau_connector_create(dev, dcbe);
>                 if (IS_ERR(connector))
>                         continue;
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index 7b557c354307..0c5cc600c973 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -408,8 +408,10 @@ nouveau_connector_destroy(struct drm_connector *connector)
>         kfree(nv_connector->edid);
>         drm_connector_unregister(connector);
>         drm_connector_cleanup(connector);
> -       if (nv_connector->aux.transfer)
> +       if (nv_connector->aux.transfer) {
>                 drm_dp_aux_unregister(&nv_connector->aux);
> +               kfree(nv_connector->aux.name);
> +       }
>         kfree(connector);
>  }
>
> @@ -1201,13 +1203,16 @@ drm_conntype_from_dcb(enum dcb_connector_type dcb)
>  }
>
>  struct drm_connector *
> -nouveau_connector_create(struct drm_device *dev, int index)
> +nouveau_connector_create(struct drm_device *dev,
> +                        const struct dcb_output *dcbe)
>  {
>         const struct drm_connector_funcs *funcs = &nouveau_connector_funcs;
>         struct nouveau_drm *drm = nouveau_drm(dev);
>         struct nouveau_display *disp = nouveau_display(dev);
>         struct nouveau_connector *nv_connector = NULL;
>         struct drm_connector *connector;
> +       char aux_name[48] = {0};
> +       int index = dcbe->connector;
>         int type, ret = 0;
>         bool dummy;
>
> @@ -1306,6 +1311,9 @@ nouveau_connector_create(struct drm_device *dev, int index)
>         case DRM_MODE_CONNECTOR_eDP:
>                 nv_connector->aux.dev = dev->dev;
>                 nv_connector->aux.transfer = nouveau_connector_aux_xfer;
> +               snprintf(aux_name, sizeof(aux_name), "sor-%04x-%04x",
> +                        dcbe->hasht, dcbe->hashm);
> +               nv_connector->aux.name = kstrdup(aux_name, GFP_KERNEL);
>                 ret = drm_dp_aux_register(&nv_connector->aux);
>                 if (ret) {
>                         NV_ERROR(drm, "failed to register aux channel\n");
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/drm/nouveau/nouveau_connector.h
> index a4d1a059bd3d..2c5cb51c7c33 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
> @@ -35,6 +35,7 @@
>  #include "nouveau_crtc.h"
>
>  struct nvkm_i2c_port;
> +struct dcb_output;
>
>  struct nouveau_connector {
>         struct drm_connector base;
> @@ -76,7 +77,7 @@ nouveau_crtc_connector_get(struct nouveau_crtc *nv_crtc)
>  }
>
>  struct drm_connector *
> -nouveau_connector_create(struct drm_device *, int index);
> +nouveau_connector_create(struct drm_device *, const struct dcb_output *);
>
>  extern int nouveau_tv_disable;
>  extern int nouveau_ignorelid;
> --
> 2.17.1
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
