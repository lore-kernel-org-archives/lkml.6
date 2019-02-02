Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16AAC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F132146E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYt+tFGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfBBGCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 01:02:19 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35114 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfBBGCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 01:02:19 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so4331343plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 22:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qRtjlMOi/SJ1W86foIpyHsGDel14pHy8YaLCgR1IgAY=;
        b=HYt+tFGuBOE/5X6UJy6p9g7qk6PbREoi3lIT+qWARBwUi0wk3iKAJ12cA1+H9uKNQP
         jzNuHnb/OjDWsSw434CKGALU6qA7a3VYnzC7CqDRu71kwTGDQqVgErJXBgCdpmlMPNaf
         lyWeCjCnV8ynKNQg6eJitl58EuY6llS6rdVMNbNXwgZWJKdbVd5vOpTOhJvVgWBrXLJy
         aWYXBy5/Kyk2FYQRbWsjcDXzBBsbXju1P5OIKr7sk7yseefTu/+gbhOjDxIsKsO+RCUa
         kTZSFm3JmaXzK0BR0wMl0Phy2czhOgSUl+54iPEYIwJ80kdTwtIisQVdnc5TNlXLOhvX
         /vZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qRtjlMOi/SJ1W86foIpyHsGDel14pHy8YaLCgR1IgAY=;
        b=MP/YOUO79FGY9poFqbh8hm14fB/pLDBB3YoQoEKfHgKfqqrsQyWzQl7JNdXozj4/xT
         1PsojQG2vdsxyP0HClRkqFq5QUxS9jhw+6VtloUzMeG00AcbZFPu4kL9X7EGrHDNK51G
         Y55zDbsq4iyeklj4/mTjUgFwzlKVBtY8Hnwxr6F7kI30/soev9Zg7aDL5xALDRkM4FVW
         7FUkhkKuTAPFFGZCvlppbGULpuWq/kFguSAqehFjZO7qR6jqEKjEkQWehOp6nk7k9pV0
         EyZ++FjW6Ki2l7DSF5rBkSLKd5YuszM6nuz8H7M45RqFgeGWUpfDVCI+XcfgWS+gVphc
         tCXg==
X-Gm-Message-State: AJcUukfvfrYtb5Y41p9hngQk7a6iEkujyaQOH812e1YgC6UVk/rQo8Wy
        mJgyF89gORssmRnCLBbz/RRWxy9qrfs+PGNJ6cY=
X-Google-Smtp-Source: ALg8bN5TUagWc9TArJzkm91jwF4K5BikAfKmRrAKfHJkwcDQTguymSa/lmMgvYNDqWCabz38yPX593nRCWlY3/1o0q4=
X-Received: by 2002:a17:902:bf44:: with SMTP id u4mr43252573pls.5.1549087338103;
 Fri, 01 Feb 2019 22:02:18 -0800 (PST)
MIME-Version: 1.0
References: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1548929853-25877-3-git-send-email-Tianyu.Lan@microsoft.com> <20190201145130.GW3973@sasha-vm>
In-Reply-To: <20190201145130.GW3973@sasha-vm>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Sat, 2 Feb 2019 14:02:06 +0800
Message-ID: <CAOLK0py2EChX7AsZkFNH2kDu1U3BKT5qQ68boGRCzd5kiC2hQQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
To:     Sasha Levin <sashal@kernel.org>
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Joerg Roedel <joro@8bytes.org>, mchehab+samsung@kernel.org,
        davem@davemloft.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, nicolas.ferre@microchip.com,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha:
             Thanks for your review.

