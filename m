Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbeBJKWM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 05:22:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751077AbeBJKWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 05:22:11 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7198921726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Sat, 10 Feb 2018 11:22:05 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <kernellwp@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 3/6] sched/isolation: Isolate workqueues when
 "nohz_full=" is set
Message-ID: <20180210102203.GA14047@lerouge>
References: <1518112779-30196-1-git-send-email-frederic@kernel.org>
 <1518112779-30196-4-git-send-email-frederic@kernel.org>
 <20180209065544.6ywka67hwerdrtvt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209065544.6ywka67hwerdrtvt@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 07:55:44AM +0100, Ingo Molnar wrote:
> 
> * Frederic Weisbecker <frederic@kernel.org> wrote:
> 
> > -	flags = HK_FLAG_TICK | HK_FLAG_TIMER | HK_FLAG_RCU | HK_FLAG_MISC;
> > +	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER |
> > +		HK_FLAG_RCU | HK_FLAG_MISC;
> 
> > -	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(HK_FLAG_DOMAIN));
> > +	cpumask_copy(wq_unbound_cpumask,
> > +		     housekeeping_cpumask(HK_FLAG_DOMAIN | HK_FLAG_WQ));
> 
> LGTM, but _please_ don't do these ugly line-breaks, just keep it slightly over 
> col80.

Works for me, I'll fix.

Thanks.
