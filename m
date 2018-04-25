Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-900250-1524669295-2-9145489916874016704
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DCC_CHECK 1.1, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524669295; b=AL3dzBCf9PjEyYyz2sIp1TCK/mLBYkcnGixVcMw1iLXO4eon02
    AXOsG2t6DpWMJ/bWtY76ypg9/dJqqZNbVRu4W+F9fwM3Tr6u2ErKExgFoo+m/RX8
    rTHJu278PAG557G821YUmqhA5PeLYTFaI0/eQVT77WwVM6MEV1l2OndvgNtdGGrK
    QI17IAAxXRq56ZY85Q16szPGqGjxFXENTen+6cjfPtWwkMOMWPnP1RuptnP9iYnH
    qJ1yr3RbxN9HO+SJasgYiu/4yNZl0U3lXZlpCNnBfVrskIyVaEtjGMIZTIJAwROA
    v2Q0SKeQ5yD4mFEkFd53VIygpaEw/VS3aXZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524669295; bh=
    jNrLqgW7EDAXNQ8Ty7+IjCixDQlzM8U9UkerH2+5jD0=; b=oQ0L1+4P/yDtUEvJ
    71dopqvMFMcDjsLpAOrhL7pGi0HT4RGpb8EVA9s7tdm+5k5n+XdjT6hgeX8FEhq4
    8dPq8rujF8AE9ySXCgxsanuQ9h7VlGhU6mgqeEQBBXywpDfCgX7r2XMvqGqMs/G0
    GVp7kHJd5m1QyPGQBXbkj16AATmSpKOunn52J40a3/fWi0a+5YJGAr2I5TJWnqjy
    7cRZOOQG6Bs4clQeIonu9oJuKFtw4eXiAk1edasAt0r1UU260TtKQoQ+/mpsCc7O
    EzUtuSLlSa5y7nbSpGWSum4fMIeQr4R6tRHMyw3n/k8iUaVSAIjwhNH2J+7Qawu7
    hXP2qQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNiY+Z5SsQoILeU0F57r+xRlKmdBgpMj+VcVkDXxNN0KX0tzwNQaCqWdgzKcwPL578e8nL6OUo/PovwmvwZCtaPrgHXPSiNpcuvdk+AU9TQWPf9cUilD
    O4lXidLMsL7q4J2ko9IijxoPBM+rciZtffNcbIa2iHwBxadl4GeBDOzeLViGBqFZT8ywusN3eNsaXL9gZ9zcqweAW4n2KGHKm3zPP+pCYkXs+vrzw2x03Y/k
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=FNbY91q4yPS2UJJtoc0A:9 a=7NjrCPENOew_uOyn:21 a=pggDN5BVWsiSjfup:21
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754701AbeDYPHD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 11:07:03 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:48989 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754567AbeDYPHC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 11:07:02 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        libc-alpha@sourceware.org, tglx@linutronix.de,
        deepa.kernel@gmail.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, albert.aribaud@3adev.fr,
        linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, x86@kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-mips@linux-mips.org, jhogan@kernel.org, ralf@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        zackw@panix.com, noloader@gmail.com, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 01/16] y2038: asm-generic: Extend sysvipc data structures
