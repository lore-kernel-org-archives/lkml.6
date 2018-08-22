Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1B0C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083342178B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUBGkRw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083342178B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeHVGaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 02:30:52 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37952 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeHVGaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 02:30:52 -0400
Received: by mail-pl0-f68.google.com with SMTP id u11-v6so248510plq.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 20:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FZQVcSjva4KqT1QnxQl07tGVuHDUFsqtAvdlpz1t47Q=;
        b=dUBGkRw4fQaiMecEzf8cFWCp6lhVcwMzGzSJuhJ/kDZkOS/u/pcLbU9y5Xf1q1j77r
         dtL/gCMhC9eqDMKxzYrXtYRlA5a94kZIwjuX+W8VHjreqVs9v6Dscjei2XBBlnncnM4p
         n73u1ktG72mHDkQonOkyTO1/t4u/t1qqLjVMvDj7/lvdikAWO7X+SCQYDPl7U2GSVlfJ
         M2ft/3Qfgwnj4P1+9mUHj4676Eku6rYRBV32xYXzPBdGb0x3G/XnuydXMwFf72akSOpp
         7Krekn3z/4ghm2DDp1SZzdN5QUHqpfUvUf0gya3hnJ/6JYU5XPlrKy0IN3wXa46RWS/6
         MJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FZQVcSjva4KqT1QnxQl07tGVuHDUFsqtAvdlpz1t47Q=;
        b=SSloIjYQ4y7IHK3mg6CXj/Nwv7Js77j3pKwLs0gmKhEgHW2aF0bln+nTR2JU7a846A
         ohqnbTDciu2dCTehGaIWlJr/4QeVSdT04XHx4ZtjQ+Ltay1msizQMYYYYu2TIQ5y1rTc
         LRMyWM5Jl6FOsvEU3Vn/oZgdUA8tPFcFpJPfhB3e1C29XDj0gO9wkZwHx1pO2yMV+9WH
         KePNV/uWwCrxNGlG6RMsq9kYWsvRK/9LIg/vG8zuAiBG2Eu8ch9q/7IdaCsykH1klk/d
         ZxAqpWnwK5gGj0vJN9x9oY6vC7hOa7Yl3S6w+eRZd+AphaT2zTHXclaspr1vHmDxigmw
         LzdA==
X-Gm-Message-State: AOUpUlGARP8a6z0Q6EtvCBKrIIbeeyGFD+fCLxY/HleUt1dCAFaNEG1V
        REV7BYlkU77Aq/BHcx1gE48=
X-Google-Smtp-Source: AA+uWPx7O8adWCfcvaXiGqLDUgNNylojl01bhH+g/Gjqes6HLwaxhGQ5ncYX6Lz40i2yhizGHITgng==
X-Received: by 2002:a17:902:42e2:: with SMTP id h89-v6mr51827967pld.69.1534907281175;
        Tue, 21 Aug 2018 20:08:01 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id q7-v6sm440165pfq.43.2018.08.21.20.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 20:08:00 -0700 (PDT)
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
Subject: [PATCH v11 2/3] mm: page_alloc: remain memblock_next_valid_pfn() on arm/arm64
Date:   Wed, 22 Aug 2018 11:07:16 +0800
Message-Id: <1534907237-2982-3-git-send-email-jia.he@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
References: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But it causes
possible panic bug. So Daniel Vacek reverted it later.

But as suggested by Daniel Vacek, it is fine to using memblock to skip
gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.
Daniel said:
"On arm and arm64, memblock is used by default. But generic version of
pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
not always return the next valid one but skips more resulting in some
valid frames to be skipped (as if they were invalid). And that's why
kernel was eventually crashing on some !arm machines."

About the performance consideration:
As said by James in b92df1de5,
"I have tested this patch on a virtual model of a Samurai CPU
with a sparse memory map.  The kernel boot time drops from 109 to
62 seconds."

Thus it would be better if we remain memblock_next_valid_pfn on arm/arm64.

Suggested-by: Daniel Vacek <neelx@redhat.com>
Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 include/linux/mmzone.h |  9 +++++++++
 mm/memblock.c          | 30 ++++++++++++++++++++++++++++++
 mm/page_alloc.c        |  5 ++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 32699b2..8e5e20b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1266,6 +1266,10 @@ static inline int pfn_present(unsigned long pfn)
 #endif
 
 #define early_pfn_valid(pfn)	pfn_valid(pfn)
+#ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
+extern unsigned long memblock_next_valid_pfn(unsigned long pfn);
+#define next_valid_pfn(pfn)	memblock_next_valid_pfn(pfn)
+#endif
 void sparse_init(void);
 #else
 #define sparse_init()	do {} while (0)
@@ -1287,6 +1291,11 @@ struct mminit_pfnnid_cache {
 #define early_pfn_valid(pfn)	(1)
 #endif
 
+/* fallback to default definitions*/
+#ifndef next_valid_pfn
+#define next_valid_pfn(pfn)	(pfn + 1)
+#endif
+
 void memory_present(int nid, unsigned long start, unsigned long end);
 
 /*
diff --git a/mm/memblock.c b/mm/memblock.c
index 3d03866..077ca62 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1140,6 +1140,36 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
 }
 #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
 
+#ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
+unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
+{
+	struct memblock_type *type = &memblock.memory;
+	unsigned int right = type->cnt;
+	unsigned int mid, left = 0;
+	phys_addr_t addr = PFN_PHYS(++pfn);
+
+	do {
+		mid = (right + left) / 2;
+
+		if (addr < type->regions[mid].base)
+			right = mid;
+		else if (addr >= (type->regions[mid].base +
+				  type->regions[mid].size))
+			left = mid + 1;
+		else {
+			/* addr is within the region, so pfn is valid */
+			return pfn;
+		}
+	} while (left < right);
+
+	if (right == type->cnt)
+		return -1UL;
+	else
+		return PHYS_PFN(type->regions[right].base);
+}
+EXPORT_SYMBOL(memblock_next_valid_pfn);
+#endif /*CONFIG_HAVE_MEMBLOCK_PFN_VALID*/
+
 static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 					phys_addr_t align, phys_addr_t start,
 					phys_addr_t end, int nid, ulong flags)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cd3c7b9..607deff 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5485,8 +5485,11 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		if (context != MEMMAP_EARLY)
 			goto not_early;
 
-		if (!early_pfn_valid(pfn))
+		if (!early_pfn_valid(pfn)) {
+			pfn = next_valid_pfn(pfn) - 1;
 			continue;
+		}
+
 		if (!early_pfn_in_nid(pfn, nid))
 			continue;
 		if (!update_defer_init(pgdat, pfn, end_pfn, &nr_initialised))
-- 
1.8.3.1

