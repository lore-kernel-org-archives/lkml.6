Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeEBLCV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:02:21 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51709 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbeEBLCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:02:17 -0400
X-Google-Smtp-Source: AB8JxZoPxxI3Zt6BHGF5MdgsJEP9BxyCp9QNUcDSRhlULRDxUFT+lEhZ1cLNa3ssCwPiWE1+EkvfQQ==
Date: Wed, 2 May 2018 12:02:13 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Joel Fernandes <joelaf@google.com>
Cc: julien.thierry@arm.com,
        "Joel Fernandes (Google)" <joel.opensrc@gmail.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>, James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2 0/6] arm64: provide pseudo NMI with GICv3
Message-ID: <20180502110213.okx5gxu7vys34nxt@holly.lan>
References: <1516190084-18978-1-git-send-email-julien.thierry@arm.com>
 <e0b5ae90-f21e-f5db-a4af-52900a2e8c07@arm.com>
 <CAEi0qNkt75cqF=03HrQ81+pDdWVOpzGiHrk8_cTNTJo9os9D8Q@mail.gmail.com>
 <07a0b8c1-3d87-0cae-61df-dbff782be301@arm.com>
 <20180430105559.ys6kcfoy76o3qpoj@holly.lan>
 <CAJWu+oqH0-nwBNSXiuuf1gPK62rstSYBaus89dmanoCw1QYv7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+oqH0-nwBNSXiuuf1gPK62rstSYBaus89dmanoCw1QYv7A@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 06:18:44PM +0000, Joel Fernandes wrote:
> > > From my understanding, Linux's hardlockup detector already uses the ARM
> PMU
> > > interrupt to check whether some task is stuck. I haven't looked at the
> > > details of the implementation yet, but in theory having the PMU
> interrupt as
> > > NMI should make the hard lockup detector use the NMI.
> > >
> > > When I do the v3, I'll have a look at this to check whether the
> hardlockup
> > > detector works fine when using NMI.
> 
> > That's what I saw on arch/arm (with some of the much older FIQ work).
> 
> > Once you have PMU and the appropriate config to *admit* to supporting
> > hard lockup then it will "just work" and be setup automatically during
> > kernel boot.
> 
> > Actually the problem then becomes that if you want to use the PMU
> > for anything else then you may end up having to disable the hard
> > lockup detector.
> 
> This problem is not anything pseudo-NMI specific though right?
> Contention/constraints on PMU resources should be a problem even on
> platforms with real NMI.

Quite so. Nothing specific to pseudo-NMI; merely part of life's rich tapestry.

Moreover it is a potential surprise for anyone coming from x86 since I think
the performance monitors make it easier to run hard lockup alongside
some simple perf activity.

Either way, if you are impacted, its easy to disable the hard lockup
using procfs.


Daniel.