Date: Wed, 25 Apr 2018 17:05:51 +0200
Message-Id: <20180425150606.954771-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:rzofm/IKNbWPqr4GjH0nXJtjoQAqLmjGLl4jPaangeBZGAU/3ID
 BXqS+Wo6W6wCrzvu4OeX9NstTEhNyOAzesPGsgDacgSgdKkF5uwhOI2wQEGmw4HtAC3gtpu
 gRSuUH5aqKshxU+nPAeaPviSL9kZUPMsdKxx51YbOPhjGaRCvYvPJch9e36xao46BG2CP9X
 bFG5vafR8T3e79vP1ohBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J+Cr7WiJN14=:OjPrDbxR1F6EpxUh6UxkIj
 zoDhplfpbIEdabXqD5fy5JLCUVbIjI452WuTZ08UpLMARTN35GkR0wi3jQ7g2iMwxBw3E6jJN
 labRbFM+t717ELT9gLSKspp0Sm3rzVR8VUWoDeOci9MKOKSy2zoUBf8BowxOspls0HpHZPXQn
 AUJ+pZe5z/36Ob0PvMQXW+kIvrpI1YMoOo37uz8yR4897qeCXe8sgrcFPI4COJwWrZtwzgi04
 3g3WlHwsVklNKteJHkD3diAMF1wnebfk2zQ+aIA1e+H15VP9rFljY0oQ9teYn8Nqyl0u1ADbP
 qTy0/J0eNHMf54vOjzC3GyFWoNYQYk9sfgjkj27Utkr5uoeU4ft35HNQMNo2dHjPYS7dZFvkM
 zbdWL8E0XPL/bRLXEQANahoYtylri+cpaRN83ekoL3EDaBS2xfbEuiw7FKxmrkd5tbgewPrl6
 uPf56CYDGmGlcErPO6wmvAWD0MNZtQ6vv7Gm3LFbM55+aM+T8xM7X7XWyHq/N4MQllxMGU0fw
 UjOoR6OoaFpPbUfhLq01jvdJrvH/QYbfoVcrN68Jx+kV3ajDVXfInDSBRfwzrnQhCYy7QDbAg
 EHnZfsNApmXHG6vXK+4kQ1kV51FuNrb6eU7/NI7j4ITjKWjcdYJwkcC2skQtSYXYj+TdLEzrv
 7QL3IeSHNDn0b0QsZJKcocT8H4GKglqV72PSMRrfb67mve/C9pA8UDkgonXOwE010ebtu3PqD
 NNWOVQ7p5e2RxbA1I1d1yimR8zf0HthvqajScQ==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Most architectures now use the asm-generic copy of the sysvipc data
structures (msqid64_ds, semid64_ds, shmid64_ds), which use 32-bit
__kernel_time_t on 32-bit architectures but have padding behind them to
allow extending the type to 64-bit.

Unfortunately, that fails on all big-endian architectures, which have the
padding on the wrong side. As so many of them get it wrong, we decided to
not bother even trying to fix it up when we introduced the asm-generic
copy. Instead we always use the padding word now to provide the upper
32 bits of the seconds value, regardless of the endianess.

A libc implementation on a typical big-endian system can deal with
this by providing its own copy of the structure definition to user
space, and swapping the two 32-bit words before returning from the
semctl/shmctl/msgctl system calls.

Note that msqid64_ds and shmid64_ds were broken on x32 since commit
f4b4aae18288 ("x86/headers/uapi: Fix __BITS_PER_LONG value for x32
builds"). I have sent a separate fix for that, but as we no longer
have to worry about x32 here, I no longer worry about x32 here and
use 'unsigned long' instead of __kernel_ulong_t.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/msgbuf.h | 27 +++++++++++++-------------
 include/uapi/asm-generic/sembuf.h | 26 +++++++++++++++----------
 include/uapi/asm-generic/shmbuf.h | 41 +++++++++++++++++++--------------------
 3 files changed, 49 insertions(+), 45 deletions(-)

diff --git a/include/uapi/asm-generic/msgbuf.h b/include/uapi/asm-generic/msgbuf.h
index fb306ebdb36f..9fe4881557cb 100644
--- a/include/uapi/asm-generic/msgbuf.h
+++ b/include/uapi/asm-generic/msgbuf.h
@@ -18,31 +18,30 @@
  * On big-endian systems, the padding is in the wrong place.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
+#if __BITS_PER_LONG == 64
 	__kernel_time_t msg_stime;	/* last msgsnd time */
-#if __BITS_PER_LONG != 64
-	unsigned long	__unused1;
-#endif
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
-#if __BITS_PER_LONG != 64
-	unsigned long	__unused2;
-#endif
 	__kernel_time_t msg_ctime;	/* last change time */
-#if __BITS_PER_LONG != 64
-	unsigned long	__unused3;
+#else
+	unsigned long	msg_stime;	/* last msgsnd time */
+	unsigned long	msg_stime_high;
+	unsigned long	msg_rtime;	/* last msgrcv time */
+	unsigned long	msg_rtime_high;
+	unsigned long	msg_ctime;	/* last change time */
+	unsigned long	msg_ctime_high;
 #endif
-	__kernel_ulong_t msg_cbytes;	/* current number of bytes on queue */
-	__kernel_ulong_t msg_qnum;	/* number of messages in queue */
-	__kernel_ulong_t msg_qbytes;	/* max number of bytes on queue */
+	unsigned long	msg_cbytes;	/* current number of bytes on queue */
+	unsigned long	msg_qnum;	/* number of messages in queue */
+	unsigned long	 msg_qbytes;	/* max number of bytes on queue */
 	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
 	__kernel_pid_t msg_lrpid;	/* last receive pid */
-	__kernel_ulong_t __unused4;
-	__kernel_ulong_t __unused5;
+	unsigned long	 __unused4;
+	unsigned long	 __unused5;
 };
 
 #endif /* __ASM_GENERIC_MSGBUF_H */
