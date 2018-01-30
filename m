Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753837AbeA3VDb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 16:03:31 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45207 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeA3VD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 16:03:27 -0500
Date: Tue, 30 Jan 2018 22:03:17 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: Sebastian Sewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] hrtimer: Reset hrtimer cpu base proper on CPU hotplug
In-Reply-To: <20180129234347.GA26365@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1801302202510.2293@nanos>
References: <alpine.DEB.2.20.1801261447590.2067@nanos> <20180126220917.GI3741@linux.vnet.ibm.com> <20180129082047.hash3pnhpztzcg22@linutronix.de> <20180129095738.GU3741@linux.vnet.ibm.com> <20180129234347.GA26365@linux.vnet.ibm.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2018, Paul E. McKenney wrote:

> On Mon, Jan 29, 2018 at 01:57:38AM -0800, Paul E. McKenney wrote:
> > On Mon, Jan 29, 2018 at 09:20:48AM +0100, Sebastian Sewior wrote:
> > > On 2018-01-26 14:09:17 [-0800], Paul E. McKenney wrote:
> > > > find this one.  ;-)  But it did pass rcutorture testing for a great many
> > > > years, didn't it?  :-/
> > > 
> > > It started to trigger better (or at all) on our test box with
> > > 	modprobe kvm_intel preemption_timer=n
> > > 
> > > on the host kernel so maybe a completely unrelated change helped to
> > > trigger this.
> > 
> > Good point!
> > 
> > And testing continues, currently at 108 hours of TREE01 without any
> > waylayed timers, so looking good!  ;-)
> > 
> > Just kicked off another 70 hours worth.
> 
> And those completed without incident for a total of 178 hours.  I believe
> we can call this one fixed.  Thank you all!!!
> 
> One question...  Is the patch shown below needed, or is this just yet
> another case of me being confused?  (The lack of it is not triggering,
> but...)

See commit 26456f87aca7
