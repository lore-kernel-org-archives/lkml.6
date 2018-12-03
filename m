Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D898C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3120E20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="of2S7LwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3120E20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbeLCIdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:33:41 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59436 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeLCIdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=crPLSNVBh/sifKfRyiGoMjYX2/4swqYqdTP0F28SKKQ=; b=of2S7LwI8IJNAJLyIcHsvtqzB
        Xf/+ke+sqpuobeMpl4n4GXhoe/txj+LwCeouh/DzvCuFCv/GURH0CHZ4dSNfEax6mxA3/b1RHXCn0
        3KluPSNXPinehrzwE/jO6P/ALjWWBrHhWEuLbJPJS7Wuv2d7QyWODlUyTQfLybXlyCyNHUqQEBzjh
        T8b/exPVCCoUNPIJVmTJhLIjPlvr5yglLNxnqC3z56y+Lk+rGJdI8k7+x9tLbzh0w9TmyPE4/FXRl
        i6rvHeS9TFfuuBgUDlwFU5XxCkiEMeqc9mvNtV2E9Sldizjt3SAfBNOFAxHOZEgKDngg7vW6fT/kk
        FK2FSjj0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTjfZ-0005nn-AL; Mon, 03 Dec 2018 08:33:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CECD12029F873; Mon,  3 Dec 2018 09:33:29 +0100 (CET)
Date:   Mon, 3 Dec 2018 09:33:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn
Subject: Re: [PATCH] sched/fair: Fix assignment of boolean variables
Message-ID: <20181203083329.GG11614@hirez.programming.kicks-ass.net>
References: <20181201090936.10175-1-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181201090936.10175-1-wen.yang99@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2018 at 05:09:36PM +0800, Wen Yang wrote:
> Fix the following warnings reported by coccinelle:
> kernel//sched/fair.c:7958:3-12: WARNING: Assignment of bool to 0/1
> 
> This also makes the code more readable.

I disagree; anybody that has trouble with 0/1 vs false/true needs to
stay away from C.

> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: linux-kernel@vger.kernel.org
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a2e8160968cb..f19aa66f9b15 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7955,7 +7955,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
>  		    sgs->group_misfit_task_load < rq->misfit_task_load) {
>  			sgs->group_misfit_task_load = rq->misfit_task_load;
> -			*overload = 1;
> +			*overload = true;
>  		}
>  	}
>  

Anyway, this code is going away anyway:

  https://lkml.kernel.org/r/20181119141857.8625-12-quentin.perret@arm.com

