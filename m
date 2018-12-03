Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306CDC65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDF82147C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhtBZibI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDF82147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbeLCEWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 23:22:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41837 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeLCEWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 23:22:02 -0500
Received: by mail-lj1-f194.google.com with SMTP id z80-v6so10005028ljb.8;
        Sun, 02 Dec 2018 20:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SYCAqsoUZtLwLDlDfp6OtymT17dsOHDXcRiDcCLSAAI=;
        b=nhtBZibIwnBkPDHJCbP4PMmNHMC+hiwcwr8/1k8ga5Sa94daTE5kR2ylsNtJ+WtuWX
         vi8JsMjhfolq2sXSmYCU4pYFsgI7iElOBqAPbJZEu5BZThXXOWrM6uSz8ybFxIjUXrQO
         qfKX9UjocO3UbX66fUOUff0DRTmVTBfapCxbvoLq1kB6/jVnMQ/bgXyMgoE+TSOjkSwA
         StdMUVUi3E8wkOM9ibp9H4LqFJqe9Sa6/SeON6fsguiNgph3EZevdAYdC0Di6jhurgiJ
         ZEI1SQdsjs+0WCFseHxPJ+rzczhClEwUUA3de/d0wax+aruFf9NX5IqUtZkpvZAlrGsc
         Eodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYCAqsoUZtLwLDlDfp6OtymT17dsOHDXcRiDcCLSAAI=;
        b=B4Eh/MmKde8OweatztpOm9gDLsvj+ssYt3wMjW/MilrcbnjHyraCZZ8JAvsdNKwMM9
         0+XdXsLOPQgMY7KTOhyjKADyb2pPGSQTzqVHpGZPMRo5JpeBbnrP6/RvfZqSZK+HxK6U
         vz6wyvA3T4LRkAtuht1cIfJoqwn5+wxkYevtjnkXlzR3/NwW7LiAaDX3Ae7M6gLm8VOY
         ACklSPNR7gUxxY5iqvkR8GL4besbV6zK+173MVF9MnGqMhMm7OWKZ3c3DdmpPc+LNrzz
         WMEwwNI4KOIbuCfevcBsZ6BUhdsjQ/HG4Y4N+4Bc1Y+TC1S6LZkTGZYVfZ8cgSSq06Er
         p3iA==
X-Gm-Message-State: AA+aEWbKjcXVelOa2NjjxliyEKUVbV7YgZPfWuRAj+T0FS6+/fbB4j6V
        Hcd47ujpJNRj/GPmGeWT+gHYl3KVkYTs2EXLt/Y=
X-Google-Smtp-Source: AFSGD/ULEaU52DpGnoEB0+B391rVIknIq95m9aFt1PWmOEugtipxjN1gDll5xHanHFuNsFuqFVfAnPwwh/hYD9vnflk=
X-Received: by 2002:a2e:630a:: with SMTP id x10-v6mr8707628ljb.11.1543810916221;
 Sun, 02 Dec 2018 20:21:56 -0800 (PST)
MIME-Version: 1.0
References: <20181202061944.GA3094@jordon-HP-15-Notebook-PC> <20181202111313.GC6959@rapoport-lnx>
In-Reply-To: <20181202111313.GC6959@rapoport-lnx>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 3 Dec 2018 09:51:45 +0530
Message-ID: <CAFqt6zbvyaPF3tUA1-=RsfSM14p7Rx5NgQqAeW5-JUfd+NrJ2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] mm: Introduce new vm_insert_range API
To:     rppt@linux.ibm.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        vbabka@suse.cz, Rik van Riel <riel@surriel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        rppt@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin.murphy@arm.com, iamjoonsoo.kim@lge.com, treding@nvidia.com,
        Kees Cook <keescook@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        stefanr@s5r6.in-berlin.de, hjc@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie,
        oleksandr_andrushchenko@epam.com, joro@8bytes.org,
        pawel@osciak.com, Kyungmin Park <kyungmin.park@samsung.com>,
        mchehab@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, xen-devel@lists.xen.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Sun, Dec 2, 2018 at 4:43 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Sun, Dec 02, 2018 at 11:49:44AM +0530, Souptick Joarder wrote:
