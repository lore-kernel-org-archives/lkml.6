Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbeEKEDU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 00:03:20 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:40579 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbeEKEDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 00:03:19 -0400
X-Google-Smtp-Source: AB8JxZoCIfXjhKp7RaaNOoRorUbU9t3Qng5gSqzda9DZZxPmOiKArSBdx5qfjj10VthhwaJdsqrebAkSAbICBJOqBf4=
MIME-Version: 1.0
In-Reply-To: <20180404143239.GA18238@arm.com>
References: <20180404143239.GA18238@arm.com>
From: Yang Li <pku.leo@gmail.com>
Date: Thu, 10 May 2018 23:03:18 -0500
Message-ID: <CADRPPNQhoXSGr4hpHaomcyamW51wT_F4fRTqZi4qtAD-jBHjxA@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: updates for 4.17
To: Will Deacon <will.deacon@arm.com>
Cc: torvalds@linux-foundation.org, lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>, lorenzo.pieralisi@arm.com,
        ebiederm@xmission.com, Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 9:32 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Linus,
>
> Please pull these arm64 updates for 4.17. Note that I've pulled in a
> stable branch from Eric Biederman here to fulfil some siginfo dependencies,
> so the diffstat strays slightly out of arm64 due to his changes.
{snip}
>
> Catalin Marinas (1):
>       arm64: Revert L1_CACHE_SHIFT back to 6 (64-byte cache line size)
>

{snip}

>
> Will Deacon (20):
>       arm64: signal: Make force_signal_inject more robust
>       arm64: signal: Force SIGKILL for unknown signals in force_signal_inject
>       arm64: Introduce arm64_force_sig_info and hook up in arm64_notify_die
>       arm64: signal: Don't print anything directly in force_signal_inject
>       arm64: Pass user fault info to arm64_notify_die instead of printing it
>       arm64: mm: Rework unhandled user pagefaults to call arm64_force_sig_info
>       arm64: signal: Call arm64_notify_segfault when failing to deliver signal
>       arm64: Move show_unhandled_signals_ratelimited into traps.c
>       arm64: Use arm64_force_sig_info instead of force_sig_info
>       arm64: lse: Pass -fomit-frame-pointer to out-of-line ll/sc atomics
>       arm64: kaslr: Set TCR_EL1.NFD1 when CONFIG_RANDOMIZE_BASE=y
>       Merge tag 'acpi/iort-for-v4.17' of git://git.kernel.org/.../lpieralisi/linux into aarch64/for-next/core
>       Merge branch 'siginfo-next' of git://git.kernel.org/.../ebiederm/user-namespace into aarch64/for-next/core
>       arm64: cpufeature: Avoid warnings due to unused symbols
>       Revert "arm64: Revert L1_CACHE_SHIFT back to 6 (64-byte cache line size)"

Hi Will,

I'm wondering if we are changing the L1_CACHE_SHIFT to 6 in 4.17?
This is causing big performance differences for us now.

Regards,
Leo
