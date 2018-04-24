Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753465AbeDXJG2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:06:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34577 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751239AbeDXJGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:06:24 -0400
Date: Tue, 24 Apr 2018 11:06:19 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
cc: Diego Viola <diego.viola@gmail.com>, linux-kernel@vger.kernel.org,
        len.brown@intel.com, rui.zhang@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Experiencing freezes with kernel 4.16.3 on a desktop with E5500
 CPU (bisect included)
In-Reply-To: <20180423164425.GS4129@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1804241105180.5261@nanos.tec.linutronix.de>
References: <CA+ToGPE59B0EKYkRbMcoddEtWwe50nXNu-91UMdjamz+s8nKfg@mail.gmail.com> <20180423091633.GU4064@hirez.programming.kicks-ass.net> <CA+ToGPEaHb1ueDRGuzCzm_HxketqxW8j1gawEsCCp2QGLCA=xg@mail.gmail.com> <20180423114850.GK4082@hirez.programming.kicks-ass.net>
 <CA+ToGPHA+Y=0PtiXF7fTSqSgwtzsJy3Z=U1i3xiW9jkzQGsXWQ@mail.gmail.com> <20180423123847.GL4082@hirez.programming.kicks-ass.net> <20180423155801.GQ4129@hirez.programming.kicks-ass.net> <20180423164425.GS4129@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2018, Peter Zijlstra wrote:

> On Mon, Apr 23, 2018 at 05:58:01PM +0200, Peter Zijlstra wrote:
> > Thomas, we could not find the de-rate stuff, but the above can be
> > simplified; what happens is:
> > 
> > 	cs->flags |= UNSTABLE;
> > 	schedule_work(&watchdog_work)
> > 	  kthread_run(clocksource_watchdog_kthread)
> 
> Also, Thomas, do you remember why we spawn a short running kthread from
> a work ? Can't we simply run the whole thing from the worker thread?

No. I think we did it directly in the early days and then it was changed to
that worker/thread stuff for whatever reason. I need to do git archaeology.

Thanks,

	tglx
