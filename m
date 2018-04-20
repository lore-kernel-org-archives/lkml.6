Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1571551-1524226057-2-3927295332042574105
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
    1524226056; b=Luvt3gUcGlCl4uEUBo46cs+xFBuBeqyu1Ax5pCvRq1o/ciYdcI
    xCKkHmCqvIXe32E5J5kN0A3zttMQTgXi/88G3Z6DfUUy7yWaDweDDs5kPBQ9/igf
    XXhSmsONiJclvIWKtGLP0R/Z45PflHgZhNLMvzKiWaiK+rnfPMw2L3mEzFe5R5lK
    og8mh+tuswhPTjm6JdkRR871rYblsVC9a6Eno5I1CqW174ZFBAmeDYJnZV5bPrjG
    t5dWowNq0V5LQymmfpiOEUKtVEpYkQjP6kUb2vPRqxPev6TiV0NAC82RzgUnZP3q
    sYDEj+LK5wEJxutv06fzAvrNfOC/dvBW3Lyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524226056; bh=ei5CdbjGnxB0YI7LqJP91+IhPsDZ61
    IcB/+F5/F3LDE=; b=FThpPahd3GtRTnaEBNVee16eVDnnwhb7e7VCTuSt0oJj0/
    QLL8liB9aIHv0dOuRDt+LibOIFQcJWbEYZT34N3BXTgRI2Wv/8+6HVpDtMqy7DPE
    IBHorvClXjAp01sQozJ3rgcfCazuzy3H844INtfc1OnPe2ObUJ26r9jIX8epRGf9
    qKeKiv64VYHgtIreUyJqCGDYEW8BnRX0wvmvh9HQ7XN8RU93KWphvwF+LT7k3XaT
    +g6nEjr3xwn+qmPCjXj4cGSPYQizUhGfAe2i5IralbvlawiJ/lpb/X7Z8w6ZSRZa
    BIodi5MS9YvBYD33LekMfPpF3VbKozO9jn2LmcUw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfDXftkAgIGtrrTGhtGKFkdN+AZ9288pc2eJS+IuhGLp2fCFYAb1f+wz7BjLltR2Ye9BfWEB1XmhNbWiUxc2YRFeuEn4oEAAUDD7oh/ouQiuN6gxD1Z49
    UxKWgQLaBXx/IxOg4yc4oqlRAyHVVQEKDIFRIBxKysxROPOCLZzEhC3sBh9oyJLk9KrPUSZKw0xLvW735FYeGCiTwq6bgaoZaqi64JrJrXdpNAhZ5+ynTxzK
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=PtDNVHqPAAAA:8 a=uwY6HSmwGULrugzuKLYA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=BpimnaHY1jUKGyF_4-AF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754686AbeDTMHd (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 08:07:33 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:50873 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754673AbeDTMHb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Apr 2018 08:07:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Eggert <eggert@cs.ucla.edu>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org
Subject: [PATCH v2 1/2] y2038: rusage: Use __kernel_old_timeval for process times
Date: Fri, 20 Apr 2018 14:05:13 +0200
Message-Id: <20180420120605.1612248-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:0SNFXZmFStKcH5/8A4BPPkveCyAk32QpJigBXVo4F7YQWwpeUFS
 YVWvXTrGRJg2blaKLn2PhWh/cQQIIWp6/H9+pocsn+bRgyVDvA8bE5dHVpmIdven1UWJkjd
 AnBiCuEo9xd2qjP4VNFl2Wq9jloJs7r6AibkLCOcgOM2SqYdyLFY4C38APSKgwodCq++lOi
 hcExeyh3dw9UDhN1/Q5Gg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1gcBgKKlDZo=:Q+6FinLZilEVDee+qz6neT
 h1gRz00XaggIMUnZEYcrZfH30sFfmzW3cYltBx6jvvYuKFEaGQYqSzN3vA4ufhlaCcs3djAxj
 z8tTvYZyKn/x32p9BAjG8EqHxM2qrb5J9eJ6UASjBDgn+ilD7rtz2W7VKRSh76D5YNum/mxN5
 L+cBxM4JR23T+QBZizDRzm3kaeA4uK67jzmoKwcbK5whou6KJXuDvyQZrRTCF52thVzlA5GKg
 YzBKGF5LEntKNIm7pygiIq7v92M8rN1+Dm+6s8x4YSm7unTfX5Z8xs5H5D6okCbOgW1A4o4aV
 ziGZYWjEsBoyMFPzsnJq9eO8Ih+lQ9YMtxEtVWrpp5HaAnyoB4FHirDdpx2305o86aQHT1qFw
 Q6Z1acgsKpbTZEugFHnHdZdBUyQw+vM2LruB7UOizaagx89lfoT7CaJTqqaufnuimgOKdQsfr
 EN2jtSE6IBshoxMspPzSUzh5YVL2Kxf7x5oCgMbUtChqxbYBAf2h02o+UaSwbvey1gEyLYK+P
 3ilgc84pzqFayJTZSOxIvDyWJKNucHzRMZXgIM5bxa/ohxIorIaZ0pQ8DCt1pLjxx6dqlbm5I
 IGeFPZWVUs5eSMLB8wSivASC87aU58+YqD3Q9J438+fcOR5IYAGREQ0LC8NbnJW9YJ+uiujOZ
 pBSIro1UihWmryRRdpPJmoIKvuaa/kUgU0KmEEOibC1isNU905lmxJsqylKD4h4SKH8vLDDEf
 L114s0xht4EhYNbGOaJQJu2M1vdfxxSkWpegpA==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

'struct rusage' contains the run times of a process in 'timeval' format
and is accessed through the wait4() and getrusage() system calls. This
is not a problem for y2038 safety by itself, but causes an issue when
the C library starts using 64-bit time_t on 32-bit architectures because
the structure layout becomes incompatible.

There are three possible ways of dealing with this:

a) deprecate the wait4() and getrusage() system calls, and create
   a set of kernel interfaces based around a newly defined structure that
   could solve multiple problems at once, e.g. provide more fine-grained
   timestamps. The C library could then implement the posix interfaces
   on top of the new system calls.

