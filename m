Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA9FECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9FF20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVYNAzFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9FF20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387748AbeGUNul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:41 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46266 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbeGUNul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:41 -0400
Received: by mail-pl0-f66.google.com with SMTP id t17-v6so3780071ply.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ICWsjYubSa0j/x7U/enMvHlcR+YgNoexYltxLyjpTUQ=;
        b=cVYNAzFavQXGDgTX9JslFifilg+QlPTq9Okx57yYA3g5hmiGRjIr7vH7ZHufMRo93P
         zZLxzFVEUIoYhF5x9ymV8WRtiGWQa0vNLwZoHe0EdEL0KBed6bdenZz4OxJN7HTWpLEe
         YBce4Kw3c3//w6BK4EohKZkAQ6hIv9YB/CUfImrw6kzNEbt6KQlEKGxAUtPC7udG6XkL
         LBgdYle/gWZwQWIp/E9wKEbEvcVb8HvEonMbuJ7uXJPy49UYX1hgfQUpqRa7HOltBmGd
         LhxQv99jH2k8UZdp6gKmKy2A4bb9qQ4Mixw9DLvo/Z793C6vYMuBBAYAvqRR+yL2DkuU
         mpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ICWsjYubSa0j/x7U/enMvHlcR+YgNoexYltxLyjpTUQ=;
        b=g/HD0b1Mt2TjzBDsxJQnH3E+S/BfyibmYIO6BUICzY8Y/Jw88zC1MPnuJI310cZhii
         2aLNlKZHXqkp+/0BFnZ3R3rA75j8pXly5HV45/Z4yDckoj3VV3TozT/bHmRu2E2l7kC8
         IMJT0KOILDGbMn+g/WQAW8vHuTgWuaP2rvealcnPtQB0lO+4rb3IZyVBT+fL8UDa1Rw3
         1y3DautAEFRbc8qAx1CbzasaUYY7XJAm0n2Z1fIQw8TUQ1o+lzqMGPK8JDe10R7DhMfB
         JpIwhe0xE8sAgdhOJ4RyGuT2dsqVHsgB7q4tPpC3kmDz27o4g+Xq5scvSwqmhGRi83jD
         dk8Q==
X-Gm-Message-State: AOUpUlFR9k+uJkUw8mMa13rQ0LlvgppgEX7cZ8y29iYFvc6Y67K9kFgS
        63hCo8QEHctc3lATL8rx8iRJ3vsHo+I=
X-Google-Smtp-Source: AAOMgpdAOi85c9qfAvTsFWIsaeOqehLe+BVurMO68UKsfNnHK9sqSUKB+EJ45JFg02dEF/zuWmNsWg==
X-Received: by 2002:a17:902:e18b:: with SMTP id cd11-v6mr5628599plb.305.1532177880736;
        Sat, 21 Jul 2018 05:58:00 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:58:00 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 16/20] staging: gasket: always allow root open for write
Date:   Sat, 21 Jul 2018 05:57:09 -0700
Message-Id: <20180721125713.88501-31-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Always allow root to open device for writing.

Drop special-casing of ioctl permissions for root vs. owner.

Convert to bool types as appropriate.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c  | 15 ++++----------
 drivers/staging/gasket/gasket_core.c  |  8 ++++---
 drivers/staging/gasket/gasket_ioctl.c | 30 +++++++++++++--------------
 3 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index a01b1f2b827ea..4c00f3609f081 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -140,7 +140,7 @@ static int apex_reset(struct gasket_dev *gasket_dev, uint type);
 
 static int apex_get_status(struct gasket_dev *gasket_dev);
 
-static uint apex_ioctl_check_permissions(struct file *file, uint cmd);
+static bool apex_ioctl_check_permissions(struct file *file, uint cmd);
 
 static long apex_ioctl(struct file *file, uint cmd, ulong arg);
 
@@ -625,18 +625,11 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
  * @file: File pointer from ioctl.
  * @cmd: ioctl command.
  *
- * Returns 1 if the current user may execute this ioctl, and 0 otherwise.
+ * Returns true if the current user may execute this ioctl, and false otherwise.
  */
