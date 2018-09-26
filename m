Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0643DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9145F2154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hnrjnkOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9145F2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbeI0FSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:18:33 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:56544 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeI0FSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:18:33 -0400
Received: by mail-pf1-f201.google.com with SMTP id p8-v6so647168pfn.23
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 16:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=z0lg6Fv1h9XcazspLnetYZvop9FkgG15MU+UJq0IVBI=;
        b=hnrjnkOVg0ij8Pvn8rFBUn2en1ZasbkZ38Fpoq2QcXZKI94CVVB4GFWdSIvgr8itWR
         jnIy71EEOyHm9t4BTfEcMxjxo9s4hSh+q3AWUaf3ZOGTkGSQhrvX5o0dzo9OUDtH7orq
         6toUhRY0YnPJgEbNwH8UqsPt2scD8SuG4AUVoZx39vukmjzA8MDMvVZSP5ALdew/rJdB
         YDEhXgCrdLV4jURbxIKnlCmYZQpgYAkrImIRJ6gv0mcsa8lhbpENvB23Kz0vnRcXpRji
         16hO+1kfbDWXJM7ZorQD2fKUdAUcgP6aHnzKTQpY1srLtl5/8BloVos5Iwv2jFIaMEBv
         Nbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=z0lg6Fv1h9XcazspLnetYZvop9FkgG15MU+UJq0IVBI=;
        b=n5TgRZMazYAiM2/iOU9LGF61wJOAsxyKnB6z9/z5t0nkliV+h8jz8UcevzRUEP6SoB
         edaXiJRjVF/0USLKIxiLyCZLcO/HdDoDaG9PGStQo0J0ail61yEDB24s4OqMQ+Udy9uv
         NVPv9zfFNkYHWJUaR1MjFRXTmBr0RLxq6JXJ+cvLcRB/HsfAC8LVyxFJip469gd9hqWz
         uOx5DZ5nI6KLaBbsTThkAOxMwisvSIDbtzVWAFMLyp7GjB5ldxtHxLrtOhjXXDV3YZjL
         1dBk3sy+GSHz222F0auzsjkcfT9g9Evqq6A50qexzbsJPE+/oEjEoSTt90LwTqsxOZmS
         ICEQ==
X-Gm-Message-State: ABuFfoi1fcSjvLqDqPFngsq+anMmGpiELnIDrwDFsa9ElSzxBrx3ELui
        9oHj2MBMWRiZafiMO/UvGMKs550b
X-Google-Smtp-Source: ACcGV60eInQeW6dbL6S31BN/u8k8SS/6fJJAHcCOn7EgR3VfTR2zbOLc6M30/ve8IDb+vkYe+lSnjbdK
X-Received: by 2002:a63:4924:: with SMTP id w36-v6mr675973pga.77.1538002996772;
 Wed, 26 Sep 2018 16:03:16 -0700 (PDT)
Date:   Wed, 26 Sep 2018 16:02:19 -0700
Message-Id: <20180926230222.126513-1-rkir@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v2 06/21] platform: goldfish: pipe: Add DMA support to
 goldfish pipe
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>,
        Lingfeng Yang <lfy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

Goldfish DMA is an extension to the pipe device and is designed
to facilitate high-speed RAM->RAM transfers from guest to host.

See uapi/linux/goldfish/goldfish_dma.h for more details.

Signed-off-by: Roman Kiryanov <rkir@google.com>
Signed-off-by: Lingfeng Yang <lfy@google.com>
---
Changes in v2:
 - Got sign-off from Lingfeng Yang.
 - Removed the license boilerplate from goldfish_dma.h.
 - Rebased.

 drivers/platform/goldfish/goldfish_pipe.c     | 312 +++++++++++++++++-
 .../platform/goldfish/goldfish_pipe_qemu.h    |   2 +
 include/uapi/linux/goldfish/goldfish_dma.h    |  71 ++++
 3 files changed, 383 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/linux/goldfish/goldfish_dma.h

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 56665e879e5a..7eb5436d7c35 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -63,21 +63,28 @@
 #include <linux/mm.h>
 #include <linux/acpi.h>
 #include <linux/bug.h>
+#include <uapi/linux/goldfish/goldfish_dma.h>
 #include "goldfish_pipe_qemu.h"
 
 /*
  * Update this when something changes in the driver's behavior so the host
  * can benefit from knowing it
+ * Notes:
+ *	version 2 was an intermediate release and isn't supported anymore.
+ *	version 3 is goldfish_pipe_v2 without DMA support.
+ *	version 4 (current) is goldfish_pipe_v2 with DMA support.
  */
 enum {
-	PIPE_DRIVER_VERSION = 2,
+	PIPE_DRIVER_VERSION = 4,
 	PIPE_CURRENT_DEVICE_VERSION = 2
 };
 
 enum {
 	MAX_BUFFERS_PER_COMMAND = 336,
 	MAX_SIGNALLED_PIPES = 64,
-	INITIAL_PIPES_CAPACITY = 64
+	INITIAL_PIPES_CAPACITY = 64,
+	DMA_REGION_MIN_SIZE = PAGE_SIZE,
+	DMA_REGION_MAX_SIZE = 256 << 20
 };
 
 struct goldfish_pipe_dev;
@@ -100,6 +107,11 @@ struct goldfish_pipe_command {
 			/* buffer sizes, guest -> host */
 			u32 sizes[MAX_BUFFERS_PER_COMMAND];
 		} rw_params;
+		/* Parameters for PIPE_CMD_DMA_HOST_(UN)MAP */
+		struct {
+			u64 dma_paddr;
+			u64 sz;
+		} dma_maphost_params;
 	};
 };
 
@@ -122,6 +134,24 @@ struct goldfish_pipe_dev_buffers {
 		signalled_pipe_buffers[MAX_SIGNALLED_PIPES];
 };
 
+/*
+ * The main data structure tracking state is
+ * struct goldfish_dma_context, which is included
+ * as an extra pointer field in struct goldfish_pipe.
+ * Each such context is associated with possibly
+ * one physical address and size describing the
+ * allocated DMA region, and only one allocation
+ * is allowed for each pipe fd. Further allocations
+ * require more open()'s of pipe fd's.
+ */
+struct goldfish_dma_context {
+	struct device *pdev_dev;	/* pointer to feed to dma_*_coherent */
+	void *dma_vaddr;		/* kernel vaddr of dma region */
+	size_t dma_size;		/* size of dma region */
+	dma_addr_t phys_begin;		/* paddr of dma region */
+	dma_addr_t phys_end;		/* paddr of dma region + dma_size */
+};
+
 /* This data type models a given pipe instance */
 struct goldfish_pipe {
 	/* pipe ID - index into goldfish_pipe_dev::pipes array */
@@ -162,6 +192,9 @@ struct goldfish_pipe {
 
 	/* A buffer of pages, too large to fit into a stack frame */
 	struct page *pages[MAX_BUFFERS_PER_COMMAND];
+
+	/* Holds information about reserved DMA region for this pipe */
+	struct goldfish_dma_context *dma;
 };
 
 /* The global driver data. Holds a reference to the i/o page used to
@@ -208,6 +241,9 @@ struct goldfish_pipe_dev {
 	int irq;
 	int version;
 	unsigned char __iomem *base;
+
+	/* DMA info */
+	size_t dma_alloc_total;
 };
 
 static struct goldfish_pipe_dev goldfish_pipe_dev;
@@ -739,6 +775,8 @@ static int goldfish_pipe_open(struct inode *inode, struct file *file)
 	spin_unlock_irqrestore(&dev->lock, flags);
 	if (status < 0)
 		goto err_cmd;
+	pipe->dma = NULL;
+
 	/* All is done, save the pipe into the file's private data field */
 	file->private_data = pipe;
 	return 0;
