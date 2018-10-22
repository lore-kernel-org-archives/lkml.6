Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741F8C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C78820663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilEHMf24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C78820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbeJWFyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:54:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47047 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeJWFyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:54:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id x3-v6so38385599lji.13;
        Mon, 22 Oct 2018 14:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aA5PzG9j8MlbvCqFbqMudH/mSDUJ54+dkNvas0/8RiU=;
        b=ilEHMf24/ktfRV+xbxOCyibMtTxVAqVDbicGh29aHsDlp/jkNwRLo5wn/6fHk2vnHk
         nigQWMBSEO9Vo1nY44xCio2tCBQnCKzLFz9Hw2GW2Sav26cecDazKm+5LJxZyj7MkuaJ
         NntA3+ncP2v55P/Nms6BHuOKP6QolH/+OOePwA499rVUoRQf9R9EYrqmehmCpubSUJCS
         lpk2wiPyRJTbbKcnACI+6fEEDWknrY48yMYYuVay9E+/g0iqRxwKStQ9K26BrjvafTNy
         nwi3PaDgPUpRwXA+11Ryh0/vdDBsmFPFAsr7GoWMt2d+3q7wwQpYM7Xdnq8ZHEj8rYka
         ejjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aA5PzG9j8MlbvCqFbqMudH/mSDUJ54+dkNvas0/8RiU=;
        b=IJNhyMRjat90PTw/vNPUo8baCY+nhBIJYuphlLdcX5smKY5Fz8dm7tAl9I7+qnBP5p
         hF6Lf4rFWd2W0jFEyRI+0Lce9RV5f7dhYD46Tjk8j+I/CU6OwWfdxFPPxM4hym5qS2TK
         MV/+pf+oC9ZqSK5ETd7piPAlCyRrgehD62p4JsaIqPzswnm8a529Z9QJsT3ZsLKjPhz9
         VSCXylt53sZczAg9CsP8vjweOdfUKeVrhvW3/yYkf4+aH5JUS7JPVB48NfQxEcfRxcbd
         LudLdELS/XlrxhiArGQOT7NmKS4GCK+j0Upd15tE43QaEtl7JsaN3V7D9qWMvvE73qG+
         p/YA==
X-Gm-Message-State: ABuFfoguU+7pmodLcp2DspeZrytBRKlnXxOjxF0Y69C0ivjMf+I7UV4b
        3ZHg9OyJLRVMxpqRXPCspDE80KCoY2c50UKoeKo=
X-Google-Smtp-Source: AJdET5fxeHI/UQTCVOTWOCkipj4+rdQ+wV2DMaZlEp//EFB/vPl7/0P4EN20xsk1pgGWvDgoLDayGndipDrLewF7gvo=
X-Received: by 2002:a2e:5c2:: with SMTP id 185-v6mr629885ljf.127.1540244068349;
 Mon, 22 Oct 2018 14:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <20181021222712.GI1617@thunk.org>
 <8fb78062-b6d4-6f2d-d943-44bec6b95ff0@petrovitsch.priv.at>
 <20181022102743.nua5fgbscyeymzal@mwanda> <1474d995-1b5a-2efb-f077-33eb4a5d9e31@petrovitsch.priv.at>
 <20181022105314.j6djkrpwbnokhai5@mwanda> <CANiq72=ioYcRA-yq38+Z4i6iVDNm6C2-+b4feRmnvEiekuR7dA@mail.gmail.com>
 <3cbb5345-0270-5575-7563-6ad37d888e42@petrovitsch.priv.at>
In-Reply-To: <3cbb5345-0270-5575-7563-6ad37d888e42@petrovitsch.priv.at>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Oct 2018 23:34:16 +0200
Message-ID: <CANiq72kLOV63XZx2zCnnSuvEyXucqpnjb5dnF=gRZ_q-hEGO2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
To:     bernd@petrovitsch.priv.at
Cc:     Dan <dan.carpenter@oracle.com>, "Ted Ts'o" <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Mon, Oct 22, 2018 at 7:50 PM Bernd Petrovitsch
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

I think Dan meant too simply not touch anything (i.e. not losing the
warning anywhere).

>
> For the archives: I have Eclipse Photon/June 2016 here. And "no break"
> is the (default) string in a comment used by Eclipse (it can be
> customized and is actually a regexp but it must be in a comment).
>

Hm... that means they don't support (by default) the same regexps as
GCC; which is bad: it means that it is only equivalent to the most
relaxed level in gcc, 1:

    """
    -Wimplicit-fallthrough=1 matches .* regular expression, any
comment is used as fallthrough comment.
    """

    See https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html

i.e. any other level above will either not match Eclipse or not match gcc.

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

It shouldn't according to the standard -- but who knows... :-)

> - Eclipse looks *only* in comments for the string/regexp given
>   the warnings configuration (and that comment must be on the line
>   directly before the "case").
> - Eclipse understands [[fallthrough]] out-of-the-box though (which
>   is C++11 AFAIK) as does g++-7 (I use -std=gnu++17 - most of the
>   sources are C++, but not all) and clang++-6 (all the current standard
>   Ubuntu-18.06/Bionic packages).

Eclipse understanding [[fallthrough]] is very good, actually.

>   Eclipse "accepts" [[fallthrough]] only in C++ sources (and not in C
>   sources).

Bad, but I guess they will add it to C eventually, since it is
probably coming for C2x.

> - Neither gcc nor clang understand [[fallthrough]] (so it's probably a
>   no-go for the Kernel with C89 anyways).

clang does it if you enable -fdouble-square-bracket-attributes (please
see my other messages). gcc will at some point (if C2x gets the
attributes), but at the moment the C parser is different than the C++
parser and there is no support for it on trunk that I could see, so
they will have to copy the support; i.e. it will take a bit more time
than clang, likely.

Thanks a *lot* for taking a look at Eclipse!

Cheers,
Miguel
