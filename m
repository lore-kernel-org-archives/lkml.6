Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299ECC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D8A20700
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jp/kr+dn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfBTUCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:02:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38088 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfBTUCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:02:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so10162889pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 12:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=112zj6PRaNXWgIVj94nd+tIs7m+rINcfBIyQEFXR0Pg=;
        b=Jp/kr+dnK71oGHB9Tx0lEr3BSYMspX+z9Nh9j/nldJotDy7CDUx9stfQh4XrKNEArF
         uAQjHt9fcb7qSNAyP1+MaQWx+EoCX0r7l/9pwGKk+B0mjlGMJpB2L0zqfrtYCY5Ryc0h
         /nRHbHEG5UF5WoOjXwp7bI1mdFY8OZc4J+o5q7q6gLo9dhWxGBGqXEvaCfZtcCWVNftv
         E3v2m8DuUE6sCfb7zU4FVjnQqlMsU/7kPmEpy+Za6wxcckNc7KjnprrT/77OTloX/MsV
         4AGXOvVi7l/viGkRi3LitvXeAaWtQCR24usoAWYJxqHHAx4Z8ITZFUVS+1YhelkY0plt
         o5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=112zj6PRaNXWgIVj94nd+tIs7m+rINcfBIyQEFXR0Pg=;
        b=WKnF3IPuc5517EEnpR0fR0jvL2A58MO0KLVi+s4pimDAp6EGcsN4g+ewjrMkC/kwgF
         9vZ1fkSifcyaHEZJNQHJtAQaDSgSdIYhsYLhezJMmVsfpnVkqCXntp0fU8uk+FFmqdHt
         ds7mzl0oGWhTMg5io5foYwJeDl1xvruBrzNT5VbJFVhdXkNjt16cFb/jSO23Xw52u/vr
         SJ31SoF7MkI6p1H8hBWLJt1A+HAx1fskBErmavetxCPI5c3yCCpOx/NTp2U/ltsfK6Wm
         kGg8heuVspznzw/GJ4VjIJJFkryWVnZnLRLC6mnT0jjPIKQQb7zYPaR3scCtgBmSs94F
         ORKQ==
X-Gm-Message-State: AHQUAua4CuAo+/Q32ENRzM3o2ftxrmHgWX0uF40PUSh/2pdcPL+Gn46g
        A+LR/O8yOo8gaOjh9HXLqzmZeQhXmXwSI6AX3ZQb9w==
X-Google-Smtp-Source: AHgI3IZbrxZ7YGELiS4WQnWNOJzilpHs1QhU0rF6ImrEsYFiXxhXrzU/XxeB+WMQlQMqrvSvajP/gAcTAPhTl8SLCIs=
X-Received: by 2002:a63:fe58:: with SMTP id x24mr30887173pgj.255.1550692961511;
 Wed, 20 Feb 2019 12:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20190219214940.391081-1-arnd@arndb.de> <CAAeHK+xSpsu0tNmeq0wKXfT=0HuORnvU+XzLswDzhbtfZVa4Hw@mail.gmail.com>
 <CAK8P3a1NfHohd1xT7iHK85L2PGnD95RJvwFi-2cWrFpipQzqwg@mail.gmail.com>
 <b109ad0d-6995-8ca2-5426-7e2627d2032c@virtuozzo.com> <CAK8P3a0tg1WRLK=fs9S+X4TPB7sR55ZsjMbBVX07AtAfguXCsw@mail.gmail.com>
 <CAKwvOd=XrNNb=r3qgsT8O6JNzL4hg4pqfJJFcY2DzA0Ooc=E3w@mail.gmail.com> <20190220184408.GG9878@sirena.org.uk>
In-Reply-To: <20190220184408.GG9878@sirena.org.uk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 Feb 2019 12:02:30 -0800
Message-ID: <CAKwvOdne3aE5bUsQF-2C-L2Xezqq9qb=NqF8FA+B7nvqXKAXFA@mail.gmail.com>
Subject: Re: [PATCH] kasan: turn off asan-stack for clang-8 and earlier
To:     Mark Brown <broonie@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, Qian Cai <cai@lca.pw>,
        Alexander Potapenko <glider@google.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:44 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Feb 20, 2019 at 10:07:36AM -0800, Nick Desaulniers wrote:
>
> > I like Evgenii's idea:
> > https://bugs.llvm.org/show_bug.cgi?id=38809#c10
>
> That's a suggestion to tune the inlining heuristics.

Yes; but it will also improve KASAN (if feasible).

> > While I myself share Arnd's goal of driving compiler warnings to zero,
> > in general I'd prefer not to disable warning-producing-features or
> > disable warnings outright for cases where we have some ideas of
> > changes we can make to the compiler.  There's probably a list now of
> > false warnings produced by old versions of Clang from bugs in Clang
> > that we fixed.  I'm not interested in additionally trying to work
> > around those somehow in kernel sources.
>
> We do have infrastructure in the kernel for managing warnings based on
> compiler version (Arnd was looking at some improvements to that IIRC),
> if we've got a kernel that builds with a given compiler it's worth
> looking at tuning what we do with that compiler.  If newer versions of
> the compiler work better or have new options we can turn things on for
> them.

so maybe something like (pseudocode):
if kasan && clang && clang_version < 9:
  disable -Wframe-larger-than=

If you overrun the stack with KASAN, a warning would be nice, but
you'll hopefully find out the hard way at runtime.  And that doesn't
require up to 114 Makefile changes, which would be kind of obnoxious
for this papercut.

>
> > Qian previously pointed out that most drivers don't produce this
> > warning under KASAN+Clang.  While 114 is a lot, what are the chances
> > that someone NEEDS a KASAN+Clang build to compile warning free and
> > happen to include one of these problematic drivers?  And if there is a
> > chance they do observe the warning, are we doing a disservice by
> > disabling the feature (-asan-stack=1) outright for the whole kernel,
> > or disabling the warning (`-Wstack-frame-larger-than=`) which can flag
> > issues unrelated to KASAN?
>
> People doing treewide work and subsystem maintainers are a reasonably
> important target for this sort of thing - for example people looking at
> the kernelci output.  It's a lot easier to pay attention to problems if
> you don't have to wade through large numbers of false positives.

Good point.  Current reports are a flood of -Wframe-larger-than=
because of KASAN (we've fixed just about everything else), and I have
to pick out what's new from that sea of false positives.  I would hate
for these warnings from KASAN to be the last thing before people start
taking clang builds seriously due to false positive warnings.

-- 
Thanks,
~Nick Desaulniers
