Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0098CC43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15082087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CGcrzugW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfAHEve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 23:51:34 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37310 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfAHEvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 23:51:32 -0500
Received: by mail-io1-f66.google.com with SMTP id g8so2197580iok.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 20:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WzLE1kl1n8qfTCuciv1x7YgTzmk4xHvqyK6zizNAsLQ=;
        b=CGcrzugWjzCZw5wd+yyC/qHn/OxPNIIQOiOTLkty4jiVxNtNQ/28SXXw4A8++QUkoL
         k0CuF1r7v7NqlMBT6FdTAxNCkHKOZ1RvyWPqHU4QG0gnVd13dEfA/GnK0LnmmyWg29I4
         a1BQpJAhruVWnN7bKqTly7Y1ac3/sx305nUFhx1POGxUWdqXSyRcS0QFCosJHXucsydC
         +cYHGH0AvvI8lklaXlpaPd1vHRZA1dZ75stD8RsknCTJHkFfISX4GTgLvSHSdRVKinzI
         FAsgm1D5fMjy9NvkoZMoC2Qv2vigf1vi8jY+fkVcBGQ7USC4JuSEiPnK5QYvWvSgo4Az
         sTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WzLE1kl1n8qfTCuciv1x7YgTzmk4xHvqyK6zizNAsLQ=;
        b=TZLAR7EPcLVkdhneTl3rq1tYWwANUKta78Zfq2fIFxYGd5cPfV+TXWEtsaILpOG1Tb
         aidYcULUWbtdsmp+cD+ooTtnjv5nJp44DMA0bC4ga2mt6Xd3i4M+69dtaqh+zpurZxoP
         K4Moaa1dbqn+wc8UDGz+a4aCTyoTbTMN/rb5W2ZbrB1I8VSizgBFTG5iG4XcAk7jdaSo
         Gyz73DMPEfS2gs++4/LyaxOKAWOZicNm4/mE9nK9GB+IObcNq/qvCfJ/t06geuUSQPn7
         E888ndI+kJVxQH7rM7rjKwd29KesqgDi7IbAgdlhDBQkuTu6ay0B1TNTpq+HfDN+4oH4
         sVGw==
X-Gm-Message-State: AJcUukdZ8H5oFmLU64qxXyOP0R0gszhXFIlqrWYWinJK6NIqBD0mxRQ9
        U4Z8/RQY8pRNkDxZMdnwkD0xk8G2xNXpFhiFA5iqiA==
X-Google-Smtp-Source: ALg8bN4sBBSAdKbPLoQEdQAzvStAUHALlV+Km6a/VTB/m4SrK593H6R74AvEFkxCfwGJ0vmLKRWcGWxRpMPH62W+Fy4=
X-Received: by 2002:a6b:fa0e:: with SMTP id p14mr118472ioh.271.1546923091512;
 Mon, 07 Jan 2019 20:51:31 -0800 (PST)
MIME-Version: 1.0
References: <20181211133453.2835077-1-arnd@arndb.de> <20190108022659.GA13470@flashbox>
In-Reply-To: <20190108022659.GA13470@flashbox>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 8 Jan 2019 05:51:20 +0100
Message-ID: <CACT4Y+a_LB6aVoLEcFVJhP40D9E4MM3T=7-0aBhFvBffXgNZmw@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix kasan_check_read/write definitions
To:     Alexander Potapenko <glider@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 3:27 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, Dec 11, 2018 at 02:34:35PM +0100, Arnd Bergmann wrote:
> > Building little-endian allmodconfig kernels on arm64 started failing
> > with the generated atomic.h implementation, since we now try to call
> > kasan helpers from the EFI stub:
> >
> > aarch64-linux-gnu-ld: drivers/firmware/efi/libstub/arm-stub.stub.o: in function `atomic_set':
> > include/generated/atomic-instrumented.h:44: undefined reference to `__efistub_kasan_check_write'
> >
> > I suspect that we get similar problems in other files that explicitly
> > disable KASAN for some reason but call atomic_t based helper functions.
> >
> > We can fix this by checking the predefined __SANITIZE_ADDRESS__ macro
> > that the compiler sets instead of checking CONFIG_KASAN, but this in turn
> > requires a small hack in mm/kasan/common.c so we do see the extern
> > declaration there instead of the inline function.
> >
> > Fixes: b1864b828644 ("locking/atomics: build atomic headers as required")
> > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  include/linux/kasan-checks.h | 2 +-
> >  mm/kasan/common.c            | 2 ++
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
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
>
> Hi all,
>
> Was there any other movement on this patch? I am noticing this fail as
> well and I have applied this patch in the meantime; it would be nice for
> it to be merged so I could drop it from my stack.

Alexander, ping, you wanted to double-check re KMSAN asm
instrumentation and then decide on a common approach for KASAN and
KMSAN.
