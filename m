Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934895AbeBMQgl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:36:41 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51029 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934210AbeBMQgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:36:40 -0500
Date: Tue, 13 Feb 2018 17:36:34 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: David Miller <davem@davemloft.net>, edumazet@google.com,
        torvalds@linux-foundation.org, efault@gmx.de, peterz@infradead.org,
        dima@arista.com, frederic@kernel.org, linux-kernel@vger.kernel.org,
        0x7f454c46@gmail.com, akpm@linux-foundation.org, fweisbec@gmail.com,
        hannes@stressinduktion.org, mingo@kernel.org,
        alexander.levin@verizon.com, pabeni@redhat.com,
        paulmck@linux.vnet.ibm.com, rrendec@arista.com, riel@redhat.com,
        sgruszka@redhat.com, wanpeng.li@hotmail.com
Subject: Re: [RFC 1/2] softirq: Defer net rx/tx processing to ksoftirqd
 context
In-Reply-To: <20180206165649.cze4iy4k36rcigbe@breakpoint.cc>
Message-ID: <alpine.DEB.2.21.1802131735460.1130@nanos.tec.linutronix.de>
References: <CA+55aFzk0Lh1kQRRvOQKrjMfkcuQem0aV5D9cCUmmtfw7ZamkQ@mail.gmail.com> <alpine.DEB.2.20.1801172258540.2326@nanos> <CANn89iJmA-21uL+pPBiV6zsrR7nY6RJ6bamDCgPctMoNWpa4Hw@mail.gmail.com> <20180117.172447.1568697383040902713.davem@davemloft.net>
 <20180206165649.cze4iy4k36rcigbe@breakpoint.cc>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2018, Sebastian Andrzej Siewior wrote:

> On 2018-01-17 17:24:47 [-0500], David Miller wrote:
> > From: Eric Dumazet <edumazet@google.com>
> > Date: Wed, 17 Jan 2018 14:02:43 -0800
> > > There is also the netif_rx_ni() stuff.
> > > 
> > > Can't remember right now why it is not using
> > > local_bh_{diable,enable}() pair instead
> > > of preempt_disable() ... if (local_softirq_pending()) do_softirq();
> > 
> > Hmmm, that code predates the initial GIT repository build.
> > 
> > I do remember we had some back and forth with that stuff.
> 
> So I did a little research and tried to replace preempt_disable() with
> local_bh_disable() [0] a while ago.
> 
> [0] https://lkml.kernel.org/r/20170616172400.10809-1-bigeasy@linutronix.de

Maybe you should just try again with a slightly better changelog :)
