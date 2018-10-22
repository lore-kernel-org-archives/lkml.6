Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B18C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4DA20652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkAgiFPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4DA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbeJWFTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:19:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43762 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeJWFTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:19:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id p34-v6so31523864lfg.10;
        Mon, 22 Oct 2018 13:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8HCiXpAVJicrn/bOthmQj0WB0woFgZYyFT6m/r7QNpY=;
        b=ZkAgiFPyrfWPWVMR0JZ/oXcVFh2dKX0j7AQd5OHh8vLR13r/DSzT8FYSHiWX7xa5RZ
         ooCjqme8iEXBt4XaOibLXevj0ppLpsLvzBqlOSrPYeSZE6yTsGXT/aXlHOQA6BpiKumQ
         JlTJCMZAAz9UyjFCveu38LyPF+6epny6/aby7e0Oaly4DEaTB1Ac8sM4vsCFTZAYRbcb
         J8/A2Si1FvpRLHyRlD5EcnwNVYsvvblHu48vEu9doJ/6PRNk/Hn5Qag6Xf+HDn4nRl2+
         SAtWEamP0zg4jcmL1Z6aLcbYCZ1p3OhNFS6N2p96A7G98YmT7u8p5yE1b5A5iEl+WksM
         Jdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8HCiXpAVJicrn/bOthmQj0WB0woFgZYyFT6m/r7QNpY=;
        b=LWXj4gTBP0MgOTHK/KoMLoffI/mTTPuOVwH1XPLJgsQZz1drQQYVotbF4uKV7g144v
         xLqkdBRJ6LQ2KtcYULyFO/ayrztsXagJhm11SWMxKyk5PISwjvYHL+TrhY1DGBemKsmX
         ixU1FzbgJY7e8ps0L5zvnHWj3rswIzJ33B5HPuFR6zcenGdtmvm1jsmeht4nC5FFbpN4
         RN5NHS2F7LRYlfZRiLXq/XLZgcBNbKworqIKB7oyag4Beho65mhbHzkeOPtTSTqJbkRs
         Jd8lpKLZqoupI7prQbiP5F0xtB9LvPDaKknBCGhb1N4dEw/i1WiWxVUfLB/W3rzwAmMb
         ReZQ==
X-Gm-Message-State: ABuFfoiGy1N8bW2Ygt/fLckQqUbPUCaC3M4atNWzKG1HsTdfHgXxpiuM
        ZO7awwfci9wQnxNO+fbpD19Vj/fnlM6gafwrlSQ=
X-Google-Smtp-Source: ACcGV61dgQKzoiO8+p5uDi4Qdkg085WUJ4ThNeoh48AMu/fSxZ4pINNTNeLI/FTS7WNiI4A6dzf6UxRfCwHn+UAxiQY=
X-Received: by 2002:a19:11c2:: with SMTP id 63mr9961183lfr.131.1540241968459;
 Mon, 22 Oct 2018 13:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <20181021222712.GI1617@thunk.org>
 <CANiq72mXV6WTyHXNZJDTfFOpPrXD0zD6cB30bGOuKO44AvRiog@mail.gmail.com>
 <CAGXu5jKb-0H+smRAW6ngQKDZ-PbTThhMwhmu34iB8vjTa-4H8Q@mail.gmail.com>
 <CANiq72n4+HDXPqr7xySSGx49g8vEcXaxO7a-By9cSg7YSxOS_A@mail.gmail.com>
 <CANiq72kNnrhi8OPbF7P+Rw4SGYu=JuvhDKtzGtG2J5AOoC1-Dw@mail.gmail.com> <CAKwvOdn1TOzZYg_i0zB0rU+K3jaQQ8XmWnLXz01NCG9V+8PxHw@mail.gmail.com>
In-Reply-To: <CAKwvOdn1TOzZYg_i0zB0rU+K3jaQQ8XmWnLXz01NCG9V+8PxHw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Oct 2018 22:59:16 +0200
Message-ID: <CANiq72kUJOSrR=h2=2jXfkBPLrR=DrN8X4OoKOqAte4sMLxkdQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Ted Ts'o" <tytso@mit.edu>, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan <dan.carpenter@oracle.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        David Miller <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 7:17 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Oct 22, 2018 at 2:43 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Mon, Oct 22, 2018 at 11:41 AM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> > >
> > >   * clang does *not* support the attribute in C.
> >
> > ...nor the warning at all, by the way (which is why this is OK).
> >
> > Cheers,
> > Miguel
>
> Oh? We're going through and annotating all of Android's C++ source
> right now with it.
> https://clang.llvm.org/docs/DiagnosticsReference.html#wimplicit-fallthrough
>

Sure, but I am talking about the C mode only. Please read the previous
messages in the thread :-)

> Though it looks like the attribute syntax I like from GCC is not yet
> supported in Clang.

Indeed, that is what I explained in the last message.

> https://bugs.llvm.org/show_bug.cgi?id=37135
> https://github.com/ClangBuiltLinux/linux/issues/235
> I'll take a look at adding support.
>
> So Kees sent me this embarrassing example:
> https://godbolt.org/z/gV_c9_
> (try changing the language from C++ to C; it works)!  That's embarrassing!

Yup, that is what I have been testing yesterday -- see the linked
thread in the commit message for the summary of the results.

> https://bugs.llvm.org/show_bug.cgi?id=39382
> https://github.com/ClangBuiltLinux/linux/issues/236
> Will get these both fixed up.

Cheers,
Miguel
