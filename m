Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE43C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D008E2086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfALSbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:31:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46543 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfALSbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:31:43 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0CIVXQO1254471
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 12 Jan 2019 10:31:33 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0CIVXk31254468;
        Sat, 12 Jan 2019 10:31:33 -0800
Date:   Sat, 12 Jan 2019 10:31:33 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rasmus Villemoes <tipbot@zytor.com>
Message-ID: <tip-2e905c7abdcd5ff09b9df33d25eb7148c85bed2a@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, bp@suse.de, tglx@linutronix.de,
        linux@rasmusvillemoes.dk, mingo@kernel.org, x86@kernel.org,
        hpa@zytor.com, mingo@redhat.com
Reply-To: x86@kernel.org, linux@rasmusvillemoes.dk, mingo@kernel.org,
          mingo@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, bp@suse.de
In-Reply-To: <20190111084931.24601-2-linux@rasmusvillemoes.dk>
References: <20190111084931.24601-2-linux@rasmusvillemoes.dk>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/asm: Remove unused __constant_c_x_memset() macro
 and inlines
Git-Commit-ID: 2e905c7abdcd5ff09b9df33d25eb7148c85bed2a
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

Commit-ID:  2e905c7abdcd5ff09b9df33d25eb7148c85bed2a
Gitweb:     https://git.kernel.org/tip/2e905c7abdcd5ff09b9df33d25eb7148c85bed2a
Author:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
AuthorDate: Fri, 11 Jan 2019 09:49:31 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 12 Jan 2019 17:54:49 +0100

x86/asm: Remove unused __constant_c_x_memset() macro and inlines

Nothing refers to the __constant_c_x_memset() macro anymore. Remove
it and the two referenced static inline functions.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190111084931.24601-2-linux@rasmusvillemoes.dk
---
 arch/x86/include/asm/string_32.h | 84 ----------------------------------------
 1 file changed, 84 deletions(-)

diff --git a/arch/x86/include/asm/string_32.h b/arch/x86/include/asm/string_32.h
index 2fd165f1cffa..f74362b05619 100644
--- a/arch/x86/include/asm/string_32.h
+++ b/arch/x86/include/asm/string_32.h
@@ -209,29 +209,6 @@ static inline void *__memset_generic(void *s, char c, size_t count)
 /* we might want to write optimized versions of these later */
 #define __constant_count_memset(s, c, count) __memset_generic((s), (c), (count))
 
-/*
- * memset(x, 0, y) is a reasonably common thing to do, so we want to fill
- * things 32 bits at a time even when we don't know the size of the
- * area at compile-time..
- */
-static __always_inline
-void *__constant_c_memset(void *s, unsigned long c, size_t count)
-{
-	int d0, d1;
-	asm volatile("rep ; stosl\n\t"
-		     "testb $2,%b3\n\t"
-		     "je 1f\n\t"
-		     "stosw\n"
-		     "1:\ttestb $1,%b3\n\t"
-		     "je 2f\n\t"
-		     "stosb\n"
-		     "2:"
-		     : "=&c" (d0), "=&D" (d1)
-		     : "a" (c), "q" (count), "0" (count/4), "1" ((long)s)
-		     : "memory");
-	return s;
-}
-
 /* Added by Gertjan van Wingerde to make minix and sysv module work */
 #define __HAVE_ARCH_STRNLEN
 extern size_t strnlen(const char *s, size_t count);
@@ -240,67 +217,6 @@ extern size_t strnlen(const char *s, size_t count);
 #define __HAVE_ARCH_STRSTR
 extern char *strstr(const char *cs, const char *ct);
 
-/*
- * This looks horribly ugly, but the compiler can optimize it totally,
- * as we by now know that both pattern and count is constant..
- */
-static __always_inline
-void *__constant_c_and_count_memset(void *s, unsigned long pattern,
-				    size_t count)
-{
-	switch (count) {
-	case 0:
-		return s;
-	case 1:
-		*(unsigned char *)s = pattern & 0xff;
-		return s;
-	case 2:
-		*(unsigned short *)s = pattern & 0xffff;
-		return s;
-	case 3:
-		*(unsigned short *)s = pattern & 0xffff;
-		*((unsigned char *)s + 2) = pattern & 0xff;
-		return s;
-	case 4:
-		*(unsigned long *)s = pattern;
-		return s;
-	}
-
-#define COMMON(x)							\
-	asm volatile("rep ; stosl"					\
-		     x							\
-		     : "=&c" (d0), "=&D" (d1)				\
-		     : "a" (eax), "0" (count/4), "1" ((long)s)	\
-		     : "memory")
-
-	{
-		int d0, d1;
-		unsigned long eax = pattern;
-
-		switch (count % 4) {
-		case 0:
-			COMMON("");
-			return s;
-		case 1:
-			COMMON("\n\tstosb");
-			return s;
-		case 2:
-			COMMON("\n\tstosw");
-			return s;
-		default:
-			COMMON("\n\tstosw\n\tstosb");
-			return s;
-		}
-	}
-
-#undef COMMON
-}
-
-#define __constant_c_x_memset(s, c, count)			\
-	(__builtin_constant_p(count)				\
-	 ? __constant_c_and_count_memset((s), (c), (count))	\
-	 : __constant_c_memset((s), (c), (count)))
-
 #define __memset(s, c, count)				\
 	(__builtin_constant_p(count)			\
 	 ? __constant_count_memset((s), (c), (count))	\
