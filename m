Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id uUMIMQ95GltscQAAmS7hNA
	; Fri, 08 Jun 2018 12:40:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0431F6089E; Fri,  8 Jun 2018 12:40:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 81B0E607DC;
	Fri,  8 Jun 2018 12:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 81B0E607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752729AbeFHMkE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:40:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40296 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752661AbeFHMkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:40:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id n5-v6so3435278wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 05:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aPvwLInGbnTkf9Icfav19kCQXkotfeOLbSvuHN3wDD0=;
        b=svRMKgyxGK2DkeVIx4zOqasdfbweeet9Qmh46YGb/Kj9if5iLmT8mCdnb0yhN4Q1dp
         Bf518WMJmZCphusEQRw3rxdCTPTChlQRm5+nsG962/k5tX50EYGgFuqHViekRPRuAj3U
         VGnyCqnD06YKvhck9WMFZmKNqalvNMlbd2KwUmA+BOJht4k8WrxeB4s0s7jsYQNmmHbL
         Aw4RT3BDYMWJjj9W28oEcKpPy6OQ8TUdHRX1g5tuEujaTCzh3OieSrBO2xCqxfUg3BjQ
         ewJeW2PM4S6KEu/YFMO5OtN83oYB37C3TGPu1/nIhgyYdBLNAjrhGFvThEWLpx124qVP
         IIFQ==
X-Gm-Message-State: APt69E3ZcrfWnhG1E+3WRoDKAL6ft4eLVxd9lSCYXbRlYEZ4VpYppb+4
        K9ytExgTBlbJh1cIUH36p71IIA==
X-Google-Smtp-Source: ADUXVKIBqjKEvFgaBHlm9MJC3s7Jy20u/IHNXyhy+cxFjPX9tglRpRGlC3jaPV8PZ+GTQfJGgyiyNg==
X-Received: by 2002:a1c:1050:: with SMTP id 77-v6mr1632680wmq.136.1528461601958;
        Fri, 08 Jun 2018 05:40:01 -0700 (PDT)
Received: from localhost.localdomain ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id p10-v6sm1023567wmc.17.2018.06.08.05.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 05:40:01 -0700 (PDT)
Date: Fri, 8 Jun 2018 14:39:59 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        viresh.kumar@linaro.org, valentin.schneider@arm.com,
        patrick.bellasi@arm.com, joel@joelfernandes.org,
        daniel.lezcano@linaro.org, quentin.perret@arm.com,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v6 06/11] cpufreq/schedutil: use dl utilization tracking
Message-ID: <20180608123959.GE16089@localhost.localdomain>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-7-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528459794-13066-7-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 08/06/18 14:09, Vincent Guittot wrote:
> Now that we have both the dl class bandwidth requirement and the dl class
> utilization, we can detect when CPU is fully used so we should run at max.
> Otherwise, we keep using the dl bandwidth requirement to define the
> utilization of the CPU
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---

[...]

> @@ -190,20 +192,24 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>  	if (rq->rt.rt_nr_running)
>  		return sg_cpu->max;
>  
> -	util = sg_cpu->util_dl;
> -	util += sg_cpu->util_cfs;
> +	util = sg_cpu->util_cfs;
>  	util += sg_cpu->util_rt;
>  
> +	if ((util + sg_cpu->util_dl) >= sg_cpu->max)
> +		return sg_cpu->max;
> +

Mmm, won't we run at max (or reach max) with a, say, 100ms/500ms DL task
running alone?

Best,

- Juri
