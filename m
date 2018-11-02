Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D200EC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725FA20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G2ZJVjQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725FA20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbeKCAII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:08:08 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33641 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeKCAIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:08:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id q1so1966990otk.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 08:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RPwYUuswu7A6c/30B5Ne2bhkxIzY9uenp0pCzJReDtA=;
        b=G2ZJVjQ9CTH3x74FsPcQQI9SD7cazfG76PkPq3y8Hp747Cl4zQn23qJZreo5ro3kG/
         pzNS2o6QVo67GBTMsi9uExYlahyvhPEpDIqeEiwVOi5AXSmYqqvTKm7VwKRpr2zPyKfi
         sLA36XyyNnr1yTxzRdFlgRRioOZeAyIRqLpyqHY0pMrhXBm8AXhUfXQr9L3ovtMTSiTF
         kndxzFQMOrjqj6Y4g4vqY65ikCIraL8sz2G8oHZlNGjXJf3hExxMnyeXLXfQscahxXGN
         X0Gp7L0A6qNG3OJjm3snSaMTdO1pPQbjBOJVxCQ9d30UQBL1QZJiY/uKHXyvcpxZzReV
         DVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RPwYUuswu7A6c/30B5Ne2bhkxIzY9uenp0pCzJReDtA=;
        b=Gb/IBe5m90y2ax8RorgousxdnEet7mus6Y2CzP9XOKCGsYiG+un7vuV42m4bWp6LuM
         AhmdkJR1HDD6fbsOG1wpLT2Aiub50UN1u66uhlsl2iqipOOTvs5U8+doCrEykL+hh3bR
         Y3Iu4szpgrouRwQQwjEJhm8w7StGJjpuxwqJwGyKezA61a0FzVMsxSofwGCShSEXeHqZ
         drPbN6LqOI0qChXSoUWE86DeshRJWTxJmelnXPuaKUs9i/cX/SqzS3zunO/Ad5ndlQUQ
         aG1FF0hdkViR4+JgeCNaK+mq/6HuE+zbApirt6DUny+21WJVN/YHFWoHl4JCNIZCCeRM
         5qnQ==
X-Gm-Message-State: AGRZ1gK9XN+7BhjMTAl7erjLh3oV2qx9VcYel3Uy8vVQj7FAuB+tsUSN
        n+FTWQUgqSGlFNect7EISSI7ZQoY5AUAhcUTGYZK1Q==
X-Google-Smtp-Source: AJdET5cIn6YbWPQQfm6iwf9WF7gI0n5TI3tzVl22/JxqSf+cjE9+53J63qgAIE8OciQX7IC1UvkgRUBQrcsLXBUmv2Q=
X-Received: by 2002:a9d:638f:: with SMTP id w15mr4669145otk.230.1541170843809;
 Fri, 02 Nov 2018 08:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <1541164962-28533-1-git-send-email-will.deacon@arm.com> <20181102145638.gehn7eszv22lelh6@kshutemo-mobl1>
In-Reply-To: <20181102145638.gehn7eszv22lelh6@kshutemo-mobl1>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 2 Nov 2018 16:00:17 +0100
Message-ID: <CAG48ez38PmTKPq_UQ4q39bwtWmb7epyet3-iSvt5b7JfwmCniw@mail.gmail.com>
Subject: Re: [PATCH] mremap: properly flush TLB before releasing the page
To:     kirill@shutemov.name
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 3:56 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> On Fri, Nov 02, 2018 at 01:22:42PM +0000, Will Deacon wrote:
> > From: Linus Torvalds <torvalds@linux-foundation.org>
> >
> > Commit eb66ae030829605d61fbef1909ce310e29f78821 upstream.
>
> I have never seen the original patch on mailing lists, so I'll reply to
> the backport.

For context, the original bug report is public at
https://bugs.chromium.org/p/project-zero/issues/detail?id=1695 .

> > This is a backport to stable 4.4.y.
> >
> > Jann Horn points out that our TLB flushing was subtly wrong for the
> > mremap() case.  What makes mremap() special is that we don't follow the
> > usual "add page to list of pages to be freed, then flush tlb, and then
> > free pages".  No, mremap() obviously just _moves_ the page from one page
> > table location to another.
> >
> > That matters, because mremap() thus doesn't directly control the
> > lifetime of the moved page with a freelist: instead, the lifetime of the
> > page is controlled by the page table locking, that serializes access to
> > the entry.
>
> I believe we do control the lifetime of the page with mmap_sem, don't we?

Nope. For file-backed pages, someone can come through the file mapping
and free our pages, e.g. through the ftruncate() syscall.

