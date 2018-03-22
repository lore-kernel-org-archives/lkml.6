Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbeCVTLq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 15:11:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeCVTLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 15:11:43 -0400
Date: Thu, 22 Mar 2018 20:11:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Rik van Riel <riel@surriel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpuidle: poll_state: Add time limit to poll_idle()
Message-ID: <20180322191127.GY4043@hirez.programming.kicks-ass.net>
References: <4137867.C4jYrWdt8n@aspire.rjw.lan>
 <20180314120450.GT4043@hirez.programming.kicks-ass.net>
 <1521736338.6308.24.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521736338.6308.24.camel@surriel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 12:32:18PM -0400, Rik van Riel wrote:
> On Wed, 2018-03-14 at 13:04 +0100, Peter Zijlstra wrote:
> 
> > On x86 we don't have to use that time_check_counter thing,
> > sched_clock()
> > is really cheap, not sure if it makes sense on other platforms.
> 
> Are you sure? I saw a 5-10% increase in CPU use,
> for a constant query rate to a memcache style
> workload, with v3 of this patch.

Well, I expected it to be really cheap, but if you have numbers saying
otherwise, clearly I'll need to adjust expectations ;-)
