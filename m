Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753438AbeBLRnT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:43:19 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51580 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753216AbeBLRnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:43:17 -0500
X-Google-Smtp-Source: AH8x22748fsaD0bCW9xxCbyFGbxLsOz+vX8cc/foqeqMmviXIJHqn1HKbDcoF2uOOErjwo7uZcxRJA==
Date: Mon, 12 Feb 2018 18:43:12 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, vincent.guittot@linaro.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com,
        morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, alessio.balsini@arm.com
Subject: Re: [RFC PATCH 1/3] sched/deadline: merge dl_bw into dl_bandwidth
Message-ID: <20180212174312.GN12979@localhost.localdomain>
References: <20180212134030.12846-1-juri.lelli@redhat.com>
 <20180212134030.12846-2-juri.lelli@redhat.com>
 <20180212123430.6f8e4d6e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212123430.6f8e4d6e@gandalf.local.home>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/18 12:34, Steven Rostedt wrote:
> On Mon, 12 Feb 2018 14:40:28 +0100
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > + *  - dl_bw (< 100%) is the bandwidth of the system (domain) on each CPU;
> > + *  - dl_total_bw array contains the currently allocated bandwidth on the
> > + *    i-eth CPU.
> 
> The comment for dl_total_bw doesn't make sense. You mean that
> dl_total_bw is the cpu's bandwidth? If so, let's not call it total,
> because that would suggest it's the bandwidth of all CPUs. What about
> dl_cpu_bw?

Huh, I meant to properly fix this (broken already in mainline) comment,
but I only managed to do that (hopefully) in next patch. :/

However, this surely needs to be fixed here. It's tracking the sum of
all tasks' (across CPUs) bandwidth admitted on the system, so that's why
it's called dl_total_bw. Incremented when a task passes sched_setattr()
and decremented when it leaves the system or changes scheduling class.

Does it make a bit more sense? Would you still prefer a different name?

Thanks,

- Juri
