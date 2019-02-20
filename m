Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53A6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFBD2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bc+n4ZGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfBTNSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:18:07 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56446 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBTNSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:18:06 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1KDHcES097511;
        Wed, 20 Feb 2019 07:17:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550668658;
        bh=VrlBz4j0umMYHfaozOqh6huHGwZYLnLNBA1TE12Z5vw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bc+n4ZGmVawl1xzr01Q0U4dCj4JYrlbllVZg5Ayh96+qCxDFSWLJs7biVfClS02mo
         VEeddUkmGFvxnvkkiKrJA/EKzLHvhOs1OMU781HxVasismUbxfZRU/2bR8wGeK4Wb0
         2QF63ZzAJ5ZBtBpanYDEhcbd/1cVOLCbriPTpQNA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1KDHcsL039727
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Feb 2019 07:17:38 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 20
 Feb 2019 07:17:38 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 20 Feb 2019 07:17:38 -0600
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1KDHYw8011068;
        Wed, 20 Feb 2019 07:17:34 -0600
Subject: Re: [PATCH v5 06/10] irqchip: ti-sci-intr: Add support for Interrupt
 Router driver
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-7-lokeshvutla@ti.com>
 <20190218155217.5195f118@why.wild-wind.fr.eu.org>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <1c2f2610-2be4-c145-4786-eabf3a07bc47@ti.com>
