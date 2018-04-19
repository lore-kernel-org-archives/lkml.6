Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3309672-1524148832-2-17221898894645889450
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
    1524148831; b=ldMpBAlsJpZCnqGLyNhUx3L2GdYjF3giyHqFXz6rlf/qzCoRvg
    ngotxN2K+B7a8zBeUS9GuPJIQKbYxxL/Ge1c0lDqzW6vHG7wYiZrg4FmZAUPgFo2
    C8XjgzOeQk2R234VFl2HojkNZSPw/QKDX9pYiH29/CnLt4p9Y4P1/DxAfMLZXMrd
    YXkJn7cM7ZqQ0s4OskxjINB0eWF0pvFHhv3bz7A/VVOgCh40Hwp9RD1qFPK9nOVe
    le3ReGiMz2qUoK5TNVBvBc3mf+Ddbz2UEQwA4N7RbrrCPSEoy6HNH/y3Z8ZnPSfW
    57Zb4JrD390N2IeyWeSmfxBCtMMQfYUxLm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524148831; bh=
    RPAou+pZRL3JDOy/LgOAfscZL25+nx2x/tUbkRVPEFM=; b=J+oVexlAFSGAdusy
    8PLJn2xuFSWQSLbIW5uLAXsD63S2ojXEXIpRIH1om3Kh3FcEEY2rwJoC3b5wOawA
    aLMSeQle4dimPzHjovSZGD7UJhOdUl19YXYqFdtMcSczO0AG8IRUpjJm372hJPwD
    8e6B+ERTZzUfdv7aoddNhQ09WHCt2SdqxHJUX8WYe8ul7m0guFostk1wIo61m3ea
    4UyZNSG3o6zcrtNleGuJPCVbE7wkRS5eKLBhF/0suZfCtxMHA5kDcBl1ixTaWIQR
    3QkyeRvK0f7131SeTSW8Vl3IPBnwk2snOWTNEeDNYUzWzi5clDijWLL0+hbSLtq1
    uziW6g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfJjhf4qel/qLjuJCyeemXN9lGW0qDhHFqymv2XIZQA1uVnf+tVaSkALYoQrk5Lv3/ANT5nXC6QnizGE65fltIvmrg9sBK16wdjtgXdnhHwcTSrKgVG3W
    p9dUFbBxh1E1wa8xJQbbMOZaXFA3qMMUHEaet+wLnLI56/iCHyseHPhtKgigCGIX6CoxrXcAenBg53hDBYtMWn00rcdyjEhn+vsnG3TRC55vzl9ekBCRs3TW
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=XDPUjLVUeFrZggzrMEMA:9 a=8vlkM-slKRsSqWcT:21 a=J8TjxFBZp2hdAeYA:21
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752838AbeDSOjN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 10:39:13 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:60509 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbeDSOjK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 10:39:10 -0400
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
Subject: [PATCH v3 02/17] y2038: alpha: Remove unneeded ipc uapi header files
Date: Thu, 19 Apr 2018 16:37:22 +0200
Message-Id: <20180419143737.606138-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180419143737.606138-1-arnd@arndb.de>
References: <20180419143737.606138-1-arnd@arndb.de>
X-Provags-ID: V03:K1:GJvU2GYz6J3khxgI87odc47RVbI/DmH/l0oNg9ieS6Rp+Cej7kA
 Ry/0g+wcPyG7UdO8NfYEWbFqg4CvwW9e3fFG6zdxPyuIEEvv4SZ+paliYATGwdRE8RJi3NN
 rqkDlFgFkTX8IqD3gRldLs8PHDXzTgkWVKmfocXsXoh2A4ElPmFDGLuo79tN0wBnXNhb6ah
 mvp7WWScQ0BSt7x5v8wig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sordSBH9nY0=:pAyb50zZ4YGhv+LBLSR5qz
 ttBE6I24AJl200y4dZMydeLJ8XU/UTytrzyGQ7MMWNjXert6SxeiQUfJfKDn9kr1knys+v1AR
 Zrbes7eqMcJGgBO8418CuMUbcMyAxp8ZZoq0PQRG+dQHSbYz0FYBA+Ey4r/qtZyMvzbt15rdM
 3OngiFiSZAK9CawWxmzx0AUTM0ED7myyOGRckVi5yD0SVm402JvvoeQq2zWGzumlhQuMGdA6m
 E5mYoWc2Yju3KPVKaIwHwFfMmlGP2aa0hZgFLeh6AZUf6QTHVCiW5g3m898IxwRmw8upWM0am
 F7MLXYK0uniNyaYPXtVwsagJH+GdWMSjLYvmnrBp/6vmPgNc+muwYRH35jDWki5KeqKXepVA1
 zqPrqNjXvmpsZaBDLgS2UfDsGvf6dEO97lEx6ue3J0ddcHB04GqKh0mTTNAmzv4lfJx15bWxH
 74JugZxX4I2P662oqLy3BlBTzqkDjsqx9ZILIJleRHhpn1AT7HtZhe4yGkziIzt3hiswyQrkU
 9f05kB6nz7zxPdVg4jZd3gTfua6gQPNBed4ihRzLYS2kTV4t/hIqOeHUSm9mTddIromj9E3vj
 Or6rSFi7eQ5zSspZjtcU6vMF+knzyn7Kwtu7r2RVmYjUPGKZ7AGD1MvoLPqM4bBoDCsUYHfOF
 cviK+T9gJoBHCGIb2y2oHnVz2rFw5Y97NySms2117EMa+7rZuyFjz8ouKiSO03xacqJyBxVRX
 ukVrNBJqMF3UlOiittRapfSYig0o3KhRCIKPjA==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The alpha ipcbuf/msgbuf/sembuf/shmbuf header files are all identical
