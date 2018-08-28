Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7D4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155B82086D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qS+STs+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155B82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeH1TC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:02:59 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:44960 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeH1TC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:02:59 -0400
Received: by mail-qk0-f196.google.com with SMTP id d131-v6so1198440qke.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 08:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=11QrUVLkpJRNy+Uk/E9ajBeBRbAXZv04GKnp+2Ccxyk=;
        b=qS+STs+bAVWR3iAFP3JmOEhCTh0Cxzt+iSzTaqSGLnck5C6kiVlGzEzNKcHFlu7FWa
         KSr9AVaBr/GVy6htLJ9pIfXmchYAPNN4TmFFrRfljQ8OV1Qu2SGk9+SmRqhJeGlOpye6
         rfobBY4iEfHfc+aHlCg4ZPXYEitAWQBV8AihW3Hk8TXmqD7MH4KL32G1drdV98J/prp8
         TtLLmsplT3kRufBCynrhjp2v1A7JBsCnaKlQB03tWO+cl+9I2ZiomoYGdg9gpfuyE+lV
         r1wQ9VrYvS3fP/EQBHIMUXyceerR0ViZSxrliF97zZxYXUNU/65KjKn2gmYNaDzMJOJN
         RNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=11QrUVLkpJRNy+Uk/E9ajBeBRbAXZv04GKnp+2Ccxyk=;
        b=C1tccyzL28HeeDdnyrXvrxhhQcI+xf49fMsykcub0oyHekgihtfX7QsIy0LHJTt8w/
         HrHWVEaCd8jLbLuR98ekPklIRheBDuUdbbZwp2rya83mcksZArHDHj5XbKFTEZzQzO5V
         tnkBBOH4mYTqOyJvCl3POrNX7v8TJrOOAWDwQdqLj/H/3lImixW2k9eMyr8MxucPRcSo
         z2Kop3TwmIkAu7wMPfpc5LSCNbu+PonaylY0wAgYnQn/igzvupyf1uDvhSyALWUbMB2T
         yFN7sqLqqR+WVGK+CHmCI6twEj6sfPDLI97Mg51/Htqt289YiN/ulhuHci9t757igf3t
         1Gtw==
X-Gm-Message-State: APzg51BD/voxRPjLqC2+xQCynIcO2LvVgOYYI57zYeYd4xKbB5P6PEdo
        4JN+Ly1gJgGGI4pIvcxkRdqdPV9BPV//bDy/Ilo=
X-Google-Smtp-Source: ANB0VdboX2z4+c6XQRX0QtNFcGpndBnfq/KkENtqMdwctxpkkSwGnPQEmv9jcT/US0d45u7rS0gEMQTvbf5jnFwWLgQ=
X-Received: by 2002:a37:1204:: with SMTP id c4-v6mr1940814qkh.63.1535469052018;
 Tue, 28 Aug 2018 08:10:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:471a:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 08:10:31
 -0700 (PDT)
In-Reply-To: <CAKwvOdk3PjNtjMcsXxRVvKLNcT+O_=5D1B7DXNWcwxwcMqdV2w@mail.gmail.com>
References: <20180826175748.GA29525@gmail.com> <CAKwvOdnyHctAYRBOdrkX15MBPX68pOSiKc2P2S_JnDdffdY+OA@mail.gmail.com>
 <CAKwvOdk3PjNtjMcsXxRVvKLNcT+O_=5D1B7DXNWcwxwcMqdV2w@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 28 Aug 2018 17:10:31 +0200
Message-ID: <CANiq72nV_sVGgQuZra2gqOXHnbtCYWZDBMRW=EeeLK3qTL99ew@mail.gmail.com>
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

On Mon, Aug 27, 2018 at 7:48 PM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
> On Mon, Aug 27, 2018 at 10:43 AM Nick Desaulniers
>> > +
>> > +/*
>> > + * Optional attributes: your compiler may or may not support them.
>> > + *
>> > + * To check for them, we use __has_attribute, which is supported on gcc >= 5,
>> > + * clang >= 2.9 and icc >= 17. In the meantime, to support 4.6 <= gcc < 5,
>> > + * we implement it by hand.
>> > + */
>> > +#ifndef __has_attribute
>> > +#define __has_attribute(x) __GCC46_has_attribute_##x
>> > +#define __GCC46_has_attribute_assume_aligned 0
>> > +#define __GCC46_has_attribute_designated_init 0
>> > +#define __GCC46_has_attribute_externally_visible 1
>> > +#define __GCC46_has_attribute_noclone 1
>> > +#define __GCC46_has_attribute_optimize 1
>> > +#define __GCC46_has_attribute_no_sanitize_address 0
>> > +#endif
>
> And a follow up; I'm trying to understand what will happen in the case
> of say gcc 4.9 here.  Were any of these supported between gcc 4.6 and
> 5.0?  If so, then this code will not use them.  It's simpler than
> explicit version checks, but it won't use features that are supported.
>

