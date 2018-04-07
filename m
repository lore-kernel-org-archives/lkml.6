Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbeDGJJk (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 05:09:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42646 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbeDGJJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 05:09:38 -0400
Date: Sat, 7 Apr 2018 11:09:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jan Henrik Weinstock <jan.weinstock@ice.rwth-aachen.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH] openrisc: define mb() as its mandatory
Message-ID: <20180407090905.GQ4082@hirez.programming.kicks-ass.net>
References: <20180406205852.14821-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406205852.14821-1-shorne@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 07, 2018 at 05:58:49AM +0900, Stafford Horne wrote:
> Following Peter Z's patch ("asm-generic: Disallow no-op mb() for SMP
> systems") which makes mb() mandatory for SMP architectures we define it
> as l.msync.  On OpenRISC this will flush the current cores write buffer
> and trigger remote cores to invalidate their caches of the written
> memory.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> Link: https://lkml.org/lkml/2018/1/31/254
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
> 
> Notes:
>   - Sorry, its been a while since we discussed this patch is the parent to this 
>     still going in Peter?

Oops.. yes it should. It seems I also lost track of it. Thanks for the
reminder!
