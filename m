Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F75C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723B52150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dYZgPXQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723B52150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeHXAfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:35:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37805 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbeHXAfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:35:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id h8-v6so3249966pgs.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 14:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=93DxfRqEzfsqtwdue8/9ZIMZ2ejAABgOgtZZsGqo+cc=;
        b=dYZgPXQXGADGpZEvphtuRTwntCQnLLL4fhRAFQ3AeHc7KSa1LJWquwsiH50vlRPgYU
         WoFgybCQogew6slpa41cFUSw7bYlj4FbQhQB8b4hRcIZDjqf7qxGeKGwleMk2kUpYNR6
         VtlLTz9Kw+82PKZVceWXSMkteuGZXWQJrgzx1RFRPM4ZPsIgqnIQBUwXWZwTd6I3Vfc/
         ShYH1XjGMfb7oiaGQsytTNWRqi9J3k9O6BlVeuFMpTD0uUULLjx6zphetCHNlxqlvGl+
         nqWkGulg8wj3r/EqMMzghNou7oICOoZX8RRB4XJJ2vQSx3G5gagfb+k7NkpA9Ppu/QUM
         40qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=93DxfRqEzfsqtwdue8/9ZIMZ2ejAABgOgtZZsGqo+cc=;
        b=YVo8QFSfYwjTpNx3l6ZW2mzGLZDYEQbGu+ICiuwj5B6Hi1/Kkod1Wmz+UAFA0uVBxP
         1wbmqTWfBdz2v/m043UV6aXjNC/eAfCFaWhbJXOOkxF04QmTgbZ29bFOAUlDv4MZTusr
         fhNVG0U/NnoJHIG8TDAulLXYCSXUBwcZwuaynmZsXBzixlvHIdrp/3FHaZj/fnHX40BP
         99EzyEibJ8ojCoZP3XCEvIUfwWxKNZ8L+tChmzzJZ+mSf0WQ8iLqNeDJR0rwfuTln+Dr
         ZUt8cfhzPzYzwEqFgMpjX5wp2vya806kEFFNfXHIxh/IMtshAWFefW7z8mVdffiDnazw
         ujRg==
X-Gm-Message-State: AOUpUlHytkClJNhCJTKcVIGps/YmcLF6lXadGzAFihRY5dF4wY46HZ0z
        CoJUMR8uFNeGyUeskm39/FPhE9/bRncG4Fp6DfpolA==
X-Google-Smtp-Source: AA+uWPxYS4yzATA/X1SYeahlf6HhiEc97tqAsCVGAKWENrUDIBR0cQxc++JVGCYmptCeOCndHIT+5IrBXojuONVeFxY=
X-Received: by 2002:a62:1815:: with SMTP id 21-v6mr64170389pfy.227.1535058248246;
 Thu, 23 Aug 2018 14:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180822233724.110454-1-ndesaulniers@google.com>
 <20180823002508.GA822@nautica> <CA+55aFx=pDFceeO82pb__K0mCqRmgRDEmkRT2psOKQ=yikRcEw@mail.gmail.com>
 <CAGXu5jKJdNFcH9isnB0q_Eg=fpfp8NT+jxkgnaeXY8viDT+F1Q@mail.gmail.com>
In-Reply-To: <CAGXu5jKJdNFcH9isnB0q_Eg=fpfp8NT+jxkgnaeXY8viDT+F1Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 23 Aug 2018 14:03:57 -0700
Message-ID: <CAKwvOdmJoEotNMUm=YkuvfAdihnB4SUhbZrc2PDEBScfdrvOjQ@mail.gmail.com>
Subject: Re: [PATCH] include/linux/compiler*.h: make compiler-*.h mutually exclusive
To:     Kees Cook <keescook@chromium.org>, asmadeus@codewreck.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        joe@perches.com, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
        dwmw@amazon.co.uk, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        daniel@iogearbox.net, hpa@zytor.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One reply for a bunch of the various threads, to keep the number of emails down:

On Wed, Aug 22, 2018 at 5:20 PM Joe Perches <joe@perches.com> wrote:
> On Wed, 2018-08-22 at 16:37 -0700, Nick Desaulniers wrote:
> > +/* Compiler specific macros. */
> >  #ifdef __clang__
> >  #include <linux/compiler-clang.h>
>
> probably better as
>
> #if defined(__clang)
>
> to match the style of the #elif defined()s below it

Hi Joe,
Thanks for the feedback. I always appreciate it.  If you have some
cleanups, want to send them to me, and I'll bundle them up for a PR?
I'm ok with that change.

> > +#ifdef __GNUC_STDC_INLINE__
> > +# define __gnu_inline        __attribute__((gnu_inline))
> > +#else
> > +# define __gnu_inline
> > +#endif
>
> Perhaps __gnu_inline should be in compiler-gcc and this
> should use
>
> #ifndef __gnu_inline
> #define __gnu_inline
> #endif

Not this case; it's how we get gnu89 semantics for `extern inline` is
not compiler specific (therefor should not go in a compiler specific
header).

> > +#if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) || \
> > +     !defined(CONFIG_OPTIMIZE_INLINING)
> > +#define inline \
> > +     inline __attribute__((always_inline, unused)) notrace __gnu_inline
> > +#else
> > +#define inline inline        __attribute__((unused)) notrace __gnu_inline
> > +#endif
>
> This bit might be better adding another __<foo> attribute like:
>
> #if defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) &&
>     defined(CONFIG_OPTIMIZE_INLINING)
> #define __optimized_inline __unused
> #else
> #define __optimized_inline __unused __attribute__((always_inline))
> #endif
>
> #define inline inline __optimized_inline notrace __gnu_inline

