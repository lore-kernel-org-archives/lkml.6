Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbeDERWn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 13:22:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33750 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751368AbeDERWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 13:22:42 -0400
Date: Thu, 5 Apr 2018 19:22:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, paulmck@linux.vnet.ibm.com,
        catalin.marinas@arm.com, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 06/10] barriers: Introduce smp_cond_load_relaxed and
 atomic_cond_read_relaxed
Message-ID: <20180405172226.GF4082@hirez.programming.kicks-ass.net>
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-7-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522947547-24081-7-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 05:59:03PM +0100, Will Deacon wrote:
> diff --git a/include/linux/atomic.h b/include/linux/atomic.h
> index 8b276fd9a127..01ce3997cb42 100644
> --- a/include/linux/atomic.h
> +++ b/include/linux/atomic.h
> @@ -654,6 +654,7 @@ static inline int atomic_dec_if_positive(atomic_t *v)
>  }
>  #endif
>  
> +#define atomic_cond_read_relaxed(v, c)	smp_cond_load_relaxed(&(v)->counter, (c))
>  #define atomic_cond_read_acquire(v, c)	smp_cond_load_acquire(&(v)->counter, (c))
>  
>  #ifdef CONFIG_GENERIC_ATOMIC64
> @@ -1075,6 +1076,7 @@ static inline long long atomic64_fetch_andnot_release(long long i, atomic64_t *v
>  }
>  #endif
>  
> +#define atomic64_cond_read_relaxed(v, c)	smp_cond_load_relaxed(&(v)->counter, (c))
>  #define atomic64_cond_read_acquire(v, c)	smp_cond_load_acquire(&(v)->counter, (c))
>  
>  #include <asm-generic/atomic-long.h>

Did we again forget atomic_long glue ? ;-)
