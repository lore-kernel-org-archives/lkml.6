Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC76C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519C22086E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0HTF6R5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519C22086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeIICMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 22:12:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39238 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbeIICMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 22:12:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id s14-v6so9150989wrw.6;
        Sat, 08 Sep 2018 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=01rM1QtUoUf8J7p45IvdhY9Atu3kso7QHsx3BsqEdqk=;
        b=k0HTF6R5jpzWOQaz8bWvePFRbhtJnFqqQK9dpLFbYA6xIWgjZCWNOAfDhsaXSnjmZY
         bI3se4vxjfbLcpym/jkxMRi8RxZFjvs9/WyAzNXElGGj7BYIak/n/BTikqe+6kXVsDJK
         wi4W7lSzKd86jiB72wgB+iDMBgZUPha8pF0x+/08LHShmwLJeZqN6BG3qL/sbpreNrvs
         m102yp6Pyg+bdyscKAm7PV7VYW3p83e1Zc6+4KcTvjxW1gdaGXvsx8NxcXpKnRakPKTQ
         WDlZduzTKZ5ZbJVnhaODqgulDKf5erKUO7uCGr+w6pc/OAFW2mnl2K+avz69FJr3hPpk
         CISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=01rM1QtUoUf8J7p45IvdhY9Atu3kso7QHsx3BsqEdqk=;
        b=Qv/uvxjWjBZEgyPVZi16eDI8kFLK6zUxm9JWeYa0q8DyhtesqpKRyAF4JgJlWat8hV
         Qu6zzaIYEO0VQC9ZNIDJV1NG8gGYzbkB5FVzCY6PASgqTr/WqW2g0Vvz92GMXVxYaGE5
         83UPCtfgXIu+tptY39oDwLk6DoHBoWqxZIJG+DIic5sQ4BN3sZLOeJZXZ9EFD3ks+O3i
         itKwCosNrFib9L1HF8U0mpjj1sIgVfI1qf0Mu6IMoSRLljpBjJr3l8hrIwKhIU3eH7ew
         BU8eswaFX+6eHG8chukywkdc1MjqKIuQsdGyowqVl+xZE+orKhtoBkQFtfWw6C+0v2fn
         5oRg==
X-Gm-Message-State: APzg51CaEEo88BSIZI0YnsGriRIIjOecbSekzv1ec1a04GTS6wShutEs
        hrd1iJisTCJl+eFQfwY2eXY=
X-Google-Smtp-Source: ANB0VdYTegW6cea7bQ9Ijv7SO/T0+aDqqm5ZChX6lPIWAmiDxZhHa9vqzDjjBXCqBfaJ9XsLdiGUFg==
X-Received: by 2002:adf:f7c4:: with SMTP id a4-v6mr10531253wrq.86.1536441915355;
        Sat, 08 Sep 2018 14:25:15 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id u40-v6sm17340786wrc.43.2018.09.08.14.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 14:25:14 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-sparse@vger.kernel.org
Subject: [PATCH v4 03/13] Compiler Attributes: remove unneeded tests
Date:   Sat,  8 Sep 2018 23:24:49 +0200
Message-Id: <20180908212459.19736-4-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attributes const and always_inline have tests around them
which are unneeded, since they are supported by gcc >= 4.6,
clang >= 3 and icc >= 13. https://godbolt.org/z/DFPq37

In the case of gnu_inline, we do not need to test for
__GNUC_STDC_INLINE__ because, regardless of the current
inlining behavior, we can simply always force the old
GCC inlining behavior by using the attribute in all cases.

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Eli Friedman <efriedma@codeaurora.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler_types.h | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 2bc0f94df38e..83475515bc39 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -158,10 +158,6 @@ struct ftrace_likely_data {
 	(sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
 	 sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
 
-#ifndef __attribute_const__
-#define __attribute_const__	__attribute__((__const__))
-#endif
-
 #ifndef __noclone
 #define __noclone
 #endif
@@ -196,6 +192,7 @@ struct ftrace_likely_data {
  * [...]
  */
 #define __pure			__attribute__((__pure__))
+#define __attribute_const__	__attribute__((__const__))
 #define __aligned(x)		__attribute__((__aligned__(x)))
 #define __aligned_largest	__attribute__((__aligned__))
 #define __printf(a, b)		__attribute__((__format__(printf, a, b)))
@@ -211,6 +208,8 @@ struct ftrace_likely_data {
 #define __alias(symbol)		__attribute__((__alias__(#symbol)))
 #define __cold			__attribute__((__cold__))
 #define __section(S)		__attribute__((__section__(#S)))
+#define __always_inline		inline __attribute__((__always_inline__))
+#define __gnu_inline		__attribute__((__gnu_inline__))
 
 
 #ifdef CONFIG_ENABLE_MUST_CHECK
@@ -227,18 +226,6 @@ struct ftrace_likely_data {
 
 #define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
 
-/*
- * Feature detection for gnu_inline (gnu89 extern inline semantics). Either
- * __GNUC_STDC_INLINE__ is defined (not using gnu89 extern inline semantics,
- * and we opt in to the gnu89 semantics), or __GNUC_STDC_INLINE__ is not
- * defined so the gnu89 semantics are the default.
- */
-#ifdef __GNUC_STDC_INLINE__
-# define __gnu_inline	__attribute__((__gnu_inline__))
-#else
-# define __gnu_inline
-#endif
-
 /*
  * Force always-inline if the user requests it so via the .config.
  * GCC does not warn about unused static inline functions for
@@ -263,10 +250,6 @@ struct ftrace_likely_data {
 #define __inline inline
 #define noinline	__attribute__((__noinline__))
 
-#ifndef __always_inline
-#define __always_inline inline __attribute__((__always_inline__))
-#endif
-
 /*
  * Rather then using noinline to prevent stack consumption, use
  * noinline_for_stack instead.  For documentation reasons.
-- 
2.17.1

