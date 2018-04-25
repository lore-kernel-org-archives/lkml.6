Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeDYIwd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 04:52:33 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65346 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbeDYIwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 04:52:30 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>
Cc: Genki Sky <sky@genki.is>, David Herrmann <dh.herrmann@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org
Subject: Re: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and clock BOOTTIME
Date: Wed, 25 Apr 2018 10:52:18 +0200
Message-ID: <1996930.B4PaKZ6i1F@aspire.rjw.lan>
In-Reply-To: <alpine.DEB.2.21.1804241007410.5261@nanos.tec.linutronix.de>
References: <CANq1E4QppGAaU5PYbGpuC00S6wGQcAt70Z7CntZHiLC6748z2A@mail.gmail.com> <CALAqxLWmcmiOgbH1Ri+Ki-OGFvgzRzRDzX3FZdUhcqu1OoCWiA@mail.gmail.com> <alpine.DEB.2.21.1804241007410.5261@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 24, 2018 10:09:28 AM CEST Thomas Gleixner wrote:
> On Mon, 23 Apr 2018, John Stultz wrote:
> 
> > On Mon, Apr 23, 2018 at 7:45 PM, Genki Sky <sky@genki.is> wrote:
> > > Quoting Genki Sky (2018/04/23 20:40:36 -0400)
> > >> I came across this thread for same reason as [0]: Daemons getting
> > >> killed by systemd on resume (after >WatchdogSec seconds of
> > >> suspending). I'm using master branch of systemd and the kernel. As
> > >> mentioned, systemd uses CLOCK_MONOTONIC, originally expecting it to
> > >> not include suspend time.
> > >>
> > >> Correct me if I'm mistaken, but I don't see the ambiguity of whether
> > >> this patch series breaks systemd. If it's implemented correctly, you'd
> > >> hope it *would* break it!
> > >
> > > This sounded a little weak on re-reading, sorry. So, I just confirmed
> > > that after booting a "git revert -m 1 680014d6d1da", the issue no
> > > longer appears. (I.e., a suspend for >WatchDog sec doesn't result in
> > > any daemon getting killed).
> > >
> > > Let me know if I can help in any way.
> > 
> > Yea, this is the sort of thing I was worried about.
> > 
> > Thomas: I think reverting this change is needed.
> 
> Sigh. I hoped that something like this would be catched before I sent the
> pull request by those who were actually interested in this change...

The "git revert -m 1 680014d6d1da" makes resume issues on my Aspire S5
go away (cf. https://marc.info/?l=linux-kernel&m=152460804018920&w=2).

I'll try with just the "monotonic" vs "boottime" clock changes reverted.

> I'll try to distangle it.

Cool.

Please let me know if you need any help.
