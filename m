Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2125ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B8A20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B8A20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeINQyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:54:15 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:53115 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbeINQyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:54:14 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MOhx9-1gC5tc2caV-00QDTl; Fri, 14 Sep 2018 13:39:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arch@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Joseph=20Myers=C2=A0?= <joseph@codesourcery.com>,
        David Howells <dhowells@redhat.com>, libc-alpha@sourceware.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [RFC] making uapi/linux/elfcore.h useful again
Date:   Fri, 14 Sep 2018 13:38:50 +0200
Message-Id: <20180914113929.953895-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IvQnIY3ns+ZrMCu5VYbbMbMWoe6/vWDHhdQVrYx04i3GkHbZhvw
 2TNDTxM63rbM2T7ZsQ2j3Q/LovVf9bzIYF+nbtjVZewHSF9s/s2ARwIMeCGrhqcogqr9BTp
 LVBnA2CW+mM53FS3XsR8PVD+A+DaFVMgHLMZGVz9eCWeLzBVwj2/8dlkQ+9ckg3M9W//MJ/
 ljE0+YncDdxjuQUyVrjYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OLsWcUYBQhE=:PjE+99rKcz/kzibynS49B7
 zwJq05E8oYaoKtx5euW1xyQ4vd9vTGQVeCyYXVZOIAjwATr4MlQd+Y9A+b8ifsNyertfMHfm6
 30jyzx5EaQ9w6mizFw13wnsNxQEKUdwTE0hqd4BbIenLneMrOY1rfwStuLrX7+wlOcX7YZNkG
 Ri0w5SVlD6y3Dp+veQ/wv5fQUzjzCm8t//0OY7LKLGnITiN0YJaux9fk7fYa2qDfQcIIDE4FE
 wV+nvYK1jEIQtorxeHLHnWjaaop/pvrfPpICLzibsplRun/rBcwZoWugxNMXVqxCVHPd/9ZO8
 jbjtgft16PnCy/1snw6KUlZfg8wrzTG+LIDBz4YF6jUiwxaZdw4+YH7qvvl73b4LM+gyuvFvX
 UltvO+t8qsA2PXfaVpCO0xQlgyBCy6KFHJOVf58cKd+JK19ZDFMvt4axugBf3SUEwJnJ8cb2u
 eSXiCehS7S2GYImnS8yHWIqvsfGkP7IRv74ydwiMHlHByx/WVJ96OagxZveP4+LQ3jxWooSCT
 /mVxJ9PGCDMg6ICpjwy0tOaF96ys7/KoVFrSgjpWOQckh8Q23kWSTL+/pa3Hq2g5yuFGTSnJS
 TSrVEhJ7M69tCvZqPSLAaWIWaBuKeYSs+Cn+KDeZeYfEV1E7Zki6+3S4tIUahNvo9yeKG5sNm
 pDCZiRBN1HTM+9uPS6xYAEshhaQ/MaXvozYPnh+mMpcQMTJo3z6tI+BQ3Jj783Me13VPW5UoY
 PL742Pmzq5jFYPLU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After finding a bug in glibc the question came up how linux/elfcore.h
is supposed to be used from user space. As far as I can tell, it's
not possible, as it references data types that are simply unavailable
there.

The #ifndef __KERNEL__ section in that header dates back to when the
file was introduced in linux-1.3.5, and presumably was meant to
provide the structures for the libc sys/procfs.h implementation.
However, this was never portable to architectures other than x86-32,
and has been broken on that architecture at a later point.

These are the steps that I needed to make it possible to include the
header file, e.g. for libc self-testing in order to make sure the
structures are compatible with its own:

- drop the #ifndef __KERNEL__ section that are obviously useless
  and get in the way

- change the pid_t references to __kernel_pid_t

- Move required data from the private x86 asm/elf.h file into
  a new uapi/asm/elf.h. Some other architectures already do that,
  but most of them do not. Before applying the patch, we have
  to do this for all architectures

- Change ELF_NGREG to an integer literal constant instead of
  a sizeof operation based on a private type.

Cc: Joseph Myers <joseph@codesourcery.com>
Cc: David Howells <dhowells@redhat.com>
Cc: libc-alpha@sourceware.org
Link: https://patchwork.ozlabs.org/patch/969540/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/elf.h         | 24 +-----------------------
 arch/x86/include/uapi/asm/elf.h    | 30 ++++++++++++++++++++++++++++++
 arch/x86/include/uapi/asm/signal.h |  2 +-
 include/uapi/linux/elf.h           |  1 +
 include/uapi/linux/elfcore.h       | 26 +++++---------------------
 5 files changed, 38 insertions(+), 45 deletions(-)
 create mode 100644 arch/x86/include/uapi/asm/elf.h

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 0d157d2a1e2a..973bd7b5b164 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -10,18 +10,10 @@
 #include <asm/ptrace.h>
 #include <asm/user.h>
 #include <asm/auxvec.h>
-
-typedef unsigned long elf_greg_t;
-
-#define ELF_NGREG (sizeof(struct user_regs_struct) / sizeof(elf_greg_t))
-typedef elf_greg_t elf_gregset_t[ELF_NGREG];
-
-typedef struct user_i387_struct elf_fpregset_t;
+#include <uapi/asm/elf.h>
 
 #ifdef __i386__
 
