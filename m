Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9977C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 20:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817822083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 20:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YghZJ8B0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817822083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeIBBBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 21:01:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:47028 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbeIBBBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 21:01:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id a4-v6so6918985plm.13;
        Sat, 01 Sep 2018 13:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GRew09aJfeEsYjbPJ0Hjibpihl2/M+ItBzZlyx4J8OI=;
        b=YghZJ8B0VkmAMgQ5+HyO7ZrnWJCYH+hltQJBl9mDT+HrlqKx0OwmtPBW+o5mJkczzm
         zWv/mS06C/adLAyBI+tK0wDTJNRvRgVSWaH4huYY1IgjqCjgQxNavDNqNoWPuzJojUhy
         d8Rr1YE28NTzahgzNiGZMethlSso2eE7eVhM+YWulJ8dErZiUO0ACYVWWd/6BJH45OW2
         fkfYJAnPZHrkGgHDiL6CkzqZskp4CEu/wVIA4OYE2oAjwwMbvNYuKss/oXuzmFimlMIG
         trJRJJDItL7U4tyySlMkyBdnt4xt6+m91be8+RuCJjpJo/u9ROtoU9w90P9cwquznvGp
         RqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GRew09aJfeEsYjbPJ0Hjibpihl2/M+ItBzZlyx4J8OI=;
        b=HLN/QJ0Rz0/P6/4zELdiTD2wkOEPN45PNlWPUP9LhXGDRssml3JKzujIMQA6aH3RjW
         AGDIxvqoipQ5nEjzs+tmk8gjQ48o1Mya4kEGK4Rv5saeuNgJsCERStB7I3K8EwubgA0E
         R0nv8DRO8AjYcBLSuHNRK8SSWSB9pvnhqy/fzJU/E5QlN4P73fNQlGcnDq3ehAKzT0gZ
         2rcSI76HPnGGil0aVn5hHU7wAeMYOgTHcVqYts15axs3/FIMYuG1j538ks1TUceVItWg
         v70442eOPTtX25X5o74EJLnqMcJ10jQEn8/Hi9LazZTMLuTPxSCGkFpRZPrkrEpBOTdp
         dzig==
X-Gm-Message-State: APzg51DXnTZNgOagYqXRxk0PObvbpV7x1i4K5CCQXWrrmEpOiFA0PWEO
        d/ruAb0MifF1N4Fz+rMX9ns=
X-Google-Smtp-Source: ANB0VdbI8xOUZATBnQMPMo/QMC+mmj6Utm4NpjjUk65ZfjFNbC2cl6qmOGzCdBA2svV6RPExVOPkEA==
X-Received: by 2002:a17:902:b78a:: with SMTP id e10-v6mr21674761pls.79.1535834894271;
        Sat, 01 Sep 2018 13:48:14 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id u17-v6sm24512265pfa.176.2018.09.01.13.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 13:48:13 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-aio@kvack.org
Subject: [PATCH 4/5] pselect6: use __kernel_timespec
Date:   Sat,  1 Sep 2018 13:47:20 -0700
Message-Id: <20180901204721.13117-5-deepa.kernel@gmail.com>
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
Update pselect interfaces to use struct __kernel_timespec.

sigset_t also has different representations on 32 bit and 64 bit
architectures. Hence, we need to support the following different
syscalls:

New y2038 safe syscalls:
(Controlled by CONFIG_64BIT_TIME for 32 bit ABIs)

Native 64 bit(unchanged) and native 32 bit : sys_pselect6
Compat : compat_sys_pselect6_time64

Older y2038 unsafe syscalls:
(Controlled by CONFIG_32BIT_COMPAT_TIME for 32 bit ABIs)

Native 32 bit : pselect6_time32
Compat : compat_sys_pselect6

