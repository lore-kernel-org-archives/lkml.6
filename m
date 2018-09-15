Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339F4ECE563
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 05:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC97E20881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 05:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H80jSRsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC97E20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeIOK1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 06:27:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36968 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeIOK1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 06:27:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id f1-v6so5077011plt.4;
        Fri, 14 Sep 2018 22:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xV6QtS4XkBxEqLngu8Sevec3OBS/0hrQoTPUaJeOSLI=;
        b=H80jSRsZcHw7FcaejPX7aCSkebcmiTUmI6puYxO77eA+As7AEx1PTYZImIv2aGyhJg
         smRKKPdRjOeteWGoQHK1gXYS2WXwHVgZYcnn2OjW9g/K5cp/T5b8q3q9Lm+sxskPa3FN
         HZkGtI3NQ2WMv20TLt9yrymgWvmqDxrG6RhOH0tM689U5lmZe7+7U+ZGKNKR21X4D29c
         XwgF9kMkL4p81QNO9wmTFOohor8vosPVi9EVFGn10MGgm6lkpmw3Ig7X9sRx1l8f1n7Y
         Bs2gDEjNM/TIhEPaefrjtVz9RkDHAKoTMyQozD+vEvAIlJcnq/SRsANKw7MnrjPhXa99
         Om2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xV6QtS4XkBxEqLngu8Sevec3OBS/0hrQoTPUaJeOSLI=;
        b=Zl71ye94mcdV4K0gQiD0GGUqTnaXnLm1YuEX6M4Dh6pSibljX4hTHFe+1vChxsirGY
         5KQSw2mHQwe7OF+wfEp1i4NxtPjYDttQH/bKWyZygrduKoNsdpCUihCVR/ze0zd8KBkx
         a3cJW9yJnp85+e4OGF3/YvaOVULQM2KSDluUmYbD3/6fzWxaBCLSWImCkHI+nPhqERmY
         ffGKjTvelqmlymOG6x2AF3yvS9tgW8/iUBSqH2SaJd/Msru0R5oyFJxCwCiD+DAS+sMr
         lfGRArdrKGmPUOUoQPTtnE6PyonkNgFDfbXNCD5VtLvOfxl2KX8AkpEd4F8OmXNWez0d
         /U8Q==
X-Gm-Message-State: APzg51DAWIfKEdBHPMUTy2tTNIzTw0+x8M/Zs6n+qE5BmvibCDoaCGPG
        skbEWVQDMQsvC9y0L043G0eYOL1x
X-Google-Smtp-Source: ANB0VdZwClucp+adj8GNV5QN578a/ZkxSnmS1vtOAo/oYHAvGVzNkw2ijp2kVYAFshXpRaEtjTWRkg==
X-Received: by 2002:a17:902:25ab:: with SMTP id y40-v6mr14714405pla.120.1536988176583;
        Fri, 14 Sep 2018 22:09:36 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id g6-v6sm14195676pfb.11.2018.09.14.22.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 22:09:36 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-aio@kvack.org
Subject: [PATCH v2 2/5] signal: Add restore_user_sigmask()
Date:   Fri, 14 Sep 2018 22:08:40 -0700
Message-Id: <20180915050843.19183-3-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180915050843.19183-1-deepa.kernel@gmail.com>
References: <20180915050843.19183-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the logic to restore the sigmask before the syscall
returns into an api.
This is useful for versions of syscalls that pass in the
sigmask and expect the current->sigmask to be changed during
the execution and restored after the execution of the syscall.

With the advent of new y2038 syscalls in the subsequent patches,
we add 2 more new versions of the syscalls(for pselect, ppoll
and io_pgetevents) in addition to the existing native and compat
versions. Adding such an api reduces the logic that would need to
be replicated otherwise.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/aio.c               | 29 +++++---------------
 fs/eventpoll.c         | 30 ++-------------------
 fs/select.c            | 60 ++++++------------------------------------
 include/linux/signal.h |  2 ++
 kernel/signal.c        | 33 +++++++++++++++++++++++
 5 files changed, 51 insertions(+), 103 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 67e5b1f6fb0f..b81c216534d6 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2111,18 +2111,9 @@ SYSCALL_DEFINE6(io_pgetevents,
 		return ret;
 
 	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &ts : NULL);
