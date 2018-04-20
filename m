Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754086AbeDTI2j (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:28:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753924AbeDTI2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:28:37 -0400
Date: Fri, 20 Apr 2018 10:28:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: Re: [PATCH] kernel: event: core: Change return type to vm_fault_t
Message-ID: <20180420082829.GE4064@hirez.programming.kicks-ass.net>
References: <20180414202831.GA20373@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180414202831.GA20373@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 15, 2018 at 01:58:31AM +0530, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler and
> page_mkwrite handler in struct vm_operations_struct.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
>  kernel/events/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 96db9ae..d09f1c4 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4918,11 +4918,11 @@ void perf_event_update_userpage(struct perf_event *event)
>  }
>  EXPORT_SYMBOL_GPL(perf_event_update_userpage);
> 
> -static int perf_mmap_fault(struct vm_fault *vmf)
> +static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)

I'm fine with the patch, but shouldn't this be part of a larger series /
cocinelle script?

Even if not everything that has a (struct vm_fault *) argument is a
fault handler, you could still match on the function being assigned to
vm_operations_struct::fault.

So ACK on the patch, but please don't do this with a slow trickle of
individual patches.
