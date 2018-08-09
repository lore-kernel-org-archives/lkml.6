Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50458C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CFC21F45
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyywPLru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CFC21F45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeHIUbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:31:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37991 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeHIUbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:31:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3-v6so3109318pgq.5;
        Thu, 09 Aug 2018 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RxBZVjs9DKEE5urK9kJMhOdrn6rSAMZwDy+4LM1RfYU=;
        b=KyywPLruD/2o8acM8tiuuGm7rxGmX3tSiZVOwhibnOoa0/3PzunAUHByySH6b089NI
         0dck4E+4s6cSubdq47QP2FsmWNDNwPlgJiXBA1lbFdlOw6SS/+CyzU9nPllybQLdwRnj
         fwOSu0fkBRifHe0fGcjALkPxyP+qqiEZWhW1TjIVN1XeHVPEvdMCOS80SqU0ufYc/Y1c
         ytRCtN7H3xTVAb+fKqmst9Fk/tTfQhJAa6Rjk9AwsvQG1JS60KMefeoDGuFGqriaHNUP
         K46puXV0CJfDqCNkLF9JMQBssBLmUcMd77BJpzXF0dpdUBCnn2WjOBOOLWzeQF0GNNhR
         RtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=RxBZVjs9DKEE5urK9kJMhOdrn6rSAMZwDy+4LM1RfYU=;
        b=bEsfJlnUOe2g7w+RNa5NSuDzrW3fyrfjqvl57MwIGV3CZtMf7xGpFXxpXKBeWzdv7L
         1LRf3EZ2Jx7LCCBpjzEJDN0sXMqqV4lWjtvyiPnVYcJMY2AXuxErNQtXoQCvkr5LXpEC
         Cr0TYbpKZC8ymiJgXXlzZvlSq9WyGV1qUQmdc3/3TSqR9yzdaytBt+JHXdJqQ8r9NDca
         ibkpSEK5P84MVV2uNB9sh5ftKNAhMIbS+3iIG8vFk8QiKqYqH1sDP+noBboEAjXXVVs7
         Kyi9ODdxsAJWUAq6tjQih9ZxKDBakUDiKybjSk3WPskV3am6mdKCxs4Ri8U6LWL7d+BK
         YhPg==
X-Gm-Message-State: AOUpUlH8sx9YBlERTjVLeBJw5bHydFFSr702qAY5xJiCVrcIdGxj5z8c
        /3/Bwp2P5MhtfxxSvI1W7Io=
X-Google-Smtp-Source: AA+uWPyd8xIz5Y05wbBfVXI/xy3fpBaX5sCf59Ymvp6qcsHVhJkcfRypBg4LeXTSJ180eDWNnlEuHQ==
X-Received: by 2002:a63:8341:: with SMTP id h62-v6mr3045228pge.298.1533837953131;
        Thu, 09 Aug 2018 11:05:53 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id k1-v6sm9503724pfi.62.2018.08.09.11.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:05:52 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 02/17] btrfs: Get zone information of zoned block devices
Date:   Fri, 10 Aug 2018 03:04:35 +0900
Message-Id: <20180809180450.5091-3-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809180450.5091-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a zoned block device is found, get its zone information (number of zones
and zone size) using the new helper function btrfs_get_dev_zone().  To
avoid costly run-time zone reports commands to test the device zones type
during block allocation, attach the seqzones bitmap to the device structure
to indicate if a zone is sequential or accept random writes.

This patch also introduces the helper function btrfs_dev_is_sequential() to
test if the zone storing a block is a sequential write required zone.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 fs/btrfs/volumes.c | 146 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  32 ++++++++++
 2 files changed, 178 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index da86706123ff..35b3a2187653 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -677,6 +677,134 @@ static void btrfs_free_stale_devices(const char *path,
 	}
 }
 
