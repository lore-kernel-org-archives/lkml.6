Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +Fq5EmH8GFvuEAAAmS7hNA
	; Thu, 07 Jun 2018 09:39:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4A966607F7; Thu,  7 Jun 2018 09:39:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QF+TvzlR"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BC942601C3;
	Thu,  7 Jun 2018 09:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC942601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753541AbeFGJjc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:39:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753095AbeFGJja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/FDfsejbOmCnaRdOOAbZGKkWIqpnxcbE5+Y1OBQYFT4=; b=QF+TvzlRna4mxZBm3FWO68xyH
        Ofws5i5st5UZXGfjI1p05btLfE9obLPNibyE+IUO3+WlPFBeLXDvzpurQCVEFAFPfSLGa0fNKmgQg
        o4SRfop9tVSySQGmf0leVHd4+MAOOMBSZa7aupCYD7S11vtQ3PH4PEGXnLU3hq4ijzuKe1ZH64ZCb
        +R4SgTpwBHmEaXSQntgb6Y4ZxolFHc2E9C6I8b5a+/wieRcoreib3nSti09vsO7I5clD0LTflDsWY
        z2d6S4FPRNSCu/CigNvgDHiL+bmLupJsXqRi97n8M2F2FEU7Pj+3KEKccujZlzaZzkOOzssD8SsMA
        Yk0peSXEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQrOC-0003H1-R1; Thu, 07 Jun 2018 09:39:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 53A57201EA7A5; Thu,  7 Jun 2018 11:39:27 +0200 (CEST)
Date: Thu, 7 Jun 2018 11:39:27 +0200
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
Message-ID: <20180607093927.GE12235@hirez.programming.kicks-ass.net>
References: <20180606122357.GN12258@hirez.programming.kicks-ass.net>
 <22f5cf0b-049e-7938-55f6-4b4b154f8389@linaro.org>
 <20180606150203.GE12180@hirez.programming.kicks-ass.net>
 <ea347237-7cef-095a-5ddb-19c181d10c23@linaro.org>
 <20180607083229.GJ12198@hirez.programming.kicks-ass.net>
 <20180607084251.rv2tg3kgz4aohlpd@vireshk-i7>
 <9996fb40-c7aa-db61-5445-52c146f44d85@linaro.org>
 <20180607084921.toctrooftl6y7kkx@vireshk-i7>
 <d2b8c964-ea0f-624c-a178-721537893541@linaro.org>
 <20180607093201.GL12198@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607093201.GL12198@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 11:32:01AM +0200, Peter Zijlstra wrote:
> On Thu, Jun 07, 2018 at 11:09:13AM +0200, Daniel Lezcano wrote:
> > On 07/06/2018 10:49, Viresh Kumar wrote:
> > > On 07-06-18, 10:46, Daniel Lezcano wrote:
> > >> Yes, correct.
> > >>
> > >> But if we don't care about who wins to store to value, is there a risk
> > >> of scramble variable if we just assign a value ?
> > > 
> > > Normally no, as the compiler wouldn't screw it up badly. But there is no rule
> > > which stops the compiler from doing this:
> > > 
> > > idle_duration_ms = 5;
> > > idle_duration_ms = -5;
> > > idle_duration_ms = 0;
> > > idle_duration_ms = <real-value-we-want-to-write>;
> > > 
> > > So we *must* use READ/WRITE_ONCE() to make sure garbage values aren't seen by
> > > readers.
> > 
> > Ok understood. Why would a compiler do this kind of things ?
> 
> I think the above can happen when the compiler uses the variable as a
> scratch pad -- very rare I would say.
> 
> In general a compiler needs to proof that doing this makes no observable
> difference ("as-if" rule). And since it is a regular variable it can
> assume data-race-free and do the above (or something like that). Because
> if there is a data-race it is UB and it can still do whatever it
> pleases.
> 
> And here I think the point is that regular variables are considered only
> in the context of a single linear execution context. Locks are assumed
> to bound observability.
> 
> And here the "volatile" and "_atomic" type specifiers again tell the
> compiler something 'special' is going on and you should not muck with
> things.

Also, I think, more likely:

	if (cond)
		X = 5;
	else
		X = 4;

is allowed to be transformed into:

	X = 4;
	if (cond)
		X = 5;

as long as cond doesn't involve a sequence point of sorts (think
function call).

For the single execution context case, this transformation is valid, but
it is not in the threaded case. But then we go back to the assumption
that regular variables are data-race-free.
