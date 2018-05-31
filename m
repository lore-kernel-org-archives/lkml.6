Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755332AbeEaNzI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 09:55:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:44355 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755308AbeEaNzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 09:55:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="45381063"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 1/2] mm/page_ext: Drop definition of unused PAGE_EXT_DEBUG_POISON
Date: Thu, 31 May 2018 16:54:56 +0300
Message-Id: <20180531135457.20167-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180531135457.20167-1-kirill.shutemov@linux.intel.com>
References: <20180531135457.20167-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After bd33ef368135 ("mm: enable page poisoning early at boot")
PAGE_EXT_DEBUG_POISON is not longer used. Remove it.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Vinayak Menon <vinmenon@codeaurora.org>
---
 include/linux/page_ext.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index ca5461efae2f..bbec618a614b 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -16,18 +16,7 @@ struct page_ext_operations {
 
 #ifdef CONFIG_PAGE_EXTENSION
 
-/*
- * page_ext->flags bits:
- *
- * PAGE_EXT_DEBUG_POISON is set for poisoned pages. This is used to
- * implement generic debug pagealloc feature. The pages are filled with
- * poison patterns and set this flag after free_pages(). The poisoned
- * pages are verified whether the patterns are not corrupted and clear
- * the flag before alloc_pages().
- */
-
 enum page_ext_flags {
-	PAGE_EXT_DEBUG_POISON,		/* Page is poisoned */
 	PAGE_EXT_DEBUG_GUARD,
 	PAGE_EXT_OWNER,
 #if defined(CONFIG_IDLE_PAGE_TRACKING) && !defined(CONFIG_64BIT)
-- 
2.17.0
