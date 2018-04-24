Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756610AbeDXIJh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:09:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34287 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756584AbeDXIJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:09:32 -0400
Date: Tue, 24 Apr 2018 10:09:28 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: John Stultz <john.stultz@linaro.org>
cc: Genki Sky <sky@genki.is>, David Herrmann <dh.herrmann@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and clock
 BOOTTIME
In-Reply-To: <CALAqxLWmcmiOgbH1Ri+Ki-OGFvgzRzRDzX3FZdUhcqu1OoCWiA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1804241007410.5261@nanos.tec.linutronix.de>
References: <CANq1E4QppGAaU5PYbGpuC00S6wGQcAt70Z7CntZHiLC6748z2A@mail.gmail.com> <2580c734d38041e984215ccc522a4f2d@genki.is> <cef78d739d29410cb73072e9792598a7@genki.is> <CALAqxLWmcmiOgbH1Ri+Ki-OGFvgzRzRDzX3FZdUhcqu1OoCWiA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2018, John Stultz wrote:

> On Mon, Apr 23, 2018 at 7:45 PM, Genki Sky <sky@genki.is> wrote:
> > Quoting Genki Sky (2018/04/23 20:40:36 -0400)
> >> I came across this thread for same reason as [0]: Daemons getting
> >> killed by systemd on resume (after >WatchdogSec seconds of
> >> suspending). I'm using master branch of systemd and the kernel. As
> >> mentioned, systemd uses CLOCK_MONOTONIC, originally expecting it to
> >> not include suspend time.
> >>
> >> Correct me if I'm mistaken, but I don't see the ambiguity of whether
> >> this patch series breaks systemd. If it's implemented correctly, you'd
> >> hope it *would* break it!
> >
> > This sounded a little weak on re-reading, sorry. So, I just confirmed
> > that after booting a "git revert -m 1 680014d6d1da", the issue no
> > longer appears. (I.e., a suspend for >WatchDog sec doesn't result in
> > any daemon getting killed).
> >
> > Let me know if I can help in any way.
> 
> Yea, this is the sort of thing I was worried about.
> 
> Thomas: I think reverting this change is needed.

Sigh. I hoped that something like this would be catched before I sent the
pull request by those who were actually interested in this change...

I'll try to distangle it.

Thanks,

	tglx
