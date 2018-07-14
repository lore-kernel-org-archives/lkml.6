Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C17BECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C582C208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzUDtBZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C582C208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbeGNGQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:16:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33968 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbeGNGQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 02:16:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id y5-v6so5656165pgv.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 22:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O59jqexgKqlpwcGsvao8aw0CcORyg4nOPjhgNOHisuI=;
        b=HzUDtBZVZl1XS2yE+0+s55D28MpqvatqsNErlM2wl8qkseEiUPKsu00whXAb1BXAVm
         xZzuknZwGpUfaYwq0pcmqYGECqIkqxWzpotp2x2QBMxdfDIE7iuXhg61q8ognjuSKtkH
         h8ILkhbkXqrjZccO/rhn6m/YfI8IkSWy0pxZ2IwXQumbJ4cowFwgUUamdz10E2T+FRF5
         AjXOJd5WU4eA4fclkgsKLHqA1rBISGgX3IirgQQEkQJ1/VmClHUMDf/VkQHlS3XHY5i/
         ezt+9oo4JkXFFRSq2P/4XHKZL9Rj2djWBm+VNstw/SSkw1MiA+aUiBASuu5mRHQtK3W0
         RH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O59jqexgKqlpwcGsvao8aw0CcORyg4nOPjhgNOHisuI=;
        b=UpVM/n1i47Vty5cRx8baTDl9+1dBkewXhNCa7S6zAXUs//mWOgR032i+fVsmMK17aw
         ZLXoIl8qGVtH2i25WaCoxq8LzLW8L52qETV6jAAujBsYkrj3sZWuTIupIRoadOZRe0Hd
         3KvgptGDXxbogVmBJKlF8bmgavay4BFabBuz252/Qp1D3pV3urUhVeT2/pGUwB239wCt
         D4hQrvlY/EAUG8fu3PAmPbSzicGaKeM2QKo5KYBsoNuvX75YetZdJw9LjddzgPx2IsEn
         uOX5oKnlL5+A8zA9awq1R0zdjOX+TJ7398WiK8GFu0/qIuH1s2IS9XBKPoAtReg7nbl4
         v93A==
X-Gm-Message-State: AOUpUlHPmNn3N9NA3XT61noyZdJ1bXsRolp4a/iFp0Y/o6MYJsO/OGTq
        cYaCE4ByhFtYnpHMG0Q2moE=
X-Google-Smtp-Source: AAOMgpdkUy26vuo7BSdz8CN4qWne9/E5MgAsyl519TUJXblmt+5wo7kVu5/m7H+pCRcLCTcErRb6GQ==
X-Received: by 2002:a63:7b1b:: with SMTP id w27-v6mr8220462pgc.199.1531547936064;
        Fri, 13 Jul 2018 22:58:56 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id 203-v6sm48411112pgb.14.2018.07.13.22.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 22:58:55 -0700 (PDT)
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
Subject: [PATCH 12/18] staging: gasket: annotate ioctl arg with __user
Date:   Fri, 13 Jul 2018 22:58:10 -0700
Message-Id: <20180714055816.223754-13-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180714055816.223754-1-toddpoynor@gmail.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
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
index ffe11d8168ea..40af91952283 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -12,6 +12,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/init.h>
@@ -149,9 +150,9 @@ static int apex_get_status(struct gasket_dev *gasket_dev);
 
 static uint apex_ioctl_check_permissions(struct file *file, uint cmd);
 
-static long apex_ioctl(struct file *file, uint cmd, ulong arg);
+static long apex_ioctl(struct file *file, uint cmd, void __user *arg);
 
-static long apex_clock_gating(struct gasket_dev *gasket_dev, ulong arg);
+static long apex_clock_gating(struct gasket_dev *gasket_dev, void __user *arg);
 
 static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type);
 
@@ -643,7 +644,6 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
  */
 static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)
 {
-	struct gasket_dev *gasket_dev = filp->private_data;
 	fmode_t write;
 
 	write = filp->f_mode & FMODE_WRITE;
@@ -653,7 +653,7 @@ static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)
 /*
  * Apex-specific ioctl handler.
  */
