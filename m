Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90CCC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB4D2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsWGcCP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfBDUeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:34:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46443 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbfBDUda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:33:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so1271956wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 12:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jQ1BIcEw1W+ezF38UuYALOZFyqBcSIrsONokKJ7X928=;
        b=EsWGcCP31lq6r+QwDFwJqiUME8i5s4RdEkTQ6GXP8dKTSIK4sO2LOSaIx1/j2LRzFx
         BIKYWPGmOgMBlYgRke+B9Bv+74SeaGI+wh++0lCpy/Py9FWjJR1GumjnMeMIJrLYJRTO
         wL/nghsF8QjqQvlzHzghyeWprPnUZq/RJQqf8Ync5pCJ23xfHFKEhg60d9RmUKvlmo0/
         jdcDWZJCae2AsKwOrdZy82gYFhq1fWO6s1mpGz0YhnXTXnXjcaa7KlPstQlTWgrpMVHG
         H7xhzPf/Zx0nbL22tq6Z5GKgGtzgnOlfQfBc75vANwknJ5FtUZa6AdsbLrrPSxd4szes
         bFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jQ1BIcEw1W+ezF38UuYALOZFyqBcSIrsONokKJ7X928=;
        b=YI9C2GT10ROWD5K8XDC/azEIy9SrDXV7x7RXQvC6b/aFwH1XTqXrBe1UQaG7I/O4Is
         GefZbtitvoizQy3UoGiV0YfHT65CGZRf8YUTWKCcKFd3HcUzCuvwVseP1FXgwNXO6VcU
         oLqdmCf+gZ9qBKlqjPENrRAoZ28sLlFq5Y+pIHoi2HAVUJVU/fhjqHg7HcQ/WPB1ooAC
         QTBZ6VAA6yYT7ShuQWePOpd+5t+OXDxnBNYqkzJ/k74kC4oJbYZWVWi6tTS3G3Hmr6rV
         0LdmbqDkUn8OPVjgzqjxjgdxu0cp9n+tbeR99P2As0767Q9zBoa+Lik3lSGr599cG3dq
         v0Pg==
X-Gm-Message-State: AHQUAuZkm+kzvYfCWDgreAf955hxjAFTesrZNAkwkWcbP2EiT8Q9ZqAX
        AnHM+DeVzRJGxii3Ya82H5k=
X-Google-Smtp-Source: AHgI3IaigkowSazo/VQ5wTo3pytco679SO0Afn1OO7+t1DcsTGf3QJilwjB8xFoezpmsvHt68dwdqg==
X-Received: by 2002:adf:bb8d:: with SMTP id q13mr865088wrg.183.1549312401074;
        Mon, 04 Feb 2019 12:33:21 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j24sm19990792wrd.86.2019.02.04.12.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 12:33:20 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, rppt@linux.ibm.com
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v3 11/15] habanalabs: add command submission module
Date:   Mon,  4 Feb 2019 22:32:50 +0200
Message-Id: <20190204203254.4026-12-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190204203254.4026-1-oded.gabbay@gmail.com>
References: <20190204203254.4026-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the main flow for the user to submit work to the device.

Each work is described by a command submission object (CS). The CS contains
3 arrays of command buffers: One for execution, and two for context-switch
(store and restore).

For each CB, the user specifies on which queue to put that CB. In case of
an internal queue, the entry doesn't contain a pointer to the CB but the
address in the on-chip memory that the CB resides at.

The driver parses some of the CBs to enforce security restrictions.

The user receives a sequence number that represents the CS object. The user
can then query the driver regarding the status of the CS, using that
sequence number.

In case the CS doesn't finish before the timeout expires, the driver will
perform a soft-reset of the device.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
Changes in v3:
  - Remove use of three exclamation marks
  - Remove hdev->ifh field as it was used for debugging
 
 drivers/misc/habanalabs/Makefile             |    3 +-
 drivers/misc/habanalabs/command_submission.c |  770 ++++++++++++
 drivers/misc/habanalabs/context.c            |   52 +-
 drivers/misc/habanalabs/device.c             |   16 +
 drivers/misc/habanalabs/goya/goya.c          | 1122 ++++++++++++++++++
 drivers/misc/habanalabs/habanalabs.h         |  272 +++++
 drivers/misc/habanalabs/habanalabs_drv.c     |   20 +
 drivers/misc/habanalabs/habanalabs_ioctl.c   |    4 +-
 drivers/misc/habanalabs/hw_queue.c           |  232 ++++
 drivers/misc/habanalabs/memory.c             |  200 ++++
 include/uapi/misc/habanalabs.h               |  158 ++-
 11 files changed, 2842 insertions(+), 7 deletions(-)
 create mode 100644 drivers/misc/habanalabs/command_submission.c
 create mode 100644 drivers/misc/habanalabs/memory.c

diff --git a/drivers/misc/habanalabs/Makefile b/drivers/misc/habanalabs/Makefile
index 2aeadc4cef30..5167699701b9 100644
--- a/drivers/misc/habanalabs/Makefile
+++ b/drivers/misc/habanalabs/Makefile
@@ -5,7 +5,8 @@
 obj-m	:= habanalabs.o
 
 habanalabs-y := habanalabs_drv.o device.o context.o asid.o habanalabs_ioctl.o \
-		command_buffer.o hw_queue.o irq.o sysfs.o hwmon.o
+		command_buffer.o hw_queue.o irq.o sysfs.o hwmon.o memory.o \
+		command_submission.o
 
 include $(src)/goya/Makefile
 habanalabs-y += $(HL_GOYA_FILES)
diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
new file mode 100644
index 000000000000..288dddc14873
--- /dev/null
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -0,0 +1,770 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include <uapi/misc/habanalabs.h>
+#include "habanalabs.h"
+
+#include <linux/sched/mm.h>
+#include <linux/sched/task.h>
+#include <linux/sched/signal.h>
+#include <linux/wait.h>
+#include <linux/mm.h>
+#include <linux/highmem.h>
+
+static void job_wq_completion(struct work_struct *work);
+static long _hl_cs_wait_ioctl(struct hl_device *hdev,
+		struct hl_ctx *ctx, u64 timeout_us, u64 seq);
+static void cs_do_release(struct kref *ref);
+
+static const char *hl_fence_get_driver_name(struct dma_fence *fence)
+{
+	return "HabanaLabs";
+}
+
+static const char *hl_fence_get_timeline_name(struct dma_fence *fence)
+{
+	struct hl_dma_fence *hl_fence =
+		container_of(fence, struct hl_dma_fence, base_fence);
+
+	return dev_name(hl_fence->hdev->dev);
+}
+
+static bool hl_fence_enable_signaling(struct dma_fence *fence)
+{
+	return true;
+}
+
+static void hl_fence_release(struct dma_fence *fence)
+{
+	struct hl_dma_fence *hl_fence =
+		container_of(fence, struct hl_dma_fence, base_fence);
+
+	kfree_rcu(hl_fence, base_fence.rcu);
+}
+
+static const struct dma_fence_ops hl_fence_ops = {
+	.get_driver_name = hl_fence_get_driver_name,
+	.get_timeline_name = hl_fence_get_timeline_name,
+	.enable_signaling = hl_fence_enable_signaling,
+	.wait = dma_fence_default_wait,
+	.release = hl_fence_release
+};
+
+static void cs_get(struct hl_cs *cs)
+{
+	kref_get(&cs->refcount);
+}
+
+static int cs_get_unless_zero(struct hl_cs *cs)
+{
+	return kref_get_unless_zero(&cs->refcount);
+}
+
+static void cs_put(struct hl_cs *cs)
+{
+	kref_put(&cs->refcount, cs_do_release);
+}
+
+/*
+ * cs_parser - parse the user command submission
+ *
+ * @hpriv	: pointer to the private data of the fd
+ * @job        : pointer to the job that holds the command submission info
+ *
+ * The function parses the command submission of the user. It calls the
+ * ASIC specific parser, which returns a list of memory blocks to send
+ * to the device as different command buffers
+ *
+ */
+static int cs_parser(struct hl_fpriv *hpriv, struct hl_cs_job *job)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	struct hl_cs_parser parser;
+	int rc;
+
+	parser.ctx_id = job->cs->ctx->asid;
+	parser.cs_sequence = job->cs->sequence;
+	parser.job_id = job->id;
+
+	parser.hw_queue_id = job->hw_queue_id;
+	parser.job_userptr_list = &job->userptr_list;
+	parser.patched_cb = NULL;
+	parser.user_cb = job->user_cb;
+	parser.user_cb_size = job->user_cb_size;
+	parser.ext_queue = job->ext_queue;
+	job->patched_cb = NULL;
+	parser.use_virt_addr = hdev->mmu_enable;
+
+	rc = hdev->asic_funcs->cs_parser(hdev, &parser);
+	if (job->ext_queue) {
+		if (!rc) {
+			job->patched_cb = parser.patched_cb;
+			job->job_cb_size = parser.patched_cb_size;
+
+			spin_lock(&job->patched_cb->lock);
+			job->patched_cb->cs_cnt++;
+			spin_unlock(&job->patched_cb->lock);
+		}
+
+		/*
+		 * Whether the parsing worked or not, we don't need the
+		 * original CB anymore because it was already parsed and
+		 * won't be accessed again for this CS
+		 */
+		spin_lock(&job->user_cb->lock);
+		job->user_cb->cs_cnt--;
+		spin_unlock(&job->user_cb->lock);
+		hl_cb_put(job->user_cb);
+		job->user_cb = NULL;
+	}
+
+	return rc;
+}
+
+static void free_job(struct hl_device *hdev, struct hl_cs_job *job)
+{
+	struct hl_cs *cs = job->cs;
+
+	if (job->ext_queue) {
+		hl_userptr_delete_list(hdev, &job->userptr_list);
+
+		/*
+		 * We might arrive here from rollback and patched CB wasn't
+		 * created, so we need to check it's not NULL
+		 */
+		if (job->patched_cb) {
+			spin_lock(&job->patched_cb->lock);
+			job->patched_cb->cs_cnt--;
+			spin_unlock(&job->patched_cb->lock);
+
+			hl_cb_put(job->patched_cb);
+		}
+	}
+
+	/*
+	 * This is the only place where there can be multiple threads
+	 * modifying the list at the same time
+	 */
+	spin_lock(&cs->job_lock);
+	list_del(&job->cs_node);
+	spin_unlock(&cs->job_lock);
+
+	if (job->ext_queue)
+		cs_put(cs);
+
+	kfree(job);
+}
+
+static void cs_do_release(struct kref *ref)
+{
+	struct hl_cs *cs = container_of(ref, struct hl_cs,
+						refcount);
+	struct hl_device *hdev = cs->ctx->hdev;
+	struct hl_cs_job *job, *tmp;
+
+	cs->completed = true;
+
+	/*
+	 * Although if we reached here it means that all external jobs have
+	 * finished, because each one of them took refcnt to CS, we still
+	 * need to go over the internal jobs and free them. Otherwise, we
+	 * will have leaked memory and what's worse, the CS object (and
+	 * potentially the CTX object) could be released, while the JOB
+	 * still holds a pointer to them (but no reference).
+	 */
+	list_for_each_entry_safe(job, tmp, &cs->job_list, cs_node)
+		free_job(hdev, job);
+
+	/* We also need to update CI for internal queues */
+	if (cs->submitted) {
+		hl_int_hw_queue_update_ci(cs);
+
+		spin_lock(&hdev->hw_queues_mirror_lock);
+		/* remove CS from hw_queues mirror list */
+		list_del_init(&cs->mirror_node);
+		spin_unlock(&hdev->hw_queues_mirror_lock);
+
+		/*
+		 * Don't cancel TDR in case this CS was timedout because we
+		 * might be running from the TDR context
+		 */
+		if ((!cs->timedout) &&
+			(hdev->timeout_jiffies != MAX_SCHEDULE_TIMEOUT)) {
+			struct hl_cs *next;
+
+			if (cs->tdr_active)
+				cancel_delayed_work_sync(&cs->work_tdr);
+
+			spin_lock(&hdev->hw_queues_mirror_lock);
+
+			/* queue TDR for next CS */
+			next = list_first_entry_or_null(
+					&hdev->hw_queues_mirror_list,
+					struct hl_cs, mirror_node);
+
+			if ((next) && (!next->tdr_active)) {
+				next->tdr_active = true;
+				schedule_delayed_work(&next->work_tdr,
+							hdev->timeout_jiffies);
+			}
+
+			spin_unlock(&hdev->hw_queues_mirror_lock);
+		}
+	}
+
+	hl_ctx_put(cs->ctx);
+
+	if (cs->timedout)
+		dma_fence_set_error(cs->fence, -ETIMEDOUT);
+	else if (cs->aborted)
+		dma_fence_set_error(cs->fence, -EIO);
+
+	dma_fence_signal(cs->fence);
+	dma_fence_put(cs->fence);
+
+	kfree(cs);
+}
+
+static void cs_timedout(struct work_struct *work)
+{
+	struct hl_device *hdev;
+	int ctx_asid, rc;
+	struct hl_cs *cs = container_of(work, struct hl_cs,
+						 work_tdr.work);
+	rc = cs_get_unless_zero(cs);
+	if (!rc)
+		return;
+
+	if ((!cs->submitted) || (cs->completed)) {
+		cs_put(cs);
+		return;
+	}
+
+	/* Mark the CS is timed out so we won't try to cancel its TDR */
+	cs->timedout = true;
+
+	hdev = cs->ctx->hdev;
+	ctx_asid = cs->ctx->asid;
+
+	/* TODO: add information about last signaled seq and last emitted seq */
+	dev_err(hdev->dev, "CS %d.%llu got stuck!\n", ctx_asid, cs->sequence);
+
+	cs_put(cs);
+
+	if (hdev->reset_on_lockup)
+		hl_device_reset(hdev, false, false);
+}
+
+static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
+			struct hl_cs **cs_new)
+{
+	struct hl_dma_fence *fence;
+	struct dma_fence *other = NULL;
+	struct hl_cs *cs;
+	int rc;
+
+	cs = kzalloc(sizeof(*cs), GFP_ATOMIC);
+	if (!cs)
+		return -ENOMEM;
+
+	cs->ctx = ctx;
+	cs->submitted = false;
+	cs->completed = false;
+	INIT_LIST_HEAD(&cs->job_list);
+	INIT_DELAYED_WORK(&cs->work_tdr, cs_timedout);
+	kref_init(&cs->refcount);
+	spin_lock_init(&cs->job_lock);
+
+	fence = kmalloc(sizeof(*fence), GFP_ATOMIC);
+	if (!fence) {
+		rc = -ENOMEM;
+		goto free_cs;
+	}
+
+	fence->hdev = hdev;
+	spin_lock_init(&fence->lock);
+	cs->fence = &fence->base_fence;
+
+	spin_lock(&ctx->cs_lock);
+
+	fence->cs_seq = ctx->cs_sequence;
+	other = ctx->cs_pending[fence->cs_seq & (HL_MAX_PENDING_CS - 1)];
+	if ((other) && (!dma_fence_is_signaled(other))) {
+		spin_unlock(&ctx->cs_lock);
+		rc = -EAGAIN;
+		goto free_fence;
+	}
+
+	dma_fence_init(&fence->base_fence, &hl_fence_ops, &fence->lock,
+			ctx->asid, ctx->cs_sequence);
+
+	cs->sequence = fence->cs_seq;
+
+	ctx->cs_pending[fence->cs_seq & (HL_MAX_PENDING_CS - 1)] =
+							&fence->base_fence;
+	ctx->cs_sequence++;
+
+	dma_fence_get(&fence->base_fence);
+
+	dma_fence_put(other);
+
+	spin_unlock(&ctx->cs_lock);
+
+	*cs_new = cs;
+
+	return 0;
+
+free_fence:
+	kfree(fence);
+free_cs:
+	kfree(cs);
+	return rc;
+}
+
+static void cs_rollback(struct hl_device *hdev, struct hl_cs *cs)
+{
+	struct hl_cs_job *job, *tmp;
+
+	list_for_each_entry_safe(job, tmp, &cs->job_list, cs_node)
+		free_job(hdev, job);
+}
+
+void hl_cs_rollback_all(struct hl_device *hdev)
+{
+	struct hl_cs *cs, *tmp;
+
+	/* flush all completions */
+	flush_workqueue(hdev->cq_wq);
+
+	/* Make sure we don't have leftovers in the H/W queues mirror list */
+	list_for_each_entry_safe(cs, tmp, &hdev->hw_queues_mirror_list,
+				mirror_node) {
+		cs_get(cs);
+		cs->aborted = true;
+		dev_warn_ratelimited(hdev->dev, "Killing CS %d.%llu\n",
+					cs->ctx->asid, cs->sequence);
+		cs_rollback(hdev, cs);
+		cs_put(cs);
+	}
+}
+
+static void job_wq_completion(struct work_struct *work)
+{
+	struct hl_cs_job *job = container_of(work, struct hl_cs_job,
+						finish_work);
+	struct hl_cs *cs = job->cs;
+	struct hl_device *hdev = cs->ctx->hdev;
+
+	/* job is no longer needed */
+	free_job(hdev, job);
+}
+
+static struct hl_cb *validate_queue_index(struct hl_device *hdev,
+					struct hl_cb_mgr *cb_mgr,
+					struct hl_cs_chunk *chunk,
+					bool *ext_queue)
+{
+	struct asic_fixed_properties *asic = &hdev->asic_prop;
+	struct hw_queue_properties *hw_queue_prop;
+	u32 cb_handle;
+	struct hl_cb *cb;
+
+	/* Assume external queue */
+	*ext_queue = true;
+
+	hw_queue_prop = &asic->hw_queues_props[chunk->queue_index];
+
+	if ((chunk->queue_index >= HL_MAX_QUEUES) ||
+			(hw_queue_prop->type == QUEUE_TYPE_NA)) {
+		dev_err(hdev->dev, "Queue index %d is invalid\n",
+			chunk->queue_index);
+		return NULL;
+	}
+
+	if (hw_queue_prop->kmd_only) {
+		dev_err(hdev->dev, "Queue index %d is restricted for KMD\n",
+			chunk->queue_index);
+		return NULL;
+	} else if (hw_queue_prop->type == QUEUE_TYPE_INT) {
+		*ext_queue = false;
+		return (struct hl_cb *) chunk->cb_handle;
+	}
+
+	/* Retrieve CB object */
+	cb_handle = (u32) (chunk->cb_handle >> PAGE_SHIFT);
+
+	cb = hl_cb_get(hdev, cb_mgr, cb_handle);
+	if (!cb) {
+		dev_err(hdev->dev, "CB handle 0x%x invalid\n", cb_handle);
+		return NULL;
+	}
+
+	if ((chunk->cb_size < 8) || (chunk->cb_size > cb->size)) {
+		dev_err(hdev->dev, "CB size %u invalid\n", chunk->cb_size);
+		goto release_cb;
+	}
+
+	spin_lock(&cb->lock);
+	cb->cs_cnt++;
+	spin_unlock(&cb->lock);
+
+	return cb;
+
+release_cb:
+	hl_cb_put(cb);
+	return NULL;
+}
+
+struct hl_cs_job *hl_cs_allocate_job(struct hl_device *hdev, bool ext_queue)
+{
+	struct hl_cs_job *job;
+
+	job = kzalloc(sizeof(*job), GFP_ATOMIC);
+	if (!job)
+		return NULL;
+
+	job->ext_queue = ext_queue;
+
+	if (job->ext_queue) {
+		INIT_LIST_HEAD(&job->userptr_list);
+		INIT_WORK(&job->finish_work, job_wq_completion);
+	}
+
+	return job;
+}
+
+static int _hl_cs_ioctl(struct hl_fpriv *hpriv, void __user *chunks,
+			u32 num_chunks, u64 *cs_seq)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	struct hl_cs_chunk *cs_chunk_array;
+	struct hl_cs_job *job;
+	struct hl_cs *cs;
+	struct hl_cb *cb;
+	bool ext_queue_present = false;
+	u32 size_to_copy;
+	int rc, i, parse_cnt;
+
+	*cs_seq = ULLONG_MAX;
+
+	if (num_chunks > HL_MAX_JOBS_PER_CS) {
+		dev_err(hdev->dev,
+			"Number of chunks can NOT be larger than %d\n",
+			HL_MAX_JOBS_PER_CS);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	cs_chunk_array = kmalloc_array(num_chunks, sizeof(*cs_chunk_array),
+					GFP_ATOMIC);
+	if (!cs_chunk_array) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	size_to_copy = num_chunks * sizeof(struct hl_cs_chunk);
+	if (copy_from_user(cs_chunk_array, chunks, size_to_copy)) {
+		dev_err(hdev->dev, "Failed to copy cs chunk array from user\n");
+		rc = -EFAULT;
+		goto free_cs_chunk_array;
+	}
+
+	/* increment refcnt for context */
+	hl_ctx_get(hdev, hpriv->ctx);
+
+	rc = allocate_cs(hdev, hpriv->ctx, &cs);
+	if (rc) {
+		hl_ctx_put(hpriv->ctx);
+		goto free_cs_chunk_array;
+	}
+
+	*cs_seq = cs->sequence;
+
+	/* Validate ALL the CS chunks before submitting the CS */
+	for (i = 0, parse_cnt = 0 ; i < num_chunks ; i++, parse_cnt++) {
+		struct hl_cs_chunk *chunk = &cs_chunk_array[i];
+		bool ext_queue;
+
+		cb = validate_queue_index(hdev, &hpriv->cb_mgr, chunk,
+					&ext_queue);
+		if (ext_queue) {
+			ext_queue_present = true;
+			if (!cb) {
+				rc = -EINVAL;
+				goto free_cs_object;
+			}
+		}
+
+		job = hl_cs_allocate_job(hdev, ext_queue);
+		if (!job) {
+			dev_err(hdev->dev, "Failed to allocate a new job\n");
+			rc = -ENOMEM;
+			if (ext_queue)
+				goto release_cb;
+			else
+				goto free_cs_object;
+		}
+
+		job->id = i + 1;
+		job->cs = cs;
+		job->user_cb = cb;
+		job->user_cb_size = chunk->cb_size;
+		if (job->ext_queue)
+			job->job_cb_size = cb->size;
+		else
+			job->job_cb_size = chunk->cb_size;
+		job->hw_queue_id = chunk->queue_index;
+
+		cs->jobs_in_queue_cnt[job->hw_queue_id]++;
+
+		list_add_tail(&job->cs_node, &cs->job_list);
+
+		/*
+		 * Increment CS reference. When CS reference is 0, CS is
+		 * done and can be signaled to user and free all its resources
+		 * Only increment for JOB on external queues, because only
+		 * for those JOBs we get completion
+		 */
+		if (job->ext_queue)
+			cs_get(cs);
+
+		rc = cs_parser(hpriv, job);
+		if (rc) {
+			dev_err(hdev->dev,
+				"Failed to parse JOB %d.%llu.%d, err %d, rejecting the CS\n",
+				cs->ctx->asid, cs->sequence, job->id, rc);
+			goto free_cs_object;
+		}
+	}
+
+	if (!ext_queue_present) {
+		dev_err(hdev->dev,
+			"Reject CS %d.%llu because no external queues jobs\n",
+			cs->ctx->asid, cs->sequence);
+		rc = -EINVAL;
+		goto free_cs_object;
+	}
+
+	rc = hl_hw_queue_schedule_cs(cs);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to submit CS %d.%llu to H/W queues, error %d\n",
+			cs->ctx->asid, cs->sequence, rc);
+		goto free_cs_object;
+	}
+
+	rc = HL_CS_STATUS_SUCCESS;
+	goto put_cs;
+
+release_cb:
+	spin_lock(&cb->lock);
+	cb->cs_cnt--;
+	spin_unlock(&cb->lock);
+	hl_cb_put(cb);
+free_cs_object:
+	cs_rollback(hdev, cs);
+	*cs_seq = ULLONG_MAX;
+	/* The path below is both for good and erroneous exits */
+put_cs:
+	/* We finished with the CS in this function, so put the ref */
+	cs_put(cs);
+free_cs_chunk_array:
+	kfree(cs_chunk_array);
+out:
+	return rc;
+}
+
+int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	union hl_cs_args *args = data;
+	void __user *chunks;
+	u32 num_chunks;
+	u64 cs_seq = ULONG_MAX;
+	int rc, do_restore;
+	bool need_soft_reset = false;
+
+	if (hl_device_disabled_or_in_reset(hdev)) {
+		dev_warn(hdev->dev,
+			"Device is %s. Can't submit new CS\n",
+			atomic_read(&hdev->in_reset) ? "in_reset" : "disabled");
+		rc = -EBUSY;
+		goto out;
+	}
+
+	do_restore = atomic_cmpxchg(&hpriv->ctx->thread_restore_token, 1, 0);
+
+	if (do_restore || (args->in.cs_flags & HL_CS_FLAGS_FORCE_RESTORE)) {
+		long ret;
+
+		chunks = (void __user *)(uintptr_t)args->in.chunks_restore;
+		num_chunks = args->in.num_chunks_restore;
+
+		mutex_lock(&hpriv->restore_phase_mutex);
+
+		if (do_restore) {
+			rc = hdev->asic_funcs->context_switch(hdev,
+					hpriv->ctx->asid);
+			if (rc) {
+				dev_err_ratelimited(hdev->dev,
+					"Failed to switch to context %d, rejecting CS! %d\n",
+					hpriv->ctx->asid, rc);
+				/*
+				 * If we timedout, we need to soft-reset because
+				 * QMAN is probably stuck. However, we can't
+				 * call to reset here directly because of
+				 * deadlock, so need to do it at the very end
+				 * of this function
+				 */
+				if (rc == -ETIMEDOUT)
+					need_soft_reset = true;
+				mutex_unlock(&hpriv->restore_phase_mutex);
+				goto out;
+			}
+		}
+
+		hdev->asic_funcs->restore_phase_topology(hdev);
+
+		if (num_chunks == 0) {
+			dev_dbg(hdev->dev,
+			"Need to run restore phase but restore CS is empty\n");
+			rc = 0;
+		} else {
+			rc = _hl_cs_ioctl(hpriv, chunks, num_chunks,
+						&cs_seq);
+		}
+
+		mutex_unlock(&hpriv->restore_phase_mutex);
+
+		if (rc) {
+			dev_err(hdev->dev,
+				"Failed to submit restore CS for context %d (%d)\n",
+				hpriv->ctx->asid, rc);
+			goto out;
+		}
+
+		/* Need to wait for restore completion before execution phase */
+		if (num_chunks > 0) {
+			ret = _hl_cs_wait_ioctl(hdev, hpriv->ctx,
+					jiffies_to_usecs(hdev->timeout_jiffies),
+					cs_seq);
+			if (ret <= 0) {
+				dev_err(hdev->dev,
+					"Restore CS for context %d failed to complete %ld\n",
+					hpriv->ctx->asid, ret);
+				rc = -ENOEXEC;
+				goto out;
+			}
+		}
+
+		hpriv->ctx->thread_restore_wait_token = 1;
+	} else if (!hpriv->ctx->thread_restore_wait_token) {
+		u32 tmp;
+
+		rc = hl_poll_timeout_memory(hdev,
+			(u64) &hpriv->ctx->thread_restore_wait_token,
+			jiffies_to_usecs(hdev->timeout_jiffies),
+			&tmp);
+
+		if (rc || !tmp) {
+			dev_err(hdev->dev,
+				"restore phase hasn't finished in time\n");
+			rc = -ETIMEDOUT;
+			goto out;
+		}
+	}
+
+	chunks = (void __user *)(uintptr_t)args->in.chunks_execute;
+	num_chunks = args->in.num_chunks_execute;
+
+	if (num_chunks == 0) {
+		dev_err(hdev->dev,
+			"Got execute CS with 0 chunks, context %d\n",
+			hpriv->ctx->asid);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	rc = _hl_cs_ioctl(hpriv, chunks, num_chunks, &cs_seq);
+
+out:
+	if (rc != -EAGAIN) {
+		memset(args, 0, sizeof(*args));
+		args->out.status = rc;
+		args->out.seq = cs_seq;
+	}
+
+	if ((rc == -ETIMEDOUT) && (need_soft_reset))
+		hl_device_reset(hdev, false, false);
+
+	return rc;
+}
+
+static long _hl_cs_wait_ioctl(struct hl_device *hdev,
+		struct hl_ctx *ctx, u64 timeout_us, u64 seq)
+{
+	struct dma_fence *fence;
+	unsigned long timeout;
+	long rc;
+
+	if (timeout_us == MAX_SCHEDULE_TIMEOUT)
+		timeout = timeout_us;
+	else
+		timeout = usecs_to_jiffies(timeout_us);
+
+	hl_ctx_get(hdev, ctx);
+
+	fence = hl_ctx_get_fence(ctx, seq);
+	if (IS_ERR(fence)) {
+		rc = PTR_ERR(fence);
+	} else if (fence) {
+		rc = dma_fence_wait_timeout(fence, true, timeout);
+		if (fence->error == -ETIMEDOUT)
+			rc = -ETIMEDOUT;
+		else if (fence->error == -EIO)
+			rc = -EIO;
+		dma_fence_put(fence);
+	} else
+		rc = 1;
+
+	hl_ctx_put(ctx);
+
+	return rc;
+}
+
+int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	union hl_wait_cs_args *args = data;
+	u64 seq = args->in.seq;
+	long rc;
+
+	rc = _hl_cs_wait_ioctl(hdev, hpriv->ctx, args->in.timeout_us, seq);
+
+	memset(args, 0, sizeof(*args));
+
+	if (rc < 0) {
+		dev_err(hdev->dev, "Error %ld on waiting for CS handle %llu\n",
+			rc, seq);
+		if (rc == -ERESTARTSYS) {
+			args->out.status = HL_WAIT_CS_STATUS_INTERRUPTED;
+			rc = -EINTR;
+		} else if (rc == -ETIMEDOUT) {
+			args->out.status = HL_WAIT_CS_STATUS_TIMEDOUT;
+		} else if (rc == -EIO) {
+			args->out.status = HL_WAIT_CS_STATUS_ABORTED;
+		}
+		return rc;
+	}
+
+	if (rc == 0)
+		args->out.status = HL_WAIT_CS_STATUS_BUSY;
+	else
+		args->out.status = HL_WAIT_CS_STATUS_COMPLETED;
+
+	return 0;
+}
diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
index 4d46e51e1a82..98710646de6c 100644
--- a/drivers/misc/habanalabs/context.c
+++ b/drivers/misc/habanalabs/context.c
@@ -13,6 +13,18 @@
 static void hl_ctx_fini(struct hl_ctx *ctx)
 {
 	struct hl_device *hdev = ctx->hdev;
+	int i;
+
+	/*
+	 * If we arrived here, there are no jobs waiting for this context
+	 * on its queues so we can safely remove it.
+	 * This is because for each CS, we increment the ref count and for
+	 * every CS that was finished we decrement it and we won't arrive
+	 * to this function unless the ref count is 0
+	 */
+
+	for (i = 0 ; i < HL_MAX_PENDING_CS ; i++)
+		dma_fence_put(ctx->cs_pending[i]);
 
 	if (ctx->asid != HL_KERNEL_ASID_ID)
 		hl_asid_free(hdev, ctx->asid);
@@ -24,8 +36,6 @@ void hl_ctx_do_release(struct kref *ref)
 
 	ctx = container_of(ref, struct hl_ctx, refcount);
 
-	dev_dbg(ctx->hdev->dev, "Now really releasing context %d\n", ctx->asid);
-
 	hl_ctx_fini(ctx);
 
 	if (ctx->hpriv)
@@ -91,6 +101,11 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 
 	kref_init(&ctx->refcount);
 
+	ctx->cs_sequence = 1;
+	spin_lock_init(&ctx->cs_lock);
+	atomic_set(&ctx->thread_restore_token, 1);
+	ctx->thread_restore_wait_token = 0;
+
 	if (is_kernel_ctx) {
 		ctx->asid = HL_KERNEL_ASID_ID; /* KMD gets ASID 0 */
 	} else {
@@ -101,8 +116,6 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 		}
 	}
 
