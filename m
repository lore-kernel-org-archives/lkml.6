Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB24AC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4BC20651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tfEZ1oYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4BC20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbeJWFhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:37:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39325 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbeJWFhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:37:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id p11-v6so5138232lfc.6;
        Mon, 22 Oct 2018 14:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1/Yc5JujtwwX0NbKIXymg5eBpo08pcsE417gJv5ehyo=;
        b=tfEZ1oYO5tGKNQrp1HHoF0K4QtOllE4VXQiZX3AiD1WisMc4s2Srwz0kwfNlNE5ZFr
         WmgmOKYsKn9pMiNuef8WfcWVChge0Rn6lKoGEBRplKwBwP1qCqx3tqZhCzrpJpI7PuzI
         rwKgmzdLLvfGfqcCDTPLpA8+0WaAYsdvqyeGzcIp9ninIm4u7qtGVKNh95W8pAxisx5h
         cJaEkiI2tCbsa3Wd/E25w0zJzarVTvsoGO5AsGNCM0CAlbeGMbEDNJQUnNHmr6xpZG0D
         2JxY04sen5SB//4+Fux5tTA22LRPjjrUVd7IvRKvtxDPlurD2vR+NskJO15x6vw+ViFD
         0FFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/Yc5JujtwwX0NbKIXymg5eBpo08pcsE417gJv5ehyo=;
        b=hISRdJOtda6XDGu3PnLOiDuR3VwXSqmf9pCxxaVZYERKTjhmwgv45dMInrlWCRmncM
         Sb4/+BcCozwNiOKgfo/ZbPjmtQJixLGX+oMEFWcRFjY1fiyuoZ6QKPvTOwL5SwfiDtlm
         1ARQy6IwHs4JXcPqi2CGdKRj8Y830NOddxZvayKoNlwEjJ0QjMhzdTPjuEVmWYlQpFoE
         cWh2oC5FaLe2lRbQ1UR8bTEQuBDQFhCQF5w9BcZao4jGJMpp1dku3nR394tFAy+H1Z8O
         NTEwiWa+k3iN0z0BvjN3GRoRLi/Xzo8/eKNbGLZbRFHmGr3OYoSd4ekDf77QYGVAe437
         NIQQ==
X-Gm-Message-State: ABuFfoi947X14ZkGws1a8hZuGjvz59qWGaKQj8zYmWDJbWzN/vuecprn
        96FdLWGaHsO8kjPWkuJv2at+RUyiHAIQCF0FffPlrh2H0MQ=
X-Google-Smtp-Source: ACcGV60KB6Tgyk79xlWUIot8CRvA8eRi0MRQVn3nAK7OIOsHjUOgpj5fSsuoSMvV/zBTYCugDXFALd6Tfl8kI5j3g2Q=
X-Received: by 2002:a19:6b16:: with SMTP id d22-v6mr10373152lfa.49.1540243046845;
 Mon, 22 Oct 2018 14:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <CAKwvOdmPj_mm+9t1i=yLhvO0FAe6Kd7ezjOoTnp1fzcoikPHpw@mail.gmail.com>
In-Reply-To: <CAKwvOdmPj_mm+9t1i=yLhvO0FAe6Kd7ezjOoTnp1fzcoikPHpw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Oct 2018 23:17:15 +0200
Message-ID: <CANiq72k2z78uae1GWjECo+OB7GC90b8irt0SHYtnSXT8F2Grrw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
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
        Jonathan Corbet <corbet@lwn.net>, "Ted Ts'o" <tytso@mit.edu>,
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

On Mon, Oct 22, 2018 at 7:36 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, Oct 21, 2018 at 10:14 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > of its kind) to deal with this: [[fallthrough]] is meant to be
> > a new control keyword in the form of an extension.
>
> I think we can leave the details about the [[]] notation out. IIUC,
> it's only applicable to C++.

No, because C++ is the driving force for the standard attributes
syntax; i.e. C2x is adding them because of the syntax published by
C++17; and possibly gcc 7.1 added support for fallthrough (and comment
parsing) due to C++17 too.

Basically, it is a small paragraph explaining how this came to be.

> > +#if __has_attribute(__fallthrough__)
> > +# define __fallthrough                  __attribute__((__fallthrough__))
> > +#else
> > +# define __fallthrough
>
> While this is in the correct format as the other attributes in this
> file, I think this particular attribute is a special case, because of
> the variety of fallbacks and differing support for them.  I'd like to

No, is it the correct format because we cannot add support for the
other syntax in gcc; so the best way to proceed is to simply wait
until clang supports the GNU attribute in C mode.

The tooling, of course, is another matter and independent of this.

> see in the commit message maybe a list of tools we'd like to support

Yes, I already said I would write it in one of the other threads.

> and links to the feature requests/bug reports for them.  I acknowledge
> it's more work to file bugs, but it's being a good open source
> citizen, IMO.

Who said we aren't going to do it? :-)

I was actually in the process of checking which OSS tools supported
what and how easy it was to fix in each of them (gcc's [[...]] syntax,
clang's GNU and C++ attrs in C mode, cppcheck's fallthrough
support...), but it takes time; I prefer to do the research
beforehand; so that the submitted bug reports are better/more
precise/more helpful, etc.

However, you already sent the LLVM report (without mentioning this
thread or me, nor the -fdouble-square-bracket-attributes clang flag
that I mentioned). That is a bit rude :-) Please take things a little
easier, there is no need to rush stuff. If I didn't have submitted the
LLVM bug report is because I hadn't finish looking at the issue. In
general, I think it is polite (and also more productive to avoid
duplicating efforts) to first ask whoever is working on something
before you rush to do it...

>
> I'm also curious which is the first version of GCC to support the
> comment format?

gcc 7.1 started everything. It is stated in the commit message and
several messages/threads already. Again, please pause, relax and read
a bit before sending stuff around :-)

Cheers,
Miguel
