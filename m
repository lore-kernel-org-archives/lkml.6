Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D82C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AB027AF1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgz2ZEIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AB027AF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966760AbeF2Cal (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 22:30:41 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34236 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936532AbeF2Cai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 22:30:38 -0400
Received: by mail-qt0-f193.google.com with SMTP id d23-v6so6663798qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 19:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=prJMZsopAOGvd4i4ZRQwEORKw4GozwPrjoRsWm2lbeQ=;
        b=lgz2ZEITaTVt04bNM0MT1SISuJTXx0Rrp9eDDycJTaX5aaZ2EjdEkQIohH1B4y5DJ1
         UVtQ05IMUPPQDIkMJomg4YdUJZdcRLkstlBJEJrl0EphcxFg2qo31ZgwygThX1wsIBUS
         I7i4MMopE7BZN7yy/IdUjYiQBmMKyS118ZTsDrbJnogA8q3ub001IAScmRzo2y+dgS2N
         G1/ImPXpnQ7Cx+on6s9Qd5DXMS7oule9bzFoqJXSgqtJ3CLUNb0UU/3XXJwxNgLJ4N4y
         F411z6/P0abiJ8Eqsk4pIg7nfNf//HZ6Zab/BvUPZRskxzfOfDuir+diI5NAVptBt5lP
         uUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=prJMZsopAOGvd4i4ZRQwEORKw4GozwPrjoRsWm2lbeQ=;
        b=IaXYH18MAvH8mNL41+DCjd2BtnAr47ZCeT1tG9YRk4GHitoDMiMTV6V0tO+5lK2OFr
         XGlp6pXXWJtzw3p6qFZhXWLt8nOGuASOAMM3po64q20btR227dXUTRTlN4pPhATGRUL1
         eA0TY1RDURYH+jvG2+K6tjxriT/eBmTgqJUJZWJYw2eHU3Gb/RwtUUuEz1v0798rTdLW
         EDwKLPO7d9oY+HspzM9o6oRQJUGHfHkANHlftJoFfgF5+IXkpb57alwwoSYXNRg3EfJe
         pgZRfNifDu0a4Sa85oCoQOUDZLcdTZQgtyv3BlxYpRysm89eeqcY7iV1Mf3bPm/jS33I
         JrPw==
X-Gm-Message-State: APt69E0ZcB6zlD2Y3xgLb1abW4Q9eZkXPlF3jU4dLbtvv8BHLTZlJe3d
        +s68Quw/YKLpBpRAnh6jnkE=
X-Google-Smtp-Source: AAOMgpcqIJfzdL/03nyFApzj1RxfQp6BJ298UNev1sqy6C08/xo2E1+n4eX8mzOaHT7tnEzj84w41Q==
X-Received: by 2002:aed:2a4a:: with SMTP id k10-v6mr4494886qtf.102.1530239437883;
        Thu, 28 Jun 2018 19:30:37 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id y25-v6sm6390186qtc.48.2018.06.28.19.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 19:30:37 -0700 (PDT)
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
        Jia He <hejianet@gmail.com>, Jia He <jia.he@hxt-semitech.com>
Subject: [PATCH v9 3/6] arm: arm64: page_alloc: reduce unnecessary binary search in memblock_next_valid_pfn()
Date:   Fri, 29 Jun 2018 10:29:20 +0800
Message-Id: <1530239363-2356-4-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530239363-2356-1-git-send-email-hejianet@gmail.com>
References: <1530239363-2356-1-git-send-email-hejianet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But there is
still some room for improvement. E.g. if pfn and pfn+1 are in the same
memblock region, we can simply pfn++ instead of doing the binary search
in memblock_next_valid_pfn. Furthermore, if the pfn is in a *gap* of two
memory region, skip to next region directly if possible.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 include/linux/early_pfn.h | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/linux/early_pfn.h b/include/linux/early_pfn.h
index 1b001c7..f9e40c3 100644
--- a/include/linux/early_pfn.h
+++ b/include/linux/early_pfn.h
@@ -3,31 +3,52 @@
 #ifndef __EARLY_PFN_H
 #define __EARLY_PFN_H
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

