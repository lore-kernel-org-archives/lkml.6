Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SwmzOs/SGVt2TgAAmS7hNA
	; Fri, 08 Jun 2018 00:53:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AEE646074D; Fri,  8 Jun 2018 00:53:05 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFyRVAzL"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0C686605A2;
	Fri,  8 Jun 2018 00:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C686605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeFHAxC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 20:53:02 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41136 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752139AbeFHAxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 20:53:01 -0400
Received: by mail-qk0-f193.google.com with SMTP id w23-v6so7801887qkb.8;
        Thu, 07 Jun 2018 17:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SrUwntz8HkQ+6HqFgfM2mSqvRjWA/aLSQiH/7iQ9aAw=;
        b=CFyRVAzLOsrVApiBX7d1QY1U/ifDTgfwO7MMEsFk8+WkYPD06S4ds4wjyZJ8aFCnBP
         vKESr2NgK1/l/Rtv7sldXnbtfUeTUZKOP6iRY/7Mc7myqGh1RS3Y2ODuDz5m1RboBQoH
         KGYdp+x3Dipc5ROQqGzrpDjjIAvxAfJnhWV0VThvNnVdzUoyVPCOhpu3kwoEGBSM45J0
         7TLFE6rQqoZ0nIfx2Of+oMwyK6X3KyKuTc/WjCMNtn0NHIgNTlE1OUpHuxMeXlOj6lrV
         cK0ANn2PUSvVBFxh5RWKeqDs5xlrW2/7WcZBnDkN5yLaHcDIav8B3IT6CT8o0grQv1ii
         MrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SrUwntz8HkQ+6HqFgfM2mSqvRjWA/aLSQiH/7iQ9aAw=;
        b=OFVTZfm3uGCP5MvyqDEbRKzQ0zqtEoHcYWPLtlib21YQSSM6fAi+/oy8SVRZePQtoP
         s1KdVZT0sIMCpwsNePTODfnSnyI2wg9YNgcwIcUqwULjjvdsP8w+71nwIweGKBaf1jyH
         xmPq49O/0e298Im47/gYpaOiRYYGpGKAbiyiWFNs945QaLRdnbKCrMPCHNAmyGCL5ggJ
         7gsWfWTh29M+nC8BSZAwCubqKvDaAkCIdR0jYlykvSOe0wvaPjKI/38PM/kaNy8/kU0r
         ZDYEEsYJ41LDaN7bdBVcmPBYLez9SvxlYbe/w8cSdvppprc3Oo2Psg9G3I9NKYG4MncW
         iNqA==
X-Gm-Message-State: APt69E0p4NkxF6kzWNvRNdMNjmDxA668eGrAsLGEPqAbJ/nXpM4LZ2Jg
        f5gNQQJfsQBG4acQ7HCfMtQ71DA=
X-Google-Smtp-Source: ADUXVKIDLIrB9SrJ5WKJCzbn/jW7cs54Y+ibHSqntH6ne3Ak7quDODkNxHPWjPRpBejREUAQM1C1Ow==
X-Received: by 2002:a37:88c2:: with SMTP id k185-v6mr3676598qkd.102.1528419180370;
        Thu, 07 Jun 2018 17:53:00 -0700 (PDT)
Received: from localhost.localdomain (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id v189-v6sm11303900qkb.29.2018.06.07.17.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 17:52:59 -0700 (PDT)
From: Kent Overstreet <kent.overstreet@gmail.com>
To: axboe@kernel.dk, shli@kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH] md: Unify mddev destruction paths
Date: Thu,  7 Jun 2018 20:52:54 -0400
Message-Id: <20180608005254.6692-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, mddev_put() had a couple different paths for freeing a
mddev, due to the fact that the kobject wasn't initialized when the
mddev was first allocated. If we move the kobject_init() to when it's
first allocated and just use kobject_add() later, we can clean all this
up.

This also removes a hack in mddev_put() to avoid freeing biosets under a
spinlock, which involved copying biosets on the stack after the reset
bioset_init() changes.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 drivers/md/md.c | 53 +++++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index fc692b7128..22203eba1e 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -84,6 +84,8 @@ static void autostart_arrays(int part);
 static LIST_HEAD(pers_list);
 static DEFINE_SPINLOCK(pers_lock);
 
+static struct kobj_type md_ktype;
+
 struct md_cluster_operations *md_cluster_ops;
 EXPORT_SYMBOL(md_cluster_ops);
 struct module *md_cluster_mod;
