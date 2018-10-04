Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A5FC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058BD21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fyi2xbkk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058BD21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeJDStT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:49:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33773 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeJDStS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:49:18 -0400
Received: by mail-lf1-f65.google.com with SMTP id o21-v6so6572432lfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 04:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/EOMPojdt7D0kxsMUm7FhVb89p+uxp9dIUYdizGzPE=;
        b=Fyi2xbkkjmc+gbZBssMw+PYnXtm1klaFB76PQp4HhiCeWdygJRMcRS8Cz2mQ/7CMjE
         2GOUc6zIeqShEmtCz3wEA3dX1kcsJM5FtndSfia5iSzChbRfttvlU0YqKxf/tyPPL+Ir
         px0DMUErNU8mrk23Vnp0sEssImGA5C/T6/DBTMVXoQXabAVAHO5XqP4iLLoCr4RFYOh4
         iv/vbNNF7WqLA9OxYYRDAC2e2S0ZooTnBQI1ZcxWmlHRpnef15cnLKJyXMMFAvODTGzj
         6b2g5ZaWqEclqTD0Dpw2XtCUNkwcCSN4pnVD/F7J52wrnVVgOc6L/A8SF2rqPJfNJnzT
         nabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/EOMPojdt7D0kxsMUm7FhVb89p+uxp9dIUYdizGzPE=;
        b=T0nDOI1mh3Bv9ulpfkfOUk66d9yjM7AiV+FDTngzqYFxtdFoXmg3MitCav9l9F2vwg
         mFoQUBxej/iTNWc3nkQQtVvc8xIuAbBEgMksncthJTCFqQwj0ekEVTLSdSRyc9xUbE0o
         PfqzHcLeMH/ed10Gf1z/eBMlzdwDFLPfzT98eoWU5Zi19Rb/2NkR8pl1dQV2k3vfqyMi
         bX+a4JNiojLRw/UPtL7StfVmIaK8qCPHDGz9y8UAUMh2oe3saZdKhR/lbpEUA1Paj7fs
         fYUM1rgwMjxSCF0lds/hdYukwE+z6gy+bDLj6NofpW3x9bToXqyCxyZ7q9/MO3LF7GpR
         6lWg==
X-Gm-Message-State: ABuFfogDhivfoRafbhzSJMps4MlQRW4/Y8IrzsQReFZaJ8lAzdRJpv8q
        ID5qom3YHTfFg4qgWwowoAtGCL1YmzHEtmv5wpI=
X-Google-Smtp-Source: ACcGV63RHAGN2B53iCZ+zxqwMYzkOAE4GPUDkXIkf360i/hWmHoqOG0Qw5XqzO31NJ8B0A2qjFsg7GLYcN5QBA1z3Yk=
X-Received: by 2002:a19:124b:: with SMTP id h72-v6mr3743136lfi.72.1538654180420;
 Thu, 04 Oct 2018 04:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181003185854.GA1174@jordon-HP-15-Notebook-PC> <CANiq72nHXzOuH7kOgYL7OZ7D0fC3SSLYpC13Gk5ZMYPXfimqMA@mail.gmail.com>
In-Reply-To: <CANiq72nHXzOuH7kOgYL7OZ7D0fC3SSLYpC13Gk5ZMYPXfimqMA@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 4 Oct 2018 17:26:08 +0530
Message-ID: <CAFqt6zaUaGHkBORY+0sX8qWYcAd3F1Rpv+W9+GUD7ybBJ9odVQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Introduce new function vm_insert_kmem_page
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin@protonic.nl, stefanr@s5r6.in-berlin.de, hjc@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie,
        robin.murphy@arm.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kees Cook <keescook@chromium.org>, treding@nvidia.com,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>, aryabinin@virtuozzo.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>, tchibo@google.com,
        riel@redhat.com, Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>, ak@linux.intel.com,
        rppt@linux.vnet.ibm.com, linux@dominikbrodowski.net,
        Arnd Bergmann <arnd@arndb.de>, cpandya@codeaurora.org,
        hannes@cmpxchg.org, Joe Perches <joe@perches.com>,
        mcgrof@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 1:28 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Souptick,
