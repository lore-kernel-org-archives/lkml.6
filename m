Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3352333-1524149077-2-2722321366874136524
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DCC_CHECK 1.1, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524149075; b=j8Wva3uLxhAm88TjCi9GgNE1sAXocxSkNnMYTmsrtIPGnjrW9L
    PriBvoyQ36IeEe9NRcGnxChnIMe18+SzADOO14LGNqetgHMkFAxQm0azXKFPrwdT
    H7G7mqEp3VgTeI78Ds3c1i54Q72YCrhIvchOfoqVfP7yFY8D1eqHTsK4xc05g9Ww
    +8JWKABmXIgRkRAW6B4pQC7AjHfoYjRGOsktiN4xFD2u6hynE2qwbOrzdrKZdKMp
    etKsbvhQrr4Fd3U9IYxuhUtGMcwFmzW4hOCxQaINK13Pchehdyk/lGc7YbdIUV/z
    24Z2EdHs0b6QvA/Tx1btgY7CT+fUtQVhh/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524149075; bh=
    Su/MrxE+4ECgNrJlTPECVBnLcGuU3OzIThuPodLZdSA=; b=nRE13//jJh8OUpg+
    xjC+v9HDTsMcKBW78lZ6qvAJk0F/kyVSr9CG8KNRigaUIAmthJKRVndipm5Zt3/c
    wLyXYQJ4Uxx9vNh2KrracQI/kAauPxYjQJpiYttxSEPFUwE8P9R/wyMzlq9VQszi
    OuhB8y3DWBOl4LeNxinZjhKjWmRMmZDqRj4QRhtKoVI6bf+0pdgyIkRsWq7UYDmP
    wpGeRZFKJ/obC+jkw4RvSHcCYjvP/HU7OmNS2SZfbbtgJUxkCBhLTAqhKOLyWxdI
    dUrl3bNy2CfsFH56gXPphpjMM/80U8fxEiFEPxzpUThiDZqXzA1DxSF05bJZyby6
    DuxSzQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfCHbnZvkIxKdwwkihL+ZjzDTUjZzLOe7QgSJa5ymdlmY0GCwTh4fEu76CUYvrcmFw49b9ta1B8vHaJ2lN+25rS/dFlrzNINbtybUUy2gvwotTtWza4j5
    IhXRHTqbg+Ud88kNQEiTJ+GC1Tigu3FH4oCi6lY18GjM/7C1WTUrYpkjjC2JJeF9tEf4Cho+yrHwbIV4VTeq6y5FTLnZBZeLp2TjTW0JbfQKE7pJfgKM+UDw
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=ndcGF5aaS97bXtANCUoA:9 a=5H-_3iZhzYS8U9oN:21 a=nJmb99yM-QQndeiP:21
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbeDSOoc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 10:44:32 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:57395 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752255AbeDSOi3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 10:38:29 -0400
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
Subject: [PATCH v3 04/17] y2038: s390: Remove unneeded ipc uapi header files
Date: Thu, 19 Apr 2018 16:37:24 +0200
Message-Id: <20180419143737.606138-5-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180419143737.606138-1-arnd@arndb.de>
References: <20180419143737.606138-1-arnd@arndb.de>
X-Provags-ID: V03:K1:gAFodFrE669l798gMw1l1+4ZzPohNc/YiRhd2A04AT20er4li9F
 dzBx/a45P3LxMsDSu+TGGi2U05BOnmalX7Qb3WcOryG+VM+oEhzxrkdm+nXTUFm5iu0S0b1
 X1d2dwVqSMsRudtF0qdkkhcXCV7FNnFfLL0/RJVvS3CkIa2uqpPNUFicq+P6/oStg3V4+ei
 7jCa8tXLvrV2xwC8yoU+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J32XI7yflj0=:bTG6RbenhvfmIM5bDstiIO
 SavGxK8VJrirMariKnvfOH9wYz51SN5yWSmS0DfAge73SpM3FWVI6WMzJm4+DuOcTjC3K5ewM
 73ledxuDYyARuM6mkhtcXr7adDu0px+u29DAKYoS3EvoIFwy6O/n3eF0YZJDT48fKW1f+PO+E
 JUE6nQzCthahIWL4QjWiI6lCYTx6TCir5sm2cZ4TMNmLTIP5V2XLh3FePDR4WhF30UcSwVgoO
 6GrKKwLIIjEoFdL0nuDNlgJ//4wTpp9MC6n5mH7XDGRNRdFzLCDyERBY1NGwfCe7YDEm2D1HN
 ht4yDYwbvDGscdFh9i9AJJ7klGlh4CSmyCi7DIEQiiT+4l69mQgyXW61BDttj/fnBk6JzMSSN
 D2sQFMOu2/0IKUli0HgT8XAHSWSfAjtWIS450fov6W+yCttNC2lKMP/B/bgAsCuHcZ6UuM/g5
 YeWtcHQFp7n4zsbo44fzZwI2tP4jBp+LUfRSkEzAXvyaHnXo9e0ENchvpFMXHlH96gMF2pT0i
 jd9h9rOnDcifKCZSG1SrVAMPg0V2L+obY36zaiZq+Kj7GhkKYr9DaiB1EFrwq6li1yEemdIsh
 GWbRRtZ8deRjCVrPfe2PbrUzsTRoZ4GNitcFpfJz10wlkkpzPNNYPSVvXJpWKImC4aVWBGuud
 P1vW1uPQ+Jirgqa3I1DrAR0T8AzsQU0ubjKsKqCq8jSfCyZQOoI1bsJjm8asJRJ75vvh8oK27
 rNlYuzlvdAPTO/iE2NLZcFpDG2WV6sWSQWj/AQ==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The s390 msgbuf/sembuf/shmbuf header files are all identical to the
