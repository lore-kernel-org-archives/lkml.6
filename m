Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933097AbeEWOBU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:01:20 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:35842 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932900AbeEWOBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:01:19 -0400
X-Google-Smtp-Source: AB8JxZoOP+QfgKckzYBTkl9MsOpDFUMKa2pOB6woNSNG4r+Bcqe7Re1OPDM5A3UilRYllsFy2aATZSDINrsoH6UjdB0=
MIME-Version: 1.0
In-Reply-To: <20180523133533.1076-2-mark.rutland@arm.com>
References: <20180523133533.1076-1-mark.rutland@arm.com> <20180523133533.1076-2-mark.rutland@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 May 2018 16:01:17 +0200
X-Google-Sender-Auth: -CMllusc0f3D5P8u5X5pvj58UWw
Message-ID: <CAMuHMdXuj3Z-42Hxo2qqj+E4-WVazMHaaFXGknFE=YJ-Zx4+Yg@mail.gmail.com>
Subject: Re: [PATCH 01/13] atomics/treewide: s/__atomic_add_unless/atomic_fetch_add_unless/
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
> While __atomic_add_unless was originally intended as a building-block
> for atomic_add_unless, it's now used in a number of places around the
> kernel. It's the only common atomic operation named __atomic*(), rather
> than atomic_*(), and for consistency it would be better named
> atomic_fetch_add_unless().
>
> This lack of consistency is slightly confusing, and gets in the way of
> scripting atomics. Given that, let's clean things up and promote it to
> an offical part of the atomics API, in the form of
> atomic_fetch_add_unless().
>
> This patch converts definitions and uses over to the new name, including
> the instrumented version, using the following script:
>
> ----
> git grep -w __atomic_add_unless | while read line; do
> sed -i '{s/\<__atomic_add_unless\>/atomic_fetch_add_unless/}' "${line%%:*}";
> done
> git grep -w __arch_atomic_add_unless | while read line; do
> sed -i '{s/\<__arch_atomic_add_unless\>/arch_atomic_fetch_add_unless/}' "${line%%:*}";
> done
> ----
>
> Note that we do not have atomic{64,_long}_fetch_add_unless(), which will
> be introduced by later patches.
>
> There should be no functional change as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

>  arch/m68k/include/asm/atomic.h            | 2 +-

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
