Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E08C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB8B26AC4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W+LaopLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB8B26AC4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933266AbeFZUPV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:15:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50074 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932218AbeFZUPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fUZtfCunCR3Iq2EbQaV+Qp+fChHFvI7DYV3HuYzZnsg=; b=W+LaopLt5kMMHE0n7b+QfQE1+
        aZZk4c3OHKaA6CoM3Q6gVTfM6Mm16ZkvMm95ro67/t6GmQfTrGJkSJL0BrKbQfGh7Nd0Fqbpcgwnp
        2/GQ3w5BKN4dRvl648UFTKoGTJvRhaW1XIQahWEYeqYwz3LBy09s3AEGlqi2kPZ3du6E+nWKOBHvJ
        KvYZ5pPx5n9ERdt/BzLkpxlaZZ0rFtF+1IugYk5DqAE0b5th+KA6YYNMIO3KWWNDSyAl/3AL4AWud
        nx+SAe4dZKEZFAUGQ0iXHTsd5LYZZ/i/PRyjTlNjaNKRGvdcvqsifhUMBKdqYvH/JkU4VJv9Igrq6
        Rs9FhTBJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXuMi-0007pe-NR; Tue, 26 Jun 2018 20:15:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1EAC92029F1DB; Tue, 26 Jun 2018 22:15:03 +0200 (CEST)
Date:   Tue, 26 Jun 2018 22:15:03 +0200
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
Message-ID: <20180626201503.GS2494@hirez.programming.kicks-ass.net>
References: <20180626003448.GA26209@linux.vnet.ibm.com>
 <20180626003513.27812-16-paulmck@linux.vnet.ibm.com>
 <20180626171454.GI2494@hirez.programming.kicks-ass.net>
 <20180626180855.GE3593@linux.vnet.ibm.com>
 <20180626192113.GM2494@hirez.programming.kicks-ass.net>
 <20180626193146.GK3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626193146.GK3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 12:31:46PM -0700, Paul E. McKenney wrote:
> > Then the existing comment is misleading and really needs change.
> 
> Would it be sufficient to add something like "The memory barrier is
> required to support the many-to-many ordering guaranteed by RCU grace
> periods"?

What would lead me to wonder why after the load and not (also) before.
