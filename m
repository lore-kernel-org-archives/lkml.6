Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833FBC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BCF20881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPSvHHtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfA3XK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:10:56 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40060 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfA3XKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:10:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id f188so567716wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 15:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nF88gr+l0rtParSPRFWyoZLP+cwajwXYw1B1MzyciJk=;
        b=pPSvHHtDh/wZQkTlzIteOQyyHCJrsEWwbOgE6Q6aPh/OTQyrMIPTKFQmy7ThbaSCSM
         mvc8lIWx3z1RcoThkcrzyzE0pcPuTWLHtsfh2pHJY89Drv3AM5R83gutim5kekjRP7b3
         eiGdzL1E7s4JZhJebPBeRxXR0B1h1ZJUP4vmH0MRW9moVrjs0muYk7kB5f+NMMNkqRg1
         4qda6kAG3Awu40skv8x2ZWCi7xkUg8zIG53WQ5pPu3j2wJI7xP2mxQ+aRvtOGOoDTstY
         KGVUktYKMJoP+jkFIOx/F/s+UL7vdhvPGOjsIZGOILqs3EKoPpfDq3tr/ae/6jo27Rux
         b/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nF88gr+l0rtParSPRFWyoZLP+cwajwXYw1B1MzyciJk=;
        b=g/CQgn1+VB292uPTLFbatenaklRoE/Q4okQnBjty/8bUcs/lgm7TSBVg7b0Gok8UZ9
         yR3bwRt+ThJ9m/PwGtR13iLKDkLgVR5ovZGJ1kH0TyazpGXUOJXFmpZtYqmO+Mu8r6CY
         WGPquRhuh+iPMkWHKEys1f4SCe6ysBgcko8THrCKlPMlBwOFzfIW5J/+3HMapdob2I6N
         CxbAP3ckAm6HeVVgknRvbPdQlAeznKX1Nw5N5ei2ZDGR9uSEvytDpvNDwoHWBYQVrJKE
         dHs2+YDU4kHo8EtSCJTUtkf4F4rFGQrLCcPeav+ESa0Of43rjLz7n1IiJTq5AJEXgQcD
         TH1g==
X-Gm-Message-State: AJcUukfDiDq/TB4nBJbRJM8lmsFXRQQkwZ1LK7gVr6Y8h/6tjAJG3ts0
        /RNsZVzWj6WiOWoNym8NqjspeGe9
X-Google-Smtp-Source: ALg8bN7zH4HaXlVF5xMsDxaUC2NZFZP4WlYAyvlaq7/7YP4jGrNnsvWJAEQak64IakdbpQ63Zbvyvg==
X-Received: by 2002:a1c:2457:: with SMTP id k84mr26951602wmk.139.1548885992412;
        Wed, 30 Jan 2019 14:06:32 -0800 (PST)
Received: from oded-ubuntu-des.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id b13sm2341349wrn.28.2019.01.30.14.06.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 14:06:31 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, rppt@linux.ibm.com
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v2 04/15] habanalabs: add context and ASID modules
Date:   Thu, 31 Jan 2019 00:06:06 +0200
Message-Id: <20190130220617.4862-5-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190130220617.4862-1-oded.gabbay@gmail.com>
References: <20190130220617.4862-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds two modules - ASID and context.

Each user process that opens a device's file must have at least one
context before it is able to "work" with the device. Each context has its
own device address-space and contains information about its runtime state
(its active command submissions).

To have address-space separation between contexts, each context is assigned
a unique ASID, which stands for "address-space id". Goya supports up to
1024 ASIDs.

