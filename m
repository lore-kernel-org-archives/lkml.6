Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D019FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CD020873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsX7OS93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfBKITj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:19:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38359 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfBKITj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:19:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so4917868pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 00:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/smVMPMl9GWqxu/Z1LcqGsxNbn7IcBQF9lrgEYBuOs=;
        b=CsX7OS93bwckWPmYZPL9MdjkJdRfG7IpZY/IglVGkeGqElQuJAh8VZxVrRfQsUnHb7
         xR+aTSqm/Gz7U58vHHDKsbBbGNwnxpQM9K80qxE/gtx4J2w4JRjEAuriuyXVh5UNR020
         r4bdVEZffM8iY3TESjYMEB+D/TKmsloNBx5XdqD9Kzwq/m29ZMrVVBR7ECOhkRSIVQGz
         0ngcRvQyTxRjrJIKrkhyg0fzDEfApL/fYVS/JRwGNYwrblMuHWmhYqE0Y01Avkjwd2hm
         /qpYe+cEucgJs6rC/buJlg308UPIwb2W9J1mf/eOrpyV/vc/RB0rUO4PRjjajL1KFalC
         qecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/smVMPMl9GWqxu/Z1LcqGsxNbn7IcBQF9lrgEYBuOs=;
        b=nDgIg3dlNBdI6/lbEUchABjS7T/kHEs3Dv6QPHfWVUkWYxdh+zSYWGZSfMA54WiSu4
         9CYVnudvNLWW2oCiUmuPPgDfMXMR35LRgEMDGC2LZZ3ShL6rD1uH+jxPFAh9T7Cqazqo
         9eOkyuK0tLbVWcex6v7liAU7dX7rzfz3B5BanKGvgzl3JDz6IQFDORIxEHmp2IF9XYIW
         p6+BsvXCra0g5b85k5Uh73CqQHQKmd4n2UW2U70hRfl+AbXWl9Yo71NvAG2uG+QDo6yK
         H68Ilh/EfgX+8/zIziC4qbE1pIoelzkVOeqqh97cn5IHOK/8CIMdsfTMB3AxHvQ6PXyb
         I7UA==
X-Gm-Message-State: AHQUAuZtq+JgCtv6DbgfPLz5v8UHR2PPqsgfqOTM+BcBmSA+PJlh/ROP
        hLqHcEyp5od9Z4bWUCJ1g+um+dRoswvoXtKQVM8=
X-Google-Smtp-Source: AHgI3IbLiJ3nHZB+eY5ej5G1zrGoNb7z4ujaWPFrtC/kbKB5Pyn5RKGlU5qEH1+A0wDrpV83fwdbdkwxiv0QCJkbCO0=
X-Received: by 2002:a63:da14:: with SMTP id c20mr31311916pgh.233.1549873178454;
 Mon, 11 Feb 2019 00:19:38 -0800 (PST)
MIME-Version: 1.0
References: <1549553629-8414-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1549553629-8414-3-git-send-email-Tianyu.Lan@microsoft.com> <87a7j7wmd8.fsf@vitty.brq.redhat.com>
In-Reply-To: <87a7j7wmd8.fsf@vitty.brq.redhat.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Mon, 11 Feb 2019 16:19:27 +0800
Message-ID: <CAOLK0pwByr2YpVw1j5mx0xXQtmQ6M-sW_Sv3N3-3zot3gSMJXA@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Joerg Roedel <joro@8bytes.org>, mchehab+samsung@kernel.org,
        davem@davemloft.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.ferre@microchip.com, Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 1:15 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> lantianyu1986@gmail.com writes:
