Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C77C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EA323F4C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB0ljqP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9EA323F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754038AbeGFIP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:15:29 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36303 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753610AbeGFIP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:15:26 -0400
Received: by mail-pf0-f194.google.com with SMTP id u16-v6so7780428pfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 01:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M4lUapXVAyrWXwX+FZXA04S5ONE2QLINrxH7fBNkdn4=;
        b=FB0ljqP3jrw94czePvXM8wmi3K5GbTMIcIyOqEle5lEzSR4ALIRNgrskUyVmvH3aP2
         o7W0myWvRd53+8m1hjDmhwtnLpKNhH6TxhrjfmSgb1USVnzT17+nsc0OLtxwfhEDWgqi
         j/53IZVRCkysrV8oomKln7ZUU1TiglhGXxWIdE5urRhMy1PZJtGpYUKbojG1/FkuqIdr
         fvPntoLv3h7DGSvKoMOzEGCHS/iDKfi/ODeCaISaW+Ef7T1oGsRB7xErg7nvGt5rpHez
         jlQpPYvV5M3K43DLU20Ef4Bws4jkQLytOPcCOfoLq5aaMtbUaHZDvPQxKvLqxuk/CYpR
         busA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M4lUapXVAyrWXwX+FZXA04S5ONE2QLINrxH7fBNkdn4=;
        b=YQi9THkBnxWyWWPgoM6MX4PyzaDVLtJpmTbIwuvZYv0SbmAJJFt5Z2RmjFSoNOa9HW
         9IxJMrA1r1YDW0sGdUe9PSFTYgeNtv0Ddlek1oApwCdfjn08Z+UJbdHtRB14GOEc4W3q
         w1Jo+87TLTj6+FnzqG8tC0MBhHoM2FdzWDqFeawgVgW91PcPQcpfrlI4EGGVaNf02N/U
         wG5eeAC567isPW2HGMj7qLb8aQrzzx3gjxgVAgL2p6PKwgAsCWci8Xr9ZWfDRoPhRA/j
         HS2up3pXHutBtX1CagmyPWfj+ObKHPOkURADJnP+XqQofd5GEZsaGMxeI6/U6U9tQEdn
         JZdQ==
X-Gm-Message-State: APt69E1Nm7hruVDR6aVs6UxbldGUtidPvWu5Bgb8kFHm/tX7c2mEVOKd
        vWrQcqE3lwQLL6u7SR6CqE4=
X-Google-Smtp-Source: AAOMgpeEUEce5o4yvRMN6z0P/bf9SsD7zzGthwQg0bf+tIOo0cJrDpFOwIX04n19Y+H4fAwFEYqb4A==
X-Received: by 2002:a62:8917:: with SMTP id v23-v6mr9738853pfd.127.1530864925835;
        Fri, 06 Jul 2018 01:15:25 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id c141-v6sm4673049pfc.25.2018.07.06.01.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 01:15:25 -0700 (PDT)
From:   Jia He <hejianet@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steve Capper <steve.capper@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>, richard.weiyang@gmail.com,
        Jia He <jia.he@hxt-semitech.com>
Subject: [PATCH v10 3/6] mm: page_alloc: reduce unnecessary binary search in memblock_next_valid_pfn()
Date:   Fri,  6 Jul 2018 16:14:17 +0800
Message-Id: <1530864860-7671-4-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530864860-7671-1-git-send-email-hejianet@gmail.com>
References: <1530864860-7671-1-git-send-email-hejianet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia He <jia.he@hxt-semitech.com>

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But there is
still some room for improvement.

E.g. if pfn and pfn+1 are in the same memblock region, we can simply pfn++
instead of doing the binary search in memblock_next_valid_pfn.

Furthermore, if the pfn is in a gap of two memory region, skip to next
region directly if possible.

