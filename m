Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8620AC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 20:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF1C2083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 20:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7LkNs1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF1C2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeIBBBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 21:01:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41728 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbeIBBBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 21:01:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id h79-v6so7002951pfk.8;
        Sat, 01 Sep 2018 13:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YMpkSxmw9bd8CAaCEUlW1+ILH8RIVB/QhU2HebHtNRs=;
        b=a7LkNs1jgqG+Mtk1+3ngi4frcdsKgEseI28SS8cQVujIp7knIEKtXonyCwgfhwlkbZ
         pUCDmVvC4RyEDxWIiCW232Od/ZeBWa56tlSW/s6OvmK8s/hg59/hXoW9GihdOAKhCJdm
         Mmtd+T6xITnccLMbw1kKkyhaiUTajbyZ0fkGFNde+aJaPnZ58WVdLjKr436S4w/oynZ/
         vTJEDOE2ZUo+93AK8IOxr+9nsIaBL8566Y/Wml4V4OFXON8aMGggS/DgXcCTeoO1wdPY
         zrKGPFnZmLDa4p6GOvTBSU38sridNf/HJt77DQVTrmw4dPKv5mfV/xQ0sLtmICndxFHy
         DlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YMpkSxmw9bd8CAaCEUlW1+ILH8RIVB/QhU2HebHtNRs=;
        b=BU1JJA2TNApdOmHJm8/9GVVtO/970Ad2co4nBHBf/oYpmYhUlDG0Wz6l68AQ26lMwg
         zAuZG9cHPHs8Qqu3wsVX7S5Yr2vaCDaDQWpl8RMzq8PjS17F2W1NKnNHCsNhJNdiNP89
         DjHoglocitw6HEmwxY5W+TtJ4oeb2sPYUuDcOUfEW+aLPj0X37oPLtotnFbFC/jZsv20
         FRlRTrEIG9MakUv3tLKsZ9e3vnbxvNOnJVez4X8OyEqu7ArBZgIXo9AXx/xCdbTTHnuv
         /2gKfxWDoL08DdlDHjRx35x5AlrPSmFjtS3AbV8DgCbt6xFjfKMpgQGGTZAi1IpY7Mt4
         j29A==
X-Gm-Message-State: APzg51AjsDcJd8ZKBZTgGyahn2TmJ6v6e8QYvgycNtkCJebBzleMjPyV
        azlSk5f7IGzF/oAE+w0c0dK7hAVw
X-Google-Smtp-Source: ANB0VdamaRrOBYy1sAM0YB368vptig7rZMXQ8zJuDU7uTX4p5lwvajEl500PfuK9GSkxRq8ALn8g5w==
X-Received: by 2002:a63:2445:: with SMTP id k66-v6mr13289021pgk.405.1535834892322;
        Sat, 01 Sep 2018 13:48:12 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id u17-v6sm24512265pfa.176.2018.09.01.13.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 13:48:11 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-aio@kvack.org
Subject: [PATCH 3/5] ppoll: use __kernel_timespec
Date:   Sat,  1 Sep 2018 13:47:19 -0700
Message-Id: <20180901204721.13117-4-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180901204721.13117-1-deepa.kernel@gmail.com>
References: <20180901204721.13117-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct timespec is not y2038 safe.
struct __kernel_timespec is the new y2038 safe structure for all
syscalls that are using struct timespec.
Update ppoll interfaces to use struct __kernel_timespec.

sigset_t also has different representations on 32 bit and 64 bit
architectures. Hence, we need to support the following different
syscalls:

New y2038 safe syscalls:
(Controlled by CONFIG_64BIT_TIME for 32 bit ABIs)

Native 64 bit(unchanged) and native 32 bit : sys_ppoll
Compat : compat_sys_ppoll_time64

Older y2038 unsafe syscalls:
(Controlled by CONFIG_32BIT_COMPAT_TIME for 32 bit ABIs)

