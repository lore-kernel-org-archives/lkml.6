Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA18C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3482087C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwFbsl/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3482087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeHZVlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 17:41:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33112 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeHZVlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 17:41:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id i134-v6so8280505wmf.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 10:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GlvEQsInJiSz3vHuMCloJBJqaoj09VSHKTDM/1Twb2s=;
        b=YwFbsl/XKyLzsbVKyNokJD35d3M5AG1iL/wbFsp/Pt9xKG8d979H91X+KyoHg07FX2
         5hEkmKgv0owb1AgGmE8kJALadzxT3MRqNlNAKcBPKYQWkrd/UyKBM53pL4KQRjxWYWAZ
         14ZZlKkAVd2aOE45qKxpzHDQLrSxVVh9C6jBhkK4/b0TfUuFkUaHBpsUh/oE0JqMTQJP
         jvgNs50hEnKBWDvlKwA0w6QOVzVM8IdPQc/0cup/ngGEGP1xQqA5/U4UpCZ0J3eg5riu
         i7BLWy3EKPUweo/hMXrb7HqgArnSZw6jfXzCqKC0HtUHtdXyYQar9jyx3ww39rZAcadp
         QRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GlvEQsInJiSz3vHuMCloJBJqaoj09VSHKTDM/1Twb2s=;
        b=DL8KAe917FmZ/iP4DOoE53HJhEu3UyZAqz167O2iYc1JkL8HBO1In/Rqcm/aV1e8Yw
         RA/eAM58JPp3mzpot3eCtPRS6F9tVnf5dohqWaJoEZOGbp5jnUZW1YKU3S3CoRFWI5td
         kYhmHcV0ZafsVYs08/ZBiFv2LhenKf+y4Scfxr6vGsf1a9kWtE54A6cAqYZXB8dff5C9
         hbKDNMuFtu5RClkvDNzgIT3aTABhl5uVXGDGm7fcR8XpWJdvxF+rp1iVjuJWKVGql3Wb
         ChngXq68n6OLpT1nUbQYylW7KYemvOQd8kwDI664h/p+cs1oqRxTCIe4EisqKIDPbCuo
         qd2w==
X-Gm-Message-State: APzg51DthcMPRTfkadf4wUKiZUohebwLcDHSBomkfzzGCEiiFBoDapAn
        e8M8U5dIjNhVuKz4nHdQf3U=
X-Google-Smtp-Source: ANB0Vda0JLj6z4T2SOj1Ch4SJhxbEDuN2LT0O7XC5QDAKmf338otTu+pqyzmTBBULJY4X0dyWg/oWw==
X-Received: by 2002:a1c:7711:: with SMTP id t17-v6mr3826345wmi.35.1535306281640;
        Sun, 26 Aug 2018 10:58:01 -0700 (PDT)
Received: from gmail.com (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id j44-v6sm21399059wre.40.2018.08.26.10.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Aug 2018 10:58:00 -0700 (PDT)
Date:   Sun, 26 Aug 2018 19:57:48 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] include/linux/compiler*.h: Use feature checking instead of
 version checks for attributes
Message-ID: <20180826175748.GA29525@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using version checks per-compiler to define (or not) each attribute,
use __has_attribute to test for them, following the cleanup started with
commit 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive").

All the attributes that are fairly common/standard (i.e. those that do not
require extra logic to define them) have been moved to a new file
include/linux/compiler_attributes.h. The attributes have been sorted
and divided between "required" and "optional".

Further, attributes that are already supported in gcc >= 4.6 and recent clang
were simply made to be required (instead of testing for them):
  * always_inline
  * const (pure was already "required", by the way)
  * gnu_inline

Finally, some other bits were cleaned up in the process:
  * __optimize: removed (unused in the whole kernel tree)
  * __must_be_array: removed from -gcc and -clang (identical), moved to _types
    (it depends on the unconditionally used  __builtin_types_compatible_p
  * Removes unneeded underscores on the attributes' names

There are some things that can be further cleaned up afterwards:
  * __attribute_const__: rename to __const
  * __noretpoline: avoid checking for defined(__notrepoline)
  * __compiletime_warning/error: they are in two different places,
    -gcc and compiler.h.
  * sparse' attributes could potentially go into the end of attributes.h
    too (as another separate section).

Compile-tested an x86 allmodconfig for a while with gcc 8.2.0 and 4.6.4.

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
*Seems* to work, but note that I did not finish the entire allmodconfig :)

A few things could be splitted into their own patch, but I kept it
as one for simplicity for a first review.

These files are becoming no-headaches-readable again, yay.

 include/linux/compiler-clang.h      |   5 --
 include/linux/compiler-gcc.h        |  60 ----------------
 include/linux/compiler-intel.h      |   6 --
 include/linux/compiler.h            |   4 --
 include/linux/compiler_attributes.h | 105 ++++++++++++++++++++++++++++
 include/linux/compiler_types.h      |  91 ++++--------------------
 6 files changed, 118 insertions(+), 153 deletions(-)
 create mode 100644 include/linux/compiler_attributes.h

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index b1ce500fe8b3..3e7dafb3ea80 100644
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
@@ -41,6 +39,3 @@
  * compilers, like ICC.
  */
 #define barrier() __asm__ __volatile__("" : : : "memory")
