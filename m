Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8096C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1A020835
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alolM98W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1A020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeHaVNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:13:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33772 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbeHaVNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:13:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id v90-v6so11866925wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cjnPIVL8p+xBuSeO3oVTQvN3sYtqX4rNBY9aeGBgyII=;
        b=alolM98Wsnx1TLEZA2pVsA1yrq3W1r1vss9Fy40IwvXEJOw9Ah2dCt6gVaMhOtBS6o
         ksKtBFqpXarb8iSJRt6unEwN4IVTf57uGBxAUgSqGX73hgNX05cyWqJbiGoo2xS6Dmjg
         P6ZI5EpYfNesKyFDRm1JmpcT5QTxT0WmZwCATVs2M5NBZ36GRea8nhu6VW9p4Xt75vYP
         0xV6QLvqMPF7E/6WtoiT3JhnOT8OlA7wb/JE+2S6bwstqakVhyscprq12vhJTGouD+0r
         ye08Jtbsvfd3yWgxx5dqTElb3v5XIOzcQRp+G/vcFQrHq0DmpR0ShZeLkc2Yc12sfokm
         Jnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cjnPIVL8p+xBuSeO3oVTQvN3sYtqX4rNBY9aeGBgyII=;
        b=NCKGswFGHExGnxGXJC8VA+gc+cz9+70n3mS/8QUR0vY8oabbuFNv5o2kc9wizVLO/s
         EhTjwB7SEBQ92DgGzVKbCJHDJR9Q/58hf+rCPxHZs9nkFE9csJbJlq13SBPxu+hdfA+J
         EPd1zzJf6oDEpZUDLNMPGIc7bfQBOO/nJbSY80SL2DhLLQ2JfUl2kNz3e1RJc9Xrt7Hi
         yimDhB182oP/HXViATPDKY22XIWF6f9ZeLlaaCpNmdY9dPwSIeXW/GGQIV8cund9WbsU
         QIWjUnPOLd/qJx2d39IL+NTHj5VfkTJG5JJOFI2IA3SOmR9mfyXBCTGLWrMB5lzXR3dn
         kowg==
X-Gm-Message-State: APzg51CNyPcR0+fd5ySn2I2dzbN4E5TVaJkfv+2pN3yzfu/r7IJr0DFY
        so0bSJmTm3JkQM7WUia+VA8=
X-Google-Smtp-Source: ANB0VdawyP5EbZXV/V8MCkhsPW0m5ajiACCjZaHc8oicbzsZfr1gGgHd9YMxj1wpt+jBhOlUJIDLdQ==
X-Received: by 2002:adf:f5c9:: with SMTP id k9-v6mr11494094wrp.59.1535735127278;
        Fri, 31 Aug 2018 10:05:27 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id c19-v6sm11280332wre.86.2018.08.31.10.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 10:05:26 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4/7] Compiler Attributes: homogenize __must_be_array
Date:   Fri, 31 Aug 2018 19:05:11 +0200
Message-Id: <20180831170514.24665-4-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different definitions of __must_be_array:

  * gcc: disabled for __CHECKER__

  * clang: same definition as gcc's, but without __CHECKER__

  * intel: the comment claims __builtin_types_compatible_p()
    is unsupported; but icc seems to support it since 13.0.1
    (released in 2012). See https://godbolt.org/z/S0l6QQ

Therefore, we can remove all of them and have a single definition
in compiler.h

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
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler-clang.h | 1 -
 include/linux/compiler-gcc.h   | 7 -------
 include/linux/compiler-intel.h | 3 ---
 include/linux/compiler.h       | 7 +++++++
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index efda74f4eeba..0aee694d3ab8 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -41,6 +41,5 @@
  * compilers, like ICC.
  */
 #define barrier() __asm__ __volatile__("" : : : "memory")
-#define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 #define __assume_aligned(a, ...)	\
 	__attribute__((assume_aligned(a, ## __VA_ARGS__)))
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index dbfbecf703f8..66e1eb8822d9 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -68,13 +68,6 @@
  */
 #define uninitialized_var(x) x = x
 
-#ifdef __CHECKER__
-#define __must_be_array(a)	0
-#else
-/* &a[0] degrades to a pointer: a different type from an array */
-#define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
-#endif
-
 #ifdef RETPOLINE
 #define __noretpoline __attribute__((indirect_branch("keep")))
 #endif
diff --git a/include/linux/compiler-intel.h b/include/linux/compiler-intel.h
index 4c7f9befa9f6..18bd4362deaa 100644
--- a/include/linux/compiler-intel.h
+++ b/include/linux/compiler-intel.h
@@ -29,9 +29,6 @@
  */
 #define OPTIMIZER_HIDE_VAR(var) barrier()
 
-/* Intel ECC compiler doesn't support __builtin_types_compatible_p() */
-#define __must_be_array(a) 0
-
 #endif
 
 /* icc has this, but it's called _bswap16 */
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index e0e55eb3f242..e4a702f99e50 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -357,4 +357,11 @@ static inline void *offset_to_ptr(const int *off)
 	compiletime_assert(__native_word(t),				\
 		"Need native word sized stores/loads for atomicity.")
 
+#ifdef __CHECKER__
+#define __must_be_array(a)	0
+#else
+/* &a[0] degrades to a pointer: a different type from an array */
+#define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
+#endif
+
 #endif /* __LINUX_COMPILER_H */
-- 
2.17.1

