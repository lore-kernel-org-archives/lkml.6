Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CA8C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD712238B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjF9ok55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD712238B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbeHIUhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:37:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42310 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeHIUhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:37:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so3208849pff.9;
        Thu, 09 Aug 2018 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iFWTvH5MPUVacum5DjJN+Ab+qJD2T9tCP90fDGvByTY=;
        b=KjF9ok55YzqvtxHShY9FQqeeM80Q6/niMME0dlEZNCNsdmjOxZhy9EuhesYXlBteyG
         40TWYLZSbrQt1lDZZRKg4xgUaD3rAyozBK/6qNLRrdVW94SpxWlKGsgeoKziv7gfj7eX
         MGPVkPULLrPFnHR9AA4k0a8E7gU5IYuO3rPOl7d5zRPyNZVVG7FizYuk6zMr/1UAIAag
         2MFzOxZT3NN1vUxjDVEVkZE/QxF27UOWizn3Utal0+8fYG59YJ/ArBA9W09szM7G18GL
         COsWp+HRhbgRMI4eeecoSKA5HbGsB/rZuKQDK9qVVbVtjjysbhdNV0V1Zi/ODkEaqjNw
         CWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=iFWTvH5MPUVacum5DjJN+Ab+qJD2T9tCP90fDGvByTY=;
        b=NvleE656Y2R7lcsxLdzNfGD0mMIg8zJBH/ulkmFJg/eHeaKFdMC4RUpgX8n5n7Gjuj
         7gwbeEtpZLKqd9UzD6A5Np0WSo+gJiDiZzkooRjoK7kMqtWH7NmBkt+e5ugtBvpP81O6
         QUky5NE4+U7lFwuRCwcYJWWA0BFS6BN+361RkXRlw1AvEKQ8TdsqGwnhGcO0OTGp2MqP
         Y9MjcttxSUGMbF6z7MgfjcyFp+8XQrZDT0TbBp70hZFcj6YlAwKYbhbuLSs6YFtucNQj
         gPeiTo2w26LhSuNtPdI43zGIJFifPWzvDUvwy6DGUF9/VzhchU+eXkDyGM34e4XkNfsA
         saDA==
X-Gm-Message-State: AOUpUlG9oG/gWYoaaFnjY1IB9vj5doGSwq28gie2tPGubJCXo/rQX8p1
        TTLppWi21ZIaLvM83DQMank=
X-Google-Smtp-Source: AA+uWPxkmkWqnq13HLCK3XmWcV1mQ9Z2NYKg6s5tUh0azi9ZEXbkhDfoocwQFdfEZJue9zPkJROIiw==
X-Received: by 2002:a63:fc0a:: with SMTP id j10-v6mr3135496pgi.1.1533838273018;
        Thu, 09 Aug 2018 11:11:13 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id z11-v6sm16325417pff.162.2018.08.09.11.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:11:12 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 02/12] btrfs-progs: utils: Introduce queue_param
Date:   Fri, 10 Aug 2018 03:10:55 +0900
Message-Id: <20180809181105.12856-2-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809181105.12856-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
 <20180809181105.12856-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the queue_param function to get a device request queue
parameter and this function to test if the device is an SSD in
is_ssd().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
[Naohiro] fixed error return value
Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 mkfs/main.c | 40 ++--------------------------------------
 utils.c     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 utils.h     |  1 +
 3 files changed, 49 insertions(+), 38 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index b76462a7..83969b4b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -435,49 +435,13 @@ static int zero_output_file(int out_fd, u64 size)
 
 static int is_ssd(const char *file)
 {
-	blkid_probe probe;
-	char wholedisk[PATH_MAX];
-	char sysfs_path[PATH_MAX];
-	dev_t devno;
-	int fd;
 	char rotational;
 	int ret;
 
-	probe = blkid_new_probe_from_filename(file);
-	if (!probe)
+	ret = queue_param(file, "rotational", &rotational, 1);
+	if (ret < 1)
 		return 0;
 
-	/* Device number of this disk (possibly a partition) */
-	devno = blkid_probe_get_devno(probe);
-	if (!devno) {
-		blkid_free_probe(probe);
-		return 0;
-	}
-
-	/* Get whole disk name (not full path) for this devno */
-	ret = blkid_devno_to_wholedisk(devno,
-			wholedisk, sizeof(wholedisk), NULL);
-	if (ret) {
-		blkid_free_probe(probe);
-		return 0;
-	}
-
-	snprintf(sysfs_path, PATH_MAX, "/sys/block/%s/queue/rotational",
-		 wholedisk);
-
-	blkid_free_probe(probe);
-
-	fd = open(sysfs_path, O_RDONLY);
-	if (fd < 0) {
-		return 0;
-	}
-
-	if (read(fd, &rotational, 1) < 1) {
-		close(fd);
-		return 0;
-	}
-	close(fd);
-
 	return rotational == '0';
 }
 
diff --git a/utils.c b/utils.c
index d4395b1f..2212692c 100644
--- a/utils.c
+++ b/utils.c
@@ -65,6 +65,52 @@ static unsigned short rand_seed[3];
 
 struct btrfs_config bconf;
 
+/*
+ * Get a device request queue parameter.
+ */
+int queue_param(const char *file, const char *param, char *buf, size_t len)
+{
+	blkid_probe probe;
+	char wholedisk[PATH_MAX];
+	char sysfs_path[PATH_MAX];
+	dev_t devno;
+	int fd;
+	int ret;
+
+	probe = blkid_new_probe_from_filename(file);
+	if (!probe)
+		return 0;
+
+	/* Device number of this disk (possibly a partition) */
+	devno = blkid_probe_get_devno(probe);
+	if (!devno) {
+		blkid_free_probe(probe);
+		return 0;
+	}
+
+	/* Get whole disk name (not full path) for this devno */
+	ret = blkid_devno_to_wholedisk(devno,
+			wholedisk, sizeof(wholedisk), NULL);
+	if (ret) {
+		blkid_free_probe(probe);
+		return 0;
+	}
+
+	snprintf(sysfs_path, PATH_MAX, "/sys/block/%s/queue/%s",
+		 wholedisk, param);
+
+	blkid_free_probe(probe);
+
+	fd = open(sysfs_path, O_RDONLY);
+	if (fd < 0)
+		return 0;
+
+	len = read(fd, buf, len);
+	close(fd);
+
+	return len;
+}
+
 /*
  * Discard the given range in one go
  */
diff --git a/utils.h b/utils.h
index b6c00cfa..ac333095 100644
--- a/utils.h
+++ b/utils.h
@@ -120,6 +120,7 @@ int get_label(const char *btrfs_dev, char *label);
 int set_label(const char *btrfs_dev, const char *label);
 
 char *__strncpy_null(char *dest, const char *src, size_t n);
+int queue_param(const char *file, const char *param, char *buf, size_t len);
 int is_block_device(const char *file);
 int is_mount_point(const char *file);
 int is_path_exist(const char *file);
-- 
2.18.0