version from asm-generic.

This patch removes the files and replaces them with 'generic-y'
statements, to avoid having to modify each copy when we extend sysvipc
to deal with 64-bit time_t in 32-bit user space.

Note that unlike alpha and ia64, the ipcbuf.h header file is slightly
different here, so I'm leaving the private copy.

To deal with 32-bit compat tasks, we also have to adapt the definitions
of compat_{shm,sem,msg}id_ds to match the changes to the respective
asm-generic files.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/include/asm/compat.h      | 32 ++++++++++++------------
 arch/s390/include/uapi/asm/Kbuild   |  3 +++
 arch/s390/include/uapi/asm/msgbuf.h | 38 ----------------------------
 arch/s390/include/uapi/asm/sembuf.h | 30 -----------------------
 arch/s390/include/uapi/asm/shmbuf.h | 49 -------------------------------------
 5 files changed, 19 insertions(+), 133 deletions(-)
 delete mode 100644 arch/s390/include/uapi/asm/msgbuf.h
 delete mode 100644 arch/s390/include/uapi/asm/sembuf.h
 delete mode 100644 arch/s390/include/uapi/asm/shmbuf.h

diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index 501aaff85304..97db2fba546a 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -232,10 +232,10 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	compat_time_t  sem_otime;
-	compat_ulong_t __pad1;
-	compat_time_t  sem_ctime;
-	compat_ulong_t __pad2;
+	compat_ulong_t sem_otime;
+	compat_ulong_t sem_otime_high;
+	compat_ulong_t sem_ctime;
+	compat_ulong_t sem_ctime_high;
 	compat_ulong_t sem_nsems;
 	compat_ulong_t __unused1;
 	compat_ulong_t __unused2;
