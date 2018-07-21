Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AD3ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5AB20872
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTDQmBLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5AB20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbeGUO2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:28:48 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38778 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbeGUO2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:28:16 -0400
Received: by mail-pl0-f65.google.com with SMTP id b1-v6so6350966pls.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q9kReK5tZUutLvhAvbUCEgi9Q9LNcMaiDMfnVmd8CqM=;
        b=rTDQmBLGnvmXcRk9nwqHkrCnGWgNQjnV33X+xE6UecPWMs7TrBe+SNxdoIKt5ulTLx
         /HOXNZNizo1vsKmP6SvbmTQj3eObHJ8HVAmghizf1p4uCuZbOI/ACae7j/R2ZMYrSKDS
         0/4AleHa/FraOmkkr7N2jcbIkFkYxlAUqk2JdvFrdRlruSLBiCicbELU3eDoO04rt6gR
         WZUkXpqUCnspm/qYKaQYu55kdp0neTfodusf1QOllcsmTjawH/PRgy2rSmuuVKYiohsU
         nmnGQ4xwBgicoxj+QuzFW+okVkylZyxHCfbVsiN9XcStHD3QtOBI2tZd/oOoCytH2WTZ
         yqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q9kReK5tZUutLvhAvbUCEgi9Q9LNcMaiDMfnVmd8CqM=;
        b=fmtXOZGkDv8VgZgG9iuxWGjkHgmwkneTQom/wUsSY8KuSew5mnEn0AH6O1+UtgP3n8
         CMaLPzIA77M0Otv4VlHamfi7ejJQhbb/N2wb0l+g2oMTGjFC4g/QEPMrxk3zXE6MhoKs
         XJAp+KOy7HkDy+5nb9nDINKDaF59YJpwuAdNB2i6EOdpYVWrCXTlZ2R5cEiw3cpduzxD
         7WCaV2KvUm5nAZPs3xTNrw8FH3QSmxW5/NREmbhYZe2gC8KPCYOPJlMkuDoaRlxu1Qxv
         LEji4y/r1z4t7A1J6/aG1tiuPf8WMTjPWc5cYFYCV3AP1oxLVWFhZmJ1tluUn3Jfmukk
         HIqg==
X-Gm-Message-State: AOUpUlG8WyNoQ1cLglr3lR/6Mtr2PW1Tvix6WhrPhZrNSRgOTx8LZo0t
        ATjE7O240IIBb2HhzCG8Yak=
