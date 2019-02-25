Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0193AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA178213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A6zdCs3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfBYMBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:01:21 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40672 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfBYMBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:01:20 -0500
Received: by mail-it1-f196.google.com with SMTP id i2so12841763ite.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 04:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ndSOUne7vN9B51aRGGGPJ4uRsKau7mMwvXBeVR/XNdU=;
        b=A6zdCs3jdyexiv+JvV546vpUMak1BHxPjQslyxIXX6yBvvb3oxjnfeO0DTrfoFSHD9
         r7j0pRZ/ALoWM+YBTJoz+5ZuwMGyEzYekZDOIp8lo4OT40xH6HcawTzYcW7Jfpp8a+xA
         2WyJwG2vMFVd5bXWYiQ2rpTdcruyALpwi7zLOTcCt+mW0rCa+fwAhuTpmJjTVAT7Sa20
         y0DzqSb1PVh7KtfRhMyp2Z5zQNN0j8RLboHsLoswK5XeLlgfyjjKGTNlYzN6cuoBNSUr
         7BzkaVAaA1IlaCTexF+Pu9O3I16pS9ygCIsEoglbIBq1xxbr4WOOVk+Mpe8SfkVIce80
         eyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndSOUne7vN9B51aRGGGPJ4uRsKau7mMwvXBeVR/XNdU=;
        b=LHyfSMHhnIfgNYiSw+wN02IA1b8fLzXJxRX3lJgoZYezM7fRfg+EPDLrWOr8uV+KMU
         j98sStPOPVkYKiY5zu0S0RJ3yAZV4ndWYX7qu5XRdOXOOieUlOAl8fEei6Ref9SyleHD
         YfZN1h5CxqzSbl69WuXmFiu01t9ApkCdmwSI1lYmKGMc3tIgqIHGU4k1E4aKbw6keidY
         mA8V1eKkY91gu/89Sd08KHIcSFktIKrxIz32i0N0sXjp7xWA68sdy9sZtUdA0niAA6Ct
         qt/bRLi3Thw5F8ucOD3UKySmYceuy5qUe1P4WYyMKlVmoycvELw6FazqI2LnWpAG/7X7
         ejlw==
X-Gm-Message-State: AHQUAuYgIILjD/fRs1578Y9uYUVbVlqnEVP87jP1zJzNHywuTR1mBtKf
        RT/Umux6+obb4LjWQ0jmwYf6agGTe/n1QFmbfQ3qRQ==
X-Google-Smtp-Source: AHgI3IaaqoU3BQbUh9uAkt2F+2qr2PIcPe+eiNj0Y1C1WJhLyeUHjOimFlF3pia4tkKSv3Cg76F7L5qy/fzOsaeryNg=
X-Received: by 2002:a02:4985:: with SMTP id p5mr9120988jad.35.1551096079146;
 Mon, 25 Feb 2019 04:01:19 -0800 (PST)
MIME-Version: 1.0
References: <20190222182851.21174-1-mark.rutland@arm.com> <CACT4Y+Z39U5JqaDQ-VMCn6Zmg+sJ58ZRO4ts8DQEr8XKS53Eug@mail.gmail.com>
 <20190225113509.GE26236@lakrids.cambridge.arm.com>
In-Reply-To: <20190225113509.GE26236@lakrids.cambridge.arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 25 Feb 2019 13:01:08 +0100
Message-ID: <CACT4Y+YtEzSU3dE0NpU1XXtdAWXGptwAk64EeBXzPb61YTz0-Q@mail.gmail.com>
Subject: Re: [PATCH] kasan: prevent recursive instrumentation
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ingo Molnar <mingo@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 12:35 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Sat, Feb 23, 2019 at 11:29:45AM +0100, Dmitry Vyukov wrote:
> > On Fri, Feb 22, 2019 at 7:29 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > When CONFIG_KASAN is selected, <linux/kasan-checks.h> defines the
> > > prototypes for kasan_check_{read,write}(), rather than inline stubs.
> >
> > +kasan-dev@googlegroups.com
> >
> > Doesn't this do the same as?
> > https://groups.google.com/d/msg/kasan-dev/NwEdpGgUeac/oXUIRUC6CAAJ
>
> I had missed that patch -- thanks for the pointer!
>
> Either patch should both fix the issue with the EFI stub, but the
> __kasan_check*() renaming in this patch also prevents unexpected
> instrumentation within mm/kasan/common.c, if a call to kasan_check_*()
> were inlined there.
>
> If you think that robustness is worthwhile, I can spin a v2 making that
> a bit clearer, and fix the logic to look at __SANITIZE_ADDRESS__ rather
> than adding the KASAN_NOSANITIZE definition.
>
> AFAICT Arnd's patch isn't queued anywhere just yet.


I dunno. I don't have strong preference.
Also not sure if Arnd's patch is not, say, in mm... problems of
extremely long patch submission times... patches should take at most
days to commit.


