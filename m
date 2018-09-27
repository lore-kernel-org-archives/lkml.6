Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE7DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08CE216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vazNJLqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08CE216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeI0UEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:04:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44796 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeI0UEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:04:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id g2-v6so1995070pgu.11;
        Thu, 27 Sep 2018 06:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4phDb1xWxQiiR8jky/VREeoibO5x9Y96ECC8F1IMjuA=;
        b=vazNJLqMAoLx/XSRRv0Kuv0cP8eXa7U24Qbf0VWlQiza9YEgat7A2MD24r0dqE5FPr
         FDatFsSsVeBhv/KWyuc0lWhaZ4+OYy4OuklhsLL4nQczqD84jxt7Lc2nBStsV2+A45Wo
         adeKM7Fm3atR0+y3hhYYTi8G4BVL+EpgEDU0eXduF6IR9vrYUJWxQtPaNBfD5BaJZO30
         /etCL3ReMZcxB+9mYe+lUDza90P49n2J6xHO+qykBpHJ5v1GEnrIXIRdlTL86VsqyGAH
         3lPBI0m89gGYvSk4s8mGCijlxkoA5kcGYFhQfUsUds1EcDTudQeKSS4qOoyhDnTi9jkF
         ZOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4phDb1xWxQiiR8jky/VREeoibO5x9Y96ECC8F1IMjuA=;
        b=KUs6Kiahmiyw2gnXjdqF8PfQFjNy6PP8t0kCLIhL4PWcSa3TwmRbbTKdTb01V6vIcp
         O+iYU6r+uqzeg+RF9G3qsY1B9Mh5Cz/Qv4Vl8d94ht6pu7odEa3EV3MJHnCfXx2xlI7E
         7VbYN4x+ltXEA+czl0A3ez96nUxkvNzVuVLOgDSOJBDA+czbChTnwF0jubDypTllsujD
         HLgPA0mj2o9Nd76uKm/l11vw86HFwNoQgfPIekljYr/b8hAvKZpXIZTuE+A1/ex0skIP
         UdCk912Sq7fiJHh51IKZ7U1IZ+B7Nmm8CILh2OfFxyrktMmoNdcvEF4ZELWOI9lef8bW
         tYhQ==
X-Gm-Message-State: ABuFfoiIUy8MHNXFhOVwJJSCg//MyXK5EgZJn3mNgi+kOPkZxtEsvRkv
        oLytOayyjytfJ+Y/V2cZ4mDmZMPRpVPieQ==
X-Google-Smtp-Source: ACcGV62o0aUKZOQGn7ECtMuqZDXHPuGkvmbiUzuD1gRyF/XiM3Rog4m8YrB07fM8fTdCCwTVV9aoEA==
X-Received: by 2002:a65:4849:: with SMTP id i9-v6mr10200135pgs.350.1538055979569;
        Thu, 27 Sep 2018 06:46:19 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([113.88.12.25])
        by smtp.gmail.com with ESMTPSA id z5-v6sm3137049pfh.83.2018.09.27.06.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 06:46:18 -0700 (PDT)
From:   guoju <fangguoju@gmail.com>
To:     colyli@suse.de, kent.overstreet@gmail.com,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     guoju <fangguoju@gmail.com>
Subject: [PATCH] bcache: add separate workqueue for journal_write to avoid deadlock
Date:   Thu, 27 Sep 2018 21:45:19 +0800
Message-Id: <1538055919-5757-1-git-send-email-fangguoju@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After write SSD completed, bcache schedule journal_write work to
system_wq, that is a public workqueue in system, without WQ_MEM_RECLAIM
flag. system_wq is also a bound wq, and there may be no idle kworker on
current processor. Creating a new kworker may unfortunately need to
reclaim memory first, by shrinking cache and slab used by vfs, which
depends on bcache device. That's a deadlock.

This patch create a new workqueue for journal_write with WQ_MEM_RECLAIM
flag. It's rescuer thread will work to avoid the deadlock.

Signed-off-by: guoju <fangguoju@gmail.com>
---
 drivers/md/bcache/bcache.h  | 1 +
 drivers/md/bcache/journal.c | 6 +++---
 drivers/md/bcache/super.c   | 8 ++++++++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 83504dd..954dad2 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -965,6 +965,7 @@ bool bch_alloc_sectors(struct cache_set *c, struct bkey *k,
 void bch_write_bdev_super(struct cached_dev *dc, struct closure *parent);
 
 extern struct workqueue_struct *bcache_wq;
+extern struct workqueue_struct *bch_journal_wq;
 extern struct mutex bch_register_lock;
 extern struct list_head bch_cache_sets;
 
diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 6116bbf..522c742 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -485,7 +485,7 @@ static void do_journal_discard(struct cache *ca)
 
 		closure_get(&ca->set->cl);
 		INIT_WORK(&ja->discard_work, journal_discard_work);
-		schedule_work(&ja->discard_work);
+		queue_work(bch_journal_wq, &ja->discard_work);
 	}
 }
 
@@ -592,7 +592,7 @@ static void journal_write_done(struct closure *cl)
 		: &j->w[0];
 
 	__closure_wake_up(&w->wait);
-	continue_at_nobarrier(cl, journal_write, system_wq);
+	continue_at_nobarrier(cl, journal_write, bch_journal_wq);
 }
 
 static void journal_write_unlock(struct closure *cl)
@@ -627,7 +627,7 @@ static void journal_write_unlocked(struct closure *cl)
 		spin_unlock(&c->journal.lock);
 
 		btree_flush_write(c);
-		continue_at(cl, journal_write, system_wq);
+		continue_at(cl, journal_write, bch_journal_wq);
 		return;
 	}
 
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 3ede144..64715a8 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -47,6 +47,7 @@
 static DEFINE_IDA(bcache_device_idx);
 static wait_queue_head_t unregister_wait;
 struct workqueue_struct *bcache_wq;
+struct workqueue_struct *bch_journal_wq;
 
 #define BTREE_MAX_PAGES		(256 * 1024 / PAGE_SIZE)
 /* limitation of partitions number on single bcache device */
@@ -2344,6 +2345,9 @@ static void bcache_exit(void)
 		kobject_put(bcache_kobj);
 	if (bcache_wq)
 		destroy_workqueue(bcache_wq);
+	if (bch_journal_wq)
+		destroy_workqueue(bch_journal_wq);
+
 	if (bcache_major)
 		unregister_blkdev(bcache_major, "bcache");
 	unregister_reboot_notifier(&reboot);
@@ -2373,6 +2377,10 @@ static int __init bcache_init(void)
 	if (!bcache_wq)
 		goto err;
 
+	bch_journal_wq = alloc_workqueue("bch_journal", WQ_MEM_RECLAIM, 0);
+	if (!bch_journal_wq)
+		goto err;
+
 	bcache_kobj = kobject_create_and_add("bcache", fs_kobj);
 	if (!bcache_kobj)
 		goto err;
-- 
1.8.3.1

