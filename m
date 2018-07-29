Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34547C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D979C20857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPS+bAVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D979C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbeG2VIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:08:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44711 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbeG2VId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:08:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so6026874pgp.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 12:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JT7zd3AmksLuk08DZdDn93fty6525TTv0Ac71ABLDSQ=;
        b=LPS+bAVaeWhTS4mjz/MUJuFiWL6VpEC2M6p/73JbtlCjiRt73vxR96jAt61qYw409p
         lF/JZ4Y8SzI9dvCE3BQ8UhSTe057GOZh+DUonNZwC09nW3MeA5vwVz1dcuZoh/gRjygr
         WR6UqW38gdmj4Zv/svOBMPGyMJYACUChlVRqkeBBtKuU5z98F5jytcotAqMXZ7qOg90n
         ozOpHE3A4NmQWrnztAZJ/D6oGRUyxUNuyXUZ8pG7KRU9CSNh/uzZrpj/cYl9ANmNhwlP
         U0IjvBsmpMwsxHWlHRsZbvaeGg9GQdZTLi/fW5Nvb0Aj9uwj7kdG8JOVx15R6G+R8WAj
         pG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JT7zd3AmksLuk08DZdDn93fty6525TTv0Ac71ABLDSQ=;
        b=kMCyurlevRg85nJdnKiOLg7tU1+Ubh50Kn8uumwosx4lP0zObszdMIlTpEB7/mFSj2
         M3XzHVIe88vwmQyUDae0s9DGWb9JZbafVlGkul8TrgWS6zM/rej5ws8b/kUagUFsW7Q1
         xRVSHVBVNiypPaJf+Xzhjc6JZjcYV9qrzK2EujDOO1TEPT6C5eyTlD2kyjU+CcQj73br
         UeshPK5LVGrV0FvkMw0rrNfYjGsaDoJjGJPnSXTLa8JavqMqR5CIGBlTXNAKqlOE0RMH
         aBoO0ib7R52d/aN8NNJGNbAx7Px+oiMfdaNa7qC5bPKpoqsigbnOhKXyzD9bfJxJEJ5a
         +OAA==
X-Gm-Message-State: AOUpUlE1xllq7S6JoW6e1BGX6Any6YcjOJyVo5q1ikwN463vRfhjbtbJ
        rZzKQT1ji7BcFfnT0Ccz6I0=
X-Google-Smtp-Source: AAOMgpfBVzwsKGnOQWTLfnKxpFphc9lMm5KiefM8PfTvCKyLcPiFYCxgsUUlozNOZgwYphYdqn0VRg==
X-Received: by 2002:a63:e001:: with SMTP id e1-v6mr13664682pgh.380.1532893021866;
        Sun, 29 Jul 2018 12:37:01 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id k26-v6sm27474062pfb.167.2018.07.29.12.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 12:37:01 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dtor@chromium.org>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 04/13] staging: gasket: core: allow root access based on user namespace
Date:   Sun, 29 Jul 2018 12:36:37 -0700
Message-Id: <20180729193646.201721-5-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180729193646.201721-1-toddpoynor@gmail.com>
References: <20180729193646.201721-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Use user namespace to determine whether gasket device file opener is
root, allowing root access to containers, if necessary.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index b832a4f529f27..291cd6d074a2e 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -13,13 +13,16 @@
 #include "gasket_page_table.h"
 #include "gasket_sysfs.h"
 
+#include <linux/capability.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/of.h>
+#include <linux/pid_namespace.h>
 #include <linux/printk.h>
+#include <linux/sched.h>
 
 #ifdef GASKET_KERNEL_TRACE_SUPPORT
 #define CREATE_TRACE_POINTS
@@ -1064,7 +1067,8 @@ static int gasket_open(struct inode *inode, struct file *filp)
 	char task_name[TASK_COMM_LEN];
 	struct gasket_cdev_info *dev_info =
 	    container_of(inode->i_cdev, struct gasket_cdev_info, cdev);
-	int is_root = capable(CAP_SYS_ADMIN);
+	struct pid_namespace *pid_ns = task_active_pid_ns(current);
+	int is_root = ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN);
 
 	gasket_dev = dev_info->gasket_dev_ptr;
 	driver_desc = gasket_dev->internal_desc->driver_desc;
@@ -1147,6 +1151,8 @@ static int gasket_release(struct inode *inode, struct file *file)
 	char task_name[TASK_COMM_LEN];
 	struct gasket_cdev_info *dev_info =
 		container_of(inode->i_cdev, struct gasket_cdev_info, cdev);
+	struct pid_namespace *pid_ns = task_active_pid_ns(current);
+	int is_root = ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN);
 
 	gasket_dev = dev_info->gasket_dev_ptr;
 	driver_desc = gasket_dev->internal_desc->driver_desc;
@@ -1158,7 +1164,7 @@ static int gasket_release(struct inode *inode, struct file *file)
 		"Releasing device node. Call origin: tgid %u (%s) "
 		"(f_mode: 0%03o, fmode_write: %d, is_root: %u)\n",
 		current->tgid, task_name, file->f_mode,
-		(file->f_mode & FMODE_WRITE), capable(CAP_SYS_ADMIN));
+		(file->f_mode & FMODE_WRITE), is_root);
 	dev_dbg(gasket_dev->dev, "Current open count (owning tgid %u): %d\n",
 		ownership->owner, ownership->write_open_count);
 
-- 
2.18.0.345.g5c9ce644c3-goog