-static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)
+static bool apex_ioctl_check_permissions(struct file *filp, uint cmd)
 {
-	struct gasket_dev *gasket_dev = filp->private_data;
-	int root = capable(CAP_SYS_ADMIN);
-	int is_owner = gasket_dev->dev_info.ownership.is_owned &&
-		       current->tgid == gasket_dev->dev_info.ownership.owner;
-
-	if (root || is_owner)
-		return 1;
-	return 0;
+	return !!(filp->f_mode & FMODE_WRITE);
 }
 
 /*
diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index ba48a379b0ada..254fb392c05c1 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1072,6 +1072,7 @@ static int gasket_open(struct inode *inode, struct file *filp)
 	char task_name[TASK_COMM_LEN];
 	struct gasket_cdev_info *dev_info =
 	    container_of(inode->i_cdev, struct gasket_cdev_info, cdev);
+	int is_root = capable(CAP_SYS_ADMIN);
 
 	gasket_dev = dev_info->gasket_dev_ptr;
 	driver_desc = gasket_dev->internal_desc->driver_desc;
@@ -1085,7 +1086,7 @@ static int gasket_open(struct inode *inode, struct file *filp)
 		"Attempting to open with tgid %u (%s) (f_mode: 0%03o, "
 		"fmode_write: %d is_root: %u)",
 		current->tgid, task_name, filp->f_mode,
-		(filp->f_mode & FMODE_WRITE), capable(CAP_SYS_ADMIN));
+		(filp->f_mode & FMODE_WRITE), is_root);
 
 	/* Always allow non-writing accesses. */
 	if (!(filp->f_mode & FMODE_WRITE)) {
@@ -1099,8 +1100,9 @@ static int gasket_open(struct inode *inode, struct file *filp)
 		gasket_dev, "Current owner open count (owning tgid %u): %d.",
 		ownership->owner, ownership->write_open_count);
 
-	/* Opening a node owned by another TGID is an error (even root.) */
-	if (ownership->is_owned && ownership->owner != current->tgid) {
+	/* Opening a node owned by another TGID is an error (unless root) */
+	if (ownership->is_owned && ownership->owner != current->tgid &&
+	    !is_root) {
 		gasket_log_error(
 			gasket_dev,
 			"Process %u is opening a node held by %u.",
diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index d0142ed048a65..8fd44979fe713 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -22,7 +22,7 @@
 #define trace_gasket_ioctl_config_coherent_allocator(x, ...)
 #endif
 
-static uint gasket_ioctl_check_permissions(struct file *filp, uint cmd);
+static bool gasket_ioctl_check_permissions(struct file *filp, uint cmd);
 static int gasket_set_event_fd(struct gasket_dev *dev, ulong arg);
 static int gasket_read_page_table_size(
 	struct gasket_dev *gasket_dev, ulong arg);
@@ -167,12 +167,13 @@ long gasket_is_supported_ioctl(uint cmd)
  * @filp: File structure pointer describing this node usage session.
  * @cmd: ioctl number to handle.
  *
- * Standard permissions checker.
+ * Check permissions for Gasket ioctls.
+ * Returns true if the file opener may execute this ioctl, or false otherwise.
  */
-static uint gasket_ioctl_check_permissions(struct file *filp, uint cmd)
+static bool gasket_ioctl_check_permissions(struct file *filp, uint cmd)
 {
-	uint alive, root, device_owner;
-	fmode_t read, write;
+	bool alive;
+	bool read, write;
 	struct gasket_dev *gasket_dev = (struct gasket_dev *)filp->private_data;
 
 	alive = (gasket_dev->status == GASKET_STATUS_ALIVE);
@@ -183,36 +184,33 @@ static uint gasket_ioctl_check_permissions(struct file *filp, uint cmd)
 			alive, gasket_dev->status);
 	}
 
-	root = capable(CAP_SYS_ADMIN);
-	read = filp->f_mode & FMODE_READ;
-	write = filp->f_mode & FMODE_WRITE;
-	device_owner = (gasket_dev->dev_info.ownership.is_owned &&
-			current->tgid == gasket_dev->dev_info.ownership.owner);
+	read = !!(filp->f_mode & FMODE_READ);
+	write = !!(filp->f_mode & FMODE_WRITE);
 
 	switch (cmd) {
 	case GASKET_IOCTL_RESET:
 	case GASKET_IOCTL_CLEAR_INTERRUPT_COUNTS:
-		return root || (write && device_owner);
+		return write;
 
 	case GASKET_IOCTL_PAGE_TABLE_SIZE:
 	case GASKET_IOCTL_SIMPLE_PAGE_TABLE_SIZE:
 	case GASKET_IOCTL_NUMBER_PAGE_TABLES:
-		return root || read;
+		return read;
 
 	case GASKET_IOCTL_PARTITION_PAGE_TABLE:
 	case GASKET_IOCTL_CONFIG_COHERENT_ALLOCATOR:
-		return alive && (root || (write && device_owner));
+		return alive && write;
 
 	case GASKET_IOCTL_MAP_BUFFER:
 	case GASKET_IOCTL_UNMAP_BUFFER:
-		return alive && (root || (write && device_owner));
+		return alive && write;
 
 	case GASKET_IOCTL_CLEAR_EVENTFD:
 	case GASKET_IOCTL_SET_EVENTFD:
-		return alive && (root || (write && device_owner));
+		return alive && write;
 	}
 
-	return 0; /* unknown permissions */
+	return false; /* unknown permissions */
 }
 
 /*
-- 
2.18.0.233.g985f88cf7e-goog

