Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C101C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3EF2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FhLaD3xp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bhrVgwiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3EF2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436590AbeKVWlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:41:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52034 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbeKVWlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:41:47 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F141360710; Thu, 22 Nov 2018 12:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542888161;
        bh=gmZwPK792OsEBQCLpAfUmDtrynLU/JgtlXthlx+rVnA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FhLaD3xptDI0Ox/F9T2T8f1Hj/dTKrrrveKVcr8Ro0JkBtbiqhBCSISgrGgW2OHj9
         9iRyM7HM0DUQB1O0vfi1gtLg3jYZkHD/WKVToMyCM2M9J/CysZ5t+7mAfy3Au2xHA9
         GI5iebdhH6KU1C5U78M9L9xAjOztJOw9v1BI6OKw=
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B3132607B5;
        Thu, 22 Nov 2018 12:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542888159;
        bh=gmZwPK792OsEBQCLpAfUmDtrynLU/JgtlXthlx+rVnA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bhrVgwiJ1OHG3i2jj9f2nW9uDlNqzlhSv97pTgJFYxZSCgR4ZlO1mHsLttaKnYRo6
         7Ax3q1v5YVF6MFgHdDnPZetehfpSvj88pp6wMx5evN8Zqvrqq7H4ZKJHElTaskWxxY
         YiVTdVcxrKNAyA2THvGelPyCYoyVMotzFiYR+u7w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3132607B5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt1-f169.google.com with SMTP id n21so7154640qtl.6;
        Thu, 22 Nov 2018 04:02:38 -0800 (PST)
X-Gm-Message-State: AGRZ1gLqTAuZ05mv5HepWnleop74dJHZca+xxMCLcn/c8vO32ZGFLHcq
        I51m6TXd8HY1d9R1pwLpta6pWI1uqaGYtgEkXiw=
X-Google-Smtp-Source: AJdET5dr+NTEKeDNB1z7etXIndT/pmWGR6myJpgl/EAIw7gYQN08bY26/1daCdZSZo9FaCSBjOF7kvujSZmYXmiqkTg=
X-Received: by 2002:ac8:7353:: with SMTP id q19mr9514802qtp.265.1542888157373;
 Thu, 22 Nov 2018 04:02:37 -0800 (PST)
MIME-Version: 1.0
References: <20181116112430.31248-1-vivek.gautam@codeaurora.org>
 <20181116112430.31248-3-vivek.gautam@codeaurora.org> <20181121173757.GA9801@arm.com>
In-Reply-To: <20181121173757.GA9801@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Thu, 22 Nov 2018 17:32:24 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEH7_XEcZNsbZfn6iBF5_o-ZKBj=DpturH7N85LU289qg@mail.gmail.com>
Message-ID: <CAFp+6iEH7_XEcZNsbZfn6iBF5_o-ZKBj=DpturH7N85LU289qg@mail.gmail.com>
Subject: Re: [RESEND PATCH v17 2/5] iommu/arm-smmu: Invoke pm_runtime during
 probe, add/remove device
To:     Will Deacon <will.deacon@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alex.williamson@redhat.com,
        Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
        freedreno <freedreno@lists.freedesktop.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "robh+dt" <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Wed, Nov 21, 2018 at 11:09 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Fri, Nov 16, 2018 at 04:54:27PM +0530, Vivek Gautam wrote:
> > From: Sricharan R <sricharan@codeaurora.org>
> >
> > The smmu device probe/remove and add/remove master device callbacks
> > gets called when the smmu is not linked to its master, that is without
> > the context of the master device. So calling runtime apis in those places
> > separately.
> > Global locks are also initialized before enabling runtime pm as the
> > runtime_resume() calls device_reset() which does tlb_sync_global()
> > that ultimately requires locks to be initialized.
> >
> > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > [vivek: Cleanup pm runtime calls]
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> >  drivers/iommu/arm-smmu.c | 101 ++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 91 insertions(+), 10 deletions(-)
>
> Given that you're doing the get/put in the TLBI ops unconditionally:
>
> >  static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
> >  {
> >       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> > +     struct arm_smmu_device *smmu = smmu_domain->smmu;
> >
> > -     if (smmu_domain->tlb_ops)
> > +     if (smmu_domain->tlb_ops) {
> > +             arm_smmu_rpm_get(smmu);
> >               smmu_domain->tlb_ops->tlb_flush_all(smmu_domain);
> > +             arm_smmu_rpm_put(smmu);
> > +     }
> >  }
> >
> >  static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
> >  {
> >       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> > +     struct arm_smmu_device *smmu = smmu_domain->smmu;
> >
> > -     if (smmu_domain->tlb_ops)
> > +     if (smmu_domain->tlb_ops) {
> > +             arm_smmu_rpm_get(smmu);
> >               smmu_domain->tlb_ops->tlb_sync(smmu_domain);
> > +             arm_smmu_rpm_put(smmu);
> > +     }
>
> Why do you need them around the map/unmap calls as well?

We still have .tlb_add_flush path?

Thanks
Vivek
>
> Will
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
