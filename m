Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1518ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1112147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="gV9SWbuY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1112147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbeIRBlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:41:23 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42718 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbeIRBkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:40:12 -0400
Received: by mail-qt0-f194.google.com with SMTP id z8-v6so16538711qto.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDD2baT+lsROoq6EE1W/VAoJVJKr4qIgwTtt1LziTQk=;
        b=gV9SWbuYM9BH6HM+D4yU6VifBfBNnG0qJF0camBxJ3urn5wvCzgc+DO29hcmCwmtNa
         +dP2aR38GZRPhFuysvugVBiyhP9p7sGgZIK0P1ZHGEXhY+20UfVeEFwwwrVjjw+blrxX
         V1aYLqt2WM9wq42rLkCyCa/yeqKOCaWq33DkLE0yozUj1U/K+JfgypeIJekOOAciEel2
         eoSRIbfzOW/SAtUxQ/2RROM5tzKly2am2H7AlAc3h0nCNRuD6P21ZSLPiPq0ZJ7iCXBc
         pRfPVMrAP5iY89TJdtv8tGpZAUrKCi4WY7b3nOuq385Zdn5RPifcAGVKC9pbulFYNmlz
         IQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDD2baT+lsROoq6EE1W/VAoJVJKr4qIgwTtt1LziTQk=;
        b=l9HxFPb/AR/28dtUTje3gqEUrPV0wzIBRM6OsAV/WUR/xswJIfIfstprGr2ngNuYgW
         rmnSxDKAAVR04w8TtEt5h/OjlOlVlMtH/O1eJk2fl86/f0Dp6ddtL6KcHBQKNnVR0bcO
         wYKCt1LM6q1IWRVmGRUEUTKj524n9faY2YeOHYhOPlPFDeVw3I6bLt3wYREIH+JrWsqK
         3iGp+AnmMql85tzmYafHv2TzW/TPb4xrWPQvXm3533l0M1d5ip96zjlK/CV9wt9V+14H
         uqa3hzijHKceK/NHuum1IGFIo1JtWU+TmeGb/NqMtHjfWE/kDUurLRhgjHS8ZomY5HRh
         sViA==
X-Gm-Message-State: APzg51AvFYZv4aOfkELbZIpNBvhXpt+c/NIXKRUVq3JkIwBjfs+Gg+E3
        flyB8nKlmyF1Ub89IKLxHB5O/TVlyaWENHG0
X-Google-Smtp-Source: ANB0VdZZNDdf+P+SGtDQtGdTEySws13cEzsscW+ilbWCnwg7HTcjPveDZ85dlRu8+Dq+xALsJzFBIw==
X-Received: by 2002:ac8:290a:: with SMTP id y10-v6mr18540939qty.42.1537215080189;
        Mon, 17 Sep 2018 13:11:20 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-18-215-252-133.compute-1.amazonaws.com. [18.215.252.133])
        by smtp.gmail.com with ESMTPSA id n8-v6sm11053480qtk.38.2018.09.17.13.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 13:11:19 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        devel@lists.orangefs.org
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 09/17] orangefs: remove orangefs_readpages
Date:   Mon, 17 Sep 2018 20:10:46 +0000
Message-Id: <20180917201054.3530-10-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917201054.3530-1-martin@omnibond.com>
References: <20180917201054.3530-1-martin@omnibond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a copy of the loop which would run in read_pages from
mm/readahead.c.

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
---
 fs/orangefs/inode.c | 39 +--------------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index cf0811ef0e93..1ef000b69e06 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -15,7 +15,7 @@
 #include "orangefs-kernel.h"
 #include "orangefs-bufmap.h"
 
-static int read_one_page(struct page *page)
+static int orangefs_readpage(struct file *file, struct page *page)
 {
 	int ret;
 	int max_block;
@@ -60,42 +60,6 @@ static int read_one_page(struct page *page)
 	return ret;
 }
 
-static int orangefs_readpage(struct file *file, struct page *page)
-{
-	return read_one_page(page);
-}
-
-static int orangefs_readpages(struct file *file,
-			   struct address_space *mapping,
-			   struct list_head *pages,
-			   unsigned nr_pages)
-{
-	int page_idx;
-	int ret;
-
-	gossip_debug(GOSSIP_INODE_DEBUG, "orangefs_readpages called\n");
-
-	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
-		struct page *page;
-
-		page = list_entry(pages->prev, struct page, lru);
-		list_del(&page->lru);
-		if (!add_to_page_cache(page,
-				       mapping,
-				       page->index,
-				       readahead_gfp_mask(mapping))) {
-			ret = read_one_page(page);
-			gossip_debug(GOSSIP_INODE_DEBUG,
-				"failure adding page to cache, read_one_page returned: %d\n",
-				ret);
-	      } else {
-			put_page(page);
-	      }
-	}
-	BUG_ON(!list_empty(pages));
-	return 0;
-}
-
 static void orangefs_invalidatepage(struct page *page,
 				 unsigned int offset,
 				 unsigned int length)
@@ -141,7 +105,6 @@ static ssize_t orangefs_direct_IO(struct kiocb *iocb,
 /** ORANGEFS2 implementation of address space operations */
 static const struct address_space_operations orangefs_address_operations = {
 	.readpage = orangefs_readpage,
-	.readpages = orangefs_readpages,
 	.invalidatepage = orangefs_invalidatepage,
 	.releasepage = orangefs_releasepage,
 	.direct_IO = orangefs_direct_IO,
-- 
2.19.0

