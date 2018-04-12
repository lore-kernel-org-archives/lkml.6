Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753124AbeDLOUj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:20:39 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:47377 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752798AbeDLOUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:20:34 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 02/13] y2038: alpha: remove unneeded ipc uapi header files
Date: Thu, 12 Apr 2018 16:20:13 +0200
Message-Id: <20180412142024.853892-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180412142024.853892-1-arnd@arndb.de>
References: <20180412142024.853892-1-arnd@arndb.de>
X-Provags-ID: V03:K1:Hl7tuAx/AzVq9PLhiEaxrZmCy8o74FaTUlnckfhHF7ebjhJEojd
 EFgaqdt2vXYuNlRlG/BVEnDo1q6BWY7MEvs/HRsnUd6Bgg/cyq9UVQqhlqc56mL4rE5zyed
 JlLcDS7n0mRswcI3OIZusr1dRy/SlTS2tt48GlAWt96+jF1ss1dRIkMziZlwgTTsqonsyyc
 WA7QvpHNfpQbUH6jDbSYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZtFPCYH0eMQ=:qKG4BA6SmHU3iNXUfr8e6s
 bIOeMS+bo4WmqiJ/M/W+denl9Dj6yAMvmAkJusGUVqeQaujWU5yTN1UrZdaqW6MRzONey9NL7
 kGmpYzXD+u2mfHzq8UldDWfPnuAabnQvK8aJvSt5erX2Yjf/SNk8nP0/ltp0dvaEI2SreMTr5
 jK1xCq+oGa5gdWCMsXJxyJ6/HAHALT+XY4J9D1nazhy3vhIUj+N5nPaNcr5fEG/id2+xR6jFM
 CcEFhy/DPHfnfzwIjbmi8CZoM3fd+dqEwEn6OUYtixQBNfMJ+M5R4vxUQVm+ygXZRuBL1t+Nh
 DdEBjyz+4BkuMsAYKVcz1p/2lJYXN+7SWtLnL5RxkOqZUTq87bKREJ7TxxuVHIOf6cIk1H97U
 sdzb+MAdp2lStJHBVoZcp1krlJPeQ9onHCck0yNj7iFY3TpFma5bOEdMLYQgLp/j24S1H8x+R
 TT2SSoZNGTP9rrSX9G1bHxzPsQ+O0s5rWe0h10UBVr1/IeAFbIrRd+eMRX8P2/xjZLf3FA4F/
 qtsB98eX+MWoM/6jPJpYZ+uuDKWh0iBVThXd8Y1MqWvgxenYBeKHZpSplpTgFgosqmL3mQy8J
 GYtWsJuPD7lRIJ6e8F6H8mOx+01fTUVOJl2V6ZWb08lXDhlLHmhiCuyutrr9ae9guAS3N2Ii5
 hSIeDWU/cnNlWE548vPiw0YX1abqIIZ5+TOAzV3DcGUK2r6NoVdKXzx6T8djv6Y0sxEq8xfX7
 0dP65U6GnU5dLk9eqOtzY5S1sTdH+5EUJ1E1/g==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alpha ipcbuf/msgbuf/sembuf/shmbuf header files are all identical
to the version from asm-generic.

This patch removes the files and replaces them with 'generic-y'
statements as part of the y2038 series. Since there is no 32-bit
syscall support for alpha, we don't need the other changes, but
it's good to have clean this up anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/Kbuild        |  4 ++++
 arch/alpha/include/uapi/asm/ipcbuf.h |  2 --
 arch/alpha/include/uapi/asm/msgbuf.h | 28 --------------------------
 arch/alpha/include/uapi/asm/sembuf.h | 23 ---------------------
 arch/alpha/include/uapi/asm/shmbuf.h | 39 ------------------------------------
 5 files changed, 4 insertions(+), 92 deletions(-)
 delete mode 100644 arch/alpha/include/uapi/asm/ipcbuf.h
 delete mode 100644 arch/alpha/include/uapi/asm/msgbuf.h
 delete mode 100644 arch/alpha/include/uapi/asm/sembuf.h
 delete mode 100644 arch/alpha/include/uapi/asm/shmbuf.h

diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
index 0580cb8c84b2..b011d981cac4 100644
--- a/arch/alpha/include/asm/Kbuild
+++ b/arch/alpha/include/asm/Kbuild
@@ -5,11 +5,15 @@ generic-y += compat.h
 generic-y += exec.h
 generic-y += export.h
 generic-y += fb.h
+generic-y += ipcbuf.h
 generic-y += irq_work.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += msgbuf.h
 generic-y += preempt.h
 generic-y += sections.h
+generic-y += sembuf.h
+generic-y += shmbuf.h
 generic-y += trace_clock.h
 generic-y += current.h
 generic-y += kprobes.h
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
