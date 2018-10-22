Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE11C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6C520652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JBBNqeqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6C520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbeJWCNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 22:13:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36201 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbeJWCNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 22:13:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id l6-v6so648752pgp.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 10:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wx7+DFotACulVON7B1V/bfMhbYtnzILL34pxQ+bKY1Q=;
        b=JBBNqeqJDtjFhyMMJGUT+PlgQ6FW/GrN/AXqH85qwfteBRCEhBVMzB8QHh1l0EhXQb
         FJI84w4HZIzvJGPtsI1EIF6ThPZmXKrYrtqwE3WNxkQT8+KK+mkWuaYw1L2I3l6TRHHd
         GaGHjwPZnKQVoIvoKw5i8gUE0p0IDdluGp2Zs1ELv2n6413S03NG3WxeZ1kkwEIRQQXF
         B1ECxtvJsoX1BXVNHx0i6yhpQMgBmssfYwVoC+RiwiCMVTa+acsOsVDmwSmOZs+wE//T
         QrSWYPAX8rt7az/Ab4dJrWAO0OtQRJvLATSL8PpmKFFLc98s293xk6z2FZhcsgx1NuOy
         sMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wx7+DFotACulVON7B1V/bfMhbYtnzILL34pxQ+bKY1Q=;
        b=Gg2S0TDlqU9u1FopELLcWjEMC+pVVl3CoqywQvBgRgrP7tM5zdWg+5/i8dcQb8JwSV
         CULj5+Y5moBAkIR7yvb2dghZTx47u9FYedE2yymrhC/BJjtGoKxIzDXzY8Wx848uPtAB
         Nod3iYIxHY7+sfxgSY4g23S0LC3C5kZO6q4fQT0qm/QUsvZVHpNW8GRlJmTD65Sujp2/
         mUGxcC1fgJYnXZBVubzwTDG3hr3jMHSl1Qneh9tmF770aLZVXfHocEZYV8zMTSg5E8qU
         vKZ7CN93sc4PMmm4lRjFtC/PTI7zaAkXBi0siL110Or0Za9VqXk75qqPEl9kgfaeXw+V
         y3qg==
X-Gm-Message-State: ABuFfoj8/41vgBmvjy6Idhf6AB+J1rxH+iLGFqGQQBtHfs/6C29blTmW
        o4bGn9vHc6QMYz/Gw6LlhBJAz2yBt9JDc00bIJmMKg==
X-Google-Smtp-Source: ACcGV62pTOq331E3DqUp7/P+M3hykNsHlBhsRTCb+M1LEcdrfOeZ59qk2TEPklWr83I5dPlVwafs3e5PALtM9SoSzd4=
X-Received: by 2002:a63:9e02:: with SMTP id s2-v6mr44569797pgd.302.1540230854397;
 Mon, 22 Oct 2018 10:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <20181021222712.GI1617@thunk.org>
 <8fb78062-b6d4-6f2d-d943-44bec6b95ff0@petrovitsch.priv.at>
 <20181022102743.nua5fgbscyeymzal@mwanda> <1474d995-1b5a-2efb-f077-33eb4a5d9e31@petrovitsch.priv.at>
 <20181022105314.j6djkrpwbnokhai5@mwanda> <CANiq72=ioYcRA-yq38+Z4i6iVDNm6C2-+b4feRmnvEiekuR7dA@mail.gmail.com>
 <3cbb5345-0270-5575-7563-6ad37d888e42@petrovitsch.priv.at>
