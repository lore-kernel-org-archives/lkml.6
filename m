Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E8AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3B3222AC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTmRyFx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403933AbfBKPST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:18:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51680 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731038AbfBKPSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:18:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so18144846wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 07:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c5VQaPVFP8zdT983TUSJEu2k+NYxxDtyHv3ZUHVvHfc=;
        b=PTmRyFx+7F4dUm67iQZGMI4OTQ1sQC855FDHhTXIgFdJ+OPYx6KB0/uLT1dGzM49Xu
         59v/8g84UsaACqTfg6oLhMT786X/9LozV1IHcq+x5BiMvypoT2XZnIPgE6PbK6PKKojm
         YoFeAeKMbsGzY8raCWfog29+93QAFY2lScUBTnQGMIu0UToKqZttP8JfG0/ypuqG9/Xb
         +0wT55WLU2PZZco+gJQw56Zey+S0WKIkDy88O0krAVgn64LuxGQ8H4LEEx4on1VWniAh
         d26GnY8DVjvFEOFWmBXeBVXku837QB73MDYG6Mv58mzF1SfMccKX97ec51xqH75eTHsF
         heRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c5VQaPVFP8zdT983TUSJEu2k+NYxxDtyHv3ZUHVvHfc=;
        b=N3VGrOF2cwC93JugQeiQJ80os0BDGlRa0OKmbVEYw8Liyyg2oh7R5Qp0+JMiZ0uIWE
         oVywdSXMC/Esc43pURhOo9Gw/XVl2SjKQE6aFQxVl4AO9v+sL0ugSe36FTtA9t3KTnsF
         EtSeq/FtaW070KHEF1U4erl0qVxVE3dMsO+ct5tyoVkHC8Ngek7XOQLBTvjcxsigKsHu
         0HFs3QUDHZyf42/RLb7jZnL9HZRXSjN9RQ0vipam1vwwPNo2/NtDZp4/LnEnRi+Az0gU
         6OuaQaN852I4cU1rw0xj3O88iNxKNXZqRyfFiBkNPVugFn6gFW5pUpZN7DckzNI7zQsY
         eQIA==
X-Gm-Message-State: AHQUAuaDIrR3FaQ7ZZPc3l7ecwGtr5cTN7ucVYEUVcCTWl7lzsHN/DBH
        Gtb/THxyDy2QxtWIn8UrVos=
X-Google-Smtp-Source: AHgI3IbrGW/IGPc85kSsGYTKw0gJeh8YFWlaxyG9Aeq+by99H/isPOYQCDtlJzXSLs6gv3XbLRkjSQ==
X-Received: by 2002:a1c:4683:: with SMTP id t125mr10349395wma.9.1549898288608;
        Mon, 11 Feb 2019 07:18:08 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c186sm12531380wmf.34.2019.02.11.07.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 07:18:08 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com, olof@lixom.net
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v4 05/15] habanalabs: add command buffer module
Date:   Mon, 11 Feb 2019 17:17:41 +0200
Message-Id: <20190211151751.12336-6-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211151751.12336-1-oded.gabbay@gmail.com>
References: <20190211151751.12336-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the command buffer (CB) module, which allows the user to
create and destroy CBs and to map them to the user's process
address-space.

A command buffer is a memory blocks that reside in DMA-able address-space
and is physically contiguous so it can be accessed by the device without
MMU translation. The command buffer memory is allocated using the
coherent DMA API.

When creating a new CB, the IOCTL returns a handle of it, and the
user-space process needs to use that handle to mmap the buffer to get a VA
in the user's address-space.

Before destroying (freeing) a CB, the user must unmap the CB's VA using the
CB handle.

Each CB has a reference counter, which tracks its usage in command
submissions and also its mmaps (only a single mmap is allowed).

The driver maintains a pool of pre-allocated CBs in order to reduce
latency during command submissions. In case the pool is empty, the driver
will go to the slow-path of allocating a new CB, i.e. calling
dma_alloc_coherent.

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
Changes in v4:
  - Use -ENOTTY to signal bad ioctl parameter
  - Call put_cb() after updating its values (to prevent dereference after free)
  - Correctly account cb unmap calls (fix bug in case of partial munmap)
  - Check for maximum CB size allowed by driver
 
 drivers/misc/habanalabs/Makefile           |   3 +-
 drivers/misc/habanalabs/command_buffer.c   | 431 +++++++++++++++++++++
 drivers/misc/habanalabs/device.c           |  43 +-
 drivers/misc/habanalabs/goya/goya.c        |  28 ++
 drivers/misc/habanalabs/habanalabs.h       |  86 ++++
 drivers/misc/habanalabs/habanalabs_drv.c   |   2 +
 drivers/misc/habanalabs/habanalabs_ioctl.c |  99 +++++
 include/uapi/misc/habanalabs.h             |  46 +++
 8 files changed, 736 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/habanalabs/command_buffer.c
 create mode 100644 drivers/misc/habanalabs/habanalabs_ioctl.c