On Fri, Feb 1, 2019 at 10:51 PM Sasha Levin <sashal@kernel.org> wrote:
>
> Hi Tianyu,
>
> Few comments below.
>
> On Thu, Jan 31, 2019 at 06:17:32PM +0800, lantianyu1986@gmail.com wrote:
> >From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >
> >On the bare metal, enabling X2APIC mode requires interrupt remapping
> >function which helps to deliver irq to cpu with 32-bit APIC ID.
> >Hyper-V doesn't provide interrupt remapping function so far and Hyper-V
> >MSI protocol already supports to deliver interrupt to the CPU whose
> >virtual processor index is more than 255. IO-APIC interrupt still has
> >8-bit APIC ID limitation.
> >
> >This patch is to add Hyper-V stub IOMMU driver in order to enable
> >X2APIC mode successfully in Hyper-V Linux guest. The driver returns X2AP=
IC
> >interrupt remapping capability when X2APIC mode is available. Otherwise,
> >it creates a Hyper-V irq domain to limit IO-APIC interrupts' affinity
> >and make sure cpus assigned with IO-APIC interrupt have 8-bit APIC ID.
> >
> >Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >---
> > drivers/iommu/Kconfig         |   7 ++
> > drivers/iommu/Makefile        |   1 +
> > drivers/iommu/hyperv-iommu.c  | 189 +++++++++++++++++++++++++++++++++++=
+++++++
> > drivers/iommu/irq_remapping.c |   3 +
> > drivers/iommu/irq_remapping.h |   1 +
> > 5 files changed, 201 insertions(+)
> > create mode 100644 drivers/iommu/hyperv-iommu.c
> >
> >diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> >index 45d7021..5c397c0 100644
> >--- a/drivers/iommu/Kconfig
> >+++ b/drivers/iommu/Kconfig
> >@@ -437,4 +437,11 @@ config QCOM_IOMMU
> >       help
> >         Support for IOMMU on certain Qualcomm SoCs.
> >
> >+config HYPERV_IOMMU
> >+      bool "Hyper-V stub IOMMU support"
> >+      depends on HYPERV
>
>         select IOMMU_API ?

Yes=E3=80=82 will  update.

