Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECD9C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D697F2246B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="dlZY5dt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D697F2246B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933932AbeFUWFU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:05:20 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:32861 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933801AbeFUWEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:04:51 -0400
Received: by mail-qk0-f194.google.com with SMTP id c131-v6so2685769qkb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 15:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2/bvuqtWHLUypoE2Q+14Y2MuWToR1uUHGjIGMfnaSuU=;
        b=dlZY5dt7y3YqI5xpnOGKJZO0iDng/T/BWcKHv0IxdwTc9lVSbFy6J+AXerxFy8k1u6
         FVm64hWfPmtBe19FzvP3SzctppHKCeGnUWZ9hAbJeOpin4xoPhCWyOU0VFbo/FqcgJzn
         muDoIqkYiM7Is5h0Y+2XqA+kq2uNxYdw3qQD8SaRmNkyhTfW6I9/UfHOM9S9Hriww9YI
         ieY/09EPSKLsjHGvXhFV0TptyZ+ytPHC9KiR62+dDaBd/bLEJA/K+r3ML8pxeS8VEVYg
         0SVlYkRcFeWiUUkiGaT3jW9koCDVWHCjVoKBJvXUnH2cnwb7t6xY4WlZSW80xfrIuSVv
         cyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2/bvuqtWHLUypoE2Q+14Y2MuWToR1uUHGjIGMfnaSuU=;
        b=uZJlO8xLLb19qBxdLrJ3FBzlccVoLfnYkJji6ewDRFcBxXpP9i4B8AJgqtxuBih3qj
         h/wREY4eJY1MyZmYTq2xyQyZ4qs7NYXA43DwEIjrsQkthN+IupFOnwWYFM39TaLI23QP
         ULmQsoa0hbAjsjad92S9W7rI7yFJCyj9tgUkI4xjnQ8Yu03IW8onH2hs7ljLwbFFmCBh
         YBQCO4aHU6Cbya7YSfwnSvqcccgRxhCRG8qvB6unGa33aXdZ6N5p8LLUkUPKuZEBOV2X
         KUJGv85S6ptGQjVnyOiMdiK3r6bsSwAqIC18wpeLS5vAhR+6SxYD8TuJTCCn1jY1051O
         8p+w==
X-Gm-Message-State: APt69E3krNwemZGV0vZmt9Ivqzyjig3lTUPbG0t8N/rN1G334m2/2gq2
        rZ6TJFIYoDI55F8a29exti5kKQ==
X-Google-Smtp-Source: ADUXVKL5KPWeIoCUpg0pNYunNc2XjE+nf5LU+TBhvQFF8XQu4ZAk/sVllq0vVv24i8HuAraYe5r+tQ==
X-Received: by 2002:a37:66c5:: with SMTP id a188-v6mr23366836qkc.201.1529618690098;
        Thu, 21 Jun 2018 15:04:50 -0700 (PDT)
Received: from localhost.localdomain ([173.38.117.67])
        by smtp.gmail.com with ESMTPSA id l73-v6sm6668473qkl.78.2018.06.21.15.04.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 15:04:49 -0700 (PDT)
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
        "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v4 4/4] seccomp: add support for passing fds via USER_NOTIF
Date:   Thu, 21 Jun 2018 16:04:16 -0600
Message-Id: <20180621220416.5412-5-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621220416.5412-1-tycho@tycho.ws>
References: <20180621220416.5412-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea here is that the userspace handler should be able to pass an fd
back to the trapped task, for example so it can be returned from socket().

I've proposed one API here, but I'm open to other options. In particular,
this only lets you return an fd from a syscall, which may not be enough in
all cases. For example, if an fd is written to an output parameter instead
of returned, the current API can't handle this. Another case is that
netlink takes as input fds sometimes (IFLA_NET_NS_FD, e.g.). If netlink
ever decides to install an fd and output it, we wouldn't be able to handle
this either.

Still, the vast majority of interesting cases are covered by this API, so
perhaps it is Enough.

I've left it as a separate commit for two reasons:
  * It illustrates the way in which we would grow struct seccomp_notif and
    struct seccomp_notif_resp without using netlink
  * It shows just how little code is needed to accomplish this :)

v2: new in v2
v3: no changes
v4: * pass fd flags back from userspace as well (Jann)
    * update same cgroup data on fd pass as SCM_RIGHTS (Alban)
    * only set the REPLIED state /after/ successful fdget (Alban)
    * reflect GET_LISTENER -> NEW_LISTENER changes
    * add to the new Documentation/ on user notifications about fd replies

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
 .../userspace-api/seccomp_filter.rst          |  11 ++
 include/uapi/linux/seccomp.h                  |   3 +
 kernel/seccomp.c                              |  51 +++++++-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 114 ++++++++++++++++++
 4 files changed, 177 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
index e51422559dd6..3db93df254fb 100644
--- a/Documentation/userspace-api/seccomp_filter.rst
+++ b/Documentation/userspace-api/seccomp_filter.rst
@@ -232,6 +232,9 @@ The interface for a seccomp notification fd consists of two structures:
         __u64 id;
         __s32 error;
         __s64 val;
+        __u8 return_fd;
+        __u32 fd;
+        __u32 fd_flags;
     };
 
 Users can ``read()`` or ``poll()`` on a seccomp notification fd to receive a
@@ -251,6 +254,14 @@ mentioned above in this document: all arguments being read from the tracee's
 memory should be read into the tracer's memory before any policy decisions are
 made. This allows for an atomic decision on syscall arguments.
 