-#define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
-#define __assume_aligned(a, ...)	\
-	__attribute__((__assume_aligned__(a, ## __VA_ARGS__)))
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 763bbad1e258..dde3daae6287 100644
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
@@ -95,8 +88,6 @@
 
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
-#define __optimize(level)	__attribute__((__optimize__(level)))
-
 #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
 
 #ifndef __CHECKER__
@@ -133,9 +124,6 @@
 		__builtin_unreachable();	\
 	} while (0)
 
-/* Mark a function definition as prohibited from being cloned. */
-#define __noclone	__attribute__((__noclone__, __optimize__("no-tracer")))
-
 #if defined(RANDSTRUCT_PLUGIN) && !defined(__CHECKER__)
 #define __randomize_layout __attribute__((randomize_layout))
 #define __no_randomize_layout __attribute__((no_randomize_layout))
@@ -144,32 +132,6 @@
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
-#if GCC_VERSION >= 40900 && !defined(__CHECKER__)
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
-#define __assume_aligned(a, ...) __attribute__((__assume_aligned__(a, ## __VA_ARGS__)))
-#endif
-
 /*
  * GCC 'asm goto' miscompiles certain code sequences:
  *
@@ -201,32 +163,10 @@
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
index 4c7f9befa9f6..fb9e77fc65ec 100644
--- a/include/linux/compiler-intel.h
+++ b/include/linux/compiler-intel.h
@@ -37,9 +37,3 @@
 /* icc has this, but it's called _bswap16 */
 #define __HAVE_BUILTIN_BSWAP16__
 #define __builtin_bswap16 _bswap16
-
-/* The following are for compatibility with GCC, from compiler-gcc.h,
- * and may be redefined here because they should not be shared with other
- * compilers, like clang.
- */
-#define __visible	__attribute__((externally_visible))
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 681d866efb1e..7c0157d50964 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -301,10 +301,6 @@ static inline void *offset_to_ptr(const int *off)
 
 #endif /* __ASSEMBLY__ */
 
-#ifndef __optimize
-# define __optimize(level)
-#endif
-
 /* Compile time object size, -1 for unknown */
 #ifndef __compiletime_object_size
 # define __compiletime_object_size(obj) -1
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
new file mode 100644
index 000000000000..af8c8413d136
--- /dev/null
+++ b/include/linux/compiler_attributes.h
@@ -0,0 +1,105 @@
+#ifndef __LINUX_COMPILER_ATTRIBUTES_H
+#define __LINUX_COMPILER_ATTRIBUTES_H
+
+/* This file is meant to be sorted. */
+
+/*
+ * Required attributes: your compiler must support these.
+ */
+#define __alias(symbol)		__attribute__((alias(#symbol)))
+#define __aligned(x)		__attribute__((aligned(x)))
+#define __aligned_largest	__attribute__((aligned))
+#define __always_inline         inline __attribute__((always_inline))
+#define __always_unused		__attribute__((unused))
+#define __attribute_const__     __attribute__((const))
+#define __cold			__attribute__((cold))
+#define __gnu_inline            __attribute__((gnu_inline))
+#define __malloc		__attribute__((malloc))
+#define __maybe_unused		__attribute__((unused))
+#define __mode(x)		__attribute__((mode(x)))
+#define   noinline              __attribute__((noinline))
+#define __noreturn		__attribute__((noreturn))
+#define __packed		__attribute__((packed))
+#define __printf(a, b)		__attribute__((format(printf, a, b)))
+#define __pure			__attribute__((pure))
+#define __scanf(a, b)		__attribute__((format(scanf, a, b)))
+#define __section(S)		__attribute__((section(#S)))
+#define __used			__attribute__((used))
+#define __weak			__attribute__((weak))
+
+/*
+ * Optional attributes: your compiler may or may not support them.
+ *
+ * To check for them, we use __has_attribute, which is supported on gcc >= 5,
+ * clang >= 2.9 and icc >= 17. In the meantime, to support 4.6 <= gcc < 5,
+ * we implement it by hand.
+ */
+#ifndef __has_attribute
+#define __has_attribute(x) __GCC46_has_attribute_##x
+#define __GCC46_has_attribute_assume_aligned 0
+#define __GCC46_has_attribute_designated_init 0
+#define __GCC46_has_attribute_externally_visible 1
+#define __GCC46_has_attribute_noclone 1
+#define __GCC46_has_attribute_optimize 1
+#define __GCC46_has_attribute_no_sanitize_address 0
+#endif
+
+/*
+ * __assume_aligned(n, k): Tell the optimizer that the returned
+ * pointer can be assumed to be k modulo n. The second argument is
+ * optional (default 0), so we use a variadic macro to make the
+ * shorthand.
+ *
+ * Beware: Do not apply this to functions which may return
+ * ERR_PTRs. Also, it is probably unwise to apply it to functions
+ * returning extra information in the low bits (but in that case the
+ * compiler should see some alignment anyway, when the return value is
+ * massaged by 'flags = ptr & 3; ptr &= ~3;').
+ */
+#if __has_attribute(assume_aligned)
+#define __assume_aligned(a, ...) __attribute__((assume_aligned(a, ## __VA_ARGS__)))
+#else
+#define __assume_aligned(a, ...)
+#endif
+
+/*
+ * Mark structures as requiring designated initializers.
+ * https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html
+ */
+#if __has_attribute(designated_init)
+#define __designated_init __attribute__((designated_init))
+#else
+#define __designated_init
+#endif
+
+/*
+ * When used with Link Time Optimization, gcc can optimize away C functions or
+ * variables which are referenced only from assembly code.  __visible tells the
+ * optimizer that something else uses this function or variable, thus preventing
+ * this.
+ */
+#if __has_attribute(externally_visible)
+#define __visible __attribute__((externally_visible))
+#else
+#define __visible
+#endif
+
+/* Mark a function definition as prohibited from being cloned. */
+#if __has_attribute(noclone) && __has_attribute(optimize)
+#define __noclone __attribute__((noclone, optimize("no-tracer")))
+#else
+#define __noclone
+#endif
+
+/*
+ * Tell the compiler that address safety instrumentation (KASAN)
+ * should not be applied to that function.
+ * Conflicts with inlining: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
+ */
+#if __has_attribute(no_sanitize_address)
+#define __no_sanitize_address __attribute__((no_sanitize_address))
+#else
+#define __no_sanitize_address
+#endif
+
+#endif /* __LINUX_COMPILER_ATTRIBUTES_H */
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 3525c179698c..8cd622bedec4 100644
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
@@ -119,10 +116,6 @@ struct ftrace_likely_data {
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
@@ -140,17 +133,6 @@ struct ftrace_likely_data {
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
 
@@ -159,14 +141,6 @@ struct ftrace_likely_data {
 	(sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
 	 sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
 
-#ifndef __attribute_const__
-#define __attribute_const__	__attribute__((__const__))
-#endif
-
-#ifndef __noclone
-#define __noclone
-#endif
-
 /* Helpers for emitting diagnostics in pragmas. */
 #ifndef __diag
 #define __diag(string)
@@ -186,34 +160,6 @@ struct ftrace_likely_data {
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
-#define __aligned(x)		__attribute__((aligned(x)))
-#define __aligned_largest	__attribute__((aligned))
-#define __printf(a, b)		__attribute__((format(printf, a, b)))
-#define __scanf(a, b)		__attribute__((format(scanf, a, b)))
-#define __maybe_unused		__attribute__((unused))
-#define __always_unused		__attribute__((unused))
-#define __mode(x)		__attribute__((mode(x)))
-#define __malloc		__attribute__((__malloc__))
-#define __used			__attribute__((__used__))
-#define __noreturn		__attribute__((noreturn))
-#define __packed		__attribute__((packed))
-#define __weak			__attribute__((weak))
-#define __alias(symbol)		__attribute__((alias(#symbol)))
-#define __cold			__attribute__((cold))
-#define __section(S)		__attribute__((__section__(#S)))
-
-
 #ifdef CONFIG_ENABLE_MUST_CHECK
 #define __must_check		__attribute__((warn_unused_result))
 #else
@@ -228,18 +174,6 @@ struct ftrace_likely_data {
 
 #define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
 
-/*
- * Feature detection for gnu_inline (gnu89 extern inline semantics). Either
- * __GNUC_STDC_INLINE__ is defined (not using gnu89 extern inline semantics,
- * and we opt in to the gnu89 semantics), or __GNUC_STDC_INLINE__ is not
- * defined so the gnu89 semantics are the default.
- */
-#ifdef __GNUC_STDC_INLINE__
-# define __gnu_inline	__attribute__((gnu_inline))
-#else
-# define __gnu_inline
-#endif
-
 /*
  * Force always-inline if the user requests it so via the .config.
  * GCC does not warn about unused static inline functions for
@@ -254,19 +188,13 @@ struct ftrace_likely_data {
  */
 #if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) || \
 	!defined(CONFIG_OPTIMIZE_INLINING)
-#define inline \
-	inline __attribute__((always_inline, unused)) notrace __gnu_inline
+#define inline inline __attribute__((always_inline, unused)) notrace __gnu_inline
 #else
-#define inline inline	__attribute__((unused)) notrace __gnu_inline
+#define inline inline __attribute__((unused)) notrace __gnu_inline
 #endif
 
 #define __inline__ inline
-#define __inline inline
-#define noinline	__attribute__((noinline))
-
-#ifndef __always_inline
-#define __always_inline inline __attribute__((always_inline))
-#endif
+#define __inline   inline
 
 /*
  * Rather then using noinline to prevent stack consumption, use
@@ -274,4 +202,11 @@ struct ftrace_likely_data {
  */
 #define noinline_for_stack noinline
 
+#ifdef __CHECKER__
+#define __must_be_array(a) 0
+#else
+/* &a[0] degrades to a pointer: a different type from an array */
+#define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
+#endif
+
 #endif /* __LINUX_COMPILER_TYPES_H */
-- 
2.17.1

