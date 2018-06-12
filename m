Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DATE_IN_PAST_96_XX,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB5AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1603A20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPDMbt0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1603A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755788AbeFSFZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:25:51 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32834 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbeFSFZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:25:49 -0400
Received: by mail-pg0-f67.google.com with SMTP id e11-v6so8613994pgq.0;
        Mon, 18 Jun 2018 22:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9xxG0/2qu8Xl12qjRk/yMZIid2vqNdcm7oji8nmg7Q0=;
        b=sPDMbt0mVM0dqZdj7xC7Dclt//Qf1BwDu65bU4UTVGkA9+a/C1GF7Gm1vT9fXGrik1
         ftQA0V0o9z8CGexhatlQn1QZ155ssZsQ63X8a6lNorSZ0RtcgKA0ahKp2T16IkjqY3LS
         JURl2e8CFqg5WkLscR481RO8U7fOT4PwP+Psg/NY6mtdYsewMeFrmIoyntyD7BN2CNdC
         m9f6rn2US0k6W33IVGpbud6cKuga3RH1H/UmnMLTMEfZLCnKmedfj5qZqOjRJx3HumpG
         oOhO0Ap6HoqwZy7Fqnk5G8Vhm7ErDPYCpYFApVUaXsODqIJ3inLJiO5ek9OlXJooTenu
         NdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9xxG0/2qu8Xl12qjRk/yMZIid2vqNdcm7oji8nmg7Q0=;
        b=tSH9JyQ2ZZmOHjkWEQncNyukgn9eRTTO2gsdMMaIzWuasNmCIGRvZqKXfwhP9c/XLA
         bjeOZZtJcwHnQ0TDXzGFd+tp2JbjNC4+VYb4wuLVVSH5ForWljS7iH/KIuZALp1XTpXO
         SGo/6D0a67NaCJXKEivrlzP5WpBAysGPife4YR3Q9NQraTxzVY1Necl/SaYDZ4WeA6CR
         EfGhd+9pzDE+LLqU3N/vuxBWhiEjRyrYsbV3fUaMqv8jRKcQBrZwwkF3E+mLW6/LwQ0r
         sgXfHz3cJo/ZsBoMeGFjdk+1mA4BqQz4O/XscYNOmWlv9EvbGzsgVpj11wZgXJsGlbTU
         5ndQ==
X-Gm-Message-State: APt69E1sBmGKzOvrLaYqunWjyHDXiFBZCHJqsWGUIn1ca0ehaQnVlSFJ
        RjvnfZzW56jjK03xx1KDrx6CwvMY
X-Google-Smtp-Source: ADUXVKK0Rpo8wuWtG4EkS/6loyUHlsBUT8aIhqkQ6la/zRxqiGivkCdbSaKoXe9Us5RfzgyPl5XnqQ==
X-Received: by 2002:a62:1747:: with SMTP id 68-v6mr16313444pfx.69.1529385948353;
        Mon, 18 Jun 2018 22:25:48 -0700 (PDT)
Received: from ubuntu.AD.HARMAN.COM ([106.206.6.177])
        by smtp.gmail.com with ESMTPSA id d22-v6sm28451666pfk.126.2018.06.18.22.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jun 2018 22:25:47 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, jbackik@fb.com, dsterba@suse.com,
        linux-kernel@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH] btrfs: stop using get_seconds()
