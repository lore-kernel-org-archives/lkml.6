Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6729C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88ACC2243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synesis-ru.20150623.gappssmtp.com header.i=@synesis-ru.20150623.gappssmtp.com header.b="dK4nT05D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88ACC2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synesis.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732785AbeKMVi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:38:56 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34005 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732745AbeKMViz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:38:55 -0500
Received: by mail-ot1-f66.google.com with SMTP id t5so11033117otk.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 03:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synesis-ru.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EvmegWeMGN3KLd49d+KfRSjjnyXopGgu3o0DkzqVaR8=;
        b=dK4nT05Doih52AmAxzNadY/dsk0/21ERSWdf2Y5PkkSVCeSAIbG3gYH91opZn5Q4Zb
         b77pEZRcDxW4asZ9AGhxTpaiv6/WuTyQfD0LxRV1BEfgvhOutEUpOQpOiZ0X8tJ3/iV4
         TYE46b9tsjpsNwNyDnYZkKTzJ4HpR/0UKZ7XZTsNgA8KMeLoPD+XZy8xQNIHxrjc2Ths
         mYGuYLtcFoWjki27kHlsnjxjPwzt+IkHRQHpg1fNh+DERtCB3iqEhZl+XQmnxYS8T8kv
         E0+WdoRONx9NeQMoE4pDYiV5ZdPtKsrENG+wrENZ/VSzw/JwzZpZe9hQAGSHEpv0RXiW
         5jqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EvmegWeMGN3KLd49d+KfRSjjnyXopGgu3o0DkzqVaR8=;
        b=MubIrUZ3wHA2blL4I/A10vsRaXgjKfmCpwRjqIIgQrfn/RyALePpWX9o9zL/GnpEh7
         O5tMdlcOaYRC6IC5JZvdncXu4qdQB6AX8sJgBkaIJiIRu+Dkf7b7hUzOnQ+7qXMzwrBH
         5FqX09b11xLCSa6kMUCxMnVHg/O3hANN14P/O1RRK18vmsYgCgOnpkM0UuWsy2xxrngJ
         wzAm74porlJTptncpiJG5zDEObiewJdCWQlpQZHRoWE4xmTP7+/1e5m8kxBeI77nLXp3
         wqhxNkmGuaSauvPFYt4r1gl+26IJrHLhygZ6COn8ytMAl7js4mrNs5lpKygPYJwmnbaU
         CaMQ==
X-Gm-Message-State: AGRZ1gKcMBeWLtxQodKUm2z5Wqd0GAStlH8TGpjrmakbDn8FT/Xk+LJJ
        Jy/hu7RJ2Bs+WKofGns7FeR5Or4eKJjY1z4I
