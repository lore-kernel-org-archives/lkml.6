Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeBAPuY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:50:24 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:40023 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbeBAPuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:50:21 -0500
Date: Thu, 1 Feb 2018 16:50:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Stafford Horne <shorne@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: asm-generic: Disallow no-op mb() for SMP systems
Message-ID: <20180201155007.GB2249@hirez.programming.kicks-ass.net>
References: <20180131130034.GR2269@hirez.programming.kicks-ass.net>
 <20180131131737.GA5097@arm.com>
 <20180131132610.GT2269@hirez.programming.kicks-ass.net>
 <20180201122750.GE30895@lianli.shorne-pla.net>
 <20180201132909.GW2249@hirez.programming.kicks-ass.net>
 <20180201133229.GB9182@arm.com>
 <20180201135329.GB2269@hirez.programming.kicks-ass.net>
 <20180201153951.GG9182@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201153951.GG9182@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 03:39:51PM +0000, Will Deacon wrote:
> > I could've gotten my brain in a twist or course, which isn't _that_
> > unusual. I never seem to be able to quite remember the holes you have
> > with ll/sc on arm64 :-)
> 
> Is smp_mb__before_atomic supposed to provide ordering guarantees if it's
> used before a failed cmpxchg? If so, I think it's needed here because the
> l.swa might not even execute. Or did I just invent another problem?

I think it should do so indeed (and afaik all our current archs are good
that way).
