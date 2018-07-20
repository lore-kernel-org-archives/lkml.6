Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85777ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A28A20833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nb+T2WHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A28A20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeGTEgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:36:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35540 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbeGTEgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:36:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6-v6so5625735pgv.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 20:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ICWsjYubSa0j/x7U/enMvHlcR+YgNoexYltxLyjpTUQ=;
        b=Nb+T2WHVli63EjsnWKL7lE/qH7GIL1BTIcEp18NI8Q0gfHEB6zRlmP/OPuUMolBcRO
         AhFLYIvOsBaDhaRvPHOOfbrnD8ZX4XeTYCTLc9Anh6IEvIBz/Xt2WZY4NVGOryawaq1C
         8fk8XvDVJ7yottjLScf6utXGFdj1rXXpPA0pW7++7k3CiWac63E735HJtlZ4fOKYbt4n
         UcRbzN+tDfb17twLnGc9MoaUyqhXb2AcRNoMIwdD4IlQ9fOrwl8vgRU6DuSJYVSGC362
         NmIXj/zsEqckFL4G/LdjbPwZtSExgGoyCrX9aY62jPuMpKX1mj6CIKss1g9aL9kbdUDI
         Jndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ICWsjYubSa0j/x7U/enMvHlcR+YgNoexYltxLyjpTUQ=;
        b=abNqiGhv6J/+wqPhMX+RUxI0QXLUCORZWnZ7VeP7iLG7IzHm33vh5vi9AMb9+0dd9J
         f09resB8nUMpPqaXTOfaB5YYX38WahAcT5wIXX69qEaSlgR3j8voI36iRIM+lEr0KBwA
         C5XiHjnwu7VjQUjvD+nX7vBOtMroN7EJKRLN5BDHoe9w5iYnUAgsR9EAcgjxrRSH7OKm
         UfPrChl7vTUxKbhrfUuzp7jNJ2HHkJ4IpkoAmvpUTolrJoj+8ygRdPHGXWJLxRlMJcuG
         z8MEOLpa2r4ogBbA3HAajA6M+XA91s4fewY1B+9OiTrbR+8DHDxs9G8/u+oEIUEIbWgX
         Crzw==
X-Gm-Message-State: AOUpUlFuNBf3Jo1t3PShyI+RR8+qD7n+l8XQFnAZpXt8Vv0ohMVGRY1Y
        pF6XnziLrstRdGRnnG/JPBQ=
X-Google-Smtp-Source: AAOMgpc+pA8HgzR6Dso3+eVY9kVPTSGRJcj07A7fFa4gvnvZwlg9EQ93BRVW+6EorXNOLmJgav203A==
X-Received: by 2002:a65:60cf:: with SMTP id r15-v6mr425617pgv.41.1532058604312;
        Thu, 19 Jul 2018 20:50:04 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id x66-v6sm864255pff.123.2018.07.19.20.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 20:50:03 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 16/20] staging: gasket: always allow root open for write
Date:   Thu, 19 Jul 2018 20:49:16 -0700
Message-Id: <20180720034920.77320-17-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180720034920.77320-1-toddpoynor@gmail.com>
References: <20180720034920.77320-1-toddpoynor@gmail.com>
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

