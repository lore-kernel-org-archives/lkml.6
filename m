Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E65C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19B520870
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="MfMmGDmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfA2AuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:50:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34170 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfA2AuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 19:50:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so8839137pfg.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 16:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HW6vfZb9HKOhB/thNHF7wYWR0nnjHTqYCVWDeFK8H3k=;
        b=MfMmGDmS9XTiuCqBWjvdrwQQ1mK3gpOssYsyrNnHLzq0Ex1Dg9ZKEPEcTRDVHu2d/M
         OKeF92ePLrftmKO48Npcorl61UcGptV74RRZdTadwVMgqQO5OE1yMBzhS0lMjygjtwEu
         wmYHArTDkceFT3+Azz/VjlA9ZXkR4/esO7/bzfWFohQFjaqVCoKXa/y9u4yNwKOwauc+
         QBaIj+TsTiR0n8jkst48uDNFUsPBXGj5UnN7jmZI5i7H/ttgxntRC/0hmZrCc6LrqpDI
         +Q52+BAcvrJPYT34rbTzitjEbV75poOW9y4SVukPLwEMjNxntPGJ3ncbOyXlgSy5iyuE
         FA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HW6vfZb9HKOhB/thNHF7wYWR0nnjHTqYCVWDeFK8H3k=;
        b=ShB+Pz2gdOiGJZyp5E+/b/L5FSb0IbllCSYn2qYWXNLG9So0548fAwlDeZh0/1KPDa
         FeukhsEeEQGU2QLCQngdHwM+Aw7TL7KLyLjx1u4lDUakr671CQB6iusougb2LZfqwCsn
         +3+/ePUoGSWnhdSA4J3XuROi7aTpKXBup9Z9BQipim27+C0c8vcI1PdywRvzak5rX02K
         s1Gud/PIY1tC/CbImpAWohVCw7qcCM/TlF/lpyh5mlG8YHA89r0yZD6Bc1qD6xcJT8ob
         Qiq+tE7784c2G9Ur51Y0GhVsfNcpHaGpcCNnvNZ6giyeIvzc5bMSREUVw00F1VpbZVJ7
         +5Aw==
X-Gm-Message-State: AJcUuke+PCug3LLsuZzBM4Uu80qMP5ddONUzVuNGAyR3yjlmNH4kANYw
        r3JR9SPuwFyz4xbrPJEfrMnUog==
X-Google-Smtp-Source: ALg8bN54K6NV/3VZZxOj2jsTS3E07Y5Y1SZ2l5euwSIOdjMeFcx7Cy84K2EAASsNl+FZew95jytHdw==
X-Received: by 2002:a62:d448:: with SMTP id u8mr23944943pfl.105.1548723009680;
        Mon, 28 Jan 2019 16:50:09 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id g3sm52090792pfe.37.2019.01.28.16.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 16:50:08 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH 2/7] binder: add functions to copy to/from binder buffers
Date:   Mon, 28 Jan 2019 16:49:29 -0800
Message-Id: <20190129004934.85885-3-tkjos@google.com>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190129004934.85885-1-tkjos@google.com>
References: <20190129004934.85885-1-tkjos@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid vm_area when copying to or from binder buffers.
Instead, new copy functions are added that copy from
kernel space to binder buffer space. These use
kmap_atomic() and kunmap_atomic() to create temporary
mappings and then memcpy() is used to copy within
that page.

Also, kmap_atomic() / kunmap_atomic() use the appropriate
cache flushing to support VIVT cache architectures.
Allow binder to build if CPU_CACHE_VIVT is defined.

Several uses of the new functions are added here. More
to follow in subsequent patches.

Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/Kconfig        |   2 +-
 drivers/android/binder.c       | 119 +++++++++++++++++++++------------
 drivers/android/binder_alloc.c |  59 ++++++++++++++++
 drivers/android/binder_alloc.h |  12 ++++
 4 files changed, 147 insertions(+), 45 deletions(-)

diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
index 4c190f8d1f4c6..6fdf2abe4598a 100644
--- a/drivers/android/Kconfig
+++ b/drivers/android/Kconfig
@@ -10,7 +10,7 @@ if ANDROID
 
 config ANDROID_BINDER_IPC
 	bool "Android Binder IPC Driver"
