Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048A8ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD2120C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD2120C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbeGQKnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:43:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39405 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbeGQKnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:43:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so654079wre.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 03:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=23N4D7vmnZK1vbbiHXgv8gEZE4xCuBcCOgQvDkMc77o=;
        b=IVSgKyJx8lpss9KF3G4Vr9GHAk2khAbpQ5o+1INgApCa/WcfruwnA16tpjjFulG4Io
         H8hC0Zu24VnBPA1Sc88/r44qxynl8stz+er6rCESwwg5jMEsBr3WRoV9TQTtnDNIznS0
         ShVBZV5/p2YGrQIRrLtD8uL0vmPbJtonld51Cq0siVuWM9ZgEH8dZ/PrjvTCy5lRN08b
         7SA16BR/Gww59qk6IS4hcQlbVubTZAac9fKHosQts76sZx5ry3tfirWZ+Z14HY8vvNuG
         TPZHXbdgD+4OZf6YlW7v0nSed+dVoq9yaiRJkkWTONQ40zIqEqIcMXhjjPo4HsxFwCKY
         kL1A==
X-Gm-Message-State: AOUpUlHi1Muy8Y50URgaVppHmSjTW1ORsaWZl/tjdW+0BG7l62tON/vQ
        KLnIc9sZujRx6u0qGpRKt1pWkLaDlL9b8z1LZNdv0g==
X-Google-Smtp-Source: AAOMgpc1PX2xxMAxXtyofhiTKJbM10PuVtkFT7fb+f78v15P+FSNwT7poLD1hwoQRGIrmMGVJZTPCcf0AHE1GjZaXwc=
X-Received: by 2002:a5d:50cd:: with SMTP id f13-v6mr907315wrt.73.1531822284631;
 Tue, 17 Jul 2018 03:11:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:28c2:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 03:11:24
 -0700 (PDT)
In-Reply-To: <20180716235936.11268-4-lyude@redhat.com>
References: <20180716235936.11268-1-lyude@redhat.com> <20180716235936.11268-4-lyude@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 17 Jul 2018 12:11:24 +0200
Message-ID: <CACO55ts0OiOQqzu617kL2XfcMxJ2PnjTvmkb2K_bFFFznh9O5Q@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 3/5] drm/nouveau: Add missing RPM get/put() when
 probing connectors
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <karolherbst@gmail.com>

On Tue, Jul 17, 2018 at 1:59 AM, Lyude Paul <lyude@redhat.com> wrote:
> While the GPU is guaranteed to be on when a hotplug has been received,
> the same assertion does not hold true if a connector probe has been
> started by userspace without having had received a sysfs event. So
> ensure that any connector probing keeps the GPU alive for the duration
> of the probe.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Karol Herbst <karolherbst@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c     |  2 +-
>  drivers/gpu/drm/nouveau/nouveau_connector.c | 21 +++++++++++++++++++--
>  drivers/gpu/drm/nouveau/nouveau_connector.h |  3 +++
>  3 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index ea2a886854fe..0f283ca75189 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -858,7 +858,7 @@ static const struct drm_connector_funcs
>  nv50_mstc = {
>         .reset = nouveau_conn_reset,
>         .detect = nv50_mstc_detect,
> -       .fill_modes = drm_helper_probe_single_connector_modes,
> +       .fill_modes = nouveau_connector_probe_single_connector_modes,
>         .destroy = nv50_mstc_destroy,
>         .atomic_duplicate_state = nouveau_conn_atomic_duplicate_state,
>         .atomic_destroy_state = nouveau_conn_atomic_destroy_state,
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index 2a45b4c2ceb0..feb142fb7a8a 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -770,6 +770,23 @@ nouveau_connector_force(struct drm_connector *connector)
>         nouveau_connector_set_encoder(connector, nv_encoder);
>  }
>
> +int
> +nouveau_connector_probe_single_connector_modes(struct drm_connector *connector,
> +                                              uint32_t maxX, uint32_t maxY)
> +{
> +       struct device *dev = connector->dev->dev;
> +       int ret;
> +
> +       ret = pm_runtime_get_sync(dev);
> +       if (WARN_ON(ret < 0 && ret != -EACCES))
> +               return 0;
> +
> +       ret = drm_helper_probe_single_connector_modes(connector, maxX, maxY);
> +
> +       pm_runtime_put_autosuspend(dev);
> +       return ret;
> +}
> +
>  static int
>  nouveau_connector_set_property(struct drm_connector *connector,
>                                struct drm_property *property, uint64_t value)
> @@ -1088,7 +1105,7 @@ nouveau_connector_funcs = {
>         .reset = nouveau_conn_reset,
>         .detect = nouveau_connector_detect,
>         .force = nouveau_connector_force,
> -       .fill_modes = drm_helper_probe_single_connector_modes,
> +       .fill_modes = nouveau_connector_probe_single_connector_modes,
>         .set_property = nouveau_connector_set_property,
>         .destroy = nouveau_connector_destroy,
>         .atomic_duplicate_state = nouveau_conn_atomic_duplicate_state,
> @@ -1103,7 +1120,7 @@ nouveau_connector_funcs_lvds = {
>         .reset = nouveau_conn_reset,
>         .detect = nouveau_connector_detect_lvds,
>         .force = nouveau_connector_force,
> -       .fill_modes = drm_helper_probe_single_connector_modes,
> +       .fill_modes = nouveau_connector_probe_single_connector_modes,
>         .set_property = nouveau_connector_set_property,
>         .destroy = nouveau_connector_destroy,
>         .atomic_duplicate_state = nouveau_conn_atomic_duplicate_state,
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/drm/nouveau/nouveau_connector.h
> index 2d9d35a146a4..e9ffc6eebda2 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
> @@ -106,6 +106,9 @@ nouveau_crtc_connector_get(struct nouveau_crtc *nv_crtc)
>
>  struct drm_connector *
>  nouveau_connector_create(struct drm_device *, const struct dcb_output *);
> +int
> +nouveau_connector_probe_single_connector_modes(struct drm_connector *,
> +                                              uint32_t, uint32_t);
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
