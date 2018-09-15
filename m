Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79737ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 11:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B0C2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 11:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8KEy/SK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B0C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeIORFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 13:05:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40656 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeIORFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 13:05:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id n2-v6so12916704wrw.7;
        Sat, 15 Sep 2018 04:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zGztH+B4RdYZ7oVTwbLR9J11A750i/xUN60ky3+xfQs=;
        b=l8KEy/SKZn9MHKr9bQWdNfbfEH5LYWkdgkObE4Q10ZUumdsuwC9OBZTt0kFscBu9Vk
         MiueSU8W0bPftGeLRk8gGGXa+ezTnNYUteK2pkm0uHOQqUSH3kB1ANG0u30jsD3/SxhX
         1878fFnVlEyaAwx7vzUTc0dDd5ae2fyS2evx3vcz/0B3Q7d5pvXcLuDYAo0zPyUbTDwk
         mp8v6uKRtiuVQiOY9j9NeLNlYor8xojnzu1Ri8kSL0i37gcfgkePpneba713/Cgm2aqY
         GaegJ35Tqn4Nb+hSIGDyaIgS0WwGvIR41iQGcifttHUIe543sY0JHVnEcAX2lroodlDI
         w2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zGztH+B4RdYZ7oVTwbLR9J11A750i/xUN60ky3+xfQs=;
        b=mg/nYNBl2iyKu0I36AVrngcF6/m4JyCiVGRSgqgVwAdwGaWVdd4z5sqyfDomGCQDia
         pGOAMHMmiLGPWAEek68ibq1iYVC8NWC6ZPR5uLjJ4bBMRNs44f7685EQjjmvPRPLCyN2
         pxtXXtvJ36HE2lyOC3GHZQpQVkWe107WZSgWhADt8S+HSWmBmcuPb7rGYe+9PJbyG+Zh
         vDo/TP7WsdX3zEwirKHB0Szo9A/6CHy6DPoe2i/I2ZPW1Dpx8owh8bMMGq08Ght0Lc+X
         W1JhAwJWNMboNuZ00y57DruAtGCrv/jUNuU/Xu1OwXFwp0PhL1s6KP0if5lHae6gzLYe
         AGRw==
X-Gm-Message-State: APzg51CaOf8ICxgZ6GbHzrFn5dm4sqdsw+ZOv3ezwyF3u/8/GGvgXc4g
        j8Q0cFGhRNAMaLc4/la1ns0=
X-Google-Smtp-Source: ANB0Vdb/DuHOYJPT9Ipb7r/Hi7IXDwlHa3A67h+fKlaABO1dW+J5Y0zsQZQ2n/HRoKZvU9+S1WdnDg==
X-Received: by 2002:adf:e30e:: with SMTP id b14-v6mr12461363wrj.158.1537012020674;
        Sat, 15 Sep 2018 04:47:00 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l24-v6sm22255600wrb.65.2018.09.15.04.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 04:46:59 -0700 (PDT)
Date:   Sat, 15 Sep 2018 13:46:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     mingo@redhat.com, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, hpa@zytor.com
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched/fair: Remove #ifdefs from
 scale_rt_capacity()
Message-ID: <20180915114657.GA63704@gmail.com>
References: <1532001606-6689-1-git-send-email-vincent.guittot@linaro.org>
 <tip-2e62c4743adc4c7bfcbc1f45118fc7bec58cf30a@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-2e62c4743adc4c7bfcbc1f45118fc7bec58cf30a@git.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot for Vincent Guittot <tipbot@zytor.com> wrote:

> Commit-ID:  2e62c4743adc4c7bfcbc1f45118fc7bec58cf30a
> Gitweb:     https://git.kernel.org/tip/2e62c4743adc4c7bfcbc1f45118fc7bec58cf30a
> Author:     Vincent Guittot <vincent.guittot@linaro.org>
> AuthorDate: Thu, 19 Jul 2018 14:00:06 +0200
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Wed, 25 Jul 2018 11:41:05 +0200
> 
> sched/fair: Remove #ifdefs from scale_rt_capacity()
> 
> Reuse cpu_util_irq() that has been defined for schedutil and set irq util
> to 0 when !CONFIG_IRQ_TIME_ACCOUNTING.
> 
> But the compiler is not able to optimize the sequence (at least with
> aarch64 GCC 7.2.1):
> 
> 	free *= (max - irq);
> 	free /= max;
> 
> when irq is fixed to 0
> 
> Add a new inline function scale_irq_capacity() that will scale utilization
> when irq is accounted. Reuse this funciton in schedutil which applies
> similar formula.
> 
> Suggested-by: Ingo Molnar <mingo@redhat.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: rjw@rjwysocki.net
> Link: http://lkml.kernel.org/r/1532001606-6689-1-git-send-email-vincent.guittot@linaro.org
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  kernel/sched/core.c              |  2 +-
>  kernel/sched/cpufreq_schedutil.c |  3 +--
>  kernel/sched/fair.c              | 13 +++----------
>  kernel/sched/sched.h             | 20 ++++++++++++++++++--
>  4 files changed, 23 insertions(+), 15 deletions(-)

This commit introduced a build warning in the SMP=n case, could we please fix that? (Probably 
the best to maintain variant would be to mark it as __maybe_unused.)

Also, while at it, there's a number of other places that use this pattern:

> -#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> +#ifdef HAVE_SCHED_AVG_IRQ

Could we convert those to HAVE_SCHED_AVG_IRQ as well?

dagon:~/tip> git grep 'defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)' kernel/sched/
kernel/sched/core.c:#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
kernel/sched/fair.c:#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
kernel/sched/pelt.c:#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
kernel/sched/pelt.h:#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
kernel/sched/sched.h:#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)

Thanks,

	Ingo
