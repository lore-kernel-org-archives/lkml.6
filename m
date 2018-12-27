Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817C5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 10:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF5E214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 10:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="shvsJTuV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbeL0KBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 05:01:33 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:44900 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbeL0KBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 05:01:32 -0500
Received: from avalon.localnet (unknown [91.182.109.47])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 57BF6505;
        Thu, 27 Dec 2018 11:01:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1545904889;
        bh=Eefz2uYPZ2y1yUZ5udoBUQlTEx6wN2uNCe/i62ES1cM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=shvsJTuVglyWbQFxqXRTS4ZlbyoKWPohWg/dcNW/1lliFj3X/TqySYAyA2lwdtelK
         sInrlJDrsQo9q/OqIhMiYFdpme6Ag4C2Cac6VImm17YW5JT1FW5exh1kjMZaQGD1za
         EtPDP4zxR8OgyMC9yI2ep1Xc9FdKWvFeZHWvntVA=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v1 4/7] drm: remove include of drmP.h from bridge/dw_hdmi.h
Date:   Thu, 27 Dec 2018 12:02:25 +0200
Message-ID: <14317533.zFDg2lzPh5@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181226210353.13993-4-sam@ravnborg.org>
References: <20181226210215.GA27610@ravnborg.org> <20181226210353.13993-4-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Thank you for the patch.

On Wednesday, 26 December 2018 23:03:50 EET Sam Ravnborg wrote:
> Add missing includes in dw_hdmi.h and
> fix fallout in drivers.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 4 ++++
>  drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c              | 1 +
>  include/drm/bridge/dw_hdmi.h                        | 5 ++++-
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c index
> 8f9c8a6b46de..c61ec4caaa84 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> @@ -8,6 +8,10 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +
>  #include <drm/bridge/dw_hdmi.h>
> 
>  #include <sound/hdmi-codec.h>
> diff --git a/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
> b/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c index 75490a3e0a2a..f5b07a2e3f59
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
> @@ -8,6 +8,7 @@
>   */
> 
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>

Nitpicking, _ comes before u.

>  #include <linux/platform_device.h>
> 
>  #include <drm/bridge/dw_hdmi.h>
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index ccb5aa8468e0..b0218ee75a65 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -10,7 +10,10 @@
>  #ifndef __DW_HDMI__
>  #define __DW_HDMI__
> 
> -#include <drm/drmP.h>
> +#include <linux/platform_device.h>

I think you can replace this with a forward declaration of struct 
platform_device. You will likely need to handle more fallout.

> +#include <drm/drm_connector.h>
> +#include <drm/drm_modes.h>

Please add forward definitions for structures used in this file and not 
defined in the above headers. I'm thinking about struct regmap and struct 
drm_encoder. They may be defined in headers included from the above three, or 
from headers included from files including dw_hdmi.h, but we shouldn't rely on 
that as it may change.

With this fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  struct dw_hdmi;

-- 
Regards,

Laurent Pinchart