to the version from asm-generic.

This patch removes the files and replaces them with 'generic-y'
statements as part of the y2038 series. Since there is no 32-bit
syscall support for alpha, we don't need the other changes, but
it's good to have clean this up anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/uapi/asm/Kbuild   |  4 ++++
 arch/alpha/include/uapi/asm/ipcbuf.h |  2 --
 arch/alpha/include/uapi/asm/msgbuf.h | 28 --------------------------
 arch/alpha/include/uapi/asm/sembuf.h | 23 ---------------------
 arch/alpha/include/uapi/asm/shmbuf.h | 39 ------------------------------------
 5 files changed, 4 insertions(+), 92 deletions(-)
 delete mode 100644 arch/alpha/include/uapi/asm/ipcbuf.h
 delete mode 100644 arch/alpha/include/uapi/asm/msgbuf.h
 delete mode 100644 arch/alpha/include/uapi/asm/sembuf.h
 delete mode 100644 arch/alpha/include/uapi/asm/shmbuf.h

diff --git a/arch/alpha/include/uapi/asm/Kbuild b/arch/alpha/include/uapi/asm/Kbuild
index 9afaba5e5503..1a5b75310cf4 100644
--- a/arch/alpha/include/uapi/asm/Kbuild
+++ b/arch/alpha/include/uapi/asm/Kbuild
@@ -2,4 +2,8 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
+generic-y += ipcbuf.h
+generic-y += msgbuf.h
 generic-y += poll.h
+generic-y += sembuf.h
+generic-y += shmbuf.h
diff --git a/arch/alpha/include/uapi/asm/ipcbuf.h b/arch/alpha/include/uapi/asm/ipcbuf.h
deleted file mode 100644
index 90d6445a14df..000000000000
--- a/arch/alpha/include/uapi/asm/ipcbuf.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/ipcbuf.h>
diff --git a/arch/alpha/include/uapi/asm/msgbuf.h b/arch/alpha/include/uapi/asm/msgbuf.h
deleted file mode 100644
index 8c5d4d8c1b16..000000000000
--- a/arch/alpha/include/uapi/asm/msgbuf.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ALPHA_MSGBUF_H
-#define _ALPHA_MSGBUF_H
-
-/* 
- * The msqid64_ds structure for alpha architecture.
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
-#endif /* _ALPHA_MSGBUF_H */
diff --git a/arch/alpha/include/uapi/asm/sembuf.h b/arch/alpha/include/uapi/asm/sembuf.h
deleted file mode 100644
index f28ffa668b2f..000000000000
--- a/arch/alpha/include/uapi/asm/sembuf.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ALPHA_SEMBUF_H
-#define _ALPHA_SEMBUF_H
-
-/* 
- * The semid64_ds structure for alpha architecture.
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
-#endif /* _ALPHA_SEMBUF_H */
diff --git a/arch/alpha/include/uapi/asm/shmbuf.h b/arch/alpha/include/uapi/asm/shmbuf.h
deleted file mode 100644
index 7e041ca2eb40..000000000000
--- a/arch/alpha/include/uapi/asm/shmbuf.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ALPHA_SHMBUF_H
-#define _ALPHA_SHMBUF_H
-
-/* 
- * The shmid64_ds structure for alpha architecture.
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
-#endif /* _ALPHA_SHMBUF_H */
-- 
2.9.0

