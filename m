Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbeDGQg2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 12:36:28 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52177 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbeDGQg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 12:36:27 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v9 06/10] time: tick-sched: Split tick_nohz_stop_sched_tick()
Date: Sat, 07 Apr 2018 18:36:34 +0200
Message-ID: <2792573.Q2KagqXIrf@aspire.rjw.lan>
In-Reply-To: <20180407023623.GA16600@lerouge>
References: <1736751.LdhZHb50jq@aspire.rjw.lan> <4511679.r9V9QramI4@aspire.rjw.lan> <20180407023623.GA16600@lerouge>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, April 7, 2018 4:36:25 AM CEST Frederic Weisbecker wrote:
> On Wed, Apr 04, 2018 at 10:41:13AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > In order to address the issue with short idle duration predictions
> > by the idle governor after the scheduler tick has been stopped, split
> > tick_nohz_stop_sched_tick() into two separate routines, one computing
> > the time to the next timer event and the other simply stopping the
> > tick when the time to the next timer event is known.
> > 
> > Prepare these two routines to be called separately, as one of them
> > will be called by the idle governor in the cpuidle_select() code
> > path after subsequent changes.
> > 
> > Update the former callers of tick_nohz_stop_sched_tick() to use
> > the new routines, tick_nohz_next_event() and tick_nohz_stop_tick(),
> > instead of it and move the updates of the sleep_length field in
> > struct tick_sched into __tick_nohz_idle_stop_tick() as it doesn't
> > need to be updated anywhere else.
> > 
> > There should be no intentional visible changes in functionality
> > resulting from this change.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Thanks! And sorry for the slow reviews, the changes are sensitive

Right, very much so.

> and I want to make sure we are not breaking some subtlety.

Thanks a lot for doing that!
