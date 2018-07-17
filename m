Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DB0ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1F820693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1zKupwq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1F820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbeGQVlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:41:07 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37999 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbeGQVjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:31 -0400
Received: by mail-pf0-f193.google.com with SMTP id v15-v6so1094277pff.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lt4Al/A0AbUkNLGynNdtVIyxo0uerKGNKJ4IDKBLEIo=;
        b=T1zKupwq1ebHb3Z0VnOyJoD4YaU0lLGYT0/LKdgmktB1xM/PgI0fuZo+v9iecDFHTt
         LiTxMGw6RiY7niMueTWK26bEFYM7W1a0Mh2buo5TgUunH0V1VKhCEd9qZ203hLUx4Hvi
         2TA/uMOsFWfDWzhRFpt10OlnIv9e3JjfatGgJPTp6hjmn3oXywwqYhEjr+4PqO5DCHpN
         Yns2NSUIv1bR+ly81KbpEBvO5QPbKZAfeEZLCV9uzq00arVz/L4iOOZeDGsOuZ1iATjy
         mgEanWYv5gDEsr5cs6dL0hlDQVWWLp+MQq7NNOlYtS4IOPLMP+bmAk9+Cuz30qEArw07
         3Duw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lt4Al/A0AbUkNLGynNdtVIyxo0uerKGNKJ4IDKBLEIo=;
        b=If1hJB3Q/1usS6xz5ri6QaobzamVHQuJqnub+8IcfRMLUJnq2tA3lgxYcX4cvQPzuA
         TQG23qWXOV/AT3/ueifCUIFqNA09MOR7CCFzgA71YnUZwH4tIMLmbmZ9RraGiz4DLlE1
         rTJC2dUkOY1FfkjPp0KfpJK2/da4fZwAFrHSHz//XlfRKRyjFQWgEuJrfsVvOc2QHG7r
         bIXxcCZv2CKOQxQNqchwYtGKIquCL+pnnSTUATAntQ9gY0QF2XagI99ZAWsXn7J9HxiV
         qq5RUn+NIJv/CTPn4SovwfX8EsHtRBo4KP2uZoTObwlScb324gssIJf8prXb7YIS91Na
         LsDA==
X-Gm-Message-State: AOUpUlHxkUA/buCE/581BDk3276C/1LCmftHl77lTY8ZwpK+ZdL35pi4
        Rk8UnpYzyEj/C7q/gHMGac9WO+dq
X-Google-Smtp-Source: AAOMgpfp79C+mE/8/yh8OIwkxuO4tCaV/Zx1LFAhu8b6yZ/LgGr2RfaeoOEdJJ1TymP/CBm2xRUbdQ==
X-Received: by 2002:a62:4808:: with SMTP id v8-v6mr2284095pfa.89.1531861504205;
        Tue, 17 Jul 2018 14:05:04 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:05:03 -0700 (PDT)
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
Subject: [PATCH 16/32] staging: gasket: always allow root open for write
Date:   Tue, 17 Jul 2018 13:56:56 -0700
Message-Id: <20180717205712.29495-17-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Always allow root to open device for writing.

Drop special-casing of ioctl permissions for root vs. owner.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c  |  9 +--------
 drivers/staging/gasket/gasket_core.c  |  8 +++++---
 drivers/staging/gasket/gasket_ioctl.c | 19 ++++++++-----------
 3 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 3a83c3d4d5561..612b3ab803196 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -629,14 +629,7 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
  */
 static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)
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
index 0d5ba7359af73..947b4fcc76970 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1085,6 +1085,7 @@ static int gasket_open(struct inode *inode, struct file *filp)
 	char task_name[TASK_COMM_LEN];
 	struct gasket_cdev_info *dev_info =
 	    container_of(inode->i_cdev, struct gasket_cdev_info, cdev);
+	int is_root = capable(CAP_SYS_ADMIN);
 
 	gasket_dev = dev_info->gasket_dev_ptr;
 	driver_desc = gasket_dev->internal_desc->driver_desc;
@@ -1098,7 +1099,7 @@ static int gasket_open(struct inode *inode, struct file *filp)
 		"Attempting to open with tgid %u (%s) (f_mode: 0%03o, "
 		"fmode_write: %d is_root: %u)",
 		current->tgid, task_name, filp->f_mode,
-		(filp->f_mode & FMODE_WRITE), capable(CAP_SYS_ADMIN));
+		(filp->f_mode & FMODE_WRITE), is_root);
 
 	/* Always allow non-writing accesses. */
 	if (!(filp->f_mode & FMODE_WRITE)) {
@@ -1112,8 +1113,9 @@ static int gasket_open(struct inode *inode, struct file *filp)
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
index 0c2f85cf54480..d0fa05b8bf1d3 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -171,7 +171,7 @@ long gasket_is_supported_ioctl(uint cmd)
  */
 static uint gasket_ioctl_check_permissions(struct file *filp, uint cmd)
 {
-	uint alive, root, device_owner;
+	uint alive;
 	fmode_t read, write;
 	struct gasket_dev *gasket_dev = (struct gasket_dev *)filp->private_data;
 
@@ -183,33 +183,30 @@ static uint gasket_ioctl_check_permissions(struct file *filp, uint cmd)
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
 
 	return 0; /* unknown permissions */
-- 
2.18.0.203.gfac676dfb9-goog

