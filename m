Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1310BECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1F420C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFrVEgFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1F420C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbeGQCkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:20 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38605 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731896AbeGQCkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:19 -0400
Received: by mail-pl0-f68.google.com with SMTP id b1-v6so16090825pls.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iju9vuP6lUFdTg60JSZOqqxI6g0ECSGR7GmmdU6hOUM=;
        b=aFrVEgFCr9Gr7r+4+6EaGXTOLBW1Y4d/QZbwNFyuLEk4yT9nWIuEogjqUy/Hc9YxHB
         TZB7iVOzelBVjGc8+CWPn9x3SUrbJnwUdxUWNzsN1LsztstL79iNZ6Z//Ke4RjpLpP+/
         JzVeA375wxhk+fr9uCrjUcbUOVXwFykL5GqJoCGeLvHpwN37/ga+82/wF0WOmI9fmrK4
         bRgNCEJKzi871VhTVZ95o+3bfKWTEgXVvRIK1Jfl1jt2icoF3lsuTNiBqLFbF3d2WINC
         YxbLyj+z1u3ngjAsfaoSkUzUMQSO+lvMz/uKtgbEufCaLi8NktNH+t/cZAo1GpIUUiOy
         E0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iju9vuP6lUFdTg60JSZOqqxI6g0ECSGR7GmmdU6hOUM=;
        b=brOmq2WMYyD52J+siLY5x+4uqus8KW8aP6gdoKhihaUXMeOooJE9dOY6nc6PX1r6Ga
         Klbjtp77EUuW0EgOWGTyGxhgE0ZX+bRQwPb5cv3O4vY3T7hcCPgX3OESzSCvcYO7Q8ib
         t4LBidxHlV/2wTaQyrwOrigjOdCDNlngTFtAegGnqZeAdNuOCrBtAiyii2v2jle+P6L1
         3ptXJzp9EAvh5qh6QJKLgTwYBNjUABKugfQBFwm49jm1wjxa6VLrN8LSSAP0a0xdWYFH
         5owImyyeqb0oZ1FDh2ve5kEiyTqQeIfJYCu6gDVwEFQ7kZ+PkTQoFLZv1BOvDt6LHd7t
         fD0A==
X-Gm-Message-State: AOUpUlG8uM+deTNEdgann5W4WnV0sc45EmJM4ntjhuDEB0QJH+Sf0o2Q
        p+A7pDxR7mso8nYoQK2PMVIIATSV
X-Google-Smtp-Source: AAOMgpfumICzcZwuNi0lx5iSGN1kn9wzPtjXiCQstljqTuKrSYE387kc5V5TnwCGtV/mZZEM+BGmuQ==
X-Received: by 2002:a17:902:654b:: with SMTP id d11-v6mr18698552pln.8.1531793409519;
        Mon, 16 Jul 2018 19:10:09 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:10:08 -0700 (PDT)
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
Subject: [PATCH 17/32] staging: gasket: annotate ioctl arg with __user
Date:   Mon, 16 Jul 2018 19:09:11 -0700
Message-Id: <20180717020926.176408-18-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

For sparse checking.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c  | 12 ++---
 drivers/staging/gasket/gasket_core.c  |  6 ++-
 drivers/staging/gasket/gasket_core.h  |  4 +-
 drivers/staging/gasket/gasket_ioctl.c | 72 ++++++++++++++-------------
 drivers/staging/gasket/gasket_ioctl.h |  4 +-
 5 files changed, 52 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 6fd09c45a3df6..6a22fa9a9c045 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2018 Google, Inc.
  */
 
+#include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/init.h>
@@ -142,9 +143,9 @@ static int apex_get_status(struct gasket_dev *gasket_dev);
 
 static uint apex_ioctl_check_permissions(struct file *file, uint cmd);
 
-static long apex_ioctl(struct file *file, uint cmd, ulong arg);
+static long apex_ioctl(struct file *file, uint cmd, void __user *arg);
 
-static long apex_clock_gating(struct gasket_dev *gasket_dev, ulong arg);
+static long apex_clock_gating(struct gasket_dev *gasket_dev, void __user *arg);
 
 static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type);
 
@@ -629,7 +630,6 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
  */
 static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)
 {
-	struct gasket_dev *gasket_dev = filp->private_data;
 	fmode_t write;
 
 	write = filp->f_mode & FMODE_WRITE;
@@ -639,7 +639,7 @@ static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)
 /*
  * Apex-specific ioctl handler.
  */
