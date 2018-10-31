Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B712BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBA42054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BWmJmWQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBA42054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbeJaXR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:17:27 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34654 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbeJaXR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:17:27 -0400
Received: by mail-io1-f66.google.com with SMTP id d80-v6so9783008iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 07:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=IlzRQXbAV1LXlsHt9Ex8s6CKDGNyrq+9u53dKATLAyw=;
        b=BWmJmWQof9e0QpnRPkWeO1GfBA5TijTXWmOknsK4BaUjIbyvBQX1UD7bbTWdI0mLyK
         p6+ERICySQKBkEo3oLAxaQXmyfHwRN8kJBjN3nDPWTN8WL0CW8aDbpTpf+bjTS3KqOcN
         PM+gj4ouDouHPFjfZ3c41a7j56tPaOe5J+Ll94u/G2NtmVxYlU3fPMIs+c7D4vbv5VhU
         MWct8LM3WEhCCRSXGkGD7cNPMUuGzXE1fVgzWkFspkqGaP3SD7K7gew86mWKauaDoT8/
         d5wVLhKP0RGALRQaKj5q0ZxcpRt4qNtLcPLFKWmUEzEk8ten29j0u0OP9X0ivS+oJXYE
         k56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IlzRQXbAV1LXlsHt9Ex8s6CKDGNyrq+9u53dKATLAyw=;
        b=qWC0kGnDU2jnJWryHRO/MQM8fuSGDi3jj2bYietrmT01rRWp2CGyMlk0gIV/K0SLQB
         pkafBF0zXCwDrT61N2TpnWgbOMyv3j11T9yIFSQ6TvbqQfqg62zUk9zo1lK65gGNWnrY
         Sr+ktHYMrneYZhhcwFvOb4iMzbAs7/kW1L6UjOOLAJ3XyrIZ54SrPMXy8l80cnHc1rM0
         6tKZyblUGBRfkgJq78kJsyWXcZ+Ks+k/5/fD5K2Ap5PuosZTdFcc0QYZDE2zDtJHgc6d
         8BJT341PfvrE74wqdfpwT8KutrE0pSpbMUYicfQsOMoxWFfQEnMoMwo+mRVaIHiMvEbt
         AzJQ==
X-Gm-Message-State: AGRZ1gLZ0qX2bYMVjgxCzZAfoE5c8J2QgfgTelXZ/inExKoFAPAylphk
        pDSFu1uGTinAVhGd5YvqA508HGtqmJk=
X-Google-Smtp-Source: AJdET5e/EtH61gVC/MlGIzj2I1F6nFbgDINzhkHkxCpojNU29UyGVKJP3f7nkrCG/OpcSCApic64ag==
X-Received: by 2002:a6b:bd45:: with SMTP id n66-v6mr2159406iof.25.1540995552802;
        Wed, 31 Oct 2018 07:19:12 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 22-v6sm12398779ioc.22.2018.10.31.07.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 07:19:11 -0700 (PDT)
Subject: Re: [PATCH 05/16] blk-mq: allow software queue to map to multiple
 hardware queues
To:     Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-6-axboe@kernel.dk>
 <f5bff9c7-2c94-8988-cf76-318fa0808cf0@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <95e50d97-7cb3-7632-6e3f-b75ce32153ff@kernel.dk>
Date:   Wed, 31 Oct 2018 08:19:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f5bff9c7-2c94-8988-cf76-318fa0808cf0@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 6:49 PM, Sagi Grimberg wrote:
> 
> 
>> @@ -2342,10 +2346,16 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>>   
>>   		ctx = per_cpu_ptr(q->queue_ctx, i);
>>   		hctx = blk_mq_map_queue_type(q, 0, i);
>> -
>> +		hctx->type = 0;
>>   		cpumask_set_cpu(i, hctx->cpumask);
>> -		ctx->index_hw = hctx->nr_ctx;
>> +		ctx->index_hw[hctx->type] = hctx->nr_ctx;
>>   		hctx->ctxs[hctx->nr_ctx++] = ctx;
>> +
>> +		/*
>> +		 * If the nr_ctx type overflows, we have exceeded the
>> +		 * amount of sw queues we can support.
>> +		 */
>> +		BUG_ON(!hctx->nr_ctx);
> 
> Was this added because nr_ctx became short? What was the motivation
> for that? save space? structure alignment?

Right, I made it smaller to not take up more space after this change.
And since it is now smaller, adding a check for wrap seemed like
a good idea.

> Perhaps this should be mentioned in the change log (as it contradicts
> that no functional changes exist in this patch). Or, if this can happen
> even when 32bit nr_ctx, it should be a separate small patch?

Could happen for any type, but more likely now of course. I'll
mention this in the changelog.

-- 
Jens Axboe