-	dev_dbg(hdev->dev, "Created context with ASID %u\n", ctx->asid);
-
 	return 0;
 }
 
@@ -116,6 +129,37 @@ int hl_ctx_put(struct hl_ctx *ctx)
 	return kref_put(&ctx->refcount, hl_ctx_do_release);
 }
 
+struct dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq)
+{
+	struct hl_device *hdev = ctx->hdev;
+	struct dma_fence *fence;
+
+	spin_lock(&ctx->cs_lock);
+
+	if (seq >= ctx->cs_sequence) {
+		dev_notice(hdev->dev,
+			"Can't wait on seq %llu because current CS is at seq %llu\n",
+			seq, ctx->cs_sequence);
+		spin_unlock(&ctx->cs_lock);
+		return ERR_PTR(-EINVAL);
+	}
+
+
+	if (seq + HL_MAX_PENDING_CS < ctx->cs_sequence) {
+		dev_dbg(hdev->dev,
+			"Can't wait on seq %llu because current CS is at seq %llu (Fence is gone)\n",
+			seq, ctx->cs_sequence);
+		spin_unlock(&ctx->cs_lock);
+		return NULL;
+	}
+
+	fence = dma_fence_get(
+			ctx->cs_pending[seq & (HL_MAX_PENDING_CS - 1)]);
+	spin_unlock(&ctx->cs_lock);
+
+	return fence;
+}
+
 /*
  * hl_ctx_mgr_init - initialize the context manager
  *
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index d64c250feb1c..ad27d46a03ba 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -30,6 +30,8 @@ static void hpriv_release(struct kref *ref)
 
 	put_pid(hpriv->taskpid);
 
+	mutex_destroy(&hpriv->restore_phase_mutex);
+
 	kfree(hpriv);
 
 	/* Now the FD is really closed */
@@ -201,6 +203,8 @@ static int device_early_init(struct hl_device *hdev)
 
 	mutex_init(&hdev->fd_open_cnt_lock);
 	mutex_init(&hdev->send_cpu_message_lock);
+	INIT_LIST_HEAD(&hdev->hw_queues_mirror_list);
+	spin_lock_init(&hdev->hw_queues_mirror_lock);
 	atomic_set(&hdev->in_reset, 0);
 	atomic_set(&hdev->fd_open_cnt, 0);
 
@@ -582,6 +586,9 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 	 */
 	hdev->asic_funcs->halt_engines(hdev, hard_reset);
 