Date:   Tue, 12 Jun 2018 17:18:25 +0530
Message-Id: <1528804105-24100-1-git-send-email-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_seconds() function is deprecated as it truncates
the timestamp to 32 bits. Change to either ktime_get_seconds()
or ktime_get_real_seconds()

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 fs/btrfs/ctree.h       | 4 ++--
 fs/btrfs/dev-replace.c | 8 ++++----
 fs/btrfs/disk-io.c     | 4 ++--
 fs/btrfs/transaction.c | 2 +-
 fs/btrfs/transaction.h | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 118346a..e671a1f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -342,8 +342,8 @@ struct btrfs_path {
 					sizeof(struct btrfs_item))
 struct btrfs_dev_replace {
 	u64 replace_state;	/* see #define above */
-	u64 time_started;	/* seconds since 1-Jan-1970 */
-	u64 time_stopped;	/* seconds since 1-Jan-1970 */
+	time64_t time_started;	/* seconds since 1-Jan-1970 */
+	time64_t time_stopped;	/* seconds since 1-Jan-1970 */
 	atomic64_t num_write_errors;
 	atomic64_t num_uncorrectable_read_errors;
 
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index e2ba041..1b30c38 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -465,7 +465,7 @@ int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	 * go to the tgtdev as well (refer to btrfs_map_block()).
 	 */
 	dev_replace->replace_state = BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED;
-	dev_replace->time_started = get_seconds();
+	dev_replace->time_started = ktime_get_real_seconds();
 	dev_replace->cursor_left = 0;
 	dev_replace->committed_cursor_left = 0;
 	dev_replace->cursor_left_last_write_of_item = 0;
@@ -618,7 +618,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 			  : BTRFS_IOCTL_DEV_REPLACE_STATE_FINISHED;
 	dev_replace->tgtdev = NULL;
 	dev_replace->srcdev = NULL;
-	dev_replace->time_stopped = get_seconds();
+	dev_replace->time_stopped = ktime_get_real_seconds();
 	dev_replace->item_needs_writeback = 1;
 
 	/* replace old device with new one in mapping tree */
@@ -807,7 +807,7 @@ int btrfs_dev_replace_cancel(struct btrfs_fs_info *fs_info)
 		break;
 	}
 	dev_replace->replace_state = BTRFS_IOCTL_DEV_REPLACE_STATE_CANCELED;
-	dev_replace->time_stopped = get_seconds();
+	dev_replace->time_stopped = ktime_get_real_seconds();
 	dev_replace->item_needs_writeback = 1;
 	btrfs_dev_replace_write_unlock(dev_replace);
 	btrfs_scrub_cancel(fs_info);
@@ -848,7 +848,7 @@ void btrfs_dev_replace_suspend_for_unmount(struct btrfs_fs_info *fs_info)
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED:
 		dev_replace->replace_state =
 			BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED;
-		dev_replace->time_stopped = get_seconds();
+		dev_replace->time_stopped = ktime_get_real_seconds();
 		dev_replace->item_needs_writeback = 1;
 		btrfs_info(fs_info, "suspending dev_replace for unmount");
 		break;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 205092d..f3224e2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1803,7 +1803,7 @@ static int transaction_kthread(void *arg)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_transaction *cur;
 	u64 transid;
-	unsigned long now;
+	time64_t now;
 	unsigned long delay;
 	bool cannot_commit;
 
@@ -1819,7 +1819,7 @@ static int transaction_kthread(void *arg)
 			goto sleep;
 		}
 
-		now = get_seconds();
+		now = ktime_get_real_seconds();
 		if (cur->state < TRANS_STATE_BLOCKED &&
 		    !test_bit(BTRFS_FS_NEED_ASYNC_COMMIT, &fs_info->flags) &&
 		    (now < cur->start_time ||
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index ff5f6c7..56c8bab 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -241,7 +241,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	refcount_set(&cur_trans->use_count, 2);
 	atomic_set(&cur_trans->pending_ordered, 0);
 	cur_trans->flags = 0;
-	cur_trans->start_time = get_seconds();
+	cur_trans->start_time = ktime_get_real_seconds();
 
 	memset(&cur_trans->delayed_refs, 0, sizeof(cur_trans->delayed_refs));
 
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 9443948..4cbb1b5 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -48,7 +48,7 @@ struct btrfs_transaction {
 	int aborted;
 	struct list_head list;
 	struct extent_io_tree dirty_pages;
-	unsigned long start_time;
+	time64_t start_time;
 	wait_queue_head_t writer_wait;
 	wait_queue_head_t commit_wait;
 	wait_queue_head_t pending_wait;
-- 
2.7.4

