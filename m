Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ADEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302EC20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxiC52+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302EC20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502120AbeKWRNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 12:13:20 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46901 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbeKWRNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 12:13:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so10184526ply.13;
        Thu, 22 Nov 2018 22:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uuWGp3zyxbxME1Wt3RH1MzHgwfQA3oDGF/6E0Wn/XHs=;
        b=NxiC52+JhT5uAitoxh7+wVDsn7WRHkbO8aOTiK44XeqSTWi+H2Cu610WqquzLkmM2o
         kpzZMxK2EVaQ9ObUwW3pz5YB8fCQoFAeSAyp92a9pnhM8I9vto+rTpkAXIHrsbbqC66L
         iiPsIN4grZ52Amd1GR74MQcwdNU/2GnHuGoVVycqfWEK45NhlW8rfx98HRZyy0x7K3fh
         eDqtwtBvcVLgv0BZC7XVUn6FPMUmbN8i8T05EQydrEcdRb19kr2ElgSlDgpCktFrPbxP
         S9xu2Bxmr+jrKBFR6SZTGp/zmA3/O/vf3tY55nCgoO6MJUDOvUYpsa/vhX502Q9edSNs
         7TQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=uuWGp3zyxbxME1Wt3RH1MzHgwfQA3oDGF/6E0Wn/XHs=;
        b=ody9N1fok5K4x4D7KNTAFJGjn7xioA1yGusNbRWrrKB4cHol+afIgk+CMUesy3vbLh
         tnR6P4ADiZVavHkqVj39YQiR1yaMCdrRW0Uj2zlAYzCysmAcUmKcBQk1RUX0rD2egI4Z
         XvGRlvRZw49MgP+TPqxaiibeZ+WmV9yAXrz+cecUlUkBqn5RNlDVVliDJ53askvsDEqk
         pAlbkYFsaDbSE3U1o3NuaD5Zd1ZrEEn3hp5L/p5DelKoX6pIcTHdDth5HLiaQ54jTOGO
         EVWEAB+1X/Hpy1o/LRJCh45t7eOGYUKH5E/G4qRMoGjHOPlkN/qAQQNpzQNOAYPuTyZB
         j3cg==
X-Gm-Message-State: AA+aEWZHKb3EPAvzXXwcGrUvjysbShPj1dfLa5UwiGxsAfEfT2M81uIy
        O7ylAqThOnJcl/QrXUbPvmFdpW23rmw=
X-Google-Smtp-Source: AFSGD/WbWL9sL3TOvlxm5jB/TcaCD9S8CNzIrPPynZC2QZUw7WoeSps0ugOZ1HTIEMJbBkbE4PxFjQ==
X-Received: by 2002:a17:902:27e6:: with SMTP id i35mr11005759plg.222.1542954628965;
        Thu, 22 Nov 2018 22:30:28 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id m3sm79782357pgl.69.2018.11.22.22.30.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 22:30:28 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     stable@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, hare@suse.com,
        LKML <linux-kernel@vger.kernel.org>, sashal@kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Howard Chen <howardsoc@google.com>
Subject: [PATCH] [PATCH for v3.18] zram: close udev startup race condition as default groups
Date:   Fri, 23 Nov 2018 15:30:22 +0900
Message-Id: <20181123063022.228315-1-minchan@kernel.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181115174504.GJ95254@sasha-vm>
References: <20181115174504.GJ95254@sasha-vm>
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
 drivers/block/zram/zram_drv.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 7e94459a489a..5f4e6a3c2dde 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -999,6 +999,11 @@ static struct attribute_group zram_disk_attr_group = {
 	.attrs = zram_disk_attrs,
 };
 
+static const struct attribute_group *zram_disk_attr_groups[] = {
+	&zram_disk_attr_group,
+	NULL,
+};
+
 static int create_device(struct zram *zram, int device_id)
 {
 	int ret = -ENOMEM;
@@ -1060,22 +1065,14 @@ static int create_device(struct zram *zram, int device_id)
 		zram->disk->queue->limits.discard_zeroes_data = 0;
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, zram->disk->queue);
 
+	disk_to_dev(zram->disk)->groups = zram_disk_attr_groups;
 	add_disk(zram->disk);
 
-	ret = sysfs_create_group(&disk_to_dev(zram->disk)->kobj,
-				&zram_disk_attr_group);
-	if (ret < 0) {
-		pr_warn("Error creating sysfs group");
-		goto out_free_disk;
-	}
 	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
 	zram->meta = NULL;
 	zram->max_comp_streams = 1;
 	return 0;
 
-out_free_disk:
-	del_gendisk(zram->disk);
-	put_disk(zram->disk);
 out_free_queue:
 	blk_cleanup_queue(zram->queue);
 out:
@@ -1084,9 +1081,6 @@ static int create_device(struct zram *zram, int device_id)
 
 static void destroy_device(struct zram *zram)
 {
-	sysfs_remove_group(&disk_to_dev(zram->disk)->kobj,
-			&zram_disk_attr_group);
-
 	del_gendisk(zram->disk);
 	put_disk(zram->disk);
 
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

