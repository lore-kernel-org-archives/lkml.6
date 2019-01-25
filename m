Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37193C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BE1218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBQVU3KV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfAYSrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:47:06 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36247 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfAYSrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:47:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so7656713lfg.3;
        Fri, 25 Jan 2019 10:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dDjzpjZHNudR58j9A+X6wWJAobmjBRUzv1f4dmw61E0=;
        b=RBQVU3KV6VGke5pPgWXPArbn5SrDMLzGAFdJ18J2YuEM9lJJgbKfV5pJ/1vcKy97jt
         jdW+diLJmX4c5mAJQ4vQ37IEsVuIIeBHXHbMxOSRPf0lrU2Wy3EMX6VcRwrADaLMyPiM
         PrbPYbJ8yxBDrHrG0jNo3FxkE7BH5dMR/i1TCc6bJ7G7oR9rTZBQLsOlFuGh2icAXdgD
         28saTEcoF6sr46XWUhnJKak/NlaaxnoPrYPKVSrWs1dR4x5vb+LehfueJn+VLS7B6WrV
         hFwZfQlZ0Y300BWKzbVhN9MqTO6Ql4QMVf6oCOG+hjW8yDAGT1uGOsyr8DkA1i32oWrs
         ly4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dDjzpjZHNudR58j9A+X6wWJAobmjBRUzv1f4dmw61E0=;
        b=of8jaQR8mRJZKv4FrfzIm++q9ypLrXsLpyngI18iNsRcYqPZG4tLmC+4nrKrNxhOuH
         EkoWRcl2yw3wRiP3xoseB1x6rqkSps3uOkAC7HyzDbhdNoNOJG0a/whedINZOZrkIm9P
         DFf9BPCboEq8iQEvSEFeix4c7yeCHAbYP5PaN7lUPLSRGvKbvPymrHeaTVEfj+aNc1KQ
         xzMCfPv1RTihzUyZ/cwL3A9m6iwc+ohez75re9SEMJKAQMpevtTXXnYyVSfytVkujG3Y
         4VB9O8JKpxMskjPOj+Y1VM9GY0E85WkAbAMHIcZfoyY0EY9kebfjK6C/Utfh4EAkzQap
         JXyw==
X-Gm-Message-State: AJcUukdGdVBBRVBJMAriYvAz2vXaVbEvnr/47yxhvrGQ/0jHjWM2gTM9
        D8vHMv2W6YOQY+EaRJMBILPKS4iiEBM=
X-Google-Smtp-Source: ALg8bN41lQFgZc+bv8bYCtQM251XiSVkQpZZ+oiv+tZcCtGtjengWRj44pb7YT9GyuCmlKmyb9S7RA==
X-Received: by 2002:a19:9653:: with SMTP id y80mr9983487lfd.66.1548442022387;
        Fri, 25 Jan 2019 10:47:02 -0800 (PST)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id q6sm1561305lfh.52.2019.01.25.10.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 10:47:01 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] treewide: get rid of HAVE_FUTEX_CMPXCHG
Date:   Fri, 25 Jan 2019 10:46:40 -0800
Message-Id: <20190125184640.5174-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_HAVE_FUTEX_CMPXCHG is currently used to determine if
atomic_inatomic is always working or must be probed. For most
architectures it is either selected, or it is known that they always
have futex_atomic_cmpxchg_inatomic working.

Drop HAVE_FUTEX_CMPXCHG from the Kconfig and let architectures that may
not have it working define macro arch_have_futex_cmpxchg that probes
whether futex_atomic_cmpxchg_inatomic is working, otherwise assume that
it is working.

Implement arch_have_futex_cmpxchg for MIPS, Xtensa and for the users of
asm-generic/futex.h.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- fix #ifdef/#ifndef logic in kernel/futex.c

 arch/arc/Kconfig                |  1 -
 arch/m68k/Kconfig               |  1 -
 arch/mips/include/asm/futex.h   |  2 ++
 arch/riscv/Kconfig              |  1 -
 arch/s390/Kconfig               |  1 -
 arch/sh/Kconfig                 |  1 -
 arch/um/Kconfig                 |  1 -
 arch/xtensa/Kconfig             |  1 -
 arch/xtensa/include/asm/futex.h |  4 ++++
 include/asm-generic/futex.h     |  2 ++
 init/Kconfig                    |  8 --------
 kernel/futex.c                  | 30 ++++++++----------------------
 12 files changed, 16 insertions(+), 37 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 376366a7db81..01932be9f7e3 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -29,7 +29,6 @@ config ARC
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_DEBUG_STACKOVERFLOW
-	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_IOREMAP_PROT
 	select HAVE_KERNEL_GZIP
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index e173ea2ff395..09499af5d22a 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -20,7 +20,6 @@ config M68K
 	select GENERIC_STRNLEN_USER if MMU
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_USES_GETTIMEOFFSET if MMU && !COLDFIRE
-	select HAVE_FUTEX_CMPXCHG if MMU && FUTEX
 	select HAVE_MOD_ARCH_SPECIFIC
 	select MODULES_USE_ELF_REL
 	select MODULES_USE_ELF_RELA
diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
index c14d798f3888..f61221d080fc 100644
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -122,6 +122,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 	return ret;
 }
 
+#define arch_have_futex_cmpxchg() (cpu_has_llsc)
+
 static inline int
 futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 			      u32 oldval, u32 newval)
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index feeeaa60697c..074966cdd41d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -31,7 +31,6 @@ config RISCV
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_DMA_CONTIGUOUS
-	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_PERF_EVENTS
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ed554b09eb3f..6f3819275d08 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -146,7 +146,6 @@ config S390
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
-	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_GCC_PLUGINS
 	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_GZIP
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index a9c36f95744a..a04bc11c8819 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -50,7 +50,6 @@ config SUPERH
 	select OLD_SIGACTION
 	select PCI_DOMAINS if PCI
 	select HAVE_ARCH_AUDITSYSCALL
-	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_NMI
 	select NEED_SG_DMA_LENGTH
 
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index ec9711d068b7..38c5ce3b64b1 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -10,7 +10,6 @@ config UML
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_UID16
-	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_BUGVERBOSE
 	select GENERIC_IRQ_SHOW
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 7021d1e15909..a4d34de57809 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -25,7 +25,6 @@ config XTENSA
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_EXIT_THREAD
 	select HAVE_FUNCTION_TRACER
-	select HAVE_FUTEX_CMPXCHG if !MMU
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_OPROFILE
diff --git a/arch/xtensa/include/asm/futex.h b/arch/xtensa/include/asm/futex.h
index 505d09eff184..ac88d64f94e4 100644
--- a/arch/xtensa/include/asm/futex.h
+++ b/arch/xtensa/include/asm/futex.h
@@ -87,6 +87,10 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 	return ret;
 }
 
+#if !XCHAL_HAVE_S32C1I
+#define arch_have_futex_cmpxchg() (0)
+#endif
+
 static inline int
 futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 			      u32 oldval, u32 newval)
diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index fcb61b4659b3..deefe5b22b9b 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -136,6 +136,8 @@ arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
 	return ret;
 }
 
+#define arch_have_futex_cmpxchg() (0)
+
 static inline int
 futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 			      u32 oldval, u32 newval)
diff --git a/init/Kconfig b/init/Kconfig
index 513fa544a134..351f4c93f932 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1338,14 +1338,6 @@ config FUTEX_PI
 	depends on FUTEX && RT_MUTEXES
 	default y
 
-config HAVE_FUTEX_CMPXCHG
-	bool
-	depends on FUTEX
-	help
-	  Architectures should select this if futex_atomic_cmpxchg_inatomic()
-	  is implemented and always working. This removes a couple of runtime
-	  checks.
-
 config EPOLL
 	bool "Enable eventpoll support" if EXPERT
 	default y
diff --git a/kernel/futex.c b/kernel/futex.c
index be3bff2315ff..1b3695c4c6cc 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -174,7 +174,11 @@
  * double_lock_hb() and double_unlock_hb(), respectively.
  */
 
-#ifdef CONFIG_HAVE_FUTEX_CMPXCHG
+/*
+ * Architectures should define this macro if futex_atomic_cmpxchg_inatomic()
+ * may not be always working.
+ */
+#ifndef arch_have_futex_cmpxchg
 #define futex_cmpxchg_enabled 1
 #else
 static int  __read_mostly futex_cmpxchg_enabled;
@@ -3842,26 +3846,6 @@ COMPAT_SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 }
 #endif /* CONFIG_COMPAT_32BIT_TIME */
 
-static void __init futex_detect_cmpxchg(void)
-{
-#ifndef CONFIG_HAVE_FUTEX_CMPXCHG
-	u32 curval;
-
-	/*
-	 * This will fail and we want it. Some arch implementations do
-	 * runtime detection of the futex_atomic_cmpxchg_inatomic()
-	 * functionality. We want to know that before we call in any
-	 * of the complex code paths. Also we want to prevent
-	 * registration of robust lists in that case. NULL is
-	 * guaranteed to fault and we get -EFAULT on functional
-	 * implementation, the non-functional ones will return
-	 * -ENOSYS.
-	 */
-	if (cmpxchg_futex_value_locked(&curval, NULL, 0, 0) == -EFAULT)
-		futex_cmpxchg_enabled = 1;
-#endif
-}
-
 static int __init futex_init(void)
 {
 	unsigned int futex_shift;
@@ -3880,7 +3864,9 @@ static int __init futex_init(void)
 					       futex_hashsize, futex_hashsize);
 	futex_hashsize = 1UL << futex_shift;
 
-	futex_detect_cmpxchg();
+#ifdef arch_have_futex_cmpxchg
+	futex_cmpxchg_enabled = arch_have_futex_cmpxchg();
+#endif
 
 	for (i = 0; i < futex_hashsize; i++) {
 		atomic_set(&futex_queues[i].waiters, 0);
-- 
2.11.0

