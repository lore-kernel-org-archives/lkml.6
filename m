Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641E6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C11218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbeLXMCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 07:02:19 -0500
Received: from foss.arm.com ([217.140.101.70]:58078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbeLXMCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 07:02:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0036A80D;
        Mon, 24 Dec 2018 04:02:18 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E0623F718;
        Mon, 24 Dec 2018 04:02:17 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 069C9680369; Mon, 24 Dec 2018 12:02:16 +0000 (GMT)
Date:   Mon, 24 Dec 2018 12:02:15 +0000
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
Subject: Re: [PATCH v3 3/9] drm/komeda: Build komeda to be a platform module
Message-ID: <20181224120215.GE22341@e110455-lin.cambridge.arm.com>
References: <20181221095757.15510-1-james.qian.wang@arm.com>
 <20181221095757.15510-4-james.qian.wang@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181221095757.15510-4-james.qian.wang@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 09:59:28AM +0000, james qian wang (Arm Technology China) wrote:
> Implement a simple wrapper for platform module to build komeda to module,
> Also add a very simple D71 layer code to show how to discover a product.
> Komeda driver direct bind the product ENTRY function xxx_identity to DT
> compatible name like:
> 
> d71_product = {
> 	.product_id = MALIDP_D71_PRODUCT_ID,
> 	.identify = d71_identify,
> },
> 
> const struct of_device_id komeda_of_match[] = {
> 	{ .compatible = "arm,mali-d71", .data = &d71_product, },
> 	{},
> };
> 
> Then when linux found a matched DT node and call driver to probe, we can
> easily get the of data, and call into the product to do the identify:
> 
> komeda_bind()
> {
>     ...
>     product = of_device_get_match_data(dev);
> 
>     product->identify();
>     ...
> }
> 
> Changes in v3:
> - Fixed style problem found by checkpatch.pl --strict.
> 
> Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  .../gpu/drm/arm/display/include/malidp_io.h   |  42 ++++++
>  drivers/gpu/drm/arm/display/komeda/Makefile   |   6 +-
>  .../gpu/drm/arm/display/komeda/d71/d71_dev.c  |  33 +++++
>  .../gpu/drm/arm/display/komeda/komeda_dev.h   |   3 +
>  .../gpu/drm/arm/display/komeda/komeda_drv.c   | 132 ++++++++++++++++++
>  5 files changed, 215 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/arm/display/include/malidp_io.h
>  create mode 100644 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
>  create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> 
> diff --git a/drivers/gpu/drm/arm/display/include/malidp_io.h b/drivers/gpu/drm/arm/display/include/malidp_io.h
> new file mode 100644
> index 000000000000..4fb3caf864ce
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/include/malidp_io.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
> + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> + *
> + */
> +#ifndef _MALIDP_IO_H_
> +#define _MALIDP_IO_H_
> +
> +#include <linux/io.h>
> +
> +static inline u32
> +malidp_read32(u32 __iomem *base, u32 offset)
> +{
> +	return readl((base + (offset >> 2)));
> +}
> +
> +static inline void
> +malidp_write32(u32 __iomem *base, u32 offset, u32 v)
> +{
> +	writel(v, (base + (offset >> 2)));
> +}
> +
> +static inline void
> +malidp_write32_mask(u32 __iomem *base, u32 offset, u32 m, u32 v)
> +{
> +	u32 tmp = malidp_read32(base, offset);
> +
> +	tmp &= (~m);
> +	malidp_write32(base, offset, v | tmp);
> +}
> +
> +static inline void
> +malidp_write_group(u32 __iomem *base, u32 offset, int num, const u32 *values)
> +{
> +	int i;
> +
> +	for (i = 0; i < num; i++)
> +		malidp_write32(base, offset + i * 4, values[i]);
> +}
> +
> +#endif /*_MALIDP_IO_H_*/
> diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/arm/display/komeda/Makefile
> index 5b44e36509b1..c03d6876ef75 100644
> --- a/drivers/gpu/drm/arm/display/komeda/Makefile
> +++ b/drivers/gpu/drm/arm/display/komeda/Makefile
> @@ -5,7 +5,11 @@ ccflags-y := \
>  	-I$(src)
>  
>  komeda-y := \
> +	komeda_drv.o \
>  	komeda_dev.o \
> -	komeda_pipeline.o \
> +	komeda_pipeline.o
> +
> +komeda-y += \
> +	d71/d71_dev.o
>  
>  obj-$(CONFIG_DRM_KOMEDA) += komeda.o
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> new file mode 100644
> index 000000000000..af3dabb499cd
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
> + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> + *
> + */
> +#include "malidp_io.h"
> +#include "komeda_dev.h"
> +
> +static int d71_enum_resources(struct komeda_dev *mdev)
> +{
> +	/* TODO add enum resources */
> +	return -1;
> +}
> +
> +static struct komeda_dev_funcs d71_chip_funcs = {
> +	.enum_resources	= d71_enum_resources,
> +	.cleanup	= NULL,
> +};
> +
> +#define GLB_ARCH_ID		0x000
> +#define GLB_CORE_ID		0x004
> +#define GLB_CORE_INFO		0x008
> +
> +struct komeda_dev_funcs *
> +d71_identify(u32 __iomem *reg_base, struct komeda_chip_info *chip)
> +{
> +	chip->arch_id	= malidp_read32(reg_base, GLB_ARCH_ID);
> +	chip->core_id	= malidp_read32(reg_base, GLB_CORE_ID);
> +	chip->core_info	= malidp_read32(reg_base, GLB_CORE_INFO);
> +
> +	return &d71_chip_funcs;
> +}
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> index ad8fa160eff9..680e3e2cf100 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -92,6 +92,9 @@ komeda_product_match(struct komeda_dev *mdev, u32 target)
>  	return MALIDP_CORE_ID_PRODUCT_ID(mdev->chip.core_id) == target;
>  }
>  
> +struct komeda_dev_funcs *
> +d71_identify(u32 __iomem *reg, struct komeda_chip_info *chip);
> +
>  struct komeda_dev *komeda_dev_create(struct device *dev);
>  void komeda_dev_destroy(struct komeda_dev *mdev);
>  
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> new file mode 100644
> index 000000000000..a2657b3d09d7
> --- /dev/null
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
> + * Author: James.Qian.Wang <james.qian.wang@arm.com>
> + *
> + */
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/component.h>
> +#include <drm/drm_of.h>
> +#include "komeda_dev.h"
> +
> +struct komeda_drv {
> +	struct komeda_dev *mdev;
> +};
> +
> +static void komeda_unbind(struct device *dev)
> +{
> +	struct komeda_drv *mdrv = dev_get_drvdata(dev);
> +
> +	dev_set_drvdata(dev, NULL);
> +
> +	if (!mdrv)
> +		return;
> +
> +	komeda_dev_destroy(mdrv->mdev);
> +	kfree(mdrv);
> +}
> +
> +static int komeda_bind(struct device *dev)
> +{
> +	struct komeda_drv *mdrv;
> +	int err;
> +
> +	mdrv = kzalloc(sizeof(*mdrv), GFP_KERNEL);
> +	if (!mdrv)
> +		return -ENOMEM;
> +
> +	mdrv->mdev = komeda_dev_create(dev);
> +	if (IS_ERR(mdrv->mdev)) {
> +		err = PTR_ERR(mdrv->mdev);
> +		goto free_mdrv;
> +	}
> +
> +	dev_set_drvdata(dev, mdrv);
> +
> +	return 0;
> +
> +free_mdrv:
> +	kfree(mdrv);
> +	return err;
> +}
> +
> +static const struct component_master_ops komeda_master_ops = {
> +	.bind	= komeda_bind,
> +	.unbind	= komeda_unbind,
> +};
> +
> +static int compare_of(struct device *dev, void *data)
> +{
> +	return dev->of_node == data;
> +}
> +
> +static void komeda_add_slave(struct device *master,
> +			     struct component_match **match,
> +			     struct device_node *np, int port)
> +{
> +	struct device_node *remote;
> +
> +	remote = of_graph_get_remote_node(np, port, 0);
> +	if (!remote) {
> +		drm_of_component_match_add(master, match, compare_of, remote);
> +		of_node_put(remote);
> +	}
> +}
> +
> +static int komeda_platform_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct component_match *match = NULL;
> +	struct device_node *child;
> +
> +	if (!dev->of_node)
> +		return -ENODEV;
> +
> +	for_each_available_child_of_node(dev->of_node, child) {
> +		if (of_node_cmp(child->name, "pipeline") != 0)
> +			continue;
> +
> +		/* add connector */
> +		komeda_add_slave(dev, &match, child, KOMEDA_OF_PORT_OUTPUT);
> +	}
> +
> +	return component_master_add_with_match(dev, &komeda_master_ops, match);
> +}
> +
> +static int komeda_platform_remove(struct platform_device *pdev)
> +{
> +	component_master_del(&pdev->dev, &komeda_master_ops);
> +	return 0;
> +}
> +
> +static const struct komeda_product_data komeda_products[] = {
> +	[MALI_D71] = {
> +		.product_id = MALIDP_D71_PRODUCT_ID,
> +		.identify = d71_identify,
> +	},
> +};
> +
> +const struct of_device_id komeda_of_match[] = {
> +	{ .compatible = "arm,mali-d71", .data = &komeda_products[MALI_D71], },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, komeda_of_match);
> +
> +static struct platform_driver komeda_platform_driver = {
> +	.probe	= komeda_platform_probe,
> +	.remove	= komeda_platform_remove,
> +	.driver	= {
> +		.name = "komeda",
> +		.of_match_table	= komeda_of_match,
> +		.pm = NULL,
> +	},
> +};
> +
> +module_platform_driver(komeda_platform_driver);
> +
> +MODULE_AUTHOR("James.Qian.Wang <james.qian.wang@arm.com>");
> +MODULE_DESCRIPTION("Komeda KMS driver");
> +MODULE_LICENSE("GPL v2");
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
