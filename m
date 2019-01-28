Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F13C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA8A21736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfA1Ieu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:34:50 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40872 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbfA1Ieu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:34:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F98DEBD;
        Mon, 28 Jan 2019 00:34:50 -0800 (PST)
Received: from [192.168.1.12] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1DC2F3F589;
        Mon, 28 Jan 2019 00:34:48 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Remove unneeded prototype of capacity_of()
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, morten.rasmussen@arm.com,
        quentin.perret@arm.com, Dietmar.Eggemann@arm.com
References: <20190102135549.6929-1-valentin.schneider@arm.com>
Message-ID: <232cce1e-7fb5-c1fd-8171-ca4fc00171ba@arm.com>
Date:   Mon, 28 Jan 2019 08:34:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190102135549.6929-1-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/01/2019 13:55, Valentin Schneider wrote:
> The prototype of that function was already hoisted up in
> 
>   commit 3b1baa6496e6 ("sched/fair: Add 'group_misfit_task' load-balance type")
> 
> but that seems to have been missed. Get rid of the extra prototype.
> 
> Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

I had forgotten about that one... Ping.

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
> 
