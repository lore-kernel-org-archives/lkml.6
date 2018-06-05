Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbeFEJ1W (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:27:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59728 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbeFEJ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:27:19 -0400
Date: Tue, 5 Jun 2018 11:26:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>
Subject: Re: [PATCHv2 05/16] atomics: prepare for atomic64_fetch_add_unless()
Message-ID: <20180605092637.GF12258@hirez.programming.kicks-ass.net>
References: <20180529154346.3168-1-mark.rutland@arm.com>
 <20180529154346.3168-6-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529154346.3168-6-mark.rutland@arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 04:43:35PM +0100, Mark Rutland wrote:
>  /**
> + * atomic64_add_unless - add unless the number is already a given value
> + * @v: pointer of type atomic_t
> + * @a: the amount to add to v...
> + * @u: ...unless v is equal to u.
> + *
> + * Atomically adds @a to @v, so long as @v was not already @u.
> + * Returns non-zero if @v was not @u, and zero otherwise.

I always get confused by that wording; would something like: "Returns
true if the addition was done" not be more clear?

> + */
> +#ifdef atomic64_fetch_add_unless
> +static inline int atomic64_add_unless(atomic64_t *v, long long a, long long u)

Do we want to make that a "bool' return?

> +{
> +	return atomic64_fetch_add_unless(v, a, u) != u;
> +}
> +#endif
