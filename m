Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27906C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBD92077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="yoq3NinW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBD92077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbeIFUFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:05:46 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36113 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbeIFUFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:05:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id 93-v6so7590758qks.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XpGZxNn0y0DYUFteV51XQsdIMNKsTfp8zyksPeE7mGY=;
        b=yoq3NinWv7sArgdFomqHmltmkv59oJCv/zt8XAs9APkhBAQ2Wjw+DKoJ2FoPaO1cIp
         JbhYuosvGbXClVzrl5eKr5mpW7LLll7JLNEjMFhnz8Vzsb/WF407C7sZ3iu7NIMKUC7P
         z3QYP1cYgns+GNLr6fHTP/+OiZRuvOYJ2yMair6V4/pNvrIT1LIlPZKUwgd69vNdloc+
         DqpkcgJ0GdN+W4ZYLcYcLxyYHRT2Y2q//VWSdpyJitBOo3ZL3QbezAjFAWnjVuQoeypJ
         GyNMj8+8/SbldrGrf+OrNupuQggMLJyc1QcBaJWOpVx8PdSQoRbsPsv2WdtkuNLUDp6m
         NlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XpGZxNn0y0DYUFteV51XQsdIMNKsTfp8zyksPeE7mGY=;
        b=M7Ifl1BbgAvErn+leqgN0MiGHfDACVk6Bk6flpC/P4J3MHE2AuiywTZbPJCSluW5vu
         oegrLQHefpvQZP5kflCAmq50H8XhGrL23esepFzYH8OBq4Dl2mbaw2iquGrsWtKE/Hpa
         zDuJXRgrA7SvidTG5EqbnpuZA7BXzpNyWI1lu4N7CWVPPVvp9q4Jh2bX5MniPth42Jqd
         hp7b7NpPZM7fziNVr0EXju4r5Nf8tTKOuc9uwMKN3q72jXFTku0mFH05gE+pWz+AJXgE
         42DGaYeuENxz/FGrLUKGDjYQXoJme0pX3pGpaag0q8/O8Ybu01/0dhU4BXZmMXa9BwUp
         zghA==
X-Gm-Message-State: APzg51AJEWUEBRj+qqiQAxtR1Fh3xz6U8W3wNoDSAdY3zJztfjSkck9c
        y5GuSoNS74yh5PIAC2r6UFOiBg==
X-Google-Smtp-Source: ANB0VdYZ+OrSVoOJyKxtTTy3bDwXvjK++yt1PIuMBfMbFwp03L6pRYIveM96eOQORMXoovoSkZl+2Q==
X-Received: by 2002:a37:c04f:: with SMTP id o76-v6mr2460188qki.315.1536247781539;
        Thu, 06 Sep 2018 08:29:41 -0700 (PDT)
Received: from localhost.localdomain ([173.38.117.76])
        by smtp.gmail.com with ESMTPSA id n8-v6sm3254507qtk.38.2018.09.06.08.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 08:29:40 -0700 (PDT)
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
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v6 3/5] seccomp: add a way to get a listener fd from ptrace
Date:   Thu,  6 Sep 2018 09:28:57 -0600
Message-Id: <20180906152859.7810-4-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180906152859.7810-1-tycho@tycho.ws>
References: <20180906152859.7810-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As an alternative to SECCOMP_FILTER_FLAG_GET_LISTENER, perhaps a ptrace()
version which can acquire filters is useful. There are at least two reasons
this is preferable, even though it uses ptrace:

1. You can control tasks that aren't cooperating with you
2. You can control tasks whose filters block sendmsg() and socket(); if the
   task installs a filter which blocks these calls, there's no way with
   SECCOMP_FILTER_FLAG_GET_LISTENER to get the fd out to the privileged task.

v2: fix a bug where listener mode was not unset when an unused fd was not
    available
v3: fix refcounting bug (Oleg)
v4: * change the listener's fd flags to be 0
    * rename GET_LISTENER to NEW_LISTENER (Matthew)
v5: * add capable(CAP_SYS_ADMIN) requirement

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
 include/linux/seccomp.h                       | 11 +++
 include/uapi/linux/ptrace.h                   |  2 +
 kernel/ptrace.c                               |  4 ++
 kernel/seccomp.c                              | 31 +++++++++
 tools/testing/selftests/seccomp/seccomp_bpf.c | 68 +++++++++++++++++++
 5 files changed, 116 insertions(+)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 017444b5efed..c17c7d051af0 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -112,4 +112,15 @@ static inline long seccomp_get_metadata(struct task_struct *task,
 	return -EINVAL;
 }
 #endif /* CONFIG_SECCOMP_FILTER && CONFIG_CHECKPOINT_RESTORE */
