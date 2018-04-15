Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-539844-1523804582-2-1491003972235250320
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523804581; b=Cy7CA10Rb/VxS2/d2JRfZdLEutPEqE8Na/ZH5aESwtNYjiJStM
    +dsMEWv4FzY86Yls+QNV3TRj/mf3oyO+VrR77vecxu+WK8iGfxLy0+7hOSVwj39F
    HLD/NFq57lyD3zhiY4UuO1NlCHWdMPg/20vk1dEruQ3yiOcrnK0oURW1qJ00ILJJ
    z53Jt3vTZWnqwxpGtt7MQfMRA+n6R1UEbwiK5RV77s5Yo8sBTo8UlJJQlAmtv7AG
    FBNIpTJS8m1P+UJywUFjh3Nf9QH5G/Al22NYGNEUmzVXVZhdkLfSUgi58aE6CVWf
    CRSGowkNUU50aMm/5NMAM8Ey/zPk6vz4VaYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523804581; bh=
    c+Z92HOp6csJOrzG5JqF3Uep6tLvp0P0vp6T6TQ49cQ=; b=TMLetLM49IVcXv38
    OX8/r6QlybcTiERjY9q+UZ02a+VtsyzejFZv64irm93fRo/T6/ski34BcT7iG/dx
    dxhxjN9lnyRBWBu9JO6uN34khKbScKKWT/ZDalyGoJZRtia9RSXqXXth8mshrdWI
    BlPn76zvHlbCLss1LEdZSWtcz6NYj8iYz2q/nvf8dbRw+W4ZJgfEVk2+k4j96cgY
    wKL57V0+fRpvcuzfgpbWmMkKM0CCrBG1/ksY5PjEbPcinaQN+iziAOdwAFF1xEbu
    vPEFbqcxXdwQBxipdFUtmeZPBz+agyk04L2gUhBF46d6VoH8BlY4/dT4rfZ7wHOM
    msVHgA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=GK4g4bOe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=GK4g4bOe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEMi04K9wOezLFuVoC1/HfXooZUpkM0g/TP2UGn08MfmI0mn7T1b01f/xik7RpNsc1EakJ4N/cshnUySCB3Gb/frH8LTvjvZwtBjZW7TKBo+AVT0rRrS
    wFpYPvrLZfA5YHmmjQ5FJ4CgHY/A/TZhq1L2Cq4/uRIUGuwruwU7PbVfOq9CBucCwRS/2fWMZKTpxjvwkA+/bjs00m/4PJKPiB4qCw472gWOnV+v/mVov0bk
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=ag1SF4gXAAAA:8
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=haeVt1Z3vwnvLCLuccwA:9 a=x8gzFH9gYPwA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753215AbeDOPCo (ORCPT <rfc822;greg@kroah.com>);
        Sun, 15 Apr 2018 11:02:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752931AbeDOPBk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 15 Apr 2018 11:01:40 -0400
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] aio: implement io_pgetevents
Date: Sun, 15 Apr 2018 17:01:08 +0200
Message-Id: <20180415150108.1341-8-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180415150108.1341-1-hch@lst.de>
References: <20180415150108.1341-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the io_getevents equivalent of ppoll/pselect and allows to
properly mix signals and aio completions (especially with IOCB_CMD_POLL)
and atomically executes the following sequence:

	sigset_t origmask;

	pthread_sigmask(SIG_SETMASK, &sigmask, &origmask);
	ret = io_getevents(ctx, min_nr, nr, events, timeout);
	pthread_sigmask(SIG_SETMASK, &origmask, NULL);

Note that unlike many other signal related calls we do not pass a sigmask
size, as that would get us to 7 arguments, which aren't easily supported
by the syscall infrastructure.  It seems a lot less painful to just add a
new syscall variant in the unlikely case we're going to increase the
sigset size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/aio.c                               | 114 ++++++++++++++++++++++---
 include/linux/compat.h                 |   7 ++
 include/linux/syscalls.h               |   6 ++
 include/uapi/asm-generic/unistd.h      |   4 +-
 include/uapi/linux/aio_abi.h           |   6 ++
 kernel/sys_ni.c                        |   2 +
 8 files changed, 130 insertions(+), 11 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c58f75b088c5..99b6f7a36178 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -391,3 +391,4 @@
 382	i386	pkey_free		sys_pkey_free
 383	i386	statx			sys_statx
 384	i386	arch_prctl		sys_arch_prctl			compat_sys_arch_prctl
