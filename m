Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF63C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A059E21928
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbeLXMPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 07:15:30 -0500
Received: from foss.arm.com ([217.140.101.70]:58226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbeLXMP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 07:15:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0083580D;
        Mon, 24 Dec 2018 04:15:26 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E33B3F718;
        Mon, 24 Dec 2018 04:15:25 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id E9AA568036B; Mon, 24 Dec 2018 12:15:23 +0000 (GMT)
Date:   Mon, 24 Dec 2018 12:15:23 +0000
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3 6/9] drm/komeda: Add komeda_framebuffer
Message-ID: <20181224121523.GH22341@e110455-lin.cambridge.arm.com>
References: <20181221095757.15510-1-james.qian.wang@arm.com>
 <20181221095757.15510-7-james.qian.wang@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181221095757.15510-7-james.qian.wang@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 10:00:17AM +0000, james qian wang (Arm Technology China) wrote:
> komeda_framebuffer is for extending drm_framebuffer to add komeda own
> attributes and komeda specific fb handling.
> 
> Changes in v3:
> - Fixed style problem found by checkpatch.pl --strict.
> 
> Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/Makefile   |   3 +-
>  .../arm/display/komeda/komeda_framebuffer.c   | 165 ++++++++++++++++++
>  .../arm/display/komeda/komeda_framebuffer.h   |  31 ++++
>  3 files changed, 198 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
>  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/arm/display/komeda/Makefile
> index 394fc2aa434a..25beae900ed2 100644
> --- a/drivers/gpu/drm/arm/display/komeda/Makefile
> +++ b/drivers/gpu/drm/arm/display/komeda/Makefile
> @@ -8,7 +8,8 @@ komeda-y := \
>  	komeda_drv.o \
>  	komeda_dev.o \
>  	komeda_format_caps.o \
> -	komeda_pipeline.o
> +	komeda_pipeline.o \
> +	komeda_framebuffer.o
>  
>  komeda-y += \
>  	d71/d71_dev.o
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> new file mode 100644
> index 000000000000..4ddd5314ca23
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
> + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> + *
> + */
> +#include <drm/drm_gem.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_fb_cma_helper.h>
> +#include <drm/drm_gem_cma_helper.h>
> +#include "komeda_framebuffer.h"
> +#include "komeda_dev.h"
> +
> +static void komeda_fb_destroy(struct drm_framebuffer *fb)
> +{
> +	struct komeda_fb *kfb = to_kfb(fb);
> +	u32 i;
> +
> +	for (i = 0; i < fb->format->num_planes; i++)
> +		drm_gem_object_put_unlocked(fb->obj[i]);
> +
> +	drm_framebuffer_cleanup(fb);
> +	kfree(kfb);
> +}
> +
> +static int komeda_fb_create_handle(struct drm_framebuffer *fb,
> +				   struct drm_file *file, u32 *handle)
> +{
> +	return drm_gem_handle_create(file, fb->obj[0], handle);
> +}
> +
> +static const struct drm_framebuffer_funcs komeda_fb_funcs = {
> +	.destroy	= komeda_fb_destroy,
> +	.create_handle	= komeda_fb_create_handle,
> +};
> +
> +static int
> +komeda_fb_none_afbc_size_check(struct komeda_dev *mdev, struct komeda_fb *kfb,
> +			       struct drm_file *file,
> +			       const struct drm_mode_fb_cmd2 *mode_cmd)

