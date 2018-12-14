Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22535C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317EF20896
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="VvqXJFUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbeLNX6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 18:58:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33543 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeLNX6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 18:58:34 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so3395152pgu.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 15:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NfnkaPnS1dPc1kok/jrapY3qumZ/TEy+Fb6QqCIKHFY=;
        b=VvqXJFUBnds2LJBlY8M4+nd0eAO3PNvHeZKV2CFEPogzM73lFCMCeK9EE8NdKuWfs1
         unmmGdM8uX/h25nsEBzWa3FxuQ9lK3nuE0GGKPFlN2SHOEFpOfdi9WYZdysX5mNKsb8P
         X4bBVEuQ5bZIaQTbDu9g+tBq4quNjHEB5ICpVol0XXSAc9Ytk+l33nU7TkRBhOvIO+ch
         0T2X5PaOcLu5RY4aTBg8clXvc0+0YHruZ0j+IFEM+JFnUlV3YBSlXWdIK1mq9Q4FwyD+
         Vh/VjTz9h03/GjTqTEVkSfd6vQEU6aMNpEVc05GhXGn0u8Zv1hrZzAXdckweq2wCkIov
         xJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NfnkaPnS1dPc1kok/jrapY3qumZ/TEy+Fb6QqCIKHFY=;
        b=VOzR5Zobf+vha2sP/x8W3yO0ArJlFTj6hUbAecEDDfUHdQvwMZuW5WhhDApfWtcXAV
         qwIAtiUpe8TmheuI1K2wZ5WhPBPaxRMA3x9FFTQdOmmCpcxvlWgbs5sCjauC+F3Ne5lN
         JezYLgxMRm4Koz8vjV2Ogse5Bp9+JczC99tE7DV5+CNKE+tc7CynEwo+2nLEuNODFGsf
         RMn48GRjrX0+uSvxAfXGyc5hzoFjifTIdqSttZ3wnG36/2hK1jwYtsj6hZGa75e2urZV
         ziFIvv84igrCURlBE3cAwYBp/ZK5o6mDF69k9b5JSNPcGLHZBcxQKv9yxBVa9P7ZUqMg
         OjQQ==
X-Gm-Message-State: AA+aEWZ+ctenPV5XmLZuQbmD8+BjNnHmSGaczWlGcSRZtUv6g6GWeBSU
        q2covd7XtCZBzRKFWQoCKMvoYA==
X-Google-Smtp-Source: AFSGD/VBnk+Q+j8wXcjvxuZqsk0J13OA0Vkwp2D+JER8mPVVIeEVRWXbfcHreUdUNkH7znKdn3C0Ew==
X-Received: by 2002:a65:520a:: with SMTP id o10mr4611623pgp.276.1544831913022;
        Fri, 14 Dec 2018 15:58:33 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id q199sm12377453pfc.97.2018.12.14.15.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 15:58:32 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, viro@zeniv.linux.org.uk
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH v3] binder: fix use-after-free due to ksys_close() during fdget()
Date:   Fri, 14 Dec 2018 15:58:21 -0800
Message-Id: <20181214235821.67558-1-tkjos@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

44d8047f1d8 ("binder: use standard functions to allocate fds")
exposed a pre-existing issue in the binder driver.

fdget() is used in ksys_ioctl() as a performance optimization.
One of the rules associated with fdget() is that ksys_close() must
not be called between the fdget() and the fdput(). There is a case
where this requirement is not met in the binder driver which results
in the reference count dropping to 0 when the device is still in
use. This can result in use-after-free or other issues.

If userpace has passed a file-descriptor for the binder driver using
a BINDER_TYPE_FDA object, then kys_close() is called on it when
handling a binder_ioctl(BC_FREE_BUFFER) command. This violates
the assumptions for using fdget().

The problem is fixed by deferring the close using task_work_add(). A
new variant of __close_fd() was created that returns a struct file
with a reference. The fput() is deferred instead of using ksys_close().

Fixes: 44d8047f1d87a ("binder: use standard functions to allocate fds")
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Todd Kjos <tkjos@google.com>
---
v2:
- simplified code
v3:
- implemented Al Viro's suggestion to pass struct file instead of fd
- added __close_fd_get_file() to close the fd, but reference the file

 drivers/android/binder.c | 63 ++++++++++++++++++++++++++++++++++++++--
 fs/file.c                | 29 ++++++++++++++++++
 include/linux/fdtable.h  |  1 +
 3 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index c525b164d39d2f..c4ee11d883dd93 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -72,6 +72,7 @@
 #include <linux/spinlock.h>
 #include <linux/ratelimit.h>
 #include <linux/syscalls.h>
+#include <linux/task_work.h>
 
 #include <uapi/linux/android/binder.h>
 