@@ -510,11 +512,6 @@ static void mddev_delayed_delete(struct work_struct *ws);
 
 static void mddev_put(struct mddev *mddev)
 {
-	struct bio_set bs, sync_bs;
-
-	memset(&bs, 0, sizeof(bs));
-	memset(&sync_bs, 0, sizeof(sync_bs));
-
 	if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
 		return;
 	if (!mddev->raid_disks && list_empty(&mddev->disks) &&
@@ -522,30 +519,23 @@ static void mddev_put(struct mddev *mddev)
 		/* Array is not configured at all, and not held active,
 		 * so destroy it */
 		list_del_init(&mddev->all_mddevs);
-		bs = mddev->bio_set;
-		sync_bs = mddev->sync_set;
-		memset(&mddev->bio_set, 0, sizeof(mddev->bio_set));
-		memset(&mddev->sync_set, 0, sizeof(mddev->sync_set));
-		if (mddev->gendisk) {
-			/* We did a probe so need to clean up.  Call
-			 * queue_work inside the spinlock so that
-			 * flush_workqueue() after mddev_find will
-			 * succeed in waiting for the work to be done.
-			 */
-			INIT_WORK(&mddev->del_work, mddev_delayed_delete);
-			queue_work(md_misc_wq, &mddev->del_work);
-		} else
-			kfree(mddev);
+
+		/*
+		 * Call queue_work inside the spinlock so that
+		 * flush_workqueue() after mddev_find will succeed in waiting
+		 * for the work to be done.
+		 */
+		INIT_WORK(&mddev->del_work, mddev_delayed_delete);
+		queue_work(md_misc_wq, &mddev->del_work);
 	}
 	spin_unlock(&all_mddevs_lock);
-	bioset_exit(&bs);
-	bioset_exit(&sync_bs);
 }
 
 static void md_safemode_timeout(struct timer_list *t);
 
 void mddev_init(struct mddev *mddev)
 {
+	kobject_init(&mddev->kobj, &md_ktype);
 	mutex_init(&mddev->open_mutex);
 	mutex_init(&mddev->reconfig_mutex);
 	mutex_init(&mddev->bitmap_info.mutex);
@@ -5215,6 +5205,8 @@ static void md_free(struct kobject *ko)
 		put_disk(mddev->gendisk);
 	percpu_ref_exit(&mddev->writes_pending);
 
+	bioset_exit(&mddev->bio_set);
+	bioset_exit(&mddev->sync_set);
 	kfree(mddev);
 }
 
@@ -5348,8 +5340,7 @@ static int md_alloc(dev_t dev, char *name)
 	mutex_lock(&mddev->open_mutex);
 	add_disk(disk);
 
-	error = kobject_init_and_add(&mddev->kobj, &md_ktype,
-				     &disk_to_dev(disk)->kobj, "%s", "md");
+	error = kobject_add(&mddev->kobj, &disk_to_dev(disk)->kobj, "%s", "md");
 	if (error) {
 		/* This isn't possible, but as kobject_init_and_add is marked
 		 * __must_check, we must do something with the result
@@ -5506,7 +5497,7 @@ int md_run(struct mddev *mddev)
 	if (!bioset_initialized(&mddev->sync_set)) {
 		err = bioset_init(&mddev->sync_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
 		if (err)
-			goto abort;
+			return err;
 	}
 
 	spin_lock(&pers_lock);
@@ -5519,8 +5510,7 @@ int md_run(struct mddev *mddev)
 		else
 			pr_warn("md: personality for level %s is not loaded!\n",
 				mddev->clevel);
-		err = -EINVAL;
-		goto abort;
+		return -EINVAL;
 	}
 	spin_unlock(&pers_lock);
 	if (mddev->level != pers->level) {
@@ -5533,8 +5523,7 @@ int md_run(struct mddev *mddev)
 	    pers->start_reshape == NULL) {
 		/* This personality cannot handle reshaping... */
 		module_put(pers->owner);
-		err = -EINVAL;
-		goto abort;
+		return -EINVAL;
 	}
 
 	if (pers->sync_request) {
@@ -5603,7 +5592,7 @@ int md_run(struct mddev *mddev)
 		mddev->private = NULL;
 		module_put(pers->owner);
 		bitmap_destroy(mddev);
-		goto abort;
+		return err;
 	}
 	if (mddev->queue) {
 		bool nonrot = true;
@@ -5665,12 +5654,6 @@ int md_run(struct mddev *mddev)
 	sysfs_notify_dirent_safe(mddev->sysfs_action);
 	sysfs_notify(&mddev->kobj, NULL, "degraded");
 	return 0;
-
-abort:
-	bioset_exit(&mddev->bio_set);
-	bioset_exit(&mddev->sync_set);
-
-	return err;
 }
 EXPORT_SYMBOL_GPL(md_run);
 
-- 
2.17.1
