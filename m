Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E18FC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DEB2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hVU8ws3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DEB2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeJ3En0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:43:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37684 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeJ3EnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:43:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id c10-v6so4421838pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 12:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0cPiMcwlsGYtQhxvcHlRTbM4PdmO5Hd3NjbmK0HI/BQ=;
        b=hVU8ws3qOTcY9R/wQrT3mbCW3giXyR4GgNaFVw+RpgcjP6dDFN+2C7Fe0wEISWQSgB
         2H7eoIjKrkeS6xWHpUoBoMtBCls7d8mOhMrw5dDmrk4f2D/ARLucmjBFgKs5A2yoDOZA
         LCAHOMX+2XEB4P9skJsR0iOdo8YY1e/nG23hYKl+kQhQuTLqpb3JDpn36qtbG5lsXNsY
         us785kZPuJ0r7alGFQpwURQHiYj06hpOI9DwvOYjnkItL5RYlP5ZbhAdZt0Az6trF9Yw
         qb19Y9UtXMeX3LQ/m1uDZWU8aBkf9zh4bXsTxqWGKTtnK5lIDnmVs6PnKlX9qmCp9nUT
         YfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0cPiMcwlsGYtQhxvcHlRTbM4PdmO5Hd3NjbmK0HI/BQ=;
        b=TdLlGNWTr5Hv3antieLpPxTEhzsO0ydTvR+gPnbxC5kjEqSDV6Qux3qJEYHWvjx3vS
         K93ac0Wv3wOtWTh/3YDNo1IWjx5E26c5D/+uOeNYOJLGcxIHDGHBh4Kz1ZMHBigtZCi6
         hoDKzenC4nsYpWrPB8yfX26euDuY1SsopbTw4RwYK2lrGq48wiQhrglZC1O/caRRLIZz
         3yPPB/yYG85292tH9vzcA1+zEW5dFrHBx5k5XCvA0L9bxVKvjBpTqtOhtxf2qZrAfpd7
         5ZVicgg4erBUMhG4y0WZ8KNiYi6NU6glrJowxVFvEW0KQTX4B+Bh0KdUrDYOsbVwpehX
         P8FA==
X-Gm-Message-State: AGRZ1gJORdA1QnJ+n08frbPbsJrFLeGRKcqbfQXSPwIv54xKHGXq0v0b
        aCMntrn88VtGuVGuteKmZHaCHUIQ6kc=
X-Google-Smtp-Source: AJdET5dSNpA2y046ibU0eXB/+EIlrjSqQJ7AD69ZBURdgz/Kf7qk/CCCCS+JqTjMIduhTzyEPB1gaw==
X-Received: by 2002:a62:2803:: with SMTP id o3-v6mr10129976pfo.57.1540842795845;
        Mon, 29 Oct 2018 12:53:15 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p1-v6sm28967896pfj.72.2018.10.29.12.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 12:53:14 -0700 (PDT)
Subject: Re: [PATCH 10/14] blk-mq: initial support for multiple queue maps
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-11-axboe@kernel.dk>
 <1540842034.196084.89.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ac755067-1432-54ce-6a4f-c7383f1ecc9d@kernel.dk>
Date:   Mon, 29 Oct 2018 13:53:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540842034.196084.89.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/18 1:40 PM, Bart Van Assche wrote:
> On Mon, 2018-10-29 at 10:37 -0600, Jens Axboe wrote:
>> -static int cpu_to_queue_index(unsigned int nr_queues, const int cpu)
>> +static int cpu_to_queue_index(struct blk_mq_queue_map *qmap,
>> +			      unsigned int nr_queues, const int cpu)
>>  {
>> -	return cpu % nr_queues;
>> +	return qmap->queue_offset + (cpu % nr_queues);
>>  }
>>
>> [ ... ]
>>  
>> --- a/include/linux/blk-mq.h
>> +++ b/include/linux/blk-mq.h
>> @@ -78,10 +78,11 @@ struct blk_mq_hw_ctx {
>>  struct blk_mq_queue_map {
>>  	unsigned int *mq_map;
>>  	unsigned int nr_queues;
>> +	unsigned int queue_offset;
>>  };
> 
> I think it's unfortunate that the blk-mq core uses the .queue_offset member but
> that mapping functions in block drivers are responsible for setting that member.
> Since the block driver mapping functions have to set blk_mq_queue_map.nr_queues,
> how about adding a loop in blk_mq_update_queue_map() that derives .queue_offset
> from .nr_queues from previous array entries?

It's not a simple increment, so the driver has to be the one setting it. If
we end up sharing queues, for instance, then the driver will need to set
it to the start offset of that set. If you go two patches forward you
can see that exact construct.

IOW, it's the driver that controls the offset, not the core.

-- 
Jens Axboe

