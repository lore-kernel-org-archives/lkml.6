Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeDEI1n (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 04:27:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDEI1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 04:27:04 -0400
Date: Thu, 5 Apr 2018 10:27:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: sched_rt_period_timer causing large latencies
Message-ID: <20180405082701.GL4082@hirez.programming.kicks-ass.net>
References: <20180405091138.6ef14d15@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405091138.6ef14d15@roar.ozlabs.ibm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 09:11:38AM +1000, Nicholas Piggin wrote:
> Hi,
> 
> I'm seeing some pretty big latencies on a ~idle system when a CPU wakes
> out of a nohz idle. Looks like it's due to the taking a lot of remote
> locks and cache lines. irqoff trace:

On RT I think we default RT_RUNTIME_SHARE to false, maybe we should do
the same for mainline. It's always been a dodgy feature and if we ever
figure out how to do FIFO servers this code will be deleted entirely.
