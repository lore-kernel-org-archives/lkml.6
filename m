Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A62C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDB923EC0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rfI8yJFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDB923EC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753864AbeGFKgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:36:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42250 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753535AbeGFKgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KZvNoqjquVLUP7YccbzxQzHxtD7orfT9FssMk5yqAXA=; b=rfI8yJFRzbQFM9jTsjO06hw92
        AilEHTzMQN/u7csnMSWaoc1K2eUjRqiwycyAb+YD6hwYQaH4FoaCIdIBOzeOYgAouEEd8eLW4ZK4b
        q8Ol9YxnqLahVMmgHfPT67DI06wIWiFeKZ3jPgmCprH8jeXbGkd1GR+QRfnD9/aXw5TZFqh9DOgfX
        4fEF/IZbRE/IaqK3yLqHvegPSPdM/JCO7iFDCFhB3WmFZWYOciWc5hY9F7lM9ZGtZOaO+S5TvT01P
        wmpdu9Zg2Ggo78NHVd4NP4MBK729t7HeYJH60OHJRWValdGOVhpii0DjChCA1lEZcwYT05UFZWMeQ
        FQ3foD3qw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbO61-00005E-EZ; Fri, 06 Jul 2018 10:36:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C5FE92028932F; Fri,  6 Jul 2018 12:36:11 +0200 (CEST)
Date:   Fri, 6 Jul 2018 12:36:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 0/3] sched/locking/doc: Miscellaneous fixes
Message-ID: <20180706103611.GL2494@hirez.programming.kicks-ass.net>
References: <1530182480-13205-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20180705222812.GA4582@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705222812.GA4582@andrea>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 12:28:12AM +0200, Andrea Parri wrote:
> What is the plan for this series?
> 
> We are currently discussing locking changes that might affect 2/3, but
> I'd still consider this patch and the overall series as an improvement
> over the current status (1/3 is a fix to the code) and I'd really like
> future changes to be based on this series...
> 
> I expected this series to go via "-rcu -> tip -> ..."; 2/3 had Peter's
> Ack, but 1/3 and 3/3 are missing any comments (or tags): please let me
> know if any action on the series is required from me (the series still
> applies on the latest "dev" branch of -rcu).

You can add my ack:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

to the others as well, they look like a definite improvement. I'm fine
with these going through Paul's tree, Ingo?
