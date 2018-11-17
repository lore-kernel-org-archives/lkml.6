Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19B4C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 06:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7014E2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 06:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAE4J3qL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7014E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbeKQRIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 12:08:53 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40882 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeKQRIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 12:08:53 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so17987858lfe.7;
        Fri, 16 Nov 2018 22:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=op/Fzc5gB1jGezgnzcbiiSkhfxRQN/vTo5Lc/zGssBY=;
        b=SAE4J3qLhrdpDp0Jj83HXSB7a8TCTKQgvwySUYBJvKp4L6Rwd+T/e6kFmLQ7OJ/J5V
         +gN7LuoRttYqsurn6SF3tnuMauEUMjDkKa1Ci6aRyN5xuSIayBZHa+NpwHKm8BGnzdTR
         YI0WUKklVlpJfEjHuwjpJCLrdNvubW6DttrkslFCd5Fsl5FtpNxc4+GEAJEUh+xFB1cL
         lUFyaB3+RgE1PRlU6YgRlc4GkL2kfc8picgtAkLIdx3etuVEHcW/lKMa1AUDI1OG7IQD
         OEqrtua4k7J9MwQ+tVs1ZfH1KOl8wKdRM+h6IQQLw2REOCbGjUYB13nCItNXpqGsrBPY
         nlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=op/Fzc5gB1jGezgnzcbiiSkhfxRQN/vTo5Lc/zGssBY=;
        b=rffe9a8KZm5P8NBXa5c2lcENSK8Pa2XtNdDsO5zLbcXmZns9e632B+yUoxEnBCU0cR
         clYbMG9IDd2vWJVzWxGCC4gPh7aJMWIWeUaK/3qGx6Qn8Lp7N6xIz+4NuULiGwIjBAkd
         6oyDF0HM/3cM67EJMkZamtsMEj+uMcFmFW9sVLSWOyeQeBHo9Ls5fgZ5Y/+oYT4CKAya
         HpM1GX71N1o6F5SaLrRlyB6u0gr0JzuBJ12nvVw1OUj0Ab/8GSvW/8VGYdJFtEatK4Cg
         6F9dieuqMMbRkAUWuHyHglAydzai+fE9x9d89+ee2oYY0q8Ekwa2QGX/25KrFve22Hif
         r46A==
X-Gm-Message-State: AGRZ1gK+NqqgAuGViY+lcCpL3fkE4wI72yzvwz7N/7TvosoLHuFXir/8
        Nko2/eqwmcHlcV0ZGiqWp3fRvnSU2Xydi90WmEY=
X-Google-Smtp-Source: AJdET5c4TNXE7Ec4sXVwE8J+pNBScRs0cc6cthsrJ7LOwh6k9pb9gE01PmWrTGpkDPrcIiLtowBLy4JFOcCzIhr5ZKw=
X-Received: by 2002:a19:d912:: with SMTP id q18mr6509483lfg.24.1542437590548;
 Fri, 16 Nov 2018 22:53:10 -0800 (PST)
MIME-Version: 1.0
References: <20181115154530.GA27872@jordon-HP-15-Notebook-PC> <20181116182836.GB17088@rapoport-lnx>
In-Reply-To: <20181116182836.GB17088@rapoport-lnx>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 17 Nov 2018 12:26:38 +0530
Message-ID: <CAFqt6zYp0j999WXw9Jus0oZMjADQQkPfso8btv6du6L9CE3PXA@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm: Introduce new vm_insert_range API
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

On Fri, Nov 16, 2018 at 11:59 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Thu, Nov 15, 2018 at 09:15:30PM +0530, Souptick Joarder wrote:
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
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Reviewed-by: Matthew Wilcox <willy@infradead.org>
> > ---
> >  include/linux/mm_types.h |  3 +++
> >  mm/memory.c              | 28 ++++++++++++++++++++++++++++
> >  mm/nommu.c               |  7 +++++++
> >  3 files changed, 38 insertions(+)
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
> >  static inline void init_tlb_flush_pending(struct mm_struct *mm)
> >  {
> >       atomic_set(&mm->tlb_flush_pending, 0);
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 15c417e..da904ed 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1478,6 +1478,34 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
> >  }
> >
> >  /**
> > + * vm_insert_range - insert range of kernel pages into user vma
> > + * @vma: user vma to map to
> > + * @addr: target user address of this page
> > + * @pages: pointer to array of source kernel pages
> > + * @page_count: no. of pages need to insert into user vma
> > + *
> > + * This allows drivers to insert range of kernel pages they've allocated
> > + * into a user vma. This is a generic function which drivers can use
> > + * rather than using their own way of mapping range of kernel pages into
> > + * user vma.
>
> Please add the return value and context descriptions.
>
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

Sure I will wait for some time to get additional review comments and
add all of those requested changes in v2.

Any further feedback on driver changes as part of this patch series ?