+Userspace can also return file descriptors. For example, one may decide to
+intercept ``socket()`` syscalls, and return some file descriptor from those
+based on some policy. To return a file descriptor, the ``return_fd`` member
+should be non-zero, the ``fd`` argument should be the fd in the listener's
+table to send to the tracee (similar to how ``SCM_RIGHTS`` works), and
+``fd_flags`` should be the flags that the fd in the tracee's table is opened
+with (e.g. ``O_EXCL`` or similar).
+
 Sysctls
 =======
 
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index 8836a3b25500..ed2a475e0fe6 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -72,6 +72,9 @@ struct seccomp_notif_resp {
 	__u64 id;
 	__s32 error;
 	__s64 val;
+	__u8 return_fd;
+	__u32 fd;
+	__u32 fd_flags;
 };
 
 #endif /* _UAPI_LINUX_SECCOMP_H */
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index b68a5d4a15cd..abd6e8c7e64e 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -43,6 +43,7 @@
 
 #ifdef CONFIG_SECCOMP_USER_NOTIFICATION
 #include <linux/anon_inodes.h>
+#include <net/cls_cgroup.h>
 
 enum notify_state {
 	SECCOMP_NOTIFY_INIT,
@@ -77,6 +78,8 @@ struct seccomp_knotif {
 	/* The return values, only valid when in SECCOMP_NOTIFY_REPLIED */
 	int error;
 	long val;
+	struct file *file;
+	unsigned int flags;
 
 	/* Signals when this has entered SECCOMP_NOTIFY_REPLIED */
 	struct completion ready;
@@ -796,10 +799,44 @@ static void seccomp_do_user_notification(int this_syscall,
 			goto remove_list;
 	}
 
-	ret = n.val;
-	err = n.error;
+	if (n.file) {
+		int fd;
+		struct socket *sock;
+
+		fd = get_unused_fd_flags(n.flags);
+		if (fd < 0) {
+			err = fd;
+			ret = -1;
+			goto remove_list;
+		}
+
+		/*
+		 * Similar to what SCM_RIGHTS does, let's re-set the cgroup
+		 * data to point ot the tracee's cgroups instead of the
+		 * listener's.
+		 */
+		sock = sock_from_file(n.file, &err);
+		if (sock) {
+			sock_update_netprioidx(&sock->sk->sk_cgrp_data);
+			sock_update_classid(&sock->sk->sk_cgrp_data);
+		}
+
+		ret = fd;
+		err = 0;
+
+		fd_install(fd, n.file);
+		/* Don't fput, since fd has a reference now */
+		n.file = NULL;
+	} else {
+		ret = n.val;
+		err = n.error;
+	}
+
 
 remove_list:
+	if (n.file)
+		fput(n.file);
+
 	list_del(&n.list);
 out:
 	mutex_unlock(&match->notify_lock);
@@ -1669,10 +1706,20 @@ static ssize_t seccomp_notify_write(struct file *file, const char __user *buf,
 		goto out;
 	}
 
+	if (resp.return_fd) {
+		knotif->flags = resp.fd_flags;
+		knotif->file = fget(resp.fd);
+		if (!knotif->file) {
+			ret = -EBADF;
+			goto out;
+		}
+	}
+
 	ret = size;
 	knotif->state = SECCOMP_NOTIFY_REPLIED;
 	knotif->error = resp.error;
 	knotif->val = resp.val;
+
 	complete(&knotif->ready);
 out:
 	mutex_unlock(&filter->notify_lock);
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index dde64178593b..c80ccb21f3a1 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -171,6 +171,9 @@ struct seccomp_notif_resp {
 	__u64 id;
 	__s32 error;
 	__s64 val;
+	__u8 return_fd;
+	__u32 fd;
+	__u32 fd_flags;
 };
 #endif
 
@@ -3213,6 +3216,117 @@ TEST(get_user_notification_ptrace)
 	close(listener);
 }
 
+TEST(user_notification_pass_fd)
+{
+	pid_t pid;
+	int status, listener;
+	int sk_pair[2];
+	char c;
+	struct seccomp_notif req = {};
+	struct seccomp_notif_resp resp = {};
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
+	resp.id = req.id;
+	resp.return_fd = 1;
+	resp.fd = sk_pair[1];
+	resp.fd_flags = 0;
+	EXPECT_EQ(write(listener, &resp, sizeof(resp)), sizeof(resp));
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
+TEST(user_notification_struct_size_mismatch)
+{
+	pid_t pid;
+	long ret;
+	int status, listener, len;
+	struct seccomp_notif req;
+	struct seccomp_notif_resp resp;
+
+	listener = user_trap_syscall(__NR_getpid,
+				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	EXPECT_GE(listener, 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ret = syscall(__NR_getpid);
+		exit(ret != USER_NOTIF_MAGIC);
+	}
+
+	EXPECT_EQ(read(listener, &req, sizeof(req)), sizeof(req));
+
+	resp.id = req.id;
+	resp.error = 0;
+	resp.val = USER_NOTIF_MAGIC;
+
+	/*
+	 * Only write a partial structure: this is what was available before we
+	 * had fd support.
+	 */
+	len = offsetof(struct seccomp_notif_resp, val) + sizeof(resp.val);
+	EXPECT_EQ(write(listener, &resp, len), len);
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
 /*
  * Check that a pid in a child namespace still shows up as valid in ours.
  */
-- 
2.17.1

