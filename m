Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061BAC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14EC20989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="bkbfhBFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfA2UFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:05:03 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37029 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfA2UFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:05:03 -0500
Received: by mail-ot1-f66.google.com with SMTP id s13so19045674otq.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 12:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yrWDUDhoyYGIFap6yXSC0PKoELQ511iVKxMkPwh5BQs=;
        b=bkbfhBFnweMgDSJIBVXJkp8NaQJKZ2j7s9SAip2zlBn9qIwrIzv9q+jmcCbYaDTNdj
         OF/ashyFT5RdHTousv84tq6TkEAwiJJaaF67/1UqF6R9DAhfm8sA9QUS+p2RImf3n873
         8EKm0PzBd0MPUYZ5v9EpPQ/NKqkW78ggwiTYj0phzsaWG7Fm+fdJe9g9dDFMsFMgjoQX
         mLVPucdf4WBI7tBgnePkE5tzFWksqBoyfaxBl4Sb9gM9JqXjmsEdoaPggC2wYQ21+tuT
         1wqVajtp5WQ/4QRPflJ/ykekjBjij8HfzLlNRFdILQQA0eFq1iux1Pux5WQictG9vyui
         joOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yrWDUDhoyYGIFap6yXSC0PKoELQ511iVKxMkPwh5BQs=;
        b=SBw/WZ1EyR/RZjLhJoqJEE+H1Lj/Zjz+F7GxK/r6Sjj58HfEMODKRCZQHGKOqDM8EX
         ubBUNKRXHJb6RnqwrvWN5VDqJ0MgYBKtXs10fGFqxYmxei4A1tjWQ49aZA7bGn6as3mS
         UZGAwSiC4lGLvRALFyBJaqrmnzfw/guq4G4hms7cgEY7bKkXXEqvmQOLlkM9g7OcLk4G
         ndrFegJvDqVqOJPI4C6pxdu4rwYwjSW7+/sValOkiyIZae9FJ2V5IFf9jHmGLgLUzQYi
         n1jpEK/gHXMUcTRKMnvGlYHdi8SO3MXHtsaOjNmEVU6QUhyezIeapqjMRhOfn24VGLWr
         lV9w==
X-Gm-Message-State: AJcUuke72EPXaCfrWicfkTLFqWHYC3M7M1UpxfTBG6HUMkpBpiZ0m3CE
        KJqmSMUOeDjpIJY/FoBORI8mCMYnU7nl7NuceumhDA==
X-Google-Smtp-Source: ALg8bN6Lo/HuIjb8whLk3ikPLOMecohVb2/LO+CsbKt0AskAyGaeacF1dESBod+UnOVnYRrk0yEA4Sv1SQGK4iNG6n8=
X-Received: by 2002:a9d:7dd5:: with SMTP id k21mr21206645otn.214.1548792302276;
 Tue, 29 Jan 2019 12:05:02 -0800 (PST)
MIME-Version: 1.0
References: <154690326478.676627.103843791978176914.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154690327057.676627.18166704439241470885.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190125142039.GN3560@dhcp22.suse.cz>
In-Reply-To: <20190125142039.GN3560@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Jan 2019 12:04:50 -0800
Message-ID: <CAPcyv4hB0YPcuvMZSjbDXkhnvHnt49jzi-NvNnE-8--aFiZKwA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] mm: Shuffle initial free memory to improve
 memory-side-cache utilization
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whoops, did not reply to all your feedback, see below:

On Fri, Jan 25, 2019 at 6:21 AM Michal Hocko <mhocko@kernel.org> wrote:
[..]
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index cc4a507d7ca4..8c37a023a790 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1272,6 +1272,10 @@ void sparse_init(void);
> >  #else
> >  #define sparse_init()        do {} while (0)
> >  #define sparse_index_init(_sec, _nid)  do {} while (0)
> > +static inline int pfn_present(unsigned long pfn)
> > +{
> > +     return 1;
> > +}
>
> Does this really make sense? Shouldn't this default to pfn_valid on
> !sparsemem?

Yes, I think it should be pfn_valid()

