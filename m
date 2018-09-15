Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F96ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 05:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDA320881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 05:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITQopEHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDA320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeIOK1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 06:27:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44190 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeIOK1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 06:27:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so5186935pff.11;
        Fri, 14 Sep 2018 22:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jlmnHUGC8iL2am7DwiQ3GqGRZEIAp/ZmMc0CVMbI5KA=;
        b=ITQopEHATDiX0sLAFdZQoCbuGOZdnzEZ5TCr1N7PbzlfQ6D/6YeNfojaL7QGMZBj6H
         VG0fip3jfxU4uWgHYGLcppYGUuN0kJ0BfwUwBH77JaPmehoOk43EF1aroMdx2UUPFz5h
         0xcnrfevmw2DkdFFoxuFCaPYDVlkREW2yphG/aPW7sKe+9CMWTK3tZARj4hmS+16zVvA
         D7n6jndIU+DSPU1qdywC+5P7P1zSBJXV2no1beWIKHufiEmR5yYQq/y0ADaKaZRV3siQ
         DyaG3ahgHuoU8xL7bV5krpNcIFNyRoF/uILuFhXPQSJWT9b0Rw4OD/pqlw7naTToSUyt
         UjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jlmnHUGC8iL2am7DwiQ3GqGRZEIAp/ZmMc0CVMbI5KA=;
        b=bERlC5c5ykcOMlKjHFbVmLIfa/oMfGOqOVwSp8NxbNx3Tkti6FRH7bZo6jtB6oKASg
         1yLcaHHhcpEuox71u60VWXOyNjx9s9c8jawFpqhTlnWrdALgoZbyxNtSr3h5Tv23PiWo
         8wa1BsUdReMXcBnfKLW2+eOFbFFK0m90TH/DMKVVNUEtqQ1ggeUuPwShZUIGwkqDHBCQ
         6Up5Tb8o7w/SrigtdxSR83LnmR+muyp2Frop4bMCFMr+HoZ4gSP/0ERFKZGy7xf+GvbP
         gQ65khYdCfC/ErtYjh0CeqVeEsawC/fBEAnWJaofuuqAW3b6VwiKE7zHZlwKvjDyP7Zz
         CLFw==
X-Gm-Message-State: APzg51D4N29toBnwRqFUUIbcOvFXQlLsQaPg+yd7YrEdRx8S4K+EexE+
        +joFOHyZzhwPET1pieS9Ovn6xT6F
X-Google-Smtp-Source: ANB0VdaoItRz3gK31vyTZ71tVsaAqo6ZZHkjSU8V4gpHb6Ot9viyRmrVfoTYnApWHy+54vZHEf2ehQ==
X-Received: by 2002:a63:a319:: with SMTP id s25-v6mr14071892pge.199.1536988172036;
        Fri, 14 Sep 2018 22:09:32 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id g6-v6sm14195676pfb.11.2018.09.14.22.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 22:09:31 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-aio@kvack.org
Subject: [PATCH v2 1/5] signal: Add set_user_sigmask()
Date:   Fri, 14 Sep 2018 22:08:39 -0700
Message-Id: <20180915050843.19183-2-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180915050843.19183-1-deepa.kernel@gmail.com>
References: <20180915050843.19183-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor reading sigset from userspace and updating sigmask
into an api.

This is useful for versions of syscalls that pass in the
sigmask and expect the current->sigmask to be changed during
the execution and restored after the execution of the syscall.

With the advent of new y2038 syscalls in the subsequent patches,
we add 2 more new versions of the syscalls(for pselect, ppoll
and io_pgetevents) in addition to the existing native and compat
versions. Adding such an api reduces the logic that would need to
be replicated otherwise.

