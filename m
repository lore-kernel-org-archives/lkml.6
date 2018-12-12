Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9524C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CB82086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a44j1xTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CB82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeLLNvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:51:52 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:33817 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbeLLNvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:51:51 -0500
Received: by mail-it1-f196.google.com with SMTP id x124so13704997itd.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 05:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eEpCoLPa3YrSbQPOUuLkkfExo2IQG3MVLYpYKqVQQqM=;
        b=a44j1xTm7+YjGmVQhZtdjl9niRXGEJI+zMU95jJC3GQmKGbT5qr9vit3NMMUnb4ybW
         ea14xlejYn5Bs/vD3Shmjl+4CoBJyYJ2p9bVmrZq/M8kCwn4fApbRqD3++mUo3cr6W4h
         sARjkfLFDoS28YPoITsKGmyeXIpjfzGjayx2y3Pby0xGmVcmN91Tsi5rcXoJ51TpVDSV
         7OlKQKoW0331ULhS2UiwAwzxPSCyS7Cnus0qCfMPV0dW+L5RUzTl/4jU0fPDbbsFGOLl
         pPNZ0iO486y0ni0FwqCD0pL5ZxqmYTQrbB3Xcz/zihlZiRHA5BiioUD6G2CbLCD4hlhN
         Me9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eEpCoLPa3YrSbQPOUuLkkfExo2IQG3MVLYpYKqVQQqM=;
        b=nwal2r9DR+B7ZcpufJRhN6Bis7w66pn2pVf7M01+RCyJZ84TLNvZmKffZ8AFX9aivu
         z43fvpNzTUCaHIhU2i1LJWslOKsCi2EfEvRGKY+m/R+qplS8RYu6ZtdrcMjQRyKEfnzD
         gEyDVuKlD0SFrec/wc2RZwP1DNshT0LEajCQqLOE22cbidE5zxdt3Hipi24m03g9bqcQ
         /i1gJVbUF3fZN47XWPXbNs++9hoqttlC2jYCP0FuYwOENBwPYYUmZyZWiOCerhQCFHrY
         6Ai2DX80optIOQW6CUZ/kRH4FWS/qOvXMjHpDgyhu+s9adNyCxcFu4xuOkeEcIOpca/z
         /7/w==
X-Gm-Message-State: AA+aEWaKcwwWlIcCCuVlrdSGX0+QHHOdSe88W5koa/fMKfbD5s6R3tn1
        taIly7Kht39DBbu7/UAzj4trOi8U61xjc4FvoH4=
X-Google-Smtp-Source: AFSGD/WlNraaJDU+iXTm5iViDyyO+yy39mZAwN6litQXFGstWtT/pRP+KWKwJUbcHqKvyJRMgdoI/DB70YyeNRg1/E0=
X-Received: by 2002:a24:a08a:: with SMTP id o132mr6095554ite.1.1544622710375;
 Wed, 12 Dec 2018 05:51:50 -0800 (PST)
MIME-Version: 1.0
References: <20181211051254.16633-1-peterx@redhat.com> <1fc103f7-3164-007d-bcfd-7ad7c60bb6ec@yandex-team.ru>
 <20181212051540.GA8970@xz-x1>
In-Reply-To: <20181212051540.GA8970@xz-x1>
From:   Konstantin Khlebnikov <koct9i@gmail.com>
Date:   Wed, 12 Dec 2018 16:51:38 +0300
Message-ID: <CALYGNiOSrwH-JCEqsZCeCNwnyJBTy_WtpjVuq5hpo6MYX=db7Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm: thp: fix flags for pmd migration when split
To:     peterx@redhat.com
Cc:     =?UTF-8?B?0JrQvtC90YHRgtCw0L3RgtC40L0g0KXQu9C10LHQvdC40LrQvtCy?= 
        <khlebnikov@yandex-team.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, dave.jiang@intel.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 8:15 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Dec 11, 2018 at 11:21:44AM +0300, Konstantin Khlebnikov wrote:
