Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66720C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CFD26B4A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Te0Oc3/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CFD26B4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeFZT1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:27:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbeFZT1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N+sopYf2CE+gPMZbtFcxCgUf5l/4mnkBWEBnbcgwMJA=; b=Te0Oc3/WAuy0n30l8wN1uvRov
        Q9eWEw9ttZ7vUdxJAB1L3/k+ptjn/+CayF54UELWUEQ2OZ9cAJ+O4ivKRvFm1c801/Eo4/JYztORg
        u6q5p/UhH3kIygav1KYyh1kp1KRaUsI5/EC12YPlk4JfjFPEgIOAZbWuvvOYaK28qXynhI8r/0o3a
        POQtr8Yxce7JMEstGZsXlO1j9XlHbf6bvCLrFtz7MPCpyxqGkIpM8Sb8rp3fbMs3rAV/n6I/QoSEx
        DKC2NUPqG4/uEOiTpCDJhqIGewROKN3U+v7hRcMlgwStNR+Hnq548tYdk6m+mw9SI8J0ChIXa+stb
        /fGL2vqeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXtcg-000558-Bd; Tue, 26 Jun 2018 19:27:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 931382029FA0A; Tue, 26 Jun 2018 21:27:28 +0200 (CEST)
Date:   Tue, 26 Jun 2018 21:27:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 16/27] rcu: Add comment documenting how
 rcu_seq_snap works
Message-ID: <20180626192728.GN2494@hirez.programming.kicks-ass.net>
References: <20180626003448.GA26209@linux.vnet.ibm.com>
 <20180626003513.27812-16-paulmck@linux.vnet.ibm.com>
 <20180626173055.GJ2494@hirez.programming.kicks-ass.net>
 <20180626181025.GF3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626181025.GF3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 11:10:25AM -0700, Paul E. McKenney wrote:
> > Is the below not much simpler:
> > 
> > >  static inline unsigned long rcu_seq_snap(unsigned long *sp)
> > >  {
> > >  	unsigned long s;
> > 
> > 	s = smp_load_aquire(sp);
> > 
> > 	/* Add one GP */
> > 	s += 1 << RCU_SEQ_CTR_SHIFT;
> > 
> > 	/* Complete any pending state by rounding up */
> > 	s = __ALIGN_MASK(s, RCU_SEQ_STATE_MASK);
> > 
> > 	return s;
> > }
> 
> Seems equivalent to me, but with more lines.  To say nothing of more
> levels of lookup of macro definitions.  ;-)

But it does explain the various parts in the equation, or at least gives
a fair clue as to how the thing composes. And I find the alignment thing
far easier to read that an open coded variant, but whatever.