+385	i386	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 5aef183e2f85..e995cd2b4e65 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -339,6 +339,7 @@
 330	common	pkey_alloc		sys_pkey_alloc
 331	common	pkey_free		sys_pkey_free
 332	common	statx			sys_statx
+333	common	io_pgetevents		sys_io_pgetevents
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/aio.c b/fs/aio.c
index de56496ba86c..5cfeb5bc3a7d 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1303,10 +1303,6 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
 		wait_event_interruptible_hrtimeout(ctx->wait,
 				aio_read_events(ctx, min_nr, nr, event, &ret),
 				until);
-
-	if (!ret && signal_pending(current))
-		ret = -EINTR;
-
 	return ret;
 }
 
@@ -1913,13 +1909,60 @@ SYSCALL_DEFINE5(io_getevents, aio_context_t, ctx_id,
 		struct timespec __user *, timeout)
 {
 	struct timespec64	ts;
+	int			ret;
+
+	if (timeout && unlikely(get_timespec64(&ts, timeout)))
+		return -EFAULT;
+
+	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &ts : NULL);
+	if (!ret && signal_pending(current))
+		ret = -EINTR;
+	return ret;
+}
 
-	if (timeout) {
-		if (unlikely(get_timespec64(&ts, timeout)))
+SYSCALL_DEFINE6(io_pgetevents,
+		aio_context_t, ctx_id,
+		long, min_nr,
+		long, nr,
+		struct io_event __user *, events,
+		struct timespec __user *, timeout,
+		const struct __aio_sigset __user *, usig)
+{
+	struct __aio_sigset	ksig = { NULL, };
+	sigset_t		ksigmask, sigsaved;
+	struct timespec64	ts;
+	int ret;
+
+	if (timeout && unlikely(get_timespec64(&ts, timeout)))
+		return -EFAULT;
+
+	if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
+		return -EFAULT;
+
+	if (ksig.sigmask) {
+		if (ksig.sigsetsize != sizeof(sigset_t))
+			return -EINVAL;
+		if (copy_from_user(&ksigmask, ksig.sigmask, sizeof(ksigmask)))
 			return -EFAULT;
+		sigdelsetmask(&ksigmask, sigmask(SIGKILL) | sigmask(SIGSTOP));
+		sigprocmask(SIG_SETMASK, &ksigmask, &sigsaved);
+	}
+
+	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &ts : NULL);
+	if (signal_pending(current)) {
+		if (ksig.sigmask) {
+			current->saved_sigmask = sigsaved;
+			set_restore_sigmask();
+		}
+
+		if (!ret)
+			ret = -ERESTARTNOHAND;
+	} else {
+		if (ksig.sigmask)
+			sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 	}
 
-	return do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &ts : NULL);
+	return ret;
 }
 
 #ifdef CONFIG_COMPAT
@@ -1930,13 +1973,64 @@ COMPAT_SYSCALL_DEFINE5(io_getevents, compat_aio_context_t, ctx_id,
 		       struct compat_timespec __user *, timeout)
 {
 	struct timespec64 t;
+	int ret;
+
+	if (timeout && compat_get_timespec64(&t, timeout))
+		return -EFAULT;
+
+	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &t : NULL);
+	if (!ret && signal_pending(current))
+		ret = -EINTR;
+	return ret;
+}
+
 
