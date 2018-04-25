Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-937867-1524672499-2-18435170236240086168
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524672498; b=ucPJr8B1Y9NFe9gwO9wLyqHA+8T+wiZjA34x+LswmiHIyaIAen
    EMLAH90xBokkLgFKC6WkVT7QKDIETUh07pqaTmGTDlLG+Zfq8NBvSKuRSF2CdWjz
    /Otj1pDnoGf/QcRD2bn2uF56T7Y+HEWNTn2f6Bk3VAVfX+e8rSMmsHfMD60hmCpW
    xR7/PBgIj1BGqA2utJujMRtFAaCCFl+T4P/rmQvjp85oxDjX7jJhOfCdS6V7Yu/y
    zawRxYHAbboGTiDTagaqv7U/E5nyYPV06HtpyDbpEmu7ODzKvhVDeNY8o2NvLPvb
    Aap3JQHbnS/xcx2punZ9QDv1gSjYQOhHI+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524672498; bh=
    Ry9u5gt7jUuMcuK5C0RaJUdibaiQPihlFni9W9Qffk0=; b=EmnwPRIuHY3UOkgd
    YZP609LPIY5WK04X9BLE0YHtJj6jqoJJELd8vGuginZ6xQlyDTwITPVtN0N+/PFO
    4h03Uw2h6OU3+nqwTVu+Fts1mq2fp3WA6Lp5lNV60WL7jYWkH++ofOFgjDqEe951
    /+umS00HAtUI4MFJT4kZn1sRUmMTHjwDMTLIFwVUw3nYT4Xy0HOB7JBXFHQD4AbP
    GAON34pWjgIXTHSyTHpbPIu9PK65C4ipz6NtEKtXPaeEgPCtoOr8l0wX/4RL9UY8
    /PMSVFKQYu8y6sPCViRLW5/VaGoChF7BUh8kfj3g0do9BxWRoENnm0lW1fQWRMJT
    BtCeAg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGaIaydLMSb+B7eWxSrCC0y6Szdq5SwqxJ2NKhxDdRw3ve9kIcY3ctpc/zBfnMBQbpwbK3EyMz6GLpB2U7xvoQYhuQ0Jsr12CXWTe5+0Xx2ESXTKL9K7
    XwI3QTjao5o8fwWLOlOIypPyY39+4FxPuwOCiLoDTrJakspMgdfsaNQhsTUzztY1btVjgxfXV+wGWTOVdO/WCVb0dm/P+xKZnZwwWXVxeUS53kKpKz5uLUMq
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=go4SHiR5EDEQzzRrmHkA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755845AbeDYQFB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 12:05:01 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:50117 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754578AbeDYQEz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 12:04:55 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        tglx@linutronix.de, netdev@vger.kernel.org, deepa.kernel@gmail.com,
        viro@zeniv.linux.org.uk, albert.aribaud@3adev.fr,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 14/17] y2038: socket: Add compat_sys_recvmmsg_time64
