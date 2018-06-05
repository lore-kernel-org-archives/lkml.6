Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeFEMwl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:52:41 -0400
Received: from foss.arm.com ([217.140.101.70]:55462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751625AbeFEMwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:52:40 -0400
Date: Tue, 5 Jun 2018 13:52:36 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 4/7] atomics: add common header generation files
Message-ID: <20180605125236.6d6tcfsql7q2hrnl@lakrids.cambridge.arm.com>
References: <20180529180746.29684-1-mark.rutland@arm.com>
 <20180529180746.29684-5-mark.rutland@arm.com>
 <20180605122537.GJ12258@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605122537.GJ12258@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 02:25:37PM +0200, Peter Zijlstra wrote:
> On Tue, May 29, 2018 at 07:07:43PM +0100, Mark Rutland wrote:
> > +++ b/scripts/atomic/atomics.tbl
> > @@ -0,0 +1,41 @@
> > +# name	meta	args...
> > +#
> > +# Where meta contains a string of variants to generate.
> > +# Upper-case implies _{acquire,release,relaxed} variants.
> > +# Valid meta values are:
> > +# * B/b	- bool: returns bool
> > +# * v	- void: returns void
> > +# * I/i	- int: returns base type
> > +# * R	- return: returns base type (has _return variants)
> > +# * F/f	- fetch: returns base type (has fetch_ variants)
> > +# * l	- load: returns base type (has _acquire order variant)
> > +# * s	- store: returns void (has _release order variant)
> > +#
> > +# Where args contains list of type[:name], where type is:
> > +# * cv	- const pointer to atomic base type (atomic_t/atomic64_t/atomic_long_t)
> > +# * v	- pointer to atomic base type (atomic_t/atomic64_t/atomic_long_t)
> > +# * i	- base type (int/s64/long)
> > +# * I	- pointer to base type (int/s64/long)
> 
> I thought we agreed to make that 'p' instead of 'I'.

Whoops; I'd left that as a cleanup and never folded it in.

Fixed up now.

Thanks,
Mark
