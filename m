Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8EEC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 07:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF6C20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 07:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EGaSWFJB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bvxArwO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF6C20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeJWQHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 12:07:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43798 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbeJWQHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 12:07:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 969FE6021A; Tue, 23 Oct 2018 07:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540280741;
        bh=kmXqwHARdD6bdyLK8X2ly2tegMqi+eAwPBrLnKglfsk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EGaSWFJBLNCv1XwzEf7MKcK3DnbZknC4UUwRCdLgKXoAEDjlA3FfCDwg6ZwMuUphh
         nPeDFxKvcFiaGXJrTKhfjoRCrHTqhn1tp0rx2sPbfamy0ODXya7ppp8yVhLby8kmrZ
         PXLBOJ8k3/wH1QbewnKcMSy2lF3NwopotLEUBo6M=
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 86E1C6021A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 07:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540280740;
        bh=kmXqwHARdD6bdyLK8X2ly2tegMqi+eAwPBrLnKglfsk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bvxArwO54hu06k6JVtuFWSDiMim6Hw+nFcEGdr8Tkdtfx6U+sDjRguiANtR41dkrH
         Goxhjc5qnsIFiOldMkT3xyZw6re3gTPKxQPCJ+rCPWsxilu7YSCN5+6NB7F2EiORA1
         W/zU71fpDgKrp7F0fugaDTEhi5JnNf2nS/12xCzg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86E1C6021A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f173.google.com with SMTP id a193-v6so208392qkc.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 00:45:40 -0700 (PDT)
X-Gm-Message-State: ABuFfoiU8BWVLhSafqjvX9LkuuUkL21/emPHWatBFHipGsMdIfLEolv6
        j32K0Fu58i2cKwKz5QVAo1Qqzafxuq6Y3BR34JA=
X-Google-Smtp-Source: ACcGV63f0cXDd4CH3KdykQb1w/haE3BTVf2xAlZ/SNo8lg6B87uU8034AUKe9280WRKPwFThu86rcNAhq0qVjhNQtLo=
X-Received: by 2002:a37:4952:: with SMTP id w79-v6mr45071017qka.85.1540280739774;
 Tue, 23 Oct 2018 00:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180910062551.28175-1-vivek.gautam@codeaurora.org>
 <20180910062551.28175-5-vivek.gautam@codeaurora.org> <29fd7e9e-708b-b884-4de1-ecc141f41692@arm.com>
In-Reply-To: <29fd7e9e-708b-b884-4de1-ecc141f41692@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Tue, 23 Oct 2018 13:15:27 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEUOukwPzerEKXgk900uR=GwN1AopG6Lpcz=f1Oawu-Yw@mail.gmail.com>
Message-ID: <CAFp+6iEUOukwPzerEKXgk900uR=GwN1AopG6Lpcz=f1Oawu-Yw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iommu/arm-smmu: Add support to handle Qcom's TLBI
 serialization errata
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        Andy Gross <andy.gross@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        David Brown <david.brown@linaro.org>, swboyd@chromium.org,
        open list <linux-kernel@vger.kernel.org>,
        pratikp@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Tue, Sep 25, 2018 at 6:01 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 10/09/18 07:25, Vivek Gautam wrote:
> > Qcom's implementation of arm,mmu-500 require to serialize all
> > TLB invalidations for context banks.
>
> What does "serailize all TLB invalidations" actually mean, because it's
> not entirely clear from context, and furthermore this patch appears to
> behave subtly differently to the downstream code so I'm really
> struggling to figure out whether it's actually doing what it's intended
> to do.

Adding Pratik Patel from downstream team.

Thanks for taking a look at this.
We want to space out the TLB invalidation and then the workaround
to toggle wait-safe logic would let the safe checks in HW work and
only allow invalidation to occur when device is expected to not
run into underruns.

