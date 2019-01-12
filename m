Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1198EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DA92084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfALSbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:31:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36213 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfALSbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:31:43 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0CIUvPq1254424
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 12 Jan 2019 10:30:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0CIUu2P1254418;
        Sat, 12 Jan 2019 10:30:56 -0800
Date:   Sat, 12 Jan 2019 10:30:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rasmus Villemoes <tipbot@zytor.com>
Message-ID: <tip-88ca66d8540ca26119b1428cddb96b37925bdf01@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        bp@suse.de, x86@kernel.org, hpa@zytor.com, geert@linux-m68k.org,
        dan.j.williams@intel.com, mingo@redhat.com, willy@infradead.org
Reply-To: geert@linux-m68k.org, hpa@zytor.com, x86@kernel.org, bp@suse.de,
          willy@infradead.org, mingo@redhat.com, dan.j.williams@intel.com,
          linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
          peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20190111084931.24601-1-linux@rasmusvillemoes.dk>
References: <20190111084931.24601-1-linux@rasmusvillemoes.dk>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/asm: Remove dead __GNUC__ conditionals
Git-Commit-ID: 88ca66d8540ca26119b1428cddb96b37925bdf01
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  88ca66d8540ca26119b1428cddb96b37925bdf01
Gitweb:     https://git.kernel.org/tip/88ca66d8540ca26119b1428cddb96b37925bdf01
Author:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
AuthorDate: Fri, 11 Jan 2019 09:49:30 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 12 Jan 2019 17:50:48 +0100

x86/asm: Remove dead __GNUC__ conditionals

The minimum supported gcc version is >= 4.6, so these can be removed.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190111084931.24601-1-linux@rasmusvillemoes.dk
---
 arch/x86/include/asm/bitops.h    |  6 ------
 arch/x86/include/asm/string_32.h | 20 --------------------
 arch/x86/include/asm/string_64.h | 15 ---------------
 3 files changed, 41 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index ad7b210aa3f6..d153d570bb04 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -36,13 +36,7 @@
  * bit 0 is the LSB of addr; bit 32 is the LSB of (addr+1).
  */
 
-#if __GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ < 1)
-/* Technically wrong, but this avoids compilation errors on some gcc
-   versions. */
-#define BITOP_ADDR(x) "=m" (*(volatile long *) (x))
-#else
 #define BITOP_ADDR(x) "+m" (*(volatile long *) (x))
-#endif
 
 #define ADDR				BITOP_ADDR(addr)
 
diff --git a/arch/x86/include/asm/string_32.h b/arch/x86/include/asm/string_32.h
index 55d392c6bd29..2fd165f1cffa 100644
--- a/arch/x86/include/asm/string_32.h
+++ b/arch/x86/include/asm/string_32.h
@@ -179,14 +179,7 @@ static inline void *__memcpy3d(void *to, const void *from, size_t len)
  *	No 3D Now!
  */
 
-#if (__GNUC__ >= 4)
 #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
-#else
-#define memcpy(t, f, n)				\
-	(__builtin_constant_p((n))		\
-	 ? __constant_memcpy((t), (f), (n))	\
-	 : __memcpy((t), (f), (n)))
-#endif
 
 #endif
 #endif /* !CONFIG_FORTIFY_SOURCE */
@@ -282,12 +275,7 @@ void *__constant_c_and_count_memset(void *s, unsigned long pattern,
 
 	{
 		int d0, d1;
-#if __GNUC__ == 4 && __GNUC_MINOR__ == 0
-		/* Workaround for broken gcc 4.0 */
-		register unsigned long eax asm("%eax") = pattern;
-#else
 		unsigned long eax = pattern;
-#endif
 
 		switch (count % 4) {
 		case 0:
@@ -321,15 +309,7 @@ void *__constant_c_and_count_memset(void *s, unsigned long pattern,
 #define __HAVE_ARCH_MEMSET
 extern void *memset(void *, int, size_t);
 #ifndef CONFIG_FORTIFY_SOURCE
-#if (__GNUC__ >= 4)
 #define memset(s, c, count) __builtin_memset(s, c, count)
-#else
-#define memset(s, c, count)						\
-	(__builtin_constant_p(c)					\
-	 ? __constant_c_x_memset((s), (0x01010101UL * (unsigned char)(c)), \
-				 (count))				\
-	 : __memset((s), (c), (count)))
-#endif
 #endif /* !CONFIG_FORTIFY_SOURCE */
 
 #define __HAVE_ARCH_MEMSET16
diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 4e4194e21a09..75314c3dbe47 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -14,21 +14,6 @@
 extern void *memcpy(void *to, const void *from, size_t len);
 extern void *__memcpy(void *to, const void *from, size_t len);
 
-#ifndef CONFIG_FORTIFY_SOURCE
-#if (__GNUC__ == 4 && __GNUC_MINOR__ < 3) || __GNUC__ < 4
-#define memcpy(dst, src, len)					\
-({								\
-	size_t __len = (len);					\
-	void *__ret;						\
-	if (__builtin_constant_p(len) && __len >= 64)		\
-		__ret = __memcpy((dst), (src), __len);		\
-	else							\
-		__ret = __builtin_memcpy((dst), (src), __len);	\
-	__ret;							\
-})
-#endif
-#endif /* !CONFIG_FORTIFY_SOURCE */
-
 #define __HAVE_ARCH_MEMSET
 void *memset(void *s, int c, size_t n);
 void *__memset(void *s, int c, size_t n);
