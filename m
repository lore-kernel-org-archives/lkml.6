Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F131C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E1B20578
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405893AbfAPRQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:16:50 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53490 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbfAPRQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:16:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3B02A78;
        Wed, 16 Jan 2019 09:16:49 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA7DF3F5AF;
        Wed, 16 Jan 2019 09:16:46 -0800 (PST)
Subject: Re: [PATCH v4 07/13] irqchip: ti-sci-intr: Add support for Interrupt
 Router driver
To:     Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, tglx@linutronix.de,
        jason@lakedaemon.net
Cc:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20181227060829.5080-1-lokeshvutla@ti.com>
 <20181227061313.5451-1-lokeshvutla@ti.com>
 <20181227061313.5451-7-lokeshvutla@ti.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 mQINBE6Jf0UBEADLCxpix34Ch3kQKA9SNlVQroj9aHAEzzl0+V8jrvT9a9GkK+FjBOIQz4KE
 g+3p+lqgJH4NfwPm9H5I5e3wa+Scz9wAqWLTT772Rqb6hf6kx0kKd0P2jGv79qXSmwru28vJ
 t9NNsmIhEYwS5eTfCbsZZDCnR31J6qxozsDHpCGLHlYym/VbC199Uq/pN5gH+5JHZyhyZiNW
 ozUCjMqC4eNW42nYVKZQfbj/k4W9xFfudFaFEhAf/Vb1r6F05eBP1uopuzNkAN7vqS8XcgQH
 qXI357YC4ToCbmqLue4HK9+2mtf7MTdHZYGZ939OfTlOGuxFW+bhtPQzsHiW7eNe0ew0+LaL
 3wdNzT5abPBscqXWVGsZWCAzBmrZato+Pd2bSCDPLInZV0j+rjt7MWiSxEAEowue3IcZA++7
 ifTDIscQdpeKT8hcL+9eHLgoSDH62SlubO/y8bB1hV8JjLW/jQpLnae0oz25h39ij4ijcp8N
 t5slf5DNRi1NLz5+iaaLg4gaM3ywVK2VEKdBTg+JTg3dfrb3DH7ctTQquyKun9IVY8AsxMc6
 lxl4HxrpLX7HgF10685GG5fFla7R1RUnW5svgQhz6YVU33yJjk5lIIrrxKI/wLlhn066mtu1
 DoD9TEAjwOmpa6ofV6rHeBPehUwMZEsLqlKfLsl0PpsJwov8TQARAQABtCNNYXJjIFp5bmdp
 ZXIgPG1hcmMuenluZ2llckBhcm0uY29tPokCOwQTAQIAJQIbAwYLCQgHAwIGFQgCCQoLBBYC
 AwECHgECF4AFAk6NvYYCGQEACgkQI9DQutE9ekObww/+NcUATWXOcnoPflpYG43GZ0XjQLng
 LQFjBZL+CJV5+1XMDfz4ATH37cR+8gMO1UwmWPv5tOMKLHhw6uLxGG4upPAm0qxjRA/SE3LC
 22kBjWiSMrkQgv5FDcwdhAcj8A+gKgcXBeyXsGBXLjo5UQOGvPTQXcqNXB9A3ZZN9vS6QUYN
 TXFjnUnzCJd+PVI/4jORz9EUVw1q/+kZgmA8/GhfPH3xNetTGLyJCJcQ86acom2liLZZX4+1
 6Hda2x3hxpoQo7pTu+XA2YC4XyUstNDYIsE4F4NVHGi88a3N8yWE+Z7cBI2HjGvpfNxZnmKX
 6bws6RQ4LHDPhy0yzWFowJXGTqM/e79c1UeqOVxKGFF3VhJJu1nMlh+5hnW4glXOoy/WmDEM
 UMbl9KbJUfo+GgIQGMp8mwgW0vK4HrSmevlDeMcrLdfbbFbcZLNeFFBn6KqxFZaTd+LpylIH
 bOPN6fy1Dxf7UZscogYw5Pt0JscgpciuO3DAZo3eXz6ffj2NrWchnbj+SpPBiH4srfFmHY+Y
 LBemIIOmSqIsjoSRjNEZeEObkshDVG5NncJzbAQY+V3Q3yo9og/8ZiaulVWDbcpKyUpzt7pv
 cdnY3baDE8ate/cymFP5jGJK++QCeA6u6JzBp7HnKbngqWa6g8qDSjPXBPCLmmRWbc5j0lvA
 6ilrF8m5Ag0ETol/RQEQAM/2pdLYCWmf3rtIiP8Wj5NwyjSL6/UrChXtoX9wlY8a4h3EX6E3
 64snIJVMLbyr4bwdmPKULlny7T/R8dx/mCOWu/DztrVNQiXWOTKJnd/2iQblBT+W5W8ep/nS
 w3qUIckKwKdplQtzSKeE+PJ+GMS+DoNDDkcrVjUnsoCEr0aK3cO6g5hLGu8IBbC1CJYSpple
 VVb/sADnWF3SfUvJ/l4K8Uk4B4+X90KpA7U9MhvDTCy5mJGaTsFqDLpnqp/yqaT2P7kyMG2E
 w+eqtVIqwwweZA0S+tuqput5xdNAcsj2PugVx9tlw/LJo39nh8NrMxAhv5aQ+JJ2I8UTiHLX
 QvoC0Yc/jZX/JRB5r4x4IhK34Mv5TiH/gFfZbwxd287Y1jOaD9lhnke1SX5MXF7eCT3cgyB+
 hgSu42w+2xYl3+rzIhQqxXhaP232t/b3ilJO00ZZ19d4KICGcakeiL6ZBtD8TrtkRiewI3v0
 o8rUBWtjcDRgg3tWx/PcJvZnw1twbmRdaNvsvnlapD2Y9Js3woRLIjSAGOijwzFXSJyC2HU1
 AAuR9uo4/QkeIrQVHIxP7TJZdJ9sGEWdeGPzzPlKLHwIX2HzfbdtPejPSXm5LJ026qdtJHgz
 BAb3NygZG6BH6EC1NPDQ6O53EXorXS1tsSAgp5ZDSFEBklpRVT3E0NrDABEBAAGJAh8EGAEC
 AAkFAk6Jf0UCGwwACgkQI9DQutE9ekMLBQ//U+Mt9DtFpzMCIHFPE9nNlsCm75j22lNiw6mX
 mx3cUA3pl+uRGQr/zQC5inQNtjFUmwGkHqrAw+SmG5gsgnM4pSdYvraWaCWOZCQCx1lpaCOl
 MotrNcwMJTJLQGc4BjJyOeSH59HQDitKfKMu/yjRhzT8CXhys6R0kYMrEN0tbe1cFOJkxSbV
 0GgRTDF4PKyLT+RncoKxQe8lGxuk5614aRpBQa0LPafkirwqkUtxsPnarkPUEfkBlnIhAR8L
 kmneYLu0AvbWjfJCUH7qfpyS/FRrQCoBq9QIEcf2v1f0AIpA27f9KCEv5MZSHXGCdNcbjKw1
 39YxYZhmXaHFKDSZIC29YhQJeXWlfDEDq6nIhvurZy3mSh2OMQgaIoFexPCsBBOclH8QUtMk
 a3jW/qYyrV+qUq9Wf3SKPrXf7B3xB332jFCETbyZQXqmowV+2b3rJFRWn5hK5B+xwvuxKyGq
 qDOGjof2dKl2zBIxbFgOclV7wqCVkhxSJi/QaOj2zBqSNPXga5DWtX3ekRnJLa1+ijXxmdjz
 hApihi08gwvP5G9fNGKQyRETePEtEAWt0b7dOqMzYBYGRVr7uS4uT6WP7fzOwAJC4lU7ZYWZ
 yVshCa0IvTtp1085RtT3qhh9mobkcZ+7cQOY+Tx2RGXS9WeOh2jZjdoWUv6CevXNQyOUXMM=
