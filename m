Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeB1I73 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 03:59:29 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48188 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbeB1I72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 03:59:28 -0500
Date: Wed, 28 Feb 2018 09:59:43 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Woody Suwalski <terraluna977@gmail.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        William Grant <william.grant@canonical.com>
Subject: Re: 4.16 regression: s2ram broken on non-PAE i686
In-Reply-To: <CAM6Zs0WTjWW+Lw3ws_iAH-K1dJgd5r9s0oC=u4TgEFUyC5bxig@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1802280959180.1886@nanos.tec.linutronix.de>
References: <CAM6Zs0WTjWW+Lw3ws_iAH-K1dJgd5r9s0oC=u4TgEFUyC5bxig@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Woody,

On Tue, 27 Feb 2018, Woody Suwalski wrote:

> There is a problem with s2ram on 4.16, and it has now been propagated
> to 4.15 and 4.14 stable updates.
> 
> It originates from
> 
> commit 62c00e6122a6b5aa7b1350023967a2d7a12b54c9
> Author: William Grant <william.grant@canonical.com
> <mailto:william.grant@canonical.com>>
> Date:   Tue Jan 30 22:22:55 2018 +1100
> 
>     x86/mm: Fix overlap of i386 CPU_ENTRY_AREA with FIX_BTMAP
> 
> s2ram works OK on PAE kernels, breaks badly on non-PAE. I do not think
> that the problem can be duplicated in VMPlayer, but it is 100%
> reproducible on a "real" hardware.
> System goes to sleep OK, but when woken - it reboots the PC.
> 
> The issue is tracked in Bugzilla bug 198763
> [https://bugzilla.kernel.org/show_bug.cgi?id=198763]

Thanks for digging into this so far. Can you please provide dmesg output
from a PAE=y and PAE=n kernel after boot?

Thanks,

	tglx
