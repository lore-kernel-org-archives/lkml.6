Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbeCOMdY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:33:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47102 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeCOMdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:33:22 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFT][PATCH v4 1/7] time: tick-sched: Reorganize idle tick management code
Date: Thu, 15 Mar 2018 13:33:54 +0100
Message-ID: <22374739.VLR6IT0dbg@aspire.rjw.lan>
In-Reply-To: <20180314154934.GA3635@lerouge>
References: <2352117.3UUoYAu18A@aspire.rjw.lan> <2019498.YXfJVQUTuX@aspire.rjw.lan> <20180314154934.GA3635@lerouge>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 14, 2018 4:49:39 PM CET Frederic Weisbecker wrote:
> On Mon, Mar 12, 2018 at 10:47:41AM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Prepare the scheduler tick code for reworking the idle loop to
> > avoid stopping the tick in some cases.
> > 
> > Move away the tick_nohz_start_idle() invocation from
> > __tick_nohz_idle_enter(), rename the latter to
> > __tick_nohz_idle_stop_tick() and define tick_nohz_idle_stop_tick()
> > as a wrapper around it for calling it from the outside.
> > 
> > Make tick_nohz_idle_enter() only call tick_nohz_start_idle() instead
> > of calling the entire __tick_nohz_idle_enter(), add another wrapper
> > disabling and enabling interrupts around tick_nohz_idle_stop_tick()
> > and make the current callers of tick_nohz_idle_enter() call it too
> > to retain their current functionality.
> 
> Perhaps we should have a higher level description of what the patch does.
> After all the low level part is already described in the diff.
> 
> Ie: we are splitting the nohz idle entry call to decouple the idle time
> stats accounting and preparatory work from the actual tick stop code, that
> in order to later be able to delay the tick stop once we reach more
> power-knowledgeable callers.

OK
