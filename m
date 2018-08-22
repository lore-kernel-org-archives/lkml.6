Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D44BC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D1A2183D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CClWurYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D1A2183D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeHVGbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 02:31:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36551 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeHVGbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 02:31:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17-v6so274196pgv.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 20:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k6L7V60tgYGv+lfJrTEz7C2h3jQjmVlNf+2CpL355Uw=;
        b=CClWurYYhPZP1b+a7/UxW5hDMp0ivher8C5m4yrUKdrW9DeAia5nUZUldiFJtXv5u+
         U51mRFG9CE0yXAjhinVdbewB1QO01ag8L6Wz0o8Qge3pwIDs7q+2C+hxvx7zo33vnJWx
         FlG++ASu0bEoNy1mTdNFNBYGwLSy4NGnluNaAjlZOHk5ZZ0jl+92GM1yoqoqKgcKIz2N
         WiWmcbtGZn4Bs1GWACMcQan/c5QDpVdBECNSdax+UKkz9N3x/PdJYUaoa0Bdxu6o6y9Z
         vsKFnZ7ZrfSArJq1vOw0NGWuGSfXiqzE3UsdTS4wRy41PmYfVU3zI2a6WzoodQ0iAJmO
         d9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k6L7V60tgYGv+lfJrTEz7C2h3jQjmVlNf+2CpL355Uw=;
        b=bs6FrabG4We1NNmv8D2Dit/sc7ei7IroXdw032FqMLJ/7LzQ8yi7rEZpZrMek7yAL5
         WGzY+mXeU2L1igoRfh7OcfC+GpBtH6Xp9ex3LEnJZumplmC3FhglUMt6BjKbfvPXHi6w
         BYhhxrmznaDtatd+211H/UbJ1C8VY+pPpvvhgnOFzxMfe+pXI9OMyHCBK9GN/WKqME5h
         lCkcJJrPTiGuFS/UteFm9mZy+KnVdlq1s/puTyeg6l/TjAjHhCVFuoFwkKr2TY4keTIO
         R7iTEg+RxANpmIHgEdKznsi3SZdHzRWztp0zw2tEZmsdmlHWWnRLSgXufoAJRI4Xn1y9
         iM5A==
X-Gm-Message-State: AOUpUlFfIkkka57BxG3FGY1YbwgyUdAF0oePmro79utuitWnkCK8MafM
        ebFoezjS90dCIkZhLeMoILo=
X-Google-Smtp-Source: AA+uWPxV31z1jy7Bm6/N+EN8CZpSzp3X6Sr/3HvKeDlgpaJshLexqp3C8dErWomwKpKdjQ81IiuOyg==
X-Received: by 2002:a65:6551:: with SMTP id a17-v6mr50379577pgw.132.1534907292982;
        Tue, 21 Aug 2018 20:08:12 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id q7-v6sm440165pfq.43.2018.08.21.20.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 20:08:12 -0700 (PDT)
From:   Jia He <hejianet@gmail.com>
X-Google-Original-From: Jia He <jia.he@hxt-semitech.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jia He <jia.he@hxt-semitech.com>
Subject: [PATCH v11 3/3] mm: page_alloc: reduce unnecessary binary search in memblock_next_valid_pfn
Date:   Wed, 22 Aug 2018 11:07:17 +0800
Message-Id: <1534907237-2982-4-git-send-email-jia.he@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
References: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
---
 mm/memblock.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 077ca62..46cb6be 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1144,28 +1144,49 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
 unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
 {
 	struct memblock_type *type = &memblock.memory;
+	struct memblock_region *regions = type->regions;
 	unsigned int right = type->cnt;
 	unsigned int mid, left = 0;
+	unsigned long start_pfn, end_pfn, next_start_pfn;
 	phys_addr_t addr = PFN_PHYS(++pfn);
+	static int early_region_idx __initdata_memblock = -1;
 
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