+	/* Go over all the queues, release all CS and their jobs */
+	hl_cs_rollback_all(hdev);
+
 	if (hard_reset) {
 		/* Release kernel context */
 		if (hl_ctx_put(hdev->kernel_ctx) != 1) {
@@ -605,6 +612,12 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
 		hl_cq_reset(hdev, &hdev->completion_queue[i]);
 
+	/* Make sure the setup phase for the user context will run again */
+	if (hdev->user_ctx) {
+		atomic_set(&hdev->user_ctx->thread_restore_token, 1);
+		hdev->user_ctx->thread_restore_wait_token = 0;
+	}
+
 	/* Finished tear-down, starting to re-initialize */
 
 	if (hard_reset) {
@@ -930,6 +943,9 @@ void hl_device_fini(struct hl_device *hdev)
 	 */
 	hdev->asic_funcs->halt_engines(hdev, true);
 
+	/* Go over all the queues, release all CS and their jobs */
+	hl_cs_rollback_all(hdev);
+
 	hl_cb_pool_fini(hdev);
 
 	/* Release kernel context */
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index ee573b649ed9..8ff104b8ecc0 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -102,6 +102,19 @@ static const char goya_irq_name[GOYA_MSIX_ENTRIES][GOYA_MAX_STRING_LEN] = {
 		"goya cq 4", "goya cpu eq"
 };
 
+static u16 goya_packet_sizes[MAX_PACKET_ID] = {
+	[PACKET_WREG_32]	= sizeof(struct packet_wreg32),
+	[PACKET_WREG_BULK]	= sizeof(struct packet_wreg_bulk),
+	[PACKET_MSG_LONG]	= sizeof(struct packet_msg_long),
+	[PACKET_MSG_SHORT]	= sizeof(struct packet_msg_short),
+	[PACKET_CP_DMA]		= sizeof(struct packet_cp_dma),
+	[PACKET_MSG_PROT]	= sizeof(struct packet_msg_prot),
+	[PACKET_FENCE]		= sizeof(struct packet_fence),
+	[PACKET_LIN_DMA]	= sizeof(struct packet_lin_dma),
+	[PACKET_NOP]		= sizeof(struct packet_nop),
+	[PACKET_STOP]		= sizeof(struct packet_stop)
+};
+
 static const char *goya_axi_name[GOYA_MAX_INITIATORS] = {
 	"MME0",
 	"MME1",
@@ -2972,6 +2985,84 @@ void *goya_get_int_queue_base(struct hl_device *hdev, u32 queue_id,
 	return base;
 }
 
+int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	struct packet_msg_prot *fence_pkt;
+	u32 *fence_ptr;
+	dma_addr_t fence_dma_addr;
+	struct hl_cb *cb;
+	u32 tmp;
+	int rc;
+
+	if (!hdev->asic_funcs->is_device_idle(hdev)) {
+		dev_err_ratelimited(hdev->dev,
+			"Can't send KMD job on QMAN0 if device is not idle\n");
+		return -EFAULT;
+	}
+
+	fence_ptr = hdev->asic_funcs->dma_pool_zalloc(hdev, 4, GFP_KERNEL,
+							&fence_dma_addr);
+	if (!fence_ptr) {
+		dev_err(hdev->dev,
+			"Failed to allocate fence memory for QMAN0\n");
+		return -ENOMEM;
+	}
+
+	*fence_ptr = 0;
+
+	if (goya->hw_cap_initialized & HW_CAP_MMU) {
+		WREG32(mmDMA_QM_0_GLBL_PROT, QMAN_DMA_FULLY_TRUSTED);
+		RREG32(mmDMA_QM_0_GLBL_PROT);
+	}
+
+	/*
+	 * goya cs parser saves space for 2xpacket_msg_prot at end of CB. For
+	 * synchronized kernel jobs we only need space for 1 packet_msg_prot
+	 */
+	job->job_cb_size -= sizeof(struct packet_msg_prot);
+
+	cb = job->patched_cb;
+
+	fence_pkt = (struct packet_msg_prot *) (cb->kernel_address +
+			job->job_cb_size - sizeof(struct packet_msg_prot));
+
+	fence_pkt->ctl = (PACKET_MSG_PROT << GOYA_PKT_CTL_OPCODE_SHIFT) |
+			(1 << GOYA_PKT_CTL_EB_SHIFT) |
+			(1 << GOYA_PKT_CTL_MB_SHIFT);
+	fence_pkt->value = GOYA_QMAN0_FENCE_VAL;
+	fence_pkt->addr = fence_dma_addr +
+			hdev->asic_prop.host_phys_base_address;
+
+	rc = hl_hw_queue_send_cb_no_cmpl(hdev, GOYA_QUEUE_ID_DMA_0,
+					job->job_cb_size, cb->bus_address);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to send CB on QMAN0, %d\n", rc);
+		goto free_fence_ptr;
+	}
+
+	rc = hl_poll_timeout_memory(hdev, (u64) fence_ptr,
+					HL_DEVICE_TIMEOUT_USEC, &tmp);
+
+	hl_hw_queue_inc_ci_kernel(hdev, GOYA_QUEUE_ID_DMA_0);
+
+	if ((rc) || (tmp != GOYA_QMAN0_FENCE_VAL)) {
+		dev_err(hdev->dev, "QMAN0 Job hasn't finished in time\n");
+		rc = -ETIMEDOUT;
+	}
+
+free_fence_ptr:
+	hdev->asic_funcs->dma_pool_free(hdev, (void *) fence_ptr,
+					fence_dma_addr);
+
+	if (goya->hw_cap_initialized & HW_CAP_MMU) {
+		WREG32(mmDMA_QM_0_GLBL_PROT, QMAN_DMA_PARTLY_TRUSTED);
+		RREG32(mmDMA_QM_0_GLBL_PROT);
+	}
+
+	return rc;
+}
+
 int goya_send_cpu_message(struct hl_device *hdev, u32 *msg, u16 len,
 				u32 timeout, long *result)
 {
@@ -3206,11 +3297,981 @@ void goya_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
 	gen_pool_free(hdev->cpu_accessible_dma_pool, (u64) vaddr, size);
 }
 
+int goya_dma_map_sg(struct hl_device *hdev, struct scatterlist *sg, int nents,
+			enum dma_data_direction dir)
+{
+	if (!dma_map_sg(&hdev->pdev->dev, sg, nents, dir))
+		return -ENOMEM;
+
+	return 0;
+}
+
+void goya_dma_unmap_sg(struct hl_device *hdev, struct scatterlist *sg,
+			int nents, enum dma_data_direction dir)
+{
+	dma_unmap_sg(&hdev->pdev->dev, sg, nents, dir);
+}
+
+u32 goya_get_dma_desc_list_size(struct hl_device *hdev,
+					struct sg_table *sgt)
+{
+	struct scatterlist *sg, *sg_next_iter;
+	u32 count, len, dma_desc_cnt, len_next;
+	dma_addr_t addr, addr_next;
+
+	dma_desc_cnt = 0;
+
+	for_each_sg(sgt->sgl, sg, sgt->nents, count) {
+
+		len = sg_dma_len(sg);
+		addr = sg_dma_address(sg);
+
+		if (len == 0)
+			break;
+
+		while ((count + 1) < sgt->nents) {
+			sg_next_iter = sg_next(sg);
+			len_next = sg_dma_len(sg_next_iter);
+			addr_next = sg_dma_address(sg_next_iter);
+
+			if (len_next == 0)
+				break;
+
+			if ((addr + len == addr_next) &&
+				(len + len_next <= DMA_MAX_TRANSFER_SIZE)) {
+				len += len_next;
+				count++;
+				sg = sg_next_iter;
+			} else {
+				break;
+			}
+		}
+
+		dma_desc_cnt++;
+	}
+
+	return dma_desc_cnt * sizeof(struct packet_lin_dma);
+}
+
+static int goya_pin_memory_before_cs(struct hl_device *hdev,
+				struct hl_cs_parser *parser,
+				struct packet_lin_dma *user_dma_pkt,
+				u64 addr, enum dma_data_direction dir)
+{
+	struct hl_userptr *userptr;
+	int rc;
+
+	if (hl_userptr_is_pinned(hdev, addr, user_dma_pkt->tsize,
+			parser->job_userptr_list, &userptr))
+		goto already_pinned;
+
+	userptr = kzalloc(sizeof(*userptr), GFP_ATOMIC);
+	if (!userptr)
+		return -ENOMEM;
+
+	rc = hl_pin_host_memory(hdev, addr, user_dma_pkt->tsize, userptr);
+	if (rc)
+		goto free_userptr;
+
+	list_add_tail(&userptr->job_node, parser->job_userptr_list);
+
+	rc = hdev->asic_funcs->asic_dma_map_sg(hdev, userptr->sgt->sgl,
+					userptr->sgt->nents, dir);
+	if (rc) {
+		dev_err(hdev->dev, "failed to map sgt with DMA region\n");
+		goto unpin_memory;
+	}
+
+	userptr->dma_mapped = true;
+	userptr->dir = dir;
+
+already_pinned:
+	parser->patched_cb_size +=
+			goya_get_dma_desc_list_size(hdev, userptr->sgt);
+
+	return 0;
+
+unpin_memory:
+	hl_unpin_host_memory(hdev, userptr);
+free_userptr:
+	kfree(userptr);
+	return rc;
+}
+
+static int goya_validate_dma_pkt_host(struct hl_device *hdev,
+				struct hl_cs_parser *parser,
+				struct packet_lin_dma *user_dma_pkt)
+{
+	u64 device_memory_addr, addr;
+	enum dma_data_direction dir;
+	enum goya_dma_direction user_dir;
+	bool sram_addr = true;
+	bool skip_host_mem_pin = false;
+	bool user_memset;
+	int rc = 0;
+
+	user_dir = (user_dma_pkt->ctl & GOYA_PKT_LIN_DMA_CTL_DMA_DIR_MASK) >>
+			GOYA_PKT_LIN_DMA_CTL_DMA_DIR_SHIFT;
+
+	user_memset = (user_dma_pkt->ctl & GOYA_PKT_LIN_DMA_CTL_MEMSET_MASK) >>
+			GOYA_PKT_LIN_DMA_CTL_MEMSET_SHIFT;
+
+	switch (user_dir) {
+	case DMA_HOST_TO_DRAM:
+		dev_dbg(hdev->dev, "DMA direction is HOST --> DRAM\n");
+		dir = DMA_TO_DEVICE;
+		sram_addr = false;
+		addr = user_dma_pkt->src_addr;
+		device_memory_addr = user_dma_pkt->dst_addr;
+		if (user_memset)
+			skip_host_mem_pin = true;
+		break;
+
+	case DMA_DRAM_TO_HOST:
+		dev_dbg(hdev->dev, "DMA direction is DRAM --> HOST\n");
+		dir = DMA_FROM_DEVICE;
+		sram_addr = false;
+		addr = user_dma_pkt->dst_addr;
+		device_memory_addr = user_dma_pkt->src_addr;
+		break;
+
+	case DMA_HOST_TO_SRAM:
+		dev_dbg(hdev->dev, "DMA direction is HOST --> SRAM\n");
+		dir = DMA_TO_DEVICE;
+		addr = user_dma_pkt->src_addr;
+		device_memory_addr = user_dma_pkt->dst_addr;
+		if (user_memset)
+			skip_host_mem_pin = true;
+		break;
+
+	case DMA_SRAM_TO_HOST:
+		dev_dbg(hdev->dev, "DMA direction is SRAM --> HOST\n");
+		dir = DMA_FROM_DEVICE;
+		addr = user_dma_pkt->dst_addr;
+		device_memory_addr = user_dma_pkt->src_addr;
+		break;
+	default:
+		dev_err(hdev->dev, "DMA direction is undefined\n");
+		return -EFAULT;
+	}
+
+	if (parser->ctx_id != HL_KERNEL_ASID_ID) {
+		if (sram_addr) {
+			if (!hl_mem_area_inside_range(device_memory_addr,
+					user_dma_pkt->tsize,
+					hdev->asic_prop.sram_user_base_address,
+					hdev->asic_prop.sram_end_address)) {
+
+				dev_err(hdev->dev,
+					"SRAM address 0x%llx + 0x%x is invalid\n",
+					device_memory_addr,
+					user_dma_pkt->tsize);
+				return -EFAULT;
+			}
+		} else {
+			if (!hl_mem_area_inside_range(device_memory_addr,
+					user_dma_pkt->tsize,
+					hdev->asic_prop.dram_user_base_address,
+					hdev->asic_prop.dram_end_address)) {
+
+				dev_err(hdev->dev,
+					"DRAM address 0x%llx + 0x%x is invalid\n",
+					device_memory_addr,
+					user_dma_pkt->tsize);
+				return -EFAULT;
+			}
+		}
+	}
+
+	if (skip_host_mem_pin)
+		parser->patched_cb_size += sizeof(*user_dma_pkt);
+	else {
+		if ((dir == DMA_TO_DEVICE) &&
+				(parser->hw_queue_id > GOYA_QUEUE_ID_DMA_1)) {
+			dev_err(hdev->dev,
+				"Can't DMA from host on queue other then 1\n");
+			return -EFAULT;
+		}
+
+		rc = goya_pin_memory_before_cs(hdev, parser, user_dma_pkt,
+						addr, dir);
+	}
+
+	return rc;
+}
+
+static int goya_validate_dma_pkt_no_host(struct hl_device *hdev,
+				struct hl_cs_parser *parser,
+				struct packet_lin_dma *user_dma_pkt)
+{
+	u64 sram_memory_addr, dram_memory_addr;
+	enum goya_dma_direction user_dir;
+
+	user_dir = (user_dma_pkt->ctl & GOYA_PKT_LIN_DMA_CTL_DMA_DIR_MASK) >>
+			GOYA_PKT_LIN_DMA_CTL_DMA_DIR_SHIFT;
+
+	if (user_dir == DMA_DRAM_TO_SRAM) {
+		dev_dbg(hdev->dev, "DMA direction is DRAM --> SRAM\n");
+		dram_memory_addr = user_dma_pkt->src_addr;
+		sram_memory_addr = user_dma_pkt->dst_addr;
+	} else {
+		dev_dbg(hdev->dev, "DMA direction is SRAM --> DRAM\n");
+		sram_memory_addr = user_dma_pkt->src_addr;
+		dram_memory_addr = user_dma_pkt->dst_addr;
+	}
+
+	if (!hl_mem_area_inside_range(sram_memory_addr, user_dma_pkt->tsize,
+				hdev->asic_prop.sram_user_base_address,
+				hdev->asic_prop.sram_end_address)) {
+		dev_err(hdev->dev, "SRAM address 0x%llx + 0x%x is invalid\n",
+			sram_memory_addr, user_dma_pkt->tsize);
+		return -EFAULT;
+	}
+
+	if (!hl_mem_area_inside_range(dram_memory_addr, user_dma_pkt->tsize,
+				hdev->asic_prop.dram_user_base_address,
+				hdev->asic_prop.dram_end_address)) {
+		dev_err(hdev->dev, "DRAM address 0x%llx + 0x%x is invalid\n",
+			dram_memory_addr, user_dma_pkt->tsize);
+		return -EFAULT;
+	}
+
+	parser->patched_cb_size += sizeof(*user_dma_pkt);
+
+	return 0;
+}
+
+static int goya_validate_dma_pkt_no_mmu(struct hl_device *hdev,
+				struct hl_cs_parser *parser,
+				struct packet_lin_dma *user_dma_pkt)
+{
+	enum goya_dma_direction user_dir;
+	int rc;
+
+	dev_dbg(hdev->dev, "DMA packet details:\n");
+	dev_dbg(hdev->dev, "source == 0x%llx\n", user_dma_pkt->src_addr);
+	dev_dbg(hdev->dev, "destination == 0x%llx\n", user_dma_pkt->dst_addr);
+	dev_dbg(hdev->dev, "size == %u\n", user_dma_pkt->tsize);
+
+	user_dir = (user_dma_pkt->ctl & GOYA_PKT_LIN_DMA_CTL_DMA_DIR_MASK) >>
+			GOYA_PKT_LIN_DMA_CTL_DMA_DIR_SHIFT;
+
+	/*
+	 * Special handling for DMA with size 0. The H/W has a bug where
+	 * this can cause the QMAN DMA to get stuck, so block it here.
+	 */
+	if (user_dma_pkt->tsize == 0) {
+		dev_err(hdev->dev,
+			"Got DMA with size 0, might reset the device\n");
+		return -EINVAL;
+	}
+
+	if ((user_dir == DMA_DRAM_TO_SRAM) || (user_dir == DMA_SRAM_TO_DRAM))
+		rc = goya_validate_dma_pkt_no_host(hdev, parser, user_dma_pkt);
+	else
+		rc = goya_validate_dma_pkt_host(hdev, parser, user_dma_pkt);
+
+	return rc;
+}
+
+static int goya_validate_dma_pkt_mmu(struct hl_device *hdev,
+				struct hl_cs_parser *parser,
+				struct packet_lin_dma *user_dma_pkt)
+{
+	dev_dbg(hdev->dev, "DMA packet details:\n");
+	dev_dbg(hdev->dev, "source == 0x%llx\n", user_dma_pkt->src_addr);
+	dev_dbg(hdev->dev, "destination == 0x%llx\n", user_dma_pkt->dst_addr);
+	dev_dbg(hdev->dev, "size == %u\n", user_dma_pkt->tsize);
+
+	/*
+	 * WA for HW-23.
+	 * We can't allow user to read from Host using QMANs other than 1.
+	 */
+	if (parser->hw_queue_id > GOYA_QUEUE_ID_DMA_1 &&
+		hl_mem_area_inside_range(user_dma_pkt->src_addr,
+				user_dma_pkt->tsize,
+				hdev->asic_prop.va_space_host_start_address,
+				hdev->asic_prop.va_space_host_end_address)) {
+		dev_err(hdev->dev,
+			"Can't DMA from host on queue other then 1\n");
+		return -EFAULT;
+	}
+
+	if (user_dma_pkt->tsize == 0) {
+		dev_err(hdev->dev,
+			"Got DMA with size 0, might reset the device\n");
+		return -EINVAL;
+	}
+
+	parser->patched_cb_size += sizeof(*user_dma_pkt);
+
+	return 0;
+}
+
+static int goya_validate_wreg32(struct hl_device *hdev,
+				struct hl_cs_parser *parser,
+				struct packet_wreg32 *wreg_pkt)
+{
+	struct goya_device *goya = hdev->asic_specific;
+	u32 sob_start_addr, sob_end_addr;
+	u16 reg_offset;
+
+	reg_offset = wreg_pkt->ctl & GOYA_PKT_WREG32_CTL_REG_OFFSET_MASK;
+
+	dev_dbg(hdev->dev, "WREG32 packet details:\n");
+	dev_dbg(hdev->dev, "reg_offset == 0x%x\n", reg_offset);
+	dev_dbg(hdev->dev, "value      == 0x%x\n", wreg_pkt->value);
+
+	if (reg_offset != (mmDMA_CH_1_WR_COMP_ADDR_LO & 0xFFFF)) {
+		dev_err(hdev->dev, "WREG32 packet with illegal address 0x%x\n",
+			reg_offset);
+		return -EPERM;
+	}
+
+	/*
+	 * With MMU, DMA channels are not secured, so it doesn't matter where
+	 * the WR COMP will be written to because it will go out with
+	 * non-secured property
+	 */
+	if (goya->hw_cap_initialized & HW_CAP_MMU)
+		return 0;
+
+	sob_start_addr = lower_32_bits(CFG_BASE + mmSYNC_MNGR_SOB_OBJ_0);
+	sob_end_addr = lower_32_bits(CFG_BASE + mmSYNC_MNGR_SOB_OBJ_1023);
+
+	if ((wreg_pkt->value < sob_start_addr) ||
+			(wreg_pkt->value > sob_end_addr)) {
+
+		dev_err(hdev->dev, "WREG32 packet with illegal value 0x%x\n",
+			wreg_pkt->value);
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+static int goya_validate_cb(struct hl_device *hdev,
+			struct hl_cs_parser *parser, bool is_mmu)
+{
+	u32 cb_parsed_length = 0;
+	int rc = 0;
+
+	parser->patched_cb_size = 0;
+
+	/* cb_user_size is more than 0 so loop will always be executed */
+	while (cb_parsed_length < parser->user_cb_size) {
+		enum packet_id pkt_id;
+		u16 pkt_size;
+		void *user_pkt;
+
+		user_pkt = (void *) (parser->user_cb->kernel_address +
+							cb_parsed_length);
+
+		pkt_id = (enum packet_id) (((*(u64 *) user_pkt) &
+				PACKET_HEADER_PACKET_ID_MASK) >>
+					PACKET_HEADER_PACKET_ID_SHIFT);
+
+		pkt_size = goya_packet_sizes[pkt_id];
+		cb_parsed_length += pkt_size;
+		if (cb_parsed_length > parser->user_cb_size) {
+			dev_err(hdev->dev,
+				"packet 0x%x is out of CB boundary\n", pkt_id);
+			rc = -EINVAL;
+			break;
+		}
+
+		switch (pkt_id) {
+		case PACKET_WREG_32:
+			/*
+			 * Although it is validated after copy in patch_cb(),
+			 * need to validate here as well because patch_cb() is
+			 * not called in MMU path while this function is called
+			 */
+			rc = goya_validate_wreg32(hdev, parser, user_pkt);
+			break;
+
+		case PACKET_WREG_BULK:
+			dev_err(hdev->dev,
+				"User not allowed to use WREG_BULK\n");
+			rc = -EPERM;
+			break;
+
+		case PACKET_MSG_PROT:
+			dev_err(hdev->dev,
+				"User not allowed to use MSG_PROT\n");
+			rc = -EPERM;
+			break;
+
+		case PACKET_CP_DMA:
+			dev_err(hdev->dev, "User not allowed to use CP_DMA\n");
+			rc = -EPERM;
+			break;
+
+		case PACKET_STOP:
+			dev_err(hdev->dev, "User not allowed to use STOP\n");
+			rc = -EPERM;
+			break;
+
+		case PACKET_LIN_DMA:
+			if (is_mmu)
+				rc = goya_validate_dma_pkt_mmu(hdev, parser,
+						user_pkt);
+			else
+				rc = goya_validate_dma_pkt_no_mmu(hdev, parser,
+						user_pkt);
+			break;
+
+		case PACKET_MSG_LONG:
+		case PACKET_MSG_SHORT:
+		case PACKET_FENCE:
+		case PACKET_NOP:
+			parser->patched_cb_size += pkt_size;
+			break;
+
+		default:
+			dev_err(hdev->dev, "Invalid packet header 0x%x\n",
+				pkt_id);
+			rc = -EINVAL;
+			break;
+		}
+
+		if (rc)
+			break;
+	}
+
+	/*
+	 * The new CB should have space at the end for two MSG_PROT packets:
+	 * 1. A packet that will act as a completion packet
+	 * 2. A packet that will generate MSI-X interrupt
+	 */
+	parser->patched_cb_size += sizeof(struct packet_msg_prot) * 2;
+
+	return rc;
+}
+
+static int goya_patch_dma_packet(struct hl_device *hdev,
+				struct hl_cs_parser *parser,
+				struct packet_lin_dma *user_dma_pkt,
+				struct packet_lin_dma *new_dma_pkt,
+				u32 *new_dma_pkt_size)
+{
+	struct hl_userptr *userptr;
+	struct scatterlist *sg, *sg_next_iter;
+	u32 count, len, dma_desc_cnt, len_next;
+	dma_addr_t dma_addr, dma_addr_next;
+	enum goya_dma_direction user_dir;
+	u64 device_memory_addr, addr;
+	enum dma_data_direction dir;
+	struct sg_table *sgt;
+	bool skip_host_mem_pin = false;
+	bool user_memset;
+	u32 user_rdcomp_mask, user_wrcomp_mask;
+
+	user_dir = (user_dma_pkt->ctl & GOYA_PKT_LIN_DMA_CTL_DMA_DIR_MASK) >>
+			GOYA_PKT_LIN_DMA_CTL_DMA_DIR_SHIFT;
+
+	user_memset = (user_dma_pkt->ctl & GOYA_PKT_LIN_DMA_CTL_MEMSET_MASK) >>
+			GOYA_PKT_LIN_DMA_CTL_MEMSET_SHIFT;
+
+	if ((user_dir == DMA_DRAM_TO_SRAM) || (user_dir == DMA_SRAM_TO_DRAM) ||
+			(user_dma_pkt->tsize == 0)) {
+		memcpy(new_dma_pkt, user_dma_pkt, sizeof(*new_dma_pkt));
+		*new_dma_pkt_size = sizeof(*new_dma_pkt);
+		return 0;
+	}
+
+	if ((user_dir == DMA_HOST_TO_DRAM) || (user_dir == DMA_HOST_TO_SRAM)) {
+		addr = user_dma_pkt->src_addr;
+		device_memory_addr = user_dma_pkt->dst_addr;
+		dir = DMA_TO_DEVICE;
+		if (user_memset)
+			skip_host_mem_pin = true;
+	} else {
+		addr = user_dma_pkt->dst_addr;
+		device_memory_addr = user_dma_pkt->src_addr;
+		dir = DMA_FROM_DEVICE;
+	}
+
+	if ((!skip_host_mem_pin) &&
+		(hl_userptr_is_pinned(hdev, addr, user_dma_pkt->tsize,
+			parser->job_userptr_list, &userptr) == false)) {
+		dev_err(hdev->dev, "Userptr 0x%llx + 0x%x NOT mapped\n",
+				addr, user_dma_pkt->tsize);
+		return -EFAULT;
+	}
+
+	if ((user_memset) && (dir == DMA_TO_DEVICE)) {
+		memcpy(new_dma_pkt, user_dma_pkt, sizeof(*user_dma_pkt));
+		*new_dma_pkt_size = sizeof(*user_dma_pkt);
+		return 0;
+	}
+
+	user_rdcomp_mask =
+			(user_dma_pkt->ctl & GOYA_PKT_LIN_DMA_CTL_RDCOMP_MASK);
+
+	user_wrcomp_mask =
+			(user_dma_pkt->ctl & GOYA_PKT_LIN_DMA_CTL_WRCOMP_MASK);
+
+	sgt = userptr->sgt;
+	dma_desc_cnt = 0;
+
+	for_each_sg(sgt->sgl, sg, sgt->nents, count) {
+		len = sg_dma_len(sg);
+		dma_addr = sg_dma_address(sg);
+
+		if (len == 0)
+			break;
+
+		while ((count + 1) < sgt->nents) {
+			sg_next_iter = sg_next(sg);
+			len_next = sg_dma_len(sg_next_iter);
+			dma_addr_next = sg_dma_address(sg_next_iter);
+
+			if (len_next == 0)
+				break;
+
+			if ((dma_addr + len == dma_addr_next) &&
+				(len + len_next <= DMA_MAX_TRANSFER_SIZE)) {
+				len += len_next;
+				count++;
+				sg = sg_next_iter;
+			} else {
+				break;
+			}
+		}
+
+		new_dma_pkt->ctl = user_dma_pkt->ctl;
+		if (likely(dma_desc_cnt))
+			new_dma_pkt->ctl &= ~GOYA_PKT_CTL_EB_MASK;
+		new_dma_pkt->ctl &= ~(GOYA_PKT_LIN_DMA_CTL_RDCOMP_MASK |
+					GOYA_PKT_LIN_DMA_CTL_WRCOMP_MASK);
+		new_dma_pkt->tsize = len;
+
+		dma_addr += hdev->asic_prop.host_phys_base_address;
+
+		if (dir == DMA_TO_DEVICE) {
+			new_dma_pkt->src_addr = dma_addr;
+			new_dma_pkt->dst_addr = device_memory_addr;
+		} else {
+			new_dma_pkt->src_addr = device_memory_addr;
+			new_dma_pkt->dst_addr = dma_addr;
+		}
+
+		if (!user_memset)
+			device_memory_addr += len;
+		dma_desc_cnt++;
+		new_dma_pkt++;
+	}
+
+	if (!dma_desc_cnt) {
+		dev_err(hdev->dev,
+			"Error of 0 SG entries when patching DMA packet\n");
+		return -EFAULT;
+	}
+
+	/* Fix the last dma packet - rdcomp/wrcomp must be as user set them */
+	new_dma_pkt--;
+	new_dma_pkt->ctl |= (user_rdcomp_mask | user_wrcomp_mask);
+
+	*new_dma_pkt_size = dma_desc_cnt * sizeof(struct packet_lin_dma);
+
+	return 0;
+}
+
+static int goya_patch_cb(struct hl_device *hdev,
+				struct hl_cs_parser *parser)
+{
+	u32 cb_parsed_length = 0;
+	u32 cb_patched_cur_length = 0;
+	int rc = 0;
+
+	/* cb_user_size is more than 0 so loop will always be executed */
+	while (cb_parsed_length < parser->user_cb_size) {
+		enum packet_id pkt_id;
+		u16 pkt_size;
+		u32 new_pkt_size = 0;
+		void *user_pkt, *kernel_pkt;
+
+		user_pkt = (void *) (parser->user_cb->kernel_address +
+							cb_parsed_length);
+		kernel_pkt = (void *) (parser->patched_cb->kernel_address +
+							cb_patched_cur_length);
+
+		pkt_id = (enum packet_id) (((*(u64 *) user_pkt) &
+				PACKET_HEADER_PACKET_ID_MASK) >>
+					PACKET_HEADER_PACKET_ID_SHIFT);
+
+		pkt_size = goya_packet_sizes[pkt_id];
+		cb_parsed_length += pkt_size;
+		if (cb_parsed_length > parser->user_cb_size) {
+			dev_err(hdev->dev,
+				"packet 0x%x is out of CB boundary\n", pkt_id);
+			rc = -EINVAL;
+			break;
+		}
+
+		switch (pkt_id) {
+		case PACKET_LIN_DMA:
+			rc = goya_patch_dma_packet(hdev, parser, user_pkt,
+						kernel_pkt, &new_pkt_size);
+			cb_patched_cur_length += new_pkt_size;
+			break;
+
+		case PACKET_WREG_32:
+			memcpy(kernel_pkt, user_pkt, pkt_size);
+			cb_patched_cur_length += pkt_size;
+			rc = goya_validate_wreg32(hdev, parser, kernel_pkt);
+			break;
+
+		case PACKET_WREG_BULK:
+			dev_err(hdev->dev,
+				"User not allowed to use WREG_BULK\n");
+			rc = -EPERM;
+			break;
+
+		case PACKET_MSG_PROT:
+			dev_err(hdev->dev,
+				"User not allowed to use MSG_PROT\n");
+			rc = -EPERM;
+			break;
+
+		case PACKET_CP_DMA:
+			dev_err(hdev->dev, "User not allowed to use CP_DMA\n");
+			rc = -EPERM;
+			break;
+
+		case PACKET_STOP:
+			dev_err(hdev->dev, "User not allowed to use STOP\n");
+			rc = -EPERM;
+			break;
+
+		case PACKET_MSG_LONG:
+		case PACKET_MSG_SHORT:
+		case PACKET_FENCE:
+		case PACKET_NOP:
+			memcpy(kernel_pkt, user_pkt, pkt_size);
+			cb_patched_cur_length += pkt_size;
+			break;
+
+		default:
+			dev_err(hdev->dev, "Invalid packet header 0x%x\n",
+				pkt_id);
+			rc = -EINVAL;
+			break;
+		}
+
+		if (rc)
+			break;
+	}
+
+	return rc;
+}
+
+static int goya_parse_cb_mmu(struct hl_device *hdev,
+		struct hl_cs_parser *parser)
+{
+	u64 patched_cb_handle;
+	u32 patched_cb_size;
+	struct hl_cb *user_cb;
+	int rc;
+
+	/*
+	 * The new CB should have space at the end for two MSG_PROT pkt:
+	 * 1. A packet that will act as a completion packet
+	 * 2. A packet that will generate MSI-X interrupt
+	 */
+	parser->patched_cb_size = parser->user_cb_size +
+			sizeof(struct packet_msg_prot) * 2;
+
+	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr,
+				parser->patched_cb_size,
+				&patched_cb_handle, HL_KERNEL_ASID_ID);
+
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to allocate patched CB for DMA CS %d\n",
+			rc);
+		return rc;
+	}
+
+	patched_cb_handle >>= PAGE_SHIFT;
+	parser->patched_cb = hl_cb_get(hdev, &hdev->kernel_cb_mgr,
+				(u32) patched_cb_handle);
+	/* hl_cb_get should never fail here so use kernel WARN */
+	WARN(!parser->patched_cb, "DMA CB handle invalid 0x%x\n",
+			(u32) patched_cb_handle);
+	if (!parser->patched_cb) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	/*
+	 * The check that parser->user_cb_size <= parser->user_cb->size was done
+	 * in validate_queue_index().
+	 */
+	memcpy((void *) parser->patched_cb->kernel_address,
+		(void *) parser->user_cb->kernel_address,
+		parser->user_cb_size);
+
+	patched_cb_size = parser->patched_cb_size;
+
+	/* validate patched CB instead of user CB */
+	user_cb = parser->user_cb;
+	parser->user_cb = parser->patched_cb;
+	rc = goya_validate_cb(hdev, parser, true);
+	parser->user_cb = user_cb;
+
+	if (rc) {
+		hl_cb_put(parser->patched_cb);
+		goto out;
+	}
+
+	if (patched_cb_size != parser->patched_cb_size) {
+		dev_err(hdev->dev, "user CB size mismatch\n");
+		hl_cb_put(parser->patched_cb);
+		rc = -EINVAL;
+		goto out;
+	}
+
+out:
+	/*
+	 * Always call cb destroy here because we still have 1 reference
+	 * to it by calling cb_get earlier. After the job will be completed,
+	 * cb_put will release it, but here we want to remove it from the
+	 * idr
+	 */
+	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr,
+					patched_cb_handle << PAGE_SHIFT);
+
+	return rc;
+}
+
+int goya_parse_cb_no_mmu(struct hl_device *hdev, struct hl_cs_parser *parser)
+{
+	u64 patched_cb_handle;
+	int rc;
+
+	rc = goya_validate_cb(hdev, parser, false);
+
+	if (rc)
+		goto free_userptr;
+
+	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr,
+				parser->patched_cb_size,
+				&patched_cb_handle, HL_KERNEL_ASID_ID);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to allocate patched CB for DMA CS %d\n", rc);
+		goto free_userptr;
+	}
+
+	patched_cb_handle >>= PAGE_SHIFT;
+	parser->patched_cb = hl_cb_get(hdev, &hdev->kernel_cb_mgr,
+				(u32) patched_cb_handle);
+	/* hl_cb_get should never fail here so use kernel WARN */
+	WARN(!parser->patched_cb, "DMA CB handle invalid 0x%x\n",
+			(u32) patched_cb_handle);
+	if (!parser->patched_cb) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	rc = goya_patch_cb(hdev, parser);
+
+	if (rc)
+		hl_cb_put(parser->patched_cb);
+
+out:
+	/*
+	 * Always call cb destroy here because we still have 1 reference
+	 * to it by calling cb_get earlier. After the job will be completed,
+	 * cb_put will release it, but here we want to remove it from the
+	 * idr
+	 */
+	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr,
+				patched_cb_handle << PAGE_SHIFT);
+
+free_userptr:
+	if (rc)
+		hl_userptr_delete_list(hdev, parser->job_userptr_list);
+	return rc;
+}
+
+int goya_parse_cb_no_ext_quque(struct hl_device *hdev,
+		struct hl_cs_parser *parser)
+{
+	struct asic_fixed_properties *asic_prop = &hdev->asic_prop;
+	struct goya_device *goya = hdev->asic_specific;
+
+	if (!(goya->hw_cap_initialized & HW_CAP_MMU)) {
+		/* For internal queue jobs, just check if cb address is valid */
+		if (hl_mem_area_inside_range(
+				(u64) parser->user_cb,
+				parser->user_cb_size,
+				asic_prop->sram_user_base_address,
+				asic_prop->sram_end_address))
+			return 0;
+
+		if (hl_mem_area_inside_range(
+				(u64) parser->user_cb,
+				parser->user_cb_size,
+				asic_prop->dram_user_base_address,
+				asic_prop->dram_end_address))
+			return 0;
+
+		dev_err(hdev->dev,
+			"Internal CB address 0x%llx + 0x%x is not in SRAM nor in DRAM\n",
+			(u64) parser->user_cb, parser->user_cb_size);
+
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int goya_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser)
+{
+	struct goya_device *goya = hdev->asic_specific;
+
+	if (!parser->ext_queue)
+		return goya_parse_cb_no_ext_quque(hdev, parser);
+
+	if ((goya->hw_cap_initialized & HW_CAP_MMU) && parser->use_virt_addr)
+		return goya_parse_cb_mmu(hdev, parser);
+	else
+		return goya_parse_cb_no_mmu(hdev, parser);
+}
+
+void goya_add_end_of_cb_packets(u64 kernel_address, u32 len, u64 cq_addr,
+				u32 cq_val, u32 msix_vec)
+{
+	struct packet_msg_prot *cq_pkt;
+
+	cq_pkt = (struct packet_msg_prot *) (kernel_address + len -
+					(sizeof(struct packet_msg_prot) * 2));
+
+	cq_pkt->ctl = (PACKET_MSG_PROT << GOYA_PKT_CTL_OPCODE_SHIFT) |
+			(1 << GOYA_PKT_CTL_EB_SHIFT) |
+			(1 << GOYA_PKT_CTL_MB_SHIFT);
+	cq_pkt->value = cq_val;
+	cq_pkt->addr = cq_addr;
+
+	cq_pkt++;
+
+	cq_pkt->ctl = (PACKET_MSG_PROT << GOYA_PKT_CTL_OPCODE_SHIFT) |
+			(1 << GOYA_PKT_CTL_MB_SHIFT);
+	cq_pkt->value = msix_vec & 0x7FF;
+	cq_pkt->addr = CFG_BASE + mmPCIE_DBI_MSIX_DOORBELL_OFF;
+}
+
 static void goya_update_eq_ci(struct hl_device *hdev, u32 val)
 {
 	WREG32(mmPSOC_GLOBAL_CONF_SCRATCHPAD_6, val);
 }
 
+int goya_context_switch(struct hl_device *hdev, u32 asid)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct packet_lin_dma *clear_sram_pkt;
+	struct hl_cs_parser parser;
+	struct hl_cs_job *job;
+	u32 cb_size;
+	struct hl_cb *cb;
+	int rc;
+
+	cb = hl_cb_kernel_create(hdev, PAGE_SIZE);
+	if (!cb)
+		return -EFAULT;
+
+	clear_sram_pkt = (struct packet_lin_dma *) cb->kernel_address;
+	memset(clear_sram_pkt, 0, sizeof(*clear_sram_pkt));
+	cb_size = sizeof(*clear_sram_pkt);
+
+	clear_sram_pkt->ctl = ((PACKET_LIN_DMA << GOYA_PKT_CTL_OPCODE_SHIFT) |
+		(DMA_HOST_TO_SRAM << GOYA_PKT_LIN_DMA_CTL_DMA_DIR_SHIFT) |
+		(1 << GOYA_PKT_LIN_DMA_CTL_MEMSET_SHIFT) |
+		(1 << GOYA_PKT_LIN_DMA_CTL_WO_SHIFT) |
+		(1 << GOYA_PKT_CTL_RB_SHIFT) |
+		(1 << GOYA_PKT_CTL_MB_SHIFT));
+
+	clear_sram_pkt->src_addr = 0x7777777777777777ull;
+	clear_sram_pkt->dst_addr = prop->sram_base_address;
+	if (hdev->pldm)
+		clear_sram_pkt->tsize = 0x10000;
+	else
+		clear_sram_pkt->tsize = prop->sram_size;
+
+	job = hl_cs_allocate_job(hdev, true);
+	if (!job) {
+		dev_err(hdev->dev, "Failed to allocate a new job\n");
+		rc = -ENOMEM;
+		goto release_cb;
+	}
+
+	job->id = 0;
+	job->user_cb = cb;
+	job->user_cb->cs_cnt++;
+	job->user_cb_size = cb_size;
+	job->hw_queue_id = GOYA_QUEUE_ID_DMA_0;
+
+	parser.ctx_id = HL_KERNEL_ASID_ID;
+	parser.cs_sequence = 0;
+	parser.job_id = job->id;
+	parser.hw_queue_id = job->hw_queue_id;
+	parser.job_userptr_list = &job->userptr_list;
+	parser.user_cb = job->user_cb;
+	parser.user_cb_size = job->user_cb_size;
+	parser.ext_queue = job->ext_queue;
+	parser.use_virt_addr = hdev->mmu_enable;
+
+	rc = hdev->asic_funcs->cs_parser(hdev, &parser);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to parse kernel CB during context switch\n");
+		goto free_job;
+	}
+
+	job->patched_cb = parser.patched_cb;
+	job->job_cb_size = parser.patched_cb_size;
+	job->patched_cb->cs_cnt++;
+
+	rc = goya_send_job_on_qman0(hdev, job);
+
+	job->patched_cb->cs_cnt--;
+	hl_cb_put(job->patched_cb);
+
+free_job:
+	hl_userptr_delete_list(hdev, &job->userptr_list);
+	kfree(job);
+	cb->cs_cnt--;
+
+release_cb:
+	hl_cb_put(cb);
+	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, cb->id << PAGE_SHIFT);
+
+	return rc;
+}
+
+void goya_restore_phase_topology(struct hl_device *hdev)
+{
+	int i, num_of_sob_in_longs, num_of_mon_in_longs;
+
+	num_of_sob_in_longs =
+		((mmSYNC_MNGR_SOB_OBJ_1023 - mmSYNC_MNGR_SOB_OBJ_0) + 4);
+
+	num_of_mon_in_longs =
+		((mmSYNC_MNGR_MON_STATUS_255 - mmSYNC_MNGR_MON_STATUS_0) + 4);
+
+	for (i = 0 ; i < num_of_sob_in_longs ; i += 4)
+		WREG32(mmSYNC_MNGR_SOB_OBJ_0 + i, 0);
+
+	for (i = 0 ; i < num_of_mon_in_longs ; i += 4)
+		WREG32(mmSYNC_MNGR_MON_STATUS_0 + i, 0);
+
+	/* Flush all WREG to prevent race */
+	i = RREG32(mmSYNC_MNGR_SOB_OBJ_0);
+}
+
 static void goya_get_axi_name(struct hl_device *hdev, u32 agent_id,
 		u16 event_type, char *axi_name, int len)
 {
@@ -3600,6 +4661,59 @@ static void goya_disable_clock_gating(struct hl_device *hdev)
 
 }
 