> > In case the TLB invalidation requests don't go through the first
> > time, there's a way to disable/enable the wait for safe logic.
> > Disabling this logic expadites the TLBIs.
> >
> > Different bootloaders with their access control policies allow this
> > register access differntly. With one, we should be able to directly
> > make qcom-scm call to do io read/write, while with other we should
> > use the specific SCM command to send request to do the complete
> > register configuration.
> > A separate device tree flag for arm-smmu will allow to identify
> > which firmware configuration of the two mentioned above we use.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > ---
> >   drivers/iommu/arm-smmu-regs.h |   2 +
> >   drivers/iommu/arm-smmu.c      | 133 +++++++++++++++++++++++++++++++++=
++++++++-
> >   2 files changed, 133 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-reg=
s.h
> > index a1226e4ab5f8..71662cae9806 100644
> > --- a/drivers/iommu/arm-smmu-regs.h
> > +++ b/drivers/iommu/arm-smmu-regs.h
> > @@ -177,6 +177,8 @@ enum arm_smmu_s2cr_privcfg {
> >   #define ARM_SMMU_CB_ATS1PR          0x800
> >   #define ARM_SMMU_CB_ATSR            0x8f0
> >
> > +#define ARM_SMMU_GID_QCOM_CUSTOM_CFG 0x300
> > +
> >   #define SCTLR_S1_ASIDPNE            (1 << 12)
> >   #define SCTLR_CFCFG                 (1 << 7)
> >   #define SCTLR_CFIE                  (1 << 6)
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 411e5ac57c64..de9c4a5bf686 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -49,6 +49,7 @@
> >   #include <linux/pci.h>
> >   #include <linux/platform_device.h>
> >   #include <linux/pm_runtime.h>
> > +#include <linux/qcom_scm.h>
> >   #include <linux/slab.h>
> >   #include <linux/spinlock.h>
> >
> > @@ -181,7 +182,8 @@ struct arm_smmu_device {
> >   #define ARM_SMMU_FEAT_EXIDS         (1 << 12)
> >       u32                             features;
> >
> > -#define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
> > +#define ARM_SMMU_OPT_SECURE_CFG_ACCESS        (1 << 0)
> > +#define ARM_SMMU_OPT_QCOM_FW_IMPL_ERRATA (1 << 1)
> >       u32                             options;
> >       enum arm_smmu_arch_version      version;
> >       enum arm_smmu_implementation    model;
> > @@ -266,6 +268,7 @@ static bool using_legacy_binding, using_generic_bin=
ding;
> >
> >   static struct arm_smmu_option_prop arm_smmu_options[] =3D {
> >       { ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-acc=
ess" },
> > +     { ARM_SMMU_OPT_QCOM_FW_IMPL_ERRATA, "qcom,smmu-500-fw-impl-errata=
" },
> >       { 0, NULL},
> >   };
> >
> > @@ -531,12 +534,134 @@ static void arm_smmu_tlb_inv_vmid_nosync(unsigne=
d long iova, size_t size,
> >       writel_relaxed(smmu_domain->cfg.vmid, base + ARM_SMMU_GR0_TLBIVMI=
D);
> >   }
> >
> > +#define CUSTOM_CFG_MDP_SAFE_ENABLE           BIT(15)
> > +#define CUSTOM_CFG_IFE1_SAFE_ENABLE          BIT(14)
> > +#define CUSTOM_CFG_IFE0_SAFE_ENABLE          BIT(13)
> > +
> > +static int __qsmmu500_wait_safe_toggle(struct arm_smmu_device *smmu, i=
nt en)
> > +{
> > +     int ret;
> > +     u32 val, gid_phys_base;
> > +     phys_addr_t reg;
> > +     struct vm_struct *vm;
> > +
> > +     /* We want physical address of SMMU, so the vm_area */
> > +     vm =3D find_vm_area(smmu->base);
> > +
> > +     /*
> > +      * GID (implementation defined address space) is located at
> > +      * SMMU_BASE + (2 =C3=97 PAGESIZE).
> > +      */
> > +     gid_phys_base =3D vm->phys_addr + (2 << (smmu)->pgshift);
> > +     reg =3D gid_phys_base + ARM_SMMU_GID_QCOM_CUSTOM_CFG;
> > +
> > +     ret =3D qcom_scm_io_readl_atomic(reg, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (en)
> > +             val |=3D CUSTOM_CFG_MDP_SAFE_ENABLE |
> > +                    CUSTOM_CFG_IFE0_SAFE_ENABLE |
> > +                    CUSTOM_CFG_IFE1_SAFE_ENABLE;
> > +     else
> > +             val &=3D ~(CUSTOM_CFG_MDP_SAFE_ENABLE |
> > +                      CUSTOM_CFG_IFE0_SAFE_ENABLE |
> > +                      CUSTOM_CFG_IFE1_SAFE_ENABLE);
> > +
> > +     ret =3D qcom_scm_io_writel_atomic(reg, val);
> > +
> > +     return ret;
> > +}
> > +
> > +static int qsmmu500_wait_safe_toggle(struct arm_smmu_device *smmu,
> > +                                  int en, bool is_fw_impl)
> > +{
> > +     if (is_fw_impl)
> > +             return qcom_scm_qsmmu500_wait_safe_toggle(en);
> > +     else
> > +             return __qsmmu500_wait_safe_toggle(smmu, en);
> > +}
> > +
> > +static void qcom_errata_tlb_sync(struct arm_smmu_domain *smmu_domain)
> > +{
> > +     struct arm_smmu_device *smmu =3D smmu_domain->smmu;
> > +     void __iomem *base =3D ARM_SMMU_CB(smmu, smmu_domain->cfg.cbndx);
> > +     bool is_fw_impl;
> > +     u32 val;
> > +
> > +     writel_relaxed(0, base + ARM_SMMU_CB_TLBSYNC);
> > +
> > +     if (!readl_poll_timeout_atomic(base + ARM_SMMU_CB_TLBSTATUS, val,
> > +                                    !(val & sTLBGSTATUS_GSACTIVE), 0, =
100))
> > +             return;
> > +
> > +     is_fw_impl =3D smmu->options & ARM_SMMU_OPT_QCOM_FW_IMPL_ERRATA ?
> > +                     true : false;
> > +
> > +     /* SCM call here to disable the wait-for-safe logic. */
>
> I take it this is a global state, so it can't just be turned off for the
> relevant contexts and left that way?

Yes this is a global state disable/enable. But can we disable it for
the required context altogether forever, I will have to find it out.

>
> > +     if (WARN(qsmmu500_wait_safe_toggle(smmu, false, is_fw_impl),
> > +              "Failed to disable wait-safe logic, bad hw state\n"))
> > +             return;
> > +
> > +     if (!readl_poll_timeout_atomic(base + ARM_SMMU_CB_TLBSTATUS, val,
> > +                                    !(val & sTLBGSTATUS_GSACTIVE), 0, =
10000))
> > +             return;
> > +
> > +     /* SCM call here to re-enable the wait-for-safe logic. */
> > +     WARN(qsmmu500_wait_safe_toggle(smmu, true, is_fw_impl),
> > +          "Failed to re-enable wait-safe logic, bad hw state\n");
> > +
> > +     dev_err_ratelimited(smmu->dev,
> > +                         "TLB sync timed out -- SMMU in bad state\n");
> > +}
> > +
> > +static void qcom_errata_tlb_sync_context(void *cookie)
> > +{
> > +     struct arm_smmu_domain *smmu_domain =3D cookie;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&smmu_domain->cb_lock, flags);
> > +     qcom_errata_tlb_sync(smmu_domain);
> > +     spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
> > +}
> > +
> > +static void qcom_errata_tlb_inv_context_s1(void *cookie)
> > +{
> > +     struct arm_smmu_domain *smmu_domain =3D cookie;
> > +     struct arm_smmu_cfg *cfg =3D &smmu_domain->cfg;
> > +     void __iomem *base =3D ARM_SMMU_CB(smmu_domain->smmu, cfg->cbndx)=
;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&smmu_domain->cb_lock, flags);
> > +     writel_relaxed(cfg->asid, base + ARM_SMMU_CB_S1_TLBIASID);
> > +     qcom_errata_tlb_sync(cookie);
> > +     spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
> > +}
> > +
> > +static void qcom_errata_tlb_inv_range_nosync(unsigned long iova, size_=
t size,
> > +                                          size_t granule, bool leaf,
> > +                                          void *cookie)
> > +{
> > +     struct arm_smmu_domain *smmu_domain =3D cookie;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&smmu_domain->cb_lock, flags);
> > +     arm_smmu_tlb_inv_range_nosync(iova, size, granule, leaf, cookie);
> > +     spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
>
> I don't get what this locking is trying to achieve - the only thing it
> protects is one or more writes to TLBIVA{L}, which *must* surely be
> "serialised" by the interconnect anyway?
>

Okay, right. This callback is just a write to TLBIVA{L} registers, so this
should be good without any locking.
A subsequent .tlb_sync has the locking anyways.

> The downstream code doesn't appear to implement .tlb_add_flush at all,
> so something smells off.

Yes, the downstream pg-table driver never uses tlb_add_flush and
tlb_sync to do TLBIs.
Rather it relies on tlb_flush_all to flush the entire TLB after the
unmap is finished.
Moreover, in downstream a global remote spinlock is used to protect
the invalidation
requests owing to other entities besides kernel handling the TLB operations=
.

Assuming we don't want to do tlb_flush_all, we still want to serialize
the invalidation
requests, and then toggle the wait-safe logic too.
We would also not want the remote spinlock as we are invalidating based on =
ASIDs
in the kernel.

Regards
Vivek

>
> Robin.
>
> > +}
> > +
> >   static const struct iommu_gather_ops arm_smmu_s1_tlb_ops =3D {
> >       .tlb_flush_all  =3D arm_smmu_tlb_inv_context_s1,
> >       .tlb_add_flush  =3D arm_smmu_tlb_inv_range_nosync,
> >       .tlb_sync       =3D arm_smmu_tlb_sync_context,
> >   };
> >
> > +static const struct iommu_gather_ops qcom_errata_s1_tlb_ops =3D {
> > +     .tlb_flush_all  =3D qcom_errata_tlb_inv_context_s1,
> > +     .tlb_add_flush  =3D qcom_errata_tlb_inv_range_nosync,
> > +     .tlb_sync       =3D qcom_errata_tlb_sync_context,
> > +};
> > +
> >   static const struct iommu_gather_ops arm_smmu_s2_tlb_ops_v2 =3D {
> >       .tlb_flush_all  =3D arm_smmu_tlb_inv_context_s2,
> >       .tlb_add_flush  =3D arm_smmu_tlb_inv_range_nosync,
> > @@ -824,7 +949,11 @@ static int arm_smmu_init_domain_context(struct iom=
mu_domain *domain,
> >                       ias =3D min(ias, 32UL);
> >                       oas =3D min(oas, 32UL);
> >               }
> > -             smmu_domain->tlb_ops =3D &arm_smmu_s1_tlb_ops;
> > +             if (of_device_is_compatible(smmu->dev->of_node,
> > +                                         "qcom,sdm845-smmu-500"))
> > +                     smmu_domain->tlb_ops =3D &qcom_errata_s1_tlb_ops;
> > +             else
> > +                     smmu_domain->tlb_ops =3D &arm_smmu_s1_tlb_ops;
> >               break;
> >       case ARM_SMMU_DOMAIN_NESTED:
> >               /*
> >
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



--=20
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
