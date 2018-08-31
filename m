Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83284C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1593720841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="klSg4u0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1593720841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeIADRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:17:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36119 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeIADRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:17:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id e11-v6so6097904plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A1G4apW8N5td1nUpy1peQkmaImnhKRDFJiPNnJtOc50=;
        b=klSg4u0xInlY3PvlhM9v4q0kW5mfUC44kYd95qYdHlGRzZp8Kt09FHExJ1QteWFxlN
         f+DW77TpR4jZnjeIYpmUtay3ygmqJyhoZh9s/IJMUTwQvqPqWmRTE+PLbfi+1wa9JVgZ
         ci8oQjaPtS9AXwYRsIY0wHLBueBBWO4TgXMUhOl/vLuxOidItFEd0/HYdb74h4WrKrIr
         Am1Fo/13QzIiopZbQx4C3U6OuRxxZjaM0YczUgno29lweUFLC98uGnlbnQAy0YAOXqs5
         bUtRwICzNY/6H+htqTwtg+XQESmJ+21SP6wy1iQAvdcwNaSd9uqvzs6aQGo0rdvXAtGe
         rDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A1G4apW8N5td1nUpy1peQkmaImnhKRDFJiPNnJtOc50=;
        b=N28eHvqqU3kTy4mCbbBs6JhWY2QLwoCOC/kLQuZf/F2xEr9XrbcJf7ILE9B62KKWEY
         pz9A8jnnxesb8Td9y73cCclrzgl/hjSYEbp80Hgt74Bu0Yiand8zSiaxfVjeODxTqVXB
         uCmWsEQTh2XRo2BFl7VRa0bhNcsSYc9MTUOU9Q7SnwiTs2QG2rTwpqOip2HUC6K5iofc
         VWFf8ITUpuhysarSAXcr6w/+NEJINpRalLTu4RFy22HR4TRlhWtz/vFRb5gEuj+BF+9k
         jSA+mqL/cKkQ+oxqZCP2EV+LdqCWIkwMbCrGK1r3KcXAuSlQ1D8eHLuQjZgBzbEKYPka
         LExw==
X-Gm-Message-State: APzg51AFzHlypNS5ePcH6vgtQS0yjHjgWVEoLpAqN/yOZ+6kl6M7mhEs
        48Gc1TsoukIuNuBZGyY9zB2QF89lEnsIt1IjVkrs4w==
X-Google-Smtp-Source: ANB0VdavI1ZomexMUxQxaHXnRLtOd9Dl9p8m/hVAypA+RTCBctMnmms2HyahRaD0TDAGPSTM2rj6OQl+ndqeaHPAry4=
X-Received: by 2002:a17:902:561:: with SMTP id 88-v6mr17425174plf.320.1535756855562;
 Fri, 31 Aug 2018 16:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com> <20180831170514.24665-7-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180831170514.24665-7-miguel.ojeda.sandonis@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 31 Aug 2018 16:07:23 -0700
Message-ID: <CAKwvOdmF7bPJvnf38HYvnzdo8vO4K5=qkFwdTqwNnKA6PUVwpQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] Compiler Attributes: use feature checks instead of
 version checks
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, efriedma@codeaurora.org,
        sparse@chrisli.org, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        joe@perches.com, asmadeus@codewreck.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Overall, pretty happy with this patch.  Still some thoughts for a v3,
thanks for sending it!

