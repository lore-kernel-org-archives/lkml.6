Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7B6C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E465C2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="K4cVVlTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E465C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbeH2Ak1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:40:27 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:39044 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH2Ak0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:40:26 -0400
Received: by mail-pg1-f179.google.com with SMTP id g20-v6so1279811pgv.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2d+IR6+4wUC/4R2FfaS1O0vOpDhs3VJvlZHPYspuhos=;
        b=K4cVVlTa7JKl8m1bUhtxaubflCUWCvu20Bgm0qVsmhTzgTYncGUVzoNf9r+eIn7S+0
         2aVN9dvwn+848OzB0ESQ9FKZgiBKFUrgghHGhfraG9UHXOhykf7PxOpttQB9vN/9anRE
         DGqMS8RRvNbvdH9BJ4vIteaKq6P6DBWmWhcIKrt01MqNbFaxEAdp/4qq2qFSF0dbu1p6
         L5jQZ4uPavQr1Y8tg1zPDBnkFmPY088CuWOF03Tl60HhTcv4Tjr4n4/v9x4XS7cTotGY
         7UJ0Yql2kq0ysfWdBag9eL4QQI3dENliNYzlSQOgx2CxLBmjIPGeYzfYYL5338vdROR4
         wFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2d+IR6+4wUC/4R2FfaS1O0vOpDhs3VJvlZHPYspuhos=;
        b=GKb+P6EbGHaGnyD+cHUpqzy0HWLJdHIQH3/UNqyUpQKwMmsriWgTnxPN10OyfTiEZ/
         aVzPIGBiW9MtyqEoA0qpTu3y9mc5CiEyJjaf3Zx8Y561CRqDnk3B7PraXFd6cVARpv3+
         Gu64+ADzzN2ZZoJPypM1vEKysKa3tiX2YUXvrwXJtZQXe8zRb7H4cfwzpnIxRArJDt2q
         +l1H/5FbFPO3WwrE3F/7sSpMQhUxpfZ09QXumdTnfIBqcF+jQ2HPl71enNZ7ktjlZWfl
         WiesELFnp2jiUr4iS1FJv9ISmvCTYQaBHs0ad+5Nf4Yel1iaTshZAvDuFBkbWe49SqOR
         7TrA==
X-Gm-Message-State: APzg51D7vHcbnvWSiQh4bhrjZ1wEbmomgFGF81N8r6Axj/Eb1dYVPZWJ
        QuAjqRzjcpRcP6CK+yAjSVSF+Q==
X-Google-Smtp-Source: ANB0Vdb4nosDxoSBMeJvE6LyH0ukOpdhz0enj5eh+EGekD+5i3QfGWvF0pGd9bXzdN0I57+uEP9UxA==
X-Received: by 2002:a65:5288:: with SMTP id y8-v6mr2992037pgp.284.1535489223864;
        Tue, 28 Aug 2018 13:47:03 -0700 (PDT)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:f5a1:2b8d:9c84:99b])
        by smtp.googlemail.com with ESMTPSA id 17-v6sm4981699pgl.1.2018.08.28.13.47.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 13:47:03 -0700 (PDT)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     christian.brauner@canonical.com, ben@decadent.org.uk
Subject: [PATCH v2] binder: use standard functions to allocate fds
Date:   Tue, 28 Aug 2018 13:46:25 -0700
Message-Id: <20180828204625.232573-1-tkjos@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binder uses internal fs interfaces to allocate and install fds:

__alloc_fd
__fd_install
__close_fd
get_files_struct
put_files_struct

These were used to support the passing of fds between processes
as part of a transaction. The actual allocation and installation
of the fds in the target process was handled by the sending
process so the standard functions, alloc_fd() and fd_install()
which assume task==current couldn't be used.

This patch refactors this mechanism so that the fds are
allocated and installed by the target process allowing the
standard functions to be used.

The sender now creates a list of fd fixups that contains the
struct *file and the address to fixup with the new fd once
it is allocated. This list is processed by the target process
when the transaction is dequeued.

A new error case is introduced by this change. If an async
transaction with file descriptors cannot allocate new
fds in the target (probably due to out of file descriptors),
the transaction is discarded with a log message. In the old
implementation this would have been detected in the sender
context and failed prior to sending.

