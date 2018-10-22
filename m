Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ABAC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7D82083A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQyZUtHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7D82083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbeJVRu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:50:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44895 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeJVRu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:50:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id v6-v6so36274426ljc.11;
        Mon, 22 Oct 2018 02:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DoeTa8clP94vb0y/U8jIPON2PaapmjHGUcCLCmMk7Vw=;
        b=qQyZUtHRAuOAxVghkpd5ekwLMIYwHHJ34u0szYP27d6r2YhoBkjyOFsNslNL3Xfe4O
         aUl6FhmstaLwh7TAOybQC0cnAQyyC8fT8Hm6wsIRRXzqTbByKLDIoB2ifb/I7uAiN1US
         5dHIIGWegYh5CKyVo/D/9xIbh7gyDAQ2WxhLHGYKXk209U/z+R9IN7nyWnQiwZ4jC26i
         B5CVldbOB4leqhUIc1+GuQUgjcmb9gfFRTWNS66wnTfiP3RwcC3OnJ3SStHreD9SPytD
         iZNRLRJVHFvIrfAlZ5DAY1hPN9Qmqo4ZVsbS74YQIE4LZ9VbkXspL29cvK6DK3cj3AbF
         p0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DoeTa8clP94vb0y/U8jIPON2PaapmjHGUcCLCmMk7Vw=;
        b=lkgOs4hNWjpvJMwjVy6ULL4UUeoK/S5FQPcWIjOdfHV1PgrKPR27tjtunyBpMBnHIA
         Cm3TeTwyJYUkC3yTJBuXNNt8E354gMdtHo2driF8loMbK11YVuabF1EuxpgPvASu+Yxp
         AsHHsAB9V16QE8METMuJYakoIb9/33nsZc4s6axTnfvn18/TDsWYCEGVe43cnEbnPQ7T
         49IFsScDjDuWHWUwyQUyN/QbZYDIqax2IJ5lJzIGfNkk/lfTHWcNs3ZPFLW5krjwJDwp
         iHr0J8ekoVzhcMR+20ScrVVQpMspeAX34fFPZfSzpfl3np5fsjbmYg42vQsHAmg5hwNY
         VSMw==
X-Gm-Message-State: ABuFfojK3VH2yvsjL/koIKGi9rpLqPFtGfrDLvu7M4BJ19p1O8VtJNe9
        iUDugltC/x5LvrHAe1IHMKqa3W/0x7dZxw+jBRA=
X-Google-Smtp-Source: ACcGV626FKF3oCuV+QMkX5ZivgfTrUV0Ns/l54n3km4u5SpB/d77J+Jxzfmo2McbVOriA6xJyOTun9jJip1zIsGHJic=
X-Received: by 2002:a2e:9d7:: with SMTP id 206-v6mr31349614ljj.127.1540200761001;
 Mon, 22 Oct 2018 02:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <20181022004217.GA4941@bombadil.infradead.org>
In-Reply-To: <20181022004217.GA4941@bombadil.infradead.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Oct 2018 11:32:29 +0200
Message-ID: <CANiq72nKkJgLuHVTEZAMPcrXeTd1OvP2owCAUjqnYtru4JeMYA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
To:     Matthew Wilcox <willy@infradead.org>
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

On Mon, Oct 22, 2018 at 2:42 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Oct 21, 2018 at 07:14:13PM +0200, Miguel Ojeda wrote:
> > +#if __has_attribute(__fallthrough__)
> > +# define __fallthrough                  __attribute__((__fallthrough__))
> > +#else
> > +# define __fallthrough
> > +#endif
>
> Why is the #else not:
>
> # define __fallthrough          /* fallthrough */
>
> Would this solve the Coverity problem, or does Coverity look at the raw
> source code before preprocessing?

That wouldn't work if Coverity follows the standard, because it is
required that comments are removed right before the preprocessing
phase.

That is one of the advantages vs. the attribute that I mentioned:

    """
    We can actually use a #define for it like for the rest of
    attributes/extensions, which is not possible with a comment, (...)
    """

Cheers,
Miguel
