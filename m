Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AB1C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE77B20818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5SO2kWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE77B20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeKJDnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:43:49 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43388 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeKJDnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:43:49 -0500
Received: by mail-io1-f66.google.com with SMTP id t81-v6so1873477iod.10;
        Fri, 09 Nov 2018 10:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RcBD/xuEh1VvpIJKRXOUNsvXPJPxOki1FrUqfSszYrc=;
        b=C5SO2kWxKLjJ3M9ijxYSYz8IePLdpfC7SkiZ++YVnaXTEWrDyy2AVAgH9iLqYEdmTJ
         qBTihwVbRM8Z+FxfaSsGJpupeRcjGlusFpsVt422jmUPVB8Yuk9xR5V8PsFopZvEerQB
         U3vAoB1lyKZkeFCQIajsPyXdueJZfLRCh7hZd4hZTMxoeH7HZR7aD8ZL86bX9m41gS9/
         puefGV4O2CD9R1oc+OlYs+XovAzkhpO1dS4Lfo4w6gZc2nHw117kX1D6V0lpoJ07GiLZ
         C5K00GoA7bLSNLvOjBKNntg+jN+WQBUz6mJAjkNmOrOyr2grmcTDgRdeScTb+BDtRDHB
         /WSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RcBD/xuEh1VvpIJKRXOUNsvXPJPxOki1FrUqfSszYrc=;
        b=QCC2zjrIzmkOEbcRhNZTJVTyjPgphQbhr6poPmk3a1EgCHgAWN3EeLOa4TYy7YskMQ
         SIWClyqIKQQ2WEHjttcB4Gf7WGV4z3A6q8kN97zSE1WD+XDofT2FDZXfJtTrP7FP1CJk
         VZI6vI6lQK2ho8bQ2Tf4qsWxaqVaq7ary275/27wolDa10FqeCkbPdP6d0+3WrKQ2OfL
         bSX2F3Abi7It40iTVZJuWzg6mMyTYhvkhq10uDCEOX9hFJfhtWhi8vm17qohkiG/ooc5
         L0mTPIWV/1Y0lfrcKmOeTtvAHRQJ312Quspa61AQFW0AlgNBEEDMTooCEdIg72mQ7iSA
         zO7Q==
X-Gm-Message-State: AGRZ1gIL4QQnKgWhrKeTamgVMo9K7FYPZCxmZiMZpMDCh0pWTHkvSb4W
        H6780jkCaWoyswwGN8obXudsnCtnoz4R0XZtLBEj6Q==
X-Google-Smtp-Source: AJdET5fd4PR45uP6MvypwRjeER8DYqv0BYM12r1m2pCcrQ6vKIEGJ/aBd+u4RjojFnWQJEv5JFGPCaUAfkQEG7flm3I=
X-Received: by 2002:a6b:8ec9:: with SMTP id q192-v6mr7677253iod.248.1541786527885;
 Fri, 09 Nov 2018 10:02:07 -0800 (PST)
MIME-Version: 1.0
References: <20180927224609.19515-1-robdclark@gmail.com> <20181029191000.GD16739@arm.com>
In-Reply-To: <20181029191000.GD16739@arm.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 9 Nov 2018 13:01:55 -0500
Message-ID: <CAF6AEGtgC0V6ii2=p2HGmqvHFKNJhaOLi8873SGPDsrg70xGRg@mail.gmail.com>
Subject: Re: [PATCH] iommu: arm-smmu: Set SCTLR.HUPCF bit
To:     Will Deacon <will.deacon@arm.com>
Cc:     "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 3:09 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Thu, Sep 27, 2018 at 06:46:07PM -0400, Rob Clark wrote:
> > We seem to need to set either this or CFCFG (stall), otherwise gpu
> > faults trigger problems with other in-flight transactions from the
> > GPU causing CP errors, etc.
> >
> > In the ARM SMMU spec, the 'Hit under previous context fault' bit is
> > described as:
> >
> >  '0' - Stall or terminate subsequent transactions in the presence
> >        of an outstanding context fault
> >  '1' - Process all subsequent transactions independently of any
> >        outstanding context fault.
> >
> > Since we don't enable CFCFG (stall) the behavior of terminating
> > other transactions makes sense.  And is probably not what we want
> > (and definately not what we want for GPU).
> >
> > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > ---
> > So I hit this issue a long time back on 820 (msm8996) and at the
> > time I solved it with a patch that enabled CFCFG.  And it resurfaced
> > more recently on sdm845.  But at the time CFCFG was rejected, iirc
> > because of concern that it would cause problems on other non-qcom
> > arm smmu implementations.  And I think I forgot to send this version
> > of the solution.
> >
> > If enabling HUPCF is anticipated to cause problems on other ARM
> > SMMU implementations, I think I can come up with a variant of this
> > patch which conditionally enables it for snapdragon.
> >
> > Either way, I'd really like to get some variant of this fix merged
> > (and probably it would be a good idea for stable kernel branches
> > too), since current behaviour with the GPU means faults turn into
> > a fantastic cascade of fail.
>
> Can you describe how this fantastic cascade of fail improves with this
> patch, please? If you're getting context faults then something has already
> gone horribly wrong, so I'm trying to work out how this improves things.
>

There are plenty of cases where getting iommu faults with a GPU is
"normal", or at least not something the kernel or even GL driver can
control.

With this patch, you still get the iommu fault, but it doesn't cause
the gpu to crash.  But without it, other memory accesses in flight
while the fault occurs, like the GPU command-processor reading further
ahead in the cmdstream to setup next draw, would return zero's,
causing the GPU to crash or get into a bad state.

BR,
-R

> > diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
> > index a1226e4ab5f8..2291925eb800 100644
> > --- a/drivers/iommu/arm-smmu-regs.h
> > +++ b/drivers/iommu/arm-smmu-regs.h
> > @@ -178,6 +178,7 @@ enum arm_smmu_s2cr_privcfg {
> >  #define ARM_SMMU_CB_ATSR             0x8f0
> >
> >  #define SCTLR_S1_ASIDPNE             (1 << 12)
> > +#define SCTLR_HUPCF                  (1 << 8)
> >  #define SCTLR_CFCFG                  (1 << 7)
> >  #define SCTLR_CFIE                   (1 << 6)
> >  #define SCTLR_CFRE                   (1 << 5)
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index f7a96bcf94a6..47ffc9aade72 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -713,9 +713,9 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
> >       reg = SCTLR_CFIE | SCTLR_CFRE | SCTLR_AFE | SCTLR_TRE | SCTLR_M;
> >       if (stage1)
> >               reg |= SCTLR_S1_ASIDPNE;
> > +     reg |= SCTLR_HUPCF;
>
> Maybe just throw this into the assignment a couple of lines above?
>
> >       if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> >               reg |= SCTLR_E;
> > -
>
> Random whitespace change.
>
> Will
