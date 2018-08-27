Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B088C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2FB208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2FB208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbeH0Xec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:34:32 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:48091 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbeH0Xdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:33:47 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M6DoA-1fjzPk0k8o-00yBxR; Mon, 27 Aug 2018 21:45:38 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     tglx@linutronix.de
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, deepa.kernel@gmail.com,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 07/14] asm-generic: Remove unneeded __ARCH_WANT_SYS_LLSEEK macro
Date:   Mon, 27 Aug 2018 21:45:24 +0200
Message-Id: <20180827194531.3796559-8-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827194531.3796559-1-arnd@arndb.de>
References: <20180827194531.3796559-1-arnd@arndb.de>
X-Provags-ID: V03:K1:kz0MUR0edeX/CTA9y/GpA3AA0Hfpn6jT9kn21nGkPkdsEtiluk1
 xRKbWld+2f5lmUPUr4wYneLMVhpEhMGFtbVOKHnYcZGYHFaGAURJQqaShv5OjjKP5VB+RCg
 PlzBJiOiN/QqqlbBm+nwt/iQNgG66s1HgXLLsO54X6OLPGUXEZQsMGRvDrQvW0ZYO1SCcgc
 vO6tgSuLXrBHrtg8eT81A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N/oyfW0C/NY=:hv9OoiN+MqO+bpuEmNd0Uf
 oOmHlnBkLEqmtsGMjI5hVZKubuYIMwkzoS2DQahRg1JC1hnjxy9iGTG1OgmgUKkpA56t6C1h8
 L1hUqnUoBH2xFNiMlCN4h+Ri5DKcARUT9zM4NB638z1KBxFO3vjRRqMWvJ0ZttJoX5MEhwZi3
 FGfggth+eMk68aXb9BYi83XvL2BmOX67ZIUoqj0VzXDw3O6NYPEpqZlp/1bbp+I8LVs/k9f6S
 gnvLx3hEgpnLukZceTYWTWV9x7dX6+UX/T3x22jFLSCQDmhHy96jPhLQ7fL5b3zdmVl8BLJdS
 zAB6KoXvMZjbfmJhx24x/vp675myP+MJVAOj/aXBBVVxPgcLFUkf5wPSwztYfFXAXpV0TVP8G
 P/mb3S7lnmX/uurK3fFsvASwJL5jnanavpa39pCE0uN+BEDtxRzUWFiosT6KnX4TPfXvh50a+
 330ULRQRTEcu9+U6HAmBOy71AcJ1qxqn4r1HZKma9rLF1Mm6TDex+yvQGtOVgWfiqenjk5kEk
 Hq7dqSnILMYj/PXFJQNH7tv4xlcWDMAtoNbbbznDlwUffKrmJNXnbirsJq3FrVlnpS9nMKeMp
 61vqTVVG+fABjN1vhLRlTFs1+91YKb2mCyTe9ndq+irE0jk+oiNZP4Zp7D8moahDkqtrjRlqk
 zyNy2/ArrQT49i0MY1koNi3DVyalwcOxnNBwwsd92JpXez9YmwfWk3VY6Ofw10vqQtIs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sys_llseek sytem call is needed on all 32-bit architectures and
none of the 64-bit ones, so we can remove the __ARCH_WANT_SYS_LLSEEK guard
and simplify the include/asm-generic/unistd.h header further.

Since 32-bit tasks can run either natively or in compat mode on 64-bit
architectures, we have to check for both !CONFIG_64BIT and CONFIG_COMPAT.

There are a few 64-bit architectures that also reference sys_llseek
in their 64-bit ABI (e.g. sparc), but I verified that those all
select CONFIG_COMPAT, so the #if check is still correct here. It's
a bit odd to include it in the syscall table though, as it's the
same as sys_lseek() on 64-bit, but with strange calling conventions.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/unistd.h        | 1 -
 arch/arm64/include/asm/unistd.h      | 1 -
 arch/m68k/include/asm/unistd.h       | 1 -
 arch/microblaze/include/asm/unistd.h | 1 -
 arch/mips/include/asm/unistd.h       | 1 -
 arch/parisc/include/asm/unistd.h     | 1 -
 arch/powerpc/include/asm/unistd.h    | 1 -
 arch/s390/include/asm/unistd.h       | 1 -
 arch/sh/include/asm/unistd.h         | 1 -
 arch/sparc/include/asm/unistd.h      | 1 -
 arch/x86/include/asm/unistd.h        | 1 -
 arch/xtensa/include/asm/unistd.h     | 1 -
 fs/read_write.c                      | 2 +-
 include/asm-generic/unistd.h         | 9 ---------
 14 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 07e58010d597..8f1159c26f20 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -21,7 +21,6 @@
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index e0d0f5b856e7..2af308f13463 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -18,7 +18,6 @@
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
diff --git a/arch/m68k/include/asm/unistd.h b/arch/m68k/include/asm/unistd.h
index db22cdadc38a..e680031bda7b 100644
--- a/arch/m68k/include/asm/unistd.h
+++ b/arch/m68k/include/asm/unistd.h
@@ -22,7 +22,6 @@
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_OLD_GETRLIMIT
 #define __ARCH_WANT_SYS_OLD_MMAP
