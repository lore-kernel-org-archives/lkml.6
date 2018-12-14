Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADF1C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21ABD20811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544763702;
	bh=FPJtRCJoHGrVN3Z9sjCA5NX8KkyHIk3PqkGg3hA8wKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oZiFwOYy1+lyzv70Bh/TqdeYq4AEsIrCLEjsnrasL3TOkt2QayrcLfRLv1UDn7wlX
	 ahElEqfHcrFChJUUhwr8Xmr/mDFNpeHxL6SGt3VpZgL5niPDBNNTgAF+AJIzb9j6t1
	 xu5gplB0rLGdvC0MvtMaOzxk0Zuq63TYsSZuAZXc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21ABD20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeLNFBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 00:01:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:60868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbeLNFBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 00:01:31 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D13C220879;
        Fri, 14 Dec 2018 05:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544763689;
        bh=FPJtRCJoHGrVN3Z9sjCA5NX8KkyHIk3PqkGg3hA8wKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U//6/MJHAzJrxuGcoWPgz7SK0H8Z2jN+TEThPwo3ioX2GAU4kLRt03mxrjT9tX+Ej
         t2DorKMgLG1LpxkoflmtwjaxdUKhH/zayS0zABNS01nDDyvO/0KXw/xvb/kUFTiIGL
         BUVn/Q30vX4m0cd69vUtza9hJNduDn8OIHU/PUmk=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: correct wrong spelling, issing_*
Date:   Thu, 13 Dec 2018 21:01:26 -0800
Message-Id: <20181214050127.45025-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181214050127.45025-1-jaegeuk@kernel.org>
References: <20181214050127.45025-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use "queued" instead of "issuing".

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c   |  4 ++--
 fs/f2fs/f2fs.h    | 10 +++++-----
 fs/f2fs/segment.c | 26 +++++++++++++-------------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 11d4448e8e09..ebcc121920ba 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -64,7 +64,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 		si->nr_flushed =
 			atomic_read(&SM_I(sbi)->fcc_info->issued_flush);
 		si->nr_flushing =
-			atomic_read(&SM_I(sbi)->fcc_info->issing_flush);
+			atomic_read(&SM_I(sbi)->fcc_info->queued_flush);
 		si->flush_list_empty =
 			llist_empty(&SM_I(sbi)->fcc_info->issue_list);
 	}
@@ -72,7 +72,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 		si->nr_discarded =
 			atomic_read(&SM_I(sbi)->dcc_info->issued_discard);
 		si->nr_discarding =
-			atomic_read(&SM_I(sbi)->dcc_info->issing_discard);
+			atomic_read(&SM_I(sbi)->dcc_info->queued_discard);
 		si->nr_discard_cmd =
 			atomic_read(&SM_I(sbi)->dcc_info->discard_cmd_cnt);
 		si->undiscard_blks = SM_I(sbi)->dcc_info->undiscard_blks;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 81bd9a2bf22b..b634043fe14c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -285,7 +285,7 @@ struct discard_cmd {
 	struct block_device *bdev;	/* bdev */
 	unsigned short ref;		/* reference count */
 	unsigned char state;		/* state */
-	unsigned char issuing;		/* issuing discard */
+	unsigned char queued;		/* queued discard */
 	int error;			/* bio error */
 	spinlock_t lock;		/* for state/bio_ref updating */
 	unsigned short bio_ref;		/* bio reference count */
@@ -327,7 +327,7 @@ struct discard_cmd_control {
 	unsigned int undiscard_blks;		/* # of undiscard blocks */
 	unsigned int next_pos;			/* next discard position */
 	atomic_t issued_discard;		/* # of issued discard */
-	atomic_t issing_discard;		/* # of issing discard */
+	atomic_t queued_discard;		/* # of queued discard */
 	atomic_t discard_cmd_cnt;		/* # of cached cmd count */
 	struct rb_root_cached root;		/* root of discard rb-tree */
 	bool rbtree_check;			/* config for consistence check */
@@ -892,7 +892,7 @@ struct flush_cmd_control {
 	struct task_struct *f2fs_issue_flush;	/* flush thread */
 	wait_queue_head_t flush_wait_queue;	/* waiting queue for wake-up */
 	atomic_t issued_flush;			/* # of issued flushes */
-	atomic_t issing_flush;			/* # of issing flushes */
+	atomic_t queued_flush;			/* # of queued flushes */
 	struct llist_head issue_list;		/* list for command issue */
 	struct llist_node *dispatch_list;	/* list for command dispatch */
 };
@@ -2167,8 +2167,8 @@ static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 		get_pages(sbi, F2FS_WB_CP_DATA) ||
 		get_pages(sbi, F2FS_DIO_READ) ||
 		get_pages(sbi, F2FS_DIO_WRITE) ||
-		atomic_read(&SM_I(sbi)->dcc_info->issing_discard) ||
-		atomic_read(&SM_I(sbi)->fcc_info->issing_flush))
+		atomic_read(&SM_I(sbi)->dcc_info->queued_discard) ||
+		atomic_read(&SM_I(sbi)->fcc_info->queued_flush))
 		return false;
 	return f2fs_time_over(sbi, type);
 }
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 98649d304a2f..49ea9009ab5a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -620,16 +620,16 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino)
 		return 0;
 
 	if (!test_opt(sbi, FLUSH_MERGE)) {
-		atomic_inc(&fcc->issing_flush);
+		atomic_inc(&fcc->queued_flush);
 		ret = submit_flush_wait(sbi, ino);
-		atomic_dec(&fcc->issing_flush);
+		atomic_dec(&fcc->queued_flush);
 		atomic_inc(&fcc->issued_flush);
 		return ret;
 	}
 