Date:   Wed, 20 Feb 2019 18:47:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190218155217.5195f118@why.wild-wind.fr.eu.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 18/02/19 9:22 PM, Marc Zyngier wrote:
> On Tue, 12 Feb 2019 13:12:33 +0530
> Lokesh Vutla <lokeshvutla@ti.com> wrote:
> 
>> Texas Instruments' K3 generation SoCs has an IP Interrupt Router
>> that does allows for redirection of input interrupts to host
>> interrupt controller. Interrupt Router inputs are either from a
>> peripheral or from an Interrupt Aggregator which is another
>> interrupt controller.
>>
>> Configuration of the interrupt router registers can only be done by
>> a system co-processor and the driver needs to send a message to this
>> co processor over TISCI protocol.
>>
>> Add support for Interrupt Router driver over TISCI protocol.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>> Changes since v4:
>> - Moved the ti_sci irq resource handling to ti-sci-common.c from ti_sci.c.
>>   Firmware maintainer rejected the idea of having this in firmware
>> driver as the resource handling is specific to the client.
>> - Obtain the number of peripheral interrupts attached to INTR by
>> parsing DT. Using this information store the max irqs that can be
>> allocated to INTA. This is done for pre allocating the INTA
>> irqs(vints) during inta driver probe.
>>   This will not work for cases where there are more that 1 INTAs
>> attached to INTR, but wanted to show this approach as suggested by
>> Marc.
> 
> Or not.
> 
>>
>>  MAINTAINERS                         |   3 +
>>  drivers/irqchip/Kconfig             |  11 +
>>  drivers/irqchip/Makefile            |   1 +
>>  drivers/irqchip/irq-ti-sci-common.c | 131 ++++++++++++
>>  drivers/irqchip/irq-ti-sci-common.h |  59 ++++++
>>  drivers/irqchip/irq-ti-sci-intr.c   | 315
>> ++++++++++++++++++++++++++++ 6 files changed, 520 insertions(+)
>>  create mode 100644 drivers/irqchip/irq-ti-sci-common.c
>>  create mode 100644 drivers/irqchip/irq-ti-sci-common.h
>>  create mode 100644 drivers/irqchip/irq-ti-sci-intr.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index c918d9b2ee18..823eeb672cf0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15065,6 +15065,9 @@ F:
>> Documentation/devicetree/bindings/clock/ti,sci-clk.txt F:
>> drivers/clk/keystone/sci-clk.c F:	drivers/reset/reset-ti-sci.c
>>  F:
>> Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>> +F:	drivers/irqchip/irq-ti-sci-intr.c +F:
>> drivers/irqchip/irq-ti-sci-common.c +F:
>> drivers/irqchip/irq-ti-sci-common.h 
>>  Texas Instruments ASoC drivers
>>  M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index 3d1e60779078..a8d9bed0254b 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -406,6 +406,17 @@ config IMX_IRQSTEER
>>  	help
>>  	  Support for the i.MX IRQSTEER interrupt
>> multiplexer/remapper. 
>> +config TI_SCI_INTR_IRQCHIP
>> +	bool
>> +	depends on TI_SCI_PROTOCOL && ARCH_K3
>> +	select IRQ_DOMAIN
>> +	select IRQ_DOMAIN_HIERARCHY
>> +	help
>> +	  This enables the irqchip driver support for K3 Interrupt
>> router
>> +	  over TI System Control Interface available on some new
>> TI's SoCs.
>> +	  If you wish to use interrupt router irq resources managed
>> by the
>> +	  TI System Controller, say Y here. Otherwise, say N.
>> +
>>  endmenu
>>  
>>  config SIFIVE_PLIC
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index c93713d24b86..0499fae148a9 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -94,3 +94,4 @@ obj-$(CONFIG_CSKY_APB_INTC)		+=
>> irq-csky-apb-intc.o obj-$(CONFIG_SIFIVE_PLIC)		+=
>> irq-sifive-plic.o obj-$(CONFIG_IMX_IRQSTEER)		+=
>> irq-imx-irqsteer.o obj-$(CONFIG_MADERA_IRQ)		+=
>> irq-madera.o +obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+=
>> irq-ti-sci-intr.o irq-ti-sci-common.o diff --git
>> a/drivers/irqchip/irq-ti-sci-common.c
>> b/drivers/irqchip/irq-ti-sci-common.c new file mode 100644 index
>> 000000000000..79d9c4e8ea14 --- /dev/null
>> +++ b/drivers/irqchip/irq-ti-sci-common.c
>> @@ -0,0 +1,131 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Common Code for TISCI IRQCHIP drivers
>> + *
>> + * Copyright (C) 2019 Texas Instruments Incorporated -
>> http://www.ti.com/
>> + *	Lokesh Vutla <lokeshvutla@ti.com>
>> + */
>> +
>> +#include <linux/of.h>
>> +#include <linux/bitmap.h>
>> +#include <linux/device.h>
>> +#include <linux/soc/ti/ti_sci_protocol.h>
>> +#include "irq-ti-sci-common.h"
>> +
>> +/**
>> + * ti_sci_get_free_resource() - Get a free resource from TISCI
>> resource.
>> + * @res:	Pointer to the TISCI resource
>> + *
>> + * Return: resource num if all went ok else TI_SCI_RESOURCE_NULL.
>> + */
>> +u16 ti_sci_get_free_resource(struct ti_sci_resource *res)
>> +{
>> +	u16 set, free_bit;
>> +
>> +	mutex_lock(&res->request_mutex);
>> +	for (set = 0; set < res->sets; set++) {
>> +		free_bit =
>> find_first_zero_bit(res->desc[set].res_map,
>> +					       res->desc[set].num);
>> +		if (free_bit != res->desc[set].num) {
>> +			set_bit(free_bit, res->desc[set].res_map);
>> +			mutex_unlock(&res->request_mutex);
>> +			return res->desc[set].start + free_bit;
>> +		}
>> +	}
>> +	mutex_unlock(&res->request_mutex);
>> +
>> +	return TI_SCI_RESOURCE_NULL;
>> +}
>> +
>> +/**
>> + * ti_sci_release_resource() - Release a resource from TISCI
>> resource.
>> + * @res:	Pointer to the TISCI resource
>> + * @id:		Resource id to be released.
>> + */
>> +void ti_sci_release_resource(struct ti_sci_resource *res, u16 id)
>> +{
>> +	u16 set;
>> +
>> +	mutex_lock(&res->request_mutex);
>> +	for (set = 0; set < res->sets; set++) {
>> +		if (res->desc[set].start <= id &&
>> +		    (res->desc[set].num + res->desc[set].start) > id)
>> +			clear_bit(id - res->desc[set].start,
>> +				  res->desc[set].res_map);
>> +	}
>> +	mutex_unlock(&res->request_mutex);
>> +}
>> +
>> +u32 ti_sci_get_num_resources(struct ti_sci_resource *res)
>> +{
>> +	u32 count = 0, set;
>> +
>> +	for (set = 0; set < res->sets; set++)
>> +		count += res->desc[set].num;
>> +
>> +	return count;
>> +}
>> +
>> +/**
>> + * devm_ti_sci_get_of_resource() - Get a TISCI resource assigned to
>> a device
>> + * @handle:	TISCI handle
>> + * @dev:	Device pointer to which the resource is assigned
>> + * @of_prop:	property name by which the resource are
>> represented
>> + *
>> + * Return: Pointer to ti_sci_resource if all went well else
>> appropriate
>> + *	   error pointer.
>> + */
>> +struct ti_sci_resource *
>> +devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
>> +			    struct device *dev, u32 dev_id, char
>> *of_prop) +{
>> +	struct ti_sci_resource *res;
>> +	u32 resource_subtype;
>> +	int i, ret;
>> +
>> +	res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
>> +	if (!res)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	res->sets =
>> of_property_count_elems_of_size(dev_of_node(dev), of_prop,
>> +						    sizeof(u32));
>> +	if (res->sets < 0) {
>> +		dev_err(dev, "%s resource type ids not available\n",
>> of_prop);
>> +		return ERR_PTR(res->sets);
>> +	}
>> +
>> +	res->desc = devm_kcalloc(dev, res->sets, sizeof(*res->desc),
>> +				 GFP_KERNEL);
>> +	if (!res->desc)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	for (i = 0; i < res->sets; i++) {
>> +		ret = of_property_read_u32_index(dev_of_node(dev),
>> of_prop, i,
>> +						 &resource_subtype);
>> +		if (ret)
>> +			return ERR_PTR(-EINVAL);
>> +
>> +		ret = handle->ops.rm_core_ops.get_range(handle,
>> dev_id,
>> +
>> resource_subtype,
>> +
>> &res->desc[i].start,
>> +
>> &res->desc[i].num);
>> +		if (ret) {
>> +			dev_err(dev, "dev = %d subtype %d not
>> allocated for this host\n",
>> +				dev_id, resource_subtype);
>> +			return ERR_PTR(ret);
>> +		}
>> +
>> +		dev_dbg(dev, "dev = %d, subtype = %d, start = %d,
>> num = %d\n",
>> +			dev_id, resource_subtype, res->desc[i].start,
>> +			res->desc[i].num);
>> +
>> +		res->desc[i].res_map =
>> +			devm_kzalloc(dev,
>> BITS_TO_LONGS(res->desc[i].num) *
>> +				     sizeof(*res->desc[i].res_map),
>> GFP_KERNEL);
>> +		if (!res->desc[i].res_map)
>> +			return ERR_PTR(-ENOMEM);
>> +	}
>> +	mutex_init(&res->request_mutex);
>> +
>> +	return res;
>> +}
>> diff --git a/drivers/irqchip/irq-ti-sci-common.h
>> b/drivers/irqchip/irq-ti-sci-common.h new file mode 100644
>> index 000000000000..60c4b28bebab
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-ti-sci-common.h
>> @@ -0,0 +1,59 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Common header file for TISCI IRQCHIP drivers
>> + *
>> + * Copyright (C) 2019 Texas Instruments Incorporated -
>> http://www.ti.com/
>> + *	Lokesh Vutla <lokeshvutla@ti.com>
>> + */
>> +
>> +#ifndef __TI_SCI_COMMON_IRQCHIP_H
>> +#define __TI_SCI_COMMON_IRQCHIP_H
>> +
>> +#include <linux/mutex.h>
>> +
>> +#define TI_SCI_RESOURCE_NULL	0xffff
>> +#define TI_SCI_DEV_ID_MASK	0xffff
>> +#define TI_SCI_DEV_ID_SHIFT	16
>> +#define TI_SCI_IRQ_ID_MASK	0xffff
>> +#define TI_SCI_IRQ_ID_SHIFT	0
>> +#define TI_SCI_VINT_IRQ		BIT(0)
>> +#define HWIRQ_TO_DEVID(hwirq)	(((hwirq) >>
>> (TI_SCI_DEV_ID_SHIFT)) & \
>> +				 (TI_SCI_DEV_ID_MASK))
>> +#define HWIRQ_TO_IRQID(hwirq)	((hwirq) & (TI_SCI_IRQ_ID_MASK))
>> +#define TO_HWIRQ(dev, index)	((((dev) & TI_SCI_DEV_ID_MASK)
>> << \
>> +				 TI_SCI_DEV_ID_SHIFT) | \
>> +				((index) & TI_SCI_IRQ_ID_MASK))
>> +
>> +/**
>> + * struct ti_sci_resource_desc - Description of TI SCI resource
>> instance range.
>> + * @start:	Start index of the resource.
>> + * @num:	Number of resources.
>> + * @res_map:	Bitmap to manage the allocation of these
>> resources.
>> + */
>> +struct ti_sci_resource_desc {
>> +	u16 start;
>> +	u16 num;
>> +	unsigned long *res_map;
>> +};
>> +
>> +/**
>> + * struct ti_sci_resource - Structure representing a resource
>> assigned
>> + *			    to a device.
>> + * @sets:		Number of sets available from this resource
>> type
>> + * @request_mutex:	mutex to protect request and release of
>> resources.
>> + * @desc:		Array of resource descriptors.
>> + */
>> +struct ti_sci_resource {
>> +	u16 sets;
>> +	/* Mutex to protect request and release of resources */
>> +	struct mutex request_mutex;
>> +	struct ti_sci_resource_desc *desc;
>> +};
>> +
>> +u16 ti_sci_get_free_resource(struct ti_sci_resource *res);
>> +void ti_sci_release_resource(struct ti_sci_resource *res, u16 id);
>> +u32 ti_sci_get_num_resources(struct ti_sci_resource *res);
>> +struct ti_sci_resource *
>> +devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
>> +			    struct device *dev, u32 dev_id, char
>> *of_prop); +#endif /*__TI_SCI_COMMON_IRQCHIP_H */
> 
> Most the above "common" should be a separate patch, really. Also, why