Date: Wed, 25 Apr 2018 18:03:08 +0200
Message-Id: <20180425160311.2718314-15-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425160311.2718314-1-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de>
X-Provags-ID: V03:K1:dHIHUzO9bnjqbCTrlKSvM8snJn28+p7M2xabbLAaIIVkidEkDYO
 EkF5gzVX36Iqjt1OjfQiFAQN2VkWvKpp/ajQvbpqzdBXVD5ZFi2ghGvEM0VUnmn1/P7vlnR
 V0vF57lvMqrEkgYFfCkF2Y+thR/8FmJvWVHziAgzQdoLfbtmW5GFC1QXLH101pyY1iqdoa2
 AoQaAceRPI88evL8RaSUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hsOUounq7to=:uBmn6NOvgVy5KCUbgV6WyK
 2CQPwZgE6lIv32HwyOMHt4pNl5RTjNwCjIPNIpBkChqAEwFVXybyE67DFtyE42rXAn41tLxSi
 M37s4LR3JPdaibYA60OIgH6HXD4P8yvZEt5ryLycKAPgSOBuWI9+sNIv7eF9Frnf2tGETSn57
 SXUnRne4yRq1ZEk7PD3KcYvrD72aHgc0jLqACxkc0gHOUeWi9aaLlq4cd6uW8hE8rzIIas5BP
 wi6EZXawItA5UYe5+QxyaZnbJRQ2eRyauqWc57bN7elZZG72NNDzUuS89Nujc/vIZIJmmUGsH
 mmKi5jdVpLIIphAYGprZMt72j+4wpXwN2AEQ/l4OflA1CAm9P3ZvsTLdUU8snFx8cCydWl0xe
 cCCu28tHMFMm2k+d88iAo8cYhhvSEznWdHqDgF+N6pX+0C5w9bW1b+AimgHHa4r5IqHIqevZd
 J42gJgQL5QbCskMEWCEVezOexhJxgB2vKg9P2rnP32FWz6WJiub093eAk2BoFMQRESR3uo24/
 Cwejs/CKOlVjQqgrVoUQJ/VEsN2NyuydKL36VKubnMa2YvWyQTEEHFEpidpF+3iVekJM5Akau
 LZ4PMwGlj1EuoWuSy3Z7EiZjWiot3RllhttLuo9efPhx65rc3tE/5f0H2jJcsTAL4IDn45Okf
 I/Cq24X4YTYf0WxsQiZvdG3cTrliFJVxTzIKiqbm38gswfvB7OZfqm+41mYVMryNtVW8=
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

recvmmsg() takes two arguments to pointers of structures that differ
between 32-bit and 64-bit architectures: mmsghdr and timespec.

For y2038 compatbility, we are changing the native system call from
timespec to __kernel_timespec with a 64-bit time_t (in another patch),
and use the existing compat system call on both 32-bit and 64-bit
architectures for compatibility with traditional 32-bit user space.

As we now have two variants of recvmmsg() for 32-bit tasks that are both
different from the variant that we use on 64-bit tasks, this means we
also require two compat system calls!

The solution I picked is to flip things around: The existing
compat_sys_recvmmsg() call gets moved from net/compat.c into net/socket.c
and now handles the case for old user space on all architectures that
have set CONFIG_COMPAT_32BIT_TIME.  A new compat_sys_recvmmsg_time64()
call gets added in the old place for 64-bit architectures only, this
one handles the case of a compat mmsghdr structure combined with
__kernel_timespec.

In the indirect sys_socketcall(), we now need to call either
do_sys_recvmmsg() or __compat_sys_recvmmsg(), depending on what kind of
architecture we are on. For compat_sys_socketcall(), no such change is
needed, we always call __compat_sys_recvmmsg().

