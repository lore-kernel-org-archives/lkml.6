Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A8CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4292183F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQN/UtSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfAIIVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:21:51 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45509 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbfAIIVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:21:51 -0500
Received: by mail-oi1-f193.google.com with SMTP id y1so5605212oie.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 00:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nBU5TR4H3monR0v2OXEjXhxUUBCnKLGZrjsC6sKbbSI=;
        b=TQN/UtSeKptcrlF6WEstW4blFirdBTTorYT6uxmzRwWNM7s6IGsY3hwPX7LvV970Hz
         +xz80G9aj336IqQWsNEBCbz3WHdvqIlZSWyCv6WEuwkU3eU9OGpPxrRSYgZjmfnTKaDs
         boKTxpXQhjLzvCe4HLLgWD4dzKSsuNcKNH6fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nBU5TR4H3monR0v2OXEjXhxUUBCnKLGZrjsC6sKbbSI=;
        b=E1aUEJS1dBl9Cr3hrBZmRAmbUQMXgZXa0y2hLCt4o64oOrjTnTm6sxsDoSK7cxpDsa
         x+RWzg0PTS645MVnSwsBM+ezpC85qTfNuigK7LEsleRTRViOWt4UT6br512dRvfNVOFY
         Yz5lwr6rPGfhk7GxUjNab96LexvMhpa1ey2sGGp734qT6bEilthSwVNYjC8+tRYK1EMo
         SsQfDmhjI0mXVFoyGND9dnmGiBtdGWpDtj0E3nANACPptxOKWKi+fYokq9UMTRP2vZyS
         R8YcrZzRO0vdwGLTbxboziDuBCuxlAvxk4RhJ3qhpChxOXKvfA/IskCiKY+d6KNfwj50
         LUnA==
X-Gm-Message-State: AJcUukdH5/LJlbWrUJ3tEWPqpH098xmNGpz5KaL/zmHUmNriLFAHI/ZV
        islZqZolCivP+lCLpKTiz4Tb30IRvbUtMSenewwh9A==
X-Google-Smtp-Source: ALg8bN5cHjIFb1NiI5LVDcUmk40GMtmrb1z7a1qK2nr31T9jONncd6WweqRWPcNMDe0OsJ1yuRSIcFdZCoOC4xq2jJI=
X-Received: by 2002:aca:c0c6:: with SMTP id q189mr3131210oif.226.1547022109686;
 Wed, 09 Jan 2019 00:21:49 -0800 (PST)
MIME-Version: 1.0
References: <20190108192939.15255-1-sam@ravnborg.org> <20190108192939.15255-11-sam@ravnborg.org>
In-Reply-To: <20190108192939.15255-11-sam@ravnborg.org>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Wed, 9 Jan 2019 09:21:39 +0100
Message-ID: <CA+M3ks5odiPjG1mTFB-MUGDh8ku11rY2zpkxcQMZBzphakH1Cw@mail.gmail.com>
Subject: Re: [PATCH v3 10/12] drm/stm: do not reply on drmP.h from drm_gem_cma_helper.h
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Philippe Cornu <philippe.cornu@st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar. 8 janv. 2019 =C3=A0 20:30, Sam Ravnborg <sam@ravnborg.org> a =C3=A9=
crit :
I just notice the a typo in the title of the commit message reply ->rely ?

>
> drmP.h was the only header file in the past and a lot
> of files rely on that drmP.h defines everything.
> The goal is to one day to delete drmP.h and
> as a step towards this it will no longer be included in the
> headers files in include/drm/
>
> To prepare stm/ for this add dependencies that
> othwewise was pulled in by drmP.h from drm_gem_cma_helper.h
>
> Sort the include list when we anyway modify it.
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Acked-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
> Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Yannick Fertre <yannick.fertre@st.com>
> Cc: Philippe Cornu <philippe.cornu@st.com>
> Cc: Vincent Abriou <vincent.abriou@st.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
>  drivers/gpu/drm/stm/drv.c  | 6 +++++-
>  drivers/gpu/drm/stm/ltdc.c | 9 ++++++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
> index 8dec001b9d37..9cd6228a18ad 100644
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
>  #include <drm/drm_fb_helper.h>
> -#include <drm/drm_fb_cma_helper.h>
> +#include <drm/drm_drv.h>
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_fb_cma_helper.h>
> +#include <drm/drm_vblank.h>
>
>  #include "ltdc.h"
>
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 61dd661aa0ac..5cce6c7f35d4 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -10,17 +10,24 @@
>
>  #include <linux/clk.h>
>  #include <linux/component.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_graph.h>
> +#include <linux/platform_device.h>
>  #include <linux/reset.h>
>
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_bridge.h>
>  #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_device.h>
>  #include <drm/drm_fb_cma_helper.h>
> +#include <drm/drm_fourcc.h>
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_of.h>
> -#include <drm/drm_bridge.h>
> +#include <drm/drm_vblank.h>
>  #include <drm/drm_plane_helper.h>
>
>  #include <video/videomode.h>
> --
> 2.12.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