diff --git a/arch/microblaze/include/asm/unistd.h b/arch/microblaze/include/asm/unistd.h
index a28dc770c9b2..f42c40f5001b 100644
--- a/arch/microblaze/include/asm/unistd.h
+++ b/arch/microblaze/include/asm/unistd.h
@@ -27,7 +27,6 @@
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 /* #define __ARCH_WANT_SYS_OLD_GETRLIMIT */
 #define __ARCH_WANT_SYS_OLDUMOUNT
diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index d7878b3e16d8..c2174b80e50e 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -34,7 +34,6 @@
 #define __ARCH_WANT_SYS_WAITPID
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_OLD_UNAME
 #define __ARCH_WANT_SYS_OLDUMOUNT
diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index b36273bacca7..a0c38374fff0 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -156,7 +156,6 @@ type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5)	\
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 8b37e01817be..9326c9133516 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -36,7 +36,6 @@
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_OLD_GETRLIMIT
 #define __ARCH_WANT_SYS_OLD_UNAME
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index 1d181373288a..a2d583ea526d 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -26,7 +26,6 @@
 #define __ARCH_WANT_SYS_IPC
 #define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_OLD_GETRLIMIT
 #define __ARCH_WANT_SYS_OLD_MMAP
diff --git a/arch/sh/include/asm/unistd.h b/arch/sh/include/asm/unistd.h
index a845b57eac69..a99234b61051 100644
--- a/arch/sh/include/asm/unistd.h
+++ b/arch/sh/include/asm/unistd.h
@@ -20,7 +20,6 @@
 # define __ARCH_WANT_SYS_SOCKETCALL
 # define __ARCH_WANT_SYS_FADVISE64
 # define __ARCH_WANT_SYS_GETPGRP
-# define __ARCH_WANT_SYS_LLSEEK
 # define __ARCH_WANT_SYS_NICE
 # define __ARCH_WANT_SYS_OLD_GETRLIMIT
 # define __ARCH_WANT_SYS_OLD_UNAME
diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index 3544244685e1..f7514d3eae7b 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -34,7 +34,6 @@
 #define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_NICE
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index 35b66bbf8028..153d2a5e6b02 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -38,7 +38,6 @@
 # define __ARCH_WANT_SYS_FADVISE64
 # define __ARCH_WANT_SYS_GETHOSTNAME
 # define __ARCH_WANT_SYS_GETPGRP
-# define __ARCH_WANT_SYS_LLSEEK
 # define __ARCH_WANT_SYS_NICE
 # define __ARCH_WANT_SYS_OLDUMOUNT
 # define __ARCH_WANT_SYS_OLD_GETRLIMIT
diff --git a/arch/xtensa/include/asm/unistd.h b/arch/xtensa/include/asm/unistd.h
index 0d532ab60b37..574e5520968c 100644
--- a/arch/xtensa/include/asm/unistd.h
+++ b/arch/xtensa/include/asm/unistd.h
@@ -8,7 +8,6 @@
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_UTIME
-#define __ARCH_WANT_SYS_LLSEEK
 #define __ARCH_WANT_SYS_GETPGRP
 
 /* 
diff --git a/fs/read_write.c b/fs/read_write.c
index 39b4a21dd933..e892e409386b 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -331,7 +331,7 @@ COMPAT_SYSCALL_DEFINE3(lseek, unsigned int, fd, compat_off_t, offset, unsigned i
 }
 #endif
 
-#ifdef __ARCH_WANT_SYS_LLSEEK
+#if !defined(CONFIG_64BIT) || defined(CONFIG_COMPAT)
 SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
 		unsigned long, offset_low, loff_t __user *, result,
 		unsigned int, whence)
diff --git a/include/asm-generic/unistd.h b/include/asm-generic/unistd.h
index ea74eca8463f..71d2fcf9dbcd 100644
--- a/include/asm-generic/unistd.h
+++ b/include/asm-generic/unistd.h
@@ -1,12 +1,3 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <uapi/asm-generic/unistd.h>
 #include <linux/export.h>
-
-/*
- * These are required system calls, we should
- * invert the logic eventually and let them
- * be selected by default.
- */
-#if __BITS_PER_LONG == 32
-#define __ARCH_WANT_SYS_LLSEEK
-#endif
-- 
2.18.0

