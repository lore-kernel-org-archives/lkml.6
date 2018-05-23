Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933163AbeEWOCw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:02:52 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:47084 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932342AbeEWOCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:02:49 -0400
X-Google-Smtp-Source: AB8JxZpELT9aRo2aBczNVmPEUznVcgsXZtAlxMjPt4Vw5x9+wwgnC9/x9bVGgO02wgGvX79zjK72KHLYME70MQurSOQ=
MIME-Version: 1.0
In-Reply-To: <20180523133533.1076-5-mark.rutland@arm.com>
References: <20180523133533.1076-1-mark.rutland@arm.com> <20180523133533.1076-5-mark.rutland@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 May 2018 16:02:46 +0200
X-Google-Sender-Auth: 1pKloS_E6GBXADYQEIW0rFWdcik
Message-ID: <CAMuHMdUxahNNq=NiOX8eYtgWbtDOBToV633opkR65aXvDj82Tw@mail.gmail.com>
Subject: Re: [PATCH 04/13] atomics/treewide: make atomic_fetch_add_unless() optional
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>, Vineet Gupta <vgupta@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 3:35 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Several architectures these have a near-identical implementation based
> on atomic_read() and atomic_cmpxchg() that we can instead define in
> <linux/atomic.h>, so let's do so, using something close to the existing
> x86 implementation with try_cmpxchg().
>
> Where an architecture provides its own atomic_fetch_add_unless(), it
> must define a preprocessor symbol for it. The instrumented atomics are
> updated accordingly.
>
> Note that arch/arc's existing atomic_fetch_add_unless() had redundant
> barriers, as these are already present in its atomic_cmpxchg()
> implementation.
>
> There should be no functional change as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

>  arch/m68k/include/asm/atomic.h            | 15 ---------------
>  include/linux/atomic.h                    | 23 +++++++++++++++++++++++

For m68k:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
