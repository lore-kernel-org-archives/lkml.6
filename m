Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC8DECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4B220854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGMTtVQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4B220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeGUSX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 14:23:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43693 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbeGUSX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 14:23:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id v13-v6so9306611pgr.10;
        Sat, 21 Jul 2018 10:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oU+bL+T+HfkDmA67qfWNq4xTnQmopUkcVDO/YclhDV0=;
        b=qGMTtVQtqREX4plNM14l0tjPqBW1jls6IEFP3DN5Ka1tz0rM59DfRrEqxU0pJLirpX
         QzWUO9Tg/ODLt9RsNIyIxEqOiId1AnGyqrh9czvVtzXUjmx86WbwLxchy40YAba5bHI6
         EPp1MRvJGV8odZxVUV9WP16gE1iZ4Am76X03Aax5WWtRT3R7u52EpEsgRjGTGqWlqlwJ
         iFj4G61gU1L9r/Aqqe8Lh14Ru1pgfysjdnS9bjZNcQQOm84Gv4skMMua7OKFq7jiYOXC
         s/jSwIyXLMnyd0UTMrSsp5kfODhw/LemStWe+k0vD5rG1z/ACn156s1Xv/Mjd+S3U0Gh
         O2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oU+bL+T+HfkDmA67qfWNq4xTnQmopUkcVDO/YclhDV0=;
        b=T0Hy45F/31tY7QtupZNaOevBckphQueHaDwcch9YyBssDV45LuMtHaspnA+gl3yTI4
         UhnebyOJb3MV4ybGZkyDckNnLVs8tDBOm+jGaU245FRZ9KeRypoXDjkpbT3IaPAqb/fl
         Y+WffZDkppNvfhzdNneECGUDEfutuWkojccCSaqSr3HfPWQ/Iw9PqtH/UD581iZ1TSg4
         KKRNn6j5Kzb1P6v2UFO/S4727K562PAwhdDJGk+DEu0+mHtZC0RrA7e2r2fwRwX/K/2x
         B7YAUUDrA7JPQKjR9up/oxJXv/STW5VLGUmbMZs4GiJy4VtsUZXVcV4VuQ1QBMJ9O0iO
         DpQQ==
X-Gm-Message-State: AOUpUlEQoMsQ+YFiTBpn8vuuVPlCGEzLs7+us2EzG0Z3cyfk4YAnjdMx
        dIYo9cAE4gWEpbp5NhvH7PfXfShK
X-Google-Smtp-Source: AAOMgpf3QCv5mrNi/QYsp6ASQMhTn0/4PflKXIFoortr/31psNUonI1j5dUjKBj4lUBan8uTv+ZMCg==
X-Received: by 2002:a63:62c4:: with SMTP id w187-v6mr6264043pgb.55.1532194231097;
        Sat, 21 Jul 2018 10:30:31 -0700 (PDT)
Received: from linux-zmni.DHCP ([124.227.0.73])
        by smtp.gmail.com with ESMTPSA id i6-v6sm6800708pfo.107.2018.07.21.10.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 Jul 2018 10:30:30 -0700 (PDT)
From:   Sean Fu <fxinrong@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Fu <fxinrong@gmail.com>
Subject: [PATCH] fs/buffer.c: Optimize grow_buffer function.
Date:   Sun, 22 Jul 2018 01:30:17 +0800
Message-Id: <1532194217-19002-1-git-send-email-fxinrong@gmail.com>
X-Mailer: git-send-email 2.6.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use PAGE_SHIFT and i_blkbits of bd_inode directly to avoid ugly sizebits
calculation.
Remove ugly sizebits calculation.
Remove unnecessary sizebits parameter of grow_dev_page.

Reduces code size:

Before:

sean@linux-zmni:~/sda5/source/linus_repo/linux> size fs/buffer.o
   text	   data	    bss	    dec	    hex	filename
  34037	   1510	     16	  35563	   8aeb	fs/buffer.o

After:

sean@linux-zmni:~/sda5/source/linus_repo/linux> size fs/buffer.o
   text	   data	    bss	    dec	    hex	filename
  34021	   1510	     16	  35547	   8adb	fs/buffer.o

Signed-off-by: Sean Fu <fxinrong@gmail.com>
---
 fs/buffer.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 249b83f..143ad78 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -918,7 +918,7 @@ init_page_buffers(struct page *page, struct block_device *bdev,
  */
 static int
 grow_dev_page(struct block_device *bdev, sector_t block,
-	      pgoff_t index, int size, int sizebits, gfp_t gfp)
+	      pgoff_t index, int size, gfp_t gfp)
 {
 	struct inode *inode = bdev->bd_inode;
 	struct page *page;
@@ -945,7 +945,7 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 		bh = page_buffers(page);
 		if (bh->b_size == size) {
 			end_block = init_page_buffers(page, bdev,
-						(sector_t)index << sizebits,
+						(sector_t)index << (PAGE_SHIFT - inode->i_blkbits),
 						size);
 			goto done;
 		}
@@ -965,7 +965,8 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 	 */
 	spin_lock(&inode->i_mapping->private_lock);
 	link_dev_buffers(page, bh);
-	end_block = init_page_buffers(page, bdev, (sector_t)index << sizebits,
+	end_block = init_page_buffers(page, bdev,
+			(sector_t)index << (PAGE_SHIFT - inode->i_blkbits),
 			size);
 	spin_unlock(&inode->i_mapping->private_lock);
 done:
@@ -984,20 +985,13 @@ static int
 grow_buffers(struct block_device *bdev, sector_t block, int size, gfp_t gfp)
 {
 	pgoff_t index;
-	int sizebits;
-
-	sizebits = -1;
-	do {
-		sizebits++;
-	} while ((size << sizebits) < PAGE_SIZE);
-
-	index = block >> sizebits;
+	index = block >> (PAGE_SHIFT - bdev->bd_inode->i_blkbits);
 
 	/*
 	 * Check for a block which wants to lie outside our maximum possible
 	 * pagecache index.  (this comparison is done using sector_t types).
 	 */
-	if (unlikely(index != block >> sizebits)) {
+	if (unlikely(index != block >> (PAGE_SHIFT - bdev->bd_inode->i_blkbits))) {
 		printk(KERN_ERR "%s: requested out-of-range block %llu for "
 			"device %pg\n",
 			__func__, (unsigned long long)block,
@@ -1006,7 +1000,7 @@ grow_buffers(struct block_device *bdev, sector_t block, int size, gfp_t gfp)
 	}
 
 	/* Create a page with the proper size buffers.. */
-	return grow_dev_page(bdev, block, index, size, sizebits, gfp);
+	return grow_dev_page(bdev, block, index, size, gfp);
 }
 
 static struct buffer_head *
-- 
2.6.2