-	if (timeout) {
-		if (compat_get_timespec64(&t, timeout))
+struct __compat_aio_sigset {
+	compat_sigset_t __user	*sigmask;
+	compat_size_t		sigsetsize;
+};
+
+COMPAT_SYSCALL_DEFINE6(io_pgetevents,
+		compat_aio_context_t, ctx_id,
+		compat_long_t, min_nr,
+		compat_long_t, nr,
+		struct io_event __user *, events,
+		struct compat_timespec __user *, timeout,
+		const struct __compat_aio_sigset __user *, usig)
+{
+	struct __compat_aio_sigset ksig = { NULL, };
+	sigset_t ksigmask, sigsaved;
+	struct timespec64 t;
+	int ret;
+
+	if (timeout && compat_get_timespec64(&t, timeout))
+		return -EFAULT;
+
+	if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
+		return -EFAULT;
+
+	if (ksig.sigmask) {
+		if (ksig.sigsetsize != sizeof(compat_sigset_t))
+			return -EINVAL;
+		if (get_compat_sigset(&ksigmask, ksig.sigmask))
 			return -EFAULT;
+		sigdelsetmask(&ksigmask, sigmask(SIGKILL) | sigmask(SIGSTOP));
+		sigprocmask(SIG_SETMASK, &ksigmask, &sigsaved);
+	}
 
+	ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &t : NULL);
+	if (signal_pending(current)) {
+		if (ksig.sigmask) {
+			current->saved_sigmask = sigsaved;
+			set_restore_sigmask();
+		}
+		if (!ret)
+			ret = -ERESTARTNOHAND;
+	} else {
+		if (ksig.sigmask)
+			sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 	}
 
-	return do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &t : NULL);
+	return ret;
 }
 #endif
diff --git a/include/linux/compat.h b/include/linux/compat.h
index f188eab10570..fdd068f192c1 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -310,6 +310,7 @@ extern int put_compat_rusage(const struct rusage *,
 			     struct compat_rusage __user *);
 
 struct compat_siginfo;
+struct __compat_aio_sigset;
 
 struct compat_dirent {
 	u32		d_ino;
@@ -528,6 +529,12 @@ asmlinkage long compat_sys_io_getevents(compat_aio_context_t ctx_id,
 					compat_long_t nr,
 					struct io_event __user *events,
 					struct compat_timespec __user *timeout);
+asmlinkage long compat_sys_io_pgetevents(compat_aio_context_t ctx_id,
+					compat_long_t min_nr,
+					compat_long_t nr,
+					struct io_event __user *events,
+					struct compat_timespec __user *timeout,
+					const struct __compat_aio_sigset __user *usig);
 
 /* fs/cookies.c */
 asmlinkage long compat_sys_lookup_dcookie(u32, u32, char __user *, compat_size_t);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index b961184f597a..c40cf5ec24c9 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -264,6 +264,12 @@ asmlinkage long sys_io_getevents(aio_context_t ctx_id,
 				long nr,
 				struct io_event __user *events,
 				struct timespec __user *timeout);
+asmlinkage long sys_io_pgetevents(aio_context_t ctx_id,
+				long min_nr,
+				long nr,
+				struct io_event __user *events,
+				struct timespec __user *timeout,
+				const struct __aio_sigset *sig);
 
 /* fs/xattr.c */
 asmlinkage long sys_setxattr(const char __user *path, const char __user *name,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 8bcb186c6f67..42990676a55e 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -732,9 +732,11 @@ __SYSCALL(__NR_pkey_alloc,    sys_pkey_alloc)
 __SYSCALL(__NR_pkey_free,     sys_pkey_free)
 #define __NR_statx 291
 __SYSCALL(__NR_statx,     sys_statx)
+#define __NR_io_pgetevents 292
+__SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
 
 #undef __NR_syscalls
-#define __NR_syscalls 292
+#define __NR_syscalls 293
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
index a04adbc70ddf..2c0a3415beee 100644
--- a/include/uapi/linux/aio_abi.h
+++ b/include/uapi/linux/aio_abi.h
@@ -29,6 +29,7 @@
 
 #include <linux/types.h>
 #include <linux/fs.h>
+#include <linux/signal.h>
 #include <asm/byteorder.h>
 
 typedef __kernel_ulong_t aio_context_t;
@@ -108,5 +109,10 @@ struct iocb {
 #undef IFBIG
 #undef IFLITTLE
 
+struct __aio_sigset {
+	sigset_t __user	*sigmask;
+	size_t		sigsetsize;
+};
+
 #endif /* __LINUX__AIO_ABI_H */
 
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 6cafc008f6db..7571cf9d7424 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -33,7 +33,9 @@ COND_SYSCALL(io_submit);
 COND_SYSCALL_COMPAT(io_submit);
 COND_SYSCALL(io_cancel);
 COND_SYSCALL(io_getevents);
+COND_SYSCALL(io_pgetevents);
 COND_SYSCALL_COMPAT(io_getevents);
+COND_SYSCALL_COMPAT(io_pgetevents);
 
 /* fs/xattr.c */
 
-- 
2.17.0