@@ -243,12 +243,12 @@ struct compat_semid64_ds {
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
-	compat_time_t   msg_stime;
-	compat_ulong_t __pad1;
-	compat_time_t   msg_rtime;
-	compat_ulong_t __pad2;
-	compat_time_t   msg_ctime;
-	compat_ulong_t __pad3;
+	compat_ulong_t msg_stime;
+	compat_ulong_t msg_stime_high;
+	compat_ulong_t msg_rtime;
+	compat_ulong_t msg_rtime_high;
+	compat_ulong_t msg_ctime;
+	compat_ulong_t msg_ctime_high;
 	compat_ulong_t msg_cbytes;
 	compat_ulong_t msg_qnum;
 	compat_ulong_t msg_qbytes;
@@ -261,12 +261,12 @@ struct compat_msqid64_ds {
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
 	compat_size_t  shm_segsz;
-	compat_time_t  shm_atime;
-	compat_ulong_t __pad1;
-	compat_time_t  shm_dtime;
-	compat_ulong_t __pad2;
-	compat_time_t  shm_ctime;
-	compat_ulong_t __pad3;
+	compat_ulong_t shm_atime;
+	compat_ulong_t shm_atime_high;
+	compat_ulong_t shm_dtime;
+	compat_ulong_t shm_dtime_high;
+	compat_ulong_t shm_ctime;
+	compat_ulong_t shm_ctime_high;
 	compat_pid_t   shm_cpid;
 	compat_pid_t   shm_lpid;
 	compat_ulong_t shm_nattch;
diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm/Kbuild
index faef3f7e8353..e364873e0d10 100644
--- a/arch/s390/include/uapi/asm/Kbuild
+++ b/arch/s390/include/uapi/asm/Kbuild
@@ -9,9 +9,12 @@ generic-y += errno.h
 generic-y += fcntl.h
 generic-y += ioctl.h
 generic-y += mman.h
+generic-y += msgbuf.h
 generic-y += param.h
 generic-y += poll.h
 generic-y += resource.h
+generic-y += sembuf.h
+generic-y += shmbuf.h
 generic-y += sockios.h
 generic-y += swab.h
 generic-y += termbits.h
diff --git a/arch/s390/include/uapi/asm/msgbuf.h b/arch/s390/include/uapi/asm/msgbuf.h
deleted file mode 100644
index 604f847cd68c..000000000000
--- a/arch/s390/include/uapi/asm/msgbuf.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _S390_MSGBUF_H
-#define _S390_MSGBUF_H
-
-/* 
- * The msqid64_ds structure for S/390 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
- * - 2 miscellaneous 32-bit values
- */
-
-struct msqid64_ds {
-	struct ipc64_perm msg_perm;
-	__kernel_time_t msg_stime;	/* last msgsnd time */
-#ifndef __s390x__
-	unsigned long	__unused1;
-#endif /* ! __s390x__ */
-	__kernel_time_t msg_rtime;	/* last msgrcv time */
-#ifndef __s390x__
-	unsigned long	__unused2;
-#endif /* ! __s390x__ */
-	__kernel_time_t msg_ctime;	/* last change time */
-#ifndef __s390x__
-	unsigned long	__unused3;
-#endif /* ! __s390x__ */
-	unsigned long  msg_cbytes;	/* current number of bytes on queue */
-	unsigned long  msg_qnum;	/* number of messages in queue */
-	unsigned long  msg_qbytes;	/* max number of bytes on queue */
-	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
-	__kernel_pid_t msg_lrpid;	/* last receive pid */
-	unsigned long  __unused4;
-	unsigned long  __unused5;
-};
-
-#endif /* _S390_MSGBUF_H */
diff --git a/arch/s390/include/uapi/asm/sembuf.h b/arch/s390/include/uapi/asm/sembuf.h
deleted file mode 100644
index 3e917697b668..000000000000
--- a/arch/s390/include/uapi/asm/sembuf.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _S390_SEMBUF_H
-#define _S390_SEMBUF_H
-
-/* 
- * The semid64_ds structure for S/390 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem (for !__s390x__)
- * - 2 miscellaneous 32-bit values
- */
-
-struct semid64_ds {
-	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-	__kernel_time_t	sem_otime;		/* last semop time */
-#ifndef __s390x__
-	unsigned long	__unused1;
-#endif /* ! __s390x__ */
-	__kernel_time_t	sem_ctime;		/* last change time */
-#ifndef __s390x__
-	unsigned long	__unused2;
-#endif /* ! __s390x__ */
-	unsigned long	sem_nsems;		/* no. of semaphores in array */
-	unsigned long	__unused3;
-	unsigned long	__unused4;
-};
-
-#endif /* _S390_SEMBUF_H */
diff --git a/arch/s390/include/uapi/asm/shmbuf.h b/arch/s390/include/uapi/asm/shmbuf.h
deleted file mode 100644
index 9cdce8d7ce60..000000000000
--- a/arch/s390/include/uapi/asm/shmbuf.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _S390_SHMBUF_H
-#define _S390_SHMBUF_H
-
-/* 
- * The shmid64_ds structure for S/390 architecture.
- * Note extra padding because this structure is passed back and forth
- * between kernel and user space.
- *
- * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem (for !__s390x__)
- * - 2 miscellaneous 32-bit values
- */
-
-struct shmid64_ds {
-	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
-	__kernel_time_t		shm_atime;	/* last attach time */
-#ifndef __s390x__
-	unsigned long		__unused1;
-#endif /* ! __s390x__ */
-	__kernel_time_t		shm_dtime;	/* last detach time */
-#ifndef __s390x__
-	unsigned long		__unused2;
-#endif /* ! __s390x__ */
-	__kernel_time_t		shm_ctime;	/* last change time */
-#ifndef __s390x__
-	unsigned long		__unused3;
-#endif /* ! __s390x__ */
-	__kernel_pid_t		shm_cpid;	/* pid of creator */
-	__kernel_pid_t		shm_lpid;	/* pid of last operator */
-	unsigned long		shm_nattch;	/* no. of current attaches */
-	unsigned long		__unused4;
-	unsigned long		__unused5;
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
-#endif /* _S390_SHMBUF_H */
-- 
2.9.0

