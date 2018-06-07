Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /BtlD376GFsNeAAAmS7hNA
	; Thu, 07 Jun 2018 09:32:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4BA32607DC; Thu,  7 Jun 2018 09:32:13 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GyZlwyzL"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BF44E605A2;
	Thu,  7 Jun 2018 09:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF44E605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753561AbeFGJcL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:32:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55068 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753103AbeFGJcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GXJ8S5YkF5gqls0HfWHKYUwDOjqYMmaNVvbrd3gZupU=; b=GyZlwyzLVDjGMMoaKjFrDaDIR
        nW8hC7lIzsi6omiUYvB32J8NdAkjECrlXK/i7c9I4k8EOjoRHFwQXjbBXAnTUQAAhx46+wlgYSKN8
        a3zLqdj0l+TDCu0ND2EIK6nlMi4RAcHi33lCjv5QxxgbY+sOc1q43ScDutT8q8lo9UiLA1wICKzrI
        B++fQpM/MYwsLkuZXv34QoIRAMnismqByjU1f+XkmjAcOeOumrZetilMWD4L+rK4c2nWV0qB6JJCv
        V8q+ywDy3z8C1XNChEGWlsz5fO1GzvaGEmmrhMgP6WUieb0PxWaeVCYk/9iRGr/FPn4Os7e6To2jA
        eirEf/VFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQrH1-0000Nf-Vd; Thu, 07 Jun 2018 09:32:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C79DF201EA7A3; Thu,  7 Jun 2018 11:32:01 +0200 (CEST)
Date: Thu, 7 Jun 2018 11:32:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180607093201.GL12198@hirez.programming.kicks-ass.net>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
 <20180606122357.GN12258@hirez.programming.kicks-ass.net>
 <22f5cf0b-049e-7938-55f6-4b4b154f8389@linaro.org>
 <20180606150203.GE12180@hirez.programming.kicks-ass.net>
 <ea347237-7cef-095a-5ddb-19c181d10c23@linaro.org>
 <20180607083229.GJ12198@hirez.programming.kicks-ass.net>
 <20180607084251.rv2tg3kgz4aohlpd@vireshk-i7>
 <9996fb40-c7aa-db61-5445-52c146f44d85@linaro.org>
 <20180607084921.toctrooftl6y7kkx@vireshk-i7>
 <d2b8c964-ea0f-624c-a178-721537893541@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2b8c964-ea0f-624c-a178-721537893541@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 11:09:13AM +0200, Daniel Lezcano wrote:
> On 07/06/2018 10:49, Viresh Kumar wrote:
> > On 07-06-18, 10:46, Daniel Lezcano wrote:
> >> Yes, correct.
> >>
> >> But if we don't care about who wins to store to value, is there a risk
> >> of scramble variable if we just assign a value ?
> > 
> > Normally no, as the compiler wouldn't screw it up badly. But there is no rule
> > which stops the compiler from doing this:
> > 
> > idle_duration_ms = 5;
> > idle_duration_ms = -5;
> > idle_duration_ms = 0;
> > idle_duration_ms = <real-value-we-want-to-write>;
> > 
> > So we *must* use READ/WRITE_ONCE() to make sure garbage values aren't seen by
> > readers.
> 
> Ok understood. Why would a compiler do this kind of things ?

I think the above can happen when the compiler uses the variable as a
scratch pad -- very rare I would say.

In general a compiler needs to proof that doing this makes no observable
difference ("as-if" rule). And since it is a regular variable it can
assume data-race-free and do the above (or something like that). Because
if there is a data-race it is UB and it can still do whatever it
pleases.

And here I think the point is that regular variables are considered only
in the context of a single linear execution context. Locks are assumed
to bound observability.

And here the "volatile" and "_atomic" type specifiers again tell the
compiler something 'special' is going on and you should not muck with
things.