@@ -2184,6 +2185,64 @@ static bool binder_validate_fixup(struct binder_buffer *b,
 	return (fixup_offset >= last_min_offset);
 }
 
+/**
+ * struct binder_task_work_cb - for deferred close
+ *
+ * @twork:                callback_head for task work
+ * @fd:                   fd to close
+ *
+ * Structure to pass task work to be handled after
+ * returning from binder_ioctl() via task_work_add().
+ */
+struct binder_task_work_cb {
+	struct callback_head twork;
+	struct file *file;
+};
+
+/**
+ * binder_do_fd_close() - close list of file descriptors
+ * @twork:	callback head for task work
+ *
+ * It is not safe to call ksys_close() during the binder_ioctl()
+ * function if there is a chance that binder's own file descriptor
+ * might be closed. This is to meet the requirements for using
+ * fdget() (see comments for __fget_light()). Therefore use
+ * task_work_add() to schedule the close operation once we have
+ * returned from binder_ioctl(). This function is a callback
+ * for that mechanism and does the actual ksys_close() on the
+ * given file descriptor.
+ */
+static void binder_do_fd_close(struct callback_head *twork)
+{
+	struct binder_task_work_cb *twcb = container_of(twork,
+			struct binder_task_work_cb, twork);
+
+	fput(twcb->file);
+	kfree(twcb);
+}
+
+/**
+ * binder_deferred_fd_close() - schedule a close for the given file-descriptor
+ * @fd:		file-descriptor to close
+ *
+ * See comments in binder_do_fd_close(). This function is used to schedule
+ * a file-descriptor to be closed after returning from binder_ioctl().
+ */
+static void binder_deferred_fd_close(int fd)
+{
+	struct binder_task_work_cb *twcb;
+
+	twcb = kzalloc(sizeof(*twcb), GFP_KERNEL);
+	if (!twcb)
+		return;
+	init_task_work(&twcb->twork, binder_do_fd_close);
+	__close_fd_get_file(fd, &twcb->file);
+	if (twcb->file)
+		task_work_add(current, &twcb->twork, true);
+	else
+		kfree(twcb);
+}
+
 static void binder_transaction_buffer_release(struct binder_proc *proc,
 					      struct binder_buffer *buffer,
 					      binder_size_t *failed_at)
@@ -2323,7 +2382,7 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 			}
 			fd_array = (u32 *)(parent_buffer + (uintptr_t)fda->parent_offset);
 			for (fd_index = 0; fd_index < fda->num_fds; fd_index++)
-				ksys_close(fd_array[fd_index]);
+				binder_deferred_fd_close(fd_array[fd_index]);
 		} break;
 		default:
 			pr_err("transaction release %d bad object type %x\n",
@@ -3942,7 +4001,7 @@ static int binder_apply_fd_fixups(struct binder_transaction *t)
 		} else if (ret) {
 			u32 *fdp = (u32 *)(t->buffer->data + fixup->offset);
 
-			ksys_close(*fdp);
+			binder_deferred_fd_close(*fdp);
 		}
 		list_del(&fixup->fixup_entry);
 		kfree(fixup);
diff --git a/fs/file.c b/fs/file.c
index 7ffd6e9d103d64..8d059d8973e9fc 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -640,6 +640,35 @@ int __close_fd(struct files_struct *files, unsigned fd)
 }
 EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
 
+/*
+ * variant of __close_fd that gets a ref on the file for later fput
+ */
+int __close_fd_get_file(unsigned int fd, struct file **res)
+{
+	struct files_struct *files = current->files;
+	struct file *file;
+	struct fdtable *fdt;
+
+	spin_lock(&files->file_lock);
+	fdt = files_fdtable(files);
+	if (fd >= fdt->max_fds)
+		goto out_unlock;
+	file = fdt->fd[fd];
+	if (!file)
+		goto out_unlock;
+	rcu_assign_pointer(fdt->fd[fd], NULL);
+	__put_unused_fd(files, fd);
+	spin_unlock(&files->file_lock);
+	get_file(file);
+	*res = file;
+	return filp_close(file, files);
+
+out_unlock:
+	spin_unlock(&files->file_lock);
+	*res = NULL;
+	return -ENOENT;
+}
+
 void do_close_on_exec(struct files_struct *files)
 {
 	unsigned i;
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 41615f38bcff3e..f07c55ea0c22f1 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -121,6 +121,7 @@ extern void __fd_install(struct files_struct *files,
 		      unsigned int fd, struct file *file);
 extern int __close_fd(struct files_struct *files,
 		      unsigned int fd);
+extern int __close_fd_get_file(unsigned int fd, struct file **res);
 
 extern struct kmem_cache *files_cachep;
 
-- 
2.20.0.405.gbc1bbc6f85-goog

