Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AB6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F802084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="K3uh3lHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F802084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeJ3CXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:23:11 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39741 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeJ3CXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:23:10 -0400
Received: by mail-io1-f66.google.com with SMTP id n11-v6so5497505iob.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ZbubRYa/8fy+0yJxd9+y45LroD/J4+JL9RC6O2OzP8w=;
        b=K3uh3lHZN0OE4CM1dCqWmJIB9hkipycO+/JsiXdLVrp5RwvFVrOVuE1nvQA2bDf2Hq
         Ci3HBPIcKwfbaBDZ5sBUaiSA2ZIP+MNQIKXj/aQMziSDPDvkeTa4TKYn/hb9uLJ6Fd15
         1RhHw3yHVJurQ+Mt2NrDWz5F5XRkGTpgk0vFO6prcIbmbeaPnY3RkPS1OunYN4x7jhuS
         1CYaaV77/YqRKlXbTTK6zkyks+VjlZUaQU1cOTGJoe9uuE4GdYH/hA+BGjhUxXjykXrs
         +YHUmPm46eg1mRCxWYNTAjtE6P/3mqWBAr5CcT6Rh4S44VFTqD5o8Zv0jRmc5HywyaZ5
         npUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZbubRYa/8fy+0yJxd9+y45LroD/J4+JL9RC6O2OzP8w=;
        b=CZGpM1GZ5CLuDRbwtXjLPF88I2snwexTda9Lqdba+rT6p3zQ2rDQ2kwHd7TkgGC1pO
         pZk+HMfJWRIrPwCxVcqPDvq3mUKsj5C2h/ye1xnOlTo3SUZ4SZ6Y/TQTRWk+K/UKcS2S
         sX31okkqItLWqPffQTp2GTLvzlKHmQ0YC/+yPrsHOpTHcsAYkIa0UJBy20raTq8+GfIM
         DtNcYwWXM3xDqAqRBryOVd80xeQSpY8eErJjyrWJzbnurgyztfGtWnrffM1l8KQY9V2v
         CnguxLTr91RaINy9hG6QRtC2wRwQO9EbFJxe0rS26B61DfXjhXgewIqbrlhZhfF24/Hr
         Akdw==
X-Gm-Message-State: AGRZ1gJvvzpLKZqNLAclkni2n8DPRQO+Ixv/xNcTYTJ/aWjumVAYJsDS
        U6sTYyjVMVQNBG0/mynPteuzE/Tp5Jk=
X-Google-Smtp-Source: AJdET5eNuL5y5btNXG41pSHDpoMFYpZgzgjXpypPFXCuxpYUHNhEgb1TYfqGAPBgBSa1F/r0vnuwXw==
X-Received: by 2002:a6b:c6d1:: with SMTP id w200-v6mr8858646iof.79.1540834414936;
        Mon, 29 Oct 2018 10:33:34 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id n2-v6sm6738920iog.75.2018.10.29.10.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 10:33:33 -0700 (PDT)
Subject: Re: [PATCH 04/14] blk-mq: pass in request/bio flags to queue mapping
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-5-axboe@kernel.dk> <1540834236.196084.61.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9b61eab8-0289-2127-5529-4f599fb1da24@kernel.dk>
Date:   Mon, 29 Oct 2018 11:33:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540834236.196084.61.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/18 11:30 AM, Bart Van Assche wrote:
> On Mon, 2018-10-29 at 10:37 -0600, Jens Axboe wrote:
>> @@ -400,9 +402,15 @@ void blk_mq_sched_insert_requests(struct request_queue *q,
>>  				  struct blk_mq_ctx *ctx,
>>  				  struct list_head *list, bool run_queue_async)
>>  {
>> -	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
>> -	struct elevator_queue *e = hctx->queue->elevator;
>> +	struct blk_mq_hw_ctx *hctx;
>> +	struct elevator_queue *e;
>> +	struct request *rq;
>> +
>> +	/* For list inserts, requests better be on the same hw queue */
>> +	rq = list_first_entry(list, struct request, queuelist);
>> +	hctx = blk_mq_map_queue(q, rq->cmd_flags, ctx->cpu);
> 
> Passing all request cmd_flags bits to blk_mq_map_queue() makes it possible
> for that function to depend on every single cmd_flags bit even if different
> requests have different cmd_flags. Have you considered to pass the hw_ctx
> type only to blk_mq_map_queue() to avoid that that function would start
> depending on other cmd_flags?

The core only knows about the number of types, not what each type means
nor how to map it outside of using the mapping functions. So I don't
want to expose this is an explicit type, as that would then mean that
blk-mq had to know about them.

> Additionally, what guarantees that all requests in queuelist have the same
> hw_ctx type? If a later patch will guarantee that, please mention that in
> the comment about list_first_entry().

When the code is introduced, it's always the same hctx. Later on when we
do support multiple sets, the user of the list insert (plugging) explicitly
makes sure that a list only contains requests for the same hardware queue.

I'll improve the comment.

-- 
Jens Axboe

