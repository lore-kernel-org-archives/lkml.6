Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xXeQAbLtGFvDeAAAmS7hNA
	; Thu, 07 Jun 2018 08:32:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DBEA36089E; Thu,  7 Jun 2018 08:32:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pw1ZbqSK"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 59DF360115;
	Thu,  7 Jun 2018 08:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59DF360115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932639AbeFGIcp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:32:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43366 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752568AbeFGIcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gG199qVn++i15hkbvtxiIIvowAu89gWF5LkzdmriZ9Y=; b=Pw1ZbqSKGPpva4D+8IN3VaS4z
        AoEBLab9yLwciz66DL7Spfd17uV2a2w25T1uSsu1+9D/sdyAotp1pQMY36Gvx8IiEOHF9ENHY7gxl
        rxoV3djEIbD++TFxVqG+HcER7I3wNj0ls9nYQNm331aU2Qr7h1/WVUvxns2ISfX/FN87xgHyOkUb/
        71Ccx/qJ7xAlIKgTCxi9argWuSPiLOTt+YWlinh+T4dfJgIrw24QtQocCPDP/6nz3PLvUmzklG86J
        rJBNg+epFwJxtTCSbpSGBUrMONyutKSkfiz8aQtR2wOYu47feqPS7lX6uDINeBf63kBJcw119oiiD
        vANrUHeEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQqLQ-0003iC-5M; Thu, 07 Jun 2018 08:32:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2C29F201EA7A6; Thu,  7 Jun 2018 10:32:29 +0200 (CEST)
Date: Thu, 7 Jun 2018 10:32:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
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
Message-ID: <20180607083229.GJ12198@hirez.programming.kicks-ass.net>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
 <20180606122357.GN12258@hirez.programming.kicks-ass.net>
 <22f5cf0b-049e-7938-55f6-4b4b154f8389@linaro.org>
 <20180606150203.GE12180@hirez.programming.kicks-ass.net>
 <ea347237-7cef-095a-5ddb-19c181d10c23@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea347237-7cef-095a-5ddb-19c181d10c23@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 10:18:27AM +0200, Daniel Lezcano wrote:
> So IIUC, neither atomic or WRITE|READ_ONCE are necessary in this code
> because of the wake_up_process() barrier is enough, right ?

I didn't look hard enough; if there ever is a time where the loads and
stores happen concurrently, you need READ/WRITE_ONCE(). If there is no
concurrency on the variables, you don't need anything.

Neither atomic_read/set() nor REAd/WRITE_ONCE() will help with ordering,
which is what the wake_up_process() would provide here, different things
entirely.
