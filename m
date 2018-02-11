Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518323701-5-15232300472668084935
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518323701; b=Ojz4iMrTnMZBImrdq2gyIXbhEl3+mZwzt4SQ/VudTi43ySR
    DeXtBXANGZVp4J5BgdUlI6cPP3g1mog0JhUGiI30WrPswh4FXd/1hBwXjNh0ZTwP
    jNaTtg/U+0uHMJ0FeUFkJ5ZkY5Cf28uYv9EhvIfuCIH8HIlc44rcg1kjvqzvZc8A
    LRhpUxkudGA3oU5hw8OQDudX7Kv9Uzz0hTlz+iwyV6ztqlQAFRNk3b9YeYXD4vWg
    VubreG9U/LKGBAq6tWAdWbNBDZwMsoPhuz1b3dQrmTHtbwz2LBX36ztxUcBfJZI+
    0BRiThHH9eFhQzp0OrvOJn356YSSWdpE2dwGfjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518323701; bh=cEvm2oTeQKiQSSdzxOP
    f2gspvORmqbafdbxaLCu4xuo=; b=oJhMu1dnAIlHaZReGThKSDUzz3hMueoy1tf
    vEa7W+OTtzPhZNHhpZeGkw3QhThZCUOzlP+WB5i1pG00m4UUKnNaguEoEh3R4xH1
    l+vAiVW7AQcme5gekbGOiu8LLIjW2xbhQKJeRw4Hu61NbXv1Pcau+1tnjA2fi7le
    swGTub8ag5zWwSr+/MczOWjUGYs9JSkWH7P6gLxhR9GDpVsRjemOQexGu68y8Bi9
    YjyATwoE/dfP/0pGndY69rQRqG/K78GA2/4SzJ78uZhGtUtZ62duE7xRBcEu8Hkx
    Fk7UWZqT+knnU/xgZv3vQ4EhdpJXV5DpBmz5mhgObj+AxUTp1GQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbeBKEe7 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:34:59 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41789 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753009AbeBKEeO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Christoph Hellwig" <hch@infradead.org>,
        "Jens Axboe" <axboe@kernel.dk>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Waiman Long" <longman@redhat.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.542842782@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 075/136] blktrace: Fix potential deadlock between
 delete & sysfs ops
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <longman@redhat.com>

commit 5acb3cc2c2e9d3020a4fee43763c6463767f1572 upstream.

The lockdep code had reported the following unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(s_active#228);
                               lock(&bdev->bd_mutex/1);
                               lock(s_active#228);
  lock(&bdev->bd_mutex);

 *** DEADLOCK ***

The deadlock may happen when one task (CPU1) is trying to delete a
partition in a block device and another task (CPU0) is accessing
tracing sysfs file (e.g. /sys/block/dm-1/trace/act_mask) in that
partition.

The s_active isn't an actual lock. It is a reference count (kn->count)
on the sysfs (kernfs) file. Removal of a sysfs file, however, require
a wait until all the references are gone. The reference count is
treated like a rwsem using lockdep instrumentation code.

The fact that a thread is in the sysfs callback method or in the
ioctl call means there is a reference to the opended sysfs or device
file. That should prevent the underlying block structure from being
removed.

Instead of using bd_mutex in the block_device structure, a new
blk_trace_mutex is now added to the request_queue structure to protect
access to the blk_trace structure.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Fix typo in patch subject line, and prune a comment detailing how
the code used to work.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 block/blk-core.c        |  3 +++
 include/linux/blkdev.h  |  1 +
 kernel/trace/blktrace.c | 18 ++++++++++++------
 3 files changed, 16 insertions(+), 6 deletions(-)

--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -611,6 +611,9 @@ struct request_queue *blk_alloc_queue_no
 
 	kobject_init(&q->kobj, &blk_queue_ktype);
 
+#ifdef CONFIG_BLK_DEV_IO_TRACE
+	mutex_init(&q->blk_trace_mutex);
+#endif
 	mutex_init(&q->sysfs_lock);
 	spin_lock_init(&q->__queue_lock);
 
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -448,6 +448,7 @@ struct request_queue {
 	int			node;
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	struct blk_trace	*blk_trace;
+	struct mutex		blk_trace_mutex;
 #endif
 	/*
 	 * for flush operations
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -634,6 +634,12 @@ int blk_trace_startstop(struct request_q
 }
 EXPORT_SYMBOL_GPL(blk_trace_startstop);
 
+/*
+ * When reading or writing the blktrace sysfs files, the references to the
+ * opened sysfs or device files should prevent the underlying block device
+ * from being removed. So no further delete protection is really needed.
+ */
+
 /**
  * blk_trace_ioctl: - handle the ioctls associated with tracing
  * @bdev:	the block device
@@ -651,7 +657,7 @@ int blk_trace_ioctl(struct block_device
 	if (!q)
 		return -ENXIO;
 
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock(&q->blk_trace_mutex);
 
 	switch (cmd) {
 	case BLKTRACESETUP:
@@ -677,7 +683,7 @@ int blk_trace_ioctl(struct block_device
 		break;
 	}
 
-	mutex_unlock(&bdev->bd_mutex);
+	mutex_unlock(&q->blk_trace_mutex);
 	return ret;
 }
 
@@ -1670,7 +1676,7 @@ static ssize_t sysfs_blk_trace_attr_show
 	if (q == NULL)
 		goto out_bdput;
 
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock(&q->blk_trace_mutex);
 
 	if (attr == &dev_attr_enable) {
 		ret = sprintf(buf, "%u\n", !!q->blk_trace);
@@ -1689,7 +1695,7 @@ static ssize_t sysfs_blk_trace_attr_show
 		ret = sprintf(buf, "%llu\n", q->blk_trace->end_lba);
 
 out_unlock_bdev:
-	mutex_unlock(&bdev->bd_mutex);
+	mutex_unlock(&q->blk_trace_mutex);
 out_bdput:
 	bdput(bdev);
 out:
@@ -1731,7 +1737,7 @@ static ssize_t sysfs_blk_trace_attr_stor
 	if (q == NULL)
 		goto out_bdput;
 
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock(&q->blk_trace_mutex);
 
 	if (attr == &dev_attr_enable) {
 		if (value)
@@ -1757,7 +1763,7 @@ static ssize_t sysfs_blk_trace_attr_stor
 	}
 
 out_unlock_bdev:
-	mutex_unlock(&bdev->bd_mutex);
+	mutex_unlock(&q->blk_trace_mutex);
 out_bdput:
 	bdput(bdev);
 out:
