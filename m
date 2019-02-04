Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9527C282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7262073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqEDdvyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfBDUdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:33:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54355 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729545AbfBDUdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:33:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so1309022wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 12:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gPO7VADXgilIuhPfkLOPfkHU43fHUEuVMJbhGFD6lro=;
        b=AqEDdvyp4bDexBG2p8xfmktCOmCd4ZezeU3ksyhsWTyVuyRZ0XOWM8p+ZcBGSR5OIo
         BIwCKTV0djUW6BatekqI1b2c5dXTnfjkbnzJH1BgbBnAEX7bY/fat1Og7fTSzqm3yvGS
         yem9/TGg4AILZK4VGe4cYhPE2EL9qOUX9jprYX8XTB1YlwIJzaMcK0XxgicZl2pF1d2g
         AGe1Ridlzk2r/yx1pbTehQe/tKBIyN9wxZCm2aesQhYmU1YLKFetOBkd6a1gBD2D8j3U
         vftoenRfvmo2wQSmpvOhRk1hmsG6GhtLyptiGfqxgnCb2iJFqXYp93PxzUzPeRHlDSoc
         BUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gPO7VADXgilIuhPfkLOPfkHU43fHUEuVMJbhGFD6lro=;
        b=Pw+MQE6anVRKj2Q52VoF/fb2vmrpMhSRCwP6qxoiwb53kT1yFpNOfAGRQxAd4Z9AXk
         WFUwm/XTW0wVLXypBMXACsqbTwPr/s6laEMU9bhPf9qw5qvEePR57+XvvZitzL+IDGGC
         gvKZa/lywWlelM9kUyLnQ/xWL9EaeQtUINGJhNYfMdFmY6Jd32sGApmUdC5zIp9gMwHM
         oO3QJmmFYB9Sz3HUVbZ7nLH+utLlKvta8QonrbfmxMf3ndbYtEbi//oJHTfD+Dwh+eTF
         LOD51mvJTuacCivksj+qL6Hc7JqfLrWtgYLKvyhndt4nuEH8XnZd59j8Zu2wRPWAfcJn
         +PYQ==
X-Gm-Message-State: AHQUAuYm5PYJNGLLbxXZqdbpyC3wDZkJbswVawwWHS7gwSkbLRrwhDpD
        KwvCMA2CpahrLfODXZ32OaM=
X-Google-Smtp-Source: AHgI3IaKzcVir/RJVlMTZ47TDZ0l3nfw1LxSuOAA/5dyiBlVH7kXgohSj2zVJDi42dKzSD52mHnvvg==
X-Received: by 2002:a1c:f518:: with SMTP id t24mr912802wmh.26.1549312399267;
        Mon, 04 Feb 2019 12:33:19 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j24sm19990792wrd.86.2019.02.04.12.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 12:33:18 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, rppt@linux.ibm.com
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v3 10/15] habanalabs: add device reset support
Date:   Mon,  4 Feb 2019 22:32:49 +0200
Message-Id: <20190204203254.4026-11-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190204203254.4026-1-oded.gabbay@gmail.com>
References: <20190204203254.4026-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for doing various on-the-fly reset of Goya.

The driver supports two types of resets:
1. soft-reset
2. hard-reset

Soft-reset is done when the device detects a timeout of a command
submission that was given to the device. The soft-reset process only resets
the engines that are relevant for the submission of compute jobs, i.e. the
DMA channels, the TPCs and the MME. The purpose is to bring the device as
fast as possible to a working state.

Hard-reset is done in several cases:
1. After soft-reset is done but the device is not responding
2. When fatal errors occur inside the device, e.g. ECC error
3. When the driver is removed

Hard-reset performs a reset of the entire chip except for the PCI
controller and the PLLs. It is a much longer process then soft-reset but it
helps to recover the device without the need to reboot the Host.

After hard-reset, the driver will restore the max power attribute and in
case of manual power management, the frequencies that were set.

This patch also adds two entries to the sysfs, which allows the root user
to initiate a soft or hard reset.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
Changes in v3:
  - Remove use of three exclamation marks
  - Add "init_done" field to hl_device to mark that initialization is done.
    This field is used in the reset function to avoid doing reset during
    initialization phase. This is instead of setting the in_reset atomic
    field to 1 during initialization, which is conceptually not accurate.
 
 drivers/misc/habanalabs/command_buffer.c   |   9 +-
 drivers/misc/habanalabs/device.c           | 317 ++++++++++++++++++++-
 drivers/misc/habanalabs/goya/goya.c        | 210 ++++++++++++++
 drivers/misc/habanalabs/goya/goya_hwmgr.c  |  18 +-
 drivers/misc/habanalabs/habanalabs.h       |  38 +++
 drivers/misc/habanalabs/habanalabs_drv.c   |   9 +-
 drivers/misc/habanalabs/habanalabs_ioctl.c |   6 +
 drivers/misc/habanalabs/hwmon.c            |   4 +-
 drivers/misc/habanalabs/irq.c              |  31 ++
 drivers/misc/habanalabs/sysfs.c            | 120 +++++++-
 10 files changed, 737 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/habanalabs/command_buffer.c b/drivers/misc/habanalabs/command_buffer.c
index 20adba5f9d0c..c70b548a7b8a 100644
--- a/drivers/misc/habanalabs/command_buffer.c
+++ b/drivers/misc/habanalabs/command_buffer.c
@@ -89,9 +89,14 @@ int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 	bool alloc_new_cb = true;
 	int rc;
 
-	if (hdev->disabled) {
+	/*
+	 * Can't use generic function to check this because of special case
+	 * where we create a CB as part of the reset process
+	 */
+	if ((hdev->disabled) || ((atomic_read(&hdev->in_reset)) &&
+					(ctx_id != HL_KERNEL_ASID_ID))) {
 		dev_warn_ratelimited(hdev->dev,
-			"Device is disabled. Can't create new CBs\n");
+			"Device is disabled or in reset. Can't create new CBs\n");
 		rc = -EBUSY;
 		goto out_err;
 	}
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 5cb54cbd8502..d64c250feb1c 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -11,6 +11,14 @@
 #include <linux/kthread.h>
 #include <linux/sched/signal.h>
 
+bool hl_device_disabled_or_in_reset(struct hl_device *hdev)
+{
+	if ((hdev->disabled) || (atomic_read(&hdev->in_reset)))
+		return true;
+	else
+		return false;
+}
+
 static void hpriv_release(struct kref *ref)
 {
 	struct hl_fpriv *hpriv;
@@ -193,6 +201,7 @@ static int device_early_init(struct hl_device *hdev)
 
 	mutex_init(&hdev->fd_open_cnt_lock);
 	mutex_init(&hdev->send_cpu_message_lock);
+	atomic_set(&hdev->in_reset, 0);
 	atomic_set(&hdev->fd_open_cnt, 0);
 
 	return 0;
@@ -243,6 +252,27 @@ static void set_freq_to_low_job(struct work_struct *work)
 			usecs_to_jiffies(HL_PLL_LOW_JOB_FREQ_USEC));
 }
 
+static void hl_device_heartbeat(struct work_struct *work)
+{
+	struct hl_device *hdev = container_of(work, struct hl_device,
+						work_heartbeat.work);
+
+	if (hl_device_disabled_or_in_reset(hdev))
+		goto reschedule;
+
+	if (!hdev->asic_funcs->send_heartbeat(hdev))
+		goto reschedule;
+
+	dev_err(hdev->dev, "Device heartbeat failed!\n");
+	hl_device_reset(hdev, true, false);
+
+	return;
+
+reschedule:
+	schedule_delayed_work(&hdev->work_heartbeat,
+			usecs_to_jiffies(HL_HEARTBEAT_PER_USEC));
+}
+
 /*
  * device_late_init - do late stuff initialization for the habanalabs device
  *
@@ -278,6 +308,12 @@ static int device_late_init(struct hl_device *hdev)
 	schedule_delayed_work(&hdev->work_freq,
 			usecs_to_jiffies(HL_PLL_LOW_JOB_FREQ_USEC));
 
+	if (hdev->heartbeat) {
+		INIT_DELAYED_WORK(&hdev->work_heartbeat, hl_device_heartbeat);
+		schedule_delayed_work(&hdev->work_heartbeat,
+				usecs_to_jiffies(HL_HEARTBEAT_PER_USEC));
+	}
+
 	hdev->late_init_done = true;
 
 	return 0;
@@ -295,6 +331,8 @@ static void device_late_fini(struct hl_device *hdev)
 		return;
 
 	cancel_delayed_work_sync(&hdev->work_freq);
+	if (hdev->heartbeat)
+		cancel_delayed_work_sync(&hdev->work_heartbeat);
 
 	if (hdev->asic_funcs->late_fini)
 		hdev->asic_funcs->late_fini(hdev);
@@ -402,6 +440,260 @@ int hl_device_resume(struct hl_device *hdev)
 	return 0;
 }
 
+static void hl_device_hard_reset_pending(struct work_struct *work)
+{
+	struct hl_device_reset_work *device_reset_work =
+		container_of(work, struct hl_device_reset_work, reset_work);
+	struct hl_device *hdev = device_reset_work->hdev;
+	u16 pending_cnt = HL_PENDING_RESET_PER_SEC;
+	struct task_struct *task = NULL;
+
+	/* Flush all processes that are inside hl_open */
+	mutex_lock(&hdev->fd_open_cnt_lock);
+
+	while ((atomic_read(&hdev->fd_open_cnt)) && (pending_cnt)) {
+
+		pending_cnt--;
+
+		dev_info(hdev->dev,
+			"Can't HARD reset, waiting for user to close FD\n");
+		ssleep(1);
+	}
+
+	if (atomic_read(&hdev->fd_open_cnt)) {
+		task = get_pid_task(hdev->user_ctx->hpriv->taskpid,
+					PIDTYPE_PID);
+		if (task) {
+			dev_info(hdev->dev, "Killing user processes\n");
+			send_sig(SIGKILL, task, 1);
+			msleep(100);
+
+			put_task_struct(task);
+		}
+	}
+
+	mutex_unlock(&hdev->fd_open_cnt_lock);
+
+	hl_device_reset(hdev, true, true);
+
+	kfree(device_reset_work);
+}
+
+/*
+ * hl_device_reset - reset the device
+ *
+ * @hdev: pointer to habanalabs device structure
+ * @hard_reset: should we do hard reset to all engines or just reset the
+ *              compute/dma engines
+ *
+ * Block future CS and wait for pending CS to be enqueued
+ * Call ASIC H/W fini
+ * Flush all completions
+ * Re-initialize all internal data structures
+ * Call ASIC H/W init, late_init
+ * Test queues
+ * Enable device
+ *
+ * Returns 0 for success or an error on failure.
+ */
+int hl_device_reset(struct hl_device *hdev, bool hard_reset,
+			bool from_hard_reset_thread)
+{
+	int i, rc;
+
+	if (!hdev->init_done) {
+		dev_err(hdev->dev,
+			"Can't reset before initialization is done\n");
+		return 0;
+	}
+
+	/*
+	 * Prevent concurrency in this function - only one reset should be
+	 * done at any given time. Only need to perform this if we didn't
+	 * get from the dedicated hard reset thread
+	 */
+	if (!from_hard_reset_thread) {
+		/* Block future CS/VM/JOB completion operations */
+		rc = atomic_cmpxchg(&hdev->in_reset, 0, 1);
+		if (rc)
+			return 0;
+
+		/* This also blocks future CS/VM/JOB completion operations */
+		hdev->disabled = true;
+
+		/*
+		 * Flush anyone that is inside the critical section of enqueue
+		 * jobs to the H/W
+		 */
+		hdev->asic_funcs->hw_queues_lock(hdev);
+		hdev->asic_funcs->hw_queues_unlock(hdev);
+
+		dev_err(hdev->dev, "Going to RESET device!\n");
+	}
+
+again:
+	if ((hard_reset) && (!from_hard_reset_thread)) {
+		struct hl_device_reset_work *device_reset_work;
+
+		if (!hdev->pdev) {
+			dev_err(hdev->dev,
+				"Reset action is NOT supported in simulator\n");
+			rc = -EINVAL;
+			goto out_err;
+		}
+
+		hdev->hard_reset_pending = true;
+
+		device_reset_work = kzalloc(sizeof(*device_reset_work),
+						GFP_ATOMIC);
+		if (!device_reset_work) {
+			rc = -ENOMEM;
+			goto out_err;
+		}
+
+		/*
+		 * Because the reset function can't run from interrupt or
+		 * from heartbeat work, we need to call the reset function
+		 * from a dedicated work
+		 */
+		INIT_WORK(&device_reset_work->reset_work,
+				hl_device_hard_reset_pending);
+		device_reset_work->hdev = hdev;
+		schedule_work(&device_reset_work->reset_work);
+
+		return 0;
+	}
+
+	if (hard_reset) {
+		device_late_fini(hdev);
+
+		/*
+		 * Now that the heartbeat thread is closed, flush processes
+		 * which are sending messages to CPU
+		 */
+		mutex_lock(&hdev->send_cpu_message_lock);
+		mutex_unlock(&hdev->send_cpu_message_lock);
+	}
+
+	/*
+	 * Halt the engines and disable interrupts so we won't get any more
+	 * completions from H/W and we won't have any accesses from the
+	 * H/W to the host machine
+	 */
+	hdev->asic_funcs->halt_engines(hdev, hard_reset);
+
+	if (hard_reset) {
+		/* Release kernel context */
+		if (hl_ctx_put(hdev->kernel_ctx) != 1) {
+			dev_err(hdev->dev,
+				"kernel ctx is alive during hard reset\n");
+			rc = -EBUSY;
+			goto out_err;
+		}
+
+		hdev->kernel_ctx = NULL;
+	}
+
+	/* Reset the H/W. It will be in idle state after this returns */
+	hdev->asic_funcs->hw_fini(hdev, hard_reset);
+
+	if (hard_reset)
+		hl_eq_reset(hdev, &hdev->event_queue);
+
+	/* Re-initialize PI,CI to 0 in all queues (hw queue, cq) */
+	hl_hw_queue_reset(hdev, hard_reset);
+	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
+		hl_cq_reset(hdev, &hdev->completion_queue[i]);
+
+	/* Finished tear-down, starting to re-initialize */
+
+	if (hard_reset) {
+		/* Allocate the kernel context */
+		hdev->kernel_ctx = kzalloc(sizeof(*hdev->kernel_ctx),
+						GFP_KERNEL);
+		if (!hdev->kernel_ctx) {
+			rc = -ENOMEM;
+			goto out_err;
+		}
+
+		hdev->user_ctx = NULL;
+
+		rc = hl_ctx_init(hdev, hdev->kernel_ctx, true);
+		if (rc) {
+			dev_err(hdev->dev,
+				"failed to init kernel ctx in hard reset\n");
+			kfree(hdev->kernel_ctx);
+			hdev->kernel_ctx = NULL;
+			goto out_err;
+		}
+	}
+
+	rc = hdev->asic_funcs->hw_init(hdev);
+	if (rc) {
+		dev_err(hdev->dev,
+			"failed to initialize the H/W after reset\n");
+		goto out_err;
+	}
+
+	hdev->disabled = false;
+
+	/* Check that the communication with the device is working */
+	rc = hdev->asic_funcs->test_queues(hdev);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to detect if device is alive after reset\n");
+		goto out_err;
+	}
+
+	if (hard_reset) {
+		rc = device_late_init(hdev);
+		if (rc) {
+			dev_err(hdev->dev,
+				"Failed late init after hard reset\n");
+			goto out_err;
+		}
+
+		hl_set_max_power(hdev, hdev->max_power);
+
+		hdev->hard_reset_pending = false;
+	} else {
+		rc = hdev->asic_funcs->soft_reset_late_init(hdev);
+		if (rc) {
+			dev_err(hdev->dev,
+				"Failed late init after soft reset\n");
+			goto out_err;
+		}
+	}
+
+	atomic_set(&hdev->in_reset, 0);
+
+	if (hard_reset)
+		hdev->hard_reset_cnt++;
+	else
+		hdev->soft_reset_cnt++;
+
+	return 0;
+
+out_err:
+	hdev->disabled = true;
+
+	if (hard_reset) {
+		dev_err(hdev->dev,
+			"Failed to reset! Device is NOT usable\n");
+		hdev->hard_reset_cnt++;
+	} else {
+		dev_err(hdev->dev,
+			"Failed to do soft-reset, trying hard reset\n");
+		hdev->soft_reset_cnt++;
+		hard_reset = true;
+		goto again;
+	}
+
+	atomic_set(&hdev->in_reset, 0);
+
+	return rc;
+}
+
 /*
  * hl_device_init - main initialization function for habanalabs device
  *
@@ -549,6 +841,8 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	dev_notice(hdev->dev,
 		"Successfully added device to habanalabs driver\n");
 
+	hdev->init_done = true;
+
 	return 0;
 
 free_cb_pool:
@@ -596,9 +890,30 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
  */
 void hl_device_fini(struct hl_device *hdev)
 {
-	int i;
+	int i, rc;
+	ktime_t timeout;
+
 	dev_info(hdev->dev, "Removing device\n");
 
+	/*
+	 * This function is competing with the reset function, so try to
+	 * take the reset atomic and if we are already in middle of reset,
+	 * wait until reset function is finished. Reset function is designed
+	 * to always finish (could take up to a few seconds in worst case).
+	 */
+
+	timeout = ktime_add_us(ktime_get(),
+				HL_PENDING_RESET_PER_SEC * 1000 * 1000 * 4);
+	rc = atomic_cmpxchg(&hdev->in_reset, 0, 1);
+	while (rc) {
+		usleep_range(50, 200);
+		rc = atomic_cmpxchg(&hdev->in_reset, 0, 1);
+		if (ktime_compare(ktime_get(), timeout) > 0) {
+			WARN(1, "Failed to remove device because reset function did not finish\n");
+			return;
+		}
+	};
+
 	/* Mark device as disabled */
 	hdev->disabled = true;
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index dd6366c6d309..ee573b649ed9 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -127,6 +127,130 @@ static const char *goya_axi_name[GOYA_MAX_INITIATORS] = {
 
 #define GOYA_ASYC_EVENT_GROUP_NON_FATAL_SIZE 121
 
+static u32 goya_non_fatal_events[GOYA_ASYC_EVENT_GROUP_NON_FATAL_SIZE] = {
+	GOYA_ASYNC_EVENT_ID_PCIE_IF,
+	GOYA_ASYNC_EVENT_ID_TPC0_ECC,
+	GOYA_ASYNC_EVENT_ID_TPC1_ECC,
+	GOYA_ASYNC_EVENT_ID_TPC2_ECC,
+	GOYA_ASYNC_EVENT_ID_TPC3_ECC,
+	GOYA_ASYNC_EVENT_ID_TPC4_ECC,
+	GOYA_ASYNC_EVENT_ID_TPC5_ECC,
+	GOYA_ASYNC_EVENT_ID_TPC6_ECC,
+	GOYA_ASYNC_EVENT_ID_TPC7_ECC,
+	GOYA_ASYNC_EVENT_ID_MME_ECC,
+	GOYA_ASYNC_EVENT_ID_MME_ECC_EXT,
+	GOYA_ASYNC_EVENT_ID_MMU_ECC,
+	GOYA_ASYNC_EVENT_ID_DMA_MACRO,
+	GOYA_ASYNC_EVENT_ID_DMA_ECC,
+	GOYA_ASYNC_EVENT_ID_CPU_IF_ECC,
+	GOYA_ASYNC_EVENT_ID_PSOC_MEM,
+	GOYA_ASYNC_EVENT_ID_PSOC_CORESIGHT,
+	GOYA_ASYNC_EVENT_ID_SRAM0,
+	GOYA_ASYNC_EVENT_ID_SRAM1,
+	GOYA_ASYNC_EVENT_ID_SRAM2,
+	GOYA_ASYNC_EVENT_ID_SRAM3,
+	GOYA_ASYNC_EVENT_ID_SRAM4,
+	GOYA_ASYNC_EVENT_ID_SRAM5,
+	GOYA_ASYNC_EVENT_ID_SRAM6,
+	GOYA_ASYNC_EVENT_ID_SRAM7,
+	GOYA_ASYNC_EVENT_ID_SRAM8,
+	GOYA_ASYNC_EVENT_ID_SRAM9,
+	GOYA_ASYNC_EVENT_ID_SRAM10,
+	GOYA_ASYNC_EVENT_ID_SRAM11,
+	GOYA_ASYNC_EVENT_ID_SRAM12,
+	GOYA_ASYNC_EVENT_ID_SRAM13,
+	GOYA_ASYNC_EVENT_ID_SRAM14,
+	GOYA_ASYNC_EVENT_ID_SRAM15,
+	GOYA_ASYNC_EVENT_ID_SRAM16,
+	GOYA_ASYNC_EVENT_ID_SRAM17,
+	GOYA_ASYNC_EVENT_ID_SRAM18,
+	GOYA_ASYNC_EVENT_ID_SRAM19,
+	GOYA_ASYNC_EVENT_ID_SRAM20,
+	GOYA_ASYNC_EVENT_ID_SRAM21,
+	GOYA_ASYNC_EVENT_ID_SRAM22,
+	GOYA_ASYNC_EVENT_ID_SRAM23,
+	GOYA_ASYNC_EVENT_ID_SRAM24,
+	GOYA_ASYNC_EVENT_ID_SRAM25,
+	GOYA_ASYNC_EVENT_ID_SRAM26,
+	GOYA_ASYNC_EVENT_ID_SRAM27,
+	GOYA_ASYNC_EVENT_ID_SRAM28,
+	GOYA_ASYNC_EVENT_ID_SRAM29,
+	GOYA_ASYNC_EVENT_ID_GIC500,
+	GOYA_ASYNC_EVENT_ID_PLL0,
+	GOYA_ASYNC_EVENT_ID_PLL1,
+	GOYA_ASYNC_EVENT_ID_PLL3,
+	GOYA_ASYNC_EVENT_ID_PLL4,
+	GOYA_ASYNC_EVENT_ID_PLL5,
+	GOYA_ASYNC_EVENT_ID_PLL6,
+	GOYA_ASYNC_EVENT_ID_AXI_ECC,
+	GOYA_ASYNC_EVENT_ID_L2_RAM_ECC,
+	GOYA_ASYNC_EVENT_ID_PSOC_GPIO_05_SW_RESET,
+	GOYA_ASYNC_EVENT_ID_PSOC_GPIO_10_VRHOT_ICRIT,
+	GOYA_ASYNC_EVENT_ID_PCIE_DEC,
+	GOYA_ASYNC_EVENT_ID_TPC0_DEC,
+	GOYA_ASYNC_EVENT_ID_TPC1_DEC,
+	GOYA_ASYNC_EVENT_ID_TPC2_DEC,
+	GOYA_ASYNC_EVENT_ID_TPC3_DEC,
+	GOYA_ASYNC_EVENT_ID_TPC4_DEC,
+	GOYA_ASYNC_EVENT_ID_TPC5_DEC,
+	GOYA_ASYNC_EVENT_ID_TPC6_DEC,
+	GOYA_ASYNC_EVENT_ID_TPC7_DEC,
+	GOYA_ASYNC_EVENT_ID_MME_WACS,
+	GOYA_ASYNC_EVENT_ID_MME_WACSD,
+	GOYA_ASYNC_EVENT_ID_CPU_AXI_SPLITTER,
+	GOYA_ASYNC_EVENT_ID_PSOC_AXI_DEC,
+	GOYA_ASYNC_EVENT_ID_PSOC,
+	GOYA_ASYNC_EVENT_ID_TPC0_KRN_ERR,
+	GOYA_ASYNC_EVENT_ID_TPC1_KRN_ERR,
+	GOYA_ASYNC_EVENT_ID_TPC2_KRN_ERR,
+	GOYA_ASYNC_EVENT_ID_TPC3_KRN_ERR,
+	GOYA_ASYNC_EVENT_ID_TPC4_KRN_ERR,
+	GOYA_ASYNC_EVENT_ID_TPC5_KRN_ERR,
+	GOYA_ASYNC_EVENT_ID_TPC6_KRN_ERR,
+	GOYA_ASYNC_EVENT_ID_TPC7_KRN_ERR,
+	GOYA_ASYNC_EVENT_ID_TPC0_CMDQ,
+	GOYA_ASYNC_EVENT_ID_TPC1_CMDQ,
+	GOYA_ASYNC_EVENT_ID_TPC2_CMDQ,
+	GOYA_ASYNC_EVENT_ID_TPC3_CMDQ,
+	GOYA_ASYNC_EVENT_ID_TPC4_CMDQ,
+	GOYA_ASYNC_EVENT_ID_TPC5_CMDQ,
+	GOYA_ASYNC_EVENT_ID_TPC6_CMDQ,
+	GOYA_ASYNC_EVENT_ID_TPC7_CMDQ,
+	GOYA_ASYNC_EVENT_ID_TPC0_QM,
+	GOYA_ASYNC_EVENT_ID_TPC1_QM,
+	GOYA_ASYNC_EVENT_ID_TPC2_QM,
+	GOYA_ASYNC_EVENT_ID_TPC3_QM,
+	GOYA_ASYNC_EVENT_ID_TPC4_QM,
+	GOYA_ASYNC_EVENT_ID_TPC5_QM,
+	GOYA_ASYNC_EVENT_ID_TPC6_QM,
+	GOYA_ASYNC_EVENT_ID_TPC7_QM,
+	GOYA_ASYNC_EVENT_ID_MME_QM,
+	GOYA_ASYNC_EVENT_ID_MME_CMDQ,
+	GOYA_ASYNC_EVENT_ID_DMA0_QM,
+	GOYA_ASYNC_EVENT_ID_DMA1_QM,
+	GOYA_ASYNC_EVENT_ID_DMA2_QM,
+	GOYA_ASYNC_EVENT_ID_DMA3_QM,
+	GOYA_ASYNC_EVENT_ID_DMA4_QM,
+	GOYA_ASYNC_EVENT_ID_DMA0_CH,
+	GOYA_ASYNC_EVENT_ID_DMA1_CH,
+	GOYA_ASYNC_EVENT_ID_DMA2_CH,
+	GOYA_ASYNC_EVENT_ID_DMA3_CH,
+	GOYA_ASYNC_EVENT_ID_DMA4_CH,
+	GOYA_ASYNC_EVENT_ID_TPC0_BMON_SPMU,
+	GOYA_ASYNC_EVENT_ID_TPC1_BMON_SPMU,
+	GOYA_ASYNC_EVENT_ID_TPC2_BMON_SPMU,
+	GOYA_ASYNC_EVENT_ID_TPC3_BMON_SPMU,
+	GOYA_ASYNC_EVENT_ID_TPC4_BMON_SPMU,
+	GOYA_ASYNC_EVENT_ID_TPC5_BMON_SPMU,
+	GOYA_ASYNC_EVENT_ID_TPC6_BMON_SPMU,
+	GOYA_ASYNC_EVENT_ID_TPC7_BMON_SPMU,
+	GOYA_ASYNC_EVENT_ID_DMA_BM_CH0,
+	GOYA_ASYNC_EVENT_ID_DMA_BM_CH1,
+	GOYA_ASYNC_EVENT_ID_DMA_BM_CH2,
+	GOYA_ASYNC_EVENT_ID_DMA_BM_CH3,
+	GOYA_ASYNC_EVENT_ID_DMA_BM_CH4
+};
+
 static int goya_armcp_info_get(struct hl_device *hdev);
 
 static void goya_get_fixed_properties(struct hl_device *hdev)
@@ -2577,6 +2701,14 @@ static void goya_hw_fini(struct hl_device *hdev, bool hard_reset)
 			"Timeout while waiting for device to reset 0x%x\n",
 			status);
 
+	if (!hard_reset) {
+		goya->hw_cap_initialized &= ~(HW_CAP_DMA | HW_CAP_MME |
+						HW_CAP_GOLDEN | HW_CAP_TPC);
+		WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
+				GOYA_ASYNC_EVENT_ID_SOFT_RESET);
+		return;
+	}
+
 	/* Chicken bit to re-initiate boot sequencer flow */
 	WREG32(mmPSOC_GLOBAL_CONF_BOOT_SEQ_RE_START,
 		1 << PSOC_GLOBAL_CONF_BOOT_SEQ_RE_START_IND_SHIFT);
