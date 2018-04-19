Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3309672-1524149053-2-5580028224100737095
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES endaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524149053; b=K3D/4jdevsijyu+K65En2E0T17w9oMdLuKNTS6ZdmRNGt3vO7Q
    KtQgwmIiA4FCAjniqATCzRcy56HesJC1h3TrmCMTU0K1NuF7zJEK3iiUNTNAlT6G
    Etjf2nTg69MhYMu7UivB4k+SLxd29hlbHu/7SAUa/C+iWc22QR8ElA2VmvniEW0g
    lLj8y4Ny2cxJFSQZhZcaXEgl+JAkcROnrkCwDj18CRw1Wk7W6xPtjKDot1+Eukub
    +mWNMBLwOAjeBJQJweZvZA22Upt4ZqGAQ/Rl2y09TwLb4q5/i+3dHjTF/LludtGL
    78zLftZm0alk5eP4Jg9GVQ2chK2f1ejq9//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524149053; bh=
    Hfd0pB7ZzXtLEBOQ56xQ/8awEnsgMrTBactvzsB5oaI=; b=WYamqBTqQWFEkpma
    1ave1kLwHrFNJgC0gR8vtpRtxM8pzn2DJT6WDSK9sJ7zTTdYz16OblblgUirHA4L
    6R/TjNhe9CGHC2lZ56ZF8U3wm8/Yg1pEtgUaHRPIsAxp4OgmROnU3Sxcut7Bijdl
    xOZnvPDwSjf18E7RVuRrclOs8C0P6D4k06k2vlX868gfe3pe9gLfswviwsjBBu2o
    IvVk2dLK6Pu3mmlolJhL75m6pjeqGHoUm8VZkMyQvYHVZ3o2WXLUPDBnikX0mKTQ
    1gCahXXVnCR+WIjO5fo4s8shE0IjkrnfeVY7OuwBHlH1Mc1p4QV0xpDaOGZo/AWL
    LJwTNQ==
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
X-CM-Envelope: MS4wfL/vQ0rg13z8FQIsM3+4rTx6667ifAMdm6FdHI5U8mYvRJ7QdV41jt0S18VfixjUM1CmqQ6ghfFOcnvG41G2ceRzKs2qXwhmCXHueVZvbuLtLQyJ+4UF
    1CzXDtxDO+24dUC1ic8HT9/1Ygybz+tvKY3SY/pem/NxPZ93eI8vnXpzPsrP2/b3h9Dp2UlonDRVxeIdjy+VwN9TjS7Vp1rMMak99YF9cvtirkzpqUf6GibO
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=1Y418u4J_7SVKqeaot0A:9 a=lodVfSXsk3HTW-p3:21 a=R7ZINnc8kaS4Yk62:21
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbeDSOik (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 10:38:40 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:58611 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752780AbeDSOii (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 10:38:38 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        tglx@linutronix.de, deepa.kernel@gmail.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        albert.aribaud@3adev.fr, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, x86@kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-mips@linux-mips.org, jhogan@kernel.org,
        ralf@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: [PATCH v3 03/17] y2038: ia64: Remove unneeded ipc uapi header files
Date: Thu, 19 Apr 2018 16:37:23 +0200
Message-Id: <20180419143737.606138-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180419143737.606138-1-arnd@arndb.de>
References: <20180419143737.606138-1-arnd@arndb.de>
X-Provags-ID: V03:K1:togmoBqsxPzWYZRjoFWcVxWB8zwSf3VacbiJCfeT+d9Xss8JIqC
 m3aeZZa0gbY0vMTtvPR4rnllAegCZwvIUHmT9vMCfYDPM1zAYXzdWjQ3cNrgaNt7u8pb9Yn
 aaCdkCi5bFn9vquqUqWIrakTxl6upoal9CgusA39F6HVsC8PFtv42Pn1+lENE9+zhDg/XJ4
 94YNXC7q9hLFtHG0Nz18w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a8+4xEiDwvg=:qIGdbUviRp1TU+YUq9AKT+
 tc2Ne6l4NINpyVOjpERT/tgXHdXoOhP3+ywX1Q7LayHPe90nyKIfUKkL2wwgV2W9BOorwfWa6
 mh31AWD1s2zD29r6tD9gEJDPawrzuUseV6tWxh9eKs1R+m5nMugscwcX3YWVMMwwPPj++iIo3
 3XmjjRpWl6FNKsiaZBmD3D6I5Vh54jC0UgCono+nuSmtXw60A2zP9tCwCt3F7lyK4Q7319vlC
 jWbFqdLuMzRX5uJctQhrgn2wegDWlAw4Kb/sElqOjk57juFbLsg/6eqN2/aCCRmOGPSROFed8
 dyKrWjGFB168w64Pk7J9U74Lcabt9qPZGBhN/Gsr5wcuDjyRgWudhvzBsIGzgJG4KMAHAdzjR
 a4TCHPJEYEXtMYCZ0RYoeq/x6V5R7YnhcR9Lgm+ENdVFY3xExE8PDa76ALBMRWV+Gn6RyHibb
 0psdK9JkPoxuUWeZWrHIObifKxECZD8nTeCzTH+hhgkkE9VloTHYBdBLVRmw10hK4JpuV63bD
 NwwSJPAyMSVtw7z/EBFWqaEfqLsk6Ls/2NDQ2EXb0YR6EfNZV9G8jHXH5/Wwus4lHHeJKYSx1
 rZ6Lby13uB5IeAEasa8GakGgVok7mE/oSAAmmYk1iWeB26xB6XXSLtvcu5M5hhgsejwvSPO/i
 prwZ7t9GzBtvrsOPZalLGe2DSaEKFeA76AoCh0TfmmHi4PtrjNhnYyQR+7V32bRvaQrBTQUbh
 Vt7ZfZtu0FhKOVmFzQ+XbRevvfH4he2yVPW7qQ==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The ia64 ipcbuf/msgbuf/sembuf/shmbuf header files are all identical
to the version from asm-generic.

This patch removes the files and replaces them with 'generic-y'
statements as part of the y2038 changes. While ia64 no longer has
a compat mode and doesn't need the file any more, it seem nicer
to clean this up anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/include/uapi/asm/Kbuild   |  4 ++++
 arch/ia64/include/uapi/asm/ipcbuf.h |  2 --
 arch/ia64/include/uapi/asm/msgbuf.h | 28 --------------------------
 arch/ia64/include/uapi/asm/sembuf.h | 23 ----------------------
 arch/ia64/include/uapi/asm/shmbuf.h | 39 -------------------------------------
 5 files changed, 4 insertions(+), 92 deletions(-)
 delete mode 100644 arch/ia64/include/uapi/asm/ipcbuf.h
 delete mode 100644 arch/ia64/include/uapi/asm/msgbuf.h
 delete mode 100644 arch/ia64/include/uapi/asm/sembuf.h
 delete mode 100644 arch/ia64/include/uapi/asm/shmbuf.h

diff --git a/arch/ia64/include/uapi/asm/Kbuild b/arch/ia64/include/uapi/asm/Kbuild
index c0527cfc48f0..3982e673e967 100644
--- a/arch/ia64/include/uapi/asm/Kbuild
+++ b/arch/ia64/include/uapi/asm/Kbuild
@@ -2,5 +2,9 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
+generic-y += ipcbuf.h
 generic-y += kvm_para.h
+generic-y += msgbuf.h
 generic-y += poll.h
+generic-y += sembuf.h
+generic-y += shmbuf.h
diff --git a/arch/ia64/include/uapi/asm/ipcbuf.h b/arch/ia64/include/uapi/asm/ipcbuf.h
deleted file mode 100644
index 90d6445a14df..000000000000
--- a/arch/ia64/include/uapi/asm/ipcbuf.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/ipcbuf.h>
diff --git a/arch/ia64/include/uapi/asm/msgbuf.h b/arch/ia64/include/uapi/asm/msgbuf.h
deleted file mode 100644
index aa25df92d9dc..000000000000
--- a/arch/ia64/include/uapi/asm/msgbuf.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_IA64_MSGBUF_H
-#define _ASM_IA64_MSGBUF_H
-
-/*
- * The msqid64_ds structure for IA-64 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 2 miscellaneous 64-bit values
- */
-
-struct msqid64_ds {
-	struct ipc64_perm msg_perm;
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-	__kernel_time_t msg_ctime;	/* last change time */
-	unsigned long  msg_cbytes;	/* current number of bytes on queue */
-	unsigned long  msg_qnum;	/* number of messages in queue */
-	unsigned long  msg_qbytes;	/* max number of bytes on queue */
-	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
-	__kernel_pid_t msg_lrpid;	/* last receive pid */
-	unsigned long  __unused1;
-	unsigned long  __unused2;
-};
-
-#endif /* _ASM_IA64_MSGBUF_H */
diff --git a/arch/ia64/include/uapi/asm/sembuf.h b/arch/ia64/include/uapi/asm/sembuf.h
deleted file mode 100644
index 6ed058760afc..000000000000
--- a/arch/ia64/include/uapi/asm/sembuf.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_IA64_SEMBUF_H
-#define _ASM_IA64_SEMBUF_H
-
-/*
- * The semid64_ds structure for IA-64 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 2 miscellaneous 64-bit values
- */
-
-struct semid64_ds {
-	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-	__kernel_time_t	sem_otime;		/* last semop time */
-	__kernel_time_t	sem_ctime;		/* last change time */
-	unsigned long	sem_nsems;		/* no. of semaphores in array */
-	unsigned long	__unused1;
-	unsigned long	__unused2;
-};
-
-#endif /* _ASM_IA64_SEMBUF_H */
diff --git a/arch/ia64/include/uapi/asm/shmbuf.h b/arch/ia64/include/uapi/asm/shmbuf.h
deleted file mode 100644
index 6ef57cb70dee..000000000000
--- a/arch/ia64/include/uapi/asm/shmbuf.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_IA64_SHMBUF_H
-#define _ASM_IA64_SHMBUF_H
-
-/*
- * The shmid64_ds structure for IA-64 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 2 miscellaneous 64-bit values
- */
-
-struct shmid64_ds {
-	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_time_t		shm_atime;	/* last attach time */
-	__kernel_time_t		shm_dtime;	/* last detach time */
-	__kernel_time_t		shm_ctime;	/* last change time */
-	__kernel_pid_t		shm_cpid;	/* pid of creator */
-	__kernel_pid_t		shm_lpid;	/* pid of last operator */
-	unsigned long		shm_nattch;	/* no. of current attaches */
-	unsigned long		__unused1;
-	unsigned long		__unused2;
-};
-
-struct shminfo64 {
-	unsigned long	shmmax;
-	unsigned long	shmmin;
-	unsigned long	shmmni;
-	unsigned long	shmseg;
-	unsigned long	shmall;
-	unsigned long	__unused1;
-	unsigned long	__unused2;
-	unsigned long	__unused3;
-	unsigned long	__unused4;
-};
-
-#endif /* _ASM_IA64_SHMBUF_H */
-- 
2.9.0

