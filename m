Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C992C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3894A23F4C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9GAMPcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3894A23F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbeGFIPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:15:17 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40724 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753763AbeGFIPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:15:13 -0400
Received: by mail-pf0-f193.google.com with SMTP id z24-v6so7789387pfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 01:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rBt92G0faVb+l4LzkWBVpJgQsD4xrw1+OJsW6IjcYy8=;
        b=p9GAMPcMJ1/KGfcZ9ULSFU1uurbb9Xh4TPGNVcVHLmEE5CEwPWb1+XbTtcmYRp+eeH
         TllUdRzP7dpHRSs2r4f0jxf5y3M5IPdPFtmrLmqGsOkiMKEDYqSpsK0darnALRSSgDr+
         32HJsGFMHKhyEcxmMzTkLqBetQGysQuNKjP8z+RZXM0Hl/ry7rbIpgJmY0gZKGJ3phM2
         I4jiNLtFSbxAFY19opvGPQxhw/VYE4juMSn3grTnWfpDOHLMS0n5Mvo2d+GdjiEJ2a+L
         pk71+ZU6Ljgtyf7+m7CTcyRFqxsunbSuwLpITGuSX/hq0roclK5oZOnMK7Ek1robjO7r
         4mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rBt92G0faVb+l4LzkWBVpJgQsD4xrw1+OJsW6IjcYy8=;
        b=pKLrD+QV/zCU+yv8rtq+kt+3ZWaFAyB93+Mxwz+KWI9S2Ny/00RDjYW3gYs91Iq4cA
         S6vRXCTqgFx+/nq0Qz8hFp46GGDECb8Hs11kXxxAFqr0zlgrl6z9/83yv5Y/+hb+6Uwj
         l+I4qeesj9HhPHOc+mI6DvIysewCgO/zjX0abXn3AyXQOIJvF3Zd9SGr2H0Z250uSTwO
         t9Mbcibb3y2lfjBv2ipVPVvhkC1GU3ONJYVtKj+b7yr9p/tMCi4HyMIbE2VCQ2OPEo4D
         Fz5w/g9fCupjfpr6bwgkqVyGZ0m5l1/l+IccGSkYgybwv5WBdbF8/p6l+C52U6pmjhK6
         KiIA==
X-Gm-Message-State: APt69E1cNd+A/kErEDJ5fPIkEb3guyMZL9tXQR9/hgMjH9eWEpj5gyfJ
        1N0nSVxtwHBa3QBPEC3TpLk=
X-Google-Smtp-Source: AAOMgpeS4VY7yFiOn8jWTX63Qcc0tacptHOccY0y748dsmgvVcpm6AvISdIifp17xdOr5TwAklTOyg==
X-Received: by 2002:a65:57c9:: with SMTP id q9-v6mr8700904pgr.128.1530864913069;
        Fri, 06 Jul 2018 01:15:13 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id c141-v6sm4673049pfc.25.2018.07.06.01.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 01:15:12 -0700 (PDT)
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
Subject: [PATCH v10 2/6] mm: page_alloc: remain memblock_next_valid_pfn() on arm/arm64
Date:   Fri,  6 Jul 2018 16:14:16 +0800
Message-Id: <1530864860-7671-3-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530864860-7671-1-git-send-email-hejianet@gmail.com>
References: <1530864860-7671-1-git-send-email-hejianet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia He <jia.he@hxt-semitech.com>

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
 include/linux/mmzone.h | 11 +++++++++++
 mm/memblock.c          | 30 ++++++++++++++++++++++++++++++
 mm/page_alloc.c        |  5 ++++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 32699b2..57cdc42 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1241,6 +1241,8 @@ static inline int pfn_valid(unsigned long pfn)
 		return 0;
 	return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
 }
+
+#define next_valid_pfn(pfn)	(pfn + 1)
 #endif
 
 static inline int pfn_present(unsigned long pfn)
@@ -1266,6 +1268,10 @@ static inline int pfn_present(unsigned long pfn)
 #endif
 
 #define early_pfn_valid(pfn)	pfn_valid(pfn)
+#ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
+extern ulong memblock_next_valid_pfn(ulong pfn);
+#define next_valid_pfn(pfn)	memblock_next_valid_pfn(pfn)
+#endif
 void sparse_init(void);
 #else
 #define sparse_init()	do {} while (0)
@@ -1287,6 +1293,11 @@ struct mminit_pfnnid_cache {
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
index b9cdfa0..ccad225 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1139,6 +1139,36 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
 }
 #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
 
+#ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
+ulong __init_memblock memblock_next_valid_pfn(ulong pfn)
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