I addressed that in the email I sent afterwards:

"""
Note that:
  - assume_aligned came with gcc 4.9
  - no_sanitize_address came with gcc 4.8

So if we feel it is important to have them there (before gcc 5), we
would need here a quick version check here.
"""

The idea is that, in the future, whenever gcc 5 or later is the
minimum version, we just get rid of the #ifdef block without touching
the rest of the code :-)

Cheers,
Miguel

>> > +
>> > +/*
>> > + * __assume_aligned(n, k): Tell the optimizer that the returned
>> > + * pointer can be assumed to be k modulo n. The second argument is
>> > + * optional (default 0), so we use a variadic macro to make the
>> > + * shorthand.
>> > + *
>> > + * Beware: Do not apply this to functions which may return
>> > + * ERR_PTRs. Also, it is probably unwise to apply it to functions
>> > + * returning extra information in the low bits (but in that case the
>> > + * compiler should see some alignment anyway, when the return value is
>> > + * massaged by 'flags = ptr & 3; ptr &= ~3;').
>> > + */
>> > +#if __has_attribute(assume_aligned)
>> > +#define __assume_aligned(a, ...) __attribute__((assume_aligned(a, ## __VA_ARGS__)))
>> > +#else
>> > +#define __assume_aligned(a, ...)
>> > +#endif
>> > +
>> > +/*
>> > + * Mark structures as requiring designated initializers.
>> > + * https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html
>> > + */
>> > +#if __has_attribute(designated_init)
>> > +#define __designated_init __attribute__((designated_init))
>> > +#else
>> > +#define __designated_init
>> > +#endif
>> > +
>> > +/*
>> > + * When used with Link Time Optimization, gcc can optimize away C functions or
>> > + * variables which are referenced only from assembly code.  __visible tells the
>> > + * optimizer that something else uses this function or variable, thus preventing
>> > + * this.
>> > + */
>> > +#if __has_attribute(externally_visible)
>> > +#define __visible __attribute__((externally_visible))
>> > +#else
>> > +#define __visible
>> > +#endif
>> > +
>> > +/* Mark a function definition as prohibited from being cloned. */
>> > +#if __has_attribute(noclone) && __has_attribute(optimize)
>> > +#define __noclone __attribute__((noclone, optimize("no-tracer")))
>> > +#else
>> > +#define __noclone
>> > +#endif
>> > +
>> > +/*
>> > + * Tell the compiler that address safety instrumentation (KASAN)
>> > + * should not be applied to that function.
>> > + * Conflicts with inlining: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
>> > + */
>> > +#if __has_attribute(no_sanitize_address)
>> > +#define __no_sanitize_address __attribute__((no_sanitize_address))
>> > +#else
>> > +#define __no_sanitize_address
>> > +#endif
>> > +
>> > +#endif /* __LINUX_COMPILER_ATTRIBUTES_H */
>> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
>> > index 3525c179698c..8cd622bedec4 100644
>> > --- a/include/linux/compiler_types.h
>> > +++ b/include/linux/compiler_types.h
>> > @@ -54,6 +54,9 @@ extern void __chk_io_ptr(const volatile void __iomem *);
>> >
>> >  #ifdef __KERNEL__
>> >
>> > +/* Attributes */
>> > +#include <linux/compiler_attributes.h>
>> > +
>> >  /* Compiler specific macros. */
>> >  #ifdef __clang__
>> >  #include <linux/compiler-clang.h>
>> > @@ -78,12 +81,6 @@ extern void __chk_io_ptr(const volatile void __iomem *);
>> >  #include <asm/compiler.h>
>> >  #endif
>> >
>> > -/*
>> > - * Generic compiler-independent macros required for kernel
>> > - * build go below this comment. Actual compiler/compiler version
>> > - * specific implementations come from the above header files
>> > - */
>> > -
>> >  struct ftrace_branch_data {
>> >         const char *func;
>> >         const char *file;
>> > @@ -119,10 +116,6 @@ struct ftrace_likely_data {
>> >   * compilers. We don't consider that to be an error, so set them to nothing.
>> >   * For example, some of them are for compiler specific plugins.
>> >   */
>> > -#ifndef __designated_init
>> > -# define __designated_init
>> > -#endif
>> > -
>> >  #ifndef __latent_entropy
>> >  # define __latent_entropy
>> >  #endif
>> > @@ -140,17 +133,6 @@ struct ftrace_likely_data {
>> >  # define randomized_struct_fields_end
>> >  #endif
>> >
>> > -#ifndef __visible
>> > -#define __visible
>> > -#endif
>> > -
>> > -/*
>> > - * Assume alignment of return value.
>> > - */
>> > -#ifndef __assume_aligned
>> > -#define __assume_aligned(a, ...)
>> > -#endif
>> > -
>> >  /* Are two types/vars the same type (ignoring qualifiers)? */
>> >  #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>> >
>> > @@ -159,14 +141,6 @@ struct ftrace_likely_data {
>> >         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
>> >          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>> >
>> > -#ifndef __attribute_const__
>> > -#define __attribute_const__    __attribute__((__const__))
>> > -#endif
>> > -
>> > -#ifndef __noclone
>> > -#define __noclone
>> > -#endif
>> > -
>> >  /* Helpers for emitting diagnostics in pragmas. */
>> >  #ifndef __diag
>> >  #define __diag(string)
>> > @@ -186,34 +160,6 @@ struct ftrace_likely_data {
>> >  #define __diag_error(compiler, version, option, comment) \
>> >         __diag_ ## compiler(version, error, option)
>> >
>> > -/*
>> > - * From the GCC manual:
>> > - *
>> > - * Many functions have no effects except the return value and their
>> > - * return value depends only on the parameters and/or global
>> > - * variables.  Such a function can be subject to common subexpression
>> > - * elimination and loop optimization just as an arithmetic operator
>> > - * would be.
>> > - * [...]
>> > - */
>> > -#define __pure                 __attribute__((pure))
>> > -#define __aligned(x)           __attribute__((aligned(x)))
>> > -#define __aligned_largest      __attribute__((aligned))
>> > -#define __printf(a, b)         __attribute__((format(printf, a, b)))
>> > -#define __scanf(a, b)          __attribute__((format(scanf, a, b)))
>> > -#define __maybe_unused         __attribute__((unused))
>> > -#define __always_unused                __attribute__((unused))
>> > -#define __mode(x)              __attribute__((mode(x)))
>> > -#define __malloc               __attribute__((__malloc__))
>> > -#define __used                 __attribute__((__used__))
>> > -#define __noreturn             __attribute__((noreturn))
>> > -#define __packed               __attribute__((packed))
>> > -#define __weak                 __attribute__((weak))
>> > -#define __alias(symbol)                __attribute__((alias(#symbol)))
>> > -#define __cold                 __attribute__((cold))
>> > -#define __section(S)           __attribute__((__section__(#S)))
>> > -
>> > -
>> >  #ifdef CONFIG_ENABLE_MUST_CHECK
>> >  #define __must_check           __attribute__((warn_unused_result))
>> >  #else
>> > @@ -228,18 +174,6 @@ struct ftrace_likely_data {
>> >
>> >  #define __compiler_offsetof(a, b)      __builtin_offsetof(a, b)
>> >
>> > -/*
>> > - * Feature detection for gnu_inline (gnu89 extern inline semantics). Either
>> > - * __GNUC_STDC_INLINE__ is defined (not using gnu89 extern inline semantics,
>> > - * and we opt in to the gnu89 semantics), or __GNUC_STDC_INLINE__ is not
>> > - * defined so the gnu89 semantics are the default.
>> > - */
>> > -#ifdef __GNUC_STDC_INLINE__
>> > -# define __gnu_inline  __attribute__((gnu_inline))
>> > -#else
>> > -# define __gnu_inline
>> > -#endif
>> > -
>> >  /*
>> >   * Force always-inline if the user requests it so via the .config.
>> >   * GCC does not warn about unused static inline functions for
>> > @@ -254,19 +188,13 @@ struct ftrace_likely_data {
>> >   */
>> >  #if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) || \
>> >         !defined(CONFIG_OPTIMIZE_INLINING)
>> > -#define inline \
>> > -       inline __attribute__((always_inline, unused)) notrace __gnu_inline
>> > +#define inline inline __attribute__((always_inline, unused)) notrace __gnu_inline
>> >  #else
>> > -#define inline inline  __attribute__((unused)) notrace __gnu_inline
>> > +#define inline inline __attribute__((unused)) notrace __gnu_inline
>> >  #endif
>> >
>> >  #define __inline__ inline
>> > -#define __inline inline
>> > -#define noinline       __attribute__((noinline))
>> > -
>> > -#ifndef __always_inline
>> > -#define __always_inline inline __attribute__((always_inline))
>> > -#endif
>> > +#define __inline   inline
>>
>> All of the changes to inline should not be removed, see above.  It's
>> important to make this work correctly regardless of C standard used.
>>
>> >
>> >  /*
>> >   * Rather then using noinline to prevent stack consumption, use
>> > @@ -274,4 +202,11 @@ struct ftrace_likely_data {
>> >   */
>> >  #define noinline_for_stack noinline
>> >
>> > +#ifdef __CHECKER__
>> > +#define __must_be_array(a) 0
>> > +#else
>> > +/* &a[0] degrades to a pointer: a different type from an array */
>> > +#define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
>> > +#endif
>> > +
>> >  #endif /* __LINUX_COMPILER_TYPES_H */
>> > --
>> > 2.17.1
>> >
>>
>> With the above changes requested, I'm super happy with the spirit of
>> this patch, and look forward to a v2.  Thanks again Miguel!
>> --
>> Thanks,
>> ~Nick Desaulniers
>
>
>
> --
> Thanks,
> ~Nick Desaulniers