Signed-off-by: Todd Kjos <tkjos@google.com>
---
v2: use "%zu" printk format for size_t

 drivers/android/Kconfig        |   2 +-
 drivers/android/binder.c       | 387 ++++++++++++++++++++-------------
 drivers/android/binder_trace.h |  36 ++-
 3 files changed, 260 insertions(+), 165 deletions(-)

diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
index 432e9ad770703..51e8250d113fa 100644
--- a/drivers/android/Kconfig
+++ b/drivers/android/Kconfig
@@ -10,7 +10,7 @@ if ANDROID
 
 config ANDROID_BINDER_IPC
 	bool "Android Binder IPC Driver"
-	depends on MMU
+	depends on MMU && !CPU_CACHE_VIVT
 	default n
 	---help---
 	  Binder is used in Android for both communication between processes,
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index d58763b6b0090..50856319bc7da 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -71,6 +71,7 @@
 #include <linux/security.h>
 #include <linux/spinlock.h>
 #include <linux/ratelimit.h>
+#include <linux/syscalls.h>
 
 #include <uapi/linux/android/binder.h>
 
@@ -457,9 +458,8 @@ struct binder_ref {
 };
 
 enum binder_deferred_state {
-	BINDER_DEFERRED_PUT_FILES    = 0x01,
-	BINDER_DEFERRED_FLUSH        = 0x02,
-	BINDER_DEFERRED_RELEASE      = 0x04,
+	BINDER_DEFERRED_FLUSH        = 0x01,
+	BINDER_DEFERRED_RELEASE      = 0x02,
 };
 
 /**
@@ -480,9 +480,6 @@ enum binder_deferred_state {
  *                        (invariant after initialized)
  * @tsk                   task_struct for group_leader of process
  *                        (invariant after initialized)
- * @files                 files_struct for process
- *                        (protected by @files_lock)
- * @files_lock            mutex to protect @files
  * @deferred_work_node:   element for binder_deferred_list
  *                        (protected by binder_deferred_lock)
  * @deferred_work:        bitmap of deferred work to perform
@@ -527,8 +524,6 @@ struct binder_proc {
 	struct list_head waiting_threads;
 	int pid;
 	struct task_struct *tsk;
-	struct files_struct *files;
-	struct mutex files_lock;
 	struct hlist_node deferred_work_node;
 	int deferred_work;
 	bool is_dead;
@@ -611,6 +606,23 @@ struct binder_thread {
 	bool is_dead;
 };
 
+/**
+ * struct binder_txn_fd_fixup - transaction fd fixup list element
+ * @fixup_entry:          list entry
+ * @file:                 struct file to be associated with new fd
+ * @offset:               offset in buffer data to this fixup
+ *
+ * List element for fd fixups in a transaction. Since file
+ * descriptors need to be allocated in the context of the
+ * target process, we pass each fd to be processed in this
+ * struct.
+ */
+struct binder_txn_fd_fixup {
+	struct list_head fixup_entry;
+	struct file *file;
+	size_t offset;
+};
+
 struct binder_transaction {
 	int debug_id;
 	struct binder_work work;
@@ -628,6 +640,7 @@ struct binder_transaction {
 	long	priority;
 	long	saved_priority;
 	kuid_t	sender_euid;
+	struct list_head fd_fixups;
 	/**
 	 * @lock:  protects @from, @to_proc, and @to_thread
 	 *
@@ -920,66 +933,6 @@ static void binder_free_thread(struct binder_thread *thread);
 static void binder_free_proc(struct binder_proc *proc);
 static void binder_inc_node_tmpref_ilocked(struct binder_node *node);
 
-static int task_get_unused_fd_flags(struct binder_proc *proc, int flags)
-{
-	unsigned long rlim_cur;
-	unsigned long irqs;
-	int ret;
-
-	mutex_lock(&proc->files_lock);
-	if (proc->files == NULL) {
-		ret = -ESRCH;
-		goto err;
-	}
-	if (!lock_task_sighand(proc->tsk, &irqs)) {
-		ret = -EMFILE;
-		goto err;
-	}
-	rlim_cur = task_rlimit(proc->tsk, RLIMIT_NOFILE);
-	unlock_task_sighand(proc->tsk, &irqs);
-
-	ret = __alloc_fd(proc->files, 0, rlim_cur, flags);
-err:
-	mutex_unlock(&proc->files_lock);
-	return ret;
-}
-
-/*
- * copied from fd_install
- */
-static void task_fd_install(
-	struct binder_proc *proc, unsigned int fd, struct file *file)
-{
-	mutex_lock(&proc->files_lock);
-	if (proc->files)
-		__fd_install(proc->files, fd, file);
-	mutex_unlock(&proc->files_lock);
-}
-
-/*
- * copied from sys_close
- */
-static long task_close_fd(struct binder_proc *proc, unsigned int fd)
-{
-	int retval;
-
-	mutex_lock(&proc->files_lock);
-	if (proc->files == NULL) {
-		retval = -ESRCH;
-		goto err;
-	}
-	retval = __close_fd(proc->files, fd);
-	/* can't restart close syscall because file table entry was cleared */
-	if (unlikely(retval == -ERESTARTSYS ||
-		     retval == -ERESTARTNOINTR ||
-		     retval == -ERESTARTNOHAND ||
-		     retval == -ERESTART_RESTARTBLOCK))
-		retval = -EINTR;
-err:
-	mutex_unlock(&proc->files_lock);
-	return retval;
-}
-
 static bool binder_has_work_ilocked(struct binder_thread *thread,
 				    bool do_proc_work)
 {
@@ -1958,10 +1911,32 @@ static struct binder_thread *binder_get_txn_from_and_acq_inner(
 	return NULL;
 }
 
+/**
+ * binder_free_txn_fixups() - free unprocessed fd fixups
+ * @t:	binder transaction for t->from
+ *
+ * If the transaction is being torn down prior to being
+ * processed by the target process, free all of the
+ * fd fixups and fput the file structs. It is safe to
+ * call this function after the fixups have been
+ * processed -- in that case, the list will be empty.
+ */
+static void binder_free_txn_fixups(struct binder_transaction *t)
+{
+	struct binder_txn_fd_fixup *fixup, *tmp;
+
+	list_for_each_entry_safe(fixup, tmp, &t->fd_fixups, fixup_entry) {
+		fput(fixup->file);
+		list_del(&fixup->fixup_entry);
+		kfree(fixup);
+	}
+}
+
 static void binder_free_transaction(struct binder_transaction *t)
 {
 	if (t->buffer)
 		t->buffer->transaction = NULL;
+	binder_free_txn_fixups(t);
 	kfree(t);
 	binder_stats_deleted(BINDER_STAT_TRANSACTION);
 }
@@ -2262,12 +2237,17 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 		} break;
 
 		case BINDER_TYPE_FD: {
-			struct binder_fd_object *fp = to_binder_fd_object(hdr);
-
-			binder_debug(BINDER_DEBUG_TRANSACTION,
-				     "        fd %d\n", fp->fd);
-			if (failed_at)
-				task_close_fd(proc, fp->fd);
+			/*
+			 * No need to close the file here since user-space
+			 * closes it for for successfully delivered
+			 * transactions. For transactions that weren't
+			 * delivered, the new fd was never allocated so
+			 * there is no need to close and the fput on the
+			 * file is done when the transaction is torn
+			 * down.
+			 */
+			WARN_ON(failed_at &&
+				proc->tsk == current->group_leader);
 		} break;
 		case BINDER_TYPE_PTR:
 			/*
@@ -2283,6 +2263,15 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 			size_t fd_index;
 			binder_size_t fd_buf_size;
 
+			if (proc->tsk != current->group_leader) {
+				/*
+				 * Nothing to do if running in sender context
+				 * The fd fixups have not been applied so no
+				 * fds need to be closed.
+				 */
+				continue;
+			}
+
 			fda = to_binder_fd_array_object(hdr);
 			parent = binder_validate_ptr(buffer, fda->parent,
 						     off_start,
@@ -2315,7 +2304,7 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 			}
 			fd_array = (u32 *)(parent_buffer + (uintptr_t)fda->parent_offset);
 			for (fd_index = 0; fd_index < fda->num_fds; fd_index++)
-				task_close_fd(proc, fd_array[fd_index]);
+				ksys_close(fd_array[fd_index]);
 		} break;
 		default:
 			pr_err("transaction release %d bad object type %x\n",
@@ -2447,17 +2436,18 @@ static int binder_translate_handle(struct flat_binder_object *fp,
 	return ret;
 }
 
-static int binder_translate_fd(int fd,
+static int binder_translate_fd(u32 *fdp,
 			       struct binder_transaction *t,
 			       struct binder_thread *thread,
 			       struct binder_transaction *in_reply_to)
 {
 	struct binder_proc *proc = thread->proc;
 	struct binder_proc *target_proc = t->to_proc;
-	int target_fd;
+	struct binder_txn_fd_fixup *fixup;
 	struct file *file;
-	int ret;
+	int ret = 0;
 	bool target_allows_fd;
+	int fd = *fdp;
 
 	if (in_reply_to)
 		target_allows_fd = !!(in_reply_to->flags & TF_ACCEPT_FDS);
@@ -2485,19 +2475,24 @@ static int binder_translate_fd(int fd,
 		goto err_security;
 	}
 
-	target_fd = task_get_unused_fd_flags(target_proc, O_CLOEXEC);
-	if (target_fd < 0) {
+	/*
+	 * Add fixup record for this transaction. The allocation
+	 * of the fd in the target needs to be done from a
+	 * target thread.
+	 */
+	fixup = kzalloc(sizeof(*fixup), GFP_KERNEL);
+	if (!fixup) {
 		ret = -ENOMEM;
-		goto err_get_unused_fd;
+		goto err_alloc;
 	}
-	task_fd_install(target_proc, target_fd, file);
-	trace_binder_transaction_fd(t, fd, target_fd);
-	binder_debug(BINDER_DEBUG_TRANSACTION, "        fd %d -> %d\n",
-		     fd, target_fd);
+	fixup->file = file;
+	fixup->offset = (uintptr_t)fdp - (uintptr_t)t->buffer->data;
+	trace_binder_transaction_fd_send(t, fd, fixup->offset);
+	list_add_tail(&fixup->fixup_entry, &t->fd_fixups);
 
-	return target_fd;
+	return ret;
 
-err_get_unused_fd:
+err_alloc:
 err_security:
 	fput(file);
 err_fget:
@@ -2511,8 +2506,7 @@ static int binder_translate_fd_array(struct binder_fd_array_object *fda,
 				     struct binder_thread *thread,
 				     struct binder_transaction *in_reply_to)
 {
-	binder_size_t fdi, fd_buf_size, num_installed_fds;
-	int target_fd;
+	binder_size_t fdi, fd_buf_size;
 	uintptr_t parent_buffer;
 	u32 *fd_array;
 	struct binder_proc *proc = thread->proc;
@@ -2544,23 +2538,12 @@ static int binder_translate_fd_array(struct binder_fd_array_object *fda,
 		return -EINVAL;
 	}
 	for (fdi = 0; fdi < fda->num_fds; fdi++) {
-		target_fd = binder_translate_fd(fd_array[fdi], t, thread,
+		int ret = binder_translate_fd(&fd_array[fdi], t, thread,
 						in_reply_to);
-		if (target_fd < 0)
-			goto err_translate_fd_failed;
-		fd_array[fdi] = target_fd;
+		if (ret < 0)
+			return ret;
 	}
 	return 0;
-
-err_translate_fd_failed:
-	/*
-	 * Failed to allocate fd or security error, free fds
-	 * installed so far.
-	 */
-	num_installed_fds = fdi;
-	for (fdi = 0; fdi < num_installed_fds; fdi++)
-		task_close_fd(target_proc, fd_array[fdi]);
-	return target_fd;
 }
 
 static int binder_fixup_parent(struct binder_transaction *t,
@@ -2911,6 +2894,7 @@ static void binder_transaction(struct binder_proc *proc,
 		return_error_line = __LINE__;
 		goto err_alloc_t_failed;
 	}
+	INIT_LIST_HEAD(&t->fd_fixups);
 	binder_stats_created(BINDER_STAT_TRANSACTION);
 	spin_lock_init(&t->lock);
 
@@ -3066,17 +3050,16 @@ static void binder_transaction(struct binder_proc *proc,
 
 		case BINDER_TYPE_FD: {
 			struct binder_fd_object *fp = to_binder_fd_object(hdr);
-			int target_fd = binder_translate_fd(fp->fd, t, thread,
-							    in_reply_to);
+			int ret = binder_translate_fd(&fp->fd, t, thread,
+						      in_reply_to);
 
-			if (target_fd < 0) {
+			if (ret < 0) {
 				return_error = BR_FAILED_REPLY;
-				return_error_param = target_fd;
+				return_error_param = ret;
 				return_error_line = __LINE__;
 				goto err_translate_failed;
 			}
 			fp->pad_binder = 0;
-			fp->fd = target_fd;
 		} break;
 		case BINDER_TYPE_FDA: {
 			struct binder_fd_array_object *fda =
@@ -3233,6 +3216,7 @@ static void binder_transaction(struct binder_proc *proc,
 err_bad_offset:
 err_bad_parent:
 err_copy_data_failed:
+	binder_free_txn_fixups(t);
 	trace_binder_transaction_failed_buffer_release(t->buffer);
 	binder_transaction_buffer_release(target_proc, t->buffer, offp);
 	if (target_node)
@@ -3294,6 +3278,47 @@ static void binder_transaction(struct binder_proc *proc,
 	}
 }
 
+/**
+ * binder_free_buf() - free the specified buffer
+ * @proc:	binder proc that owns buffer
+ * @buffer:	buffer to be freed
+ *
+ * If buffer for an async transaction, enqueue the next async
+ * transaction from the node.
+ *
+ * Cleanup buffer and free it.
+ */
+void
+binder_free_buf(struct binder_proc *proc, struct binder_buffer *buffer)
+{
+	if (buffer->transaction) {
+		buffer->transaction->buffer = NULL;
+		buffer->transaction = NULL;
+	}
+	if (buffer->async_transaction && buffer->target_node) {
+		struct binder_node *buf_node;
+		struct binder_work *w;
+
+		buf_node = buffer->target_node;
+		binder_node_inner_lock(buf_node);
+		BUG_ON(!buf_node->has_async_transaction);
+		BUG_ON(buf_node->proc != proc);
+		w = binder_dequeue_work_head_ilocked(
+				&buf_node->async_todo);
+		if (!w) {
+			buf_node->has_async_transaction = false;
+		} else {
+			binder_enqueue_work_ilocked(
+					w, &proc->todo);
+			binder_wakeup_proc_ilocked(proc);
+		}
+		binder_node_inner_unlock(buf_node);
+	}
+	trace_binder_transaction_buffer_release(buffer);
+	binder_transaction_buffer_release(proc, buffer, NULL);
+	binder_alloc_free_buf(&proc->alloc, buffer);
+}
+
 static int binder_thread_write(struct binder_proc *proc,
 			struct binder_thread *thread,
 			binder_uintptr_t binder_buffer, size_t size,
@@ -3480,33 +3505,7 @@ static int binder_thread_write(struct binder_proc *proc,
 				     proc->pid, thread->pid, (u64)data_ptr,
 				     buffer->debug_id,
 				     buffer->transaction ? "active" : "finished");
-
-			if (buffer->transaction) {
-				buffer->transaction->buffer = NULL;
-				buffer->transaction = NULL;
-			}
-			if (buffer->async_transaction && buffer->target_node) {
-				struct binder_node *buf_node;
-				struct binder_work *w;
-
-				buf_node = buffer->target_node;
-				binder_node_inner_lock(buf_node);
-				BUG_ON(!buf_node->has_async_transaction);
-				BUG_ON(buf_node->proc != proc);
-				w = binder_dequeue_work_head_ilocked(
-						&buf_node->async_todo);
-				if (!w) {
-					buf_node->has_async_transaction = false;
-				} else {
-					binder_enqueue_work_ilocked(
-							w, &proc->todo);
-					binder_wakeup_proc_ilocked(proc);
-				}
-				binder_node_inner_unlock(buf_node);
-			}
-			trace_binder_transaction_buffer_release(buffer);
-			binder_transaction_buffer_release(proc, buffer, NULL);
-			binder_alloc_free_buf(&proc->alloc, buffer);
+			binder_free_buf(proc, buffer);
 			break;
 		}
 
@@ -3829,6 +3828,76 @@ static int binder_wait_for_work(struct binder_thread *thread,
 	return ret;
 }
 
+/**
+ * binder_apply_fd_fixups() - finish fd translation
+ * @t:	binder transaction with list of fd fixups
+ *
+ * Now that we are in the context of the transaction target
+ * process, we can allocate and install fds. Process the
+ * list of fds to translate and fixup the buffer with the
+ * new fds.
+ *
+ * If we fail to allocate an fd, then free the resources by
+ * fput'ing files that have not been processed and ksys_close'ing
+ * any fds that have already been allocated.
+ */
+static int binder_apply_fd_fixups(struct binder_transaction *t)
+{
+	struct binder_txn_fd_fixup *fixup, *tmp;
+	int ret = 0;
+
+	list_for_each_entry(fixup, &t->fd_fixups, fixup_entry) {
+		int fd = get_unused_fd_flags(O_CLOEXEC);
+		u32 *fdp;
+
+		if (fd < 0) {
+			binder_debug(BINDER_DEBUG_TRANSACTION,
+				     "failed fd fixup txn %d fd %d\n",
+				     t->debug_id, fd);
+			ret = -ENOMEM;
+			break;
+		}
+		binder_debug(BINDER_DEBUG_TRANSACTION,
+			     "fd fixup txn %d fd %d\n",
+			     t->debug_id, fd);
+		trace_binder_transaction_fd_recv(t, fd, fixup->offset);
+		fd_install(fd, fixup->file);
+		fixup->file = NULL;
+		fdp = (u32 *)(t->buffer->data + fixup->offset);
+		/*
+		 * This store can cause problems for CPUs with a
+		 * VIVT cache (eg ARMv5) since the cache cannot
+		 * detect virtual aliases to the same physical cacheline.
+		 * To support VIVT, this address and the user-space VA
+		 * would both need to be flushed. Since this kernel
+		 * VA is not constructed via page_to_virt(), we can't
+		 * use flush_dcache_page() on it, so we'd have to use
+		 * an internal function. If devices with VIVT ever
+		 * need to run Android, we'll either need to go back
+		 * to patching the translated fd from the sender side
+		 * (using the non-standard kernel functions), or rework
+		 * how the kernel uses the buffer to use page_to_virt()
+		 * addresses instead of allocating in our own vm area.
+		 *
+		 * For now, we disable compilation if CONFIG_CPU_CACHE_VIVT.
+		 */
+		*fdp = fd;
+	}
+	list_for_each_entry_safe(fixup, tmp, &t->fd_fixups, fixup_entry) {
+		if (fixup->file) {
+			fput(fixup->file);
+		} else if (ret) {
+			u32 *fdp = (u32 *)(t->buffer->data + fixup->offset);
+
+			ksys_close(*fdp);
+		}
+		list_del(&fixup->fixup_entry);
+		kfree(fixup);
+	}
+
+	return ret;
+}
+
 static int binder_thread_read(struct binder_proc *proc,
 			      struct binder_thread *thread,
 			      binder_uintptr_t binder_buffer, size_t size,
@@ -4110,6 +4179,34 @@ static int binder_thread_read(struct binder_proc *proc,
 			tr.sender_pid = 0;
 		}
 
+		ret = binder_apply_fd_fixups(t);
+		if (ret) {
+			struct binder_buffer *buffer = t->buffer;
+			bool oneway = !!(t->flags & TF_ONE_WAY);
+			int tid = t->debug_id;
+
+			if (t_from)
+				binder_thread_dec_tmpref(t_from);
+			buffer->transaction = NULL;
+			binder_cleanup_transaction(t, "fd fixups failed",
+						   BR_FAILED_REPLY);
+			binder_free_buf(proc, buffer);
+			binder_debug(BINDER_DEBUG_FAILED_TRANSACTION,
+				     "%d:%d %stransaction %d fd fixups failed %d/%d, line %d\n",
+				     proc->pid, thread->pid,
+				     oneway ? "async " :
+					(cmd == BR_REPLY ? "reply " : ""),
+				     tid, BR_FAILED_REPLY, ret, __LINE__);
+			if (cmd == BR_REPLY) {
+				cmd = BR_FAILED_REPLY;
+				if (put_user(cmd, (uint32_t __user *)ptr))
+					return -EFAULT;
+				ptr += sizeof(uint32_t);
+				binder_stat_br(proc, thread, cmd);
+				break;
+			}
+			continue;
+		}
 		tr.data_size = t->buffer->data_size;
 		tr.offsets_size = t->buffer->offsets_size;
 		tr.data.ptr.buffer = (binder_uintptr_t)
@@ -4693,7 +4790,6 @@ static void binder_vma_close(struct vm_area_struct *vma)
 		     (vma->vm_end - vma->vm_start) / SZ_1K, vma->vm_flags,
 		     (unsigned long)pgprot_val(vma->vm_page_prot));
 	binder_alloc_vma_close(&proc->alloc);
-	binder_defer_work(proc, BINDER_DEFERRED_PUT_FILES);
 }
 
 static vm_fault_t binder_vm_fault(struct vm_fault *vmf)
@@ -4739,9 +4835,6 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
 	ret = binder_alloc_mmap_handler(&proc->alloc, vma);
 	if (ret)
 		return ret;
-	mutex_lock(&proc->files_lock);
-	proc->files = get_files_struct(current);
-	mutex_unlock(&proc->files_lock);
 	return 0;
 
 err_bad_arg:
@@ -4765,7 +4858,6 @@ static int binder_open(struct inode *nodp, struct file *filp)
 	spin_lock_init(&proc->outer_lock);
 	get_task_struct(current->group_leader);
 	proc->tsk = current->group_leader;
-	mutex_init(&proc->files_lock);
 	INIT_LIST_HEAD(&proc->todo);
 	proc->default_priority = task_nice(current);
 	binder_dev = container_of(filp->private_data, struct binder_device,
@@ -4915,8 +5007,6 @@ static void binder_deferred_release(struct binder_proc *proc)
 	struct rb_node *n;
 	int threads, nodes, incoming_refs, outgoing_refs, active_transactions;
 
-	BUG_ON(proc->files);
-
 	mutex_lock(&binder_procs_lock);
 	hlist_del(&proc->proc_node);
 	mutex_unlock(&binder_procs_lock);
@@ -4998,7 +5088,6 @@ static void binder_deferred_release(struct binder_proc *proc)
 static void binder_deferred_func(struct work_struct *work)
 {
 	struct binder_proc *proc;
-	struct files_struct *files;
 
 	int defer;
 
@@ -5016,23 +5105,11 @@ static void binder_deferred_func(struct work_struct *work)
 		}
 		mutex_unlock(&binder_deferred_lock);
 
-		files = NULL;
-		if (defer & BINDER_DEFERRED_PUT_FILES) {
-			mutex_lock(&proc->files_lock);
-			files = proc->files;
-			if (files)
-				proc->files = NULL;
-			mutex_unlock(&proc->files_lock);
-		}
-
 		if (defer & BINDER_DEFERRED_FLUSH)
 			binder_deferred_flush(proc);
 
 		if (defer & BINDER_DEFERRED_RELEASE)
 			binder_deferred_release(proc); /* frees proc */
-
-		if (files)
-			put_files_struct(files);
 	} while (proc);
 }
 static DECLARE_WORK(binder_deferred_work, binder_deferred_func);
diff --git a/drivers/android/binder_trace.h b/drivers/android/binder_trace.h
index 588eb3ec35070..14de7ac57a34d 100644
--- a/drivers/android/binder_trace.h
+++ b/drivers/android/binder_trace.h
@@ -223,22 +223,40 @@ TRACE_EVENT(binder_transaction_ref_to_ref,
 		  __entry->dest_ref_debug_id, __entry->dest_ref_desc)
 );
 
-TRACE_EVENT(binder_transaction_fd,
-	TP_PROTO(struct binder_transaction *t, int src_fd, int dest_fd),
-	TP_ARGS(t, src_fd, dest_fd),
+TRACE_EVENT(binder_transaction_fd_send,
+	TP_PROTO(struct binder_transaction *t, int fd, size_t offset),
+	TP_ARGS(t, fd, offset),
 
 	TP_STRUCT__entry(
 		__field(int, debug_id)
-		__field(int, src_fd)
-		__field(int, dest_fd)
+		__field(int, fd)
+		__field(size_t, offset)
+	),
+	TP_fast_assign(
+		__entry->debug_id = t->debug_id;
+		__entry->fd = fd;
+		__entry->offset = offset;
+	),
+	TP_printk("transaction=%d src_fd=%d offset=%zu",
+		  __entry->debug_id, __entry->fd, __entry->offset)
+);
+
+TRACE_EVENT(binder_transaction_fd_recv,
+	TP_PROTO(struct binder_transaction *t, int fd, size_t offset),
+	TP_ARGS(t, fd, offset),
+
+	TP_STRUCT__entry(
+		__field(int, debug_id)
+		__field(int, fd)
+		__field(size_t, offset)
 	),
 	TP_fast_assign(
 		__entry->debug_id = t->debug_id;
-		__entry->src_fd = src_fd;
-		__entry->dest_fd = dest_fd;
+		__entry->fd = fd;
+		__entry->offset = offset;
 	),
-	TP_printk("transaction=%d src_fd=%d ==> dest_fd=%d",
-		  __entry->debug_id, __entry->src_fd, __entry->dest_fd)
+	TP_printk("transaction=%d dest_fd=%d offset=%zu",
+		  __entry->debug_id, __entry->fd, __entry->offset)
 );
 
 DECLARE_EVENT_CLASS(binder_buffer_class,
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

