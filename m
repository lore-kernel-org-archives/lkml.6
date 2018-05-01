Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756466AbeEASS5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:18:57 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:50653 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756445AbeEASS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:18:56 -0400
X-Google-Smtp-Source: AB8JxZrs9U4mUEZpKCjacLy+l8rZPErRVEM/iv4SkKTauUHVtM2aW8dtI8aLr2m+HST2CK5LhfC8AGMiP65wttOyvCo=
MIME-Version: 1.0
References: <1516190084-18978-1-git-send-email-julien.thierry@arm.com>
 <e0b5ae90-f21e-f5db-a4af-52900a2e8c07@arm.com> <CAEi0qNkt75cqF=03HrQ81+pDdWVOpzGiHrk8_cTNTJo9os9D8Q@mail.gmail.com>
 <07a0b8c1-3d87-0cae-61df-dbff782be301@arm.com> <20180430105559.ys6kcfoy76o3qpoj@holly.lan>
In-Reply-To: <20180430105559.ys6kcfoy76o3qpoj@holly.lan>
From: Joel Fernandes <joelaf@google.com>
Date: Tue, 01 May 2018 18:18:44 +0000
Message-ID: <CAJWu+oqH0-nwBNSXiuuf1gPK62rstSYBaus89dmanoCw1QYv7A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] arm64: provide pseudo NMI with GICv3
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: julien.thierry@arm.com,
        "Joel Fernandes (Google)" <joel.opensrc@gmail.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>, James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > On 29/04/18 07:37, Joel Fernandes wrote:
> > > On Wed, Jan 17, 2018 at 4:10 AM, Julien Thierry <
julien.thierry@arm.com> wrote:
> > > > Hi,
> > > >
> > > > On 17/01/18 11:54, Julien Thierry wrote:
> > > > >
> > > > > This series is a continuation of the work started by Daniel [1].
The goal
> > > > > is to use GICv3 interrupt priorities to simulate an NMI.
> > > > >
> > > >
> > > >
> > > > I have submitted a separate series making use of this feature for
the ARM
> > > > PMUv3 interrupt [1].
> > >
> > > I guess the hard lockup detector using NMI could be a nice next step
> > > to see how well it works with lock up detection. That's the main
> > > usecase for my interest. However, perf profiling is also a strong one.
> > >
> >
> > From my understanding, Linux's hardlockup detector already uses the ARM
PMU
> > interrupt to check whether some task is stuck. I haven't looked at the
> > details of the implementation yet, but in theory having the PMU
interrupt as
> > NMI should make the hard lockup detector use the NMI.
> >
> > When I do the v3, I'll have a look at this to check whether the
hardlockup
> > detector works fine when using NMI.

> That's what I saw on arch/arm (with some of the much older FIQ work).

> Once you have PMU and the appropriate config to *admit* to supporting
> hard lockup then it will "just work" and be setup automatically during
> kernel boot.

> Actually the problem then becomes that if you want to use the PMU
> for anything else then you may end up having to disable the hard
> lockup detector.

This problem is not anything pseudo-NMI specific though right?
Contention/constraints on PMU resources should be a problem even on
platforms with real NMI.

thanks,

- Joel
