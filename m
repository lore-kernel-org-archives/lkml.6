Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E048C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A214D20835
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EA76+bax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A214D20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeHaVOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:14:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37529 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbeHaVOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:14:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so11833130wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 10:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1pjMpMqt8jlEJt8nuzTFm7eM0bz3iTpqtI30tsy6y74=;
        b=EA76+baxeVdkG2fM16eU3EHXKl+XPOs74P6HREXnRJ6Ge/R2cK1dYAqgIhXfw3y9lf
         lRMv/Wt+YZAhPuFWVoNjHf885H4CXRLdlFPaNv2qy09+ChRrv5dFqyt+5696STDUVRir
         iqloozoPKQ0bT4vSs4YToBrrDQcmXwdrKLQH0wqTZ1VgZsRZT8cfgiih1xlI/+cctOFy
         kqP9eZMTmhwg6Me+3xK52kgHbHUqbiFboMxYDo9iCDOpWcoz7WwsKHRTVf8LbY8XJpRP
         qwKB1U3s1oZr9Z5hFfkArT2xxsHMCnps5i/lORp4VpCoV7aRSSMhFOj7qfXug5NEuVZ7
         E4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1pjMpMqt8jlEJt8nuzTFm7eM0bz3iTpqtI30tsy6y74=;
        b=dARdXOgjbJXkrXvzggXTAt/Oh8yFWcs8QbURbwFnW5srdb7k1e0QPWeg1DCNrIcJ6V
         Q4Z7ZK78lfO8R3p6o4DBBrvhybP8r0l79AftJ9YRtAZq4CvrX936B0+SzmYC90jcjq1X
         NMUznoZq/WruLnftRllogobD58Q7VDoTe/zktusAPgzaAfGHNh7hPQYxjOm6sn1Q6LMD
         4BmPN9faTiwJBT8jmeD8JIsN5c+JCyM4XGLxPbmUxnTPSITskMWWx+PKu1ZvLj3LMRlr
         Df4aHvN36Qvvti5A9l1mxV/2Fj5KyhFSTEfpiiaQ0pkBdP0RdsfVeFRrw9Ejztns7ySC
         Wtmw==
X-Gm-Message-State: APzg51DkfIwMNXImgxzwl5OqlBR7QQ0t4wE/2B9ClajSwpCKiIFz3dBI
        wo7CqE+kXmECCZ5E28gteLPuWrdKKWc=
X-Google-Smtp-Source: ANB0VdaiUCjRL0ChUkEo86r/CfEEG4tYRO7E2pWsXtq20J6YYZsyOg/YMMfYvTPjf+nxh8RZi9RoVg==
X-Received: by 2002:adf:90e9:: with SMTP id i96-v6mr11309402wri.146.1535735133184;
        Fri, 31 Aug 2018 10:05:33 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id c19-v6sm11280332wre.86.2018.08.31.10.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 10:05:32 -0700 (PDT)
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
Subject: [PATCH 7/7] Compiler Attributes: use feature checks instead of version checks
Date:   Fri, 31 Aug 2018 19:05:14 +0200
Message-Id: <20180831170514.24665-7-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using version checks per-compiler to define (or not)
each attribute, use __has_attribute to test for them, following
the cleanup started with commit 815f0ddb346c
("include/linux/compiler*.h: make compiler-*.h mutually exclusive").

All the attributes that are fairly common/standard (i.e. those that
do not require extra logic to define them) have been moved
to a new file include/linux/compiler_attributes.h.

In an effort to make the file as regular as possible, comments
stating the purpose of attributes have been removed. Instead,
links to the compiler docs have been added (i.e. to gcc and,
if available, to clang as well). In addition, they have been sorted.

Finally, if an attribute is optional (i.e. if it is guarded
by __has_attribute), the reason has been stated for future reference.

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
 include/linux/compiler-clang.h      |   4 -
 include/linux/compiler-gcc.h        |  51 -------
 include/linux/compiler-intel.h      |   6 -
 include/linux/compiler_attributes.h | 226 ++++++++++++++++++++++++++++
 include/linux/compiler_types.h      |  72 +--------
 5 files changed, 232 insertions(+), 127 deletions(-)
 create mode 100644 include/linux/compiler_attributes.h

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 0aee694d3ab8..3e7dafb3ea80 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -21,8 +21,6 @@
 #define __SANITIZE_ADDRESS__
 #endif
 
-#define __no_sanitize_address __attribute__((no_sanitize("address")))
-
 /*
  * Not all versions of clang implement the the type-generic versions
  * of the builtin overflow checkers. Fortunately, clang implements
@@ -41,5 +39,3 @@
  * compilers, like ICC.
  */
 #define barrier() __asm__ __volatile__("" : : : "memory")