Native 32 bit : ppoll_time32
Compat : compat_sys_ppoll

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/select.c              | 171 ++++++++++++++++++++++++++-------------
 include/linux/compat.h   |   5 ++
 include/linux/syscalls.h |   5 +-
 3 files changed, 124 insertions(+), 57 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index eb9132520197..653eed2add8e 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -287,12 +287,18 @@ int poll_select_set_timeout(struct timespec64 *to, time64_t sec, long nsec)
 	return 0;
 }
 
+enum poll_time_type {
+	PT_TIMEVAL = 0,
+	PT_OLD_TIMEVAL = 1,
+	PT_TIMESPEC = 2,
+	PT_OLD_TIMESPEC = 3,
+};
+
 static int poll_select_copy_remaining(struct timespec64 *end_time,
 				      void __user *p,
-				      int timeval, int ret)
+				      enum poll_time_type pt_type, int ret)
 {
 	struct timespec64 rts;
-	struct timeval rtv;
 
 	if (!p)
 		return ret;
@@ -310,18 +316,40 @@ static int poll_select_copy_remaining(struct timespec64 *end_time,
 		rts.tv_sec = rts.tv_nsec = 0;
 
 
-	if (timeval) {
-		if (sizeof(rtv) > sizeof(rtv.tv_sec) + sizeof(rtv.tv_usec))
-			memset(&rtv, 0, sizeof(rtv));
-		rtv.tv_sec = rts.tv_sec;
-		rtv.tv_usec = rts.tv_nsec / NSEC_PER_USEC;
+	switch (pt_type) {
+	case PT_TIMEVAL:
+		{
+			struct timeval rtv;
 
-		if (!copy_to_user(p, &rtv, sizeof(rtv)))
+			if (sizeof(rtv) > sizeof(rtv.tv_sec) + sizeof(rtv.tv_usec))
+				memset(&rtv, 0, sizeof(rtv));
+			rtv.tv_sec = rts.tv_sec;
+			rtv.tv_usec = rts.tv_nsec / NSEC_PER_USEC;
+			if (!copy_to_user(p, &rtv, sizeof(rtv)))
+				return ret;
+		}
+		break;
+	case PT_OLD_TIMEVAL:
+		{
+			struct old_timeval32 rtv;
+
+			rtv.tv_sec = rts.tv_sec;
+			rtv.tv_usec = rts.tv_nsec / NSEC_PER_USEC;
+			if (!copy_to_user(p, &rtv, sizeof(rtv)))
+				return ret;
+		}
+		break;
+	case PT_TIMESPEC:
+		if (!put_timespec64(&rts, p))
 			return ret;
-
-	} else if (!put_timespec64(&rts, p))
-		return ret;
-
+		break;
+	case PT_OLD_TIMESPEC:
+		if (!put_old_timespec32(&rts, p))
+			return ret;
+		break;
+	default:
+		BUG();
+	}
 	/*
 	 * If an application puts its timeval in read-only memory, we
 	 * don't want the Linux-specific update to the timeval to
@@ -689,7 +717,7 @@ static int kern_select(int n, fd_set __user *inp, fd_set __user *outp,
 	}
 
 	ret = core_sys_select(n, inp, outp, exp, to);
-	ret = poll_select_copy_remaining(&end_time, tvp, 1, ret);
+	ret = poll_select_copy_remaining(&end_time, tvp, PT_TIMEVAL, ret);
 
 	return ret;
 }
@@ -722,7 +750,7 @@ static long do_pselect(int n, fd_set __user *inp, fd_set __user *outp,
 		return ret;
 
 	ret = core_sys_select(n, inp, outp, exp, to);
-	ret = poll_select_copy_remaining(&end_time, tsp, 0, ret);
+	ret = poll_select_copy_remaining(&end_time, tsp, PT_TIMESPEC, ret);
 
 	restore_user_sigmask(sigmask, &sigsaved);
 
@@ -1026,7 +1054,7 @@ SYSCALL_DEFINE3(poll, struct pollfd __user *, ufds, unsigned int, nfds,
 }
 
 SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds, unsigned int, nfds,
-		struct timespec __user *, tsp, const sigset_t __user *, sigmask,
+		struct __kernel_timespec __user *, tsp, const sigset_t __user *, sigmask,
 		size_t, sigsetsize)
 {
 	sigset_t ksigmask, sigsaved;
@@ -1054,60 +1082,50 @@ SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds, unsigned int, nfds,
 	if (ret == -EINTR)
 		ret = -ERESTARTNOHAND;
 
-	ret = poll_select_copy_remaining(&end_time, tsp, 0, ret);
+	ret = poll_select_copy_remaining(&end_time, tsp, PT_TIMESPEC, ret);
 
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
-#define __COMPAT_NFDBITS       (8 * sizeof(compat_ulong_t))
+#if defined(CONFIG_COMPAT_32BIT_TIME) && !defined(CONFIG_64BIT)
 
-static
-int compat_poll_select_copy_remaining(struct timespec64 *end_time, void __user *p,
-				      int timeval, int ret)
+SYSCALL_DEFINE5(ppoll_time32, struct pollfd __user *, ufds, unsigned int, nfds,
+		struct old_timespec32 __user *, tsp, const sigset_t __user *, sigmask,
+		size_t, sigsetsize)
 {
-	struct timespec64 ts;
+	sigset_t ksigmask, sigsaved;
+	struct timespec64 ts, end_time, *to = NULL;
+	int ret;
 
-	if (!p)
-		return ret;
+	if (tsp) {
+		if (get_old_timespec32(&ts, tsp))
+			return -EFAULT;
 
-	if (current->personality & STICKY_TIMEOUTS)
-		goto sticky;
+		to = &end_time;
+		if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec))
+			return -EINVAL;
+	}
 
-	/* No update for zero timeout */
-	if (!end_time->tv_sec && !end_time->tv_nsec)
+	ret = set_user_sigmask(sigmask, &ksigmask, &sigsaved, sigsetsize);
+	if (ret)
 		return ret;
 
-	ktime_get_ts64(&ts);
-	ts = timespec64_sub(*end_time, ts);
-	if (ts.tv_sec < 0)
-		ts.tv_sec = ts.tv_nsec = 0;
-
-	if (timeval) {
-		struct old_timeval32 rtv;
-
-		rtv.tv_sec = ts.tv_sec;
-		rtv.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
+	ret = do_sys_poll(ufds, nfds, to);
 
-		if (!copy_to_user(p, &rtv, sizeof(rtv)))
-			return ret;
-	} else {
-		if (!put_old_timespec32(&ts, p))
-			return ret;
+	/* We can restart this syscall, usually */
+	if (ret == -EINTR) {
+		restore_user_sigmask(sigmask, &sigsaved);
+		ret = -ERESTARTNOHAND;
 	}
-	/*
-	 * If an application puts its timeval in read-only memory, we
-	 * don't want the Linux-specific update to the timeval to
-	 * cause a fault after the select has completed
-	 * successfully. However, because we're not updating the
-	 * timeval, we can't restart the system call.
-	 */
 
-sticky:
-	if (ret == -ERESTARTNOHAND)
-		ret = -EINTR;
+	ret = poll_select_copy_remaining(&end_time, tsp, PT_OLD_TIMESPEC, ret);
+
 	return ret;
 }
+#endif
+
+#ifdef CONFIG_COMPAT
+#define __COMPAT_NFDBITS       (8 * sizeof(compat_ulong_t))
 
 /*
  * Ooo, nasty.  We need here to frob 32-bit unsigned longs to
@@ -1239,7 +1257,7 @@ static int do_compat_select(int n, compat_ulong_t __user *inp,
 	}
 
 	ret = compat_core_sys_select(n, inp, outp, exp, to);
-	ret = compat_poll_select_copy_remaining(&end_time, tvp, 1, ret);
+	ret = poll_select_copy_remaining(&end_time, tvp, PT_OLD_TIMEVAL, ret);
 
 	return ret;
 }
@@ -1292,7 +1310,7 @@ static long do_compat_pselect(int n, compat_ulong_t __user *inp,
 		return ret;
 
 	ret = compat_core_sys_select(n, inp, outp, exp, to);
-	ret = compat_poll_select_copy_remaining(&end_time, tsp, 0, ret);
+	ret = poll_select_copy_remaining(&end_time, tsp, PT_OLD_TIMESPEC, ret);
 
 	restore_user_sigmask(sigmask, &sigsaved);
 
@@ -1318,6 +1336,7 @@ COMPAT_SYSCALL_DEFINE6(pselect6, int, n, compat_ulong_t __user *, inp,
 				 sigsetsize);
 }
 
+#if defined(CONFIG_COMPAT_32BIT_TIME)
 COMPAT_SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds,
 	unsigned int,  nfds, struct old_timespec32 __user *, tsp,
 	const compat_sigset_t __user *, sigmask, compat_size_t, sigsetsize)
@@ -1347,8 +1366,48 @@ COMPAT_SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds,
 	if (ret == -EINTR)
 		ret = -ERESTARTNOHAND;
 
-	ret = compat_poll_select_copy_remaining(&end_time, tsp, 0, ret);
+	ret = poll_select_copy_remaining(&end_time, tsp, PT_OLD_TIMESPEC, ret);
+
+	return ret;
+}
+#endif
+
+/* New compat syscall for 64 bit time_t*/
+#if defined(CONFIG_64BIT_TIME)
+
+COMPAT_SYSCALL_DEFINE5(ppoll_time64, struct pollfd __user *, ufds,
+	unsigned int,  nfds, struct __kernel_timespec __user *, tsp,
+	const compat_sigset_t __user *, sigmask, compat_size_t, sigsetsize)
+{
+	sigset_t ksigmask, sigsaved;
+	struct timespec64 ts, end_time, *to = NULL;
+	int ret;
+
+	if (tsp) {
+		if (get_timespec64(&ts, tsp))
+			return -EFAULT;
+
+		to = &end_time;
+		if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec))
+			return -EINVAL;
+	}
+
+	ret = set_compat_user_sigmask(sigmask, &ksigmask, &sigsaved, sigsetsize);
+	if (ret)
+		return ret;
+
+	ret = do_sys_poll(ufds, nfds, to);
+
+	/* We can restart this syscall, usually */
+	if (ret == -EINTR) {
+		restore_user_sigmask(sigmask, &sigsaved);
+		ret = -ERESTARTNOHAND;
+	}
+
+	ret = poll_select_copy_remaining(&end_time, tsp, PT_TIMESPEC, ret);
 
 	return ret;
 }