Note that all other versions of select syscalls will not have
y2038 safe versions.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/select.c              | 98 ++++++++++++++++++++++++++++++++++------
 include/linux/compat.h   |  5 ++
 include/linux/syscalls.h |  5 +-
 3 files changed, 94 insertions(+), 14 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 653eed2add8e..b1a9f10b521a 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -729,16 +729,27 @@ SYSCALL_DEFINE5(select, int, n, fd_set __user *, inp, fd_set __user *, outp,
 }
 
 static long do_pselect(int n, fd_set __user *inp, fd_set __user *outp,
-		       fd_set __user *exp, struct timespec __user *tsp,
-		       const sigset_t __user *sigmask, size_t sigsetsize)
+		       fd_set __user *exp, void __user *tsp,
+		       const sigset_t __user *sigmask, size_t sigsetsize,
+		       enum poll_time_type type)
 {
 	sigset_t ksigmask, sigsaved;
 	struct timespec64 ts, end_time, *to = NULL;
 	int ret;
 
 	if (tsp) {
-		if (get_timespec64(&ts, tsp))
-			return -EFAULT;
+		switch (type) {
+		case PT_TIMESPEC:
+			if (get_timespec64(&ts, tsp))
+				return -EFAULT;
+			break;
+		case PT_OLD_TIMESPEC:
+			if (get_old_timespec32(&ts, tsp))
+				return -EFAULT;
+			break;
+		default:
+			BUG();
+		}
 
 		to = &end_time;
 		if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec))
@@ -750,7 +761,7 @@ static long do_pselect(int n, fd_set __user *inp, fd_set __user *outp,
 		return ret;
 
 	ret = core_sys_select(n, inp, outp, exp, to);
-	ret = poll_select_copy_remaining(&end_time, tsp, PT_TIMESPEC, ret);
+	ret = poll_select_copy_remaining(&end_time, tsp, type, ret);
 
 	restore_user_sigmask(sigmask, &sigsaved);
 
@@ -764,7 +775,27 @@ static long do_pselect(int n, fd_set __user *inp, fd_set __user *outp,
  * the sigset size.
  */
 SYSCALL_DEFINE6(pselect6, int, n, fd_set __user *, inp, fd_set __user *, outp,
-		fd_set __user *, exp, struct timespec __user *, tsp,
+		fd_set __user *, exp, struct __kernel_timespec __user *, tsp,
+		void __user *, sig)
+{
+	size_t sigsetsize = 0;
+	sigset_t __user *up = NULL;
+
+	if (sig) {
+		if (!access_ok(VERIFY_READ, sig, sizeof(void *)+sizeof(size_t))
+		    || __get_user(up, (sigset_t __user * __user *)sig)
+		    || __get_user(sigsetsize,
+				(size_t __user *)(sig+sizeof(void *))))
+			return -EFAULT;
+	}
+
+	return do_pselect(n, inp, outp, exp, tsp, up, sigsetsize, PT_TIMESPEC);
+}
+
+#if defined(CONFIG_COMPAT_32BIT_TIME) && !defined(CONFIG_64BIT)
+
+SYSCALL_DEFINE6(pselect6_time32, int, n, fd_set __user *, inp, fd_set __user *, outp,
+		fd_set __user *, exp, struct old_timespec32 __user *, tsp,
 		void __user *, sig)
 {
 	size_t sigsetsize = 0;
@@ -778,9 +809,11 @@ SYSCALL_DEFINE6(pselect6, int, n, fd_set __user *, inp, fd_set __user *, outp,
 			return -EFAULT;
 	}
 
-	return do_pselect(n, inp, outp, exp, tsp, up, sigsetsize);
+	return do_pselect(n, inp, outp, exp, tsp, up, sigsetsize, PT_OLD_TIMESPEC);
 }
 
+#endif
+
 #ifdef __ARCH_WANT_SYS_OLD_SELECT
 struct sel_arg_struct {
 	unsigned long n;
@@ -1289,16 +1322,26 @@ COMPAT_SYSCALL_DEFINE1(old_select, struct compat_sel_arg_struct __user *, arg)
 
 static long do_compat_pselect(int n, compat_ulong_t __user *inp,
 	compat_ulong_t __user *outp, compat_ulong_t __user *exp,
-	struct old_timespec32 __user *tsp, compat_sigset_t __user *sigmask,
-	compat_size_t sigsetsize)
+	void __user *tsp, compat_sigset_t __user *sigmask,
+	compat_size_t sigsetsize, enum poll_time_type type)
 {
 	sigset_t ksigmask, sigsaved;
 	struct timespec64 ts, end_time, *to = NULL;
 	int ret;
 
 	if (tsp) {
-		if (get_old_timespec32(&ts, tsp))
-			return -EFAULT;
+		switch (type) {
+		case PT_OLD_TIMESPEC:
+			if (get_old_timespec32(&ts, tsp))
+				return -EFAULT;
+			break;
+		case PT_TIMESPEC:
+			if (get_old_timespec32(&ts, tsp))
+				return -EFAULT;
+			break;
+		default:
+			BUG();
+		}
 
 		to = &end_time;
 		if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec))
@@ -1310,13 +1353,39 @@ static long do_compat_pselect(int n, compat_ulong_t __user *inp,
 		return ret;
 
 	ret = compat_core_sys_select(n, inp, outp, exp, to);
-	ret = poll_select_copy_remaining(&end_time, tsp, PT_OLD_TIMESPEC, ret);
+	ret = poll_select_copy_remaining(&end_time, tsp, type, ret);
 
 	restore_user_sigmask(sigmask, &sigsaved);
 
 	return ret;
 }
 
+#if defined(CONFIG_64BIT_TIME)
+
+COMPAT_SYSCALL_DEFINE6(pselect6_time64, int, n, compat_ulong_t __user *, inp,
+	compat_ulong_t __user *, outp, compat_ulong_t __user *, exp,
+	struct __kernel_timespec __user *, tsp, void __user *, sig)
+{
+	compat_size_t sigsetsize = 0;
+	compat_uptr_t up = 0;
+
+	if (sig) {
+		if (!access_ok(VERIFY_READ, sig,
+				sizeof(compat_uptr_t)+sizeof(compat_size_t)) ||
+				__get_user(up, (compat_uptr_t __user *)sig) ||
+				__get_user(sigsetsize,
+				(compat_size_t __user *)(sig+sizeof(up))))
+			return -EFAULT;
+	}
+
+	return do_compat_pselect(n, inp, outp, exp, tsp, compat_ptr(up),
+				 sigsetsize, PT_TIMESPEC);
+}
+
+#endif
+
+#if defined(CONFIG_COMPAT_32BIT_TIME)
+
 COMPAT_SYSCALL_DEFINE6(pselect6, int, n, compat_ulong_t __user *, inp,
 	compat_ulong_t __user *, outp, compat_ulong_t __user *, exp,
 	struct old_timespec32 __user *, tsp, void __user *, sig)
@@ -1332,10 +1401,13 @@ COMPAT_SYSCALL_DEFINE6(pselect6, int, n, compat_ulong_t __user *, inp,
 				(compat_size_t __user *)(sig+sizeof(up))))
 			return -EFAULT;
 	}
