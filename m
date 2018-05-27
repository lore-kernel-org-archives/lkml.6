Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbeE0UHN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 16:07:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44516 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751343AbeE0UHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 16:07:12 -0400
Date: Sun, 27 May 2018 22:07:08 +0200
From: Borislav Petkov <bp@alien8.de>
To: Gabriel C <nix.or.die@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: smpboot seems to be confused on dual EPYC system
Message-ID: <20180527200707.GC6349@zn.tnic>
References: <CAEJqkgjMdeeiF+apcAGKdOJQRvaq8SLFsS2dvpuapY1DQn6oTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEJqkgjMdeeiF+apcAGKdOJQRvaq8SLFsS2dvpuapY1DQn6oTA@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 03:23:32PM +0200, Gabriel C wrote:
> Hello,
> 
> I have an H11DSi-NT board with 2 *  EPYC 7281 16C/32T CPUs.
> 
> On that box for some reason spmboot things '4' logical packages
> are possible.

First of all, which kernel?

> Max CPUs can be 128 ( 2 * 32C/64T ), however only 2 CPUs are possible
> not 4 and therefor there is no way to add other 64 hotplug CPUs.
> ( not even sure cpu hotplug will work here )
> 
> $ dmesg | egrep "smpboot|NR_CPUS|CPUs"
> [    0.000000] smpboot: Allowing 128 CPUs, 64 hotplug CPUs

Your BIOS is made to support 32-Core CPUs too.

> [    0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:128
> nr_cpu_ids:128 nr_node_ids:8
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=128, Nodes=8
> [    0.000000]  RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=128.
> [    0.037000] smpboot: CPU0: AMD EPYC 7281 16-Core Processor (family:
> 0x17, model: 0x1, stepping: 0x2)

That says 2 * 16C * 2T = 64T.

> [    0.048005] smp: Bringing up secondary CPUs ...
> [    0.055042] .... node  #0, CPUs:          #1   #2   #3
> [    0.079029] .... node  #1, CPUs:     #4   #5   #6   #7
> [    0.111049] .... node  #2, CPUs:     #8   #9  #10  #11
> [    0.143050] .... node  #3, CPUs:    #12  #13  #14  #15
> [    0.175031] .... node  #4, CPUs:    #16  #17  #18  #19
> [    0.217031] .... node  #5, CPUs:    #20  #21  #22  #23
> [    0.249062] .... node  #6, CPUs:    #24  #25  #26  #27
> [    0.281058] .... node  #7, CPUs:    #28  #29  #30  #31
> [    0.313028] .... node  #0, CPUs:    #32  #33  #34  #35
> [    0.345028] .... node  #1, CPUs:    #36  #37  #38  #39
> [    0.377046] .... node  #2, CPUs:    #40  #41  #42  #43
> [    0.409043] .... node  #3, CPUs:    #44  #45  #46  #47
> [    0.441028] .... node  #4, CPUs:    #48  #49  #50  #51
> [    0.473029] .... node  #5, CPUs:    #52  #53  #54  #55
> [    0.505060] .... node  #6, CPUs:    #56  #57  #58  #59
> [    0.537052] .... node  #7, CPUs:    #60  #61  #62  #63
> [    0.562171] smp: Brought up 8 nodes, 64 CPUs
> [    0.562171] smpboot: Max logical packages: 4
> [    0.562171] smpboot: Total of 64 processors activated (268089.53 BogoMIPS)

You have 64 logical CPUs.

So what is the problem?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
