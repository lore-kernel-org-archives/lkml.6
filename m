Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD67C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24C221738
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550480115;
	bh=fryPfb3qUEsbv7prLXOwjbwv4MMuRGFOWfXs1TXlaxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q7n0Gtg3dZLY2qb7tRAkCaOgCihmOkURVLbopLwvtX9P6n9SMOsG0EpzR4XL40IJM
	 cIZooA3r3pkdpzxIBhAhaevVq7M6mjgLxUosGzKVSYi9dA1JqHYfg9JyswimJWzEV/
	 QUjIemslRWkefQ1I0ISCWxmQp/lKwqd1ogZj8lsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbfBRIzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:55:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:52854 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727423AbfBRIzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:55:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F640ACA2;
        Mon, 18 Feb 2019 08:55:11 +0000 (UTC)
Date:   Mon, 18 Feb 2019 09:55:10 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@01.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [LKP] efad4e475c [ 40.308255] Oops: 0000 [#1] PREEMPT SMP PTI
Message-ID: <20190218085510.GC7251@dhcp22.suse.cz>
References: <20190218052823.GH29177@shao2-debian>
 <20190218070844.GC4525@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218070844.GC4525@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry for an excessive quoting in the previous email]
[Cc Pavel - the full report is http://lkml.kernel.org/r/20190218052823.GH29177@shao2-debian[]

On Mon 18-02-19 08:08:44, Michal Hocko wrote:
> On Mon 18-02-19 13:28:23, kernel test robot wrote:
[...]
> > [   40.305212] PGD 0 P4D 0 
> > [   40.308255] Oops: 0000 [#1] PREEMPT SMP PTI
> > [   40.313055] CPU: 1 PID: 239 Comm: udevd Not tainted 5.0.0-rc4-00149-gefad4e4 #1
> > [   40.321348] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> > [   40.330813] RIP: 0010:page_mapping+0x12/0x80
> > [   40.335709] Code: 5d c3 48 89 df e8 0e ad 02 00 85 c0 75 da 89 e8 5b 5d c3 0f 1f 44 00 00 53 48 89 fb 48 8b 43 08 48 8d 50 ff a8 01 48 0f 45 da <48> 8b 53 08 48 8d 42 ff 83 e2 01 48 0f 44 c3 48 83 38 ff 74 2f 48
> > [   40.356704] RSP: 0018:ffff88801fa87cd8 EFLAGS: 00010202
> > [   40.362714] RAX: ffffffffffffffff RBX: fffffffffffffffe RCX: 000000000000000a
> > [   40.370798] RDX: fffffffffffffffe RSI: ffffffff820b9a20 RDI: ffff88801e5c0000
> > [   40.378830] RBP: 6db6db6db6db6db7 R08: ffff88801e8bb000 R09: 0000000001b64d13
> > [   40.386902] R10: ffff88801fa87cf8 R11: 0000000000000001 R12: ffff88801e640000
> > [   40.395033] R13: ffffffff820b9a20 R14: ffff88801f145258 R15: 0000000000000001
> > [   40.403138] FS:  00007fb2079817c0(0000) GS:ffff88801dd00000(0000) knlGS:0000000000000000
> > [   40.412243] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   40.418846] CR2: 0000000000000006 CR3: 000000001fa82000 CR4: 00000000000006a0
> > [   40.426951] Call Trace:
> > [   40.429843]  __dump_page+0x14/0x2c0
> > [   40.433947]  is_mem_section_removable+0x24c/0x2c0
> 
> This looks like we are stumbling over an unitialized struct page again.
> Something this patch should prevent from. Could you try to apply [1]
> which will make __dump_page more robust so that we do not blow up there
> and give some more details in return.
> 
> Btw. is this reproducible all the time?

And forgot to ask whether this is reproducible with pending mmotm
patches in linux-next.

> I will have a look at the memory layout later today.

[    0.059335] No NUMA configuration found
[    0.059345] Faking a node at [mem 0x0000000000000000-0x000000001ffdffff]
[    0.059399] NODE_DATA(0) allocated [mem 0x1e8c3000-0x1e8c5fff]
[    0.073143] Zone ranges:
[    0.073175]   DMA32    [mem 0x0000000000001000-0x000000001ffdffff]
[    0.073204]   Normal   empty
[    0.073212] Movable zone start for each node
[    0.073240] Early memory node ranges
[    0.073247]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.073275]   node   0: [mem 0x0000000000100000-0x000000001ffdffff]
[    0.073309] Zeroed struct page in unavailable ranges: 98 pages
[    0.073312] Initmem setup node 0 [mem 0x0000000000001000-0x000000001ffdffff]
[    0.073343] On node 0 totalpages: 130942
[    0.073373]   DMA32 zone: 1792 pages used for memmap
[    0.073400]   DMA32 zone: 21 pages reserved
[    0.073408]   DMA32 zone: 130942 pages, LIFO batch:31

We have only a single NUMA node with a single ZONE_DMA32. But there is a
hole in the zone and the first range before the hole is not section
aligned. We do zero some unavailable ranges but from the number it is no
clear which range it is and 98. [0x60fff, 0xfffff) is 96 pages. The
patch below should tell us whether we are covering all we need. If yes
then the hole shouldn't make any difference and the problem must be
somewhere else.

---
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 35fdde041f5c..c60642505e04 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6706,10 +6706,13 @@ void __init zero_resv_unavail(void)
 	pgcnt = 0;
 	for_each_mem_range(i, &memblock.memory, NULL,
 			NUMA_NO_NODE, MEMBLOCK_NONE, &start, &end, NULL) {
-		if (next < start)
+		if (next < start) {
+			pr_info("zeroying %llx-%llx\n", PFN_DOWN(next), PFN_UP(start));
 			pgcnt += zero_pfn_range(PFN_DOWN(next), PFN_UP(start));
+		}
 		next = end;
 	}
+	pr_info("zeroying %llx-%lx\n", PFN_DOWN(next), max_pfn);
 	pgcnt += zero_pfn_range(PFN_DOWN(next), max_pfn);
 
 	/*
-- 
Michal Hocko
SUSE Labs