Currently, the driver doesn't support multiple contexts. Therefore, the
user doesn't need to actively create a context. A "primary context" is
created automatically when the user opens the device's file.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
Changes in v2:
  - Use fd_open_cnt to identify whether we have an open process on the device
  - Replace /** with /* in all functions
  - Rename device_open mutex to fd_open_cnt_lock
 
 drivers/misc/habanalabs/Makefile         |   2 +-
 drivers/misc/habanalabs/asid.c           |  58 +++++++++
 drivers/misc/habanalabs/context.c        | 155 +++++++++++++++++++++++
 drivers/misc/habanalabs/device.c         |  47 +++++++
 drivers/misc/habanalabs/habanalabs.h     |  71 +++++++++++
 drivers/misc/habanalabs/habanalabs_drv.c |  46 ++++++-
 6 files changed, 376 insertions(+), 3 deletions(-)
 create mode 100644 drivers/misc/habanalabs/asid.c
 create mode 100644 drivers/misc/habanalabs/context.c

diff --git a/drivers/misc/habanalabs/Makefile b/drivers/misc/habanalabs/Makefile
index 64bad3ca21c6..4944d6ccf8fe 100644
--- a/drivers/misc/habanalabs/Makefile
+++ b/drivers/misc/habanalabs/Makefile
@@ -4,7 +4,7 @@
 
 obj-m	:= habanalabs.o
 
-habanalabs-y := habanalabs_drv.o device.o
+habanalabs-y := habanalabs_drv.o device.o context.o asid.o
 
 include $(src)/goya/Makefile
 habanalabs-y += $(HL_GOYA_FILES)
diff --git a/drivers/misc/habanalabs/asid.c b/drivers/misc/habanalabs/asid.c
new file mode 100644
index 000000000000..0ce84c8f5a47
--- /dev/null
+++ b/drivers/misc/habanalabs/asid.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "habanalabs.h"
+
+#include <linux/slab.h>
+#include <linux/types.h>
+
+int hl_asid_init(struct hl_device *hdev)
+{
+	hdev->asid_bitmap = kcalloc(BITS_TO_LONGS(hdev->asic_prop.max_asid),
+					sizeof(*hdev->asid_bitmap), GFP_KERNEL);
+	if (!hdev->asid_bitmap)
+		return -ENOMEM;
+
+	mutex_init(&hdev->asid_mutex);
+
+	/* ASID 0 is reserved for KMD */
+	set_bit(0, hdev->asid_bitmap);
+
+	return 0;
+}
+
+void hl_asid_fini(struct hl_device *hdev)
+{
+	mutex_destroy(&hdev->asid_mutex);
+	kfree(hdev->asid_bitmap);
+}
+
+unsigned long hl_asid_alloc(struct hl_device *hdev)
+{
+	unsigned long found;
+
+	mutex_lock(&hdev->asid_mutex);
+
+	found = find_first_zero_bit(hdev->asid_bitmap,
+					hdev->asic_prop.max_asid);
+	if (found == hdev->asic_prop.max_asid)
+		found = 0;
+	else
+		set_bit(found, hdev->asid_bitmap);
+
+	mutex_unlock(&hdev->asid_mutex);
+
+	return found;
+}
+
+void hl_asid_free(struct hl_device *hdev, unsigned long asid)
+{
+	if (WARN((asid == 0 || asid >= hdev->asic_prop.max_asid),
+						"Invalid ASID %lu", asid))
+		return;
+	clear_bit(asid, hdev->asid_bitmap);
+}
diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
new file mode 100644
index 000000000000..4d46e51e1a82
--- /dev/null
+++ b/drivers/misc/habanalabs/context.c
@@ -0,0 +1,155 @@
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
+#include <linux/delay.h>
+
+static void hl_ctx_fini(struct hl_ctx *ctx)
+{
+	struct hl_device *hdev = ctx->hdev;
+
+	if (ctx->asid != HL_KERNEL_ASID_ID)
+		hl_asid_free(hdev, ctx->asid);
+}
+
+void hl_ctx_do_release(struct kref *ref)
+{
+	struct hl_ctx *ctx;
+
+	ctx = container_of(ref, struct hl_ctx, refcount);
+
+	dev_dbg(ctx->hdev->dev, "Now really releasing context %d\n", ctx->asid);
+
+	hl_ctx_fini(ctx);
+
+	if (ctx->hpriv)
+		hl_hpriv_put(ctx->hpriv);
+
+	kfree(ctx);
+}
+
+int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
+{
+	struct hl_ctx_mgr *mgr = &hpriv->ctx_mgr;
+	struct hl_ctx *ctx;
+	int rc;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		rc = -ENOMEM;
+		goto out_err;
+	}
+
+	rc = hl_ctx_init(hdev, ctx, false);
+	if (rc)
+		goto free_ctx;
+
+	hl_hpriv_get(hpriv);
+	ctx->hpriv = hpriv;
+
+	/* TODO: remove for multiple contexts */
+	hpriv->ctx = ctx;
+	hdev->user_ctx = ctx;
+
+	mutex_lock(&mgr->ctx_lock);
+	rc = idr_alloc(&mgr->ctx_handles, ctx, 1, 0, GFP_KERNEL);
+	mutex_unlock(&mgr->ctx_lock);
+
+	if (rc < 0) {
+		dev_err(hdev->dev, "Failed to allocate IDR for a new CTX\n");
+		hl_ctx_free(hdev, ctx);
+		goto out_err;
+	}
+
+	return 0;
+
+free_ctx:
+	kfree(ctx);
+out_err:
+	return rc;
+}
+
+void hl_ctx_free(struct hl_device *hdev, struct hl_ctx *ctx)
+{
+	if (kref_put(&ctx->refcount, hl_ctx_do_release) == 1)
+		return;
+
+	dev_warn(hdev->dev,
+		"Context %d closed or terminated but its CS are executing\n",
+		ctx->asid);
+}
+
+int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
+{
+	ctx->hdev = hdev;
+
+	kref_init(&ctx->refcount);
+
+	if (is_kernel_ctx) {
+		ctx->asid = HL_KERNEL_ASID_ID; /* KMD gets ASID 0 */
+	} else {
+		ctx->asid = hl_asid_alloc(hdev);
+		if (!ctx->asid) {
+			dev_err(hdev->dev, "No free ASID, failed to create context\n");
+			return -ENOMEM;
+		}
+	}
+
+	dev_dbg(hdev->dev, "Created context with ASID %u\n", ctx->asid);
+
+	return 0;
+}
+
+void hl_ctx_get(struct hl_device *hdev, struct hl_ctx *ctx)
+{
+	kref_get(&ctx->refcount);
+}
+
+int hl_ctx_put(struct hl_ctx *ctx)
+{
+	return kref_put(&ctx->refcount, hl_ctx_do_release);
+}
+
+/*
+ * hl_ctx_mgr_init - initialize the context manager
+ *
+ * @mgr: pointer to context manager structure
+ *
+ * This manager is an object inside the hpriv object of the user process.
+ * The function is called when a user process opens the FD.
+ */
+void hl_ctx_mgr_init(struct hl_ctx_mgr *mgr)
+{
+	mutex_init(&mgr->ctx_lock);
+	idr_init(&mgr->ctx_handles);
+}
+
+/*
+ * hl_ctx_mgr_fini - finalize the context manager
+ *
+ * @hdev: pointer to device structure
+ * @mgr: pointer to context manager structure
+ *
+ * This function goes over all the contexts in the manager and frees them.
+ * It is called when a process closes the FD.
+ */
+void hl_ctx_mgr_fini(struct hl_device *hdev, struct hl_ctx_mgr *mgr)
+{
+	struct hl_ctx *ctx;
+	struct idr *idp;
+	u32 id;
+
+	idp = &mgr->ctx_handles;
+
+	idr_for_each_entry(idp, ctx, id)
+		hl_ctx_free(hdev, ctx);
+
+	idr_destroy(&mgr->ctx_handles);
+	mutex_destroy(&mgr->ctx_lock);
+}
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index d77e070ae389..81acb1de9c7e 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -23,6 +23,12 @@ static void hpriv_release(struct kref *ref)
 	put_pid(hpriv->taskpid);
 
 	kfree(hpriv);
