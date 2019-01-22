Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FE6C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B23520866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SGgWtVDy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D1LSPVCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfAVRGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:06:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40724 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbfAVRGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:06:52 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3F44C6058E; Tue, 22 Jan 2019 17:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548176811;
        bh=m9EYD1U6kVRMiotzE6lgXblp3Ir5lCrzPsFy85sYUsQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SGgWtVDyjJ4EklYW3kC15qlOJD6j8jD9WcVAduVMk42aO6M90GlBog9704vScHjA5
         fU1a92STEon9cEi4tMkJOGr1JAjvLh1E7YZFI3QZbfTmYiqoAYlqEJxt5eYAUQhIqf
         aNAYp0FWk7S4W3TMCggf35qd2Mjzmco2pUH7q8NY=
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 86C9D6079C;
        Tue, 22 Jan 2019 17:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548176809;
        bh=m9EYD1U6kVRMiotzE6lgXblp3Ir5lCrzPsFy85sYUsQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D1LSPVCAO2cvp07wHRLPLe7fJAoPsd9HmH4gPrbSQGwhfph8Bfvsqw6WQ1QguCzhk
         FWIYCFzmj00OivrGYyo+8T9cS9LKs3DrHzEHzfdWLkcVVjHsv9hU1ytbPiSnHdbUbO
         YIOWmRHXHlofaRgD6WSMebRfGZ81pmoYNxba6TnU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86C9D6079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-ed1-f53.google.com with SMTP id d39so19857766edb.12;
        Tue, 22 Jan 2019 09:06:49 -0800 (PST)
X-Gm-Message-State: AJcUukc/xcUrGJICePOKvEUMF/4Wzk2gLdnUF/d11TnpKIrk3E/lrU19
        5i7j3hKnDiI3zBUm92Qmw8zkJwCjq6Pp3GhmicU=
X-Google-Smtp-Source: ALg8bN6cWW4VzOHbSqQJpW4P5Q/2gR5K1qPiqLCEBvwRyHDg4rRiJ6DM+A3QZZG9yB9lSZDU/km4Rvft7zPeeAoF+eI=
X-Received: by 2002:aa7:c0d0:: with SMTP id j16mr31111179edp.173.1548176808160;
 Tue, 22 Jan 2019 09:06:48 -0800 (PST)
MIME-Version: 1.0
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
 <20190121055335.15430-2-vivek.gautam@codeaurora.org> <b0688376-f922-9d17-eb66-f28df6963bcf@arm.com>
In-Reply-To: <b0688376-f922-9d17-eb66-f28df6963bcf@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Tue, 22 Jan 2019 22:36:36 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEanKEhLkonZwqBYV1e-=-yKbStj0SoL0x6UNQxaOft=w@mail.gmail.com>
Message-ID: <CAFp+6iEanKEhLkonZwqBYV1e-=-yKbStj0SoL0x6UNQxaOft=w@mail.gmail.com>
Subject: Re: [PATCH 1/3] iommu/arm-smmu: Move to bitmap for arm_smmu_domain atrributes
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        pdaly@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        pratikp@codeaurora.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 7:23 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 21/01/2019 05:53, Vivek Gautam wrote:
> > A number of arm_smmu_domain's attributes can be assigned based
> > on the iommu domains's attributes. These local attributes better
> > be managed by a bitmap.
> > So remove boolean flags and move to a 32-bit bitmap, and enable
> > each bits separtely.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > ---
> >   drivers/iommu/arm-smmu.c | 10 ++++++----
> >   1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 7ebbcf1b2eb3..52b300dfc096 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -257,10 +257,11 @@ struct arm_smmu_domain {
> >       const struct iommu_gather_ops   *tlb_ops;
> >       struct arm_smmu_cfg             cfg;
> >       enum arm_smmu_domain_stage      stage;
> > -     bool                            non_strict;
> >       struct mutex                    init_mutex; /* Protects smmu pointer */
> >       spinlock_t                      cb_lock; /* Serialises ATS1* ops and TLB syncs */
> >       struct iommu_domain             domain;
> > +#define ARM_SMMU_DOMAIN_ATTR_NON_STRICT      BIT(0)
> > +     unsigned int                    attr;
> >   };
> >
> >   struct arm_smmu_option_prop {
> > @@ -901,7 +902,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> >       if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
> >               pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
> >
> > -     if (smmu_domain->non_strict)
> > +     if (smmu_domain->attr & ARM_SMMU_DOMAIN_ATTR_NON_STRICT)
> >               pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
> >
> >       /* Non coherent page table mappings only for Stage-1 */
> > @@ -1598,7 +1599,8 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> >       case IOMMU_DOMAIN_DMA:
> >               switch (attr) {
> >               case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
> > -                     *(int *)data = smmu_domain->non_strict;
> > +                     *(int *)data = !!(smmu_domain->attr &
> > +                                       ARM_SMMU_DOMAIN_ATTR_NON_STRICT);
> >                       return 0;
> >               default:
> >                       return -ENODEV;
> > @@ -1638,7 +1640,7 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
> >       case IOMMU_DOMAIN_DMA:
> >               switch (attr) {
> >               case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
> > -                     smmu_domain->non_strict = *(int *)data;
> > +                     smmu_domain->attr |= ARM_SMMU_DOMAIN_ATTR_NON_STRICT;
>
> But what if *data == 0?

Right, a check for data here also similar to what we are doing for
QCOM_SYS_CACHE [1].

[1] https://lore.kernel.org/patchwork/patch/1033796/

Regards
Vivek

>
> Robin.
>
> >                       break;
> >               default:
> >                       ret = -ENODEV;
> >
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
