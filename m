Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77177C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A9F20849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nmtX3NCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A9F20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeLLKAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:00:21 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40306 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbeLLKAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:00:21 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so8833373ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 02:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PCMMGWyvPYrev9RR1m66VHnWBNlCo9exbcjAzzQ0GsY=;
        b=nmtX3NCIJkrEYG3XiirWVUn3UXjltP3qD6QYKNVajpYBMBXqcQ70lUE/mkTTzSTjIs
         E3o2Vi/o0SKo/0xK66EVgDm1/FD8e3UGUc++D0y7pxgDG6LdxYBXxXi0WH2dHOD5X4By
         sExGCkwPqNW8qijjBlk4qFH3s8AH0E+AdYu6sSD6bqnudNZs82KWfvZnL88jo4tfYImw
         4qXCruH0j3F7zg1BrLhbsjV6E0y9iNW4wJ0XYzAo2JrBytBqwhgdC9chcghQWHaUhyqp
         swF+Dr/MegyIiVL/JBuVh1eVQDFQ0G7U4/DYumw6I27cnwsjcQJbrv+YTMGt/SwHnPJV
         xKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PCMMGWyvPYrev9RR1m66VHnWBNlCo9exbcjAzzQ0GsY=;
        b=nxWPJyuYOQSPoGl3dDktypWwd8d2vYIbwRKMeQJahyp3pbPy2z1kXyePoW4rhIR07z
         2ULTcUdURQZe2WaYtxSO20Q53LY5JBJAYkTV2XV4x/WiwiV3QBQWIks+LxKhz6syfrzz
         VaQnO4ON3m/eMYpnM8lsxA1P+xQJ+jaeCoP/QXAmajF7gt4chPKEjJD5oHmcusDJUWRr
         UaV6XKjrbVvQul+jtRwfIooBkKNn6HW4JlLEoBBBDXBzYura9EChrOO3VvE1Ti81TF9h
         JwkIcD7pQ52H1iuLHw+4Oz5Mjp1oJk2Kn+5zrQasdKVHts0pvnIjmuE0hE6VnD2XXGzo
         ouhg==
X-Gm-Message-State: AA+aEWa/qJlZvR44GK7k9y0xutsRUL08d25pJRWqrh/c8F2e1PvX24Wz
        zIdqYyiKf9pX9xREKrYzBKqcXZuFqNQP4MHsdDnwlQ==
X-Google-Smtp-Source: AFSGD/USiE8ycoxzcQn8ODaBzFHNxyFTET8S7Hpo9x3/FQinJvTMXH23PP2HT0IRkxbOGOXHOboOTof4+WpATOLp634=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr4887004iti.166.1544608819792;
 Wed, 12 Dec 2018 02:00:19 -0800 (PST)
MIME-Version: 1.0
References: <20181211133453.2835077-1-arnd@arndb.de> <CACT4Y+bRzY9hO5b=TjHeXTsVVO1z3eBOHz6oLgBhVR4OSm1d1w@mail.gmail.com>
 <CAG_fn=U2d799W6GiujK4pedkLZr=LJrFrZhfCQ=Kin35quA76g@mail.gmail.com>
In-Reply-To: <CAG_fn=U2d799W6GiujK4pedkLZr=LJrFrZhfCQ=Kin35quA76g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 12 Dec 2018 11:00:08 +0100
Message-ID: <CACT4Y+bEvJVAS+bdAS+p5SzX4DrfzvTSfV1qzH=BszpGjtoL6g@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix kasan_check_read/write definitions
To:     Alexander Potapenko <glider@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        anders.roxell@linaro.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:25 PM Alexander Potapenko <glider@google.com> wr=
ote:
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
> >
> >
> > Alexander, I think you are doing a similar thing for similar reasons
> > in KMSAN patch (see KMSAN_CHECK_ATOMIC_PARAMS):
> > https://github.com/google/kmsan/commit/17ebbfe19624c84adf79b0e5a74fd258=
c49ff12b
> > Namely, non-KMSAN-instrumented files must not get KMSAN callbacks from
> > atomics too.
> I'll need to double-check, but it occurs to me that we won't need
> additional hooks for atomics in KMSAN - the compiler instrumentation
> should suffice.

Compiler asm instrumentation will only insert conservative
initialization, but not checks of arguments, right?
I mean these checks are optional in the sense that it's only false
negatives, but since we already have them and they don't seem to lead
to false positives, why do we want to remove them?


> > Arnd patch does it the other way around: non-instrumented files need
> > to opt-in instead of opt-out.
> Shouldn't we put __SANITIZE_ADDRESS__ somewhere into mm/kasan/kasan.h the=
n?
> > Let's settle on a common way to do this, so that we can use it
> > consistently across all tools.
> >
> >
> >
> > > Fixes: b1864b828644 ("locking/atomics: build atomic headers as requir=
ed")
> > > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
>
>
>
> --
> Alexander Potapenko
> Software Engineer
>
> Google Germany GmbH
> Erika-Mann-Stra=C3=9Fe, 33
> 80636 M=C3=BCnchen
>
> Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
> Registergericht und -nummer: Hamburg, HRB 86891
> Sitz der Gesellschaft: Hamburg
