Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C2DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1654A222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4mkl4eB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388675AbfBMLzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:55:41 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35344 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfBMLzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:55:41 -0500
Received: by mail-lf1-f67.google.com with SMTP id v7so1576276lfd.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 03:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SACQ5M4HotXM/MYLGDRFVKPHZJfogzeYcVZ+MN/XhU8=;
        b=f4mkl4eBBsyow13NsoWcy6TCJgJY3qmCYJ5OXfuE1gLUpq1a2dUlEBASHKokOdWVKk
         gezG7rROm1xc9bXetKR/SBOCewP4OG2gO8zgmTjvkcXykqIYUW2Xorftbhdz8RL6ombp
         rvy7lP0QVctGb3APbiXrl+LrqL2urnMBnbGEt+/C7BEw5mQ3fCjK59AxeX2316hADnYG
         5jI+wJUTwSeGNU6v9zCpoZTlnm6QGptLldPOdEeK2BXNLhmd9CpxNdRKxXhbAfSb702D
         x4XpUiv5Rgjtl+a8w5+I9Edkm8Xi6mYL95iJkLUKmlL2/2+dv46y1P0VHqgWg8PKJ1Co
         HKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SACQ5M4HotXM/MYLGDRFVKPHZJfogzeYcVZ+MN/XhU8=;
        b=I2VfWh9OHWc2cytFwGQt0l8/jWxqEXvGUfvYSixCNGW3pdwOg5dNH6sE7etdNtmYiI
         kctPYrhxo+SvQygGWvI78sDRUpt/ashriAclzvze9+PBdwRmvMN9y3FyLE5iUBtP0BVH
         +WC9mSii+v7hVYesd3f8C+Ei2fq4JLIkocxVPL2jqqA27cNv524UbWy7+rS6iG6XKcsx
         4nhPfBs2yp2VwYeZCP+MCn1beNdBBMc4sxdGLbxPFS3FuifiEFnOl7w8wloMJuPvp4Y3
         /ynkc/tdv8Nc/9Tt0KjROLVw2GX1FWcVvoQeg5xsR9Km7BNLR7T9TbcCAiMr83Sk8qG7
         k4Bw==
X-Gm-Message-State: AHQUAuYVfsC/8ySOfFxPvVq556NoConPVbDwJYjrrMRdnDgL3fnv7OXQ
        4Ex6Eq/37l10NrYOqdnWmTc=
X-Google-Smtp-Source: AHgI3IbdNW1WvqVvocr/4aCjt3V04aLfT7CC3QIJ6fObKnzez5pQTJ9ndpoBUkr3Ttl1NLx+85f8GQ==
X-Received: by 2002:a19:f607:: with SMTP id x7mr64132lfe.47.1550058938092;
        Wed, 13 Feb 2019 03:55:38 -0800 (PST)
Received: from localhost (pat-31-128-146-191.pool.powernet.com.ru. [31.128.146.191])
        by smtp.gmail.com with ESMTPSA id z85sm3151848lff.80.2019.02.13.03.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 03:55:37 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
Date:   Wed, 13 Feb 2019 14:55:36 +0300
To:     Will Deacon <will.deacon@arm.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: 5.0-rc kernel hangs on early boot
Message-ID: <20190213115536.GB8928@yury-thinkpad>
References: <20190213082134.GA21834@yury-thinkpad>
 <20190213111843.GA1912@brain-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213111843.GA1912@brain-police>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 11:18:44AM +0000, Will Deacon wrote:
> Hi Yury,
> 
> On Wed, Feb 13, 2019 at 11:25:40AM +0300, Yury Norov wrote:
> > My kernel on qemu/arm64 setup hangs at early boot since v5.0-rc1.
> > Backtrace is not too verbose:
> > (gdb) i threads
> >   Id   Target Id         Frame
> > * 1    Thread 1 (CPU#0 [running]) 0xffff000010a49b74 in __delay (cycles=4096)
> >     at arch/arm64/lib/delay.c:49
> >   2    Thread 2 (CPU#1 [halted ]) 0x0000000000000000 in ?? ()
> >   3    Thread 3 (CPU#2 [halted ]) 0x0000000000000000 in ?? ()
> >   4    Thread 4 (CPU#3 [halted ]) 0x0000000000000000 in ?? ()
> > (gdb) bt
> > #0  0xffff000010a49b74 in __delay (cycles=4096) at arch/arm64/lib/delay.c:49
> > Backtrace stopped: previous frame identical to this frame (corrupt stack?)
> > 
> > Reverting the patch
> > 1c30844d2dfe272d58c ("mm: reclaim small amounts of memory when an external
> > fragmentation event occurs") together with following patch
> > 73444bc4d8f92e46a20 ("mm, page_alloc: do not wake kswapd with zone lock held")
> > helps me to boot normally. 
> > 
> > Some system information is below, and config is attached.
> 
> FWIW, running with your command-line and .config under KVM with earlycon
> leads to an early page allocation failure followed by a NULL dereference
> during boot if only 1G is configured (log below). For the mm folks, it's
> probably worth pointing out that you're using 64k pages.
> 
> Can you confirm that the kernel boots successfully if you pass more memory to
> qemu (e.g. 2gb)?

2G workaround works, I confirm. Also, Mel's fix provided in this thread works
as well.

Thanks,
Yury

> Will
> 
> --->8
> 
> [    0.000000] swapper: page allocation failure: order:0, mode:0x0(), nodemask=(null),cpuset=(null),mems_allowed=0-3
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc64.9.0+ #1
> [    0.000000] Hardware name: linux,dummy-virt (DT)
> [    0.000000] Call trace:
> [    0.000000]  dump_backtrace+0x0/0x178
> [    0.000000]  show_stack+0x24/0x30
> [    0.000000]  dump_stack+0x90/0xb4
> [    0.000000]  warn_alloc+0x100/0x188
> [    0.000000]  __alloc_pages_nodemask+0xd48/0xd88
> [    0.000000]  alloc_pages_current+0x8c/0xf8
> [    0.000000]  allocate_slab+0x370/0x4a8
> [    0.000000]  new_slab+0x98/0xc0
> [    0.000000]  ___slab_alloc+0x27c/0x510
> [    0.000000]  __slab_alloc+0x50/0x68
> [    0.000000]  kmem_cache_alloc+0x1d0/0x1f8
> [    0.000000]  bootstrap+0x34/0x170
> [    0.000000]  kmem_cache_init+0x9c/0x130
> [    0.000000]  start_kernel+0x240/0x464
> [    0.000000] Mem-Info:
> [    0.000000] active_anon:0 inactive_anon:0 isolated_anon:0
> [    0.000000]  active_file:0 inactive_file:0 isolated_file:0
> [    0.000000]  unevictable:0 dirty:0 writeback:0 unstable:0
> [    0.000000]  slab_reclaimable:0 slab_unreclaimable:1
> [    0.000000]  mapped:0 shmem:0 pagetables:0 bounce:0
> [    0.000000]  free:7737 free_pcp:0 free_cma:0
> [    0.000000] Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
> [    0.000000] Node 0 DMA32 free:495168kB min:524288kB low:524288kB high:524288kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1048576kB managed:495232kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [    0.000000] lowmem_reserve[]: 0 0 0
> [    0.000000] Node 0 DMA32: 1*64kB (U) 4*128kB (U) 2*256kB (U) 3*512kB (U) 3*1024kB (U) 1*2048kB (U) 3*4096kB (U) 2*8192kB (U) 2*16384kB (U) 3*32768kB (U) 3*65536kB (U) 1*131072kB (U) 0*262144kB 0*524288kB = 495168kB
> [    0.000000] 0 total pagecache pages
> [    0.000000] 0 pages in swap cache
> [    0.000000] Swap cache stats: add 0, delete 0, find 0/0
> [    0.000000] Free swap  = 0kB
> [    0.000000] Total swap = 0kB
> [    0.000000] 16384 pages RAM
> [    0.000000] 0 pages HighMem/MovableOnly
> [    0.000000] 8646 pages reserved
> [    0.000000] 8192 pages cma reserved
> [    0.000000] SLUB: Unable to allocate memory on node -1, gfp=0x408000(GFP_NOWAIT|__GFP_ZERO)
> [    0.000000]   cache: kmem_cache, object size: 336, buffer size: 384, default order: 0, min order: 0
> [    0.000000]   node 0: slabs: 0, objs: 0, free: 0
> [    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [    0.000000] Mem abort info:
> [    0.000000]   ESR = 0x96000045
> [    0.000000]   Exception class = DABT (current EL), IL = 32 bits
> [    0.000000]   SET = 0, FnV = 0
> [    0.000000]   EA = 0, S1PTW = 0
> [    0.000000] Data abort info:
> [    0.000000]   ISV = 0, ISS = 0x00000045
> [    0.000000]   CM = 0, WnR = 1
> [    0.000000] [0000000000000000] user address but active_mm is swapper
> [    0.000000] Internal error: Oops: 96000045 [#1] SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc64.9.0+ #1
> [    0.000000] Hardware name: linux,dummy-virt (DT)
> [    0.000000] pstate: 20000085 (nzCv daIf -PAN -UAO)
> [    0.000000] pc : __memcpy+0x110/0x180
> [    0.000000] lr : bootstrap+0x48/0x170
> [    0.000000] sp : ffff00001104ff20
> [    0.000000] x29: ffff00001104ff20 x28: 0000000080ea0018 
> [    0.000000] x27: 0000000000000000 x26: 0000000000000000 
> [    0.000000] x25: 0000000000000000 x24: ffff000010f80008 
> [    0.000000] x23: ffff000010f92490 x22: ffff000011070000 
> [    0.000000] x21: ffff000010f92490 x20: ffff000011a1f000 
> [    0.000000] x19: 0000000000000000 x18: 0000000000000010 
> [    0.000000] x17: 0000000000000000 x16: 0000000000000000 
> [    0.000000] x15: ffffffffffffffff x14: 00000000ffffffff 
> [    0.000000] x13: 00000000000000aa x12: 000000aa000000aa 
> [    0.000000] x11: 0000000d00000000 x10: 0000015000000180 
> [    0.000000] x9 : 0000000000000005 x8 : 0000000040002000 
> [    0.000000] x7 : ffff000011030e80 x6 : 0000000000000000 
> [    0.000000] x5 : 0000000000000000 x4 : 0000000000000000 
> [    0.000000] x3 : 0000000000000000 x2 : 00000000000000d0 
> [    0.000000] x1 : ffff000010f924d0 x0 : 0000000000000000 
> [    0.000000] Process swapper (pid: 0, stack limit = 0x(____ptrval____))
> [    0.000000] Call trace:
> [    0.000000]  __memcpy+0x110/0x180
> [    0.000000]  kmem_cache_init+0x9c/0x130
> [    0.000000]  start_kernel+0x240/0x464
> [    0.000000] Code: a8c12027 a8c12829 a8c1302b a8c1382d (a88120c7) 
> [    0.000000] ---[ end trace a6053f496cb6dec0 ]---
> [    0.000000] Kernel panic - not syncing: Fatal exception
> [    0.000000] ---[ end Kernel panic - not syncing: Fatal exception ]---