-	if (atomic_inc_return(&fcc->issing_flush) == 1 || sbi->s_ndevs > 1) {
+	if (atomic_inc_return(&fcc->queued_flush) == 1 || sbi->s_ndevs > 1) {
 		ret = submit_flush_wait(sbi, ino);
-		atomic_dec(&fcc->issing_flush);
+		atomic_dec(&fcc->queued_flush);
 
 		atomic_inc(&fcc->issued_flush);
 		return ret;
@@ -648,14 +648,14 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino)
 
 	if (fcc->f2fs_issue_flush) {
 		wait_for_completion(&cmd.wait);
-		atomic_dec(&fcc->issing_flush);
+		atomic_dec(&fcc->queued_flush);
 	} else {
 		struct llist_node *list;
 
 		list = llist_del_all(&fcc->issue_list);
 		if (!list) {
 			wait_for_completion(&cmd.wait);
-			atomic_dec(&fcc->issing_flush);
+			atomic_dec(&fcc->queued_flush);
 		} else {
 			struct flush_cmd *tmp, *next;
 
@@ -664,7 +664,7 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino)
 			llist_for_each_entry_safe(tmp, next, list, llnode) {
 				if (tmp == &cmd) {
 					cmd.ret = ret;
-					atomic_dec(&fcc->issing_flush);
+					atomic_dec(&fcc->queued_flush);
 					continue;
 				}
 				tmp->ret = ret;
@@ -693,7 +693,7 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
 	if (!fcc)
 		return -ENOMEM;
 	atomic_set(&fcc->issued_flush, 0);
-	atomic_set(&fcc->issing_flush, 0);
+	atomic_set(&fcc->queued_flush, 0);
 	init_waitqueue_head(&fcc->flush_wait_queue);
 	init_llist_head(&fcc->issue_list);
 	SM_I(sbi)->fcc_info = fcc;
@@ -909,7 +909,7 @@ static struct discard_cmd *__create_discard_cmd(struct f2fs_sb_info *sbi,
 	dc->len = len;
 	dc->ref = 0;
 	dc->state = D_PREP;
-	dc->issuing = 0;
+	dc->queued = 0;
 	dc->error = 0;
 	init_completion(&dc->wait);
 	list_add_tail(&dc->list, pend_list);
@@ -942,7 +942,7 @@ static void __detach_discard_cmd(struct discard_cmd_control *dcc,
 							struct discard_cmd *dc)
 {
 	if (dc->state == D_DONE)
-		atomic_sub(dc->issuing, &dcc->issing_discard);
+		atomic_sub(dc->queued, &dcc->queued_discard);
 
 	list_del(&dc->list);
 	rb_erase_cached(&dc->rb_node, &dcc->root);
@@ -1145,8 +1145,8 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 		dc->bio_ref++;
 		spin_unlock_irqrestore(&dc->lock, flags);
 
-		atomic_inc(&dcc->issing_discard);
-		dc->issuing++;
+		atomic_inc(&dcc->queued_discard);
+		dc->queued++;
 		list_move_tail(&dc->list, wait_list);
 
 		/* sanity check on discard range */
@@ -1996,7 +1996,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	INIT_LIST_HEAD(&dcc->fstrim_list);
 	mutex_init(&dcc->cmd_lock);
 	atomic_set(&dcc->issued_discard, 0);
-	atomic_set(&dcc->issing_discard, 0);
+	atomic_set(&dcc->queued_discard, 0);
 	atomic_set(&dcc->discard_cmd_cnt, 0);
 	dcc->nr_discards = 0;
 	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
-- 
2.19.0.605.g01d371f741-goog