ok will move this into a separate patch.

> isn't the whole resource management part of the firmware interface? I
> see that "Firmware maintainer rejected the idea", but I don't really
> buy the rational. I don't see anything irq specific to the whole
> devm_ti_sci_get_of_resource and co, to be honest.

I guess the concern is mostly about the way ids are represented from DT. Using
this every tisci client should mandate to have separate DT property for each of
its resource.

> 
>> diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
>> new file mode 100644
>> index 000000000000..7e224552a735
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-ti-sci-intr.c
>> @@ -0,0 +1,315 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Texas Instruments' K3 Interrupt Router irqchip driver
>> + *
>> + * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
>> + *	Lokesh Vutla <lokeshvutla@ti.com>
>> + */

[..snip..]

>> +	err = ti_sci_intr_irq_domain_translate(domain, fwspec, &hwirq, &type);
>> +	if (err)
>> +		return err;
>> +
>> +	vint_irq = fwspec->param[3] & TI_SCI_VINT_IRQ;
>> +
>> +	err = ti_sci_intr_alloc_gic_irq(domain, virq, hwirq, type, vint_irq);
>> +	if (err)
>> +		return err;
>> +
>> +	err = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
>> +					    &ti_sci_intr_irq_chip,
>> +					    (void *)vint_irq);
> 
> I think I see what you're trying to achieve. I suggest you look a
> uintptr_t instead of playing with unrelated data types whose semantic
> really doesn't apply here.

