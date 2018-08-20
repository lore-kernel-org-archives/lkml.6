Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7718C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5447220C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4PdEDE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5447220C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbeHTMdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:33:51 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43285 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeHTMdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:33:50 -0400
Received: by mail-pl0-f66.google.com with SMTP id x6-v6so6800967plv.10;
        Mon, 20 Aug 2018 02:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xpLV1uF+iMUi2sMMOeSI6yl7Ueq8p0sOV2ipQ/5s2+Y=;
        b=P4PdEDE19WID9H6Eb4BMLnIgjF3CTZ0S4OOq7TTEP+4AK0RdgEDOxVVGdLtEA9vhNV
         eufwxf0ThDB0CggqwwUlZ9G2ery0hNdbNgqQi5vDoGZ0lym682AhZyrd5wNoeCaZpEb4
         ddVt7T46IL71BcNJFe/3jJ12YhD9nKABwZzrk8wSKDDoFMmTlcagilrLEKrQ1a5XvawO
         zdrgOU84XuuQxwlI4Pc5lsvGDFTthb02bizxTvb2+Gv/ggNNBIU6zTRmHrOWOcInt20D
         3AEItpE6AekXLRsXU7pwGtsqwRde/KcGNDxLwK09Gx6ga5H4VHbQ1y6SeBkdK0dArOSq
         LI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xpLV1uF+iMUi2sMMOeSI6yl7Ueq8p0sOV2ipQ/5s2+Y=;
        b=qTMPJYVx7TrMFI9k7M4n4hlYWRtI+/vpo2S7kX+gnqRotj1jmZLzCLGMCcGEausO0A
         833MMUqNOe1fbrybEhRpiQAb/1oT2l2k1F9vUL9tla477nzka4l/mKo9bD2PSpdi/xtn
         4btoKfJwoGAF53jmkDscL7ih2b3O9RW3XOrUmUIxpcFa6Rv5/GF9Py/MROklMne0fPcL
         pXXjRTZLNBZk392SkZvLOH4Mwpo9U+nEmHyq9/oPHa7QiqF7LiLPH6Y2EkYL04/yZtwg
         Ko2V/N4OA8i1NbR8Zgd4RGLWGabo+2nmPopOldfgYEbw5ZoAnDbRAJl6QuVVIERsIITP
         1MLw==
X-Gm-Message-State: AOUpUlFfTw0iKdRwN16VkQLyRHsKDGrJH1GeOznAwqYW/7uX2eF0x4df
        oT4X0FmBwYqj4snIvCkvvRzcvIs=
X-Google-Smtp-Source: AA+uWPw6rYa5U+uR4eEBOF10NUfUqdl0wzV9i+CgbW/C3U5/qEpB+dZszxvh8Vc+azaXz/tE011fsA==
X-Received: by 2002:a17:902:3a2:: with SMTP id d31-v6mr45041414pld.287.1534756739220;
        Mon, 20 Aug 2018 02:18:59 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u11-v6sm16166340pfd.117.2018.08.20.02.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 02:18:58 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drivers/base: move device_shutdown() to base/power
Date:   Mon, 20 Aug 2018 17:18:35 +0800
Message-Id: <1534756717-25553-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534756717-25553-1-git-send-email-kernelfans@gmail.com>
References: <1534756717-25553-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider the shutdown as a system state transition, i.e. something like
suspend, hibernate, hence move it under the base/power. (This is a first
step to unify the duplicate code logic on devices_kset and dpm_list.)

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 drivers/base/core.c           | 70 ---------------------------------------
 drivers/base/power/Makefile   |  1 +
 drivers/base/power/shutdown.c | 76 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 70 deletions(-)
 create mode 100644 drivers/base/power/shutdown.c

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 04bbcd7..7c83384 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2854,76 +2854,6 @@ int device_move(struct device *dev, struct device *new_parent,
 }
 EXPORT_SYMBOL_GPL(device_move);
 
