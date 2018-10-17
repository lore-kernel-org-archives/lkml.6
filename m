Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906C9ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DA420869
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Zz1q4iP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DA420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeJRBzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:55:53 -0400
Received: from mta-p2.oit.umn.edu ([134.84.196.202]:43830 "EHLO
        mta-p2.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeJRBzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:55:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p2.oit.umn.edu (Postfix) with ESMTP id 489DA279;
        Wed, 17 Oct 2018 17:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1539799143; x=1541613544; bh=Ifx6ZwYA5w
        SQGoccvwX9BecsQMW3u5OcLbAA9CLp+/0=; b=Zz1q4iP2UMgJL0Mkbi7AdIosKT
        sJWk/yLy4QjJTseF5PCzvAqiATtLeU3B6EXFvwLcXTP+E6a2E/MBZk4Raf0I4XQX
        sKqLNnwl+Ok0ukffTY/KAr+qGiP7Zya+0162KC5nXXO8kGEIdmsmcmH3GZR2fapb
        aXJ/YncxQ56L1DDE21bvyR4WZvcSCdSCiy/9HfVIs8eB2Xtv7QfbAwKMBFrZMQNM
        fXnKTMJt6U7Bs3FEUb8fzksFdHIzui8r92O7neS3RJKASPpf4sj/Rryw2JfcY/i1
        Y4TIrSDlG7xHh+OoWyrlba5zU/xvhq/YkSlD8v4A68RSHNeomkxHsVIerkyw==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p2.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p2.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k15l3IR9XKrM; Wed, 17 Oct 2018 12:59:03 -0500 (CDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p2.oit.umn.edu (Postfix) with ESMTPSA id 1869324D;
        Wed, 17 Oct 2018 12:59:03 -0500 (CDT)
Received: by mail-ot1-f43.google.com with SMTP id q50so27133418otd.0;
        Wed, 17 Oct 2018 10:59:03 -0700 (PDT)
X-Gm-Message-State: ABuFfoiWuGB7zeMcIJi9zfhhWEhEue7e8BjNbQHlCVqfgePCWf4ErKi/
        34BvGssFLqo007lY2qPcyyckd/zx/ujNcwHQu44=
X-Google-Smtp-Source: ACcGV60RQ6AtGY0Dtb5qSSeEoOr6IuWqUtZh5RGHf3jLUcIULPqhaEQwKLZhcRVZI8vE0juCfcFPENnA25gvC1dwyZE=
X-Received: by 2002:a9d:f61:: with SMTP id 88mr17954040ott.364.1539799142698;
 Wed, 17 Oct 2018 10:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <1539786725-1812-1-git-send-email-wang6495@umn.edu> <20181017094506.1b09eb64@w520.home>
In-Reply-To: <20181017094506.1b09eb64@w520.home>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Wed, 17 Oct 2018 12:58:26 -0500
X-Gmail-Original-Message-ID: <CAAa=b7erQ-FwD6eQiAKanU1kb5fEoUGoEG4P6LQQP6YMDxfakg@mail.gmail.com>
Message-ID: <CAAa=b7erQ-FwD6eQiAKanU1kb5fEoUGoEG4P6LQQP6YMDxfakg@mail.gmail.com>
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

On Wed, Oct 17, 2018 at 10:45 AM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Wed, 17 Oct 2018 09:32:04 -0500
> Wenwen Wang <wang6495@umn.edu> wrote:
>
> > In vfio_spapr_iommu_eeh_ioctl(), if the ioctl command is VFIO_EEH_PE_OP,
> > the user-space buffer 'arg' is copied to the kernel object 'op' and the
> > 'argsz' and 'flags' fields of 'op' are checked. If the check fails, an
> > error code EINVAL is returned. Otherwise, 'op.op' is further checked
> > through a switch statement to invoke related handlers. If 'op.op' is
> > VFIO_EEH_PE_INJECT_ERR, the whole user-space buffer 'arg' is copied again
> > to 'op' to obtain the err information. However, in the following execution
> > of this case, the fields of 'op', except the field 'err', are actually not
> > used. That is, the second copy has a redundant part. Therefore, for both
> > performance consideration, the redundant part of the second copy should be
> > removed.
> >
> > This patch removes such a part in the second copy. It only copies from
> > 'err.type' to 'err.mask', which is exactly required by the
> > VFIO_EEH_PE_INJECT_ERR op.
> >
> > This patch also adds a 4-byte reserved field in the structure
> > vfio_eeh_pe_op to make sure that the u64 fields in the structure
> > vfio_eeh_pe_err are 8-byte aligned.
> >
> > Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> > ---
> >  drivers/vfio/vfio_spapr_eeh.c | 9 ++++++---
> >  include/uapi/linux/vfio.h     | 1 +
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
> > index 38edeb4..66634c6 100644
> > --- a/drivers/vfio/vfio_spapr_eeh.c
> > +++ b/drivers/vfio/vfio_spapr_eeh.c
> > @@ -37,6 +37,7 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
> >       struct eeh_pe *pe;
> >       struct vfio_eeh_pe_op op;
> >       unsigned long minsz;
> > +     unsigned long start, end;
> >       long ret = -EINVAL;
> >
> >       switch (cmd) {
> > @@ -86,10 +87,12 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
> >                       ret = eeh_pe_configure(pe);
> >                       break;
> >               case VFIO_EEH_PE_INJECT_ERR:
> > -                     minsz = offsetofend(struct vfio_eeh_pe_op, err.mask);
> > -                     if (op.argsz < minsz)
> > +                     start = offsetof(struct vfio_eeh_pe_op, err.type);
>
> I noted in the previous version that we already have this in minsz, so
> you're fixing a redundant copy with a redundant operation.

The value in start is different from the value in minsz. So why is
this a redundant operation?

> > +                     end = offsetofend(struct vfio_eeh_pe_op, err.mask);
> > +                     if (op.argsz < end)
> >                               return -EINVAL;
> > -                     if (copy_from_user(&op, (void __user *)arg, minsz))
> > +                     if (copy_from_user(&op.err, (char __user *)arg +
> > +                                             start, end - start))
> >                               return -EFAULT;
> >
> >                       ret = eeh_pe_inject_err(pe, op.err.type, op.err.func,
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 1aa7b82..d904c42 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -729,6 +729,7 @@ struct vfio_eeh_pe_op {
> >       __u32 argsz;
> >       __u32 flags;
> >       __u32 op;
> > +     __u32 __resv;
> >       union {
> >               struct vfio_eeh_pe_err err;
> >       };
>
> Please don't include two separate issues in the same patch.  Am I also
> correct in assuming that this is untested?  Thanks,

No problem. I will seperate these two patches. And yes, this is not tested.

Thanks,
Wenwen
