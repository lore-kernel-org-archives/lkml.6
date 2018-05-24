Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034354AbeEXSsy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 14:48:54 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39965 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030220AbeEXSsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 14:48:52 -0400
X-Google-Smtp-Source: AB8JxZpAdzoIat28QNXV1M+uDu8zh46N3puWYP6/0Q8nqMPH5UmMe7oWwSIDyDWZcPAGckEHNiTwijATF5bfjia0U2o=
MIME-Version: 1.0
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
 <57C635C3-716C-4FC3-90C7-E394AA7242BA@zytor.com> <CAKwvOdndRL6gs29eQQrL+bVNBt1fjrXS=mBgF4CRshz+J5LY-Q@mail.gmail.com>
In-Reply-To: <CAKwvOdndRL6gs29eQQrL+bVNBt1fjrXS=mBgF4CRshz+J5LY-Q@mail.gmail.com>
From: Alistair Strachan <astrachan@google.com>
Date: Thu, 24 May 2018 11:48:40 -0700
Message-ID: <CANDihLFdmbE0q8Ya5YPWkRLxXEo4DR6ZRP-s+PjZDKEgoSY6rg@mail.gmail.com>
Subject: Re: [clang] stack protector and f1f029c7bf
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: hpa@zytor.com, Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resent plain text)

On Thu, May 24, 2018 at 11:24 AM Nick Desaulniers <ndesaulniers@google.com>
wrote:

> On Thu, May 24, 2018 at 11:20 AM <hpa@zytor.com> wrote:
> > A stack canary on an *inlined* function? That's bound to break things
> elsewhere too sooner or later.

> But it's *not* inlined by GCC or Clang.

FWIW, GCC can also insert a stack guard in an out-of-lined inline function,
it just doesn't for this one. The -fstack-protector and
-fstack-protector-strong flags are heuristic and the heuristic does not
match between gcc and clang for this function. It is working on GCC purely
by chance.

> While the function is marked `static inline`, it's not in
> arch/x86/kernel/paravirt.o due to:
> arch/x86/kernel/paravirt.c:326

> 325 __visible struct pv_irq_ops pv_irq_ops = {

> 326         .save_fl = __PV_IS_CALLEE_SAVE(native_save_fl),

> see comparison of disassembly  attached in:
> https://bugs.llvm.org/attachment.cgi?id=20338
> --
> Thanks,
> ~Nick Desaulniers
