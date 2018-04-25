Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-889516-1524668924-2-544465664898247685
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524668922; b=htv1gSzDyNeBy0+/myfv5RIRTbirdkKvKeCMCN+CssOSl/SBFe
    kcPl7cd6KS2rwW08AbkntF1cDOflk9D2DUphR7g3Vj7UyBkKz9i/dWb0MYU89Q0b
    sPbfRhY4gIF2LZLS7Qg4u3JzNjjIP0aZXuHgkTHa+eUGM5m0/zrR7ULisFGdol3u
    8RqpA7M979oa4GQL5BV2AJd1xD3ktwDzVzqnROAE5i0n9CGsDZ7P5G0uFfXb+yP6
    Tg6V44WbNpC78kiRFKATS19wIEeW5EeStFL3MjAEPHTaPNL7+8uksS5YRTUuiXIy
    r+AYKVB+Dq7s6sHEsbEByVfHZS7opy9k9O6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524668922; bh=
    udcnS219HEp5wjcqhG0vK5NTLA0eDU3MIJpQXYLHPDM=; b=ZjySiwOgzeC/hIlS
    uvBtxAdxtFJMImSF6D/GhkFHUs51kq5pQevX/N5WvZhIr8p58ceGInYOnFBxk/OK
    QNTlDSfBAz3q8fcbqS+N4SQrKqI7INR/nb0+riQLdRRvrjuEodDqCVfefDFS3jRz
    renlNIvO3RXfx9ZoUS+OzyU577qJ022mRsWIkFa3cdxyGreQPSsTlpEVMutMJvzE
    9QNScSpf6XFxniXPADgSs9Uk+mYVDGE2pROeQeXwKdso3yBbTO+jdK+4YiacVQ/e
    xHhmFotDTt70KLKCUlUw5HdZGr9dghAcRTlAx+fksdSPnbZsecz0Ebi8eZlLR2uY
    ngDDsg==
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
X-CM-Envelope: MS4wfLehBNvabNMfd3l8bI1Bd7GW0007oo9Jna/HeRC6pNZSMBzpG5TexPc5eGICHKAYKi8rQhThG4uPlq8467ACE+3anf4u6TjqgYWImQL3eBLcyqz7Av4e
    qgVgeb4j1q8UuK+eo1zIcROHIQG8a32V5iEY/sUVLph6QXsXWI8jKKf7K5w7pzVgmTrpNFqJgoAp0w+ZZgUSnndW9yFk8Lp/aUtFQTDfK5iuiDOHVKVB9RGQ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VnNF1IyMAAAA:8
    a=VwQbUJbxAAAA:8 a=ndcGF5aaS97bXtANCUoA:9 a=ahKESPsKcH8xrhKw:21
    a=WNYhXgY2FmAB_EhS:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754917AbeDYPHY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 11:07:24 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:57261 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754889AbeDYPHV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 11:07:21 -0400
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
Subject: [PATCH v4 05/16] y2038: s390: Remove unneeded ipc uapi header files
Date: Wed, 25 Apr 2018 17:05:55 +0200
Message-Id: <20180425150606.954771-5-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:CbZ/SvN+g6Gd2QKi56UPeGr9vFRU83X9kKAjsgi53KWnI72+IUW
 4ucN2R5vio5ReIOdy8p4HCB/q4EbE7Tx9buAScZ1T3Ml39X72Uz+BiWKVjW24MYDC6j31Ag
 2G51J14q8CaFWv+TZNAn9wsN37QMhO/Ra/CjlDrhhidlxmFphaBUVM2oZwV/3p0b2eZD00m
 tKcGY2HYdYgc7Ead6c6Lg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n7TcznSx4k0=:6AEqmGrBvP/yvabW5Xy1pU
 0X48GMa7a2VgL5zI2rn97FSRAr8jNxkAezgm0rCkioeww1737mAj/7hHYOcNRYpMqPFNMqygN
 Jg4inrzGR47IBRrJHusSjdW7bTL9CKM/lW32ZRtGmeGJTw++X4EQhreCXBwQLSXEuEeuiVrVy
 6WdSIlrqZiLdbiDcA1N2y02m5ZyiJ8VuOYkTGtMEiG/fBsLfwBZeBXLz5yoVA8eleEY6gyyvS
 abjF5gF3hnEsQO1z+ekWmMZnTlx90HU/xZghh3m1IeTiGM+bjts1Js9zWExrCTZM2nynReNVE
 A9ae5ZynfaDA2HsSKy9kBQGmbmGojcP2sHej9QjEKw1MhGRXz4d8zV+kH0eojGM6o1Y/W4uQR
 qnMQcqAc3PRrjFQOaRqf9ppwwaAgOj7GgInhdVt6qEnEhujPKQHtEzPMUWD5z60ho4v4QMb7X
 1OFl5LAtchURPKlw+tjzenjwnzp+2A24OVoJx9kw0KGPadGnd9k5AkozEvgr7BNnvpSwkREDa
 pOFLLxt0vCRdS3aIwYXkwXsxFJ2I69pZy/GCSZXqsxuAhLnIANLyZb9Zwr3U1Weam+7Rp5E6V
 tmd/0le3SJDGEyJ421d4+Xcc3vl34JjBGI1f9dAmXVmwpu3Su7UxVo4yAdenRswqmdBa+QgEy
 0MjXS/tQqLe/d8rT7X5jMSYc9FamnStbOyUc6tvapyzhcjhmR/kn/wbpn/krMdjMo5DEM+KI3
 ajO1oH4N9YgsVxH0A5xVJiKp8TJOoUb0njjiAQ==
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

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
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

