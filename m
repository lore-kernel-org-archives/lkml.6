Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9692CC282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA2920870
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="aFwqEivi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfA2AuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:50:10 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32898 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfA2AuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 19:50:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so8845121pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 16:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mwJFsPrQ8Tfx+sEMp0LbDaSQGrC/2Igxr0RHoK8xdGw=;
        b=aFwqEivizdFPYkqaMHgLoQSa47WxQeJUmM7Gzv9X2xfAUPf3aGG11ZKUOWs44WnPXH
         0Y2PsY3VadpQCsEaavk3buTfqzXZACuKr5r8wfF4cKXEn5misEa8Krdob0eiw1md/Jji
         ZoTuNHgDVkC2sWE9Y6mkBf7tlFI/28N4t09oPQFGjF67Fs0WKeNnpDvIQD7/4EMdmf3W
         YNu5CorybcRbSmn89oDweqkQDDCKACC8e8yvGuHERIwty++iGc0SHVb0UnhZgVHCaaXQ
         aQjXmDRvnfBv6IuPc3OoUEv9vakV22bcII4KKO7GtoWaH22Dtbpwbk88LNEsp15gV7Y6
         2Wew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mwJFsPrQ8Tfx+sEMp0LbDaSQGrC/2Igxr0RHoK8xdGw=;
        b=TxkxxuFGhuBUnc7d1/MugOhoNq47/fo27Osylof2FkKm5DVAN0AS6KKJuPb7eR0gQi
         ZO5eW8c8/kc4+MWCWr5G1ScZWB0Tty78qOROI+cx/uCbSjOMr3uh5zn/y6mfqBd0DdsI
         +YB2SyoRZaMcthqZW0iEEJlT5lo+aygi3xM02iaAERVYSCYCjH/yqiz6+AIsSHoMrmCi
         Rfa1qE1/3FZMYAE6p9L2UBUbD83bTOln5kUK5ZkQ7lxGBbacM+diA7gJbNtUMZquE7br
         ip8j7FsymoROPuQoqrvBLL5eEn59KVKuOXTX6eJyT+dYPCOTGuMvRJwKdgl/xUTame8p
         jUag==
X-Gm-Message-State: AJcUukcS0yluz9GmDoRPk+ct+V8kPQH8cg2mZ8O6jfonRK8rchla43cs
        L4nZFUxK9bqBhTtvKqaC2PtX6Q==
X-Google-Smtp-Source: ALg8bN7fkGUTycEU9ME1H0yiVPMkoXP7kBL9yALgi2tHl/bfYV0SqeW9czUv3KlxeOdwkPvKMIYPSw==
X-Received: by 2002:a63:e344:: with SMTP id o4mr21486149pgj.158.1548723008328;
        Mon, 28 Jan 2019 16:50:08 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id g3sm52090792pfe.37.2019.01.28.16.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 16:50:07 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH 1/7] binder: create userspace-to-binder-buffer copy function
Date:   Mon, 28 Jan 2019 16:49:28 -0800
Message-Id: <20190129004934.85885-2-tkjos@google.com>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190129004934.85885-1-tkjos@google.com>
References: <20190129004934.85885-1-tkjos@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binder driver uses a vm_area to map the per-process
binder buffer space. For 32-bit android devices, this is
now taking too much vmalloc space. This patch removes
the use of vm_area when copying the transaction data
from the sender to the buffer space. Instead of using
copy_from_user() for multi-page copies, it now uses
binder_alloc_copy_user_to_buffer() which uses kmap()
and kunmap() to map each page, and uses copy_from_user()
for copying to that page.

Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder.c       |  29 +++++++--
 drivers/android/binder_alloc.c | 114 +++++++++++++++++++++++++++++++++
 drivers/android/binder_alloc.h |   8 +++
 3 files changed, 144 insertions(+), 7 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 5f6ef5e63b91e..ab0b3eec363bc 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3078,8 +3078,12 @@ static void binder_transaction(struct binder_proc *proc,
 				      ALIGN(tr->data_size, sizeof(void *)));
 	offp = off_start;
 