Note that the calls to sigprocmask() ignored the return value
from the api as the function only returns an error on an invalid
first argument that is hardcoded at these call sites.
The updated logic uses set_current_blocked() instead.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/aio.c               | 23 ++++++-------------
 fs/eventpoll.c         | 22 +++++--------------
 fs/select.c            | 50 ++++++++++--------------------------------
 include/linux/compat.h |  4 ++++
 include/linux/signal.h |  2 ++
 kernel/signal.c        | 45 +++++++++++++++++++++++++++++++++++++
 6 files changed, 76 insertions(+), 70 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 2914e8c1b3d2..67e5b1f6fb0f 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2105,14 +2105,10 @@ SYSCALL_DEFINE6(io_pgetevents,
 	if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
 		return -EFAULT;
 
-	if (ksig.sigmask) {
-		if (ksig.sigsetsize != sizeof(sigset_t))
-			return -EINVAL;
-		if (copy_from_user(&ksigmask, ksig.sigmask, sizeof(ksigmask)))
-			return -EFAULT;
-		sigdelsetmask(&ksigmask, sigmask(SIGKILL) | sigmask(SIGSTOP));
-		sigprocmask(SIG_SETMASK, &ksigmask, &sigsaved);
-	}
+
+	ret = set_user_sigmask(ksig.sigmask, &ksigmask, &sigsaved, ksig.sigsetsize);
+	if (ret)
+		return ret;
 
 	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &ts : NULL);
 	if (signal_pending(current)) {
@@ -2175,14 +2171,9 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
 	if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
 		return -EFAULT;
 
-	if (ksig.sigmask) {
-		if (ksig.sigsetsize != sizeof(compat_sigset_t))
-			return -EINVAL;
-		if (get_compat_sigset(&ksigmask, ksig.sigmask))
-			return -EFAULT;
-		sigdelsetmask(&ksigmask, sigmask(SIGKILL) | sigmask(SIGSTOP));
-		sigprocmask(SIG_SETMASK, &ksigmask, &sigsaved);
-	}
+	ret = set_compat_user_sigmask(ksig.sigmask, &ksigmask, &sigsaved, ksig.sigsetsize);
+	if (ret)
+		return ret;
 
 	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &t : NULL);
 	if (signal_pending(current)) {
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 42bbe6824b4b..2d86eeba837b 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2223,14 +2223,9 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct epoll_event __user *, events,
 	 * If the caller wants a certain signal mask to be set during the wait,
 	 * we apply it here.
 	 */
-	if (sigmask) {
-		if (sigsetsize != sizeof(sigset_t))
-			return -EINVAL;
-		if (copy_from_user(&ksigmask, sigmask, sizeof(ksigmask)))
-			return -EFAULT;
-		sigsaved = current->blocked;
-		set_current_blocked(&ksigmask);
-	}
+	error = set_user_sigmask(sigmask, &ksigmask, &sigsaved, sigsetsize);
+	if (error)
+		return error;
 
 	error = do_epoll_wait(epfd, events, maxevents, timeout);
 
@@ -2266,14 +2261,9 @@ COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,
 	 * If the caller wants a certain signal mask to be set during the wait,
 	 * we apply it here.
 	 */
-	if (sigmask) {
-		if (sigsetsize != sizeof(compat_sigset_t))
-			return -EINVAL;
-		if (get_compat_sigset(&ksigmask, sigmask))
-			return -EFAULT;
-		sigsaved = current->blocked;
-		set_current_blocked(&ksigmask);
-	}
+	err = set_compat_user_sigmask(sigmask, &ksigmask, &sigsaved, sigsetsize);
+	if (err)
+		return err;
 
 	err = do_epoll_wait(epfd, events, maxevents, timeout);
 
diff --git a/fs/select.c b/fs/select.c
index 22b3bf89f051..65c78b4147a2 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -717,16 +717,9 @@ static long do_pselect(int n, fd_set __user *inp, fd_set __user *outp,
 			return -EINVAL;
 	}
 
-	if (sigmask) {
-		/* XXX: Don't preclude handling different sized sigset_t's.  */
-		if (sigsetsize != sizeof(sigset_t))
-			return -EINVAL;
-		if (copy_from_user(&ksigmask, sigmask, sizeof(ksigmask)))
-			return -EFAULT;
-
-		sigdelsetmask(&ksigmask, sigmask(SIGKILL)|sigmask(SIGSTOP));
-		sigprocmask(SIG_SETMASK, &ksigmask, &sigsaved);
-	}
+	ret = set_user_sigmask(sigmask, &ksigmask, &sigsaved, sigsetsize);
+	if (ret)
+		return ret;
 
 	ret = core_sys_select(n, inp, outp, exp, to);
 	ret = poll_select_copy_remaining(&end_time, tsp, 0, ret);
@@ -1061,16 +1054,9 @@ SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds, unsigned int, nfds,
 			return -EINVAL;
 	}
 
-	if (sigmask) {
-		/* XXX: Don't preclude handling different sized sigset_t's.  */
-		if (sigsetsize != sizeof(sigset_t))
-			return -EINVAL;
-		if (copy_from_user(&ksigmask, sigmask, sizeof(ksigmask)))
-			return -EFAULT;
-
-		sigdelsetmask(&ksigmask, sigmask(SIGKILL)|sigmask(SIGSTOP));
-		sigprocmask(SIG_SETMASK, &ksigmask, &sigsaved);
-	}
+	ret = set_user_sigmask(sigmask, &ksigmask, &sigsaved, sigsetsize);
+	if (ret)
+		return ret;
 
 	ret = do_sys_poll(ufds, nfds, to);
 