-/**
- * device_shutdown - call ->shutdown() on each device to shutdown.
- */
-void device_shutdown(void)
-{
-	struct device *dev, *parent;
-
-	wait_for_device_probe();
-	device_block_probing();
-
-	spin_lock(&devices_kset->list_lock);
-	/*
-	 * Walk the devices list backward, shutting down each in turn.
-	 * Beware that device unplug events may also start pulling
-	 * devices offline, even as the system is shutting down.
-	 */
-	while (!list_empty(&devices_kset->list)) {
-		dev = list_entry(devices_kset->list.prev, struct device,
-				kobj.entry);
-
-		/*
-		 * hold reference count of device's parent to
-		 * prevent it from being freed because parent's
-		 * lock is to be held
-		 */
-		parent = get_device(dev->parent);
-		get_device(dev);
-		/*
-		 * Make sure the device is off the kset list, in the
-		 * event that dev->*->shutdown() doesn't remove it.
-		 */
-		list_del_init(&dev->kobj.entry);
-		spin_unlock(&devices_kset->list_lock);
-
-		/* hold lock to avoid race with probe/release */
-		if (parent)
-			device_lock(parent);
-		device_lock(dev);
-
-		/* Don't allow any more runtime suspends */
-		pm_runtime_get_noresume(dev);
-		pm_runtime_barrier(dev);
-
-		if (dev->class && dev->class->shutdown_pre) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown_pre\n");
-			dev->class->shutdown_pre(dev);
-		}
-		if (dev->bus && dev->bus->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->bus->shutdown(dev);
-		} else if (dev->driver && dev->driver->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->driver->shutdown(dev);
-		}
-
-		device_unlock(dev);
-		if (parent)
-			device_unlock(parent);
-
-		put_device(dev);
-		put_device(parent);
-
-		spin_lock(&devices_kset->list_lock);
-	}
-	spin_unlock(&devices_kset->list_lock);
-}
-
 /*
  * Device logging functions
  */
diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index e1bb691..057ddbf 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-y	+= shutdown.o
 obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o common.o qos.o runtime.o wakeirq.o
 obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
diff --git a/drivers/base/power/shutdown.c b/drivers/base/power/shutdown.c
new file mode 100644
index 0000000..c405d09
--- /dev/null
+++ b/drivers/base/power/shutdown.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+
+#include "../base.h"
+#include "power.h"
+/**
+ * device_shutdown - call ->shutdown() on each device to shutdown.
+ */
+void device_shutdown(void)
+{
+	struct device *dev, *parent;
+
+	wait_for_device_probe();
+	device_block_probing();
+
+	spin_lock(&devices_kset->list_lock);
+	/*
+	 * Walk the devices list backward, shutting down each in turn.
+	 * Beware that device unplug events may also start pulling
+	 * devices offline, even as the system is shutting down.
+	 */
+	while (!list_empty(&devices_kset->list)) {
+		dev = list_entry(devices_kset->list.prev, struct device,
+				kobj.entry);
+
+		/*
+		 * hold reference count of device's parent to
+		 * prevent it from being freed because parent's
+		 * lock is to be held
+		 */
+		parent = get_device(dev->parent);
+		get_device(dev);
+		/*
+		 * Make sure the device is off the kset list, in the
+		 * event that dev->*->shutdown() doesn't remove it.
+		 */
+		list_del_init(&dev->kobj.entry);
+		spin_unlock(&devices_kset->list_lock);
+
+		/* hold lock to avoid race with probe/release */
+		if (parent)
+			device_lock(parent);
+		device_lock(dev);
+
+		/* Don't allow any more runtime suspends */
+		pm_runtime_get_noresume(dev);
+		pm_runtime_barrier(dev);
+
+		if (dev->class && dev->class->shutdown_pre) {
+			if (initcall_debug)
+				dev_info(dev, "shutdown_pre\n");
+			dev->class->shutdown_pre(dev);
+		}
+		if (dev->bus && dev->bus->shutdown) {
+			if (initcall_debug)
+				dev_info(dev, "shutdown\n");
+			dev->bus->shutdown(dev);
+		} else if (dev->driver && dev->driver->shutdown) {
+			if (initcall_debug)
+				dev_info(dev, "shutdown\n");
+			dev->driver->shutdown(dev);
+		}
+
+		device_unlock(dev);
+		if (parent)
+			device_unlock(parent);
+
+		put_device(dev);
+		put_device(parent);
+
+		spin_lock(&devices_kset->list_lock);
+	}
+	spin_unlock(&devices_kset->list_lock);
+}
-- 
2.7.4

