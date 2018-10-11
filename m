Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E1DC28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F90820835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="o3IUKIgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F90820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeJLGxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 02:53:45 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38346 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeJLGxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 02:53:45 -0400
Received: by mail-oi1-f196.google.com with SMTP id u197-v6so8481598oif.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 16:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GfWMLeTPrwZhqn4Jj+gUe61EvNxwuCNb9W1/NvTM3nE=;
        b=o3IUKIgBABfBLUQOAxYzsKVmin/pnO/edwezAZ/WW4z+6wjx9lmlO3JD12QWzTQvy1
         VPBiTtFaEzHBMFKCX7cv9xVojq4aaofsdRqdRpv7n2lBKL6a5TpQGIuYAVK64vOGZYYy
         7CMRtE2VzDhcGCWGl1biH0nUcxl0Uibplf6o8+AOu69GgiS2q8PMrL8cjTXN2PpXcZw+
         ++n8E4Y22JcR0GGV/VCkqiwY/6NuRusxRnybjO7GlWtn66ywikBcDKntv4t+Jmvw11MA
         Q5hJIuu5LXgbHxUpBgUDp76d41Iex+qcVbj1Os21nJ98cqXPU3OnLPcUiRPQUrBWP6yM
         /LqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GfWMLeTPrwZhqn4Jj+gUe61EvNxwuCNb9W1/NvTM3nE=;
        b=k/qxU8IfBJCs0BZIaFmROlT5YLA0KnX5zs/YxSj5IYQkYgDoE5tA7r6Wp0I21putgF
         EY0xqeLiKNEY/d5dyNzyQaNftTUhoM+IxUQo1ylKGsup67aFhiaKBN+SxVyO7tHV6lqU
         daz+nT0DyejQH+svOcnJC1hVlZvbmHjj7Mj7dNpYm6o9/2gbLAEgcMJZUkF9PxBhnODy
         DhGQaF26hryILS13RK4Ngz9QIzJ2Pdl+I/gHR9/g75023LL7kPZ0/5RoYBYwf3p7j7MP
         gUamQuMrJxFRPLuY9igWR587tHSSkkbsqbS6elvnM8q1f2VccND/bplKAMsLTO0exiw3
         emeA==
X-Gm-Message-State: ABuFfogi0qbOWcInxKF8vxNVeBH4Fcb+1H9nRxlOe5bQoJUNmkCZuzU+
        IwjxE4RqMgTB6p8DNdvRgGRvqzL0YgKXeGxGiIvTmA==
X-Google-Smtp-Source: ACcGV62bEg5JeoHXM4NJQyi/XpIl0VSLY7qu7YRqrh+rfXYOGKnMDgx3ro6/kV/d6GiS+12cXBWGJdJz01xIu4aLiP8=
X-Received: by 2002:aca:590b:: with SMTP id n11-v6mr1924716oib.232.1539300253254;
 Thu, 11 Oct 2018 16:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181011175542.13045-1-keith.busch@intel.com>
In-Reply-To: <20181011175542.13045-1-keith.busch@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 11 Oct 2018 16:24:02 -0700
Message-ID: <CAPcyv4gGqhGpR8g-HmNzoEnMAysO5uAO+8njeAokHq2CT9x71A@mail.gmail.com>
Subject: Re: [PATCHv2] mm/gup: Cache dev_pagemap while pinning pages
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 11:00 AM Keith Busch <keith.busch@intel.com> wrote:
>
> Getting pages from ZONE_DEVICE memory needs to check the backing device's
> live-ness, which is tracked in the device's dev_pagemap metadata. This
> metadata is stored in a radix tree and looking it up adds measurable
> software overhead.
>
> This patch avoids repeating this relatively costly operation when
> dev_pagemap is used by caching the last dev_pagemap while getting user
> pages. The gup_benchmark kernel self test reports this reduces time to
> get user pages to as low as 1/3 of the previous time.
>
> Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Other than the 2 comments below, this looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

