Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC23AC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6998321473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dnEyRNfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6998321473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeJRQrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:47:10 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:55190 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbeJRQrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:47:10 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6C4EC113F;
        Thu, 18 Oct 2018 10:47:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539852431;
        bh=rogeq3cVpiw3u4YQnZJxbnAp2hbVX4fnOKrucklRY68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dnEyRNfipD7ab01Sa3S4TAQ/djYlnTZ5aqQ5X07Vr403RrGCuifBnZDoP9xNa3cAM
         2n3u52udnsQECyL6SXCouqUI61W1YifkYiSZnJbr0bp+fEBRRtYIPWCXU18IVIh5zT
         OEiscmalePvBrOgBPmpTrq0y4uR3dBoT2sBzG404=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/9] drm/bridge: move ANA78xx driver to analogix subdirectory
Date:   Thu, 18 Oct 2018 11:47:20 +0300
Message-ID: <1600163.alMOuyZOxo@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181018073327.64942-2-icenowy@aosc.io>
References: <20181018073327.64942-1-icenowy@aosc.io> <20181018073327.64942-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Icenowy,

Thank you for the patch.

On Thursday, 18 October 2018 10:33:19 EEST Icenowy Zheng wrote:
> As ANA78xx chips are designed and produced by Analogix Semiconductor,
> Inc, move their driver codes into analogix subdirectory.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/gpu/drm/bridge/Kconfig                         | 10 ----------
>  drivers/gpu/drm/bridge/Makefile                        |  4 ++--
>  drivers/gpu/drm/bridge/analogix/Kconfig                | 10 ++++++++++
>  drivers/gpu/drm/bridge/analogix/Makefile               |  1 +
>  .../gpu/drm/bridge/{ => analogix}/analogix-anx78xx.c   |  0
>  .../gpu/drm/bridge/{ => analogix}/analogix-anx78xx.h   |  0
>  6 files changed, 13 insertions(+), 12 deletions(-)
>  rename drivers/gpu/drm/bridge/{ => analogix}/analogix-anx78xx.c (100%)
>  rename drivers/gpu/drm/bridge/{ => analogix}/analogix-anx78xx.h (100%)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 9eeb8ef0b174..8a7ffb3256d8 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -15,16 +15,6 @@ config DRM_PANEL_BRIDGE
>  menu "Display Interface Bridges"
>  	depends on DRM && DRM_BRIDGE
> 
> -config DRM_ANALOGIX_ANX78XX
> -	tristate "Analogix ANX78XX bridge"
> -	select DRM_KMS_HELPER
> -	select REGMAP_I2C
> -	---help---
> -	  ANX78XX is an ultra-low Full-HD SlimPort transmitter
> -	  designed for portable devices. The ANX78XX transforms
> -	  the HDMI output of an application processor to MyDP
> -	  or DisplayPort.
> -
>  config DRM_CDNS_DSI
>  	tristate "Cadence DPI/DSI bridge"
>  	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/bridge/Makefile
> b/drivers/gpu/drm/bridge/Makefile index 4934fcf5a6f8..a6c7dd7727ea 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -1,5 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
>  obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
>  obj-$(CONFIG_DRM_DUMB_VGA_DAC) += dumb-vga-dac.o
>  obj-$(CONFIG_DRM_LVDS_ENCODER) += lvds-encoder.o
> @@ -12,8 +11,9 @@ obj-$(CONFIG_DRM_SII9234) += sii9234.o
>  obj-$(CONFIG_DRM_THINE_THC63LVD1024) += thc63lvd1024.o
>  obj-$(CONFIG_DRM_TOSHIBA_TC358764) += tc358764.o
>  obj-$(CONFIG_DRM_TOSHIBA_TC358767) += tc358767.o
> -obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix/
>  obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
>  obj-$(CONFIG_DRM_TI_SN65DSI86) += ti-sn65dsi86.o
>  obj-$(CONFIG_DRM_TI_TFP410) += ti-tfp410.o
> +
> +obj-y += analogix/
>  obj-y += synopsys/
> diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig
> b/drivers/gpu/drm/bridge/analogix/Kconfig index 80f286fa3a69..27b37aa2ea77
> 100644
> --- a/drivers/gpu/drm/bridge/analogix/Kconfig
> +++ b/drivers/gpu/drm/bridge/analogix/Kconfig
> @@ -1,3 +1,13 @@
>  config DRM_ANALOGIX_DP
>  	tristate
>  	depends on DRM
> +
> +config DRM_ANALOGIX_ANX78XX
> +	tristate "Analogix ANX78XX bridge"
> +	select DRM_KMS_HELPER
> +	select REGMAP_I2C
> +	---help---
> +	  ANX78XX is an ultra-low Full-HD SlimPort transmitter
> +	  designed for portable devices. The ANX78XX transforms
> +	  the HDMI output of an application processor to MyDP
> +	  or DisplayPort.
> diff --git a/drivers/gpu/drm/bridge/analogix/Makefile
> b/drivers/gpu/drm/bridge/analogix/Makefile index cd4010ba6890..eb41be845055
> 100644
> --- a/drivers/gpu/drm/bridge/analogix/Makefile
> +++ b/drivers/gpu/drm/bridge/analogix/Makefile
> @@ -1,2 +1,3 @@
>  analogix_dp-objs := analogix_dp_core.o analogix_dp_reg.o
>  obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix_dp.o
> +obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o

This makes sense to me. I would have tried to keep the Kconfig and Makefile 
entries alphabetically sorted, but that's not a big deal. With or without the 
sorting,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c
> b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c similarity index 100%
> rename from drivers/gpu/drm/bridge/analogix-anx78xx.c
> rename to drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
> diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.h
> b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h similarity index 100%
> rename from drivers/gpu/drm/bridge/analogix-anx78xx.h
> rename to drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h

-- 
Regards,

Laurent Pinchart