>
> On Wed, Oct 3, 2018 at 8:55 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > vm_insert_kmem_page is similar to vm_insert_page and will
> > be used by drivers to map kernel (kmalloc/vmalloc/pages)
> > allocated memory to user vma.
> >
> > Going forward, the plan is to restrict future drivers not
> > to use vm_insert_page ( *it will generate new errno to
> > VM_FAULT_CODE mapping code for new drivers which were already
> > cleaned up for existing drivers*) in #PF (page fault handler)
> > context but to make use of vmf_insert_page which returns
> > VMF_FAULT_CODE and that is not possible until both vm_insert_page
> > and vmf_insert_page API exists.
> >
> > But there are some consumers of vm_insert_page which use it
> > outside #PF context. straight forward conversion of vm_insert_page
> > to vmf_insert_page won't work there as those function calls expects
> > errno not vm_fault_t in return.
> >
> > These are the approaches which could have been taken to handle
> > this scenario -
> >
> > *  Replace vm_insert_page with vmf_insert_page and then write few
> >    extra lines of code to convert VM_FAULT_CODE to errno which
> >    makes driver users more complex ( also the reverse mapping errno to
> >    VM_FAULT_CODE have been cleaned up as part of vm_fault_t migration ,
> >    not preferred to introduce anything similar again)
> >
> > *  Maintain both vm_insert_page and vmf_insert_page and use it in
> >    respective places. But it won't gurantee that vm_insert_page will
> >    never be used in #PF context.
> >
> > *  Introduce a similar API like vm_insert_page, convert all non #PF
> >    consumer to use it and finally remove vm_insert_page by converting
> >    it to vmf_insert_page.
> >
> > And the 3rd approach was taken by introducing vm_insert_kmem_page().
>
> This looks better than the previous one of adding non-trivial code to
> each driver, thank you!
>
> A couple of comments below.
>
> >
> > In short, vmf_insert_page will be used in page fault handlers
> > context and vm_insert_kmem_page will be used to map kernel
> > memory to user vma outside page fault handlers context.
> >
> > Few drivers are converted to use vm_insert_kmem_page(). This will
> > allow both to review the api and that it serves it purpose. other
> > consumers of vm_insert_page (*used in non #PF context*) will be
> > replaced by vm_insert_kmem_page, but in separate patches.
> >
>
> other -> Other
>
> Also, as far as I can see, there are only a few vm_insert_page users
> remaining. With the new function, they should be trivial to convert,
> no? Therefore, could we do them all in one go, possibly in a patch
> series?

yes, all the user can be converted in a patch series.

>
> Or, maybe, even better: wait until you remove the vm_* functions and
> simply reuse vm_insert_page for this -- that way you don't need a new
> name and you don't have to change any of the last users (I mean the
> drivers using it outside the page fault handlers).
>
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> > v2: Few non #PF consumers of vm_insert_page are converted
> >     to use vm_insert_kmem_page in patch v2.
> >
> >     Updated the change log.
> >
> >  arch/arm/mm/dma-mapping.c                   |  2 +-
> >  drivers/auxdisplay/cfag12864bfb.c           |  2 +-
> >  drivers/auxdisplay/ht16k33.c                |  2 +-
> >  drivers/firewire/core-iso.c                 |  2 +-
> >  drivers/gpu/drm/rockchip/rockchip_drm_gem.c |  2 +-
> >  include/linux/mm.h                          |  2 +
> >  kernel/kcov.c                               |  4 +-
> >  mm/memory.c                                 | 69 +++++++++++++++++++++++++++++
> >  mm/nommu.c                                  |  7 +++
> >  mm/vmalloc.c                                |  2 +-
> >  10 files changed, 86 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index 6656647..58d7971 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -1598,7 +1598,7 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
> >         pages += off;
> >
> >         do {
> > -               int ret = vm_insert_page(vma, uaddr, *pages++);
> > +               int ret = vm_insert_kmem_page(vma, uaddr, *pages++);
> >                 if (ret) {
> >                         pr_err("Remapping memory failed: %d\n", ret);
> >                         return ret;
> > diff --git a/drivers/auxdisplay/cfag12864bfb.c b/drivers/auxdisplay/cfag12864bfb.c
> > index 40c8a55..82fd627 100644
> > --- a/drivers/auxdisplay/cfag12864bfb.c
> > +++ b/drivers/auxdisplay/cfag12864bfb.c
> > @@ -52,7 +52,7 @@
> >
> >  static int cfag12864bfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
> >  {
> > -       return vm_insert_page(vma, vma->vm_start,
> > +       return vm_insert_kmem_page(vma, vma->vm_start,
> >                 virt_to_page(cfag12864b_buffer));
> >  }
> >
> > diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
> > index a43276c..64de30b 100644
> > --- a/drivers/auxdisplay/ht16k33.c
> > +++ b/drivers/auxdisplay/ht16k33.c
> > @@ -224,7 +224,7 @@ static int ht16k33_mmap(struct fb_info *info, struct vm_area_struct *vma)
> >  {
> >         struct ht16k33_priv *priv = info->par;
> >
> > -       return vm_insert_page(vma, vma->vm_start,
> > +       return vm_insert_kmem_page(vma, vma->vm_start,
> >                               virt_to_page(priv->fbdev.buffer));
> >  }
> >
> > diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
> > index 051327a..5f1548d 100644
> > --- a/drivers/firewire/core-iso.c
> > +++ b/drivers/firewire/core-iso.c
> > @@ -112,7 +112,7 @@ int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
> >
> >         uaddr = vma->vm_start;
> >         for (i = 0; i < buffer->page_count; i++) {
> > -               err = vm_insert_page(vma, uaddr, buffer->pages[i]);
> > +               err = vm_insert_kmem_page(vma, uaddr, buffer->pages[i]);
> >                 if (err)
> >                         return err;
> >
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> > index a8db758..57eb7af 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> > @@ -234,7 +234,7 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
> >                 return -ENXIO;
> >
> >         for (i = offset; i < end; i++) {
> > -               ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
> > +               ret = vm_insert_kmem_page(vma, uaddr, rk_obj->pages[i]);
> >                 if (ret)
> >                         return ret;
> >                 uaddr += PAGE_SIZE;
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index a61ebe8..5f42d35 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2477,6 +2477,8 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
> >  struct vm_area_struct *find_extend_vma(struct mm_struct *, unsigned long addr);
> >  int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
> >                         unsigned long pfn, unsigned long size, pgprot_t);
> > +int vm_insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
> > +                               struct page *page);
> >  int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
> >  int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
> >                         unsigned long pfn);
> > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > index 3ebd09e..2afaeb4 100644
> > --- a/kernel/kcov.c
> > +++ b/kernel/kcov.c
> > @@ -293,8 +293,8 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
> >                 spin_unlock(&kcov->lock);
> >                 for (off = 0; off < size; off += PAGE_SIZE) {
> >                         page = vmalloc_to_page(kcov->area + off);
> > -                       if (vm_insert_page(vma, vma->vm_start + off, page))
> > -                               WARN_ONCE(1, "vm_insert_page() failed");
> > +                       if (vm_insert_kmem_page(vma, vma->vm_start + off, page))
> > +                               WARN_ONCE(1, "vm_insert_kmem_page() failed");
> >                 }
> >                 return 0;
> >         }
> > diff --git a/mm/memory.c b/mm/memory.c
> > index c467102..b800c10 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1682,6 +1682,75 @@ pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
> >         return pte_alloc_map_lock(mm, pmd, addr, ptl);
> >  }
> >
> > +static int insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
> > +               struct page *page, pgprot_t prot)
> > +{
> > +       struct mm_struct *mm = vma->vm_mm;
> > +       int retval;
> > +       pte_t *pte;
> > +       spinlock_t *ptl;
> > +
> > +       retval = -EINVAL;
> > +       if (PageAnon(page))
> > +               goto out;
> > +       retval = -ENOMEM;
> > +       flush_dcache_page(page);
> > +       pte = get_locked_pte(mm, addr, &ptl);
> > +       if (!pte)
> > +               goto out;
> > +       retval = -EBUSY;
> > +       if (!pte_none(*pte))
> > +               goto out_unlock;
> > +
> > +       get_page(page);
> > +       inc_mm_counter_fast(mm, mm_counter_file(page));
> > +       page_add_file_rmap(page, false);
> > +       set_pte_at(mm, addr, pte, mk_pte(page, prot));
> > +
> > +       retval = 0;
> > +       pte_unmap_unlock(pte, ptl);
> > +       return retval;
> > +out_unlock:
> > +       pte_unmap_unlock(pte, ptl);
> > +out:
> > +       return retval;
> > +}
> > +
> > +/**
> > + * vm_insert_kmem_page - insert single page into user vma
> > + * @vma: user vma to map to
> > + * @addr: target user address of this page
> > + * @page: source kernel page
> > + *
> > + * This allows drivers to insert individual kernel memory into a user vma.
> > + * This API should be used outside page fault handlers context.
> > + *
> > + * Previously the same has been done with vm_insert_page by drivers. But
> > + * vm_insert_page will be converted to vmf_insert_page and will be used
> > + * in fault handlers context and return type of vmf_insert_page will be
> > + * vm_fault_t type.
>
> This is a "temporal" comment, i.e. it refers to things that are
> happening at the moment -- I would say that should be part of the
> commit message, not the code, since it will be obsolete soon. Also,
> consider that, in a way, vm_insert_page is actually being replaced by
> vmf_insert_page only in one of the use cases (the other being replaced
> by this). Maybe you could instead say something like:
>
>     In the past, vm_insert_page was used for this purpose. Do not use
> vmf_insert_page because...
>
> and leave the full explanation in the commit.

Sure , I will work on it.
>
> > + *
> > + * But there are places where drivers need to map kernel memory into user
> > + * vma outside fault handlers context. As vmf_insert_page will be restricted
> > + * to use within page fault handlers, vm_insert_kmem_page could be used
> > + * to map kernel memory to user vma outside fault handlers context.
> > + */
>
> Ditto.
>
> > +int vm_insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
> > +                       struct page *page)
> > +{
> > +       if (addr < vma->vm_start || addr >= vma->vm_end)
> > +               return -EFAULT;
> > +       if (!page_count(page))
> > +               return -EINVAL;
> > +       if (!(vma->vm_flags & VM_MIXEDMAP)) {
> > +               BUG_ON(down_read_trylock(&vma->vm_mm->mmap_sem));
> > +               BUG_ON(vma->vm_flags & VM_PFNMAP);
> > +               vma->vm_flags |= VM_MIXEDMAP;
> > +       }
> > +       return insert_kmem_page(vma, addr, page, vma->vm_page_prot);
> > +}
> > +EXPORT_SYMBOL(vm_insert_kmem_page);
> > +
> >  /*
> >   * This is the old fallback for page remapping.
> >   *
> > diff --git a/mm/nommu.c b/mm/nommu.c
> > index e4aac33..153b8c8 100644
> > --- a/mm/nommu.c
> > +++ b/mm/nommu.c
> > @@ -473,6 +473,13 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
> >  }
> >  EXPORT_SYMBOL(vm_insert_page);
> >
> > +int vm_insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
> > +                               struct page *page)
> > +{
> > +       return -EINVAL;
> > +}
> > +EXPORT_SYMBOL(vm_insert_kmem_page);
> > +
> >  /*
> >   *  sys_brk() for the most part doesn't need the global kernel
> >   *  lock, except when an application is doing something nasty
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index a728fc4..61d279f 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2251,7 +2251,7 @@ int remap_vmalloc_range_partial(struct vm_area_struct *vma, unsigned long uaddr,
> >                 struct page *page = vmalloc_to_page(kaddr);
> >                 int ret;
> >
> > -               ret = vm_insert_page(vma, uaddr, page);
> > +               ret = vm_insert_kmem_page(vma, uaddr, page);
> >                 if (ret)
> >                         return ret;
> >
> > --
> > 1.9.1
> >
>
> Cheers,
> Miguel
