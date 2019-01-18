Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06D9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9EF20657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Ty33CYAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfARPZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:25:09 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:53210 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfARPZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:25:06 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 73B8253E;
        Fri, 18 Jan 2019 16:25:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1547825103;
        bh=kOzd4fbb4z1ozKX6ceJSd/xA2R+IB7nm0cFfienrEZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ty33CYABuFEXPz2gI+kE1q9V0M19wBQs2W0elnogAps34bFrCFT12mjTephP12K3i
         ZmfH/xnkjmn3u0aSkCTQ159TQ6SImNGb6BVy+9pkOm6D22m9hbAssyliwKtJupYM+b
         itDcChru9/hdKfU0qpbi8AHxZn7rB1lUZgdLj+KU=
Date:   Fri, 18 Jan 2019 17:25:04 +0200
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
Subject: Re: [PATCH v4 8/8] drm: remove drmP.h from drm_modeset_helper.h
Message-ID: <20190118152504.GG5275@pendragon.ideasonboard.com>
References: <20190112193251.20450-1-sam@ravnborg.org>
 <20190112193251.20450-9-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190112193251.20450-9-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Thank you for the patch.

On Sat, Jan 12, 2019 at 08:32:51PM +0100, Sam Ravnborg wrote:
> With the removal of drmP.h from drm_modeset_helper.h
> the drmP.h are no longer included by any include files
> in include/drm.
> The drmP.h file is thus only included explicit
> either in .c files or in local .h files.
> This makes the process of deleting the drmP.h includes easier
> as we have a more local dependency chain.
> 
> Include build failures fixes in drm files after the drmP.h removal.

Great work!

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
>  drivers/gpu/drm/drm_damage_helper.c  | 1 +
>  drivers/gpu/drm/drm_modeset_helper.c | 2 ++
>  include/drm/drm_modeset_helper.h     | 6 +++++-
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
> index 31032407254d..b575a768f51c 100644
> --- a/drivers/gpu/drm/drm_damage_helper.c
> +++ b/drivers/gpu/drm/drm_damage_helper.c
> @@ -32,6 +32,7 @@
>  
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_damage_helper.h>
> +#include <drm/drm_device.h>
>  
>  /**
>   * DOC: overview
> diff --git a/drivers/gpu/drm/drm_modeset_helper.c b/drivers/gpu/drm/drm_modeset_helper.c
> index 9150fa385bba..9bc1ef788c77 100644
> --- a/drivers/gpu/drm/drm_modeset_helper.c
> +++ b/drivers/gpu/drm/drm_modeset_helper.c
> @@ -23,8 +23,10 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_fb_helper.h>
> +#include <drm/drm_fourcc.h>
>  #include <drm/drm_modeset_helper.h>
>  #include <drm/drm_plane_helper.h>
> +#include <drm/drm_print.h>
>  
>  /**
>   * DOC: aux kms helpers
> diff --git a/include/drm/drm_modeset_helper.h b/include/drm/drm_modeset_helper.h
> index efa337f03129..995fd981cab0 100644
> --- a/include/drm/drm_modeset_helper.h
> +++ b/include/drm/drm_modeset_helper.h
> @@ -23,7 +23,11 @@
>  #ifndef __DRM_KMS_HELPER_H__
>  #define __DRM_KMS_HELPER_H__
>  
> -#include <drm/drmP.h>
> +struct drm_crtc;
> +struct drm_crtc_funcs;
> +struct drm_device;
> +struct drm_framebuffer;
> +struct drm_mode_fb_cmd2;
>  
>  void drm_helper_move_panel_connectors_to_head(struct drm_device *);
>  

-- 
Regards,

Laurent Pinchart
