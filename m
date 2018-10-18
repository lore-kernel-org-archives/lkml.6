Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1FFECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F6121470
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ysrjk40B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F6121470
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeJRJN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 05:13:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44198 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeJRJN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 05:13:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id p23so28143290otf.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 18:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aGuzJU80PFUHIskyAueEiEH4rpUPgJ8eZQqpuYFEm1I=;
        b=Ysrjk40B5o74rAN1O0ctn0ffD31V1ZJ8SgeerE16XK2YHIQ90RFo/QX1VHncxsurZB
         BCWXQoRCIwuyKMtl3cln1LGZICaNmzsSKqx3L8HXqmPAm/fzoIbGr0EkQsQfaRypPYmC
         7hPNbDQwqr8NLrp0q1HodrrE83uWWm/NJNEApkncLqUlF5eUNwXGVmH/h7Vi9c8WKUtA
         /DaYade5/5NOtErqs8UWScrulmz7iEfFMbe3zElZZma6y33rb+2B/0Kt4AIPAafIPnqy
         JGZLrAi0psFlSPqHdzf2vXHdyeGO5ZkWHJ7ocdoiTZJ7fJ9TdZOVtUeDd9xH4StFD+uP
         Pvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aGuzJU80PFUHIskyAueEiEH4rpUPgJ8eZQqpuYFEm1I=;
        b=WxVSYWm1Hz8sY0NyXBbpH+vExCmKPfBNCuo4ykTfi03QWpyM48en5j4snQmNlIBI8n
         iGAAeOl+6d6QkbWq4+DR7v8qsBZOC7RsZHD5FV1YMdZ9eFbP8rHdTIDBjIthU11PLJb+
         MHv/ZEICHqDBAKBwMO0cHLMLGa1KZ4pDfbxhBrgocql6esVZKQy6NLaFJdWZ0rgLdO4g
         pXCwsnmKDKIRVQF2iwFmgRRJ7ae6SIsMmRd+06xscyeVmI3eoGFy9yZbOxIDB+s+y3Ew
         fcdWRBjZ+OKG6TEh0uQoSB2SeXJCPpI4Or6Ktnb654Q+l7JmG4Lx3w47t0fKuRl8Ifdo
         hTFA==
X-Gm-Message-State: ABuFfohvnjqxOABWv9S6QzMZtAXRNaCwRbGPNZ7+rJ6Z7AYuB9WvURT1
        FLLcwm2jnnquo2OEVCxVqNLsLdmP3f2FjWcI9Ecr3A==
X-Google-Smtp-Source: ACcGV60pkAeS+H2+VwyI3Hl2WIiugmNMxFN/t7GpYHhuOYPE3cKqvCILzUIVyj1YoAcS1tJzQ3SWIJw/Xk+8PFm0Jb8=
X-Received: by 2002:a9d:2117:: with SMTP id i23mr17274277otb.230.1539825301680;
 Wed, 17 Oct 2018 18:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
 <20181016235120.138227-27-brendanhiggins@google.com> <CABGGisyMYC12UZtZ3wBw_1GO1Qq9-MEzSznq0r8796kVsQ6DoA@mail.gmail.com>
In-Reply-To: <CABGGisyMYC12UZtZ3wBw_1GO1Qq9-MEzSznq0r8796kVsQ6DoA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 17 Oct 2018 18:14:49 -0700
Message-ID: <CAFd5g445rkyALoe=RYsSzsn_coDX67c8dYC+8EAG3gXbAzMkPQ@mail.gmail.com>
Subject: Re: [RFC v1 26/31] arch: um: added stubs for mock iomem for KUnit
To:     Rob Herring <robh@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        shuah@kernel.org, Joel Stanley <joel@jms.id.au>,
        mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 3:28 PM Rob Herring <robh@kernel.org> wrote:
<snip>
> > diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
> > index 07f84c842cc31..72e7efb74f7fd 100644
> > --- a/arch/um/Kconfig.common
> > +++ b/arch/um/Kconfig.common
> > @@ -19,7 +19,13 @@ config MMU
> >         default y
> >
> >  config NO_IOMEM
> > -       def_bool y
> > +       bool
> > +       default y if !KUNIT
> > +
> > +config HAS_IOMEM
>
> HAS_IOMEM is essentially a disable flag for lots of drivers on UML.
> Ignoring drivers, it doesn't really control a significant amount of
> code (albeit small amount of code you need for this series). As a
> driver disable, it does a poor job as lots of drivers aren't MMIO and
> aren't disabled. I think we should decouple these 2 things. Perhaps
> get rid of the driver disable part altogether. We already do 'depends
> on ARCH_FOO || COMPILE_TEST' for lots of drivers.
>
I think that makes sense. Any code that can build should be able to
build under KUnit, but we probably want to turn that on on a per
driver basis as we write tests for them.

> Also, I wouldn't be surprised if turning on HAS_IOMEM causes UML
> randconfig failures. Arnd does lots of randconfig testing and might be
> willing to help check.
>
It almost certainly would fail randconfig. As you point out below, I
don't implement everything that's required, just enough to show off
KUnit in a couple examples.

> > +       bool "Turns on fake IOMEM support for KUnit"
> > +       depends on KUNIT
> > +       select MOCK_IOMEM
> >
> >  config ISA
> >         bool
> > diff --git a/arch/um/Kconfig.um b/arch/um/Kconfig.um
> > index 20da5a8ca9490..8d35e0e2c23d1 100644
> > --- a/arch/um/Kconfig.um
> > +++ b/arch/um/Kconfig.um
> > @@ -122,3 +122,8 @@ config SECCOMP
> >           defined by each seccomp mode.
> >
> >           If unsure, say Y.
> > +
> > +config PLATFORM_MOCK
> > +       bool "Enable a mock architecture used for unit testing."
> > +       depends on KUNIT && OF
> > +       default n
> > diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
> > index b10dde6cb793b..9fd2827ab76d1 100644
> > --- a/arch/um/include/asm/Kbuild
> > +++ b/arch/um/include/asm/Kbuild
> > @@ -12,7 +12,6 @@ generic-y += ftrace.h
> >  generic-y += futex.h
> >  generic-y += hardirq.h
> >  generic-y += hw_irq.h
> > -generic-y += io.h
> >  generic-y += irq_regs.h
> >  generic-y += irq_work.h
> >  generic-y += kdebug.h
> > diff --git a/arch/um/include/asm/io-mock-shared.h b/arch/um/include/asm/io-mock-shared.h
> > new file mode 100644
> > index 0000000000000..6baf59cb17a58
> > --- /dev/null
> > +++ b/arch/um/include/asm/io-mock-shared.h
> > @@ -0,0 +1,33 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_UM_IO_MOCK_SHARED_H
> > +#define _ASM_UM_IO_MOCK_SHARED_H
> > +
> > +#define readb readb
> > +u8 readb(const volatile void __iomem *);
>
> What about all the other flavors of MMIO accessors like __raw_readb,
> readb_relaxed, etc.? readX/writeX is intended for PCI based drivers
> which doesn't seem to be what you are targeting in this series.
>
Those need to be done too. I just mostly wanted to illustrate that it
can be done, and what is needed to support mocking MMIO. I wasn't sure
how controversial my approach would be, so I didn't want to put any
more work than was necessary for illustration without getting some
feedback.

> I think it would be good if this capability was not just on UML. I
> could also imagine wanting to run tests on real h/w. Perhaps you just

I think that's reasonable.

> want to log and/or check i/o accesses. Or you need some dependencies
> in place rather than trying to fake everything (clocks, gpios, pinmux,
> irq, etc.). That being said, I'm not trying to add a bunch of things
> for you to do. Though maybe it makes sense to split this series some.

Almost definitely. I figured this patchset, as is, is a good
illustration of what I am trying to do, what is possible, and the kind
of work that is necessary to get there. If people like what I am doing
and want more of this type of thing, I think focussing on getting base
support in and then working on features separately is the way to go.

> How many of the patches are needed to convert the DT unittests for
> example?

At first glance, just you probably only need the stuff in the first 9
patches for that. You don't appear to be doing any IO of any sort, so
you don't need this stuff. You appear to depend only on some fake
data; everything else seems pretty self contained, so you don't need
any of the mocking support for that. So if I understand correctly you
just need the base support needed for bare bones unit tests, all that
stuff is in the first 9 patches.

Cheers
