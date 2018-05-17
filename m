Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeEQS1c (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:27:32 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45551 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbeEQS1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:27:31 -0400
X-Google-Smtp-Source: AB8JxZoTdMYePG26lJO8wr+JYHB8Ba2PCQz/AIqI59xOEn4WFc3CYEafoFSYCaFnmt4eoQ6sRfAk0Q==
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Thu, 17 May 2018 14:27:27 -0400 (EDT)
X-X-Sender: vince@macbook-air
To: Peter Zijlstra <peterz@infradead.org>
cc: Stefan Wahren <stefan.wahren@i2se.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Vince Weaver <vincent.weaver@maine.edu>, linux-kernel@vger.kernel.org,
        Eric Anholt <eric@anholt.net>, linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
In-Reply-To: <20180517180758.GK12198@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1805171422450.8529@macbook-air>
References: <20180517131727.29263-1-eric@anholt.net> <1412187220.62585.1526572780332@email.1und1.de> <alpine.DEB.2.21.1805171233500.7984@macbook-air> <307323036.63872.1526576126537@email.1und1.de> <20180517180758.GK12198@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2018, Peter Zijlstra wrote:

> On Thu, May 17, 2018 at 06:55:26PM +0200, Stefan Wahren wrote:
> > > Vince Weaver <vincent.weaver@maine.edu> hat am 17. Mai 2018 um 18:34 geschrieben:
> > > On Thu, 17 May 2018, Stefan Wahren wrote:
> > > > > Eric Anholt <eric@anholt.net> hat am 17. Mai 2018 um 15:17 geschrieben:
> 
> > > > > The a53 and a7 counters seem to match up, so we advertise a7 so that
> > > > > arm32 can probe.
> > > 
> > > so how closely did you look at the a53/a7 differences?  I see some major 
> > > differences, especially with the CPU_CYCLES event (0xff vs 0x11).
> > > 
> > > The proper fix here might be to add a cortex-a53 PMU entry to the armv7 
> > > code rather than trying to treat it as a cortex-a7.
> > 
> > we like to use the PMU of BCM2837 SoC (4x A53 cores) under arm32 and arm64.
> > 
> > What is the right way (tm) to the define the DT compatibles?
> > Does the arm32 PMU driver need patching for proper A53 support?
> 
> I'm completely clueless on all of this; Mark might have ideas.

Spending more time looking at it the only obvious differences are the 
previously mentioned CYCLES difference, as well as the cortex-a7 has
18 events in the perf_cache_map but cortex-a53 only has 3.  Plus probably 
support for the various other features of the armv8v3 pmu that the a7 
knows nothing about.

Is it hard to get lines in the DT changed once they are there?  If we go 
with cortex-a7 now, would it be possible to later drop that if proper 
cortex-a53 support is added to the armv7 pmu driver?  Or would that lead 
to all kinds of back-compatability mess?

Vince
