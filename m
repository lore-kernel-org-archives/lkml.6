Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeDYIz6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 04:55:58 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42032 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbeDYIzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 04:55:53 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>, Genki Sky <sky@genki.is>,
        David Herrmann <dh.herrmann@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and clock BOOTTIME
Date: Wed, 25 Apr 2018 10:55:42 +0200
Message-ID: <5103081.SE2RLkTpIo@aspire.rjw.lan>
In-Reply-To: <20180425065015.GA6222@amd>
References: <CANq1E4QppGAaU5PYbGpuC00S6wGQcAt70Z7CntZHiLC6748z2A@mail.gmail.com> <alpine.DEB.2.21.1804241007410.5261@nanos.tec.linutronix.de> <20180425065015.GA6222@amd>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 25, 2018 8:50:15 AM CEST Pavel Machek wrote:
> 
> --ReaqsoxgOBHFXBhH
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On Tue 2018-04-24 10:09:28, Thomas Gleixner wrote:
> > On Mon, 23 Apr 2018, John Stultz wrote:
> >=20
> > > On Mon, Apr 23, 2018 at 7:45 PM, Genki Sky <sky@genki.is> wrote:
> > > > Quoting Genki Sky (2018/04/23 20:40:36 -0400)
> > > >> I came across this thread for same reason as [0]: Daemons getting
> > > >> killed by systemd on resume (after >WatchdogSec seconds of
> > > >> suspending). I'm using master branch of systemd and the kernel. As
> > > >> mentioned, systemd uses CLOCK_MONOTONIC, originally expecting it to
> > > >> not include suspend time.
> > > >>
> > > >> Correct me if I'm mistaken, but I don't see the ambiguity of whether
> > > >> this patch series breaks systemd. If it's implemented correctly, you=
> 'd
> > > >> hope it *would* break it!
> > > >
> > > > This sounded a little weak on re-reading, sorry. So, I just confirmed
> > > > that after booting a "git revert -m 1 680014d6d1da", the issue no
> > > > longer appears. (I.e., a suspend for >WatchDog sec doesn't result in
> > > > any daemon getting killed).
> > > >
> > > > Let me know if I can help in any way.
> > >=20
> > > Yea, this is the sort of thing I was worried about.
> > >=20
> > > Thomas: I think reverting this change is needed.
> >=20
> > Sigh. I hoped that something like this would be catched before I sent the
> > pull request by those who were actually interested in this change...
> 
> Well, we had two regressions in -next this cycle... I reported both
> but bisections were not easy and noone was really interested.

It's more that it was difficult to correlate the reported symptoms with a
particular set of kernel changes.
