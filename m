Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5B5ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549AC2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fCD7I1df"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549AC2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbeJYWvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:51:33 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45543 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbeJYWvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:51:31 -0400
Received: by mail-io1-f68.google.com with SMTP id p83-v6so5562621iod.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 07:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+HzlY1k4slAIhe1YKshJZJ6SZqvHLbxR+aogQPbwhJM=;
        b=fCD7I1df6jJKIjxIJc2i9wbIv7COG4NQ3iMbzapAwo4fHX2JsDOGUdDZWRkasopUfO
         RqISQelVkTy8HWTs/BheN9nYIwr3Blmn0zWy93DTxKtYli434BaLa2KMsmTL7TGB3boV
         Cfa6jUf5lSILKxi3Oh+7YoOpbZr+hLrrWHBHMKl6pt8KQFVYSBHKCYDFJ9pTUbavEwn7
         7G26/4Orom7bd9rr1UnoK95jpNqjVU6tUClt2eWXBKazk5IhkAZxtJmT2Y6ypyHeZDh5
         VOuu5td5Tw/mITqDTjySqYFzcpoECzIVBl0McQYHyHnGKfBYeMhz0WgCA7DME731f5Cn
         Qn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+HzlY1k4slAIhe1YKshJZJ6SZqvHLbxR+aogQPbwhJM=;
        b=afvG0AbFb0Wu60NTEjFk+zJukEs46tudxioJGRTmtwiR+nZUVvQZ5bRUBxDOeMdl2f
         A5XFsdyWe+dxNGI+CUxUyoeQpX3K8D9R25ONrghg16RQXnBPB5TOhSkMBrAbybeicVyQ
         nEdTntLnewjMdYNtqQiqK9rU9nz8dAPPV94qgk2xDtWLWGFAyEHre8rG/6LUUzYHJTsc
         PRs5IaA/hzEfMyq/5xfNUYgA7Xcx9DwJzwXgqHj4ENj6qtwbuXi0DxPPmJ3RKZAmH4ip
         ftsB0G/Tp+ezklemLPTsRqqJytoE0c3vQQvwuPf1xhAjY0OE2VWz3KdckCjSRT5w7iR3
         ziRQ==
X-Gm-Message-State: AGRZ1gKBqtFEkfQEAl0U0kFRxSQMrN153mAwhGz6mNx3tTj608M5np1w
        GtWAfxbcR+NzQw9TdxSm9FvsMA==
X-Google-Smtp-Source: AJdET5fSIO2tOUSy5AcWz77hiSPIDndrZ5Er1I9eVPf6cFvxTGHSc+brPz48U7ctDtKRRH3V2C6gwQ==
X-Received: by 2002:a6b:cc05:: with SMTP id c5-v6mr1070976iog.171.1540477112778;
        Thu, 25 Oct 2018 07:18:32 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k5-v6sm623181ita.14.2018.10.25.07.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 07:18:31 -0700 (PDT)
Subject: Re: [PATCH BUGFIX] block, bfq: fix asymmetric scenarios detection
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Federico Motta <federico@willer.it>
References: <20181024171325.7154-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7023bec4-f0dc-2238-25ca-4b76edfeb0f1@kernel.dk>
Date:   Thu, 25 Oct 2018 08:18:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181024171325.7154-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/18 11:13 AM, Paolo Valente wrote:
> From: Federico Motta <federico@willer.it>
> 
> Since commit 2d29c9f89fcd ("block, bfq: improve asymmetric scenarios
> detection"), a scenario is defined asymmetric when one of the
> following conditions holds:
> - active bfq_queues have different weights
> - one or more group of entities (bfq_queue or other groups of entities)
>   are active
> bfq grants fairness and low latency also in such asymmetric scenarios,
> by plugging the dispatching of I/O if the bfq_queue in service happens
> to be temporarily idle. This plugging may lower throughput, so it is
> important to do it only when strictly needed.
> 
> By mystake, in commit '2d29c9f89fcd' ("block, bfq: improve asymmetric
> scenarios detection") the num_active_groups counter was firstly
> incremented and subsequently decremented at any entity (group or
> bfq_queue) weight change.
> 
> This is useless, because only transitions from active to inactive and
> vice versa matter for that counter. Unfortunately this is also
> incorrect in the following case: the entity at issue is a bfq_queue
> and it is under weight raising. In fact in this case there is a
> spurious increment of the num_active_groups counter.
> 
> This spurious increment may cause scenarios to be wrongly detected as
> asymmetric, thus causing useless plugging and loss of throughput.
> 
> This commit fixes this issue by simply removing the above useless and
> wrong increments and decrements.

Applied for 4.20, thanks.

-- 
Jens Axboe

