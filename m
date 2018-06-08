Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id yCfYNmeGGlugeAAAmS7hNA
	; Fri, 08 Jun 2018 13:36:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CC059607E4; Fri,  8 Jun 2018 13:36:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 43E5F602FC;
	Fri,  8 Jun 2018 13:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43E5F602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeFHNgh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:36:37 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43804 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbeFHNgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:36:35 -0400
Received: by mail-wr0-f196.google.com with SMTP id d2-v6so13418003wrm.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 06:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mKz3xHX82bUPd+a8FBDIKg/f6pAqWfUMpc3YQuMxUqc=;
        b=T23EuApVKIUlQ1mER1LdoCmhBUCc8Y4qIxGC8VFobfhyHJ2CZ2q/Bhp0pkelXuA3CT
         0VfNFiVmGB50NGk20a0XBHT8V7YPu+ZgnmHcqf6fAyIOlz97wh7F3T++38ph1GlTnxe5
         5Grr1HF+fViDfRwQv7SsuYdZ96E+uFtvScrMbp7mSOCdEYwF6ckzIvJK95UH7/uUOjuP
         Xgx2oyhBWuiI5Kcpt4D9x1P1xiLJSao585m6ELWYdCE4PJ6ArlG+l5EwtfwuMeXCF36B
         9o8DdxNrkF8FcwwJwi90/pQv5Xn3NnY44UgNmzlXdILcYAo9dFMiKt8TqgpOn205mwSb
         XyPw==
X-Gm-Message-State: APt69E0Jn1TwC1qqvWUvgM3WMbmEpr7Dq8BmS6EiPtTdEDlORzRutpg7
        1ZmLd8OrMqzNst+LeAO/oTGyHg==
X-Google-Smtp-Source: ADUXVKLtwtU+w1c6soNRfdp+KM+RdvCTUI7/aGByEifOBB1dS9e8a0Vvg8n/3qeYVKq0GglEl8ZGuQ==
X-Received: by 2002:adf:ba01:: with SMTP id o1-v6mr5379097wrg.249.1528464994729;
        Fri, 08 Jun 2018 06:36:34 -0700 (PDT)
Received: from localhost.localdomain ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id k17-v6sm2464530wmc.23.2018.06.08.06.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 06:36:32 -0700 (PDT)
Date: Fri, 8 Jun 2018 15:36:30 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>
Subject: Re: [PATCH v6 06/11] cpufreq/schedutil: use dl utilization tracking
Message-ID: <20180608133630.GS16089@localhost.localdomain>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-7-git-send-email-vincent.guittot@linaro.org>
 <20180608123959.GE16089@localhost.localdomain>
 <CAKfTPtCTMFN2Hed9Ku=VLH2Uwm4sC1kBBa5yRbb20r0o=-R7jw@mail.gmail.com>
 <20180608125448.GR16089@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608125448.GR16089@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/18 14:54, Juri Lelli wrote:
> On 08/06/18 14:48, Vincent Guittot wrote:
> > On 8 June 2018 at 14:39, Juri Lelli <juri.lelli@redhat.com> wrote:
> > > Hi Vincent,
> > >
> > > On 08/06/18 14:09, Vincent Guittot wrote:
> > >> Now that we have both the dl class bandwidth requirement and the dl class
> > >> utilization, we can detect when CPU is fully used so we should run at max.
> > >> Otherwise, we keep using the dl bandwidth requirement to define the
> > >> utilization of the CPU
> > >>
> > >> Cc: Ingo Molnar <mingo@redhat.com>
> > >> Cc: Peter Zijlstra <peterz@infradead.org>
> > >> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > >> ---
> > >
> > > [...]
> > >
> > >> @@ -190,20 +192,24 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> > >>       if (rq->rt.rt_nr_running)
> > >>               return sg_cpu->max;
> > >>
> > >> -     util = sg_cpu->util_dl;
> > >> -     util += sg_cpu->util_cfs;
> > >> +     util = sg_cpu->util_cfs;
> > >>       util += sg_cpu->util_rt;
> > >>
> > >> +     if ((util + sg_cpu->util_dl) >= sg_cpu->max)
> > >> +             return sg_cpu->max;
> > >> +
> > >
> > > Mmm, won't we run at max (or reach max) with a, say, 100ms/500ms DL task
> > > running alone?
> > 
> > not for a 100ms running task. You have to run more than 320ms to reach max value
> > 
> > 100ms/500ms will vary between 0 and 907
> 
> OK, right, my point I guess is still that such a task will run fine at
> ~250 and it might be save more energy by doing so?

As discussed on IRC, we still endup selecting 1/5 of max freq because
util_dl is below max.

So, turning point is at ~320ms/[something_bigger], which looks a pretty
big runtime, but I'm not sure if having that is OK. Also, it becomes
smaller with CFS/RT background "perturbations". Mmm.

BTW, adding Luca and Claudio. :)
