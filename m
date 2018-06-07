Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kjIEEFb2GFu5QwAAmS7hNA
	; Thu, 07 Jun 2018 09:09:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2567D6089E; Thu,  7 Jun 2018 09:09:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RIQgi5JX"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9638D607DC;
	Thu,  7 Jun 2018 09:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9638D607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932792AbeFGJJj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:09:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44940 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932396AbeFGJJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0B01QRXqJRM5GULkW5+mO0Eio8lveXp58x8Xfqg24ps=; b=RIQgi5JXkDX+YDInUjDp3jtLM
        tKC2PAgtTbIWkedAzuvUtGsfAdvJu8fYP71cyUs3oVQu0z8u0jY/29fcSzt1I4XGlzah+Y/lx78Uf
        PCWP4Z2izXQbnftN0/Iw6YwWvuOqgy1mzhXrzlKuGjoXDnEIAbEHd6fNbWpm9fQwosijcY0FRs6qu
        K806fq5gmSJMUpngxVpp+ajxbYWt5DvyFP2F8fW3OEALf3F3bhwRdUfAQaJeasWz5kd35xZRdbyYW
        HlcBh4H/ED3Cu+zQLSLNEa32x+kdIUNIi65S0pJ7O8IPH5Ufni823rWZU6lbMGMuqf1ghP8zy1nLB
        3MFLxoljQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQqvC-00049C-17; Thu, 07 Jun 2018 09:09:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 40B89201EA7A4; Thu,  7 Jun 2018 11:09:28 +0200 (CEST)
Date: Thu, 7 Jun 2018 11:09:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net,
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
Message-ID: <20180607090928.GK12198@hirez.programming.kicks-ass.net>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
 <20180606122357.GN12258@hirez.programming.kicks-ass.net>
 <22f5cf0b-049e-7938-55f6-4b4b154f8389@linaro.org>
 <20180606150203.GE12180@hirez.programming.kicks-ass.net>
 <ea347237-7cef-095a-5ddb-19c181d10c23@linaro.org>
 <20180607083229.GJ12198@hirez.programming.kicks-ass.net>
 <20180607084251.rv2tg3kgz4aohlpd@vireshk-i7>
 <9996fb40-c7aa-db61-5445-52c146f44d85@linaro.org>
 <20180607084921.toctrooftl6y7kkx@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607084921.toctrooftl6y7kkx@vireshk-i7>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 02:19:21PM +0530, Viresh Kumar wrote:
> On 07-06-18, 10:46, Daniel Lezcano wrote:
> > Yes, correct.
> > 
> > But if we don't care about who wins to store to value, is there a risk
> > of scramble variable if we just assign a value ?
> 
> Normally no, as the compiler wouldn't screw it up badly. But there is no rule
> which stops the compiler from doing this:
> 
> idle_duration_ms = 5;
> idle_duration_ms = -5;
> idle_duration_ms = 0;
> idle_duration_ms = <real-value-we-want-to-write>;
> 
> So we *must* use READ/WRITE_ONCE() to make sure garbage values aren't seen by
> readers.

That too, however it is far worse..

The compiler is allowed to do store/load-tearing. Basically it can emit
individual byte store/loads in any random order.

So:
	foo = bar = 0;

	P0			P1

	foo = 0x12345678;	bar = foo;

Could result in: bar == 0x12005600 or any other random combination.

Now, it generally doesn't do this, because it is really retarded to
generate code like that. But we've seen cases where it managed to do
really weird things (think constructing 64bit literals with two or more
smaller stores, which total smaller code).

The volatile in READ/WRITE_ONCE() disallows this and ensures the
variables are read / written in a single go (assuming naturally aligned
native word sizes).
