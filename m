Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4335CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D479E204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="ehP2sAdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D479E204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbeIFUFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:05:51 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44459 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730353AbeIFUFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:05:50 -0400
Received: by mail-qt0-f195.google.com with SMTP id k38-v6so12690444qtk.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 08:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NJJQvHJPIv8dXBL7+WOaDttW/sjhnmePOtNSTP7rgtU=;
        b=ehP2sAdviXj1Pd7NkZ1S++eNvpRdJoEC/08eBe/If7rwsxTHP91TNqRGDE9b0RBH8w
         WaN0pde82vTeBa74jpJohO5aBqb12cpHLViwdvf4trr7xWvDN0/dj0F7DKmUJUUI8UYp
         296JTpMIcKupL3v5XA3adimRYBWg6/Om64aFH3lQoMStcGTt0y5zKoAnXoRO/E1yhEXY
         gJNEFBupKJl552dwstLIpTPVdaPb0kLttV0KldLT3uM6pDodRd7wc1aXudMNAXXinNhD
         OGExhX/yr/5sFyDF20XcDftA9vp2tx9xvy/uBstNi4p55uPPj0ghsyg0UAkY/8sbwBmw
         SX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NJJQvHJPIv8dXBL7+WOaDttW/sjhnmePOtNSTP7rgtU=;
        b=ikHyw/1JIH3666yZoRr3lEa4MUNJBuiWHnxciKZSCmBMTYalHxyd3FBndSfQfNUJoB
         FJPqjnuaNwGHZ8K9xfi5KjAm8SOM1PF2iLfbQs68wN17hQATtO6/Y6TLxiHUzaeN++pt
         kpxpp2WLswV8oH5oQTzE2YWYOUJi7+B3a4bLJ1Pew5llrGedaXwdCUxqHdnwI9TdcPXF
         LNTHU/J3yvE9kjeC21yaNIr1Wt3OdVwJOOLDILiIUCkuaUnO9hnnEK0wbfQQhegBnhjE
         HEGd0PHEhVjF8iRuz0fKnBUrL/pkKlpceTKgdljaNfof3CBcs+XW9aE3A6KH5pxdsOWc
         LW1w==
X-Gm-Message-State: APzg51Dn2CNwAbgBQUjA7E4LALU2xnZa29M1FExa37yKI9PcZGE8qhoi
        WI0hZXbwI6DkQnIU2lnqdgGPCw==
X-Google-Smtp-Source: ANB0VdZBj9Qi7pUnqk6FmVDCmdJXVWI8gDXXDhSlG5Vr6b3bu2UCi2NbAloyaomqoId0L9LY7NH50w==
X-Received: by 2002:ad4:420a:: with SMTP id k10-v6mr2515084qvp.212.1536247786503;
        Thu, 06 Sep 2018 08:29:46 -0700 (PDT)
Received: from localhost.localdomain ([173.38.117.76])
        by smtp.gmail.com with ESMTPSA id n8-v6sm3254507qtk.38.2018.09.06.08.29.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 08:29:45 -0700 (PDT)
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
Subject: [PATCH v6 5/5] samples: add an example of seccomp user trap
Date:   Thu,  6 Sep 2018 09:28:59 -0600
Message-Id: <20180906152859.7810-6-tycho@tycho.ws>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180906152859.7810-1-tycho@tycho.ws>
References: <20180906152859.7810-1-tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea here is just to give a demonstration of how one could safely use
the SECCOMP_RET_USER_NOTIF feature to do mount policies. This particular
policy is (as noted in the comment) not very interesting, but it serves to
illustrate how one might apply a policy dodging the various TOCTOU issues.

v5: new in v5

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
 samples/seccomp/.gitignore  |   1 +
 samples/seccomp/Makefile    |   7 +-
 samples/seccomp/user-trap.c | 312 ++++++++++++++++++++++++++++++++++++
 3 files changed, 319 insertions(+), 1 deletion(-)

diff --git a/samples/seccomp/.gitignore b/samples/seccomp/.gitignore
index 78fb78184291..d1e2e817d556 100644
--- a/samples/seccomp/.gitignore
+++ b/samples/seccomp/.gitignore
@@ -1,3 +1,4 @@
 bpf-direct
 bpf-fancy
 dropper
+user-trap
diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
index cf34ff6b4065..4920903c8009 100644
--- a/samples/seccomp/Makefile
+++ b/samples/seccomp/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 ifndef CROSS_COMPILE
-hostprogs-$(CONFIG_SAMPLE_SECCOMP) := bpf-fancy dropper bpf-direct
+hostprogs-$(CONFIG_SAMPLE_SECCOMP) := bpf-fancy dropper bpf-direct user-trap
 
 HOSTCFLAGS_bpf-fancy.o += -I$(objtree)/usr/include
 HOSTCFLAGS_bpf-fancy.o += -idirafter $(objtree)/include
