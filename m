Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB53C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCE7218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbeLXMFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 07:05:23 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58156 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbeLXMFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 07:05:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1D4480D;
        Mon, 24 Dec 2018 04:05:21 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AFD93F718;
        Mon, 24 Dec 2018 04:05:21 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id C49B568036B; Mon, 24 Dec 2018 12:05:19 +0000 (GMT)
Date:   Mon, 24 Dec 2018 12:05:19 +0000
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
Subject: Re: [PATCH v3 5/9] drm/komeda: Add komeda_format_caps for format
 handling
Message-ID: <20181224120519.GG22341@e110455-lin.cambridge.arm.com>
References: <20181221095757.15510-1-james.qian.wang@arm.com>
 <20181221095757.15510-6-james.qian.wang@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181221095757.15510-6-james.qian.wang@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 10:00:01AM +0000, james qian wang (Arm Technology China) wrote:
> komeda_format_caps is for describing ARM display specific features and
> limitations of a specific format, and format_caps will be linked into
> &komeda_framebuffer like a extension of &drm_format_info.
> And komed_format_caps_table will be initialized before the enum_resources,
> since the layer features description depend on this format_caps table, so
> we'd better initialize the table first.
> 
> Changes in v3:
> - Fixed style problem found by checkpatch.pl --strict.
> 
> Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/display/komeda/Makefile   |  1 +
>  .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 78 ++++++++++++++++
>  .../gpu/drm/arm/display/komeda/komeda_dev.c   |  2 +
>  .../gpu/drm/arm/display/komeda/komeda_dev.h   | 11 ++-
>  .../arm/display/komeda/komeda_format_caps.c   | 75 ++++++++++++++++
>  .../arm/display/komeda/komeda_format_caps.h   | 89 +++++++++++++++++++
>  .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
>  7 files changed, 256 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
>  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/arm/display/komeda/Makefile
> index c03d6876ef75..394fc2aa434a 100644
> --- a/drivers/gpu/drm/arm/display/komeda/Makefile
> +++ b/drivers/gpu/drm/arm/display/komeda/Makefile
> @@ -7,6 +7,7 @@ ccflags-y := \
>  komeda-y := \
>  	komeda_drv.o \
>  	komeda_dev.o \
> +	komeda_format_caps.o \
>  	komeda_pipeline.o
>  
>  komeda-y += \
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> index af3dabb499cd..edbf9daa1545 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> @@ -13,7 +13,85 @@ static int d71_enum_resources(struct komeda_dev *mdev)
>  	return -1;
>  }
>  
> +#define __HW_ID(__group, __format) \
> +	((((__group) & 0x7) << 3) | ((__format) & 0x7))
> +
> +#define RICH		KOMEDA_FMT_RICH_LAYER
> +#define SIMPLE		KOMEDA_FMT_SIMPLE_LAYER
> +#define RICH_SIMPLE	(KOMEDA_FMT_RICH_LAYER | KOMEDA_FMT_SIMPLE_LAYER)
> +#define RICH_WB		(KOMEDA_FMT_RICH_LAYER | KOMEDA_FMT_WB_LAYER)
> +#define RICH_SIMPLE_WB	(RICH_SIMPLE | KOMEDA_FMT_WB_LAYER)
> +
> +#define Rot_0		DRM_MODE_ROTATE_0
> +#define Flip_H_V	(DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y | Rot_0)
> +#define Rot_ALL_H_V	(DRM_MODE_ROTATE_MASK | Flip_H_V)
> +
> +#define LYT_NM		BIT(AFBC_FORMAT_MOD_BLOCK_SIZE_16x16)
> +#define LYT_WB		BIT(AFBC_FORMAT_MOD_BLOCK_SIZE_32x8)
> +#define LYT_NM_WB	(LYT_NM | LYT_WB)
> +
> +#define AFB_TH		AFBC(_TILED | _SPARSE)
> +#define AFB_TH_SC_YTR	AFBC(_TILED | _SC | _SPARSE | _YTR)
> +#define AFB_TH_SC_YTR_BS AFBC(_TILED | _SC | _SPARSE | _YTR | _SPLIT)
> +
> +static struct komeda_format_caps d71_format_caps_table[] = {
> +	/*   HW_ID    |        fourcc        | tile_sz |   layer_types |   rots    | afbc_layouts | afbc_features */
> +	/* ABGR_2101010*/
> +	{__HW_ID(0, 0),	DRM_FORMAT_ARGB2101010,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
> +	{__HW_ID(0, 1),	DRM_FORMAT_ABGR2101010,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
> +	{__HW_ID(0, 1),	DRM_FORMAT_ABGR2101010,	1,	RICH_SIMPLE,	Rot_ALL_H_V,	LYT_NM_WB, AFB_TH_SC_YTR_BS}, /* afbc */
> +	{__HW_ID(0, 2),	DRM_FORMAT_RGBA1010102,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
> +	{__HW_ID(0, 3),	DRM_FORMAT_BGRA1010102,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
> +	/* ABGR_8888*/
> +	{__HW_ID(1, 0),	DRM_FORMAT_ARGB8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
> +	{__HW_ID(1, 1),	DRM_FORMAT_ABGR8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
> +	{__HW_ID(1, 1),	DRM_FORMAT_ABGR8888,	1,	RICH_SIMPLE,	Rot_ALL_H_V,	LYT_NM_WB, AFB_TH_SC_YTR_BS}, /* afbc */
> +	{__HW_ID(1, 2),	DRM_FORMAT_RGBA8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
> +	{__HW_ID(1, 3),	DRM_FORMAT_BGRA8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
> +	/* XBGB_8888 */
> +	{__HW_ID(2, 0),	DRM_FORMAT_XRGB8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
> +	{__HW_ID(2, 1),	DRM_FORMAT_XBGR8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
> +	{__HW_ID(2, 2),	DRM_FORMAT_RGBX8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
> +	{__HW_ID(2, 3),	DRM_FORMAT_BGRX8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
> +	/* BGR_888 */ /* none-afbc RGB888 doesn't support rotation and flip */
> +	{__HW_ID(3, 0),	DRM_FORMAT_RGB888,	1,	RICH_SIMPLE_WB,	Rot_0,			0, 0},
> +	{__HW_ID(3, 1),	DRM_FORMAT_BGR888,	1,	RICH_SIMPLE_WB,	Rot_0,			0, 0},
> +	{__HW_ID(3, 1),	DRM_FORMAT_BGR888,	1,	RICH_SIMPLE,	Rot_ALL_H_V,	LYT_NM_WB, AFB_TH_SC_YTR_BS}, /* afbc */
> +	/* BGR 16bpp */
> +	{__HW_ID(4, 0),	DRM_FORMAT_RGBA5551,	1,	RICH_SIMPLE,	Flip_H_V,		0, 0},
> +	{__HW_ID(4, 1),	DRM_FORMAT_ABGR1555,	1,	RICH_SIMPLE,	Flip_H_V,		0, 0},
> +	{__HW_ID(4, 1),	DRM_FORMAT_ABGR1555,	1,	RICH_SIMPLE,	Rot_ALL_H_V,	LYT_NM_WB, AFB_TH_SC_YTR}, /* afbc */
> +	{__HW_ID(4, 2),	DRM_FORMAT_RGB565,	1,	RICH_SIMPLE,	Flip_H_V,		0, 0},
> +	{__HW_ID(4, 3),	DRM_FORMAT_BGR565,	1,	RICH_SIMPLE,	Flip_H_V,		0, 0},
> +	{__HW_ID(4, 3),	DRM_FORMAT_BGR565,	1,	RICH_SIMPLE,	Rot_ALL_H_V,	LYT_NM_WB, AFB_TH_SC_YTR}, /* afbc */
> +	{__HW_ID(4, 4), DRM_FORMAT_R8,		1,	SIMPLE,		Rot_0,			0, 0},
> +	/* YUV 444/422/420 8bit  */
> +	{__HW_ID(5, 0),	0 /*XYUV8888*/,		1,	0,		0,			0, 0},
> +	/* XYUV unsupported*/
> +	{__HW_ID(5, 1),	DRM_FORMAT_YUYV,	1,	RICH,		Rot_ALL_H_V,	LYT_NM, AFB_TH}, /* afbc */
> +	{__HW_ID(5, 2),	DRM_FORMAT_YUYV,	1,	RICH,		Flip_H_V,		0, 0},
> +	{__HW_ID(5, 3),	DRM_FORMAT_UYVY,	1,	RICH,		Flip_H_V,		0, 0},
> +	{__HW_ID(5, 4),	0, /*X0L0 */		2,		0,			0, 0}, /* Y0L0 unsupported */
> +	{__HW_ID(5, 6),	DRM_FORMAT_NV12,	1,	RICH,		Flip_H_V,		0, 0},
> +	{__HW_ID(5, 6),	0/*DRM_FORMAT_YUV420_8BIT*/,	1,	RICH,	Rot_ALL_H_V,	LYT_NM, AFB_TH}, /* afbc */
> +	{__HW_ID(5, 7),	DRM_FORMAT_YUV420,	1,	RICH,		Flip_H_V,		0, 0},
> +	/* YUV 10bit*/
> +	{__HW_ID(6, 0),	0,/*XVYU2101010*/	1,	0,		0,			0, 0},/* VYV30 unsupported */
> +	{__HW_ID(6, 6),	0/*DRM_FORMAT_X0L2*/,	2,	RICH,		Flip_H_V,		0, 0},
> +	{__HW_ID(6, 7),	0/*DRM_FORMAT_P010*/,	1,	RICH,		Flip_H_V,		0, 0},
> +	{__HW_ID(6, 7),	0/*DRM_FORMAT_YUV420_10BIT*/, 1,	RICH,	Rot_ALL_H_V,	LYT_NM, AFB_TH},
> +};
> +
> +static void d71_init_fmt_tbl(struct komeda_dev *mdev)
> +{
> +	struct komeda_format_caps_table *table = &mdev->fmt_tbl;
> +
> +	table->format_caps = d71_format_caps_table;
> +	table->n_formats = ARRAY_SIZE(d71_format_caps_table);
> +}
> +
>  static struct komeda_dev_funcs d71_chip_funcs = {
> +	.init_format_table = d71_init_fmt_tbl,
>  	.enum_resources	= d71_enum_resources,
>  	.cleanup	= NULL,
>  };
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> index d0cc4f758077..2f8f4685eb62 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -138,6 +138,8 @@ struct komeda_dev *komeda_dev_create(struct device *dev)
>  		 MALIDP_CORE_ID_MAJOR(mdev->chip.core_id),
>  		 MALIDP_CORE_ID_MINOR(mdev->chip.core_id));
>  
> +	mdev->funcs->init_format_table(mdev);
> +
>  	err = mdev->funcs->enum_resources(mdev);
>  	if (err) {
>  		DRM_ERROR("enumerate display resource failed.\n");
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> index 4a27a44e2ec6..555510be66f1 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -11,6 +11,7 @@
>  #include <linux/interrupt.h>
>  #include "komeda_pipeline.h"
>  #include "malidp_product.h"
> +#include "komeda_format_caps.h"
>  
>  /* malidp device id */
>  enum {
> @@ -44,6 +45,13 @@ struct komeda_dev;
>   * Supplied by chip level and returned by the chip entry function xxx_identify,
>   */
>  struct komeda_dev_funcs {
> +	/**
> +	 * @init_format_table:
> +	 *
> +	 * initialize &komeda_dev->format_table, this function should be called
> +	 * before the &enum_resource
> +	 */
> +	void (*init_format_table)(struct komeda_dev *mdev);
>  	/**
>  	 * @enum_resources:
>  	 *
> @@ -66,7 +74,8 @@ struct komeda_dev {
>  	u32 __iomem   *reg_base;
>  
>  	struct komeda_chip_info chip;
> -
> +	/** @fmt_tbl: initialized by &komeda_dev_funcs->init_format_table */
> +	struct komeda_format_caps_table fmt_tbl;
>  	/** @pclk: APB clock for register access */
>  	struct clk *pclk;
>  	/** @mck: HW main engine clk */
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
> new file mode 100644
> index 000000000000..1e17bd6107a4
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
> + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> + *
> + */
> +
> +#include <linux/slab.h>
> +#include "komeda_format_caps.h"
> +#include "malidp_utils.h"
> +
> +const struct komeda_format_caps *
> +komeda_get_format_caps(struct komeda_format_caps_table *table,
> +		       u32 fourcc, u64 modifier)
> +{
> +	const struct komeda_format_caps *caps;
> +	u64 afbc_features = modifier & ~(AFBC_FORMAT_MOD_BLOCK_SIZE_MASK);
> +	u32 afbc_layout = modifier & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK;
> +	int id;
> +
> +	for (id = 0; id < table->n_formats; id++) {
> +		caps = &table->format_caps[id];
> +
> +		if (fourcc != caps->fourcc)
> +			continue;
> +
> +		if ((modifier == 0ULL) && (caps->supported_afbc_layouts == 0))
> +			return caps;
> +
> +		if (has_bits(afbc_features, caps->supported_afbc_features) &&
> +		    has_bit(afbc_layout, caps->supported_afbc_layouts))
> +			return caps;
> +	}
> +
> +	return NULL;
> +}
> +
> +u32 *komeda_get_layer_fourcc_list(struct komeda_format_caps_table *table,
> +				  u32 layer_type, u32 *n_fmts)
> +{
> +	const struct komeda_format_caps *cap;
> +	u32 *fmts;
> +	int i, j, n = 0;
> +
> +	fmts = kcalloc(table->n_formats, sizeof(u32), GFP_KERNEL);
> +	if (!fmts)
> +		return NULL;
> +
> +	for (i = 0; i < table->n_formats; i++) {
> +		cap = &table->format_caps[i];
> +		if (!(layer_type & cap->supported_layer_types) ||
> +		    (cap->fourcc == 0))
> +			continue;
> +
> +		/* one fourcc may has two caps items in table (afbc/none-afbc),
> +		 * so check the existing list to avoid adding a duplicated one.
> +		 */
> +		for (j = n - 1; j >= 0; j--)
> +			if (fmts[j] == cap->fourcc)
> +				break;
> +
> +		if (j < 0)
> +			fmts[n++] = cap->fourcc;
> +	}
> +
> +	if (n_fmts)
> +		*n_fmts = n;
> +
> +	return fmts;
> +}
> +
> +void komeda_put_fourcc_list(u32 *fourcc_list)
> +{
> +	kfree(fourcc_list);
> +}
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> new file mode 100644
> index 000000000000..60f39e77b098
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
> @@ -0,0 +1,89 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
> + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> + *
> + */
> +
> +#ifndef _KOMEDA_FORMAT_CAPS_H_
> +#define _KOMEDA_FORMAT_CAPS_H_
> +
> +#include <linux/types.h>
> +#include <uapi/drm/drm_fourcc.h>
> +#include <drm/drm_fourcc.h>
> +
> +#define AFBC(x)		DRM_FORMAT_MOD_ARM_AFBC(x)
> +
> +/* afbc layerout */
> +#define AFBC_16x16(x)	AFBC(AFBC_FORMAT_MOD_BLOCK_SIZE_16x16 | (x))
> +#define AFBC_32x8(x)	AFBC(AFBC_FORMAT_MOD_BLOCK_SIZE_32x8 | (x))
> +
> +/* afbc features */
> +#define _YTR		AFBC_FORMAT_MOD_YTR
> +#define _SPLIT		AFBC_FORMAT_MOD_SPLIT
> +#define _SPARSE		AFBC_FORMAT_MOD_SPARSE
> +#define _CBR		AFBC_FORMAT_MOD_CBR
> +#define _TILED		AFBC_FORMAT_MOD_TILED
> +#define _SC		AFBC_FORMAT_MOD_SC
> +
> +/* layer_type */
> +#define KOMEDA_FMT_RICH_LAYER		BIT(0)
> +#define KOMEDA_FMT_SIMPLE_LAYER		BIT(1)
> +#define KOMEDA_FMT_WB_LAYER		BIT(2)
> +
> +#define AFBC_TH_LAYOUT_ALIGNMENT	8
> +#define AFBC_HEADER_SIZE		16
> +#define AFBC_SUPERBLK_ALIGNMENT		128
> +#define AFBC_SUPERBLK_PIXELS		256
> +#define AFBC_BODY_START_ALIGNMENT	1024
> +#define AFBC_TH_BODY_START_ALIGNMENT	4096
> +
> +/**
> + * struct komeda_format_caps
> + *
> + * komeda_format_caps is for describing ARM display specific features and
> + * limitations for a specific format, and format_caps will be linked into
> + * &komeda_framebuffer like a extension of &drm_format_info.
> + *
> + * NOTE: one fourcc may has two different format_caps items for fourcc and
> + * fourcc+modifier
> + *
> + * @hw_id: hw format id, hw specific value.
> + * @fourcc: drm fourcc format.
> + * @tile_size: format tiled size, used by ARM format X0L0/X0L2
> + * @supported_layer_types: indicate which layer supports this format
> + * @supported_rots: allowed rotations for this format
> + * @supported_afbc_layouts: supported afbc layerout
> + * @supported_afbc_features: supported afbc features
> + */
> +struct komeda_format_caps {
> +	u32 hw_id;
> +	u32 fourcc;
> +	u32 tile_size;
> +	u32 supported_layer_types;
> +	u32 supported_rots;
> +	u32 supported_afbc_layouts;
> +	u64 supported_afbc_features;
> +};
> +
> +/**
> + * struct komeda_format_caps_table - format_caps mananger
> + *
> + * @n_formats: the size of format_caps list.
> + * @format_caps: format_caps list.
> + */
> +struct komeda_format_caps_table {
> +	u32 n_formats;
> +	const struct komeda_format_caps *format_caps;
> +};
> +
> +const struct komeda_format_caps *
> +komeda_get_format_caps(struct komeda_format_caps_table *table,
> +		       u32 fourcc, u64 modifier);
> +
> +u32 *komeda_get_layer_fourcc_list(struct komeda_format_caps_table *table,
> +				  u32 layer_type, u32 *n_fmts);
> +
> +void komeda_put_fourcc_list(u32 *fourcc_list);
> +
> +#endif
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index d1e0c1140273..2d68ffeae25d 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -213,6 +213,7 @@ static inline u16 component_changed_inputs(struct komeda_component_state *st)
>  struct komeda_layer {
>  	struct komeda_component base;
>  	/* layer specific features and caps */
> +	int layer_type; /* RICH, SIMPLE or WB */
>  };
>  
>  struct komeda_layer_state {
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
