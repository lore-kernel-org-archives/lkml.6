Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C169C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3266220869
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733302AbfAaOE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:04:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42552 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731609AbfAaOE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:04:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so3399140wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 06:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dCa9JWEWqU1l6JbekoRorH9i2fpvx18ZLWgQP6mdkVU=;
        b=iPDkPz3FXzCa2fQ/4SDiAb8hAsSVYefKGePe6WM5y4qs6bqz355z7FyT5p8R9icIb5
         zyY9G0uIyZRtsLbXnA21Y32NrrSxvCsWToPNtEY8Z5PHnRQLC4KG21/uEtN+b53bReyS
         ZOU/vQgcb++pYA2KNbFQ1dTBM1AxdZP2zC+NU3tpQ4+bodrhBEXR5FgtpifwFls325nP
         11DH1he4kKrYU0SY3Ul1MVEgT0UZwEM4paRrJDQwrg9FHkfQlkyOc0/S9oMDpJpBAo1B
         8edbJn0Li73zqq3hJ1ujbf3XZCPHsvnVNNTke7jnLRmkGuYX0WyuBHM7Pa7zb3aW9JLY
         6GUg==
X-Gm-Message-State: AJcUukc7yv7BrOAUNUR/aV3aa/IPZYo7OeDvXwE96r8cV+wV2fZdWTqj
        FQ4NMGJo8Zuklokt66YTKT1OlQ==
X-Google-Smtp-Source: ALg8bN7EQz6e3xRXa979tUXSqP+Tp1Ui7zwzB9GQG66VpcMHO6vizQY75UGUe2Wymws41AycQV1KnQ==
X-Received: by 2002:adf:8506:: with SMTP id 6mr35990521wrh.128.1548943466237;
        Thu, 31 Jan 2019 06:04:26 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o15sm3525594wrp.12.2019.01.31.06.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 06:04:25 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     lantianyu1986@gmail.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, joro@8bytes.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        nicolas.ferre@microchip.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        michael.h.kelley@microsoft.com, kys@microsoft.com,
        alex.williamson@redhat.com
