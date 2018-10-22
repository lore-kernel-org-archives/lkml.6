Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7F9C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBAE20651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 21:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5/KMGNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBAE20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbeJWFoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:44:13 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46250 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbeJWFoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:44:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id x3-v6so38363137lji.13;
        Mon, 22 Oct 2018 14:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CxbGsIEBKJXLFMJMwsrH4depnZVFzjL0UEhUtSqhCgc=;
        b=P5/KMGNw65Q35bdeFHk1TQv/9QBlY6zVMz/YsUU5nkht3Ajw2TjBSVC+tOAYxsaahq
         /Zz0/clKS1bRgZGq1LmLA98Z4VTFIaUBuctAkpkCCBlo5kHYz+3qKrQtjI3sh8t+Qp4J
         Rd7Cve20wKgYW1mNAiSbXhOWDIwfSto+tc4tgON7IP2HDk/1Bal2TqAQOPaVRh7n7iXJ
         oPadhEGKIjvJ8S7JTFrmyhy8j1b1oxcI45NUbg2GfPDa2pPpWCDOh91138LUFXLYuzvV
         kKfdxJQ73WIsuZC8J4rcnfP9OzOY9aIIofH3rPXQ0xEYVyNFh/7/SH6Y7NrpNf16WEUY
         cV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CxbGsIEBKJXLFMJMwsrH4depnZVFzjL0UEhUtSqhCgc=;
        b=DpZoPqadcSxYvO5eEys45owPDaQ2HvfwBI3QCFBS+xGkawIm5E4FVUgZIUoG+AeErY
         UBUzVT7TOfNjeJcmfF8R/udNW6D+U8gMO4MSoK9+EelOFSrlRrCRseuCEl2AdIYxb3QY
         GJL5hlBF6CakM+mpgYCYwmLJPWRKGrnumV3zea8QIa8RmKvvpOiIUlEDjrLqGRvXGQP7
         zy7DWZzh9GNmyre/OWhKP4xvHoKM/P6neZvsV6AGR9O1FCmC2oONfASEvNXsyUSznt2O
         yEvDhofizoxe20CuGxtniRwMzoQZuD95eIfGOxTN10CJAskgRZJbfWY9FYARIt5wCEXk
         fW3A==
X-Gm-Message-State: ABuFfoi8hX/GH2dELVaDEuLE8Vl0ReWl369EcAQrMso6N5JRLYEt50R1
        JDL1HjM6olbgZnJ6bjDElfR1USrNz/mCnMWij4E=
X-Google-Smtp-Source: ACcGV62GwZBnvhASoZye/JJlSPTuVHnBNfWeevRAXwu7h6CbjLNAm2N0sCfW7qVJaLjC/5bIrUTl5T+1ddKwJx8shNg=
X-Received: by 2002:a2e:6e08:: with SMTP id j8-v6mr33346152ljc.61.1540243437212;
 Mon, 22 Oct 2018 14:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021182926.GB6683@kroah.com> <CANiq72kOE0a4M0oCmmiWO9xTFJsybEirwUyb_ZTXpJJhc7O_TA@mail.gmail.com>
 <CAKwvOdn9hOcF01eOmwfnrH_ciFZ4fPaspSzMPiY68o3B0En-VQ@mail.gmail.com>
In-Reply-To: <CAKwvOdn9hOcF01eOmwfnrH_ciFZ4fPaspSzMPiY68o3B0En-VQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Oct 2018 23:23:45 +0200
Message-ID: <CANiq72ktOU91ghnT4eRPvBzO-xq3_Kq-RCyCB1_VSf2b+17YXw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Compiler Attributes: __fallthrough
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

On Mon, Oct 22, 2018 at 6:54 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Oct 22, 2018 at 2:48 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Sun, Oct 21, 2018 at 8:29 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > Will this work with all of the static tools that are currently looking
> > > for the comment instead?  I know coverity handles that, what about
> > > others?
> >
> > I will also contact the different tools about this.
>
> Let's contact the authors of these tools if they don't parse the
> attribute.  I prefer to have the attributes rather than specifically
> formatted comments.

Sorry, not sure what you mean -- isn't that what I said? Greg was
asking whether tools would support the attribute equally well compared
to the comment parsing; not the comments.

>
> I do think this may be tricky to provide backwards support for though;
> Miguel, do you have info on which versions of GCC support comments vs
> attribute?

It is in the commit message:

    """
    In C mode, GCC supports the __fallthrough__ attribute since 7.1,
    the same time the warning and the comment parsing were introduced.
    """

Cheers,
Miguel
