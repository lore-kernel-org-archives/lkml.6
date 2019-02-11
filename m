Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460FAC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132DE2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hs3Rcp3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBKK1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:27:04 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42347 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKK1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:27:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so4756600pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 02:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Atq5Da3K7qTkjOjLzwv5oROr1qroNLD3l0/lPceBN8=;
        b=Hs3Rcp3yjWdYeI0VgNx7ZsiGfPhn8M6gb6BVm/09BDgPOTRMlG7pm37IaJBmTMcpr6
         VCfsRhiztnYG24bKHGZNklHZtbyeFT9oIO5pFVi0UBU/eOg+fv/JBsSRhynKpGxLE3m9
         +VXAI6F6s/kh99rj8enKlO1SX/Iw706UXbeNBhLVMgX11gW1MUCIXsGIJOC+9cocBvGs
         ZbK33wIXdnKtTJe7ZbEiIZ1TqH96lVJw+WZ1qv9aL1JqLRM/7ayOuhuDIwbJNTk+GeiE
         lObb08se5DOGLBnL0FdtBdeHy+9LRQPJOd/XYcbavz4QOKi3wOHNhKnMBs2g846UE4pS
         U8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Atq5Da3K7qTkjOjLzwv5oROr1qroNLD3l0/lPceBN8=;
        b=ru0dZjjICEnPn+9zfJ85LxaAoO5UzCWeBiEa5Mfi7GBVTfnQYyv0aSDCVJfuYAuY/n
         sIwO4TV4a0caR+MER+D0cen7spl0F69Erq/xa0s2rELLPtnjrEQFyqc4fJ6jtxbnCil9
         nBYT0lehDcDF6PT9sA2vjl0UUICOemItp+SZ/OIaXJIZYB6DkBse6emr9tGspQBWVeX0
         Yv7D2uOApxdv762h/3GnwQvkDrKJkzFhk5DzKS+u9Ps653X/+rSSB3JEUuPdUnG7Lcgp
         XkHTihHrM6rVM6nozEMtpS8R/xwDgkaryqlx7YWG5m8qSvsTM1K2+0fdCPzoNVC6+Z4e
         2X4w==
X-Gm-Message-State: AHQUAuYQ6ZLdDGSdqAhUIdoVXTv1XOV1nYCI32YLDMxjbBBU15deId5d
        +OMG3lj4eZtUEr9G87te3MKo2A==
X-Google-Smtp-Source: AHgI3IbqTSdmqw+4d8ij0zrLbXdiDCgcKcaUqn8+nj09d74RTQaZKzXDl8sA7i96YaPqkMxPXbPTnw==
X-Received: by 2002:a63:484c:: with SMTP id x12mr32699580pgk.375.1549880821904;
        Mon, 11 Feb 2019 02:27:01 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id f10sm104905pfn.11.2019.02.11.02.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 02:27:01 -0800 (PST)
Date:   Mon, 11 Feb 2019 15:56:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/fair: Improve the for loop in
 select_idle_core()
Message-ID: <20190211102659.wihncqtchczlj3j7@vireshk-i7>
References: <f91c5e118183e79d4a982e9ac4ce5e47948f6c1b.1549536337.git.viresh.kumar@linaro.org>
 <6b165676325a47d67e667582a7b78da85c5c118a.1549536337.git.viresh.kumar@linaro.org>
 <20190211093014.GS32511@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211093014.GS32511@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-02-19, 10:30, Peter Zijlstra wrote:
> On Thu, Feb 07, 2019 at 04:16:06PM +0530, Viresh Kumar wrote:
> > @@ -6081,10 +6082,14 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
> >  	for_each_cpu_wrap(core, cpus, target) {
> >  		bool idle = true;
> >  
> > -		for_each_cpu(cpu, cpu_smt_mask(core)) {
> > -			cpumask_clear_cpu(cpu, cpus);
> > -			if (!available_idle_cpu(cpu))
> > +		smt = cpu_smt_mask(core);
> > +		cpumask_andnot(cpus, cpus, smt);
> 
> So where the previous code was like 1-2 stores, you just added 16.

Is the max number of possible threads per core just 2? That's what I
read just now and I wasn't aware of that earlier. This commit doesn't
improve anything then. Sorry for the noise.

-- 
viresh
