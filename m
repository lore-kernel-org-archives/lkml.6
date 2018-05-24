Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965016AbeEXMoS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 08:44:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935296AbeEXMoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 08:44:14 -0400
Date: Thu, 24 May 2018 14:44:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org, yamada.masahiro@socionext.com
Subject: Re: [PATCH 6/9] asm-generic/bitops/atomic.h: Rewrite using
 atomic_fetch_*
Message-ID: <20180524124410.GF12198@hirez.programming.kicks-ass.net>
References: <1527159586-8578-1-git-send-email-will.deacon@arm.com>
 <1527159586-8578-7-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527159586-8578-7-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 11:59:43AM +0100, Will Deacon wrote:
> +static inline void set_bit(unsigned int nr, volatile unsigned long *p)
>  {
> +	p += BIT_WORD(nr);
> +	atomic_long_fetch_or_relaxed(BIT_MASK(nr), (atomic_long_t *)p);
>  }
>  
> +static inline void clear_bit(unsigned int nr, volatile unsigned long *p)
>  {
> +	p += BIT_WORD(nr);
> +	atomic_long_fetch_andnot_relaxed(BIT_MASK(nr), (atomic_long_t *)p);
>  }
>  
> +static inline void change_bit(unsigned int nr, volatile unsigned long *p)
>  {
> +	p += BIT_WORD(nr);
> +	atomic_long_fetch_xor_relaxed(BIT_MASK(nr), (atomic_long_t *)p);
>  }

Why use the fetch variants here?
