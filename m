Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887D6C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 21:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EED20652
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 21:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pblUvn0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EED20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbeJNFTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 01:19:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40879 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeJNFTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 01:19:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id 1-v6so7488446plv.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 14:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PYDq7hgBhHOnvbNQWmSrh+MOVU+QnkRRnv/J/5jcuGM=;
        b=pblUvn0t5wNz1NmyuQk2r0sU+i4HXJqsl3x9qdzlhqkcvXSKzg/xKs3vX/p9QvMFIM
         FhHpjKNzUYZt1qYp9vVPH3nM0DnNX/sGH1TI3jXzPJWKQPCCPUYHoNuUh4pz3pBW+ml7
         3bhazUgq6BTgpA//zwmT8HkYMmLuTK8nTEwuPI/d1lpLSdnQ8e0lYsPNhzsvomVC2+/1
         KS4OPiuwy9n37eVkr8EpIix4t1cbBCngEkoRTcBplHw6wQ+LaKSigaYJmsYQU97rZrdu
         gWcklkRXxxSVmg9rdcvpVkSY4GX56T1QMrrjqWFFxTH3yV2Q94/SwZ6lQ1m9r0ZjDfKG
         PSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PYDq7hgBhHOnvbNQWmSrh+MOVU+QnkRRnv/J/5jcuGM=;
        b=Xa3ybooxsPGw1S/JyexQHCduYIrGH2+VNYqt9xK6X0FMx9Ug8i7atHGcr19sm9vcJ9
         4IcJJ4Z2RokKmV2YGQ4EEW6ketLV2rvbsPWtcSY0sfQheR5uMPhrrSlHgvoQTMtFDwXr
         vbaT/OkoQlexLYxEMbrHQWLR95IMMofcK/3FCZqcD7Npn3asbH5rXNhV5tkrCwEa6IA8
         o5wunP9v8UxW3GXmVex60oI7feStGmFPpiDT9+RIAXPpbkuNa/PK4yA4BcWiN5zr5c8n
         XwrQz6colSzvFQhx/YyGhJoHeBgdzIpogkxgY/J5UDIm/Ge2/VRPSYBGlehuFlyceQed
         i15A==
X-Gm-Message-State: ABuFfohmYBnSW7QndWHV/FBs/ZitCgcsc/klQ6ZZMdw85RLaT3tXWK5Z
        Zdhz4zsLpcyxfG3q3qw88RUHgQ==
X-Google-Smtp-Source: ACcGV63QZ8vn6J77FWQyMfz6yvWwf0l/xU6uuiU8+LqFZQ4gUr9pFyh8BK3KT2OQsDxpUVUSwvuObA==
X-Received: by 2002:a17:902:aa8f:: with SMTP id d15-v6mr11097511plr.242.1539466834660;
        Sat, 13 Oct 2018 14:40:34 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s80-v6sm8742930pfa.114.2018.10.13.14.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Oct 2018 14:40:33 -0700 (PDT)
Subject: Re: [PATCH] block, bfq: improve asymmetric scenarios detection
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, Federico Motta <federico@willer.it>
References: <20181012095557.13744-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5aea7d49-440c-e090-d12c-74db346fb93e@kernel.dk>
Date:   Sat, 13 Oct 2018 15:40:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181012095557.13744-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/18 3:55 AM, Paolo Valente wrote:
> From: Federico Motta <federico@willer.it>
> 
> bfq defines as asymmetric a scenario where an active entity, say E
> (representing either a single bfq_queue or a group of other entities),
> has a higher weight than some other entities.  If the entity E does sync
> I/O in such a scenario, then bfq plugs the dispatch of the I/O of the
> other entities in the following situation: E is in service but
> temporarily has no pending I/O request.  In fact, without this plugging,
> all the times that E stops being temporarily idle, it may find the
> internal queues of the storage device already filled with an
> out-of-control number of extra requests, from other entities. So E may
> have to wait for the service of these extra requests, before finally
> having its own requests served. This may easily break service
> guarantees, with E getting less than its fair share of the device
> throughput.  Usually, the end result is that E gets the same fraction of
> the throughput as the other entities, instead of getting more, according
> to its higher weight.
> 
> Yet there are two other more subtle cases where E, even if its weight is
> actually equal to or even lower than the weight of any other active
> entities, may get less than its fair share of the throughput in case the
> above I/O plugging is not performed:
> 1. other entities issue larger requests than E;
> 2. other entities contain more active child entities than E (or in
>    general tend to have more backlog than E).
> 
> In the first case, other entities may get more service than E because
> they get larger requests, than those of E, served during the temporary
> idle periods of E.  In the second case, other entities get more service
> because, by having many child entities, they have many requests ready
> for dispatching while E is temporarily idle.
> 
> This commit addresses this issue by extending the definition of
> asymmetric scenario: a scenario is asymmetric when
> - active entities representing bfq_queues have differentiated weights,
>   as in the original definition
> or (inclusive)
> - one or more entities representing groups of entities are active.
> 
> This broader definition makes sure that I/O plugging will be performed
> in all the above cases, provided that there is at least one active
> group.  Of course, this definition is very coarse, so it will trigger
> I/O plugging also in cases where it is not needed, such as, e.g.,
> multiple active entities with just one child each, and all with the same
> I/O-request size.  The reason for this coarse definition is just that a
> finer-grained definition would be rather heavy to compute.
> 
> On the opposite end, even this new definition does not trigger I/O
> plugging in all cases where there is no active group, and all bfq_queues
> have the same weight.  So, in these cases some unfairness may occur if
> there are asymmetries in I/O-request sizes.  We made this choice because
> I/O plugging may lower throughput, and probably a user that has not
> created any group cares more about throughput than about perfect
> fairness.  At any rate, as for possible applications that may care about
> service guarantees, bfq already guarantees a high responsiveness and a
> low latency to soft real-time applications automatically.

Thanks, applied.

-- 
Jens Axboe