@@ -3184,6 +3316,57 @@ static void goya_print_irq_info(struct hl_device *hdev, u16 event_type)
 	}
 }
 
+static int goya_unmask_irq_arr(struct hl_device *hdev, u32 *irq_arr,
+		size_t irq_arr_size)
+{
+	struct armcp_unmask_irq_arr_packet *pkt;
+	size_t total_pkt_size;
+	long result;
+	int rc;
+
+	total_pkt_size = sizeof(struct armcp_unmask_irq_arr_packet) +
+			irq_arr_size;
+
+	/* data should be aligned to 8 bytes in order to ArmCP to copy it */
+	total_pkt_size = (total_pkt_size + 0x7) & ~0x7;
+
+	/* total_pkt_size is casted to u16 later on */
+	if (total_pkt_size > USHRT_MAX) {
+		dev_err(hdev->dev, "too many elements in IRQ array\n");
+		return -EINVAL;
+	}
+
+	pkt = kzalloc(total_pkt_size, GFP_KERNEL);
+	if (!pkt)
+		return -ENOMEM;
+
+	pkt->length = irq_arr_size / sizeof(irq_arr[0]);
+	memcpy(&pkt->irqs, irq_arr, irq_arr_size);
+
+	pkt->armcp_pkt.ctl = ARMCP_PACKET_UNMASK_RAZWI_IRQ_ARRAY <<
+						ARMCP_PKT_CTL_OPCODE_SHIFT;
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) pkt,
+			total_pkt_size, HL_DEVICE_TIMEOUT_USEC, &result);
+
+	if (rc)
+		dev_err(hdev->dev, "failed to unmask IRQ array\n");
+
+	kfree(pkt);
+
+	return rc;
+}
+
+static int goya_soft_reset_late_init(struct hl_device *hdev)
+{
+	/*
+	 * Unmask all IRQs since some could have been received
+	 * during the soft reset
+	 */
+	return goya_unmask_irq_arr(hdev, goya_non_fatal_events,
+			sizeof(goya_non_fatal_events));
+}
+
 static int goya_unmask_irq(struct hl_device *hdev, u16 event_type)
 {
 	struct armcp_packet pkt;
@@ -3245,6 +3428,7 @@ void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
 		dev_err(hdev->dev,
 			"Received H/W interrupt %d, reset the chip\n",
 			event_type);
+		hl_device_reset(hdev, true, false);
 		break;
 
 	case GOYA_ASYNC_EVENT_ID_PCIE_DEC:
@@ -3310,6 +3494,30 @@ void *goya_get_events_stat(struct hl_device *hdev, u32 *size)
 	return goya->events_stat;
 }
 