-	depends on MMU && !CPU_CACHE_VIVT
+	depends on MMU
 	default n
 	---help---
 	  Binder is used in Android for both communication between processes,
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index ab0b3eec363bc..74d0c1ff874e2 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2244,14 +2244,22 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 		off_end = (void *)off_start + buffer->offsets_size;
 	for (offp = off_start; offp < off_end; offp++) {
 		struct binder_object_header *hdr;
-		size_t object_size = binder_validate_object(buffer, *offp);
-
+		size_t object_size;
+		binder_size_t object_offset;
+		binder_size_t buffer_offset = (uintptr_t)offp -
+			(uintptr_t)buffer->data;
+
+		binder_alloc_copy_from_buffer(&proc->alloc, &object_offset,
+					      buffer, buffer_offset,
+					      sizeof(object_offset));
+		object_size = binder_validate_object(buffer, object_offset);
 		if (object_size == 0) {
 			pr_err("transaction release %d bad object at offset %lld, size %zd\n",
-			       debug_id, (u64)*offp, buffer->data_size);
+			       debug_id, (u64)object_offset, buffer->data_size);
 			continue;
 		}
-		hdr = (struct binder_object_header *)(buffer->data + *offp);
+		hdr = (struct binder_object_header *)
+			(buffer->data + object_offset);
 		switch (hdr->type) {
 		case BINDER_TYPE_BINDER:
 		case BINDER_TYPE_WEAK_BINDER: {
@@ -2359,8 +2367,20 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 				continue;
 			}
 			fd_array = (u32 *)(parent_buffer + (uintptr_t)fda->parent_offset);
-			for (fd_index = 0; fd_index < fda->num_fds; fd_index++)
-				binder_deferred_fd_close(fd_array[fd_index]);
+			for (fd_index = 0; fd_index < fda->num_fds;
+			     fd_index++) {
+				u32 fd;
+				binder_size_t offset =
+					(uintptr_t)&fd_array[fd_index] -
+					(uintptr_t)buffer->data;
+
+				binder_alloc_copy_from_buffer(&proc->alloc,
+							      &fd,
+							      buffer,
+							      offset,
+							      sizeof(fd));
+				binder_deferred_fd_close(fd);
+			}
 		} break;
 		default:
 			pr_err("transaction release %d bad object type %x\n",
@@ -2496,7 +2516,7 @@ static int binder_translate_handle(struct flat_binder_object *fp,
 	return ret;
 }
 
-static int binder_translate_fd(u32 *fdp,
+static int binder_translate_fd(u32 fd, binder_size_t fd_offset,
 			       struct binder_transaction *t,
 			       struct binder_thread *thread,
 			       struct binder_transaction *in_reply_to)
@@ -2507,7 +2527,6 @@ static int binder_translate_fd(u32 *fdp,
 	struct file *file;
 	int ret = 0;
 	bool target_allows_fd;
-	int fd = *fdp;
 
 	if (in_reply_to)
 		target_allows_fd = !!(in_reply_to->flags & TF_ACCEPT_FDS);
@@ -2546,7 +2565,7 @@ static int binder_translate_fd(u32 *fdp,
 		goto err_alloc;
 	}
 	fixup->file = file;
-	fixup->offset = (uintptr_t)fdp - (uintptr_t)t->buffer->data;
+	fixup->offset = fd_offset;
 	trace_binder_transaction_fd_send(t, fd, fixup->offset);
 	list_add_tail(&fixup->fixup_entry, &t->fd_fixups);
 
@@ -2598,8 +2617,17 @@ static int binder_translate_fd_array(struct binder_fd_array_object *fda,
 		return -EINVAL;
 	}
 	for (fdi = 0; fdi < fda->num_fds; fdi++) {
-		int ret = binder_translate_fd(&fd_array[fdi], t, thread,
-						in_reply_to);
+		u32 fd;
+		int ret;
+		binder_size_t offset =
+			(uintptr_t)&fd_array[fdi] -
+			(uintptr_t)t->buffer->data;
+
+		binder_alloc_copy_from_buffer(&target_proc->alloc,
+					      &fd, t->buffer,
+					      offset, sizeof(fd));
+		ret = binder_translate_fd(fd, offset, t, thread,
+					  in_reply_to);
 		if (ret < 0)
 			return ret;
 	}
@@ -3066,7 +3094,9 @@ static void binder_transaction(struct binder_proc *proc,
 
 		t->security_ctx = (uintptr_t)kptr +
 		    binder_alloc_get_user_buffer_offset(&target_proc->alloc);
-		memcpy(kptr, secctx, secctx_sz);
+		binder_alloc_copy_to_buffer(&target_proc->alloc,
+					    t->buffer, buf_offset,
+					    secctx, secctx_sz);
 		security_release_secctx(secctx, secctx_sz);
 		secctx = NULL;
 	}
@@ -3128,11 +3158,21 @@ static void binder_transaction(struct binder_proc *proc,
 	off_min = 0;
 	for (; offp < off_end; offp++) {
 		struct binder_object_header *hdr;
-		size_t object_size = binder_validate_object(t->buffer, *offp);
-
-		if (object_size == 0 || *offp < off_min) {
+		size_t object_size;
+		binder_size_t object_offset;
+		binder_size_t buffer_offset =
+			(uintptr_t)offp - (uintptr_t)t->buffer->data;
+
+		binder_alloc_copy_from_buffer(&target_proc->alloc,
+					      &object_offset,
+					      t->buffer,
+					      buffer_offset,
+					      sizeof(object_offset));
+		object_size = binder_validate_object(t->buffer, object_offset);
+		if (object_size == 0 || object_offset < off_min) {
 			binder_user_error("%d:%d got transaction with invalid offset (%lld, min %lld max %lld) or object.\n",
-					  proc->pid, thread->pid, (u64)*offp,
+					  proc->pid, thread->pid,
+					  (u64)object_offset,
 					  (u64)off_min,
 					  (u64)t->buffer->data_size);
 			return_error = BR_FAILED_REPLY;
@@ -3141,8 +3181,9 @@ static void binder_transaction(struct binder_proc *proc,
 			goto err_bad_offset;
 		}
 
-		hdr = (struct binder_object_header *)(t->buffer->data + *offp);
-		off_min = *offp + object_size;
+		hdr = (struct binder_object_header *)
+			(t->buffer->data + object_offset);
+		off_min = object_offset + object_size;
 		switch (hdr->type) {
 		case BINDER_TYPE_BINDER:
 		case BINDER_TYPE_WEAK_BINDER: {
@@ -3173,8 +3214,10 @@ static void binder_transaction(struct binder_proc *proc,
 
 		case BINDER_TYPE_FD: {
 			struct binder_fd_object *fp = to_binder_fd_object(hdr);
-			int ret = binder_translate_fd(&fp->fd, t, thread,
-						      in_reply_to);
+			binder_size_t fd_offset = object_offset +
+				(uintptr_t)&fp->fd - (uintptr_t)fp;
+			int ret = binder_translate_fd(fp->fd, fd_offset, t,
+						      thread, in_reply_to);
 
 			if (ret < 0) {
 				return_error = BR_FAILED_REPLY;
@@ -3967,6 +4010,7 @@ static int binder_wait_for_work(struct binder_thread *thread,
 
 /**
  * binder_apply_fd_fixups() - finish fd translation
+ * @proc:         binder_proc associated @t->buffer
  * @t:	binder transaction with list of fd fixups
  *
  * Now that we are in the context of the transaction target
@@ -3978,14 +4022,14 @@ static int binder_wait_for_work(struct binder_thread *thread,
  * fput'ing files that have not been processed and ksys_close'ing
  * any fds that have already been allocated.
  */
-static int binder_apply_fd_fixups(struct binder_transaction *t)
+static int binder_apply_fd_fixups(struct binder_proc *proc,
+				  struct binder_transaction *t)
 {
 	struct binder_txn_fd_fixup *fixup, *tmp;
 	int ret = 0;
 
 	list_for_each_entry(fixup, &t->fd_fixups, fixup_entry) {
 		int fd = get_unused_fd_flags(O_CLOEXEC);
-		u32 *fdp;
 
 		if (fd < 0) {
 			binder_debug(BINDER_DEBUG_TRANSACTION,
@@ -4000,33 +4044,20 @@ static int binder_apply_fd_fixups(struct binder_transaction *t)
 		trace_binder_transaction_fd_recv(t, fd, fixup->offset);
 		fd_install(fd, fixup->file);
 		fixup->file = NULL;
-		fdp = (u32 *)(t->buffer->data + fixup->offset);
-		/*
-		 * This store can cause problems for CPUs with a
-		 * VIVT cache (eg ARMv5) since the cache cannot
-		 * detect virtual aliases to the same physical cacheline.
-		 * To support VIVT, this address and the user-space VA
-		 * would both need to be flushed. Since this kernel
-		 * VA is not constructed via page_to_virt(), we can't
-		 * use flush_dcache_page() on it, so we'd have to use
-		 * an internal function. If devices with VIVT ever
-		 * need to run Android, we'll either need to go back
-		 * to patching the translated fd from the sender side
-		 * (using the non-standard kernel functions), or rework
-		 * how the kernel uses the buffer to use page_to_virt()
-		 * addresses instead of allocating in our own vm area.
-		 *
-		 * For now, we disable compilation if CONFIG_CPU_CACHE_VIVT.
-		 */
-		*fdp = fd;
+		binder_alloc_copy_to_buffer(&proc->alloc, t->buffer,
+					    fixup->offset, &fd,
+					    sizeof(u32));
 	}
 	list_for_each_entry_safe(fixup, tmp, &t->fd_fixups, fixup_entry) {
 		if (fixup->file) {
 			fput(fixup->file);
 		} else if (ret) {
-			u32 *fdp = (u32 *)(t->buffer->data + fixup->offset);
+			u32 fd;
 
-			binder_deferred_fd_close(*fdp);
+			binder_alloc_copy_from_buffer(&proc->alloc, &fd,
+						      t->buffer, fixup->offset,
+						      sizeof(fd));
+			binder_deferred_fd_close(fd);
 		}
 		list_del(&fixup->fixup_entry);
 		kfree(fixup);
@@ -4324,7 +4355,7 @@ static int binder_thread_read(struct binder_proc *proc,
 			trd->sender_pid = 0;
 		}
 
-		ret = binder_apply_fd_fixups(t);
+		ret = binder_apply_fd_fixups(proc, t);
 		if (ret) {
 			struct binder_buffer *buffer = t->buffer;
 			bool oneway = !!(t->flags & TF_ONE_WAY);
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 255fa71911e5e..be2a6077e6c5c 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1167,3 +1167,62 @@ binder_alloc_copy_user_to_buffer(struct binder_alloc *alloc,
 	}
 	return 0;
 }
+
+static void binder_alloc_do_buffer_copy(struct binder_alloc *alloc,
+					bool to_buffer,
+					struct binder_buffer *buffer,
+					binder_size_t buffer_offset,
+					void *ptr,
+					size_t bytes)
+{
+	/* All copies must be 32-bit aligned and 32-bit size */
+	BUG_ON(!check_buffer(alloc, buffer, buffer_offset, bytes));
+
+	while (bytes) {
+		unsigned long size;
+		struct page *page;
+		pgoff_t pgoff;
+		void *tmpptr;
+		void *base_ptr;
+
+		page = binder_alloc_get_page(alloc, buffer,
+					     buffer_offset, &pgoff);
+		size = min(bytes, (size_t)(PAGE_SIZE - pgoff));
+		base_ptr = kmap_atomic(page);
+		tmpptr = (void *)((uintptr_t)base_ptr + pgoff);
+		if (to_buffer)
+			memcpy(tmpptr, ptr, size);
+		else
+			memcpy(ptr, tmpptr, size);
+		/*
+		 * kunmap_atomic() takes care of flushing the cache
+		 * if this device has VIVT cache arch
+		 */
+		kunmap_atomic(base_ptr);
+		bytes -= size;
+		pgoff = 0;
+		ptr = (void *)(uintptr_t)ptr + size;
+		buffer_offset += size;
+	}
+}
+
+void binder_alloc_copy_to_buffer(struct binder_alloc *alloc,
+				 struct binder_buffer *buffer,
+				 binder_size_t buffer_offset,
+				 void *src,
+				 size_t bytes)
+{
+	binder_alloc_do_buffer_copy(alloc, true, buffer, buffer_offset,
+				    src, bytes);
+}
+
+void binder_alloc_copy_from_buffer(struct binder_alloc *alloc,
+				   void *dest,
+				   struct binder_buffer *buffer,
+				   binder_size_t buffer_offset,
+				   size_t bytes)
+{
+	binder_alloc_do_buffer_copy(alloc, false, buffer, buffer_offset,
+				    dest, bytes);
+}
+
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 995155f31dbd4..9d682b9d6c241 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -191,5 +191,17 @@ binder_alloc_copy_user_to_buffer(struct binder_alloc *alloc,
 				 const void __user *from,
 				 size_t bytes);
 
+void binder_alloc_copy_to_buffer(struct binder_alloc *alloc,
+				 struct binder_buffer *buffer,
+				 binder_size_t buffer_offset,
+				 void *src,
+				 size_t bytes);
+
+void binder_alloc_copy_from_buffer(struct binder_alloc *alloc,
+				   void *dest,
+				   struct binder_buffer *buffer,
+				   binder_size_t buffer_offset,
+				   size_t bytes);
+
 #endif /* _LINUX_BINDER_ALLOC_H */
 
-- 
2.20.1.495.gaa96b0ce6b-goog

