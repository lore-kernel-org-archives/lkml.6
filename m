Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AEEC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D379520870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEbxJ7bh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfBBGVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 01:21:08 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42284 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfBBGVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 01:21:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so4331038plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 22:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UPf3t3wPa7r8opUS0AryXv3De+X8IP/H8ak+WyBBYXU=;
        b=WEbxJ7bhPqYHUxy03TrgSyzyqLnD7NOoFH+ubUj/crqullDcl7+YfgEzFx2WmR3Pvl
         smMy/CpFPX+cAGSbRf6oUEiWXfWHKVlcrLRqIzluO+LZ/GCPy08weplAEXef0en+esBP
         iAq5g8SQi/mkUJw8wYkwlaEXNgiQ6qiHbBxp3uzK0uJkuFG41dj7p4Ax8Z7qPtupusCP
         jY3nyqG4m8CtzOQJ1jKsyE2apb9LC0WuXoRrbJX6v0ZOxO4SIByyyy7LQ3akwTMxTgs3
         vRP0W02/EN3fLREPAlEiIuctmvRGiCSbZP+Ie40taSGbr+F1H/oOx4VyUQrKQ2SvxPHN
         FcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UPf3t3wPa7r8opUS0AryXv3De+X8IP/H8ak+WyBBYXU=;
        b=Tjr45VU6NCJKI2aSUhhMBKyMpCj/1d4fqivMebRqQoHpuC3JJxyvCoCtx3VxDj2paB
         vUegLG/qhBnQndTitd2Fquu7qt8rqjrqD4qo/LBTdlo9lBSomRtKZ2CD4vXilJ3UzUJh
         WnR18FFCic71kcDl4Mqo9zCBM13aUjm/kxsvtVwM40SchP3OrB2nVBOxdYeYnbZ1GIxp
         4XJERk8ejXkWwEu7hZQRpEbDUso577G8qihcmZ4OqDyhq1pQMzjeJrPuJ2FFdpgGJFqO
         ziJ34Q+RWywViityVB8TY9D0QSstjfU2e7KnCka9quW29FS+3G9FD8GE83h+OWrzW0CJ
         OFkw==
X-Gm-Message-State: AJcUukfwljumJCz4DFuKoAd/7LUh9sFpuFKsvBYgwS0K+QrU5BZH6cJF
        OQxcIV+iyPjwixplgV4hSRgWaCKC4M/lMg5T1lw=
X-Google-Smtp-Source: ALg8bN5RIOVEUQNsZOyPh9P85+ZoUAarjWCBdVIGEGjFPJFVmhHfaWj6BOKM5VuIa1bmKkuwhF8PQU9wKXpPKiF3Rfw=
X-Received: by 2002:a17:902:8d95:: with SMTP id v21mr42838281plo.162.1549088466725;
 Fri, 01 Feb 2019 22:21:06 -0800 (PST)