+int goya_send_heartbeat(struct hl_device *hdev)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	struct armcp_packet hb_pkt;
+	long result;
+	int rc;
+
+	if (!(goya->hw_cap_initialized & HW_CAP_CPU_Q))
+		return 0;
+
+	memset(&hb_pkt, 0, sizeof(hb_pkt));
+
+	hb_pkt.ctl = ARMCP_PACKET_TEST << ARMCP_PKT_CTL_OPCODE_SHIFT;
+	hb_pkt.value = ARMCP_PACKET_FENCE_VAL;
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &hb_pkt,
+			sizeof(hb_pkt), HL_DEVICE_TIMEOUT_USEC, &result);
+
+	if ((rc) || (result != ARMCP_PACKET_FENCE_VAL))
+		rc = -EIO;
+
+	return rc;
+}
+
 static int goya_armcp_info_get(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
@@ -3485,8 +3693,10 @@ static const struct hl_asic_funcs goya_funcs = {
 	.handle_eqe = goya_handle_eqe,
 	.set_pll_profile = goya_set_pll_profile,
 	.get_events_stat = goya_get_events_stat,
+	.send_heartbeat = goya_send_heartbeat,
 	.enable_clock_gating = goya_init_clock_gating,
 	.disable_clock_gating = goya_disable_clock_gating,
+	.soft_reset_late_init = goya_soft_reset_late_init,
 	.hw_queues_lock = goya_hw_queues_lock,
 	.hw_queues_unlock = goya_hw_queues_unlock,
 	.get_eeprom_data = goya_get_eeprom_data,
diff --git a/drivers/misc/habanalabs/goya/goya_hwmgr.c b/drivers/misc/habanalabs/goya/goya_hwmgr.c
index 866d1774b2e4..68f057c4b224 100644
--- a/drivers/misc/habanalabs/goya/goya_hwmgr.c
+++ b/drivers/misc/habanalabs/goya/goya_hwmgr.c
@@ -38,7 +38,7 @@ static ssize_t mme_clk_show(struct device *dev, struct device_attribute *attr,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long value;
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, MME_PLL, false);
@@ -57,7 +57,7 @@ static ssize_t mme_clk_store(struct device *dev, struct device_attribute *attr,
 	int rc;
 	long value;
 
-	if (hdev->disabled) {
+	if (hl_device_disabled_or_in_reset(hdev)) {
 		count = -ENODEV;
 		goto fail;
 	}
@@ -87,7 +87,7 @@ static ssize_t tpc_clk_show(struct device *dev, struct device_attribute *attr,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long value;
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, TPC_PLL, false);
@@ -106,7 +106,7 @@ static ssize_t tpc_clk_store(struct device *dev, struct device_attribute *attr,
 	int rc;
 	long value;
 
-	if (hdev->disabled) {
+	if (hl_device_disabled_or_in_reset(hdev)) {
 		count = -ENODEV;
 		goto fail;
 	}
@@ -136,7 +136,7 @@ static ssize_t ic_clk_show(struct device *dev, struct device_attribute *attr,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long value;
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, IC_PLL, false);
@@ -155,7 +155,7 @@ static ssize_t ic_clk_store(struct device *dev, struct device_attribute *attr,
 	int rc;
 	long value;
 
-	if (hdev->disabled) {
+	if (hl_device_disabled_or_in_reset(hdev)) {
 		count = -ENODEV;
 		goto fail;
 	}
@@ -185,7 +185,7 @@ static ssize_t mme_clk_curr_show(struct device *dev,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long value;
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, MME_PLL, true);
@@ -202,7 +202,7 @@ static ssize_t tpc_clk_curr_show(struct device *dev,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long value;
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, TPC_PLL, true);
@@ -219,7 +219,7 @@ static ssize_t ic_clk_curr_show(struct device *dev,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long value;
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	value = hl_get_frequency(hdev, IC_PLL, true);
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 5e0f20b92bde..402309180b40 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -26,8 +26,12 @@
 
 #define HL_MMAP_CB_MASK			(0x8000000000000000ull >> PAGE_SHIFT)
 
+#define HL_PENDING_RESET_PER_SEC	5
+
 #define HL_DEVICE_TIMEOUT_USEC		1000000 /* 1 s */
 
+#define HL_HEARTBEAT_PER_USEC		5000000 /* 5 s */
+
 #define HL_PLL_LOW_JOB_FREQ_USEC	5000000 /* 5 s */
 
 #define HL_MAX_QUEUES			128
@@ -367,8 +371,10 @@ enum hl_pll_frequency {
  * @handle_eqe: handle event queue entry (IRQ) from ArmCP.
  * @set_pll_profile: change PLL profile (manual/automatic).
  * @get_events_stat: retrieve event queue entries histogram.
+ * @send_heartbeat: send is-alive packet to ArmCP and verify response.
  * @enable_clock_gating: enable clock gating for reducing power consumption.
  * @disable_clock_gating: disable clock for accessing registers on HBW.
+ * @soft_reset_late_init: perform certain actions needed after soft reset.
  * @hw_queues_lock: acquire H/W queues lock.
  * @hw_queues_unlock: release H/W queues lock.
  * @get_eeprom_data: retrieve EEPROM data from F/W.
@@ -414,8 +420,10 @@ struct hl_asic_funcs {
 	void (*set_pll_profile)(struct hl_device *hdev,
 			enum hl_pll_frequency freq);
 	void* (*get_events_stat)(struct hl_device *hdev, u32 *size);
+	int (*send_heartbeat)(struct hl_device *hdev);
 	void (*enable_clock_gating)(struct hl_device *hdev);
 	void (*disable_clock_gating)(struct hl_device *hdev);
+	int (*soft_reset_late_init)(struct hl_device *hdev);
 	void (*hw_queues_lock)(struct hl_device *hdev);
 	void (*hw_queues_unlock)(struct hl_device *hdev);
 	int (*get_eeprom_data)(struct hl_device *hdev, void *data,
@@ -533,6 +541,16 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 	WREG32(mm##reg, (RREG32(mm##reg) & ~REG_FIELD_MASK(reg, field)) | \
 			(val) << REG_FIELD_SHIFT(reg, field))
 
+/**
+ * struct hl_device_reset_work - reset workqueue task wrapper.
+ * @reset_work: reset work to be done.
+ * @hdev: habanalabs device structure.
+ */
+struct hl_device_reset_work {
+	struct work_struct		reset_work;
+	struct hl_device		*hdev;
+};
+
 /**
  * struct hl_device - habanalabs device structure.
  * @pdev: pointer to PCI device, can be NULL in case of simulator device.
@@ -541,6 +559,7 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
  * @cdev: related char device.
  * @dev: realted kernel basic device structure.
  * @work_freq: delayed work to lower device frequency if possible.
+ * @work_heartbeat: delayed work for ArmCP is-alive check.
  * @asic_name: ASIC specific nmae.
  * @asic_type: ASIC specific type.
  * @completion_queue: array of hl_cq.
@@ -572,6 +591,7 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
  * @cb_pool: list of preallocated CBs.
  * @cb_pool_lock: protects the CB pool.
  * @user_ctx: current user context executing.
+ * @in_reset: is device in reset flow.
  * @curr_pll_profile: current PLL profile.
  * @fd_open_cnt: number of open user processes.
  * @max_power: the max power of the device, as configured by the sysadmin. This
@@ -579,10 +599,15 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
  *             value and update the F/W after the re-initialization
  * @major: habanalabs KMD major.
  * @high_pll: high PLL profile frequency.
+ * @soft_reset_cnt: number of soft reset since KMD loading.
+ * @hard_reset_cnt: number of hard reset since KMD loading.
  * @id: device minor.
  * @disabled: is device disabled.
  * @late_init_done: is late init stage was done during initialization.
  * @hwmon_initialized: is H/W monitor sensors was initialized.
+ * @hard_reset_pending: is there a hard reset work pending.
+ * @heartbeat: is heartbeat sanity check towards ArmCP enabled.
+ * @init_done: is the initialization of the device done.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -591,6 +616,7 @@ struct hl_device {
 	struct cdev			cdev;
 	struct device			*dev;
 	struct delayed_work		work_freq;
+	struct delayed_work		work_heartbeat;
 	char				asic_name[16];
 	enum hl_asic_type		asic_type;
 	struct hl_cq			*completion_queue;
@@ -622,15 +648,21 @@ struct hl_device {
 	/* TODO: remove user_ctx for multiple process support */
 	struct hl_ctx			*user_ctx;
 
+	atomic_t			in_reset;
 	atomic_t			curr_pll_profile;
 	atomic_t			fd_open_cnt;
 	u64				max_power;
 	u32				major;
 	u32				high_pll;
+	u32				soft_reset_cnt;
+	u32				hard_reset_cnt;
 	u16				id;
 	u8				disabled;
 	u8				late_init_done;
 	u8				hwmon_initialized;
+	u8				hard_reset_pending;
+	u8				heartbeat;
+	u8				init_done;
 
 	/* Parameters for bring-up */
 	u8				cpu_enable;
@@ -671,6 +703,7 @@ struct hl_ioctl_desc {
  */
 
 int hl_device_open(struct inode *inode, struct file *filp);
+bool hl_device_disabled_or_in_reset(struct hl_device *hdev);
 int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 		enum hl_asic_type asic_type, int minor);
 void destroy_hdev(struct hl_device *hdev);
@@ -684,6 +717,7 @@ int hl_hw_queue_send_cb_no_cmpl(struct hl_device *hdev, u32 hw_queue_id,
 				u32 cb_size, u64 cb_ptr);
 u32 hl_hw_queue_add_ptr(u32 ptr, u16 val);
 void hl_hw_queue_inc_ci_kernel(struct hl_device *hdev, u32 hw_queue_id);
+void hl_hw_queue_reset(struct hl_device *hdev, bool hard_reset);
 
 #define hl_queue_inc_ptr(p)		hl_hw_queue_add_ptr(p, 1)
 #define hl_pi_2_offset(pi)		((pi) & (HL_QUEUE_LENGTH - 1))
@@ -692,6 +726,8 @@ int hl_cq_init(struct hl_device *hdev, struct hl_cq *q, u32 hw_queue_id);
 void hl_cq_fini(struct hl_device *hdev, struct hl_cq *q);
 int hl_eq_init(struct hl_device *hdev, struct hl_eq *q);
 void hl_eq_fini(struct hl_device *hdev, struct hl_eq *q);
+void hl_cq_reset(struct hl_device *hdev, struct hl_cq *q);
+void hl_eq_reset(struct hl_device *hdev, struct hl_eq *q);
 irqreturn_t hl_irq_handler_cq(int irq, void *arg);
 irqreturn_t hl_irq_handler_eq(int irq, void *arg);
 int hl_asid_init(struct hl_device *hdev);
@@ -709,6 +745,8 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass);
 void hl_device_fini(struct hl_device *hdev);
 int hl_device_suspend(struct hl_device *hdev);
 int hl_device_resume(struct hl_device *hdev);
+int hl_device_reset(struct hl_device *hdev, bool hard_reset,
+			bool from_hard_reset_thread);
 void hl_hpriv_get(struct hl_fpriv *hpriv);
 void hl_hpriv_put(struct hl_fpriv *hpriv);
 int hl_device_set_frequency(struct hl_device *hdev, enum hl_pll_frequency freq);
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 6260d99ef1ca..0702f6f974eb 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -88,9 +88,9 @@ int hl_device_open(struct inode *inode, struct file *filp)
 
 	mutex_lock(&hdev->fd_open_cnt_lock);
 
-	if (hdev->disabled) {
+	if (hl_device_disabled_or_in_reset(hdev)) {
 		dev_err_ratelimited(hdev->dev,
-			"Can't open %s because it is disabled\n",
+			"Can't open %s because it is disabled or in reset\n",
 			dev_name(hdev->dev));
 		mutex_unlock(&hdev->fd_open_cnt_lock);
 		return -EPERM;
@@ -183,6 +183,7 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 	hdev->cpu_queues_enable = 1;
 	hdev->fw_loading = 1;
 	hdev->pldm = 0;
+	hdev->heartbeat = 1;
 
 	/* If CPU is disabled, no point in loading FW */
 	if (!hdev->cpu_enable)
@@ -192,6 +193,10 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 	if (!hdev->fw_loading)
 		hdev->cpu_queues_enable = 0;
 
+	/* If CPU queues not enabled, no way to do heartbeat */
+	if (!hdev->cpu_queues_enable)
+		hdev->heartbeat = 0;
+
 	hdev->disabled = true;
 	hdev->pdev = pdev; /* can be NULL in case of simulator device */
 
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index 71a7a782fbd1..12b004b92c83 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -33,6 +33,12 @@ long hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	unsigned int usize, asize;
 	int retcode;
 
+	if (hdev->hard_reset_pending) {
+		dev_crit_ratelimited(hdev->dev,
+			"Device HARD reset pending! Please close FD\n");
+		return -ENODEV;
+	}
+
 	if ((nr >= HL_COMMAND_START) && (nr < HL_COMMAND_END)) {
 		u32 hl_size;
 
diff --git a/drivers/misc/habanalabs/hwmon.c b/drivers/misc/habanalabs/hwmon.c
index 4d60b36dfa21..61b0a2b26c19 100644
--- a/drivers/misc/habanalabs/hwmon.c
+++ b/drivers/misc/habanalabs/hwmon.c
@@ -111,7 +111,7 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	switch (type) {
@@ -185,7 +185,7 @@ static int hl_write(struct device *dev, enum hwmon_sensor_types type,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	switch (type) {
diff --git a/drivers/misc/habanalabs/irq.c b/drivers/misc/habanalabs/irq.c
index 5a7cb85ab50a..29dc24c63606 100644
--- a/drivers/misc/habanalabs/irq.c
+++ b/drivers/misc/habanalabs/irq.c
@@ -250,6 +250,23 @@ void hl_cq_fini(struct hl_device *hdev, struct hl_cq *q)
 			(void *) q->kernel_address, q->bus_address);
 }
 
+void hl_cq_reset(struct hl_device *hdev, struct hl_cq *q)
+{
+	q->ci = 0;
+	q->pi = 0;
+
+	atomic_set(&q->free_slots_cnt, HL_CQ_LENGTH);
+
+	/*
+	 * It's not enough to just reset the PI/CI because the H/W may have
+	 * written valid completion entries before it was halted and therefore
+	 * we need to clean the actual queues so we won't process old entries
+	 * when the device is operational again
+	 */
+
+	memset((void *) q->kernel_address, 0, HL_CQ_SIZE_IN_BYTES);
+}
+
 /*
  * hl_eq_init - main initialization function for an event queue object
  *
@@ -292,3 +309,17 @@ void hl_eq_fini(struct hl_device *hdev, struct hl_eq *q)
 	hdev->asic_funcs->dma_free_coherent(hdev, HL_EQ_SIZE_IN_BYTES,
 			(void *) q->kernel_address, q->bus_address);
 }
+
+void hl_eq_reset(struct hl_device *hdev, struct hl_eq *q)
+{
+	q->ci = 0;
+
+	/*
+	 * It's not enough to just reset the PI/CI because the H/W may have
+	 * written valid completion entries before it was halted and therefore
+	 * we need to clean the actual queues so we won't process old entries
+	 * when the device is operational again
+	 */
+
+	memset((void *) q->kernel_address, 0, HL_EQ_SIZE_IN_BYTES);
+}
diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/sysfs.c
index c5b90f338b4d..a145442f4cbd 100644
--- a/drivers/misc/habanalabs/sysfs.c
+++ b/drivers/misc/habanalabs/sysfs.c
@@ -105,7 +105,7 @@ static ssize_t pm_mng_profile_show(struct device *dev,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	return snprintf(buf, PAGE_SIZE, "%s\n",
@@ -119,7 +119,7 @@ static ssize_t pm_mng_profile_store(struct device *dev,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	if (hdev->disabled) {
+	if (hl_device_disabled_or_in_reset(hdev)) {
 		count = -ENODEV;
 		goto out;
 	}
@@ -163,7 +163,7 @@ static ssize_t high_pll_show(struct device *dev, struct device_attribute *attr,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	return snprintf(buf, PAGE_SIZE, "%u\n", hdev->high_pll);
@@ -176,7 +176,7 @@ static ssize_t high_pll_store(struct device *dev, struct device_attribute *attr,
 	long value;
 	int rc;
 
-	if (hdev->disabled) {
+	if (hl_device_disabled_or_in_reset(hdev)) {
 		count = -ENODEV;
 		goto out;
 	}
@@ -264,6 +264,48 @@ static ssize_t preboot_btl_ver_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%s\n", hdev->asic_prop.preboot_ver);
 }
 
+static ssize_t soft_reset_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	long value;
+	int rc;
+
+	rc = kstrtoul(buf, 0, &value);
+
+	if (rc) {
+		count = -EINVAL;
+		goto out;
+	}
+
+	hl_device_reset(hdev, false, false);
+
+out:
+	return count;
+}
+
+static ssize_t hard_reset_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	long value;
+	int rc;
+
+	rc = kstrtoul(buf, 0, &value);
+
+	if (rc) {
+		count = -EINVAL;
+		goto out;
+	}
+
+	hl_device_reset(hdev, true, false);
+
+out:
+	return count;
+}
+
 static ssize_t device_type_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -305,7 +347,9 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	char *str;
 
-	if (hdev->disabled)
+	if (atomic_read(&hdev->in_reset))
+		str = "In reset";
+	else if (hdev->disabled)
 		str = "Malfunction";
 	else
 		str = "Operational";
@@ -321,13 +365,29 @@ static ssize_t write_open_cnt_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", hdev->user_ctx ? 1 : 0);
 }
 
+static ssize_t soft_reset_cnt_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", hdev->soft_reset_cnt);
+}
+
+static ssize_t hard_reset_cnt_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", hdev->hard_reset_cnt);
+}
+
 static ssize_t max_power_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	long val;
 
-	if (hdev->disabled)
+	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
 
 	val = hl_get_max_power(hdev);
@@ -342,7 +402,7 @@ static ssize_t max_power_store(struct device *dev,
 	unsigned long value;
 	int rc;
 
-	if (hdev->disabled) {
+	if (hl_device_disabled_or_in_reset(hdev)) {
 		count = -ENODEV;
 		goto out;
 	}
@@ -399,10 +459,14 @@ static DEVICE_ATTR_RO(infineon_ver);
 static DEVICE_ATTR_RO(fuse_ver);
 static DEVICE_ATTR_RO(thermal_ver);
 static DEVICE_ATTR_RO(preboot_btl_ver);
+static DEVICE_ATTR_WO(soft_reset);
+static DEVICE_ATTR_WO(hard_reset);
 static DEVICE_ATTR_RO(device_type);
 static DEVICE_ATTR_RO(pci_addr);
 static DEVICE_ATTR_RO(status);
 static DEVICE_ATTR_RO(write_open_cnt);
+static DEVICE_ATTR_RO(soft_reset_cnt);
+static DEVICE_ATTR_RO(hard_reset_cnt);
 static DEVICE_ATTR_RW(max_power);
 
 static const struct bin_attribute bin_attr_eeprom = {
@@ -488,11 +552,23 @@ int hl_sysfs_init(struct hl_device *hdev)
 		goto remove_thermal_ver;
 	}
 
+	rc = device_create_file(hdev->dev, &dev_attr_soft_reset);
+	if (rc) {
+		dev_err(hdev->dev, "failed to create device file soft_reset\n");
+		goto remove_preboot_ver;
+	}
+
+	rc = device_create_file(hdev->dev, &dev_attr_hard_reset);
+	if (rc) {
+		dev_err(hdev->dev, "failed to create device file hard_reset\n");
+		goto remove_soft_reset;
+	}
+
 	rc = device_create_file(hdev->dev, &dev_attr_device_type);
 	if (rc) {
 		dev_err(hdev->dev,
 			"failed to create device file device_type\n");
-		goto remove_preboot_ver;
+		goto remove_hard_reset;
 	}
 
 	rc = device_create_file(hdev->dev, &dev_attr_pci_addr);
@@ -514,13 +590,27 @@ int hl_sysfs_init(struct hl_device *hdev)
 		goto remove_status;
 	}
 
+	rc = device_create_file(hdev->dev, &dev_attr_soft_reset_cnt);
+	if (rc) {
+		dev_err(hdev->dev,
+			"failed to create device file soft_reset_count\n");
+		goto remove_write_open_cnt;
+	}
+
+	rc = device_create_file(hdev->dev, &dev_attr_hard_reset_cnt);
+	if (rc) {
+		dev_err(hdev->dev,
+			"failed to create device file hard_reset_count\n");
+		goto remove_soft_reset_cnt;
+	}
+
 	hdev->max_power = hdev->asic_prop.max_power_default;
 
 	rc = device_create_file(hdev->dev, &dev_attr_max_power);
 	if (rc) {
 		dev_err(hdev->dev,
 			"failed to create device file max_power\n");
-		goto remove_write_open_cnt;
+		goto remove_hard_reset_cnt;
 	}
 
 	rc = sysfs_create_bin_file(&hdev->dev->kobj, &bin_attr_eeprom);
@@ -533,6 +623,10 @@ int hl_sysfs_init(struct hl_device *hdev)
 
 remove_attr_max_power:
 	device_remove_file(hdev->dev, &dev_attr_max_power);
+remove_hard_reset_cnt:
+	device_remove_file(hdev->dev, &dev_attr_hard_reset_cnt);
+remove_soft_reset_cnt:
+	device_remove_file(hdev->dev, &dev_attr_soft_reset_cnt);
 remove_write_open_cnt:
 	device_remove_file(hdev->dev, &dev_attr_write_open_cnt);
 remove_status:
@@ -541,6 +635,10 @@ int hl_sysfs_init(struct hl_device *hdev)
 	device_remove_file(hdev->dev, &dev_attr_pci_addr);
 remove_device_type:
 	device_remove_file(hdev->dev, &dev_attr_device_type);
+remove_hard_reset:
+	device_remove_file(hdev->dev, &dev_attr_hard_reset);
+remove_soft_reset:
+	device_remove_file(hdev->dev, &dev_attr_soft_reset);
 remove_preboot_ver:
 	device_remove_file(hdev->dev, &dev_attr_preboot_btl_ver);
 remove_thermal_ver:
@@ -571,10 +669,14 @@ void hl_sysfs_fini(struct hl_device *hdev)
 {
 	sysfs_remove_bin_file(&hdev->dev->kobj, &bin_attr_eeprom);
 	device_remove_file(hdev->dev, &dev_attr_max_power);
+	device_remove_file(hdev->dev, &dev_attr_hard_reset_cnt);
+	device_remove_file(hdev->dev, &dev_attr_soft_reset_cnt);
 	device_remove_file(hdev->dev, &dev_attr_write_open_cnt);
 	device_remove_file(hdev->dev, &dev_attr_status);
 	device_remove_file(hdev->dev, &dev_attr_pci_addr);
 	device_remove_file(hdev->dev, &dev_attr_device_type);
+	device_remove_file(hdev->dev, &dev_attr_hard_reset);
+	device_remove_file(hdev->dev, &dev_attr_soft_reset);
 	device_remove_file(hdev->dev, &dev_attr_preboot_btl_ver);
 	device_remove_file(hdev->dev, &dev_attr_thermal_ver);
 	device_remove_file(hdev->dev, &dev_attr_fuse_ver);
-- 
2.17.1