> I mean any shoot down of the page from a mapping would require at least
> down_read(mmap_sem) and we hold down_write(mmap_sem). Hm?
>
> > As a result, we need to flush the TLB not just before releasing the lock
> > for the source location (to avoid any concurrent accesses to the entry),
> > but also before we release the destination page table lock (to avoid the
> > TLB being flushed after somebody else has already done something to that
> > page).
> >
> > This also makes the whole "need_flush" logic unnecessary, since we now
> > always end up flushing the TLB for every valid entry.
> >
> > Reported-and-tested-by: Jann Horn <jannh@google.com>
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > Tested-by: Ingo Molnar <mingo@kernel.org>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > [will: backport to 4.4 stable]
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  mm/huge_memory.c |  6 +++++-
> >  mm/mremap.c      | 21 ++++++++++++++++-----
> >  2 files changed, 21 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index c4ea57ee2fd1..465786cd6490 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1511,7 +1511,7 @@ int move_huge_pmd(struct vm_area_struct *vma, struct vm_area_struct *new_vma,
> >       spinlock_t *old_ptl, *new_ptl;
> >       int ret = 0;
> >       pmd_t pmd;
> > -
> > +     bool force_flush = false;
> >       struct mm_struct *mm = vma->vm_mm;
> >
> >       if ((old_addr & ~HPAGE_PMD_MASK) ||
> > @@ -1539,6 +1539,8 @@ int move_huge_pmd(struct vm_area_struct *vma, struct vm_area_struct *new_vma,
> >               if (new_ptl != old_ptl)
> >                       spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> >               pmd = pmdp_huge_get_and_clear(mm, old_addr, old_pmd);
> > +             if (pmd_present(pmd))
> > +                     force_flush = true;
> >               VM_BUG_ON(!pmd_none(*new_pmd));
> >
> >               if (pmd_move_must_withdraw(new_ptl, old_ptl)) {
> > @@ -1547,6 +1549,8 @@ int move_huge_pmd(struct vm_area_struct *vma, struct vm_area_struct *new_vma,
> >                       pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
> >               }
> >               set_pmd_at(mm, new_addr, new_pmd, pmd_mksoft_dirty(pmd));
> > +             if (force_flush)
> > +                     flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
> >               if (new_ptl != old_ptl)
> >                       spin_unlock(new_ptl);
> >               spin_unlock(old_ptl);
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index fe7b7f65f4f4..450b306d473e 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -96,6 +96,8 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
> >       struct mm_struct *mm = vma->vm_mm;
> >       pte_t *old_pte, *new_pte, pte;
> >       spinlock_t *old_ptl, *new_ptl;
> > +     bool force_flush = false;
> > +     unsigned long len = old_end - old_addr;
> >
> >       /*
> >        * When need_rmap_locks is true, we take the i_mmap_rwsem and anon_vma
> > @@ -143,12 +145,26 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
> >               if (pte_none(*old_pte))
> >                       continue;
> >               pte = ptep_get_and_clear(mm, old_addr, old_pte);
> > +             /*
> > +              * If we are remapping a valid PTE, make sure
> > +              * to flush TLB before we drop the PTL for the PTE.
> > +              *
> > +              * NOTE! Both old and new PTL matter: the old one
> > +              * for racing with page_mkclean(), the new one to
> > +              * make sure the physical page stays valid until
> > +              * the TLB entry for the old mapping has been
> > +              * flushed.
> > +              */
>
> Could you elaborate on the race with page_mkclean()?
>
> I think the new logic is unnecessary strict (and slow).
>
> Any barely sane userspace must not access the old mapping after
> mremap(MREMAP_MAYMOVE) called and must not access the new mapping
> before the mremap() returns.
>
> The old logic *should* be safe if this argument valid.
>
> Do I miss something?
>
> > +             if (pte_present(pte))
> > +                     force_flush = true;
> >               pte = move_pte(pte, new_vma->vm_page_prot, old_addr, new_addr);
> >               pte = move_soft_dirty_pte(pte);
> >               set_pte_at(mm, new_addr, new_pte, pte);
> >       }
> >
> >       arch_leave_lazy_mmu_mode();
> > +     if (force_flush)
> > +             flush_tlb_range(vma, old_end - len, old_end);
> >       if (new_ptl != old_ptl)
> >               spin_unlock(new_ptl);
> >       pte_unmap(new_pte - 1);
> > @@ -168,7 +184,6 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> >  {
> >       unsigned long extent, next, old_end;
> >       pmd_t *old_pmd, *new_pmd;
> > -     bool need_flush = false;
> >       unsigned long mmun_start;       /* For mmu_notifiers */
> >       unsigned long mmun_end;         /* For mmu_notifiers */
> >
> > @@ -207,7 +222,6 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> >                                       anon_vma_unlock_write(vma->anon_vma);
> >                       }
> >                       if (err > 0) {
> > -                             need_flush = true;
> >                               continue;
> >                       } else if (!err) {
> >                               split_huge_page_pmd(vma, old_addr, old_pmd);
> > @@ -224,10 +238,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> >                       extent = LATENCY_LIMIT;
> >               move_ptes(vma, old_pmd, old_addr, old_addr + extent,
> >                         new_vma, new_pmd, new_addr, need_rmap_locks);
> > -             need_flush = true;
> >       }
> > -     if (likely(need_flush))
> > -             flush_tlb_range(vma, old_end-len, old_addr);
> >
> >       mmu_notifier_invalidate_range_end(vma->vm_mm, mmun_start, mmun_end);
> >
> > --
> > 2.1.4
> >
>
> --
>  Kirill A. Shutemov
