Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADADECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E303E2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E303E2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeJSX2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:28:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54944 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbeJSX2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:28:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D03CBA78;
        Fri, 19 Oct 2018 08:22:13 -0700 (PDT)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9741C3F71A;
        Fri, 19 Oct 2018 08:22:11 -0700 (PDT)
Subject: Re: [PATCH v2 09/10] irqchip: ti-sci-inta: Add support for Interrupt
 Aggregator driver
To:     Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, tglx@linutronix.de,
        jason@lakedaemon.net
Cc:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-10-lokeshvutla@ti.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <b20127dc-be43-3b00-9960-663738df0069@arm.com>
Date:   Fri, 19 Oct 2018 16:22:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018154017.7112-10-lokeshvutla@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lokesh,

On 18/10/18 16:40, Lokesh Vutla wrote:
> Texas Instruments' K3 generation SoCs has an IP Interrupt Aggregator
> which is an interrupt controller that does the following:
> - Converts events to interrupts that can be understood by
>   an interrupt router.
> - Allows for multiplexing of events to interrupts.
> - Allows for grouping of multiple events to a single interrupt.

Aren't the last two points the same thing? Also, can you please define
what an "event" is? What is its semantic? If they look like interrupts,
can we just name them as such?

> 
> Configuration of the interrupt aggregator registers can only be done by
> a system co-processor and the driver needs to send a message to this
> co processor over TISCI protocol.
> 
> Add support for Interrupt Aggregator driver over TISCI protocol.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Changes since v1:
> - New patch
> 
>  MAINTAINERS                             |   1 +
>  drivers/irqchip/Kconfig                 |  11 +
>  drivers/irqchip/Makefile                |   1 +
>  drivers/irqchip/irq-ti-sci-inta.c       | 613 ++++++++++++++++++++++++
>  include/linux/irqchip/irq-ti-sci-inta.h |  35 ++
>  5 files changed, 661 insertions(+)
>  create mode 100644 drivers/irqchip/irq-ti-sci-inta.c
>  create mode 100644 include/linux/irqchip/irq-ti-sci-inta.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8cf1a6b73e6c..35c790ab0ae7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14689,6 +14689,7 @@ F:	drivers/reset/reset-ti-sci.c
>  F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
>  F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
>  F:	drivers/irqchip/irq-ti-sci-intr.c
> +F:	drivers/irqchip/irq-ti-sci-inta.c
>  
>  THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
>  M:	Hans Verkuil <hverkuil@xs4all.nl>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index f6620a6bb872..895f6b47dc5b 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -385,6 +385,17 @@ config TI_SCI_INTR_IRQCHIP
>  	  If you wish to use interrupt router irq resources managed by the
>  	  TI System Controller, say Y here. Otherwise, say N.
>  
> +config TI_SCI_INTA_IRQCHIP
> +	bool
> +	depends on TI_SCI_PROTOCOL && ARCH_K3
> +	select IRQ_DOMAIN
> +	select IRQ_DOMAIN_HIERARCHY
> +	help
> +	  This enables the irqchip driver support for K3 Interrupt aggregator
> +	  over TI System Control Interface available on some new TI's SoCs.
> +	  If you wish to use interrupt aggregator irq resources managed by the
> +	  TI System Controller, say Y here. Otherwise, say N.
> +
>  endmenu
>  
>  config SIFIVE_PLIC
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 44bf65606d60..aede4c1cc4a6 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -90,3 +90,4 @@ obj-$(CONFIG_NDS32)			+= irq-ativic32.o
>  obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
>  obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
>  obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
> +obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
> diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
> new file mode 100644
> index 000000000000..ef0a2e8b782c
> --- /dev/null
> +++ b/drivers/irqchip/irq-ti-sci-inta.c
> @@ -0,0 +1,613 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Texas Instruments' K3 Interrupt Aggregator irqchip driver
> + *
> + * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + *	Lokesh Vutla <lokeshvutla@ti.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/irqchip.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/irqdomain.h>
> +#include <linux/soc/ti/ti_sci_protocol.h>
> +
> +#define MAX_EVENTS_PER_VINT	64
> +#define TI_SCI_EVENT_IRQ	BIT(31)
> +
> +#define VINT_ENABLE_CLR_OFFSET	0x18
> +
> +/**
> + * struct ti_sci_inta_irq_domain - Structure representing a TISCI based
> + *				   Interrupt Aggregator IRQ domain.
> + * @sci:	Pointer to TISCI handle
> + * @vint:	TISCI resource pointer representing IA inerrupts.
> + * @global_event:TISCI resource pointer representing global events.
> + * @base:	Base address of the memory mapped IO registers
> + * @ia_id:	TISCI device ID of this Interrupt Aggregator.
> + * @dst_id:	TISCI device ID of the destination irq controller.
> + */
> +struct ti_sci_inta_irq_domain {
> +	const struct ti_sci_handle *sci;
> +	struct ti_sci_resource *vint;
> +	struct ti_sci_resource *global_event;
> +	void __iomem *base;
> +	u16 ia_id;
> +	u16 dst_id;
> +};
> +
> +/**
> + * struct ti_sci_inta_event_desc - Description of an event coming to
> + *				   Interrupt Aggregator.
> + * @global_event:	Global event number corresponding to this event
> + * @src_id:		TISCI device ID of the event source
> + * @src_index:		Event source index within the device.
> + */
> +struct ti_sci_inta_event_desc {
> +	u16 global_event;
> +	u16 src_id;
> +	u16 src_index;
> +};
> +
> +/**
> + * struct ti_sci_inta_vint_desc - Description of a virtual interrupt coming out
> + *				  of Interrupt Aggregator.
> + * @lock:		lock to guard the event map
> + * @event_map:		Bitmap to manage the allocation of events to vint.
> + * @events:		Array of event descriptors assigned to this vint.
> + * @ack_needed:		Event needs to be acked via INTA. This is used when
> + *			HW generating events cannot clear the events by itself.
> + *			Assuming that only events from the same hw block are
> + *			grouped. So all the events attached to vint needs
> + *			an ack or none needs an ack.
> + */
> +struct ti_sci_inta_vint_desc {
> +	raw_spinlock_t lock;
> +	unsigned long *event_map;
> +	struct ti_sci_inta_event_desc events[MAX_EVENTS_PER_VINT];
> +	bool ack_needed;
> +};
> +
> +static void ti_sci_inta_irq_eoi(struct irq_data *data)
> +{
> +	struct ti_sci_inta_irq_domain *inta = data->domain->host_data;
> +	struct ti_sci_inta_vint_desc *vint_desc;
> +	u64 val;
> +	int bit;
> +
> +	vint_desc = irq_data_get_irq_chip_data(data);
> +	if (!vint_desc->ack_needed)
> +		goto out;
> +
> +	for_each_set_bit(bit, vint_desc->event_map, MAX_EVENTS_PER_VINT) {
> +		val = 1 << bit;
> +		__raw_writeq(val, inta->base + data->hwirq * 0x1000 +
> +			     VINT_ENABLE_CLR_OFFSET);
> +	}

If you need an ack callback, why is this part of the eoi? We have
interrupt flows that allow you to combine both, so why don't you use that?

Also, the __raw_writeq call is probably wrong, as it assumes that both
the CPU and the INTA have the same endianness.

> +
> +out:
> +	irq_chip_eoi_parent(data);
> +}
> +
> +static struct irq_chip ti_sci_inta_irq_chip = {
> +	.name			= "INTA",
> +	.irq_eoi		= ti_sci_inta_irq_eoi,
> +	.irq_mask		= irq_chip_mask_parent,
> +	.irq_unmask		= irq_chip_unmask_parent,
> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> +	.irq_set_type		= irq_chip_set_type_parent,
> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> +};
> +
> +/**
> + * ti_sci_inta_irq_domain_translate() - Retrieve hwirq and type from
> + *					IRQ firmware specific handler.
> + * @domain:	Pointer to IRQ domain
> + * @fwspec:	Pointer to IRQ specific firmware structure
> + * @hwirq:	IRQ number identified by hardware
> + * @type:	IRQ type
> + *
> + * Return 0 if all went ok else appropriate error.
> + */
> +static int ti_sci_inta_irq_domain_translate(struct irq_domain *domain,
> +					    struct irq_fwspec *fwspec,
> +					    unsigned long *hwirq,
> +					    unsigned int *type)
> +{
> +	if (is_of_node(fwspec->fwnode)) {
> +		if (fwspec->param_count != 4)
> +			return -EINVAL;
> +
> +		*hwirq = fwspec->param[2];
> +		*type = fwspec->param[3] & IRQ_TYPE_SENSE_MASK;
> +
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +/**
> + * ti_sci_free_event_irq() - Free an event from vint
> + * @inta:	Pointer to Interrupt Aggregator IRQ domain
> + * @vint_desc:	Virtual interrupt descriptor containing the event.
> + * @event_index:Event Index within the vint.
> + * @dst_irq:	Destination host irq
> + * @vint:	Interrupt number within interrupt aggregator.
> + */
> +static void ti_sci_free_event_irq(struct ti_sci_inta_irq_domain *inta,
> +				  struct ti_sci_inta_vint_desc *vint_desc,
> +				  u32 event_index, u16 dst_irq, u16 vint)
> +{
> +	struct ti_sci_inta_event_desc *event;
> +	unsigned long flags;
> +
> +	if (event_index >= MAX_EVENTS_PER_VINT)
> +		return;

How can this happen?

> +
> +	event = &vint_desc->events[event_index];
> +	inta->sci->ops.rm_irq_ops.free_event_irq(inta->sci,
> +						 event->src_id,
> +						 event->src_index,
> +						 inta->dst_id,
> +						 dst_irq,
> +						 inta->ia_id, vint,
> +						 event->global_event,
> +						 event_index);
> +
> +	raw_spin_lock_irqsave(&vint_desc->lock, flags);
> +	clear_bit(event_index, vint_desc->event_map);
> +	raw_spin_unlock_irqrestore(&vint_desc->lock, flags);

clear_bit is atomic. Why do you need a spinlock?

> +
> +	ti_sci_release_resource(inta->global_event, event->global_event);
> +}
> +
> +/**
> + * ti_sci_inta_irq_domain_free() - Free an IRQ from the IRQ domain
> + * @domain:	Domain to which the irqs belong
> + * @virq:	base linux virtual IRQ to be freed.
> + * @nr_irqs:	Number of continuous irqs to be freed
> + */
> +static void ti_sci_inta_irq_domain_free(struct irq_domain *domain,
> +					unsigned int virq, unsigned int nr_irqs)
> +{
> +	struct ti_sci_inta_irq_domain *inta = domain->host_data;
> +	struct ti_sci_inta_vint_desc *vint_desc;
> +	struct irq_data *data, *gic_data;
> +	int event_index;
> +
> +	data = irq_domain_get_irq_data(domain, virq);
> +	gic_data = irq_domain_get_irq_data(domain->parent->parent, virq);

That's absolutely horrid...

> +
> +	vint_desc = irq_data_get_irq_chip_data(data);
> +
> +	/* This is the last event in the vint */
> +	event_index = find_first_bit(vint_desc->event_map, MAX_EVENTS_PER_VINT);

What guarantees that you only have a single "event" left here?

> +	ti_sci_free_event_irq(inta, vint_desc, event_index,
> +			      gic_data->hwirq, data->hwirq);
> +	irq_domain_free_irqs_parent(domain, virq, 1);
> +	irq_domain_reset_irq_data(data);
> +	ti_sci_release_resource(inta->vint, data->hwirq);
> +	kfree(vint_desc->event_map);
> +	kfree(vint_desc);
> +}
> +
> +/**
> + * ti_sci_allocate_event_irq() - Allocate an event to a IA vint.
> + * @inta:	Pointer to Interrupt Aggregator IRQ domain
> + * @vint_desc:	Virtual interrupt descriptor to which the event gets attached.
> + * @src_id:	TISCI device id of the event source
> + * @src_index:	Event index with in the device.
> + * @dst_irq:	Destination host irq
> + * @vint:	Interrupt number within interrupt aggregator.
> + *
> + * Return 0 if all went ok else appropriate error value.
> + */
> +static int ti_sci_allocate_event_irq(struct ti_sci_inta_irq_domain *inta,
> +				     struct ti_sci_inta_vint_desc *vint_desc,
> +				     u16 src_id, u16 src_index, u16 dst_irq,
> +				     u16 vint)
> +{
> +	struct ti_sci_inta_event_desc *event;
> +	unsigned long flags;
> +	u32 free_bit;
> +	int err;
> +
> +	raw_spin_lock_irqsave(&vint_desc->lock, flags);
> +	free_bit = find_first_zero_bit(vint_desc->event_map,
> +				       MAX_EVENTS_PER_VINT);
> +	if (free_bit != MAX_EVENTS_PER_VINT)
> +		set_bit(free_bit, vint_desc->event_map);
> +	raw_spin_unlock_irqrestore(&vint_desc->lock, flags);

Why disabling the interrupts? Do you expect to take this lock
concurrently with an interrupt? Why isn't it enough to just have a mutex
instead?

> +
> +	if (free_bit >= MAX_EVENTS_PER_VINT)
> +		return -ENODEV;
> +
> +	event = &vint_desc->events[free_bit];
> +
> +	event->src_id = src_id;
> +	event->src_index = src_index;
> +	event->global_event = ti_sci_get_free_resource(inta->global_event);

Reading patch #5, shouldn't you at least test for the validity of what
this function returns?

> +
> +	err = inta->sci->ops.rm_irq_ops.set_event_irq(inta->sci,
> +						      src_id, src_index,
> +						      inta->dst_id,
> +						      dst_irq,
> +						      inta->ia_id,
> +						      vint,
> +						      event->global_event,
> +						      free_bit);
> +	if (err) {
> +		pr_err("%s: Event allocation failed from src = %d, index = %d, to dst = %d,irq = %d,via ia_id = %d, vint = %d,global event = %d, status_bit = %d\n",
> +		       __func__, src_id, src_index, inta->dst_id, dst_irq,
> +		       inta->ia_id, vint, event->global_event, free_bit);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * alloc_parent_irq() - Allocate parent irq to Interrupt aggregator
> + * @domain:	IRQ domain corresponding to Interrupt Aggregator
> + * @virq:	Linux virtual IRQ number
> + * @src_id:	TISCI device id of the event source
> + * @src_index:	Event index with in the device.
> + * @vint:	Virtual interrupt number within IA
> + * @flags:	Corresponding IRQ flags
> + *
> + * Return pointer to vint descriptor if all went well else corresponding
> + * error pointer.
> + */
> +static struct ti_sci_inta_vint_desc *alloc_parent_irq(struct irq_domain *domain,

Please rename this function to something less ambiguous (you've prefixed
all functions so far, why not this one?).

> +						      unsigned int virq,
> +						      u32 src_id, u32 src_index,
> +						      u32 vint, u32 flags)
> +{
> +	struct ti_sci_inta_irq_domain *inta = domain->host_data;
> +	struct ti_sci_inta_vint_desc *vint_desc;
> +	struct irq_data *gic_data;
> +	struct irq_fwspec fwspec;
> +	int err;
> +
> +	if (!irq_domain_get_of_node(domain->parent))
> +		return ERR_PTR(-EINVAL);
> +
> +	vint_desc = kzalloc(sizeof(*vint_desc), GFP_KERNEL);
> +	if (!vint_desc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	vint_desc->event_map = kcalloc(BITS_TO_LONGS(MAX_EVENTS_PER_VINT),
> +				       sizeof(*vint_desc->event_map),
> +				       GFP_KERNEL);
> +	if (!vint_desc->event_map) {
> +		kfree(vint_desc);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	fwspec.fwnode = domain->parent->fwnode;
> +	fwspec.param_count = 3;
> +	/* Interrupt parent is Interrupt Router */
> +	fwspec.param[0] = inta->ia_id;
> +	fwspec.param[1] = vint;
> +	fwspec.param[2] = flags | TI_SCI_EVENT_IRQ;

Why isn't that flag an additional parameter instead of mixing stuff
coming from DT and things that are purely internal?

> +
> +	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
> +	if (err)
> +		goto err_irqs;
> +
> +	gic_data = irq_domain_get_irq_data(domain->parent->parent, virq);
> +
> +	raw_spin_lock_init(&vint_desc->lock);
> +
> +	err = ti_sci_allocate_event_irq(inta, vint_desc, src_id, src_index,
> +					gic_data->hwirq, vint);
> +	if (err)
> +		goto err_events;
> +
> +	return vint_desc;
> +
> +err_events:
> +	irq_domain_free_irqs_parent(domain, virq, 1);
> +err_irqs:
> +	ti_sci_release_resource(inta->vint, vint);
> +	kfree(vint_desc);
> +	return ERR_PTR(err);
> +}
> +
> +/**
> + * ti_sci_inta_irq_domain_alloc() - Allocate Interrupt aggregator IRQs
> + * @domain:	Point to the interrupt aggregator IRQ domain
> + * @virq:	Corresponding Linux virtual IRQ number
> + * @nr_irqs:	Continuous irqs to be allocated
> + * @data:	Pointer to firmware specifier
> + *
> + * Return 0 if all went well else appropriate error value.
> + */
> +static int ti_sci_inta_irq_domain_alloc(struct irq_domain *domain,
> +					unsigned int virq, unsigned int nr_irqs,
> +					void *data)
> +{
> +	struct ti_sci_inta_vint_desc *vint_desc;
> +	struct irq_fwspec *fwspec = data;
> +	int err;
> +
> +	vint_desc = alloc_parent_irq(domain, virq, fwspec->param[0],
> +				     fwspec->param[1], fwspec->param[2],
> +				     fwspec->param[3]);

Frankly, what is the point of doing that? Why don't you simply pass the
fwspec?

> +	if (IS_ERR(vint_desc))
> +		return PTR_ERR(vint_desc);
> +
> +	err = irq_domain_set_hwirq_and_chip(domain, virq, fwspec->param[2],
> +					    &ti_sci_inta_irq_chip, vint_desc);
> +
> +	return err;
> +}
> +
> +static const struct irq_domain_ops ti_sci_inta_irq_domain_ops = {
> +	.alloc		= ti_sci_inta_irq_domain_alloc,
> +	.free		= ti_sci_inta_irq_domain_free,
> +	.translate	= ti_sci_inta_irq_domain_translate,
> +};
> +
> +static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
> +{
> +	struct irq_domain *parent_domain, *domain;
> +	struct ti_sci_inta_irq_domain *inta;
> +	struct device_node *parent_node;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	int ret;
> +
> +	parent_node = of_irq_find_parent(dev_of_node(dev));
> +	if (!parent_node) {
> +		dev_err(dev, "Failed to get IRQ parent node\n");
> +		return -ENODEV;
> +	}
> +
> +	parent_domain = irq_find_host(parent_node);
> +	if (!parent_domain)
> +		return -EPROBE_DEFER;
> +
> +	inta = devm_kzalloc(dev, sizeof(*inta), GFP_KERNEL);
> +	if (!inta)
> +		return -ENOMEM;
> +
> +	inta->sci = devm_ti_sci_get_by_phandle(dev, "ti,sci");
> +	if (IS_ERR(inta->sci)) {
> +		ret = PTR_ERR(inta->sci);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "ti,sci read fail %d\n", ret);
> +		inta->sci = NULL;
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(dev->of_node, "ti,sci-dev-id",
> +				   (u32 *)&inta->ia_id);
> +	if (ret) {
> +		dev_err(dev, "missing 'ti,sci-dev-id' property\n");
> +		return -EINVAL;
> +	}
> +
> +	inta->vint = devm_ti_sci_get_of_resource(inta->sci, dev,
> +						 inta->ia_id,
> +						 "ti,sci-rm-range-vint");
> +	if (IS_ERR(inta->vint)) {
> +		dev_err(dev, "VINT resource allocation failed\n");
> +		return PTR_ERR(inta->vint);
> +	}
> +
> +	inta->global_event =
> +		devm_ti_sci_get_of_resource(inta->sci, dev,
> +					    inta->ia_id,
> +					    "ti,sci-rm-range-global-event");
> +	if (IS_ERR(inta->global_event)) {
> +		dev_err(dev, "Global event resource allocation failed\n");
> +		return PTR_ERR(inta->global_event);
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	inta->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(inta->base))
> +		return -ENODEV;
> +
> +	ret = of_property_read_u32(parent_node, "ti,sci-dst-id",
> +				   (u32 *)&inta->dst_id);
> +
> +	domain = irq_domain_add_hierarchy(parent_domain, 0, 0, dev_of_node(dev),
> +					  &ti_sci_inta_irq_domain_ops, inta);
> +	if (!domain) {
> +		dev_err(dev, "Failed to allocate IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ti_sci_inta_register_event() - Register a event to an interrupt aggregator
> + * @dev:	Device pointer to source generating the event
> + * @src_id:	TISCI device ID of the event source
> + * @src_index:	Event source index within the device.
> + * @virq:	Linux Virtual IRQ number
> + * @flags:	Corresponding IRQ flags
> + * @ack_needed:	If explicit clearing of event is required.
> + *
> + * Creates a new irq and attaches to IA domain if virq is not specified
> + * else attaches the event to vint corresponding to virq.
> + * When using TISCI within the client drivers, source indexes are always
> + * generated dynamically and cannot be represented in DT. So client
> + * drivers should call this API instead of platform_get_irq().

NAK. Either this fits in the standard model, or we adapt the standard
model to catter for your particular use case. But we don't define a new,
TI specific API.

I have a hunch that if the IDs are generated dynamically, then the model
we use for MSIs would fit this thing. I also want to understand what
this event is, and how drivers get notified that such an event has fired.

So please explain what this is all about, and we'll work out something.
In the meantime, I'll stop here for that particular patch.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