-static long apex_ioctl(struct file *filp, uint cmd, ulong arg)
+static long apex_ioctl(struct file *filp, uint cmd, void __user *arg)
 {
 	struct gasket_dev *gasket_dev = filp->private_data;
 
@@ -659,7 +659,7 @@ static long apex_ioctl(struct file *filp, uint cmd, ulong arg)
  * @gasket_dev: Gasket device pointer.
  * @arg: User ioctl arg, in this case to a apex_gate_clock_ioctl struct.
  */
-static long apex_clock_gating(struct gasket_dev *gasket_dev, ulong arg)
+static long apex_clock_gating(struct gasket_dev *gasket_dev, void __user *arg)
 {
 	struct apex_gate_clock_ioctl ibuf;
 
@@ -667,7 +667,7 @@ static long apex_clock_gating(struct gasket_dev *gasket_dev, ulong arg)
 		return 0;
 
 	if (allow_sw_clock_gating) {
-		if (copy_from_user(&ibuf, (void __user *)arg, sizeof(ibuf)))
+		if (copy_from_user(&ibuf, arg, sizeof(ibuf)))
 			return -EFAULT;
 
 		gasket_log_error(
diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 9d1bb3caf6de2..9f974f179e378 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -14,6 +14,7 @@
 #include "gasket_page_table.h"
 #include "gasket_sysfs.h"
 
+#include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/init.h>
@@ -1823,14 +1824,15 @@ static long gasket_ioctl(struct file *filp, uint cmd, ulong arg)
 		 * check_and_invoke_callback.
 		 */
 		if (driver_desc->ioctl_handler_cb)
-			return driver_desc->ioctl_handler_cb(filp, cmd, arg);
+			return driver_desc->ioctl_handler_cb(
+			    filp, cmd, (void __user *)arg);
 
 		gasket_log_error(
 			gasket_dev, "Received unknown ioctl 0x%x", cmd);
 		return -EINVAL;
 	}
 
-	return gasket_handle_ioctl(filp, cmd, arg);
+	return gasket_handle_ioctl(filp, cmd, (void __user *)arg);
 }
 
 int gasket_reset(struct gasket_dev *gasket_dev, uint reset_type)
diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 50ad0c8853183..68b4d2ac9fd6c 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -315,7 +315,7 @@ struct gasket_dev {
 
 /* Type of the ioctl permissions check callback. See below. */
 typedef int (*gasket_ioctl_permissions_cb_t)(
-	struct file *filp, uint cmd, ulong arg);
+	struct file *filp, uint cmd, void __user *arg);
 
 /*
  * Device type descriptor.
@@ -549,7 +549,7 @@ struct gasket_driver_desc {
 	 * return -EINVAL. Should return an error status (either -EINVAL or
 	 * the error result of the ioctl being handled).
 	 */
-	long (*ioctl_handler_cb)(struct file *filp, uint cmd, ulong arg);
+	long (*ioctl_handler_cb)(struct file *filp, uint cmd, void __user *arg);
 
 	/*
 	 * device_status_cb: Callback to determine device health.
diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index 17431d14e6ef1..531c360949a64 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -7,6 +7,7 @@
 #include "gasket_interrupt.h"
 #include "gasket_logging.h"
 #include "gasket_page_table.h"
+#include <linux/compiler.h>
 #include <linux/fs.h>
 #include <linux/uaccess.h>
 
@@ -23,17 +24,18 @@
 #endif
 
 static uint gasket_ioctl_check_permissions(struct file *filp, uint cmd);
-static int gasket_set_event_fd(struct gasket_dev *dev, ulong arg);
+static int gasket_set_event_fd(struct gasket_dev *dev, void __user *arg);
 static int gasket_read_page_table_size(
-	struct gasket_dev *gasket_dev, ulong arg);
+	struct gasket_dev *gasket_dev, void __user *arg);
 static int gasket_read_simple_page_table_size(
-	struct gasket_dev *gasket_dev, ulong arg);
+	struct gasket_dev *gasket_dev, void __user *arg);
 static int gasket_partition_page_table(
-	struct gasket_dev *gasket_dev, ulong arg);
-static int gasket_map_buffers(struct gasket_dev *gasket_dev, ulong arg);
-static int gasket_unmap_buffers(struct gasket_dev *gasket_dev, ulong arg);
+	struct gasket_dev *gasket_dev, void __user *arg);
+static int gasket_map_buffers(struct gasket_dev *gasket_dev, void __user *arg);
+static int gasket_unmap_buffers(struct gasket_dev *gasket_dev,
+				void __user *arg);
 static int gasket_config_coherent_allocator(
-	struct gasket_dev *gasket_dev, ulong arg);
+	struct gasket_dev *gasket_dev, void __user *arg);
 
 /*
  * standard ioctl dispatch function.
@@ -43,9 +45,10 @@ static int gasket_config_coherent_allocator(
  *
  * Standard ioctl dispatcher; forwards operations to individual handlers.
  */
-long gasket_handle_ioctl(struct file *filp, uint cmd, ulong arg)
+long gasket_handle_ioctl(struct file *filp, uint cmd, void __user *arg)
 {
 	struct gasket_dev *gasket_dev;
+	ulong intarg = (ulong)arg;
 	int retval;
 
 	gasket_dev = (struct gasket_dev *)filp->private_data;
@@ -74,16 +77,16 @@ long gasket_handle_ioctl(struct file *filp, uint cmd, ulong arg)
 	 */
 	switch (cmd) {
 	case GASKET_IOCTL_RESET:
-		trace_gasket_ioctl_integer_data(arg);
-		retval = gasket_reset(gasket_dev, arg);
+		trace_gasket_ioctl_integer_data(intarg);
+		retval = gasket_reset(gasket_dev, intarg);
 		break;
 	case GASKET_IOCTL_SET_EVENTFD:
 		retval = gasket_set_event_fd(gasket_dev, arg);
 		break;
 	case GASKET_IOCTL_CLEAR_EVENTFD:
-		trace_gasket_ioctl_integer_data(arg);
+		trace_gasket_ioctl_integer_data(intarg);
 		retval = gasket_interrupt_clear_eventfd(
-			gasket_dev->interrupt_data, (int)arg);
+			gasket_dev->interrupt_data, (int)intarg);
 		break;
 	case GASKET_IOCTL_PARTITION_PAGE_TABLE:
 		trace_gasket_ioctl_integer_data(arg);
@@ -91,7 +94,7 @@ long gasket_handle_ioctl(struct file *filp, uint cmd, ulong arg)
 		break;
 	case GASKET_IOCTL_NUMBER_PAGE_TABLES:
 		trace_gasket_ioctl_integer_data(gasket_dev->num_page_tables);
-		if (copy_to_user((void __user *)arg,
+		if (copy_to_user(arg,
 				 &gasket_dev->num_page_tables,
 				 sizeof(uint64_t)))
 			retval = -EFAULT;
@@ -217,11 +220,11 @@ static uint gasket_ioctl_check_permissions(struct file *filp, uint cmd)
  * @gasket_dev: Pointer to the current gasket_dev we're using.
  * @arg: Pointer to gasket_interrupt_eventfd struct in userspace.
  */
-static int gasket_set_event_fd(struct gasket_dev *gasket_dev, ulong arg)
+static int gasket_set_event_fd(struct gasket_dev *gasket_dev, void __user *arg)
 {
 	struct gasket_interrupt_eventfd die;
 
-	if (copy_from_user(&die, (void __user *)arg,
+	if (copy_from_user(&die, arg,
 			   sizeof(struct gasket_interrupt_eventfd))) {
 		return -EFAULT;
 	}
@@ -237,13 +240,13 @@ static int gasket_set_event_fd(struct gasket_dev *gasket_dev, ulong arg)
  * @gasket_dev: Pointer to the current gasket_dev we're using.
  * @arg: Pointer to gasket_page_table_ioctl struct in userspace.
  */
-static int gasket_read_page_table_size(struct gasket_dev *gasket_dev, ulong arg)
+static int gasket_read_page_table_size(struct gasket_dev *gasket_dev,
+				       void __user *arg)
 {
 	int ret = 0;
 	struct gasket_page_table_ioctl ibuf;
 
-	if (copy_from_user(&ibuf, (void __user *)arg,
-			   sizeof(struct gasket_page_table_ioctl)))
+	if (copy_from_user(&ibuf, arg, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
 
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
@@ -256,7 +259,7 @@ static int gasket_read_page_table_size(struct gasket_dev *gasket_dev, ulong arg)
 		ibuf.page_table_index, ibuf.size, ibuf.host_address,
 		ibuf.device_address);
 
-	if (copy_to_user((void __user *)arg, &ibuf, sizeof(ibuf)))
+	if (copy_to_user(arg, &ibuf, sizeof(ibuf)))
 		return -EFAULT;
 
 	return ret;
@@ -268,13 +271,12 @@ static int gasket_read_page_table_size(struct gasket_dev *gasket_dev, ulong arg)
  * @arg: Pointer to gasket_page_table_ioctl struct in userspace.
  */
 static int gasket_read_simple_page_table_size(
-	struct gasket_dev *gasket_dev, ulong arg)
+	struct gasket_dev *gasket_dev, void __user *arg)
 {
 	int ret = 0;
 	struct gasket_page_table_ioctl ibuf;
 
-	if (copy_from_user(&ibuf, (void __user *)arg,
-			   sizeof(struct gasket_page_table_ioctl)))
+	if (copy_from_user(&ibuf, arg, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
 
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
@@ -287,7 +289,7 @@ static int gasket_read_simple_page_table_size(
 		ibuf.page_table_index, ibuf.size, ibuf.host_address,
 		ibuf.device_address);
 
-	if (copy_to_user((void __user *)arg, &ibuf, sizeof(ibuf)))
+	if (copy_to_user(arg, &ibuf, sizeof(ibuf)))
 		return -EFAULT;
 
 	return ret;
@@ -298,14 +300,14 @@ static int gasket_read_simple_page_table_size(
  * @gasket_dev: Pointer to the current gasket_dev we're using.
  * @arg: Pointer to gasket_page_table_ioctl struct in userspace.
  */
-static int gasket_partition_page_table(struct gasket_dev *gasket_dev, ulong arg)
+static int gasket_partition_page_table(struct gasket_dev *gasket_dev,
+				       void __user *arg)
 {
 	int ret;
 	struct gasket_page_table_ioctl ibuf;
 	uint max_page_table_size;
 
-	if (copy_from_user(&ibuf, (void __user *)arg,
-			   sizeof(struct gasket_page_table_ioctl)))
+	if (copy_from_user(&ibuf, arg, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
 
 	trace_gasket_ioctl_page_table_data(
@@ -339,12 +341,12 @@ static int gasket_partition_page_table(struct gasket_dev *gasket_dev, ulong arg)
  * @gasket_dev: Pointer to the current gasket_dev we're using.
  * @arg: Pointer to a gasket_page_table_ioctl struct in userspace.
  */
-static int gasket_map_buffers(struct gasket_dev *gasket_dev, ulong arg)
+static int gasket_map_buffers(struct gasket_dev *gasket_dev,
+			      void __user *arg)
 {
 	struct gasket_page_table_ioctl ibuf;
 
-	if (copy_from_user(&ibuf, (void __user *)arg,
-			   sizeof(struct gasket_page_table_ioctl)))
+	if (copy_from_user(&ibuf, arg, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
 
 	trace_gasket_ioctl_page_table_data(
@@ -369,12 +371,12 @@ static int gasket_map_buffers(struct gasket_dev *gasket_dev, ulong arg)
  * @gasket_dev: Pointer to the current gasket_dev we're using.
  * @arg: Pointer to a gasket_page_table_ioctl struct in userspace.
  */
-static int gasket_unmap_buffers(struct gasket_dev *gasket_dev, ulong arg)
+static int gasket_unmap_buffers(struct gasket_dev *gasket_dev,
+				void __user *arg)
 {
 	struct gasket_page_table_ioctl ibuf;
 
-	if (copy_from_user(&ibuf, (void __user *)arg,
-			   sizeof(struct gasket_page_table_ioctl)))
+	if (copy_from_user(&ibuf, arg, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
 
 	trace_gasket_ioctl_page_table_data(
@@ -402,12 +404,12 @@ static int gasket_unmap_buffers(struct gasket_dev *gasket_dev, ulong arg)
  * @arg: Pointer to a gasket_coherent_alloc_config_ioctl struct in userspace.
  */
 static int gasket_config_coherent_allocator(
-	struct gasket_dev *gasket_dev, ulong arg)
+	struct gasket_dev *gasket_dev, void __user *arg)
 {
 	int ret;
 	struct gasket_coherent_alloc_config_ioctl ibuf;
 
-	if (copy_from_user(&ibuf, (void __user *)arg,
+	if (copy_from_user(&ibuf, arg,
 			   sizeof(struct gasket_coherent_alloc_config_ioctl)))
 		return -EFAULT;
 
@@ -431,7 +433,7 @@ static int gasket_config_coherent_allocator(
 			gasket_dev, ibuf.size, &ibuf.dma_address,
 			ibuf.page_table_index);
 	}
-	if (copy_to_user((void __user *)arg, &ibuf, sizeof(ibuf)))
+	if (copy_to_user(arg, &ibuf, sizeof(ibuf)))
 		return -EFAULT;
 
 	return ret;
diff --git a/drivers/staging/gasket/gasket_ioctl.h b/drivers/staging/gasket/gasket_ioctl.h
index 461fab27a3e52..2c6bd3e6ba2c9 100644
--- a/drivers/staging/gasket/gasket_ioctl.h
+++ b/drivers/staging/gasket/gasket_ioctl.h
@@ -5,6 +5,8 @@
 
 #include "gasket_core.h"
 
+#include <linux/compiler.h>
+
 /*
  * Handle Gasket common ioctls.
  * @filp: Pointer to the ioctl's file.
@@ -13,7 +15,7 @@
  *
  * Returns 0 on success and nonzero on failure.
  */
-long gasket_handle_ioctl(struct file *filp, uint cmd, ulong arg);
+long gasket_handle_ioctl(struct file *filp, uint cmd, void __user *arg);
 
 /*
  * Determines if an ioctl is part of the standard Gasket framework.
-- 
2.18.0.203.gfac676dfb9-goog

