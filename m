Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C621C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7BB2148E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH9dw5Jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7BB2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbeHBKdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:33:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42395 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbeHBKdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:33:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id l9-v6so893233pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 01:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f1kHrX6yr8618+B1fyR7WDZRA65nQgxP/8qCsSCQ9UM=;
        b=UH9dw5Jz31gD3qRw5Nf/4xSSYMkmxyqOwzhExJ/BbU/S5FMUehvJ0nU3DUz/YGZloD
         oUdfd8ZRJi5CL2bGWYoQHKZRQTjqImXBeAKRlB54AkUM6Qzb7dfljUkYVmRn7oNeXkoa
         525NphYNtno0VcqenWlwNS2yBB7W35nP1v2sitMjonk6yl2ZWpX/wvWDjlreyz4Nu+Au
         r4UWxJ8vysjWbcG6i7g0VTTU//wrF85KWbLothDBXe80B8JOG9A5GXifGRyWc1WGFpGo
         hKS/T6PBl0dJP5Gk7JDgFu2p5/CPkNgpMLLszAScV3+6CS0yikc0jOjTRltNO9Q4SMI7
         IwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f1kHrX6yr8618+B1fyR7WDZRA65nQgxP/8qCsSCQ9UM=;
        b=mPoc0Z/OLGEDBtHP7Ln6I1oLJiCFR5kwWOPM38Gfv/0GUTab4qdV0zo344BQxpiIrw
         26hNsvUZ15nFVjU7ajRE7BpxlsJGH+ug2NaN82TpU0BZQel27j0KnJsHhPFEGnrv9ApA
         oFNk5ns7NFo8PuKIFiy7ve+u5MbMRLuDd+VlcjDCIZuVAcztLIx8jw5o3urGpCwDjlQB
         MmeMzDx8VWZ1HfFhJOFwvAFAAooDLx8gGOkTuhK6G9EqRJscL8euAPeRGJaCMyqQpPhC
         AATqdti6IkG6+DwiDRjwudXv1GZhiycd3Yr1HDw10YbCyLMqhAuJX40Tx+4B7CUl1RiP
         KQVQ==
X-Gm-Message-State: AOUpUlFvP4s/lhx8kLck69U4L7sYnh7IR8u4hnT+OKlZ065XGQKVoz4a
        hF17yIYFia+NzjqwUgjYEFc=
X-Google-Smtp-Source: AAOMgpdu9QXQxVvfV97h2YTmBsCmtIpnHs/hnaoAOgSkfAQDNA3ebAJn7yTxJs8Qc1QpqF2R5D+onw==
X-Received: by 2002:a63:6188:: with SMTP id v130-v6mr1849791pgb.100.1533199386852;
        Thu, 02 Aug 2018 01:43:06 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id q21-v6sm2128397pfl.156.2018.08.02.01.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 01:43:06 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 6/8] staging: gasket: remove "reset type" param from framework
Date:   Thu,  2 Aug 2018 01:42:43 -0700
Message-Id: <20180802084245.239689-7-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180802084245.239689-1-toddpoynor@gmail.com>
References: <20180802084245.239689-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

The "type of reset" parameter to the gasket device reset APIs isn't
required by the only gasket device submitted upstream, apex.

The framework documents the param as private to the device driver and a
pass-through at the gasket layer, but the gasket core calls the device
driver with a hardcoded reset type of zero, which is not documented as
having a predefined meaning.

In light of all this, remove the reset type parameter from the
framework.  Remove the reset ioctl reset type parameter, and bump the
framework version number to reflect the interface change.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket.h           |  4 ++--
 drivers/staging/gasket/gasket_constants.h |  2 +-
 drivers/staging/gasket/gasket_core.c      | 11 +++++------
 drivers/staging/gasket/gasket_core.h      | 13 +++----------
 drivers/staging/gasket/gasket_ioctl.c     |  3 +--
 5 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/gasket/gasket.h b/drivers/staging/gasket/gasket.h
