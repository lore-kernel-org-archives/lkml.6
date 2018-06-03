Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbeFCI1S (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 04:27:18 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46341 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeFCI1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 04:27:16 -0400
X-Google-Smtp-Source: ADUXVKJ1DBI62dOAmmz2+B+yfHmGPdLRJET9lhs+Y+7esifwe14bUy67SIVvcpsk5cDWWcdkme0xQA==
From: kpark3469@gmail.com
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, mhocko@suse.com,
        vinmenon@codeaurora.org, jack@suse.cz,
        Sahara <keun-o.park@darkmatter.ae>
Subject: [PATCH] mm: clean up page_is_poisoned in linux/mm.h
Date: Sun,  3 Jun 2018 12:22:18 +0400
Message-Id: <1528014138-27674-1-git-send-email-kpark3469@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sahara <keun-o.park@darkmatter.ae>

When bd33ef36("mm: enable page poisoning early at boot") got rid of
the PAGE_EXT_DEBUG_POISON, page_is_poisoned in the header left
behind. This patch cleans up the leftovers under the table.

Signed-off-by: Sahara <keun-o.park@darkmatter.ae>
---
 include/linux/mm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c6fa9a2..a53b0ad 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2522,12 +2522,10 @@ extern int apply_to_page_range(struct mm_struct *mm, unsigned long address,
 #ifdef CONFIG_PAGE_POISONING
 extern bool page_poisoning_enabled(void);
 extern void kernel_poison_pages(struct page *page, int numpages, int enable);
-extern bool page_is_poisoned(struct page *page);
 #else
 static inline bool page_poisoning_enabled(void) { return false; }
 static inline void kernel_poison_pages(struct page *page, int numpages,
 					int enable) { }
-static inline bool page_is_poisoned(struct page *page) { return false; }
 #endif
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
-- 
2.7.4
