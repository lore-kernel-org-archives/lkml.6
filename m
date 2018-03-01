Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3702529-1519933155-2-1719913100750905973
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519933154; b=RJMj8XHsMmHP9pZTl8/bkGKG7rqc0NREL1vx9nVKsx0Htjd
    B3gYvANULfXfCZCDZ46m5Pz6tC++gygZ1nAf24+gNHaQddRSaasumSTYorZtcRP3
    e+nSyWMqTZjv/Dv13K6+23BSTqJZzQ5N6wcn+yOwPaz5Z7bMls8c0UP756lEzgps
    B4CBfvxnxzKFsLBpCo0+KtENfy4aMQ8Pqv0kIMe0GnL1P2n3hPyPEQeZoDQWgv4e
    qCMxBaclcjEcsZKXa8g7/JvABVFpI9hA3RmIda0M2sxlKHeezz2vRUJtW1q086vK
    Gv2u/Z5nJmWnCVEjCPmHQ0jN3BnWtDnIibiQxhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519933154;
    bh=GiXJ9Fu308x2OYtNIFVGoKE+5xSaiMVpA6N7tlhn86k=; b=FkOYu8uEfN1a
    DQjRz/O4ooAM1QqZlh/epifhQ+rM4hk94T/EtVwsrt9h2LIAxHojObjVMyPtuAgm
    2NZ8rDqBP9MsuhDoSW3EAX9yegqcUdIJzqL63g80aVJlxTL2XWwdbVNseknePZx7
    wbrRIWO9LXS+1Z50W/Sv4cllL7P5/yr9YlwRR6sT64fa1KfCSzsenuMDdrYVkfmd
    vw3tfSJoz0xlZmp+7QSZmHZTcVadginB6wLY6AWToZ3gtmpzHWq0VmH84kqit4SN
    0ZZDGuoWhy/qzcK+2mne/L39PXxl9uAp8m866H24+BRX2LQooe/vSc3YBzs7VDMA
    QMiW3u37wQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034132AbeCATiv (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 14:38:51 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35851 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033435AbeCATit (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 14:38:49 -0500
From: Joseph Salisbury <joseph.salisbury@canonical.com>
To: mlyle@lyle.org, kent.overstreet@gmail.com,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ryan.harper@canonical.com, stable@vger.kernel.org
Subject: [PATCH] bcache: decouple emitting a cached_dev CHANGE uevent
Date: Thu,  1 Mar 2018 14:38:46 -0500
Message-Id: <07844d5b6f5e3273f774db248815da4d50cb4e3c.1513001217.git.joseph.salisbury@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1513001217.git.joseph.salisbury@canonical.com>
References: <cover.1513001217.git.joseph.salisbury@canonical.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ryan Harper <ryan.harper@canonical.com>

BugLink: http://bugs.launchpad.net/bugs/1729145

A bug is preventing /dev/bcache/by-uuid links from being created after reboot.
It appears that since the initramfs loads the bcache module which probes and
finds all of the cache devices and backing devices then once the rootfs is
mounted and udev gets to run, the bcache kernel module does not emit the
CACHED_UUID value into the environment if the underlying devices are already registered.    

With this patch, instead of just failing with "device already registered"
the kernel emits another uevent with CACHED_UUID which would be processed
another time to set up a symlink.


- decouple emitting a cached_dev CHANGE uevent which includes dev.uuid
  and dev.label from bch_cached_dev_run() which only happens when a
  bcacheX device is bound to the actual backing block device (bcache0 -> vdb)

- update bch_cached_dev_run() to invoke bch_cached_dev_emit_change() as
  needed; no functional code path changes here

- Modify register_bcache to detect a re-registering of a bcache
  cached_dev, and in that case call bcache_cached_dev_emit_change() to

Cc: stable@vger.kernel.org
Signed-off-by: Ryan Harper <ryan.harper@canonical.com>
Signed-off-by: Joseph Salisbury <joseph.salisbury@canonical.com>
---
 drivers/md/bcache/bcache.h |  1 +
 drivers/md/bcache/super.c  | 53 +++++++++++++++++++++++++++++++++++++---------
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 02619ca..8ed7e7a 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -906,6 +906,7 @@ int bch_flash_dev_create(struct cache_set *c, uint64_t size);
 
 int bch_cached_dev_attach(struct cached_dev *, struct cache_set *);
 void bch_cached_dev_detach(struct cached_dev *);
+void bch_cached_dev_emit_change(struct cached_dev *);
 void bch_cached_dev_run(struct cached_dev *);
 void bcache_device_stop(struct bcache_device *);
 
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 04608da..9ff0aac 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -834,7 +834,7 @@ static void calc_cached_dev_sectors(struct cache_set *c)
 	c->cached_dev_sectors = sectors;
 }
 
-void bch_cached_dev_run(struct cached_dev *dc)
+void bch_cached_dev_emit_change(struct cached_dev *dc)
 {
 	struct bcache_device *d = &dc->disk;
 	char buf[SB_LABEL_SIZE + 1];
@@ -849,9 +849,18 @@ void bch_cached_dev_run(struct cached_dev *dc)
 	buf[SB_LABEL_SIZE] = '\0';
 	env[2] = kasprintf(GFP_KERNEL, "CACHED_LABEL=%s", buf);
 
+	/* won't show up in the uevent file, use udevadm monitor -e instead
+	 * only class / kset properties are persistent */
+	kobject_uevent_env(&disk_to_dev(d->disk)->kobj, KOBJ_CHANGE, env);
+	kfree(env[1]);
+	kfree(env[2]);
+
+}
+
+void bch_cached_dev_run(struct cached_dev *dc)
+{
+	struct bcache_device *d = &dc->disk;
 	if (atomic_xchg(&dc->running, 1)) {
-		kfree(env[1]);
-		kfree(env[2]);
 		return;
 	}
 
@@ -867,11 +876,9 @@ void bch_cached_dev_run(struct cached_dev *dc)
 
 	add_disk(d->disk);
 	bd_link_disk_holder(dc->bdev, dc->disk.disk);
-	/* won't show up in the uevent file, use udevadm monitor -e instead
-	 * only class / kset properties are persistent */
-	kobject_uevent_env(&disk_to_dev(d->disk)->kobj, KOBJ_CHANGE, env);
-	kfree(env[1]);
-	kfree(env[2]);
+
+	/* emit change event */
+	bch_cached_dev_emit_change(dc);
 
 	if (sysfs_create_link(&d->kobj, &disk_to_dev(d->disk)->kobj, "dev") ||
 	    sysfs_create_link(&disk_to_dev(d->disk)->kobj, &d->kobj, "bcache"))
@@ -1916,6 +1923,21 @@ static bool bch_is_open_backing(struct block_device *bdev) {
 	return false;
 }
 
+static struct cached_dev *bch_find_cached_dev(struct block_device *bdev) {
+	struct cache_set *c, *tc;
+	struct cached_dev *dc, *t;
+
+	list_for_each_entry_safe(c, tc, &bch_cache_sets, list)
+		list_for_each_entry_safe(dc, t, &c->cached_devs, list)
+			if (dc->bdev == bdev)
+				return dc;
+	list_for_each_entry_safe(dc, t, &uncached_devices, list)
+		if (dc->bdev == bdev)
+			return dc;
+
+	return NULL;
+}
+
 static bool bch_is_open_cache(struct block_device *bdev) {
 	struct cache_set *c, *tc;
 	struct cache *ca;
@@ -1941,6 +1963,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	struct cache_sb *sb = NULL;
 	struct block_device *bdev = NULL;
 	struct page *sb_page = NULL;
+	struct cached_dev *dc = NULL;
 
 	if (!try_module_get(THIS_MODULE))
 		return -EBUSY;
@@ -1957,10 +1980,20 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 		if (bdev == ERR_PTR(-EBUSY)) {
 			bdev = lookup_bdev(strim(path), 0);
 			mutex_lock(&bch_register_lock);
-			if (!IS_ERR(bdev) && bch_is_open(bdev))
+			if (!IS_ERR(bdev) && bch_is_open(bdev)) {
 				err = "device already registered";
-			else
+				/* emit CHANGE event for backing devices to export
+				 * CACHED_{UUID/LABEL} values to udev */
+				if (bch_is_open_backing(bdev)) {
+					dc = bch_find_cached_dev(bdev);
+					if (dc) {
+						bch_cached_dev_emit_change(dc);
+						err = "device already registered (emitting change event)";
+					}
+				}
+			} else {
 				err = "device busy";
+            }
 			mutex_unlock(&bch_register_lock);
 			if (!IS_ERR(bdev))
 				bdput(bdev);
-- 
2.7.4
