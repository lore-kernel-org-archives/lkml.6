Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD352C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 03:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586B8222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 03:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LrRtHvQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394379AbfBPDIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 22:08:49 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:33345 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfBPDIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 22:08:49 -0500
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x1G38atP011746;
        Sat, 16 Feb 2019 12:08:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x1G38atP011746
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550286517;
        bh=p2Q9L/ltzZxjvTnn9Bbjd54by4CdgaT1jnWDmxgtbfY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LrRtHvQ5JPOf+BVDPpk7E60FeJL4VjjFij9UdqBcAFNI4tTr34WvRlsPVqBpt1lH6
         IA23UyLKklg9XNYPTHwHjc0u61B+3oxF8N6sZpTS0wgkCVuuvMzzYzyN+kRg9u3TdO
         asnnp2o5VnD+DjKmS2Et0HWFEHHgeobzh4Ubn+eDyDKX6R5Ofm1YYc3+NETPC2iVEL
         fo+yPVz9yp3X5S6FOBjjo1g8L62MSUKz1LeJ0bpHPjRt+VhK4w+W1pbNffRVZF8xIF
         K6hiiGudbnmVm7twb9Z9wzNkHxyb4xcDY5sUTimAzW9UENBgvl98fxVHRADTL5gyfD
         ubyiqJcP4lIQQ==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id q17so4232178uam.0;
        Fri, 15 Feb 2019 19:08:36 -0800 (PST)
X-Gm-Message-State: AHQUAubGUx/6xRR00+c66LGIJBWhZ2jBH6NG3IQvdg+LIX4pcHyJM9m9
        SjlcYvPvMyRHf+kzMc8RBak2EbBBVFIEJbnkZzs=
X-Google-Smtp-Source: AHgI3Ia2juXsuthv8ZyGw02D8uaGdPQ3BdOyZOLE55Az+1tNVUZUTmcMk0wcD8jm5A+wUjMYQdkYZEY0XekUCWOf4xI=
X-Received: by 2002:ab0:2a01:: with SMTP id o1mr2230009uar.42.1550286515464;
 Fri, 15 Feb 2019 19:08:35 -0800 (PST)
MIME-Version: 1.0
References: <20190211193008.24101-1-ndesaulniers@google.com>
 <20190211193008.24101-3-ndesaulniers@google.com> <CAK7LNATZY-K4g81LLvXpjp=+oMSY8L0wQoVXgHt-Bjrb2WXnNg@mail.gmail.com>
 <CAKwvOdmyNFsV=67eLQtETSDJJyDZ8aEJY1+LHuoP4OtpdQOdWQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmyNFsV=67eLQtETSDJJyDZ8aEJY1+LHuoP4OtpdQOdWQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 16 Feb 2019 12:07:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQMoYNevPns0zSaSx0iU5LA+2146snNDmy9fF8v5ej5tg@mail.gmail.com>
Message-ID: <CAK7LNAQMoYNevPns0zSaSx0iU5LA+2146snNDmy9fF8v5ej5tg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Makefile: lld: tell clang to use lld
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 8:08 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Feb 13, 2019 at 6:59 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > On Tue, Feb 12, 2019 at 5:42 AM <ndesaulniers@google.com> wrote:
> > >
> > > This is needed because clang doesn't select which linker to use based on
> > > $LD but rather -fuse-ld=lld. This is problematic especially for
> > > cc-ldoption, which checks for linker flag support via invoking the
> > > compiler, rather than the linker.
> >
> >
> > Sorry, please explain what kind of problem
> > this patch solves.
> >
> >
> >
> > [1] $(LD) is used to link vmlinux, modules, etc.
> >
> > [2] $(CC) is used to link vdso, etc.
> >     and -fuse-ld= selects which linker is invoked from $(CC)
>
> It solves case 2.
>
> >
> >
> > Is it a problem to use a different
> > type of linker for [1] and [2] ?
>
> Ideally, no, but I can think of at least one case where it might be
> problematic to mix linkers like that:
> You might be mixing linker flags added via ld-option from one linker
> that aren't actually supported by the other linker.

You can do this only when you are sure
that the _exactly_ same linker is used.

In my understanding, -fuse-ld=lld does not guarantee it.



-- 
Best Regards
Masahiro Yamada
