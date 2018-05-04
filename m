Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeEDQVJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 12:21:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59688 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbeEDQVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 12:21:08 -0400
Date: Fri, 4 May 2018 18:21:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org
Subject: Re: Introduce atomic_dec_and_lock_irqsave()
Message-ID: <20180504162102.GQ12217@hirez.programming.kicks-ass.net>
References: <20180504154533.8833-1-bigeasy@linutronix.de>
 <20180504155446.GP12217@hirez.programming.kicks-ass.net>
 <20180504160726.ikotgmd5fbix7b6b@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504160726.ikotgmd5fbix7b6b@linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 06:07:26PM +0200, Sebastian Andrzej Siewior wrote:

> do you intend to kill refcount_dec_and_lock() in the longterm?

You meant to say atomic_dec_and_lock() ? Dunno if we ever get there, but
typically dec_and_lock is fairly refcounty, but I suppose it is possible
to have !refcount users, in which case we're eternally stuck with it.

But a quick look at the sites you converted, they all appear to be true
refcounts, and would thus benefit from being converted to refcount_t.
