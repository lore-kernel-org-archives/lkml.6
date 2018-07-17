Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B615ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181C620C03
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPfs9OKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181C620C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731940AbeGQCkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:19 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35103 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731896AbeGQCkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:18 -0400
Received: by mail-pl0-f67.google.com with SMTP id w3-v6so2971697plq.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U8210jamEaM0qHC+pt3ipgCF6gmDZYjU9daXiWi0rc8=;
        b=kPfs9OKG/yiEZ+SiWbvcgXPrck/tnY+mYDF/HkeZtz//nnB2bjwVQSTNOPjosF+8uG
         xu5HnnfcG+O0pK60iRKJwI6tfpRFGompiKCeMBrY7dNha8aUht9cIhkoVE/LKbFDnVCN
         Il7Q7u/4riHGqLrNshUolzgksvjSPzyxWDZqbFLPONYshssFxz8Zwp8lNX7ir58jeF4A
         2cxHP3uVc4KAOxW6qoVYZnB565pQMxdyCEhvlnBXRX7Q7bPzCh84jFaUMf86q5/0GtvS
         w+t/ndoWClHs2MjW0xJQ3mve5zGVs1aoJxAyEUeux9mDAuYo8XoQ+iq8yrHry9ci/f8Q
         iw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U8210jamEaM0qHC+pt3ipgCF6gmDZYjU9daXiWi0rc8=;
        b=eoXWMbLiBKuD8JPndazIHVMvM8uCZCIbE8/2tIeM4OoPz+Fk2/MBUAguxiY9jJ/U7+
         BLN8UmwNRcj/CrC3uO/dHLTxR4fK+fLzc/w8h5HG+fMNuaW9hfwSvmY9yUpziTmvH1+i
         cTN8UYgxhhOKYiadbh8Zeyt5CdCZrzTBz5YEjg/FaQAVO5se86+0P3I/H9g166+8EmF7
         LkwvJ3JexseKedapATANlaJX573uy9lvSCDR2z/3FCkYYtcceo2amZ40G+3ZZcHUxZwq
         3Dh0UB2PQoCSHn3EEX2HVZvy2L6OGo5Q8ggKLHqlG/RKoqoLHoI60r3Ma54J6sMo7Dtf
         PAqg==
X-Gm-Message-State: AOUpUlFLkDgeeEV4q9ajs7ZN4llI+ApPI1W/vE9EalBpsil5z0ifDqx2
        ZkzCS0zBWlQX5a2pF70QTfU=
X-Google-Smtp-Source: AAOMgpepnrMs8tddVQG8ZxJIqf+poOeirdhSyEMifrkvmZEgfMV3pZjPNz1QnpbPzMhju2dtIZGvqA==
X-Received: by 2002:a17:902:585:: with SMTP id f5-v6mr10531931plf.7.1531793407747;
        Mon, 16 Jul 2018 19:10:07 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:10:07 -0700 (PDT)
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
Date:   Mon, 16 Jul 2018 19:09:10 -0700
Message-Id: <20180717020926.176408-17-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
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
Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/staging/gasket/apex_driver.c  |  9 +++------
 drivers/staging/gasket/gasket_core.c  |  8 +++++---
 drivers/staging/gasket/gasket_ioctl.c | 15 ++++++---------
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 3a83c3d4d5561..6fd09c45a3df6 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -630,13 +630,10 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
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
index ae20b7ff9569b..9d1bb3caf6de2 100644
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
index 0c2f85cf54480..17431d14e6ef1 100644
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

