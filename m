Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78B8C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9661E2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f14eLpKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfBGTso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:48:44 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45814 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfBGTsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1CcmVVwzqXHvGyue8+fGzj5x9f2QCCBdzMmFKuWYvvI=; b=f14eLpKtzKaxMtx4VihGne5Yv
        3uhI+pBxOe/zRqrgJUKcIEm2hz91td1S43Na3Y59E83kGj7N3Yzgkjvn0IJS7aqXnkf4MDwmT4ZI+
        WMD3LjZaKNTa3Rn9yYaoGdDB1k91hT/asZAoIAU4uh/Wa/MOYJJPpJ7UT1+NElwtMDe1nTPq8Q1nz
        QS+dSRwJjJYFfVDxKHR/kxi62mnUxBlgXGFrG/pCvpeO17dMiPrdJ8TAKIzG2SURuhksc7gEJlaNe
        Bv0bVqtu482N3/gyYF7VsFKBJ2mT7S0bgfMYfznX2oafvgTylrSNqrBQJ8S1QJtrQ8E5xeYMvAjTu
        T81w7uqYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grpew-00075D-3U; Thu, 07 Feb 2019 19:48:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DD0EB2029E062; Thu,  7 Feb 2019 20:48:28 +0100 (CET)
Date:   Thu, 7 Feb 2019 20:48:28 +0100
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
Subject: Re: [PATCH-tip 04/22] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190207194828.GC32534@hirez.programming.kicks-ass.net>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <1549566446-27967-5-git-send-email-longman@redhat.com>
 <20190207193656.GF32511@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207193656.GF32511@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 08:36:56PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 07, 2019 at 02:07:08PM -0500, Waiman Long wrote:
> 
> > +static inline int __down_read_trylock(struct rw_semaphore *sem)
> > +{
> > +	long tmp;
> > +
> > +	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
> > +		if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp,
> > +				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
> > +			return 1;
> > +		}
> > +	}
> 
> Nah, you're supposed to write that like:
> 
> 	for (;;) {
> 		val = atomic_long_cond_read_relaxed(&sem->count, VAL < 0);
> 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &val,
> 						    val + RWSEM_ACTIVE_READ_BIAS))
> 			break;
> 	}

N/m that's not in fact the same...

> > +	return 0;
> > +}
> 
> 
> Anyway, yuck, you're keeping all that BIAS nonsense :/ I was so hoping
> for a rwsem implementation without that impenetrable crap.