Organization: ARM Ltd
Message-ID: <96ae4b44-0331-b11d-c67a-515afd88dee5@arm.com>
Date:   Wed, 16 Jan 2019 17:16:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181227061313.5451-7-lokeshvutla@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Still in the process of sorting out my email - don't ask]

On 27/12/2018 06:13, Lokesh Vutla wrote:
> Texas Instruments' K3 generation SoCs has an IP Interrupt Router
> that does allows for redirection of input interrupts to host
> interrupt controller. Interrupt Router inputs are either from a
> peripheral or from an Interrupt Aggregator which is another
> interrupt controller.
> 
> Configuration of the interrupt router registers can only be done by
> a system co-processor and the driver needs to send a message to this
> co processor over TISCI protocol.
> 
> Add support for Interrupt Router driver over TISCI protocol.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  MAINTAINERS                       |   1 +
>  drivers/irqchip/Kconfig           |  11 ++
>  drivers/irqchip/Makefile          |   1 +
>  drivers/irqchip/irq-ti-sci-intr.c | 310 ++++++++++++++++++++++++++++++
>  4 files changed, 323 insertions(+)
>  create mode 100644 drivers/irqchip/irq-ti-sci-intr.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8c7513b02d50..4480eb2fe851 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15024,6 +15024,7 @@ F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
>  F:	drivers/clk/keystone/sci-clk.c
>  F:	drivers/reset/reset-ti-sci.c
>  F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
> +F:	drivers/irqchip/irq-ti-sci-intr.c
>  
>  Texas Instruments ASoC drivers
>  M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 3d1e60779078..a8d9bed0254b 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -406,6 +406,17 @@ config IMX_IRQSTEER
>  	help
>  	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
>  
> +config TI_SCI_INTR_IRQCHIP
> +	bool
> +	depends on TI_SCI_PROTOCOL && ARCH_K3
> +	select IRQ_DOMAIN
> +	select IRQ_DOMAIN_HIERARCHY
> +	help
> +	  This enables the irqchip driver support for K3 Interrupt router
> +	  over TI System Control Interface available on some new TI's SoCs.
> +	  If you wish to use interrupt router irq resources managed by the
> +	  TI System Controller, say Y here. Otherwise, say N.
> +
>  endmenu
>  
>  config SIFIVE_PLIC
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index c93713d24b86..b4ff376a08ef 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -94,3 +94,4 @@ obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
>  obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
>  obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
>  obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
> +obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
> diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
> new file mode 100644
> index 000000000000..a5396e08412c
> --- /dev/null
> +++ b/drivers/irqchip/irq-ti-sci-intr.c
> @@ -0,0 +1,310 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Texas Instruments' K3 Interrupt Router irqchip driver
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
> +#define TI_SCI_DEV_ID_MASK	0xffff
> +#define TI_SCI_DEV_ID_SHIFT	16
> +#define TI_SCI_IRQ_ID_MASK	0xffff
> +#define TI_SCI_IRQ_ID_SHIFT	0
> +#define TI_SCI_EVENT_IRQ	BIT(0)
> +
> +#define HWIRQ_TO_DEVID(hwirq)	(((hwirq) >> (TI_SCI_DEV_ID_SHIFT)) & \
> +				 (TI_SCI_DEV_ID_MASK))
> +#define HWIRQ_TO_IRQID(hwirq)	((hwirq) & (TI_SCI_IRQ_ID_MASK))
> +#define FWSPEC_TO_HWIRQ(fwspec)	(((fwspec->param[0] & TI_SCI_DEV_ID_MASK) << \
> +				 TI_SCI_DEV_ID_SHIFT) | \
> +				(fwspec->param[1] & TI_SCI_IRQ_ID_MASK))
> +
> +/**
> + * struct ti_sci_intr_irq_domain - Structure representing a TISCI based
> + *				   Interrupt Router IRQ domain.
> + * @sci:	Pointer to TISCI handle
> + * @dst_irq:	TISCI resource pointer representing destination irq controller.
> + * @dst_id:	TISCI device ID of the destination irq controller.
> + */
> +struct ti_sci_intr_irq_domain {
> +	const struct ti_sci_handle *sci;
> +	struct ti_sci_resource *dst_irq;
> +	u16 dst_id;
> +};
> +
> +static struct irq_chip ti_sci_intr_irq_chip = {
> +	.name			= "INTR",
> +	.irq_eoi		= irq_chip_eoi_parent,
> +	.irq_mask		= irq_chip_mask_parent,
> +	.irq_unmask		= irq_chip_unmask_parent,
> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> +	.irq_set_type		= irq_chip_set_type_parent,
> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> +};
> +
> +/**
> + * ti_sci_intr_irq_domain_translate() - Retrieve hwirq and type from
> + *					IRQ firmware specific handler.
> + * @domain:	Pointer to IRQ domain
> + * @fwspec:	Pointer to IRQ specific firmware structure
> + * @hwirq:	IRQ number identified by hardware
> + * @type:	IRQ type
> + *
> + * Return 0 if all went ok else appropriate error.
> + */
> +static int ti_sci_intr_irq_domain_translate(struct irq_domain *domain,
> +					    struct irq_fwspec *fwspec,
> +					    unsigned long *hwirq,
> +					    unsigned int *type)
> +{
> +	if (is_of_node(fwspec->fwnode)) {
> +		if (fwspec->param_count != 4)
> +			return -EINVAL;
> +
> +		*hwirq = FWSPEC_TO_HWIRQ(fwspec);
> +		*type = fwspec->param[2];
> +
> +		return 0;
> +	}

From what I can see in the code used by this platform, there is
absolutely no chance this will ever support any firmware interface other
than DT. So I think you can loose the is_of_node check here.

Another thing is that you do not seem to use the 4th parameter to the
intspec. So what is it used for here?

> +
> +	return -EINVAL;
> +}
> +
> +static inline void ti_sci_intr_delete_desc(struct ti_sci_intr_irq_domain *intr,

So this is called "delete desc". What is desc? It seems to free an irq
in the resource manager, so please call it something that matches what
this does.

> +					   u16 src_id, u16 src_index,
> +					   u16 dst_irq)
> +{
> +	intr->sci->ops.rm_irq_ops.free_direct_irq(intr->sci, src_id, src_index,
> +						  intr->dst_id, dst_irq);
> +}
> +
> +/**
> + * ti_sci_intr_irq_domain_free() - Free the specified IRQs from the domain.
> + * @domain:	Domain to which the irqs belong
> + * @virq:	Linux virtual IRQ to be freed.
> + * @nr_irqs:	Number of continuous irqs to be freed
> + */
> +static void ti_sci_intr_irq_domain_free(struct irq_domain *domain,
> +					unsigned int virq, unsigned int nr_irqs)
> +{
> +	struct ti_sci_intr_irq_domain *intr = domain->host_data;
> +	struct irq_data *data, *parent_data;
> +	u64 flags;
> +	int i;
> +
> +	intr = domain->host_data;
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		data = irq_domain_get_irq_data(domain, virq + i);
> +		flags = (u64)irq_data_get_irq_chip_data(data);

Are you guaranteed that this will only exist on a 64bit architecture?

> +		parent_data = irq_domain_get_irq_data(domain->parent, virq + i);
> +
> +		if (!(flags & TI_SCI_EVENT_IRQ))
> +			ti_sci_intr_delete_desc(intr,
> +						HWIRQ_TO_DEVID(data->hwirq),
> +						HWIRQ_TO_IRQID(data->hwirq),
> +						parent_data->hwirq);
> +		ti_sci_release_resource(intr->dst_irq, parent_data->hwirq);
> +		irq_domain_free_irqs_parent(domain, virq + i, 1);

Couldn't this be moved out of the loop so that you free nr_irqs directly
since you seem to be assuming that they are continuous? But are they?

Also, and depending on the context this is called from, it is pretty
unlikely that you'll see nr_irqs!=1, the only case I know about being
the PCI Multi-MSI train-wreck.

> +		irq_domain_reset_irq_data(data);
> +	}
> +}
> +
> +/**
> + * ti_sci_intr_allocate_gic_irq() - Allocate GIC specific IRQ
> + * @domain:	Point to the interrupt router IRQ domain
> + * @dev:	TISCI device IRQ generating the IRQ
> + * @irq:	IRQ offset within the device
> + * @flags:	Corresponding flags to the IRQ
> + * @event_irq:	Flag to tell if requested irq is from interrupt aggregator.
> + *
> + * Returns 0 if all went well else appropriate error pointer.
> + */
> +static int ti_sci_intr_allocate_gic_irq(struct irq_domain *domain,
> +					unsigned int virq, u16 dev, u16 irq,
> +					u32 flags, u8 event_irq)
> +{
> +	struct ti_sci_intr_irq_domain *intr = domain->host_data;
> +	struct irq_fwspec fwspec;
> +	u16 dst_irq;
> +	int err;
> +
> +	if (!irq_domain_get_of_node(domain->parent))
> +		return -EINVAL;
> +
> +	dst_irq = ti_sci_get_free_resource(intr->dst_irq);
> +	if (dst_irq == TI_SCI_RESOURCE_NULL)
> +		return -EINVAL;
> +
> +	fwspec.fwnode = domain->parent->fwnode;
> +	fwspec.param_count = 3;
> +	fwspec.param[0] = 0;	/* SPI */
> +	fwspec.param[1] = dst_irq - 32; /* SPI offset */
> +	fwspec.param[2] = flags & IRQ_TYPE_SENSE_MASK;
> +
> +	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
> +	if (err)
> +		goto err_irqs;
> +
> +	/* If event is requested then return */
> +	if (event_irq == TI_SCI_EVENT_IRQ)
> +		return 0;
> +
> +	err = intr->sci->ops.rm_irq_ops.set_direct_irq(intr->sci, dev, irq,
> +						       intr->dst_id, dst_irq);
> +	if (err) {
> +		pr_err("%s: IRQ allocation failed from src = %d, src_index = %d to dst_id = %d, dst_irq = %d",
> +		       __func__, dev, irq, intr->dst_id, dst_irq);

Do we really needs this error message? It doesn't seem to provide any
useful information at this stage. I'd rather the terrible callback does
the screaming if required.

> +		goto err_msg;
> +	}
> +
> +	return 0;
> +
> +err_msg:
> +	irq_domain_free_irqs_parent(domain, virq, 1);
> +err_irqs:
> +	ti_sci_release_resource(intr->dst_irq, dst_irq);
> +	return err;
> +}
> +
> +/**
> + * ti_sci_intr_irq_domain_alloc() - Allocate Interrupt router IRQs
> + * @domain:	Point to the interrupt router IRQ domain
> + * @virq:	Corresponding Linux virtual IRQ number
> + * @nr_irqs:	Continuous irqs to be allocated
> + * @data:	Pointer to firmware specifier
> + *
> + * Return 0 if all went well else appropriate error value.
> + */
> +static int ti_sci_intr_irq_domain_alloc(struct irq_domain *domain,
> +					unsigned int virq, unsigned int nr_irqs,
> +					void *data)
> +{
> +	struct irq_fwspec *fwspec = data;
> +	u16 src_id, src_index;
> +	unsigned long hwirq;
> +	u8 event_irq;
> +	int i, err;
> +	u32 type;
> +
> +	err = ti_sci_intr_irq_domain_translate(domain, fwspec, &hwirq, &type);
> +	if (err)
> +		return err;
> +
> +	src_id = HWIRQ_TO_DEVID(hwirq);
> +	src_index = HWIRQ_TO_IRQID(hwirq);
> +	event_irq = fwspec->param[3];

Ah, so this is where it is used. You could perform some sanitization,
given that you're feeding this to other part of the system.

> +
> +	for (i = 0; i < nr_irqs; i++) {

Again, is there a case where such a loop is actually used?

> +		err = ti_sci_intr_allocate_gic_irq(domain, virq + i, src_id,
> +						   src_index + i, type,
> +						   event_irq);
> +		if (err)
> +			goto err_irq;
> +
> +		err = irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> +						    &ti_sci_intr_irq_chip,
> +						    (void *)(u64)event_irq);
> +		if (err)
> +			goto err_irq;
> +	}
> +
> +	return 0;
> +err_irq:
> +	ti_sci_intr_irq_domain_free(domain, virq, i);
> +	return err;
> +}
> +
> +static const struct irq_domain_ops ti_sci_intr_irq_domain_ops = {
> +	.alloc		= ti_sci_intr_irq_domain_alloc,
> +	.free		= ti_sci_intr_irq_domain_free,
> +	.translate	= ti_sci_intr_irq_domain_translate,
> +};
> +
> +static int ti_sci_intr_irq_domain_probe(struct platform_device *pdev)
> +{
> +	struct irq_domain *parent_domain, *domain;
> +	struct ti_sci_intr_irq_domain *intr;
> +	struct device_node *parent_node;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	parent_node = of_irq_find_parent(dev_of_node(dev));
> +	if (!parent_node) {
> +		dev_err(dev, "Failed to get IRQ parent node\n");
> +		return -ENODEV;
> +	}
> +
> +	parent_domain = irq_find_host(parent_node);
> +	if (!parent_domain) {
> +		dev_err(dev, "Failed to find IRQ parent domain\n");
> +		return -ENODEV;
> +	}
> +
> +	intr = devm_kzalloc(dev, sizeof(*intr), GFP_KERNEL);
> +	if (!intr)
> +		return -ENOMEM;
> +
> +	intr->sci = devm_ti_sci_get_by_phandle(dev, "ti,sci");
> +	if (IS_ERR(intr->sci)) {
> +		ret = PTR_ERR(intr->sci);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "ti,sci read fail %d\n", ret);
> +		intr->sci = NULL;
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(dev_of_node(dev), "ti,sci-dst-id",
> +				   (u32 *)&intr->dst_id);
> +	if (ret) {
> +		dev_err(dev, "missing 'ti,sci-dst-id' property\n");
> +		return -EINVAL;
> +	}
> +
> +	intr->dst_irq = devm_ti_sci_get_of_resource(intr->sci, dev,
> +						    intr->dst_id,
> +						    "ti,sci-rm-range-girq");
> +	if (IS_ERR(intr->dst_irq)) {
> +		dev_err(dev, "Destination irq resource allocation failed\n");
> +		return PTR_ERR(intr->dst_irq);
> +	}
> +
> +	domain = irq_domain_add_hierarchy(parent_domain, 0, 0, dev_of_node(dev),
> +					  &ti_sci_intr_irq_domain_ops, intr);
> +	if (!domain) {
> +		dev_err(dev, "Failed to allocate IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ti_sci_intr_irq_domain_of_match[] = {
> +	{ .compatible = "ti,sci-intr", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, ti_sci_intr_irq_domain_of_match);
> +
> +static struct platform_driver ti_sci_intr_irq_domain_driver = {
> +	.probe = ti_sci_intr_irq_domain_probe,
> +	.driver = {
> +		.name = "ti-sci-intr",
> +		.of_match_table = ti_sci_intr_irq_domain_of_match,
> +	},
> +};
> +module_platform_driver(ti_sci_intr_irq_domain_driver);
> +
> +MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ticom>");
> +MODULE_DESCRIPTION("K3 Interrupt Router driver over TI SCI protocol");
> +MODULE_LICENSE("GPL v2");
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
