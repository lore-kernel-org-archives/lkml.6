Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797C5C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA87214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CEYiAAwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbfBDPd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:33:26 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33554 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfBDPd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:33:26 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x14FWU5Z063794;
        Mon, 4 Feb 2019 09:32:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549294350;
        bh=C5FnMWzzJJxzI5Q5I0ycsAON557wn8HGJJK4WRgRuWs=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=CEYiAAwoiolKCJsBn5Nd79eIiT5fiJnYLGUfxJTRs/EJYPCA4XxKKNKaAvc21bOF1
         PwVOfQT5HpWpg4KMWy0uhhqyAe1lLCmZeJ/+J0zgJ/GxxciiqVicnZIOOEOQVzoS1/
         NCkp1hUxjcyG74W+xuD3zEPnHSML2BijDKgr8rhI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x14FWUUs126775
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 09:32:30 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Feb 2019 09:32:29 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Feb 2019 09:32:29 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x14FWPsa022526;
        Mon, 4 Feb 2019 09:32:26 -0600
Subject: Re: [PATCH v2 02/14] soc: ti: pruss: Add a platform driver for PRUSS
 in TI SoCs
To:     "Andrew F. Davis" <afd@ti.com>, <tony@atomide.com>,
        <ohad@wizery.com>, <bjorn.andersson@linaro.org>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-3-git-send-email-rogerq@ti.com>
 <99a3717c-7eab-07d2-e73e-f302c3848b8a@ti.com>
