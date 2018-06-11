Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id J61aNsc9HlucSwAAmS7hNA
	; Mon, 11 Jun 2018 09:15:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CC020607A4; Mon, 11 Jun 2018 09:15:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B8BD9600D0;
	Mon, 11 Jun 2018 09:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8BD9600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932599AbeFKJPs convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 19 others);
        Mon, 11 Jun 2018 05:15:48 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:34104 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932277AbeFKJPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:15:47 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w5B9F1D7032523
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 11 Jun 2018 18:15:01 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w5B9F1X6013721;
        Mon, 11 Jun 2018 18:15:01 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w5B9DQtm002892;
        Mon, 11 Jun 2018 18:15:01 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-1102922; Mon, 11 Jun 2018 18:05:02 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0319.002; Mon,
 11 Jun 2018 18:05:01 +0900
From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To: Oscar Salvador <osalvador@techadventures.net>
CC: Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: Re: kernel panic in reading /proc/kpageflags when enabling
 RAM-simulated PMEM
Thread-Topic: kernel panic in reading /proc/kpageflags when enabling
 RAM-simulated PMEM
Thread-Index: AQHT/GeymmpDVR1XWE69lshFJtmzcqRQRpEAgABpKgCAAWucAIAALt0AgAANvoCAAAOvAIAABOqAgAFfi4CAAApwAIAAL2mAgAADywCABjkkAA==
Date: Mon, 11 Jun 2018 09:05:00 +0000
Message-ID: <20180611090500.GA20480@hori1.linux.bs1.fc.nec.co.jp>
References: <20180605073500.GA23766@hori1.linux.bs1.fc.nec.co.jp>
 <20180606051624.GA16021@hori1.linux.bs1.fc.nec.co.jp>
 <20180606080408.GA31794@techadventures.net>
 <20180606085319.GA32052@techadventures.net>
 <20180606090630.GA27065@hori1.linux.bs1.fc.nec.co.jp>
 <20180606092405.GA6562@hori1.linux.bs1.fc.nec.co.jp>
 <20180607062218.GB22554@hori1.linux.bs1.fc.nec.co.jp>
 <20180607065940.GA7334@techadventures.net>
 <20180607094921.GA8545@techadventures.net>
 <20180607100256.GA9129@hori1.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20180607100256.GA9129@hori1.linux.bs1.fc.nec.co.jp>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.81]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <0C1CA386112E9742BDC2E4797561174B@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 10:02:56AM +0000, Horiguchi Naoya(堀口 直也) wrote:
> On Thu, Jun 07, 2018 at 11:49:21AM +0200, Oscar Salvador wrote:
> > On Thu, Jun 07, 2018 at 08:59:40AM +0200, Oscar Salvador wrote:
> > > On Thu, Jun 07, 2018 at 06:22:19AM +0000, Naoya Horiguchi wrote:
> > > > On Wed, Jun 06, 2018 at 09:24:05AM +0000, Horiguchi Naoya(堀口 直也) wrote:
> > > > > On Wed, Jun 06, 2018 at 09:06:30AM +0000, Horiguchi Naoya(堀口 直也) wrote:
> > > > > > On Wed, Jun 06, 2018 at 10:53:19AM +0200, Oscar Salvador wrote:
> > > > > > > On Wed, Jun 06, 2018 at 10:04:08AM +0200, Oscar Salvador wrote:
> > > > > > > > On Wed, Jun 06, 2018 at 05:16:24AM +0000, Naoya Horiguchi wrote:
> > > > > > > > > On Tue, Jun 05, 2018 at 07:35:01AM +0000, Horiguchi Naoya(堀口 直也) wrote:
> > > > > > > > > > On Mon, Jun 04, 2018 at 06:18:36PM -0700, Matthew Wilcox wrote:
> > > > > > > > > > > On Tue, Jun 05, 2018 at 12:54:03AM +0000, Naoya Horiguchi wrote:
> > > > > > > > > > > > Reproduction precedure is like this:
> > > > > > > > > > > >  - enable RAM based PMEM (with a kernel boot parameter like memmap=1G!4G)
> > > > > > > > > > > >  - read /proc/kpageflags (or call tools/vm/page-types with no arguments)
> > > > > > > > > > > >  (- my kernel config is attached)
> > > > > > > > > > > >
> > > > > > > > > > > > I spent a few days on this, but didn't reach any solutions.
> > > > > > > > > > > > So let me report this with some details below ...
> > > > > > > > > > > >
> > > > > > > > > > > > In the critial page request, stable_page_flags() is called with an argument
> > > > > > > > > > > > page whose ->compound_head was somehow filled with '0xffffffffffffffff'.
> > > > > > > > > > > > And compound_head() returns (struct page *)(head - 1), which explains the
> > > > > > > > > > > > address 0xfffffffffffffffe in the above message.
> > > > > > > > > > >
> > > > > > > > > > > Hm.  compound_head shares with:
> > > > > > > > > > >
> > > > > > > > > > >                         struct list_head lru;
> > > > > > > > > > >                                 struct list_head slab_list;     /* uses lru */
> > > > > > > > > > >                                 struct {        /* Partial pages */
> > > > > > > > > > >                                         struct page *next;
> > > > > > > > > > >                         unsigned long _compound_pad_1;  /* compound_head */
> > > > > > > > > > >                         unsigned long _pt_pad_1;        /* compound_head */
> > > > > > > > > > >                         struct dev_pagemap *pgmap;
> > > > > > > > > > >                 struct rcu_head rcu_head;
> > > > > > > > > > >
> > > > > > > > > > > None of them should be -1.
> > > > > > > > > > >
> > > > > > > > > > > > It seems that this kernel panic happens when reading kpageflags of pfn range
> > > > > > > > > > > > [0xbffd7, 0xc0000), which coresponds to a 'reserved' range.
> > > > > > > > > > > >
> > > > > > > > > > > > [    0.000000] user-defined physical RAM map:
> > > > > > > > > > > > [    0.000000] user: [mem 0x0000000000000000-0x000000000009fbff] usable
> > > > > > > > > > > > [    0.000000] user: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> > > > > > > > > > > > [    0.000000] user: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> > > > > > > > > > > > [    0.000000] user: [mem 0x0000000000100000-0x00000000bffd6fff] usable
> > > > > > > > > > > > [    0.000000] user: [mem 0x00000000bffd7000-0x00000000bfffffff] reserved
> > > > > > > > > > > > [    0.000000] user: [mem 0x00000000feffc000-0x00000000feffffff] reserved
> > > > > > > > > > > > [    0.000000] user: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
> > > > > > > > > > > > [    0.000000] user: [mem 0x0000000100000000-0x000000013fffffff] persistent (type 12)
> > > > > > > > > > > >
> > > > > > > > > > > > So I guess 'memmap=' parameter might badly affect the memory initialization process.
> > > > > > > > > > > >
> > > > > > > > > > > > This problem doesn't reproduce on v4.17, so some pre-released patch introduces it.
> > > > > > > > > > > > I hope this info helps you find the solution/workaround.
> > > > > > > > > > >
> > > > > > > > > > > Can you try bisecting this?  It could be one of my patches to reorder struct
> > > > > > > > > > > page, or it could be one of Pavel's deferred page initialisation patches.
> > > > > > > > > > > Or something else ;-)
> > > > > > > > > >
> > > > > > > > > > Thank you for the comment. I'm trying bisecting now, let you know the result later.
> > > > > > > > > >
> > > > > > > > > > And I found that my statement "not reproduce on v4.17" was wrong (I used
> > > > > > > > > > different kvm guests, which made some different test condition and misguided me),
> > > > > > > > > > this seems an older (at least < 4.15) bug.
> > > > > > > > >
> > > > > > > > > (Cc: Pavel)
> > > > > > > > >
> > > > > > > > > Bisection showed that the following commit introduced this issue:
> > > > > > > > >
> > > > > > > > >   commit f7f99100d8d95dbcf09e0216a143211e79418b9f
> > > > > > > > >   Author: Pavel Tatashin <pasha.tatashin@oracle.com>
> > > > > > > > >   Date:   Wed Nov 15 17:36:44 2017 -0800
> > > > > > > > >
> > > > > > > > >       mm: stop zeroing memory during allocation in vmemmap
> > > > > > > > >
> > > > > > > > > This patch postpones struct page zeroing to later stage of memory initialization.
> > > > > > > > > My kernel config disabled CONFIG_DEFERRED_STRUCT_PAGE_INIT so two callsites of
> > > > > > > > > __init_single_page() were never reached. So in such case, struct pages populated
> > > > > > > > > by vmemmap_pte_populate() could be left uninitialized?
> > > > > > > > > And I'm not sure yet how this issue becomes visible with memmap= setting.
> > > > > > > >
> > > > > > > > I think that this becomes visible because memmap=x!y creates a persistent memory region:
> > > > > > > >
> > > > > > > > parse_memmap_one
> > > > > > > > {
> > > > > > > > 	...
> > > > > > > >         } else if (*p == '!') {
> > > > > > > >                 start_at = memparse(p+1, &p);
> > > > > > > >                 e820__range_add(start_at, mem_size, E820_TYPE_PRAM);
> > > > > > > > 	...
> > > > > > > > }
> > > > > > > >
> > > > > > > > and this region it is not added neither in memblock.memory nor in memblock.reserved.
> > > > > > > > Ranges in memblock.memory get zeroed in memmap_init_zone(), while memblock.reserved get zeroed
> > > > > > > > in free_low_memory_core_early():
> > > > > > > >
> > > > > > > > static unsigned long __init free_low_memory_core_early(void)
> > > > > > > > {
> > > > > > > > 	...
> > > > > > > > 	for_each_reserved_mem_region(i, &start, &end)
> > > > > > > > 		reserve_bootmem_region(start, end);
> > > > > > > > 	...
> > > > > > > > }
> > > > > > > >
> > > > > > > >
> > > > > > > > Maybe I am mistaken, but I think that persistent memory regions should be marked as reserved.
> > > > > > > > A comment in do_mark_busy() suggests this:
> > > > > > > >
> > > > > > > > static bool __init do_mark_busy(enum e820_type type, struct resource *res)
> > > > > > > > {
> > > > > > > >
> > > > > > > > 	...
> > > > > > > >         /*
> > > > > > > >          * Treat persistent memory like device memory, i.e. reserve it
> > > > > > > >          * for exclusive use of a driver
> > > > > > > >          */
> > > > > > > > 	...
> > > > > > > > }
> > > > > > > >
> > > > > > > >
> > > > > > > > I wonder if something like this could work and if so, if it is right (i haven't tested it yet):
> > > > > > > >
> > > > > > > > diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> > > > > > > > index 71c11ad5643e..3c9686ef74e5 100644
> > > > > > > > --- a/arch/x86/kernel/e820.c
> > > > > > > > +++ b/arch/x86/kernel/e820.c
> > > > > > > > @@ -1247,6 +1247,11 @@ void __init e820__memblock_setup(void)
> > > > > > > >                 if (end != (resource_size_t)end)
> > > > > > > >                         continue;
> > > > > > > >
> > > > > > > > +               if (entry->type == E820_TYPE_PRAM || entry->type == E820_TYPE_PMEM) {
> > > > > > > > +                       memblock_reserve(entry->addr, entry->size);
> > > > > > > > +                       continue;
> > > > > > > > +               }
> > > > > > > > +
> > > > > > > >                 if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
> > > > > > > >                         continue;
> > > > > > >
> > > > > > > It does not seem to work, so the reasoning might be incorrect.
> > > > > > 
> > > > > > Thank you for the comment.
> > > > > > 
> > > > > > One note is that the memory region with "broken struct page" is a typical
> > > > > > reserved region, not a pmem region. Strangely reading offset 0xbffd7 of
> > > > > > /proc/kpageflags is OK if pmem region does not exist, but NG if pmem region exists.
> > > > > > Reading the offset like 0x100000 (on pmem region) does not cause the crash,
> > > > > > so pmem region seems properly set up.
> > > > > > 
> > > > > > [    0.000000] user-defined physical RAM map:
> > > > > > [    0.000000] user: [mem 0x0000000000000000-0x000000000009fbff] usable
> > > > > > [    0.000000] user: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> > > > > > [    0.000000] user: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> > > > > > [    0.000000] user: [mem 0x0000000000100000-0x00000000bffd6fff] usable
> > > > > > [    0.000000] user: [mem 0x00000000bffd7000-0x00000000bfffffff] reserved   ===> "broken struct page" region
> > > > > > [    0.000000] user: [mem 0x00000000feffc000-0x00000000feffffff] reserved
> > > > > > [    0.000000] user: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
> > > > > > [    0.000000] user: [mem 0x0000000100000000-0x000000013fffffff] persistent (type 12) => pmem region
> > > > > > [    0.000000] user: [mem 0x0000000140000000-0x000000023fffffff] usable
> > > > > > 
> > > > > 
> > > > > I have another note:
> > > > > 
> > > > > > My kernel config disabled CONFIG_DEFERRED_STRUCT_PAGE_INIT so two callsites of
> > > > > > __init_single_page() were never reached. So in such case, struct pages populated
> > > > > > by vmemmap_pte_populate() could be left uninitialized?
> > > > > 
> > > > > I quickly checked whether enabling CONFIG_DEFERRED_STRUCT_PAGE_INIT affect
> > > > > the issue. And found that the kernel panic happens even with this config enabled.
> > > > > So I'm still confused...
> > > > 
> > > > Let me share some new facts:
> > > > 
> > > > I gave accidentally an inconvenient memmap layout like 'memmap=1G!4G' in
> > > > 2 NUMA node with 8 GB memory.
> > > > While I didn't intended this, but 4GB is the address starting some memory
> > > > block when no "memmap=" option is provided.
> > > > 
> > > >   (messages from free_area_init_nodes() for no "memmap=" case
> > > >   [    0.000000] Early memory node ranges
> > > >   [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> > > >   [    0.000000]   node   0: [mem 0x0000000000100000-0x00000000bffd6fff]
> > > >   [    0.000000]   node   0: [mem 0x0000000100000000-0x000000013fffffff] // <---
> > > >   [    0.000000]   node   1: [mem 0x0000000140000000-0x000000023fffffff]
> > > > 
> > > > When "memmap=1G!4G" is given, the range [0x0000000100000000-0x000000013fffffff]
> > > > disappears and kernel messages are like below:
> > > > 
> > > >   (messages from free_area_init_nodes() for "memmap=1G!4G" case
> > > >   [    0.000000] Early memory node ranges
> > > >   [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> > > >   [    0.000000]   node   0: [mem 0x0000000000100000-0x00000000bffd6fff]
> > > >   [    0.000000]   node   1: [mem 0x0000000140000000-0x000000023fffffff]
> > > > 
> > > > This makes kernel think that the end pfn of node 0 is 0 0xbffd7
> > > > instead of 0x140000, which affects the memory initialization process.
> > > > memmap_init_zone() calls __init_single_page() for each page within a zone,
> > > > so if zone->spanned_pages are underestimated, some pages are left uninitialized.
> > > > 
> > > > If I provide 'memmap=1G!7G', the kernel panic does not reproduce and
> > > > kernel messages are like below.
> > > >   
> > > >   (messages from free_area_init_nodes() for "memmap=1G!7G" case
> > > >   [    0.000000] Early memory node ranges
> > > >   [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> > > >   [    0.000000]   node   0: [mem 0x0000000000100000-0x00000000bffd6fff]
> > > >   [    0.000000]   node   0: [mem 0x0000000100000000-0x000000013fffffff]
> > > >   [    0.000000]   node   1: [mem 0x0000000140000000-0x00000001bfffffff]
> > > >   [    0.000000]   node   1: [mem 0x0000000200000000-0x000000023fffffff]
> > > > 
> > > > 
> > > > I think that in order to fix this, we need some conditions and/or prechecks
> > > > for memblock layout, does it make sense? Or any other better approaches?
> > 

> All this is handled in parse_memmap_one(), so I wonder if the right to do would be that in
> case we detect that an user-specified map falls in an usable map, we just back off and do not insert it.
> 
> Maybe a subroutine that checks for that kind of overlapping maps before calling e820__range_add()?
> 

This problem seems to happen when the end address of the user-defined memmap
is equal to the end address of NUMA node (0x140000000 or 5GB in this case.)
So that's the condition to be checked, I think.
However we don't initialize numa at parse_memmap_one(), so we need identify
right place to do this, so I'll do this next.

Thanks,
Naoya Horiguchi