[..]
> diff --git a/mm/gup.c b/mm/gup.c
> index 1abc8b4afff6..d2700dff6f66 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
[..]
> @@ -431,7 +430,22 @@ struct page *follow_page_mask(struct vm_area_struct *vma,
>                 return no_page_table(vma, flags);
>         }
>
> -       return follow_p4d_mask(vma, address, pgd, flags, page_mask);
> +       return follow_p4d_mask(vma, address, pgd, flags, ctx);
> +}
> +
> +struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
> +                        unsigned int foll_flags)
> +{
> +       struct page *page;
> +       struct follow_page_context ctx = {
> +               .pgmap = NULL,
> +               .page_mask = 0,
> +       };

You don't need to init all members. It is defined that if you init at
least one member then all non initialized members are set to zero, so
you should be able to do " = { 0 }".

> +
> +       page = follow_page_mask(vma, address, foll_flags, &ctx);
> +       if (ctx.pgmap)
> +               put_dev_pagemap(ctx.pgmap);
> +       return page;
>  }
>
>  static int get_gate_page(struct mm_struct *mm, unsigned long address,
> @@ -659,9 +673,9 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>                 unsigned int gup_flags, struct page **pages,
>                 struct vm_area_struct **vmas, int *nonblocking)
>  {
> -       long i = 0;
> -       unsigned int page_mask;
> +       long ret = 0, i = 0;
>         struct vm_area_struct *vma = NULL;
> +       struct follow_page_context ctx = {};

Does this have defined behavior? I would feel better with " = { 0 }"
to be explicit.

>
>         if (!nr_pages)
>                 return 0;
> @@ -691,12 +705,14 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>                                                 pages ? &pages[i] : NULL);
>                                 if (ret)
>                                         return i ? : ret;
> -                               page_mask = 0;
> +                               ctx.page_mask = 0;
>                                 goto next_page;
>                         }
>
> -                       if (!vma || check_vma_flags(vma, gup_flags))
> -                               return i ? : -EFAULT;
> +                       if (!vma || check_vma_flags(vma, gup_flags)) {
> +                               ret = -EFAULT;
> +                               goto out;
> +                       }
>                         if (is_vm_hugetlb_page(vma)) {
>                                 i = follow_hugetlb_page(mm, vma, pages, vmas,
>                                                 &start, &nr_pages, i,
> @@ -709,23 +725,26 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>                  * If we have a pending SIGKILL, don't keep faulting pages and
>                  * potentially allocating memory.
>                  */
> -               if (unlikely(fatal_signal_pending(current)))
> -                       return i ? i : -ERESTARTSYS;
> +               if (unlikely(fatal_signal_pending(current))) {
> +                       ret = -ERESTARTSYS;
> +                       goto out;
> +               }
>                 cond_resched();
> -               page = follow_page_mask(vma, start, foll_flags, &page_mask);
> +
> +               page = follow_page_mask(vma, start, foll_flags, &ctx);
>                 if (!page) {
> -                       int ret;
>                         ret = faultin_page(tsk, vma, start, &foll_flags,
>                                         nonblocking);
>                         switch (ret) {
>                         case 0:
>                                 goto retry;
> +                       case -EBUSY:
> +                               ret = 0;
> +                               /* FALLTHRU */
>                         case -EFAULT:
>                         case -ENOMEM:
>                         case -EHWPOISON:
> -                               return i ? i : ret;
> -                       case -EBUSY:
> -                               return i;
> +                               goto out;
>                         case -ENOENT:
>                                 goto next_page;
>                         }
> @@ -737,27 +756,31 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>                          */
>                         goto next_page;
>                 } else if (IS_ERR(page)) {
> -                       return i ? i : PTR_ERR(page);
> +                       ret = PTR_ERR(page);
> +                       goto out;
>                 }
>                 if (pages) {
>                         pages[i] = page;
>                         flush_anon_page(vma, page, start);
>                         flush_dcache_page(page);
> -                       page_mask = 0;
> +                       ctx.page_mask = 0;
>                 }
>  next_page:
>                 if (vmas) {
>                         vmas[i] = vma;
> -                       page_mask = 0;
> +                       ctx.page_mask = 0;
>                 }
> -               page_increm = 1 + (~(start >> PAGE_SHIFT) & page_mask);
> +               page_increm = 1 + (~(start >> PAGE_SHIFT) & ctx.page_mask);
>                 if (page_increm > nr_pages)
>                         page_increm = nr_pages;
>                 i += page_increm;
>                 start += page_increm * PAGE_SIZE;
>                 nr_pages -= page_increm;
>         } while (nr_pages);
> -       return i;
> +out:
> +       if (ctx.pgmap)
> +               put_dev_pagemap(ctx.pgmap);
> +       return i ? i : ret;
>  }
>
>  static bool vma_permits_fault(struct vm_area_struct *vma,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 533f9b00147d..d2b510fe5156 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -852,11 +852,10 @@ static void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
>  }
>
>  struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
> -               pmd_t *pmd, int flags)
> +               pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
>  {
>         unsigned long pfn = pmd_pfn(*pmd);
>         struct mm_struct *mm = vma->vm_mm;
> -       struct dev_pagemap *pgmap;
>         struct page *page;
>
>         assert_spin_locked(pmd_lockptr(mm, pmd));
> @@ -886,12 +885,11 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
>                 return ERR_PTR(-EEXIST);
>
>         pfn += (addr & ~PMD_MASK) >> PAGE_SHIFT;
> -       pgmap = get_dev_pagemap(pfn, NULL);
> -       if (!pgmap)
> +       *pgmap = get_dev_pagemap(pfn, *pgmap);
> +       if (!*pgmap)
>                 return ERR_PTR(-EFAULT);
>         page = pfn_to_page(pfn);
>         get_page(page);
> -       put_dev_pagemap(pgmap);
>
>         return page;
>  }
> @@ -1000,11 +998,10 @@ static void touch_pud(struct vm_area_struct *vma, unsigned long addr,
>  }
>
>  struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
> -               pud_t *pud, int flags)
> +               pud_t *pud, int flags, struct dev_pagemap **pgmap)
>  {
>         unsigned long pfn = pud_pfn(*pud);
>         struct mm_struct *mm = vma->vm_mm;
> -       struct dev_pagemap *pgmap;
>         struct page *page;
>
>         assert_spin_locked(pud_lockptr(mm, pud));
> @@ -1028,12 +1025,11 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
>                 return ERR_PTR(-EEXIST);
>
>         pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
> -       pgmap = get_dev_pagemap(pfn, NULL);
> -       if (!pgmap)
> +       *pgmap = get_dev_pagemap(pfn, *pgmap);
> +       if (!*pgmap)
>                 return ERR_PTR(-EFAULT);
>         page = pfn_to_page(pfn);
>         get_page(page);
> -       put_dev_pagemap(pgmap);
>
>         return page;
>  }
> diff --git a/mm/nommu.c b/mm/nommu.c
> index e4aac33216ae..749276beb109 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1709,11 +1709,9 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>         return ret;
>  }
>
> -struct page *follow_page_mask(struct vm_area_struct *vma,
> -                             unsigned long address, unsigned int flags,
> -                             unsigned int *page_mask)
> +struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
> +                        unsigned int foll_flags)
>  {
> -       *page_mask = 0;
>         return NULL;
>  }
>
> --
> 2.14.4
>