+
+#ifdef CONFIG_SECCOMP_USER_NOTIFICATION
+extern long seccomp_new_listener(struct task_struct *task,
+				 unsigned long filter_off);
+#else
+static inline long seccomp_new_listener(struct task_struct *task,
+					unsigned long filter_off)
+{
+	return -EINVAL;
+}
+#endif/* CONFIG_SECCOMP_USER_NOTIFICATION */
 #endif /* _LINUX_SECCOMP_H */
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index d5a1b8a492b9..e80ecb1bd427 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -73,6 +73,8 @@ struct seccomp_metadata {
 	__u64 flags;		/* Output: filter's flags */
 };
 
+#define PTRACE_SECCOMP_NEW_LISTENER	0x420e
+
 /* Read signals from a shared (process wide) queue */
 #define PTRACE_PEEKSIGINFO_SHARED	(1 << 0)
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 21fec73d45d4..289960ac181b 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1096,6 +1096,10 @@ int ptrace_request(struct task_struct *child, long request,
 		ret = seccomp_get_metadata(child, addr, datavp);
 		break;
 
+	case PTRACE_SECCOMP_NEW_LISTENER:
+		ret = seccomp_new_listener(child, addr);
+		break;
+
 	default:
 		break;
 	}
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index ed786655186d..580888785324 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1787,6 +1787,37 @@ static struct file *init_listener(struct task_struct *task,
 
 	return ret;
 }
+
+long seccomp_new_listener(struct task_struct *task,
+			  unsigned long filter_off)
+{
+	struct seccomp_filter *filter;
+	struct file *listener;
+	int fd;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	filter = get_nth_filter(task, filter_off);
+	if (IS_ERR(filter))
+		return PTR_ERR(filter);
+
+	fd = get_unused_fd_flags(0);
+	if (fd < 0) {
+		__put_seccomp_filter(filter);
+		return fd;
+	}
+
+	listener = init_listener(task, task->seccomp.filter);
+	__put_seccomp_filter(filter);
+	if (IS_ERR(listener)) {
+		put_unused_fd(fd);
+		return PTR_ERR(listener);
+	}
+
+	fd_install(fd, listener);
+	return fd;
+}
 #else
 static struct file *init_listener(struct task_struct *task,
 				  struct seccomp_filter *filter)
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 89f2c788a06b..61b8e3c5c06b 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -193,6 +193,10 @@ int seccomp(unsigned int op, unsigned int flags, void *args)
 }
 #endif
 
+#ifndef PTRACE_SECCOMP_NEW_LISTENER
+#define PTRACE_SECCOMP_NEW_LISTENER 0x420e
+#endif
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define syscall_arg(_n) (offsetof(struct seccomp_data, args[_n]))
 #elif __BYTE_ORDER == __BIG_ENDIAN
@@ -3165,6 +3169,70 @@ TEST(get_user_notification_syscall)
 	EXPECT_EQ(0, WEXITSTATUS(status));
 }
 
+TEST(get_user_notification_ptrace)
+{
+	pid_t pid;
+	int status, listener;
+	int sk_pair[2];
+	char c;
+	struct seccomp_notif req = {};
+	struct seccomp_notif_resp resp = {};
+
+	ASSERT_EQ(socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		EXPECT_EQ(user_trap_syscall(__NR_getpid, 0), 0);
+
+		/* Test that we get ENOSYS while not attached */
+		EXPECT_EQ(syscall(__NR_getpid), -1);
+		EXPECT_EQ(errno, ENOSYS);
+
+		/* Signal we're ready and have installed the filter. */
+		EXPECT_EQ(write(sk_pair[1], "J", 1), 1);
+
+		EXPECT_EQ(read(sk_pair[1], &c, 1), 1);
+		EXPECT_EQ(c, 'H');
+
+		exit(syscall(__NR_getpid) != USER_NOTIF_MAGIC);
+	}
+
+	EXPECT_EQ(read(sk_pair[0], &c, 1), 1);
+	EXPECT_EQ(c, 'J');
+
+	EXPECT_EQ(ptrace(PTRACE_ATTACH, pid), 0);
+	EXPECT_EQ(waitpid(pid, NULL, 0), pid);
+	listener = ptrace(PTRACE_SECCOMP_NEW_LISTENER, pid, 0);
+	EXPECT_GE(listener, 0);
+
+	/* EBUSY for second listener */
+	EXPECT_EQ(ptrace(PTRACE_SECCOMP_NEW_LISTENER, pid, 0), -1);
+	EXPECT_EQ(errno, EBUSY);
+
+	EXPECT_EQ(ptrace(PTRACE_DETACH, pid, NULL, 0), 0);
+
+	/* Now signal we are done and respond with magic */
+	EXPECT_EQ(write(sk_pair[0], "H", 1), 1);
+
+	req.len = sizeof(req);
+	EXPECT_EQ(ioctl(listener, SECCOMP_NOTIF_RECV, &req), sizeof(req));
+
+	resp.len = sizeof(resp);
+	resp.id = req.id;
+	resp.error = 0;
+	resp.val = USER_NOTIF_MAGIC;
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_NOTIF_SEND, &resp), sizeof(resp));
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	close(listener);
+}
+
 /*
  * Check that a pid in a child namespace still shows up as valid in ours.
  */
-- 
2.17.1

