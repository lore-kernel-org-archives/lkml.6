Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F41ECE567
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EE121534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7ExAC7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EE121534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388089AbeITXII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:08:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52804 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387922AbeITXIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:08:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id y139-v6so328953wmc.2;
        Thu, 20 Sep 2018 10:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IOszDx0+PcEdvwwbT4AXK0NljevKHMGsY/DMk4sv7Dc=;
        b=K7ExAC7JSD0agyD0RvT0q8cXvC6yEwbBU5+ykXIOb+fSS5+GmbFI8qRKBnHHSAl6Gz
         LH3upOYhlPJeSLNliTYbPHhZUHarvUr1rYsDeI+YOEKfm+hDl6C4EiqHHv4Pqr+IC5P9
         ZFjAA4ms4dmAtT63dhBSRPskues4ak2YKbXgm+QMfHpgLeYYWhN/XVkxhkv7ooJ37oKV
         ok6F/EqrChPWLciCEcTBk4eEGBCks5zxt1KxTsKsmFPE4xEFqsOSAhsO2JTH4cuEkDpt
         dbKkAlVdnS6WZBY3/tXTowYfLrt2tRRIeqk6ZzMZonfmidOO3LZgagDGG/9x7Vb+S75j
         mHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IOszDx0+PcEdvwwbT4AXK0NljevKHMGsY/DMk4sv7Dc=;
        b=kYN5RSQ6hm2hu1GdqPOBLOBi+9y5yRrHpTXI1sPM7+/T/P3kTpFnG6hgvL9zveCTI1
         h995R05Y1nO0yvQHHHJIA6F8J0X4v7N+t1C9Nm+hX53WQ8E/99j9g4GVkcN4aNBgdY+V
         gGfOJKexi2wxTnMtSNTjB+eTk+1V5rBPiqEe3Umlr5PDdnY+NZnOc+x6o0vRCOfG2P1W
         rkMaPI9Nn8vO7nFgZKGrqjsE5QoV00ZqKQ6R9XIFYhhaK439bHpFOhvWwCQ3M3mTjT3P
         HMed/8AbF0T/63gZRyRwNaRPsxnWfabOyBd8guo0WEIddKs8omp8/duNCK7Oe8EQf8TY
         YVqw==
X-Gm-Message-State: ABuFfohRiW0GSp0yE8utboljIX0AeOGWyCI+Ktz0bzHuw2Wg18WXCieU
        WagQFOfKZIJv6ug6Mtz8rCo=
X-Google-Smtp-Source: ANB0Vdb0WqhZt4aUrTspa42pbi+ObXTn9IKpRijP7VwTjnBd6NAs91VztZMiHDdieffha3eC4IK52A==
X-Received: by 2002:a1c:c3:: with SMTP id 186-v6mr3949415wma.126.1537464215294;
        Thu, 20 Sep 2018 10:23:35 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id q200-v6sm3466562wmd.2.2018.09.20.10.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:23:34 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Theodore Ts'o <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH v5 05/15] Compiler Attributes: remove unneeded sparse (__CHECKER__) tests
Date:   Thu, 20 Sep 2018 19:22:51 +0200
Message-Id: <20180920172301.21868-6-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse knows about a few more attributes now, so we can remove
the __CHECKER__ conditions from them (which, in turn, allow us
to move some of them later on to compiler_attributes.h).

  * assume_aligned: since sparse's commit ffc860b ("sparse:
    ignore __assume_aligned__ attribute"), included in 0.5.1

  * error: since sparse's commit 0a04210 ("sparse: Add 'error'
    to ignored attributes"), included in 0.5.0

  * hotpatch: since sparse's commit 6043210 ("sparse/parse.c:
    ignore hotpatch attribute"), included in 0.5.1

  * warning: since sparse's commit 977365d ("Avoid "attribute
    'warning': unknown attribute" warning"), included in 0.4.2

On top of that, __must_be_array does not need it either because:

  * Even ancient versions of sparse do not have a problem

  * BUILD_BUG_ON_ZERO() is currently disabled for __CHECKER__

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler-gcc.h   | 6 ++----
 include/linux/compiler.h       | 4 ----
 include/linux/compiler_types.h | 2 +-
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 3b32bbfa5a49..1ca6a51cfaa9 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -76,14 +76,12 @@
 
 #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
 
-#ifndef __CHECKER__
 #define __compiletime_warning(message) __attribute__((__warning__(message)))
 #define __compiletime_error(message) __attribute__((__error__(message)))
 
-#ifdef LATENT_ENTROPY_PLUGIN
+#if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
 #define __latent_entropy __attribute__((latent_entropy))
 #endif
-#endif /* __CHECKER__ */
 
 /*
  * calling noreturn functions, __builtin_unreachable() and __builtin_trap()
@@ -131,7 +129,7 @@
 
 /* gcc version specific checks */
 
-#if GCC_VERSION >= 40900 && !defined(__CHECKER__)
+#if GCC_VERSION >= 40900
 /*
  * __assume_aligned(n, k): Tell the optimizer that the returned
  * pointer can be assumed to be k modulo n. The second argument is
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 165b1d5683ed..4030a2940d6b 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -357,11 +357,7 @@ static inline void *offset_to_ptr(const int *off)
 	compiletime_assert(__native_word(t),				\
 		"Need native word sized stores/loads for atomicity.")
 
-#ifdef __CHECKER__
-#define __must_be_array(a)	0
-#else
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
-#endif
 
 #endif /* __LINUX_COMPILER_H */
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 5ff9cda893f4..a3eceb3ad1b3 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -218,7 +218,7 @@ struct ftrace_likely_data {
 #define __must_check
 #endif
 
-#if defined(CC_USING_HOTPATCH) && !defined(__CHECKER__)
+#if defined(CC_USING_HOTPATCH)
 #define notrace			__attribute__((hotpatch(0, 0)))
 #else
 #define notrace			__attribute__((__no_instrument_function__))
-- 
2.17.1

