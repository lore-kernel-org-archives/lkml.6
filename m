Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752298AbeDJHQp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:16:45 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41963 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbeDJHQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:16:43 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tick-sched: avoid a maybe-uninitialized warning
Date: Tue, 10 Apr 2018 09:16:49 +0200
Message-ID: <2227858.przuGYB40B@aspire.rjw.lan>
In-Reply-To: <CAK8P3a0dY++MwoLhxCEHHHg6AVpcaSDrDcqioh_mT0yxkg7Ujw@mail.gmail.com>
References: <20180409122339.1709840-1-arnd@arndb.de> <20180409161817.bnmokplnoagyxwrc@gmail.com> <CAK8P3a0dY++MwoLhxCEHHHg6AVpcaSDrDcqioh_mT0yxkg7Ujw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 9, 2018 7:53:30 PM CEST Arnd Bergmann wrote:
> On Mon, Apr 9, 2018 at 6:18 PM, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > * Arnd Bergmann <arnd@arndb.de> wrote:
> >
> >> The use of bitfields seems to confuse gcc, leading to a false-positive
> >> warning in all compiler versions:
> >>
> >> kernel/time/tick-sched.c: In function 'tick_nohz_idle_exit':
> >> kernel/time/tick-sched.c:538:2: error: 'now' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> >>
> >> This introduces a temporary variable to track the flags so gcc
> >> doesn't have to evaluate twice, eliminating the code path that
> >> leads to the warning.
> >>
> >> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=85301
> >> Fixes: 1cae544d42d2 ("nohz: Gather tick_sched booleans under a common flag field")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Which tree is this against? There's no such commit either in -tip, upstream or in
> > -next AFAICS.
> 
> It's in today's linux-next. I found that it came in through Rafael's
> pm/linux-next tree.

That's the idle loop rework series.

I'll add this patch on top of that if there are no objections.

Thanks,
Rafael
