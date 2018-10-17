Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA8AECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5365A214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="jM23WgKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5365A214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeJQWRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:17:24 -0400
Received: from mta-p4.oit.umn.edu ([134.84.196.204]:55426 "EHLO
        mta-p4.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbeJQWRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:17:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p4.oit.umn.edu (Postfix) with ESMTP id A5C4A51F;
        Wed, 17 Oct 2018 14:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1539786087; x=1541600488; bh=r6ADaZAZjg
        2NaXOt1ZlhdlI4BKiNjQ5OKnShZdjL8Gc=; b=jM23WgKK2tu5JzS91VgFlTz9hU
        tgY3sU6d8YHQec7eq6WrpC01qyO7vHEiWKSAOOxkQJfaNfPSHHp4XyEhDsC2O/Iw
        gGcKJ9kjdl/RY9t0E+l1C0rWDRtvx36JCW/b06Ehy46aGGpV1+jbVXYo1TbceFO1
        puFPQHH1IYJgD6TD1JqXqdE3IZb51IdrU+LjaY28Behpem19P3DZruZH4rMUMlx6
        wl3cEvmeN0jbtlnqTE6C+8DD2O0SdLA+a+lfSN32qBkYoDnOb1gXXFPS7PCN9xPT
        SoHniPu8mIegc/6+JwQTlaqOMXYIbl7ml7p5cPupVV2Jv7jyOWGqnyfd80UA==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p4.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p4.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zwWT31zpw3cS; Wed, 17 Oct 2018 09:21:27 -0500 (CDT)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p4.oit.umn.edu (Postfix) with ESMTPSA id 6C01715F;
        Wed, 17 Oct 2018 09:21:27 -0500 (CDT)
Received: by mail-oi1-f175.google.com with SMTP id u197-v6so21191172oif.5;
        Wed, 17 Oct 2018 07:21:27 -0700 (PDT)
X-Gm-Message-State: ABuFfoj5/meTzcxKf34lvM9mrsuwCokqHKGPzc1sQX+TquEWnoDqkVAD
        ioQYb031Q6IL8IGv4KxW0SHw1hHu/NfsmyXzFHM=
X-Google-Smtp-Source: ACcGV62C3GVACfcRDjkHZvG/BKJZQVVsbLckAdyhxbSNaCWLt/7ljTTSwRQezRCOvHb3lnkHUgfYxndFxET/AwgNwA0=
X-Received: by 2002:aca:3195:: with SMTP id x143-v6mr13448204oix.213.1539786087039;
 Wed, 17 Oct 2018 07:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <1539021980-2412-1-git-send-email-wang6495@umn.edu> <20181008124738.23a547d0@w520.home>
In-Reply-To: <20181008124738.23a547d0@w520.home>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Wed, 17 Oct 2018 09:20:50 -0500
X-Gmail-Original-Message-ID: <CAAa=b7d5a07o8b9Xkn_dqpiLrm43DYQujro2w=SNev702q0zkA@mail.gmail.com>
Message-ID: <CAAa=b7d5a07o8b9Xkn_dqpiLrm43DYQujro2w=SNev702q0zkA@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/vfio: Fix a redundant copy bug
To:     alex.williamson@redhat.com
Cc:     Kangjie Lu <kjlu@umn.edu>, kvm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>, aik@ozlabs.ru,
        Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 1:47 PM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Mon,  8 Oct 2018 13:06:20 -0500
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
> > Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> > ---
> >  drivers/vfio/vfio_spapr_eeh.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
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
> We already have this in minsz, offsetofend(,op) == offsetof(,err.type).
> That can't change without breaking userspace.
>
> > +                     end = offsetofend(struct vfio_eeh_pe_op, err.mask);
> > +                     if (op.argsz < end)
> >                               return -EINVAL;
> > -                     if (copy_from_user(&op, (void __user *)arg, minsz))
> > +                     if (copy_from_user(&op.err, (char __user *)arg +
> > +                                             start, end - start))
>
> So we trade 12 bytes of redundant copy for an extra stack variable and
> an arithmetic operation, not necessarily an obvious win, but more
> correct I guess.
>
> Alexey, I also notice that these 12 bytes means that the u64 fields in
> struct vfio_eeh_pe_err are not 8-byte aligned which could lead to
> compiler dependent packing interpretation issues with userspace.
> Should there be a 4-byte reserved field in there to make it explicit
> (so long as it matches the current interpretation)?  Thanks,

It sounds reasonable. I can add such a field in struct vfio_eeh_pe_op. Thanks!

Wenwen
