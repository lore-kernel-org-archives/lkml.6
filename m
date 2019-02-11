Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC346C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C6220863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/Skj5b6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfBKIKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:10:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41868 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKIKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:10:52 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so4902810pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 00:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YOup/o569sw/hiGdSHNEtw+CT6Xaq/EoVGVzK1HrB0Y=;
        b=j/Skj5b61K+0HADM9VSdmG5YwKfPpuBJdjnPRumYPMwiAyI/pdcYbpfPeb8dJDKTIa
         pXo0wJmdQFza3ULLBUT/1MOWIHd1VUh9FN7j83+biJ2ybvlqqTL1voggbVpMLn+3aaTl
         aPpQgLhSnsmJFes1aPROew56Z6Y8JWDCC+zr6Behugw8mkg5KT5Zdw1wxRtBtgRxr4Jh
         bFsqe3G/hUInoNH7PCS81uX25gANEqxkooRHgZcWTyfyztm7nTfKRQjPcQPjVgCN2Azp
         pGs62umTntmls70A62ATEEwHQq5YUHRaxGyFsXrXksGjGxdCRBE4g/Ki2fBftGLxbhnq
         lDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOup/o569sw/hiGdSHNEtw+CT6Xaq/EoVGVzK1HrB0Y=;
        b=k3NWA3fKrjl4Vg1SKXEu8TivnidsORR7qwiD/mW3ecxTBB/PQFfmEyZ2L7hcGwhqUH
         ppSwH1ia/kuJu1GZAG0NdhufzkPr7xSm3zf38sidzLzqyXvsRdtNEnlRvcImhZyHx9VL
         wYYJ4w0+e2oDLJxB2LgJYdh8uFlhBNN7eJaxqrRr7Yi3nkEPeFCwUbHG+fJa6zY3yH6a
         ByrtdZOxVS3WLW6JDrYi+9YzXr2RNvY3wYeDEkF/Cmt/wc2m+9slmWrWVQq7wORKbPJ/
         QJ2643IGwLxT7Ljrq7qga83VNqwkazUEVfJWpMrOrX/NPJZCFLybhP/65psbOeFF+uL9
         fuRA==
X-Gm-Message-State: AHQUAuZPkFNavbUkxjZ9L9NZqWzketeisSuGAA6G2LuELBesaQCddotR
        8UDEEghsJzgwvPAxgVE0ZPQmouQDVDmrlRlvlXc=
X-Google-Smtp-Source: AHgI3Ib9Z33Fgu2ECXvOluu6fgpIQ09TP/c+smtGsPCc7u8H43KW6w7gvcLg4b0Yjyc7HCQwVJkzUVECtVTVxYtHLD4=
X-Received: by 2002:a63:d70e:: with SMTP id d14mr32575765pgg.159.1549872651653;
 Mon, 11 Feb 2019 00:10:51 -0800 (PST)
MIME-Version: 1.0
References: <1549553629-8414-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1549553629-8414-3-git-send-email-Tianyu.Lan@microsoft.com> <20190207111514.425d137b@w520.home>
In-Reply-To: <20190207111514.425d137b@w520.home>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Mon, 11 Feb 2019 16:10:40 +0800
Message-ID: <CAOLK0pyAn6FrzF_518XhwTJ3ptq=wQXZ2NV+=nEPwF5tvbYD2A@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Joerg Roedel <joro@8bytes.org>, mchehab+samsung@kernel.org,
        davem@davemloft.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.ferre@microchip.com, Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex:
            Thanks for your review.

On Fri, Feb 8, 2019 at 2:15 AM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Thu,  7 Feb 2019 23:33:48 +0800
> lantianyu1986@gmail.com wrote:
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
> ...
> > diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> > new file mode 100644
> > index 0000000..d8572c5
> > --- /dev/null
> > +++ b/drivers/iommu/hyperv-iommu.c
> ...
> > +static int __init hyperv_prepare_irq_remapping(void)
> > +{
> > +     struct fwnode_handle *fn;
> > +     int i;
> > +
> > +     if (!hypervisor_is_type(x86_hyper_type) ||
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
>
> This looks sketchy.  What if NR_CPUS is less than 256?  Thanks,

Nice catch. I should check NR_CPUS here. Will update. Thanks.


-- 
Best regards
Tianyu Lan