Sure, as above I'm happy to take clean ups, but that might result in
treewide changes (maybe less benefit but could separate `inline` from
`__optimized_inline`).  Maybe bikeshed territory, but `force_inline`
or some notion that we're trying to overrule the compiler here might
make intent clearer.

> > -#if (GCC_VERSION >= 40700 && GCC_VERSION < 40900) && defined(CONFIG_ARM)
> > +#if defined(CONFIG_ARM) && \
> > +     defined(GCC_VERSION) && GCC_VERSION < 40900 && GCC_VERSION >= 40700
>
> I find the reversed version tests a bit odd to read

Sorry, I probably didn't need to reorder that. My thought process was
in terms of short circuiting, what order was most likely for us to
bail out of the condition first?  If it hurts readability, I'm happy
to take clean ups.

On Wed, Aug 22, 2018 at 5:25 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
> Overall looks good to me, just pointing at the same error I wrote in my
> other mail here -- I saw that by the time I was done writing this this
> patch got taken but that alone will probably warrant a follow-up :/
> > +#define barrier() (__asm__ __volatile__("" : : : "memory"))
>
> barrier here has gained external () compared to the definition and
> compiler-gcc.h:
> #define barrier() __asm__ __volatile__("": : :"memory")

Dominique,
Yes, sorry about that (looks like Linus noticed that, too).  Was a
stupid last minute mistake on my part, trying to appease
checkpatch.pl.  One of these days, I'll get frustrated enough to
rewrite checkpatch.pl as a set of clang tidy checks (so that it
actually parses the code), but I'll have to learn how to read perl
first to start translating.

> I've also added a few style nitpicks/questions but feel free to ignore
> these.

No, please, I really appreciate you taking the time to actually test
this and provide feedback.  That kind of support is critical in open
source.

> On a side note, I noticed tools/include/linux/compiler.h includes
> linux/compiler-gcc.h but maybe it should include linux/compiler_types.h?
> (I'm not sure at who uses that header, so it really is an open question
> here)

Without looking into the code, this sounds like compiler.h is wrong.
Looking at the source, there's references to ancient Android NDK's
(what?! Let me show this to the NDK maintainers).  This whole thing
needs to be cleaned up, too, IMO.  Oh, there's two compiler-gcc.h in
the tree:

- tools/include/linux/compiler-gcc.h (that's what's being included in
the case you point out)
- include/linux/compiler-gcc.h

Maybe they can be combined?

> > -#define __nostackprotector   __optimize("no-stack-protector")
>
> I do not see this being added back, it's probably fine though as it
> doesn't look used?
> (I didn't check all removed lines, maybe about half)

For each case, I triple checked that the macro was actually being used
in the code.  __nostackprotector was not, so I dropped it.

Sounds like I may have messed up `__naked` though, see below.

> I'm not sure I understand the logic of where you removed ifndef and
> where you kept them (but, well, this should work)

There were some cases were some symbols were defined in glibc's
headers, so `make CC=clang` (implying that HOSTCC=gcc) would produce
redefinition warnings.  I should've added a comment to clarify.

> If you tried to align these, __always_unused and __alias(symbol) look
> off

I have `set tabstop=8` in vim, and it looks correct there, but both
`git diff` and github's code viewer show it as off.  Maybe I have my
settings wrong in vim and need to go back to first grade, but
(personal opinion ahead) you don't have this kind of nonsense
(ambiguity around how many spaces a tab should be displayed as in
various code viewers) if you just always use spaces everywhere, for
everything.  Other large codebases use automatic code formatters (like
clang-format) and that prevents holy wars and other distractions.
There's even a cool utility called `git-clang-format` that can check
just the code you changed, which is useful for not reformatting the
entire codebase messing up git blame.

On Wed, Aug 22, 2018 at 6:02 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> I've fixed that manually, but when I tried to test it I just hit the
>
>   arch/x86/Makefile:179: *** Compiler lacks asm-goto support..  Stop.
>
> error.
>
> Do you have some experimental clang build with asm goto support? What
> version? Or is it just that you're building ARM, not x86?

Linus,
Not yet.  I'll probably start implementing it myself if I don't see
patches soon.

Arm64 builds with defconfig minus CONFIG_ARM64_LSE_ATOMICS, or x86_64
with some #errors and a few other things commented out produces a
working build (but I realize that's living on borrowed time, hence
trying to document each bug and fix it properly).

Looks like I need to create some Arm32 bit qemu images for testing, see below.

On Wed, Aug 22, 2018 at 7:43 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> It was previous included by all compilers,
> but now it is only by _true_ GCC.

Good catch, and thanks for the report and testing.  I missed that
because I was testing x86_64 and arm64 (which I guess don't hit that
in the configs I tested) and not arm32.  Should be a simple fix to
move it to shared the definition.  Send me a patch, or I'll get to it.

> Even if I move the __naked definition
> to <linux/compiler_types.h>,
> I see a different error.

Did that regress due to my change?  If so, sorry and I'll look into it
more soon.

Kees,
Thanks for the additional comments in the bug tracker.  Seems like
some differences in builtin_constant_p between compilers, let's keep
tracking this (maybe there's more that can be done in the Clang
patch).

Thanks everyone for the feedback.
-- 
Thanks,
~Nick Desaulniers
