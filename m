Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755393AbeDCJam (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 05:30:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35660 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755198AbeDCJak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 05:30:40 -0400
Date: Tue, 3 Apr 2018 11:30:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20180403093030.GB4082@hirez.programming.kicks-ass.net>
References: <20180403154122.00d76d61@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403154122.00d76d61@canb.auug.org.au>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 03:41:22PM +1000, Stephen Rothwell wrote:

> Caused by commit
> 
>   9b8cce52c4b5 ("sched/wait: Remove the wait_on_atomic_t() API")
> 
> interacting with commits
> 
>   d3be4d244330 ("xrpc: Fix potential call vs socket/net destruction race")
>   31f5f9a1691e ("rxrpc: Fix apparent leak of rxrpc_local objects")
> 
> from the net-next tree.
> 
> Haven't we figured out how to remove/change APIs yet? :-(

I figured that since there were only a handful of users it wasn't a
popular API, also David very much knew of those patches changing it so
could easily have pulled in the special tip/sched/wait branch :/