-#define __assume_aligned(a, ...)	\
-	__attribute__((assume_aligned(a, ## __VA_ARGS__)))
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 32e6ce06163f..627fa8941436 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -116,9 +116,6 @@
 		__builtin_unreachable();	\
 	} while (0)
 
-/* Mark a function definition as prohibited from being cloned. */
-#define __noclone	__attribute__((noclone, optimize("no-tracer")))
-
 #if defined(RANDSTRUCT_PLUGIN) && !defined(__CHECKER__)
 #define __randomize_layout __attribute__((randomize_layout))
 #define __no_randomize_layout __attribute__((no_randomize_layout))
@@ -127,32 +124,6 @@
 #define randomized_struct_fields_end	} __randomize_layout;
 #endif
 
-/*
- * When used with Link Time Optimization, gcc can optimize away C functions or
- * variables which are referenced only from assembly code.  __visible tells the
- * optimizer that something else uses this function or variable, thus preventing
- * this.
- */
-#define __visible	__attribute__((externally_visible))
-
-/* gcc version specific checks */
-
-#if GCC_VERSION >= 40900
-/*
- * __assume_aligned(n, k): Tell the optimizer that the returned
- * pointer can be assumed to be k modulo n. The second argument is
- * optional (default 0), so we use a variadic macro to make the
- * shorthand.
- *
- * Beware: Do not apply this to functions which may return
- * ERR_PTRs. Also, it is probably unwise to apply it to functions
- * returning extra information in the low bits (but in that case the
- * compiler should see some alignment anyway, when the return value is
- * massaged by 'flags = ptr & 3; ptr &= ~3;').
- */
-#define __assume_aligned(a, ...) __attribute__((assume_aligned(a, ## __VA_ARGS__)))
-#endif
-
 /*
  * GCC 'asm goto' miscompiles certain code sequences:
  *
@@ -184,32 +155,10 @@
 #define KASAN_ABI_VERSION 3
 #endif
 
-#if GCC_VERSION >= 40902
-/*
- * Tell the compiler that address safety instrumentation (KASAN)
- * should not be applied to that function.
- * Conflicts with inlining: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
- */
-#define __no_sanitize_address __attribute__((no_sanitize_address))
-#endif
-
 #if GCC_VERSION >= 50100
-/*
- * Mark structures as requiring designated initializers.
- * https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html
- */
-#define __designated_init __attribute__((designated_init))
 #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
 #endif
 
-#if !defined(__noclone)
-#define __noclone	/* not needed */
-#endif
-
-#if !defined(__no_sanitize_address)
-#define __no_sanitize_address
-#endif
-
 /*
  * Turn individual warnings and errors on and off locally, depending
  * on version.
diff --git a/include/linux/compiler-intel.h b/include/linux/compiler-intel.h
index 18bd4362deaa..517bd14e1222 100644
--- a/include/linux/compiler-intel.h
+++ b/include/linux/compiler-intel.h
@@ -34,9 +34,3 @@
 /* icc has this, but it's called _bswap16 */
 #define __HAVE_BUILTIN_BSWAP16__
 #define __builtin_bswap16 _bswap16
-
-/* The following are for compatibility with GCC, from compiler-gcc.h,
- * and may be redefined here because they should not be shared with other
- * compilers, like clang.
- */
-#define __visible	__attribute__((externally_visible))
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
new file mode 100644
index 000000000000..a9dfafc8fd19
--- /dev/null
+++ b/include/linux/compiler_attributes.h
@@ -0,0 +1,226 @@
+#ifndef __LINUX_COMPILER_ATTRIBUTES_H
+#define __LINUX_COMPILER_ATTRIBUTES_H
+
+/*
+ * This file is meant to be sorted (by actual attribute name,
+ * not by #define identifier).
+ *
+ * Do not add here attributes which depend on others or require extra logic.
+ *
+ * If an attribute is optional, state the reason in the comment.
+ */
+
+/*
+ * To check for optional attributes, we use __has_attribute, which is supported
+ * on gcc >= 5, clang >= 2.9 and icc >= 17. In the meantime, to support
+ * 4.6 <= gcc < 5, we implement __has_attribute by hand.
+ */
+#ifndef __has_attribute
+#define __has_attribute(x) __GCC4_has_attribute_##x
+#define __GCC4_has_attribute_externally_visible 1
+#define __GCC4_has_attribute_noclone 1
+#define __GCC4_has_attribute_optimize 1
+#if __GNUC_MINOR__ >= 8
+#define __GCC4_has_attribute_no_sanitize_address 1
+#endif
+#if __GNUC_MINOR__ >= 9
+#define __GCC4_has_attribute_assume_aligned 1
+#endif
+#endif
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-alias-function-attribute
+ */
+#define __alias(symbol)         __attribute__((alias(#symbol)))
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-aligned-function-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-aligned-type-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-aligned-variable-attribute
+ */
+#define __aligned(x)            __attribute__((aligned(x)))
+#define __aligned_largest       __attribute__((aligned))
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-always_005finline-function-attribute
+ * clang: mentioned but no proper documentation
+ */
+#define __always_inline         inline __attribute__((always_inline))
+
+/*
+ * The second argument is optional (default 0), so we use a variadic macro
+ * to make the shorthand.
+ *
+ * Beware: Do not apply this to functions which may return
+ * ERR_PTRs. Also, it is probably unwise to apply it to functions
+ * returning extra information in the low bits (but in that case the
+ * compiler should see some alignment anyway, when the return value is
+ * massaged by 'flags = ptr & 3; ptr &= ~3;').
+ *
+ * Optional: only supported since gcc >= 4.9
+ * Optional: not supported by icc
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-assume_005faligned-function-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#assume-aligned
+ */
+#if __has_attribute(assume_aligned)
+#define __assume_aligned(a, ...) __attribute__((assume_aligned(a, ## __VA_ARGS__)))
+#else
+#define __assume_aligned(a, ...)
+#endif
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-cold-function-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Label-Attributes.html#index-cold-label-attribute
+ */
+#define __cold                  __attribute__((cold))
+
+/*
+ * Note the long name.
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-const-function-attribute
+ */
+#define __attribute_const__     __attribute__((const))
+
+/*
+ * Don't. Just don't. See commit 771c035372a0 ("deprecate the '__deprecated'
+ * attribute warnings entirely and for good") for more information.
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-deprecated-function-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-deprecated-type-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-deprecated-variable-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Enumerator-Attributes.html#index-deprecated-enumerator-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#deprecated
+ */
+#define __deprecated
+
+/*
+ * Optional: only supported since gcc >= 5.1
+ * Optional: not supported by clang
+ * Optional: not supported by icc
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-designated_005finit-type-attribute
+ */
+#if __has_attribute(designated_init)
+#define __designated_init       __attribute__((designated_init))
+#else
+#define __designated_init
+#endif
+
+/*
+ * Optional: not supported by clang
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-externally_005fvisible-function-attribute
+ */
+#if __has_attribute(externally_visible)
+#define __visible               __attribute__((externally_visible))
+#else
+#define __visible
+#endif
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-format-function-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#format
+ */
+#define __printf(a, b)          __attribute__((format(printf, a, b)))
+#define __scanf(a, b)           __attribute__((format(scanf, a, b)))
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-gnu_005finline-function-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#gnu-inline
+ */
+#define __gnu_inline            __attribute__((gnu_inline))
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-malloc-function-attribute
+ */
+#define __malloc                __attribute__((malloc))
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-mode-type-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-mode-variable-attribute
+ */
+#define __mode(x)               __attribute__((mode(x)))
+
+/*
+ * Optional: not supported by clang
+ * Note: icc does not recognize gcc's no-tracer
+ *
+ *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-noclone-function-attribute
+ *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-optimize-function-attribute
+ */
+#if __has_attribute(noclone) && __has_attribute(optimize)
+#define __noclone               __attribute__((noclone, optimize("no-tracer")))
+#else
+#define __noclone
+#endif
+
+/*
+ * Note the missing underscores.
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-noinline-function-attribute
+ * clang: mentioned but no proper documentation
+ */
+#define   noinline              __attribute__((noinline))
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-noreturn-function-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#noreturn
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#id1
+ */
+#define __noreturn              __attribute__((noreturn))
+
+/*
+ * Optional: only supported since gcc >= 4.8
+ * Optional: not supported by icc
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-no_005fsanitize_005faddress-function-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#no-sanitize-address-no-address-safety-analysis
+ */
+#if __has_attribute(no_sanitize_address)
+#define __no_sanitize_address   __attribute__((no_sanitize_address))
+#else
+#define __no_sanitize_address
+#endif
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-packed-type-attribute
+ * clang: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-packed-variable-attribute
+ */
+#define __packed                __attribute__((packed))
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-pure-function-attribute
+ */
+#define __pure                  __attribute__((pure))
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-section-function-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-section-variable-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#section-declspec-allocate
+ */
+#define __section(S)            __attribute__((section(#S)))
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-unused-function-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-unused-type-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-unused-variable-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Label-Attributes.html#index-unused-label-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#maybe-unused-unused
+ */
+#define __always_unused         __attribute__((unused))
+#define __maybe_unused          __attribute__((unused))
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-used-function-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-used-variable-attribute
+ */
+#define __used                  __attribute__((used))
+
+/*
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-weak-function-attribute
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-weak-variable-attribute
+ */
+#define __weak                  __attribute__((weak))
+
+#endif /* __LINUX_COMPILER_ATTRIBUTES_H */
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 5dddc7e0c607..f1e658433323 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -54,6 +54,9 @@ extern void __chk_io_ptr(const volatile void __iomem *);
 
 #ifdef __KERNEL__
 
+/* Attributes */
+#include <linux/compiler_attributes.h>
+
 /* Compiler specific macros. */
 #ifdef __clang__
 #include <linux/compiler-clang.h>
@@ -78,12 +81,6 @@ extern void __chk_io_ptr(const volatile void __iomem *);
 #include <asm/compiler.h>
 #endif
 
-/*
- * Generic compiler-independent macros required for kernel
- * build go below this comment. Actual compiler/compiler version
- * specific implementations come from the above header files
- */
-
 struct ftrace_branch_data {
 	const char *func;
 	const char *file;
@@ -106,9 +103,6 @@ struct ftrace_likely_data {
 	unsigned long			constant;
 };
 
-/* Don't. Just don't. */
-#define __deprecated
-
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
@@ -118,10 +112,6 @@ struct ftrace_likely_data {
  * compilers. We don't consider that to be an error, so set them to nothing.
  * For example, some of them are for compiler specific plugins.
  */
-#ifndef __designated_init
-# define __designated_init
-#endif
-
 #ifndef __latent_entropy
 # define __latent_entropy
 #endif
@@ -139,17 +129,6 @@ struct ftrace_likely_data {
 # define randomized_struct_fields_end
 #endif
 
-#ifndef __visible
-#define __visible
-#endif
-
-/*
- * Assume alignment of return value.
- */
-#ifndef __assume_aligned
-#define __assume_aligned(a, ...)
-#endif
-
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
 
@@ -158,10 +137,6 @@ struct ftrace_likely_data {
 	(sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
 	 sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
 
-#ifndef __noclone
-#define __noclone
-#endif
-
 /* Helpers for emitting diagnostics in pragmas. */
 #ifndef __diag
 #define __diag(string)
@@ -181,35 +156,6 @@ struct ftrace_likely_data {
 #define __diag_error(compiler, version, option, comment) \
 	__diag_ ## compiler(version, error, option)
 
-/*
- * From the GCC manual:
- *
- * Many functions have no effects except the return value and their
- * return value depends only on the parameters and/or global
- * variables.  Such a function can be subject to common subexpression
- * elimination and loop optimization just as an arithmetic operator
- * would be.
- * [...]
- */
-#define __pure			__attribute__((pure))
-#define __const			__attribute__((const))
-#define __aligned(x)		__attribute__((aligned(x)))
-#define __aligned_largest	__attribute__((aligned))
-#define __printf(a, b)		__attribute__((format(printf, a, b)))
-#define __scanf(a, b)		__attribute__((format(scanf, a, b)))
-#define __maybe_unused		__attribute__((unused))
-#define __always_unused		__attribute__((unused))
-#define __mode(x)		__attribute__((mode(x)))
-#define __malloc		__attribute__((malloc))
-#define __used			__attribute__((used))
-#define __noreturn		__attribute__((noreturn))
-#define __packed		__attribute__((packed))
-#define __weak			__attribute__((weak))
-#define __alias(symbol)		__attribute__((alias(#symbol)))
-#define __cold			__attribute__((cold))
-#define __section(S)		__attribute__((section(#S)))
-
-
 #ifdef CONFIG_ENABLE_MUST_CHECK
 #define __must_check		__attribute__((warn_unused_result))
 #else
@@ -224,8 +170,6 @@ struct ftrace_likely_data {
 
 #define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
 
-#define __gnu_inline	__attribute__((gnu_inline))
-
 /*
  * Force always-inline if the user requests it so via the .config.
  * GCC does not warn about unused static inline functions for
@@ -240,17 +184,13 @@ struct ftrace_likely_data {
  */
 #if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) || \
 	!defined(CONFIG_OPTIMIZE_INLINING)
-#define inline \
-	inline __attribute__((always_inline, unused)) notrace __gnu_inline
+#define inline __always_inline __gnu_inline __maybe_unused notrace
 #else
-#define inline inline	__attribute__((unused)) notrace __gnu_inline
+#define inline          inline __gnu_inline __maybe_unused notrace
 #endif
 
 #define __inline__ inline
-#define __inline inline
-#define noinline	__attribute__((noinline))
-
-#define __always_inline inline __attribute__((always_inline))
+#define __inline   inline
 
 /*
  * Rather then using noinline to prevent stack consumption, use
-- 
2.17.1

