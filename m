Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HSlHFB6EHltpGQAAmS7hNA
	; Mon, 11 Jun 2018 14:15:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3A1E2607BB; Mon, 11 Jun 2018 14:15:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SxnE1mBa"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BDB1F6074D;
	Mon, 11 Jun 2018 14:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BDB1F6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934051AbeFKOPx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:15:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45972 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933570AbeFKOHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cp1noagiBNyq9HAsILQXj5VlZgjwOoF7k27YeP6vh0Y=; b=SxnE1mBapiL1y28hZwNeGhwJ/
        09GiEhWbiib7/g4Cf75aq6Mmb1CR7cHxMapWj7kfybfOHAnN4e8Z/pRh0APfHIQ8UORSfvNeE4yAT
        OgRbmoYJ5MsXrO7CXw1orPGIwM61vo6P8lAv+KtPFjAZF4KsMOU0C6rHaXJG7/QUHP67Xst6/T1j3
        kKeGvrj03NUAd30r20e6DEpV3rYn/8f6mNT07W8BPtRbJFcJjBA2wsF31eiThUGDptumCq90fytF8
        99wUYAh4T4zj5KSBLms74ym6yGsbRfaL2G7ODSleL9hApFG3JeXlnoD35k2xeeOQ45RfrFk3M1t2Y
        zPgRHySzA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNTI-0004pL-7n; Mon, 11 Jun 2018 14:07:00 +0000
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
Subject: [PATCH v13 44/72] mm: Convert is_page_cache_freeable to XArray
Date: Mon, 11 Jun 2018 07:06:11 -0700
Message-Id: <20180611140639.17215-45-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

This is just a variable rename and comment change.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/vmscan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0448b1b366d9..575747728ee6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -572,12 +572,12 @@ static inline int is_page_cache_freeable(struct page *page)
 {
 	/*
 	 * A freeable page cache page is referenced only by the caller
-	 * that isolated the page, the page cache radix tree and
-	 * optional buffer heads at page->private.
+	 * that isolated the page, the page cache and optional buffer
+	 * heads at page->private.
 	 */
-	int radix_pins = PageTransHuge(page) && PageSwapCache(page) ?
+	int page_cache_pins = PageTransHuge(page) && PageSwapCache(page) ?
 		HPAGE_PMD_NR : 1;
-	return page_count(page) - page_has_private(page) == 1 + radix_pins;
+	return page_count(page) - page_has_private(page) == 1 + page_cache_pins;
 }
 
 static int may_write_to_inode(struct inode *inode, struct scan_control *sc)
-- 
2.17.1
