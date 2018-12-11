Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA81C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005FC20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rdRn2WMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005FC20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeLKWZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:25:43 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44022 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeLKWZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:25:42 -0500
Received: by mail-vs1-f66.google.com with SMTP id x1so9864547vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 14:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qsq9eRINQk74oPk5zkoV/bpLO783jMuG/Fg5ykE4qJM=;
        b=rdRn2WMyuN5KUWSZQd3M9bw3Ev3OMLsSZzRzVNeyPdCJcDax7ZxgnHiEmeEWCpSyOq
         31FvCiEPWLBEDRNP9qUOp2DHUrBdGIu8KvMZfnlcyFZ6SmiPfFsAmoJq2Uz5u8eCClsk
         pa+6YNr3vm86fQ/8cm65vVp/oG4ZQMXH4dXgx0IxSMBjhqMdkHzbmaWwxR/GfKFlGqrl
         7VUczlrYkW4L6hQ/I3HgyfKntNJhDglN5foFnZvIO/nnD1D0tMpkzu0mPVcf6ZFXidrQ
         J/Qx3JPbGh6YbMlDwYS0nGMQFCkLaycvs2Vfxq78fHgfRDHDpwvR8FMMnAeInyGR4BqI
         7r8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qsq9eRINQk74oPk5zkoV/bpLO783jMuG/Fg5ykE4qJM=;
        b=tXTyuffj8InfKkf/eOMsYL1khOwMRnY15M54rRkN5mXl9XydovlvXwPkbqPh6nJH67
         OeRMiz/jnquHVo98E7+kd7MBa/1/M0Skf98W6QRPQyVCVdUYv2aAvBG7VvI+XA5PVgtS
         2hfx1wUpv7kKQZdjl9/KgKnOCNZqXyNoYocmYbv9eALrfQTw1pUN9MfxlFRDT7t2Pm67
         hRxfAzDow4O6EHAHvT+NaLCKsIopuq3zDRQQgV+PVnuRr5y5hjhWwV6uIG1F2LRekKrd
         IUbO7EofezANovn7CZ2vwJGGF9LZMKbWyKi1AlOVwUzq9lZOFkUhmeXUsLuWR4hpCpHn
         G3fw==
X-Gm-Message-State: AA+aEWYrN7128CUbw/E7avBlSJFG7yABXd9CEZiZY23Y3Qv4CJ7F8VVD
        Fuakw3SmvSmx04c7R5svW0G5FtkH2In7XAIrqoQ3bQ==
X-Google-Smtp-Source: AFSGD/Wlo94daBAchMU6xPBE5+ZhwvY7zQyAKGJw7Fr+ZXGuP8CQH0k1V9l0FwvgAOil4lnMz92YpQsgZdbpR031MS0=
X-Received: by 2002:a67:88c9:: with SMTP id k192mr8119744vsd.103.1544567141144;
 Tue, 11 Dec 2018 14:25:41 -0800 (PST)
MIME-Version: 1.0
References: <20181211133453.2835077-1-arnd@arndb.de> <CACT4Y+bRzY9hO5b=TjHeXTsVVO1z3eBOHz6oLgBhVR4OSm1d1w@mail.gmail.com>
In-Reply-To: <CACT4Y+bRzY9hO5b=TjHeXTsVVO1z3eBOHz6oLgBhVR4OSm1d1w@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 11 Dec 2018 23:25:28 +0100
Message-ID: <CAG_fn=U2d799W6GiujK4pedkLZr=LJrFrZhfCQ=Kin35quA76g@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix kasan_check_read/write definitions
To:     Dmitriy Vyukov <dvyukov@google.com>
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
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 2:45 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Dec 11, 2018 at 2:35 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Building little-endian allmodconfig kernels on arm64 started failing
> > with the generated atomic.h implementation, since we now try to call
> > kasan helpers from the EFI stub:
> >
> > aarch64-linux-gnu-ld: drivers/firmware/efi/libstub/arm-stub.stub.o: in =
function `atomic_set':
> > include/generated/atomic-instrumented.h:44: undefined reference to `__e=
fistub_kasan_check_write'
> >
> > I suspect that we get similar problems in other files that explicitly
> > disable KASAN for some reason but call atomic_t based helper functions.
> >
> > We can fix this by checking the predefined __SANITIZE_ADDRESS__ macro
> > that the compiler sets instead of checking CONFIG_KASAN, but this in tu=
rn
> > requires a small hack in mm/kasan/common.c so we do see the extern
> > declaration there instead of the inline function.
>
>
> Alexander, I think you are doing a similar thing for similar reasons
> in KMSAN patch (see KMSAN_CHECK_ATOMIC_PARAMS):
> https://github.com/google/kmsan/commit/17ebbfe19624c84adf79b0e5a74fd258c4=
9ff12b
> Namely, non-KMSAN-instrumented files must not get KMSAN callbacks from
> atomics too.
I'll need to double-check, but it occurs to me that we won't need
additional hooks for atomics in KMSAN - the compiler instrumentation
should suffice.

> Arnd patch does it the other way around: non-instrumented files need
> to opt-in instead of opt-out.
Shouldn't we put __SANITIZE_ADDRESS__ somewhere into mm/kasan/kasan.h then?
> Let's settle on a common way to do this, so that we can use it
> consistently across all tools.
>
>
>
> > Fixes: b1864b828644 ("locking/atomics: build atomic headers as required=
")
> > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  include/linux/kasan-checks.h | 2 +-
> >  mm/kasan/common.c            | 2 ++
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.=
h
> > index d314150658a4..a61dc075e2ce 100644
> > --- a/include/linux/kasan-checks.h
> > +++ b/include/linux/kasan-checks.h
> > @@ -2,7 +2,7 @@
> >  #ifndef _LINUX_KASAN_CHECKS_H
> >  #define _LINUX_KASAN_CHECKS_H
> >
> > -#ifdef CONFIG_KASAN
> > +#if defined(__SANITIZE_ADDRESS__) || defined(__KASAN_INTERNAL)
> >  void kasan_check_read(const volatile void *p, unsigned int size);
> >  void kasan_check_write(const volatile void *p, unsigned int size);
> >  #else
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 03d5d1374ca7..51a7932c33a3 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -14,6 +14,8 @@
> >   *
> >   */
> >
> > +#define __KASAN_INTERNAL
> > +
> >  #include <linux/export.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/init.h>
> > --
> > 2.20.0
> >



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
