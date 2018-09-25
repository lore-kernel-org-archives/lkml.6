Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B77C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A601620842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n/idxsNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A601620842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeIYQxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:53:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57338 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbeIYQxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MejC+4zc43EWHejjlWoVt7RZayK70nthlvp1HZ1fdsY=; b=n/idxsNLjIrg3kEbPgC/Hw2EF
        pvS9RELaIG1Um8IQNFi95JK3ppndRqyDk/ygcirzWvAIMRDnT5bCYo/QaGQmcmDyAx67IWs1TcnLH
        qYy4bS2Wx3UQCb1B5LKGMOWnAuveLFfq15L1CpYKcjbWAhdzen2nUoHaSp4i1HEzwKTwVjOnwCIdB
        vPkGRgh6YKmSEPN/ivGAu9LWlldbXgQZenVYK9bMVgDKkhydyrY6W5GlpgBQbEVEY8ffKAWDnoEg1
        TeWP3jf22+baY94BFU8wlA15NAors5AAoydg8yBBPDLY+LpXqPfpqscEGoD5sbgzCPEXpfB6HQ/nc
        x1UshvjBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4kqh-0000vO-Cm; Tue, 25 Sep 2018 10:46:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E8A22029F4C2; Tue, 25 Sep 2018 12:45:41 +0200 (CEST)
Date:   Tue, 25 Sep 2018 12:45:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Guo Ren <ren_guo@c-sky.com>, akpm@linux-foundation.org,
        arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, robh@kernel.org, robh+dt@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        green.hu@gmail.com, palmer@sifive.com
Subject: Re: [PATCH V5 17/30] csky: Misc headers
Message-ID: <20180925104541.GA27311@hirez.programming.kicks-ass.net>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <5ae1990e1863fe2293bba1e5ec0408892a9a7f0c.1537789737.git.ren_guo@c-sky.com>
 <20180925100803.GA6891@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925100803.GA6891@andrea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 12:08:03PM +0200, Andrea Parri wrote:
> Hi Guo,
> 
> > +/*
> > + * set_bit - Atomically set a bit in memory
> > + * @nr: the bit to set
> > + * @addr: the address to start counting from
> > + *
> > + * This function is atomic and may not be reordered.  See __set_bit()
> > + * if you do not require the atomic guarantees.
> > + *
> > + * Note: there are no guarantees that this function will not be reordered
> > + * on non x86 architectures, so if you are writing portable code,
> > + * make sure not to rely on its reordering guarantees.
> > + *
> > + * Note that @nr may be almost arbitrarily large; this function is not
> > + * restricted to acting on a single-word quantity.
> > + */
> > +static inline void set_bit(int nr, volatile unsigned long *addr)
> > +{
> > +	unsigned long mask = BIT_MASK(nr);
> > +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> > +	unsigned long tmp;
> > +
> > +	/* *p  |= mask; */
> > +	smp_mb();
> > +	asm volatile (
> > +		"1:	ldex.w		%0, (%2)	\n"
> > +		"	or32		%0, %0, %1	\n"
> > +		"	stex.w		%0, (%2)	\n"
> > +		"	bez		%0, 1b		\n"
> > +		: "=&r"(tmp)
> > +		: "r"(mask), "r"(p)
> > +		: "memory");
> > +	smp_mb();
> > +}
> > +
> > +/**
> > + * clear_bit - Clears a bit in memory
> > + * @nr: Bit to clear
> > + * @addr: Address to start counting from
> > + *
> > + * clear_bit() is atomic and may not be reordered.  However, it does
> > + * not contain a memory barrier, so if it is used for locking purposes,
> > + * you should call smp_mb__before_atomic() and/or smp_mb__after_atomic()
> > + * in order to ensure changes are visible on other processors.
> > + */
> > +static inline void clear_bit(int nr, volatile unsigned long *addr)
> > +{
> > +	unsigned long mask = BIT_MASK(nr);
> > +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> > +	unsigned long tmp;
> > +
> > +	/* *p &= ~mask; */
> > +	mask = ~mask;
> > +	smp_mb();
> > +	asm volatile (
> > +		"1:	ldex.w		%0, (%2)	\n"
> > +		"	and32		%0, %0, %1	\n"
> > +		"	stex.w		%0, (%2)	\n"
> > +		"	bez		%0, 1b		\n"
> > +		: "=&r"(tmp)
> > +		: "r"(mask), "r"(p)
> > +		: "memory");
> > +	smp_mb();
> > +}
> > +
> > +/**
> > + * change_bit - Toggle a bit in memory
> > + * @nr: Bit to change
> > + * @addr: Address to start counting from
> > + *
> > + * change_bit() is atomic and may not be reordered. It may be
> > + * reordered on other architectures than x86.
> > + * Note that @nr may be almost arbitrarily large; this function is not
> > + * restricted to acting on a single-word quantity.
> > + */
> > +static inline void change_bit(int nr, volatile unsigned long *addr)
> > +{
> > +	unsigned long mask = BIT_MASK(nr);
> > +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> > +	unsigned long tmp;
> > +
> > +	/* *p ^= mask; */
> > +	smp_mb();
> > +	asm volatile (
> > +		"1:	ldex.w		%0, (%2)	\n"
> > +		"	xor32		%0, %0, %1	\n"
> > +		"	stex.w		%0, (%2)	\n"
> > +		"	bez		%0, 1b		\n"
> > +		: "=&r"(tmp)
> > +		: "r"(mask), "r"(p)
> > +		: "memory");
> > +	smp_mb();
> > +}
> 
> The {set,clear,change}_bit() operations don't have to be ordered: you
> might want to remove the above smp_mb()s (and adjust the comments).

Better yet, you can entirely delete all that and use
asm-generic/bitops/atomic.h instead.