+
 	return do_compat_pselect(n, inp, outp, exp, tsp, compat_ptr(up),
-				 sigsetsize);
+				 sigsetsize, PT_OLD_TIMESPEC);
 }
 
+#endif
+
 #if defined(CONFIG_COMPAT_32BIT_TIME)
 COMPAT_SYSCALL_DEFINE5(ppoll, struct pollfd __user *, ufds,
 	unsigned int,  nfds, struct old_timespec32 __user *, tsp,
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 349a2d98e450..6896e6e51c00 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -641,6 +641,11 @@ asmlinkage long compat_sys_pselect6(int n, compat_ulong_t __user *inp,
 				    compat_ulong_t __user *exp,
 				    struct old_timespec32 __user *tsp,
 				    void __user *sig);
+asmlinkage long compat_sys_pselect6_time64(int n, compat_ulong_t __user *inp,
+				    compat_ulong_t __user *outp,
+				    compat_ulong_t __user *exp,
+				    struct __kernel_timespec __user *tsp,
+				    void __user *sig);
 asmlinkage long compat_sys_ppoll(struct pollfd __user *ufds,
 				 unsigned int nfds,
 				 struct old_timespec32 __user *tsp,
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 9755e70cfbb0..e9cd0409c3fe 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -467,7 +467,10 @@ asmlinkage long sys_sendfile64(int out_fd, int in_fd,
 
 /* fs/select.c */
 asmlinkage long sys_pselect6(int, fd_set __user *, fd_set __user *,
-			     fd_set __user *, struct timespec __user *,
+			     fd_set __user *, struct __kernel_timespec __user *,
+			     void __user *);
+asmlinkage long sys_pselect6_time32(int, fd_set __user *, fd_set __user *,
+			     fd_set __user *, struct old_timespec32 __user *,
 			     void __user *);
 asmlinkage long sys_ppoll(struct pollfd __user *, unsigned int,
 			  struct __kernel_timespec __user *, const sigset_t __user *,
-- 
2.17.1

