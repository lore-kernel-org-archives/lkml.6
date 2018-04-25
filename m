Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754593AbeDYN0D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:26:03 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:39133 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752985AbeDYNW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:22:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 03/16] y2038: alpha: Remove unneeded ipc uapi header files
Date: Wed, 25 Apr 2018 15:22:29 +0200
Message-Id: <20180425132242.1500539-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425132242.1500539-1-arnd@arndb.de>
References: <20180425132242.1500539-1-arnd@arndb.de>
X-Provags-ID: V03:K1:nNxmCVph91iMEuhvNV8ggAHicLgiXCPVDs/Lox21+qZXVcnvyQC
 xfAOqtKdsr3zO5dt15bcLUHKJMgsBVHTXFoW6F7Kc8zYMFEpx/El5lk3RfVM21s7E3Etms4
 v6JrfKuKWXZWyDmmSKIkWdAJZlHV/NdYWhZIDMRWtFrMIim9+CoZM9Z8uY+REkx/qgupHCf
 NOK7wj6p/yCk/pSMisLLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XoRTgtyhi5M=:41IBRo/KyEVKOBaBbCo1Rn
 TaS+23yR7djdU0FIhhuBC0cefx8Zjx5CrCNz30iH/MhwbLHOlVgZr0tygQXLp0Pq8VZLHlf1N
 SICBeE6NeHm5S/WshP11/y8sh4+ECg5qZ1wpHGTJaTGEyu7uPnl1m9gnWNS907SvCEuOsEuv0
 j2uGn13+UsYmJVjQ2t10Id/cXII9npNNHuucwerKWMB91c9cWffibDhr4doU6fy5++Bm+aeMT
 lZBHwAWMgE842rhVKFh8ah9ksWod6f7J7dv4ALCZwx6ZhZxXrfWjiAJ5GRYUKuj5B1mCQGCb0
 rpJ+P8YOTcpB1adB/OQ+M9umFatY2XBnp52B282bHlEmjC2Np8zsjT4jo6AjtH+klwFoUep00
 Vaody6kXRcbO58gBg5jWTn477D/i9DxNMHIR5twt+kjuqUKXiD6610H16zNujvzTeMD08qo6J
 R+npynexCo+1mAJB0yBv2Wtsk47jtIx/Yztqee0fb/wbyP4NIZj70PY6d32etekEtSn9pMFrz
 yHUoz14WmH9MuNRGIPnaQ6E9J5j9+WdeStYEy4/uC3A/YgLwoWrEuibgmBD1WbWn6Mo7sUSNF
 h2+ymEe9mUAn07T8QKmjLE6qi0Iv43KKU8XfjLL9mIgJs25hnfcjMDdjJfjo+0c9DYRzhDaU4
 DjYtJBvFvppkHKfjc8DhaCOpE0FxABMKJPONNQ9MLNkXwFtVs/TGljrB/EF3XywjyFMZfmx9q
 G7SH+GueR724+lZzsliTm4AhoNq0LHCWeeASYw==
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