Attached the memblock region information in my server.
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000000200000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000017ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000200000-0x000000000021ffff]
[    0.000000]   node   0: [mem 0x0000000000820000-0x000000000307ffff]
[    0.000000]   node   0: [mem 0x0000000003080000-0x000000000308ffff]
[    0.000000]   node   0: [mem 0x0000000003090000-0x00000000031fffff]
[    0.000000]   node   0: [mem 0x0000000003200000-0x00000000033fffff]
[    0.000000]   node   0: [mem 0x0000000003410000-0x00000000034fffff]
[    0.000000]   node   0: [mem 0x0000000003500000-0x000000000351ffff]
[    0.000000]   node   0: [mem 0x0000000003520000-0x000000000353ffff]
[    0.000000]   node   0: [mem 0x0000000003540000-0x0000000003e3ffff]
[    0.000000]   node   0: [mem 0x0000000003e40000-0x0000000003e7ffff]
[    0.000000]   node   0: [mem 0x0000000003e80000-0x0000000003ecffff]
[    0.000000]   node   0: [mem 0x0000000003ed0000-0x0000000003ed5fff]
[    0.000000]   node   0: [mem 0x0000000003ed6000-0x0000000006eeafff]
[    0.000000]   node   0: [mem 0x0000000006eeb000-0x000000000710ffff]
[    0.000000]   node   0: [mem 0x0000000007110000-0x0000000007f0ffff]
[    0.000000]   node   0: [mem 0x0000000007f10000-0x0000000007faffff]
[    0.000000]   node   0: [mem 0x0000000007fb0000-0x000000000806ffff]
[    0.000000]   node   0: [mem 0x0000000008070000-0x00000000080affff]
[    0.000000]   node   0: [mem 0x00000000080b0000-0x000000000832ffff]
[    0.000000]   node   0: [mem 0x0000000008330000-0x000000000836ffff]
[    0.000000]   node   0: [mem 0x0000000008370000-0x000000000838ffff]
[    0.000000]   node   0: [mem 0x0000000008390000-0x00000000083a9fff]
[    0.000000]   node   0: [mem 0x00000000083aa000-0x00000000083bbfff]
[    0.000000]   node   0: [mem 0x00000000083bc000-0x00000000083fffff]
[    0.000000]   node   0: [mem 0x0000000008400000-0x000000000841ffff]
[    0.000000]   node   0: [mem 0x0000000008420000-0x000000000843ffff]
[    0.000000]   node   0: [mem 0x0000000008440000-0x000000000865ffff]
[    0.000000]   node   0: [mem 0x0000000008660000-0x000000000869ffff]
[    0.000000]   node   0: [mem 0x00000000086a0000-0x00000000086affff]
[    0.000000]   node   0: [mem 0x00000000086b0000-0x00000000086effff]
[    0.000000]   node   0: [mem 0x00000000086f0000-0x0000000008b6ffff]
[    0.000000]   node   0: [mem 0x0000000008b70000-0x0000000008bbffff]
[    0.000000]   node   0: [mem 0x0000000008bc0000-0x0000000008edffff]
[    0.000000]   node   0: [mem 0x0000000008ee0000-0x0000000008ee0fff]
[    0.000000]   node   0: [mem 0x0000000008ee1000-0x0000000008ee2fff]
[    0.000000]   node   0: [mem 0x0000000008ee3000-0x000000000decffff]
[    0.000000]   node   0: [mem 0x000000000ded0000-0x000000000defffff]
[    0.000000]   node   0: [mem 0x000000000df00000-0x000000000fffffff]
[    0.000000]   node   0: [mem 0x0000000010800000-0x0000000017feffff]
[    0.000000]   node   0: [mem 0x000000001c000000-0x000000001c00ffff]
[    0.000000]   node   0: [mem 0x000000001c010000-0x000000001c7fffff]
[    0.000000]   node   0: [mem 0x000000001c810000-0x000000007efbffff]
[    0.000000]   node   0: [mem 0x000000007efc0000-0x000000007efdffff]
[    0.000000]   node   0: [mem 0x000000007efe0000-0x000000007efeffff]
[    0.000000]   node   0: [mem 0x000000007eff0000-0x000000007effffff]
[    0.000000]   node   0: [mem 0x000000007f000000-0x00000017ffffffff]
[    0.000000] Initmem setup node 0 [mem
0x0000000000200000-0x00000017ffffffff]
[    0.000000] On node 0 totalpages: 25145296
[    0.000000]   DMA32 zone: 16376 pages used for memmap
[    0.000000]   DMA32 zone: 0 pages reserved
[    0.000000]   DMA32 zone: 1028048 pages, LIFO batch:31
[    0.000000]   Normal zone: 376832 pages used for memmap
[    0.000000]   Normal zone: 24117248 pages, LIFO batch:31

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 mm/memblock.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index ccad225..84f7fa7 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1140,31 +1140,52 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
 #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
 
 #ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
+static int early_region_idx __init_memblock = -1;
 ulong __init_memblock memblock_next_valid_pfn(ulong pfn)
 {
 	struct memblock_type *type = &memblock.memory;
-	unsigned int right = type->cnt;
-	unsigned int mid, left = 0;
+	struct memblock_region *regions = type->regions;
+	uint right = type->cnt;
+	uint mid, left = 0;
+	ulong start_pfn, end_pfn, next_start_pfn;
 	phys_addr_t addr = PFN_PHYS(++pfn);
 
+	/* fast path, return pfn+1 if next pfn is in the same region */
+	if (early_region_idx != -1) {
+		start_pfn = PFN_DOWN(regions[early_region_idx].base);
+		end_pfn = PFN_DOWN(regions[early_region_idx].base +
+				regions[early_region_idx].size);
+
+		if (pfn >= start_pfn && pfn < end_pfn)
+			return pfn;
+
+		early_region_idx++;
+		next_start_pfn = PFN_DOWN(regions[early_region_idx].base);
+
+		if (pfn >= end_pfn && pfn <= next_start_pfn)
+			return next_start_pfn;
+	}
+
+	/* slow path, do the binary searching */
 	do {
 		mid = (right + left) / 2;
 
-		if (addr < type->regions[mid].base)
+		if (addr < regions[mid].base)
 			right = mid;
-		else if (addr >= (type->regions[mid].base +
-				  type->regions[mid].size))
+		else if (addr >= (regions[mid].base + regions[mid].size))
 			left = mid + 1;
 		else {
-			/* addr is within the region, so pfn is valid */
+			early_region_idx = mid;
 			return pfn;
 		}
 	} while (left < right);
 
 	if (right == type->cnt)
 		return -1UL;
-	else
-		return PHYS_PFN(type->regions[right].base);
+
+	early_region_idx = right;
+
+	return PHYS_PFN(regions[early_region_idx].base);
 }
 EXPORT_SYMBOL(memblock_next_valid_pfn);
 #endif /*CONFIG_HAVE_MEMBLOCK_PFN_VALID*/
-- 
1.8.3.1