+static int __btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
+				 struct blk_zone **zones,
+				 unsigned int *nr_zones, gfp_t gfp_mask)
+{
+	struct blk_zone *z = *zones;
+	int ret;
+
+	if (!z) {
+		z = kcalloc(*nr_zones, sizeof(struct blk_zone), GFP_KERNEL);
+		if (!z)
+			return -ENOMEM;
+	}
+
+	ret = blkdev_report_zones(device->bdev, pos >> 9,
+				  z, nr_zones, gfp_mask);
+	if (ret != 0) {
+		pr_err("BTRFS: Get zone at %llu failed %d\n",
+		       pos, ret);
+		return ret;
+	}
+
+	*zones = z;
+
+	return 0;
+}
+
+static void btrfs_drop_dev_zonetypes(struct btrfs_device *device)
+{
+	kfree(device->seq_zones);
+	kfree(device->empty_zones);
+	device->seq_zones = NULL;
+	device->empty_zones = NULL;
+	device->nr_zones = 0;
+	device->zone_size = 0;
+	device->zone_size_shift = 0;
+}
+
+int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
+		       struct blk_zone *zone, gfp_t gfp_mask)
+{
+	unsigned int nr_zones = 1;
+	int ret;
+
+	ret = __btrfs_get_dev_zones(device, pos, &zone, &nr_zones, gfp_mask);
+	if (ret != 0 || !nr_zones)
+		return ret ? ret : -EIO;
+
+	return 0;
+}
+
+static int btrfs_get_dev_zonetypes(struct btrfs_device *device)
+{
+	struct block_device *bdev = device->bdev;
+	sector_t nr_sectors = bdev->bd_part->nr_sects;
+	sector_t sector = 0;
+	struct blk_zone *zones = NULL;
+	unsigned int i, n = 0, nr_zones;
+	int ret;
+
+	device->zone_size = 0;
+	device->zone_size_shift = 0;
+	device->nr_zones = 0;
+	device->seq_zones = NULL;
+	device->empty_zones = NULL;
+
+	if (!bdev_is_zoned(bdev))
+		return 0;
+
+	device->zone_size = (u64)bdev_zone_sectors(bdev) << 9;
+	device->zone_size_shift = ilog2(device->zone_size);
+	device->nr_zones = nr_sectors >> ilog2(bdev_zone_sectors(bdev));
+	if (nr_sectors & (bdev_zone_sectors(bdev) - 1))
+		device->nr_zones++;
+
+	device->seq_zones = kcalloc(BITS_TO_LONGS(device->nr_zones),
+				    sizeof(*device->seq_zones), GFP_KERNEL);
+	if (!device->seq_zones)
+		return -ENOMEM;
+
+	device->empty_zones = kcalloc(BITS_TO_LONGS(device->nr_zones),
+				      sizeof(*device->empty_zones), GFP_KERNEL);
+	if (!device->empty_zones)
+		return -ENOMEM;
+
+#define BTRFS_REPORT_NR_ZONES   4096
+
+	/* Get zones type */
+	while (sector < nr_sectors) {
+		nr_zones = BTRFS_REPORT_NR_ZONES;
+		ret = __btrfs_get_dev_zones(device, sector << 9,
+					    &zones, &nr_zones, GFP_KERNEL);
+		if (ret != 0 || !nr_zones) {
+			if (!ret)
+				ret = -EIO;
+			goto out;
+		}
+
+		for (i = 0; i < nr_zones; i++) {
+			if (zones[i].type == BLK_ZONE_TYPE_SEQWRITE_REQ)
+				set_bit(n, device->seq_zones);
+			if (zones[i].cond == BLK_ZONE_COND_EMPTY)
+				set_bit(n, device->empty_zones);
+			sector = zones[i].start + zones[i].len;
+			n++;
+		}
+	}
+
+	if (n != device->nr_zones) {
+		pr_err("BTRFS: Inconsistent number of zones (%u / %u)\n",
+		       n, device->nr_zones);
+		ret = -EIO;
+		goto out;
+	}
+
+	pr_info("BTRFS: host-%s zoned block device, %u zones of %llu sectors\n",
+		bdev_zoned_model(bdev) == BLK_ZONED_HM ? "managed" : "aware",
+		device->nr_zones, device->zone_size >> 9);
+
+out:
+	kfree(zones);
+
+	if (ret)
+		btrfs_drop_dev_zonetypes(device);
+
+	return ret;
+}
+
+
 static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 			struct btrfs_device *device, fmode_t flags,
 			void *holder)
@@ -726,6 +854,13 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	device->mode = flags;
 
+	/* Get zone type information of zoned block devices */
+	if (bdev_is_zoned(bdev)) {
+		ret = btrfs_get_dev_zonetypes(device);
+		if (ret != 0)
+			goto error_brelse;
+	}
+
 	fs_devices->open_devices++;
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
 	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
@@ -1012,6 +1147,7 @@ static void btrfs_close_bdev(struct btrfs_device *device)
 	}
 
 	blkdev_put(device->bdev, device->mode);
+	btrfs_drop_dev_zonetypes(device);
 }
 
 static void btrfs_close_one_device(struct btrfs_device *device)
@@ -2439,6 +2575,15 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	mutex_unlock(&fs_info->chunk_mutex);
 	mutex_unlock(&fs_devices->device_list_mutex);
 
+	/* Get zone type information of zoned block devices */
+	if (bdev_is_zoned(bdev)) {
+		ret = btrfs_get_dev_zonetypes(device);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto error_sysfs;
+		}
+	}
+
 	if (seeding_dev) {
 		mutex_lock(&fs_info->chunk_mutex);
 		ret = init_first_rw_device(trans, fs_info);
@@ -2504,6 +2649,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	return ret;
 
 error_sysfs:
+	btrfs_drop_dev_zonetypes(device);
 	btrfs_sysfs_rm_device_link(fs_devices, device);
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	mutex_lock(&fs_info->chunk_mutex);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 23e9285d88de..13d59bff204f 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -61,6 +61,16 @@ struct btrfs_device {
 
 	struct block_device *bdev;
 
+	/*
+	 * Number of zones, zone size and types of zones if bdev is a
+	 * zoned block device.
+	 */
+	u64 zone_size;
+	u8  zone_size_shift;
+	u32 nr_zones;
+	unsigned long *seq_zones;
+	unsigned long *empty_zones;
+
 	/* the mode sent to blkdev_get */
 	fmode_t mode;
 
@@ -404,6 +414,8 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			   int mirror_num, int async_submit);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       fmode_t flags, void *holder);
+int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
+		       struct blk_zone *zone, gfp_t gfp_mask);
 struct btrfs_device *btrfs_scan_one_device(const char *path,
 					   fmode_t flags, void *holder);
 int btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
@@ -466,6 +478,26 @@ int btrfs_finish_chunk_alloc(struct btrfs_trans_handle *trans,
 			     u64 chunk_offset, u64 chunk_size);
 int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset);
 
+static inline int btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
+{
+	unsigned int zno = pos >> device->zone_size_shift;
+
+	if (!device->seq_zones)
+		return 1;
+
+	return test_bit(zno, device->seq_zones);
+}
+
+static inline int btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
+{
+	unsigned int zno = pos >> device->zone_size_shift;
+
+	if (!device->empty_zones)
+		return 0;
+
+	return test_bit(zno, device->empty_zones);
+}
+
 static inline void btrfs_dev_stat_inc(struct btrfs_device *dev,
 				      int index)
 {
-- 
2.18.0

