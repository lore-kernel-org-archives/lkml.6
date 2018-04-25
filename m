Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753973AbeDYNDW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:03:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40599 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbeDYNDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:03:19 -0400
Date: Wed, 25 Apr 2018 15:03:13 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc: John Stultz <john.stultz@linaro.org>, Genki Sky <sky@genki.is>,
        David Herrmann <dh.herrmann@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org
Subject: Re: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and clock
 BOOTTIME
In-Reply-To: <1858767.c2KKoU8fl2@aspire.rjw.lan>
Message-ID: <alpine.DEB.2.21.1804251502310.2082@nanos.tec.linutronix.de>
References: <CANq1E4QppGAaU5PYbGpuC00S6wGQcAt70Z7CntZHiLC6748z2A@mail.gmail.com> <alpine.DEB.2.21.1804241007410.5261@nanos.tec.linutronix.de> <1996930.B4PaKZ6i1F@aspire.rjw.lan> <1858767.c2KKoU8fl2@aspire.rjw.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Rafael J. Wysocki wrote:
> On Wednesday, April 25, 2018 10:52:18 AM CEST Rafael J. Wysocki wrote:
> > On Tuesday, April 24, 2018 10:09:28 AM CEST Thomas Gleixner wrote:
> > > On Mon, 23 Apr 2018, John Stultz wrote:
> > > 
> > > > On Mon, Apr 23, 2018 at 7:45 PM, Genki Sky <sky@genki.is> wrote:
> > > > > Quoting Genki Sky (2018/04/23 20:40:36 -0400)
> > > > >> I came across this thread for same reason as [0]: Daemons getting
> > > > >> killed by systemd on resume (after >WatchdogSec seconds of
> > > > >> suspending). I'm using master branch of systemd and the kernel. As
> > > > >> mentioned, systemd uses CLOCK_MONOTONIC, originally expecting it to
> > > > >> not include suspend time.
> > > > >>
> > > > >> Correct me if I'm mistaken, but I don't see the ambiguity of whether
> > > > >> this patch series breaks systemd. If it's implemented correctly, you'd
> > > > >> hope it *would* break it!
> > > > >
> > > > > This sounded a little weak on re-reading, sorry. So, I just confirmed
> > > > > that after booting a "git revert -m 1 680014d6d1da", the issue no
> > > > > longer appears. (I.e., a suspend for >WatchDog sec doesn't result in
> > > > > any daemon getting killed).
> > > > >
> > > > > Let me know if I can help in any way.
> > > > 
> > > > Yea, this is the sort of thing I was worried about.
> > > > 
> > > > Thomas: I think reverting this change is needed.
> > > 
> > > Sigh. I hoped that something like this would be catched before I sent the
> > > pull request by those who were actually interested in this change...
> > 
> > The "git revert -m 1 680014d6d1da" makes resume issues on my Aspire S5
> > go away (cf. https://marc.info/?l=linux-kernel&m=152460804018920&w=2).
> > 
> > I'll try with just the "monotonic" vs "boottime" clock changes reverted.
> 
> FWICS (so far) system resume still works here with the commits between
> d6ed449afdb3 (timekeeping: Make the MONOTONIC clock behave like the BOOTTIME
> clock) and 127bfa5f4342 (hrtimer: Unify MONOTONIC and BOOTTIME clock behavior)
> inclusive reverted on top of 4.17-rc2.  [I probably should revert commit
> 92af4dcb4e1c (tracing: Unify the "boot" and "mono" tracing clocks) too, but
> it doesn't revert cleanly and it doesn't apprear to affect things here too.]

Right, it does not matter. The real interesting one is d6ed449afdb3.

Thanks,

	tglx