-static long apex_ioctl(struct file *filp, uint cmd, ulong arg)
+static long apex_ioctl(struct file *filp, uint cmd, void __user *arg)
 {
 	struct gasket_dev *gasket_dev = filp->private_data;
 
@@ -673,7 +673,7 @@ static long apex_ioctl(struct file *filp, uint cmd, ulong arg)
  * @gasket_dev: Gasket device pointer.
  * @arg: User ioctl arg, in this case to a apex_gate_clock_ioctl struct.
  */
-static long apex_clock_gating(struct gasket_dev *gasket_dev, ulong arg)
+static long apex_clock_gating(struct gasket_dev *gasket_dev, void __user *arg)
 {
 	struct apex_gate_clock_ioctl ibuf;
 
@@ -681,7 +681,7 @@ static long apex_clock_gating(struct gasket_dev *gasket_dev, ulong arg)
 		return 0;
 
 	if (allow_sw_clock_gating) {
-		if (copy_from_user(&ibuf, (void __user *)arg, sizeof(ibuf)))
+		if (copy_from_user(&ibuf, arg, sizeof(ibuf)))
 			return -EFAULT;
 
 		gasket_log_error(
diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 5908964f0039..65aa7cf454fb 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -21,6 +21,7 @@
 #include "gasket_page_table.h"
 #include "gasket_sysfs.h"
 
+#include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/init.h>
@@ -1842,14 +1843,15 @@ static long gasket_ioctl(struct file *filp, uint cmd, ulong arg)
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
index 16bee478dce6..177b239e2c50 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -322,7 +322,7 @@ struct gasket_dev {
 
 /* Type of the ioctl permissions check callback. See below. */
 typedef int (*gasket_ioctl_permissions_cb_t)(
-	struct file *filp, uint cmd, ulong arg);
+	struct file *filp, uint cmd, void __user *arg);
 
 /*
  * Device type descriptor.
@@ -556,7 +556,7 @@ struct gasket_driver_desc {
 	 * return -EINVAL. Should return an error status (either -EINVAL or
 	 * the error result of the ioctl being handled).
 	 */
-	long (*ioctl_handler_cb)(struct file *filp, uint cmd, ulong arg);
+	long (*ioctl_handler_cb)(struct file *filp, uint cmd, void __user *arg);
 
 	/*
 	 * device_status_cb: Callback to determine device health.
diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index 23875fd465f6..0c1e0723bef1 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -16,6 +16,7 @@
 #include "gasket_interrupt.h"
 #include "gasket_logging.h"
 #include "gasket_page_table.h"
+#include <linux/compiler.h>
 #include <linux/fs.h>
 #include <linux/uaccess.h>
 
@@ -32,17 +33,18 @@
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
@@ -52,9 +54,10 @@ static int gasket_config_coherent_allocator(
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
@@ -83,16 +86,16 @@ long gasket_handle_ioctl(struct file *filp, uint cmd, ulong arg)
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
@@ -100,7 +103,7 @@ long gasket_handle_ioctl(struct file *filp, uint cmd, ulong arg)
 		break;
 	case GASKET_IOCTL_NUMBER_PAGE_TABLES:
 		trace_gasket_ioctl_integer_data(gasket_dev->num_page_tables);
-		if (copy_to_user((void __user *)arg,
+		if (copy_to_user(arg,
 				 &gasket_dev->num_page_tables,
 				 sizeof(uint64_t)))
 			retval = -EFAULT;
@@ -225,11 +228,11 @@ static uint gasket_ioctl_check_permissions(struct file *filp, uint cmd)
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
@@ -245,13 +248,13 @@ static int gasket_set_event_fd(struct gasket_dev *gasket_dev, ulong arg)
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
@@ -264,7 +267,7 @@ static int gasket_read_page_table_size(struct gasket_dev *gasket_dev, ulong arg)
 		ibuf.page_table_index, ibuf.size, ibuf.host_address,
 		ibuf.device_address);
 
-	if (copy_to_user((void __user *)arg, &ibuf, sizeof(ibuf)))
+	if (copy_to_user(arg, &ibuf, sizeof(ibuf)))
 		return -EFAULT;
 
 	return ret;
@@ -276,13 +279,12 @@ static int gasket_read_page_table_size(struct gasket_dev *gasket_dev, ulong arg)
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
@@ -295,7 +297,7 @@ static int gasket_read_simple_page_table_size(
 		ibuf.page_table_index, ibuf.size, ibuf.host_address,
 		ibuf.device_address);
 
-	if (copy_to_user((void __user *)arg, &ibuf, sizeof(ibuf)))
+	if (copy_to_user(arg, &ibuf, sizeof(ibuf)))
 		return -EFAULT;
 
 	return ret;
@@ -306,14 +308,14 @@ static int gasket_read_simple_page_table_size(
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
@@ -347,12 +349,12 @@ static int gasket_partition_page_table(struct gasket_dev *gasket_dev, ulong arg)
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
@@ -377,12 +379,12 @@ static int gasket_map_buffers(struct gasket_dev *gasket_dev, ulong arg)
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
@@ -410,12 +412,12 @@ static int gasket_unmap_buffers(struct gasket_dev *gasket_dev, ulong arg)
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
 
@@ -439,7 +441,7 @@ static int gasket_config_coherent_allocator(
 			gasket_dev, ibuf.size, &ibuf.dma_address,
 			ibuf.page_table_index);
 	}
-	if (copy_to_user((void __user *)arg, &ibuf, sizeof(ibuf)))
+	if (copy_to_user(arg, &ibuf, sizeof(ibuf)))
 		return -EFAULT;
 
 	return ret;
diff --git a/drivers/staging/gasket/gasket_ioctl.h b/drivers/staging/gasket/gasket_ioctl.h
index df868000c803..a9e10e4bc84a 100644
--- a/drivers/staging/gasket/gasket_ioctl.h
+++ b/drivers/staging/gasket/gasket_ioctl.h
@@ -14,6 +14,8 @@
 
 #include "gasket_core.h"
 
+#include <linux/compiler.h>
+
 /*
  * Handle Gasket common ioctls.
  * @filp: Pointer to the ioctl's file.
@@ -22,7 +24,7 @@
  *
  * Returns 0 on success and nonzero on failure.
  */
-long gasket_handle_ioctl(struct file *filp, uint cmd, ulong arg);
+long gasket_handle_ioctl(struct file *filp, uint cmd, void __user *arg);
 
 /*
  * Determines if an ioctl is part of the standard Gasket framework.
-- 
2.18.0.203.gfac676dfb9-goog

