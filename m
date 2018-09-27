Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865A3C004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465182170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="o0sy6bis";
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="m6n4vYDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465182170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeI1CJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:09:28 -0400
Received: from forward105p.mail.yandex.net ([77.88.28.108]:39069 "EHLO
        forward105p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727530AbeI1CJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:09:27 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Sep 2018 22:09:24 EDT
Received: from mxback15j.mail.yandex.net (mxback15j.mail.yandex.net [IPv6:2a02:6b8:0:1619::91])
        by forward105p.mail.yandex.net (Yandex) with ESMTP id 041F440876E1;
        Thu, 27 Sep 2018 22:41:46 +0300 (MSK)
Received: from smtp1p.mail.yandex.net (smtp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:6])
        by mxback15j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id F9YVjElSvM-fjfW8nYK;
        Thu, 27 Sep 2018 22:41:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1538077306;
        bh=p9KYwSN7c3drpZGnNBkY2ptdEpqFYs/sJIPVtXknpRs=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=o0sy6bisKBO2LP9/6tlBUG1Y4aKo9YBZp0NwnSMtUw/f0tlNWJMYOSwO8Iv/5eQwm
         hnN4bHZZ92RY14fU9g3KXpBGacN5FBwqp4NwuBsMpkRINJcezxfUdm0iU7F1I/yK/G
         4xLlhkadu+aMV/5Eyba0tHbqjHGepq15CFWfuj20=
Received: by smtp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id WtsMNePOsp-fiK0PDD6;
        Thu, 27 Sep 2018 22:41:44 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1538077304;
        bh=p9KYwSN7c3drpZGnNBkY2ptdEpqFYs/sJIPVtXknpRs=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=m6n4vYDm/hnHUHfyTTOijEJ2/Br36MIUV4MVVARMtd7Rb9wMUrrtagyy3nKRh1aSx
         TveArBwxP1wQ/bdn9UbYdrvNfEFU37oDzlOL2WWm835pIA+eTwzqkXWHHOM8xr8gw1
         pC62YDOsQztfihGoG8Sa5QkXkvMSC1qQa47t1RCc=
Authentication-Results: smtp1p.mail.yandex.net; dkim=pass header.i=@yandex.ru
From:   Andrey Abramov <st5pub@yandex.ru>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrey Abramov <st5pub@yandex.ru>
Subject: [PATCH] Fixed some code style issues in the fs/ext4/...
Date:   Thu, 27 Sep 2018 22:41:43 +0300
Message-Id: <20180927194143.32665-1-st5pub@yandex.ru>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
---
 fs/ext4/balloc.c         |  7 +++----
 fs/ext4/block_validity.c |  4 +++-
 fs/ext4/file.c           | 16 ++++++++++------
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index e5d6ee61ff48..87dca171d7f6 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -239,7 +239,7 @@ unsigned ext4_free_clusters_after_init(struct super_block *sb,
 				       ext4_group_t block_group,
 				       struct ext4_group_desc *gdp)
 {
-	return num_clusters_in_group(sb, block_group) - 
+	return num_clusters_in_group(sb, block_group) -
 		ext4_num_overhead_clusters(sb, block_group, gdp);
 }
 
@@ -261,7 +261,7 @@ unsigned ext4_free_clusters_after_init(struct super_block *sb,
  * @bh:			pointer to the buffer head to store the block
  *			group descriptor
  */
-struct ext4_group_desc * ext4_get_group_desc(struct super_block *sb,
+struct ext4_group_desc *ext4_get_group_desc(struct super_block *sb,
 					     ext4_group_t block_group,
 					     struct buffer_head **bh)
 {
@@ -823,8 +823,7 @@ unsigned long ext4_bg_num_gdb(struct super_block *sb, ext4_group_t group)
 	if (!ext4_has_feature_meta_bg(sb) || metagroup < first_meta_bg)
 		return ext4_bg_num_gdb_nometa(sb, group);
 
-	return ext4_bg_num_gdb_meta(sb,group);
-
+	return ext4_bg_num_gdb_meta(sb, group);
 }
 
 /*
diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 913061c0de1b..35e96951eb84 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -154,11 +154,12 @@ int ext4_setup_system_zone(struct super_block *sb)
 	if (sbi->system_blks.rb_node)
 		return 0;
 
-	for (i=0; i < ngroups; i++) {
+	for (i = 0; i < ngroups; i++) {
 		if (ext4_bg_has_super(sb, i) &&
 		    ((i < 5) || ((i % flex_size) == 0)))
 			add_system_zone(sbi, ext4_group_first_block_no(sb, i),
 					ext4_bg_num_gdb(sb, i) + 1);
+
 		gdp = ext4_get_group_desc(sb, i, NULL);
 		ret = add_system_zone(sbi, ext4_block_bitmap(sb, gdp), 1);
 		if (ret)
@@ -174,6 +175,7 @@ int ext4_setup_system_zone(struct super_block *sb)
 
 	if (test_opt(sb, DEBUG))
 		debug_print_tree(sbi);
+
 	return 0;
 }
 
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 69d65d49837b..3e5ded9b3dd4 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -64,7 +64,10 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(file_inode(iocb->ki_filp)->i_sb))))
+	if (unlikely(ext4_forced_shutdown(
+		EXT4_SB(file_inode(iocb->ki_filp)->i_sb)
+		)))
+
 		return -EIO;
 
 	if (!iov_iter_count(to))
@@ -89,14 +92,15 @@ static int ext4_release_file(struct inode *inode, struct file *filp)
 		ext4_clear_inode_state(inode, EXT4_STATE_DA_ALLOC_CLOSE);
 	}
 	/* if we are the last writer on the inode, drop the block reservation */
-	if ((filp->f_mode & FMODE_WRITE) &&
-			(atomic_read(&inode->i_writecount) == 1) &&
-		        !EXT4_I(inode)->i_reserved_data_blocks)
-	{
+	if ((filp->f_mode & FMODE_WRITE)
+		&& (atomic_read(&inode->i_writecount) == 1)
+		&& !EXT4_I(inode)->i_reserved_data_blocks) {
+
 		down_write(&EXT4_I(inode)->i_data_sem);
 		ext4_discard_preallocations(inode);
 		up_write(&EXT4_I(inode)->i_data_sem);
 	}
+
 	if (is_dx(inode) && filp->private_data)
 		ext4_htree_free_dir_info(filp->private_data);
 
@@ -429,7 +433,7 @@ static int ext4_sample_last_mounted(struct super_block *sb,
 	return err;
 }
 
-static int ext4_file_open(struct inode * inode, struct file * filp)
+static int ext4_file_open(struct inode *inode, struct file *filp)
 {
 	int ret;
 
-- 
2.19.0

