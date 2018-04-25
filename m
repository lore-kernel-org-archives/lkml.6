Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754900AbeDYPC3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:02:29 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:39041 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754320AbeDYPCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:02:22 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 04/16] y2038: ia64: Remove unneeded ipc uapi header files
Date: Wed, 25 Apr 2018 17:01:55 +0200
Message-Id: <20180425150207.822862-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:u75ovvnCuPDo99kPqSCGFyR/kSVxIQYQBPXlLsqPW7pk+9vo66w
 5nk6jZt8O8cSah6ggM70xKi1YT+yUxTS2WjRf3K0FYiI70FQUKHY/Y0Tec9aqB/Hu6vm1jz
 0+cx1eEqj4c94dSrySpgnh2myk997grKk51jShw8kq1c7vxtVR3oUZw9VxlI6OtDS01aa+i
 ap307hCWI4uMrVqGIRXyw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k0SUu6P6Sng=:ezZX/1zWPEOsS5PrfRj/lb
 V15dyBrx0FIpyX5rTkpE0WHBuDMGu53ixOfc6GQ1EDKfqjVelvTv/QwLbyT4oPJnOCDcV4dkH
 TXOlqD7z74+ZwI4iGB1Y95hV4tJolcKET/gq0XFCCWzGSbglaOMb01nRj4CKh+RYianeIz0Pk
 226sUSGr+cc8pLN0AW1EFBcGSSktv699zzqPp2+FJKXNjHF6A/ODDN0511p5HsqR4icsBjHSU
 TBMfKYU8MvpH9dzwlmuLh4sP/CavL1OR+Djg/z28JYwgo5vVlhUCYY6qh/PTUrXq/5qf4iTn5
 AD0mbQhOp2rbMx2XqDRDuxXF80h364KX0uaH5ftWeOsRqMF2HVradqsSCEHyV4yWmiLGZac8J
 uwDWHD6L0+PK23hQqcnbH6hfkxafMtMtZlg07rqUlPb8U6eNFQrRsKOlPBJCya5YI6eyVFSyY
 fD7hwLNOayit0rlNjyeKPS5zamdeZhBBXYBOnKNF8eGpDu8d4FDWbekCeEk5qq1ERN+4FAIkk
 x92sIbBqw+8KwN+VG6uw40JG0OF34bMzzQC8+jR9AqaJVUna8cXg3ZeGVVR5gvLHYw/G6qmfT
 Q8bjQwLlVmughy5SynindNngdb47YltttHt24rtFpKlHXU47XeR2iUyTr3QkEp1209L1C8YpO
 tN3U3lq/YKpgdZxyzL39OEcmOwsInGlCSJWQA3tHAvMFiD4GggkTCjwHI+yMMrosqhjLEJUfI
 gN8vYa9EuEJgvkIiavtbI/HcBSe2Ei4E9QrCGA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