-typedef struct user_fxsr_struct elf_fpxregset_t;
-
 #define R_386_NONE	0
 #define R_386_32	1
 #define R_386_PC32	2
@@ -35,13 +27,6 @@ typedef struct user_fxsr_struct elf_fpxregset_t;
 #define R_386_GOTPC	10
 #define R_386_NUM	11
 
-/*
- * These are used to set parameters in the core dumps.
- */
-#define ELF_CLASS	ELFCLASS32
-#define ELF_DATA	ELFDATA2LSB
-#define ELF_ARCH	EM_386
-
 #else
 
 /* x86-64 relocation types */
@@ -65,13 +50,6 @@ typedef struct user_fxsr_struct elf_fpxregset_t;
 
 #define R_X86_64_NUM		16
 
-/*
- * These are used to set parameters in the core dumps.
- */
-#define ELF_CLASS	ELFCLASS64
-#define ELF_DATA	ELFDATA2LSB
-#define ELF_ARCH	EM_X86_64
-
 #endif
 
 #include <asm/vdso.h>
diff --git a/arch/x86/include/uapi/asm/elf.h b/arch/x86/include/uapi/asm/elf.h
new file mode 100644
index 000000000000..a640e1224939
--- /dev/null
+++ b/arch/x86/include/uapi/asm/elf.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_ASM_X86_ELF_H
+#define _UAPI_ASM_X86_ELF_H
+
+#ifdef __i386__
+
+/*
+ * These are used to set parameters in the core dumps.
+ */
+#define ELF_CLASS	ELFCLASS32
+#define ELF_DATA	ELFDATA2LSB
+#define ELF_ARCH	EM_386
+#define ELF_NGREG	17
+
+#else
+
+/*
+ * These are used to set parameters in the core dumps.
+ */
+#define ELF_CLASS	ELFCLASS64
+#define ELF_DATA	ELFDATA2LSB
+#define ELF_ARCH	EM_X86_64
+#define ELF_NGREG	27
+
+#endif /* __i386__ */
+
+typedef unsigned long elf_greg_t;
+typedef elf_greg_t elf_gregset_t[ELF_NGREG];
+
+#endif
diff --git a/arch/x86/include/uapi/asm/signal.h b/arch/x86/include/uapi/asm/signal.h
index e5745d593dc7..00f273eaddf7 100644
--- a/arch/x86/include/uapi/asm/signal.h
+++ b/arch/x86/include/uapi/asm/signal.h
@@ -128,7 +128,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 #endif /* __ASSEMBLY__ */
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index c5358e0ae7c5..e1e4561ed9c2 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/elf-em.h>
+#include <asm/elf.h>
 
 /* 32-bit ELF base types. */
 typedef __u32	Elf32_Addr;
diff --git a/include/uapi/linux/elfcore.h b/include/uapi/linux/elfcore.h
index baf03562306d..9c0078004275 100644
--- a/include/uapi/linux/elfcore.h
+++ b/include/uapi/linux/elfcore.h
@@ -16,15 +16,6 @@ struct elf_siginfo
 	int	si_errno;			/* errno */
 };
 
-
-#ifndef __KERNEL__
-typedef elf_greg_t greg_t;
-typedef elf_gregset_t gregset_t;
-typedef elf_fpregset_t fpregset_t;
-typedef elf_fpxregset_t fpxregset_t;
-#define NGREG ELF_NGREG
-#endif
-
 /*
  * Definitions to generate Intel SVR4-like core files.
  * These mostly have the same names as the SVR4 types with "elf_"
@@ -49,10 +40,10 @@ struct elf_prstatus
 	struct sigaltstack pr_altstack;	/* Alternate stack info */
 	struct sigaction pr_action;	/* Signal action for current sig */
 #endif
-	pid_t	pr_pid;
-	pid_t	pr_ppid;
-	pid_t	pr_pgrp;
-	pid_t	pr_sid;
+	__kernel_pid_t	pr_pid;
+	__kernel_pid_t	pr_ppid;
+	__kernel_pid_t	pr_pgrp;
+	__kernel_pid_t	pr_sid;
 	struct __kernel_old_timeval pr_utime;	/* User time */
 	struct __kernel_old_timeval pr_stime;	/* System time */
 	struct __kernel_old_timeval pr_cutime;	/* Cumulative user time */
@@ -85,17 +76,10 @@ struct elf_prpsinfo
 	unsigned long pr_flag;	/* flags */
 	__kernel_uid_t	pr_uid;
 	__kernel_gid_t	pr_gid;
-	pid_t	pr_pid, pr_ppid, pr_pgrp, pr_sid;
+	__kernel_pid_t	pr_pid, pr_ppid, pr_pgrp, pr_sid;
 	/* Lots missing */
 	char	pr_fname[16];	/* filename of executable */
 	char	pr_psargs[ELF_PRARGSZ];	/* initial part of arg list */
 };
 
-#ifndef __KERNEL__
-typedef struct elf_prstatus prstatus_t;
-typedef struct elf_prpsinfo prpsinfo_t;
-#define PRARGSZ ELF_PRARGSZ 
-#endif
-
-
 #endif /* _UAPI_LINUX_ELFCORE_H */
-- 
2.18.0

