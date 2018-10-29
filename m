Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E94C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FADF2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="pxHjSrHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FADF2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeJ3G0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:26:21 -0400
Received: from mta-p3.oit.umn.edu ([134.84.196.203]:53976 "EHLO
        mta-p3.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeJ3G0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:26:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p3.oit.umn.edu (Postfix) with ESMTP id E5E37747;
        Mon, 29 Oct 2018 21:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1540848948; x=1542663349; bh=1pZ9IQ1tzN
        j8laltio2HQY+vd5k8OukTrKRJ3LrmxoQ=; b=pxHjSrHMC0Z/5hl5X03tTbF6aZ
        Qs1kmmkUohgpb5Scw5zkAKuVxXwU16AL2r46Y59kmz3K0lvIRnpQ/EvAJRANVH6O
        MpeKLkb6VSDxcqBbbBZAPTmdD51XWVWJFdMnyEbYaOEhkrsRSRG6S7Fki8bAaeHC
        qFwYkmGAjqd1gqobD17eobhdUVX2nYq6UhZZN4SqlKvYi7qOGG28n7wcyN66ytHE
        bAQCqsUVVlLOiMsaOwLmiMkeM4GMT37JLfX5ujSxbsKrtlM8lFBbia3Qfd1C1CQN
        jkuP0hrHFeLqGkgfhR07gbDneqF6uktTaTk6TrUyvKDJUDEiz4CNIAltWjig==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p3.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p3.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D8Tqnf5B8k8y; Mon, 29 Oct 2018 16:35:48 -0500 (CDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p3.oit.umn.edu (Postfix) with ESMTPSA id AEDC46AE;
        Mon, 29 Oct 2018 16:35:48 -0500 (CDT)
Received: by mail-io1-f50.google.com with SMTP id q4-v6so5965250iob.8;
        Mon, 29 Oct 2018 14:35:48 -0700 (PDT)
X-Gm-Message-State: AGRZ1gJn7bXngrgM69IgeHD1TuSmxRUZbmU4UM6d3Fl/XA9THq9tRtsh
        QdORLL244Q3gmCsijZs82bvMML3mepeMUTYmWPY=
X-Google-Smtp-Source: AJdET5casSWI1BkyEA/n/GwT4pSaegfqHiHNPZvBD26oLpAdQVwgG0SI0CiKfR6evc/5CafpNMSOY6Dl3QgSx4A5vSY=
X-Received: by 2002:a5e:dd4d:: with SMTP id u13-v6mr9805930iop.62.1540848948443;
 Mon, 29 Oct 2018 14:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <1539803924-3190-1-git-send-email-wang6495@umn.edu>
 <CAAa=b7dE=6obq4nABsyo84iA1CTOcLVCAuUxHDYfSCimzc12eA@mail.gmail.com> <20181029153234.36e67a6f@t450s.home>
In-Reply-To: <20181029153234.36e67a6f@t450s.home>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Mon, 29 Oct 2018 16:35:12 -0500
X-Gmail-Original-Message-ID: <CAAa=b7epUf=w-atorOgyWqahuDLQj84vO_mU0bFvyUboK77_Rw@mail.gmail.com>
Message-ID: <CAAa=b7epUf=w-atorOgyWqahuDLQj84vO_mU0bFvyUboK77_Rw@mail.gmail.com>
Subject: Re: [PATCH v4] drivers/vfio: Fix a redundant copy bug
To:     alex.williamson@redhat.com
Cc:     Kangjie Lu <kjlu@umn.edu>, kvm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 4:32 PM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Mon, 29 Oct 2018 13:56:54 -0500
> Wenwen Wang <wang6495@umn.edu> wrote:
>
> > Hello,
> >
> > Could you please apply this patch? Thanks!
>
> I'd like to see testing and/or review from David or Alexey since I also
> don't have an environment for spapr/eeh.  We're already late into the
> v4.20 merge window so this is probably v4.21 material.  Thanks,

I see. Thanks for your response, Alex!

> > On Wed, Oct 17, 2018 at 2:18 PM Wenwen Wang <wang6495@umn.edu> wrote:
> > >
> > > In vfio_spapr_iommu_eeh_ioctl(), if the ioctl command is VFIO_EEH_PE_OP,
> > > the user-space buffer 'arg' is copied to the kernel object 'op' and the
> > > 'argsz' and 'flags' fields of 'op' are checked. If the check fails, an
> > > error code EINVAL is returned. Otherwise, 'op.op' is further checked
> > > through a switch statement to invoke related handlers. If 'op.op' is
> > > VFIO_EEH_PE_INJECT_ERR, the whole user-space buffer 'arg' is copied again
> > > to 'op' to obtain the err information. However, in the following execution
> > > of this case, the fields of 'op', except the field 'err', are actually not
> > > used. That is, the second copy has a redundant part. Therefore, for
> > > performance consideration, the redundant part of the second copy should be
> > > removed.
> > >
> > > This patch removes such a part in the second copy. It only copies from
> > > 'err.type' to 'err.mask', which is exactly required by the
> > > VFIO_EEH_PE_INJECT_ERR op.
> > >
> > > Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> > > ---
> > >  drivers/vfio/vfio_spapr_eeh.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
> > > index 38edeb4..66634c6 100644
> > > --- a/drivers/vfio/vfio_spapr_eeh.c
> > > +++ b/drivers/vfio/vfio_spapr_eeh.c
> > > @@ -37,6 +37,7 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
> > >         struct eeh_pe *pe;
> > >         struct vfio_eeh_pe_op op;
> > >         unsigned long minsz;
> > > +       unsigned long start, end;
> > >         long ret = -EINVAL;
> > >
> > >         switch (cmd) {
> > > @@ -86,10 +87,12 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
> > >                         ret = eeh_pe_configure(pe);
> > >                         break;
> > >                 case VFIO_EEH_PE_INJECT_ERR:
> > > -                       minsz = offsetofend(struct vfio_eeh_pe_op, err.mask);
> > > -                       if (op.argsz < minsz)
> > > +                       start = offsetof(struct vfio_eeh_pe_op, err.type);
> > > +                       end = offsetofend(struct vfio_eeh_pe_op, err.mask);
> > > +                       if (op.argsz < end)
> > >                                 return -EINVAL;
> > > -                       if (copy_from_user(&op, (void __user *)arg, minsz))
> > > +                       if (copy_from_user(&op.err, (char __user *)arg +
> > > +                                               start, end - start))
> > >                                 return -EFAULT;
> > >
> > >                         ret = eeh_pe_inject_err(pe, op.err.type, op.err.func,
> > > --
> > > 2.7.4
> > >
>