+static bool goya_is_device_idle(struct hl_device *hdev)
+{
+	u64 offset, dma_qm_reg, tpc_qm_reg, tpc_cmdq_reg, tpc_cfg_reg;
+	int i;
+
+	offset = mmDMA_QM_1_GLBL_STS0 - mmDMA_QM_0_GLBL_STS0;
+
+	for (i = 0 ; i < DMA_MAX_NUM ; i++) {
+		dma_qm_reg = mmDMA_QM_0_GLBL_STS0 + i * offset;
+
+		if ((RREG32(dma_qm_reg) & DMA_QM_IDLE_MASK) !=
+				DMA_QM_IDLE_MASK)
+			return false;
+	}
+
+	offset = mmTPC1_QM_GLBL_STS0 - mmTPC0_QM_GLBL_STS0;
+
+	for (i = 0 ; i < TPC_MAX_NUM ; i++) {
+		tpc_qm_reg = mmTPC0_QM_GLBL_STS0 + i * offset;
+		tpc_cmdq_reg = mmTPC0_CMDQ_GLBL_STS0 + i * offset;
+		tpc_cfg_reg = mmTPC0_CFG_STATUS + i * offset;
+
+		if ((RREG32(tpc_qm_reg) & TPC_QM_IDLE_MASK) !=
+				TPC_QM_IDLE_MASK)
+			return false;
+
+		if ((RREG32(tpc_cmdq_reg) & TPC_CMDQ_IDLE_MASK) !=
+				TPC_CMDQ_IDLE_MASK)
+			return false;
+
+		if ((RREG32(tpc_cfg_reg) & TPC_CFG_IDLE_MASK) !=
+				TPC_CFG_IDLE_MASK)
+			return false;
+	}
+
+	if ((RREG32(mmMME_QM_GLBL_STS0) & MME_QM_IDLE_MASK) !=
+			MME_QM_IDLE_MASK)
+		return false;
+
+	if ((RREG32(mmMME_CMDQ_GLBL_STS0) & MME_CMDQ_IDLE_MASK) !=
+			MME_CMDQ_IDLE_MASK)
+		return false;
+
+	if ((RREG32(mmMME_ARCH_STATUS) & MME_ARCH_IDLE_MASK) !=
+			MME_ARCH_IDLE_MASK)
+		return false;
+
+	if (RREG32(mmMME_SHADOW_0_STATUS) & MME_SHADOW_IDLE_MASK)
+		return false;
+
+	return true;
+}
+
 static void goya_hw_queues_lock(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
@@ -3687,7 +4801,14 @@ static const struct hl_asic_funcs goya_funcs = {
 	.dma_pool_free = goya_dma_pool_free,
 	.cpu_accessible_dma_pool_alloc = goya_cpu_accessible_dma_pool_alloc,
 	.cpu_accessible_dma_pool_free = goya_cpu_accessible_dma_pool_free,
+	.hl_dma_unmap_sg = goya_dma_unmap_sg,
+	.cs_parser = goya_cs_parser,
+	.asic_dma_map_sg = goya_dma_map_sg,
+	.get_dma_desc_list_size = goya_get_dma_desc_list_size,
+	.add_end_of_cb_packets = goya_add_end_of_cb_packets,
 	.update_eq_ci = goya_update_eq_ci,
+	.context_switch = goya_context_switch,
+	.restore_phase_topology = goya_restore_phase_topology,
 	.add_device_attr = goya_add_device_attr,
 	.remove_device_attr = goya_remove_device_attr,
 	.handle_eqe = goya_handle_eqe,
@@ -3696,6 +4817,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.send_heartbeat = goya_send_heartbeat,
 	.enable_clock_gating = goya_init_clock_gating,
 	.disable_clock_gating = goya_disable_clock_gating,
+	.is_device_idle = goya_is_device_idle,
 	.soft_reset_late_init = goya_soft_reset_late_init,
 	.hw_queues_lock = goya_hw_queues_lock,
 	.hw_queues_unlock = goya_hw_queues_unlock,
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 402309180b40..af674e3caa87 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -36,6 +36,11 @@
 
 #define HL_MAX_QUEUES			128
 
+#define HL_MAX_JOBS_PER_CS		64
+
+/* MUST BE POWER OF 2 and larger than 1 */
+#define HL_MAX_PENDING_CS		64
+
 struct hl_device;
 struct hl_fpriv;
 
@@ -66,6 +71,16 @@ struct hw_queue_properties {
 	u8			kmd_only;
 };
 
+/**
+ * enum vm_type_t - virtual memory mapping request information.
+ * @VM_TYPE_USERPTR: mapping of user memory to device virtual address.
+ * @VM_TYPE_PHYS_LIST: mapping of DRAM memory to device virtual address.
+ */
+enum vm_type_t {
+	VM_TYPE_USERPTR,
+	VM_TYPE_PHYS_LIST
+};
+
 /**
  * struct asic_fixed_properties - ASIC specific immutable properties.
  * @hw_queues_props: H/W queues properties.
@@ -140,6 +155,19 @@ struct asic_fixed_properties {
 	u8			tpc_enabled_mask;
 };
 
+/**
+ * struct hl_dma_fence - wrapper for fence object used by command submissions.
+ * @base_fence: kernel fence object.
+ * @lock: spinlock to protect fence.
+ * @hdev: habanalabs device structure.
+ * @cs_seq: command submission sequence number.
+ */
+struct hl_dma_fence {
+	struct dma_fence	base_fence;
+	spinlock_t		lock;
+	struct hl_device	*hdev;
+	u64			cs_seq;
+};
 
 /*
  * Command Buffers
@@ -167,6 +195,7 @@ struct hl_cb_mgr {
  * @vm_end: Holds the CB's user end virtual address (when mmaped).
  * @size: holds the CB's size.
  * @id: the CB's ID.
+ * @cs_cnt: holds number of CS that this CB participates in.
  * @ctx_id: holds the ID of the owner's context.
  * @mmap: true if the CB is currently mmaped to user.
  * @is_pool: true if CB was acquired from the pool, false otherwise.
@@ -182,6 +211,7 @@ struct hl_cb {
 	u64			vm_end;
 	u32			size;
 	u32			id;
+	u32			cs_cnt;
 	u32			ctx_id;
 	u8			mmap;
 	u8			is_pool;
@@ -306,6 +336,8 @@ enum hl_asic_type {
 	ASIC_INVALID
 };
 
+struct hl_cs_parser;
+
 /**
  * enum hl_pm_mng_profile - power management profile.
  * @PM_AUTO: internal clock is set by KMD.
@@ -365,7 +397,14 @@ enum hl_pll_frequency {
  * @dma_pool_free: free small DMA allocation from pool.
  * @cpu_accessible_dma_pool_alloc: allocate CPU PQ packet from DMA pool.
  * @cpu_accessible_dma_pool_free: free CPU PQ packet from DMA pool.
+ * @hl_dma_unmap_sg: DMA unmap scatter-gather list.
+ * @cs_parser: parse Command Submission.
+ * @asic_dma_map_sg: DMA map scatter-gather list.
+ * @get_dma_desc_list_size: get number of LIN_DMA packets required for CB.
+ * @add_end_of_cb_packets: Add packets to the end of CB, if device requires it.
  * @update_eq_ci: update event queue CI.
+ * @context_switch: called upon ASID context switch.
+ * @restore_phase_topology: clear all SOBs amd MONs.
  * @add_device_attr: add ASIC specific device attributes.
  * @remove_device_attr: remove ASIC specific device attributes.
  * @handle_eqe: handle event queue entry (IRQ) from ArmCP.
@@ -374,6 +413,7 @@ enum hl_pll_frequency {
  * @send_heartbeat: send is-alive packet to ArmCP and verify response.
  * @enable_clock_gating: enable clock gating for reducing power consumption.
  * @disable_clock_gating: disable clock for accessing registers on HBW.
+ * @is_device_idle: return true if device is idle, false otherwise.
  * @soft_reset_late_init: perform certain actions needed after soft reset.
  * @hw_queues_lock: acquire H/W queues lock.
  * @hw_queues_unlock: release H/W queues lock.
@@ -412,7 +452,20 @@ struct hl_asic_funcs {
 				size_t size, dma_addr_t *dma_handle);
 	void (*cpu_accessible_dma_pool_free)(struct hl_device *hdev,
 				size_t size, void *vaddr);
+	void (*hl_dma_unmap_sg)(struct hl_device *hdev,
+				struct scatterlist *sg, int nents,
+				enum dma_data_direction dir);
+	int (*cs_parser)(struct hl_device *hdev, struct hl_cs_parser *parser);
+	int (*asic_dma_map_sg)(struct hl_device *hdev,
+				struct scatterlist *sg, int nents,
+				enum dma_data_direction dir);
+	u32 (*get_dma_desc_list_size)(struct hl_device *hdev,
+					struct sg_table *sgt);
+	void (*add_end_of_cb_packets)(u64 kernel_address, u32 len, u64 cq_addr,
+					u32 cq_val, u32 msix_num);
 	void (*update_eq_ci)(struct hl_device *hdev, u32 val);
+	int (*context_switch)(struct hl_device *hdev, u32 asid);
+	void (*restore_phase_topology)(struct hl_device *hdev);
 	int (*add_device_attr)(struct hl_device *hdev);
 	void (*remove_device_attr)(struct hl_device *hdev);
 	void (*handle_eqe)(struct hl_device *hdev,
@@ -423,6 +476,7 @@ struct hl_asic_funcs {
 	int (*send_heartbeat)(struct hl_device *hdev);
 	void (*enable_clock_gating)(struct hl_device *hdev);
 	void (*disable_clock_gating)(struct hl_device *hdev);
+	bool (*is_device_idle)(struct hl_device *hdev);
 	int (*soft_reset_late_init)(struct hl_device *hdev);
 	void (*hw_queues_lock)(struct hl_device *hdev);
 	void (*hw_queues_unlock)(struct hl_device *hdev);
@@ -445,12 +499,28 @@ struct hl_asic_funcs {
  * @hdev: pointer to the device structure.
  * @refcount: reference counter for the context. Context is released only when
  *		this hits 0l. It is incremented on CS and CS_WAIT.
+ * @cs_pending: array of DMA fence objects representing pending CS.
+ * @cs_sequence: sequence number for CS. Value is assigned to a CS and passed
+ *			to user so user could inquire about CS. It is used as
+ *			index to cs_pending array.
+ * @cs_lock: spinlock to protect cs_sequence.
+ * @thread_restore_token: token to prevent multiple threads of the same context
+ *				from running the restore phase. Only one thread
+ *				should run it.
+ * @thread_restore_wait_token: token to prevent the threads that didn't run
+ *				the restore phase from moving to their execution
+ *				phase before the restore phase has finished.
  * @asid: context's unique address space ID in the device's MMU.
  */
 struct hl_ctx {
 	struct hl_fpriv		*hpriv;
 	struct hl_device	*hdev;
 	struct kref		refcount;
+	struct dma_fence	*cs_pending[HL_MAX_PENDING_CS];
+	u64			cs_sequence;
+	spinlock_t		cs_lock;
+	atomic_t		thread_restore_token;
+	u32			thread_restore_wait_token;
 	u32			asid;
 };
 
@@ -465,14 +535,129 @@ struct hl_ctx_mgr {
 };
 
 
+
+/*
+ * COMMAND SUBMISSIONS
+ */
+
+/**
+ * struct hl_userptr - memory mapping chunk information
+ * @vm_type: type of the VM.
+ * @job_node: linked-list node for hanging the object on the Job's list.
+ * @vec: pointer to the frame vector.
+ * @sgt: pointer to the scatter-gather table that holds the pages.
+ * @dir: for DMA unmapping, the direction must be supplied, so save it.
+ * @debugfs_list: node in debugfs list of command submissions.
+ * @addr: user-space virtual pointer to the start of the memory area.
+ * @size: size of the memory area to pin & map.
+ * @dma_mapped: true if the SG was mapped to DMA addresses, false otherwise.
+ */
+struct hl_userptr {
+	enum vm_type_t		vm_type; /* must be first */
+	struct list_head	job_node;
+	struct frame_vector	*vec;
+	struct sg_table		*sgt;
+	enum dma_data_direction dir;
+	struct list_head	debugfs_list;
+	u64			addr;
+	u32			size;
+	u8			dma_mapped;
+};
+
+/**
+ * struct hl_cs - command submission.
+ * @jobs_in_queue_cnt: per each queue, maintain counter of submitted jobs.
+ * @ctx: the context this CS belongs to.
+ * @job_list: list of the CS's jobs in the various queues.
+ * @job_lock: spinlock for the CS's jobs list. Needed for free_job.
+ * @refcount: reference counter for usage of the CS.
+ * @fence: pointer to the fence object of this CS.
+ * @work_tdr: delayed work node for TDR.
+ * @mirror_node : node in device mirror list of command submissions.
+ * @sequence: the sequence number of this CS.
+ * @submitted: true if CS was submitted to H/W.
+ * @completed: true if CS was completed by device.
+ * @timedout : true if CS was timedout.
+ * @tdr_active: true if TDR was activated for this CS (to prevent
+ *		double TDR activation).
+ * @aborted: true if CS was aborted due to some device error.
+ */
+struct hl_cs {
+	u8			jobs_in_queue_cnt[HL_MAX_QUEUES];
+	struct hl_ctx		*ctx;
+	struct list_head	job_list;
+	spinlock_t		job_lock;
+	struct kref		refcount;
+	struct dma_fence	*fence;
+	struct delayed_work	work_tdr;
+	struct list_head	mirror_node;
+	u64			sequence;
+	u8			submitted;
+	u8			completed;
+	u8			timedout;
+	u8			tdr_active;
+	u8			aborted;
+};
+
 /**
  * struct hl_cs_job - command submission job.
+ * @cs_node: the node to hang on the CS jobs list.
+ * @cs: the CS this job belongs to.
+ * @user_cb: the CB we got from the user.
+ * @patched_cb: in case of patching, this is internal CB which is submitted on
+ *		the queue instead of the CB we got from the IOCTL.
  * @finish_work: workqueue object to run when job is completed.
+ * @userptr_list: linked-list of userptr mappings that belong to this job and
+ *			wait for completion.
  * @id: the id of this job inside a CS.
+ * @hw_queue_id: the id of the H/W queue this job is submitted to.
+ * @user_cb_size: the actual size of the CB we got from the user.
+ * @job_cb_size: the actual size of the CB that we put on the queue.
+ * @ext_queue: whether the job is for external queue or internal queue.
  */
 struct hl_cs_job {
+	struct list_head	cs_node;
+	struct hl_cs		*cs;
+	struct hl_cb		*user_cb;
+	struct hl_cb		*patched_cb;
 	struct work_struct	finish_work;
+	struct list_head	userptr_list;
 	u32			id;
+	u32			hw_queue_id;
+	u32			user_cb_size;
+	u32			job_cb_size;
+	u8			ext_queue;
+};
+
+/**
+ * struct hl_cs_parser - command submission paerser properties.
+ * @user_cb: the CB we got from the user.
+ * @patched_cb: in case of patching, this is internal CB which is submitted on
+ *		the queue instead of the CB we got from the IOCTL.
+ * @job_userptr_list: linked-list of userptr mappings that belong to the related
+ *			job and wait for completion.
+ * @cs_sequence: the sequence number of the related CS.
+ * @ctx_id: the ID of the context the related CS belongs to.
+ * @hw_queue_id: the id of the H/W queue this job is submitted to.
+ * @user_cb_size: the actual size of the CB we got from the user.
+ * @patched_cb_size: the size of the CB after parsing.
+ * @ext_queue: whether the job is for external queue or internal queue.
+ * @job_id: the id of the related job inside the related CS.
+ * @use_virt_addr: whether to treat the addresses in the CB as virtual during
+ *			parsing.
+ */
+struct hl_cs_parser {
+	struct hl_cb		*user_cb;
+	struct hl_cb		*patched_cb;
+	struct list_head	*job_userptr_list;
+	u64			cs_sequence;
+	u32			ctx_id;
+	u32			hw_queue_id;
+	u32			user_cb_size;
+	u32			patched_cb_size;
+	u8			ext_queue;
+	u8			job_id;
+	u8			use_virt_addr;
 };
 
 
@@ -489,6 +674,7 @@ struct hl_cs_job {
  * @ctx_mgr: context manager to handle multiple context for this FD.
  * @cb_mgr: command buffer manager to handle multiple buffers for this FD.
  * @refcount: number of related contexts.
+ * @restore_phase_mutex: lock for context switch and restore phase.
  */
 struct hl_fpriv {
 	struct hl_device	*hdev;
@@ -498,6 +684,7 @@ struct hl_fpriv {
 	struct hl_ctx_mgr	ctx_mgr;
 	struct hl_cb_mgr	cb_mgr;
 	struct kref		refcount;
+	struct mutex		restore_phase_mutex;
 };
 
 
@@ -567,6 +754,8 @@ struct hl_device_reset_work {
  * @eq_wq: work queue of event queue for executing work in process context.
  * @kernel_ctx: KMD context structure.
  * @kernel_queues: array of hl_hw_queue.
+ * @hw_queues_mirror_list: CS mirror list for TDR.
+ * @hw_queues_mirror_lock: protects hw_queues_mirror_list.
  * @kernel_cb_mgr: command buffer manager for creating/destroying/handling CGs.
  * @event_queue: event queue for IRQ from ArmCP.
  * @dma_pool: DMA pool for small allocations.
@@ -594,6 +783,7 @@ struct hl_device_reset_work {
  * @in_reset: is device in reset flow.
  * @curr_pll_profile: current PLL profile.
  * @fd_open_cnt: number of open user processes.
+ * @timeout_jiffies: device CS timeout value.
  * @max_power: the max power of the device, as configured by the sysadmin. This
  *             value is saved so in case of hard-reset, KMD will restore this
  *             value and update the F/W after the re-initialization
@@ -607,7 +797,10 @@ struct hl_device_reset_work {
  * @hwmon_initialized: is H/W monitor sensors was initialized.
  * @hard_reset_pending: is there a hard reset work pending.
  * @heartbeat: is heartbeat sanity check towards ArmCP enabled.
+ * @reset_on_lockup: true if a reset should be done in case of stuck CS, false
+ *                   otherwise.
  * @init_done: is the initialization of the device done.
+ * @mmu_enable: is MMU enabled.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -624,6 +817,8 @@ struct hl_device {
 	struct workqueue_struct		*eq_wq;
 	struct hl_ctx			*kernel_ctx;
 	struct hl_hw_queue		*kernel_queues;
+	struct list_head		hw_queues_mirror_list;
+	spinlock_t			hw_queues_mirror_lock;
 	struct hl_cb_mgr		kernel_cb_mgr;
 	struct hl_eq			event_queue;
 	struct dma_pool			*dma_pool;
@@ -651,6 +846,7 @@ struct hl_device {
 	atomic_t			in_reset;
 	atomic_t			curr_pll_profile;
 	atomic_t			fd_open_cnt;
+	u64				timeout_jiffies;
 	u64				max_power;
 	u32				major;
 	u32				high_pll;
@@ -662,9 +858,11 @@ struct hl_device {
 	u8				hwmon_initialized;
 	u8				hard_reset_pending;
 	u8				heartbeat;
+	u8				reset_on_lockup;
 	u8				init_done;
 
 	/* Parameters for bring-up */
+	u8				mmu_enable;
 	u8				cpu_enable;
 	u8				reset_pcilink;
 	u8				cpu_queues_enable;
@@ -702,6 +900,58 @@ struct hl_ioctl_desc {
  * Kernel module functions that can be accessed by entire module
  */
 
+/**
+ * hl_mem_area_inside_range() - Checks whether address+size are inside a range.
+ * @address: The start address of the area we want to validate.
+ * @size: The size in bytes of the area we want to validate.
+ * @range_start_address: The start address of the valid range.
+ * @range_end_address: The end address of the valid range.
+ *
+ * Return: true if the area is inside the valid range, false otherwise.
+ */
+static inline bool hl_mem_area_inside_range(u64 address, u32 size,
+				u64 range_start_address, u64 range_end_address)
+{
+	u64 end_address = address + size;
+
+	if ((address >= range_start_address) &&
+			(end_address <= range_end_address) &&
+			(end_address > address))
+		return true;
+
+	return false;
+}
+
+/**
+ * hl_mem_area_crosses_range() - Checks whether address+size crossing a range.
+ * @address: The start address of the area we want to validate.
+ * @size: The size in bytes of the area we want to validate.
+ * @range_start_address: The start address of the valid range.
+ * @range_end_address: The end address of the valid range.
+ *
+ * Return: true if the area overlaps part or all of the valid range,
+ *		false otherwise.
+ */
+static inline bool hl_mem_area_crosses_range(u64 address, u32 size,
+				u64 range_start_address, u64 range_end_address)
+{
+	u64 end_address = address + size;
+
+	if ((address >= range_start_address) &&
+			(address < range_end_address))
+		return true;
+
+	if ((end_address >= range_start_address) &&
+			(end_address < range_end_address))
+		return true;
+
+	if ((address < range_start_address) &&
+			(end_address >= range_end_address))
+		return true;
+
+	return false;
+}
+
 int hl_device_open(struct inode *inode, struct file *filp);
 bool hl_device_disabled_or_in_reset(struct hl_device *hdev);
 int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
@@ -715,8 +965,10 @@ int hl_hw_queues_create(struct hl_device *hdev);
 void hl_hw_queues_destroy(struct hl_device *hdev);
 int hl_hw_queue_send_cb_no_cmpl(struct hl_device *hdev, u32 hw_queue_id,
 				u32 cb_size, u64 cb_ptr);
+int hl_hw_queue_schedule_cs(struct hl_cs *cs);
 u32 hl_hw_queue_add_ptr(u32 ptr, u16 val);
 void hl_hw_queue_inc_ci_kernel(struct hl_device *hdev, u32 hw_queue_id);
+void hl_int_hw_queue_update_ci(struct hl_cs *cs);
 void hl_hw_queue_reset(struct hl_device *hdev, bool hard_reset);
 
 #define hl_queue_inc_ptr(p)		hl_hw_queue_add_ptr(p, 1)
@@ -730,6 +982,8 @@ void hl_cq_reset(struct hl_device *hdev, struct hl_cq *q);
 void hl_eq_reset(struct hl_device *hdev, struct hl_eq *q);
 irqreturn_t hl_irq_handler_cq(int irq, void *arg);
 irqreturn_t hl_irq_handler_eq(int irq, void *arg);
+u32 hl_cq_inc_ptr(u32 ptr);
+
 int hl_asid_init(struct hl_device *hdev);
 void hl_asid_fini(struct hl_device *hdev);
 unsigned long hl_asid_alloc(struct hl_device *hdev);
@@ -738,9 +992,13 @@ void hl_asid_free(struct hl_device *hdev, unsigned long asid);
 int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv);
 void hl_ctx_free(struct hl_device *hdev, struct hl_ctx *ctx);
 int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx);
+void hl_ctx_do_release(struct kref *ref);
+void hl_ctx_get(struct hl_device *hdev,	struct hl_ctx *ctx);
 int hl_ctx_put(struct hl_ctx *ctx);
+struct dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq);
 void hl_ctx_mgr_init(struct hl_ctx_mgr *mgr);
 void hl_ctx_mgr_fini(struct hl_device *hdev, struct hl_ctx_mgr *mgr);
+
 int hl_device_init(struct hl_device *hdev, struct class *hclass);
 void hl_device_fini(struct hl_device *hdev);
 int hl_device_suspend(struct hl_device *hdev);
@@ -772,8 +1030,20 @@ struct hl_cb *hl_cb_kernel_create(struct hl_device *hdev, u32 cb_size);
 int hl_cb_pool_init(struct hl_device *hdev);
 int hl_cb_pool_fini(struct hl_device *hdev);
 
+void hl_cs_rollback_all(struct hl_device *hdev);
+struct hl_cs_job *hl_cs_allocate_job(struct hl_device *hdev, bool ext_queue);
+
 void goya_set_asic_funcs(struct hl_device *hdev);
 
+int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u32 size,
+			struct hl_userptr *userptr);
+int hl_unpin_host_memory(struct hl_device *hdev, struct hl_userptr *userptr);
+void hl_userptr_delete_list(struct hl_device *hdev,
+				struct list_head *userptr_list);
+bool hl_userptr_is_pinned(struct hl_device *hdev, u64 addr, u32 size,
+				struct list_head *userptr_list,
+				struct hl_userptr **userptr);
+
 long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr);
 void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq);
 long hl_get_temperature(struct hl_device *hdev, int sensor_index, u32 attr);
@@ -789,5 +1059,7 @@ void hl_set_max_power(struct hl_device *hdev, u64 value);
 /* IOCTLs */
 long hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
 int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data);
+int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data);
+int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data);
 
 #endif /* HABANALABSP_H_ */
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 0702f6f974eb..dbc0c9c2c99a 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -28,6 +28,17 @@ static struct class *hl_class;
 DEFINE_IDR(hl_devs_idr);
 DEFINE_MUTEX(hl_devs_idr_lock);
 
+static int timeout_locked = 5;
+static int reset_on_lockup = 1;
+
+module_param(timeout_locked, int, 0444);
+MODULE_PARM_DESC(timeout_locked,
+	"Device lockup timeout in seconds (0 = disabled, default 5s)");
+
+module_param(reset_on_lockup, int, 0444);
+MODULE_PARM_DESC(reset_on_lockup,
+	"Do device reset on lockup (0 = no, 1 = yes, default yes)");
+
 #define PCI_VENDOR_ID_HABANALABS	0x1da3
 
 #define PCI_IDS_GOYA			0x0001
@@ -117,6 +128,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	hpriv->hdev = hdev;
 	filp->private_data = hpriv;
 	hpriv->filp = filp;
+	mutex_init(&hpriv->restore_phase_mutex);
 	kref_init(&hpriv->refcount);
 	nonseekable_open(inode, filp);
 
@@ -144,6 +156,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	filp->private_data = NULL;
 	hl_ctx_mgr_fini(hpriv->hdev, &hpriv->ctx_mgr);
 	hl_cb_mgr_fini(hpriv->hdev, &hpriv->cb_mgr);
+	mutex_destroy(&hpriv->restore_phase_mutex);
 	kfree(hpriv);
 
 close_device:
@@ -176,8 +189,10 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 		return -ENOMEM;
 
 	hdev->major = hl_major;
+	hdev->reset_on_lockup = reset_on_lockup;
 
 	/* Parameters for bring-up - set them to defaults */
+	hdev->mmu_enable = 0;
 	hdev->cpu_enable = 1;
 	hdev->reset_pcilink = 0;
 	hdev->cpu_queues_enable = 1;
@@ -197,6 +212,11 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 	if (!hdev->cpu_queues_enable)
 		hdev->heartbeat = 0;
 
+	if (timeout_locked)
+		hdev->timeout_jiffies = msecs_to_jiffies(timeout_locked * 1000);
+	else
+		hdev->timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
+
 	hdev->disabled = true;
 	hdev->pdev = pdev; /* can be NULL in case of simulator device */
 
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index 12b004b92c83..35b3df73b752 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -16,7 +16,9 @@
 	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func}
 
 static const struct hl_ioctl_desc hl_ioctls[] = {
-	HL_IOCTL_DEF(HL_IOCTL_CB, hl_cb_ioctl)
+	HL_IOCTL_DEF(HL_IOCTL_CB, hl_cb_ioctl),
+	HL_IOCTL_DEF(HL_IOCTL_CS, hl_cs_ioctl),
+	HL_IOCTL_DEF(HL_IOCTL_WAIT_CS, hl_cs_wait_ioctl)
 };
 
 #define HL_CORE_IOCTL_COUNT	ARRAY_SIZE(hl_ioctls)
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index 6841e23f1b30..29bd525bb3bd 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -37,6 +37,29 @@ static inline int queue_free_slots(struct hl_hw_queue *q, u32 queue_len)
 		return (abs(delta) - queue_len);
 }
 
