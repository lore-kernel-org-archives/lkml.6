Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE7CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087C92146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nNRXSHAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfBKJlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:41:02 -0500
Received: from merlin.infradead.org ([205.233.59.134]:38476 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKJlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5ghs6LH9pD2+Qt1fMHsHWX7VIkwjblgvPz91UThcXfc=; b=nNRXSHARKVBmPUa0LVuH1O7kS
        D/oHBcrwrbjjDaMI/I4qewdIuT/u+ArfVn2Q44kMxGKdqoZU4BrB2JiF0LZk1bGZZs9L580RjqEhj
        L/USBXhXhYD/MgwY5GbFdlv5b6PiOyMPil73fSwdB7H5xlLFS5BPFM67km0fFGywwBOAawYMifq1G
        HSHzGXev8QvIMVygJwKAVAp68/g6FyGSdabNsVYCSP3ClQnb39d/wPIfqLOWNXziE3BHkxIZYnbfz
        /l7StgJN3Z3/SLfPW5ugji1Mm5WmfSdNY0eEzYTydiDQebUNZUpbq0AD6mr1QzMtp4JGqmU6Lyx2E
        +SFo6yR3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gt84z-0006Pu-Pp; Mon, 11 Feb 2019 09:40:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8EEA220D0BED0; Mon, 11 Feb 2019 10:40:44 +0100 (CET)
Date:   Mon, 11 Feb 2019 10:40:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190211094044.GG32534@hirez.programming.kicks-ass.net>
References: <1549850450-10171-1-git-send-email-longman@redhat.com>
 <20190211093601.GT32511@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211093601.GT32511@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:36:01AM +0100, Peter Zijlstra wrote:
> On Sun, Feb 10, 2019 at 09:00:50PM -0500, Waiman Long wrote:
> > +static inline int __down_read_trylock(struct rw_semaphore *sem)
> > +{
> > +	long tmp;
> > +
> > +	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
> > +		if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp,
> > +				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
> > +			return 1;
> 
> That really wants to be:
> 
> 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
> 						    tmp + RWSEM_ACTIVE_READ_BIAS))
> 
> > +		}
> > +	}
> > +	return 0;
> > +}

Also, the is the one case where LL/SC can actually do 'better'. Do you
have benchmarks for say PowerPC or ARM64 ?
