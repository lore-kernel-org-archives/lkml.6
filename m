Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283B0C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 04:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A935C2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 04:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Zoi5LYO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfAGEdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 23:33:51 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:47223 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfAGEdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 23:33:51 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x074XXn3031358;
        Mon, 7 Jan 2019 13:33:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x074XXn3031358
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546835614;
        bh=tKjrh6et2QA3LF0UXKDMzOelz+4nd2/egH18eO4PRrE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zoi5LYO4WGRgvlB70YH4R+JwbknrqoXl+HfMVJgtZD0JkN8h2aJ4nkgQg+JzJRgzg
         Hqr8J0VjoxDsdyOrz+nKngEi5y4W5zOe7RGTTTEh2v5BrQ9lVDzcd5XDkbTr3F+ETZ
         oMct4D7oSR6UWGflyDworV2cVJacIzugAL70aNCwuSRJT5Py1mNuJ+KGztoKGf5JAa
         1Kx2qnEQ3ZLATngH2EQNTe/67kzqEouo4yUXES24Gm5O+FMiHrvQiFIRZ31jK0EybB
         autDTXWZREuljN7pSfIPKcGmxiizPT2GckwuG/l7w13BI7pBIUl2d9jl7Y7HTU4Sqn
         h8CnCsBL8VnoA==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id x28so25959589vsh.12;
        Sun, 06 Jan 2019 20:33:33 -0800 (PST)
X-Gm-Message-State: AJcUukfozS+qLKIoJqVx0zS7edf8dTwj7MbXEiukTZjoPJmK85w7OsIw
        q7THGa7Ox/AhnjzdfxGIapMyh5suRp2iohEphJw=
X-Google-Smtp-Source: ALg8bN6hDChbR/FvyOgA9wZdyM67b4f3wH3u/y4sY6FcCKYZEbXy8asFqKgiar+QXpeo1EYCt98HKcFGZEJiDqYuuzg=
X-Received: by 2002:a67:385a:: with SMTP id f87mr24426928vsa.179.1546835612831;
 Sun, 06 Jan 2019 20:33:32 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNARQggM3aKEPRKJqa4tunFAfmfErMZuS-rrnRv6UB1VpPQ@mail.gmail.com>
 <CAHk-=wiLt3rgeyM3BWAd5VJrKcnxxuHybwoQiDGMgyspo6oXDg@mail.gmail.com>
In-Reply-To: <CAHk-=wiLt3rgeyM3BWAd5VJrKcnxxuHybwoQiDGMgyspo6oXDg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 7 Jan 2019 13:32:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNASpO86yNe4BWBYnfd+r82=d_ofxYybLi_aM+4+dgf46+A@mail.gmail.com>
Message-ID: <CAK7LNASpO86yNe4BWBYnfd+r82=d_ofxYybLi_aM+4+dgf46+A@mail.gmail.com>
Subject: Re: [GIT PULL 2/4] Kbuild updates for v4.21 part2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+CC Changbin Du, Arnd Bergmann)



On Sun, Dec 30, 2018 at 6:01 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Dec 28, 2018 at 8:00 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Introduce a new option CONFIG_NO_AUTO_INLINE as well. With this option,
> > only functions explicitly marked with "inline" will be inlined. This
> > will allow the function tracer to trace more functions.
>
> Ugh. This causes new and bogus warnings, because gcc doesn't see some
> of the checks.
>
> For example, the x86 emulate_vsyscall() function now warns that
>
>     warning: =E2=80=98syscall_nr=E2=80=99 may be used uninitialized in th=
is function
>
> because addr_to_vsyscall_nr() isn't inlined any more, so gcc doesn't
> see that the return value is always smaller than three (and then it
> doesn't see that we handle all the cases in the switch statement
> later).
>
> So honestly, these "debugging improvements" have a rather nasty side
> effect. I'm not at all convinced that we should do this.  It is *not*
> worth causing extra development pain with a totally pointless option
> that changes code generation radically like this. It's going to cause
> lots of extra churn.



Sorry for late reply.

I know this series was rejected,
but I felt guilty about being completely silent.

So, here is just my two cents.


For addr_to_vsyscall_nr(), we can fix it by marking it as 'inline'
(or __always_inline).


IMHO, it is not so bad to tell the compiler what we want.

In most cases, it is just a matter of 'inline' marker,
although I admit this process is kind of painful...



> This branch already added a couple of extra inline markers just to
> make code work reasonably. How many tens (or hundreds) got missed just
> because the build still works, but the lack of inlining means that we
> generate completely garbage code?


I do not have the exact number, but
my impression was "not so many".

Changbin and Arnd might have better insight.
They were trying to eliminate potential problems beforehand.

For example,
7e17916b
412dd15c
08813e0e




> I'm going to skip this pull request.
>
> We have basically always required a certain level of competence from
> the compiler, and this basically says that the compiler can do stupid
> things and we'd have to fix those stupidities by hand.
>
>              Linus



--=20
Best Regards
Masahiro Yamada
