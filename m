Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C942C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AB72238B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJdf5T0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AB72238B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbeHIUhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:37:22 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:34879 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbeHIUhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:37:22 -0400
Received: by mail-pf1-f177.google.com with SMTP id p12-v6so3228298pfh.2;
        Thu, 09 Aug 2018 11:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vEgVkYKjembb7998doR0VHcTdu4uilIeK4V2QI2Qgx4=;
        b=tJdf5T0KC1vyfXTtLja5K0aym0G+xycjFXFhvpvA/UkLBLPJ1QsZe+vxXfCP5Z6RjW
         Y2YWT+qbYJuQnX0buPciVnKIaXpQSi6sVXRLg6iOO84ebyYThkvR3wMNPkuN1Zom07s4
         jl5ctIsiS++VKWh4y18ctDbQuBpDeppeG+uNMIyr+55ze6IfnvzBcrPq7rCvLnVclViG
         4azPNF58ol1yvPyZikE8ttnIuFWSAmu6EtVaTOgWBBpKv7/XCXDNjjDhywfkZSCMjdys
         thBSsw8U+y412/NgT5h6MiB0c6OeTsNy8gQxlUUiN+M31VOn8nlnCNdik0tJwaPpDsyl
         3n3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=vEgVkYKjembb7998doR0VHcTdu4uilIeK4V2QI2Qgx4=;
        b=s9cDBqfsud2XrTsjPuxAi/jF262R72l6xmRlYqfXr0vSBFNm1IZF8oKY/S/ciTL1qG
         LREvAmo7nAAPxyFTLmXPgWhu/UTpLF5gZzMn0GSe8k+XKWobAHg9Emjwu9xPRk40OCtt
         VMIJQ68VXRmIVqYSe2wPIKlZPE+9VXboqqJNVWdOH9th+J0mBSZbr7M3nlJMMiblbrIT
         iGcOhgQYtOo7Y3DcDcqpvz3fHDw/PxA7gtX/EugWiI+k8rpZ7ijx+HkdCb5W2C3Qb4Mi
         bnwAbrlOK3y7sp1YgA+PHrjD6bD7huY8Q+pVSUOYgNM2SY+wr3S2RuG74d+EVZ1n7yRY
         9bBg==
X-Gm-Message-State: AOUpUlGJZMgcrLlmHUVfS4zWOvtJMiAQ/z7kf969vkp/0GMkpz1c/qUf
        sA5YCtnmhvtKlZ5GsGn201fQ8APSDb4=
X-Google-Smtp-Source: AA+uWPwYqci3E8ZLxZUMAa3To3x5DUp2vi3v19eKUaRwR3dkP1R9xE+wqL1HSwlhroLv9WtVITGVnw==
X-Received: by 2002:a62:998:: with SMTP id 24-v6mr3386794pfj.99.1533838281287;
        Thu, 09 Aug 2018 11:11:21 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id 87-v6sm15442992pfn.103.2018.08.09.11.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:11:20 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 05/12] btrfs-progs: load and check zone information
Date:   Fri, 10 Aug 2018 03:10:58 +0900
Message-Id: <20180809181105.12856-5-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809181105.12856-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
 <20180809181105.12856-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch checks if a device added to btrfs is a zoned block device. If it
is, load zones information and the zone size for the device.

For a btrfs volume composed of multiple zoned block devices, all devices
must have the same zone size.

Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 utils.c   | 10 ++++++++++
 volumes.c | 18 ++++++++++++++++++
 volumes.h |  3 +++
 3 files changed, 31 insertions(+)

diff --git a/utils.c b/utils.c
index 71fc044a..a2172a82 100644
--- a/utils.c
+++ b/utils.c
@@ -250,6 +250,16 @@ int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
+	ret = btrfs_get_zone_info(fd, path, fs_info->fs_devices->hmzoned,
+				  &device->zinfo);
+	if (ret)
+		goto out;
+	if (device->zinfo.zone_size != fs_info->fs_devices->zone_size) {
+		error("Device zone size differ\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	disk_super = (struct btrfs_super_block *)buf;
 	dev_item = &disk_super->dev_item;
 
diff --git a/volumes.c b/volumes.c
index d81b348e..2ec27cd7 100644
--- a/volumes.c
+++ b/volumes.c
@@ -160,6 +160,8 @@ static int device_list_add(const char *path,
 	struct btrfs_device *device;
 	struct btrfs_fs_devices *fs_devices;
 	u64 found_transid = btrfs_super_generation(disk_super);
+	int hmzoned = btrfs_super_incompat_flags(disk_super) &
+			BTRFS_FEATURE_INCOMPAT_HMZONED;
 
 	fs_devices = find_fsid(disk_super->fsid);
 	if (!fs_devices) {
@@ -237,6 +239,8 @@ static int device_list_add(const char *path,
 	if (fs_devices->lowest_devid > devid) {
 		fs_devices->lowest_devid = devid;
 	}
+	if (hmzoned)
+		fs_devices->hmzoned = 1;
 	*fs_devices_ret = fs_devices;
 	return 0;
 }
@@ -307,6 +311,8 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices, int flags)
 	struct btrfs_device *device;
 	int ret;
 
+	fs_devices->zone_size = 0;
+
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
 		if (!device->name) {
 			printk("no name for device %llu, skip it now\n", device->devid);
@@ -330,6 +336,18 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices, int flags)
 		device->fd = fd;
 		if (flags & O_RDWR)
 			device->writeable = 1;
+
+		ret = btrfs_get_zone_info(fd, device->name, fs_devices->hmzoned,
+					  &device->zinfo);
+		if (ret != 0)
+			goto fail;
+		if (!fs_devices->zone_size) {
+			fs_devices->zone_size = device->zinfo.zone_size;
+		} else if (device->zinfo.zone_size != fs_devices->zone_size) {
+			fprintf(stderr, "Device zone size differ\n");
+			ret = -EINVAL;
+			goto fail;
+		}
 	}
 	return 0;
 fail:
diff --git a/volumes.h b/volumes.h
index bad688e5..36a6f44b 100644
--- a/volumes.h
+++ b/volumes.h
@@ -111,6 +111,9 @@ struct btrfs_fs_devices {
 
 	int seeding;
 	struct btrfs_fs_devices *seed;
+
+	u64 zone_size;
+	unsigned int hmzoned:1;
 };
 
 struct btrfs_bio_stripe {
-- 
2.18.0

