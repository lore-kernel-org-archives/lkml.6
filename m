Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4739C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678072172E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="hvQ+4o9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678072172E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeI0Vaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:30:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40109 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbeI0Va3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:30:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id s5-v6so2130384pfj.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D0c4pyDwFmUjQbrWpRi35g8ZBVegN6wTosLVIWzhntg=;
        b=hvQ+4o9KIsjo9OeJaYZlT6KrN9aHQW4QW7fBDFcAGaNCDV5NZR1n5j2e/hI901j8Ok
         qYzd/1VTZ+/IkNu7r4Xz9u6Fxcfx0V/2UDT8rswuGx02WPwVIxYQbymTLz11K3n+lduG
         DtE0ACz7NFJPgBcA7QwqC85PfX7q2BIaR32A22eS1QFOogMI/oAjHc8FwanfeugWgI5O
         SLN4MhoIbhO8ihEWxbxVcfHdqXEs0XnEY5jpPok8Is0KVP1I44oAsgNpYtLbU7qsVdM8
         A514rO1g2MIdUHLprRXNTkYyFnSYK/7ju9dltTN6sjTP3dxzSPhNlVAVCx5tf3oEmidX
         UEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D0c4pyDwFmUjQbrWpRi35g8ZBVegN6wTosLVIWzhntg=;
        b=NehToo20GNHN+2EKhFI8iVZz7PMpKQAjneCOF3rI6GEd5msIDCm7CP9tY3vLnAavNX
         kmmPLOBwfQMwhrIDolYfl2M2WHCjZNRaqpRa0FGIqIABa/QgFMFMoI1HkxQS2vR6LejO
         CzN5TrAJmX7uGBGDBx1ISznBxxJ1fkYQl/sA7bXkL67A9gmInLqrK0HWkTksmEZvEVRc
         GaddJxGj1BoNbnxjcD6PnlS8JJt/pYD0Ll/BkxeYm4z7DegK1kZgV7S/DvW3TYlBetiO
         ixby41IOWpB/Hwpy4q/WeqeEQk6xG6BnLuB+4xNfepLSN7TkZgUhOpIlmqnSj07Z3ROz
         vKwQ==
X-Gm-Message-State: ABuFfohBaIZInmS00+XtRba8I07t2dwpZMOsgduNk8J5Mz2Xxj6M9vbi
        ym/RZZIzB+HlKv+lCYysI2wBzA==
X-Google-Smtp-Source: ACcGV63bZ9ufrS8+ONCL4xatX4nnDBcCIQfEvKHS3jnth4pv7bQquUnzEe1zz+hIRWar5HHAWeCYjQ==
X-Received: by 2002:a63:8742:: with SMTP id i63-v6mr10772300pge.27.1538061106126;
        Thu, 27 Sep 2018 08:11:46 -0700 (PDT)
Received: from localhost.localdomain ([128.107.241.178])
        by smtp.gmail.com with ESMTPSA id y19-v6sm5429610pff.14.2018.09.27.08.11.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 08:11:45 -0700 (PDT)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v7 5/6] seccomp: add a way to pass FDs via a notification fd
Date:   Thu, 27 Sep 2018 09:11:18 -0600
Message-Id: <20180927151119.9989-6-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927151119.9989-1-tycho@tycho.ws>
References: <20180927151119.9989-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a way to insert FDs into the tracee's process (also
close/overwrite fds for the tracee). This functionality is necessary to
mock things like socketpair() or dup2() or similar, but since it depends on
external (vfs) patches, I've left it as a separate patch as before so the
core functionality can still be merged while we argue about this. Except
this time it doesn't add any ugliness to the API :)

v7: new in v7

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
CC: Kees Cook <keescook@chromium.org>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Oleg Nesterov <oleg@redhat.com>
CC: Eric W. Biederman <ebiederm@xmission.com>
CC: "Serge E. Hallyn" <serge@hallyn.com>
CC: Christian Brauner <christian.brauner@ubuntu.com>
CC: Tyler Hicks <tyhicks@canonical.com>
CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
---
 .../userspace-api/seccomp_filter.rst          |  16 +++
 include/uapi/linux/seccomp.h                  |   9 ++
 kernel/seccomp.c                              |  54 ++++++++
 tools/testing/selftests/seccomp/seccomp_bpf.c | 126 ++++++++++++++++++
 4 files changed, 205 insertions(+)

diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
index d2e61f1c0a0b..383a8dbae304 100644
--- a/Documentation/userspace-api/seccomp_filter.rst
+++ b/Documentation/userspace-api/seccomp_filter.rst
@@ -237,6 +237,13 @@ The interface for a seccomp notification fd consists of two structures:
         __s64 val;
     };
 
+    struct seccomp_notif_put_fd {
+        __u64 id;
+        __s32 fd;
+        __u32 fd_flags;
+        __s32 to_replace;
+    };
+
 Users can read via ``ioctl(SECCOMP_NOTIF_RECV)``  (or ``poll()``) on a seccomp
 notification fd to receive a ``struct seccomp_notif``, which contains five
 members: the input length of the structure, a unique-per-filter ``id``, the
