Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ACDC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9012087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KaYcldL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9012087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbeKTWpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:45:12 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56706 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbeKTWpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 17:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dWQpHLZ5YnzpRmUGkheKCfgduVL+JSLGnwYGK1wo7lg=; b=KaYcldL5ufgM6fELZ12IMxd6LK
        kI+AYfI2P4edfcD6G0HsB808RX5Ayz96Z59Z1Y/U9a/GpyvQ0jtmKd7ywJcSuhrqgqfVkc7FdLwrY
        2Jf+ChaKsDDIqJHmNWBHSv7ZLeTtI9YFUe/w9lz3zG+OfYcHhKa7cNaI+Q2Lz7ye6X28l2Vo4RkIx
        UBzvgdO/rYICFB7Rv9box9BETXONU4clCifE0kxjGMac1+zMP+o8Rtcv1qaxIraBrZLWjRUV8QDvN
        rCbMzbEZoggl9hU56SwWSVyGbteOSiykUIw1yQJOdP3I5RKP9ajFZcuso2gXdZoB79yxo00fO/ppe
        gWIWCiPA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP4wy-0007Pb-FX; Tue, 20 Nov 2018 12:16:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 05C3A2029F87F; Tue, 20 Nov 2018 13:16:15 +0100 (CET)
Date:   Tue, 20 Nov 2018 13:16:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     mingo@redhat.com, bp@suse.de, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn
Subject: Re: [PATCH] sched/rt: Fix -Wmissing-prototypes warnings
Message-ID: <20181120121614.GJ2131@hirez.programming.kicks-ass.net>
References: <1542070474-4025-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1542070474-4025-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 08:54:34AM +0800, Yi Wang wrote:
> We get a warning when building kernel with W=1:
> kernel/sched/rt.c:626:6: warning: no previous prototype for ‘sched_rt_bandwidth_account’ [-Wmissing-prototypes]
>  bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
> 
> Add the missing declaration to fix this.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
>  kernel/sched/sched.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 618577f..f5f29fc 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -442,6 +442,7 @@ extern void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
>  
>  extern void free_rt_sched_group(struct task_group *tg);
>  extern int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent);
> +extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
>  extern void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
>  		struct sched_rt_entity *rt_se, int cpu,
>  		struct sched_rt_entity *parent);

This would then also render the declaration in sched/deadline.c
redundant.

Or am I missing something?
