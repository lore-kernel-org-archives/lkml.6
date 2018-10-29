Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44404C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0753D20824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vF9MlsNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0753D20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbeJ3E72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:59:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42146 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729587AbeJ3E72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:59:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id i4-v6so4429315pgq.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 13:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DCZH+xuj1XZH/fQLMSI0SyANiPPPCCy5TacoxsAHWaU=;
        b=vF9MlsNABIUSnQJdUzH80+TheDT38qBXxlFtv5VaTiTz8S8HpCMS4xPyHqa6Xe8Ayx
         nxSP6mHX1dSFoEzbB+bVimSH16yOc50QR1JYjIhXoNXoRTwpXUmhluRccXfCFJ7/aKHx
         Y+NC8bI8NKZc/LXkz7Wng71XuTBQ3lOSNLoqr1cYrLHjSYCaG0WqN6ymUFN7/ADEUXfS
         mRboqeoBIkj6AVcBkLUUmTUa+v2udYoRr20HjdW0W9R06626Wo0P4naUHZwAPlbrPD1x
         IRCdV3ynQ0HfnYe2ehvtZwc01mnBAA501M1HyhfMdWR1x6cjo1rQwSKRNkcAi9Lt5+lE
         996Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DCZH+xuj1XZH/fQLMSI0SyANiPPPCCy5TacoxsAHWaU=;
        b=UTojaGM7t8prPffLNkqGfYc6rFB5NR2pKXT66ptIztMrT/zZzoHV04sxp00R0y3TQH
         6wjhTdP3NFSU0wdrdLMcs4TV4U3+bRPDXeK9tC82x+li1G3TT7IbEcPKSlHIAEA75t9c
         b0mfNkfW4Ianh6u85mErI/G106l8Fgyit+3xwPwB5ZXXgQs6kP6+B0RONRQepk8hjckO
         dOAeNj1VG/cy3QjzmLJcPkoGbWtpIAjOozL8qjfPFIqKbhcSSa3AMyEDdHfLL6Ebulyq
         +pIgJRop7dl3PD1NkXTBWfdOnHV7EAkPeNm+J28mZMU38Aq7U+fQiKCZ5JFQmKZrcgB0
         aogA==
X-Gm-Message-State: AGRZ1gIIrYDUecPYlOcZO619GB5ujoWdn3FPtHMz3wN1nIsOdZXYbw9x
        4QuTH0+OI62uK2TYARnQ6ewAqfcr5zo=
X-Google-Smtp-Source: AJdET5fyPI09kXelT9MWXJSRC884BZ0MciF9OfH6UFA/hEm8s/kDD79H6x1da3DDXY+QcfxjfANXgA==
X-Received: by 2002:a65:4b85:: with SMTP id t5-v6mr15302413pgq.189.1540843754632;
        Mon, 29 Oct 2018 13:09:14 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b139-v6sm22254372pfb.3.2018.10.29.13.09.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 13:09:13 -0700 (PDT)
Subject: Re: [PATCH 10/14] blk-mq: initial support for multiple queue maps
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-11-axboe@kernel.dk>
 <1540842034.196084.89.camel@acm.org>
 <ac755067-1432-54ce-6a4f-c7383f1ecc9d@kernel.dk>
 <1540843250.196084.93.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <867d3e60-3edf-39e7-2bcb-02d7f1092f82@kernel.dk>
Date:   Mon, 29 Oct 2018 14:09:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540843250.196084.93.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/18 2:00 PM, Bart Van Assche wrote:
> On Mon, 2018-10-29 at 13:53 -0600, Jens Axboe wrote:
>> On 10/29/18 1:40 PM, Bart Van Assche wrote:
>>> On Mon, 2018-10-29 at 10:37 -0600, Jens Axboe wrote:
>>>> -static int cpu_to_queue_index(unsigned int nr_queues, const int cpu)
>>>> +static int cpu_to_queue_index(struct blk_mq_queue_map *qmap,
>>>> +			      unsigned int nr_queues, const int cpu)
>>>>  {
>>>> -	return cpu % nr_queues;
>>>> +	return qmap->queue_offset + (cpu % nr_queues);
>>>>  }
>>>>
>>>> [ ... ]
>>>>  
>>>> --- a/include/linux/blk-mq.h
>>>> +++ b/include/linux/blk-mq.h
>>>> @@ -78,10 +78,11 @@ struct blk_mq_hw_ctx {
>>>>  struct blk_mq_queue_map {
>>>>  	unsigned int *mq_map;
>>>>  	unsigned int nr_queues;
>>>> +	unsigned int queue_offset;
>>>>  };
>>>
>>> I think it's unfortunate that the blk-mq core uses the .queue_offset member but
>>> that mapping functions in block drivers are responsible for setting that member.
>>> Since the block driver mapping functions have to set blk_mq_queue_map.nr_queues,
>>> how about adding a loop in blk_mq_update_queue_map() that derives .queue_offset
>>> from .nr_queues from previous array entries?
>>
>> It's not a simple increment, so the driver has to be the one setting it. If
>> we end up sharing queues, for instance, then the driver will need to set
>> it to the start offset of that set. If you go two patches forward you
>> can see that exact construct.
>>
>> IOW, it's the driver that controls the offset, not the core.
> 
> If sharing of hardware queues between hardware queue types is supported,
> what should hctx->type be set to? Additionally, patch 5 adds code that uses
> hctx->type as an array index. How can that code work if a single hardware
> queue can be shared by multiple hardware queue types?

hctx->type will be set to the value of the first type. This is all driver
private, blk-mq could not care less what the value of the type means.

As to the other question, it works just fine since that is the queue
that is being accessed. There's no confusion there. I think you're
misunderstanding how it's seutp. To use nvme as the example, type 0
would be reads, 1 writes, and 2 pollable queues. If reads and writes
share the same set of hardware queues, then type 1 simply doesn't
exist in terms of ->flags_to_type() return value. This is purely
driven by the driver. That hook is the only decider of where something
will go. If we share hctx sets, we share the same hardware queue as
well. There is just the one set for that case.

-- 
Jens Axboe

