Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 221ECC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C376D2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nJvED8zB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C376D2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933384AbeFLM7g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:59:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40030 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932565AbeFLM7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+vEPuNvkj0ywfwHuEA0EH6BAgVe3rnzCI4MiLhf50Ng=; b=nJvED8zB3xYPKQJlRk1+97EHN
        8ha1sT38vOBKyz41DrLFgDExRKvNYMZ0F/cyvnww8VPWQp1Uy8jFPttqkyxUMlcDEPm4vdt8DVnYA
        67DhkQm1CZxQb5fc8dMVFWU9UNr17VGwKWv2qDiLCIK1n9HhqCLMWKchi7cDbcQw2gqQFyU5wEw+e
        cbaK3t1MmOlp0gn20yzV9/8nf+8kik49uDgmnTOPUSyu0ODbrsbhyPkReDqC7bWTw/V3XybW7aFZ1
        a4PRQui36uG0JRNC1Jh8TrXcrKbDppQMbf5TOtBq0ZMdm/fPebJi+8W7rmhsnG1uikGnxxEZS064E
        0+cG7+6Pw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSitY-0002Fr-H5; Tue, 12 Jun 2018 12:59:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A663201EA7A3; Tue, 12 Jun 2018 14:59:31 +0200 (CEST)
Date:   Tue, 12 Jun 2018 14:59:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180612125930.GP12217@hirez.programming.kicks-ass.net>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 02:00:11PM +0200, Daniel Lezcano wrote:
> +struct idle_injection_device {

remove this:
> +	cpumask_var_t cpumask;

> +	struct hrtimer timer;
> +	struct completion stop_complete;
> +	unsigned int idle_duration_ms;
> +	unsigned int run_duration_ms;
> +	atomic_t count;

add:
	unsigned long cpumask[0];
> +};


> +static struct idle_injection_device *ii_dev_alloc(void)
> +{
> +	struct idle_injection_device *ii_dev;
> +
> +	ii_dev = kzalloc(sizeof(*ii_dev), GFP_KERNEL);

use:

	sizeof(*ii_dev) + cpumask_size()

> +	if (!ii_dev)
> +		return NULL;
> +

delete:

> +	if (!alloc_cpumask_var(&ii_dev->cpumask, GFP_KERNEL)) {
> +		kfree(ii_dev);
> +		return NULL;
> +	}
> +
> +	return ii_dev;
> +}

And use:

	to_cpumask(ii_dev->cpumask)
