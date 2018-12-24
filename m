Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9794CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 11:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E68B2184C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 11:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbeLXL5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 06:57:43 -0500
Received: from foss.arm.com ([217.140.101.70]:57986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbeLXL5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 06:57:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62BC980D;
        Mon, 24 Dec 2018 03:57:41 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 086FC3F718;
        Mon, 24 Dec 2018 03:57:41 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 59F1A680358; Mon, 24 Dec 2018 11:57:39 +0000 (GMT)
Date:   Mon, 24 Dec 2018 11:57:39 +0000
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
Subject: Re: [PATCH v3 1/9] drm/komeda: komeda_dev/pipeline/component
 definition and initialzation
Message-ID: <20181224115739.GC22341@e110455-lin.cambridge.arm.com>
References: <20181221095757.15510-1-james.qian.wang@arm.com>
 <20181221095757.15510-2-james.qian.wang@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181221095757.15510-2-james.qian.wang@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 09:58:55AM +0000, james qian wang (Arm Technology China) wrote:
> 1. Added a brief definition of komeda_dev/pipeline/component, this change
>    didn't add the detailed component features and capabilities, which will
>    be added in the following changes.
> 2. Corresponding resources discovery and initialzation functions.
> 
> Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
> 
> Changes in v3:
> - Fixed style problem found by checkpatch.pl --strict.
> 
> Changes in v2:
> - Unified abbreviation of "pipeline" to "pipe".
> ---
>  drivers/gpu/drm/arm/Kconfig                   |   2 +
>  drivers/gpu/drm/arm/Makefile                  |   1 +
>  drivers/gpu/drm/arm/display/Kbuild            |   3 +
>  drivers/gpu/drm/arm/display/Kconfig           |  14 +
>  .../drm/arm/display/include/malidp_product.h  |  23 ++
>  .../drm/arm/display/include/malidp_utils.h    |  16 +
>  drivers/gpu/drm/arm/display/komeda/Makefile   |  11 +
>  .../gpu/drm/arm/display/komeda/komeda_dev.c   | 117 ++++++
>  .../gpu/drm/arm/display/komeda/komeda_dev.h   |  98 +++++
>  .../drm/arm/display/komeda/komeda_pipeline.c  | 198 ++++++++++
>  .../drm/arm/display/komeda/komeda_pipeline.h  | 350 ++++++++++++++++++
>  11 files changed, 833 insertions(+)
>  create mode 100644 drivers/gpu/drm/arm/display/Kbuild
>  create mode 100644 drivers/gpu/drm/arm/display/Kconfig
>  create mode 100644 drivers/gpu/drm/arm/display/include/malidp_product.h
>  create mode 100644 drivers/gpu/drm/arm/display/include/malidp_utils.h
>  create mode 100644 drivers/gpu/drm/arm/display/komeda/Makefile
>  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_dev.c
>  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_dev.h
>  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
>  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> 
> diff --git a/drivers/gpu/drm/arm/Kconfig b/drivers/gpu/drm/arm/Kconfig
> index f9f7761cb2f4..a204103b3efb 100644
> --- a/drivers/gpu/drm/arm/Kconfig
> +++ b/drivers/gpu/drm/arm/Kconfig
> @@ -37,4 +37,6 @@ config DRM_MALI_DISPLAY
>  
>  	  If compiled as a module it will be called mali-dp.
>  
> +source "drivers/gpu/drm/arm/display/Kconfig"
> +
>  endmenu
> diff --git a/drivers/gpu/drm/arm/Makefile b/drivers/gpu/drm/arm/Makefile
> index 3bf31d1a4722..120bef801fcf 100644
> --- a/drivers/gpu/drm/arm/Makefile
> +++ b/drivers/gpu/drm/arm/Makefile
> @@ -3,3 +3,4 @@ obj-$(CONFIG_DRM_HDLCD)	+= hdlcd.o
>  mali-dp-y := malidp_drv.o malidp_hw.o malidp_planes.o malidp_crtc.o
>  mali-dp-y += malidp_mw.o
>  obj-$(CONFIG_DRM_MALI_DISPLAY)	+= mali-dp.o
> +obj-$(CONFIG_DRM_KOMEDA) += display/
> diff --git a/drivers/gpu/drm/arm/display/Kbuild b/drivers/gpu/drm/arm/display/Kbuild
> new file mode 100644
> index 000000000000..382f1ca831e4
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/Kbuild
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_DRM_KOMEDA) += komeda/
> diff --git a/drivers/gpu/drm/arm/display/Kconfig b/drivers/gpu/drm/arm/display/Kconfig
> new file mode 100644
> index 000000000000..cec0639e3aa1
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/Kconfig
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config DRM_KOMEDA
> +	tristate "ARM Komeda display driver"
> +	depends on DRM && OF
> +	depends on COMMON_CLK
> +	select DRM_KMS_HELPER
> +	select DRM_KMS_CMA_HELPER
> +	select DRM_GEM_CMA_HELPER
> +	select VIDEOMODE_HELPERS
> +	help
> +	  Choose this option if you want to compile the ARM Komeda display
> +	  Processor driver. It supports the D71 variants of the hardware.
> +
> +	  If compiled as a module it will be called komeda.
> diff --git a/drivers/gpu/drm/arm/display/include/malidp_product.h b/drivers/gpu/drm/arm/display/include/malidp_product.h
> new file mode 100644
> index 000000000000..b35fc5db866b
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/include/malidp_product.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
> + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> + *
> + */
> +#ifndef _MALIDP_PRODUCT_H_
> +#define _MALIDP_PRODUCT_H_
> +
> +/* Product identification */
> +#define MALIDP_CORE_ID(__product, __major, __minor, __status) \
> +	((((__product) & 0xFFFF) << 16) | (((__major) & 0xF) << 12) | \
> +	(((__minor) & 0xF) << 8) | ((__status) & 0xFF))
> +
> +#define MALIDP_CORE_ID_PRODUCT_ID(__core_id) ((__u32)(__core_id) >> 16)
> +#define MALIDP_CORE_ID_MAJOR(__core_id)      (((__u32)(__core_id) >> 12) & 0xF)
> +#define MALIDP_CORE_ID_MINOR(__core_id)      (((__u32)(__core_id) >> 8) & 0xF)
> +#define MALIDP_CORE_ID_STATUS(__core_id)     (((__u32)(__core_id)) & 0xFF)
> +
> +/* Mali-display product IDs */
> +#define MALIDP_D71_PRODUCT_ID   0x0071
> +
> +#endif /* _MALIDP_PRODUCT_H_ */
> diff --git a/drivers/gpu/drm/arm/display/include/malidp_utils.h b/drivers/gpu/drm/arm/display/include/malidp_utils.h
> new file mode 100644
> index 000000000000..63cc47cefcf8
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/include/malidp_utils.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
> + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> + *
> + */
> +#ifndef _MALIDP_UTILS_
> +#define _MALIDP_UTILS_
> +
> +#define has_bit(nr, mask)	(BIT(nr) & (mask))
> +#define has_bits(bits, mask)	(((bits) & (mask)) == (bits))
> +
> +#define dp_for_each_set_bit(bit, mask) \
> +	for_each_set_bit((bit), ((unsigned long *)&(mask)), sizeof(mask) * 8)