On Fri, Aug 31, 2018 at 10:05 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Instead of using version checks per-compiler to define (or not)
> each attribute, use __has_attribute to test for them, following
> the cleanup started with commit 815f0ddb346c
> ("include/linux/compiler*.h: make compiler-*.h mutually exclusive").
>
> All the attributes that are fairly common/standard (i.e. those that
> do not require extra logic to define them) have been moved
> to a new file include/linux/compiler_attributes.h.
>
> In an effort to make the file as regular as possible, comments
> stating the purpose of attributes have been removed. Instead,
> links to the compiler docs have been added (i.e. to gcc and,
> if available, to clang as well). In addition, they have been sorted.
>
> Finally, if an attribute is optional (i.e. if it is guarded
> by __has_attribute), the reason has been stated for future reference.
>
> Cc: Eli Friedman <efriedma@codeaurora.org>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dominique Martinet <asmadeus@codewreck.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>  include/linux/compiler-clang.h      |   4 -
>  include/linux/compiler-gcc.h        |  51 -------
>  include/linux/compiler-intel.h      |   6 -
>  include/linux/compiler_attributes.h | 226 ++++++++++++++++++++++++++++
>  include/linux/compiler_types.h      |  72 +--------
>  5 files changed, 232 insertions(+), 127 deletions(-)
>  create mode 100644 include/linux/compiler_attributes.h
>
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 0aee694d3ab8..3e7dafb3ea80 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -21,8 +21,6 @@
>  #define __SANITIZE_ADDRESS__
>  #endif
>
> -#define __no_sanitize_address __attribute__((no_sanitize("address")))
> -
>  /*
>   * Not all versions of clang implement the the type-generic versions
>   * of the builtin overflow checkers. Fortunately, clang implements
> @@ -41,5 +39,3 @@
>   * compilers, like ICC.
>   */
>  #define barrier() __asm__ __volatile__("" : : : "memory")
> -#define __assume_aligned(a, ...)       \
> -       __attribute__((assume_aligned(a, ## __VA_ARGS__)))
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 32e6ce06163f..627fa8941436 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -116,9 +116,6 @@
>                 __builtin_unreachable();        \
>         } while (0)
>
> -/* Mark a function definition as prohibited from being cloned. */
> -#define __noclone      __attribute__((noclone, optimize("no-tracer")))
> -
>  #if defined(RANDSTRUCT_PLUGIN) && !defined(__CHECKER__)
>  #define __randomize_layout __attribute__((randomize_layout))
>  #define __no_randomize_layout __attribute__((no_randomize_layout))
> @@ -127,32 +124,6 @@
>  #define randomized_struct_fields_end   } __randomize_layout;
>  #endif
>
> -/*
> - * When used with Link Time Optimization, gcc can optimize away C functions or
> - * variables which are referenced only from assembly code.  __visible tells the
> - * optimizer that something else uses this function or variable, thus preventing
> - * this.
> - */
> -#define __visible      __attribute__((externally_visible))
> -
> -/* gcc version specific checks */
> -
> -#if GCC_VERSION >= 40900
> -/*
> - * __assume_aligned(n, k): Tell the optimizer that the returned
> - * pointer can be assumed to be k modulo n. The second argument is
> - * optional (default 0), so we use a variadic macro to make the
> - * shorthand.
> - *
> - * Beware: Do not apply this to functions which may return
> - * ERR_PTRs. Also, it is probably unwise to apply it to functions
> - * returning extra information in the low bits (but in that case the
> - * compiler should see some alignment anyway, when the return value is
> - * massaged by 'flags = ptr & 3; ptr &= ~3;').
> - */
> -#define __assume_aligned(a, ...) __attribute__((assume_aligned(a, ## __VA_ARGS__)))
> -#endif
> -
>  /*
>   * GCC 'asm goto' miscompiles certain code sequences:
>   *
> @@ -184,32 +155,10 @@
>  #define KASAN_ABI_VERSION 3
>  #endif
>
> -#if GCC_VERSION >= 40902
> -/*
> - * Tell the compiler that address safety instrumentation (KASAN)
> - * should not be applied to that function.
> - * Conflicts with inlining: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
> - */
> -#define __no_sanitize_address __attribute__((no_sanitize_address))
> -#endif
> -
>  #if GCC_VERSION >= 50100
> -/*
> - * Mark structures as requiring designated initializers.
> - * https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html
> - */
> -#define __designated_init __attribute__((designated_init))
>  #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
>  #endif
>
> -#if !defined(__noclone)
> -#define __noclone      /* not needed */
> -#endif
> -
> -#if !defined(__no_sanitize_address)
> -#define __no_sanitize_address
> -#endif
> -
>  /*
>   * Turn individual warnings and errors on and off locally, depending
>   * on version.
> diff --git a/include/linux/compiler-intel.h b/include/linux/compiler-intel.h
> index 18bd4362deaa..517bd14e1222 100644
> --- a/include/linux/compiler-intel.h
> +++ b/include/linux/compiler-intel.h
> @@ -34,9 +34,3 @@
>  /* icc has this, but it's called _bswap16 */
>  #define __HAVE_BUILTIN_BSWAP16__
>  #define __builtin_bswap16 _bswap16
> -
> -/* The following are for compatibility with GCC, from compiler-gcc.h,
> - * and may be redefined here because they should not be shared with other
> - * compilers, like clang.
> - */
> -#define __visible      __attribute__((externally_visible))
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> new file mode 100644
> index 000000000000..a9dfafc8fd19
> --- /dev/null
> +++ b/include/linux/compiler_attributes.h
> @@ -0,0 +1,226 @@

New file needs an SPDX license identifier right?

> +#ifndef __LINUX_COMPILER_ATTRIBUTES_H
> +#define __LINUX_COMPILER_ATTRIBUTES_H
> +
> +/*
> + * This file is meant to be sorted (by actual attribute name,
> + * not by #define identifier).
> + *
> + * Do not add here attributes which depend on others or require extra logic.
> + *
> + * If an attribute is optional, state the reason in the comment.

A lot of newlines in this comment. Can be condensed?

> + */
> +
> +/*
> + * To check for optional attributes, we use __has_attribute, which is supported
> + * on gcc >= 5, clang >= 2.9 and icc >= 17. In the meantime, to support
> + * 4.6 <= gcc < 5, we implement __has_attribute by hand.
> + */
> +#ifndef __has_attribute
> +#define __has_attribute(x) __GCC4_has_attribute_##x
> +#define __GCC4_has_attribute_externally_visible 1
> +#define __GCC4_has_attribute_noclone 1
> +#define __GCC4_has_attribute_optimize 1
> +#if __GNUC_MINOR__ >= 8
> +#define __GCC4_has_attribute_no_sanitize_address 1
> +#endif
> +#if __GNUC_MINOR__ >= 9
> +#define __GCC4_has_attribute_assume_aligned 1
> +#endif
> +#endif

I'm quite happy with this. Kudos.

> +
> +/*
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-alias-function-attribute
> + */
> +#define __alias(symbol)         __attribute__((alias(#symbol)))
> +
> +/*
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-aligned-function-attribute
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-aligned-type-attribute
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-aligned-variable-attribute
> + */
> +#define __aligned(x)            __attribute__((aligned(x)))
> +#define __aligned_largest       __attribute__((aligned))
> +
> +/*
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-always_005finline-function-attribute
> + * clang: mentioned but no proper documentation

What?! Ok, I'll add to my TODO list, but I think we can leave out that
clang doesn't have docs (yet!).

> + */
> +#define __always_inline         inline __attribute__((always_inline))
> +
> +/*
> + * The second argument is optional (default 0), so we use a variadic macro
> + * to make the shorthand.
> + *
> + * Beware: Do not apply this to functions which may return
> + * ERR_PTRs. Also, it is probably unwise to apply it to functions
> + * returning extra information in the low bits (but in that case the
> + * compiler should see some alignment anyway, when the return value is
> + * massaged by 'flags = ptr & 3; ptr &= ~3;').
> + *
> + * Optional: only supported since gcc >= 4.9
> + * Optional: not supported by icc
> + *
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-assume_005faligned-function-attribute
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#assume-aligned
> + */
> +#if __has_attribute(assume_aligned)
> +#define __assume_aligned(a, ...) __attribute__((assume_aligned(a, ## __VA_ARGS__)))
> +#else
> +#define __assume_aligned(a, ...)
> +#endif
> +
> +/*
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-cold-function-attribute
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Label-Attributes.html#index-cold-label-attribute
> + */
> +#define __cold                  __attribute__((cold))
> +
> +/*
> + * Note the long name.
> + *
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-const-function-attribute
> + */
> +#define __attribute_const__     __attribute__((const))

So I manually wrote down the list of attributes removed from one file,
and added to another, to make sure they balance out and that none were
missed.  I'm quite confident that nothing was missed moving from one
file to another.  Except this.  You've renamed __const to
__attribute_const__.  But you renamed __attribute_const_ to __const in
patch 3/7 in this series.  Surely one of them is a mistake?

> +
> +/*
> + * Don't. Just don't. See commit 771c035372a0 ("deprecate the '__deprecated'
> + * attribute warnings entirely and for good") for more information.
> + *
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-deprecated-function-attribute
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-deprecated-type-attribute
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-deprecated-variable-attribute
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Enumerator-Attributes.html#index-deprecated-enumerator-attribute
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#deprecated
> + */
> +#define __deprecated
> +
> +/*
> + * Optional: only supported since gcc >= 5.1
> + * Optional: not supported by clang
> + * Optional: not supported by icc
> + *
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-designated_005finit-type-attribute
> + */
> +#if __has_attribute(designated_init)
> +#define __designated_init       __attribute__((designated_init))
> +#else
> +#define __designated_init
> +#endif
> +
> +/*
> + * Optional: not supported by clang
> + *
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-externally_005fvisible-function-attribute
> + */
> +#if __has_attribute(externally_visible)
> +#define __visible               __attribute__((externally_visible))
> +#else
> +#define __visible
> +#endif
> +
> +/*
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-format-function-attribute
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#format
> + */
> +#define __printf(a, b)          __attribute__((format(printf, a, b)))
> +#define __scanf(a, b)           __attribute__((format(scanf, a, b)))
> +
> +/*
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-gnu_005finline-function-attribute
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#gnu-inline
> + */
> +#define __gnu_inline            __attribute__((gnu_inline))
> +
> +/*
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-malloc-function-attribute
> + */
> +#define __malloc                __attribute__((malloc))
> +
> +/*
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-mode-type-attribute
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-mode-variable-attribute
> + */
> +#define __mode(x)               __attribute__((mode(x)))
> +
> +/*
> + * Optional: not supported by clang
> + * Note: icc does not recognize gcc's no-tracer

In that case, can you provide 3 definitions for __noclone? Something like:

if has noclone
  if has optimize
    noclone = noclone optimize
  else
    noclone = noclone
else
  noclone =


> + *
> + *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-noclone-function-attribute
> + *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-optimize-function-attribute
> + */
> +#if __has_attribute(noclone) && __has_attribute(optimize)
> +#define __noclone               __attribute__((noclone, optimize("no-tracer")))
> +#else
> +#define __noclone
> +#endif
> +
> +/*
> + * Note the missing underscores.
> + *
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-noinline-function-attribute
> + * clang: mentioned but no proper documentation
> + */
> +#define   noinline              __attribute__((noinline))
> +
> +/*
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-noreturn-function-attribute
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#noreturn
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#id1
> + */
> +#define __noreturn              __attribute__((noreturn))
> +
> +/*
> + * Optional: only supported since gcc >= 4.8
> + * Optional: not supported by icc
> + *
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-no_005fsanitize_005faddress-function-attribute
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#no-sanitize-address-no-address-safety-analysis
> + */
> +#if __has_attribute(no_sanitize_address)
> +#define __no_sanitize_address   __attribute__((no_sanitize_address))
> +#else
> +#define __no_sanitize_address
> +#endif
> +
> +/*
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-packed-type-attribute
> + * clang: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-packed-variable-attribute
> + */
> +#define __packed                __attribute__((packed))
> +
> +/*
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-pure-function-attribute
> + */
> +#define __pure                  __attribute__((pure))
> +
> +/*
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-section-function-attribute
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-section-variable-attribute
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#section-declspec-allocate
> + */
> +#define __section(S)            __attribute__((section(#S)))
> +
> +/*
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-unused-function-attribute
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-unused-type-attribute
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-unused-variable-attribute
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Label-Attributes.html#index-unused-label-attribute
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#maybe-unused-unused
> + */
> +#define __always_unused         __attribute__((unused))
> +#define __maybe_unused          __attribute__((unused))
> +
> +/*
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-used-function-attribute
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-used-variable-attribute
> + */
> +#define __used                  __attribute__((used))
> +
> +/*
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-weak-function-attribute
> + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-weak-variable-attribute
> + */
> +#define __weak                  __attribute__((weak))
> +
> +#endif /* __LINUX_COMPILER_ATTRIBUTES_H */
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 5dddc7e0c607..f1e658433323 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -54,6 +54,9 @@ extern void __chk_io_ptr(const volatile void __iomem *);
>
>  #ifdef __KERNEL__
>
> +/* Attributes */
> +#include <linux/compiler_attributes.h>
> +
>  /* Compiler specific macros. */
>  #ifdef __clang__
>  #include <linux/compiler-clang.h>
> @@ -78,12 +81,6 @@ extern void __chk_io_ptr(const volatile void __iomem *);
>  #include <asm/compiler.h>
>  #endif
>
> -/*
> - * Generic compiler-independent macros required for kernel
> - * build go below this comment. Actual compiler/compiler version
> - * specific implementations come from the above header files
> - */
> -
>  struct ftrace_branch_data {
>         const char *func;
>         const char *file;
> @@ -106,9 +103,6 @@ struct ftrace_likely_data {
>         unsigned long                   constant;
>  };
>
> -/* Don't. Just don't. */
> -#define __deprecated
> -
>  #endif /* __KERNEL__ */
>
>  #endif /* __ASSEMBLY__ */
> @@ -118,10 +112,6 @@ struct ftrace_likely_data {
>   * compilers. We don't consider that to be an error, so set them to nothing.
>   * For example, some of them are for compiler specific plugins.
>   */
> -#ifndef __designated_init
> -# define __designated_init
> -#endif
> -
>  #ifndef __latent_entropy
>  # define __latent_entropy
>  #endif
> @@ -139,17 +129,6 @@ struct ftrace_likely_data {
>  # define randomized_struct_fields_end
>  #endif
>
> -#ifndef __visible
> -#define __visible
> -#endif
> -
> -/*
> - * Assume alignment of return value.
> - */
> -#ifndef __assume_aligned
> -#define __assume_aligned(a, ...)
> -#endif
> -
>  /* Are two types/vars the same type (ignoring qualifiers)? */
>  #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>
> @@ -158,10 +137,6 @@ struct ftrace_likely_data {
>         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
>          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>
> -#ifndef __noclone
> -#define __noclone
> -#endif
> -
>  /* Helpers for emitting diagnostics in pragmas. */
>  #ifndef __diag
>  #define __diag(string)
> @@ -181,35 +156,6 @@ struct ftrace_likely_data {
>  #define __diag_error(compiler, version, option, comment) \
>         __diag_ ## compiler(version, error, option)
>
> -/*
> - * From the GCC manual:
> - *
> - * Many functions have no effects except the return value and their
> - * return value depends only on the parameters and/or global
> - * variables.  Such a function can be subject to common subexpression
> - * elimination and loop optimization just as an arithmetic operator
> - * would be.
> - * [...]
> - */
> -#define __pure                 __attribute__((pure))
> -#define __const                        __attribute__((const))

See above comment about renaming __attribute_const__ to __const and back again.

> -#define __aligned(x)           __attribute__((aligned(x)))
> -#define __aligned_largest      __attribute__((aligned))
> -#define __printf(a, b)         __attribute__((format(printf, a, b)))
> -#define __scanf(a, b)          __attribute__((format(scanf, a, b)))
> -#define __maybe_unused         __attribute__((unused))
> -#define __always_unused                __attribute__((unused))
> -#define __mode(x)              __attribute__((mode(x)))
> -#define __malloc               __attribute__((malloc))
> -#define __used                 __attribute__((used))
> -#define __noreturn             __attribute__((noreturn))
> -#define __packed               __attribute__((packed))
> -#define __weak                 __attribute__((weak))
> -#define __alias(symbol)                __attribute__((alias(#symbol)))
> -#define __cold                 __attribute__((cold))
> -#define __section(S)           __attribute__((section(#S)))
> -
> -
>  #ifdef CONFIG_ENABLE_MUST_CHECK
>  #define __must_check           __attribute__((warn_unused_result))

Can this attribute be hoisted to your new header?  I guess there's a
few other __attributes__ still in this file even after this change.
Maybe not something that needs to be in this patch set, but what are
your thoughts on them?

>  #else
> @@ -224,8 +170,6 @@ struct ftrace_likely_data {
>
>  #define __compiler_offsetof(a, b)      __builtin_offsetof(a, b)
>
> -#define __gnu_inline   __attribute__((gnu_inline))
> -
>  /*
>   * Force always-inline if the user requests it so via the .config.
>   * GCC does not warn about unused static inline functions for
> @@ -240,17 +184,13 @@ struct ftrace_likely_data {
>   */
>  #if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) || \
>         !defined(CONFIG_OPTIMIZE_INLINING)
> -#define inline \
> -       inline __attribute__((always_inline, unused)) notrace __gnu_inline
> +#define inline __always_inline __gnu_inline __maybe_unused notrace
>  #else
> -#define inline inline  __attribute__((unused)) notrace __gnu_inline
> +#define inline          inline __gnu_inline __maybe_unused notrace

This seems to have different spacing after the first `inline` than the
line 2 lines above.

>  #endif
>
>  #define __inline__ inline
> -#define __inline inline
> -#define noinline       __attribute__((noinline))
> -
> -#define __always_inline inline __attribute__((always_inline))
> +#define __inline   inline
>
>  /*
>   * Rather then using noinline to prevent stack consumption, use
> --
> 2.17.1
>

Thank you again for this patch.
--
Thanks,
~Nick Desaulniers
