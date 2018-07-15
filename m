Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAB6ECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486F72089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEAhLs/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486F72089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbeGOWkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 18:40:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35292 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeGOWkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 18:40:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id a9-v6so7064676wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 15:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DIZBkwBjNyqb2D7SWCcWcBRpugT+FxoLLxpGZ6wqCJU=;
        b=eEAhLs/7tn9c+Wm4lJOA4GT7UUD3tu6Lv9VM+f4hht68/A3/eY+D1Y87ZE+SQCi6Rx
         jgg8BZdEdtXkhisYpdT0pyHYCfH6DrYpOcZ+twgFkgJapCGbkCrcsifzgcPJlFwcgK/u
         gaMwpmNR3uUnryBZIcVroF9c/JqMSHLEGDs+qLBwqdfjJW8/rQD0vQ+tEiD2crov1twM
         n0Bmf1TqKx80hQUi+ZaIxqWcjHd/8WBpk3PL0aFgraMxGle+eSwZbj0QWues+kCrlacb
         J2Q59Zs0fUChu3PG27MetXoDY6vAQrCM299c5lzUD+rmwtjTSNPnL83m4kH6O8SOkPTX
         JyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DIZBkwBjNyqb2D7SWCcWcBRpugT+FxoLLxpGZ6wqCJU=;
        b=Nl1mMsLqyPIR7ckK6L80Oc3A2t601YRH8A2bGjaaWmpYZ2IWV5q4Zeg3qSu6FIv+0j
         Oprg8OELXbnmoAMcRtxZe6x/9ex3fMspxdfcHdP+fBqXTfLKVOrFmeYjrwavE+Mr8SmY
         QszOvX8vfz1/ruiYSrthWmInjAjK4tMMUhgiBImfAHA9wVSwTVdwrkxcSlRFANJZonot
         8R0q5kvYCQhMe4XFuXLw0zrxH0ubtQ+MPrJ+DL3cIPBmjKhtxvwk1qBHNvtydVdrdWJb
         N6lk2UxXJ/CTjV4uPcCIyDscVOd0qIj8yCK4mkbBGTp3+wHGeKFBh0CstB1Gq9vYl3H+
         8tTg==
X-Gm-Message-State: AOUpUlFg3cwxn7i3CfrrpiqHYpP4aIs0wR6DscHS9CXITytenlRs3sZI
        BvsoIymp5aFGu6cG39jcX0o=
X-Google-Smtp-Source: AAOMgpcAd8qY4N0lV4YQPsZr57buoFVqLjtiaywgfPOIQNhU5hQ2o9AS2jm8YUTeazRNbEz4hJUBjQ==
X-Received: by 2002:a1c:1ad0:: with SMTP id a199-v6mr8428928wma.131.1531692941608;
        Sun, 15 Jul 2018 15:15:41 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id d7-v6sm21055407wro.92.2018.07.15.15.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 15:15:40 -0700 (PDT)
Date:   Mon, 16 Jul 2018 00:15:38 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        quentin.perret@arm.com, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 09/11] sched: use pelt for scale_rt_capacity()
Message-ID: <20180715221538.GA23280@gmail.com>
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
 <1530200714-4504-10-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1530200714-4504-10-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> The utilization of the CPU by rt, dl and interrupts are now tracked with
> PELT so we can use these metrics instead of rt_avg to evaluate the remaining
> capacity available for cfs class.
> 
> scale_rt_capacity() behavior has been changed and now returns the remaining
> capacity available for cfs instead of a scaling factor because rt, dl and
> interrupt provide now absolute utilization value.
> 
> The same formula as schedutil is used:
>   irq util_avg + (1 - irq util_avg / max capacity ) * /Sum rq util_avg
> but the implementation is different because it doesn't return the same value
> and doesn't benefit of the same optimization
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/deadline.c |  2 --
>  kernel/sched/fair.c     | 41 +++++++++++++++++++----------------------
>  kernel/sched/pelt.c     |  2 +-
>  kernel/sched/rt.c       |  2 --
>  4 files changed, 20 insertions(+), 27 deletions(-)

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d2758e3..ce0dcbf 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7550,39 +7550,36 @@ static inline int get_sd_load_idx(struct sched_domain *sd,
>  static unsigned long scale_rt_capacity(int cpu)
>  {
>  	struct rq *rq = cpu_rq(cpu);
> -	u64 total, used, age_stamp, avg;
> -	s64 delta;
> -
> -	/*
> -	 * Since we're reading these variables without serialization make sure
> -	 * we read them once before doing sanity checks on them.
> -	 */
> -	age_stamp = READ_ONCE(rq->age_stamp);
> -	avg = READ_ONCE(rq->rt_avg);
> -	delta = __rq_clock_broken(rq) - age_stamp;
> +	unsigned long max = arch_scale_cpu_capacity(NULL, cpu);
> +	unsigned long used, irq, free;
>  
> -	if (unlikely(delta < 0))
> -		delta = 0;
> +#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
> +	irq = READ_ONCE(rq->avg_irq.util_avg);
>  
> -	total = sched_avg_period() + delta;
> +	if (unlikely(irq >= max))
> +		return 1;
> +#endif

Note that 'irq' is unused outside that macro block, resulting in a new warning on 
defconfig builds:

 CC      kernel/sched/fair.o
 kernel/sched/fair.c: In function ‘scale_rt_capacity’:
 kernel/sched/fair.c:7553:22: warning: unused variable ‘irq’ [-Wunused-variable]
   unsigned long used, irq, free;
                       ^~~

I have applied the delta fix below for simplicity, but what we really want is a 
cleanup of that function to eliminate the #ifdefs. One solution would be to factor 
out the 'irq' utilization value into a helper inline, and double check that if the 
configs are off the compiler does the right thing and eliminates this identity 
transformation for the irq==0 case:

        free *= (max - irq);
        free /= max;

If the compiler refuses to optimize this away (due to the zero and overflow 
cases), try to find something more clever?

Thanks,

	Ingo

 kernel/sched/fair.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e3221db0511a..d5f7d521e448 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7550,7 +7550,10 @@ static unsigned long scale_rt_capacity(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long max = arch_scale_cpu_capacity(NULL, cpu);
-	unsigned long used, irq, free;
+	unsigned long used, free;
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+	unsigned long irq;
+#endif
 
 #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
 	irq = READ_ONCE(rq->avg_irq.util_avg);