> > On 11.12.2018 8:12, Peter Xu wrote:
> > > When splitting a huge migrating PMD, we'll transfer all the existing
> > > PMD bits and apply them again onto the small PTEs.  However we are
> > > fetching the bits unconditionally via pmd_soft_dirty(), pmd_write()
> > > or pmd_yound() while actually they don't make sense at all when it's
> > > a migration entry.  Fix them up by make it conditional.
> > >
> > > Note that if my understanding is correct about the problem then if
> > > without the patch there is chance to lose some of the dirty bits in
> > > the migrating pmd pages (on x86_64 we're fetching bit 11 which is part
> > > of swap offset instead of bit 2) and it could potentially corrupt the
> > > memory of an userspace program which depends on the dirty bit.
> > >
> > > CC: Andrea Arcangeli <aarcange@redhat.com>
> > > CC: Andrew Morton <akpm@linux-foundation.org>
> > > CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > CC: Matthew Wilcox <willy@infradead.org>
> > > CC: Michal Hocko <mhocko@suse.com>
> > > CC: Dave Jiang <dave.jiang@intel.com>
> > > CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> > > CC: Souptick Joarder <jrdr.linux@gmail.com>
> > > CC: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > > CC: linux-mm@kvack.org
> > > CC: linux-kernel@vger.kernel.org
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > > v2:
> > > - fix it up for young/write/dirty bits too [Konstantin]
> > > ---
> > >   mm/huge_memory.c | 15 ++++++++++-----
> > >   1 file changed, 10 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index f2d19e4fe854..b00941b3d342 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -2157,11 +2157,16 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
> > >             page = pmd_page(old_pmd);
> > >     VM_BUG_ON_PAGE(!page_count(page), page);
> > >     page_ref_add(page, HPAGE_PMD_NR - 1);
> > > -   if (pmd_dirty(old_pmd))
> > > -           SetPageDirty(page);
> > > -   write = pmd_write(old_pmd);
> > > -   young = pmd_young(old_pmd);
> > > -   soft_dirty = pmd_soft_dirty(old_pmd);
> > > +   if (unlikely(pmd_migration)) {
> > > +           soft_dirty = pmd_swp_soft_dirty(old_pmd);
> > > +           young = write = false;
> > > +   } else {
> > > +           if (pmd_dirty(old_pmd))
> > > +                   SetPageDirty(page);
> > > +           write = pmd_write(old_pmd);
> > > +           young = pmd_young(old_pmd);
> > > +           soft_dirty = pmd_soft_dirty(old_pmd);
> > > +   }
> >
> > Write/read-only is encoded into migration entry.
> > I suppose there should be something like this:
> >
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2151,16 +2151,21 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
> >
> >                 entry = pmd_to_swp_entry(old_pmd);
> >                 page = pfn_to_page(swp_offset(entry));
> > +               write = is_write_migration_entry(entry);
> > +               young = false;
> > +               soft_dirty = pmd_swp_soft_dirty(old_pmd);
> >         } else
> >  #endif
> > +       {
> >                 page = pmd_page(old_pmd);
> > +               if (pmd_dirty(old_pmd))
> > +                       SetPageDirty(page);
> > +               write = pmd_write(old_pmd);
> > +               young = pmd_young(old_pmd);
> > +               soft_dirty = pmd_soft_dirty(old_pmd);
> > +       }
> >         VM_BUG_ON_PAGE(!page_count(page), page);
> >         page_ref_add(page, HPAGE_PMD_NR - 1);
> > -       if (pmd_dirty(old_pmd))
> > -               SetPageDirty(page);
> > -       write = pmd_write(old_pmd);
> > -       young = pmd_young(old_pmd);
> > -       soft_dirty = pmd_soft_dirty(old_pmd);
> >
> >         /*
> >          * Withdraw the table only after we mark the pmd entry invalid.
> >
>
> Oops yes, I missed the write bit.  Thanks for pointing it out.
>
> Should I repost with your authorship and your sign-off?

Feel free to use this piece for your own patch.

> Or even I'll
> consider to directly drop the CONFIG_ARCH_ENABLE_THP_MIGRATION if with
> that since I don't see much gain to keep it:

Yep, this ifdef could be removed.
Without CONFIG_ARCH_ENABLE_THP_MIGRATION
is_pmd_migration_entry() is constant 0 so compiler should eliminate "if" branch.

>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f2d19e4fe854..aebade83cec9 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2145,23 +2145,25 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>          */
>         old_pmd = pmdp_invalidate(vma, haddr, pmd);
>
> -#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>         pmd_migration = is_pmd_migration_entry(old_pmd);
> -       if (pmd_migration) {
> +       if (unlikely(pmd_migration)) {
>                 swp_entry_t entry;
>
>                 entry = pmd_to_swp_entry(old_pmd);
>                 page = pfn_to_page(swp_offset(entry));
> -       } else
> -#endif
> +               write = is_write_migration_entry(entry);
> +               young = false;
> +               soft_dirty = pmd_swp_soft_dirty(old_pmd);
> +       } else {
>                 page = pmd_page(old_pmd);
> +               if (pmd_dirty(old_pmd))
> +                       SetPageDirty(page);
> +               write = pmd_write(old_pmd);
> +               young = pmd_young(old_pmd);
> +               soft_dirty = pmd_soft_dirty(old_pmd);
> +       }
>         VM_BUG_ON_PAGE(!page_count(page), page);
>         page_ref_add(page, HPAGE_PMD_NR - 1);
> -       if (pmd_dirty(old_pmd))
> -               SetPageDirty(page);
> -       write = pmd_write(old_pmd);
> -       young = pmd_young(old_pmd);
> -       soft_dirty = pmd_soft_dirty(old_pmd);
>
>         /*
>          * Withdraw the table only after we mark the pmd entry invalid.
>
> Thanks,
>
> --
> Peter Xu
>
