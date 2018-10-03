Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B5BC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B2C213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sal/xKkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B2C213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeJDEbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:31:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43842 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeJDEbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 00:31:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id q41-v6so7675273qtq.10;
        Wed, 03 Oct 2018 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=DcNfJBcvV+N7frxghQMur12JlWbuuNXGuvgJdjrvXBo=;
        b=sal/xKkq5rwbI2+2joC43ZN0ip6rMYj26GDTYJDS/wgXm8NtowPu+5gA25dDuh+yHa
         okkPAElXyGwrB6HFmCRWiVa/AD5FJbf/MRAB4YECiz+AJ4oxBaPcsJIURzE1TKN4Z9ze
         CyrtKMhc+mGc2k/T4vcawKa205hSGQaS8QcEXY+4NIEVaCkc3omnKnXVJKyzoE+nOV4t
         b8YqiZoPtiesYFig0gPVsU0YZ0wdGw0+2PtFRjGLYmQppF4/iWRD44E5KigGrMmY3ixv
         LdQ+wqqi3SWy3L3ozlkjxy4jhdCD5dyqVSbUFwVrMEL8NX8KwmAAkXs84KS50N3GNUl4
         JsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=DcNfJBcvV+N7frxghQMur12JlWbuuNXGuvgJdjrvXBo=;
        b=EVYxcHj179L0unZ4K0GH430Tg78C05OXYtkZoZ6bWmOMQ4sqCQaG9uZ4by+Yy/opZw
         dwZInM6fwYJHtRaF+l5hBdvEqrYvBlM4nzDDTgJdhjgqIP4KBiVdzEMJ5ciXr2E34h6u
         H30N+w2anQMpGlQ3Mxnx3GYSUDBIBhM892NGRwijES35U1+AcAqdcaCDIebO7NKWry2t
         2IVA3q1HyXyL69iREKFQJtp2T3N7ibcX1MkUaAFAs340kJD4HUOcUXggYxd9i2guRQGP
         cW83pXKspulDSJfZQ9EVk444UAPFajN1vN8WXOW5aAAdnc8Kepgs7xjBlk18mEGnFPf+
         cr2A==
X-Gm-Message-State: ABuFfoiXDPEQFXfeW37B82UAXBdCpEQ9lVvXlWRd/3QRHiH7eN1wKJd7
        0751yins/KtuDh9MnglekZBKdII29NeBEV9KEcE=
X-Google-Smtp-Source: ACcGV62IfciUlmeUqPMP0Tm5Q68jeE+CimzP24KFGHYdeSc9hZ1gmWuzPzJ8+5Un8Lv7x+pz52uBPoG8TN2mJ6loCAQ=
X-Received: by 2002:aed:2867:: with SMTP id r94-v6mr2937732qtd.112.1538602880400;
 Wed, 03 Oct 2018 14:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72=rgT9cPWH64Tf_8gAU09EiH5FvGqFUdOjV=spVbM5m8Q@mail.gmail.com>
 <20181003071059.02b3fd6f@canb.auug.org.au> <CAKwvOdmt4-jFv6d-ZVUH5OOvXSz38jpuNvQy-jtoSS3xEoh78A@mail.gmail.com>
 <CANiq72mmxiO6RWBTQfWYDaa6gmOF01nXmN6BJNCAjAFz3QJqqA@mail.gmail.com>
 <20181002232454.GB2483@thunk.org> <CANiq72=cRpqnB3BxLsmj-rMdUGJK+pac1SRppoRgsON69ErfQg@mail.gmail.com>
 <20181003153303.GC2835@thunk.org> <CANiq72=Jq8HZ1=CsSvV4GenG+F6z3vRFmiB7Joct5VKdUFo8pA@mail.gmail.com>
In-Reply-To: <CANiq72=Jq8HZ1=CsSvV4GenG+F6z3vRFmiB7Joct5VKdUFo8pA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 3 Oct 2018 23:41:08 +0200
Message-ID: <CANiq72nMu6NXg1Ovn49qJ=FP_S4_LQJSwPuS+Q_zofhOEbVZng@mail.gmail.com>
Subject: Re: [GIT PULL linux-next] Add Compiler Attributes tree
To:     "Ted Ts'o" <tytso@mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        David Miller <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 11:23 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Wed, Oct 3, 2018 at 5:33 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > had done with full consideration, specifically for this reason.  Even
> > if the definition was different, my definition *had* been fully tested
> > with over a 27+ VM hours of regression testing, and if it turned out

I forgot to mention that if the definitions were different, it could
have caused a problem, because your definition wouldn't apply, so your
27+ hours of testing wouldn't have mattered :-P Without the #ifndef,
we would have at least got a redefinition warning about it.

Cheers,
Miguel
