Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B49DECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5E8208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh1E9pQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5E8208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeGNGQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:16:45 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41044 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeGNGQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:16:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id c21-v6so19139661pfn.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 22:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CIqn9XBUK+09yrfWLIctLQX/l49zOjLWve/MhhxDZ6U=;
        b=Gh1E9pQAZblROVtdhfjAgOw6FQRdl44h6w/S+rXsXuviQI74oNhJ6qKZs5msB5RGMo
         KA0RTw4Mpso1QqetBUL/wS5TnNve34XMKSBoSemIdXel8/4ofHHo3jv+d81tYSXF4RGq
         W7qdSbb8nTbHXYRLKDSokJcbdQSKtNq6qTwzcmzg1sp8VjahdRdGO5gcp30++9dH8tds
         5tDSRXTGX1kkS3qmJZnhhkwFA63bhdw34S46ZLRueeJMPaq7RV0XgLQyl4qCgxKWP3df
         bD/dtvjyKgvwBfX/WZMk5ZG8REoRIeN9Ff2RgvvOYF+W491/LEllR4Gcppmg8JzVM+b+
         lTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CIqn9XBUK+09yrfWLIctLQX/l49zOjLWve/MhhxDZ6U=;
        b=nfZw0+7skfrKsAMmqvp4WdBoUwFRaHKtNKU3q6hjgpR41mX97yEiDbW1zJyjvG/uPz
         yxTeX+VcF+0tygzEGjneKLg+9gs/l0VWodQqINEc0aT93WU2DZ09/uqtVibFrJodGR0s
         sxYaG7k4m6WC5rxGxkTaJF0UY3RhRmDVqq0botxqDMxEFDRkIn9EqzkdopyY8RCA1mnH
         ngzTJvxEckRokLBc/HzwNqWwWQjYw2qib0qzd/XakvoEJTPo3fvkKJMLg95cemdXymY8
         Zz5nZFWzN7bdm8n1oop/eA/RfRuvrh9bxi/Ty+FL2gZFn5Lzq51FXiw0v9yV7/zEIS5E
         xveA==
X-Gm-Message-State: AOUpUlGBEmsUlmRNbj1HZFhPgOlVTKj4FJabfzECWDjCrn9X9qdnxyXW
        B439IpzIpA8Oo+FmC9DYrsY=
X-Google-Smtp-Source: AAOMgpdrJ5B3vPdoSAT8KoLJsg3BI/4eHR+ZQRtxcbsbp4RP/jfs3X5UHfCKQRYNFxuYsMapDmDgFg==
X-Received: by 2002:a63:be4a:: with SMTP id g10-v6mr8406111pgo.378.1531547935137;
        Fri, 13 Jul 2018 22:58:55 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id 203-v6sm48411112pgb.14.2018.07.13.22.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 22:58:54 -0700 (PDT)
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
Subject: [PATCH 11/18] staging: gasket: always allow root open for write
Date:   Fri, 13 Jul 2018 22:58:09 -0700
Message-Id: <20180714055816.223754-12-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180714055816.223754-1-toddpoynor@gmail.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
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
 drivers/staging/gasket/apex_driver.c  |  9 +++------
 drivers/staging/gasket/gasket_core.c  |  8 +++++---
 drivers/staging/gasket/gasket_ioctl.c | 15 ++++++---------
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index b1318482ba65..ffe11d8168ea 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -644,13 +644,10 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
 static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)
 {
 	struct gasket_dev *gasket_dev = filp->private_data;
-	int root = capable(CAP_SYS_ADMIN);
-	int is_owner = gasket_dev->dev_info.ownership.is_owned &&
-		       current->tgid == gasket_dev->dev_info.ownership.owner;
+	fmode_t write;
 
-	if (root || is_owner)
-		return 1;
-	return 0;
+	write = filp->f_mode & FMODE_WRITE;
+	return write;
 }
 
 /*
diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 0c45c54254fb..5908964f0039 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1101,6 +1101,7 @@ static int gasket_open(struct inode *inode, struct file *filp)
 	char task_name[TASK_COMM_LEN];
 	struct gasket_cdev_info *dev_info =
 	    container_of(inode->i_cdev, struct gasket_cdev_info, cdev);
+	int is_root = capable(CAP_SYS_ADMIN);
 
 	gasket_dev = dev_info->gasket_dev_ptr;
 	driver_desc = gasket_dev->internal_desc->driver_desc;
@@ -1114,7 +1115,7 @@ static int gasket_open(struct inode *inode, struct file *filp)
 		"Attempting to open with tgid %u (%s) (f_mode: 0%03o, "
 		"fmode_write: %d is_root: %u)",
 		current->tgid, task_name, filp->f_mode,
-		(filp->f_mode & FMODE_WRITE), capable(CAP_SYS_ADMIN));
+		(filp->f_mode & FMODE_WRITE), is_root);
 
 	/* Always allow non-writing accesses. */
 	if (!(filp->f_mode & FMODE_WRITE)) {
@@ -1128,8 +1129,9 @@ static int gasket_open(struct inode *inode, struct file *filp)
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
index 4758083fb19b..23875fd465f6 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -180,7 +180,7 @@ long gasket_is_supported_ioctl(uint cmd)
  */
 static uint gasket_ioctl_check_permissions(struct file *filp, uint cmd)
 {
-	uint alive, root, device_owner;
+	uint alive;
 	fmode_t read, write;
 	struct gasket_dev *gasket_dev = (struct gasket_dev *)filp->private_data;
 
@@ -191,33 +191,30 @@ static uint gasket_ioctl_check_permissions(struct file *filp, uint cmd)
 			alive, gasket_dev->status);
 	}
 
-	root = capable(CAP_SYS_ADMIN);
 	read = filp->f_mode & FMODE_READ;
 	write = filp->f_mode & FMODE_WRITE;
-	device_owner = (gasket_dev->dev_info.ownership.is_owned &&
-			current->tgid == gasket_dev->dev_info.ownership.owner);
 
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