b) Extend the approach taken by the x32 ABI, and use the 64-bit
   native structure layout for rusage on all architectures with new
   system calls that is otherwise compatible. A downside of this
   is that it requires a number of ugly hacks to deal with all the
   other fields of the structure also becoming 64 bit wide.
   Especially on big-endian architectures, we can't easily use the
   union trick from glibc.

c) Change the definition of struct rusage to be independent of
   time_t. This is the easiest change, as it does not involve new system
   call entry points, but it requires the C library to convert between
   the kernel format of the structure and the user space definition.

d) Add a new ABI variant of 'struct rusage' that corresponds to the
   current layout with 32-bit counters but 64-bit time_t. This would
   minimize the libc changes but require additional kernel code to
   handle a third binary layout on 64-bit kernels.

I'm picking approach c) for its simplicity. As pointed out by reviewers,
simply using the kernel structure in user space would not be POSIX
compliant, but I have verified that none of the usual C libraries (glibc,
musl, uclibc-ng, newlib) do that. Instead, they all provide their own
definition of 'struct rusage' to applications in sys/resource.h.

To be on the safe side, I'm only changing the definition inside of
the kernel and for user space with an updated 'time_t'. All existing
users will see the traditional layout that is compatible with what the
C libraries export. A 32-bit application that includes linux/resource.h
but uses an update C library with 64-bit time_t will now see the low-level
kernel structure that corresponds to the getrusage() system call interface
but that will be different from one defined in sys/resource.h for the
getrusage library interface.

Link: https://patchwork.kernel.org/patch/10077527/
Cc: Paul Eggert <eggert@cs.ucla.edu>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/kernel/osf_sys.c   | 15 +++++++++------
 include/uapi/linux/resource.h | 14 ++++++++++++--
 kernel/sys.c                  |  4 ++--
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 89faa6f4de47..cad03ee445b3 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1184,6 +1184,7 @@ SYSCALL_DEFINE4(osf_wait4, pid_t, pid, int __user *, ustatus, int, options,
 		struct rusage32 __user *, ur)
 {
 	unsigned int status = 0;
+	struct rusage32 r32;
 	struct rusage r;
 	long err = kernel_wait4(pid, &status, options, &r);
 	if (err <= 0)
@@ -1192,12 +1193,14 @@ SYSCALL_DEFINE4(osf_wait4, pid_t, pid, int __user *, ustatus, int, options,
 		return -EFAULT;
 	if (!ur)
 		return err;
-	if (put_tv_to_tv32(&ur->ru_utime, &r.ru_utime))
-		return -EFAULT;
-	if (put_tv_to_tv32(&ur->ru_stime, &r.ru_stime))
-		return -EFAULT;
-	if (copy_to_user(&ur->ru_maxrss, &r.ru_maxrss,
-	      sizeof(struct rusage32) - offsetof(struct rusage32, ru_maxrss)))
+	r32.ru_utime.tv_sec  = r.ru_utime.tv_sec;
+	r32.ru_utime.tv_usec = r.ru_utime.tv_usec;
+	r32.ru_stime.tv_sec  = r.ru_stime.tv_sec;
+	r32.ru_stime.tv_usec = r.ru_stime.tv_usec;
+	memcpy(&r32.ru_maxrss, &r.ru_maxrss,
+	      sizeof(struct rusage32) - offsetof(struct rusage32, ru_maxrss));
+
+	if (copy_to_user(ur, &r32, sizeof(r32)))
 		return -EFAULT;
 	return err;
 }
diff --git a/include/uapi/linux/resource.h b/include/uapi/linux/resource.h
index cc00fd079631..611d3745c70a 100644
--- a/include/uapi/linux/resource.h
+++ b/include/uapi/linux/resource.h
@@ -22,8 +22,18 @@
 #define	RUSAGE_THREAD	1		/* only the calling thread */
 
 struct	rusage {
-	struct timeval ru_utime;	/* user time used */
-	struct timeval ru_stime;	/* system time used */
+#if (__BITS_PER_LONG != 32 || !defined(__USE_TIME_BITS64)) && !defined(__KERNEL__)
+	struct timeval	ru_utime;	/* user time used */
+	struct timeval	ru_stime;	/* system time used */
+#else
+	/*
+	 * For 32-bit user space with 64-bit time_t, the binary layout
+	 * in these fields is incompatible with 'struct timeval', so the
+	 * C library has to translate this into the POSIX compatible layout.
+	 */
+	struct __kernel_old_timeval ru_utime;
+	struct __kernel_old_timeval ru_stime;
+#endif
 	__kernel_long_t	ru_maxrss;	/* maximum resident set size */
 	__kernel_long_t	ru_ixrss;	/* integral shared memory size */
 	__kernel_long_t	ru_idrss;	/* integral unshared data size */
diff --git a/kernel/sys.c b/kernel/sys.c
index ad692183dfe9..1de538f622e8 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1769,8 +1769,8 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	unlock_task_sighand(p, &flags);
 
 out:
-	r->ru_utime = ns_to_timeval(utime);
-	r->ru_stime = ns_to_timeval(stime);
+	r->ru_utime = ns_to_kernel_old_timeval(utime);
+	r->ru_stime = ns_to_kernel_old_timeval(stime);
 
 	if (who != RUSAGE_CHILDREN) {
 		struct mm_struct *mm = get_task_mm(p);
-- 
2.9.0

