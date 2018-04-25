Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-889516-1524669275-2-14037431973026245481
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DCC_CHECK 1.1, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524669273; b=BhvmbVA1bcwfvmbce41nLPTTrQLKAXtrWc5sy9ds1hoibpyyCi
    YhOVtaHWp/byqXk0ir8gvFhqCkg/HCJMpM3vtk4gXXLYoJarsLjXER67mvgSXYav
    Ki4Oc7FjjWvMLxTFA+wwlI51yntEz4ju4LAkiZ+pjHXbx/TBapO5Y4B6qEQfdgBV
    SHYRVdMZjOn0Dsz+JL7nMCKmgxE+jnZ7q5LJL5wSh/cnNjId21qXTGvPHjOiKleR
    +WjomHyJYr58RzA/xW1KPNFgVmmLu4kOMaas0wkx7cjK/8/7Jhd+XUlu/waWZnXr
    AlZbiEsQOP7XvdxqEGmBEmK2LZrdfFZ/Aqsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524669273; bh=
    vV0FctT/ow8B8vAC52Qpiyf6hjmzEAkfGtXatO91bUQ=; b=SzEyH4TAoXDAS2xx
    PWZU7h6s03/7mw1BemzoRBxiFMxc+QpGKVHYG7Ed8uRhln+IoAUz9d7bHQPw0w5K
    ciwD3/89aXCygYv30ruSnZEVOEglpMVJBYyCUPhaaUS9uSy3plm5UVWWZDWlMR3b
    jwMBS0pMHAGEE8qiwKlTkvr6rg25cicU19/vFgZWCgDWzQ/yT3jdxxnDSVZl+7MI
    V/FBr22EwNcx9mQ15unmKqFr2Bdla7RnuJ8cPSyQqtumCQ817pi916NqldC5x7w2
    APs+PLIDvqxCvuyZSF7r9LHo5VnfvHtcn5M42bHtXj1YjB10G2p+bznOHe1IerGw
    jin9Lw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLwksrdlLoDTHKRPbNlwHEZ9OwUC4/cekr4eu5Ql39K+XJZRG3OLs581w9fjHOk8Y+Pha81w+f3y5BwyEbF4m2VbJ0iJApT0j6vPIep4ma6QsvAGoa2w
    72viFbdb54fj02nNJt4weS8seNGUbtCLHgL3UREK1II2YmODR0BJlRSCRcGgRCALBuhI0lQXuQ4wVH6ifHbSxu2xZeUgJD0uq5qvbLb038Lsiq0/+/xjUgXI
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=vDQ7Dej8Tvy-y2caQbYA:9 a=xZJ_Frh7KFX-Nb_I:21 a=5UFXzkdQKP7iyrdr:21
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754847AbeDYPOa (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 11:14:30 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:46831 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754567AbeDYPHG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 11:07:06 -0400
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
Subject: [PATCH v4 08/16] y2038: parisc: Extend sysvipc data structures
Date: Wed, 25 Apr 2018 17:05:58 +0200
Message-Id: <20180425150606.954771-8-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:TFixS2nnqb6+A+fVgvSi/V4GlXqegI+wXs/3ixDn7vT38HHoVYH
 kux6Rc3OVBtfakC9A0hWhHbX4BOb/mkF8fJhPe0ca5RMJXwqZ0xaFU+xVwZidvsOdqicbBH
 YYQWdH+/PuQ4Vcs9I/+5MQGsjaUFQh2o8u9XZrgdQTPiWe7XOcskmZM8iOPya8dd25Gqv0J
 K0ngVeeLhaWM/XaD/dptw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WXETWLqf7PE=:nQX1ie/0vIpYQcwoz1oR/v
 QFZ+kxGZHlnJnlHGzNlJNfAuPMD6ge7LL1AWEntrGNNhpiARQPBuLoVi9wDIkEUrddodDFvCr
 rjnsOkkm5b2n5p4uYgYtNahCdcvt11VXK1fw4dqPnE3HjObvGNpuBpem7bXSvgC1CqvJbBfb2
 yc2tSIbSBVbb4HmjSjz89rnCVctveD/A98orc2CdyfI7lR1NXAqpilkZ3KOBI95NmML8gz76o
 Ix9TqRzipZ+ZOh4LWaIGlffm/c0asXsJ5BX9/tgARHznccPCo6mmFVt1MIlGTUqFi8EAJHuOc
 RjVZR1YIKbRDP0fnYaMzaZSASj3R7+iMMJixfYJwbT3Lng7ApEZj3xHOHh8EAQ0X8ZLwhAqJy
 1ms4bkebar/X2EuBlfbx+7kDTugGDu6zItWG5wlFZFhd6OmglHtLm17xvHyBlKDnuqr21nM82
 4bde562OGGbG6IESfLWKKM0I28v4VGWzMWU1VsFrgt7DzH4IeZrll+EVFJAuPNVV8r2LD7jh6
 LMHR9jng6CBi1a3iH7BhRp56J9pYpeOx04D79x2Ujdq5SpXzwVmBXYuCNVV/1ePc3dClasbtu
 ZCd2MZimyULYMPwwlIlQGEnn1zO4SOpiE8lCUuGGYUqSr3t0qsQeDMC3vFYeCA8ZKLVdKuDZi
 5UjEl6YNPTL2HkEpkzYBld5mhko+rMdhPIMTpYmKrIuEBYV6yN3UvlEnV0l4dpPovDjQmEjjb
 Nm6d958elN4IEz3PIxTcW+m59S4eR9+7QTfpBw==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

parisc, uses a nonstandard variation of the generic sysvipc
data structures, intended to have the padding moved around
so it can deal with big-endian 32-bit user space that has
64-bit time_t.

Unlike most architectures, parisc actually succeeded in
defining this right for big-endian CPUs, but as everyone else
got it wrong, we just use the same hack everywhere.

This takes just take the same approach here that we have for
the asm-generic headers and adds separate 32-bit fields for the
upper halves of the timestamps, to let libc deal with the mess
in user space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/parisc/include/asm/compat.h      | 32 ++++++++++++++++----------------
 arch/parisc/include/uapi/asm/msgbuf.h | 33 ++++++++++++++++-----------------
 arch/parisc/include/uapi/asm/sembuf.h | 16 ++++++++--------
 arch/parisc/include/uapi/asm/shmbuf.h | 19 ++++++++-----------
 4 files changed, 48 insertions(+), 52 deletions(-)

diff --git a/arch/parisc/include/asm/compat.h b/arch/parisc/include/asm/compat.h
index 0cdfec8857bd..ab8a54771507 100644
--- a/arch/parisc/include/asm/compat.h
+++ b/arch/parisc/include/asm/compat.h
@@ -138,10 +138,10 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	unsigned int __unused1;
-	compat_time_t sem_otime;
-	unsigned int __unused2;
-	compat_time_t sem_ctime;
+	unsigned int sem_otime_high;
+	unsigned int sem_otime;
+	unsigned int sem_ctime_high;
+	unsigned int sem_ctime;
 	compat_ulong_t sem_nsems;
 	compat_ulong_t __unused3;
 	compat_ulong_t __unused4;
@@ -149,12 +149,12 @@ struct compat_semid64_ds {
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
-	unsigned int __unused1;
-	compat_time_t msg_stime;
-	unsigned int __unused2;
-	compat_time_t msg_rtime;
-	unsigned int __unused3;
-	compat_time_t msg_ctime;
+	unsigned int msg_stime_high;
+	unsigned int msg_stime;
+	unsigned int msg_rtime_high;
+	unsigned int msg_rtime;
+	unsigned int msg_ctime_high;
+	unsigned int msg_ctime;
 	compat_ulong_t msg_cbytes;
 	compat_ulong_t msg_qnum;
 	compat_ulong_t msg_qbytes;
@@ -166,12 +166,12 @@ struct compat_msqid64_ds {
 
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
-	unsigned int __unused1;
-	compat_time_t shm_atime;
-	unsigned int __unused2;
-	compat_time_t shm_dtime;
-	unsigned int __unused3;
-	compat_time_t shm_ctime;
+	unsigned int shm_atime_high;
+	unsigned int shm_atime;
+	unsigned int shm_dtime_high;
+	unsigned int shm_dtime;
+	unsigned int shm_ctime_high;
+	unsigned int shm_ctime;
 	unsigned int __unused4;
 	compat_size_t shm_segsz;
 	compat_pid_t shm_cpid;
diff --git a/arch/parisc/include/uapi/asm/msgbuf.h b/arch/parisc/include/uapi/asm/msgbuf.h
index b48b810e626b..6a2e9ab2ef8d 100644
--- a/arch/parisc/include/uapi/asm/msgbuf.h
+++ b/arch/parisc/include/uapi/asm/msgbuf.h
@@ -10,31 +10,30 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
-#if __BITS_PER_LONG != 64
-	unsigned int   __pad1;
-#endif
+#if __BITS_PER_LONG == 64
 	__kernel_time_t msg_stime;	/* last msgsnd time */
-#if __BITS_PER_LONG != 64
-	unsigned int   __pad2;
-#endif
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
-#if __BITS_PER_LONG != 64
-	unsigned int   __pad3;
-#endif
 	__kernel_time_t msg_ctime;	/* last change time */
-	unsigned long msg_cbytes;	/* current number of bytes on queue */
-	unsigned long msg_qnum;		/* number of messages in queue */
-	unsigned long msg_qbytes;	/* max number of bytes on queue */
-	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
-	__kernel_pid_t msg_lrpid;	/* last receive pid */
-	unsigned long __unused1;
-	unsigned long __unused2;
+#else
+	unsigned long	msg_stime_high;
+	unsigned long	msg_stime;	/* last msgsnd time */
+	unsigned long	msg_rtime_high;
+	unsigned long	msg_rtime;	/* last msgrcv time */
+	unsigned long	msg_ctime_high;
+	unsigned long	msg_ctime;	/* last change time */
+#endif
+	unsigned long	msg_cbytes;	/* current number of bytes on queue */
+	unsigned long	msg_qnum;	/* number of messages in queue */
+	unsigned long	msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t	msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t	msg_lrpid;	/* last receive pid */
+	unsigned long	__unused1;
+	unsigned long	__unused2;
 };
 
 #endif /* _PARISC_MSGBUF_H */
diff --git a/arch/parisc/include/uapi/asm/sembuf.h b/arch/parisc/include/uapi/asm/sembuf.h
index 746c5d86a9b1..3c31163b1241 100644
--- a/arch/parisc/include/uapi/asm/sembuf.h
+++ b/arch/parisc/include/uapi/asm/sembuf.h
@@ -10,21 +10,21 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-#if __BITS_PER_LONG != 64
-	unsigned int	__pad1;
-#endif
+#if __BITS_PER_LONG == 64
 	__kernel_time_t	sem_otime;		/* last semop time */
-#if __BITS_PER_LONG != 64
-	unsigned int	__pad2;
-#endif
 	__kernel_time_t	sem_ctime;		/* last change time */
-	unsigned long 	sem_nsems;		/* no. of semaphores in array */
+#else
+	unsigned long	sem_otime_high;
+	unsigned long	sem_otime;		/* last semop time */
+	unsigned long	sem_ctime_high;
+	unsigned long	sem_ctime;		/* last change time */
+#endif
+	unsigned long	sem_nsems;		/* no. of semaphores in array */
 	unsigned long	__unused1;
 	unsigned long	__unused2;
 };
diff --git a/arch/parisc/include/uapi/asm/shmbuf.h b/arch/parisc/include/uapi/asm/shmbuf.h
index cd4dbce55d0b..c89b3dd8db21 100644
--- a/arch/parisc/include/uapi/asm/shmbuf.h
+++ b/arch/parisc/include/uapi/asm/shmbuf.h
@@ -10,25 +10,22 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
  * - 2 miscellaneous 32-bit values
  */
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-#if __BITS_PER_LONG != 64
-	unsigned int		__pad1;
-#endif
+#if __BITS_PER_LONG == 64
 	__kernel_time_t		shm_atime;	/* last attach time */
-#if __BITS_PER_LONG != 64
-	unsigned int		__pad2;
-#endif
 	__kernel_time_t		shm_dtime;	/* last detach time */
-#if __BITS_PER_LONG != 64
-	unsigned int		__pad3;
-#endif
 	__kernel_time_t		shm_ctime;	/* last change time */
-#if __BITS_PER_LONG != 64
+#else
+	unsigned long		shm_atime_high;
+	unsigned long		shm_atime;	/* last attach time */
+	unsigned long		shm_dtime_high;
+	unsigned long		shm_dtime;	/* last detach time */
+	unsigned long		shm_ctime_high;
+	unsigned long		shm_ctime;	/* last change time */
 	unsigned int		__pad4;
 #endif
 	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
-- 
2.9.0

