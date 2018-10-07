Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A0EC6787E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66AAA2089D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="Z/UWtp8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AAA2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbeJHGhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:37:00 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33207 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeJHGg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:36:59 -0400
Received: by mail-qk1-f195.google.com with SMTP id 84-v6so11122432qkf.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 16:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDD2baT+lsROoq6EE1W/VAoJVJKr4qIgwTtt1LziTQk=;
        b=Z/UWtp8RrUBS2mVYRS/FVfMBammL2mQ7yItwRAovAQ8EH/hTGqNbRLlcIZne5m7NRP
         STMRofc1/7cn4mtU+2exQWD+LREr8gd9Y6cRUu4e28eepYY7hfuphF7fd8sdmWRPhIb0
         pHVXCZAyJeaxpl0NbPX7xUVHzptY+C/3NQFVSZkOhu1OI2YG3rXXWo6G/HyJP4bE2JqT
         eFKiXO25YCRMHhyi3Z7HxYreCAD+c0vRqD1b996G0s0fs3PCFb6uJKpom1UoLP8P9GRB
         H8/N/7BnQOBJp4tQtvz4r8A8dCxsO1zr9xnUQk0WontuSWgsfuKjBTMLY0K1Sz64hlQS
         Gjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDD2baT+lsROoq6EE1W/VAoJVJKr4qIgwTtt1LziTQk=;
        b=maIeeSEr4QTTW0n1eFuhMts0CVsAcPzkH8M+jrh6JtfbTJS4nAGDRTRCzMdhW+ueiQ
         UxCdu+6AxLM3bYC7Wyp8tfCeDa3Jgt/FXkuWDM1MhY9TqdT/BYqw0ZzFfxibZgBMuhjT
         dtQqtffa9KhKM1JFTGQiwyXcbaxz2vK3LEZ9jwZEM8jHUGlZCYz/yHHsW3ouvitVkXAM
         ocRkFrKFfiy5gAdVfs9phsEAyuTTgZXDPthe2keeHpJbv0ke5j9MX8myEQ8pTtH5qEVe
         ziew7aWaarvcySZt1nYP/MIJ0iw6YvX4LDJOi3MJ3Ph5LNyBvQaiZIsBRRKcJUK8Bb6P
         F5TQ==
X-Gm-Message-State: ABuFfoiNnbIl65r54NvngkltEM5lUP9dXRiVCCRi8bI5f+SWaCC83DjA
        VanEPlnF6AwPH9JqQl4GIp0T2g==
X-Google-Smtp-Source: ACcGV60wLvVOozMycIBh+ynXtpJnFoOtprWu5eNcEN3I0mFsC0OCgCwTUYB3qm+3SuQ4v/iqX7tJJQ==
X-Received: by 2002:a37:38c:: with SMTP id 134-v6mr16296266qkd.194.1538954886346;
        Sun, 07 Oct 2018 16:28:06 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-35-153-175-159.compute-1.amazonaws.com. [35.153.175.159])
        by smtp.gmail.com with ESMTPSA id x38-v6sm6793915qtc.39.2018.10.07.16.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 16:28:05 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hubcap@omnibond.com
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 09/19] orangefs: remove orangefs_readpages
Date:   Sun,  7 Oct 2018 23:27:26 +0000
Message-Id: <20181007232736.3780-10-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007232736.3780-1-martin@omnibond.com>
References: <20181007232736.3780-1-martin@omnibond.com>
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