X-Google-Smtp-Source: AJdET5dgABfcO/ytQKUcSNWKjCfh3ikTvjJAO5NnAx64OKSW2b3U31Uhi5/fXqdtlLjKDHm6lGjuww==
X-Received: by 2002:a9d:2b37:: with SMTP id o52mr3002354otb.326.1542109269875;
        Tue, 13 Nov 2018 03:41:09 -0800 (PST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id l108sm381792otc.23.2018.11.13.03.41.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 03:41:08 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id p82-v6so9970575oih.11;
        Tue, 13 Nov 2018 03:41:07 -0800 (PST)
X-Received: by 2002:aca:4dd4:: with SMTP id a203-v6mr2856344oib.168.1542109267260;
 Tue, 13 Nov 2018 03:41:07 -0800 (PST)
MIME-Version: 1.0
References: <20181112231344.7161-1-timofey.titovets@synesis.ru> <20181113022516.45u6b536vtdjgvrf@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
In-Reply-To: <20181113022516.45u6b536vtdjgvrf@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
From:   Timofey Titovets <timofey.titovets@synesis.ru>
Date:   Tue, 13 Nov 2018 14:40:31 +0300
X-Gmail-Original-Message-ID: <CAGqmi744_8NA30V0aWCpFi_=WSaA+18h3njOTQG0SFUVdXi8bg@mail.gmail.com>
Message-ID: <CAGqmi744_8NA30V0aWCpFi_=WSaA+18h3njOTQG0SFUVdXi8bg@mail.gmail.com>
Subject: Re: [PATCH V3] KSM: allow dedup all tasks memory
To:     pasha.tatashin@soleen.com
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=B2=D1=82, 13 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 05:25, Pavel=
 Tatashin <pasha.tatashin@soleen.com>:
>
> On 18-11-13 02:13:44, Timofey Titovets wrote:
> > From: Timofey Titovets <nefelim4ag@gmail.com>
> >
> > ksm by default working only on memory that added by
> > madvise().
> >
> > And only way get that work on other applications:
> >   * Use LD_PRELOAD and libraries
> >   * Patch kernel
> >
> > Lets use kernel task list and add logic to import VMAs from tasks.
> >
> > That behaviour controlled by new attributes:
> >   * mode:
> >     I try mimic hugepages attribute, so mode have two states:
> >       * madvise      - old default behaviour
> >       * always [new] - allow ksm to get tasks vma and
> >                        try working on that.
> >   * seeker_sleep_millisecs:
> >     Add pauses between imports tasks VMA
> >
> > For rate limiting proporses and tasklist locking time,
> > ksm seeker thread only import VMAs from one task per loop.
> >
> > Some numbers from different not madvised workloads.
> > Formulas:
> >   Percentage ratio =3D (pages_sharing - pages_shared)/pages_unshared
> >   Memory saved =3D (pages_sharing - pages_shared)*4/1024 MiB
> >   Memory used =3D free -h
> >
> >   * Name: My working laptop
> >     Description: Many different chrome/electron apps + KDE
> >     Ratio: 5%
> >     Saved: ~100  MiB
> >     Used:  ~2000 MiB
> >
> >   * Name: K8s test VM
> >     Description: Some small random running docker images
> >     Ratio: 40%
> >     Saved: ~160 MiB
> >     Used:  ~920 MiB
> >
> >   * Name: Ceph test VM
> >     Description: Ceph Mon/OSD, some containers
> >     Ratio: 20%
> >     Saved: ~60 MiB
> >     Used:  ~600 MiB
> >
> >   * Name: BareMetal K8s backend server
> >     Description: Different server apps in containers C, Java, GO & etc
> >     Ratio: 72%
> >     Saved: ~5800 MiB
> >     Used:  ~35.7 GiB
> >
> >   * Name: BareMetal K8s processing server
> >     Description: Many instance of one CPU intensive application
> >     Ratio: 55%
> >     Saved: ~2600 MiB
> >     Used:  ~28.0 GiB
> >
> >   * Name: BareMetal Ceph node
> >     Description: Only OSD storage daemons running
> >     Raio: 2%
> >     Saved: ~190 MiB
> >     Used:  ~11.7 GiB
> >
> > Changes:
> >   v1 -> v2:
> >     * Rebase on v4.19.1 (must also apply on 4.20-rc2+)
> >   v2 -> v3:
> >     * Reformat patch description
> >     * Rename mode normal to madvise
> >     * Add some memory numbers
> >     * Fix checkpatch.pl warnings
> >     * Separate ksm vma seeker to another kthread
> >     * Fix: "BUG: scheduling while atomic: ksmd"
> >       by move seeker to another thread
> >
> > Signed-off-by: Timofey Titovets <nefelim4ag@gmail.com>
> > CC: Matthew Wilcox <willy@infradead.org>
> > CC: linux-mm@kvack.org
> > CC: linux-doc@vger.kernel.org
> > ---
> >  Documentation/admin-guide/mm/ksm.rst |  15 ++
> >  mm/ksm.c                             | 215 +++++++++++++++++++++++----
> >  2 files changed, 198 insertions(+), 32 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin=
-guide/mm/ksm.rst
> > index 9303786632d1..7cffd47f9b38 100644
> > --- a/Documentation/admin-guide/mm/ksm.rst
> > +++ b/Documentation/admin-guide/mm/ksm.rst
> > @@ -116,6 +116,21 @@ run
> >          Default: 0 (must be changed to 1 to activate KSM, except if
> >          CONFIG_SYSFS is disabled)
> >
> > +mode
> > +        * set always to allow ksm deduplicate memory of every process
> > +        * set madvise to use only madvised memory
> > +
> > +        Default: madvise (dedupulicate only madvised memory as in
> > +        earlier releases)
> > +
> > +seeker_sleep_millisecs
> > +        how many milliseconds ksmd task seeker should sleep try anothe=
r
> > +        task.
> > +        e.g. ``echo 1000 > /sys/kernel/mm/ksm/seeker_sleep_millisecs``
> > +
> > +        Default: 1000 (chosen for rate limit purposes)
> > +
> > +
> >  use_zero_pages
> >          specifies whether empty pages (i.e. allocated pages that only
> >          contain zeroes) should be treated specially.  When set to 1,
> > diff --git a/mm/ksm.c b/mm/ksm.c
> > index 5b0894b45ee5..1a03b28b6288 100644
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -273,6 +273,9 @@ static unsigned int ksm_thread_pages_to_scan =3D 10=
0;
> >  /* Milliseconds ksmd should sleep between batches */
> >  static unsigned int ksm_thread_sleep_millisecs =3D 20;
> >
> > +/* Milliseconds ksmd seeker should sleep between runs */
> > +static unsigned int ksm_thread_seeker_sleep_millisecs =3D 1000;
> > +
> >  /* Checksum of an empty (zeroed) page */
> >  static unsigned int zero_checksum __read_mostly;
> >
> > @@ -295,7 +298,12 @@ static int ksm_nr_node_ids =3D 1;
> >  static unsigned long ksm_run =3D KSM_RUN_STOP;
> >  static void wait_while_offlining(void);
> >
> > +#define KSM_MODE_MADVISE 0
> > +#define KSM_MODE_ALWAYS      1
> > +static unsigned long ksm_mode =3D KSM_MODE_MADVISE;
> > +
> >  static DECLARE_WAIT_QUEUE_HEAD(ksm_thread_wait);
> > +static DECLARE_WAIT_QUEUE_HEAD(ksm_seeker_thread_wait);
> >  static DEFINE_MUTEX(ksm_thread_mutex);
> >  static DEFINE_SPINLOCK(ksm_mmlist_lock);
> >
> > @@ -303,6 +311,11 @@ static DEFINE_SPINLOCK(ksm_mmlist_lock);
> >               sizeof(struct __struct), __alignof__(struct __struct),\
> >               (__flags), NULL)
> >
> > +static inline int ksm_mode_always(void)
> > +{
> > +     return (ksm_mode =3D=3D KSM_MODE_ALWAYS);
> > +}
> > +
> >  static int __init ksm_slab_init(void)
> >  {
> >       rmap_item_cache =3D KSM_KMEM_CACHE(rmap_item, 0);
> > @@ -2389,6 +2402,106 @@ static int ksmd_should_run(void)
> >       return (ksm_run & KSM_RUN_MERGE) && !list_empty(&ksm_mm_head.mm_l=
ist);
> >  }
> >
> > +
> > +static int ksm_enter(struct mm_struct *mm, unsigned long *vm_flags)
> > +{
> > +     int err;
> > +
> > +     if (*vm_flags & (VM_MERGEABLE | VM_SHARED  | VM_MAYSHARE   |
> > +                      VM_PFNMAP    | VM_IO      | VM_DONTEXPAND |
> > +                      VM_HUGETLB | VM_MIXEDMAP))
> > +             return 0;
> > +
> > +#ifdef VM_SAO
> > +     if (*vm_flags & VM_SAO)
> > +             return 0;
> > +#endif
> > +#ifdef VM_SPARC_ADI
> > +     if (*vm_flags & VM_SPARC_ADI)
> > +             return 0;
> > +#endif
> > +     if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
> > +             err =3D __ksm_enter(mm);
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> > +     *vm_flags |=3D VM_MERGEABLE;
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Register all vmas for all processes in the system with KSM.
> > + * Note that every call to ksm_, for a given vma, after the first
> > + * does nothing but set flags.
> > + */
> > +void ksm_import_task_vma(struct task_struct *task)
> > +{
> > +     struct vm_area_struct *vma;
> > +     struct mm_struct *mm;
> > +     int error;
> > +
> > +     mm =3D get_task_mm(task);
> > +     if (!mm)
> > +             return;
> > +     down_write(&mm->mmap_sem);
> > +     vma =3D mm->mmap;
> > +     while (vma) {
> > +             error =3D ksm_enter(vma->vm_mm, &vma->vm_flags);
> > +             vma =3D vma->vm_next;
> > +     }
> > +     up_write(&mm->mmap_sem);
> > +     mmput(mm);
> > +}
> > +
> > +static int ksm_seeker_thread(void *nothing)
>
> Is it really necessary to have an extra thread in ksm just to add vma's
> for scanning? Can we do it right from the scanner thread? Also, may be
> it is better to add vma's at their creation time when KSM_MODE_ALWAYS is
> enabled?
>
> Thank you,
> Pasha

Oh, thats a long story, and my english to bad for describe all things,
even that hard to find linux-mm conversation several years ago about that.

Anyway, so:
In V2 - i use scanner thread to add VMA, but i think scanner do that
with too high rate.
i.e. walk on task list, and get new task every 20ms, to wait write semaphor=
e,
to get VMA...
To high rate for task list scanner, i think it's overkill.

About add VMA from creation time,
UKSM add ksm_enter() hooks to mm subsystem, i port that to KSM.
But some mm people say what they not like add KSM hooks to other subsystems=
.
And want ksm do that internally by some way.

Frankly speaking i didn't have enough knowledge and skills to do that
another way in past time.
They also suggest me look to THP for that logic, but i can't find how
THP do that without hooks, and
where THP truly scan memory.

So, after all of that i implemented this in that way.
In first iteration as part of ksm scan thread, and in second, by
separate thread.
Because that allow to add VMA in fully independent way.

Thanks!
