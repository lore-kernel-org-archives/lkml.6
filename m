Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E1CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528B82154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrLtqNz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528B82154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeHTMdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:33:54 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:32798 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeHTMdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:33:53 -0400
Received: by mail-pl0-f66.google.com with SMTP id b90-v6so6817084plb.0;
        Mon, 20 Aug 2018 02:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vjJaHpZ9XKwkwSe0ImBezzXQV41i37dC9mr7lQGnEaU=;
        b=SrLtqNz9wLs8LhT5vcH88i0FPNOYDht5FIGhd7wQUfYMLGnvPY4G73saMvhLLsSMTv
         ceehzvPuw9hMBh2pEZu5dy0WESw/ZGEPwTFZovTV3Lebvqsfrw0o+YH+I3APB4IyKr26
         51FTYjoSjFCJrZ8BLbF1dH9qJxejh6CDC32lNL+fPRoazapFsOszWgC1ADs8/eUFID1m
         16GSOkmjcKuRNU1kIEqFz4zaCZJ8kyzVqs/xDjMmDyzy21IfTMjZp4uT8e3l8nW0aSNS
         4U+ft1i3MMs84NYwxSDAFANsJ+vxoW2JfNm5rYSwy+AsjuWwBrN9mA1z0fcF2YKmcQ85
         4w4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vjJaHpZ9XKwkwSe0ImBezzXQV41i37dC9mr7lQGnEaU=;
        b=aUyoYGhvlcPx6dH212BG9JDDbPEgXe9I9uRoErrSsNzipcQ7wREpCVsyHrqbi7FjUI
         0ma9ofnji13ZR4yp4tJWVHhO3q06sp8aZVIgW2q1T16AT3o7KZr21UvBY1xEWTX0A6Di
         JJhgEfbjnxmZq/PDOcPDqqeOlRJ28YSaRAIEFG72pHllxj9L2ZxHcPHw8HzmRITeRDns
         vkjhmMm9hOKMrVmAVuOHD7EZDDQTIkHug1cxdXjj2v4+Ah2NEglO9wbjO40sHc4auNWP
         0JQf/FAYI9cRWGNYwJdlssE0pr0+9T6qo5GYoFHX4GYIOC6QjRBwfjm8pxM+SPwLP0LE
         yFog==
X-Gm-Message-State: AOUpUlH6CU9hqNikt42dh8Hm1ku8AzZ/hA0Tjvzr3c7TPqM66Wkc9por
        Fvt+ysbCVj2H0p9ZoEuioYqSftE=
X-Google-Smtp-Source: AA+uWPzEYn+7E75JQOnkVqnsqSv+jZthBRl/LLfmKddSX8YrGU4yIkvUjMKtMxUqua3ztFohxvxk4A==
X-Received: by 2002:a17:902:925:: with SMTP id 34-v6mr44576775plm.307.1534756742142;
        Mon, 20 Aug 2018 02:19:02 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u11-v6sm16166340pfd.117.2018.08.20.02.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 02:19:01 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] PM/shutdown: device_shutdown() uses the order info in dpm_list instead of devices_kset
Date:   Mon, 20 Aug 2018 17:18:36 +0800
Message-Id: <1534756717-25553-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534756717-25553-1-git-send-email-kernelfans@gmail.com>
References: <1534756717-25553-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, the "parent <- child" and "suppiler <- consumer" ordering info
are stored duplicate in two places dpm_list and devices_kset, and
corresponding, there are two sets of routines to manipulate them. The patch
pushes the dpm_list and dpm_list_mtx out of CONFIG_PM, and let
device_shutdown() use them to implement shutdown seq. Comparing to original
code, this patch tries to simplify the code at the cost of a extra mutex if
without CONFIG_PM and nothing if with CONFIG_PM. The cost on dpm_list_mtx
can be ignored, since the device hot add/remove is not very frequently.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 drivers/base/power/main.c     | 119 ++++++++++++------------------------------
 drivers/base/power/power.h    |  25 +++++----
 drivers/base/power/shutdown.c |  63 +++++++++++++++++++---
 include/linux/pm.h            |   7 +--
 4 files changed, 104 insertions(+), 110 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 3f68e29..7b2f316 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -49,14 +49,12 @@ typedef int (*pm_callback_t)(struct device *);
  * dpm_list_mutex.
  */
 
-LIST_HEAD(dpm_list);
 static LIST_HEAD(dpm_prepared_list);
 static LIST_HEAD(dpm_suspended_list);
 static LIST_HEAD(dpm_late_early_list);
 static LIST_HEAD(dpm_noirq_list);
 
 struct suspend_stats suspend_stats;
