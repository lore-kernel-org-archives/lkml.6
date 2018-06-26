Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1897FC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BB925FDC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gos1pJ8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BB925FDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933346AbeFZRPR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:15:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52104 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932748AbeFZRPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0kVTeRiDGxhCHeHvIPmEOBC2dL/4FLEoN/JCukkEVoc=; b=gos1pJ8Yoon67yOjTVIR/Byxl
        /cQ44l1WSCh6u/FjUxazizMDyx1tsPD1xFkafp5IqM6GkVFX4QSlK4u7KbWNu4VJGcCxaJxBsrfHx
        ML18EvVcKijz4ouF3J7TdC6WPiV6ztTGvuq6NmGMS1anFZ4jgnXM279JlMuMi+27NGgbOZ2vNQvpr
        Y/DCYor7RsahB5ZK8Dsjrqigijbl8PlbvtchNO0ojhwiGpblahAb8EPIbSefQyH7KQK0HTipli7y0
        S6nztOdmmgD+82wje0G5wZbrQSJ62mDZstGANc6K2um0zGqWhAbGWkAGr2vYs7ZR9VT5M1ClQiyc2
        i3QH3KTjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXrYP-0004Bj-B1; Tue, 26 Jun 2018 17:14:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C10072029F1D7; Tue, 26 Jun 2018 19:14:54 +0200 (CEST)
Date:   Tue, 26 Jun 2018 19:14:54 +0200
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
Message-ID: <20180626171454.GI2494@hirez.programming.kicks-ass.net>
References: <20180626003448.GA26209@linux.vnet.ibm.com>
 <20180626003513.27812-16-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626003513.27812-16-paulmck@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 05:35:02PM -0700, Paul E. McKenney wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> rcu_seq_snap may be tricky to decipher. Lets document how it works with
> an example to make it easier.

Since you had me looking at them functions; why isn't rcu_seq_snap()
using smp_load_acquire() and rcu_seq_end() using smp_store_release() ?
Their respective comments seem to suggest that would be sufficent.

