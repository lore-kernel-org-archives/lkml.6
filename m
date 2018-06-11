Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mnN/K2GCHltUCQAAmS7hNA
	; Mon, 11 Jun 2018 14:08:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 93B2D6074D; Mon, 11 Jun 2018 14:08:33 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S1LKptTF"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A880F607A4;
	Mon, 11 Jun 2018 14:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A880F607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933687AbeFKOHW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:07:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46352 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933618AbeFKOHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UgFl0dysXKDbf8W2SmP4EbGU6+EmivqudowCUQbLCL0=; b=S1LKptTFb6IwBRg/HFYNOtO6s
        xvhJtCtRZZ/azdaRVrsVXBKxznY8NRzGqqPsxzoPcIMpgWcNGO7pCGmrSJPVpo4dy8tBWbejz0l6Y
        VYDcFR3PfrFZROAhODYJfzw3uvV6DaAd6MoPsXunHLLukqr8LCSD9+yfcEWMLTuO7niKodKCY+9lU
        1Xv3Mw3lWkVdARbEiBYjYfV/pLnKM+0ssccRgRT+LLmxWjLfTe/YZofGJzhmPAw+zJahrprKdfIUq
        /Bl/g6MqmnFDZNRPCJuSuUibq3I5cq6ZXH6flRzvCuoRb0vyp0UOCTExJzauIo/8c8ean3HGkQRx0
        r7QfT+jow==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNTO-0004wc-TE; Mon, 11 Jun 2018 14:07:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v13 55/72] shmem: Comment fixups
Date: Mon, 11 Jun 2018 07:06:22 -0700
Message-Id: <20180611140639.17215-56-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Remove the last mentions of radix tree from various comments.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/shmem.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index bffb87854852..5f14acf95eff 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -766,7 +766,7 @@ void shmem_unlock_mapping(struct address_space *mapping)
 }
 
 /*
- * Remove range of pages and swap entries from radix tree, and free them.
+ * Remove range of pages and swap entries from page cache, and free them.
  * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
  */
 static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
@@ -1146,10 +1146,10 @@ static int shmem_unuse_inode(struct shmem_inode_info *info,
 		 * We needed to drop mutex to make that restrictive page
 		 * allocation, but the inode might have been freed while we
 		 * dropped it: although a racing shmem_evict_inode() cannot
-		 * complete without emptying the radix_tree, our page lock
+		 * complete without emptying the page cache, our page lock
 		 * on this swapcache page is not enough to prevent that -
 		 * free_swap_and_cache() of our swap entry will only
-		 * trylock_page(), removing swap from radix_tree whatever.
+		 * trylock_page(), removing swap from page cache whatever.
 		 *
 		 * We must not proceed to shmem_add_to_page_cache() if the
 		 * inode has been freed, but of course we cannot rely on
@@ -1215,7 +1215,7 @@ int shmem_unuse(swp_entry_t swap, struct page *page)
 			false);
 	if (error)
 		goto out;
-	/* No radix_tree_preload: swap entry keeps a place for page in tree */
+	/* No memory allocation: swap entry occupies the slot for the page */
 	error = -EAGAIN;
 
 	mutex_lock(&shmem_swaplist_mutex);
@@ -1889,7 +1889,7 @@ alloc_nohuge:		page = shmem_alloc_and_acct_page(gfp, inode,
 		spin_unlock_irq(&info->lock);
 		goto repeat;
 	}
-	if (error == -EEXIST)	/* from above or from radix_tree_insert */
+	if (error == -EEXIST)
 		goto repeat;
 	return error;
 }
@@ -2501,7 +2501,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 }
 
 /*
- * llseek SEEK_DATA or SEEK_HOLE through the radix_tree.
+ * llseek SEEK_DATA or SEEK_HOLE through the page cache.
  */
 static pgoff_t shmem_seek_hole_data(struct address_space *mapping,
 				    pgoff_t index, pgoff_t end, int whence)
-- 
2.17.1