>
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >
> > On the bare metal, enabling X2APIC mode requires interrupt remapping
> > function which helps to deliver irq to cpu with 32-bit APIC ID.
> > Hyper-V doesn't provide interrupt remapping function so far and Hyper-V
> > MSI protocol already supports to deliver interrupt to the CPU whose
> > virtual processor index is more than 255. IO-APIC interrupt still has
> > 8-bit APIC ID limitation.
> >
> > This patch is to add Hyper-V stub IOMMU driver in order to enable
> > X2APIC mode successfully in Hyper-V Linux guest. The driver returns X2APIC
> > interrupt remapping capability when X2APIC mode is available. Otherwise,
> > it creates a Hyper-V irq domain to limit IO-APIC interrupts' affinity
> > and make sure cpus assigned with IO-APIC interrupt have 8-bit APIC ID.
> >
> > Define 24 IO-APIC remapping entries because Hyper-V only expose one
> > single IO-APIC and one IO-APIC has 24 pins according IO-APIC spec(
> > https://pdos.csail.mit.edu/6.828/2016/readings/ia32/ioapic.pdf).
> >
> > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > ---
> > Change since v2:
> >        - Improve comment about why save IO-APIC entry in the irq chip data.
> >        - Some code improvement.
> >        - Improve statement in the IOMMU Kconfig.
> >
> > Change since v1:
> >       - Remove unused pr_fmt
> >       - Make ioapic_ir_domain as static variable
> >       - Remove unused variables cfg and entry in the hyperv_irq_remapping_alloc()
> >       - Fix comments
> > ---
> >  drivers/iommu/Kconfig         |   8 ++
> >  drivers/iommu/Makefile        |   1 +
> >  drivers/iommu/hyperv-iommu.c  | 194 ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/iommu/irq_remapping.c |   3 +
> >  drivers/iommu/irq_remapping.h |   1 +
> >  5 files changed, 207 insertions(+)
> >  create mode 100644 drivers/iommu/hyperv-iommu.c
> >
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 45d7021..6090935 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -437,4 +437,12 @@ config QCOM_IOMMU
> >       help
> >         Support for IOMMU on certain Qualcomm SoCs.
> >
> > +config HYPERV_IOMMU
> > +     bool "Hyper-V x2APIC IRQ Handling"
> > +     depends on HYPERV
> > +     select IOMMU_API
> > +     help
> > +       Stub IOMMU driver to handle IRQs as to allow Hyper-V Linux
> > +       guests to run with x2APIC mode enabled.
> > +
> >  endif # IOMMU_SUPPORT
> > diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> > index a158a68..8c71a15 100644
> > --- a/drivers/iommu/Makefile
> > +++ b/drivers/iommu/Makefile
> > @@ -32,3 +32,4 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
> >  obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
> >  obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
> >  obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
> > +obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
> > diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> > new file mode 100644
> > index 0000000..d8572c5
> > --- /dev/null
> > +++ b/drivers/iommu/hyperv-iommu.c
> > @@ -0,0 +1,194 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Hyper-V stub IOMMU driver.
> > + *
> > + * Copyright (C) 2019, Microsoft, Inc.
> > + *
> > + * Author : Lan Tianyu <Tianyu.Lan@microsoft.com>
> > + */
> > +
> > +#include <linux/types.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/iommu.h>
> > +#include <linux/module.h>
> > +
> > +#include <asm/hw_irq.h>
> > +#include <asm/io_apic.h>
> > +#include <asm/irq_remapping.h>
> > +#include <asm/hypervisor.h>
> > +
> > +#include "irq_remapping.h"
> > +
> > +#ifdef CONFIG_IRQ_REMAP
> > +
> > +/*
> > + * According 82093AA IO-APIC spec , IO APIC has a 24-entry Interrupt
> > + * Redirection Table. Hyper-V exposes one single IO-APIC and so define
> > + * 24 IO APIC remmapping entries.
> > + */
> > +#define IOAPIC_REMAPPING_ENTRY 24
> > +
> > +static cpumask_t ioapic_max_cpumask = { CPU_BITS_NONE };
> > +static struct irq_domain *ioapic_ir_domain;
> > +
> > +static int hyperv_ir_set_affinity(struct irq_data *data,
> > +             const struct cpumask *mask, bool force)
> > +{
> > +     struct irq_data *parent = data->parent_data;
> > +     struct irq_cfg *cfg = irqd_cfg(data);
> > +     struct IO_APIC_route_entry *entry;
> > +     int ret;
> > +
> > +     /* Return error If new irq affinity is out of ioapic_max_cpumask. */
> > +     if (!cpumask_subset(mask, &ioapic_max_cpumask))
> > +             return -EINVAL;
> > +
> > +     ret = parent->chip->irq_set_affinity(parent, mask, force);
> > +     if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
> > +             return ret;
> > +
> > +     entry = data->chip_data;
> > +     entry->dest = cfg->dest_apicid;
> > +     entry->vector = cfg->vector;
> > +     send_cleanup_vector(cfg);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct irq_chip hyperv_ir_chip = {
> > +     .name                   = "HYPERV-IR",
> > +     .irq_ack                = apic_ack_irq,
> > +     .irq_set_affinity       = hyperv_ir_set_affinity,
> > +};
> > +
> > +static int hyperv_irq_remapping_alloc(struct irq_domain *domain,
> > +                                  unsigned int virq, unsigned int nr_irqs,
> > +                                  void *arg)
> > +{
> > +     struct irq_alloc_info *info = arg;
> > +     struct irq_data *irq_data;
> > +     struct irq_desc *desc;
> > +     int ret = 0;
> > +
> > +     if (!info || info->type != X86_IRQ_ALLOC_TYPE_IOAPIC || nr_irqs > 1)
> > +             return -EINVAL;
> > +
> > +     ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     irq_data = irq_domain_get_irq_data(domain, virq);
> > +     if (!irq_data) {
> > +             irq_domain_free_irqs_common(domain, virq, nr_irqs);
> > +             return -EINVAL;
> > +     }
> > +
> > +     irq_data->chip = &hyperv_ir_chip;
> > +
> > +     /*
> > +      * If there is interrupt remapping function of IOMMU, setting irq
> > +      * affinity only needs to change IRTE of IOMMU. But Hyper-V doesn't
> > +      * support interrupt remapping function, setting irq affinity of IO-APIC
> > +      * interrupts still needs to change IO-APIC registers. But ioapic_
> > +      * configure_entry() will ignore value of cfg->vector and cfg->
> > +      * dest_apicid when IO-APIC's parent irq domain is not the vector
> > +      * domain.(See ioapic_configure_entry()) In order to setting vector
> > +      * and dest_apicid to IO-APIC register, IO-APIC entry pointer is saved
> > +      * in the chip_data and hyperv_irq_remapping_activate()/hyperv_ir_set_
> > +      * affinity() set vector and dest_apicid directly into IO-APIC entry.
> > +      */
> > +     irq_data->chip_data = info->ioapic_entry;
> > +
> > +     /*
> > +      * Hypver-V IO APIC irq affinity should be in the scope of
> > +      * ioapic_max_cpumask because no irq remapping support.
> > +      */
> > +     desc = irq_data_to_desc(irq_data);
> > +     cpumask_copy(desc->irq_common_data.affinity, &ioapic_max_cpumask);
> > +
> > +     return 0;
> > +}
> > +
> > +static void hyperv_irq_remapping_free(struct irq_domain *domain,
> > +                              unsigned int virq, unsigned int nr_irqs)
> > +{
> > +     irq_domain_free_irqs_common(domain, virq, nr_irqs);
> > +}
> > +
> > +static int hyperv_irq_remapping_activate(struct irq_domain *domain,
> > +                       struct irq_data *irq_data, bool reserve)
> > +{
> > +     struct irq_cfg *cfg = irqd_cfg(irq_data);
> > +     struct IO_APIC_route_entry *entry = irq_data->chip_data;
> > +
> > +     entry->dest = cfg->dest_apicid;
> > +     entry->vector = cfg->vector;
> > +
> > +     return 0;
> > +}
> > +
> > +static struct irq_domain_ops hyperv_ir_domain_ops = {
> > +     .alloc = hyperv_irq_remapping_alloc,
> > +     .free = hyperv_irq_remapping_free,
> > +     .activate = hyperv_irq_remapping_activate,
> > +};
> > +
> > +static int __init hyperv_prepare_irq_remapping(void)
> > +{
> > +     struct fwnode_handle *fn;
> > +     int i;
> > +
> > +     if (!hypervisor_is_type(x86_hyper_type) ||
>
> I think this should be
>
> if (hypervisor_is_type(X86_HYPER_MS_HYPERV))

Sorry for oops and will fix in the next version. Thanks.

>
> > +         !x2apic_supported())
> > +             return -ENODEV;
> > +
> > +     fn = irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
> > +     if (!fn)
> > +             return -ENOMEM;
> > +
> > +     ioapic_ir_domain =
> > +             irq_domain_create_hierarchy(arch_get_ir_parent_domain(),
> > +                             0, IOAPIC_REMAPPING_ENTRY, fn,
> > +                             &hyperv_ir_domain_ops, NULL);
> > +
> > +     irq_domain_free_fwnode(fn);
> > +
> > +     /*
> > +      * Hyper-V doesn't provide irq remapping function for
> > +      * IO-APIC and so IO-APIC only accepts 8-bit APIC ID.
> > +      * Cpu's APIC ID is read from ACPI MADT table and APIC IDs
> > +      * in the MADT table on Hyper-v are sorted monotonic increasingly.
> > +      * APIC ID reflects cpu topology. There maybe some APIC ID
> > +      * gaps when cpu number in a socket is not power of two. Prepare
> > +      * max cpu affinity for IOAPIC irqs. Scan cpu 0-255 and set cpu
> > +      * into ioapic_max_cpumask if its APIC ID is less than 256.
> > +      */
> > +     for (i = 0; i < 256; i++)
> > +             if (cpu_physical_id(i) < 256)
> > +                     cpumask_set_cpu(i, &ioapic_max_cpumask);
> > +
> > +     return 0;
> > +}
> > +
> > +static int __init hyperv_enable_irq_remapping(void)
> > +{
> > +     return IRQ_REMAP_X2APIC_MODE;
> > +}
> > +
> > +static struct irq_domain *hyperv_get_ir_irq_domain(struct irq_alloc_info *info)
> > +{
> > +     if (info->type == X86_IRQ_ALLOC_TYPE_IOAPIC)
> > +             return ioapic_ir_domain;
> > +     else
> > +             return NULL;
> > +}
> > +
> > +struct irq_remap_ops hyperv_irq_remap_ops = {
> > +     .prepare                = hyperv_prepare_irq_remapping,
> > +     .enable                 = hyperv_enable_irq_remapping,
> > +     .get_ir_irq_domain      = hyperv_get_ir_irq_domain,
> > +};
> > +
> > +#endif
> > diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
> > index b94ebd4..81cf290 100644
> > --- a/drivers/iommu/irq_remapping.c
> > +++ b/drivers/iommu/irq_remapping.c
> > @@ -103,6 +103,9 @@ int __init irq_remapping_prepare(void)
> >       else if (IS_ENABLED(CONFIG_AMD_IOMMU) &&
> >                amd_iommu_irq_ops.prepare() == 0)
> >               remap_ops = &amd_iommu_irq_ops;
> > +     else if (IS_ENABLED(CONFIG_HYPERV_IOMMU) &&
> > +              hyperv_irq_remap_ops.prepare() == 0)
> > +             remap_ops = &hyperv_irq_remap_ops;
> >       else
> >               return -ENOSYS;
> >
> > diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
> > index 0afef6e..f8609e9 100644
> > --- a/drivers/iommu/irq_remapping.h
> > +++ b/drivers/iommu/irq_remapping.h
> > @@ -64,6 +64,7 @@ struct irq_remap_ops {
> >
> >  extern struct irq_remap_ops intel_irq_remap_ops;
> >  extern struct irq_remap_ops amd_iommu_irq_ops;
> > +extern struct irq_remap_ops hyperv_irq_remap_ops;
> >
> >  #else  /* CONFIG_IRQ_REMAP */
>
> --
> Vitaly



-- 
Best regards
Tianyu Lan
