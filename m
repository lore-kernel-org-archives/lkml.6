Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A13C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C678321508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W94IRGVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C678321508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbeIRWa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:30:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38702 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730153AbeIRWaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:30:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id t25-v6so3655445wmi.3;
        Tue, 18 Sep 2018 09:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9HtIKUpVKYxgznAebLhJ+GTOb81tqMTVvVX/aOyPgJU=;
        b=W94IRGVMKzgYITGNEWaWIXx6cBAOpYNHEi1tERfPeiC1dsFbsimPIvlRocTsUjM8CF
         7xN0FpuGCkY0SKBxWKWzpUkRzVvoyyWZ8nV3VR2BZ30+QCnhVnsJtRthha7Kcjum+825
         YB3YtMd2PvGcFnItxcuQO052n0y6nKtt+Wy2MPf7ixZPpJNTIGm1Md+6m1xs+WuS91un
         y0usYT5HmU3pbjYjug3sGQDaYSaKhBmGgyyNKaR+sxAKutR3otYERoVnw3Y7xryoocem
         b8vO5/puabt2Hc9FfbJJ4EMVPnRoe/4hmpTtqCvuxOz79NT4CuoyxzpJUGHYBi9dF+Rn
         qpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9HtIKUpVKYxgznAebLhJ+GTOb81tqMTVvVX/aOyPgJU=;
        b=ovNARRQQymoim6i9j54jm7X5gQYRECvfnjy4ee21QfQyLxpSDEhXT/fq2L147/FQJ/
         oGhYfHTUVcq4nxOTih77XkqHkQxCn0UNaWCONQNZG2zan6h3VKq+rudK15uTzbk+ba/d
         0Fv2Ss5xdcQhg+K2K7EntI3UySnhPopojpQPXMaBBNRqSMyYHXRfCH7YM7+KqLT1p8NG
         fJv2h+vsvCmIKyb136EZ6RiMxHYID38f52crJkGwFNxco148OvMwUy+rFITZ70uFKCAS
         2kAzR/Q/0F5ZO/KMUxfs1KdaaZMN7rxdJyYfHQW3xRu2dTFXH2r1pKlnDX1APt2Pfskf
         YPZQ==
X-Gm-Message-State: APzg51AazECmcmpUl9wv3k+z3HVFf2Y9pyX9TA+TCQefD60yCoh7MBA9
        aLqadlkuTVuXP91KQJxjMB0=
X-Google-Smtp-Source: ANB0VdbfB5UI42Y64j1yTp9w65BWCbXOi0KrDjXcl/6Jymnr+wSIKu9a/YaJTFjHCj8OzPtn1L5HNQ==
X-Received: by 2002:a1c:b686:: with SMTP id g128-v6mr15236897wmf.83.1537289814078;
        Tue, 18 Sep 2018 09:56:54 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id g2-v6sm2934768wme.20.2018.09.18.09.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 09:56:53 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-sparse@vger.kernel.org
Subject: [PATCH v2 2/2] Compiler Attributes: naked can be shared
Date:   Tue, 18 Sep 2018 18:55:42 +0200
Message-Id: <20180918165542.4691-3-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The naked attribute is supported by at least gcc >= 4.6 (for ARM,
which is the only current user), gcc >= 8 (for x86), clang >= 3.1
and icc >= 13. See https://godbolt.org/z/350Dyc

Therefore, move it out of compiler-gcc.h so that the definition
is shared by all compilers.

This also fixes Clang support for ARM32 --- 815f0ddb346c
("include/linux/compiler*.h: make compiler-*.h mutually exclusive").

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Eli Friedman <efriedma@codeaurora.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler-gcc.h   | 8 --------
 include/linux/compiler_types.h | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 25d3dd6b2702..4d36b27214fd 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -79,14 +79,6 @@
 #define __noretpoline __attribute__((indirect_branch("keep")))
 #endif
 
-/*
- * it doesn't make sense on ARM (currently the only user of __naked)
- * to trace naked functions because then mcount is called without
- * stack and frame pointer being set up and there is no chance to
- * restore the lr register to the value before mcount was called.
- */
-#define __naked		__attribute__((naked)) notrace
-
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
 #define __optimize(level)	__attribute__((__optimize__(level)))
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 3525c179698c..db192becfec4 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -226,6 +226,14 @@ struct ftrace_likely_data {
 #define notrace			__attribute__((no_instrument_function))
 #endif
 
+/*
+ * it doesn't make sense on ARM (currently the only user of __naked)
+ * to trace naked functions because then mcount is called without
+ * stack and frame pointer being set up and there is no chance to
+ * restore the lr register to the value before mcount was called.
+ */
+#define __naked			__attribute__((naked)) notrace
+
 #define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
 
 /*
-- 
2.17.1