+void hl_int_hw_queue_update_ci(struct hl_cs *cs)
+{
+	struct hl_device *hdev = cs->ctx->hdev;
+	struct hl_hw_queue *q;
+	int i;
+
+	hdev->asic_funcs->hw_queues_lock(hdev);
+
+	if (hdev->disabled)
+		goto out;
+
+	q = &hdev->kernel_queues[0];
+	for (i = 0 ; i < HL_MAX_QUEUES ; i++, q++) {
+		if (q->queue_type == QUEUE_TYPE_INT) {
+			q->ci += cs->jobs_in_queue_cnt[i];
+			q->ci &= ((q->int_queue_len << 1) - 1);
+		}
+	}
+
+out:
+	hdev->asic_funcs->hw_queues_unlock(hdev);
+}
+
 /*
  * ext_queue_submit_bd - Submit a buffer descriptor to an external queue
  *
@@ -122,6 +145,37 @@ static int ext_queue_sanity_checks(struct hl_device *hdev,
 	return 0;
 }
 
+/*
+ * int_queue_sanity_checks - perform some sanity checks on internal queue
+ *
+ * @hdev              : pointer to hl_device structure
+ * @q                 :	pointer to hl_hw_queue structure
+ * @num_of_entries    : how many entries to check for space
+ *
+ * H/W queues spinlock should be taken before calling this function
+ *
+ * Perform the following:
+ * - Make sure we have enough space in the h/w queue
+ *
+ */
+static int int_queue_sanity_checks(struct hl_device *hdev,
+					struct hl_hw_queue *q,
+					int num_of_entries)
+{
+	int free_slots_cnt;
+
+	/* Check we have enough space in the queue */
+	free_slots_cnt = queue_free_slots(q, q->int_queue_len);
+
+	if (free_slots_cnt < num_of_entries) {
+		dev_dbg(hdev->dev, "Queue %d doesn't have room for %d CBs\n",
+			q->hw_queue_id, num_of_entries);
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
 /*
  * hl_hw_queue_send_cb_no_cmpl - send a single CB (not a JOB) without completion
  *
@@ -168,6 +222,184 @@ int hl_hw_queue_send_cb_no_cmpl(struct hl_device *hdev, u32 hw_queue_id,
 	return rc;
 }
 
+/*
+ * ext_hw_queue_schedule_job - submit an JOB to an external queue
+ *
+ * @job: pointer to the job that needs to be submitted to the queue
+ *
+ * This function must be called when the scheduler mutex is taken
+ *
+ */
+static void ext_hw_queue_schedule_job(struct hl_cs_job *job)
+{
+	struct hl_device *hdev = job->cs->ctx->hdev;
+	struct hl_hw_queue *q = &hdev->kernel_queues[job->hw_queue_id];
+	struct hl_cq_entry cq_pkt;
+	struct hl_cq *cq;
+	u64 cq_addr;
+	struct hl_cb *cb;
+	u32 ctl;
+	u32 len;
+	u64 ptr;
+
+	/*
+	 * Update the JOB ID inside the BD CTL so the device would know what
+	 * to write in the completion queue
+	 */
+	ctl = ((q->pi << BD_CTL_SHADOW_INDEX_SHIFT) & BD_CTL_SHADOW_INDEX_MASK);
+
+	cb = job->patched_cb;
+	len = job->job_cb_size;
+	ptr = cb->bus_address;
+
+	cq_pkt.data = (q->pi << CQ_ENTRY_SHADOW_INDEX_SHIFT)
+					& CQ_ENTRY_SHADOW_INDEX_MASK;
+	cq_pkt.data |= 1 << CQ_ENTRY_SHADOW_INDEX_VALID_SHIFT;
+	cq_pkt.data |= 1 << CQ_ENTRY_READY_SHIFT;
+
+	/*
+	 * No need to protect pi_offset because scheduling to the
+	 * H/W queues is done under the scheduler mutex
+	 *
+	 * No need to check if CQ is full because it was already
+	 * checked in hl_queue_sanity_checks
+	 */
+	cq = &hdev->completion_queue[q->hw_queue_id];
+	cq_addr = cq->bus_address +
+			hdev->asic_prop.host_phys_base_address;
+	cq_addr += cq->pi * sizeof(struct hl_cq_entry);
+
+	hdev->asic_funcs->add_end_of_cb_packets(cb->kernel_address, len,
+				cq_addr, cq_pkt.data, q->hw_queue_id);
+
+	q->shadow_queue[hl_pi_2_offset(q->pi)] = job;
+
+	cq->pi = hl_cq_inc_ptr(cq->pi);
+
+	ext_queue_submit_bd(hdev, q, ctl, len, ptr);
+}
+
+/*
+ * int_hw_queue_schedule_job - submit an JOB to an internal queue
+ *
+ * @job: pointer to the job that needs to be submitted to the queue
+ *
+ * This function must be called when the scheduler mutex is taken
+ *
+ */
+static void int_hw_queue_schedule_job(struct hl_cs_job *job)
+{
+	struct hl_device *hdev = job->cs->ctx->hdev;
+	struct hl_hw_queue *q = &hdev->kernel_queues[job->hw_queue_id];
+	struct hl_bd bd;
+	u64 *pi, *pbd = (u64 *) &bd;
+
+	bd.ctl = 0;
+	bd.len = job->job_cb_size;
+	bd.ptr = (u64) job->user_cb;
+
+	pi = (u64 *) (q->kernel_address +
+		((q->pi & (q->int_queue_len - 1)) * sizeof(bd)));
+
+	pi[0] = pbd[0];
+	pi[1] = pbd[1];
+
+	q->pi++;
+	q->pi &= ((q->int_queue_len << 1) - 1);
+
+	/* Flush PQ entry write. Relevant only for specific ASICs */
+	hdev->asic_funcs->flush_pq_write(hdev, pi, pbd[0]);
+
+	hdev->asic_funcs->ring_doorbell(hdev, q->hw_queue_id, q->pi);
+}
+
+/*
+ * hl_hw_queue_schedule_cs - schedule a command submission
+ *
+ * @job        : pointer to the CS
+ *
+ */
+int hl_hw_queue_schedule_cs(struct hl_cs *cs)
+{
+	struct hl_device *hdev = cs->ctx->hdev;
+	struct hl_cs_job *job, *tmp;
+	struct hl_hw_queue *q;
+	int rc = 0, i, cq_cnt;
+
+	hdev->asic_funcs->hw_queues_lock(hdev);
+
+	if (hl_device_disabled_or_in_reset(hdev)) {
+		dev_err(hdev->dev,
+			"device is disabled or in reset, CS rejected!\n");
+		rc = -EPERM;
+		goto out;
+	}
+
+	q = &hdev->kernel_queues[0];
+	/* This loop assumes all external queues are consecutive */
+	for (i = 0, cq_cnt = 0 ; i < HL_MAX_QUEUES ; i++, q++) {
+		if (q->queue_type == QUEUE_TYPE_EXT) {
+			if (cs->jobs_in_queue_cnt[i]) {
+				rc = ext_queue_sanity_checks(hdev, q,
+					cs->jobs_in_queue_cnt[i], true);
+				if (rc)
+					goto unroll_cq_resv;
+				cq_cnt++;
+			}
+		} else if (q->queue_type == QUEUE_TYPE_INT) {
+			if (cs->jobs_in_queue_cnt[i]) {
+				rc = int_queue_sanity_checks(hdev, q,
+					cs->jobs_in_queue_cnt[i]);
+				if (rc)
+					goto unroll_cq_resv;
+			}
+		}
+	}
+
+	spin_lock(&hdev->hw_queues_mirror_lock);
+	list_add_tail(&cs->mirror_node, &hdev->hw_queues_mirror_list);
+
+	/* Queue TDR if the CS is the first entry and if timeout is wanted */
+	if ((hdev->timeout_jiffies != MAX_SCHEDULE_TIMEOUT) &&
+			(list_first_entry(&hdev->hw_queues_mirror_list,
+					struct hl_cs, mirror_node) == cs)) {
+		cs->tdr_active = true;
+		schedule_delayed_work(&cs->work_tdr, hdev->timeout_jiffies);
+		spin_unlock(&hdev->hw_queues_mirror_lock);
+	} else {
+		spin_unlock(&hdev->hw_queues_mirror_lock);
+	}
+
+	list_for_each_entry_safe(job, tmp, &cs->job_list, cs_node) {
+		if (job->ext_queue)
+			ext_hw_queue_schedule_job(job);
+		else
+			int_hw_queue_schedule_job(job);
+	}
+
+	cs->submitted = true;
+
+	goto out;
+
+unroll_cq_resv:
+	/* This loop assumes all external queues are consecutive */
+	q = &hdev->kernel_queues[0];
+	for (i = 0 ; (i < HL_MAX_QUEUES) && (cq_cnt > 0) ; i++, q++) {
+		if ((q->queue_type == QUEUE_TYPE_EXT) &&
+				(cs->jobs_in_queue_cnt[i])) {
+			atomic_t *free_slots =
+				&hdev->completion_queue[i].free_slots_cnt;
+			atomic_add(cs->jobs_in_queue_cnt[i], free_slots);
+			cq_cnt--;
+		}
+	}
+
+out:
+	hdev->asic_funcs->hw_queues_unlock(hdev);
+
+	return rc;
+}
+
 /*
  * hl_hw_queue_inc_ci_kernel - increment ci for kernel's queue
  *
diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
new file mode 100644
index 000000000000..6536b40c63e0
--- /dev/null
+++ b/drivers/misc/habanalabs/memory.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "habanalabs.h"
+
+#include <linux/sched.h>
+#include <linux/uaccess.h>
+#include <linux/genalloc.h>
+
+/*
+ * hl_pin_host_memory - pins a chunk of host memory
+ *
+ * @hdev                : pointer to the habanalabs device structure
+ * @addr                : the user-space virtual address of the memory area
+ * @size                : the size of the memory area
+ * @userptr	        : pointer to hl_userptr structure
+ *
+ * This function does the following:
+ * - Pins the physical pages
+ * - Create a SG list from those pages
+ */
+int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u32 size,
+			struct hl_userptr *userptr)
+{
+	u64 start, end;
+	u32 npages, offset;
+	int rc;
+
+	if (!size) {
+		dev_err(hdev->dev, "size to pin is invalid - %d\n",
+			size);
+		return -EINVAL;
+	}
+
+	if (!access_ok((void __user *) addr, size)) {
+		dev_err(hdev->dev, "user pointer is invalid - 0x%llx\n",
+			addr);
+		return -EFAULT;
+	}
+
+	/*
+	 * If the combination of the address and size requested for this memory
+	 * region causes an integer overflow, return error.
+	 */
+	if (((addr + size) < addr) ||
+			PAGE_ALIGN(addr + size) < (addr + size)) {
+		dev_err(hdev->dev,
+			"user pointer 0x%llx + %u causes integer overflow\n",
+			addr, size);
+		return -EINVAL;
+	}
+
+	start = addr & PAGE_MASK;
+	offset = addr & ~PAGE_MASK;
+	end = PAGE_ALIGN(addr + size);
+	npages = (end - start) >> PAGE_SHIFT;
+
+	userptr->size = size;
+	userptr->addr = addr;
+	userptr->dma_mapped = false;
+	INIT_LIST_HEAD(&userptr->job_node);
+
+	userptr->vec = frame_vector_create(npages);
+	if (!userptr->vec) {
+		dev_err(hdev->dev, "Failed to create frame vector\n");
+		return -ENOMEM;
+	}
+
+	rc = get_vaddr_frames(start, npages, FOLL_FORCE | FOLL_WRITE,
+				userptr->vec);
+
+	if (rc != npages) {
+		dev_err(hdev->dev,
+			"Failed to map host memory, user ptr probably wrong\n");
+		if (rc < 0)
+			goto destroy_framevec;
+		rc = -EFAULT;
+		goto put_framevec;
+	}
+
+	if (frame_vector_to_pages(userptr->vec) < 0) {
+		dev_err(hdev->dev,
+			"Failed to translate frame vector to pages\n");
+		rc = -EFAULT;
+		goto put_framevec;
+	}
+
+	userptr->sgt = kzalloc(sizeof(*userptr->sgt), GFP_ATOMIC);
+	if (!userptr->sgt) {
+		rc = -ENOMEM;
+		goto put_framevec;
+	}
+
+	rc = sg_alloc_table_from_pages(userptr->sgt,
+					frame_vector_pages(userptr->vec),
+					npages, offset, size, GFP_ATOMIC);
+	if (rc < 0) {
+		dev_err(hdev->dev, "failed to create SG table from pages\n");
+		goto free_sgt;
+	}
+
+	return 0;
+
+free_sgt:
+	kfree(userptr->sgt);
+put_framevec:
+	put_vaddr_frames(userptr->vec);
+destroy_framevec:
+	frame_vector_destroy(userptr->vec);
+	return rc;
+}
+
+/*
+ * hl_unpin_host_memory - unpins a chunk of host memory
+ *
+ * @hdev                : pointer to the habanalabs device structure
+ * @userptr             : pointer to hl_userptr structure
+ *
+ * This function does the following:
+ * - Unpins the physical pages related to the host memory
+ * - Free the SG list
+ */
+int hl_unpin_host_memory(struct hl_device *hdev, struct hl_userptr *userptr)
+{
+	struct page **pages;
+
+	if (userptr->dma_mapped)
+		hdev->asic_funcs->hl_dma_unmap_sg(hdev,
+				userptr->sgt->sgl,
+				userptr->sgt->nents,
+				userptr->dir);
+
+	pages = frame_vector_pages(userptr->vec);
+	if (!IS_ERR(pages)) {
+		int i;
+
+		for (i = 0; i < frame_vector_count(userptr->vec); i++)
+			set_page_dirty_lock(pages[i]);
+	}
+	put_vaddr_frames(userptr->vec);
+	frame_vector_destroy(userptr->vec);
+
+	list_del(&userptr->job_node);
+
+	sg_free_table(userptr->sgt);
+	kfree(userptr->sgt);
+
+	return 0;
+}
+
+/*
+ * hl_userptr_delete_list - clear userptr list
+ *
+ * @hdev                : pointer to the habanalabs device structure
+ * @userptr_list        : pointer to the list to clear
+ *
+ * This function does the following:
+ * - Iterates over the list and unpins the host memory and frees the userptr
+ *   structure.
+ */
+void hl_userptr_delete_list(struct hl_device *hdev,
+				struct list_head *userptr_list)
+{
+	struct hl_userptr *userptr, *tmp;
+
+	list_for_each_entry_safe(userptr, tmp, userptr_list, job_node) {
+		hl_unpin_host_memory(hdev, userptr);
+		kfree(userptr);
+	}
+
+	INIT_LIST_HEAD(userptr_list);
+}
+
+/*
+ * hl_userptr_is_pinned - returns whether the given userptr is pinned
+ *
+ * @hdev                : pointer to the habanalabs device structure
+ * @userptr_list        : pointer to the list to clear
+ * @userptr             : pointer to userptr to check
+ *
+ * This function does the following:
+ * - Iterates over the list and checks if the given userptr is in it, means is
+ *   pinned. If so, returns true, otherwise returns false.
+ */
+bool hl_userptr_is_pinned(struct hl_device *hdev, u64 addr,
+				u32 size, struct list_head *userptr_list,
+				struct hl_userptr **userptr)
+{
+	list_for_each_entry((*userptr), userptr_list, job_node) {
+		if ((addr == (*userptr)->addr) && (size == (*userptr)->size))
+			return true;
+	}
+
+	return false;
+}
+
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 756266cf0416..fba49417f607 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -73,6 +73,95 @@ union hl_cb_args {
 	struct hl_cb_out out;
 };
 
+/*
+ * This structure size must always be fixed to 64-bytes for backward
+ * compatibility
+ */
+struct hl_cs_chunk {
+	/*
+	 * For external queue, this represents a Handle of CB on the Host
+	 * For internal queue, this represents an SRAM or DRAM address of the
+	 * internal CB
+	 */
+	__u64 cb_handle;
+	/* Index of queue to put the CB on */
+	__u32 queue_index;
+	/*
+	 * Size of command buffer with valid packets
+	 * Can be smaller then actual CB size
+	 */
+	__u32 cb_size;
+	/* HL_CS_CHUNK_FLAGS_* */
+	__u32 cs_chunk_flags;
+	/* Align structure to 64 bytes */
+	__u32 pad[11];
+};
+
+#define HL_CS_FLAGS_FORCE_RESTORE	0x1
+
+#define HL_CS_STATUS_SUCCESS		0
+
+struct hl_cs_in {
+	/* this holds address of array of hl_cs_chunk for restore phase */
+	__u64 chunks_restore;
+	/* this holds address of array of hl_cs_chunk for execution phase */
+	__u64 chunks_execute;
+	/* this holds address of array of hl_cs_chunk for store phase -
+	 * Currently not in use
+	 */
+	__u64 chunks_store;
+	/* Number of chunks in restore phase array */
+	__u32 num_chunks_restore;
+	/* Number of chunks in execution array */
+	__u32 num_chunks_execute;
+	/* Number of chunks in restore phase array - Currently not in use */
+	__u32 num_chunks_store;
+	/* HL_CS_FLAGS_* */
+	__u32 cs_flags;
+	/* Context ID - Currently not in use */
+	__u32 ctx_id;
+};
+
+struct hl_cs_out {
+	/* this holds the sequence number of the CS to pass to wait ioctl */
+	__u64 seq;
+	/* HL_CS_STATUS_* */
+	__u32 status;
+	__u32 pad;
+};
+
+union hl_cs_args {
+	struct hl_cs_in in;
+	struct hl_cs_out out;
+};
+
+struct hl_wait_cs_in {
+	/* Command submission sequence number */
+	__u64 seq;
+	/* Absolute timeout to wait in microseconds */
+	__u64 timeout_us;
+	/* Context ID - Currently not in use */
+	__u32 ctx_id;
+	__u32 pad;
+};
+
+#define HL_WAIT_CS_STATUS_COMPLETED	0
+#define HL_WAIT_CS_STATUS_BUSY		1
+#define HL_WAIT_CS_STATUS_TIMEDOUT	2
+#define HL_WAIT_CS_STATUS_ABORTED	3
+#define HL_WAIT_CS_STATUS_INTERRUPTED	4
+
+struct hl_wait_cs_out {
+	/* HL_WAIT_CS_STATUS_* */
+	__u32 status;
+	__u32 pad;
+};
+
+union hl_wait_cs_args {
+	struct hl_wait_cs_in in;
+	struct hl_wait_cs_out out;
+};
+
 /*
  * Command Buffer
  * - Request a Command Buffer
@@ -89,7 +178,74 @@ union hl_cb_args {
 #define HL_IOCTL_CB		\
 		_IOWR('H', 0x02, union hl_cb_args)
 
+/*
+ * Command Submission
+ *
+ * To submit work to the device, the user need to call this IOCTL with a set
+ * of JOBS. That set of JOBS constitutes a CS object.
+ * Each JOB will be enqueued on a specific queue, according to the user's input.
+ * There can be more then one JOB per queue.
+ *
+ * There are two types of queues - external and internal. External queues
+ * are DMA queues which transfer data from/to the Host. All other queues are
+ * internal. The driver will get completion notifications from the device only
+ * on JOBS which are enqueued in the external queues.
+ *
+ * This IOCTL is asynchronous in regard to the actual execution of the CS. This
+ * means it returns immediately after ALL the JOBS were enqueued on their
+ * relevant queues. Therefore, the user mustn't assume the CS has been completed
+ * or has even started to execute.
+ *
+ * Upon successful enqueue, the IOCTL returns an opaque handle which the user
+ * can use with the "Wait for CS" IOCTL to check whether the handle's CS
+ * external JOBS have been completed. Note that if the CS has internal JOBS
+ * which can execute AFTER the external JOBS have finished, the driver might
+ * report that the CS has finished executing BEFORE the internal JOBS have
+ * actually finish executing.
+ *
+ * The CS IOCTL will receive three sets of JOBS. One set is for "restore" phase,
+ * a second set is for "execution" phase and a third set is for "store" phase.
+ * The JOBS on the "restore" phase are enqueued only after context-switch
+ * (or if its the first CS for this context). The user can also order the
+ * driver to run the "restore" phase explicitly
+ *
+ */
+#define HL_IOCTL_CS			\
+		_IOWR('H', 0x03, union hl_cs_args)
+
+/*
+ * Wait for Command Submission
+ *
+ * The user can call this IOCTL with a handle it received from the CS IOCTL
+ * to wait until the handle's CS has finished executing. The user will wait
+ * inside the kernel until the CS has finished or until the user-requeusted
+ * timeout has expired.
+ *
+ * The return value of the IOCTL is a standard Linux error code. The possible
+ * values are:
+ *
+ * EINTR     - Kernel waiting has been interrupted, e.g. due to OS signal
+ *             that the user process received
+ * ETIMEDOUT - The CS has caused a timeout on the device
+ * EIO       - The CS was aborted (usually because the device was reset)
+ * ENODEV    - The device wants to do hard-reset (so user need to close FD)
+ *
+ * The driver also returns a custom define inside the IOCTL which can be:
+ *
+ * HL_WAIT_CS_STATUS_COMPLETED   - The CS has been completed successfully (0)
+ * HL_WAIT_CS_STATUS_BUSY        - The CS is still executing (0)
+ * HL_WAIT_CS_STATUS_TIMEDOUT    - The CS has caused a timeout on the device
+ *                                 (ETIMEDOUT)
+ * HL_WAIT_CS_STATUS_ABORTED     - The CS was aborted, usually because the
+ *                                 device was reset (EIO)
+ * HL_WAIT_CS_STATUS_INTERRUPTED - Waiting for the CS was interrupted (EINTR)
+ *
+ */
+
+#define HL_IOCTL_WAIT_CS			\
+		_IOWR('H', 0x04, union hl_wait_cs_args)
+
 #define HL_COMMAND_START	0x02
-#define HL_COMMAND_END		0x03
+#define HL_COMMAND_END		0x05
 
 #endif /* HABANALABS_H_ */
-- 
2.17.1