+
+#endif
 #endif
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 03d65c509eeb..349a2d98e450 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -646,6 +646,11 @@ asmlinkage long compat_sys_ppoll(struct pollfd __user *ufds,
 				 struct old_timespec32 __user *tsp,
 				 const compat_sigset_t __user *sigmask,
 				 compat_size_t sigsetsize);
+asmlinkage long compat_sys_ppoll_time64(struct pollfd __user *ufds,
+				 unsigned int nfds,
+				 struct __kernel_timespec __user *tsp,
+				 const compat_sigset_t __user *sigmask,
+				 compat_size_t sigsetsize);
 
 /* fs/signalfd.c */
 asmlinkage long compat_sys_signalfd4(int ufd,
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 82682b69435e..9755e70cfbb0 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -470,7 +470,10 @@ asmlinkage long sys_pselect6(int, fd_set __user *, fd_set __user *,
 			     fd_set __user *, struct timespec __user *,
 			     void __user *);
 asmlinkage long sys_ppoll(struct pollfd __user *, unsigned int,
-			  struct timespec __user *, const sigset_t __user *,
+			  struct __kernel_timespec __user *, const sigset_t __user *,
+			  size_t);
+asmlinkage long sys_ppoll_time32(struct pollfd __user *, unsigned int,
+			  struct old_timespec32 __user *, const sigset_t __user *,
 			  size_t);
 
 /* fs/signalfd.c */
-- 
2.17.1

