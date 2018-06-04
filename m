Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeFDIgQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:36:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53844 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbeFDIgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:36:15 -0400
X-Google-Smtp-Source: ADUXVKJxRumTAYoe6pzj1ejuVMrx0z53G7fWbt3aggcNezPl9Ucd4WAeehb31Z7QWa2kVpl59wxbaA==
From: kpark3469@gmail.com
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, mhocko@suse.com,
        vinmenon@codeaurora.org, jack@suse.cz,
        Sahara <keun-o.park@darkmatter.ae>
Subject: [PATCH v2] mm: clean up page_is_poisoned in linux/mm.h
Date: Mon,  4 Jun 2018 12:31:09 +0400
Message-Id: <1528101069-21637-1-git-send-email-kpark3469@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sahara <keun-o.park@darkmatter.ae>

When bd33ef368135("mm: enable page poisoning early at boot") got
rid of the PAGE_EXT_DEBUG_POISON, page_is_poisoned in the header
left behind. This patch cleans up the leftovers under the table.

Acked-by: Michal Hocko <mhocko@suse.com>
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
