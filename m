Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7817C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5EA208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZG7+t/wd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfANKAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:00:01 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44929 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfANKAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:00:01 -0500
Received: by mail-ot1-f67.google.com with SMTP id f18so18745428otl.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bQ4f4RF5WaMyiQq3rejEy56AlO8ypDXawmp6AtCxU5k=;
        b=ZG7+t/wd/YljZEA6740MB4EMQCO8L4jBW+VuFbaOTAixEcPhT2WcQkynU3KPOFVL4a
         NpYHRKQ5930YN4h9JIIqw4vGsVxpoF5iGdb1GGxBUY3sNnoHtKBbMsBPYVGCTuK4Pr/f
         geKJ2syOAuZV/JgCi5Y+AvndHuSgF+FXU7nr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bQ4f4RF5WaMyiQq3rejEy56AlO8ypDXawmp6AtCxU5k=;
        b=SMgomh23D5l1R8Gf6bn9hMthDUE0uReo+xrZyUY9tDdIE13DyB3YK0/kzli+hJY2O2
         r71ornAPdg0fG3bWZCxholq5ircQANg3JdPRO7C3bve5MKuniD8ab0mpkPOpxNPr71EF
         /eP+ZSI8UBU+MUg0d/Ghyeog7zt+BjSfPOASre60CH2gBp1srcK7j3ghkan9FcIkT8XR
         xaOYgNKHVSISOjEWkccmbf4q65T/z43tJeR1WLi0BSur0a5YvdOxyj6u/xZnXKjOOSt3
         IqRsOUwvYo0T81X/TEArLRoQvV6oEzsXaiS/fw3KeVv0liVPIzB3GbqiyPbK+z0cHz2m
         OICg==
X-Gm-Message-State: AJcUukcmepHIHduakZREgYfPAKJHNqY9VBRdvP+7u+TwzjQiYDfahoqs
        ULu/4W26BJth8ziNnKaJKxoTom96mZ1dE9NA7L0u0w==
X-Google-Smtp-Source: ALg8bN5PnYRu8rYgRqSemIqUlF7NoDvOhb0iyyVpPy2s1+m1oawtgBw6jql7i6Rzdui7LD6UFiU4NiUkOsaSOnrd4+4=
X-Received: by 2002:a9d:18f:: with SMTP id e15mr17333981ote.84.1547459999809;
 Mon, 14 Jan 2019 01:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20190112193251.20450-1-sam@ravnborg.org> <20190112193251.20450-4-sam@ravnborg.org>
In-Reply-To: <20190112193251.20450-4-sam@ravnborg.org>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 14 Jan 2019 10:59:48 +0100
Message-ID: <CA+M3ks7+3iKBVb0GGqaOSSxx=5SXYPejYpJ+-2CRzpF21oQOdw@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] drm/stm: prepare for drmP.h removal from drm_modeset_helper.h
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Christian Konig <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        David Zhou <David1.Zhou@amd.com>,
        Eric Anholt <eric@anholt.net>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Rob Clark <robdclark@gmail.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam. 12 janv. 2019 =C3=A0 20:33, Sam Ravnborg <sam@ravnborg.org> a =C3=
=A9crit :
>
> The use of drmP.h is discouraged and removal of it from
> drm_modeset_helper.h caused drm/stm to fail to build.
>
> This patch introduce the necessary fixes to prepare for the
> drmP.h removal from drm_modeset_helper.h.
>
> Build tested on arm and x86 allmodconfig
>
Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Yannick Fertre <yannick.fertre@st.com>
> Cc: Philippe Cornu <philippe.cornu@st.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Vincent Abriou <vincent.abriou@st.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
>  drivers/gpu/drm/stm/drv.c  | 4 ++++
>  drivers/gpu/drm/stm/ltdc.c | 7 +++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
> index 8dec001b9d37..58bf8bae789c 100644
> --- a/drivers/gpu/drm/stm/drv.c
> +++ b/drivers/gpu/drm/stm/drv.c
> @@ -9,15 +9,19 @@
>   */
>
>  #include <linux/component.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
>  #include <linux/of_platform.h>
>
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_drv.h>
>  #include <drm/drm_fb_helper.h>
>  #include <drm/drm_fb_cma_helper.h>
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_vblank.h>
>
>  #include "ltdc.h"
>
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 61dd661aa0ac..de29f4713140 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -10,18 +10,25 @@
>
>  #include <linux/clk.h>
>  #include <linux/component.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_graph.h>
> +#include <linux/platform_device.h>
>  #include <linux/reset.h>
>
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_device.h>
>  #include <drm/drm_fb_cma_helper.h>
> +#include <drm/drm_fourcc.h>
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_of.h>
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_plane_helper.h>
> +#include <drm/drm_vblank.h>
>
>  #include <video/videomode.h>
>
> --
> 2.12.0
>


--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