@@ -256,6 +263,15 @@ mentioned above in this document: all arguments being read from the tracee's
 memory should be read into the tracer's memory before any policy decisions are
 made. This allows for an atomic decision on syscall arguments.
 
+Userspace can also insert (or overwrite) file descriptors of the tracee using
+``ioctl(SECCOMP_NOTIF_PUT_FD)``. The ``id`` member is the request/pid to insert
+the fd into. The ``fd`` is the fd in the listener's table to send or ``-1`` if
+an fd should be closed instead. The ``to_replace`` fd is the fd in the tracee's
+table that should be overwritten, or -1 if a new fd is installed. ``fd_flags``
+should be the flags that the fd in the tracee's table is opened with (e.g.
+``O_CLOEXEC`` or similar). The return value from this ioctl is the fd number
+that was installed.
+
 Sysctls
 =======
 
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index d4ccb32fe089..91d77f041fbb 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -77,6 +77,13 @@ struct seccomp_notif_resp {
 	__s64 val;
 };
 
+struct seccomp_notif_put_fd {
+	__u64 id;
+	__s32 fd;
+	__u32 fd_flags;
+	__s32 to_replace;
+};
+
 #define SECCOMP_IOC_MAGIC		0xF7
 
 /* Flags for seccomp notification fd ioctl. */
@@ -86,5 +93,7 @@ struct seccomp_notif_resp {
 					struct seccomp_notif_resp)
 #define SECCOMP_NOTIF_ID_VALID	_IOR(SECCOMP_IOC_MAGIC, 2,	\
 					__u64)
+#define SECCOMP_NOTIF_PUT_FD	_IOR(SECCOMP_IOC_MAGIC, 3,	\
+					struct seccomp_notif_put_fd)
 
 #endif /* _UAPI_LINUX_SECCOMP_H */
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 17685803a2af..07a05ad59731 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -41,6 +41,8 @@
 #include <linux/tracehook.h>
 #include <linux/uaccess.h>
 #include <linux/anon_inodes.h>
+#include <linux/fdtable.h>
+#include <net/cls_cgroup.h>
 
 enum notify_state {
 	SECCOMP_NOTIFY_INIT,
@@ -1684,6 +1686,56 @@ static long seccomp_notify_id_valid(struct seccomp_filter *filter,
 	return ret;
 }
 
+static long seccomp_notify_put_fd(struct seccomp_filter *filter,
+				  unsigned long arg)
+{
+	struct seccomp_notif_put_fd req;
+	void __user *buf = (void __user *)arg;
+	struct seccomp_knotif *knotif = NULL;
+	long ret;
+
+	if (copy_from_user(&req, buf, sizeof(req)))
+		return -EFAULT;
+
+	if (req.fd < 0 && req.to_replace < 0)
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&filter->notify_lock);
+	if (ret < 0)
+		return ret;
+
+	ret = -ENOENT;
+	list_for_each_entry(knotif, &filter->notif->notifications, list) {
+		struct file *file = NULL;
+
+		if (knotif->id != req.id)
+			continue;
+
+		if (req.fd >= 0)
+			file = fget(req.fd);
+
+		if (req.to_replace >= 0) {
+			ret = replace_fd_task(knotif->task, req.to_replace,
+					      file, req.fd_flags);
+		} else {
+			unsigned long max_files;
+
+			max_files = task_rlimit(knotif->task, RLIMIT_NOFILE);
+			ret = __alloc_fd(knotif->task->files, 0, max_files,
+					 req.fd_flags);
+			if (ret < 0)
+				break;
+
+			__fd_install(knotif->task->files, ret, file);
+		}
+
+		break;
+	}
+
+	mutex_unlock(&filter->notify_lock);
+	return ret;
+}
+
 static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
 				 unsigned long arg)
 {
@@ -1696,6 +1748,8 @@ static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
 		return seccomp_notify_send(filter, arg);
 	case SECCOMP_NOTIF_ID_VALID:
 		return seccomp_notify_id_valid(filter, arg);
+	case SECCOMP_NOTIF_PUT_FD:
+		return seccomp_notify_put_fd(filter, arg);
 	default:
 		return -EINVAL;
 	}
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index c6ba3ed5392e..cd1322c02b92 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -43,6 +43,7 @@
 #include <sys/times.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
+#include <linux/kcmp.h>
 
 #include <unistd.h>
 #include <sys/syscall.h>
@@ -169,6 +170,9 @@ struct seccomp_metadata {
 					struct seccomp_notif_resp)
 #define SECCOMP_NOTIF_ID_VALID	_IOR(SECCOMP_IOC_MAGIC, 2,	\
 					__u64)
+#define SECCOMP_NOTIF_PUT_FD	_IOR(SECCOMP_IOC_MAGIC, 3,	\
+					struct seccomp_notif_put_fd)
+
 struct seccomp_notif {
 	__u16 len;
 	__u64 id;
@@ -183,6 +187,13 @@ struct seccomp_notif_resp {
 	__s32 error;
 	__s64 val;
 };
+
+struct seccomp_notif_put_fd {
+	__u64 id;
+	__s32 fd;
+	__u32 fd_flags;
+	__s32 to_replace;
+};
 #endif
 
 #ifndef seccomp
@@ -193,6 +204,14 @@ int seccomp(unsigned int op, unsigned int flags, void *args)
 }
 #endif
 