As you commented on the dt-bindings patch to differentiate vints using the INTA
ids, this will not be needed anymore. Will completely drop this.

> 
>> +	if (err) {
>> +		ti_sci_intr_irq_domain_free(domain, virq, 1);
>> +		return err;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct irq_domain_ops ti_sci_intr_irq_domain_ops = {
>> +	.alloc		= ti_sci_intr_irq_domain_alloc,
>> +	.free		= ti_sci_intr_irq_domain_free,
>> +	.translate	= ti_sci_intr_irq_domain_translate,
>> +};
>> +
>> +static int ti_sci_intr_irq_domain_probe(struct platform_device *pdev)
>> +{
>> +	struct irq_domain *parent_domain, *domain;
>> +	struct device_node *parent_node, *dn;
>> +	struct ti_sci_intr_irq_domain *intr;
>> +	struct device *dev = &pdev->dev;
>> +	struct of_phandle_iterator it;
>> +	int ret, count, intsize;
>> +
>> +	parent_node = of_irq_find_parent(dev_of_node(dev));
>> +	if (!parent_node) {
>> +		dev_err(dev, "Failed to get IRQ parent node\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	parent_domain = irq_find_host(parent_node);
>> +	if (!parent_domain) {
>> +		dev_err(dev, "Failed to find IRQ parent domain\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	intr = devm_kzalloc(dev, sizeof(*intr), GFP_KERNEL);
>> +	if (!intr)
>> +		return -ENOMEM;
>> +
>> +	intr->sci = devm_ti_sci_get_by_phandle(dev, "ti,sci");
>> +	if (IS_ERR(intr->sci)) {
>> +		ret = PTR_ERR(intr->sci);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "ti,sci read fail %d\n", ret);
>> +		intr->sci = NULL;
>> +		return ret;
>> +	}
>> +
>> +	ret = of_property_read_u32(dev_of_node(dev), "ti,sci-dst-id",
>> +				   (u32 *)&intr->dst_id);
>> +	if (ret) {
>> +		dev_err(dev, "missing 'ti,sci-dst-id' property\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	intr->dst_irq = devm_ti_sci_get_of_resource(intr->sci, dev,
>> +						    intr->dst_id,
>> +						    "ti,sci-rm-range-girq");
>> +	if (IS_ERR(intr->dst_irq)) {
>> +		dev_err(dev, "Destination irq resource allocation failed\n");
>> +		return PTR_ERR(intr->dst_irq);
>> +	}
>> +
>> +	domain = irq_domain_add_hierarchy(parent_domain, 0, 0, dev_of_node(dev),
>> +					  &ti_sci_intr_irq_domain_ops, intr);
>> +	if (!domain) {
>> +		dev_err(dev, "Failed to allocate IRQ domain\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	if (of_property_read_u32(dev_of_node(dev), "#interrupt-cells",
>> +				 &intsize))
>> +		return -EINVAL;
>> +
>> +	count = 0;
>> +	for_each_node_with_property(dn, "interrupts") {
>> +		if (of_irq_find_parent(dn) != dev_of_node(dev))
>> +			continue;
>> +		count += of_property_count_elems_of_size(dn, "interrupts",
>> +							 sizeof(u32) * intsize);
>> +	}
>> +
>> +	for_each_node_with_property(dn, "interrupts-extended") {
>> +		of_for_each_phandle(&it, ret, dn, "interrupts-extended",
>> +				    "#interrupt-cells", 0) {
>> +			if (it.node == dev_of_node(dev))
>> +				count++;
>> +		}
>> +	}
> 
> What is this trying to do? Counting the number of interrupt descriptors
> in the whole system? What does this even mean?

I am just trying for max utilization of GIC interrupts available for this. Since
inta vints are not represented in DT, total gic available - whatever is in DT
gives the max interrupts that can be used for the child INTA.

> 
> What I suggested was to allocate the required number of interrupts
> for a given device, based on the requirements of that device. I also

okay, then Ill get the number of interrupts needed for INTA from DT.

> suggested to investigate the x86 two phase allocation mechanism for the
> INTA driver.

Sorry, Ill try to explore this path. Any pointers to the doc/code will be really
helpful :)

Thanks and regards,
Lokesh

> 
> I never suggested that you'd parse the DT to guess how many interrupts
> you'd need to allocate...
> 
> 	M.
> 
>> +
>> +	intr->vint_irqs = ti_sci_get_num_resources(intr->dst_irq) - count;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id ti_sci_intr_irq_domain_of_match[] = {
>> +	{ .compatible = "ti,sci-intr", },
>> +	{ /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, ti_sci_intr_irq_domain_of_match);
>> +
>> +static struct platform_driver ti_sci_intr_irq_domain_driver = {
>> +	.probe = ti_sci_intr_irq_domain_probe,
>> +	.driver = {
>> +		.name = "ti-sci-intr",
>> +		.of_match_table = ti_sci_intr_irq_domain_of_match,
>> +	},
>> +};
>> +module_platform_driver(ti_sci_intr_irq_domain_driver);
>> +
>> +MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ticom>");
>> +MODULE_DESCRIPTION("K3 Interrupt Router driver over TI SCI protocol");
>> +MODULE_LICENSE("GPL v2");
> 
> 
> 