@@ -16,6 +16,10 @@ HOSTCFLAGS_bpf-direct.o += -I$(objtree)/usr/include
 HOSTCFLAGS_bpf-direct.o += -idirafter $(objtree)/include
 bpf-direct-objs := bpf-direct.o
 
+HOSTCFLAGS_user-trap.o += -I$(objtree)/usr/include
+HOSTCFLAGS_user-trap.o += -idirafter $(objtree)/include
+user-trap-objs := user-trap.o
+
 # Try to match the kernel target.
 ifndef CONFIG_64BIT
 
@@ -33,6 +37,7 @@ HOSTCFLAGS_bpf-fancy.o += $(MFLAG)
 HOSTLDLIBS_bpf-direct += $(MFLAG)
 HOSTLDLIBS_bpf-fancy += $(MFLAG)
 HOSTLDLIBS_dropper += $(MFLAG)
+HOSTLDLIBS_user-trap += $(MFLAG)
 endif
 always := $(hostprogs-m)
 endif
diff --git a/samples/seccomp/user-trap.c b/samples/seccomp/user-trap.c
new file mode 100644
index 000000000000..571eb32fd80b
--- /dev/null
+++ b/samples/seccomp/user-trap.c
@@ -0,0 +1,312 @@
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <string.h>
+#include <stddef.h>
+#include <sys/sysmacros.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <sys/user.h>
+#include <sys/ioctl.h>
+#include <sys/ptrace.h>
+#include <sys/mount.h>
+#include <linux/limits.h>
+#include <linux/filter.h>
+#include <linux/seccomp.h>
+
+/*
+ * Because of some grossness, we can't include linux/ptrace.h here, so we
+ * re-define PTRACE_SECCOMP_NEW_LISTENER.
+ */
+#ifndef PTRACE_SECCOMP_NEW_LISTENER
+#define PTRACE_SECCOMP_NEW_LISTENER	0x420e
+#endif
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
+
+static int seccomp(unsigned int op, unsigned int flags, void *args)
+{
+	errno = 0;
+	return syscall(__NR_seccomp, op, flags, args);
+}
+
+static int user_trap_syscall(int nr, unsigned int flags)
+{
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_LD+BPF_W+BPF_ABS,
+			offsetof(struct seccomp_data, nr)),
+		BPF_JUMP(BPF_JMP+BPF_JEQ+BPF_K, nr, 0, 1),
+		BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_USER_NOTIF),
+		BPF_STMT(BPF_RET+BPF_K, SECCOMP_RET_ALLOW),
+	};
+
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	return seccomp(SECCOMP_SET_MODE_FILTER, flags, &prog);
+}
+
+static int handle_req(struct seccomp_notif *req,
+		      struct seccomp_notif_resp *resp, int listener)
+{
+	char path[PATH_MAX], source[PATH_MAX], target[PATH_MAX];
+	int ret = -1, mem;
+
+	resp->len = sizeof(*resp);
+	resp->id = req->id;
+	resp->error = -EPERM;
+	resp->val = 0;
+
+	if (req->data.nr != __NR_mount) {
+		fprintf(stderr, "huh? trapped something besides mknod? %d\n", req->data.nr);
+		return -1;
+	}
+
+	/* Only allow bind mounts. */
+	if (!(req->data.args[3] & MS_BIND))
+		return 0;
+
+	/*
+	 * Ok, let's read the task's memory to see where they wanted their
+	 * mount to go.
+	 */
+	snprintf(path, sizeof(path), "/proc/%d/mem", req->pid);
+	mem = open(path, O_RDONLY);
+	if (mem < 0) {
+		perror("open mem");
+		return -1;
+	}
+
+	/*
+	 * Now we avoid a TOCTOU: we referred to a pid by its pid, but since
+	 * the pid that made the syscall may have died, we need to confirm that
+	 * the pid is still valid after we open its /proc/pid/mem file. We can
+	 * ask the listener fd this as follows.
+	 *
+	 * Note that this check should occur *after* any task-specific
+	 * resources are opened, to make sure that the task has not died and
+	 * we're not wrongly reading someone else's state in order to make
+	 * decisions.
+	 */
+	if (ioctl(listener, SECCOMP_NOTIF_IS_ID_VALID, &req->id) != 1) {
+		fprintf(stderr, "task died before we could map its memory\n");
+		goto out;
+	}
+
+	/*
+	 * Phew, we've got the right /proc/pid/mem. Now we can read it. Note
+	 * that to avoid another TOCTOU, we should read all of the pointer args
+	 * before we decide to allow the syscall.
+	 */
+	if (lseek(mem, req->data.args[0], SEEK_SET) < 0) {
+		perror("seek");
+		goto out;
+	}
+
+	ret = read(mem, source, sizeof(source));
+	if (ret < 0) {
+		perror("read");
+		goto out;
+	}
+
+	if (lseek(mem, req->data.args[1], SEEK_SET) < 0) {
+		perror("seek");
+		goto out;
+	}
+
+	ret = read(mem, target, sizeof(target));
+	if (ret < 0) {
+		perror("read");
+		goto out;
+	}
+
+	/*
+	 * Our policy is to only allow bind mounts inside /tmp. This isn't very
+	 * interesting, because we could do unprivlieged bind mounts with user
+	 * namespaces already, but you get the idea.
+	 */
+	if (!strncmp(source, "/tmp", 4) && !strncmp(target, "/tmp", 4)) {
+		if (mount(source, target, NULL, req->data.args[3], NULL) < 0) {
+			ret = -1;
+			perror("actual mount");
+			goto out;
+		}
+		resp->error = 0;
+	}
+
+	/* Even if we didn't allow it because of policy, generating the
+	 * response was be a success, because we want to tell the worker EPERM.
+	 */
+	ret = 0;
+
+out:
+	close(mem);
+	return ret;
+}
+
+int main(void)
+{
+	int sk_pair[2], ret = 1, status, listener;
+	pid_t worker = 0 , tracer = 0;
+	char c;
+
+	if (socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair) < 0) {
+		perror("socketpair");
+		return 1;
+	}
+
+	worker = fork();
+	if (worker < 0) {
+		perror("fork");
+		goto close_pair;
+	}
+
+	if (worker == 0) {
+		if (user_trap_syscall(__NR_mount, 0) < 0) {
+			perror("seccomp");
+			exit(1);
+		}
+
+		if (setuid(1000) < 0) {
+			perror("setuid");
+			exit(1);
+		}
+
+		if (write(sk_pair[1], "a", 1) != 1) {
+			perror("write");
+			exit(1);
+		}
+
+		if (read(sk_pair[1], &c, 1) != 1) {
+			perror("write");
+			exit(1);
+		}
+
+		if (mkdir("/tmp/foo", 0755) < 0) {
+			perror("mkdir");
+			exit(1);
+		}
+
+		if (mount("/dev/sda", "/tmp/foo", NULL, 0, NULL) != -1) {
+			fprintf(stderr, "huh? mounted /dev/sda?\n");
+			exit(1);
+		}
+
+		if (errno != EPERM) {
+			perror("bad error from mount");
+			exit(1);
+		}
+
+		if (mount("/tmp/foo", "/tmp/foo", NULL, MS_BIND, NULL) < 0) {
+			perror("mount");
+			exit(1);
+		}
+
+		exit(0);
+	}
+
+	if (read(sk_pair[0], &c, 1) != 1) {
+		perror("read ready signal");
+		goto out_kill;
+	}
+
+	if (ptrace(PTRACE_ATTACH, worker) < 0) {
+		perror("ptrace");
+		goto out_kill;
+	}
+
+	if (waitpid(worker, NULL, 0) != worker) {
+		perror("waitpid");
+		goto out_kill;
+	}
+
+	listener = ptrace(PTRACE_SECCOMP_NEW_LISTENER, worker, 0);
+	if (listener < 0) {
+		perror("ptrace get listener");
+		goto out_kill;
+	}
+
+	if (ptrace(PTRACE_DETACH, worker, NULL, 0) < 0) {
+		perror("ptrace detach");
+		goto out_kill;
+	}
+
+	if (write(sk_pair[0], "a", 1) != 1) {
+		perror("write");
+		exit(1);
+	}
+
+	tracer = fork();
+	if (tracer < 0) {
+		perror("fork");
+		goto out_kill;
+	}
+
+	if (tracer == 0) {
+		while (1) {
+			struct seccomp_notif req = {};
+			struct seccomp_notif_resp resp = {};
+
+			req.len = sizeof(req);
+			if (ioctl(listener, SECCOMP_NOTIF_RECV, &req) != sizeof(req)) {
+				perror("ioctl recv");
+				goto out_close;
+			}
+
+			if (handle_req(&req, &resp, listener) < 0)
+				goto out_close;
+
+			if (ioctl(listener, SECCOMP_NOTIF_SEND, &resp) != sizeof(resp)) {
+				perror("ioctl send");
+				goto out_close;
+			}
+		}
+out_close:
+		close(listener);
+		exit(1);
+	}
+
+	close(listener);
+
+	if (waitpid(worker, &status, 0) != worker) {
+		perror("waitpid");
+		goto out_kill;
+	}
+
+	if (umount2("/tmp/foo", MNT_DETACH) < 0 && errno != EINVAL) {
+		perror("umount2");
+		goto out_kill;
+	}
+
+	if (remove("/tmp/foo") < 0 && errno != ENOENT) {
+		perror("remove");
+		exit(1);
+	}
+
+	if (!WIFEXITED(status) || WEXITSTATUS(status)) {
+		fprintf(stderr, "worker exited nonzero\n");
+		goto out_kill;
+	}
+
+	ret = 0;
+
+out_kill:
+	if (tracer > 0)
+		kill(tracer, SIGKILL);
+	if (worker > 0)
+		kill(worker, SIGKILL);
+
+close_pair:
+	close(sk_pair[0]);
+	close(sk_pair[1]);
+	return ret;
+}
-- 
2.17.1

