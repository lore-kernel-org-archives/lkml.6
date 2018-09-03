Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4041FC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACFD2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNVNqqKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACFD2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbeIDAzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:55:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35901 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbeIDAzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:55:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id m27-v6so1780964wrf.3;
        Mon, 03 Sep 2018 13:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+B+9bm1THTOeBY7olqboSx+3ofE8Jtp1C0MIwvpUxT4=;
        b=hNVNqqKGEpV7IIiybj5escRX0NUAk2HKivO21i7TVFypVICPGLMOgDgnITakCxT0nE
         TThZFKdJk+OjIeO1aJE0a6xzWIU1HSSuRqoX13KDMyecRXHxbVomImJg6Z0vaW9FXhcz
         K+oHj4vuQOCCYYr7lMGWnHy8FP3tC4oO2wngJ2dLzwGUOCO5zT/d936/1eeLrRXhy1e4
         Wfmqp00oLO2Wo/oCfIzLNEaLQFeeQbevlxwPkjIud0jAdyjFxuF/O1d+kbEFgfvcLW1c
         //LCMJzoSS42IIE0qElLlxUkJ9sRHNy5HZ/kfMcDBgQP9YILRadbBDdU/tt9e5YfCnRw
         nWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+B+9bm1THTOeBY7olqboSx+3ofE8Jtp1C0MIwvpUxT4=;
        b=XMq21c7S+jArKixdjlQvyROR313pX2BdqfrHudgtl4Oi7dBxfsNl2fSnwVsZCxp7KQ
         0zRud/M4u13of5ALiEw2lutqL69ktarqbOuLXcHVA/lSYlNcoMOSAnaJ/FkjwvNhc2ru
         HnP4rqEfI92D76AR343DCEspo4uG4K3nQq+ktiMGpxQ3xG0wyK27Z0huJdRZayq0kxRd
         ZIR7kn2T5p1csCTLrBxubohIDw6vRKdt6JKI8UYfbpiZTBKGZkH8khD+68ESvisdTnQq
         KYxVXx7Vsj3Qpa6XLoS9MFXqTqNbUJvfUlEnqXbuWxyY63MxSHMZnp+GzdFGOprMLWUJ
         WHGA==
X-Gm-Message-State: APzg51DIA5P6IMtNbYhfGhffEZHxCpy60mWQtHWbz7acFGfJc3R8Dz0I
        lAAc5rfeqdB/sqBXtoRgklE=
X-Google-Smtp-Source: ANB0Vdbv4HAkRKanQ/bhDWSwjMyyCCnISGbNh4r32Rsqe5H9bksxp2BQS8Q4rcbj3BeERw4mCXRxQg==
X-Received: by 2002:a5d:5450:: with SMTP id w16-v6mr21575181wrv.4.1536006835354;
        Mon, 03 Sep 2018 13:33:55 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id 132-v6sm12354870wmd.13.2018.09.03.13.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 13:33:54 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-sparse@vger.kernel.org
Subject: [PATCH 06/12] Compiler Attributes: naked can be shared
Date:   Mon,  3 Sep 2018 22:33:10 +0200
Message-Id: <20180903203316.16183-7-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
References: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The naked attribute is supported by at least gcc >= 4.6 (for ARM,
which is the only current user), gcc >= 8 (for x86), clang >= 3.1
and icc >= 13. See https://godbolt.org/z/350Dyc

Therefore, move it out of compiler-gcc.h so that the definition
is shared by all compilers.

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Eli Friedman <efriedma@codeaurora.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler-gcc.h   | 8 --------
 include/linux/compiler_types.h | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 4cd5e9264bce..3b32bbfa5a49 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -72,14 +72,6 @@
 #define __noretpoline __attribute__((__indirect_branch__("keep")))
 #endif
 
-/*
- * it doesn't make sense on ARM (currently the only user of __naked)
- * to trace naked functions because then mcount is called without
- * stack and frame pointer being set up and there is no chance to
- * restore the lr register to the value before mcount was called.
- */
-#define __naked		__attribute__((__naked__)) notrace
-
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
 #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 759b3fea9216..f182f2ef3227 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -223,6 +223,14 @@ struct ftrace_likely_data {
 #define notrace			__attribute__((__no_instrument_function__))
 #endif
 
+/*
+ * it doesn't make sense on ARM (currently the only user of __naked)
+ * to trace naked functions because then mcount is called without
+ * stack and frame pointer being set up and there is no chance to
+ * restore the lr register to the value before mcount was called.
+ */
+#define __naked			__attribute__((__naked__)) notrace
+
 #define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
 
 /*
-- 
2.17.1

