Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751852AbeFEMZo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:25:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34102 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbeFEMZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:25:43 -0400
Date: Tue, 5 Jun 2018 14:25:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 4/7] atomics: add common header generation files
Message-ID: <20180605122537.GJ12258@hirez.programming.kicks-ass.net>
References: <20180529180746.29684-1-mark.rutland@arm.com>
 <20180529180746.29684-5-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529180746.29684-5-mark.rutland@arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 07:07:43PM +0100, Mark Rutland wrote:
> +++ b/scripts/atomic/atomics.tbl
> @@ -0,0 +1,41 @@
> +# name	meta	args...
> +#
> +# Where meta contains a string of variants to generate.
> +# Upper-case implies _{acquire,release,relaxed} variants.
> +# Valid meta values are:
> +# * B/b	- bool: returns bool
> +# * v	- void: returns void
> +# * I/i	- int: returns base type
> +# * R	- return: returns base type (has _return variants)
> +# * F/f	- fetch: returns base type (has fetch_ variants)
> +# * l	- load: returns base type (has _acquire order variant)
> +# * s	- store: returns void (has _release order variant)
> +#
> +# Where args contains list of type[:name], where type is:
> +# * cv	- const pointer to atomic base type (atomic_t/atomic64_t/atomic_long_t)
> +# * v	- pointer to atomic base type (atomic_t/atomic64_t/atomic_long_t)
> +# * i	- base type (int/s64/long)
> +# * I	- pointer to base type (int/s64/long)

I thought we agreed to make that 'p' instead of 'I'.

> +#
> +read			l	cv
> +set			s	v	i
> +add			vRF	i	v
> +sub			vRF	i	v
> +inc			vRF	v
> +dec			vRF	v
> +and			vF	i	v
> +andnot			vF	i	v
> +or			vF	i	v
> +xor			vF	i	v
> +xchg			I	v	i
> +cmpxchg			I	v	i:old	i:new
> +try_cmpxchg		B	v	I:old	i:new
> +sub_and_test		b	i	v
> +dec_and_test		b	v
> +inc_and_test		b	v
> +add_negative		b	i	v
> +add_unless		fb	v	i:a	i:u
> +inc_not_zero		b	v
> +inc_unless_negative	b	v
> +dec_unless_positive	b	v
> +dec_if_positive		i	v
