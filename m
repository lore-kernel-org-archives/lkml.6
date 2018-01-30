Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbeA3SZf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:25:35 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45033 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbeA3SZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:25:34 -0500
Date: Tue, 30 Jan 2018 19:25:31 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [GIT pull] Timer core updates for 4.16
In-Reply-To: <CA+55aFxzm6fY396+Nh3mZm5BroW4ZQmh3gj0YLvg7nKs5qzQKg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1801301924370.1797@nanos>
References: <alpine.DEB.2.20.1801290935160.1849@nanos> <CA+55aFy6FX6Ewg9exGH12PWnzSNKBfmc--v6H6UYpcSAEWUR8A@mail.gmail.com> <20180130063002.gxmruvxcqsfp5hv4@gmail.com> <CA+55aFxzm6fY396+Nh3mZm5BroW4ZQmh3gj0YLvg7nKs5qzQKg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2018, Linus Torvalds wrote:
> On Mon, Jan 29, 2018 at 10:30 PM, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > These are in cases significant driver simplifications, but they also enable the
> > real deal, the elimination of the hrtimer tasklet:
> >
> >  softirq: Remove tasklet_hrtimer
> >
> >    include/linux/interrupt.h | 25 -----------------------
> >    kernel/softirq.c          | 51 -----------------------------------------------
> >    2 files changed, 76 deletions(-)
> >
> > ... which is a pretty nice thing in itself even without the driver
> > simplifications!
> >
> > Plus the _real_ secret motivation behind it all is the -rt kernel and
> > CONFIG_PREEMPT_RT=y and the ability to push most of the hrtimer processing into
> > softirq context - while it still keeps the main hrtimer machinery capable to run
> > in hard-RT hardirq domain. Turns out it was possible to implement this duality via
> > the softirq-hrtimers, with a good chunk of benefits to non-rt upstream as well.
> 
> So this is the kind of explanation that I would have liked in the
> "please pull" (and that would have been great in the merge message).
> Explaining not just the "what", but very much the "why".
> 
> Anyway, it's obviously pulled regardless, and I'm just pointing this
> out for "maybe next time".

Sorry about that. I usually try to be descriptive and will do so next time
again.

Thanks,

	tglx
