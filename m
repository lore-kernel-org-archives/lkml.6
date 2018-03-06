Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933355AbeCFTfJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 14:35:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49136 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933206AbeCFTYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 14:24:35 -0500
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH v8 39/63] mm: Convert __do_page_cache_readahead to XArray
Date: Tue,  6 Mar 2018 11:23:49 -0800
Message-Id: <20180306192413.5499-40-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180306192413.5499-1-willy@infradead.org>
References: <20180306192413.5499-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

This one is trivial.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/readahead.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 3ff9763b0461..5f528d649d5e 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -174,9 +174,7 @@ int __do_page_cache_readahead(struct address_space *mapping, struct file *filp,
 		if (page_offset > end_index)
 			break;
 
-		rcu_read_lock();
-		page = radix_tree_lookup(&mapping->i_pages, page_offset);
-		rcu_read_unlock();
+		page = xa_load(&mapping->i_pages, page_offset);
 		if (page && !xa_is_value(page))
 			continue;
 
-- 
2.16.1
