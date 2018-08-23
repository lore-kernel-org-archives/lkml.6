Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1A0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9ED21570
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PeCvqGp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9ED21570
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbeHXCo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 22:44:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38558 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeHXCo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 22:44:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id u11-v6so231144plq.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oaMROy64wLWtuDbAbGmS28cfrVWXGVZzot4DKaKf5s0=;
        b=PeCvqGp0W30Ipf+Lrgxw2Pba/8zNp+gcghFbbrl73Vt7NyNwacW9qRd0PhN9WQgUKW
         zUlK0zl+kugb/cNtiwKgFmatVrTE3Vay8Nr8DuvacY5+GlxH71+3YaEIlJNs8MSqMvsd
         a2Yp5PcdDuQVEgLs85YLe4v8yTf6L0OXs/ZynbCjsiISm3188hh7Qj3ZlxBvZCs/uJ+f
         8DsBa/BMQ0nHqaukK+D27EdPcWSBXnGn0y7lJ6fgor2adYRc7uKjleNJvHfBXW6ovzO3
         HvM2IotwCDhXvL+0CXpRtNLAUQ7hcecKkuAo+L3YRfBKOXbw3EIguqmaOmzYBEyxlN9s
         B2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oaMROy64wLWtuDbAbGmS28cfrVWXGVZzot4DKaKf5s0=;
        b=Mjwmv/IYDuP4wQpQ9c9JikjOGqsm3SYKr7birZSPtcuofx0YEQDyCdpIRjaoYv3Gi5
         mawVVw8TfSWoBPQgMVMryb7gxg3rMYScmdZ37oAUcv/bodf4PXtruN+gmRWko5rVOVqP
         KV0xy0Q3xA9XEic7tG+Hy1MkK9PUtTZQNXqHn3OOzD7voT+WS+r8UEINNibH8s1/QyrX
         qMo/BO4GuRfGHMS8ZF5Sgf8LjAFgppjP1UP36/qxyYZt+cBBRTY3NXWhie5NHOnkmm2C
         bS/UPRBuO4OCeBpeI4VrC5IfWPOIOQOZylhU/2hCwPTXETwoIdITgGqwufMVEqIHiL79
         4epA==
X-Gm-Message-State: AOUpUlGRjwHnliSjjptPAfzH4vsOZgXr8BZ2e5ODJCHh/re8O3EQtAj2
        fcLCajtImbkkN9aBmdqStZd4XgWylKG/bKwo+mYoog==
X-Google-Smtp-Source: AA+uWPxEwWbRz1Qzc9AWONm2zWhxVhIk8Dcg/2lphZYKWDH7dLRyA5YiF6sx2v5mZM3fRSXk6SzFNfS9UkURm8JOm1E=
X-Received: by 2002:a17:902:b7c3:: with SMTP id v3-v6mr24400687plz.238.1535065951622;
 Thu, 23 Aug 2018 16:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180822233724.110454-1-ndesaulniers@google.com>
 <20180823002508.GA822@nautica> <CA+55aFx=pDFceeO82pb__K0mCqRmgRDEmkRT2psOKQ=yikRcEw@mail.gmail.com>
 <CAGXu5jKJdNFcH9isnB0q_Eg=fpfp8NT+jxkgnaeXY8viDT+F1Q@mail.gmail.com>
 <CAKwvOdmJoEotNMUm=YkuvfAdihnB4SUhbZrc2PDEBScfdrvOjQ@mail.gmail.com> <e5d579d8ef832fbc133e96746ceb6edbd0870cc2.camel@perches.com>
In-Reply-To: <e5d579d8ef832fbc133e96746ceb6edbd0870cc2.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 23 Aug 2018 16:12:20 -0700
Message-ID: <CAKwvOdncUZZumxuJoLYWwPomNQb8TH+e0K=WaOSc5RjdJL7Uxw@mail.gmail.com>
Subject: Re: [PATCH] include/linux/compiler*.h: make compiler-*.h mutually exclusive
To:     joe@perches.com
Cc:     Kees Cook <keescook@chromium.org>, asmadeus@codewreck.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, dwmw@amazon.co.uk,
        LKML <linux-kernel@vger.kernel.org>,
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

On Thu, Aug 23, 2018 at 2:19 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2018-08-23 at 14:03 -0700, Nick Desaulniers wrote:
> > One reply for a bunch of the various threads, to keep the number of emails down:
> >
> > On Wed, Aug 22, 2018 at 5:20 PM Joe Perches <joe@perches.com> wrote:
> > > On Wed, 2018-08-22 at 16:37 -0700, Nick Desaulniers wrote:
> > > > +/* Compiler specific macros. */
> > > >  #ifdef __clang__
> > > >  #include <linux/compiler-clang.h>
> > >
> > > probably better as
> > >
> > > #if defined(__clang)
> > >
> > > to match the style of the #elif defined()s below it
> >
> > Hi Joe,
> > Thanks for the feedback. I always appreciate it.  If you have some
> > cleanups, want to send them to me, and I'll bundle them up for a PR?
> > I'm ok with that change.
> >
> > > > +#ifdef __GNUC_STDC_INLINE__
> > > > +# define __gnu_inline        __attribute__((gnu_inline))
> > > > +#else
> > > > +# define __gnu_inline
> > > > +#endif
> > >
> > > Perhaps __gnu_inline should be in compiler-gcc and this
> > > should use
> > >
> > > #ifndef __gnu_inline
> > > #define __gnu_inline
> > > #endif
> >
> > Not this case; it's how we get gnu89 semantics for `extern inline` is
> > not compiler specific (therefor should not go in a compiler specific
> > header).
>
> It's not possible to know that compilers support what
> __attribute__((<foo>)) and at what version that support
> exists unless it is specified somewhere.

__has_attribute:
https://clang.llvm.org/docs/LanguageExtensions.html#has-attribute

The release notes of GCC-5 mention __has_attribute.
https://gcc.gnu.org/gcc-5/changes.html

The point of feature detection is that it _doesn't matter_ what
version that support exists.  Either it does and you can use it, or it
doesn't and you can decide whether to stop compiling or there's a
valid work around.

Feature detection should be preferred to explicit version checks
except in 2 specific cases:
1. It's not possible to properly perform feature detection.  Language
features should not be added unless it's possible to safely check for
them.
2. A very specific version of a very specific compiler is broken and
needs to be explicitly guarded against.

> As far as I can tell,  gnu_inline is not recognized by clang.
>
> https://clang.llvm.org/docs/AttributeReference.html

If that was the case, I would not have added it in commit d03db2bc26f0
("compiler-gcc.h: Add __attribute__((gnu_inline)) to all inline
declarations").
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d03db2bc26f0e4a6849ad649a09c9c73fccdc656

Docs can sometimes fall behind, the lone source of truth is the source code.
https://github.com/llvm-mirror/clang/search?q=gnu_inline&unscoped_q=gnu_inline

Godbolt is also incredibly helpful for testing various compiler versions:
https://godbolt.org/z/uMJ-mo


https://reviews.llvm.org/D51190

-- 
Thanks,
~Nick Desaulniers
