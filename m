Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162491AbeBPRzO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:55:14 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:57058 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161064AbeBPRzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:55:13 -0500
Date: Fri, 16 Feb 2018 18:55:09 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/2] kernel/sofirq: consolidate common code in
 __tasklet_schedule() + _hi_
Message-ID: <20180216175508.vezb3ll32dxvlz4z@linutronix.de>
References: <20180215172042.31573-1-bigeasy@linutronix.de>
 <20180215172042.31573-2-bigeasy@linutronix.de>
 <20180215150707.49cc2332@gandalf.local.home>
 <20180216085302.ptzq5yspmdq3zlh6@linutronix.de>
 <20180216123109.5098b1ca@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180216123109.5098b1ca@gandalf.local.home>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-16 12:31:09 [-0500], Steven Rostedt wrote:
> On Fri, 16 Feb 2018 09:53:03 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > As for the second invocation (tasklet_action_common() part) is always
> > invoked in BH-disabled context (even if called from ksoftirqd) so you
> > are never preemptible() and can't switch CPUs.
> > So I am going to correct this patch as you suggested but I don't see the
> > reason to do the same in the second one.
> 
> Should we add something like:
> 
> 	WARN_ON_ONCE(!in_atomic());
> 
> ?

Doubt it. this_cpu_ptr() screams already with CONFIG_DEBUG_PREEMPT.

> -- Steve

Sebastian