+
+	/* Now the FD is really closed */
+	atomic_dec(&hdev->fd_open_cnt);
+
+	/* This allows a new user context to open the device */
+	hdev->user_ctx = NULL;
 }
 
 void hl_hpriv_get(struct hl_fpriv *hpriv)
@@ -47,6 +53,8 @@ static int hl_device_release(struct inode *inode, struct file *filp)
 {
 	struct hl_fpriv *hpriv = filp->private_data;
 
+	hl_ctx_mgr_fini(hpriv->hdev, &hpriv->ctx_mgr);
+
 	filp->private_data = NULL;
 
 	hl_hpriv_put(hpriv);
@@ -138,7 +146,20 @@ static int device_early_init(struct hl_device *hdev)
 	if (rc)
 		return rc;
 
+	rc = hl_asid_init(hdev);
+	if (rc)
+		goto early_fini;
+
+	mutex_init(&hdev->fd_open_cnt_lock);
+	atomic_set(&hdev->fd_open_cnt, 0);
+
 	return 0;
+
+early_fini:
+	if (hdev->asic_funcs->early_fini)
+		hdev->asic_funcs->early_fini(hdev);
+
+	return rc;
 }
 
 /*
@@ -150,9 +171,12 @@ static int device_early_init(struct hl_device *hdev)
 static void device_early_fini(struct hl_device *hdev)
 {
 
+	hl_asid_fini(hdev);
+
 	if (hdev->asic_funcs->early_fini)
 		hdev->asic_funcs->early_fini(hdev);
 
+	mutex_destroy(&hdev->fd_open_cnt_lock);
 }
 
 /*
@@ -246,11 +270,30 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	if (rc)
 		goto early_fini;
 
+	/* Allocate the kernel context */
+	hdev->kernel_ctx = kzalloc(sizeof(*hdev->kernel_ctx), GFP_KERNEL);
+	if (!hdev->kernel_ctx) {
+		rc = -ENOMEM;
+		goto sw_fini;
+	}
+
+	hdev->user_ctx = NULL;
+
+	rc = hl_ctx_init(hdev, hdev->kernel_ctx, true);
+	if (rc) {
+		dev_err(hdev->dev, "failed to initialize kernel context\n");
+		goto free_ctx;
+	}
+
 	dev_notice(hdev->dev,
 		"Successfully added device to habanalabs driver\n");
 
 	return 0;
 