@@ -754,6 +792,40 @@ static int goldfish_pipe_open(struct inode *inode, struct file *file)
 	return status;
 }
 
+static void goldfish_pipe_dma_release_host(struct goldfish_pipe *pipe)
+{
+	struct goldfish_dma_context *dma = pipe->dma;
+	struct device *pdev_dev;
+
+	if (!dma)
+		return;
+
+	pdev_dev = pipe->dev->pdev_dev;
+
+	if (dma->dma_vaddr) {
+		pipe->command_buffer->dma_maphost_params.dma_paddr =
+			dma->phys_begin;
+		pipe->command_buffer->dma_maphost_params.sz = dma->dma_size;
+		goldfish_pipe_cmd(pipe, PIPE_CMD_DMA_HOST_UNMAP);
+	}
+}
+
+static void goldfish_pipe_dma_release_guest(struct goldfish_pipe *pipe)
+{
+	struct goldfish_dma_context *dma = pipe->dma;
+
+	if (!dma)
+		return;
+
+	if (dma->dma_vaddr) {
+		dma_free_coherent(dma->pdev_dev,
+				  dma->dma_size,
+				  dma->dma_vaddr,
+				  dma->phys_begin);
+		pipe->dev->dma_alloc_total -= dma->dma_size;
+	}
+}
+
 static int goldfish_pipe_release(struct inode *inode, struct file *filp)
 {
 	unsigned long flags;
@@ -761,6 +833,7 @@ static int goldfish_pipe_release(struct inode *inode, struct file *filp)
 	struct goldfish_pipe_dev *dev = pipe->dev;
 
 	/* The guest is closing the channel, so tell the emulator right now */
+	goldfish_pipe_dma_release_host(pipe);
 	goldfish_pipe_cmd(pipe, PIPE_CMD_CLOSE);
 
 	spin_lock_irqsave(&dev->lock, flags);
@@ -769,11 +842,242 @@ static int goldfish_pipe_release(struct inode *inode, struct file *filp)
 	spin_unlock_irqrestore(&dev->lock, flags);
 
 	filp->private_data = NULL;
+
+	/* Even if a fd is duped or involved in a forked process,
+	 * open/release methods are called only once, ever.
+	 * This makes goldfish_pipe_release a safe point
+	 * to delete the DMA region.
+	 */
+	goldfish_pipe_dma_release_guest(pipe);
+
+	kfree(pipe->dma);
 	free_page((unsigned long)pipe->command_buffer);
 	kfree(pipe);
+
 	return 0;
 }
 
