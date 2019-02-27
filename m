Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8A7C00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CE020842
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlLu87Ry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfB0JXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:23:36 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38422 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfB0JXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:23:36 -0500
Received: by mail-io1-f68.google.com with SMTP id p18so12962611ioh.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 01:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dW6Mj78k5lfxyLYouyYEolh46R3CFwn8bxmylMHyMBM=;
        b=RlLu87RyQoZKp+0bE1s9u/Wsdwtf+i3yTfw3ywA0dFsFS9z0B44omlLTXiUYVweaiC
         vrkk3qCtg6ZjGQGKAXr1fPkRbm1rEBMQFGlagOUO9SlYcUtjIEHZVXWdaLApdnTgCaT2
         FjhsDPxhFwMQKZuO2jd1hcoJnajWa1wxoea6ixBaWDgQCiICHr19HFRakxWt+Qet/THD
         PL3ie08nRrSLaoN5MUP8FGN7/liXfy/vJfE1ny+N17I8XwjaSkNy8qez4aNUBOkyfwAE
         ODp03JkobhSVx2WvjxNpOgtFodL0fYeTWgzc+bNlWkxyu3bBE7/Gc0F0Mp8vL6kOV1w3
         tHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dW6Mj78k5lfxyLYouyYEolh46R3CFwn8bxmylMHyMBM=;
        b=K+Y/pLJlpbqCBjRfsNxTZtdVqZpTW7Z7XmXULgLOySBAE97S5IteVpG57lNWd02suE
         jv7j9gwES5HIR2a7IxkzVGFHD51Ry0NAITjZVviv4EDyOjL6e+OicpQ4Mo5O9rthcw7y
         8zuCtfi/ekTJuTyx7AFnPGzBx7je6qTsdqo/mHWtXc0pYuzCrFAabOrYZIeyKXo+NUtd
         koP5JCAz1ZIaLz+kMTyqFQEFtzD0s2YnJ+b2yzWJx87JYGUKcIn4gxwpYmUF058eLpmm
         kL8mRabn69wyFheUD1S74NBhbzPz4ykOQwHagVjpxhaNqZZ7FlTKLn7VU5kjuTdXGYYv
         YzbA==
X-Gm-Message-State: APjAAAVk04HcefJFpZOAH98oF4dTHoj/CZS0zfWbwwmcVssHauxuz7q9
        8UFcs21Ao7HR7hMjunVScpzVMGnGGOTZs4GqDw==
X-Google-Smtp-Source: APXvYqzSotMZBYN/MnDIAOlgwGImpNvHIMLB0beTcasvl7zEabtMQ13XUezaN4DkReQZsLPlJeV5za6TlqmCXYbc0dY=
X-Received: by 2002:a6b:abc2:: with SMTP id u185mr1468827ioe.145.1551259414856;
 Wed, 27 Feb 2019 01:23:34 -0800 (PST)
MIME-Version: 1.0
References: <1551011649-30103-1-git-send-email-kernelfans@gmail.com>
 <1551011649-30103-3-git-send-email-kernelfans@gmail.com> <20190226115844.GG11981@rapoport-lnx>
In-Reply-To: <20190226115844.GG11981@rapoport-lnx>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 27 Feb 2019 17:23:23 +0800
Message-ID: <CAFgQCTuvho76nr4jAFe9VQ4MDuy2oZx4nNqHwtHe-Z9So7y43A@mail.gmail.com>
Subject: Re: [PATCH 2/6] mm/memblock: make full utilization of numa info
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     x86@kernel.org, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Vacek <neelx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 7:58 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Sun, Feb 24, 2019 at 08:34:05PM +0800, Pingfan Liu wrote:
> > There are numa machines with memory-less node. When allocating memory for
> > the memory-less node, memblock allocator falls back to 'Node 0' without fully
> > utilizing the nearest node. This hurts the performance, especially for per
> > cpu section. Suppressing this defect by building the full node fall back
> > info for memblock allocator, like what we have done for page allocator.
>
> Is it really necessary to build full node fallback info for memblock and
> then rebuild it again for the page allocator?
>
Do you mean building the full node fallback info once, and share it by
both memblock and page allocator? If it is, then node online/offline
is the corner case to block this design.

> I think it should be possible to split parts of build_all_zonelists_init()
> that do not touch per-cpu areas into a separate function and call that
> function after topology detection. Then it would be possible to use
> local_memory_node() when calling memblock.
>
Yes, this is one way but may be with higher pay of changing the code.
I will try it.
Thank your for your suggestion.

