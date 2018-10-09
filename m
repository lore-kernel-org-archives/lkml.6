Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405B8ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD54920835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="yPdGk3/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD54920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeJJBW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:22:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42715 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJJBW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 21:22:59 -0400
Received: by mail-ot1-f67.google.com with SMTP id c23so817758otl.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 11:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=WxIzyjr3Bhwb6q62RGURxDq9OzggK6f/FuEBWimmRyE=;
        b=yPdGk3/TfrYQQKYJ8ikn9t86lUXMlLdnVrVv08UkEZnmXmEuB7uQ3aLREdJ8TmzsiZ
         mcPtqrh0BdWfSSZHyYBA0Qrh01sWev7yrxmFnuXZCi1dxA2HIkmvVmf0NbvaOTyg1s76
         KcnJ+ubh9vX7Sx5+ME6mlGNhPTDvCQOdQOG35MYRQLejK5bz66HNf4U0SQ3f+fxTh8yg
         A2yJXvmF+x1b7EinAHFSuHWnvITwkBZtgRvon51uiYhBiQsOkQQvidkjCK46CEMGYp3l
         Ij5AHLCQ/C/DlJJ6ht1cT3ByCUz/ikb58LdKvsf1Op+vvAnDh5T1oUI1OR/EuT2cUYVg
         rEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=WxIzyjr3Bhwb6q62RGURxDq9OzggK6f/FuEBWimmRyE=;
        b=czkaIu2UtDJKlGk8H1ZAqjkGfnHDd3xeoil9jAkjVXnkdQXIKjxQ1Gc02zUr2y/2dX
         EMGXjVk8elv8H9jq2rKQLdPocnG3p4ACxIOomo9oyQqwMNXo6+8mhmmDdLCxItkANcw6
         IoMmtL74g29S1xrmY/xrDITofnC9j9pAxd66RnmhsGulBQIBCDYA/bmAGIN2YDbvSfd4
         2V4/kSSmrinz1IigixLJ3pUdfEWznlEI3cVf2UnJ07OjwyCREZkns7V97raPU3H63nRT
         7nki0fgEawa8yszaChH9D/ndZn+KxWvTc7crc7P/fUeb9+n0fsSuXwC2kU0F6nOAAVAy
         bfuA==
X-Gm-Message-State: ABuFfojYflIZhvMPcTrpyUV0E2H8GnS/0N+Ss8+R3FF8pM7QxQ6ilusB
        S54sTXzUQG2+B7FRTahH1vzi+dOxc84HnnRLr77A5w==
X-Google-Smtp-Source: ACcGV61Ki2Yk3dTYmrNK06eJxZDSFKNKVdA+qmauzy1gdfthMzclPx259EdatR2cl2a0pBrc2N2iav9Z74TBIM28RLQ=
X-Received: by 2002:a9d:2372:: with SMTP id k47mr16495501otd.98.1539108288125;
 Tue, 09 Oct 2018 11:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925202053.3576.66039.stgit@localhost.localdomain> <20181009170051.GA40606@tiger-server>
