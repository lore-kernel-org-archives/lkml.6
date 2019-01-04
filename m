Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814F1C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB4F21871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfADJPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:15:35 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38348 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfADJPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 04:15:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7036EBD;
        Fri,  4 Jan 2019 01:15:34 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 709283F575;
        Fri,  4 Jan 2019 01:15:33 -0800 (PST)
Date:   Fri, 4 Jan 2019 09:15:28 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, morten.rasmussen@arm.com,
        Dietmar.Eggemann@arm.com
Subject: Re: [PATCH] sched/fair: Remove unneeded prototype of capacity_of()
Message-ID: <20190104091526.uxnw3bic6xydvbh6@queper01-lin>
References: <20190102135549.6929-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102135549.6929-1-valentin.schneider@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On Wednesday 02 Jan 2019 at 13:55:49 (+0000), Valentin Schneider wrote:
> The prototype of that function was already hoisted up in
> 
>   commit 3b1baa6496e6 ("sched/fair: Add 'group_misfit_task' load-balance type")
> 
> but that seems to have been missed.

Indeed, I missed that one :/

> Get rid of the extra prototype.
> 
> Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6483834f1278..6d653947a829 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5083,7 +5083,6 @@ static inline void hrtick_update(struct rq *rq)
>  
>  #ifdef CONFIG_SMP
>  static inline unsigned long cpu_util(int cpu);
> -static unsigned long capacity_of(int cpu);
>  
>  static inline bool cpu_overutilized(int cpu)
>  {
> --
> 2.20.1

Acked-by: Quentin Perret <quentin.perret@arm.com>

Thanks for cleaning this up,
Quentin
