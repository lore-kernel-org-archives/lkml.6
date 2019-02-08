Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438CBC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006F220863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="wEfr+575"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfBHSgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:36:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32931 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbfBHSfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:35:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so2088202pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 10:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eZdcqNuF9VsneBMHtex3y+GRsmEMWM9xN7ESIxmOj+Y=;
        b=wEfr+5750+HxXOh8Ty8i/CDsCmufy/D2mbFHcVzpcqEARQMa0J/QFFHWgJjLl8MtBq
         1L60b8qzEzxHiN9HD/nyicDs/fr+qjnrZ2waR/sX4ds3xUg+mWG62JFErBvX+Lr/ZrKh
         zohZnaTn5nWH7MWAdy3yQQgWfKOyc0q818bKIfgbIVmKEirWQnnAy577WIrC2pYeruPy
         UQnVi93IUl7FiHD5a+CP3THEsE4SZMavmwhx7M1c3oBCW7hnbQraN37VgASA+yd4yYTf
         7FQWZlARis4r7gRmPau+DBogaop7rZaB/Odre5bzBTP1RpmXHs6arQT+NSVmahd4Kxkq
         lM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eZdcqNuF9VsneBMHtex3y+GRsmEMWM9xN7ESIxmOj+Y=;
        b=lR/p8A4boiyB6lC/1k+yB5cwUDRLzOirat8LjLummbOYCtEBjAMUUqz6nRadiY4eLY
         fDzmYiReiqpcSTigT1QUumuvedwDnrvhMd4WtLPdzekI9rFbCSYa5HpqKtQfEuHCcVT6
         LxrCPMDUr6nnZrBQ0NFUbzuuiRp6gjKGFCX9LfYxyFs3kshlzVk3Md9NAIqE0mk8ls9r
         m4Y1qYcTO8HYMKYSkptQlcbSB4yifGAaa+KSHC15/BXhaXDcr4pd37TCYZyGePD8dH9d
         Z7yal5aQCdH573bSLuL43zJNZtoZ5uxj5MDAIhdB8ixJOgyQ3zWNah7MZh4YA0w9MLko
         jvxg==
X-Gm-Message-State: AHQUAuakpEI2TZz6Z195kegoPApSXMXauBu7OnuHTUvfj3d/YrDL/M5W
        6bOhWCIVD2jzxjTmux4oSzcVVg==
X-Google-Smtp-Source: AHgI3IZW9GHEdl5Ycl94iR9BGeGAKRsGkL0jL7Gfkmzmprt8L8otBD/bba+gSkYVLN4PxGFGQkgZPA==
X-Received: by 2002:a63:3703:: with SMTP id e3mr6387979pga.348.1549650945308;
        Fri, 08 Feb 2019 10:35:45 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id 14sm2306472pgq.22.2019.02.08.10.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 10:35:44 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v3 6/7] binder: remove user_buffer_offset
Date:   Fri,  8 Feb 2019 10:35:19 -0800
Message-Id: <20190208183520.30886-7-tkjos@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
In-Reply-To: <20190208183520.30886-1-tkjos@google.com>
References: <20190208183520.30886-1-tkjos@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove user_buffer_offset since there is no kernel
buffer pointer anymore.

Signed-off-by: Todd Kjos <tkjos@google.com>
---
v2: remove casts as suggested by Dan Carpenter

 drivers/android/binder.c       | 39 ++++++----------------------------
 drivers/android/binder_alloc.c | 16 ++++++--------
 drivers/android/binder_alloc.h | 23 --------------------
 3 files changed, 13 insertions(+), 65 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 98163bf5f35c7..b3d609b5935a6 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2380,7 +2380,6 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 			struct binder_fd_array_object *fda;
 			struct binder_buffer_object *parent;
 			struct binder_object ptr_object;
-			uintptr_t parent_buffer;
 			u32 *fd_array;
 			size_t fd_index;
 			binder_size_t fd_buf_size;
@@ -2405,14 +2404,6 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 				       debug_id);
 				continue;
 			}
-			/*
-			 * Since the parent was already fixed up, convert it
-			 * back to kernel address space to access it
-			 */
-			parent_buffer = parent->buffer -
-				binder_alloc_get_user_buffer_offset(
-						&proc->alloc);
-
 			fd_buf_size = sizeof(u32) * fda->num_fds;
 			if (fda->num_fds >= SIZE_MAX / sizeof(u32)) {
 				pr_err("transaction release %d invalid number of fds (%lld)\n",
@@ -2426,7 +2417,8 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 				       debug_id, (u64)fda->num_fds);
 				continue;
 			}