+free_ctx:
+	kfree(hdev->kernel_ctx);
+sw_fini:
+	hdev->asic_funcs->sw_fini(hdev);
 early_fini:
 	device_early_fini(hdev);
 release_device:
@@ -283,6 +326,10 @@ void hl_device_fini(struct hl_device *hdev)
 	/* Mark device as disabled */
 	hdev->disabled = true;
 
+	/* Release kernel context */
+	if ((hdev->kernel_ctx) && (hl_ctx_put(hdev->kernel_ctx) != 1))
+		dev_err(hdev->dev, "kernel ctx is still alive\n");
+
 	/* Call ASIC S/W finalize function */
 	hdev->asic_funcs->sw_fini(hdev);
 
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 644624fa378b..9f76373b3e2c 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -77,6 +77,8 @@ struct asic_fixed_properties {
 
 
 #define HL_QUEUE_LENGTH			256
+
+
 /*
  * ASICs
  */
@@ -124,6 +126,39 @@ struct hl_asic_funcs {
 					void *cpu_addr, dma_addr_t dma_handle);
 };
 
+
+/*
+ * CONTEXTS
+ */
+
+#define HL_KERNEL_ASID_ID	0
+
+/**
+ * struct hl_ctx - user/kernel context.
+ * @hpriv: pointer to the private (KMD) data of the process (fd).
+ * @hdev: pointer to the device structure.
+ * @refcount: reference counter for the context. Context is released only when
+ *		this hits 0l. It is incremented on CS and CS_WAIT.
+ * @asid: context's unique address space ID in the device's MMU.
+ */
+struct hl_ctx {
+	struct hl_fpriv		*hpriv;
+	struct hl_device	*hdev;
+	struct kref		refcount;
+	u32			asid;
+};
+
+/**
+ * struct hl_ctx_mgr - for handling multiple contexts.
+ * @ctx_lock: protects ctx_handles.
+ * @ctx_handles: idr to hold all ctx handles.
+ */
+struct hl_ctx_mgr {
+	struct mutex		ctx_lock;
+	struct idr		ctx_handles;
+};
+
+
 /*
  * FILE PRIVATE STRUCTURE
  */