Subject: Re: [PATCH 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
In-Reply-To: <1548929853-25877-3-git-send-email-Tianyu.Lan@microsoft.com>
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com> <1548929853-25877-3-git-send-email-Tianyu.Lan@microsoft.com>
Date:   Thu, 31 Jan 2019 15:04:24 +0100
Message-ID: <87k1ikylcn.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lantianyu1986@gmail.com writes:

> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
>
> On the bare metal, enabling X2APIC mode requires interrupt remapping
> function which helps to deliver irq to cpu with 32-bit APIC ID.
> Hyper-V doesn't provide interrupt remapping function so far and Hyper-V
> MSI protocol already supports to deliver interrupt to the CPU whose
> virtual processor index is more than 255. IO-APIC interrupt still has
> 8-bit APIC ID limitation.
>
> This patch is to add Hyper-V stub IOMMU driver in order to enable
> X2APIC mode successfully in Hyper-V Linux guest. The driver returns X2APIC
> interrupt remapping capability when X2APIC mode is available. Otherwise,
> it creates a Hyper-V irq domain to limit IO-APIC interrupts' affinity
> and make sure cpus assigned with IO-APIC interrupt have 8-bit APIC ID.
>
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
>  drivers/iommu/Kconfig         |   7 ++
>  drivers/iommu/Makefile        |   1 +
>  drivers/iommu/hyperv-iommu.c  | 189 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/irq_remapping.c |   3 +
>  drivers/iommu/irq_remapping.h |   1 +
>  5 files changed, 201 insertions(+)
>  create mode 100644 drivers/iommu/hyperv-iommu.c
>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 45d7021..5c397c0 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -437,4 +437,11 @@ config QCOM_IOMMU
>  	help
>  	  Support for IOMMU on certain Qualcomm SoCs.
>  
> +config HYPERV_IOMMU
> +	bool "Hyper-V stub IOMMU support"
> +	depends on HYPERV
> +	help
> +	    Hyper-V stub IOMMU driver provides capability to run
> +	    Linux guest with X2APIC mode enabled.
> +
>  endif # IOMMU_SUPPORT
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index a158a68..8c71a15 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -32,3 +32,4 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
>  obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>  obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
>  obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
> +obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> new file mode 100644
> index 0000000..a64b747
> --- /dev/null
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define pr_fmt(fmt)     "HYPERV-IR: " fmt
> +
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/iommu.h>
> +#include <linux/module.h>
> +
> +#include <asm/hw_irq.h>
> +#include <asm/io_apic.h>
> +#include <asm/irq_remapping.h>
> +#include <asm/hypervisor.h>
> +
> +#include "irq_remapping.h"
> +
> +/*
> + * According IO-APIC spec, IO APIC has a 24-entry Interrupt
> + * Redirection Table.
> + */
> +#define IOAPIC_REMAPPING_ENTRY 24

KVM already defines KVM_IOAPIC_NUM_PINS - is this the same thing?

> +
> +static cpumask_t ioapic_max_cpumask = { CPU_BITS_NONE };
> +struct irq_domain *ioapic_ir_domain;
> +
> +static int hyperv_ir_set_affinity(struct irq_data *data,
> +		const struct cpumask *mask, bool force)
> +{
> +	struct irq_data *parent = data->parent_data;
> +	struct irq_cfg *cfg = irqd_cfg(data);
> +	struct IO_APIC_route_entry *entry;
> +	cpumask_t cpumask;
> +	int ret;
> +
> +	cpumask_andnot(&cpumask, mask, &ioapic_max_cpumask);
> +
> +	/* Return error If new irq affinity is out of ioapic_max_cpumask. */
> +	if (!cpumask_empty(&cpumask))
> +		return -EINVAL;
> +
> +	ret = parent->chip->irq_set_affinity(parent, mask, force);
> +	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
> +		return ret;
> +
> +	entry = data->chip_data;
> +	entry->dest = cfg->dest_apicid;
> +	entry->vector = cfg->vector;
> +	send_cleanup_vector(cfg);
> +
> +	return 0;
> +}
> +
> +static struct irq_chip hyperv_ir_chip = {
> +	.name			= "HYPERV-IR",
> +	.irq_ack		= apic_ack_irq,
> +	.irq_set_affinity	= hyperv_ir_set_affinity,
> +};
> +
> +static int hyperv_irq_remapping_alloc(struct irq_domain *domain,
> +				     unsigned int virq, unsigned int nr_irqs,
> +				     void *arg)
> +{
> +	struct irq_alloc_info *info = arg;
> +	struct IO_APIC_route_entry *entry;
> +	struct irq_data *irq_data;
> +	struct irq_desc *desc;
> +	struct irq_cfg *cfg;
> +	int ret = 0;
> +
> +	if (!info || info->type != X86_IRQ_ALLOC_TYPE_IOAPIC || nr_irqs > 1)
> +		return -EINVAL;
> +
> +	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
> +	if (ret < 0)
> +		goto fail;
> +
> +	irq_data = irq_domain_get_irq_data(domain, virq);
> +	cfg = irqd_cfg(irq_data);
> +	if (!irq_data || !cfg) {
> +		ret = -EINVAL;
> +		goto fail;
> +	}

fail: label doesn't do anything, you can just return (and you actually
do on the first failure path).

> +
> +	irq_data->chip = &hyperv_ir_chip;
> +
> +	/*
> +	 * Save IOAPIC entry pointer here in order to set vector and
> +	 * and dest_apicid in the hyperv_irq_remappng_activate()

and and

> +	 * and hyperv_ir_set_affinity(). IOAPIC driver ignores
> +	 * cfg->dest_apicid and cfg->vector when irq remapping
> +	 * mode is enabled. Detail see ioapic_configure_entry().

I would re-phrase this a bit:

/*
 * IOAPIC entry pointer is saved in chip_data to allow
 * hyperv_irq_remappng_activate()/hyperv_ir_set_affinity() to set
 * vector and dest_apicid. cfg->vector and cfg->dest_apicid are
 * ignorred when IRQ remapping is enabled. See ioapic_configure_entry().
 */

But I'm still a bit confused. Hope others are not.

> +	 */
> +	irq_data->chip_data = entry = info->ioapic_entry;
> +

I personally dislike double assignments, hard to remember which one
happens first :-)