+#ifndef kcmp
+int kcmp(pid_t pid1, pid_t pid2, int type, unsigned long idx1,
+	 unsigned long idx2)
+{
+	return syscall(__NR_kcmp, pid1, pid2, type, idx1, idx2);
+}
+#endif
+
 #ifndef PTRACE_SECCOMP_NEW_LISTENER
 #define PTRACE_SECCOMP_NEW_LISTENER 0x420e
 #endif
@@ -3243,6 +3262,113 @@ TEST(get_user_notification_ptrace)
 	close(listener);
 }
 
+TEST(user_notification_pass_fd)
+{
+	pid_t pid;
+	int status, listener, fd;
+	int sk_pair[2];
+	char c;
+	struct seccomp_notif req = {};
+	struct seccomp_notif_resp resp = {};
+	struct seccomp_notif_put_fd putfd = {};
+	long ret;
+
+	ASSERT_EQ(socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		int fd;
+		char buf[16];
+
+		EXPECT_EQ(user_trap_syscall(__NR_getpid, 0), 0);
+
+		/* Signal we're ready and have installed the filter. */
+		EXPECT_EQ(write(sk_pair[1], "J", 1), 1);
+
+		EXPECT_EQ(read(sk_pair[1], &c, 1), 1);
+		EXPECT_EQ(c, 'H');
+		close(sk_pair[1]);
+
+		/* An fd from getpid(). Let the games begin. */
+		fd = syscall(__NR_getpid);
+		EXPECT_GT(fd, 0);
+		EXPECT_EQ(read(fd, buf, sizeof(buf)), 12);
+		close(fd);
+
+		exit(strcmp("hello world", buf));
+	}
+
+	EXPECT_EQ(read(sk_pair[0], &c, 1), 1);
+	EXPECT_EQ(c, 'J');
+
+	EXPECT_EQ(ptrace(PTRACE_ATTACH, pid), 0);
+	EXPECT_EQ(waitpid(pid, NULL, 0), pid);
+	listener = ptrace(PTRACE_SECCOMP_NEW_LISTENER, pid, 0);
+	EXPECT_GE(listener, 0);
+	EXPECT_EQ(ptrace(PTRACE_DETACH, pid, NULL, 0), 0);
+
+	/* Now signal we are done installing so it can do a getpid */
+	EXPECT_EQ(write(sk_pair[0], "H", 1), 1);
+	close(sk_pair[0]);
+
+	/* Make a new socket pair so we can send half across */
+	EXPECT_EQ(socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair), 0);
+
+	ret = read_notif(listener, &req);
+	EXPECT_EQ(ret, sizeof(req));
+	EXPECT_EQ(errno, 0);
+
+	resp.len = sizeof(resp);
+	resp.id = req.id;
+
+	putfd.id = req.id;
+	putfd.fd_flags = 0;
+
+	/* First, let's just create a new fd with our stdout. */
+	putfd.fd = 0;
+	putfd.to_replace = -1;
+	fd = ioctl(listener, SECCOMP_NOTIF_PUT_FD, &putfd);
+	EXPECT_GE(fd, 0);
+	EXPECT_EQ(kcmp(req.pid, getpid(), KCMP_FILE, fd, 0), 0);
+
+	/* Dup something else over the top of it. */
+	putfd.fd = sk_pair[1];
+	putfd.to_replace = fd;
+	fd = ioctl(listener, SECCOMP_NOTIF_PUT_FD, &putfd);
+	EXPECT_GE(fd, 0);
+	EXPECT_EQ(kcmp(req.pid, getpid(), KCMP_FILE, fd, sk_pair[1]), 0);
+
+	/* Now, try to close it. */
+	putfd.fd = -1;
+	putfd.to_replace = fd;
+	fd = ioctl(listener, SECCOMP_NOTIF_PUT_FD, &putfd);
+	EXPECT_GE(fd, 0);
+	EXPECT_EQ(kcmp(req.pid, getpid(), KCMP_FILE, fd, sk_pair[1]), 1);
+
+	/* Ok, we tried the three cases, now let's do what we really want. */
+	putfd.fd = sk_pair[1];
+	putfd.to_replace = -1;
+	fd = ioctl(listener, SECCOMP_NOTIF_PUT_FD, &putfd);
+	EXPECT_GE(fd, 0);
+	EXPECT_EQ(kcmp(req.pid, getpid(), KCMP_FILE, fd, sk_pair[1]), 0);
+
+	resp.val = fd;
+	resp.error = 0;
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_NOTIF_SEND, &resp), sizeof(resp));
+	close(sk_pair[1]);
+
+	EXPECT_EQ(write(sk_pair[0], "hello world\0", 12), 12);
+	close(sk_pair[0]);
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+	close(listener);
+}
+
 /*
  * Check that a pid in a child namespace still shows up as valid in ours.
  */
-- 
2.17.1

