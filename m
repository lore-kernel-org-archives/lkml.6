Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933179AbeEWODh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:03:37 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:37637 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932342AbeEWODg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:03:36 -0400
X-Google-Smtp-Source: AB8JxZo3uq4A1V9w5TCzyNUf14ccNcESr/NYRyrthQsStXRRBg2eKTuNEvKChlAKrUVILILYZQjiMUUSitG3hCFlb6o=
MIME-Version: 1.0
In-Reply-To: <20180523133533.1076-14-mark.rutland@arm.com>
References: <20180523133533.1076-1-mark.rutland@arm.com> <20180523133533.1076-14-mark.rutland@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 May 2018 16:03:35 +0200
X-Google-Sender-Auth: xxfvgMh0oJT9Ox-EbDHM4h_7bGI
Message-ID: <CAMuHMdUy-Vm+mFW6zbd6pe-p+j1gKoZk9BY=RtKezQ6eJLG8Rg@mail.gmail.com>
Subject: Re: [PATCH 13/13] atomics/treewide: make test ops optional
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 3:35 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Some of the atomics return the result of a test applied after the atomic
> operation, and almost all architectures implement these as trivial
> wrappers around the underlying atomic. Specifically:
>
> * <atomic>_inc_and_test(v) is (<atomic>_inc_return(v) == 0)
>
> * <atomic>_dec_and_test(v) is (<atomic>_dec_return(v) == 0)
>
> * <atomic>_sub_and_test(i, v) is (<atomic>_sub_return(i, v) == 0)
>
> * <atomic>_add_negative(i, v) is (<atomic>_add_return(i, v) < 0)
>
> Rather than have these definitions duplicated in all architectures, with
> minor inconsistencies in formatting and documentation, let's make these
> operations optional, with default fallbacks as above. Implementations
> must now provide a preprocessor symbol.
>
> The instrumented atomics are updated accordingly.
>
> Both x86 and m68k have custom implementations, which are left as-is,
> given preprocessor symbols to avoid being overridden.
>
> There should be no functional change as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

>  arch/m68k/include/asm/atomic.h            |   4 +

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
