Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeBTPoP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:44:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751340AbeBTPoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:44:10 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C555421716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Tue, 20 Feb 2018 16:44:07 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <kernellwp@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 4/6] sched/isolation: Offload residual 1Hz scheduler tick
Message-ID: <20180220154405.GA13879@lerouge>
References: <1518655694-8057-1-git-send-email-frederic@kernel.org>
 <1518655694-8057-5-git-send-email-frederic@kernel.org>
 <alpine.DEB.2.21.1802171138001.2087@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1802171138001.2087@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 11:50:52AM +0100, Thomas Gleixner wrote:
> On Thu, 15 Feb 2018, Frederic Weisbecker wrote:
> 
> > When a CPU runs in full dynticks mode, a 1Hz tick remains in order to
> > keep the scheduler stats alive. However this residual tick is a burden
> > for bare metal tasks that can't stand any interruption at all, or want
> > to minimize them.
> > 
> > The usual boot parameters "nohz_full=" or "isolcpus=nohz" will now
> > outsource these scheduler ticks to the global workqueue so that a
> > housekeeping CPU handles those remotely. The sched_class::task_tick()
> > implementations have been audited and look safe to be called remotely
> > as the target runqueue and its current task are passed in parameter
> > and don't seem to be accessed locally.
> 
> That scares me a bit. Not for the current state of affairs, but we want to
> ensure that this still works in 2 years from now
> 
> So at least you want to add a comment to task_tick() which explains the
> constraints which come with the remote tick.

Good point, I'm adding that.

> 
> Other than that this looks good!
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks!
