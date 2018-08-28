Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5D8C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8214F2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZClrsO2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8214F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbeH1S4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:56:21 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44287 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1S4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:56:21 -0400
Received: by mail-qt0-f193.google.com with SMTP id k38-v6so2023421qtk.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 08:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=scF5pPbh7HC0b8E1YHw5l0wV98FFDm7t66xmUen2N0Q=;
        b=ZClrsO2y6gqxDXba777f3vfvNCEAbr3lXmeQmsb7AdiZx1r+c7/GtK/bluG/Q/aJ3X
         kWb7pLUl0P9VS5geKx34fUsCF5ZqSmvPu2Rpa6pEgiguxECQA4mCgfb8l0F6cr1jubul
         6nIcRmwXV9sVMJvQ3+Ob3hLGIu8iPmorJc4OZlyJTLjv6CLnzacFLqcJLm2uZPcIHDD3
         3F3aoQt4l782F69ouBYzeIsSKxVDITAoNZ+/DOC43CrPfuNH/bo0wXCRk3GOFIX0xh+F
         OpZLnENVZtjMgRE7ua9RSJyPwjVW+XTOUsQGfkgzd12WYs+KcbQOdmF5Teg/5Pox6R/5
         fgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=scF5pPbh7HC0b8E1YHw5l0wV98FFDm7t66xmUen2N0Q=;
        b=QV9gGoao0RNuYMSJVSC0F4lb1e2nJf2eLTPEbSw9Ivu6a5cfjQYwefKFcqy0vAM3fq
         PqlKYapEI4/FgswDsWQ9HL45zDOJEFxKFaKOxg8Zvy8tTwvc6BAgXJoZne9BFva7uORn
         0L5IXz66qaORwJ97PMgpxxjijb12LGjxq44oVOskDcohIu6NVGNcu/p0ngBuRjce6UQ3
         tfGtz/WUBOMk/GeplogYM029fzJZLsTTiTWRZjFYq9A/Hwuw4SOl16AB4rcAMG89oJcw
         jtmGdmI43+7wgPYdRwEv23bgyUddMMIhHnxeLAb0ZFEJRbeGBASfmm/SxQPXyspaX+Yl
         +ZrA==
X-Gm-Message-State: APzg51B27b60hHRnk4WX+3WWzLktDU4mE2LjMDZnpHCCN/G9I/J+yUI2
        IOvmJ3o5GaqCUAAsPQKRVd6A5zuvPG1DTLsSy9VWttBs
X-Google-Smtp-Source: ANB0VdYyw9ZUPhqTJi4gOubEwzjjzETEz0lbuZo6fA29H+pcAJoJv5IonjY0uKN9COBqRBIIffDl/TZ9mwIVb58ZrR0=
X-Received: by 2002:aed:3fd3:: with SMTP id w19-v6mr2080974qth.226.1535468654200;
 Tue, 28 Aug 2018 08:04:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:471a:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 08:03:53
 -0700 (PDT)
In-Reply-To: <CAKwvOdnyHctAYRBOdrkX15MBPX68pOSiKc2P2S_JnDdffdY+OA@mail.gmail.com>
References: <20180826175748.GA29525@gmail.com> <CAKwvOdnyHctAYRBOdrkX15MBPX68pOSiKc2P2S_JnDdffdY+OA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 28 Aug 2018 17:03:53 +0200
Message-ID: <CANiq72=DmREZ=1mjFU5PAjQ+WYVOqerP0odFYbiNRjpyrwiNmQ@mail.gmail.com>
Subject: Re: [PATCH] include/linux/compiler*.h: Use feature checking instead
 of version checks for attributes
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Mon, Aug 27, 2018 at 7:43 PM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
> On Sun, Aug 26, 2018 at 10:58 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> Instead of using version checks per-compiler to define (or not) each attribute,
>> use __has_attribute to test for them, following the cleanup started with
>> commit 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive").
>>
>> All the attributes that are fairly common/standard (i.e. those that do not
>> require extra logic to define them) have been moved to a new file
>> include/linux/compiler_attributes.h. The attributes have been sorted
>> and divided between "required" and "optional".
>
> Nice! Thanks Miguel.  Regarding sorting, I'm happy with that.  In
> fact, some of the comments can be removed IMO, as the attributes have
> common definitions in the docs (maybe an added link to the gcc and
> clang attribute docs at the top of the file rather than per attribute
> comments).

