Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-889516-1524668908-2-2282561189402195041
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
    1524668907; b=WOaGnDiGnRSGOMKwa2+XiN9oDBMtgAmz5OrGNIYTcTN8WY2y9s
    ArDRO28wtXsBU1JJ31H55S4r69oCAq1r/l4/ZwbSPpRbYR60RzAPMTo7SAJmePlO
    jS3ZlV1UO0S+q8lNo9hLmknHvPQSSgajZbZbt1V69n/9FdoYB87fPzp3LWYEpyiP
    U+IAET4RrckeiMs/KvMy2EIxySzGRx/34K0071Unvuv1iKg6dLjYlzsT9NzK1Qxu
    mldzh9aFq7jjASQ7TI5VJ3mF5UBHHDk0GFCXsxkeQOl+MY2c+Bt+i9MtUUIXDH97
    wtsyZkDftS9es+UvdzEKenfSXR+2edk7yrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524668907; bh=
    RPAou+pZRL3JDOy/LgOAfscZL25+nx2x/tUbkRVPEFM=; b=VnsPqOxjoY9g8a7x
    A6hdtenEqDqYt8KPL/NkvXpXH+Ere7KCY0q5NYLiUf5BtKzPmQN2haTeHsJ0aJFw
    KV3OfhlzsePWpgsqfwZNymk+jgIwBdKJST0sIHvfvdls2RwUEKkIKXULKW9+sMqc
    P2+jmDiwVDOSKySZ6KK+KqO06RYBVThtP+PErFpg48+LVTcM8acDtdaTrVc4Ax+1
    gW0kgzsx++9WDfk5nH2Cj+v47MP/pCCogjfdqnzADwsZP9iuMOFm2/mC/O9+jqdV
    8WlYwalS9+PRjCEgqGrshWc8psi1mJ0L3ZgyYWMq51l5Ic+evcictoBLzSOiX8I3
    cnlQ/Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfAmOm3m1m5dMAcLyqoqvisWk7qls9ddFyj/7LxYyjv6QUb3K7K2dj55UxjETYiN9k2IH24vn4olkEGOB7TdKPItjsNmEAwi1gqSuAcm2W9f8r5Q9GgaQ
    7g28HQQhMd3AAf6fQWDgcMwoZG11IRHvcfc9OhkWY4PKR1oF5DRBrrM3n6QOWEI0ASWc//eYpIeS06Ypv1szsmJSeJJzEV5iWiY0tkfV1N2bQykmMGIICjIs
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=XDPUjLVUeFrZggzrMEMA:9 a=8vlkM-slKRsSqWcT:21 a=J8TjxFBZp2hdAeYA:21
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755063AbeDYPIO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 11:08:14 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:39195 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755019AbeDYPIE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 11:08:04 -0400
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
Subject: [PATCH v4 03/16] y2038: alpha: Remove unneeded ipc uapi header files
Date: Wed, 25 Apr 2018 17:05:53 +0200
Message-Id: <20180425150606.954771-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:21j9el2MyQ+OqSMHBba9aeA/DokgR6Wfk7pa4b3vrCA6OOfMAVg
 n+836UXVPzJq1Wlif5xui4QAkiWS1qpF0ZkELUMf4DhLX5EvHZZycIqD5aS9VpGy3uzuHvk
 wmDQ3wQ4V1BPM5smRcibjLk6v5mSo3QUB5s8ms86by4PVC1UO07NLH/nfsVy4FbPKZ/OnJT
 zO2s6Fqnk39VdUChpGyTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v0UIZlOj8S0=:xXX3Okvb9Q80HggRiauE/R
 zCiO2ninXG4wC1Yq9uPcMp5jvaixe5PwY/H8EUspEMTPVxNyfSAEqUnZZJQjssDqMuacG2A9c
 fFJ2tPFkE6wGG9ThG0zqh6jMeEc0fZlOqvOAcB4RvB2s5MvBzWjGAsZufangfwGGOPjHWg+nP
 Z6VrFpiIgP7RgARrK/tysjxmY/cO2amxc9RuNdIzZKVugCFoRypSDnNe3fgQkQmpQBLBdj5p7
 DQtG+rJpP6NJq+YioMrPymms6yGJV82UyBF2FmCAweIwyznnvANpOWT06KfJ+Fse4UHL4ZLVc
 ZmKu3Itp2h7Xvtg/yLH7yzrFv1oXU84xxd1MAxCDgzdeZtk52raHrGsqrEt5VuQQr+v2WOeO/
 3Xf4XL/uoCNaQcCSvyifgAJIVsvZpZgjSRgF0ruM9LPC2Z6/Ytjf9B1ZuZfwj+KkVge1R11r8
 C6tewNUEErxZTXDTamsLK6Hz18WYbNojtSMbx4V+Oj9QDoDuW3wMD/T1kbq/+Y/WcUSLcSs7p
 8IkPlzm9ogkl7XBZ6s9fCIx9n+XjuFdzunt2rB6xeR6qtPas2wLNUvAxHiISMnad6WFUmf6ee
 CgkX0vV21l0cjIHCBXn+pFnE+80w+RKLPsSF1kUgEEZTMNqgwXfMb0caHaAulD6rKwzrL441N
 ljB7OAFd1+OHxRlJAaqiFce6vmwye6D+Z22glI+PpsrHUlqrjms3xm2dPEjBO6NmyecdDjJlK
 AGICLMVddYm09Y/O3Tf+uPZYI1tavb6XWf0X6GIJ6vAC3agS389PuuAzQhoEoZYrU4df3auk9
 oEZLCaEYb999FzZiitVnw5Dw82Ce4N/vmW0FX4FJDJcp649gGibFe1iKTd2qyRqfyfoWlRkHP
 EM75vzOxomY0yitfjDr9+wYkKos7VthY0zboQAhZzYIu6HnIIwgseJB4BbRwGY
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

