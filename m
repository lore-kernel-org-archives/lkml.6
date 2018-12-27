Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_RHS_DOB autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32F4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 10:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897C9214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 10:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="PSABJqMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbeL0KDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 05:03:39 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:44944 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730604AbeL0KDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 05:03:39 -0500
Received: from avalon.localnet (unknown [91.182.109.47])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CC220505;
        Thu, 27 Dec 2018 11:03:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1545905016;
        bh=hVo7dKJYdsV3UxOSJXGzDkJFHUqNA4S5kygTHvVTBkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSABJqMRkGpkKPzI1exwX5on519FZfH+a0LMnX/xe+iUgOnQLxxWk1nVFlNQ2HMiy
         NCJQaPctDxYmLuA20JlqghGGrnPGC/yPQ1NMPFGKhLFhZVR7ZmEJi+ue9fLqhNDq4K
         6SN7diY74M5moNZwn0WBueQr0ten2d3/Pmzel9CM=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: Re: [PATCH v1 6/7] drm: remove include of drmP.h from drm_modeset_helper.h
Date:   Thu, 27 Dec 2018 12:04:32 +0200
Message-ID: <8497582.5Vic9fWd66@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181226210353.13993-6-sam@ravnborg.org>
References: <20181226210215.GA27610@ravnborg.org> <20181226210353.13993-6-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Thank you for the patch.

On Wednesday, 26 December 2018 23:03:52 EET Sam Ravnborg wrote:
> Fix fallout in various files/drivers by adding missing include files.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  drivers/gpu/drm/arc/arcpgu_sim.c     | 1 +
>  drivers/gpu/drm/bridge/cdns-dsi.c    | 2 ++
>  drivers/gpu/drm/drm_modeset_helper.c | 2 ++
>  drivers/gpu/drm/rcar-du/rcar_lvds.c  | 1 +
>  include/drm/drm_modeset_helper.h     | 2 --
>  5 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arc/arcpgu_sim.c
> b/drivers/gpu/drm/arc/arcpgu_sim.c index 68629e614990..3b7556f62230 100644
> --- a/drivers/gpu/drm/arc/arcpgu_sim.c
> +++ b/drivers/gpu/drm/arc/arcpgu_sim.c
> @@ -14,6 +14,7 @@
>   *
>   */
> 
> +#include <drm/drm_device.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_atomic_helper.h>
> 
> diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c
> b/drivers/gpu/drm/bridge/cdns-dsi.c index ce9496d13986..4b73d0969468 100644
> --- a/drivers/gpu/drm/bridge/cdns-dsi.c
> +++ b/drivers/gpu/drm/bridge/cdns-dsi.c
> @@ -8,11 +8,13 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_drv.h>
>  #include <drm/drm_mipi_dsi.h>
>  #include <drm/drm_panel.h>
>  #include <video/mipi_display.h>
> 
>  #include <linux/clk.h>
> +#include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> diff --git a/drivers/gpu/drm/drm_modeset_helper.c
> b/drivers/gpu/drm/drm_modeset_helper.c index f1c24ab0ef09..680cb6a5978c
> 100644
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
> diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c
> b/drivers/gpu/drm/rcar-du/rcar_lvds.c index 173d7ad0b991..f1043458cbd8
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
> @@ -10,6 +10,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/of_graph.h>
> diff --git a/include/drm/drm_modeset_helper.h
> b/include/drm/drm_modeset_helper.h index efa337f03129..82ead67dfa36 100644
> --- a/include/drm/drm_modeset_helper.h
> +++ b/include/drm/drm_modeset_helper.h
> @@ -23,8 +23,6 @@
>  #ifndef __DRM_KMS_HELPER_H__
>  #define __DRM_KMS_HELPER_H__
> 
> -#include <drm/drmP.h>

Please add forward declarations for all structures used as pointers in this 
file. We shouldn't rely on the files including drm_modeset_helper.h to provide 
definitions or declarations for those structures.

With that fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  void drm_helper_move_panel_connectors_to_head(struct drm_device *);
> 
>  void drm_helper_mode_fill_fb_struct(struct drm_device *dev,

-- 
Regards,

Laurent Pinchart