-	if (copy_from_user(t->buffer->data, (const void __user *)(uintptr_t)
-			   tr->data.ptr.buffer, tr->data_size)) {
+	if (binder_alloc_copy_user_to_buffer(
+				&target_proc->alloc,
+				t->buffer, 0,
+				(const void __user *)
+					(uintptr_t)tr->data.ptr.buffer,
+				tr->data_size)) {
 		binder_user_error("%d:%d got transaction with invalid data ptr\n",
 				proc->pid, thread->pid);
 		return_error = BR_FAILED_REPLY;
@@ -3087,8 +3091,13 @@ static void binder_transaction(struct binder_proc *proc,
 		return_error_line = __LINE__;
 		goto err_copy_data_failed;
 	}
-	if (copy_from_user(offp, (const void __user *)(uintptr_t)
-			   tr->data.ptr.offsets, tr->offsets_size)) {
+	if (binder_alloc_copy_user_to_buffer(
+				&target_proc->alloc,
+				t->buffer,
+				ALIGN(tr->data_size, sizeof(void *)),
+				(const void __user *)
+					(uintptr_t)tr->data.ptr.offsets,
+				tr->offsets_size)) {
 		binder_user_error("%d:%d got transaction with invalid offsets ptr\n",
 				proc->pid, thread->pid);
 		return_error = BR_FAILED_REPLY;
@@ -3217,6 +3226,8 @@ static void binder_transaction(struct binder_proc *proc,
 			struct binder_buffer_object *bp =
 				to_binder_buffer_object(hdr);
 			size_t buf_left = sg_buf_end - sg_bufp;
+			binder_size_t sg_buf_offset = (uintptr_t)sg_bufp -
+				(uintptr_t)t->buffer->data;
 
 			if (bp->length > buf_left) {
 				binder_user_error("%d:%d got transaction with too large buffer\n",
@@ -3226,9 +3237,13 @@ static void binder_transaction(struct binder_proc *proc,
 				return_error_line = __LINE__;
 				goto err_bad_offset;
 			}
-			if (copy_from_user(sg_bufp,
-					   (const void __user *)(uintptr_t)
-					   bp->buffer, bp->length)) {
+			if (binder_alloc_copy_user_to_buffer(
+						&target_proc->alloc,
+						t->buffer,
+						sg_buf_offset,
+						(const void __user *)
+							(uintptr_t)bp->buffer,
+						bp->length)) {
 				binder_user_error("%d:%d got transaction with invalid offsets ptr\n",
 						  proc->pid, thread->pid);
 				return_error_param = -EFAULT;
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 022cd80e80cc3..255fa71911e5e 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -29,6 +29,8 @@
 #include <linux/list_lru.h>
 #include <linux/ratelimit.h>
 #include <asm/cacheflush.h>
+#include <linux/uaccess.h>
+#include <linux/highmem.h>
 #include "binder_alloc.h"
 #include "binder_trace.h"
 
@@ -1053,3 +1055,115 @@ int binder_alloc_shrinker_init(void)
 	}
 	return ret;
 }
+
+/**
+ * check_buffer() - verify that buffer/offset is safe to access
+ * @alloc: binder_alloc for this proc
+ * @buffer: binder buffer to be accessed
+ * @offset: offset into @buffer data
+ * @bytes: bytes to access from offset
+ *
+ * Check that the @offset/@bytes are within the size of the given
+ * @buffer and that the buffer is currently active and not freeable.
+ * Offsets must also be multiples of sizeof(u32). The kernel is
+ * allowed to touch the buffer in two cases:
+ *
+ * 1) when the buffer is being created:
+ *     (buffer->free == 0 && buffer->allow_user_free == 0)
+ * 2) when the buffer is being torn down:
+ *     (buffer->free == 0 && buffer->transaction == NULL).
+ *
+ * Return: true if the buffer is safe to access
+ */
+static inline bool check_buffer(struct binder_alloc *alloc,
+				struct binder_buffer *buffer,
+				binder_size_t offset, size_t bytes)
+{
+	size_t buffer_size = binder_alloc_buffer_size(alloc, buffer);
+
+	return buffer_size >= bytes &&
+		offset <= buffer_size - bytes &&
+		IS_ALIGNED(offset, sizeof(u32)) &&
+		!buffer->free &&
+		(!buffer->allow_user_free || !buffer->transaction);
+}
+
+/**
+ * binder_alloc_get_page() - get kernel pointer for given buffer offset
+ * @alloc: binder_alloc for this proc
+ * @buffer: binder buffer to be accessed
+ * @buffer_offset: offset into @buffer data
+ * @pgoffp: address to copy final page offset to
+ *
+ * Lookup the struct page corresponding to the address
+ * at @buffer_offset into @buffer->data. If @pgoffp is not
+ * NULL, the byte-offset into the page is written there.
+ *
+ * The caller is responsible to ensure that the offset points
+ * to a valid address within the @buffer and that @buffer is
+ * not freeable by the user. Since it can't be freed, we are
+ * guaranteed that the corresponding elements of @alloc->pages[]
+ * cannot change.
+ *
+ * Return: struct page
+ */
+static struct page *binder_alloc_get_page(struct binder_alloc *alloc,
+					  struct binder_buffer *buffer,
+					  binder_size_t buffer_offset,
+					  pgoff_t *pgoffp)
+{
+	binder_size_t buffer_space_offset = buffer_offset +
+		((uintptr_t)buffer->data - (uintptr_t)alloc->buffer);
+	pgoff_t pgoff = buffer_space_offset & ~PAGE_MASK;
+	size_t index = buffer_space_offset >> PAGE_SHIFT;
+	struct binder_lru_page *lru_page;
+
+	lru_page = &alloc->pages[index];
+	*pgoffp = pgoff;
+	return lru_page->page_ptr;
+}
+
+/**
+ * binder_alloc_copy_user_to_buffer() - copy src user to tgt user
+ * @alloc: binder_alloc for this proc
+ * @buffer: binder buffer to be accessed
+ * @buffer_offset: offset into @buffer data
+ * @from: userspace pointer to source buffer
+ * @bytes: bytes to copy
+ *
+ * Copy bytes from source userspace to target buffer.
+ *
+ * Return: bytes remaining to be copied
+ */
+unsigned long
+binder_alloc_copy_user_to_buffer(struct binder_alloc *alloc,
+				 struct binder_buffer *buffer,
+				 binder_size_t buffer_offset,
+				 const void __user *from,
+				 size_t bytes)
+{
+	if (!check_buffer(alloc, buffer, buffer_offset, bytes))
+		return bytes;
+
+	while (bytes) {
+		unsigned long size;
+		unsigned long ret;
+		struct page *page;
+		pgoff_t pgoff;
+		void *kptr;
+
+		page = binder_alloc_get_page(alloc, buffer,
+					     buffer_offset, &pgoff);
+		size = min(bytes, (size_t)(PAGE_SIZE - pgoff));
+		kptr = (void *)((uintptr_t)kmap(page) + pgoff);
+		ret = copy_from_user(kptr, (const void __user *)(uintptr_t)from,
+				     size);
+		kunmap(page);
+		if (ret)
+			return bytes - size + ret;
+		bytes -= size;
+		from = (void __user *)(uintptr_t)from + size;
+		buffer_offset += size;
+	}
+	return 0;
+}
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index c0aadbbf7f193..995155f31dbd4 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -22,6 +22,7 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/list_lru.h>
+#include <uapi/linux/android/binder.h>
 
 extern struct list_lru binder_alloc_lru;
 struct binder_transaction;
@@ -183,5 +184,12 @@ binder_alloc_get_user_buffer_offset(struct binder_alloc *alloc)
 	return alloc->user_buffer_offset;
 }
 
+unsigned long
+binder_alloc_copy_user_to_buffer(struct binder_alloc *alloc,
+				 struct binder_buffer *buffer,
+				 binder_size_t buffer_offset,
+				 const void __user *from,
+				 size_t bytes);
+
 #endif /* _LINUX_BINDER_ALLOC_H */
 
-- 
2.20.1.495.gaa96b0ce6b-goog

