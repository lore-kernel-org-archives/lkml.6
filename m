Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55049C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2518820672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2518820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633063AbeKXDic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:38:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49696 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729195AbeKXDic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:38:32 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gQEht-0001Vl-SY; Fri, 23 Nov 2018 16:53:29 +0000
From:   Colin King <colin.king@canonical.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ufs: clean up indentation issues, replace spaces with tabs
Date:   Fri, 23 Nov 2018 16:53:29 +0000
Message-Id: <20181123165329.24323-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a hunk of code where spaces are used for identations, and it
off by one in an editor. Clean this up by replacing them with tabs.
Also remove one blank line.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ufs/inode.c | 87 +++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 44 deletions(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index c843ec858cf7..c4fb99eddff4 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -1066,52 +1066,51 @@ static int ufs_alloc_lastblock(struct inode *inode, loff_t size)
 
 	lastpage = ufs_get_locked_page(mapping, lastfrag >>
 				       (PAGE_SHIFT - inode->i_blkbits));
-       if (IS_ERR(lastpage)) {
-               err = -EIO;
-               goto out;
-       }
-
-       end = lastfrag & ((1 << (PAGE_SHIFT - inode->i_blkbits)) - 1);
-       bh = page_buffers(lastpage);
-       for (i = 0; i < end; ++i)
-               bh = bh->b_this_page;
-
-
-       err = ufs_getfrag_block(inode, lastfrag, bh, 1);
-
-       if (unlikely(err))
-	       goto out_unlock;
-
-       if (buffer_new(bh)) {
-	       clear_buffer_new(bh);
-	       clean_bdev_bh_alias(bh);
-	       /*
-		* we do not zeroize fragment, because of
-		* if it maped to hole, it already contains zeroes
-		*/
-	       set_buffer_uptodate(bh);
-	       mark_buffer_dirty(bh);
-	       set_page_dirty(lastpage);
-       }
-
-       if (lastfrag >= UFS_IND_FRAGMENT) {
-	       end = uspi->s_fpb - ufs_fragnum(lastfrag) - 1;
-	       phys64 = bh->b_blocknr + 1;
-	       for (i = 0; i < end; ++i) {
-		       bh = sb_getblk(sb, i + phys64);
-		       lock_buffer(bh);
-		       memset(bh->b_data, 0, sb->s_blocksize);
-		       set_buffer_uptodate(bh);
-		       mark_buffer_dirty(bh);
-		       unlock_buffer(bh);
-		       sync_dirty_buffer(bh);
-		       brelse(bh);
-	       }
-       }
+	if (IS_ERR(lastpage)) {
+		err = -EIO;
+		goto out;
+	}
+
+	end = lastfrag & ((1 << (PAGE_SHIFT - inode->i_blkbits)) - 1);
+	bh = page_buffers(lastpage);
+	for (i = 0; i < end; ++i)
+		bh = bh->b_this_page;
+
+	err = ufs_getfrag_block(inode, lastfrag, bh, 1);
+
+	if (unlikely(err))
+		goto out_unlock;
+
+	if (buffer_new(bh)) {
+		clear_buffer_new(bh);
+		clean_bdev_bh_alias(bh);
+		/*
+		 * we do not zeroize fragment, because of
+		 * if it maped to hole, it already contains zeroes
+		 */
+		set_buffer_uptodate(bh);
+		mark_buffer_dirty(bh);
+		set_page_dirty(lastpage);
+	}
+
+	if (lastfrag >= UFS_IND_FRAGMENT) {
+		end = uspi->s_fpb - ufs_fragnum(lastfrag) - 1;
+		phys64 = bh->b_blocknr + 1;
+		for (i = 0; i < end; ++i) {
+			bh = sb_getblk(sb, i + phys64);
+			lock_buffer(bh);
+			memset(bh->b_data, 0, sb->s_blocksize);
+			set_buffer_uptodate(bh);
+			mark_buffer_dirty(bh);
+			unlock_buffer(bh);
+			sync_dirty_buffer(bh);
+			brelse(bh);
+		}
+	}
 out_unlock:
-       ufs_put_locked_page(lastpage);
+	ufs_put_locked_page(lastpage);
 out:
-       return err;
+	return err;
 }
 
 static void ufs_truncate_blocks(struct inode *inode)
-- 
2.19.1