diff --git a/drivers/misc/habanalabs/Makefile b/drivers/misc/habanalabs/Makefile
index 3ffbadc2ca01..2530c9b78ca4 100644
--- a/drivers/misc/habanalabs/Makefile
+++ b/drivers/misc/habanalabs/Makefile
@@ -4,7 +4,8 @@
 
 obj-m	:= habanalabs.o
 
-habanalabs-y := habanalabs_drv.o device.o context.o asid.o
+habanalabs-y := habanalabs_drv.o device.o context.o asid.o habanalabs_ioctl.o \
+		command_buffer.o
 
 include $(src)/goya/Makefile
 habanalabs-y += $(HL_GOYA_FILES)
diff --git a/drivers/misc/habanalabs/command_buffer.c b/drivers/misc/habanalabs/command_buffer.c
new file mode 100644
index 000000000000..cd19f00f85f2
--- /dev/null
+++ b/drivers/misc/habanalabs/command_buffer.c
@@ -0,0 +1,431 @@
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
+#include <linux/dma-mapping.h>
+
+static void cb_fini(struct hl_device *hdev, struct hl_cb *cb)
+{
+	hdev->asic_funcs->dma_free_coherent(hdev, cb->size,
+			(void *) cb->kernel_address, cb->bus_address);
+	kfree(cb);
+}
+
+static void cb_do_release(struct hl_device *hdev, struct hl_cb *cb)
+{
+	if (cb->is_pool) {
+		spin_lock(&hdev->cb_pool_lock);
+		list_add(&cb->pool_list, &hdev->cb_pool);
+		spin_unlock(&hdev->cb_pool_lock);
+	} else {
+		cb_fini(hdev, cb);
+	}
+}
+
+static void cb_release(struct kref *ref)
+{
+	struct hl_device *hdev;
+	struct hl_cb *cb;
+
+	cb = container_of(ref, struct hl_cb, refcount);
+	hdev = cb->hdev;
+
+	cb_do_release(hdev, cb);
+}
+
+static struct hl_cb *hl_cb_alloc(struct hl_device *hdev, u32 cb_size,
+					int ctx_id)
+{
+	struct hl_cb *cb;
+	void *p;
+
+	/*
+	 * We use of GFP_ATOMIC here because this function can be called from
+	 * the latency-sensitive code path for command submission. Due to H/W
+	 * limitations in some of the ASICs, the kernel must copy the user CB
+	 * that is designated for an external queue and actually enqueue
+	 * the kernel's copy. Hence, we must never sleep in this code section
+	 * and must use GFP_ATOMIC for all memory allocations.
+	 */
+	if (ctx_id == HL_KERNEL_ASID_ID)
+		cb = kzalloc(sizeof(*cb), GFP_ATOMIC);
+	else
+		cb = kzalloc(sizeof(*cb), GFP_KERNEL);
+
+	if (!cb)
+		return NULL;
+
+	if (ctx_id == HL_KERNEL_ASID_ID)
+		p = hdev->asic_funcs->dma_alloc_coherent(hdev, cb_size,
+						&cb->bus_address, GFP_ATOMIC);
+	else
+		p = hdev->asic_funcs->dma_alloc_coherent(hdev, cb_size,
+						&cb->bus_address,
+						GFP_USER | __GFP_ZERO);
+	if (!p) {
+		dev_err(hdev->dev,
+			"failed to allocate %d of dma memory for CB\n",
+			cb_size);
+		kfree(cb);
+		return NULL;
+	}
+
+	cb->kernel_address = (u64) p;
+	cb->size = cb_size;
+
+	return cb;
+}
+
+int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
+			u32 cb_size, u64 *handle, int ctx_id)
+{
+	struct hl_cb *cb;
+	bool alloc_new_cb = true;
+	int rc;
+
+	if (hdev->disabled) {
+		dev_warn_ratelimited(hdev->dev,
+			"Device is disabled. Can't create new CBs\n");
+		rc = -EBUSY;
+		goto out_err;
+	}
+
+	if (cb_size > HL_MAX_CB_SIZE) {
+		dev_err(hdev->dev,
+			"CB size %d must be less then %d\n",
+			cb_size, HL_MAX_CB_SIZE);
+		rc = -EINVAL;
+		goto out_err;
+	}
+
+	/* Minimum allocation must be PAGE SIZE */
+	if (cb_size < PAGE_SIZE)
+		cb_size = PAGE_SIZE;
+
+	if (ctx_id == HL_KERNEL_ASID_ID &&
+			cb_size <= hdev->asic_prop.cb_pool_cb_size) {
+
+		spin_lock(&hdev->cb_pool_lock);
+		if (!list_empty(&hdev->cb_pool)) {
+			cb = list_first_entry(&hdev->cb_pool, typeof(*cb),
+					pool_list);
+			list_del(&cb->pool_list);
+			spin_unlock(&hdev->cb_pool_lock);
+			alloc_new_cb = false;
+		} else {
+			spin_unlock(&hdev->cb_pool_lock);
+			dev_dbg(hdev->dev, "CB pool is empty\n");
+		}
+	}
+
+	if (alloc_new_cb) {
+		cb = hl_cb_alloc(hdev, cb_size, ctx_id);
+		if (!cb) {
+			rc = -ENOMEM;
+			goto out_err;
+		}
+	}
+
+	cb->hdev = hdev;
+	cb->ctx_id = ctx_id;
+
+	spin_lock(&mgr->cb_lock);
+	rc = idr_alloc(&mgr->cb_handles, cb, 1, 0, GFP_ATOMIC);
+	spin_unlock(&mgr->cb_lock);
+
+	if (rc < 0) {
+		dev_err(hdev->dev, "Failed to allocate IDR for a new CB\n");
+		goto release_cb;
+	}
+
+	cb->id = rc;
+
+	kref_init(&cb->refcount);
+	spin_lock_init(&cb->lock);
+
+	/*
+	 * idr is 32-bit so we can safely OR it with a mask that is above
+	 * 32 bit
+	 */
+	*handle = cb->id | HL_MMAP_CB_MASK;
+	*handle <<= PAGE_SHIFT;
+
+	return 0;
+
+release_cb:
+	cb_do_release(hdev, cb);
+out_err:
+	*handle = 0;
+
+	return rc;
+}
+
+int hl_cb_destroy(struct hl_device *hdev, struct hl_cb_mgr *mgr, u64 cb_handle)
+{
+	struct hl_cb *cb;
+	u32 handle;
+	int rc = 0;
+
+	/*
+	 * handle was given to user to do mmap, I need to shift it back to
+	 * how the idr module gave it to me
+	 */
+	cb_handle >>= PAGE_SHIFT;
+	handle = (u32) cb_handle;
+
+	spin_lock(&mgr->cb_lock);
+
+	cb = idr_find(&mgr->cb_handles, handle);
+	if (cb) {
+		idr_remove(&mgr->cb_handles, handle);
+		spin_unlock(&mgr->cb_lock);
+		kref_put(&cb->refcount, cb_release);
+	} else {
+		spin_unlock(&mgr->cb_lock);
+		dev_err(hdev->dev,
+			"CB destroy failed, no match to handle 0x%x\n", handle);
+		rc = -EINVAL;
+	}
+
+	return rc;
+}
+
+int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
+{
+	union hl_cb_args *args = data;
+	struct hl_device *hdev = hpriv->hdev;
+	u64 handle;
+	int rc;
+
+	switch (args->in.op) {
+	case HL_CB_OP_CREATE:
+		rc = hl_cb_create(hdev, &hpriv->cb_mgr, args->in.cb_size,
+					&handle, hpriv->ctx->asid);
+		memset(args, 0, sizeof(*args));
+		args->out.cb_handle = handle;
+		break;
+	case HL_CB_OP_DESTROY:
+		rc = hl_cb_destroy(hdev, &hpriv->cb_mgr,
+					args->in.cb_handle);
+		break;
+	default:
+		rc = -ENOTTY;
+		break;
+	}
+
+	return rc;
+}
+
+static void cb_vm_close(struct vm_area_struct *vma)
+{
+	struct hl_cb *cb = (struct hl_cb *) vma->vm_private_data;
+
+	cb->mmap_size -= vma->vm_end - vma->vm_start;
+
+	if (cb->mmap_size)
+		return;
+
+	spin_lock(&cb->lock);
+	cb->mmap = false;
+	spin_unlock(&cb->lock);
+
+	hl_cb_put(cb);
+	vma->vm_private_data = NULL;
+}
+
+static const struct vm_operations_struct cb_vm_ops = {
+	.close = cb_vm_close
+};
+
+int hl_cb_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	struct hl_cb *cb;
+	phys_addr_t address;
+	u32 handle;
+	int rc;
+
+	handle = vma->vm_pgoff;
+
+	/* reference was taken here */
+	cb = hl_cb_get(hdev, &hpriv->cb_mgr, handle);
+	if (!cb) {
+		dev_err(hdev->dev,
+			"CB mmap failed, no match to handle %d\n", handle);
+		return -EINVAL;
+	}
+
+	/* Validation check */
+	if ((vma->vm_end - vma->vm_start) != cb->size) {
+		dev_err(hdev->dev,
+			"CB mmap failed, mmap size 0x%lx != 0x%x cb size\n",
+			vma->vm_end - vma->vm_start, cb->size);
+		rc = -EINVAL;
+		goto put_cb;
+	}
+
+	spin_lock(&cb->lock);
+
+	if (cb->mmap) {
+		dev_err(hdev->dev,
+			"CB mmap failed, CB already mmaped to user\n");
+		rc = -EINVAL;
+		goto release_lock;
+	}
+
+	cb->mmap = true;
+
+	spin_unlock(&cb->lock);
+
+	vma->vm_ops = &cb_vm_ops;
+
+	/*
+	 * Note: We're transferring the cb reference to
+	 * vma->vm_private_data here.
+	 */
+
+	vma->vm_private_data = cb;
+
+	/* Calculate address for CB */
+	address = virt_to_phys((void *) cb->kernel_address);
+
+	rc = hdev->asic_funcs->cb_mmap(hdev, vma, cb->kernel_address,
+					address, cb->size);
+
+	if (rc) {
+		spin_lock(&cb->lock);
+		cb->mmap = false;
+		goto release_lock;
+	}
+
+	cb->mmap_size = cb->size;
+
+	return 0;
+
+release_lock:
+	spin_unlock(&cb->lock);
+put_cb:
+	hl_cb_put(cb);
+	return rc;
+}
+
+struct hl_cb *hl_cb_get(struct hl_device *hdev, struct hl_cb_mgr *mgr,
+			u32 handle)
+{
+	struct hl_cb *cb;
+
+	spin_lock(&mgr->cb_lock);
+	cb = idr_find(&mgr->cb_handles, handle);
+
+	if (!cb) {
+		spin_unlock(&mgr->cb_lock);
+		dev_warn(hdev->dev,
+			"CB get failed, no match to handle %d\n", handle);
+		return NULL;
+	}
+
+	kref_get(&cb->refcount);
+
+	spin_unlock(&mgr->cb_lock);
+
+	return cb;
+
+}
+
+void hl_cb_put(struct hl_cb *cb)
+{
+	kref_put(&cb->refcount, cb_release);
+}
+
+void hl_cb_mgr_init(struct hl_cb_mgr *mgr)
+{
+	spin_lock_init(&mgr->cb_lock);
+	idr_init(&mgr->cb_handles);
+}
+
+void hl_cb_mgr_fini(struct hl_device *hdev, struct hl_cb_mgr *mgr)
+{
+	struct hl_cb *cb;
+	struct idr *idp;
+	u32 id;
+
+	idp = &mgr->cb_handles;
+
+	idr_for_each_entry(idp, cb, id) {
+		if (kref_put(&cb->refcount, cb_release) != 1)
+			dev_err(hdev->dev,
+				"CB %d for CTX ID %d is still alive\n",
+				id, cb->ctx_id);
+	}
+
+	idr_destroy(&mgr->cb_handles);
+}
+
+struct hl_cb *hl_cb_kernel_create(struct hl_device *hdev, u32 cb_size)
+{
+	u64 cb_handle;
+	struct hl_cb *cb;
+	int rc;
+
+	rc = hl_cb_create(hdev, &hdev->kernel_cb_mgr, cb_size, &cb_handle,
+			HL_KERNEL_ASID_ID);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to allocate CB for KMD %d\n", rc);
+		return NULL;
+	}
+
+	cb_handle >>= PAGE_SHIFT;
+	cb = hl_cb_get(hdev, &hdev->kernel_cb_mgr, (u32) cb_handle);
+	/* hl_cb_get should never fail here so use kernel WARN */
+	WARN(!cb, "Kernel CB handle invalid 0x%x\n", (u32) cb_handle);
+	if (!cb)
+		goto destroy_cb;
+
+	return cb;
+
+destroy_cb:
+	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, cb_handle << PAGE_SHIFT);
+
+	return NULL;
+}
+
+int hl_cb_pool_init(struct hl_device *hdev)
+{
+	struct hl_cb *cb;
+	int i;
+
+	INIT_LIST_HEAD(&hdev->cb_pool);
+	spin_lock_init(&hdev->cb_pool_lock);
+
+	for (i = 0 ; i < hdev->asic_prop.cb_pool_cb_cnt ; i++) {
+		cb = hl_cb_alloc(hdev, hdev->asic_prop.cb_pool_cb_size,
+				HL_KERNEL_ASID_ID);
+		if (cb) {
+			cb->is_pool = true;
+			list_add(&cb->pool_list, &hdev->cb_pool);
+		} else {
+			hl_cb_pool_fini(hdev);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+int hl_cb_pool_fini(struct hl_device *hdev)
+{
+	struct hl_cb *cb, *tmp;
+
+	list_for_each_entry_safe(cb, tmp, &hdev->cb_pool, pool_list) {
+		list_del(&cb->pool_list);
+		cb_fini(hdev, cb);
+	}
+
+	return 0;
+}
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 81acb1de9c7e..c5296b068aaf 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -53,6 +53,7 @@ static int hl_device_release(struct inode *inode, struct file *filp)
 {
 	struct hl_fpriv *hpriv = filp->private_data;
 
+	hl_cb_mgr_fini(hpriv->hdev, &hpriv->cb_mgr);
 	hl_ctx_mgr_fini(hpriv->hdev, &hpriv->ctx_mgr);
 
 	filp->private_data = NULL;
@@ -62,10 +63,34 @@ static int hl_device_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+/*
+ * hl_mmap - mmap function for habanalabs device
+ *
+ * @*filp: pointer to file structure
+ * @*vma: pointer to vm_area_struct of the process
+ *
+ * Called when process does an mmap on habanalabs device. Call the device's mmap
+ * function at the end of the common code.
+ */
+static int hl_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct hl_fpriv *hpriv = filp->private_data;
+
+	if ((vma->vm_pgoff & HL_MMAP_CB_MASK) == HL_MMAP_CB_MASK) {
+		vma->vm_pgoff ^= HL_MMAP_CB_MASK;
+		return hl_cb_mmap(hpriv, vma);
+	}
+
+	return hpriv->hdev->asic_funcs->mmap(hpriv, vma);
+}
+
 static const struct file_operations hl_ops = {
 	.owner = THIS_MODULE,
 	.open = hl_device_open,
-	.release = hl_device_release
+	.release = hl_device_release,
+	.mmap = hl_mmap,
+	.unlocked_ioctl = hl_ioctl,
+	.compat_ioctl = hl_ioctl
 };
 
 /*
@@ -150,6 +175,8 @@ static int device_early_init(struct hl_device *hdev)
 	if (rc)
 		goto early_fini;
 
+	hl_cb_mgr_init(&hdev->kernel_cb_mgr);
+
 	mutex_init(&hdev->fd_open_cnt_lock);
 	atomic_set(&hdev->fd_open_cnt, 0);
 
@@ -171,6 +198,8 @@ static int device_early_init(struct hl_device *hdev)
 static void device_early_fini(struct hl_device *hdev)
 {
 
+	hl_cb_mgr_fini(hdev, &hdev->kernel_cb_mgr);
+
 	hl_asid_fini(hdev);
 
 	if (hdev->asic_funcs->early_fini)
@@ -285,11 +314,21 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		goto free_ctx;
 	}
 
+	rc = hl_cb_pool_init(hdev);
+	if (rc) {
+		dev_err(hdev->dev, "failed to initialize CB pool\n");
+		goto release_ctx;
+	}
+
 	dev_notice(hdev->dev,
 		"Successfully added device to habanalabs driver\n");
 
 	return 0;
 
+release_ctx:
+	if (hl_ctx_put(hdev->kernel_ctx) != 1)
+		dev_err(hdev->dev,
+			"kernel ctx is still alive on initialization failure\n");
 free_ctx:
 	kfree(hdev->kernel_ctx);
 sw_fini:
@@ -326,6 +365,8 @@ void hl_device_fini(struct hl_device *hdev)
 	/* Mark device as disabled */
 	hdev->disabled = true;
 
+	hl_cb_pool_fini(hdev);
+
 	/* Release kernel context */
 	if ((hdev->kernel_ctx) && (hl_ctx_put(hdev->kernel_ctx) != 1))
 		dev_err(hdev->dev, "kernel ctx is still alive\n");
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 47e7472b7472..6626dead7231 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -92,6 +92,9 @@
 
 #define GOYA_MAX_INITIATORS		20
 
+#define GOYA_CB_POOL_CB_CNT		512
+#define GOYA_CB_POOL_CB_SIZE		0x20000		/* 128KB */
+
 static void goya_get_fixed_properties(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -119,6 +122,8 @@ static void goya_get_fixed_properties(struct hl_device *hdev)
 	prop->tpc_enabled_mask = TPC_ENABLED_MASK;
 
 	prop->high_pll = PLL_HIGH_DEFAULT;
+	prop->cb_pool_cb_cnt = GOYA_CB_POOL_CB_CNT;
+	prop->cb_pool_cb_size = GOYA_CB_POOL_CB_SIZE;
 }
 
 /*
@@ -604,6 +609,27 @@ int goya_resume(struct hl_device *hdev)
 	return 0;
 }
 
+int goya_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
+{
+	return -EINVAL;
+}
+
+int goya_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
+		u64 kaddress, phys_addr_t paddress, u32 size)
+{
+	int rc;
+
+	vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP |
+			VM_DONTCOPY | VM_NORESERVE;
+
+	rc = remap_pfn_range(vma, vma->vm_start, paddress >> PAGE_SHIFT,
+				size, vma->vm_page_prot);
+	if (rc)
+		dev_err(hdev->dev, "remap_pfn_range error %d", rc);
+
+	return rc;
+}
+
 void *goya_dma_alloc_coherent(struct hl_device *hdev, size_t size,
 					dma_addr_t *dma_handle, gfp_t flags)
 {
@@ -623,6 +649,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.sw_fini = goya_sw_fini,
 	.suspend = goya_suspend,
 	.resume = goya_resume,
+	.mmap = goya_mmap,
+	.cb_mmap = goya_cb_mmap,
 	.dma_alloc_coherent = goya_dma_alloc_coherent,
 	.dma_free_coherent = goya_dma_free_coherent,
 };
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 9f76373b3e2c..ed79a0be58d7 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -21,9 +21,12 @@
 
 #define HL_NAME				"habanalabs"
 
+#define HL_MMAP_CB_MASK			(0x8000000000000000ull >> PAGE_SHIFT)
+
 #define HL_MAX_QUEUES			128
 
 struct hl_device;
+struct hl_fpriv;
 
 
 /**
@@ -51,6 +54,8 @@ struct hl_device;
  * @max_asid: maximum number of open contexts (ASIDs).
  * @completion_queues_count: number of completion queues.
  * @high_pll: high PLL frequency used by the device.
+ * @cb_pool_cb_cnt: number of CBs in the CB pool.
+ * @cb_pool_cb_size: size of each CB in the CB pool.
  * @tpc_enabled_mask: which TPCs are enabled.
  */
 struct asic_fixed_properties {
@@ -71,11 +76,60 @@ struct asic_fixed_properties {
 	u32			sram_size;
 	u32			max_asid;
 	u32			high_pll;
+	u32			cb_pool_cb_cnt;
+	u32			cb_pool_cb_size;
 	u8			completion_queues_count;
 	u8			tpc_enabled_mask;
 };
 
 
+/*
+ * Command Buffers
+ */
+
+#define HL_MAX_CB_SIZE		0x200000	/* 2MB */
+
+/**
+ * struct hl_cb_mgr - describes a Command Buffer Manager.
+ * @cb_lock: protects cb_handles.
+ * @cb_handles: an idr to hold all command buffer handles.
+ */
+struct hl_cb_mgr {
+	spinlock_t		cb_lock;
+	struct idr		cb_handles; /* protected by cb_lock */
+};
+
+/**
+ * struct hl_cb - describes a Command Buffer.
+ * @refcount: reference counter for usage of the CB.
+ * @hdev: pointer to device this CB belongs to.
+ * @lock: spinlock to protect mmap/cs flows.
+ * @pool_list: node in pool list of command buffers.
+ * @kernel_address: Holds the CB's kernel virtual address.
+ * @bus_address: Holds the CB's DMA address.
+ * @mmap_size: Holds the CB's size that was mmaped.
+ * @size: holds the CB's size.
+ * @id: the CB's ID.
+ * @ctx_id: holds the ID of the owner's context.
+ * @mmap: true if the CB is currently mmaped to user.
+ * @is_pool: true if CB was acquired from the pool, false otherwise.
+ */
+struct hl_cb {
+	struct kref		refcount;
+	struct hl_device	*hdev;
+	spinlock_t		lock;
+	struct list_head	pool_list;
+	u64			kernel_address;
+	dma_addr_t		bus_address;
+	u32			mmap_size;
+	u32			size;
+	u32			id;
+	u32			ctx_id;
+	u8			mmap;
+	u8			is_pool;
+};
+
+
 #define HL_QUEUE_LENGTH			256
 
 
@@ -104,6 +158,8 @@ enum hl_asic_type {
  * @sw_fini: tears down driver state, does not configure H/W.
  * @suspend: handles IP specific H/W or SW changes for suspend.
  * @resume: handles IP specific H/W or SW changes for resume.
+ * @mmap: mmap function, does nothing.
+ * @cb_mmap: maps a CB.
  * @dma_alloc_coherent: Allocate coherent DMA memory by calling
  *                      dma_alloc_coherent(). This is ASIC function because its
  *                      implementation is not trivial when the driver is loaded
@@ -120,6 +176,9 @@ struct hl_asic_funcs {
 	int (*sw_fini)(struct hl_device *hdev);
 	int (*suspend)(struct hl_device *hdev);
 	int (*resume)(struct hl_device *hdev);
+	int (*mmap)(struct hl_fpriv *hpriv, struct vm_area_struct *vma);
+	int (*cb_mmap)(struct hl_device *hdev, struct vm_area_struct *vma,
+			u64 kaddress, phys_addr_t paddress, u32 size);
 	void* (*dma_alloc_coherent)(struct hl_device *hdev, size_t size,
 					dma_addr_t *dma_handle, gfp_t flag);
 	void (*dma_free_coherent)(struct hl_device *hdev, size_t size,
@@ -170,6 +229,7 @@ struct hl_ctx_mgr {
  * @taskpid: current process ID.
  * @ctx: current executing context.
  * @ctx_mgr: context manager to handle multiple context for this FD.
+ * @cb_mgr: command buffer manager to handle multiple buffers for this FD.
  * @refcount: number of related contexts.
  */
 struct hl_fpriv {
@@ -178,6 +238,7 @@ struct hl_fpriv {
 	struct pid		*taskpid;
 	struct hl_ctx		*ctx; /* TODO: remove for multiple ctx */
 	struct hl_ctx_mgr	ctx_mgr;
+	struct hl_cb_mgr	cb_mgr;
 	struct kref		refcount;
 };
 
@@ -232,6 +293,7 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
  * @asic_name: ASIC specific nmae.
  * @asic_type: ASIC specific type.
  * @kernel_ctx: KMD context structure.
+ * @kernel_cb_mgr: command buffer manager for creating/destroying/handling CGs.
  * @dma_pool: DMA pool for small allocations.
  * @cpu_accessible_dma_mem: KMD <-> ArmCP shared memory CPU address.
  * @cpu_accessible_dma_address: KMD <-> ArmCP shared memory DMA address.
@@ -247,6 +309,8 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
  * @asic_prop: ASIC specific immutable properties.
  * @asic_funcs: ASIC specific functions.
  * @asic_specific: ASIC specific information to use only from ASIC files.
+ * @cb_pool: list of preallocated CBs.
+ * @cb_pool_lock: protects the CB pool.
  * @user_ctx: current user context executing.
  * @fd_open_cnt: number of open user processes.
  * @major: habanalabs KMD major.
@@ -262,6 +326,7 @@ struct hl_device {
 	char				asic_name[16];
 	enum hl_asic_type		asic_type;
 	struct hl_ctx			*kernel_ctx;
+	struct hl_cb_mgr		kernel_cb_mgr;
 	struct dma_pool			*dma_pool;
 	void				*cpu_accessible_dma_mem;
 	dma_addr_t			cpu_accessible_dma_address;
@@ -273,6 +338,10 @@ struct hl_device {
 	struct asic_fixed_properties	asic_prop;
 	const struct hl_asic_funcs	*asic_funcs;
 	void				*asic_specific;
+
+	struct list_head		cb_pool;
+	spinlock_t			cb_pool_lock;
+
 	/* TODO: remove user_ctx for multiple process support */
 	struct hl_ctx			*user_ctx;
 	atomic_t			fd_open_cnt;
@@ -341,6 +410,23 @@ int hl_device_resume(struct hl_device *hdev);
 void hl_hpriv_get(struct hl_fpriv *hpriv);
 void hl_hpriv_put(struct hl_fpriv *hpriv);
 
+int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr, u32 cb_size,
+		u64 *handle, int ctx_id);
+int hl_cb_destroy(struct hl_device *hdev, struct hl_cb_mgr *mgr, u64 cb_handle);
+int hl_cb_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma);
+struct hl_cb *hl_cb_get(struct hl_device *hdev,	struct hl_cb_mgr *mgr,
+			u32 handle);
+void hl_cb_put(struct hl_cb *cb);
+void hl_cb_mgr_init(struct hl_cb_mgr *mgr);
+void hl_cb_mgr_fini(struct hl_device *hdev, struct hl_cb_mgr *mgr);
+struct hl_cb *hl_cb_kernel_create(struct hl_device *hdev, u32 cb_size);
+int hl_cb_pool_init(struct hl_device *hdev);
+int hl_cb_pool_fini(struct hl_device *hdev);
+
 void goya_set_asic_funcs(struct hl_device *hdev);
 
+/* IOCTLs */
+long hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
+int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data);
+
 #endif /* HABANALABSP_H_ */
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 8ecb51fbb133..b07979c599e2 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -120,6 +120,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	kref_init(&hpriv->refcount);
 	nonseekable_open(inode, filp);
 
+	hl_cb_mgr_init(&hpriv->cb_mgr);
 	hl_ctx_mgr_init(&hpriv->ctx_mgr);
 
 	rc = hl_ctx_create(hdev, hpriv);
@@ -135,6 +136,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 out_err:
 	filp->private_data = NULL;
 	hl_ctx_mgr_fini(hpriv->hdev, &hpriv->ctx_mgr);
+	hl_cb_mgr_fini(hpriv->hdev, &hpriv->cb_mgr);
 	kfree(hpriv);
 
 close_device:
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
new file mode 100644
index 000000000000..71dd1e760a22
--- /dev/null
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -0,0 +1,99 @@
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
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+#include <linux/cred.h>
+
+#define HL_IOCTL_DEF(ioctl, _func) \
+	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func}
+
+static const struct hl_ioctl_desc hl_ioctls[] = {
+	HL_IOCTL_DEF(HL_IOCTL_CB, hl_cb_ioctl)
+};
+
+#define HL_CORE_IOCTL_COUNT	ARRAY_SIZE(hl_ioctls)
+
+long hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
+{
+	struct hl_fpriv *hpriv = filep->private_data;
+	struct hl_device *hdev = hpriv->hdev;
+	hl_ioctl_t *func;
+	const struct hl_ioctl_desc *ioctl = NULL;
+	unsigned int nr = _IOC_NR(cmd);
+	char stack_kdata[128] = {0};
+	char *kdata = NULL;
+	unsigned int usize, asize;
+	int retcode;
+
+	if ((nr >= HL_COMMAND_START) && (nr < HL_COMMAND_END)) {
+		u32 hl_size;
+
+		ioctl = &hl_ioctls[nr];
+
+		hl_size = _IOC_SIZE(ioctl->cmd);
+		usize = asize = _IOC_SIZE(cmd);
+		if (hl_size > asize)
+			asize = hl_size;
+
+		cmd = ioctl->cmd;
+	} else {
+		dev_err(hdev->dev, "invalid ioctl: pid=%d, nr=0x%02x\n",
+			  task_pid_nr(current), nr);
+		return -ENOTTY;
+	}
+
+	/* Do not trust userspace, use our own definition */
+	func = ioctl->func;
+
+	if (unlikely(!func)) {
+		dev_dbg(hdev->dev, "no function\n");
+		retcode = -ENOTTY;
+		goto out_err;
+	}
+
+	if (cmd & (IOC_IN | IOC_OUT)) {
+		if (asize <= sizeof(stack_kdata)) {
+			kdata = stack_kdata;
+		} else {
+			kdata = kzalloc(asize, GFP_KERNEL);
+			if (!kdata) {
+				retcode = -ENOMEM;
+				goto out_err;
+			}
+		}
+	}
+
+	if (cmd & IOC_IN) {
+		if (copy_from_user(kdata, (void __user *)arg, usize)) {
+			retcode = -EFAULT;
+			goto out_err;
+		}
+	} else if (cmd & IOC_OUT) {
+		memset(kdata, 0, usize);
+	}
+
+	retcode = func(hpriv, kdata);
+
+	if (cmd & IOC_OUT)
+		if (copy_to_user((void __user *)arg, kdata, usize))
+			retcode = -EFAULT;
+
+out_err:
+	if (retcode)
+		dev_dbg(hdev->dev,
+			"error in ioctl: pid=%d, cmd=0x%02x, nr=0x%02x\n",
+			  task_pid_nr(current), cmd, nr);
+
+	if (kdata != stack_kdata)
+		kfree(kdata);
+
+	return retcode;
+}
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index a0ec23adf8f5..a8edfd3e9c95 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -17,4 +17,50 @@
  */
 #define GOYA_KMD_SRAM_RESERVED_SIZE_FROM_START	0x8000	/* 32KB */
 
+/* Opcode to create a new command buffer */
+#define HL_CB_OP_CREATE		0
+/* Opcode to destroy previously created command buffer */
+#define HL_CB_OP_DESTROY	1
+
+struct hl_cb_in {
+	/* Handle of CB or 0 if we want to create one */
+	__u64 cb_handle;
+	/* HL_CB_OP_* */
+	__u32 op;
+	/* Size of CB. Minimum requested size must be PAGE_SIZE */
+	__u32 cb_size;
+	/* Context ID - Currently not in use */
+	__u32 ctx_id;
+	__u32 pad;
+};
+
+struct hl_cb_out {
+	/* Handle of CB */
+	__u64 cb_handle;
+};
+
+union hl_cb_args {
+	struct hl_cb_in in;
+	struct hl_cb_out out;
+};
+
+/*
+ * Command Buffer
+ * - Request a Command Buffer
+ * - Destroy a Command Buffer
+ *
+ * The command buffers are memory blocks that reside in DMA-able address
+ * space and are physically contiguous so they can be accessed by the device
+ * directly. They are allocated using the coherent DMA API.
+ *
+ * When creating a new CB, the IOCTL returns a handle of it, and the user-space
+ * process needs to use that handle to mmap the buffer so it can access them.
+ *
+ */
+#define HL_IOCTL_CB		\
+		_IOWR('H', 0x02, union hl_cb_args)
+
+#define HL_COMMAND_START	0x02
+#define HL_COMMAND_END		0x03
+
 #endif /* HABANALABS_H_ */
-- 
2.17.1

