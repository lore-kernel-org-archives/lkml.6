Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-900250-1524669234-2-15110655379802090272
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
    1524669233; b=bhneQOs6I6sSHbUp5Hev+YVXH2JfDByu9upThEdZ+38u93XCSd
    3kdr2BZzT89zECKkpi1LDUq/T4ju2KDq0aiQdpMTfFyMC+r6rNmB2ZZiJu2+psoU
    125afm5FVONKwtJJIYxjfdJot/4Z4nfWck9ujRZxYGBK3MvbRVYg85o9EXacj9Lr
    5Jf4+LQP8KZHoIXLHriZKc1A6yOnhIbjGy5qF9e9AqWbpns2etmFw4iQnx6GGl+i
    3M8YmGb7ZQLOiIj3xHli9q+gaI27x36zkbk369xxdwD7U6k1cuwPlmvjp0PQEFeV
    +Xy4evvH+rcaPd5IWB0ypzUEjru2iivZVQpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524669233; bh=
    Hfd0pB7ZzXtLEBOQ56xQ/8awEnsgMrTBactvzsB5oaI=; b=JduFa+Jp9C9rJw1g
    N/BkCnXWLCYbbX2R1BUyW+VP1S+NCsMKlEo1Syw8Do8zDzQKGf7rovqvLFALxvYa
    QzzzVeNrtjthZ3D66XUuwurXXJ2HjYvJrFlVYzw78CPJsXaOuFco2cAccgc4vssa
    2SlEe6p7SRDbAJHepyB9CZ7r9E41hTOoLYdiOqA/nHTGNZcpdOg9dQWw0c6fx2o+
    5IggLLXmx0zVZ43RbJqItsl908f6DSbStAJGBQWu1q0vaWklBXMYGV7vuvQg4hu6
    zIuHl4i6SMZNPUJDztH0tv3ySMt0aj9CxETFfzhhUZMMg+hcR4TLambekF0rGelW
    aOTFrA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLbpxA7dGqLVWH/E9hjrve5D45SvJZowkOXhnBWiWQypVUOZguYHcL/aFLZIoic2IDnBdyAxQTZ3Ml2XZ3956ThQu75imBU1KW7MbBru/6aIXX7uadrU
    xqM+LkGtVVWgdfVcIvySTNN/dzpskYTx/Tp7jOReQabqucNJQhVhgAy5Y7UuoP9tNOOZXhDYiYBFAvU277nv6ZeRhKpu2Acj3AEJUH3QkYJa3GSPFL2k5NlX
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=1Y418u4J_7SVKqeaot0A:9 a=lodVfSXsk3HTW-p3:21 a=R7ZINnc8kaS4Yk62:21
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754819AbeDYPHK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 11:07:10 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:56367 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754604AbeDYPHE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 11:07:04 -0400
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
Subject: [PATCH v4 04/16] y2038: ia64: Remove unneeded ipc uapi header files
Date: Wed, 25 Apr 2018 17:05:54 +0200
Message-Id: <20180425150606.954771-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:58aLalUXCtdMgJB9sVefF/qQMXwqIt+G1S7tyRiUU5FbqjK9WSM
 N9R2g/EQcPQEv+9GknPg8XQdl8AVhXtXWc8mVGf6/GnpehE11XZo9Pd+NBrGiFaVoNdKMva
 vnMHVF0ejBiPB5BJ0zZMlbQ2BQmkLrRnbsFapigicS5BdKAdTGoeCJdBABBpQYHUI091mxa
 p9y2ck6ve5mvhQWnWsOnQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gOYDwd2xF60=:gjY9A6jssiIyyuw+so2j8V
 Q/FitRuA8VmpdOTPsY8DZ894kMLgAH4xmWttQjiQpNYby57572aItGalFq3vMEbEvPrVqKhNO
 bg0lShFJ1+9Ux1tI5/oDAdIGEVs5Daf0haHinRFwUqZzG1PpMgx2naF3Us8OM1NBkXKm9lTbP
 airOmpaoip6KBcWMFqS+joj05LJqg4p3vW2QOyTPzc0lsJYk+TlmhzrdTDijnedl8VrU7krRT
 niDnyZsRVN2ZBm0WpNZi9r6J8VCqA2yfT14jAg45ADowCgvj26g2VypnTOFQx1Do23o3jRcpK
 0Vc8QwLkMdGTxZMq9Cw4hkJABDYXOTmgzpLRmyxU/RTAHQJgm0tQAR4m4KPtgk4p1S3Blanoo
 0VDkZIbFUr7FutskrSxaGcDh7/Ail1TW6q653OmmYBiujme9zGFHbei/WwRQM2v+dcDwGx2IL
 dSPxJXWnvGGUY+jxFHj3XVsGx6laU4SkM+5AlqiMbKUoYZN0bawI7Jxr3sq+Et1vzR0Y+HSrz
 k8traXW9g0Wu08B8SgTmKB6jxaClnJQGIagIujosbOBdh4MOLoIujW9f+Pc2COBUCbMY8UHnq
 Hr4VBbeAyA12j2/jb0OOOp7PCw/eFa+FFOMUo3LISjFbC3qUdGI6Qw6mYGMmimdQzWkF1ChJ2
 XaB5qLcdhZvNU1T5irBxOh8+FCpt9/gMKvZSgpDADNyQdjwIhhZXCsM2mTF+61grK2RIpdHub
 zwwvICycUqSDCwtW5T2pWkKnoF5weFTC4BtpdDlTs2bft7fePjoE5hkV2crzZr7g3QfbJIByZ
 qndh6h+fxnT0Xj0nbWxbvGj4E3LEz2tuqdnDZDzRNqN2B4Qu9jfarQDSYjxKrFtpA+NRIhMhe
 q+aaPJeNc7CXKwWTrgSILn3m5QcrVVtPE/U4V9aUOd6GP7gmbZLgl0Lml9gvbr
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