Given that most of our registers (and masks, by extension) are 32bit, I
think it might be better to use 32 instead of sizeof(mask) * 8 as we
don't want to introduce subtle bugs in the future. And I don't think you
need the (unsigned long *) cast either.

> +
> +#endif /* _MALIDP_UTILS_ */
> diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/arm/display/komeda/Makefile
> new file mode 100644
> index 000000000000..5b44e36509b1
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/komeda/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +ccflags-y := \
> +	-I$(src)/../include \
> +	-I$(src)
> +
> +komeda-y := \
> +	komeda_dev.o \
> +	komeda_pipeline.o \
> +
> +obj-$(CONFIG_DRM_KOMEDA) += komeda.o
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> new file mode 100644
> index 000000000000..887a17005367
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
> + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> + *
> + */
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/of_device.h>
> +#include <linux/of_graph.h>
> +#include <linux/version.h>
> +#include "komeda_dev.h"
> +
> +struct komeda_dev *komeda_dev_create(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	const struct komeda_product_data *product;
> +	struct komeda_dev *mdev;
> +	struct resource *io_res;
> +	int err = 0;
> +
> +	product = of_device_get_match_data(dev);
> +	if (!product)
> +		return ERR_PTR(-ENODEV);
> +
> +	io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!io_res) {
> +		DRM_ERROR("No registers defined.\n");
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	mdev = devm_kzalloc(dev, sizeof(*mdev), GFP_KERNEL);
> +	if (!mdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mdev->dev = dev;
> +	mdev->reg_base = devm_ioremap_resource(dev, io_res);
> +	if (IS_ERR(mdev->reg_base)) {
> +		DRM_ERROR("Map register space failed.\n");
> +		err = PTR_ERR(mdev->reg_base);
> +		mdev->reg_base = NULL;
> +		goto err_cleanup;
> +	}
> +
> +	mdev->pclk = devm_clk_get(dev, "pclk");
> +	if (IS_ERR(mdev->pclk)) {
> +		DRM_ERROR("Get APB clk failed.\n");
> +		err = PTR_ERR(mdev->pclk);
> +		mdev->pclk = NULL;
> +		goto err_cleanup;
> +	}
> +
> +	/* Enable APB clock to access the registers */
> +	clk_prepare_enable(mdev->pclk);
> +
> +	mdev->funcs = product->identify(mdev->reg_base, &mdev->chip);
> +	if (!komeda_product_match(mdev, product->product_id)) {
> +		DRM_ERROR("DT configured %x mismatch with real HW %x.\n",
> +			  product->product_id,
> +			  MALIDP_CORE_ID_PRODUCT_ID(mdev->chip.core_id));
> +		err = -ENODEV;
> +		goto err_cleanup;
> +	}
> +
> +	DRM_INFO("Found ARM Mali-D%x version r%dp%d\n",
> +		 MALIDP_CORE_ID_PRODUCT_ID(mdev->chip.core_id),
> +		 MALIDP_CORE_ID_MAJOR(mdev->chip.core_id),
> +		 MALIDP_CORE_ID_MINOR(mdev->chip.core_id));
> +
> +	err = mdev->funcs->enum_resources(mdev);
> +	if (err) {
> +		DRM_ERROR("enumerate display resource failed.\n");
> +		goto err_cleanup;
> +	}
> +
> +	return mdev;
> +
> +err_cleanup:
> +	komeda_dev_destroy(mdev);
> +	return ERR_PTR(err);
> +}
> +
> +void komeda_dev_destroy(struct komeda_dev *mdev)
> +{
> +	struct device *dev = mdev->dev;
> +	struct komeda_dev_funcs *funcs = mdev->funcs;
> +	int i;
> +
> +	for (i = 0; i < mdev->n_pipelines; i++) {
> +		komeda_pipeline_destroy(mdev, mdev->pipelines[i]);
> +		mdev->pipelines[i] = NULL;
> +	}
> +
> +	mdev->n_pipelines = 0;
> +
> +	if (funcs && funcs->cleanup)
> +		funcs->cleanup(mdev);
> +
> +	if (mdev->reg_base) {
> +		devm_iounmap(dev, mdev->reg_base);
> +		mdev->reg_base = NULL;
> +	}
> +
> +	if (mdev->mclk) {
> +		devm_clk_put(dev, mdev->mclk);
> +		mdev->mclk = NULL;
> +	}
> +
> +	if (mdev->pclk) {
> +		clk_disable_unprepare(mdev->pclk);
> +		devm_clk_put(dev, mdev->pclk);
> +		mdev->pclk = NULL;
> +	}
> +
> +	devm_kfree(dev, mdev);
> +}
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> new file mode 100644
> index 000000000000..ad8fa160eff9
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -0,0 +1,98 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
> + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> + *
> + */
> +#ifndef _KOMEDA_DEV_H_
> +#define _KOMEDA_DEV_H_
> +
> +#include <linux/device.h>
> +#include <linux/interrupt.h>

You don't need this header to be included here.

> +#include "komeda_pipeline.h"
> +#include "malidp_product.h"
> +
> +/* malidp device id */
> +enum {
> +	MALI_D71 = 0,
> +};
> +
> +/* pipeline DT ports */
> +enum {
> +	KOMEDA_OF_PORT_OUTPUT		= 0,
> +	KOMEDA_OF_PORT_COPROC		= 1,
> +};
> +
> +struct komeda_chip_info {
> +	u32 arch_id;
> +	u32 core_id;
> +	u32 core_info;
> +	u32 bus_width;
> +};
> +
> +struct komeda_product_data {
> +	u32 product_id;
> +	struct komeda_dev_funcs *(*identify)(u32 __iomem *reg,
> +					     struct komeda_chip_info *info);
> +};
> +
> +struct komeda_dev;
> +
> +/**
> + * struct komeda_dev_funcs
> + *
> + * Supplied by chip level and returned by the chip entry function xxx_identify,
> + */
> +struct komeda_dev_funcs {
> +	/**
> +	 * @enum_resources:
> +	 *
> +	 * for CHIP to report or add pipeline and component resources to CORE
> +	 */
> +	int (*enum_resources)(struct komeda_dev *mdev);
> +	/** @cleanup: call to chip to cleanup komeda_dev->chip data */
> +	void (*cleanup)(struct komeda_dev *mdev);
> +};
> +
> +/**
> + * struct komeda_dev
> + *
> + * Pipeline and component are used to describe how to handle the pixel data.
> + * komeda_device is for describing the whole view of the device, and the
> + * control-abilites of device.
> + */
> +struct komeda_dev {
> +	struct device *dev;
> +	u32 __iomem   *reg_base;
> +
> +	struct komeda_chip_info chip;
> +
> +	/** @pclk: APB clock for register access */
> +	struct clk *pclk;
> +	/** @mck: HW main engine clk */
> +	struct clk *mclk;
> +
> +	int n_pipelines;
> +	struct komeda_pipeline *pipelines[KOMEDA_MAX_PIPELINES];
> +
> +	/** @funcs: chip funcs to access to HW */
> +	struct komeda_dev_funcs *funcs;
> +	/**
> +	 * @chip_data:
> +	 *
> +	 * chip data will be added by &komeda_dev_funcs.enum_resources() and
> +	 * destroyed by &komeda_dev_funcs.cleanup()
> +	 */
> +	void *chip_data;
> +};
> +
> +static inline bool
> +komeda_product_match(struct komeda_dev *mdev, u32 target)
> +{
> +	return MALIDP_CORE_ID_PRODUCT_ID(mdev->chip.core_id) == target;
> +}
> +
> +struct komeda_dev *komeda_dev_create(struct device *dev);
> +void komeda_dev_destroy(struct komeda_dev *mdev);
> +
> +#endif /*_KOMEDA_DEV_H_*/
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
> new file mode 100644
> index 000000000000..9293598b0533
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
> @@ -0,0 +1,198 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
> + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> + *
> + */
> +#include <linux/clk.h>
> +#include "komeda_dev.h"
> +#include "komeda_pipeline.h"
> +
> +/** komeda_pipeline_add - Add a pipeline to &komeda_dev */
> +struct komeda_pipeline *
> +komeda_pipeline_add(struct komeda_dev *mdev, size_t size,
> +		    struct komeda_pipeline_funcs *funcs)
> +{
> +	struct komeda_pipeline *pipe;
> +
> +	if (mdev->n_pipelines + 1 > KOMEDA_MAX_PIPELINES) {
> +		DRM_ERROR("Exceed max support %d pipelines.\n",
> +			  KOMEDA_MAX_PIPELINES);
> +		return NULL;
> +	}
> +
> +	if (size < sizeof(*pipe)) {
> +		DRM_ERROR("Request pipeline size too small.\n");
> +		return NULL;
> +	}
> +
> +	pipe = devm_kzalloc(mdev->dev, size, GFP_KERNEL);
> +	if (!pipe)
> +		return NULL;
> +
> +	pipe->mdev = mdev;
> +	pipe->id   = mdev->n_pipelines;
> +	pipe->funcs = funcs;
> +
> +	mdev->pipelines[mdev->n_pipelines] = pipe;
> +	mdev->n_pipelines++;
> +
> +	return pipe;
> +}
> +
> +void komeda_pipeline_destroy(struct komeda_dev *mdev,
> +			     struct komeda_pipeline *pipe)
> +{
> +	struct komeda_component *c;
> +	int i;
> +
> +	dp_for_each_set_bit(i, pipe->avail_comps) {
> +		c = komeda_pipeline_get_component(pipe, i);
> +

Unnecessary empty line.

> +		komeda_component_destroy(mdev, c);
> +	}
> +
> +	clk_put(pipe->pxlclk);
> +	clk_put(pipe->aclk);
> +
> +	devm_kfree(mdev->dev, pipe);
> +}
> +
> +struct komeda_component **
> +komeda_pipeline_get_component_pos(struct komeda_pipeline *pipe, int id)
> +{
> +	struct komeda_dev *mdev = pipe->mdev;
> +	struct komeda_pipeline *temp = NULL;
> +	struct komeda_component **pos = NULL;
> +
> +	switch (id) {
> +	case KOMEDA_COMPONENT_LAYER0:
> +	case KOMEDA_COMPONENT_LAYER1:
> +	case KOMEDA_COMPONENT_LAYER2:
> +	case KOMEDA_COMPONENT_LAYER3:
> +		pos = to_cpos(pipe->layers[id - KOMEDA_COMPONENT_LAYER0]);
> +		break;
> +	case KOMEDA_COMPONENT_WB_LAYER:
> +		pos = to_cpos(pipe->wb_layer);
> +		break;
> +	case KOMEDA_COMPONENT_COMPIZ0:
> +	case KOMEDA_COMPONENT_COMPIZ1:
> +		temp = mdev->pipelines[id - KOMEDA_COMPONENT_COMPIZ0];
> +		if (!temp) {
> +			DRM_ERROR("compiz-%d doesn't exist.\n", id);
> +			return NULL;
> +		}
> +		pos = to_cpos(temp->compiz);
> +		break;
> +	case KOMEDA_COMPONENT_SCALER0:
> +	case KOMEDA_COMPONENT_SCALER1:
> +		pos = to_cpos(pipe->scalers[id - KOMEDA_COMPONENT_SCALER0]);
> +		break;
> +	case KOMEDA_COMPONENT_IPS0:
> +	case KOMEDA_COMPONENT_IPS1:
> +		temp = mdev->pipelines[id - KOMEDA_COMPONENT_IPS0];
> +		if (!temp) {
> +			DRM_ERROR("ips-%d doesn't exist.\n", id);
> +			return NULL;
> +		}
> +		pos = to_cpos(temp->improc);
> +		break;
> +	case KOMEDA_COMPONENT_TIMING_CTRLR:
> +		pos = to_cpos(pipe->ctrlr);
> +		break;
> +	default:
> +		pos = NULL;
> +		DRM_ERROR("Unknown pipeline resource ID: %d.\n", id);
> +		break;
> +	}
> +
> +	return pos;
> +}
> +
> +struct komeda_component *
> +komeda_pipeline_get_component(struct komeda_pipeline *pipe, int id)
> +{
> +	struct komeda_component **pos = NULL;
> +	struct komeda_component *c = NULL;
> +
> +	pos = komeda_pipeline_get_component_pos(pipe, id);
> +	if (pos)
> +		c = *pos;
> +
> +	return c;
> +}
> +
> +/** komeda_component_add - Add a component to &komeda_pipeline */
> +struct komeda_component *
> +komeda_component_add(struct komeda_pipeline *pipe,
> +		     size_t comp_sz, u32 id, u32 hw_id,
> +		     struct komeda_component_funcs *funcs,
> +		     u8 max_active_inputs, u32 supported_inputs,
> +		     u8 max_active_outputs, u32 __iomem *reg,
> +		     const char *name_fmt, ...)
> +{
> +	struct komeda_component **pos;
> +	struct komeda_component *c;
> +	int idx, *num = NULL;
> +
> +	if (max_active_inputs > KOMEDA_COMPONENT_N_INPUTS) {
> +		WARN(1, "please large KOMEDA_COMPONENT_N_INPUTS to %d.\n",
> +		     max_active_inputs);
> +		return NULL;
> +	}
> +
> +	pos = komeda_pipeline_get_component_pos(pipe, id);
> +	if (!pos || !(*pos))
> +		return NULL;
> +
> +	if (has_bit(id, KOMEDA_PIPELINE_LAYERS)) {
> +		idx = id - KOMEDA_COMPONENT_LAYER0;
> +		num = &pipe->n_layers;
> +		if (idx != pipe->n_layers) {
> +			DRM_ERROR("please add Layer by id sequence.\n");
> +			return NULL;
> +		}
> +	} else if (has_bit(id,  KOMEDA_PIPELINE_SCALERS)) {
> +		idx = id - KOMEDA_COMPONENT_SCALER0;
> +		num = &pipe->n_scalers;
> +		if (idx != pipe->n_scalers) {
> +			DRM_ERROR("please add Scaler by id sequence.\n");
> +			return NULL;
> +		}
> +	}
> +
> +	c = devm_kzalloc(pipe->mdev->dev, comp_sz, GFP_KERNEL);
> +	if (!c)
> +		return NULL;
> +
> +	c->id = id;
> +	c->hw_id = hw_id;
> +	c->reg = reg;
> +	c->pipeline = pipe;
> +	c->max_active_inputs = max_active_inputs;
> +	c->max_active_outputs = max_active_outputs;
> +	c->supported_inputs = supported_inputs;
> +	c->funcs = funcs;
> +
> +	if (name_fmt) {
> +		va_list args;
> +
> +		va_start(args, name_fmt);
> +		vsnprintf(c->name, sizeof(c->name), name_fmt, args);
> +		va_end(args);
> +	}
> +
> +	if (num)
> +		*num = *num + 1;
> +
> +	pipe->avail_comps |= BIT(c->id);
> +	*pos = c;
> +
> +	return c;
> +}
> +
> +void komeda_component_destroy(struct komeda_dev *mdev,
> +			      struct komeda_component *c)
> +{
> +	devm_kfree(mdev->dev, c);
> +}
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> new file mode 100644
> index 000000000000..2174796d47c5
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -0,0 +1,350 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
> + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> + *
> + */
> +#ifndef _KOMEDA_PIPELINE_H_
> +#define _KOMEDA_PIPELINE_H_
> +
> +#include <linux/types.h>
> +#include <linux/of.h>
> +#include <linux/bitops.h>

of.h and bitops.h are unnecessary in this header file.

> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include "malidp_utils.h"
> +
> +#define KOMEDA_MAX_PIPELINES		2
> +#define KOMEDA_PIPELINE_MAX_LAYERS	4
> +#define KOMEDA_PIPELINE_MAX_SCALERS	2
> +#define KOMEDA_COMPONENT_N_INPUTS	5
> +
> +/* pipeline component IDs */
> +enum {
> +	KOMEDA_COMPONENT_LAYER0		= 0,
> +	KOMEDA_COMPONENT_LAYER1		= 1,
> +	KOMEDA_COMPONENT_LAYER2		= 2,
> +	KOMEDA_COMPONENT_LAYER3		= 3,
> +	KOMEDA_COMPONENT_WB_LAYER	= 7, /* write back layer */
> +	KOMEDA_COMPONENT_SCALER0	= 8,
> +	KOMEDA_COMPONENT_SCALER1	= 9,
> +	KOMEDA_COMPONENT_SPLITTER	= 12,
> +	KOMEDA_COMPONENT_MERGER		= 14,
> +	KOMEDA_COMPONENT_COMPIZ0	= 16, /* compositor */
> +	KOMEDA_COMPONENT_COMPIZ1	= 17,
> +	KOMEDA_COMPONENT_IPS0		= 20, /* post image processor */
> +	KOMEDA_COMPONENT_IPS1		= 21,
> +	KOMEDA_COMPONENT_TIMING_CTRLR	= 22, /* timing controller */
> +};
> +
> +#define KOMEDA_PIPELINE_LAYERS		(BIT(KOMEDA_COMPONENT_LAYER0) |\
> +					 BIT(KOMEDA_COMPONENT_LAYER1) |\
> +					 BIT(KOMEDA_COMPONENT_LAYER2) |\
> +					 BIT(KOMEDA_COMPONENT_LAYER3))
> +
> +#define KOMEDA_PIPELINE_SCALERS		(BIT(KOMEDA_COMPONENT_SCALER0) |\
> +					 BIT(KOMEDA_COMPONENT_SCALER1))
> +
> +#define KOMEDA_PIPELINE_COMPIZS		(BIT(KOMEDA_COMPONENT_COMPIZ0) |\
> +					 BIT(KOMEDA_COMPONENT_COMPIZ1))
> +
> +#define KOMEDA_PIPELINE_IMPROCS		(BIT(KOMEDA_COMPONENT_IPS0) |\
> +					 BIT(KOMEDA_COMPONENT_IPS1))
> +struct komeda_component;
> +struct komeda_component_state;
> +
> +/** komeda_component_funcs - component control functions */
> +struct komeda_component_funcs {
> +	/** @validate: optional,
> +	 * component may has special requirements or limitations, this function
> +	 * supply HW the ability to do the further HW specific check.
> +	 */
> +	int (*validate)(struct komeda_component *c,
> +			struct komeda_component_state *state);
> +	/** @update: update is a active update */
> +	void (*update)(struct komeda_component *c,
> +		       struct komeda_component_state *state);
> +	/** @disable: disable component */
> +	void (*disable)(struct komeda_component *c);
> +	/** @dump_register: Optional, dump registers to seq_file */
> +	void (*dump_register)(struct komeda_component *c, struct seq_file *seq);
> +};
> +
> +/**
> + * struct komeda_component
> + *
> + * struct komeda_component describe the data flow capabilities for how to link a
> + * component into the display pipeline.
> + * all specified components are subclass of this structure.
> + */
> +struct komeda_component {
> +	/** @obj: treat component as private obj */
> +	struct drm_private_obj obj;
> +	/** @pipeline: the komeda pipeline this component belongs to */
> +	struct komeda_pipeline *pipeline;
> +	/** @name: component name */
> +	char name[32];
> +	/**
> +	 * @reg:
> +	 * component register base,
> +	 * which is initialized by chip and used by chip only
> +	 */
> +	u32 __iomem *reg;
> +	/** @id: component id */
> +	u32 id;
> +	/** @hw_ic: component hw id,
> +	 *  which is initialized by chip and used by chip only
> +	 */
> +	u32 hw_id;
> +
> +	/**
> +	 * @max_active_inputs:
> +	 * @max_active_outpus:
> +	 *
> +	 * maximum number of inputs/outputs that can be active in the same time
> +	 * Note:
> +	 * the number isn't the bit number of @supported_inputs or
> +	 * @supported_outputs, but may be less than it, since component may not
> +	 * support enabling all @supported_inputs/outputs at the same time.
> +	 */
> +	u8 max_active_inputs;
> +	u8 max_active_outputs;
> +	/**
> +	 * @supported_inputs:
> +	 * @supported_outputs:
> +	 *
> +	 * bitmask of BIT(component->id) for the supported inputs/outputs
> +	 * describes the possibilities of how a component is linked into a
> +	 * pipeline.
> +	 */
> +	u32 supported_inputs;
> +	u32 supported_outputs;
> +
> +	/**
> +	 * @funcs: chip functions to access HW
> +	 */
> +	struct komeda_component_funcs *funcs;
> +};
> +
> +/**
> + * struct komeda_component_output
> + *
> + * a component has multiple outputs, if want to know where the data
> + * comes from, only know the component is not enough, we still need to know
> + * its output port
> + */
> +struct komeda_component_output {
> +	/** @component: indicate which component the data comes from */
> +	struct komeda_component *component;
> +	/** @output_port:
> +	 * the output port of the &komeda_component_output.component
> +	 */
> +	u8 output_port;
> +};
> +
> +/**
> + * struct komeda_component_state
> + *
> + * component_state is the data flow configuration of the component, and it's
> + * the superclass of all specific component_state like @komeda_layer_state,
> + * @komeda_scaler_state
> + */
> +struct komeda_component_state {
> +	/** @obj: tracking component_state by drm_atomic_state */
> +	struct drm_private_state obj;
> +	struct komeda_component *component;
> +	/**
> +	 * @binding_user:
> +	 * currently bound user, the user can be crtc/plane/wb_conn, which is
> +	 * valid decided by @component and @inputs
> +	 *
> +	 * -  Layer: its user always is plane.
> +	 * -  compiz/improc/timing_ctrlr: the user is crtc.
> +	 * -  wb_layer: wb_conn;
> +	 * -  scaler: plane when input is layer, wb_conn if input is compiz.
> +	 */
> +	union {
> +		struct drm_crtc *crtc;
> +		struct drm_plane *plane;
> +		struct drm_connector *wb_conn;
> +		void *binding_user;
> +	};
> +	/**
> +	 * @active_inputs:
> +	 *
> +	 * active_inputs is bitmask of @inputs index
> +	 *
> +	 * -  active_inputs = changed_active_inputs + unchanged_active_inputs
> +	 * -  affected_inputs = old->active_inputs + new->active_inputs;
> +	 * -  disabling_inputs = affected_inputs ^ active_inputs;
> +	 * -  changed_inputs = disabling_inputs + changed_active_inputs;
> +	 *
> +	 * NOTE:
> +	 * changed_inputs doesn't include all active_input but only
> +	 * @changed_active_inputs, and this bitmask can be used in chip
> +	 * level for dirty update.
> +	 */
> +	u16 active_inputs;
> +	u16 changed_active_inputs;
> +	u16 affected_inputs;
> +	/**
> +	 * @inputs:
> +	 *
> +	 * the specific inputs[i] only valid on BIT(i) has been set in
> +	 * @active_inputs, if not the inputs[i] is undefined.
> +	 */
> +	struct komeda_component_output inputs[KOMEDA_COMPONENT_N_INPUTS];
> +};
> +
> +static inline u16 component_disabling_inputs(struct komeda_component_state *st)
> +{
> +	return st->affected_inputs ^ st->active_inputs;
> +}
> +
> +static inline u16 component_changed_inputs(struct komeda_component_state *st)
> +{
> +	return component_disabling_inputs(st) | st->changed_active_inputs;
> +}
> +
> +#define to_comp(__c)	(((__c) == NULL) ? NULL : &((__c)->base))
> +#define to_cpos(__c)	((struct komeda_component **)&(__c))
> +
> +/* these structures are going to be filled in in uture patches */
> +struct komeda_layer {
> +	struct komeda_component base;
> +	/* layer specific features and caps */
> +};
> +
> +struct komeda_layer_state {
> +	struct komeda_component_state base;
> +	/* layer specific configuration state */
> +};
> +
> +struct komeda_compiz {
> +	struct komeda_component base;
> +	/* compiz specific features and caps */
> +};
> +
> +struct komeda_compiz_state {
> +	struct komeda_component_state base;
> +	/* compiz specific configuration state */
> +};
> +
> +struct komeda_scaler {
> +	struct komeda_component base;
> +	/* scaler features and caps */
> +};
> +
> +struct komeda_scaler_state {
> +	struct komeda_component_state base;
> +};
> +
> +struct komeda_improc {
> +	struct komeda_component base;
> +};
> +
> +struct komeda_improc_state {
> +	struct komeda_component_state base;
> +};
> +
> +/* display timing controller */
> +struct komeda_timing_ctrlr {
> +	struct komeda_component base;
> +};
> +
> +struct komeda_timing_ctrlr_state {
> +	struct komeda_component_state base;
> +};
> +
> +/** struct komeda_pipeline_funcs */
> +struct komeda_pipeline_funcs {
> +	/* dump_register: Optional, dump registers to seq_file */
> +	void (*dump_register)(struct komeda_pipeline *pipe,
> +			      struct seq_file *sf);
> +};
> +
> +/**
> + * struct komeda_pipeline
> + *
> + * Represent a complete display pipeline and hold all functional components.
> + */
> +struct komeda_pipeline {
> +	/** @obj: link pipeline as private obj of drm_atomic_state */
> +	struct drm_private_obj obj;
> +	/** @mdev: the parent komeda_dev */
> +	struct komeda_dev *mdev;
> +	/** @pxlclk: pixel clock */
> +	struct clk *pxlclk;
> +	/** @aclk: AXI clock */
> +	struct clk *aclk;
> +	/** @id: pipeline id */
> +	int id;
> +	/** @avail_comps: available components mask of pipeline */
> +	u32 avail_comps;
> +	int n_layers;
> +	struct komeda_layer *layers[KOMEDA_PIPELINE_MAX_LAYERS];
> +	int n_scalers;
> +	struct komeda_scaler *scalers[KOMEDA_PIPELINE_MAX_SCALERS];
> +	struct komeda_compiz *compiz;
> +	struct komeda_layer  *wb_layer;
> +	struct komeda_improc *improc;
> +	struct komeda_timing_ctrlr *ctrlr;
> +	struct komeda_pipeline_funcs *funcs; /* private pipeline functions */
> +};
> +
> +/**
> + * struct komeda_pipeline_state
> + *
> + * NOTE:
> + * Unlike the pipeline, pipeline_state doesn’t gather any component_state
> + * into it. It because all component will be managed by drm_atomic_state.
> + */
> +struct komeda_pipeline_state {
> +	/** @obj: tracking pipeline_state by drm_atomic_state */
> +	struct drm_private_state obj;
> +	struct komeda_pipeline *pipe;
> +	/** @crtc: currently bound crtc */
> +	struct drm_crtc *crtc;
> +	/**
> +	 * @active_comps:
> +	 *
> +	 * bitmask - BIT(component->id) of active components
> +	 */
> +	u32 active_comps;
> +};
> +
> +#define to_layer(c)	container_of(c, struct komeda_layer, base)
> +#define to_compiz(c)	container_of(c, struct komeda_compiz, base)
> +#define to_scaler(c)	container_of(c, struct komeda_scaler, base)
> +#define to_improc(c)	container_of(c, struct komeda_improc, base)
> +#define to_ctrlr(c)	container_of(c, struct komeda_timing_ctrlr, base)
> +
> +#define to_layer_st(c)	container_of(c, struct komeda_layer_state, base)
> +#define to_compiz_st(c)	container_of(c, struct komeda_compiz_state, base)
> +#define to_scaler_st(c) container_of(c, struct komeda_scaler_state, base)
> +#define to_improc_st(c)	container_of(c, struct komeda_improc_state, base)
> +#define to_ctrlr_st(c)	container_of(c, struct komeda_timing_ctrlr_state, base)
> +
> +/* pipeline APIs */
> +struct komeda_pipeline *
> +komeda_pipeline_add(struct komeda_dev *mdev, size_t size,
> +		    struct komeda_pipeline_funcs *funcs);
> +void komeda_pipeline_destroy(struct komeda_dev *mdev,
> +			     struct komeda_pipeline *pipe);
> +
> +struct komeda_component *
> +komeda_pipeline_get_component(struct komeda_pipeline *pipe, int id);
> +
> +/* component APIs */
> +struct komeda_component *
> +komeda_component_add(struct komeda_pipeline *pipe,
> +		     size_t comp_sz, u32 id, u32 hw_id,
> +		     struct komeda_component_funcs *funcs,
> +		     u8 max_active_inputs, u32 supported_inputs,
> +		     u8 max_active_outputs, u32 __iomem *reg,
> +		     const char *name_fmt, ...);
> +
> +void komeda_component_destroy(struct komeda_dev *mdev,
> +			      struct komeda_component *c);
> +
> +#endif /* _KOMEDA_PIPELINE_H_*/
> -- 
> 2.17.1
> 

With these small changes:

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu


-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