Best regards,
Pingfan
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > CC: Thomas Gleixner <tglx@linutronix.de>
> > CC: Ingo Molnar <mingo@redhat.com>
> > CC: Borislav Petkov <bp@alien8.de>
> > CC: "H. Peter Anvin" <hpa@zytor.com>
> > CC: Dave Hansen <dave.hansen@linux.intel.com>
> > CC: Vlastimil Babka <vbabka@suse.cz>
> > CC: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > CC: Andrew Morton <akpm@linux-foundation.org>
> > CC: Mel Gorman <mgorman@suse.de>
> > CC: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > CC: Andy Lutomirski <luto@kernel.org>
> > CC: Andi Kleen <ak@linux.intel.com>
> > CC: Petr Tesarik <ptesarik@suse.cz>
> > CC: Michal Hocko <mhocko@suse.com>
> > CC: Stephen Rothwell <sfr@canb.auug.org.au>
> > CC: Jonathan Corbet <corbet@lwn.net>
> > CC: Nicholas Piggin <npiggin@gmail.com>
> > CC: Daniel Vacek <neelx@redhat.com>
> > CC: linux-kernel@vger.kernel.org
> > ---
> >  include/linux/memblock.h |  3 +++
> >  mm/memblock.c            | 68 ++++++++++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 66 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > index 64c41cf..ee999c5 100644
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -342,6 +342,9 @@ void *memblock_alloc_try_nid_nopanic(phys_addr_t size, phys_addr_t align,
> >  void *memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align,
> >                            phys_addr_t min_addr, phys_addr_t max_addr,
> >                            int nid);
> > +extern int build_node_order(int *node_oder_array, int sz,
> > +     int local_node, nodemask_t *used_mask);
> > +void memblock_build_node_order(void);
> >
> >  static inline void * __init memblock_alloc(phys_addr_t size,  phys_addr_t align)
> >  {
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 022d4cb..cf78850 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -1338,6 +1338,47 @@ phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t ali
> >       return memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ACCESSIBLE);
> >  }
> >
> > +static int **node_fallback __initdata;
> > +
> > +/*
> > + * build_node_order() relies on cpumask_of_node(), hence arch should set up
> > + * cpumask before calling this func.
> > + */
> > +void __init memblock_build_node_order(void)
> > +{
> > +     int nid, i;
> > +     nodemask_t used_mask;
> > +
> > +     node_fallback = memblock_alloc(MAX_NUMNODES * sizeof(int *),
> > +             sizeof(int *));
> > +     for_each_online_node(nid) {
> > +             node_fallback[nid] = memblock_alloc(
> > +                     num_online_nodes() * sizeof(int), sizeof(int));
> > +             for (i = 0; i < num_online_nodes(); i++)
> > +                     node_fallback[nid][i] = NUMA_NO_NODE;
> > +     }
> > +
> > +     for_each_online_node(nid) {
> > +             nodes_clear(used_mask);
> > +             node_set(nid, used_mask);
> > +             build_node_order(node_fallback[nid], num_online_nodes(),
> > +                     nid, &used_mask);
> > +     }
> > +}
> > +
> > +static void __init memblock_free_node_order(void)
> > +{
> > +     int nid;
> > +
> > +     if (!node_fallback)
> > +             return;
> > +     for_each_online_node(nid)
> > +             memblock_free(__pa(node_fallback[nid]),
> > +                     num_online_nodes() * sizeof(int));
> > +     memblock_free(__pa(node_fallback), MAX_NUMNODES * sizeof(int *));
> > +     node_fallback = NULL;
> > +}
> > +
> >  /**
> >   * memblock_alloc_internal - allocate boot memory block
> >   * @size: size of memory block to be allocated in bytes
> > @@ -1370,6 +1411,7 @@ static void * __init memblock_alloc_internal(
> >  {
> >       phys_addr_t alloc;
> >       void *ptr;
> > +     int node;
> >       enum memblock_flags flags = choose_memblock_flags();
> >
> >       if (WARN_ONCE(nid == MAX_NUMNODES, "Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead\n"))
> > @@ -1397,11 +1439,26 @@ static void * __init memblock_alloc_internal(
> >               goto done;
> >
> >       if (nid != NUMA_NO_NODE) {
> > -             alloc = memblock_find_in_range_node(size, align, min_addr,
> > -                                                 max_addr, NUMA_NO_NODE,
> > -                                                 flags);
> > -             if (alloc && !memblock_reserve(alloc, size))
> > -                     goto done;
> > +             if (!node_fallback) {
> > +                     alloc = memblock_find_in_range_node(size, align,
> > +                                     min_addr, max_addr,
> > +                                     NUMA_NO_NODE, flags);
> > +                     if (alloc && !memblock_reserve(alloc, size))
> > +                             goto done;
> > +             } else {
> > +                     int i;
> > +                     for (i = 0; i < num_online_nodes(); i++) {
> > +                             node = node_fallback[nid][i];
> > +                             /* fallback list has all memory nodes */
> > +                             if (node == NUMA_NO_NODE)
> > +                                     break;
> > +                             alloc = memblock_find_in_range_node(size,
> > +                                             align, min_addr, max_addr,
> > +                                             node, flags);
> > +                             if (alloc && !memblock_reserve(alloc, size))
> > +                                     goto done;
> > +                     }
> > +             }
> >       }
> >
> >       if (min_addr) {
> > @@ -1969,6 +2026,7 @@ unsigned long __init memblock_free_all(void)
> >
> >       reset_all_zones_managed_pages();
> >
> > +     memblock_free_node_order();
> >       pages = free_low_memory_core_early();
> >       totalram_pages_add(pages);
> >
> > --
> > 2.7.4
> >
>
> --
> Sincerely yours,
> Mike.
>
