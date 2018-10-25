Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA14C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5F020834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LS3N+ZUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5F020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeJZA7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:59:32 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35048 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbeJZA7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:59:31 -0400
Received: by mail-it1-f196.google.com with SMTP id p64-v6so2531484itp.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 09:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fi1Lxx0k/XQuElJKRTZXwVZiXmz5uvY6jGwK0zrGB+8=;
        b=LS3N+ZUbVZAp3gGncd9Bsb72uAZO9AKHtUdqjK4wet8m6UZag++y47BMCbowOY35XT
         HK3V8AR+/RvU60jEm+4KYaOb8Z3Iuk8mkRMq+SAE4VAyagkZIveoA2oquq1bKz3mGP15
         vbq7iQyEBwcbaLeSfjPYh8hluIqBDgbXOemVSz3Jc63nIJLmkljW6nXrpLbjBExOX6T1
         Ypq3TiFfqByHBAuE74z7WobD8Zh6i0Xb3VNvdo1Wuewt7SsvHafKzCQ+xFaGDui6vDbk
         egyq7k7NH3eD39O8s1DEiTyeu5xtPYdDi2xVYmeH51WdblBKdi2n1E5wivzFq2cfO8qZ
         5omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fi1Lxx0k/XQuElJKRTZXwVZiXmz5uvY6jGwK0zrGB+8=;
        b=LJs+CaiGcGyK9SqhnxM3y0T8tC62SjC3lfFmISnLLcEjHSJooLbmrhIqxSB+dSPgSN
         zXwNJepewQP+BNzQakDtIt9xlVZtfPamnbHtgkY7SAQ2oM1y9F4y2qamYBEIlQvY+IdM
         CqkLejswMJfjurj4cg/tD8plWQ8K0Qp5tfm9QyMeG+RMAgtxu9Te0u9qlPddfrYY4yyE
         87ma3cm7Uc+yKbWsdnnQCbTgGfZpJdASB7SRtpYtHVu7a+XzABmiO0Rreymaj56bU4L0
         DD8QTj7JDut/XayZUoPhvK5LyCOutfouGEfIgLD91xF2P/mh8XWI9yGMwMzR+RtEzew0
         N9Kg==
X-Gm-Message-State: AGRZ1gIeSEaAtpPCHXhpPp+qQ62/qElJrtzSODOM+OsNvx6x+B9McA/W
        pczEdFG6CVhgdRTgb0P8hwY9GT1zBNi3og==
X-Google-Smtp-Source: AJdET5eBWJZiwGR8Z1Rg7H5MWq1PVmli64GNiDx5VsesRsX+38lmOXJA7HxL7SWZLh3+meulI+hAwA==
X-Received: by 2002:a02:3f5d:: with SMTP id c29-v6mr1698286jaf.107.1540484760092;
        Thu, 25 Oct 2018 09:26:00 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u4-v6sm3013526iob.0.2018.10.25.09.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 09:25:58 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: ensure hctx to be ran on mapped cpu when issue
 directly
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1540394407-20769-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a25dbb6a-2ffe-a843-abc4-1a6608c17a49@kernel.dk>
Date:   Thu, 25 Oct 2018 10:25:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540394407-20769-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/18 9:20 AM, Jianchao Wang wrote:
> When issue request directly and the task is migrated out of the
> original cpu where it allocates request, hctx could be ran on
> the cpu where it is not mapped. To fix this, insert the request
> if BLK_MQ_F_BLOCKING is set, check whether the current is mapped
> to the hctx and invoke __blk_mq_issue_directly under preemption
> disabled.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e3c39ea..0cdc306 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1717,6 +1717,12 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  {
>  	struct request_queue *q = rq->q;
>  	bool run_queue = true;
> +	blk_status_t ret;
> +
> +	if (hctx->flags & BLK_MQ_F_BLOCKING) {
> +		bypass_insert = false;
> +		goto insert;
> +	}

I'd do a prep patch that moves the insert logic out of this function,
and just have the caller do it by return BLK_STS_RESOURCE, for instance.
It's silly that we have that in both the caller and inside this function.

> @@ -1734,6 +1740,11 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  	if (q->elevator && !bypass_insert)
>  		goto insert;
>  
> +	if (!cpumask_test_cpu(get_cpu(), hctx->cpumask)) {
> +		bypass_insert = false;
> +		goto insert;
> +	}

Should be fine to just do smp_processor_id() here, as we're inside
hctx_lock() here.

-- 
Jens Axboe

