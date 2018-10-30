Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90A6C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C442080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C442080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeJ3TUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:20:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51286 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbeJ3TUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:20:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4386D80D;
        Tue, 30 Oct 2018 03:28:02 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33B303F5D3;
        Tue, 30 Oct 2018 03:28:01 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] sched/fair: Cleanup load_balance() condition
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, patrick.bellasi@arm.com
References: <1537974727-30788-1-git-send-email-valentin.schneider@arm.com>
Message-ID: <8e3c7f04-0d1e-cbe7-4762-b2b5cd42c79b@arm.com>
Date:   Tue, 30 Oct 2018 10:27:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1537974727-30788-1-git-send-email-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/09/2018 16:12, Valentin Schneider wrote:
> The alignment of the condition is off, clean that up.
> 
> Also, logical operators have lower precedence than bitwise/relational
> operators, so remove one layer of parentheses to make the condition a
> bit simpler to follow.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6bd142d..9cf93ba 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8783,9 +8783,9 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>  
>  out_one_pinned:
>  	/* tune up the balancing interval */
> -	if (((env.flags & LBF_ALL_PINNED) &&
> -			sd->balance_interval < MAX_PINNED_INTERVAL) ||
> -			(sd->balance_interval < sd->max_interval))
> +	if ((env.flags & LBF_ALL_PINNED &&
> +	     sd->balance_interval < MAX_PINNED_INTERVAL) ||
> +	    sd->balance_interval < sd->max_interval)
>  		sd->balance_interval *= 2;
>  
>  	ld_moved = 0;
> 

Is there anything else that should be done for these two patches?

Thanks,
Valentin