diff --git a/include/uapi/asm-generic/sembuf.h b/include/uapi/asm-generic/sembuf.h
index cbf9cfe977d6..0bae010f1b64 100644
--- a/include/uapi/asm-generic/sembuf.h
+++ b/include/uapi/asm-generic/sembuf.h
@@ -13,23 +13,29 @@
  * everyone just ended up making identical copies without specific
  * optimizations, so we may just as well all use the same one.
  *
- * 64 bit architectures typically define a 64 bit __kernel_time_t,
+ * 64 bit architectures use a 64-bit __kernel_time_t here, while
+ * 32 bit architectures have a pair of unsigned long values.
  * so they do not need the first two padding words.
- * On big-endian systems, the padding is in the wrong place.
  *
- * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
- * - 2 miscellaneous 32-bit values
+ * On big-endian systems, the padding is in the wrong place for
+ * historic reasons, so user space has to reconstruct a time_t
+ * value using
+ *
+ * user_semid_ds.sem_otime = kernel_semid64_ds.sem_otime +
+ *		((long long)kernel_semid64_ds.sem_otime_high << 32)
+ *
+ * Pad space is left for 2 miscellaneous 32-bit values
  */
 struct semid64_ds {
 	struct ipc64_perm sem_perm;	/* permissions .. see ipc.h */
+#if __BITS_PER_LONG == 64
 	__kernel_time_t	sem_otime;	/* last semop time */
-#if __BITS_PER_LONG != 64
-	unsigned long	__unused1;
-#endif
 	__kernel_time_t	sem_ctime;	/* last change time */
-#if __BITS_PER_LONG != 64
-	unsigned long	__unused2;
+#else
+	unsigned long	sem_otime;	/* last semop time */
+	unsigned long	sem_otime_high;
+	unsigned long	sem_ctime;	/* last change time */
+	unsigned long	sem_ctime_high;
 #endif
 	unsigned long	sem_nsems;	/* no. of semaphores in array */
 	unsigned long	__unused3;
diff --git a/include/uapi/asm-generic/shmbuf.h b/include/uapi/asm-generic/shmbuf.h
index 2b6c3bb97f97..e504422fc501 100644
--- a/include/uapi/asm-generic/shmbuf.h
+++ b/include/uapi/asm-generic/shmbuf.h
@@ -19,42 +19,41 @@
  *
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
 	size_t			shm_segsz;	/* size of segment (bytes) */
+#if __BITS_PER_LONG == 64
 	__kernel_time_t		shm_atime;	/* last attach time */
-#if __BITS_PER_LONG != 64
-	unsigned long		__unused1;
-#endif
 	__kernel_time_t		shm_dtime;	/* last detach time */
-#if __BITS_PER_LONG != 64
-	unsigned long		__unused2;
-#endif
 	__kernel_time_t		shm_ctime;	/* last change time */
-#if __BITS_PER_LONG != 64
-	unsigned long		__unused3;
+#else
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_atime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_ctime;	/* last change time */
+	unsigned long		shm_ctime_high;
 #endif
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
 	__kernel_pid_t		shm_lpid;	/* pid of last operator */
-	__kernel_ulong_t	shm_nattch;	/* no. of current attaches */
-	__kernel_ulong_t	__unused4;
-	__kernel_ulong_t	__unused5;
+	unsigned long		shm_nattch;	/* no. of current attaches */
+	unsigned long		__unused4;
+	unsigned long		__unused5;
 };
 
 struct shminfo64 {
-	__kernel_ulong_t	shmmax;
-	__kernel_ulong_t	shmmin;
-	__kernel_ulong_t	shmmni;
-	__kernel_ulong_t	shmseg;
-	__kernel_ulong_t	shmall;
-	__kernel_ulong_t	__unused1;
-	__kernel_ulong_t	__unused2;
-	__kernel_ulong_t	__unused3;
-	__kernel_ulong_t	__unused4;
+	unsigned long		shmmax;
+	unsigned long		shmmin;
+	unsigned long		shmmni;
+	unsigned long		shmseg;
+	unsigned long		shmall;
+	unsigned long		__unused1;
+	unsigned long		__unused2;
+	unsigned long		__unused3;
+	unsigned long		__unused4;
 };
 
 #endif /* __ASM_GENERIC_SHMBUF_H */
-- 
2.9.0

