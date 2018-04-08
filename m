Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeDHAHd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 20:07:33 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40442 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752262AbeDHAHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 20:07:32 -0400
X-Google-Smtp-Source: AIpwx4+xeI+QfOdCXcr99EPzmG24pbFcQSRQYEXRtTS14hbViiI9HPBfAK268PY/0QzLtmyyh5Q+zg==
Date: Sun, 8 Apr 2018 09:07:29 +0900
From: Stafford Horne <shorne@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20180408000729.GM2836@lianli.shorne-pla.net>
References: <20180406205852.14821-1-shorne@gmail.com>
 <20180407090905.GQ4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180407090905.GQ4082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 07, 2018 at 11:09:05AM +0200, Peter Zijlstra wrote:
> On Sat, Apr 07, 2018 at 05:58:49AM +0900, Stafford Horne wrote:
> > Following Peter Z's patch ("asm-generic: Disallow no-op mb() for SMP
> > systems") which makes mb() mandatory for SMP architectures we define it
> > as l.msync.  On OpenRISC this will flush the current cores write buffer
> > and trigger remote cores to invalidate their caches of the written
> > memory.
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > Link: https://lkml.org/lkml/2018/1/31/254
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> > 
> > Notes:
> >   - Sorry, its been a while since we discussed this patch is the parent to this 
> >     still going in Peter?
> 
> Oops.. yes it should. It seems I also lost track of it. Thanks for the
> reminder!

No Problem,

If you think this patch makes sense I can just put it into my OpenRISC queue for
4.17.  I dont see any reason to wait for yours. Any thoughts?

-Stafford