Not sure what _none stands for here, but otherwise:

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> +{
> +	struct drm_framebuffer *fb = &kfb->base;
> +	struct drm_gem_object *obj;
> +	u32 min_size = 0;
> +	u32 i;
> +
> +	for (i = 0; i < fb->format->num_planes; i++) {
> +		obj = drm_gem_object_lookup(file, mode_cmd->handles[i]);
> +		if (!obj) {
> +			DRM_DEBUG_KMS("Failed to lookup GEM object\n");
> +			fb->obj[i] = NULL;
> +
> +			return -ENOENT;
> +		}
> +
> +		kfb->aligned_w = fb->width / (i ? fb->format->hsub : 1);
> +		kfb->aligned_h = fb->height / (i ? fb->format->vsub : 1);
> +
> +		if (fb->pitches[i] % mdev->chip.bus_width) {
> +			DRM_DEBUG_KMS("Pitch[%d]: 0x%x doesn't align to 0x%x\n",
> +				      i, fb->pitches[i], mdev->chip.bus_width);
> +			drm_gem_object_put_unlocked(obj);
> +			fb->obj[i] = NULL;
> +
> +			return -EINVAL;
> +		}
> +
> +		min_size = ((kfb->aligned_h / kfb->format_caps->tile_size - 1)
> +			    * fb->pitches[i])
> +			    + (kfb->aligned_w * fb->format->cpp[i]
> +			       * kfb->format_caps->tile_size)
> +			    + fb->offsets[i];
> +
> +		if (obj->size < min_size) {
> +			DRM_DEBUG_KMS("Fail to check none afbc fb size.\n");
> +			drm_gem_object_put_unlocked(obj);
> +			fb->obj[i] = NULL;
> +
> +			return -EINVAL;
> +		}
> +
> +		fb->obj[i] = obj;
> +	}
> +
> +	if (fb->format->num_planes == 3) {
> +		if (fb->pitches[1] != fb->pitches[2]) {
> +			DRM_DEBUG_KMS("The pitch[1] and [2] are not same\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +struct drm_framebuffer *
> +komeda_fb_create(struct drm_device *dev, struct drm_file *file,
> +		 const struct drm_mode_fb_cmd2 *mode_cmd)
> +{
> +	struct komeda_dev *mdev = dev->dev_private;
> +	struct komeda_fb *kfb;
> +	int ret = 0, i;
> +
> +	kfb = kzalloc(sizeof(*kfb), GFP_KERNEL);
> +	if (!kfb)
> +		return ERR_PTR(-ENOMEM);
> +
> +	kfb->format_caps = komeda_get_format_caps(&mdev->fmt_tbl,
> +						  mode_cmd->pixel_format,
> +						  mode_cmd->modifier[0]);
> +	if (!kfb->format_caps) {
> +		DRM_DEBUG_KMS("FMT %x is not supported.\n",
> +			      mode_cmd->pixel_format);
> +		kfree(kfb);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	drm_helper_mode_fill_fb_struct(dev, &kfb->base, mode_cmd);
> +
> +	ret = komeda_fb_none_afbc_size_check(mdev, kfb, file, mode_cmd);
> +	if (ret < 0)
> +		goto err_cleanup;
> +
> +	ret = drm_framebuffer_init(dev, &kfb->base, &komeda_fb_funcs);
> +	if (ret < 0) {
> +		DRM_DEBUG_KMS("failed to initialize fb\n");
> +
> +		goto err_cleanup;
> +	}
> +
> +	return &kfb->base;
> +
> +err_cleanup:
> +	for (i = 0; i < kfb->base.format->num_planes; i++)
> +		drm_gem_object_put_unlocked(kfb->base.obj[i]);
> +
> +	kfree(kfb);
> +	return ERR_PTR(ret);
> +}
> +
> +dma_addr_t
> +komeda_fb_get_pixel_addr(struct komeda_fb *kfb, int x, int y, int plane)
> +{
> +	struct drm_framebuffer *fb = &kfb->base;
> +	const struct drm_gem_cma_object *obj;
> +	u32 plane_x, plane_y, cpp, pitch, offset;
> +
> +	if (plane > fb->format->num_planes) {
> +		DRM_DEBUG_KMS("Out of max plane num.\n");
> +		return -EINVAL;
> +	}
> +
> +	obj = drm_fb_cma_get_gem_obj(fb, plane);
> +
> +	offset = fb->offsets[plane];
> +	if (!fb->modifier) {
> +		plane_x = x / (plane ? fb->format->hsub : 1);
> +		plane_y = y / (plane ? fb->format->vsub : 1);
> +		cpp = fb->format->cpp[plane];
> +		pitch = fb->pitches[plane];
> +		offset += plane_x * cpp *  kfb->format_caps->tile_size +
> +				(plane_y * pitch) / kfb->format_caps->tile_size;
> +	}
> +
> +	return obj->paddr + offset;
> +}
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
> new file mode 100644
> index 000000000000..383780013bb9
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
> + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> + *
> + */
> +#ifndef _KOMEDA_FRAMEBUFFER_H_
> +#define _KOMEDA_FRAMEBUFFER_H_
> +
> +/** struct komeda_fb - entend drm_framebuffer with komeda attribute */
> +struct komeda_fb {
> +	/** @base: &drm_framebuffer */
> +	struct drm_framebuffer base;
> +	/* @format_caps: &komeda_format_caps */
> +	const struct komeda_format_caps *format_caps;
> +	/** @aligned_w: aligned frame buffer width */
> +	u32 aligned_w;
> +	/** @aligned_h: aligned frame buffer height */
> +	u32 aligned_h;
> +};
> +
> +#define to_kfb(dfb)	container_of(dfb, struct komeda_fb, base)
> +
> +struct drm_framebuffer *
> +komeda_fb_create(struct drm_device *dev, struct drm_file *file,
> +		 const struct drm_mode_fb_cmd2 *mode_cmd);
> +dma_addr_t
> +komeda_fb_get_pixel_addr(struct komeda_fb *kfb, int x, int y, int plane);
> +bool komeda_fb_is_layer_supported(struct komeda_fb *kfb, u32 layer_type);
> +
> +#endif
> -- 
> 2.17.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
