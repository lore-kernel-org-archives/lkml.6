Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CEBC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FBD2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOguRM3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FBD2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeH1PME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:12:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34249 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeH1PME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:12:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id f6-v6so603096plo.1;
        Tue, 28 Aug 2018 04:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rCMUeVqKxlpR8mAw1QaqwgN5G/ui6F18sxW16mRgzbg=;
        b=rOguRM3J3lcM/kPZaSPcAEQbaVyrefutmBcfZrlssC+KfOFnsXJ6Vjui5heOyza9Xt
         iK7+x8ng89Bjapc7F0EsHJVJL5mB4ONxLruzuwpj/fUVU1WeBA6YVerZ2bDzK8nAemv0
         uiBq3kX8C2IYkp9o+e1KW8Ac4R6HS4UvGcSAbaickQf+2TuqDmHDAX2cpKOajfYDYmOA
         VAm6IQKvxoIOHHydgXN+4A1KtQN/jt1SfMGDmY9E5mZE9DQgP2DXejhn/yB6yWhb8JwG
         0TUf+aWp/CUuaqFWPjc6qjO1WRuCZukxDNIRvlCHNhD7UCpEn6x9ZTVKVRx+zG6Q4Ttp
         u1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rCMUeVqKxlpR8mAw1QaqwgN5G/ui6F18sxW16mRgzbg=;
        b=EhRPX0opZmkGM8Qnj1sbWZoVzmOhRq2JanmkW1tEOTWm+aAUGhEsrDOERYsAswh/d5
         potQI8iSC8PSFwRm1bziG4HpDZ97/0AWzzo2FiwhWGi/dwaKkhmXZri8bgHAG+vI3XvG
         SCIl6YlCv1zkeYm25GzecyskB5f41GsoTJhZPhXSwjmwjsSGEU4OyH4+jY3x4/9ofygb
         RuNMLEKtWdiBttnOe0hR50uySbz26sW/AVktk34rsQynL0xKibnfYJS1HNmiEPxo8eQl
         7FusnrGaTfeOr0lK6+ALyyG6P+/j7/qTLETEydOBtC4mBcoQF+peyiOIvHCa5GiyosQK
         JEvQ==
X-Gm-Message-State: APzg51Aqzmm/eAUqhBrbutuvbg0suRL0eYCsxAIk4oxUJX6PpeOGanDP
        Fkk/NqaDdzNXSnsZG4mQ3zuudcjn
X-Google-Smtp-Source: ANB0Vdbt9K3kz71sMSBn8c+JLrglp1376ALqJAIKdR2WDl+whCCjXliR4Y+1Pyz04+N2UEXNEBrAKQ==
X-Received: by 2002:a17:902:6b4c:: with SMTP id g12-v6mr1111608plt.159.1535455253350;
        Tue, 28 Aug 2018 04:20:53 -0700 (PDT)
Received: from roar.au.ibm.com (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id s3-v6sm3287917pgj.84.2018.08.28.04.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 04:20:52 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/3] mm/cow: optimise pte dirty/accessed bits handling in fork
Date:   Tue, 28 Aug 2018 21:20:33 +1000
Message-Id: <20180828112034.30875-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828112034.30875-1-npiggin@gmail.com>
References: <20180828112034.30875-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fork clears dirty/accessed bits from new ptes in the child. This logic
has existed since mapped page reclaim was done by scanning ptes when
it may have been quite important. Today with physical based pte
scanning, there is less reason to clear these bits. Dirty bits are all
tested and cleared together and any dirty bit is the same as many
dirty bits. Any young bit is treated similarly to many young bits, but
not quite the same. A comment has been added where there is some
difference.

This eliminates a major source of faults powerpc/radix requires to set
dirty/accessed bits in ptes, speeding up a fork/exit microbenchmark by
about 5% on POWER9 (16600 -> 17500 fork/execs per second).

Skylake appears to have a micro-fault overhead too -- a test which
allocates 4GB anonymous memory, reads each page, then forks, and times
the child reading a byte from each page. The first pass over the pages
takes about 1000 cycles per page, the second pass takes about 27
cycles (TLB miss). With no additional minor faults measured due to
either child pass, and the page array well exceeding TLB capacity, the
large cost must be caused by micro faults caused by setting accessed
bit.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/huge_memory.c |  2 --
 mm/memory.c      | 10 +++++-----
 mm/vmscan.c      |  8 ++++++++
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d9bae12978ef..5fb1a43e12e0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -977,7 +977,6 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pmdp_set_wrprotect(src_mm, addr, src_pmd);
 		pmd = pmd_wrprotect(pmd);
 	}
-	pmd = pmd_mkold(pmd);
 	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
 
 	ret = 0;
@@ -1071,7 +1070,6 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		pudp_set_wrprotect(src_mm, addr, src_pud);
 		pud = pud_wrprotect(pud);
 	}
-	pud = pud_mkold(pud);
 	set_pud_at(dst_mm, addr, dst_pud, pud);
 
 	ret = 0;
diff --git a/mm/memory.c b/mm/memory.c
index b616a69ad770..3d8bf8220bd0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1038,12 +1038,12 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	}
 
 	/*
-	 * If it's a shared mapping, mark it clean in
-	 * the child
+	 * Child inherits dirty and young bits from parent. There is no
+	 * point clearing them because any cleaning or aging has to walk
+	 * all ptes anyway, and it will notice the bits set in the parent.
+	 * Leaving them set avoids stalls and even page faults on CPUs that
+	 * handle these bits in software.
 	 */
-	if (vm_flags & VM_SHARED)
-		pte = pte_mkclean(pte);
-	pte = pte_mkold(pte);
 
 	page = vm_normal_page(vma, addr, pte);
 	if (page) {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7e7d25504651..52fe64af3d80 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1021,6 +1021,14 @@ static enum page_references page_check_references(struct page *page,
 		 * to look twice if a mapped file page is used more
 		 * than once.
 		 *
+		 * fork() will set referenced bits in child ptes despite
+		 * not having been accessed, to avoid micro-faults of
+		 * setting accessed bits. This heuristic is not perfectly
+		 * accurate in other ways -- multiple map/unmap in the
+		 * same time window would be treated as multiple references
+		 * despite same number of actual memory accesses made by
+		 * the program.
+		 *
 		 * Mark it and spare it for another trip around the
 		 * inactive list.  Another page table reference will
 		 * lead to its activation.
-- 
2.18.0

