Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47332ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F6821476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="IcCEsTfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F6821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeJRDIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:08:20 -0400
Received: from mta-p4.oit.umn.edu ([134.84.196.204]:45980 "EHLO
        mta-p4.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeJRDIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:08:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p4.oit.umn.edu (Postfix) with ESMTP id 60307F9;
        Wed, 17 Oct 2018 19:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1539803474; x=1541617875; bh=0Giyhb9xQF
        zsSM2uCb4tjdMPirLhGfigoEJhG3pGsl4=; b=IcCEsTfsh/OWo107XsCAKRr0EP
        xDDzTRokUld///OjqbNHBAPPn/L1rt8WJgxsWyB+mTKJONkcHiYMeD4AzZ1V2+rp
        PRJuEsciSW42fOnMzUtyKrbvcYiPtUNnqtD2YeYQ7JwJPyCFKvSPdBmk70D+SgZU
        xMlRHykTeYZwjobmEk01eZR2AUan12mPF5g/ZWSFc38fhwXyuuDn1eBCr7M8NZdV
        Tq84JJL8AEL9M8wdAz6Lypv2AqAd3cLvVsP+lAGjWu+UQLd23jnv55pj11gcRrEC
        eraaVCjHkYfu3mRPpPoN2cfpp+28OO6kpao8wBRBQc9aznYqcOCTdibse6sQ==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p4.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p4.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q9X0647YE_zT; Wed, 17 Oct 2018 14:11:14 -0500 (CDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p4.oit.umn.edu (Postfix) with ESMTPSA id 2EC8B14F;
        Wed, 17 Oct 2018 14:11:14 -0500 (CDT)
Received: by mail-ot1-f54.google.com with SMTP id q50so27361874otd.0;
        Wed, 17 Oct 2018 12:11:14 -0700 (PDT)
X-Gm-Message-State: ABuFfohra9KaBwvIjAqDSU/48x0De9DY6oZ3FdcRO6DlpRIY0nqmvgA8
        u3CsYyd13FqnP+YE/4xdHLLGGdOVfpbGwTVTPqM=
X-Google-Smtp-Source: ACcGV63Ycdr5/a6dJAe18RPzea4uVUet5/rDg+ZdtegrEa/O+jKDUKDnlBpcmJY9LdwoTt0mp7wjdw3bWpoI0xRVGS0=
X-Received: by 2002:a9d:2d61:: with SMTP id v88mr18674339ota.34.1539803473782;
 Wed, 17 Oct 2018 12:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <1539786725-1812-1-git-send-email-wang6495@umn.edu>
 <20181017094506.1b09eb64@w520.home> <CAAa=b7erQ-FwD6eQiAKanU1kb5fEoUGoEG4P6LQQP6YMDxfakg@mail.gmail.com>
 <20181017130528.6df57601@w520.home>
In-Reply-To: <20181017130528.6df57601@w520.home>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Wed, 17 Oct 2018 14:10:37 -0500
X-Gmail-Original-Message-ID: <CAAa=b7eGPmfaVV+8UCVfQmELE6ZnkW+Yggfk=Xx1e_qS=gDc5A@mail.gmail.com>
Message-ID: <CAAa=b7eGPmfaVV+8UCVfQmELE6ZnkW+Yggfk=Xx1e_qS=gDc5A@mail.gmail.com>
Subject: Re: [PATCH v3] drivers/vfio: Fix a redundant copy bug
To:     alex.williamson@redhat.com
Cc:     Kangjie Lu <kjlu@umn.edu>, kvm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 2:05 PM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Wed, 17 Oct 2018 12:58:26 -0500
> Wenwen Wang <wang6495@umn.edu> wrote:
>
> > On Wed, Oct 17, 2018 at 10:45 AM Alex Williamson
> > <alex.williamson@redhat.com> wrote:
> > >
> > > On Wed, 17 Oct 2018 09:32:04 -0500
> > > Wenwen Wang <wang6495@umn.edu> wrote:
> > >
> > > > In vfio_spapr_iommu_eeh_ioctl(), if the ioctl command is VFIO_EEH_PE_OP,
> > > > the user-space buffer 'arg' is copied to the kernel object 'op' and the
> > > > 'argsz' and 'flags' fields of 'op' are checked. If the check fails, an
> > > > error code EINVAL is returned. Otherwise, 'op.op' is further checked
> > > > through a switch statement to invoke related handlers. If 'op.op' is
> > > > VFIO_EEH_PE_INJECT_ERR, the whole user-space buffer 'arg' is copied again
> > > > to 'op' to obtain the err information. However, in the following execution
> > > > of this case, the fields of 'op', except the field 'err', are actually not
> > > > used. That is, the second copy has a redundant part. Therefore, for both
> > > > performance consideration, the redundant part of the second copy should be
> > > > removed.
> > > >
> > > > This patch removes such a part in the second copy. It only copies from
> > > > 'err.type' to 'err.mask', which is exactly required by the
> > > > VFIO_EEH_PE_INJECT_ERR op.
> > > >
> > > > This patch also adds a 4-byte reserved field in the structure
> > > > vfio_eeh_pe_op to make sure that the u64 fields in the structure
> > > > vfio_eeh_pe_err are 8-byte aligned.
> > > >
> > > > Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> > > > ---
> > > >  drivers/vfio/vfio_spapr_eeh.c | 9 ++++++---
> > > >  include/uapi/linux/vfio.h     | 1 +
> > > >  2 files changed, 7 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
> > > > index 38edeb4..66634c6 100644
> > > > --- a/drivers/vfio/vfio_spapr_eeh.c
> > > > +++ b/drivers/vfio/vfio_spapr_eeh.c
> > > > @@ -37,6 +37,7 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
> > > >       struct eeh_pe *pe;
> > > >       struct vfio_eeh_pe_op op;
> > > >       unsigned long minsz;
> > > > +     unsigned long start, end;
> > > >       long ret = -EINVAL;
> > > >
> > > >       switch (cmd) {
> > > > @@ -86,10 +87,12 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
> > > >                       ret = eeh_pe_configure(pe);
> > > >                       break;
> > > >               case VFIO_EEH_PE_INJECT_ERR:
> > > > -                     minsz = offsetofend(struct vfio_eeh_pe_op, err.mask);
> > > > -                     if (op.argsz < minsz)
> > > > +                     start = offsetof(struct vfio_eeh_pe_op, err.type);
> > >
> > > I noted in the previous version that we already have this in minsz, so
> > > you're fixing a redundant copy with a redundant operation.
> >
> > The value in start is different from the value in minsz. So why is
> > this a redundant operation?
>
> I suppose that's true given the alignment issue below, so we're
> actually avoiding 16 bytes rather than 12.  The benefit of this change
> still seems pretty thin to me, but it is more correct, so I guess it's
> ok.  Do you want to send a new version or shall I just drop the vfio.h
> changes and the last paragraph of the commit log in favor of the
> separate patch?  Alexey or David, do you want to provide an Ack for
> these?  Thanks,

I can send a new version of the patch. Thanks!

Wenwen