-	if (signal_pending(current)) {
-		if (ksig.sigmask) {
-			current->saved_sigmask = sigsaved;
-			set_restore_sigmask();
-		}
-
-		if (!ret)
-			ret = -ERESTARTNOHAND;
-	} else {
-		if (ksig.sigmask)
-			sigprocmask(SIG_SETMASK, &sigsaved, NULL);
-	}
+	restore_user_sigmask(ksig.sigmask, &sigsaved);
+	if (signal_pending(current) && !ret)
+		ret = -ERESTARTNOHAND;
 
 	return ret;
 }
@@ -2176,17 +2167,9 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
 		return ret;
 
 	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &t : NULL);
-	if (signal_pending(current)) {
-		if (ksig.sigmask) {
-			current->saved_sigmask = sigsaved;
-			set_restore_sigmask();
-		}
-		if (!ret)
-			ret = -ERESTARTNOHAND;
-	} else {
-		if (ksig.sigmask)
-			sigprocmask(SIG_SETMASK, &sigsaved, NULL);
-	}
+	restore_user_sigmask(ksig.sigmask, &sigsaved);
+	if (signal_pending(current) && !ret)
+		ret = -ERESTARTNOHAND;
 
 	return ret;
 }
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 2d86eeba837b..8a5a1010886b 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2229,20 +2229,7 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct epoll_event __user *, events,
 
 	error = do_epoll_wait(epfd, events, maxevents, timeout);
 
-	/*
-	 * If we changed the signal mask, we need to restore the original one.
-	 * In case we've got a signal while waiting, we do not restore the
-	 * signal mask yet, and we allow do_signal() to deliver the signal on
-	 * the way back to userspace, before the signal mask is restored.
-	 */
-	if (sigmask) {
-		if (error == -EINTR) {
-			memcpy(&current->saved_sigmask, &sigsaved,
-			       sizeof(sigsaved));
-			set_restore_sigmask();
-		} else
-			set_current_blocked(&sigsaved);
-	}
+	restore_user_sigmask(sigmask, &sigsaved);
 
 	return error;
 }
@@ -2267,20 +2254,7 @@ COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,
 
 	err = do_epoll_wait(epfd, events, maxevents, timeout);
 
-	/*
-	 * If we changed the signal mask, we need to restore the original one.
-	 * In case we've got a signal while waiting, we do not restore the
-	 * signal mask yet, and we allow do_signal() to deliver the signal on
-	 * the way back to userspace, before the signal mask is restored.
-	 */
-	if (sigmask) {
-		if (err == -EINTR) {
-			memcpy(&current->saved_sigmask, &sigsaved,
-			       sizeof(sigsaved));
-			set_restore_sigmask();
-		} else
-			set_current_blocked(&sigsaved);
-	}
+	restore_user_sigmask(sigmask, &sigsaved);
 
 	return err;
 }
diff --git a/fs/select.c b/fs/select.c
index 65c78b4147a2..eb9132520197 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -724,19 +724,7 @@ static long do_pselect(int n, fd_set __user *inp, fd_set __user *outp,
 	ret = core_sys_select(n, inp, outp, exp, to);
 	ret = poll_select_copy_remaining(&end_time, tsp, 0, ret);
 
-	if (ret == -ERESTARTNOHAND) {
-		/*
-		 * Don't restore the signal mask yet. Let do_signal() deliver
-		 * the signal on the way back to userspace, before the signal
-		 * mask is restored.
-		 */
-		if (sigmask) {
-			memcpy(&current->saved_sigmask, &sigsaved,
-					sizeof(sigsaved));
-			set_restore_sigmask();
-		}
-	} else if (sigmask)
-		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+	restore_user_sigmask(sigmask, &sigsaved);
 
 	return ret;
 }
@@ -1060,21 +1048,11 @@ SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds, unsigned int, nfds,
 
 	ret = do_sys_poll(ufds, nfds, to);
 
+	restore_user_sigmask(sigmask, &sigsaved);
+
 	/* We can restart this syscall, usually */