@@ -1323,15 +1309,9 @@ static long do_compat_pselect(int n, compat_ulong_t __user *inp,
 			return -EINVAL;
 	}
 
-	if (sigmask) {
-		if (sigsetsize != sizeof(compat_sigset_t))
-			return -EINVAL;
-		if (get_compat_sigset(&ksigmask, sigmask))
-			return -EFAULT;
-
-		sigdelsetmask(&ksigmask, sigmask(SIGKILL)|sigmask(SIGSTOP));
-		sigprocmask(SIG_SETMASK, &ksigmask, &sigsaved);
-	}
+	ret = set_compat_user_sigmask(sigmask, &ksigmask, &sigsaved, sigsetsize);
+	if (ret)
+		return ret;
 
 	ret = compat_core_sys_select(n, inp, outp, exp, to);
 	ret = compat_poll_select_copy_remaining(&end_time, tsp, 0, ret);
@@ -1389,15 +1369,9 @@ COMPAT_SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds,
 			return -EINVAL;
 	}
 
-	if (sigmask) {
-		if (sigsetsize != sizeof(compat_sigset_t))
-			return -EINVAL;
-		if (get_compat_sigset(&ksigmask, sigmask))
-			return -EFAULT;
-
-		sigdelsetmask(&ksigmask, sigmask(SIGKILL)|sigmask(SIGSTOP));
-		sigprocmask(SIG_SETMASK, &ksigmask, &sigsaved);
-	}
+	ret = set_compat_user_sigmask(sigmask, &ksigmask, &sigsaved, sigsetsize);
+	if (ret)
+		return ret;
 
 	ret = do_sys_poll(ufds, nfds, to);
 
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 6fb5abdb87be..03d65c509eeb 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -166,6 +166,10 @@ typedef struct {
 	compat_sigset_word	sig[_COMPAT_NSIG_WORDS];
 } compat_sigset_t;
 
+int set_compat_user_sigmask(const compat_sigset_t __user *usigmask,
+			    sigset_t *set, sigset_t *oldset,
+			    size_t sigsetsize);
+
 struct compat_sigaction {
 #ifndef __ARCH_HAS_IRIX_SIGACTION
 	compat_uptr_t			sa_handler;
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 3d4cd5db30a9..403e63d01bcf 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -263,6 +263,8 @@ extern int group_send_sig_info(int sig, struct siginfo *info,
 			       struct task_struct *p, enum pid_type type);
 extern int __group_send_sig_info(int, struct siginfo *, struct task_struct *);
 extern int sigprocmask(int, sigset_t *, sigset_t *);
+extern int set_user_sigmask(const sigset_t __user *usigmask, sigset_t *set,
+	sigset_t *oldset, size_t sigsetsize);
 extern void set_current_blocked(sigset_t *);
 extern void __set_current_blocked(const sigset_t *);
 extern int show_unhandled_signals;
diff --git a/kernel/signal.c b/kernel/signal.c
index 0831d56a731a..1d72dcddcaaf 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2738,6 +2738,51 @@ int sigprocmask(int how, sigset_t *set, sigset_t *oldset)
 	return 0;
 }
 
+/*
+ * The api helps set app-provided sigmasks.
+ *
+ * This is useful for syscalls such as ppoll, pselect, io_pgetevents and
+ * epoll_pwait where a new sigmask is passed from userland for the syscalls.
+ */
+int set_user_sigmask(const sigset_t __user *usigmask, sigset_t *set,
+		     sigset_t *oldset, size_t sigsetsize)
+{
+	if (!usigmask)
+		return 0;
+
+	if (sigsetsize != sizeof(sigset_t))
+		return -EINVAL;
+	if (copy_from_user(set, usigmask, sizeof(sigset_t)))
+		return -EFAULT;
+
+	*oldset = current->blocked;
+	set_current_blocked(set);
+
+	return 0;
+}
+EXPORT_SYMBOL(set_user_sigmask);
+
+#ifdef CONFIG_COMPAT
+int set_compat_user_sigmask(const compat_sigset_t __user *usigmask,
+			    sigset_t *set, sigset_t *oldset,
+			    size_t sigsetsize)
+{
+	if (!usigmask)
+		return 0;
+
+	if (sigsetsize != sizeof(compat_sigset_t))
+		return -EINVAL;
+	if (get_compat_sigset(set, usigmask))
+		return -EFAULT;
+
+	*oldset = current->blocked;
+	set_current_blocked(set);
+
+	return 0;
+}
+EXPORT_SYMBOL(set_compat_user_sigmask);
+#endif
+
 /**
  *  sys_rt_sigprocmask - change the list of currently blocked signals
  *  @how: whether to add, remove, or set signals
-- 
2.17.1