> +	/*
> +	 * Hypver-V IO APIC irq affinity should be in the scope of
> +	 * ioapic_max_cpumask because no irq remapping support.
> +	 */
> +	desc = irq_data_to_desc(irq_data);
> +	cpumask_and(desc->irq_common_data.affinity,
> +			desc->irq_common_data.affinity,
> +			&ioapic_max_cpumask);
> +
> + fail:
> +	return ret;
> +}
> +
> +static void hyperv_irq_remapping_free(struct irq_domain *domain,
> +				 unsigned int virq, unsigned int nr_irqs)
> +{
> +	irq_domain_free_irqs_common(domain, virq, nr_irqs);
> +}
> +
> +static int hyperv_irq_remappng_activate(struct irq_domain *domain,
> +			  struct irq_data *irq_data, bool reserve)
> +{
> +	struct irq_cfg *cfg = irqd_cfg(irq_data);
> +	struct IO_APIC_route_entry *entry = irq_data->chip_data;
> +
> +	entry->dest = cfg->dest_apicid;
> +	entry->vector = cfg->vector;
> +
> +	return 0;
> +}
> +
> +static struct irq_domain_ops hyperv_ir_domain_ops = {
> +	.alloc = hyperv_irq_remapping_alloc,
> +	.free = hyperv_irq_remapping_free,
> +	.activate = hyperv_irq_remappng_activate,
> +};
> +
> +static int __init hyperv_prepare_irq_remapping(void)
> +{
> +	struct fwnode_handle *fn;
> +	u32 apic_id;
> +	int i;
> +
> +	if (x86_hyper_type != X86_HYPER_MS_HYPERV ||
> +	    !x2apic_supported())
> +		return -ENODEV;
> +
> +	fn = irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
> +	if (!fn)
> +		return -EFAULT;
> +
> +	ioapic_ir_domain =
> +		irq_domain_create_hierarchy(arch_get_ir_parent_domain(),
> +				0, IOAPIC_REMAPPING_ENTRY, fn,
> +				&hyperv_ir_domain_ops, NULL);
> +
> +	irq_domain_free_fwnode(fn);
> +
> +	/*
> +	 * Hyper-V doesn't provide irq remapping function for
> +	 * IO-APIC and so IO-APIC only accepts 8-bit APIC ID.
> +	 * Prepare max cpu affinity for IOAPIC irqs. Scan cpu 0-255
> +	 * and set cpu into ioapic_max_cpumask if its APIC ID is less
> +	 * than 255.
> +	 */
> +	for (i = 0; i < 256; i++) {
> +		apic_id = cpu_physical_id(i);
> +		if (apic_id > 255)
> +			continue;
> +
> +		cpumask_set_cpu(i, &ioapic_max_cpumask);
> +	}

This is probably not an issue right now, but what if we have > 256 CPUs?
Assuming there are no CPUs with the same APIC is, would it be better to
go through all of them seeting bits in ioapic_max_cpumask accordingly?
(Imagine a situation when CPU257 has APIC id = 1).

> +
> +	return 0;
> +}
> +
> +static int __init hyperv_enable_irq_remapping(void)
> +{
> +	return IRQ_REMAP_X2APIC_MODE;
> +}
> +
> +static struct irq_domain *hyperv_get_ir_irq_domain(struct irq_alloc_info *info)
> +{
> +	if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC)
> +		return ioapic_ir_domain;
> +	else
> +		return NULL;
> +}
> +
> +struct irq_remap_ops hyperv_irq_remap_ops = {
> +	.prepare		= hyperv_prepare_irq_remapping,
> +	.enable			= hyperv_enable_irq_remapping,
> +	.get_ir_irq_domain	= hyperv_get_ir_irq_domain,
> +};
> diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
> index b94ebd4..81cf290 100644
> --- a/drivers/iommu/irq_remapping.c
> +++ b/drivers/iommu/irq_remapping.c
> @@ -103,6 +103,9 @@ int __init irq_remapping_prepare(void)
>  	else if (IS_ENABLED(CONFIG_AMD_IOMMU) &&
>  		 amd_iommu_irq_ops.prepare() == 0)
>  		remap_ops = &amd_iommu_irq_ops;
> +	else if (IS_ENABLED(CONFIG_HYPERV_IOMMU) &&
> +		 hyperv_irq_remap_ops.prepare() == 0)
> +		remap_ops = &hyperv_irq_remap_ops;
>  	else
>  		return -ENOSYS;

Here we act under assumption that Intel/AMD IOMMUs will never be exposed
under Hyper-V. It may make sense to actually reverse the order of the
check: check PV IOMMUs _before_ we actually check for hardware ones.

>  
> diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
> index 0afef6e..f8609e9 100644
> --- a/drivers/iommu/irq_remapping.h
> +++ b/drivers/iommu/irq_remapping.h
> @@ -64,6 +64,7 @@ struct irq_remap_ops {
>  
>  extern struct irq_remap_ops intel_irq_remap_ops;
>  extern struct irq_remap_ops amd_iommu_irq_ops;
> +extern struct irq_remap_ops hyperv_irq_remap_ops;
>  
>  #else  /* CONFIG_IRQ_REMAP */

-- 
Vitaly