-	if (ret == -EINTR) {
-		/*
-		 * Don't restore the signal mask yet. Let do_signal() deliver
-		 * the signal on the way back to userspace, before the signal
-		 * mask is restored.
-		 */
-		if (sigmask) {
-			memcpy(&current->saved_sigmask, &sigsaved,
-					sizeof(sigsaved));
-			set_restore_sigmask();
-		}
+	if (ret == -EINTR)
 		ret = -ERESTARTNOHAND;
-	} else if (sigmask)
-		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 
 	ret = poll_select_copy_remaining(&end_time, tsp, 0, ret);
 
@@ -1316,19 +1294,7 @@ static long do_compat_pselect(int n, compat_ulong_t __user *inp,
 	ret = compat_core_sys_select(n, inp, outp, exp, to);
 	ret = compat_poll_select_copy_remaining(&end_time, tsp, 0, ret);
 
-	if (ret == -ERESTARTNOHAND) {
-		/*
-		 * Don't restore the signal mask yet. Let do_signal() deliver
-		 * the signal on the way back to userspace, before the signal
-		 * mask is restored.
-		 */
-		if (sigmask) {
-			memcpy(&current->saved_sigmask, &sigsaved,
-					sizeof(sigsaved));
-			set_restore_sigmask();
-		}
-	} else if (sigmask)
-		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+	restore_user_sigmask(sigmask, &sigsaved);
 
 	return ret;
 }
@@ -1375,21 +1341,11 @@ COMPAT_SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds,
 
 	ret = do_sys_poll(ufds, nfds, to);
 
+	restore_user_sigmask(sigmask, &sigsaved);
+
 	/* We can restart this syscall, usually */
-	if (ret == -EINTR) {
-		/*
-		 * Don't restore the signal mask yet. Let do_signal() deliver
-		 * the signal on the way back to userspace, before the signal
-		 * mask is restored.
-		 */
-		if (sigmask) {
-			memcpy(&current->saved_sigmask, &sigsaved,
-				sizeof(sigsaved));
-			set_restore_sigmask();
-		}
+	if (ret == -EINTR)
 		ret = -ERESTARTNOHAND;
-	} else if (sigmask)
-		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 
 	ret = compat_poll_select_copy_remaining(&end_time, tsp, 0, ret);
 
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 403e63d01bcf..ed8be17afe89 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -265,6 +265,8 @@ extern int __group_send_sig_info(int, struct siginfo *, struct task_struct *);
 extern int sigprocmask(int, sigset_t *, sigset_t *);
 extern int set_user_sigmask(const sigset_t __user *usigmask, sigset_t *set,
 	sigset_t *oldset, size_t sigsetsize);
+extern void restore_user_sigmask(const void __user *usigmask,
+				 sigset_t *sigsaved);
 extern void set_current_blocked(sigset_t *);
 extern void __set_current_blocked(const sigset_t *);
 extern int show_unhandled_signals;
diff --git a/kernel/signal.c b/kernel/signal.c
index 1d72dcddcaaf..457d1abe62a4 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2783,6 +2783,39 @@ int set_compat_user_sigmask(const compat_sigset_t __user *usigmask,
 EXPORT_SYMBOL(set_compat_user_sigmask);
 #endif
 
+/*
+ * restore_user_sigmask:
+ * usigmask: sigmask passed in from userland.
+ * sigsaved: saved sigmask when the syscall started and changed the sigmask to
+ *           usigmask.
+ *
+ * This is useful for syscalls such as ppoll, pselect, io_pgetevents and
+ * epoll_pwait where a new sigmask is passed in from userland for the syscalls.
+ */
+void restore_user_sigmask(const void __user *usigmask, sigset_t *sigsaved)
+{
+
+	if (!usigmask)
+		return;
+	/*
+	 * When signals are pending, do not restore them here.
+	 * Restoring sigmask here can lead to delivering signals that the above
+	 * syscalls are intended to block because of the sigmask passed in.
+	 */
+	if (signal_pending(current)) {
+		current->saved_sigmask = *sigsaved;
+		set_restore_sigmask();
+		return;
+	}
+
+	/*
+	 * This is needed because the fast syscall return path does not restore
+	 * saved_sigmask when signals are not pending.
+	 */
+	set_current_blocked(sigsaved);
+}
+EXPORT_SYMBOL(restore_user_sigmask);
+
 /**
  *  sys_rt_sigprocmask - change the list of currently blocked signals
  *  @how: whether to add, remove, or set signals
-- 
2.17.1