+/* VMA open/close are for debugging purposes only.
+ * One might think that fork() (and thus pure calls to open())
+ * will require some sort of bookkeeping or refcounting
+ * for dma contexts (incl. when to call dma_free_coherent),
+ * but |vm_private_data| field and |vma_open/close| are only
+ * for situations where the driver needs to interact with vma's
+ * directly with its own per-VMA data structure (which does
+ * need to be refcounted).
+ *
+ * Here, we just use the kernel's existing
+ * VMA processing; we don't do anything on our own.
+ * The only reason we would want to do so is if we had to do
+ * special processing for the virtual (not physical) memory
+ * already associated with DMA memory; it is much less related
+ * to the task of knowing when to alloc/dealloc DMA memory.
+ */
+static void goldfish_dma_vma_open(struct vm_area_struct *vma)
+{
+	/* Not used */
+}
+
+static void goldfish_dma_vma_close(struct vm_area_struct *vma)
+{
+	/* Not used */
+}
+
+static const struct vm_operations_struct goldfish_dma_vm_ops = {
+	.open = goldfish_dma_vma_open,
+	.close = goldfish_dma_vma_close,
+};
+
+static bool is_page_size_multiple(unsigned long sz)
+{
+	return !(sz & (PAGE_SIZE - 1));
+}
+
+static bool check_region_size_valid(size_t size)
+{
+	if (size < DMA_REGION_MIN_SIZE)
+		return false;
+
+	if (size > DMA_REGION_MAX_SIZE)
+		return false;
+
+	return is_page_size_multiple(size);
+}
+
+static int goldfish_pipe_dma_alloc_locked(struct goldfish_pipe *pipe)
+{
+	struct goldfish_dma_context *dma = pipe->dma;
+
+	if (dma->dma_vaddr)
+		return 0;
+
+	dma->phys_begin = 0;
+	dma->dma_vaddr = dma_alloc_coherent(dma->pdev_dev,
+					    dma->dma_size,
+					    &dma->phys_begin,
+					    GFP_KERNEL);
+	if (!dma->dma_vaddr)
+		return -ENOMEM;
+	dma->phys_end = dma->phys_begin + dma->dma_size;
+	pipe->dev->dma_alloc_total += dma->dma_size;
+	pipe->command_buffer->dma_maphost_params.dma_paddr = dma->phys_begin;
+	pipe->command_buffer->dma_maphost_params.sz = dma->dma_size;
+	return goldfish_pipe_cmd_locked(pipe, PIPE_CMD_DMA_HOST_MAP);
+}
+
+static int goldfish_dma_mmap_locked(struct goldfish_pipe *pipe,
+				    struct vm_area_struct *vma)
+{
+	struct goldfish_dma_context *dma = pipe->dma;
+	struct device *pdev_dev = pipe->dev->pdev_dev;
+	size_t sz_requested = vma->vm_end - vma->vm_start;
+	int status;
+
+	if (!check_region_size_valid(sz_requested)) {
+		dev_err(pdev_dev, "%s: bad size (%zu) requested\n", __func__,
+			sz_requested);
+		return -EINVAL;
+	}
+
+	/* Alloc phys region if not allocated already. */
+	status = goldfish_pipe_dma_alloc_locked(pipe);
+	if (status)
+		return status;
+
+	status = remap_pfn_range(vma,
+				 vma->vm_start,
+				 dma->phys_begin >> PAGE_SHIFT,
+				 sz_requested,
+				 vma->vm_page_prot);
+	if (status < 0) {
+		dev_err(pdev_dev, "Cannot remap pfn range....\n");
+		return -EAGAIN;
+	}
+	vma->vm_ops = &goldfish_dma_vm_ops;
+	return 0;
+}
+
+/* When we call mmap() on a pipe fd, we obtain a pointer into
+ * the physically contiguous DMA region of the pipe device
+ * (Goldfish DMA).
+ */
+static int goldfish_dma_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct goldfish_pipe *pipe =
+		(struct goldfish_pipe *)(filp->private_data);
+	int status;
+
+	if (mutex_lock_interruptible(&pipe->lock))
+		return -ERESTARTSYS;
+
+	status = goldfish_dma_mmap_locked(pipe, vma);
+	mutex_unlock(&pipe->lock);
+	return status;
+}
+
+static int goldfish_pipe_dma_create_region(struct goldfish_pipe *pipe,
+					   size_t size)
+{
+	struct goldfish_dma_context *dma =
+		kzalloc(sizeof(struct goldfish_dma_context), GFP_KERNEL);
+	struct device *pdev_dev = pipe->dev->pdev_dev;
+
+	if (dma) {
+		if (mutex_lock_interruptible(&pipe->lock)) {
+			kfree(dma);
+			return -ERESTARTSYS;
+		}
+
+		if (pipe->dma) {
+			mutex_unlock(&pipe->lock);
+			kfree(dma);
+			dev_err(pdev_dev, "The DMA region already allocated\n");
+			return -EBUSY;
+		}
+
+		dma->dma_size = size;
+		dma->pdev_dev = pipe->dev->pdev_dev;
+		pipe->dma = dma;
+		mutex_unlock(&pipe->lock);
+		return 0;
+	}
+
+	dev_err(pdev_dev, "Could not allocate DMA context info!\n");
+	return -ENOMEM;
+}
+
+static long goldfish_dma_ioctl_getoff(struct goldfish_pipe *pipe,
+				      unsigned long arg)
+{
+	struct device *pdev_dev = pipe->dev->pdev_dev;
+	struct goldfish_dma_ioctl_info ioctl_data;
+	struct goldfish_dma_context *dma;
+
+	BUILD_BUG_ON(FIELD_SIZEOF(struct goldfish_dma_ioctl_info, phys_begin) <
+		FIELD_SIZEOF(struct goldfish_dma_context, phys_begin));
+
+	if (mutex_lock_interruptible(&pipe->lock)) {
+		dev_err(pdev_dev, "DMA_GETOFF: the pipe is not locked\n");
+		return -EACCES;
+	}
+
+	dma = pipe->dma;
+	if (dma) {
+		ioctl_data.phys_begin = dma->phys_begin;
+		ioctl_data.size = dma->dma_size;
+	} else {
+		ioctl_data.phys_begin = 0;
+		ioctl_data.size = 0;
+	}
+
+	if (copy_to_user((void __user *)arg, &ioctl_data,
+			 sizeof(ioctl_data))) {
+		mutex_unlock(&pipe->lock);
+		return -EFAULT;
+	}
+
+	mutex_unlock(&pipe->lock);
+	return 0;
+}
+
+static long goldfish_dma_ioctl_create_region(struct goldfish_pipe *pipe,
+					     unsigned long arg)
+{
+	struct goldfish_dma_ioctl_info ioctl_data;
+
+	if (copy_from_user(&ioctl_data, (void __user *)arg, sizeof(ioctl_data)))
+		return -EFAULT;
+
+	if (!check_region_size_valid(ioctl_data.size)) {
+		dev_err(pipe->dev->pdev_dev,
+			"DMA_CREATE_REGION: bad size (%lld) requested\n",
+			ioctl_data.size);
+		return -EINVAL;
+	}
+
+	return goldfish_pipe_dma_create_region(pipe, ioctl_data.size);
+}
+
+static long goldfish_dma_ioctl(struct file *file, unsigned int cmd,
+			       unsigned long arg)
+{
+	struct goldfish_pipe *pipe =
+		(struct goldfish_pipe *)(file->private_data);
+
+	switch (cmd) {
+	case GOLDFISH_DMA_IOC_LOCK:
+		return 0;
+	case GOLDFISH_DMA_IOC_UNLOCK:
+		wake_up_interruptible(&pipe->wake_queue);
+		return 0;
+	case GOLDFISH_DMA_IOC_GETOFF:
+		return goldfish_dma_ioctl_getoff(pipe, arg);
+	case GOLDFISH_DMA_IOC_CREATE_REGION:
+		return goldfish_dma_ioctl_create_region(pipe, arg);
+	}
+	return -ENOTTY;
+}
+
 static const struct file_operations goldfish_pipe_fops = {
 	.owner = THIS_MODULE,
 	.read = goldfish_pipe_read,
@@ -781,6 +1085,10 @@ static const struct file_operations goldfish_pipe_fops = {
 	.poll = goldfish_pipe_poll,
 	.open = goldfish_pipe_open,
 	.release = goldfish_pipe_release,
+	/* DMA-related operations */
+	.mmap = goldfish_dma_mmap,
+	.unlocked_ioctl = goldfish_dma_ioctl,
+	.compat_ioctl = goldfish_dma_ioctl,
 };
 
 static struct miscdevice goldfish_pipe_miscdev = {
diff --git a/drivers/platform/goldfish/goldfish_pipe_qemu.h b/drivers/platform/goldfish/goldfish_pipe_qemu.h
index b4d78c108afd..0ffc51dba54c 100644
--- a/drivers/platform/goldfish/goldfish_pipe_qemu.h
+++ b/drivers/platform/goldfish/goldfish_pipe_qemu.h
@@ -93,6 +93,8 @@ enum PipeCmdCode {
 	 * parallel processing of pipe operations on the host.
 	 */
 	PIPE_CMD_WAKE_ON_DONE_IO,
+	PIPE_CMD_DMA_HOST_MAP,
+	PIPE_CMD_DMA_HOST_UNMAP,
 };
 
 #endif /* GOLDFISH_PIPE_QEMU_H */
diff --git a/include/uapi/linux/goldfish/goldfish_dma.h b/include/uapi/linux/goldfish/goldfish_dma.h
new file mode 100644
index 000000000000..4f6fe0f2511a
--- /dev/null
+++ b/include/uapi/linux/goldfish/goldfish_dma.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef UAPI_GOLDFISH_DMA_H
+#define UAPI_GOLDFISH_DMA_H
+
+#include <linux/types.h>
+
+/* GOLDFISH DMA
+ *
+ * Goldfish DMA is an extension to the pipe device
+ * and is designed to facilitate high-speed RAM->RAM
+ * transfers from guest to host.
+ *
+ * Interface (guest side):
+ *
+ * The guest user calls goldfish_dma_alloc (ioctls)
+ * and then mmap() on a goldfish pipe fd,
+ * which means that it wants high-speed access to
+ * host-visible memory.
+ *
+ * The guest can then write into the pointer
+ * returned by mmap(), and these writes
+ * become immediately visible on the host without BQL
+ * or otherweise context switching.
+ *
+ * dma_alloc_coherent() is used to obtain contiguous
+ * physical memory regions, and we allocate and interact
+ * with this region on both guest and host through
+ * the following ioctls:
+ *
+ * - LOCK: lock the region for data access.
+ * - UNLOCK: unlock the region. This may also be done from the host
+ *   through the WAKE_ON_UNLOCK_DMA procedure.
+ * - CREATE_REGION: initialize size info for a dma region.
+ * - GETOFF: send physical address to guest drivers.
+ * - (UN)MAPHOST: uses goldfish_pipe_cmd to tell the host to
+ * (un)map to the guest physical address associated
+ * with the current dma context. This makes the physically
+ * contiguous memory (in)visible to the host.
+ *
+ * Guest userspace obtains a pointer to the DMA memory
+ * through mmap(), which also lazily allocates the memory
+ * with dma_alloc_coherent. (On last pipe close(), the region is freed).
+ * The mmaped() region can handle very high bandwidth
+ * transfers, and pipe operations can be used at the same
+ * time to handle synchronization and command communication.
+ */
+
+#define GOLDFISH_DMA_BUFFER_SIZE (32 * 1024 * 1024)
+
+struct goldfish_dma_ioctl_info {
+	__u64 phys_begin;
+	__u64 size;
+};
+
+/* There is an ioctl associated with goldfish dma driver.
+ * Make it conflict with ioctls that are not likely to be used
+ * in the emulator.
+ * 'G'	00-3F	drivers/misc/sgi-gru/grulib.h	conflict!
+ * 'G'	00-0F	linux/gigaset_dev.h	conflict!
+ */
+#define GOLDFISH_DMA_IOC_MAGIC	'G'
+#define GOLDFISH_DMA_IOC_OP(OP)	_IOWR(GOLDFISH_DMA_IOC_MAGIC, OP, \
+				struct goldfish_dma_ioctl_info)
+
+#define GOLDFISH_DMA_IOC_LOCK		GOLDFISH_DMA_IOC_OP(0)
+#define GOLDFISH_DMA_IOC_UNLOCK		GOLDFISH_DMA_IOC_OP(1)
+#define GOLDFISH_DMA_IOC_GETOFF		GOLDFISH_DMA_IOC_OP(2)
+#define GOLDFISH_DMA_IOC_CREATE_REGION	GOLDFISH_DMA_IOC_OP(3)
+
+#endif /* UAPI_GOLDFISH_DMA_H */
-- 
2.19.0.605.g01d371f741-goog