CC:     <s-anna@ti.com>, <david@lechnology.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Keerthy <j-keerthy@ti.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C585B09.2010505@ti.com>
Date:   Mon, 4 Feb 2019 17:32:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <99a3717c-7eab-07d2-e73e-f302c3848b8a@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/19 16:52, Andrew F. Davis wrote:
> On 2/4/19 8:22 AM, Roger Quadros wrote:
>> From: Suman Anna <s-anna@ti.com>
>>
>> The Programmable Real-Time Unit - Industrial Communication
>> Subsystem (PRU-ICSS) is present on various TI SoCs such as
>> AM335x or AM437x or the Keystone 66AK2G. Each SoC can have
>> one or more PRUSS instances that may or may not be identical.
>> For example, AM335x SoCs have a single PRUSS, while AM437x has
>> two PRUSS instances PRUSS1 and PRUSS0, with the PRUSS0 being
>> a cut-down version of the PRUSS1.
>>
>> The PRUSS consists of dual 32-bit RISC cores called the
>> Programmable Real-Time Units (PRUs), with data and
>> instruction memories. It also contains various sub-modules
>> like MDIO, MII_RT, UART, etc. Each sub-module will be driven
>> by it's own driver.
>>
>> This PRUSS platform driver deals with the overall PRUSS and is
>> used for managing the subsystem level resources like various
>> memories and common CFG module. It is responsible for the
>> creation and deletion of the platform devices for the child PRU
>> devices and the various sub-modules.
>>
>> This design provides flexibility in representing the different
>> modules of PRUSS accordingly, and at the same time allowing the
>> PRUSS driver to add some instance specific configuration within
>> an SoC.
>>
>> pruss_get() and pruss_put() APIs allow client drivers to request
>> the 'struct pruss) device handle from the 'struct rproc' handle
> 
>                    ) -> '
> 
>> for the respective PRU. This handle will be used by client drivers
>> to request various operations of the PRUSS platform driver through
>> below APIs.
>>
>> pruss_request_mem_region() & pruss_release_mem_region() allow
>> client drivers to acquire and release the common memory resources
>> present within a PRU-ICSS subsystem. This allows the client drivers
>> to directly manipulate the respective memories,
>> as per their design contract with the associated firmware.
>>
>> pruss_cfg_read() and pruss_cfg_update() allow other drivers to read
>> and update the registers in the CFG submodule within the PRUSS.
>> This interface provides a simple way for client drivers
>> without having them to include and parse these syscon nodes within
>> their respective device nodes.
>>
>> pruss_cfg_miirt_enable() and pruss_cfg_xfr_enable() allow the
>> client drivers to set MII_RT event enable/disable and
>> XFR (XIN XOUT) enable/disable respectively.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/soc/ti/Kconfig  |  12 ++
>>  drivers/soc/ti/Makefile |   1 +
>>  drivers/soc/ti/pruss.c  | 347 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/pruss.h   | 211 +++++++++++++++++++++++++++++
>>  4 files changed, 571 insertions(+)
>>  create mode 100644 drivers/soc/ti/pruss.c
>>  create mode 100644 include/linux/pruss.h
>>
>> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
>> index be4570b..789f2a8 100644
>> --- a/drivers/soc/ti/Kconfig
>> +++ b/drivers/soc/ti/Kconfig
>> @@ -73,4 +73,16 @@ config TI_SCI_PM_DOMAINS
>>  	  called ti_sci_pm_domains. Note this is needed early in boot before
>>  	  rootfs may be available.
>>  
>> +config TI_PRUSS
>> +	tristate "TI PRU-ICSS Subsystem Platform drivers"
>> +	depends on SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX
>> +	select MFD_SYSCON
>> +	default n
>> +	help
>> +	  TI PRU-ICSS Subsystem platform specific support.
>> +
>> +	  Say Y or M here to support the Programmable Realtime Unit (PRU)
>> +	  processors on various TI SoCs. It's safe to say N here if you're
>> +	  not interested in the PRU or if you are unsure.
>> +
>>  endif # SOC_TI
>> diff --git a/drivers/soc/ti/Makefile b/drivers/soc/ti/Makefile
>> index a22edc0..55b4b04 100644
>> --- a/drivers/soc/ti/Makefile
>> +++ b/drivers/soc/ti/Makefile
>> @@ -8,3 +8,4 @@ obj-$(CONFIG_KEYSTONE_NAVIGATOR_DMA)	+= knav_dma.o
>>  obj-$(CONFIG_AMX3_PM)			+= pm33xx.o
>>  obj-$(CONFIG_WKUP_M3_IPC)		+= wkup_m3_ipc.o
>>  obj-$(CONFIG_TI_SCI_PM_DOMAINS)		+= ti_sci_pm_domains.o
>> +obj-$(CONFIG_TI_PRUSS)			+= pruss.o
>> diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
>> new file mode 100644
>> index 0000000..c9493983
>> --- /dev/null
>> +++ b/drivers/soc/ti/pruss.c
>> @@ -0,0 +1,347 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * PRU-ICSS platform driver for various TI SoCs
>> + *
>> + * Copyright (C) 2014-2019 Texas Instruments Incorporated - http://www.ti.com/
>> + *	Suman Anna <s-anna@ti.com>
>> + *	Andrew F. Davis <afd@ti.com>
>> + */
>> +
>> +#include <linux/dma-mapping.h>
>> +#include <linux/module.h>
>> +#include <linux/io.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +#include <linux/pruss.h>
>> +#include <linux/regmap.h>
>> +#include <linux/remoteproc.h>
>> +
>> +/**
>> + * struct pruss - PRUSS parent structure
>> + * @dev: pruss device pointer
>> + * @cfg: regmap for config region
>> + * @mem_regions: data for each of the PRUSS memory regions
>> + * @mem_in_use: to indicate if memory resource is in use
>> + * @no_shared_ram: indicate that shared RAM is absent
>> + * @lock: mutex to serialize access to resources
>> + */
>> +struct pruss {
>> +	struct device *dev;
>> +	struct regmap *cfg;
>> +	struct pruss_mem_region mem_regions[PRUSS_MEM_MAX];
>> +	struct pruss_mem_region *mem_in_use[PRUSS_MEM_MAX];
>> +	bool no_shared_ram;
>> +	struct mutex lock; /* PRU resource lock */
>> +};
>> +
>> +/**
>> + * pruss_get() - get the pruss for a given PRU remoteproc
>> + * @rproc: remoteproc handle of a PRU instance
>> + *
>> + * Finds the parent pruss device for a PRU given the @rproc handle of the
>> + * PRU remote processor. This function increments the pruss device's refcount,
>> + * so always use pruss_put() to decrement it back once pruss isn't needed
>> + * anymore.
>> + *
>> + * Returns the pruss handle on success, and an ERR_PTR on failure using one
>> + * of the following error values
>> + *    -EINVAL if invalid parameter
>> + *    -ENODEV if PRU device or PRUSS device is not found
>> + */
>> +struct pruss *pruss_get(struct rproc *rproc)
>> +{
>> +	struct pruss *pruss;
>> +	struct device *dev;
>> +	struct platform_device *ppdev;
>> +
>> +	if (IS_ERR(rproc))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	dev = &rproc->dev;
>> +	if (!dev->parent)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	/* rudimentary check to make sure rproc handle is for a PRU */
>> +	if (!strstr(dev_name(dev->parent), "pru"))
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	ppdev = to_platform_device(dev->parent->parent);
>> +	pruss = platform_get_drvdata(ppdev);
>> +	if (pruss)
>> +		get_device(pruss->dev);
>> +
>> +	return pruss ? pruss : ERR_PTR(-ENODEV);
>> +}
>> +EXPORT_SYMBOL_GPL(pruss_get);
>> +
>> +/**
>> + * pruss_put() - decrement pruss device's usecount
>> + * @pruss: pruss handle
>> + *
>> + * Complimentary function for pruss_get(). Needs to be called
>> + * after the PRUSS is used, and only if the pruss_get() succeeds.
>> + */
>> +void pruss_put(struct pruss *pruss)
>> +{
>> +	if (IS_ERR(pruss))
>> +		return;
>> +
>> +	put_device(pruss->dev);
>> +}
>> +EXPORT_SYMBOL_GPL(pruss_put);
>> +
>> +/**
>> + * pruss_request_mem_region() - request a memory resource
>> + * @pruss: the pruss instance
>> + * @mem_id: the memory resource id
>> + * @region: pointer to memory region structure to be filled in
>> + *
>> + * This function allows a client driver to request a memory resource,
>> + * and if successful, will let the client driver own the particular
>> + * memory region until released using the pruss_release_mem_region()
>> + * API.
>> + *
>> + * Returns the memory region if requested resource is available, an
>> + * error otherwise
>> + */
>> +int pruss_request_mem_region(struct pruss *pruss, enum pruss_mem mem_id,
>> +			     struct pruss_mem_region *region)
>> +{
>> +	if (IS_ERR(pruss) || !region)
>> +		return -EINVAL;
>> +
>> +	if (mem_id >= PRUSS_MEM_MAX)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&pruss->lock);
>> +
>> +	if (pruss->mem_in_use[mem_id]) {
>> +		mutex_unlock(&pruss->lock);
>> +		return -EBUSY;
>> +	}
>> +
>> +	*region = pruss->mem_regions[mem_id];
>> +	pruss->mem_in_use[mem_id] = region;
>> +
>> +	mutex_unlock(&pruss->lock);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pruss_request_mem_region);
>> +
>> +/**
>> + * pruss_release_mem_region() - release a memory resource
>> + * @pruss: the pruss instance
>> + * @region: the memory region to release
>> + *
>> + * This function is the complimentary function to
>> + * pruss_request_mem_region(), and allows the client drivers to
>> + * release back a memory resource.
>> + *
>> + * Returns 0 on success, an error code otherwise
>> + */
>> +int pruss_release_mem_region(struct pruss *pruss,
>> +			     struct pruss_mem_region *region)
>> +{
>> +	int id;
>> +
>> +	if (IS_ERR(pruss) || !region)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&pruss->lock);
>> +
>> +	/* find out the memory region being released */
>> +	for (id = 0; id < PRUSS_MEM_MAX; id++) {
>> +		if (pruss->mem_in_use[id] == region)
>> +			break;
>> +	}
>> +
>> +	if (id == PRUSS_MEM_MAX) {
>> +		mutex_unlock(&pruss->lock);
>> +		return -EINVAL;
>> +	}
>> +
>> +	pruss->mem_in_use[id] = NULL;
>> +
>> +	mutex_unlock(&pruss->lock);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pruss_release_mem_region);
>> +
>> +/**
>> + * pruss_cfg_read() - read a PRUSS CFG register
>> + * @pruss: the pruss instance handle
>> + * @reg: register offset within the CFG sub-module
>> + * @val: pointer to return the value in
>> + *
>> + * Reads a given register within CFG module of PRUSS
>> + * and returns it through the passed-in @val pointer
>> + *
>> + * Returns 0 on success, or an error code otherwise
>> + */
>> +int pruss_cfg_read(struct pruss *pruss, unsigned int reg, unsigned int *val)
>> +{
>> +	if (IS_ERR(pruss))
>> +		return -EINVAL;
>> +
>> +	return regmap_read(pruss->cfg, reg, val);
>> +}
>> +EXPORT_SYMBOL_GPL(pruss_cfg_read);
>> +
>> +/**
>> + * pruss_cfg_update() - update a PRUSS CFG register
>> + * @pruss: the pruss instance handle
>> + * @reg: register offset within the CFG sub-module
>> + * @mask: bit mask to use for programming the @val
>> + * @val: value to write
>> + *
>> + * Updates a given register within CFG sub-module of PRUSS
>> + *
>> + * Returns 0 on success, or an error code otherwise
>> + */
>> +int pruss_cfg_update(struct pruss *pruss, unsigned int reg,
>> +		     unsigned int mask, unsigned int val)
>> +{
>> +	if (IS_ERR(pruss))
>> +		return -EINVAL;
>> +
>> +	return regmap_update_bits(pruss->cfg, reg, mask, val);
>> +}
>> +EXPORT_SYMBOL_GPL(pruss_cfg_update);
>> +
>> +/**
>> + * struct pruss_match_private_data - private data to handle multiple instances
>> + * @device_name: device name of the PRUSS instance
>> + * @priv_data: PRUSS driver private data for this PRUSS instance
>> + */
>> +struct pruss_match_private_data {
>> +	const char *device_name;
>> +	const struct pruss_private_data *priv_data;
>> +};
>> +
>> +static const
>> +struct pruss_private_data *pruss_get_private_data(struct platform_device *pdev)
>> +{
>> +	const struct pruss_match_private_data *data;
>> +
>> +	if (!of_device_is_compatible(pdev->dev.of_node, "ti,am4376-pruss"))
>> +		return NULL;
> 
> Been a while since I worked with all this, so refresh my memory, this
> was only so we could pull in the "shared RAM only on one PRUSS instance
> on am4376" quirk, right? If so it looks like this is now done with a DT
> flag. All this private_data stuff can now be dropped.

Good catch.
> 
>> +
>> +	data = of_device_get_match_data(&pdev->dev);
>> +	for (; data && data->device_name; data++) {
>> +		if (!strcmp(dev_name(&pdev->dev), data->device_name))
>> +			return data->priv_data;
>> +	}
>> +
>> +	return ERR_PTR(-ENODEV);
>> +}
>> +
>> +static int pruss_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *node = dev->of_node;
>> +	struct device_node *np;
>> +	struct pruss *pruss;
>> +	struct resource *res;
>> +	int ret, i;
>> +	const struct pruss_private_data *data;
>> +	const char *mem_names[PRUSS_MEM_MAX] = { "dram0", "dram1", "shrdram2" };
>> +
>> +	if (!node) {
>> +		dev_err(dev, "Non-DT platform device not supported\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	data = pruss_get_private_data(pdev);
>> +	if (IS_ERR(data)) {
>> +		dev_err(dev, "missing private data\n");
>> +		return -ENODEV;
>> +	}
> 
> Above gets dropped.

Yes.

> 
>> +
>> +	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>> +	if (ret) {
>> +		dev_err(dev, "dma_set_coherent_mask: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	pruss = devm_kzalloc(dev, sizeof(*pruss), GFP_KERNEL);
>> +	if (!pruss)
>> +		return -ENOMEM;
>> +
>> +	pruss->dev = dev;
>> +	mutex_init(&pruss->lock);
>> +
>> +	pruss->no_shared_ram = of_property_read_bool(node, "no-shared-ram");
>> +
>> +	np = of_get_child_by_name(node, "cfg");
>> +	if (!np)
>> +		return -ENODEV;
>> +
>> +	pruss->cfg = syscon_node_to_regmap(np);
>> +	of_node_put(np);
>> +	if (IS_ERR(pruss->cfg))
>> +		return -ENODEV;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(mem_names); i++) {
>> +		if (pruss->no_shared_ram && !strcmp(mem_names[i], "shrdram2"))
>> +			continue;
>> +
>> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> +						   mem_names[i]);
>> +		pruss->mem_regions[i].va = devm_ioremap_resource(dev, res);
>> +		if (!pruss->mem_regions[i].va) {
>> +			dev_err(dev, "failed to get resource: %s\n",
>> +				mem_names[i]);
>> +			return -ENODEV;
>> +		}
>> +		pruss->mem_regions[i].pa = res->start;
>> +		pruss->mem_regions[i].size = resource_size(res);
>> +
>> +		dev_dbg(dev, "memory %8s: pa %pa size 0x%zx va %p\n",
>> +			mem_names[i], &pruss->mem_regions[i].pa,
>> +			pruss->mem_regions[i].size, pruss->mem_regions[i].va);
>> +	}
>> +
>> +	platform_set_drvdata(pdev, pruss);
>> +
>> +	dev_info(&pdev->dev, "creating PRU cores and other child platform devices\n");
>> +	ret = of_platform_populate(node, NULL, NULL, &pdev->dev);
>> +	if (ret)
>> +		dev_err(dev, "of_platform_populate failed\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static int pruss_remove(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +
>> +	dev_info(dev, "remove PRU cores and other child platform devices\n");
>> +	of_platform_depopulate(dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id pruss_of_match[] = {
>> +	{ .compatible = "ti,am3356-pruss", },
>> +	{ .compatible = "ti,am4376-pruss", },
>> +	{ .compatible = "ti,am5728-pruss", },
> 
> ti,k2g-pruss ?

Will add.


cheers,
-roger

> 
> Andrew
> 
>> +	{ /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, pruss_of_match);
>> +
>> +static struct platform_driver pruss_driver = {
>> +	.driver = {
>> +		.name = "pruss",
>> +		.of_match_table = pruss_of_match,
>> +	},
>> +	.probe  = pruss_probe,
>> +	.remove = pruss_remove,
>> +};
>> +module_platform_driver(pruss_driver);
>> +
>> +MODULE_AUTHOR("Suman Anna <s-anna@ti.com>");
>> +MODULE_DESCRIPTION("PRU-ICSS Subsystem Driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/pruss.h b/include/linux/pruss.h
>> new file mode 100644
>> index 0000000..b236b30
>> --- /dev/null
>> +++ b/include/linux/pruss.h
>> @@ -0,0 +1,211 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/**
>> + * PRU-ICSS Subsystem user interfaces
>> + *
>> + * Copyright (C) 2015-2019 Texas Instruments Incorporated - http://www.ti.com
>> + *	Suman Anna <s-anna@ti.com>
>> + *	Tero Kristo <t-kristo@ti.com>
>> + */
>> +
>> +#ifndef __LINUX_PRUSS_H
>> +#define __LINUX_PRUSS_H
>> +
>> +/*
>> + * PRU_ICSS_CFG registers
>> + * SYSCFG, ISRP, ISP, IESP, IECP, SCRP applicable on AMxxxx devices only
>> + */
>> +#define PRUSS_CFG_REVID		0x00
>> +#define PRUSS_CFG_SYSCFG	0x04
>> +#define PRUSS_CFG_GPCFG(x)	(0x08 + (x) * 4)
>> +#define PRUSS_CFG_CGR		0x10
>> +#define PRUSS_CFG_ISRP		0x14
>> +#define PRUSS_CFG_ISP		0x18
>> +#define PRUSS_CFG_IESP		0x1C
>> +#define PRUSS_CFG_IECP		0x20
>> +#define PRUSS_CFG_SCRP		0x24
>> +#define PRUSS_CFG_PMAO		0x28
>> +#define PRUSS_CFG_MII_RT	0x2C
>> +#define PRUSS_CFG_IEPCLK	0x30
>> +#define PRUSS_CFG_SPP		0x34
>> +#define PRUSS_CFG_PIN_MX	0x40
>> +
>> +/* PRUSS_GPCFG register bits */
>> +#define PRUSS_GPCFG_PRU_GPO_SH_SEL		BIT(25)
>> +
>> +#define PRUSS_GPCFG_PRU_DIV1_SHIFT		20
>> +#define PRUSS_GPCFG_PRU_DIV1_MASK		GENMASK(24, 20)
>> +
>> +#define PRUSS_GPCFG_PRU_DIV0_SHIFT		15
>> +#define PRUSS_GPCFG_PRU_DIV0_MASK		GENMASK(15, 19)
>> +
>> +#define PRUSS_GPCFG_PRU_GPO_MODE		BIT(14)
>> +#define PRUSS_GPCFG_PRU_GPO_MODE_DIRECT		0
>> +#define PRUSS_GPCFG_PRU_GPO_MODE_SERIAL		BIT(14)
>> +
>> +#define PRUSS_GPCFG_PRU_GPI_SB			BIT(13)
>> +
>> +#define PRUSS_GPCFG_PRU_GPI_DIV1_SHIFT		8
>> +#define PRUSS_GPCFG_PRU_GPI_DIV1_MASK		GENMASK(12, 8)
>> +
>> +#define PRUSS_GPCFG_PRU_GPI_DIV0_SHIFT		3
>> +#define PRUSS_GPCFG_PRU_GPI_DIV0_MASK		GENMASK(7, 3)
>> +
>> +#define PRUSS_GPCFG_PRU_GPI_CLK_MODE_POSITIVE	0
>> +#define PRUSS_GPCFG_PRU_GPI_CLK_MODE_NEGATIVE	BIT(2)
>> +#define PRUSS_GPCFG_PRU_GPI_CLK_MODE		BIT(2)
>> +
>> +#define PRUSS_GPCFG_PRU_GPI_MODE_MASK		GENMASK(1, 0)
>> +#define PRUSS_GPCFG_PRU_GPI_MODE_SHIFT		0
>> +
>> +#define PRUSS_GPCFG_PRU_MUX_SEL_SHIFT		26
>> +#define PRUSS_GPCFG_PRU_MUX_SEL_MASK		GENMASK(29, 26)
>> +
>> +/* PRUSS_MII_RT register bits */
>> +#define PRUSS_MII_RT_EVENT_EN			BIT(0)
>> +
>> +/* PRUSS_SPP register bits */
>> +#define PRUSS_SPP_XFER_SHIFT_EN			BIT(1)
>> +#define PRUSS_SPP_PRU1_PAD_HP_EN		BIT(0)
>> +
>> +/**
>> + * enum pruss_gp_mux_sel - PRUSS GPI/O Mux modes for the
>> + * PRUSS_GPCFG0/1 registers
>> + *
>> + * NOTE: The below defines are the most common values, but there
>> + * are some exceptions like on 66AK2G, where the RESERVED and MII2
>> + * values are interchanged. Also, this bit-field does not exist on
>> + * AM335x SoCs
>> + */
>> +enum pruss_gp_mux_sel {
>> +	PRUSS_GP_MUX_SEL_GP = 0,
>> +	PRUSS_GP_MUX_SEL_ENDAT,
>> +	PRUSS_GP_MUX_SEL_RESERVED,
>> +	PRUSS_GP_MUX_SEL_SD,
>> +	PRUSS_GP_MUX_SEL_MII2,
>> +	PRUSS_GP_MUX_SEL_MAX,
>> +};
>> +
>> +/**
>> + * enum pruss_gpi_mode - PRUSS GPI configuration modes, used
>> + *			 to program the PRUSS_GPCFG0/1 registers
>> + */
>> +enum pruss_gpi_mode {
>> +	PRUSS_GPI_MODE_DIRECT = 0,
>> +	PRUSS_GPI_MODE_PARALLEL,
>> +	PRUSS_GPI_MODE_28BIT_SHIFT,
>> +	PRUSS_GPI_MODE_MII,
>> +};
>> +
>> +/**
>> + * enum pruss_mem - PRUSS memory range identifiers
>> + */
>> +enum pruss_mem {
>> +	PRUSS_MEM_DRAM0 = 0,
>> +	PRUSS_MEM_DRAM1,
>> +	PRUSS_MEM_SHRD_RAM2,
>> +	PRUSS_MEM_MAX,
>> +};
>> +
>> +/**
>> + * struct pruss_mem_region - PRUSS memory region structure
>> + * @va: kernel virtual address of the PRUSS memory region
>> + * @pa: physical (bus) address of the PRUSS memory region
>> + * @size: size of the PRUSS memory region
>> + */
>> +struct pruss_mem_region {
>> +	void __iomem *va;
>> +	phys_addr_t pa;
>> +	size_t size;
>> +};
>> +
>> +struct pruss;
>> +struct rproc;
>> +
>> +#if IS_ENABLED(CONFIG_TI_PRUSS)
>> +
>> +struct pruss *pruss_get(struct rproc *rproc);
>> +void pruss_put(struct pruss *pruss);
>> +
>> +int pruss_request_mem_region(struct pruss *pruss, enum pruss_mem mem_id,
>> +			     struct pruss_mem_region *region);
>> +int pruss_release_mem_region(struct pruss *pruss,
>> +			     struct pruss_mem_region *region);
>> +
>> +int pruss_cfg_read(struct pruss *pruss, unsigned int reg, unsigned int *val);
>> +int pruss_cfg_update(struct pruss *pruss, unsigned int reg,
>> +		     unsigned int mask, unsigned int val);
>> +
>> +/**
>> + * pruss_cfg_miirt_enable() - Enable/disable MII RT Events
>> + * @pruss: the pruss instance
>> + * @enable: enable/disable
>> + *
>> + * Enable/disable the MII RT Events for the PRUSS.
>> + */
>> +static inline int pruss_cfg_miirt_enable(struct pruss *pruss, bool enable)
>> +{
>> +	u32 set = enable ? PRUSS_MII_RT_EVENT_EN : 0;
>> +
>> +	return pruss_cfg_update(pruss, PRUSS_CFG_MII_RT,
>> +				PRUSS_MII_RT_EVENT_EN, set);
>> +}
>> +
>> +/**
>> + * pruss_cfg_xfr_enable() - Enable/disable XIN XOUT shift functionality
>> + * @pruss: the pruss instance
>> + * @enable: enable/disable
>> + */
>> +static inline int pruss_cfg_xfr_enable(struct pruss *pruss, bool enable)
>> +{
>> +	u32 set = enable ? PRUSS_SPP_XFER_SHIFT_EN : 0;
>> +
>> +	return pruss_cfg_update(pruss, PRUSS_CFG_SPP,
>> +				PRUSS_SPP_XFER_SHIFT_EN, set);
>> +}
>> +#else
>> +
>> +static inline struct pruss *pruss_get(struct rproc *rproc)
>> +{
>> +	return ERR_PTR(-ENOTSUPP);
>> +}
>> +
>> +static inline void pruss_put(struct pruss *pruss) { }
>> +
>> +static inline int pruss_request_mem_region(struct pruss *pruss,
>> +					   enum pruss_mem mem_id,
>> +					   struct pruss_mem_region *region)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static inline int pruss_release_mem_region(struct pruss *pruss,
>> +					   struct pruss_mem_region *region)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static inline int pruss_cfg_read(struct pruss *pruss, unsigned int reg,
>> +				 unsigned int *val)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static inline int pruss_cfg_update(struct pruss *pruss, unsigned int reg,
>> +				   unsigned int mask, unsigned int val)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static inline int pruss_cfg_miirt_enable(struct pruss *pruss, bool enable)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static inline int pruss_cfg_xfr_enable(struct pruss *pruss, bool enable)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +#endif /* CONFIG_TI_PRUSS */
>> +
>> +#endif /* __LINUX_PRUSS_H */
>>

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