MIME-Version: 1.0
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1548929853-25877-3-git-send-email-Tianyu.Lan@microsoft.com> <aa7d9f2a-fe80-b825-efe4-cfd9a0c9501d@arm.com>
In-Reply-To: <aa7d9f2a-fe80-b825-efe4-cfd9a0c9501d@arm.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Sat, 2 Feb 2019 14:20:55 +0800
Message-ID: <CAOLK0pz7XH7UtWmdNBazsJi5v9ARH5D2mUMFNhqqoGnbEuEBhw@mail.gmail.com>
Subject: Re: [PATCH 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.ferre@microchip.com,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        michael.h.kelley@microsoft.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        iommu@lists.linux-foundation.org, mchehab+samsung@kernel.org,
        akpm@linux-foundation.org, kys@microsoft.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin:
           Thanks for your review.

On Sat, Feb 2, 2019 at 1:00 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 31/01/2019 10:17, lantianyu1986@gmail.com wrote:
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
>
> AFAICS this is a Hyper-V IOAPIC driver which neither implements nor even
> touches the IOMMU API, so having it in drivers/iommu rather than, say,
> drivers/irqchip seems a bit of a stretch to me :/
>
> Maybe this could be a good push to clean up and properly factor out the
> x86 IRQ remapping stuff, possibly to live somewhere closer to other IRQ
> layer code? I appreciate it's a bit muddied by the major x86 vendors
> both keeping their DMA virtualisation and IRQ virtualisation
> architectures together under one umbrella "IOMMU" spec, but IIRC the
> fact that intel-iommu supports building for !IOMMU_API already causes us
> a bit of grief.
>
> Of course, I'm coming from a particular not-entirely-objective viewpoint
> where DMA remapping (SMMU) code in drivers/iommu, IRQ remapping (ITS)
> code in drivers/irqchip, and the relevant ACPI table handling (IORT) in
> drivers/acpi is the norm, but even though that largely falls out of a
> less-tightly-coupled system architecture it does seem perfectly logical
> either way.

I think the different between arm and x86 about interrupt remapping is
that interrupt remapping
function is provided by IOMMU on x86 while it's provided by GIC or
other component on ARM.
As part of IOMMU on x86, the irq remapping code should be in the IOMMU
driver. if some thing
wrong, please correct me. Thanks.


>
> Robin.
>
> (who has admittedly been drinking the Cambridge water for many years now...)
>
> > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > ---
> >   drivers/iommu/Kconfig         |   7 ++
> >   drivers/iommu/Makefile        |   1 +
> >   drivers/iommu/hyperv-iommu.c  | 189 ++++++++++++++++++++++++++++++++++++++++++
> >   drivers/iommu/irq_remapping.c |   3 +
> >   drivers/iommu/irq_remapping.h |   1 +
> >   5 files changed, 201 insertions(+)
> >   create mode 100644 drivers/iommu/hyperv-iommu.c
> >
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 45d7021..5c397c0 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -437,4 +437,11 @@ config QCOM_IOMMU
> >       help
> >         Support for IOMMU on certain Qualcomm SoCs.
> >
> > +config HYPERV_IOMMU
> > +     bool "Hyper-V stub IOMMU support"
> > +     depends on HYPERV
> > +     help
> > +         Hyper-V stub IOMMU driver provides capability to run
> > +         Linux guest with X2APIC mode enabled.
> > +
> >   endif # IOMMU_SUPPORT
> > diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> > index a158a68..8c71a15 100644
> > --- a/drivers/iommu/Makefile
> > +++ b/drivers/iommu/Makefile
> > @@ -32,3 +32,4 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
> >   obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
> >   obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
> >   obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
> > +obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
> > diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> > new file mode 100644
> > index 0000000..a64b747
> > --- /dev/null
> > +++ b/drivers/iommu/hyperv-iommu.c
> > @@ -0,0 +1,189 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#define pr_fmt(fmt)     "HYPERV-IR: " fmt
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
> > +/*
> > + * According IO-APIC spec, IO APIC has a 24-entry Interrupt
> > + * Redirection Table.
> > + */
> > +#define IOAPIC_REMAPPING_ENTRY 24
> > +
> > +static cpumask_t ioapic_max_cpumask = { CPU_BITS_NONE };
> > +struct irq_domain *ioapic_ir_domain;
> > +
> > +static int hyperv_ir_set_affinity(struct irq_data *data,
> > +             const struct cpumask *mask, bool force)
> > +{
> > +     struct irq_data *parent = data->parent_data;
> > +     struct irq_cfg *cfg = irqd_cfg(data);
> > +     struct IO_APIC_route_entry *entry;
> > +     cpumask_t cpumask;
> > +     int ret;
> > +
> > +     cpumask_andnot(&cpumask, mask, &ioapic_max_cpumask);
> > +
> > +     /* Return error If new irq affinity is out of ioapic_max_cpumask. */
> > +     if (!cpumask_empty(&cpumask))
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
> > +     struct IO_APIC_route_entry *entry;
> > +     struct irq_data *irq_data;
> > +     struct irq_desc *desc;
> > +     struct irq_cfg *cfg;
> > +     int ret = 0;
> > +
> > +     if (!info || info->type != X86_IRQ_ALLOC_TYPE_IOAPIC || nr_irqs > 1)
> > +             return -EINVAL;
> > +
> > +     ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
> > +     if (ret < 0)
> > +             goto fail;
> > +
> > +     irq_data = irq_domain_get_irq_data(domain, virq);
> > +     cfg = irqd_cfg(irq_data);
> > +     if (!irq_data || !cfg) {
> > +             ret = -EINVAL;
> > +             goto fail;
> > +     }
> > +
> > +     irq_data->chip = &hyperv_ir_chip;
> > +
> > +     /*
> > +      * Save IOAPIC entry pointer here in order to set vector and
> > +      * and dest_apicid in the hyperv_irq_remappng_activate()
> > +      * and hyperv_ir_set_affinity(). IOAPIC driver ignores
> > +      * cfg->dest_apicid and cfg->vector when irq remapping
> > +      * mode is enabled. Detail see ioapic_configure_entry().
> > +      */
> > +     irq_data->chip_data = entry = info->ioapic_entry;
> > +
> > +     /*
> > +      * Hypver-V IO APIC irq affinity should be in the scope of
> > +      * ioapic_max_cpumask because no irq remapping support.
> > +      */
> > +     desc = irq_data_to_desc(irq_data);
> > +     cpumask_and(desc->irq_common_data.affinity,
> > +                     desc->irq_common_data.affinity,
> > +                     &ioapic_max_cpumask);
> > +
> > + fail:
> > +     return ret;
> > +}
> > +
> > +static void hyperv_irq_remapping_free(struct irq_domain *domain,
> > +                              unsigned int virq, unsigned int nr_irqs)
> > +{
> > +     irq_domain_free_irqs_common(domain, virq, nr_irqs);
> > +}
> > +
> > +static int hyperv_irq_remappng_activate(struct irq_domain *domain,
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
> > +     .activate = hyperv_irq_remappng_activate,
> > +};
> > +
> > +static int __init hyperv_prepare_irq_remapping(void)
> > +{
> > +     struct fwnode_handle *fn;
> > +     u32 apic_id;
> > +     int i;
> > +
> > +     if (x86_hyper_type != X86_HYPER_MS_HYPERV ||
> > +         !x2apic_supported())
> > +             return -ENODEV;
> > +
> > +     fn = irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
> > +     if (!fn)
> > +             return -EFAULT;
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
> > +      * Prepare max cpu affinity for IOAPIC irqs. Scan cpu 0-255
> > +      * and set cpu into ioapic_max_cpumask if its APIC ID is less
> > +      * than 255.
> > +      */
> > +     for (i = 0; i < 256; i++) {
> > +             apic_id = cpu_physical_id(i);
> > +             if (apic_id > 255)
> > +                     continue;
> > +
> > +             cpumask_set_cpu(i, &ioapic_max_cpumask);
> > +     }
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
> >   extern struct irq_remap_ops intel_irq_remap_ops;
> >   extern struct irq_remap_ops amd_iommu_irq_ops;
> > +extern struct irq_remap_ops hyperv_irq_remap_ops;
> >
> >   #else  /* CONFIG_IRQ_REMAP */
> >
> >



-- 
Best regards
Tianyu Lan