In-Reply-To: <3cbb5345-0270-5575-7563-6ad37d888e42@petrovitsch.priv.at>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Oct 2018 10:54:02 -0700
Message-ID: <CAKwvOdnWkPi_2UJ7VKYZ6cuWi+BDgpEUf+tcrfZLUYawbm+grw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
To:     bernd@petrovitsch.priv.at
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        dan.carpenter@oracle.com, "Theodore Ts'o" <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, adilger.kernel@dilger.ca,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, rostedt@goodmis.org,
        mchehab+samsung@kernel.org, olof@lxom.net,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        sandipan@linux.vnet.ibm.com,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        paul.burton@mips.com, David Rientjes <rientjes@google.com>,
        Willy Tarreau <w@1wt.eu>, msebor@gmail.com, sparse@chrisli.org,
        Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, joe@perches.com,
        Arnd Bergmann <arnd@arndb.de>, asmadeus@codewreck.org,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-sparse@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 10:50 AM Bernd Petrovitsch
<bernd@petrovitsch.priv.at> wrote:
>
> Hi all!
>
> On 22/10/18 13:07, Miguel Ojeda wrote:
> > On Mon, Oct 22, 2018 at 12:54 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >>
> >> Doing both is super ugly.  Let's just do comments until Eclipse gets
> >> updated.
>
> Yes, "Eclipse" as the IDE.
>
> And yes but IMHO better super ugly than loosing the warning - YMMV.
>
> For the archives: I have Eclipse Photon/June 2016 here. And "no break"
> is the (default) string in a comment used by Eclipse (it can be
> customized and is actually a regexp but it must be in a comment).
>
> >> I had wanted to move to the attribute because that would simplify things
> >> in Smatch but it's not a huge deal to delay for another year.
> >
> > I can re-send them later on, no problem. On the other hand, doing the
> > changes will push tools to get updated sooner ;-)
> >
> > If tools were doing something as fancy as comment parsing for
> > diagnostics, they should have been updated with the attribute support
> > (either gcc's or C++17's) -- it has been more than a year now since
> > gcc 7.1 and the C++17 final draft. (Note that this does not apply for
> > things like clang, since they weren't doing comment parsing to begin
> > with.)
>
> That would be nice. And if they agree on the same texts (or accept per
> default all somewhat widely used and/or old ones).
>
> After stumbling over
> https://stackoverflow.com/questions/16935935/how-do-i-turn-off-a-static-code-analysis-warning-on-a-line-by-line-warning-in-cd,
> looking into Eclipses Window -> Preferences -> C/C++ -> Code Analysis ->
> "No break at the end of case" screen (that's the screenshot there) and I
> tried various things:
>
> Preface:
> I have
> ----  snip  ----
> #define __fallthrough __attribute__((fallthrough))
> ----  snip  ----
> for gcc >= 7 (because clang doesn't know it and I had also older
> gcc's in use before).
>
> So:
> - Adding a comment to the #define doesn't change anything for Eclipse.
> - Eclipse looks *only* in comments for the string/regexp given
>   the warnings configuration (and that comment must be on the line
>   directly before the "case").
> - Eclipse understands [[fallthrough]] out-of-the-box though (which
>   is C++11 AFAIK) as does g++-7 (I use -std=gnu++17 - most of the
>   sources are C++, but not all) and clang++-6 (all the current standard
>   Ubuntu-18.06/Bionic packages).
>   Eclipse "accepts" [[fallthrough]] only in C++ sources (and not in C
>   sources).
> - Neither gcc nor clang understand [[fallthrough]] (so it's probably a
>   no-go for the Kernel with C89 anyways).
>
> MfG,
>         Bernd
>
> PS: clang++ errors with "fallthrough annotation in unreachable code" if
>     [[fallthrough]] is after an assert(). clang-devs there, please, the
>     fallthrough doesn't really generated code (I hope;-).
>     I have lots of switch()es which catch undefined values (for enums
>     et. al.) with "default"+assert() and fall through to the most safe
>     case (for the deployed version).

Can you send me a link to a simple reproducer in godbolt (godbolt.org)
and we'll take a look?

> --
> "I dislike type abstraction if it has no real reason. And saving
> on typing is not a good reason - if your typing speed is the main
> issue when you're coding, you're doing something seriously wrong."
>     - Linus Torvalds



-- 
Thanks,
~Nick Desaulniers
