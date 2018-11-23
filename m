Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C862C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A70206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wFHy9DiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A70206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409507AbeKWVgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:36:04 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:40273 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390614AbeKWVgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:36:04 -0500
X-Greylist: delayed 20955 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Nov 2018 16:36:02 EST
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wANAq34Z026467;
        Fri, 23 Nov 2018 19:52:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wANAq34Z026467
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542970324;
        bh=ty6bBoM/zHS90bYYTMrdpT/s6grcZYWbFLZPt32hzpI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wFHy9DiHLIWcW6hcnueeA+U9g2wHl0/DwuhWKY8NSvuX0JQsNdtV0T/+/KcbcRgCi
         w6H4beGmjd2654T7QKvHmmC1/JjazdzZFJv18L/QC7nVhnGZuY2CVVWFdyiGsdSiZj
         l+4VQzvvf3DlHkpVbG09uNcrsTW73bQKhLMn4I3dLukmlWHRthp9kds4fyF9/Ym2qG
         +MprhMmPMJ6S4mG6z8U0oPX8ZUMlM+kZt0jVV3m/KqyBuHPe8d/T8YInnQ9FDrKcL0
         +iwryTT8uGT5MmQ6SwyH9TRHFISxUz8iwCEvQm5dP9LT2ggydtWsonzpHNp5duExqy
         od7DgwczBQeoQ==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id e7so6926048vsc.2;
        Fri, 23 Nov 2018 02:52:03 -0800 (PST)
X-Gm-Message-State: AGRZ1gIvz9jJJBJiqwz2mD1lRfa8SDruO+D0lwz1Gi9qk2aPrXj4fCaD
        fS94pBa/7bEKXlOJ48riDqwMLbIrbX8DonFmKBU=
X-Google-Smtp-Source: AJdET5dj17Sr3c9sxSwfFkp5KXsZT0UlqgCe5ukCRYIrAUVOyrWwFG1GBgY0RgKXmUgV5Hf+h8HYVB18vveTDrp6o8E=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr6201388vsm.181.1542970322414;
 Fri, 23 Nov 2018 02:52:02 -0800 (PST)
MIME-Version: 1.0
References: <1542726258-8418-1-git-send-email-yamada.masahiro@socionext.com> <87d7d90bf8779a997b17c917680995abc455cf11.camel@infradead.org>
In-Reply-To: <87d7d90bf8779a997b17c917680995abc455cf11.camel@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 23 Nov 2018 19:51:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQVV4hcVOvG8Yu6GFVEH=Shv=v=PkGkMghDBJbGBNSE1Q@mail.gmail.com>
Message-ID: <CAK7LNAQVV4hcVOvG8Yu6GFVEH=Shv=v=PkGkMghDBJbGBNSE1Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: announce removal of SUBDIRS if used
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 5:04 PM David Woodhouse <dwmw2@infradead.org> wrote=
:
>
> On Wed, 2018-11-21 at 00:04 +0900, Masahiro Yamada wrote:
> > SUBDIRS has been kept as a backward compatibility since
> > commit ("[PATCH] kbuild: external module support") in 2002.
> >
> > We do not need multiple ways to do the same thing, so I will remove
> > SUBDIRS after the Linux 5.3 release. I cleaned up in-tree code, and
> > updated the document so that nobody would try to use it.
> >
> > Meanwhile, display the following warning if SUBDIRS is used.
> >
> > Makefile:189: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D WARNI=
NG =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Makefile:190: 'SUBDIRS' will be removed after Linux 5.3
> > Makefile:191: Please use 'M=3D' or 'KBUILD_EXTMOD' instead
> > Makefile:192: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> No, please don't do this. This is effectively a kernel=E2=86=90=E2=86=92u=
ser ABI.


External modules are just downstream kernel code.

There is no guarantee for eternal backward compatibility.


Actually, kernel headers and APIs are always changing.

We are not allowed to break the upstream code during API migration,
but we do not care about external modules.


If you want to compile external modules
with a new version of the kernel,
you need to adjust various parts of the code anyway.
Is it a problem to ask one-liner fix in a build script?


> The instructions for building a kernel module have been this, for
> *ages*:
>
>  echo 'obj-m :=3D mymod.o' > Makefile
>  make -C /lib/modules/`uname -r`/build SUBDIRS=3D`pwd`


It has been *ages* since the external module build
was improved in the current way.

Since then, M=3D<...> is a preferred way over SUBDIRS.

This case is even nicer.
I set a one-year grace period with a clear warning message.


> People have muscle memory, they have it encoded into various of their
> own makefiles and build scripts. Please don't make it stop working
> unless there's actually a really good reason to do so.

Dumping old code is a good reason.


--
Best Regards
Masahiro Yamada
