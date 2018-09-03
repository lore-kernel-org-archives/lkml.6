Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C4BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B748220869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3ZeJBUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B748220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbeIDAzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:55:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45527 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeIDAzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:55:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id 20-v6so1712696wrb.12;
        Mon, 03 Sep 2018 13:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DF6EgP2im+TL2Bj+0aBYVQPMWJB603xa+lUoFLMY8Fw=;
        b=N3ZeJBUUTuoGb3LLWWOs3VIwCM49YoDhwtHAGNM4msavD6YT9RCx33qsSpzbACBN6t
         KAzcIdLB61VIXGAtRyIgkTvFbO6ZSbHXG+JflQzL4jq+QnF2DrmGA9FhQ2W2aUTu7LEj
         vBLbmKCfRYXqGJljckX4235jYDM2YiWNtSRuG1MbXH0xD6O/bWxJKaoZFpgAcG4BiHv8
         GzZctzko2W14rXEkCQnEuV+apaxQRl+q70aMLCeoMH/IcLVNfJQmz3KAn/qS60yZA7Xz
         h0Tbz8L0kgUFxU8PKLF9SJ+n5G7+uNrVHk0P/LowPq9zuPk0UJdlDB90vla6i2qKI0Nq
         mvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DF6EgP2im+TL2Bj+0aBYVQPMWJB603xa+lUoFLMY8Fw=;
        b=aZAAn1/dOhuuGNrfwTUWDFLjjvEx0SWGro7yKYyqgd1JHY7j67/Sw/6A4Led9TSeXH
         GuF6Pu00hxRZ/Wh7neVJmzeUTMBWVtDTAJx0QEikkHG/DSL035ppZ91gjEGnbvP7mfwc
         mxfHH6Z/DQ+Fm/C7SiU2iC6/eCnyD8jxUmaPtzRYC2aw4ifshSMoWWFiV4187X9y+TSZ
         rK1lPpETYPTkm+zqSEbDEV1x/l4lLIFQ7AuHt9qBJQa738keQx7MX28f9Fi3qQUfJn82
         Hl8gOYdWmMi32WdAVx+vzahNF9KX2T36m5sjfalFwWCe35yiX7QfL3doNOXl4J9xUZ+g
         8hYA==
X-Gm-Message-State: APzg51Dd+0+sGOGaUK/NKBwNPMseAYhXTgXc3sQb3lcjth4MZgodxy29
        +Uqxj8afqpMuTQpoinl5+y4=
X-Google-Smtp-Source: ANB0VdajEQG88h/5EjDl4FcNGP04S1HHL2onUqoMdqD+iGOA3RZ5GBELkQxzB8t38HN9GQ9y/VH4Ow==
X-Received: by 2002:a5d:66d2:: with SMTP id k18-v6mr20496480wrw.154.1536006831167;
        Mon, 03 Sep 2018 13:33:51 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id 132-v6sm12354870wmd.13.2018.09.03.13.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 13:33:50 -0700 (PDT)
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
Subject: [PATCH 03/12] Compiler Attributes: remove unneeded tests
Date:   Mon,  3 Sep 2018 22:33:07 +0200
Message-Id: <20180903203316.16183-4-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
References: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
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
 include/linux/compiler_types.h | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 2bc0f94df38e..759b3fea9216 100644
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
@@ -211,7 +208,8 @@ struct ftrace_likely_data {
 #define __alias(symbol)		__attribute__((__alias__(#symbol)))
 #define __cold			__attribute__((__cold__))
 #define __section(S)		__attribute__((__section__(#S)))
-
+#define __gnu_inline		__attribute__((__gnu_inline__))
+#define __always_inline		inline __attribute__((__always_inline__))
 
 #ifdef CONFIG_ENABLE_MUST_CHECK
 #define __must_check		__attribute__((__warn_unused_result__))
@@ -227,18 +225,6 @@ struct ftrace_likely_data {
 
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
@@ -263,10 +249,6 @@ struct ftrace_likely_data {
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