-			fd_array = (u32 *)(parent_buffer + (uintptr_t)fda->parent_offset);
+			fd_array = (u32 *)(uintptr_t)
+				(parent->buffer + fda->parent_offset);
 			for (fd_index = 0; fd_index < fda->num_fds;
 			     fd_index++) {
 				u32 fd;
@@ -2646,7 +2638,6 @@ static int binder_translate_fd_array(struct binder_fd_array_object *fda,
 				     struct binder_transaction *in_reply_to)
 {
 	binder_size_t fdi, fd_buf_size;
-	uintptr_t parent_buffer;
 	u32 *fd_array;
 	struct binder_proc *proc = thread->proc;
 	struct binder_proc *target_proc = t->to_proc;
@@ -2664,13 +2655,7 @@ static int binder_translate_fd_array(struct binder_fd_array_object *fda,
 				  proc->pid, thread->pid, (u64)fda->num_fds);
 		return -EINVAL;
 	}
-	/*
-	 * Since the parent was already fixed up, convert it
-	 * back to the kernel address space to access it
-	 */
-	parent_buffer = parent->buffer -
-		binder_alloc_get_user_buffer_offset(&target_proc->alloc);
-	fd_array = (u32 *)(parent_buffer + (uintptr_t)fda->parent_offset);
+	fd_array = (u32 *)(uintptr_t)(parent->buffer + fda->parent_offset);
 	if (!IS_ALIGNED((unsigned long)fd_array, sizeof(u32))) {
 		binder_user_error("%d:%d parent offset not aligned correctly.\n",
 				  proc->pid, thread->pid);
@@ -2703,7 +2688,6 @@ static int binder_fixup_parent(struct binder_transaction *t,
 			       binder_size_t last_fixup_min_off)
 {
 	struct binder_buffer_object *parent;
-	u8 *parent_buffer;
 	struct binder_buffer *b = t->buffer;
 	struct binder_proc *proc = thread->proc;
 	struct binder_proc *target_proc = t->to_proc;
@@ -2739,11 +2723,8 @@ static int binder_fixup_parent(struct binder_transaction *t,
 				  proc->pid, thread->pid);
 		return -EINVAL;
 	}
-	parent_buffer = (u8 *)((uintptr_t)parent->buffer -
-			binder_alloc_get_user_buffer_offset(
-				&target_proc->alloc));
 	buffer_offset = bp->parent_offset +
-			(uintptr_t)parent_buffer - (uintptr_t)b->data;
+			(uintptr_t)parent->buffer - (uintptr_t)b->data;
 	binder_alloc_copy_to_buffer(&target_proc->alloc, b, buffer_offset,
 				    &bp->buffer, sizeof(bp->buffer));
 
@@ -3159,10 +3140,8 @@ static void binder_transaction(struct binder_proc *proc,
 				    ALIGN(tr->offsets_size, sizeof(void *)) +
 				    ALIGN(extra_buffers_size, sizeof(void *)) -
 				    ALIGN(secctx_sz, sizeof(u64));
-		char *kptr = t->buffer->data + buf_offset;
 
-		t->security_ctx = (uintptr_t)kptr +
-		    binder_alloc_get_user_buffer_offset(&target_proc->alloc);
+		t->security_ctx = (uintptr_t)t->buffer->data + buf_offset;
 		binder_alloc_copy_to_buffer(&target_proc->alloc,
 					    t->buffer, buf_offset,
 					    secctx, secctx_sz);
@@ -3380,9 +3359,7 @@ static void binder_transaction(struct binder_proc *proc,
 				goto err_copy_data_failed;
 			}
 			/* Fixup buffer pointer to target proc address space */
-			bp->buffer = (uintptr_t)sg_bufp +
-				binder_alloc_get_user_buffer_offset(
-						&target_proc->alloc);
+			bp->buffer = (uintptr_t)sg_bufp;
 			sg_bufp += ALIGN(bp->length, sizeof(u64));
 
 			ret = binder_fixup_parent(t, thread, bp,
@@ -4474,9 +4451,7 @@ static int binder_thread_read(struct binder_proc *proc,
 		}
 		trd->data_size = t->buffer->data_size;
 		trd->offsets_size = t->buffer->offsets_size;
-		trd->data.ptr.buffer = (binder_uintptr_t)
-			((uintptr_t)t->buffer->data +
-			binder_alloc_get_user_buffer_offset(&proc->alloc));
+		trd->data.ptr.buffer = (uintptr_t)t->buffer->data;
 		trd->data.ptr.offsets = trd->data.ptr.buffer +
 					ALIGN(t->buffer->data_size,
 					    sizeof(void *));
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index d4cbe4b3947a6..0e7f0aa967c32 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -138,17 +138,17 @@ static struct binder_buffer *binder_alloc_prepare_to_free_locked(
 {
 	struct rb_node *n = alloc->allocated_buffers.rb_node;
 	struct binder_buffer *buffer;
-	void *kern_ptr;
+	void *uptr;
 
-	kern_ptr = (void *)(user_ptr - alloc->user_buffer_offset);
+	uptr = (void *)user_ptr;
 
 	while (n) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
 		BUG_ON(buffer->free);
 
-		if (kern_ptr < buffer->data)
+		if (uptr < buffer->data)
 			n = n->rb_left;
-		else if (kern_ptr > buffer->data)
+		else if (uptr > buffer->data)
 			n = n->rb_right;
 		else {
 			/*
@@ -265,8 +265,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 		page->alloc = alloc;
 		INIT_LIST_HEAD(&page->lru);
 
-		user_page_addr =
-			(uintptr_t)page_addr + alloc->user_buffer_offset;
+		user_page_addr = (uintptr_t)page_addr;
 		ret = vm_insert_page(vma, user_page_addr, page[0].page_ptr);
 		if (ret) {
 			pr_err("%d: binder_alloc_buf failed to map page at %lx in userspace\n",
@@ -694,7 +693,6 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	}
 
 	alloc->buffer = (void *)vma->vm_start;
-	alloc->user_buffer_offset = 0;
 	mutex_unlock(&binder_alloc_mmap_lock);
 
 	alloc->pages = kcalloc((vma->vm_end - vma->vm_start) / PAGE_SIZE,
@@ -941,9 +939,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	if (vma) {
 		trace_binder_unmap_user_start(alloc, index);
 
-		zap_page_range(vma,
-			       page_addr + alloc->user_buffer_offset,
-			       PAGE_SIZE);
+		zap_page_range(vma, page_addr, PAGE_SIZE);
 
 		trace_binder_unmap_user_end(alloc, index);
 
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 9d682b9d6c241..1026e9fb20db1 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -82,7 +82,6 @@ struct binder_lru_page {
  *                      (invariant after init)
  * @vma_vm_mm:          copy of vma->vm_mm (invarient after mmap)
  * @buffer:             base of per-proc address space mapped via mmap
- * @user_buffer_offset: offset between user and kernel VAs for buffer
  * @buffers:            list of all buffers for this proc
  * @free_buffers:       rb tree of buffers available for allocation
  *                      sorted by size
@@ -104,7 +103,6 @@ struct binder_alloc {
 	struct vm_area_struct *vma;
 	struct mm_struct *vma_vm_mm;
 	void *buffer;
-	ptrdiff_t user_buffer_offset;
 	struct list_head buffers;
 	struct rb_root free_buffers;
 	struct rb_root allocated_buffers;
@@ -163,27 +161,6 @@ binder_alloc_get_free_async_space(struct binder_alloc *alloc)
 	return free_async_space;
 }
 
-/**
- * binder_alloc_get_user_buffer_offset() - get offset between kernel/user addrs
- * @alloc:	binder_alloc for this proc
- *
- * Return:	the offset between kernel and user-space addresses to use for
- * virtual address conversion
- */
-static inline ptrdiff_t
-binder_alloc_get_user_buffer_offset(struct binder_alloc *alloc)
-{
-	/*
-	 * user_buffer_offset is constant if vma is set and
-	 * undefined if vma is not set. It is possible to
-	 * get here with !alloc->vma if the target process
-	 * is dying while a transaction is being initiated.
-	 * Returning the old value is ok in this case and
-	 * the transaction will fail.
-	 */
-	return alloc->user_buffer_offset;
-}
-
 unsigned long
 binder_alloc_copy_user_to_buffer(struct binder_alloc *alloc,
 				 struct binder_buffer *buffer,
-- 
2.20.1.791.gb4d0f1c61a-goog