I decided to not add a new SYS_RECVMMSG_TIME64 socketcall: Any libc
implementation for 64-bit time_t will need significant changes including
an updated asm/unistd.h, and it seems better to consistently use the
separate syscalls that configuration, leaving the socketcall only for
backward compatibility with 32-bit time_t based libc.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/compat.h |  5 ++++-
 include/linux/socket.h | 15 ++++++++++++++-
 kernel/sys_ni.c        |  1 +
 net/compat.c           | 14 +++++++-------
 net/socket.c           | 39 +++++++++++++++++++++++++++++++++++++--
 5 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 7887b0a54c1e..f9423bbf7e7c 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -863,7 +863,10 @@ asmlinkage long compat_sys_move_pages(pid_t pid, compat_ulong_t nr_pages,
 asmlinkage long compat_sys_rt_tgsigqueueinfo(compat_pid_t tgid,
 					compat_pid_t pid, int sig,
 					struct compat_siginfo __user *uinfo);
-asmlinkage long compat_sys_recvmmsg(int fd, struct compat_mmsghdr __user *mmsg,
+asmlinkage long compat_sys_recvmmsg_time64(int fd, struct compat_mmsghdr __user *mmsg,
+				    unsigned vlen, unsigned int flags,
+				    struct __kernel_timespec __user *timeout);
+asmlinkage long compat_sys_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 				    unsigned vlen, unsigned int flags,
 				    struct compat_timespec __user *timeout);
 asmlinkage long compat_sys_wait4(compat_pid_t pid,
diff --git a/include/linux/socket.h b/include/linux/socket.h
index d36a6c1bdbaf..22358e0e1288 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -2,8 +2,8 @@
 #ifndef _LINUX_SOCKET_H
 #define _LINUX_SOCKET_H
 
-
 #include <asm/socket.h>			/* arch-dependent defines	*/
+#include <linux/errno.h>
 #include <linux/sockios.h>		/* the SIOCxxx I/O controls	*/
 #include <linux/uio.h>			/* iovec support		*/
 #include <linux/types.h>		/* pid_t			*/
@@ -346,6 +346,7 @@ extern int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_sto
 extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
 
 struct timespec64;
+struct compat_timespec;
 
 /* The __sys_...msg variants allow MSG_CMSG_COMPAT iff
  * forbid_cmsg_compat==false
@@ -356,6 +357,18 @@ extern long __sys_sendmsg(int fd, struct user_msghdr __user *msg,
 			  unsigned int flags, bool forbid_cmsg_compat);
 extern int __sys_recvmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 			  unsigned int flags, struct timespec64 *timeout);
+#ifdef CONFIG_COMPAT_32BIT_TIME
+extern int __compat_sys_recvmmsg(int fd, struct mmsghdr __user *mmsg,
+				 unsigned int vlen, unsigned int flags,
+				 struct compat_timespec __user *timeout);
+#else
+static inline int __compat_sys_recvmmsg(int fd, struct mmsghdr __user *mmsg,
+					unsigned int vlen, unsigned int flags,
+					struct compat_timespec __user *timeout)
+{
+	return -EINVAL;
+}
+#endif
 extern int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg,
 			  unsigned int vlen, unsigned int flags,
 			  bool forbid_cmsg_compat);
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 9791364925dc..61fc9babe6ce 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -283,6 +283,7 @@ COND_SYSCALL(perf_event_open);
 COND_SYSCALL(accept4);
 COND_SYSCALL(recvmmsg);
 COND_SYSCALL_COMPAT(recvmmsg);
+COND_SYSCALL_COMPAT(recvmmsg_time64);
 
 /*
  * Architecture specific syscalls: see further below
diff --git a/net/compat.c b/net/compat.c
index 93b80a3d967c..7521a0afe18d 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -810,9 +810,9 @@ COMPAT_SYSCALL_DEFINE6(recvfrom, int, fd, void __user *, buf, compat_size_t, len
 	return __compat_sys_recvfrom(fd, buf, len, flags, addr, addrlen);
 }
 
-static int __compat_sys_recvmmsg(int fd, struct compat_mmsghdr __user *mmsg,
+static int __compat_sys_recvmmsg_time64(int fd, struct compat_mmsghdr __user *mmsg,
 				 unsigned int vlen, unsigned int flags,
-				 struct compat_timespec __user *timeout)
+				 struct __kernel_timespec __user *timeout)
 {
 	int datagrams;
 	struct timespec64 ktspec;
@@ -821,22 +821,22 @@ static int __compat_sys_recvmmsg(int fd, struct compat_mmsghdr __user *mmsg,
 		return __sys_recvmmsg(fd, (struct mmsghdr __user *)mmsg, vlen,
 				      flags | MSG_CMSG_COMPAT, NULL);
 
-	if (compat_get_timespec64(&ktspec, timeout))
+	if (get_timespec64(&ktspec, timeout))
 		return -EFAULT;
 
 	datagrams = __sys_recvmmsg(fd, (struct mmsghdr __user *)mmsg, vlen,
 				   flags | MSG_CMSG_COMPAT, &ktspec);
-	if (datagrams > 0 && compat_put_timespec64(&ktspec, timeout))
+	if (datagrams > 0 && put_timespec64(&ktspec, timeout))
 		datagrams = -EFAULT;
 
 	return datagrams;
 }
 
-COMPAT_SYSCALL_DEFINE5(recvmmsg, int, fd, struct compat_mmsghdr __user *, mmsg,
+COMPAT_SYSCALL_DEFINE5(recvmmsg_time64, int, fd, struct compat_mmsghdr __user *, mmsg,
 		       unsigned int, vlen, unsigned int, flags,
-		       struct compat_timespec __user *, timeout)
+		       struct __kernel_timespec __user *, timeout)
 {
-	return __compat_sys_recvmmsg(fd, mmsg, vlen, flags, timeout);
+	return __compat_sys_recvmmsg_time64(fd, mmsg, vlen, flags, timeout);
 }
 
 COMPAT_SYSCALL_DEFINE2(socketcall, int, call, u32 __user *, args)
diff --git a/net/socket.c b/net/socket.c
index 4510e6269764..5e97b645bfee 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2483,6 +2483,37 @@ SYSCALL_DEFINE5(recvmmsg, int, fd, struct mmsghdr __user *, mmsg,
 	return do_sys_recvmmsg(fd, mmsg, vlen, flags, timeout);
 }
 
+#ifdef CONFIG_COMPAT_32BIT_TIME
+int __compat_sys_recvmmsg(int fd, struct mmsghdr __user *mmsg,
+			  unsigned int vlen, unsigned int flags,
+			  struct compat_timespec __user *timeout)
+{
+	int datagrams;
+	struct timespec64 ktspec;
+
+	if (timeout == NULL)
+		return __sys_recvmmsg(fd, (struct mmsghdr __user *)mmsg, vlen,
+				      flags | MSG_CMSG_COMPAT, NULL);
+
+	if (compat_get_timespec64(&ktspec, timeout))
+		return -EFAULT;
+
+	datagrams = __sys_recvmmsg(fd, (struct mmsghdr __user *)mmsg, vlen,
+				   flags | MSG_CMSG_COMPAT, &ktspec);
+	if (datagrams > 0 && compat_put_timespec64(&ktspec, timeout))
+		datagrams = -EFAULT;
+
+	return datagrams;
+}
+
+COMPAT_SYSCALL_DEFINE5(recvmmsg, int, fd, struct mmsghdr __user *, mmsg,
+		       unsigned int, vlen, unsigned int, flags,
+		       struct compat_timespec __user *, timeout)
+{
+	return __compat_sys_recvmmsg(fd, mmsg, vlen, flags, timeout);
+}
+#endif
+
 #ifdef __ARCH_WANT_SYS_SOCKETCALL
 /* Argument list sizes for sys_socketcall */
 #define AL(x) ((x) * sizeof(unsigned long))
@@ -2600,8 +2631,12 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 				    a[2], true);
 		break;
 	case SYS_RECVMMSG:
-		err = do_sys_recvmmsg(a0, (struct mmsghdr __user *)a1, a[2],
-				      a[3], (struct __kernel_timespec __user *)a[4]);
+		if (IS_ENABLED(CONFIG_64BIT) || !IS_ENABLED(CONFIG_64BIT_TIME))
+			err = do_sys_recvmmsg(a0, (struct mmsghdr __user *)a1, a[2],
+					      a[3], (struct __kernel_timespec __user *)a[4]);
+		else
+			err = __compat_sys_recvmmsg(a0, (struct mmsghdr __user *)a1, a[2],
+					      a[3], (struct compat_timespec __user *)a[4]);
 		break;
 	case SYS_ACCEPT4:
 		err = __sys_accept4(a0, (struct sockaddr __user *)a1,
-- 
2.9.0

