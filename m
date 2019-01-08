Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D24C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A512089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1svwCOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfAHJsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:48:30 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40317 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfAHJs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:48:29 -0500
Received: by mail-vs1-f67.google.com with SMTP id z3so2074151vsf.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SdWSdZKQoBjiJH/4qdCEMKqURCxYsoxn1mik+e6P1ng=;
        b=u1svwCOknjtO2VZ27q6q1v7Pd/20qqElikNPB2VDJzD9fMhgtVfqcN2uyQZkJAeZX/
         CC3SbHgNN8fM7ZVsGDv0yIelf2ZPiOUANQLs1IZI2cY75+qvXPhr57vrN4XzKtsXjqsH
         9a206lNdPH3stl30LiSbuCjPrfPVLWI6T4XQVqZrIzGoCSNgpqaBLTg1LYQZI7PfofOg
         v9NDnvYaptxb7ZXQ/q69eUEH4baHxwo1A1dGAP1jJjpMgnh84gcL9Yb3Zz9frAxcnZ6O
         OQrqXyBP62h1I0R880aRhnFoDKEIJKokblCcXEdaQvJTvxbrQbXa6kNNdsHeo0wuQp8J
         gG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SdWSdZKQoBjiJH/4qdCEMKqURCxYsoxn1mik+e6P1ng=;
        b=Ote3fBZ+NAfXVVqSe4JuTmA0Kou2FR1RYqjMUkEdDmpCSZjQBRzl2JcJxFzi3vY0S1
         8A3XLhLVdTNXvubn0PMgqxdCcMVYeUw4RdEinD4YmE/xxjeOCXAfii9ga52UeM1Gq5yV
         5Aa5GBuL7xJudqEfH+bdSWhzyxehwH23yl+4WF/bRIpLpaxY22m7m4pfSsGpsi5yWT3v
         l4ZSI1nN+AJcfDEaeOUowHy2bOIVZhkc77ViymeHT2PQX1V1sdfQr/2/FhFz+NjsROh+
         DwhRIUzJ7j7XPGgfMtntiR8t/usdrCj1KscWtPvDojbkQ7lSl7us/XSMdxJMrB1YPv6t
         FkoA==
X-Gm-Message-State: AJcUuke0kdt5lfajLyBHXL+uFeTm+exXC8eK6X3fpFhj1W0rD6xieROq
        3K8qRv1kkbW2vWBUQHDY1u5rTBQ3LVJ05ZkIMTQuww==
X-Google-Smtp-Source: ALg8bN78fAngS7rKFMWTyCgk4TKLIsvZdZarRTfd1W4iYXkn9CbLZCGQ+7J90sy608fubAs+b8cNB9wJ2alYbq5P4BA=
X-Received: by 2002:a67:88c9:: with SMTP id k192mr416911vsd.103.1546940908443;
 Tue, 08 Jan 2019 01:48:28 -0800 (PST)
MIME-Version: 1.0
References: <20181211133453.2835077-1-arnd@arndb.de> <20190108022659.GA13470@flashbox>
 <CACT4Y+a_LB6aVoLEcFVJhP40D9E4MM3T=7-0aBhFvBffXgNZmw@mail.gmail.com>
In-Reply-To: <CACT4Y+a_LB6aVoLEcFVJhP40D9E4MM3T=7-0aBhFvBffXgNZmw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 8 Jan 2019 10:48:17 +0100
Message-ID: <CAG_fn=XQsZ5AHj2f10_xmOzb3PUeQgT52-0XLD-W6kAb8xx0sg@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix kasan_check_read/write definitions
To:     Dmitry Vyukov <dvyukov@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 5:51 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Jan 8, 2019 at 3:27 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Tue, Dec 11, 2018 at 02:34:35PM +0100, Arnd Bergmann wrote:
> > > Building little-endian allmodconfig kernels on arm64 started failing
> > > with the generated atomic.h implementation, since we now try to call
> > > kasan helpers from the EFI stub:
> > >
> > > aarch64-linux-gnu-ld: drivers/firmware/efi/libstub/arm-stub.stub.o: i=
n function `atomic_set':
> > > include/generated/atomic-instrumented.h:44: undefined reference to `_=
_efistub_kasan_check_write'
> > >
> > > I suspect that we get similar problems in other files that explicitly
> > > disable KASAN for some reason but call atomic_t based helper function=
s.
> > >
> > > We can fix this by checking the predefined __SANITIZE_ADDRESS__ macro
> > > that the compiler sets instead of checking CONFIG_KASAN, but this in =
turn
> > > requires a small hack in mm/kasan/common.c so we do see the extern
> > > declaration there instead of the inline function.
> > >
> > > Fixes: b1864b828644 ("locking/atomics: build atomic headers as requir=
ed")
> > > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Alexander Potapenko <glider@google.com>
> > > ---
> > >  include/linux/kasan-checks.h | 2 +-
> > >  mm/kasan/common.c            | 2 ++
> > >  2 files changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-check=
s.h
> > > index d314150658a4..a61dc075e2ce 100644
> > > --- a/include/linux/kasan-checks.h
> > > +++ b/include/linux/kasan-checks.h
> > > @@ -2,7 +2,7 @@
> > >  #ifndef _LINUX_KASAN_CHECKS_H
> > >  #define _LINUX_KASAN_CHECKS_H
> > >
> > > -#ifdef CONFIG_KASAN
> > > +#if defined(__SANITIZE_ADDRESS__) || defined(__KASAN_INTERNAL)
> > >  void kasan_check_read(const volatile void *p, unsigned int size);
> > >  void kasan_check_write(const volatile void *p, unsigned int size);
> > >  #else
> > > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > > index 03d5d1374ca7..51a7932c33a3 100644
> > > --- a/mm/kasan/common.c
> > > +++ b/mm/kasan/common.c
> > > @@ -14,6 +14,8 @@
> > >   *
> > >   */
> > >
> > > +#define __KASAN_INTERNAL
> > > +
> > >  #include <linux/export.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/init.h>
> > > --
> > > 2.20.0
> > >
> >
> > Hi all,
> >
> > Was there any other movement on this patch? I am noticing this fail as
> > well and I have applied this patch in the meantime; it would be nice fo=
r
> > it to be merged so I could drop it from my stack.
>
> Alexander, ping, you wanted to double-check re KMSAN asm
> instrumentation and then decide on a common approach for KASAN and
> KMSAN.

I like Arnd's approach and will do the same for KMSAN.
Arnd, please go ahead submitting your patch.
The only possible issue I'm anticipating is that in the future we may
want to disable the checks in non-KASAN code (e.g. in arch/ or mm/),
so __KASAN_INTERNAL may not be the best name, but that's up to you.

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
