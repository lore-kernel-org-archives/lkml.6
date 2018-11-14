Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147A1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61412146D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDecWQZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61412146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbeKNPyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 10:54:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44467 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeKNPyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 10:54:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id w3-v6so6831697pgs.11;
        Tue, 13 Nov 2018 21:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cnv2BYhx2P446x/N43NNt90NWKL2ZPUUyLhJSpz5LZQ=;
        b=UDecWQZkpbtX0pGPpgfc5d4KNFzcQUtQpHO/GDhAgtRXE8W3DXBvNnViL59qajQ2H6
         6S0Y129wI3MKlbExVYYOefxLCqlt867i6hBvMIIY/hv9lIzgOHZ2s16RsUX7csJtY3y7
         YbCjM1FtOqpKukylD7s4mtnM6I7IbQzNoSRFI9sRlPHjTqeIBuFE0Ohx+73sR2i6tMl4
         Pi2quhAUgJ60CRjOiLcpNwfj+qHJNy9HLpY/8mwZwTi1KHnwRzAQ1V2mirjlyvJEG9KH
         MRJqWHPNRX+xg+hqz9lV1psoIHojk2madh3mm89hDhye+bAs4sNB4bZJOVisqRxT/04s
         wH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=cnv2BYhx2P446x/N43NNt90NWKL2ZPUUyLhJSpz5LZQ=;
        b=raOJALgs6zZEfjYAHbSXRdvAVY16QV+pLH3jr4p59taR0uMso65MZjy1xXIH5UeRWf
         m7Ankue62XjYdg7UmeYj6y/7vFcZ0ZagHMPa6u772mRA94vntSPgMixs+boyjGbfpGUK
         HtG6vpBVeINeEB5KTZ3SVB0OlZjyDDlD/j/gvhn9EIqf2AF3lO7v8b54WdKCAq8svVNp
         A99XhQW0w5n+MTeX1/8WdUSvFGOwrsUcZfYQ1UDBngJoOo1hTvNNKWdVEE141fBxdku0
         SDegcdbwMZpqt8c22f2KY7g7K7WusfeLEAvMQZAC/DKTqo8a6o8vNlFbFFS3MExNaRQa
         H8tQ==
X-Gm-Message-State: AGRZ1gLYf7zuIoOrW3ReprfOd6BSDnHByYcF6ya+fkH9Y+2DmCWnou4z
        VEaScvcuWiU52PqdNTZJkf6UCCRB1Dc=
X-Google-Smtp-Source: AJdET5f6QlA+U8GBwmfbaUGXrJPMnmTAmlIcHSgfDjCLDrFkWNaNdSuDw1VLaXbLJweXr2N4WB14Og==
X-Received: by 2002:a63:6ac5:: with SMTP id f188mr517367pgc.165.1542174751890;
        Tue, 13 Nov 2018 21:52:31 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:7630:de9:f6f2:276f])
        by smtp.gmail.com with ESMTPSA id m10-v6sm43089502pfg.180.2018.11.13.21.52.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 21:52:30 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     stable@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hannes Reinecke <hare@suse.com>,
        Howard Chen <howardsoc@google.com>
Subject: [PATCH] zram: close udev startup race condition as default groups
Date:   Wed, 14 Nov 2018 14:52:23 +0900
Message-Id: <20181114055223.66476-1-minchan@kernel.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit fef912bf860e upstream.
commit 98af4d4df889 upstream.

I got a report from Howard Chen that he saw zram and sysfs race(ie,
zram block device file is created but sysfs for it isn't yet)
when he tried to create new zram devices via hotadd knob.

v4.20 kernel fixes it by [1, 2] but it's too large size to merge
into -stable so this patch fixes the problem by registering defualt
group by Greg KH's approach[3].

This patch should be applied to every stable tree [3.16+] currently
existing from kernel.org because the problem was introduced at 2.6.37
by [4].

[1] fef912bf860e, block: genhd: add 'groups' argument to device_add_disk
[2] 98af4d4df889, zram: register default groups with device_add_disk()
[3] http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/
[4] 33863c21e69e9, Staging: zram: Replace ioctls with sysfs interface

Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Hannes Reinecke <hare@suse.com>
Tested-by: Howard Chen <howardsoc@google.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a1d6b5597c17..66921427d109 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1636,6 +1636,11 @@ static const struct attribute_group zram_disk_attr_group = {
 	.attrs = zram_disk_attrs,
 };
 
+static const struct attribute_group *zram_disk_attr_groups[] = {
+	&zram_disk_attr_group,
+	NULL,
+};
+
 /*
  * Allocate and initialize new zram device. the function returns
  * '>= 0' device_id upon success, and negative value otherwise.
@@ -1716,24 +1721,15 @@ static int zram_add(void)
 
 	zram->disk->queue->backing_dev_info->capabilities |=
 			(BDI_CAP_STABLE_WRITES | BDI_CAP_SYNCHRONOUS_IO);
+	disk_to_dev(zram->disk)->groups = zram_disk_attr_groups;
 	add_disk(zram->disk);
 
-	ret = sysfs_create_group(&disk_to_dev(zram->disk)->kobj,
-				&zram_disk_attr_group);
-	if (ret < 0) {
-		pr_err("Error creating sysfs group for device %d\n",
-				device_id);
-		goto out_free_disk;
-	}
 	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
 
 	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
 	return device_id;
 
-out_free_disk:
-	del_gendisk(zram->disk);
-	put_disk(zram->disk);
 out_free_queue:
 	blk_cleanup_queue(queue);
 out_free_idr:
@@ -1762,16 +1758,6 @@ static int zram_remove(struct zram *zram)
 	mutex_unlock(&bdev->bd_mutex);
 
 	zram_debugfs_unregister(zram);
-	/*
-	 * Remove sysfs first, so no one will perform a disksize
-	 * store while we destroy the devices. This also helps during
-	 * hot_remove -- zram_reset_device() is the last holder of
-	 * ->init_lock, no later/concurrent disksize_store() or any
-	 * other sysfs handlers are possible.
-	 */
-	sysfs_remove_group(&disk_to_dev(zram->disk)->kobj,
-			&zram_disk_attr_group);
-
 	/* Make sure all the pending I/O are finished */
 	fsync_bdev(bdev);
 	zram_reset_device(zram);
-- 
2.19.1.930.g4563a0d9d0-goog

