Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeAaG1p (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 01:27:45 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55932 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbeAaG1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 01:27:44 -0500
X-Google-Smtp-Source: AH8x225VaY0aCzL9zMfqOxzQIAG2uDnUCn1y6EZF/OkUjJ2FS53Qtg5Tdg0iRwuobYWGE/tKlkZ5VA==
Date: Wed, 31 Jan 2018 07:27:40 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [GIT pull] Timer core updates for 4.16
Message-ID: <20180131062740.xftfrfmokeap55ia@gmail.com>
References: <alpine.DEB.2.20.1801290935160.1849@nanos>
 <CA+55aFy6FX6Ewg9exGH12PWnzSNKBfmc--v6H6UYpcSAEWUR8A@mail.gmail.com>
 <20180130063002.gxmruvxcqsfp5hv4@gmail.com>
 <CA+55aFxzm6fY396+Nh3mZm5BroW4ZQmh3gj0YLvg7nKs5qzQKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxzm6fY396+Nh3mZm5BroW4ZQmh3gj0YLvg7nKs5qzQKg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

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

Yeah, and there will be a next time: we'll apply those those networking code 
simplifications and the tasklet removal for the v4.17 merge window, and include 
the full description in that pull request.

That cannot retroactively make it easier for you to apply the first batch of 
patches, but at least we'll have the meta description in the next merge commit and 
it will be part of the v4.17 Git history.

Thanks,

	Ingo
