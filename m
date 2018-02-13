Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935051AbeBMM1s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:27:48 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38662 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934971AbeBMM1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:27:47 -0500
X-Google-Smtp-Source: AH8x226fi4q2zlpBZxE66/HNMoVoR4/DnpCcSKo+EcXjZGiEtCCOz7D7vZocOhaLSVD+3fUQzC2psQ==
Date: Tue, 13 Feb 2018 13:27:42 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Mario Leinweber <marioleinweber@web.de>
Cc: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/sched/cpudeadline: Fixed code style errors and
 warnings
Message-ID: <20180213122742.tz2j5nkwuopi7unp@gmail.com>
References: <20180208025359.17695-1-marioleinweber@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208025359.17695-1-marioleinweber@web.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mario Leinweber <marioleinweber@web.de> wrote:

> diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
> index 8d9562d890d3..6a9defebbb54 100644
> --- a/kernel/sched/cpudeadline.c
> +++ b/kernel/sched/cpudeadline.c
> @@ -42,8 +42,9 @@ static void cpudl_heapify_down(struct cpudl *cp, int idx)
>  		return;
>  
>  	/* adapted from lib/prio_heap.c */
> -	while(1) {
> +	while (1) {
>  		u64 largest_dl;
> +
>  		l = left_child(idx);
>  		r = right_child(idx);
>  		largest = idx;
> @@ -131,6 +132,7 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
>  		return 1;
>  	} else {
>  		int best_cpu = cpudl_maximum(cp);
> +
>  		WARN_ON(best_cpu != -1 && !cpu_present(best_cpu));
>  
>  		if (cpumask_test_cpu(best_cpu, &p->cpus_allowed) &&
> @@ -205,6 +207,7 @@ void cpudl_set(struct cpudl *cp, int cpu, u64 dl)
>  	old_idx = cp->elements[cpu].idx;
>  	if (old_idx == IDX_INVALID) {
>  		int new_idx = cp->size++;
> +
>  		cp->elements[new_idx].dl = dl;
>  		cp->elements[new_idx].cpu = cpu;
>  		cp->elements[cpu].idx = new_idx;

Your Signed-off-by tag is missing.

Thanks,

	Ingo
