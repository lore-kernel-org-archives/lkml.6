Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935F0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EB52082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jladFqca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EB52082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbeJ3FTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:19:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43983 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbeJ3FTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:19:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id g59-v6so346021plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 13:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EZYxQZbSxAHazizrdQH9iLVv8n/OuBKXe7dil/rdMNY=;
        b=jladFqcaeyMDVEcPA5V35mgKzd7YKZnGCq9iNUhBn2kgx3FHIlE0CtJqxfFCSbR7QB
         bw7xUuZf+GbGy0RGcb7Z2Snc3JQ9P0lAQSXvThCqthNkht9G1w+TTDAHvFHRFZO5xvM3
         nep++lrf+ETGtQuJlm3/zOXOUCgZlMmkChtRIyhV//5VoHoZ2dxdZNs5ngvEWT2OUicy
         6bRmY7UTohM+2I/JWZ4LauZdWsvi9bn4/oo/Fy3cgdlMFM4Y+7lPVi/nXF2kCKRya52r
         s7pbLyiSiNrm9JjUY86p/PjREApI8q4lo/qYfkzfFTbaz0PfAC+UStQbRy3/OjkeYQSO
         30EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EZYxQZbSxAHazizrdQH9iLVv8n/OuBKXe7dil/rdMNY=;
        b=e4oypiGMZYa7oah680LQgulyYinhQTi/51Y5PIu8ES7t5lorXGFLV5jlBbGN1Y+5sH
         lqIQLrZ9QhRtNEWgxUiouNpazdNmuwqO7vEIhbbHgLMiiIzLFZF4osIn54sWxkeIlI0O
         soek8Cfyf5PgHaO1a6kA/ZO7SCmgr2M6c9qdRYk4GN/1nRYlfAXjiE52YNIZcFXYMUMy
         xYgrz0qrfR37TjG7cyKo9TIHcZPUzAf3egY1WFRRtguUk6z100xtkoc1+YdtyIVRQP8V
         Ji5ICtdFYmywnR5gdsnyfBYXOlJixpjFLliVAN8eBO4gbUsfQMXlGz/liXcrvL7lbZP8
         x7ig==
X-Gm-Message-State: AGRZ1gJGaGOHHgEf6R1tGvlam8Dp729Tr19Eb6m/7tcr/GZYw7rw8Drd
        5uICT4iAD9rtzNu+9GGevPJqq15GMw0=
X-Google-Smtp-Source: AJdET5cDEUDbRpw12rmqz5s6qI2ZlH8iqlxqiiJj+3aFcVtIko3ASgEFAj1TKZohIEx7lFQYWm1OHw==
X-Received: by 2002:a17:902:b03:: with SMTP id 3-v6mr5107520plq.233.1540844959862;
        Mon, 29 Oct 2018 13:29:19 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t85-v6sm28847053pfi.73.2018.10.29.13.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 13:29:18 -0700 (PDT)
Subject: Re: [PATCH 10/14] blk-mq: initial support for multiple queue maps
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-11-axboe@kernel.dk>
 <1540842034.196084.89.camel@acm.org>
 <ac755067-1432-54ce-6a4f-c7383f1ecc9d@kernel.dk>
 <1540843250.196084.93.camel@acm.org>
 <867d3e60-3edf-39e7-2bcb-02d7f1092f82@kernel.dk>
 <1540844730.196084.95.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <50515ef4-35d4-b238-e0fe-799c2fc758cb@kernel.dk>
Date:   Mon, 29 Oct 2018 14:29:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540844730.196084.95.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/18 2:25 PM, Bart Van Assche wrote:
> On Mon, 2018-10-29 at 14:09 -0600, Jens Axboe wrote:
>> hctx->type will be set to the value of the first type. This is all driver
>> private, blk-mq could not care less what the value of the type means.
>>
>> As to the other question, it works just fine since that is the queue
>> that is being accessed. There's no confusion there. I think you're
>> misunderstanding how it's seutp. To use nvme as the example, type 0
>> would be reads, 1 writes, and 2 pollable queues. If reads and writes
>> share the same set of hardware queues, then type 1 simply doesn't
>> exist in terms of ->flags_to_type() return value. This is purely
>> driven by the driver. That hook is the only decider of where something
>> will go. If we share hctx sets, we share the same hardware queue as
>> well. There is just the one set for that case.
> 
> How about adding a comment in blk-mq.h that explains that hardware queues can
> be shared among different hardware queue types? I think this is nontrivial and
> deserves a comment.

Sure, I can do that. I guess a key concept that is confusing based on
your above question is that the sets don't have to be consecutive.
It's perfectly valid to have 0 and 2 be the available queues, and
nothing for 1. For example.

BTW, split up the incremental patch, find them here:

http://git.kernel.dk/cgit/linux-block/commit/?h=mq-maps&id=6890d88deecfd3723ce620d82f5fc80485f9caec

and

http://git.kernel.dk/cgit/linux-block/commit/?h=mq-maps&id=907725dff2f8cc6d1502a9123f930b8d3708bd02

-- 
Jens Axboe