X-Google-Smtp-Source: AAOMgpfjcydbqnwkSfEQvJ07mFV7OG5v+HSPO/dkbD4/HT1U/lbcNhF+nuaVpI4lxc/X7v0xKxAVYw==
X-Received: by 2002:a17:902:7781:: with SMTP id o1-v6mr5849717pll.48.1532180128541;
        Sat, 21 Jul 2018 06:35:28 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p26-v6sm9445023pfi.183.2018.07.21.06.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 06:35:28 -0700 (PDT)
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
Subject: [PATCH 09/14] staging: gasket: core: convert various logs to debug level
Date:   Sat, 21 Jul 2018 06:35:02 -0700
Message-Id: <20180721133507.95599-10-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721133507.95599-1-toddpoynor@gmail.com>
References: <20180721133507.95599-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Debugging information is improperly logged at non-debug log level in a
number of places, and some logs regarding error conditions may be
generated too frequently, such that these could cause performance
problems and/or obscure other logs.  Convert these to debug log level.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 38 +++++++++++++++-------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 8265d543623d7..1d04fd0990e45 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -205,7 +205,8 @@ static inline int check_and_invoke_callback(
 {
 	int ret = 0;
 
-	gasket_nodev_error("check_and_invoke_callback %p", cb_function);
+	gasket_log_debug(gasket_dev, "check_and_invoke_callback %p",
+			 cb_function);
 	if (cb_function) {
 		mutex_lock(&gasket_dev->mutex);
 		ret = cb_function(gasket_dev);
@@ -227,7 +228,7 @@ static inline int gasket_check_and_invoke_callback_nolock(
 	int ret = 0;
 
 	if (cb_function) {
-		gasket_log_info(
+		gasket_log_debug(
 			gasket_dev, "Invoking device-specific callback.");
 		ret = cb_function(gasket_dev);
 	}
@@ -1177,7 +1178,7 @@ static int gasket_release(struct inode *inode, struct file *file)
 	if (file->f_mode & FMODE_WRITE) {
 		ownership->write_open_count--;
 		if (ownership->write_open_count == 0) {
-			gasket_log_info(gasket_dev, "Device is now free");
+			gasket_log_debug(gasket_dev, "Device is now free");
 			ownership->is_owned = 0;
 			ownership->owner = 0;
 
@@ -1198,7 +1199,7 @@ static int gasket_release(struct inode *inode, struct file *file)
 		}
 	}
 
-	gasket_log_info(
+	gasket_log_debug(
 		gasket_dev, "New open count (owning tgid %u): %d",
 		ownership->owner, ownership->write_open_count);
 	mutex_unlock(&gasket_dev->mutex);
@@ -1225,7 +1226,7 @@ static bool gasket_mmap_has_permissions(
 
 	/* Never allow non-sysadmins to access to a dead device. */
 	if (gasket_dev->status != GASKET_STATUS_ALIVE) {
-		gasket_log_info(gasket_dev, "Device is dead.");
+		gasket_log_debug(gasket_dev, "Device is dead.");
 		return false;
 	}
 
@@ -1233,7 +1234,7 @@ static bool gasket_mmap_has_permissions(
 	requested_permissions =
 		(vma->vm_flags & (VM_WRITE | VM_READ | VM_EXEC));
 	if (requested_permissions & ~(bar_permissions)) {
-		gasket_log_info(
+		gasket_log_debug(
 			gasket_dev,
 			"Attempting to map a region with requested permissions "
 			"0x%x, but region has permissions 0x%x.",
@@ -1244,7 +1245,7 @@ static bool gasket_mmap_has_permissions(
 	/* Do not allow a non-owner to write. */
 	if ((vma->vm_flags & VM_WRITE) &&
 	    !gasket_owned_by_current_tgid(&gasket_dev->dev_info)) {
-		gasket_log_info(
+		gasket_log_debug(
 			gasket_dev,
 			"Attempting to mmap a region for write without owning "
 			"device.");
@@ -1736,15 +1737,16 @@ static int gasket_get_hw_status(struct gasket_dev *gasket_dev)
 	status = gasket_check_and_invoke_callback_nolock(
 		gasket_dev, driver_desc->device_status_cb);
 	if (status != GASKET_STATUS_ALIVE) {
-		gasket_log_info(gasket_dev, "Hardware reported status %d.",
-				status);
+		gasket_log_debug(gasket_dev, "Hardware reported status %d.",
+				 status);
 		return status;
 	}
 
 	status = gasket_interrupt_system_status(gasket_dev);
 	if (status != GASKET_STATUS_ALIVE) {
-		gasket_log_info(gasket_dev,
-				"Interrupt system reported status %d.", status);
+		gasket_log_debug(gasket_dev,
+				 "Interrupt system reported status %d.",
+				 status);
 		return status;
 	}
 
@@ -1752,7 +1754,7 @@ static int gasket_get_hw_status(struct gasket_dev *gasket_dev)
 		status = gasket_page_table_system_status(
 			gasket_dev->page_table[i]);
 		if (status != GASKET_STATUS_ALIVE) {
-			gasket_log_info(
+			gasket_log_debug(
 				gasket_dev, "Page table %d reported status %d.",
 				i, status);
 			return status;
@@ -1783,7 +1785,7 @@ static long gasket_ioctl(struct file *filp, uint cmd, ulong arg)
 	gasket_dev = (struct gasket_dev *)filp->private_data;
 	driver_desc = gasket_dev->internal_desc->driver_desc;
 	if (!driver_desc) {
-		gasket_log_error(
+		gasket_log_debug(
 			gasket_dev,
 			"Unable to find device descriptor for file %s",
 			d_path(&filp->f_path, path, 256));
@@ -1831,7 +1833,7 @@ int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type)
 	/* Perform a device reset of the requested type. */
 	ret = driver_desc->device_reset_cb(gasket_dev, reset_type);
 	if (ret) {
-		gasket_log_error(
+		gasket_log_debug(
 			gasket_dev, "Device reset cb returned %d.", ret);
 		return ret;
 	}
@@ -1842,7 +1844,7 @@ int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type)
 
 	ret = gasket_interrupt_reinit(gasket_dev);
 	if (ret) {
-		gasket_log_error(
+		gasket_log_debug(
 			gasket_dev, "Unable to reinit interrupts: %d.", ret);
 		return ret;
 	}
@@ -1850,7 +1852,7 @@ int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type)
 	/* Get current device health. */
 	gasket_dev->status = gasket_get_hw_status(gasket_dev);
 	if (gasket_dev->status == GASKET_STATUS_DEAD) {
-		gasket_log_error(gasket_dev, "Device reported as dead.");
+		gasket_log_debug(gasket_dev, "Device reported as dead.");
 		return -EINVAL;
 	}
 
@@ -2002,7 +2004,7 @@ static ssize_t gasket_sysfs_data_show(
 		}
 		break;
 	default:
-		gasket_log_error(
+		gasket_log_debug(
 			gasket_dev, "Unknown attribute: %s", attr->attr.name);
 		ret = 0;
 		break;
@@ -2056,7 +2058,7 @@ int gasket_wait_with_reschedule(
 		msleep(delay_ms);
 		retries++;
 	}
-	gasket_log_error(gasket_dev, "%s timeout: reg %llx timeout (%llu ms)",
+	gasket_log_debug(gasket_dev, "%s timeout: reg %llx timeout (%llu ms)",
 			 __func__, offset, max_retries * delay_ms);
 	return -ETIMEDOUT;
 }
-- 
2.18.0.233.g985f88cf7e-goog

