Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED29C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D619A217B4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jcPa2RwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D619A217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeHGMs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:48:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39574 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeHGMs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cNqXJdzgahSNhmzJboTphAJxKTn4pluFeXpaIdnHhBE=; b=jcPa2RwOu6QyWKZEyAd6VV2iZ
        aRj5pUpBep0CFX4cIQDDcmCr/qDMEISaAHjdQ1A1rbW53ZqNvpd0aXZ7cavGKzvhIi49K3DS27FjU
        i2h40su/AuD3Nizjo1Vsuq+PYdI6kF0ezrI4R9UZdYHeQhVrqtiqtmZPDob4AnBXesg4YEc3CwgLK
        AcxwOc5x6ryRtEH9Ic2ktjnUvJdQikOP5rqSefBC8OKiqBuExOV2HnhPzR7QDa+xZVKG6rJ4Tklju
        DZ9x3eVsCAnVSZv5JcpmdX7dDcOnpTpKy4DySyu/t7xVHa74Yf9ye0NvqjatYO/aZAGW4J0kEMc9w
        dq+XPMuNg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmzKY-0006TY-00; Tue, 07 Aug 2018 10:35:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D6E92058813A; Tue,  7 Aug 2018 12:35:08 +0200 (CEST)
Date:   Tue, 7 Aug 2018 12:35:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tracing: Partial revert of "tracing: Centralize
 preemptirq tracepoints and unify their usage"
Message-ID: <20180807103508.GZ2494@hirez.programming.kicks-ass.net>
References: <20180806215432.45ae5f9a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806215432.45ae5f9a@gandalf.local.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 09:54:32PM -0400, Steven Rostedt wrote:
> 
> [ Peter, you OK with this patch? It just makes lockdep call its helper
>   functions directly like it did before. ]

Yeah, I suppose :-)
