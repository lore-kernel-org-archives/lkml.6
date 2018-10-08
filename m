Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186CEC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E23213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="W37Hj22V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E23213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeJIA4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:56:09 -0400
Received: from mta-p2.oit.umn.edu ([134.84.196.202]:60742 "EHLO
        mta-p2.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJIA4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:56:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p2.oit.umn.edu (Postfix) with ESMTP id 4E2F1629;
        Mon,  8 Oct 2018 17:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1539020598; x=1540834999; bh=6+crBoWQ0W
        Eqsb+PFYKpnRZPl03KiO+SyHIHOzzkodc=; b=W37Hj22VPtfJdGW2gKfmYUY0+T
        vUiMxC65poff67psU617vGh4XgK3LCjdZtfFMu0pNsNeE32CdfHsCbsDQktnBzZ2
        KyfYoVBcGpnmZZtIxCU8KwcTCuPQge9FTbJP8RjGNHS+K+Ozdj+LGNwTmDmF3Ljq
        bMjz/HMx3zbyK7dCUuNir/+rLA/EAUMa1lfAKUAFHgFHMWZVyVIt3nReqTEX05Aw
        eNV8iOUN1t30pk02QGpC7U7itlGQ3wlOTXcyJcbFFbDH3XJz6v907DxIRzmHQefk
        693N3tlcApoDWegT6+FxEpI0gQmU/hgPT7GQVmRs1GrJrHQi6PjTAiQy6RTw==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p2.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p2.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NOdrSd3eNi2M; Mon,  8 Oct 2018 12:43:18 -0500 (CDT)
Received: from mail-it1-f172.google.com (mail-it1-f172.google.com [209.85.166.172])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p2.oit.umn.edu (Postfix) with ESMTPSA id 0F41C60A;
        Mon,  8 Oct 2018 12:43:18 -0500 (CDT)
Received: by mail-it1-f172.google.com with SMTP id l191-v6so12568372ita.4;
        Mon, 08 Oct 2018 10:43:18 -0700 (PDT)
X-Gm-Message-State: ABuFfogF3JlI1LzXqGnwQPWXtqvJXDSOrZ04Q6y9GsaBArgarNUayC7r
        Pr/MQSRHEJ4rx0TwInwnrjeYH6i/FrgOjVybwTY=
X-Google-Smtp-Source: ACcGV62WTaG3tfoOqwRUXNK+YIeFxKfw0arow9XlWdN0lpSPn4RbIuLv052F+D9NHM7SQ5DiVROQvusrobq1jHGAPdQ=
X-Received: by 2002:a02:b476:: with SMTP id w51-v6mr18270996jaj.140.1539020597741;
 Mon, 08 Oct 2018 10:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <1538923466-29705-1-git-send-email-wang6495@umn.edu> <20181008104350.7776c729@w520.home>
In-Reply-To: <20181008104350.7776c729@w520.home>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Mon, 8 Oct 2018 12:42:40 -0500
X-Gmail-Original-Message-ID: <CAAa=b7fJAFhV+8q=_es6OCmx3=5U7UfsyRmP8VTUbE5UMGgj-Q@mail.gmail.com>
Message-ID: <CAAa=b7fJAFhV+8q=_es6OCmx3=5U7UfsyRmP8VTUbE5UMGgj-Q@mail.gmail.com>
Subject: Re: [PATCH] drivers/vfio: Fix a redundant copy bug
To:     alex.williamson@redhat.com
Cc:     Kangjie Lu <kjlu@umn.edu>, kvm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 11:43 AM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> Hi,
>
> On Sun,  7 Oct 2018 09:44:25 -0500
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
> > performance and security reasons, the redundant part of the second copy
> > should be removed.
>
> Redundant, yes.  Performance-wise it's 12 bytes on a non-performance
> path, so theoretically yes, but in practice maybe it's a simplicity
> trade-off.  Security?  I don't see it, please explain.
>
> > This patch removes such a part in the second copy. It only copies the 'err'
> > information from the buffer 'arg'.
> >
> > Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> > ---
> >  drivers/vfio/vfio_spapr_eeh.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
> > index 38edeb4..5bc4b60 100644
> > --- a/drivers/vfio/vfio_spapr_eeh.c
> > +++ b/drivers/vfio/vfio_spapr_eeh.c
> > @@ -86,10 +86,10 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
> >                       ret = eeh_pe_configure(pe);
> >                       break;
> >               case VFIO_EEH_PE_INJECT_ERR:
> > -                     minsz = offsetofend(struct vfio_eeh_pe_op, err.mask);
> > -                     if (op.argsz < minsz)
> > +                     if (op.argsz < sizeof(op))
> >                               return -EINVAL;
>
> The original code is written such that new operations can be added,
> possibly with new entries in the struct vfio_eeh_pe_op union, which
> might change sizeof(op) to be more than necessary for a
> VFIO_EEH_PE_INJECT_ERR op.  Existing userspace suddenly wouldn't work
> without effectively reverting this change.  This is a subtle dependency
> that is not worth the above code change, imo.
>
> > -                     if (copy_from_user(&op, (void __user *)arg, minsz))
> > +                     if (copy_from_user(&op.err, (char __user *)arg +
> > +                                             minsz, sizeof(op.err)))
> >                               return -EFAULT;
>
> Please rework with the assumption that the union in struct
> vfio_eeh_pe_op can be expanded and must not break existing userspace.

Thanks for your suggestion. I will resubmit the patch.

Wenwen

> Thanks,
>
> Alex
