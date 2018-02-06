Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753351AbeBFQ7I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:59:08 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:35192 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752331AbeBFQ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:56:58 -0500
Date: Tue, 6 Feb 2018 17:56:49 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: David Miller <davem@davemloft.net>
Cc: edumazet@google.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        efault@gmx.de, peterz@infradead.org, dima@arista.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org,
        0x7f454c46@gmail.com, akpm@linux-foundation.org, fweisbec@gmail.com,
        hannes@stressinduktion.org, mingo@kernel.org,
        alexander.levin@verizon.com, pabeni@redhat.com,
        paulmck@linux.vnet.ibm.com, rrendec@arista.com, riel@redhat.com,
        sgruszka@redhat.com, wanpeng.li@hotmail.com
Subject: Re: [RFC 1/2] softirq: Defer net rx/tx processing to ksoftirqd
 context
Message-ID: <20180206165649.cze4iy4k36rcigbe@breakpoint.cc>
References: <CA+55aFzk0Lh1kQRRvOQKrjMfkcuQem0aV5D9cCUmmtfw7ZamkQ@mail.gmail.com>
 <alpine.DEB.2.20.1801172258540.2326@nanos>
 <CANn89iJmA-21uL+pPBiV6zsrR7nY6RJ6bamDCgPctMoNWpa4Hw@mail.gmail.com>
 <20180117.172447.1568697383040902713.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180117.172447.1568697383040902713.davem@davemloft.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-01-17 17:24:47 [-0500], David Miller wrote:
> From: Eric Dumazet <edumazet@google.com>
> Date: Wed, 17 Jan 2018 14:02:43 -0800
> > There is also the netif_rx_ni() stuff.
> > 
> > Can't remember right now why it is not using
> > local_bh_{diable,enable}() pair instead
> > of preempt_disable() ... if (local_softirq_pending()) do_softirq();
> 
> Hmmm, that code predates the initial GIT repository build.
> 
> I do remember we had some back and forth with that stuff.

So I did a little research and tried to replace preempt_disable() with
local_bh_disable() [0] a while ago.

[0] https://lkml.kernel.org/r/20170616172400.10809-1-bigeasy@linutronix.de

Sebastian