index 9f709f0c5a2bb..a0f065c517a52 100644
--- a/drivers/staging/gasket/gasket.h
+++ b/drivers/staging/gasket/gasket.h
@@ -52,8 +52,8 @@ struct gasket_coherent_alloc_config_ioctl {
 /* Base number for all Gasket-common IOCTLs */
 #define GASKET_IOCTL_BASE 0xDC
 
-/* Reset the device using the specified reset type. */
-#define GASKET_IOCTL_RESET _IOW(GASKET_IOCTL_BASE, 0, unsigned long)
+/* Reset the device. */
+#define GASKET_IOCTL_RESET _IO(GASKET_IOCTL_BASE, 0)
 
 /* Associate the specified [event]fd with the specified interrupt. */
 #define GASKET_IOCTL_SET_EVENTFD                                               \
diff --git a/drivers/staging/gasket/gasket_constants.h b/drivers/staging/gasket/gasket_constants.h
index 82ed3f21e8aed..50d87c7b178c2 100644
--- a/drivers/staging/gasket/gasket_constants.h
+++ b/drivers/staging/gasket/gasket_constants.h
@@ -3,7 +3,7 @@
 #ifndef __GASKET_CONSTANTS_H__
 #define __GASKET_CONSTANTS_H__
 
-#define GASKET_FRAMEWORK_VERSION "1.1.1"
+#define GASKET_FRAMEWORK_VERSION "1.1.2"
 
 /*
  * The maximum number of simultaneous device types supported by the framework.
diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 19331feb9b09f..99994e30b154b 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1295,7 +1295,7 @@ static int gasket_release(struct inode *inode, struct file *file)
 			ownership->owner = 0;
 
 			/* Forces chip reset before we unmap the page tables. */
-			driver_desc->device_reset_cb(gasket_dev, 0);
+			driver_desc->device_reset_cb(gasket_dev);
 
 			for (i = 0; i < driver_desc->num_page_tables; ++i) {
 				gasket_page_table_unmap_all(gasket_dev->page_table[i]);
@@ -1623,18 +1623,18 @@ const char *gasket_num_name_lookup(uint num,
 }
 EXPORT_SYMBOL(gasket_num_name_lookup);
 
-int gasket_reset(struct gasket_dev *gasket_dev, uint reset_type)
+int gasket_reset(struct gasket_dev *gasket_dev)
 {
 	int ret;
 
 	mutex_lock(&gasket_dev->mutex);
-	ret = gasket_reset_nolock(gasket_dev, reset_type);
+	ret = gasket_reset_nolock(gasket_dev);
 	mutex_unlock(&gasket_dev->mutex);
 	return ret;
 }
 EXPORT_SYMBOL(gasket_reset);
 
-int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type)
+int gasket_reset_nolock(struct gasket_dev *gasket_dev)
 {
 	int ret;
 	int i;
@@ -1644,8 +1644,7 @@ int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type)
 	if (!driver_desc->device_reset_cb)
 		return 0;
 
-	/* Perform a device reset of the requested type. */
-	ret = driver_desc->device_reset_cb(gasket_dev, reset_type);
+	ret = driver_desc->device_reset_cb(gasket_dev);
 	if (ret) {
 		dev_dbg(gasket_dev->dev, "Device reset cb returned %d.\n",
 			ret);
diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 713bf42de41a4..67f5960943a8a 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -580,17 +580,12 @@ struct gasket_driver_desc {
 	/*
 	 * device_reset_cb: Reset the hardware in question.
 	 * @dev: Pointer to the gasket_dev structure for this device.
-	 * @type: Integer representing reset type. (All
-	 * Gasket resets have an integer representing their type
-	 * defined in (device)_ioctl.h; the specific resets are
-	 * device-dependent, but are handled in the device-specific
-	 * callback anyways.)
 	 *
 	 * Called by reset ioctls. This function should not
 	 * lock the gasket_dev mutex. It should return 0 on success
 	 * and an error on failure.
 	 */
-	int (*device_reset_cb)(struct gasket_dev *dev, uint reset_type);
+	int (*device_reset_cb)(struct gasket_dev *dev);
 };
 
 /*
@@ -615,15 +610,13 @@ void gasket_unregister_device(const struct gasket_driver_desc *desc);
 /*
  * Reset the Gasket device.
  * @gasket_dev: Gasket device struct.
- * @reset_type: Uint representing requested reset type. Should be
- * valid in the underlying callback.
  *
  * Calls device_reset_cb. Returns 0 on success and an error code othewrise.
  * gasket_reset_nolock will not lock the mutex, gasket_reset will.
  *
  */
-int gasket_reset(struct gasket_dev *gasket_dev, uint reset_type);
-int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type);
+int gasket_reset(struct gasket_dev *gasket_dev);
+int gasket_reset_nolock(struct gasket_dev *gasket_dev);
 
 /*
  * Memory management functions. These will likely be spun off into their own
diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index d3397cc74e69f..0ca48e688818f 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -304,8 +304,7 @@ long gasket_handle_ioctl(struct file *filp, uint cmd, void __user *argp)
 	 */
 	switch (cmd) {
 	case GASKET_IOCTL_RESET:
-		trace_gasket_ioctl_integer_data(arg);
-		retval = gasket_reset(gasket_dev, arg);
+		retval = gasket_reset(gasket_dev);
 		break;
 	case GASKET_IOCTL_SET_EVENTFD:
 		retval = gasket_set_event_fd(gasket_dev, argp);
-- 
2.18.0.597.ga71716f1ad-goog