@@ -133,12 +168,16 @@ struct hl_asic_funcs {
  * @hdev: habanalabs device structure.
  * @filp: pointer to the given file structure.
  * @taskpid: current process ID.
+ * @ctx: current executing context.
+ * @ctx_mgr: context manager to handle multiple context for this FD.
  * @refcount: number of related contexts.
  */
 struct hl_fpriv {
 	struct hl_device	*hdev;
 	struct file		*filp;
 	struct pid		*taskpid;
+	struct hl_ctx		*ctx; /* TODO: remove for multiple ctx */
+	struct hl_ctx_mgr	ctx_mgr;
 	struct kref		refcount;
 };
 
@@ -192,13 +231,24 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
  * @dev: realted kernel basic device structure.
  * @asic_name: ASIC specific nmae.
  * @asic_type: ASIC specific type.
+ * @kernel_ctx: KMD context structure.
  * @dma_pool: DMA pool for small allocations.
  * @cpu_accessible_dma_mem: KMD <-> ArmCP shared memory CPU address.
  * @cpu_accessible_dma_address: KMD <-> ArmCP shared memory DMA address.
  * @cpu_accessible_dma_pool: KMD <-> ArmCP shared memory pool.
+ * @asid_bitmap: holds used/available ASIDs.
+ * @asid_mutex: protects asid_bitmap.
+ * @fd_open_cnt_lock: lock for updating fd_open_cnt in hl_device_open. Although
+ *                    fd_open_cnt is atomic, we need this lock to serialize
+ *                    the open function because the driver currently supports
+ *                    only a single process at a time. In addition, we need a
+ *                    lock here so we can flush user processes which are opening
+ *                    the device while we are trying to hard reset it
  * @asic_prop: ASIC specific immutable properties.
  * @asic_funcs: ASIC specific functions.
  * @asic_specific: ASIC specific information to use only from ASIC files.
+ * @user_ctx: current user context executing.
+ * @fd_open_cnt: number of open user processes.
  * @major: habanalabs KMD major.
  * @id: device minor.
  * @disabled: is device disabled.
@@ -211,13 +261,21 @@ struct hl_device {
 	struct device			*dev;
 	char				asic_name[16];
 	enum hl_asic_type		asic_type;
+	struct hl_ctx			*kernel_ctx;
 	struct dma_pool			*dma_pool;
 	void				*cpu_accessible_dma_mem;
 	dma_addr_t			cpu_accessible_dma_address;
 	struct gen_pool			*cpu_accessible_dma_pool;
+	unsigned long			*asid_bitmap;
+	struct mutex			asid_mutex;
+	/* TODO: remove fd_open_cnt_lock for multiple process support */
+	struct mutex			fd_open_cnt_lock;
 	struct asic_fixed_properties	asic_prop;
 	const struct hl_asic_funcs	*asic_funcs;
 	void				*asic_specific;
+	/* TODO: remove user_ctx for multiple process support */
+	struct hl_ctx			*user_ctx;
+	atomic_t			fd_open_cnt;
 	u32				major;
 	u16				id;
 	u8				disabled;
@@ -265,10 +323,23 @@ int hl_poll_timeout_memory(struct hl_device *hdev, u64 addr, u32 timeout_us,
 int hl_poll_timeout_device_memory(struct hl_device *hdev, void __iomem *addr,
 				u32 timeout_us, u32 *val);
 
+int hl_asid_init(struct hl_device *hdev);
+void hl_asid_fini(struct hl_device *hdev);
+unsigned long hl_asid_alloc(struct hl_device *hdev);
+void hl_asid_free(struct hl_device *hdev, unsigned long asid);
+
+int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv);
+void hl_ctx_free(struct hl_device *hdev, struct hl_ctx *ctx);
+int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx);
+int hl_ctx_put(struct hl_ctx *ctx);
+void hl_ctx_mgr_init(struct hl_ctx_mgr *mgr);
+void hl_ctx_mgr_fini(struct hl_device *hdev, struct hl_ctx_mgr *mgr);
 int hl_device_init(struct hl_device *hdev, struct class *hclass);
 void hl_device_fini(struct hl_device *hdev);
 int hl_device_suspend(struct hl_device *hdev);
 int hl_device_resume(struct hl_device *hdev);
+void hl_hpriv_get(struct hl_fpriv *hpriv);
+void hl_hpriv_put(struct hl_fpriv *hpriv);
 
 void goya_set_asic_funcs(struct hl_device *hdev);
 
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 1596cf38f6c0..8ecb51fbb133 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -74,6 +74,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 {
 	struct hl_device *hdev;
 	struct hl_fpriv *hpriv;
+	int rc;
 
 	mutex_lock(&hl_devs_idr_lock);
 	hdev = idr_find(&hl_devs_idr, iminor(inode));
@@ -85,9 +86,33 @@ int hl_device_open(struct inode *inode, struct file *filp)
 		return -ENXIO;
 	}
 
+	mutex_lock(&hdev->fd_open_cnt_lock);
+
+	if (hdev->disabled) {
+		dev_err_ratelimited(hdev->dev,
+			"Can't open %s because it is disabled\n",
+			dev_name(hdev->dev));
+		mutex_unlock(&hdev->fd_open_cnt_lock);
+		return -EPERM;
+	}
+
+	if (atomic_read(&hdev->fd_open_cnt)) {
+		dev_info_ratelimited(hdev->dev,
+			"Device %s is already attached to application\n",
+			dev_name(hdev->dev));
+		mutex_unlock(&hdev->fd_open_cnt_lock);
+		return -EBUSY;
+	}
+
+	atomic_inc(&hdev->fd_open_cnt);
+
+	mutex_unlock(&hdev->fd_open_cnt_lock);
+
 	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
-	if (!hpriv)
-		return -ENOMEM;
+	if (!hpriv) {
+		rc = -ENOMEM;
+		goto close_device;
+	}
 
 	hpriv->hdev = hdev;
 	filp->private_data = hpriv;
@@ -95,9 +120,26 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	kref_init(&hpriv->refcount);
 	nonseekable_open(inode, filp);
 
+	hl_ctx_mgr_init(&hpriv->ctx_mgr);
+
+	rc = hl_ctx_create(hdev, hpriv);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to open FD (CTX fail)\n");
+		goto out_err;
+	}
+
 	hpriv->taskpid = find_get_pid(current->pid);
 
 	return 0;
+
+out_err:
+	filp->private_data = NULL;
+	hl_ctx_mgr_fini(hpriv->hdev, &hpriv->ctx_mgr);
+	kfree(hpriv);
+
+close_device:
+	atomic_dec(&hdev->fd_open_cnt);
+	return rc;
 }
 
 /*
-- 
2.17.1