> > Previouly drivers have their own way of mapping range of
> > kernel pages/memory into user vma and this was done by
> > invoking vm_insert_page() within a loop.
> >
> > As this pattern is common across different drivers, it can
> > be generalized by creating a new function and use it across
> > the drivers.
> >
> > vm_insert_range is the new API which will be used to map a
> > range of kernel memory/pages to user vma.
> >
> > This API is tested by Heiko for Rockchip drm driver, on rk3188,
> > rk3288, rk3328 and rk3399 with graphics.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Reviewed-by: Matthew Wilcox <willy@infradead.org>
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  include/linux/mm_types.h |  3 +++
> >  mm/memory.c              | 38 ++++++++++++++++++++++++++++++++++++++
> >  mm/nommu.c               |  7 +++++++
> >  3 files changed, 48 insertions(+)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 5ed8f62..15ae24f 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -523,6 +523,9 @@ extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
> >  extern void tlb_finish_mmu(struct mmu_gather *tlb,
> >                               unsigned long start, unsigned long end);
> >
> > +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> > +                     struct page **pages, unsigned long page_count);
> > +
>
> This seem to belong to include/linux/mm.h, near vm_insert_page()

Ok, I will change it. Apart from this change does it looks good ?

>
> >  static inline void init_tlb_flush_pending(struct mm_struct *mm)
> >  {
> >       atomic_set(&mm->tlb_flush_pending, 0);
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 15c417e..84ea46c 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1478,6 +1478,44 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
> >  }
> >
> >  /**
> > + * vm_insert_range - insert range of kernel pages into user vma
> > + * @vma: user vma to map to
> > + * @addr: target user address of this page
> > + * @pages: pointer to array of source kernel pages
> > + * @page_count: number of pages need to insert into user vma
> > + *
> > + * This allows drivers to insert range of kernel pages they've allocated
> > + * into a user vma. This is a generic function which drivers can use
> > + * rather than using their own way of mapping range of kernel pages into
> > + * user vma.
> > + *
> > + * If we fail to insert any page into the vma, the function will return
> > + * immediately leaving any previously-inserted pages present.  Callers
> > + * from the mmap handler may immediately return the error as their caller
> > + * will destroy the vma, removing any successfully-inserted pages. Other
> > + * callers should make their own arrangements for calling unmap_region().
> > + *
> > + * Context: Process context. Called by mmap handlers.
> > + * Return: 0 on success and error code otherwise
> > + */
> > +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> > +                     struct page **pages, unsigned long page_count)
> > +{
> > +     unsigned long uaddr = addr;
> > +     int ret = 0, i;
> > +
> > +     for (i = 0; i < page_count; i++) {
> > +             ret = vm_insert_page(vma, uaddr, pages[i]);
> > +             if (ret < 0)
> > +                     return ret;
> > +             uaddr += PAGE_SIZE;
> > +     }
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL(vm_insert_range);
> > +
> > +/**
> >   * vm_insert_page - insert single page into user vma
> >   * @vma: user vma to map to
> >   * @addr: target user address of this page
> > diff --git a/mm/nommu.c b/mm/nommu.c
> > index 749276b..d6ef5c7 100644
> > --- a/mm/nommu.c
> > +++ b/mm/nommu.c
> > @@ -473,6 +473,13 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
> >  }
> >  EXPORT_SYMBOL(vm_insert_page);
> >
> > +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> > +                     struct page **pages, unsigned long page_count)
> > +{
> > +     return -EINVAL;
> > +}
> > +EXPORT_SYMBOL(vm_insert_range);
> > +
> >  /*
> >   *  sys_brk() for the most part doesn't need the global kernel
> >   *  lock, except when an application is doing something nasty
> > --
> > 1.9.1
> >
>
> --
> Sincerely yours,
> Mike.
>
