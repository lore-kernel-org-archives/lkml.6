Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF129C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB31920657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="d22x2Xnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfARPVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:21:32 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:53034 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfARPVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:21:31 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0AB9553E;
        Fri, 18 Jan 2019 16:21:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1547824888;
        bh=+53q32JyMBAn6gJ+nJ977UynYT1TnR5GD+PyvC5gt3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d22x2Xnd/01H92FGL8U/WaiFXMQcJ8lqeeV/w871PpaLfL/79Exo9bTK4sqKTEw7A
         NcbbIieNbrBzS+jP3hvwzvuK4wCpYbhKb3wo1+rwPzgbnaTw7EkjZwq1KE4NYDND35
         1L50Vn1g6IhLr31KTIhBw21Lwp2tIo1/K6KiMLBQ=
Date:   Fri, 18 Jan 2019 17:21:28 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Christian Konig <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        David Zhou <David1.Zhou@amd.com>,
        Eric Anholt <eric@anholt.net>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 2/8] drm: move EXPORT_SYMBOL_FOR_TESTS_ONLY to
 drm_util.h
Message-ID: <20190118152128.GE5275@pendragon.ideasonboard.com>
References: <20190112193251.20450-1-sam@ravnborg.org>
 <20190112193251.20450-3-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190112193251.20450-3-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Thank you for the patch.

On Sat, Jan 12, 2019 at 08:32:45PM +0100, Sam Ravnborg wrote:
> In the quest to get rid of drmP.h move the newly
> added EXPORT_SYMBOL_FOR_TESTS_ONLY to drm_util.h.

Would it make sense to move it to drm_internal.h as it's really for
internal use of the DRM core ?

> Fix the single user.
> 
> Add a note to drmP.h to avoid further use of it.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
>  drivers/gpu/drm/drm_framebuffer.c |  1 +
>  include/drm/drmP.h                | 11 ++++++-----
>  include/drm/drm_util.h            | 10 ++++++++++
>  3 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> index fcaea8f50513..7abcb265a108 100644
> --- a/drivers/gpu/drm/drm_framebuffer.c
> +++ b/drivers/gpu/drm/drm_framebuffer.c
> @@ -27,6 +27,7 @@
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_uapi.h>
>  #include <drm/drm_print.h>
> +#include <drm/drm_util.h>
>  
>  #include "drm_internal.h"
>  #include "drm_crtc_internal.h"
> diff --git a/include/drm/drmP.h b/include/drm/drmP.h
> index bc4cb3732407..3f5c577c9dbd 100644
> --- a/include/drm/drmP.h
> +++ b/include/drm/drmP.h
> @@ -94,10 +94,11 @@ struct dma_buf_attachment;
>  struct pci_dev;
>  struct pci_controller;
>  
> -#if defined(CONFIG_DRM_DEBUG_SELFTEST_MODULE)
> -#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x) EXPORT_SYMBOL(x)
> -#else
> -#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x)
> -#endif
> +/*
> + * NOTE: drmP.h is obsolete - do NOT add anything to this file
> + *
> + * Do not include drmP.h in new files.
> + * Work is ongoing to remove drmP.h includes from existing files
> + */
>  
>  #endif
> diff --git a/include/drm/drm_util.h b/include/drm/drm_util.h
> index f776a55e5508..0500da65b1d1 100644
> --- a/include/drm/drm_util.h
> +++ b/include/drm/drm_util.h
> @@ -37,6 +37,16 @@
>  #include <linux/kgdb.h>
>  #include <linux/smp.h>
>  
> +/*
> + * Use EXPORT_SYMBOL_FOR_TESTS_ONLY() for functions that shall
> + * only be visible for drmselftests.
> + */
> +#if defined(CONFIG_DRM_DEBUG_SELFTEST_MODULE)
> +#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x) EXPORT_SYMBOL(x)

I'd make this EXPORT_SYMBOL_GPL given the internal use, but that change
should be part of a separate patch.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +#else
> +#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x)
> +#endif
> +
>  /**
>   * for_each_if - helper for handling conditionals in various for_each macros
>   * @condition: The condition to check

-- 
Regards,

Laurent Pinchart