>
> >+      help
> >+          Hyper-V stub IOMMU driver provides capability to run
> >+          Linux guest with X2APIC mode enabled.
> >+
> > endif # IOMMU_SUPPORT
> >diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> >index a158a68..8c71a15 100644
> >--- a/drivers/iommu/Makefile
> >+++ b/drivers/iommu/Makefile
> >@@ -32,3 +32,4 @@ obj-$(CONFIG_EXYNOS_IOMMU) +=3D exynos-iommu.o
> > obj-$(CONFIG_FSL_PAMU) +=3D fsl_pamu.o fsl_pamu_domain.o
> > obj-$(CONFIG_S390_IOMMU) +=3D s390-iommu.o
> > obj-$(CONFIG_QCOM_IOMMU) +=3D qcom_iommu.o
> >+obj-$(CONFIG_HYPERV_IOMMU) +=3D hyperv-iommu.o
> >diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> >new file mode 100644
> >index 0000000..a64b747
> >--- /dev/null
> >+++ b/drivers/iommu/hyperv-iommu.c
> >@@ -0,0 +1,189 @@
> >+// SPDX-License-Identifier: GPL-2.0
> >+
> >+#define pr_fmt(fmt)     "HYPERV-IR: " fmt
> >+
> >+#include <linux/types.h>
> >+#include <linux/interrupt.h>
> >+#include <linux/irq.h>
> >+#include <linux/iommu.h>
> >+#include <linux/module.h>
> >+
> >+#include <asm/hw_irq.h>
> >+#include <asm/io_apic.h>
> >+#include <asm/irq_remapping.h>
> >+#include <asm/hypervisor.h>
> >+
> >+#include "irq_remapping.h"
> >+
> >+/*
> >+ * According IO-APIC spec, IO APIC has a 24-entry Interrupt
> >+ * Redirection Table.
>
> Can the spec be linked somewhere? In the commit message, or here?

Sure. Will update.

>
> >+ */
> >+#define IOAPIC_REMAPPING_ENTRY 24
> >+
> >+static cpumask_t ioapic_max_cpumask =3D { CPU_BITS_NONE };
> >+struct irq_domain *ioapic_ir_domain;
> >+
> >+static int hyperv_ir_set_affinity(struct irq_data *data,
> >+              const struct cpumask *mask, bool force)
> >+{
> >+      struct irq_data *parent =3D data->parent_data;
> >+      struct irq_cfg *cfg =3D irqd_cfg(data);
> >+      struct IO_APIC_route_entry *entry;
> >+      cpumask_t cpumask;
> >+      int ret;
> >+
> >+      cpumask_andnot(&cpumask, mask, &ioapic_max_cpumask);
> >+
> >+      /* Return error If new irq affinity is out of ioapic_max_cpumask.=
 */
> >+      if (!cpumask_empty(&cpumask))
> >+              return -EINVAL;
> >+
> >+      ret =3D parent->chip->irq_set_affinity(parent, mask, force);
> >+      if (ret < 0 || ret =3D=3D IRQ_SET_MASK_OK_DONE)
> >+              return ret;
> >+
> >+      entry =3D data->chip_data;
> >+      entry->dest =3D cfg->dest_apicid;
> >+      entry->vector =3D cfg->vector;
> >+      send_cleanup_vector(cfg);
> >+
> >+      return 0;
> >+}
> >+
> >+static struct irq_chip hyperv_ir_chip =3D {
> >+      .name                   =3D "HYPERV-IR",
> >+      .irq_ack                =3D apic_ack_irq,
> >+      .irq_set_affinity       =3D hyperv_ir_set_affinity,
> >+};
> >+
> >+static int hyperv_irq_remapping_alloc(struct irq_domain *domain,
> >+                                   unsigned int virq, unsigned int nr_i=
rqs,
> >+                                   void *arg)
> >+{
> >+      struct irq_alloc_info *info =3D arg;
> >+      struct IO_APIC_route_entry *entry;
>
> What's the role of this variable? We set it, once, later on in the
> function but that's all?
>

This one should be removed.

> >+      struct irq_data *irq_data;
> >+      struct irq_desc *desc;
> >+      struct irq_cfg *cfg;
> >+      int ret =3D 0;
> >+
> >+      if (!info || info->type !=3D X86_IRQ_ALLOC_TYPE_IOAPIC || nr_irqs=
 > 1)
> >+              return -EINVAL;
> >+
> >+      ret =3D irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
> >+      if (ret < 0)
> >+              goto fail;
> >+
> >+      irq_data =3D irq_domain_get_irq_data(domain, virq);
> >+      cfg =3D irqd_cfg(irq_data);
>
> Is this actually being used anywhere, or do we only need it for the
> check below? It's not clear from the code why we're calling irqd_cfg()
> and ignoring the result.

Sorry. irqd_cfg() should not be needed here.

>
> >+      if (!irq_data || !cfg) {
>
> You just dereferenced irq_data in the line above this one, it's a bit
> late to check that it's not NULL.
>

OK. Will update.

> >+              ret =3D -EINVAL;
> >+              goto fail;
> >+      }
> >+
> >+      irq_data->chip =3D &hyperv_ir_chip;
> >+
> >+      /*
> >+       * Save IOAPIC entry pointer here in order to set vector and
> >+       * and dest_apicid in the hyperv_irq_remappng_activate()
> >+       * and hyperv_ir_set_affinity(). IOAPIC driver ignores
> >+       * cfg->dest_apicid and cfg->vector when irq remapping
> >+       * mode is enabled. Detail see ioapic_configure_entry().
> >+       */
> >+      irq_data->chip_data =3D entry =3D info->ioapic_entry;
> >+
> >+      /*
> >+       * Hypver-V IO APIC irq affinity should be in the scope of
> >+       * ioapic_max_cpumask because no irq remapping support.
> >+       */
> >+      desc =3D irq_data_to_desc(irq_data);
> >+      cpumask_and(desc->irq_common_data.affinity,
> >+                      desc->irq_common_data.affinity,
> >+                      &ioapic_max_cpumask);
> >+
> >+ fail:
> >+      return ret;
>
> This one doesn't actually free anything?

irq_domain_free_irqs_common() should be called here. Thanks.

>
> >+}
> >+
> >+static void hyperv_irq_remapping_free(struct irq_domain *domain,
> >+                               unsigned int virq, unsigned int nr_irqs)
> >+{
> >+      irq_domain_free_irqs_common(domain, virq, nr_irqs);
> >+}
> >+
> >+static int hyperv_irq_remappng_activate(struct irq_domain *domain,
> >+                        struct irq_data *irq_data, bool reserve)
> >+{
> >+      struct irq_cfg *cfg =3D irqd_cfg(irq_data);
> >+      struct IO_APIC_route_entry *entry =3D irq_data->chip_data;
> >+
> >+      entry->dest =3D cfg->dest_apicid;
> >+      entry->vector =3D cfg->vector;
> >+
> >+      return 0;
> >+}
> >+
> >+static struct irq_domain_ops hyperv_ir_domain_ops =3D {
> >+      .alloc =3D hyperv_irq_remapping_alloc,
> >+      .free =3D hyperv_irq_remapping_free,
> >+      .activate =3D hyperv_irq_remappng_activate,
> >+};
> >+
> >+static int __init hyperv_prepare_irq_remapping(void)
> >+{
> >+      struct fwnode_handle *fn;
> >+      u32 apic_id;
> >+      int i;
> >+
> >+      if (x86_hyper_type !=3D X86_HYPER_MS_HYPERV ||
> >+          !x2apic_supported())
> >+              return -ENODEV;
> >+
> >+      fn =3D irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
> >+      if (!fn)
> >+              return -EFAULT;
>
> Why EFAULT? The only reason irq_domain_alloc_named_id_fwnode() might
> fail is running out of memory.

ENOMEM should be more accurate.

>
> >+
> >+      ioapic_ir_domain =3D
> >+              irq_domain_create_hierarchy(arch_get_ir_parent_domain(),
> >+                              0, IOAPIC_REMAPPING_ENTRY, fn,
> >+                              &hyperv_ir_domain_ops, NULL);
> >+
> >+      irq_domain_free_fwnode(fn);
> >+
> >+      /*
> >+       * Hyper-V doesn't provide irq remapping function for
> >+       * IO-APIC and so IO-APIC only accepts 8-bit APIC ID.
> >+       * Prepare max cpu affinity for IOAPIC irqs. Scan cpu 0-255
> >+       * and set cpu into ioapic_max_cpumask if its APIC ID is less
> >+       * than 255.
>
> Off-by-one here: it'll set the CPU in the affinity mask if it's less
> than 256, not 255.

Yes. will update.

>
> >+       */
> >+      for (i =3D 0; i < 256; i++) {
> >+              apic_id =3D cpu_physical_id(i);
> >+              if (apic_id > 255)
> >+                      continue;
> >+
> >+              cpumask_set_cpu(i, &ioapic_max_cpumask);
> >+      }
>
> I'm curious here: assuming we have a large amount of CPUs, what
> guarantee do we have that this mask will have anything set? What happens
> if it remains empty?

The APIC id of BSP is always 0. The CPU's APIC ID comes from ACPI MADT tabl=
e.
The APIC ID in the ACPI MADT table will be monotone increasing from Hyper-V
team.

>
> >+
> >+      return 0;
> >+}
> >+
> >+static int __init hyperv_enable_irq_remapping(void)
> >+{
> >+      return IRQ_REMAP_X2APIC_MODE;
> >+}
> >+
> >+static struct irq_domain *hyperv_get_ir_irq_domain(struct irq_alloc_inf=
o *info)
> >+{
> >+      if (info->type =3D=3D X86_IRQ_ALLOC_TYPE_IOAPIC)
> >+              return ioapic_ir_domain;
> >+      else
> >+              return NULL;
> >+}
> >+
> >+struct irq_remap_ops hyperv_irq_remap_ops =3D {
> >+      .prepare                =3D hyperv_prepare_irq_remapping,
> >+      .enable                 =3D hyperv_enable_irq_remapping,
> >+      .get_ir_irq_domain      =3D hyperv_get_ir_irq_domain,
> >+};
> >diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping=
.c
> >index b94ebd4..81cf290 100644
> >--- a/drivers/iommu/irq_remapping.c
> >+++ b/drivers/iommu/irq_remapping.c
> >@@ -103,6 +103,9 @@ int __init irq_remapping_prepare(void)
> >       else if (IS_ENABLED(CONFIG_AMD_IOMMU) &&
> >                amd_iommu_irq_ops.prepare() =3D=3D 0)
> >               remap_ops =3D &amd_iommu_irq_ops;
> >+      else if (IS_ENABLED(CONFIG_HYPERV_IOMMU) &&
> >+               hyperv_irq_remap_ops.prepare() =3D=3D 0)
> >+              remap_ops =3D &hyperv_irq_remap_ops;
> >       else
> >               return -ENOSYS;
> >
> >diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping=
.h
> >index 0afef6e..f8609e9 100644
> >--- a/drivers/iommu/irq_remapping.h
> >+++ b/drivers/iommu/irq_remapping.h
> >@@ -64,6 +64,7 @@ struct irq_remap_ops {
> >
> > extern struct irq_remap_ops intel_irq_remap_ops;
> > extern struct irq_remap_ops amd_iommu_irq_ops;
> >+extern struct irq_remap_ops hyperv_irq_remap_ops;
> >
> > #else  /* CONFIG_IRQ_REMAP */
> >
> >--
> >2.7.4
> >



--=20
Best regards
Tianyu Lan