>
> [...]
> > +config SHUFFLE_PAGE_ALLOCATOR
> > +     bool "Page allocator randomization"
> > +     depends on ACPI_NUMA
> > +     default SLAB_FREELIST_RANDOM
> > +     help
> > +       Randomization of the page allocator improves the average
> > +       utilization of a direct-mapped memory-side-cache. See section
> > +       5.2.27 Heterogeneous Memory Attribute Table (HMAT) in the ACPI
> > +       6.2a specification for an example of how a platform advertises
> > +       the presence of a memory-side-cache. There are also incidental
> > +       security benefits as it reduces the predictability of page
> > +       allocations to compliment SLAB_FREELIST_RANDOM, but the
> > +       default granularity of shuffling on 4MB (MAX_ORDER) pages is
> > +       selected based on cache utilization benefits.
> > +
> > +       While the randomization improves cache utilization it may
> > +       negatively impact workloads on platforms without a cache. For
> > +       this reason, by default, the randomization is enabled only
> > +       after runtime detection of a direct-mapped memory-side-cache.
> > +       Otherwise, the randomization may be force enabled with the
> > +       'page_alloc.shuffle' kernel command line parameter.
> > +
> > +       Say Y if unsure.
>
> Do we really need to make this a choice? Are any of the tiny systems
> going to be NUMA? Why cannot we just make it depend on ACPI_NUMA?

Kees wants to use this on ARM and I removed the ACPI_NUMA dependency
in v8 (you happened to review v7).

Given the setting has performance impact I believe it should allow for
being hard disabled at compile time, but I'll update the default to:

    default SLAB_FREELIST_RANDOM && ACPI_NUMA

>
> > +config SHUFFLE_PAGE_ORDER
> > +     depends on SHUFFLE_PAGE_ALLOCATOR
> > +     int "Page allocator shuffle order"
> > +     range 0 10
> > +     default 10
> > +     help
> > +       Specify the granularity at which shuffling (randomization) is
> > +       performed. By default this is set to MAX_ORDER-1 to minimize
> > +       runtime impact of randomization and with the expectation that
> > +       SLAB_FREELIST_RANDOM mitigates heap attacks on smaller
> > +       object granularities.
> > +
>
> and no, do not make this configurable here as already mentioned.

Will remove.

> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 022d4cbb3618..3602f7a2eab4 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/poison.h>
> >  #include <linux/pfn.h>
> >  #include <linux/debugfs.h>
> > +#include <linux/shuffle.h>
> >  #include <linux/kmemleak.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/memblock.h>
> > @@ -1929,9 +1930,16 @@ static unsigned long __init free_low_memory_core_early(void)
> >        *  low ram will be on Node1
> >        */
> >       for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end,
> > -                             NULL)
> > +                             NULL) {
> > +             pg_data_t *pgdat;
> > +
> >               count += __free_memory_core(start, end);
> >
> > +             for_each_online_pgdat(pgdat)
> > +                     shuffle_free_memory(pgdat, PHYS_PFN(start),
> > +                                     PHYS_PFN(end));
> > +     }
> > +
> >       return count;
> >  }
> >
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index b9a667d36c55..7caffb9a91ab 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/highmem.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/ioport.h>
> > +#include <linux/shuffle.h>
> >  #include <linux/delay.h>
> >  #include <linux/migrate.h>
> >  #include <linux/page-isolation.h>
> > @@ -895,6 +896,8 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, int online_typ
> >       zone->zone_pgdat->node_present_pages += onlined_pages;
> >       pgdat_resize_unlock(zone->zone_pgdat, &flags);
> >
> > +     shuffle_zone(zone, pfn, zone_end_pfn(zone));
> > +
> >       if (onlined_pages) {
> >               node_states_set_node(nid, &arg);
> >               if (need_zonelists_rebuild)
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index cde5dac6229a..2adcd6da8a07 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -61,6 +61,7 @@
> >  #include <linux/sched/rt.h>
> >  #include <linux/sched/mm.h>
> >  #include <linux/page_owner.h>
> > +#include <linux/shuffle.h>
> >  #include <linux/kthread.h>
> >  #include <linux/memcontrol.h>
> >  #include <linux/ftrace.h>
> > @@ -1634,6 +1635,8 @@ static int __init deferred_init_memmap(void *data)
> >       }
> >       pgdat_resize_unlock(pgdat, &flags);
> >
> > +     shuffle_zone(zone, first_init_pfn, zone_end_pfn(zone));
> > +
> >       /* Sanity check that the next zone really is unpopulated */
> >       WARN_ON(++zid < MAX_NR_ZONES && populated_zone(++zone));
>
> I would prefer if would have less placess to place the shuffling. Why
> cannot we have a single place for the bootup and one for onlining part?
> page_alloc_init_late sounds like a good place for the later. You can
> miss some early allocations but are those of a big interest?

Ok, so you mean reduce the 3 callsites to 2. Replace the
free_low_memory_core_early() and deferred_init_memmap() sites with a
single shuffle call in page_alloc_init_late() after waiting for
deferred_init_memmap() work to complete? I don't see any red flags
with that, I'll give it a try.

> I haven't checked the actual shuffling algorithm, I will trust you on
> that part ;)

The algorithm has proved reliable. The breakage has only arisen from
missing locations that free large amounts of memory to the allocator
and failing to re-randomize within a whole zone, i.e. not just the
pages that were currently being hot-added.
