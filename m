Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UzGILWXNGFt+fAAAmS7hNA
	; Thu, 07 Jun 2018 06:23:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 69D6D6089E; Thu,  7 Jun 2018 06:23:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6713E6063F;
	Thu,  7 Jun 2018 06:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6713E6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752873AbeFGGXx convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Thu, 7 Jun 2018 02:23:53 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:55119 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeFGGXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 02:23:52 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w576NCxn022279
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 15:23:12 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w576NCCQ011456;
        Thu, 7 Jun 2018 15:23:12 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id w576NCFc005398;
        Thu, 7 Jun 2018 15:23:12 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-1041300; Thu, 7 Jun 2018 15:22:20 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0319.002; Thu, 7
 Jun 2018 15:22:20 +0900
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
Thread-Index: AQHT/GeymmpDVR1XWE69lshFJtmzcqRQRpEAgABpKgCAAWucAIAALt0AgAANvoCAAAOvAIAABOqAgAFfi4A=
Date: Thu, 7 Jun 2018 06:22:19 +0000
Message-ID: <20180607062218.GB22554@hori1.linux.bs1.fc.nec.co.jp>
References: <20180605005402.GA22975@hori1.linux.bs1.fc.nec.co.jp>
 <20180605011836.GA32444@bombadil.infradead.org>
 <20180605073500.GA23766@hori1.linux.bs1.fc.nec.co.jp>
 <20180606051624.GA16021@hori1.linux.bs1.fc.nec.co.jp>
 <20180606080408.GA31794@techadventures.net>
 <20180606085319.GA32052@techadventures.net>
 <20180606090630.GA27065@hori1.linux.bs1.fc.nec.co.jp>
 <20180606092405.GA6562@hori1.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20180606092405.GA6562@hori1.linux.bs1.fc.nec.co.jp>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <C1A409AA411F0B4895AFE9A0F0B3DE87@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 09:24:05AM +0000, Horiguchi Naoya(堀口 直也) wrote:
> On Wed, Jun 06, 2018 at 09:06:30AM +0000, Horiguchi Naoya(堀口 直也) wrote:
> > On Wed, Jun 06, 2018 at 10:53:19AM +0200, Oscar Salvador wrote:
> > > On Wed, Jun 06, 2018 at 10:04:08AM +0200, Oscar Salvador wrote:
> > > > On Wed, Jun 06, 2018 at 05:16:24AM +0000, Naoya Horiguchi wrote:
> > > > > On Tue, Jun 05, 2018 at 07:35:01AM +0000, Horiguchi Naoya(堀口 直也) wrote:
> > > > > > On Mon, Jun 04, 2018 at 06:18:36PM -0700, Matthew Wilcox wrote:
> > > > > > > On Tue, Jun 05, 2018 at 12:54:03AM +0000, Naoya Horiguchi wrote:
> > > > > > > > Reproduction precedure is like this:
> > > > > > > >  - enable RAM based PMEM (with a kernel boot parameter like memmap=1G!4G)
> > > > > > > >  - read /proc/kpageflags (or call tools/vm/page-types with no arguments)
> > > > > > > >  (- my kernel config is attached)
> > > > > > > >
> > > > > > > > I spent a few days on this, but didn't reach any solutions.
> > > > > > > > So let me report this with some details below ...
> > > > > > > >
> > > > > > > > In the critial page request, stable_page_flags() is called with an argument
> > > > > > > > page whose ->compound_head was somehow filled with '0xffffffffffffffff'.
> > > > > > > > And compound_head() returns (struct page *)(head - 1), which explains the
> > > > > > > > address 0xfffffffffffffffe in the above message.
> > > > > > >
> > > > > > > Hm.  compound_head shares with:
> > > > > > >
> > > > > > >                         struct list_head lru;
> > > > > > >                                 struct list_head slab_list;     /* uses lru */
> > > > > > >                                 struct {        /* Partial pages */
> > > > > > >                                         struct page *next;
> > > > > > >                         unsigned long _compound_pad_1;  /* compound_head */
> > > > > > >                         unsigned long _pt_pad_1;        /* compound_head */
> > > > > > >                         struct dev_pagemap *pgmap;
> > > > > > >                 struct rcu_head rcu_head;
> > > > > > >
> > > > > > > None of them should be -1.
> > > > > > >
> > > > > > > > It seems that this kernel panic happens when reading kpageflags of pfn range
> > > > > > > > [0xbffd7, 0xc0000), which coresponds to a 'reserved' range.
> > > > > > > >
> > > > > > > > [    0.000000] user-defined physical RAM map:
> > > > > > > > [    0.000000] user: [mem 0x0000000000000000-0x000000000009fbff] usable
> > > > > > > > [    0.000000] user: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> > > > > > > > [    0.000000] user: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> > > > > > > > [    0.000000] user: [mem 0x0000000000100000-0x00000000bffd6fff] usable
> > > > > > > > [    0.000000] user: [mem 0x00000000bffd7000-0x00000000bfffffff] reserved
> > > > > > > > [    0.000000] user: [mem 0x00000000feffc000-0x00000000feffffff] reserved
> > > > > > > > [    0.000000] user: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
> > > > > > > > [    0.000000] user: [mem 0x0000000100000000-0x000000013fffffff] persistent (type 12)
> > > > > > > >
> > > > > > > > So I guess 'memmap=' parameter might badly affect the memory initialization process.
> > > > > > > >
> > > > > > > > This problem doesn't reproduce on v4.17, so some pre-released patch introduces it.
> > > > > > > > I hope this info helps you find the solution/workaround.
> > > > > > >
> > > > > > > Can you try bisecting this?  It could be one of my patches to reorder struct
> > > > > > > page, or it could be one of Pavel's deferred page initialisation patches.
> > > > > > > Or something else ;-)
> > > > > >
> > > > > > Thank you for the comment. I'm trying bisecting now, let you know the result later.
> > > > > >
> > > > > > And I found that my statement "not reproduce on v4.17" was wrong (I used
> > > > > > different kvm guests, which made some different test condition and misguided me),
> > > > > > this seems an older (at least < 4.15) bug.
> > > > >
> > > > > (Cc: Pavel)
> > > > >
> > > > > Bisection showed that the following commit introduced this issue:
> > > > >
> > > > >   commit f7f99100d8d95dbcf09e0216a143211e79418b9f
> > > > >   Author: Pavel Tatashin <pasha.tatashin@oracle.com>
> > > > >   Date:   Wed Nov 15 17:36:44 2017 -0800
> > > > >
> > > > >       mm: stop zeroing memory during allocation in vmemmap
> > > > >
> > > > > This patch postpones struct page zeroing to later stage of memory initialization.
> > > > > My kernel config disabled CONFIG_DEFERRED_STRUCT_PAGE_INIT so two callsites of
> > > > > __init_single_page() were never reached. So in such case, struct pages populated
> > > > > by vmemmap_pte_populate() could be left uninitialized?
> > > > > And I'm not sure yet how this issue becomes visible with memmap= setting.
> > > >
> > > > I think that this becomes visible because memmap=x!y creates a persistent memory region:
> > > >
> > > > parse_memmap_one
> > > > {
> > > > 	...
> > > >         } else if (*p == '!') {
> > > >                 start_at = memparse(p+1, &p);
> > > >                 e820__range_add(start_at, mem_size, E820_TYPE_PRAM);
> > > > 	...
> > > > }
> > > >
> > > > and this region it is not added neither in memblock.memory nor in memblock.reserved.
> > > > Ranges in memblock.memory get zeroed in memmap_init_zone(), while memblock.reserved get zeroed
> > > > in free_low_memory_core_early():
> > > >
> > > > static unsigned long __init free_low_memory_core_early(void)
> > > > {
> > > > 	...
> > > > 	for_each_reserved_mem_region(i, &start, &end)
> > > > 		reserve_bootmem_region(start, end);
> > > > 	...
> > > > }
> > > >
> > > >
> > > > Maybe I am mistaken, but I think that persistent memory regions should be marked as reserved.
> > > > A comment in do_mark_busy() suggests this:
> > > >
> > > > static bool __init do_mark_busy(enum e820_type type, struct resource *res)
> > > > {
> > > >
> > > > 	...
> > > >         /*
> > > >          * Treat persistent memory like device memory, i.e. reserve it
> > > >          * for exclusive use of a driver
> > > >          */
> > > > 	...
> > > > }
> > > >
> > > >
> > > > I wonder if something like this could work and if so, if it is right (i haven't tested it yet):
> > > >
> > > > diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> > > > index 71c11ad5643e..3c9686ef74e5 100644
> > > > --- a/arch/x86/kernel/e820.c
> > > > +++ b/arch/x86/kernel/e820.c
> > > > @@ -1247,6 +1247,11 @@ void __init e820__memblock_setup(void)
> > > >                 if (end != (resource_size_t)end)
> > > >                         continue;
> > > >
> > > > +               if (entry->type == E820_TYPE_PRAM || entry->type == E820_TYPE_PMEM) {
> > > > +                       memblock_reserve(entry->addr, entry->size);
> > > > +                       continue;
> > > > +               }
> > > > +
> > > >                 if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
> > > >                         continue;
> > >
> > > It does not seem to work, so the reasoning might be incorrect.
> > 
> > Thank you for the comment.
> > 
> > One note is that the memory region with "broken struct page" is a typical
> > reserved region, not a pmem region. Strangely reading offset 0xbffd7 of
> > /proc/kpageflags is OK if pmem region does not exist, but NG if pmem region exists.
> > Reading the offset like 0x100000 (on pmem region) does not cause the crash,
> > so pmem region seems properly set up.
> > 
> > [    0.000000] user-defined physical RAM map:
> > [    0.000000] user: [mem 0x0000000000000000-0x000000000009fbff] usable
> > [    0.000000] user: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> > [    0.000000] user: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> > [    0.000000] user: [mem 0x0000000000100000-0x00000000bffd6fff] usable
> > [    0.000000] user: [mem 0x00000000bffd7000-0x00000000bfffffff] reserved   ===> "broken struct page" region
> > [    0.000000] user: [mem 0x00000000feffc000-0x00000000feffffff] reserved
> > [    0.000000] user: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
> > [    0.000000] user: [mem 0x0000000100000000-0x000000013fffffff] persistent (type 12) => pmem region
> > [    0.000000] user: [mem 0x0000000140000000-0x000000023fffffff] usable
> > 
> 
> I have another note:
> 
> > My kernel config disabled CONFIG_DEFERRED_STRUCT_PAGE_INIT so two callsites of
> > __init_single_page() were never reached. So in such case, struct pages populated
> > by vmemmap_pte_populate() could be left uninitialized?
> 
> I quickly checked whether enabling CONFIG_DEFERRED_STRUCT_PAGE_INIT affect
> the issue. And found that the kernel panic happens even with this config enabled.
> So I'm still confused...

Let me share some new facts:

I gave accidentally an inconvenient memmap layout like 'memmap=1G!4G' in
2 NUMA node with 8 GB memory.
While I didn't intended this, but 4GB is the address starting some memory
block when no "memmap=" option is provided.

  (messages from free_area_init_nodes() for no "memmap=" case
  [    0.000000] Early memory node ranges
  [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
  [    0.000000]   node   0: [mem 0x0000000000100000-0x00000000bffd6fff]
  [    0.000000]   node   0: [mem 0x0000000100000000-0x000000013fffffff] // <---
  [    0.000000]   node   1: [mem 0x0000000140000000-0x000000023fffffff]

When "memmap=1G!4G" is given, the range [0x0000000100000000-0x000000013fffffff]
disappears and kernel messages are like below:

  (messages from free_area_init_nodes() for "memmap=1G!4G" case
  [    0.000000] Early memory node ranges
  [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
  [    0.000000]   node   0: [mem 0x0000000000100000-0x00000000bffd6fff]
  [    0.000000]   node   1: [mem 0x0000000140000000-0x000000023fffffff]

This makes kernel think that the end pfn of node 0 is 0 0xbffd7
instead of 0x140000, which affects the memory initialization process.
memmap_init_zone() calls __init_single_page() for each page within a zone,
so if zone->spanned_pages are underestimated, some pages are left uninitialized.

If I provide 'memmap=1G!7G', the kernel panic does not reproduce and
kernel messages are like below.
  
  (messages from free_area_init_nodes() for "memmap=1G!7G" case
  [    0.000000] Early memory node ranges
  [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
  [    0.000000]   node   0: [mem 0x0000000000100000-0x00000000bffd6fff]
  [    0.000000]   node   0: [mem 0x0000000100000000-0x000000013fffffff]
  [    0.000000]   node   1: [mem 0x0000000140000000-0x00000001bfffffff]
  [    0.000000]   node   1: [mem 0x0000000200000000-0x000000023fffffff]


I think that in order to fix this, we need some conditions and/or prechecks
for memblock layout, does it make sense? Or any other better approaches?

Thanks,
Naoya Horiguchi
