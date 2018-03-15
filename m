Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeCOJ6o (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 05:58:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59602 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751467AbeCOJ6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 05:58:42 -0400
Date: Thu, 15 Mar 2018 10:58:03 +0100
From: Borislav Petkov <bp@alien8.de>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: X86 ML <x86@kernel.org>, Emanuel Czirai <xftroxgpx@protonmail.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: Re: [PATCH 2/2] x86/microcode: Fix CPU synchronization routine
Message-ID: <20180315095803.GB27816@pd.tnic>
References: <20180314183615.17629-1-bp@alien8.de>
 <20180314183615.17629-2-bp@alien8.de>
 <20180315010014.xsedkarzrgqiunxf@khazad-dum.debian.net>
 <20180315010152.GE11061@pd.tnic>
 <20180315040132.m3i3ozykkbjrxa66@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180315040132.m3i3ozykkbjrxa66@khazad-dum.debian.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Arjan.

On Thu, Mar 15, 2018 at 01:01:32AM -0300, Henrique de Moraes Holschuh wrote:
> A reasonably well-known paper on intel microcode updates[1] profiled
> that very well, years ago (2013).  The information about a linear
> increase in update time versus update size comes from that paper (I did
> not attempt to reproduce his findings, though).

WTF?

If I read this paper correctly:

http://www.inertiawar.com/microcode/

it is injecting faults and attempting to manipulate some size field -
I'm guessing the encrypted data size. And I'm also guessing that if you
manipulate that size, it would simply take a lot longer to attempt to
decrypt and verify that it is broken microcode and reject it. So it is
not actually a real update - it is just taking a lot longer to reject
it.

Now, I'm talking about genuine microcode updates. And that paper also
claims that they take thousands of cycles.

Now let's look at your previous, hm, "statement":

> Intel takes anything from twenty thousand cycles to several *million*
> cycles per core, proportional to microcode update size.

So you took a fault injection measurement out of context to claim that
*regular* microcode updates take millions of cycles.

So you had to say something - doesn't matter if it is apples and oranges
- as long as it is dramatic. Fuck the truth.

> When I measured my Xeon X5550 workstation doing an early update, the
> Xeon took about 1M cycles for the BSP, and 800k cycles for the APs (see
> below).
>
> To measure that, as far as I recall I just did a rdtsc right before the

RDTSC gets executed speculatively, so you need barriers around it. I
hope you added them.

> wrmsr, and another right after, and stashed the result somewhere to be
> able to print it out later in the BSP's case.  I repeated the process
> (by rebooting) a few times.  There was a *lot* of variation, but not
> enough to get it wrong by an order of magnitude.
> 
> I am surprised that this would be news to you, though.  It is not like I
> have been quiet about how expensive these updates are on Intel over the
> past years every time I sent you a patch related to this...

Frankly, I don't take you seriously. Even less so after this.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