In-Reply-To: <20181009170051.GA40606@tiger-server>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 9 Oct 2018 11:04:36 -0700
Message-ID: <CAPcyv4g99_rJJSn0kWv5YO0Mzj90q1LH1wC3XrjCh1=x6mo7BQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
To:     alexander.h.duyck@linux.intel.com, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        rppt@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 3:21 AM Yi Zhang <yi.z.zhang@linux.intel.com> wrote:
>
> On 2018-09-25 at 13:21:24 -0700, Alexander Duyck wrote:
> > The ZONE_DEVICE pages were being initialized in two locations. One was with
> > the memory_hotplug lock held and another was outside of that lock. The
> > problem with this is that it was nearly doubling the memory initialization
> > time. Instead of doing this twice, once while holding a global lock and
> > once without, I am opting to defer the initialization to the one outside of
> > the lock. This allows us to avoid serializing the overhead for memory init
> > and we can instead focus on per-node init times.
> >
> > One issue I encountered is that devm_memremap_pages and
> > hmm_devmmem_pages_create were initializing only the pgmap field the same
> > way. One wasn't initializing hmm_data, and the other was initializing it to
> > a poison value. Since this is something that is exposed to the driver in
> > the case of hmm I am opting for a third option and just initializing
> > hmm_data to 0 since this is going to be exposed to unknown third party
> > drivers.
> >
> > Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >
> > v4: Moved moved memmap_init_zone_device to below memmmap_init_zone to avoid
> >     merge conflicts with other changes in the kernel.
> > v5: No change
> >
> >  include/linux/mm.h |    2 +
> >  kernel/memremap.c  |   24 +++++---------
> >  mm/hmm.c           |   12 ++++---
> >  mm/page_alloc.c    |   92 ++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  4 files changed, 107 insertions(+), 23 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 06d7d7576f8d..7312fb78ef31 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -848,6 +848,8 @@ static inline bool is_zone_device_page(const struct page *page)
> >  {
> >       return page_zonenum(page) == ZONE_DEVICE;
> >  }
> > +extern void memmap_init_zone_device(struct zone *, unsigned long,
> > +                                 unsigned long, struct dev_pagemap *);
> >  #else
> >  static inline bool is_zone_device_page(const struct page *page)
> >  {
> > diff --git a/kernel/memremap.c b/kernel/memremap.c
> > index 5b8600d39931..d0c32e473f82 100644
> > --- a/kernel/memremap.c
> > +++ b/kernel/memremap.c
> > @@ -175,10 +175,10 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
> >       struct vmem_altmap *altmap = pgmap->altmap_valid ?
> >                       &pgmap->altmap : NULL;
> >       struct resource *res = &pgmap->res;
> > -     unsigned long pfn, pgoff, order;
> > +     struct dev_pagemap *conflict_pgmap;
> >       pgprot_t pgprot = PAGE_KERNEL;
> > +     unsigned long pgoff, order;
> >       int error, nid, is_ram;
> > -     struct dev_pagemap *conflict_pgmap;
> >
> >       align_start = res->start & ~(SECTION_SIZE - 1);
> >       align_size = ALIGN(res->start + resource_size(res), SECTION_SIZE)
> > @@ -256,19 +256,13 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
> >       if (error)
> >               goto err_add_memory;
> >
> > -     for_each_device_pfn(pfn, pgmap) {
> > -             struct page *page = pfn_to_page(pfn);
> > -
> > -             /*
> > -              * ZONE_DEVICE pages union ->lru with a ->pgmap back
> > -              * pointer.  It is a bug if a ZONE_DEVICE page is ever
> > -              * freed or placed on a driver-private list.  Seed the
> > -              * storage with LIST_POISON* values.
> > -              */
> > -             list_del(&page->lru);
> > -             page->pgmap = pgmap;
> > -             percpu_ref_get(pgmap->ref);
> > -     }
> > +     /*
> > +      * Initialization of the pages has been deferred until now in order
> > +      * to allow us to do the work while not holding the hotplug lock.
> > +      */
> > +     memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
> > +                             align_start >> PAGE_SHIFT,
> > +                             align_size >> PAGE_SHIFT, pgmap);
> >
> >       devm_add_action(dev, devm_memremap_pages_release, pgmap);
> >
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index c968e49f7a0c..774d684fa2b4 100644
> > --- a/mm/hmm.c
> > +++ b/mm/hmm.c
> > @@ -1024,7 +1024,6 @@ static int hmm_devmem_pages_create(struct hmm_devmem *devmem)
> >       resource_size_t key, align_start, align_size, align_end;
> >       struct device *device = devmem->device;
> >       int ret, nid, is_ram;
> > -     unsigned long pfn;
> >
> >       align_start = devmem->resource->start & ~(PA_SECTION_SIZE - 1);
> >       align_size = ALIGN(devmem->resource->start +
> > @@ -1109,11 +1108,14 @@ static int hmm_devmem_pages_create(struct hmm_devmem *devmem)
> >                               align_size >> PAGE_SHIFT, NULL);
> >       mem_hotplug_done();
> >
> > -     for (pfn = devmem->pfn_first; pfn < devmem->pfn_last; pfn++) {
> > -             struct page *page = pfn_to_page(pfn);
> > +     /*
> > +      * Initialization of the pages has been deferred until now in order
> > +      * to allow us to do the work while not holding the hotplug lock.
> > +      */
> > +     memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
> > +                             align_start >> PAGE_SHIFT,
> > +                             align_size >> PAGE_SHIFT, &devmem->pagemap);
> >
> > -             page->pgmap = &devmem->pagemap;
> > -     }
> >       return 0;
> >
> >  error_add_memory:
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 926ad3083b28..7ec0997ded39 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5489,12 +5489,23 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> >       if (highest_memmap_pfn < end_pfn - 1)
> >               highest_memmap_pfn = end_pfn - 1;
> >
> > +#ifdef CONFIG_ZONE_DEVICE
> >       /*
> >        * Honor reservation requested by the driver for this ZONE_DEVICE
> > -      * memory
> > +      * memory. We limit the total number of pages to initialize to just
> > +      * those that might contain the memory mapping. We will defer the
> > +      * ZONE_DEVICE page initialization until after we have released
> > +      * the hotplug lock.
> >        */
> > -     if (altmap && start_pfn == altmap->base_pfn)
> > -             start_pfn += altmap->reserve;
> > +     if (zone == ZONE_DEVICE) {
> > +             if (!altmap)
> > +                     return;
> > +
> > +             if (start_pfn == altmap->base_pfn)
> > +                     start_pfn += altmap->reserve;
> > +             end_pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
> > +     }
> > +#endif
> >
> >       for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> >               /*
> > @@ -5538,6 +5549,81 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> >       }
> >  }
> >
> > +#ifdef CONFIG_ZONE_DEVICE
> > +void __ref memmap_init_zone_device(struct zone *zone,
> > +                                unsigned long start_pfn,
> > +                                unsigned long size,
> > +                                struct dev_pagemap *pgmap)
> > +{
> > +     unsigned long pfn, end_pfn = start_pfn + size;
> > +     struct pglist_data *pgdat = zone->zone_pgdat;
> > +     unsigned long zone_idx = zone_idx(zone);
> > +     unsigned long start = jiffies;
> > +     int nid = pgdat->node_id;
> > +
> > +     if (WARN_ON_ONCE(!pgmap || !is_dev_zone(zone)))
> > +             return;
> > +
> > +     /*
> > +      * The call to memmap_init_zone should have already taken care
> > +      * of the pages reserved for the memmap, so we can just jump to
> > +      * the end of that region and start processing the device pages.
> > +      */
> > +     if (pgmap->altmap_valid) {
> > +             struct vmem_altmap *altmap = &pgmap->altmap;
> > +
> > +             start_pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
> > +             size = end_pfn - start_pfn;
> > +     }
> > +
> > +     for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> > +             struct page *page = pfn_to_page(pfn);
> > +
> > +             __init_single_page(page, pfn, zone_idx, nid);
> > +
> > +             /*
> > +              * Mark page reserved as it will need to wait for onlining
> > +              * phase for it to be fully associated with a zone.
> > +              *
> > +              * We can use the non-atomic __set_bit operation for setting
> > +              * the flag as we are still initializing the pages.
> > +              */
> > +             __SetPageReserved(page);
>
> So we need to hold the page reserved flag while memory onlining.
> But after onlined, Do we neeed to clear the reserved flag in the DEV/FS
> DAX memory type?
> @Dan, What will going on with this?
>

That comment is incorrect, device-pages are never onlined. So I think
we can just skip that call to __SetPageReserved() unless the memory
range is MEMORY_DEVICE_{PRIVATE,PUBLIC}.