> > > This is the case even when it is included by files which are not
> > > instrumented by KASAN. Where helpers (e.g. the atomics) are instrumented
> > > with explicit calls to kasan_check_{read,write}(), this results in files
> > > being unexpectedly instrumented.
> > >
> > > This is problematic as it can result in instrumentation in files which
> > > cannot safely call these functions, such as within the EFI stub:
> > >
> > > [mark@lakrids:~/src/linux]% usekorg 8.1.0 make ARCH=arm64 CROSS_COMPILE=aarch64-linux- -j64 -s
> > > drivers/firmware/efi/libstub/arm-stub.stub.o: In function `atomic_set':
> > > /home/mark/src/linux/./include/asm-generic/atomic-instrumented.h:44: undefined reference to `__efistub_kasan_check_write'
> > > /home/mark/src/linux/./include/asm-generic/atomic-instrumented.h:44:(.init.text+0xa0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__efistub_kasan_check_write'
> > > Makefile:1021: recipe for target 'vmlinux' failed
> > > make: *** [vmlinux] Error 1
> > >
> > > Let's avoid this by ensuring that uninstrumented files are given the
> > > same stub definition of these functions used for !KASAN builds. So that
> > > the stub defintions don't conflict with the real definitions in
> > > (uninstrumented) common KASAN code, the real definitions are prefixed
> > > with underscores, and called from unprefixed macros.
> > >
> > > Any compiler-generated instrumentation uses separate
> > > __asan_{load,store}_*() entry points, and is not affected by this
> > > change.
> > >
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Alexander Potapenko <glider@google.com>
> > > Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > > Cc: Dmitry Vyukov <dvyukov@google.com>
> > > Cc: Ingo Molnar <mingo@kernel.org>
> > > ---
> > >  include/linux/kasan-checks.h | 8 +++++---
> > >  mm/kasan/common.c            | 8 ++++----
> > >  scripts/Makefile.kasan       | 2 +-
> > >  3 files changed, 10 insertions(+), 8 deletions(-)
> > >
> > > Hi,
> > >
> > > Assuming the KASAN folk are happy with this, I'd like this to be queued in the
> > > tip tree, where the arm64 instrumented atomics are already queued.
> > >
> > > Thanks,
> > > Mark.
> > >
> > > diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
> > > index d314150658a4..6cf4b41a5393 100644
> > > --- a/include/linux/kasan-checks.h
> > > +++ b/include/linux/kasan-checks.h
> > > @@ -2,9 +2,11 @@
> > >  #ifndef _LINUX_KASAN_CHECKS_H
> > >  #define _LINUX_KASAN_CHECKS_H
> > >
> > > -#ifdef CONFIG_KASAN
> > > -void kasan_check_read(const volatile void *p, unsigned int size);
> > > -void kasan_check_write(const volatile void *p, unsigned int size);
> > > +#if defined(CONFIG_KASAN) && !defined (KASAN_NOSANITIZE)
> > > +void __kasan_check_read(const volatile void *p, unsigned int size);
> > > +#define kasan_check_read __kasan_check_read
> > > +void __kasan_check_write(const volatile void *p, unsigned int size);
> > > +#define kasan_check_write __kasan_check_write
> > >  #else
> > >  static inline void kasan_check_read(const volatile void *p, unsigned int size)
> > >  { }
> > > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > > index 73c9cbfdedf4..630e32838adb 100644
> > > --- a/mm/kasan/common.c
> > > +++ b/mm/kasan/common.c
> > > @@ -95,17 +95,17 @@ void kasan_disable_current(void)
> > >         current->kasan_depth--;
> > >  }
> > >
> > > -void kasan_check_read(const volatile void *p, unsigned int size)
> > > +void __kasan_check_read(const volatile void *p, unsigned int size)
> > >  {
> > >         check_memory_region((unsigned long)p, size, false, _RET_IP_);
> > >  }
> > > -EXPORT_SYMBOL(kasan_check_read);
> > > +EXPORT_SYMBOL(__kasan_check_read);
> > >
> > > -void kasan_check_write(const volatile void *p, unsigned int size)
> > > +void __kasan_check_write(const volatile void *p, unsigned int size)
> > >  {
> > >         check_memory_region((unsigned long)p, size, true, _RET_IP_);
> > >  }
> > > -EXPORT_SYMBOL(kasan_check_write);
> > > +EXPORT_SYMBOL(__kasan_check_write);
> > >
> > >  #undef memset
> > >  void *memset(void *addr, int c, size_t len)
> > > diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> > > index 25c259df8ffa..c475a8ac776c 100644
> > > --- a/scripts/Makefile.kasan
> > > +++ b/scripts/Makefile.kasan
> > > @@ -52,5 +52,5 @@ CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
> > >  endif # CONFIG_KASAN_SW_TAGS
> > >
> > >  ifdef CONFIG_KASAN
> > > -CFLAGS_KASAN_NOSANITIZE := -fno-builtin
> > > +CFLAGS_KASAN_NOSANITIZE := -fno-builtin -DKASAN_NOSANITIZE
> > >  endif
> > > --
> > > 2.11.0
> > >
