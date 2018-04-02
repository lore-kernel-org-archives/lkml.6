Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932520AbeDBUgp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 16:36:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932425AbeDBUgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 16:36:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C30C20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Mon, 2 Apr 2018 22:36:39 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
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
Subject: Re: [PATCH v8 02/10] sched: idle: Do not stop the tick upfront in
 the idle loop
Message-ID: <20180402203638.GA19895@lerouge>
References: <40092860.XNQZrLjKDd@aspire.rjw.lan>
 <1665095.utJuM4vCji@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1665095.utJuM4vCji@aspire.rjw.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 02:01:14PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Push the decision whether or not to stop the tick somewhat deeper
> into the idle loop.
> 
> Stopping the tick upfront leads to unpleasant outcomes in case the
> idle governor doesn't agree with the nohz code on the duration of the
> upcoming idle period.  Specifically, if the tick has been stopped and
> the idle governor predicts short idle, the situation is bad regardless
> of whether or not the prediction is accurate.  If it is accurate, the
> tick has been stopped unnecessarily which means excessive overhead.
> If it is not accurate, the CPU is likely to spend too much time in
> the (shallow, because short idle has been predicted) idle state
> selected by the governor [1].
> 
> As the first step towards addressing this problem, change the code
> to make the tick stopping decision inside of the loop in do_idle().
> In particular, do not stop the tick in the cpu_idle_poll() code path.
> Also don't do that in tick_nohz_irq_exit() which doesn't really have
> enough information on whether or not to stop the tick.
> 
> Link: https://marc.info/?l=linux-pm&m=150116085925208&w=2 # [1]
> Link: https://tu-dresden.de/zih/forschung/ressourcen/dateien/projekte/haec/powernightmares.pdf
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
