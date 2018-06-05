Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeFEKyO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:54:14 -0400
Received: from ozlabs.org ([203.11.71.1]:50307 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751386AbeFEKyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:54:13 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>
Subject: Re: [PATCHv2 05/16] atomics: prepare for atomic64_fetch_add_unless()
In-Reply-To: <20180605095357.64zgw3uq3py2pjs4@lakrids.cambridge.arm.com>
References: <20180529154346.3168-1-mark.rutland@arm.com> <20180529154346.3168-6-mark.rutland@arm.com> <20180605092637.GF12258@hirez.programming.kicks-ass.net> <20180605095357.64zgw3uq3py2pjs4@lakrids.cambridge.arm.com>
Date: Tue, 05 Jun 2018 20:54:03 +1000
Message-ID: <87bmcpo65w.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rutland <mark.rutland@arm.com> writes:
> On Tue, Jun 05, 2018 at 11:26:37AM +0200, Peter Zijlstra wrote:
>> On Tue, May 29, 2018 at 04:43:35PM +0100, Mark Rutland wrote:
>> >  /**
>> > + * atomic64_add_unless - add unless the number is already a given value
>> > + * @v: pointer of type atomic_t
>> > + * @a: the amount to add to v...
>> > + * @u: ...unless v is equal to u.
>> > + *
>> > + * Atomically adds @a to @v, so long as @v was not already @u.
>> > + * Returns non-zero if @v was not @u, and zero otherwise.
>> 
>> I always get confused by that wording; would something like: "Returns
>> true if the addition was done" not be more clear?
>
> Sounds clearer to me; I just stole the wording from the existing
> atomic_add_unless().
>
> I guess you'll want similar for the conditional inc/dec ops, e.g.
>
> /**
>  * atomic_inc_not_zero - increment unless the number is zero
>  * @v: pointer of type atomic_t
>  *
>  * Atomically increments @v by 1, so long as @v is non-zero.
>  * Returns non-zero if @v was non-zero, and zero otherwise.
>  */

If we're bike-shedding .. :)

I think "so long as" is overly wordy and not helpful. It'd be clearer
just as:

  * Atomically increments @v by 1, if @v is non-zero.

cheers
