Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4857C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651B020693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651B020693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754129AbeFTJxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:53:00 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51783 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeFTJw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:52:57 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MUAFy-1fdrEI2qhu-00R0BY; Wed, 20 Jun 2018 11:52:32 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Jens Axboe <axboe@kernel.dk>, Michael Lyle <mlyle@lyle.org>,
        Tang Junhui <tang.junhui@zte.com.cn>,
        Hannes Reinecke <hare@suse.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bcache: stop using the deprecated get_seconds()
Date:   Wed, 20 Jun 2018 11:51:54 +0200
Message-Id: <20180620095228.3686471-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:YOfVpYdHYutSRnNrPihuD2wxMO1U+zy2Jt44j08qFN77H6Yxyby
 vvOATHmkOE6/YnKRv4EwDp3WU8jhbF/CYuy6bSeXqjM10PXk5tJwfaBXwbvp/pPpSmpV/eb
 PvfiilTATOSkuFBwvqYcCcNdckYj9YJuyIMI1T0YSMNFeAR7ooNQIU7VLf/iKucqXOR/h+c
 Wa/NqQBTu7X1UqQArTUOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ud+DpFk1e3Y=:JaGR7bpHQd9eTXmD/UCYvl
 lAwIvisDJtFubljNBXHIcEHz0UDt7bLvOSTo7BI5ObJHezHjcx4WrDKPJgWlGXUTjs3grYwvV
 2BQ91TQbW5m+VKv0tTnAVYHtLqAf3CrgLGOUuV7y6ofUagqUs8Q09Qw4LIrh3uekWBcqClSt+
 rk5Uy0THfsgtbOBzPlQmh4SM7BzXOwx0my1b7ZrC9U0DzEQ8m8eDiRAszVNVlrPcpujvGDZBc
 aZaRUfZjX2liJ9ZGoCb4ijjcBhhDMWP7fW0qwzoiTVFb4BolrWDEZImjesyn3+fVlhu4UFqeC
 /5h6rMPdii7A39IU+bdlOuMVfArjvCFOTGVJekO6KV7Z5jpdQuRkclZt39lL1oqrpehbc9BG+
 PkJ3lbRuX2mPWHlLmunmcoqJQhCeGk2UNFMydLlnk0hzVUdGi+ipKcdmcjhusQX4gNwtelul/
 3QiWXomPNxwxhbBDsxPFDgJEWWSqxP9pnWNeWfOev9dr50vRPMp9X5E1bAg1Crd7VAOyST8nW
 sGuwpmwzqwcnIskgIjDl3Yg9k7SQQUpm8asVdVX+0k2TKOw0DjOA+xQL6gV+jLGq38Kl1WgCw
 paYaT5hREJN1HTK4v1q4nHSPYvP6AXMkl/d+6IjTz4OVgWU9LPSwhxnjLizchLV+MfQGq/28W
 bT97GafF2nEOujfklKJCP78M87LmManqDOU1hQ0Lc8pU4gJmrrDn+jV6HdfZ5BaELPbI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bcache uses get_seconds() to read the current system time and store it in
the superblock as well as in uuid_entry structures that are user visible.

This changes over from the deprecated function to
ktime_get_real_seconds(), which returns a 64-bit timestamp as it
should. Unfortunately, the two structures are still limited to 32 bits,
so this won't fix any real problems. Let's at least document that
properly, in case we get an updated format in the future it can be
fixed. Until then, we still have some time, and checking the tools
at https://github.com/koverstreet/bcache-tools reveals no access to
any of them.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/md/bcache/super.c   | 23 +++++++++++++++++------
 include/uapi/linux/bcache.h |  4 ++--
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index fa4058e43202..aa9790ee5cb5 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -53,6 +53,17 @@ struct workqueue_struct *bcache_wq;
 /* limitation of bcache devices number on single system */
 #define BCACHE_DEVICE_IDX_MAX	((1U << MINORBITS)/BCACHE_MINORS)
 
+/*
+ * various timestamp fields in the superblock are unfortunately
+ * limited to 32 bits, which will lead to overflow in year 2106.
+ *
+ * If we ever get a new superblock format, that should be fixed.
+ */
+static inline u32 bcache_get_realtime32(void)
+{
+	return (u32)ktime_get_real_seconds();
+}
+
 /* Superblock */
 
 static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
@@ -181,7 +192,7 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 		goto err;
 	}
 
-	sb->last_mount = get_seconds();
+	sb->last_mount = bcache_get_realtime32();
 	err = NULL;
 
 	get_page(bh->b_page);
@@ -701,7 +712,7 @@ static void bcache_device_detach(struct bcache_device *d)
 
 		SET_UUID_FLASH_ONLY(u, 0);
 		memcpy(u->uuid, invalid_uuid, 16);
-		u->invalidated = cpu_to_le32(get_seconds());
+		u->invalidated = cpu_to_le32(bcache_get_realtime32());
 		bch_uuid_write(d->c);
 	}
 
@@ -1027,7 +1038,7 @@ void bch_cached_dev_detach(struct cached_dev *dc)
 int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
 			  uint8_t *set_uuid)
 {
-	uint32_t rtime = cpu_to_le32(get_seconds());
+	uint32_t rtime = cpu_to_le32(bcache_get_realtime32());
 	struct uuid_entry *u;
 	struct cached_dev *exist_dc, *t;
 
@@ -1070,7 +1081,7 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
 	    (BDEV_STATE(&dc->sb) == BDEV_STATE_STALE ||
 	     BDEV_STATE(&dc->sb) == BDEV_STATE_NONE)) {
 		memcpy(u->uuid, invalid_uuid, 16);
-		u->invalidated = cpu_to_le32(get_seconds());
+		u->invalidated = cpu_to_le32(bcache_get_realtime32());
 		u = NULL;
 	}
 
@@ -1390,7 +1401,7 @@ int bch_flash_dev_create(struct cache_set *c, uint64_t size)
 
 	get_random_bytes(u->uuid, 16);
 	memset(u->label, 0, 32);
-	u->first_reg = u->last_reg = cpu_to_le32(get_seconds());
+	u->first_reg = u->last_reg = cpu_to_le32(bcache_get_realtime32());
 
 	SET_UUID_FLASH_ONLY(u, 1);
 	u->sectors = size >> 9;
@@ -1894,7 +1905,7 @@ static void run_cache_set(struct cache_set *c)
 		goto err;
 
 	closure_sync(&cl);
-	c->sb.last_mount = get_seconds();
+	c->sb.last_mount = bcache_get_realtime32();
 	bcache_write_super(c);
 
 	list_for_each_entry_safe(dc, t, &uncached_devices, list)
diff --git a/include/uapi/linux/bcache.h b/include/uapi/linux/bcache.h
index 821f71a2e48f..8d19e02d752a 100644
--- a/include/uapi/linux/bcache.h
+++ b/include/uapi/linux/bcache.h
@@ -195,7 +195,7 @@ struct cache_sb {
 	};
 	};
 
-	__u32			last_mount;	/* time_t */
+	__u32			last_mount;	/* time overflow in y2106 */
 
 	__u16			first_bucket;
 	union {
@@ -318,7 +318,7 @@ struct uuid_entry {
 		struct {
 			__u8	uuid[16];
 			__u8	label[32];
-			__u32	first_reg;
+			__u32	first_reg; /* time overflow in y2106 */
 			__u32	last_reg;
 			__u32	invalidated;
 
-- 
2.9.0

