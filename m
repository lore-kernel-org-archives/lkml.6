Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeDJJHI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 05:07:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53016 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753229AbeDJJHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 05:07:06 -0400
Date: Tue, 10 Apr 2018 11:07:03 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Nicholas Piggin <npiggin@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: Occasionally losing the tick_sched_timer
In-Reply-To: <20180410182651.727b5ae7@roar.ozlabs.ibm.com>
Message-ID: <alpine.DEB.2.21.1804101105260.2058@nanos.tec.linutronix.de>
References: <20180410121618.4fffffcc@roar.ozlabs.ibm.com> <alpine.DEB.2.21.1804100923430.2058@nanos.tec.linutronix.de> <20180410182651.727b5ae7@roar.ozlabs.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018, Nicholas Piggin wrote:
> On Tue, 10 Apr 2018 09:42:29 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> > > Thomas do you have any ideas on what we might look for, or if we can add
> > > some BUG_ON()s to catch this at its source?  
> > 
> > Not really. Tracing might be a more efficient tool that random BUG_ONs.
> 
> Sure, we could try that. Any suggestions? timer events?

timer, hrtimer and the tick-sched stuff should be a good start. And make
sure to freeze the trace once you hit the fault case. tracing_off() is your
friend.

Thanks,

	tglx