-static DEFINE_MUTEX(dpm_list_mtx);
 static pm_message_t pm_transition;
 
 static int async_error;
@@ -98,59 +96,6 @@ void device_pm_sleep_init(struct device *dev)
 	init_completion(&dev->power.completion);
 	complete_all(&dev->power.completion);
 	dev->power.wakeup = NULL;
-	INIT_LIST_HEAD(&dev->power.entry);
-}
-
-/**
- * device_pm_lock - Lock the list of active devices used by the PM core.
- */
-void device_pm_lock(void)
-{
-	mutex_lock(&dpm_list_mtx);
-}
-
-/**
- * device_pm_unlock - Unlock the list of active devices used by the PM core.
- */
-void device_pm_unlock(void)
-{
-	mutex_unlock(&dpm_list_mtx);
-}
-
-/**
- * device_pm_add - Add a device to the PM core's list of active devices.
- * @dev: Device to add to the list.
- */
-void device_pm_add(struct device *dev)
-{
-	pr_debug("PM: Adding info for %s:%s\n",
-		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
-	device_pm_check_callbacks(dev);
-	mutex_lock(&dpm_list_mtx);
-	if (dev->parent && dev->parent->power.is_prepared)
-		dev_warn(dev, "parent %s should not be sleeping\n",
-			dev_name(dev->parent));
-	list_add_tail(&dev->power.entry, &dpm_list);
-	dev->power.in_dpm_list = true;
-	mutex_unlock(&dpm_list_mtx);
-}
-
-/**
- * device_pm_remove - Remove a device from the PM core's list of active devices.
- * @dev: Device to be removed from the list.
- */
-void device_pm_remove(struct device *dev)
-{
-	pr_debug("PM: Removing info for %s:%s\n",
-		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
-	complete_all(&dev->power.completion);
-	mutex_lock(&dpm_list_mtx);
-	list_del_init(&dev->power.entry);
-	dev->power.in_dpm_list = false;
-	mutex_unlock(&dpm_list_mtx);
-	device_wakeup_disable(dev);
-	pm_runtime_remove(dev);
-	device_pm_check_callbacks(dev);
 }
 
 /**
@@ -714,7 +659,7 @@ void dpm_noirq_resume_devices(pm_message_t state)
 	ktime_t starttime = ktime_get();
 
 	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, true);
-	mutex_lock(&dpm_list_mtx);
+	device_pm_lock();
 	pm_transition = state;
 
 	/*
@@ -734,7 +679,7 @@ void dpm_noirq_resume_devices(pm_message_t state)
 		dev = to_device(dpm_noirq_list.next);
 		get_device(dev);
 		list_move_tail(&dev->power.entry, &dpm_late_early_list);
-		mutex_unlock(&dpm_list_mtx);
+		device_pm_unlock();
 
 		if (!is_async(dev)) {
 			int error;
@@ -748,10 +693,10 @@ void dpm_noirq_resume_devices(pm_message_t state)
 			}
 		}
 
-		mutex_lock(&dpm_list_mtx);
+		device_pm_lock();
 		put_device(dev);
 	}
-	mutex_unlock(&dpm_list_mtx);
+	device_pm_unlock();
 	async_synchronize_full();
 	dpm_show_time(starttime, state, 0, "noirq");
 	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false);
@@ -871,7 +816,7 @@ void dpm_resume_early(pm_message_t state)
 	ktime_t starttime = ktime_get();
 
 	trace_suspend_resume(TPS("dpm_resume_early"), state.event, true);
-	mutex_lock(&dpm_list_mtx);
+	device_pm_lock();
 	pm_transition = state;
 
 	/*
@@ -891,7 +836,7 @@ void dpm_resume_early(pm_message_t state)
 		dev = to_device(dpm_late_early_list.next);
 		get_device(dev);
 		list_move_tail(&dev->power.entry, &dpm_suspended_list);
-		mutex_unlock(&dpm_list_mtx);
+		device_pm_unlock();
 
 		if (!is_async(dev)) {
 			int error;
@@ -904,10 +849,10 @@ void dpm_resume_early(pm_message_t state)
 				pm_dev_err(dev, state, " early", error);
 			}
 		}
-		mutex_lock(&dpm_list_mtx);
+		device_pm_lock();
 		put_device(dev);
 	}
-	mutex_unlock(&dpm_list_mtx);
+	device_pm_unlock();
 	async_synchronize_full();
 	dpm_show_time(starttime, state, 0, "early");
 	trace_suspend_resume(TPS("dpm_resume_early"), state.event, false);
@@ -1039,7 +984,7 @@ void dpm_resume(pm_message_t state)
 	trace_suspend_resume(TPS("dpm_resume"), state.event, true);
 	might_sleep();
 
-	mutex_lock(&dpm_list_mtx);
+	device_pm_lock();
 	pm_transition = state;
 	async_error = 0;
 
@@ -1057,7 +1002,7 @@ void dpm_resume(pm_message_t state)
 		if (!is_async(dev)) {
 			int error;
 
-			mutex_unlock(&dpm_list_mtx);
+			device_pm_unlock();
 
 			error = device_resume(dev, state, false);
 			if (error) {
@@ -1067,13 +1012,13 @@ void dpm_resume(pm_message_t state)
 				pm_dev_err(dev, state, "", error);
 			}
 
-			mutex_lock(&dpm_list_mtx);
+			device_pm_lock();
 		}
 		if (!list_empty(&dev->power.entry))
 			list_move_tail(&dev->power.entry, &dpm_prepared_list);
 		put_device(dev);
 	}
-	mutex_unlock(&dpm_list_mtx);
+	device_pm_unlock();
 	async_synchronize_full();
 	dpm_show_time(starttime, state, 0, NULL);
 
@@ -1140,24 +1085,24 @@ void dpm_complete(pm_message_t state)
 	might_sleep();
 
 	INIT_LIST_HEAD(&list);
-	mutex_lock(&dpm_list_mtx);
+	device_pm_lock();
 	while (!list_empty(&dpm_prepared_list)) {
 		struct device *dev = to_device(dpm_prepared_list.prev);
 
 		get_device(dev);
 		dev->power.is_prepared = false;
 		list_move(&dev->power.entry, &list);
-		mutex_unlock(&dpm_list_mtx);
+		device_pm_unlock();
 
 		trace_device_pm_callback_start(dev, "", state.event);
 		device_complete(dev, state);
 		trace_device_pm_callback_end(dev, 0);
 
-		mutex_lock(&dpm_list_mtx);
+		device_pm_lock();
 		put_device(dev);
 	}
 	list_splice(&list, &dpm_list);
-	mutex_unlock(&dpm_list_mtx);
+	device_pm_unlock();
 
 	/* Allow device probing and trigger re-probing of deferred devices */
 	device_unblock_probing();
@@ -1385,7 +1330,7 @@ int dpm_noirq_suspend_devices(pm_message_t state)
 	int error = 0;
 
 	trace_suspend_resume(TPS("dpm_suspend_noirq"), state.event, true);
-	mutex_lock(&dpm_list_mtx);
+	device_pm_lock();
 	pm_transition = state;
 	async_error = 0;
 
@@ -1393,11 +1338,11 @@ int dpm_noirq_suspend_devices(pm_message_t state)
 		struct device *dev = to_device(dpm_late_early_list.prev);
 
 		get_device(dev);
-		mutex_unlock(&dpm_list_mtx);
+		device_pm_unlock();
 
 		error = device_suspend_noirq(dev);
 
-		mutex_lock(&dpm_list_mtx);
+		device_pm_lock();
 		if (error) {
 			pm_dev_err(dev, state, " noirq", error);
 			dpm_save_failed_dev(dev_name(dev));
@@ -1411,7 +1356,7 @@ int dpm_noirq_suspend_devices(pm_message_t state)
 		if (async_error)
 			break;
 	}
-	mutex_unlock(&dpm_list_mtx);
+	device_pm_unlock();
 	async_synchronize_full();
 	if (!error)
 		error = async_error;
@@ -1586,7 +1531,7 @@ int dpm_suspend_late(pm_message_t state)
 	int error = 0;
 
 	trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
-	mutex_lock(&dpm_list_mtx);
+	device_pm_lock();
 	pm_transition = state;
 	async_error = 0;
 
@@ -1594,11 +1539,11 @@ int dpm_suspend_late(pm_message_t state)
 		struct device *dev = to_device(dpm_suspended_list.prev);
 
 		get_device(dev);
-		mutex_unlock(&dpm_list_mtx);
+		device_pm_unlock();
 
 		error = device_suspend_late(dev);
 
-		mutex_lock(&dpm_list_mtx);
+		device_pm_lock();
 		if (!list_empty(&dev->power.entry))
 			list_move(&dev->power.entry, &dpm_late_early_list);
 
@@ -1613,7 +1558,7 @@ int dpm_suspend_late(pm_message_t state)
 		if (async_error)
 			break;
 	}
-	mutex_unlock(&dpm_list_mtx);
+	device_pm_unlock();
 	async_synchronize_full();
 	if (!error)
 		error = async_error;
@@ -1851,18 +1796,18 @@ int dpm_suspend(pm_message_t state)
 
 	cpufreq_suspend();
 
-	mutex_lock(&dpm_list_mtx);
+	device_pm_lock();
 	pm_transition = state;
 	async_error = 0;
 	while (!list_empty(&dpm_prepared_list)) {
 		struct device *dev = to_device(dpm_prepared_list.prev);
 
 		get_device(dev);
-		mutex_unlock(&dpm_list_mtx);
+		device_pm_unlock();
 
 		error = device_suspend(dev);
 
-		mutex_lock(&dpm_list_mtx);
+		device_pm_lock();
 		if (error) {
 			pm_dev_err(dev, state, "", error);
 			dpm_save_failed_dev(dev_name(dev));
@@ -1875,7 +1820,7 @@ int dpm_suspend(pm_message_t state)
 		if (async_error)
 			break;
 	}
-	mutex_unlock(&dpm_list_mtx);
+	device_pm_unlock();
 	async_synchronize_full();
 	if (!error)
 		error = async_error;
@@ -1989,18 +1934,18 @@ int dpm_prepare(pm_message_t state)
 	 */
 	device_block_probing();
 
-	mutex_lock(&dpm_list_mtx);
+	device_pm_lock();
 	while (!list_empty(&dpm_list)) {
 		struct device *dev = to_device(dpm_list.next);
 
 		get_device(dev);
-		mutex_unlock(&dpm_list_mtx);
+		device_pm_unlock();
 
 		trace_device_pm_callback_start(dev, "", state.event);
 		error = device_prepare(dev, state);
 		trace_device_pm_callback_end(dev, error);
 
-		mutex_lock(&dpm_list_mtx);
+		device_pm_lock();
 		if (error) {
 			if (error == -EAGAIN) {
 				put_device(dev);
@@ -2018,7 +1963,7 @@ int dpm_prepare(pm_message_t state)
 			list_move_tail(&dev->power.entry, &dpm_prepared_list);
 		put_device(dev);
 	}
-	mutex_unlock(&dpm_list_mtx);
+	device_pm_unlock();
 	trace_suspend_resume(TPS("dpm_prepare"), state.event, false);
 	return error;
 }
diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index c511def..4578d97 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -1,15 +1,31 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/pm_qos.h>
 
+extern struct mutex dpm_list_mtx;
+
+static inline void device_pm_lock(void)
+{
+	mutex_lock(&dpm_list_mtx);
+}
+
+static inline void device_pm_unlock(void)
+{
+	mutex_unlock(&dpm_list_mtx);
+}
+
 static inline void device_pm_init_common(struct device *dev)
 {
 	if (!dev->power.early_init) {
 		spin_lock_init(&dev->power.lock);
+		INIT_LIST_HEAD(&dev->power.entry);
 		dev->power.qos = NULL;
 		dev->power.early_init = true;
 	}
 }
 
+extern void device_pm_add(struct device *dev);
+extern void device_pm_remove(struct device *dev);
+
 #ifdef CONFIG_PM
 
 static inline void pm_runtime_early_init(struct device *dev)
@@ -104,8 +120,6 @@ static inline struct device *to_device(struct list_head *entry)
 }
 
 extern void device_pm_sleep_init(struct device *dev);
-extern void device_pm_add(struct device *);
-extern void device_pm_remove(struct device *);
 extern void device_pm_move_before(struct device *, struct device *);
 extern void device_pm_move_after(struct device *, struct device *);
 extern void device_pm_move_last(struct device *);
@@ -120,13 +134,6 @@ static inline bool device_pm_initialized(struct device *dev)
 
 static inline void device_pm_sleep_init(struct device *dev) {}
 
-static inline void device_pm_add(struct device *dev) {}
-
-static inline void device_pm_remove(struct device *dev)
-{
-	pm_runtime_remove(dev);
-}
-
 static inline void device_pm_move_before(struct device *deva,
 					 struct device *devb) {}
 static inline void device_pm_move_after(struct device *deva,
diff --git a/drivers/base/power/shutdown.c b/drivers/base/power/shutdown.c
index c405d09..be8e247 100644
--- a/drivers/base/power/shutdown.c
+++ b/drivers/base/power/shutdown.c
@@ -5,6 +5,50 @@
 
 #include "../base.h"
 #include "power.h"
+
+LIST_HEAD(dpm_list);
+DEFINE_MUTEX(dpm_list_mtx);
+
+/**
+ * device_pm_add - Add a device to the PM core's list of active devices.
+ * @dev: Device to add to the list.
+ */
+void device_pm_add(struct device *dev)
+{
+	pr_debug("PM: Adding info for %s:%s\n",
+		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
+	device_pm_check_callbacks(dev);
+	device_pm_lock();
+#ifdef CONFIG_PM_SLEEP
+	if (dev->parent && dev->parent->power.is_prepared)
+		dev_warn(dev, "parent %s should not be sleeping\n",
+			dev_name(dev->parent));
+#endif
+	list_add_tail(&dev->power.entry, &dpm_list);
+	dev->power.in_dpm_list = true;
+	device_pm_unlock();
+}
+
+/**
+ * device_pm_remove - Remove a device from the PM core's list of active devices.
+ * @dev: Device to be removed from the list.
+ */
+void device_pm_remove(struct device *dev)
+{
+	pr_debug("PM: Removing info for %s:%s\n",
+		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
+#ifdef CONFIG_PM_SLEEP
+	complete_all(&dev->power.completion);
+#endif
+	device_pm_lock();
+	list_del_init(&dev->power.entry);
+	dev->power.in_dpm_list = false;
+	device_pm_unlock();
+	device_wakeup_disable(dev);
+	pm_runtime_remove(dev);
+	device_pm_check_callbacks(dev);
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
@@ -15,15 +59,18 @@ void device_shutdown(void)
 	wait_for_device_probe();
 	device_block_probing();
 
-	spin_lock(&devices_kset->list_lock);
+	/*
+	 * only care about race with hotplug. And shutdown excludes suspend
+	 */
+	device_pm_lock();
 	/*
 	 * Walk the devices list backward, shutting down each in turn.
 	 * Beware that device unplug events may also start pulling
 	 * devices offline, even as the system is shutting down.
 	 */
-	while (!list_empty(&devices_kset->list)) {
-		dev = list_entry(devices_kset->list.prev, struct device,
-				kobj.entry);
+	while (!list_empty(&dpm_list)) {
+		dev = list_entry(dpm_list.prev, struct device,
+				power.entry);
 
 		/*
 		 * hold reference count of device's parent to
@@ -36,8 +83,8 @@ void device_shutdown(void)
 		 * Make sure the device is off the kset list, in the
 		 * event that dev->*->shutdown() doesn't remove it.
 		 */
-		list_del_init(&dev->kobj.entry);
-		spin_unlock(&devices_kset->list_lock);
+		list_del_init(&dev->power.entry);
+		device_pm_unlock();
 
 		/* hold lock to avoid race with probe/release */
 		if (parent)
@@ -70,7 +117,7 @@ void device_shutdown(void)
 		put_device(dev);
 		put_device(parent);
 
-		spin_lock(&devices_kset->list_lock);
+		device_pm_lock();
 	}
-	spin_unlock(&devices_kset->list_lock);
+	device_pm_unlock();
 }
diff --git a/include/linux/pm.h b/include/linux/pm.h
index e723b78..77d8a50 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -595,8 +595,8 @@ struct dev_pm_info {
 	bool			direct_complete:1;	/* Owned by the PM core */
 	u32			driver_flags;
 	spinlock_t		lock;
-#ifdef CONFIG_PM_SLEEP
 	struct list_head	entry;
+#ifdef CONFIG_PM_SLEEP
 	struct completion	completion;
 	struct wakeup_source	*wakeup;
 	bool			wakeup_path:1;
@@ -721,7 +721,6 @@ struct dev_pm_domain {
  */
 
 #ifdef CONFIG_PM_SLEEP
-extern void device_pm_lock(void);
 extern void dpm_resume_start(pm_message_t state);
 extern void dpm_resume_end(pm_message_t state);
 extern void dpm_noirq_resume_devices(pm_message_t state);
@@ -731,7 +730,6 @@ extern void dpm_resume_early(pm_message_t state);
 extern void dpm_resume(pm_message_t state);
 extern void dpm_complete(pm_message_t state);
 
-extern void device_pm_unlock(void);
 extern int dpm_suspend_end(pm_message_t state);
 extern int dpm_suspend_start(pm_message_t state);
 extern void dpm_noirq_begin(void);
@@ -778,9 +776,6 @@ extern bool dev_pm_smart_suspend_and_suspended(struct device *dev);
 
 #else /* !CONFIG_PM_SLEEP */
 
-#define device_pm_lock() do {} while (0)
-#define device_pm_unlock() do {} while (0)
-
 static inline int dpm_suspend_start(pm_message_t state)
 {
 	return 0;
-- 
2.7.4