Thanks for the review!

I thought about that, although there isn't a single page with them in
GCC (we could group them by type though: function ones, variable
ones... and then link to those). On the other hand, maybe writing a
Doc/ file is better and allows us to write as much as one would like
about each of them (and a link to each page compiler's page about it,
etc.). I think in the end the Doc/ file might be the best, in order
not to crowd the header.

>
>>
>> Further, attributes that are already supported in gcc >= 4.6 and recent clang
>> were simply made to be required (instead of testing for them):
>>   * always_inline
>>   * const (pure was already "required", by the way)
>>   * gnu_inline
>
> There's an important test for gnu_inline that isn't checking that it's
> supported, but rather what the implicit behavior is depending on which
> C standard is being used.  It's important not to remove that.

Hm... I actually thought it was not available at some point before 4.6
and removed the #ifdef. The comment even says it is featuring
detecting it so that the old GCC inlining is used; but it shouldn't
matter if you always use it, no?

I just went looking for more info in d03db2bc2 ("compiler-gcc.h: Add
__attribute__((gnu_inline)) to all inline declarations") and if I
understood the commit message, the problem is compiling with implicit
new standard in newer compilers which trigger the C90 behavior, while
we need the old one --- but if we use gnu_inline, we are getting it
regardless.

I am sure I am missing something, but I think a clarification is
needed (and in the code comment as well) -- a bit off-topic, anyway.

[Also, I wouldn't define an attribute or not depending on some other
condition. I would, instead, define something some other symbol with
that logic (i.e. instead of using "__gnu_inline", because that is
lying -- it is not using the attribute even if the compiler supports
it).]

>
>>
>> Finally, some other bits were cleaned up in the process:
>>   * __optimize: removed (unused in the whole kernel tree)
>
> A+ for removing dead code.  I also don't see it used anywhere.
>
>>   * __must_be_array: removed from -gcc and -clang (identical), moved to _types
>
> Yep, uses a builtin (we should add guards for that, later, in a
> similar style change that guards the use of builtins). Looks good.
>
>>     (it depends on the unconditionally used  __builtin_types_compatible_p
>>   * Removes unneeded underscores on the attributes' names
>
> That doesn't sound right, but lets see what you mean by that.

Some attributes used the __name__ syntax (i.e. inside the double
parenthesis), others didn't. I simplified by removing all the extra
underscores.

>
>>
>> There are some things that can be further cleaned up afterwards:
>>   * __attribute_const__: rename to __const
>
> This doesn't look correct to me; the kernel is full of call sites for
> __attribute_const__. You can't rename the definition without renaming

Of course it is full of use sites! That is why I said it is a possible
cleanup for *afterwards* this patch :-)

> all of the call sites (and that would be too big a change for this
> patch, IMO).  Skip the rename, and it also looks like you just removed
> it outright (Oops).

Not sure what you mean by this (?). The attribute is still there unchanged.

>
>>   * __noretpoline: avoid checking for defined(__notrepoline)
>>   * __compiletime_warning/error: they are in two different places,
>>     -gcc and compiler.h.
>>   * sparse' attributes could potentially go into the end of attributes.h
>>     too (as another separate section).
>>
>> Compile-tested an x86 allmodconfig for a while with gcc 8.2.0 and 4.6.4.
>
> It's important to test changes to compiler-clang.h with clang. ;)

I would agree if the clang build wasn't broken to begin with. ;)

>
>>
>> Cc: Eli Friedman <efriedma@codeaurora.org>
>> Cc: Christopher Li <sparse@chrisli.org>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Cc: Joe Perches <joe@perches.com>
>> Cc: Dominique Martinet <asmadeus@codewreck.org>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>> ---
>> *Seems* to work, but note that I did not finish the entire allmodconfig :)
>>
>> A few things could be splitted into their own patch, but I kept it
>> as one for simplicity for a first review.
>>
>> These files are becoming no-headaches-readable again, yay.
>
> A+
>
>>
>>  include/linux/compiler-clang.h      |   5 --
>>  include/linux/compiler-gcc.h        |  60 ----------------
>>  include/linux/compiler-intel.h      |   6 --
>>  include/linux/compiler.h            |   4 --
>>  include/linux/compiler_attributes.h | 105 ++++++++++++++++++++++++++++
>>  include/linux/compiler_types.h      |  91 ++++--------------------
>>  6 files changed, 118 insertions(+), 153 deletions(-)
>>  create mode 100644 include/linux/compiler_attributes.h
>>
>> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
>> index b1ce500fe8b3..3e7dafb3ea80 100644
>> --- a/include/linux/compiler-clang.h
>> +++ b/include/linux/compiler-clang.h
>> @@ -21,8 +21,6 @@
>>  #define __SANITIZE_ADDRESS__
>>  #endif
>>
>> -#define __no_sanitize_address __attribute__((no_sanitize("address")))
>> -
>>  /*
>>   * Not all versions of clang implement the the type-generic versions
>>   * of the builtin overflow checkers. Fortunately, clang implements
>> @@ -41,6 +39,3 @@
>>   * compilers, like ICC.
>>   */
>>  #define barrier() __asm__ __volatile__("" : : : "memory")
>> -#define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>> -#define __assume_aligned(a, ...)       \
>> -       __attribute__((__assume_aligned__(a, ## __VA_ARGS__)))
>> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
>> index 763bbad1e258..dde3daae6287 100644
>> --- a/include/linux/compiler-gcc.h
>> +++ b/include/linux/compiler-gcc.h
>> @@ -68,13 +68,6 @@
>>   */
>>  #define uninitialized_var(x) x = x
>>
>> -#ifdef __CHECKER__
>> -#define __must_be_array(a)     0
>> -#else
>> -/* &a[0] degrades to a pointer: a different type from an array */
>> -#define __must_be_array(a)     BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>> -#endif
>> -
>>  #ifdef RETPOLINE
>>  #define __noretpoline __attribute__((indirect_branch("keep")))
>>  #endif
>> @@ -95,8 +88,6 @@
>>
>>  #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>>
>> -#define __optimize(level)      __attribute__((__optimize__(level)))
>> -
>>  #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
>>
>>  #ifndef __CHECKER__
>> @@ -133,9 +124,6 @@
>>                 __builtin_unreachable();        \
>>         } while (0)
>>
>> -/* Mark a function definition as prohibited from being cloned. */
>> -#define __noclone      __attribute__((__noclone__, __optimize__("no-tracer")))
>> -
>>  #if defined(RANDSTRUCT_PLUGIN) && !defined(__CHECKER__)
>>  #define __randomize_layout __attribute__((randomize_layout))
>>  #define __no_randomize_layout __attribute__((no_randomize_layout))
>> @@ -144,32 +132,6 @@
>>  #define randomized_struct_fields_end   } __randomize_layout;
>>  #endif
>>
>> -/*
>> - * When used with Link Time Optimization, gcc can optimize away C functions or
>> - * variables which are referenced only from assembly code.  __visible tells the
>> - * optimizer that something else uses this function or variable, thus preventing
>> - * this.
>> - */
>> -#define __visible      __attribute__((externally_visible))
>> -
>> -/* gcc version specific checks */
>> -
>> -#if GCC_VERSION >= 40900 && !defined(__CHECKER__)
>> -/*
>> - * __assume_aligned(n, k): Tell the optimizer that the returned
>> - * pointer can be assumed to be k modulo n. The second argument is
>> - * optional (default 0), so we use a variadic macro to make the
>> - * shorthand.
>> - *
>> - * Beware: Do not apply this to functions which may return
>> - * ERR_PTRs. Also, it is probably unwise to apply it to functions
>> - * returning extra information in the low bits (but in that case the
>> - * compiler should see some alignment anyway, when the return value is
>> - * massaged by 'flags = ptr & 3; ptr &= ~3;').
>> - */
>> -#define __assume_aligned(a, ...) __attribute__((__assume_aligned__(a, ## __VA_ARGS__)))
>> -#endif
>> -
>>  /*
>>   * GCC 'asm goto' miscompiles certain code sequences:
>>   *
>> @@ -201,32 +163,10 @@
>>  #define KASAN_ABI_VERSION 3
>>  #endif
>>
>> -#if GCC_VERSION >= 40902
>> -/*
>> - * Tell the compiler that address safety instrumentation (KASAN)
>> - * should not be applied to that function.
>> - * Conflicts with inlining: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
>> - */
>> -#define __no_sanitize_address __attribute__((no_sanitize_address))
>> -#endif
>> -
>>  #if GCC_VERSION >= 50100
>> -/*
>> - * Mark structures as requiring designated initializers.
>> - * https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html
>> - */
>> -#define __designated_init __attribute__((designated_init))
>>  #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
>>  #endif
>>
>> -#if !defined(__noclone)
>> -#define __noclone      /* not needed */
>> -#endif
>> -
>> -#if !defined(__no_sanitize_address)
>> -#define __no_sanitize_address
>> -#endif
>> -
>>  /*
>>   * Turn individual warnings and errors on and off locally, depending
>>   * on version.
>> diff --git a/include/linux/compiler-intel.h b/include/linux/compiler-intel.h
>> index 4c7f9befa9f6..fb9e77fc65ec 100644
>> --- a/include/linux/compiler-intel.h
>> +++ b/include/linux/compiler-intel.h
>> @@ -37,9 +37,3 @@
>>  /* icc has this, but it's called _bswap16 */
>>  #define __HAVE_BUILTIN_BSWAP16__
>>  #define __builtin_bswap16 _bswap16
>> -
>> -/* The following are for compatibility with GCC, from compiler-gcc.h,
>> - * and may be redefined here because they should not be shared with other
>> - * compilers, like clang.
>> - */
>> -#define __visible      __attribute__((externally_visible))
>> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
>> index 681d866efb1e..7c0157d50964 100644
>> --- a/include/linux/compiler.h
>> +++ b/include/linux/compiler.h
>> @@ -301,10 +301,6 @@ static inline void *offset_to_ptr(const int *off)
>>
>>  #endif /* __ASSEMBLY__ */
>>
>> -#ifndef __optimize
>> -# define __optimize(level)
>> -#endif
>> -
>>  /* Compile time object size, -1 for unknown */
>>  #ifndef __compiletime_object_size
>>  # define __compiletime_object_size(obj) -1
>> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
>> new file mode 100644
>> index 000000000000..af8c8413d136
>> --- /dev/null
>> +++ b/include/linux/compiler_attributes.h
>> @@ -0,0 +1,105 @@
>> +#ifndef __LINUX_COMPILER_ATTRIBUTES_H
>> +#define __LINUX_COMPILER_ATTRIBUTES_H
>> +
>> +/* This file is meant to be sorted. */
>> +
>> +/*
>> + * Required attributes: your compiler must support these.
>> + */
>> +#define __alias(symbol)                __attribute__((alias(#symbol)))
>> +#define __aligned(x)           __attribute__((aligned(x)))
>> +#define __aligned_largest      __attribute__((aligned))
>> +#define __always_inline         inline __attribute__((always_inline))
>> +#define __always_unused                __attribute__((unused))
>> +#define __attribute_const__     __attribute__((const))
>> +#define __cold                 __attribute__((cold))
>> +#define __gnu_inline            __attribute__((gnu_inline))
>> +#define __malloc               __attribute__((malloc))
>> +#define __maybe_unused         __attribute__((unused))
>> +#define __mode(x)              __attribute__((mode(x)))
>> +#define   noinline              __attribute__((noinline))
>> +#define __noreturn             __attribute__((noreturn))
>> +#define __packed               __attribute__((packed))
>> +#define __printf(a, b)         __attribute__((format(printf, a, b)))
>> +#define __pure                 __attribute__((pure))
>> +#define __scanf(a, b)          __attribute__((format(scanf, a, b)))
>> +#define __section(S)           __attribute__((section(#S)))
>> +#define __used                 __attribute__((used))
>> +#define __weak                 __attribute__((weak))
>> +
>> +/*
>> + * Optional attributes: your compiler may or may not support them.
>> + *
>> + * To check for them, we use __has_attribute, which is supported on gcc >= 5,
>> + * clang >= 2.9 and icc >= 17. In the meantime, to support 4.6 <= gcc < 5,
>> + * we implement it by hand.
>> + */
>> +#ifndef __has_attribute
>> +#define __has_attribute(x) __GCC46_has_attribute_##x
>> +#define __GCC46_has_attribute_assume_aligned 0
>> +#define __GCC46_has_attribute_designated_init 0
>> +#define __GCC46_has_attribute_externally_visible 1
>> +#define __GCC46_has_attribute_noclone 1
>> +#define __GCC46_has_attribute_optimize 1
>> +#define __GCC46_has_attribute_no_sanitize_address 0
>> +#endif
>> +
>> +/*
>> + * __assume_aligned(n, k): Tell the optimizer that the returned
>> + * pointer can be assumed to be k modulo n. The second argument is
>> + * optional (default 0), so we use a variadic macro to make the
>> + * shorthand.
>> + *
>> + * Beware: Do not apply this to functions which may return
>> + * ERR_PTRs. Also, it is probably unwise to apply it to functions
>> + * returning extra information in the low bits (but in that case the
>> + * compiler should see some alignment anyway, when the return value is
>> + * massaged by 'flags = ptr & 3; ptr &= ~3;').
>> + */
>> +#if __has_attribute(assume_aligned)
>> +#define __assume_aligned(a, ...) __attribute__((assume_aligned(a, ## __VA_ARGS__)))
>> +#else
>> +#define __assume_aligned(a, ...)
>> +#endif
>> +
>> +/*
>> + * Mark structures as requiring designated initializers.
>> + * https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html
>> + */
>> +#if __has_attribute(designated_init)
>> +#define __designated_init __attribute__((designated_init))
>> +#else
>> +#define __designated_init
>> +#endif
>> +
>> +/*
>> + * When used with Link Time Optimization, gcc can optimize away C functions or
>> + * variables which are referenced only from assembly code.  __visible tells the
>> + * optimizer that something else uses this function or variable, thus preventing
>> + * this.
>> + */
>> +#if __has_attribute(externally_visible)
>> +#define __visible __attribute__((externally_visible))
>> +#else
>> +#define __visible
>> +#endif
>> +
>> +/* Mark a function definition as prohibited from being cloned. */
>> +#if __has_attribute(noclone) && __has_attribute(optimize)
>> +#define __noclone __attribute__((noclone, optimize("no-tracer")))
>> +#else
>> +#define __noclone
>> +#endif
>> +
>> +/*
>> + * Tell the compiler that address safety instrumentation (KASAN)
>> + * should not be applied to that function.
>> + * Conflicts with inlining: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
>> + */
>> +#if __has_attribute(no_sanitize_address)
>> +#define __no_sanitize_address __attribute__((no_sanitize_address))
>> +#else
>> +#define __no_sanitize_address
>> +#endif
>> +
>> +#endif /* __LINUX_COMPILER_ATTRIBUTES_H */
>> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
>> index 3525c179698c..8cd622bedec4 100644
>> --- a/include/linux/compiler_types.h
>> +++ b/include/linux/compiler_types.h
>> @@ -54,6 +54,9 @@ extern void __chk_io_ptr(const volatile void __iomem *);
>>
>>  #ifdef __KERNEL__
>>
>> +/* Attributes */
>> +#include <linux/compiler_attributes.h>
>> +
>>  /* Compiler specific macros. */
>>  #ifdef __clang__
>>  #include <linux/compiler-clang.h>
>> @@ -78,12 +81,6 @@ extern void __chk_io_ptr(const volatile void __iomem *);
>>  #include <asm/compiler.h>
>>  #endif
>>
>> -/*
>> - * Generic compiler-independent macros required for kernel
>> - * build go below this comment. Actual compiler/compiler version
>> - * specific implementations come from the above header files
>> - */
>> -
>>  struct ftrace_branch_data {
>>         const char *func;
>>         const char *file;
>> @@ -119,10 +116,6 @@ struct ftrace_likely_data {
>>   * compilers. We don't consider that to be an error, so set them to nothing.
>>   * For example, some of them are for compiler specific plugins.
>>   */
>> -#ifndef __designated_init
>> -# define __designated_init
>> -#endif
>> -
>>  #ifndef __latent_entropy
>>  # define __latent_entropy
>>  #endif
>> @@ -140,17 +133,6 @@ struct ftrace_likely_data {
>>  # define randomized_struct_fields_end
>>  #endif
>>
>> -#ifndef __visible
>> -#define __visible
>> -#endif
>> -
>> -/*
>> - * Assume alignment of return value.
>> - */
>> -#ifndef __assume_aligned
>> -#define __assume_aligned(a, ...)
>> -#endif
>> -
>>  /* Are two types/vars the same type (ignoring qualifiers)? */
>>  #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>>
>> @@ -159,14 +141,6 @@ struct ftrace_likely_data {
>>         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
>>          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>>
>> -#ifndef __attribute_const__
>> -#define __attribute_const__    __attribute__((__const__))
>> -#endif
>> -
>> -#ifndef __noclone
>> -#define __noclone
>> -#endif
>> -
>>  /* Helpers for emitting diagnostics in pragmas. */
>>  #ifndef __diag
>>  #define __diag(string)
>> @@ -186,34 +160,6 @@ struct ftrace_likely_data {
>>  #define __diag_error(compiler, version, option, comment) \
>>         __diag_ ## compiler(version, error, option)
>>
>> -/*
>> - * From the GCC manual:
>> - *
>> - * Many functions have no effects except the return value and their
>> - * return value depends only on the parameters and/or global
>> - * variables.  Such a function can be subject to common subexpression
>> - * elimination and loop optimization just as an arithmetic operator
>> - * would be.
>> - * [...]
>> - */
>> -#define __pure                 __attribute__((pure))
>> -#define __aligned(x)           __attribute__((aligned(x)))
>> -#define __aligned_largest      __attribute__((aligned))
>> -#define __printf(a, b)         __attribute__((format(printf, a, b)))
>> -#define __scanf(a, b)          __attribute__((format(scanf, a, b)))
>> -#define __maybe_unused         __attribute__((unused))
>> -#define __always_unused                __attribute__((unused))
>> -#define __mode(x)              __attribute__((mode(x)))
>> -#define __malloc               __attribute__((__malloc__))
>> -#define __used                 __attribute__((__used__))
>> -#define __noreturn             __attribute__((noreturn))
>> -#define __packed               __attribute__((packed))
>> -#define __weak                 __attribute__((weak))
>> -#define __alias(symbol)                __attribute__((alias(#symbol)))
>> -#define __cold                 __attribute__((cold))
>> -#define __section(S)           __attribute__((__section__(#S)))
>> -
>> -
>>  #ifdef CONFIG_ENABLE_MUST_CHECK
>>  #define __must_check           __attribute__((warn_unused_result))
>>  #else
>> @@ -228,18 +174,6 @@ struct ftrace_likely_data {
>>
>>  #define __compiler_offsetof(a, b)      __builtin_offsetof(a, b)
>>
>> -/*
>> - * Feature detection for gnu_inline (gnu89 extern inline semantics). Either
>> - * __GNUC_STDC_INLINE__ is defined (not using gnu89 extern inline semantics,
>> - * and we opt in to the gnu89 semantics), or __GNUC_STDC_INLINE__ is not
>> - * defined so the gnu89 semantics are the default.
>> - */
>> -#ifdef __GNUC_STDC_INLINE__
>> -# define __gnu_inline  __attribute__((gnu_inline))
>> -#else
>> -# define __gnu_inline
>> -#endif
>> -
>>  /*
>>   * Force always-inline if the user requests it so via the .config.
>>   * GCC does not warn about unused static inline functions for
>> @@ -254,19 +188,13 @@ struct ftrace_likely_data {
>>   */
>>  #if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) || \
>>         !defined(CONFIG_OPTIMIZE_INLINING)
>> -#define inline \
>> -       inline __attribute__((always_inline, unused)) notrace __gnu_inline
>> +#define inline inline __attribute__((always_inline, unused)) notrace __gnu_inline
>>  #else
>> -#define inline inline  __attribute__((unused)) notrace __gnu_inline
>> +#define inline inline __attribute__((unused)) notrace __gnu_inline
>>  #endif
>>
>>  #define __inline__ inline
>> -#define __inline inline
>> -#define noinline       __attribute__((noinline))
>> -
>> -#ifndef __always_inline
>> -#define __always_inline inline __attribute__((always_inline))
>> -#endif
>> +#define __inline   inline
>
> All of the changes to inline should not be removed, see above.  It's
> important to make this work correctly regardless of C standard used.
>

See above.

>>
>>  /*
>>   * Rather then using noinline to prevent stack consumption, use
>> @@ -274,4 +202,11 @@ struct ftrace_likely_data {
>>   */
>>  #define noinline_for_stack noinline
>>
>> +#ifdef __CHECKER__
>> +#define __must_be_array(a) 0
>> +#else
>> +/* &a[0] degrades to a pointer: a different type from an array */
>> +#define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>> +#endif
>> +
>>  #endif /* __LINUX_COMPILER_TYPES_H */
>> --
>> 2.17.1
>>
>
> With the above changes requested, I'm super happy with the spirit of
> this patch, and look forward to a v2.  Thanks again Miguel!

Thanks again for the very thorough review!

Cheers,
Miguel

> --
> Thanks,
> ~Nick Desaulniers
