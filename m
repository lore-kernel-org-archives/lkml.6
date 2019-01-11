Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD2EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456B821783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfAKJIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:08:00 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:50641 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfAKJIA (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 11 Jan 2019 04:08:00 -0500
Received: from linux-fcij.suse (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Fri, 11 Jan 2019 02:07:56 -0700
Subject: Re: [PATCH] drivers/md.c: Make bio_alloc_mddev return
 bio_alloc_bioset
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     shli@kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20181222100845.566772-1-marcos.souza.org@gmail.com>
 <20190111021740.GB1228567@bebop>
From:   Guoqing Jiang <gqjiang@suse.com>
Message-ID: <df34a41a-0818-2251-9316-9a6f0c8d6ace@suse.com>
Date:   Fri, 11 Jan 2019 17:07:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190111021740.GB1228567@bebop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/19 10:17 AM, Marcos Paulo de Souza wrote:
> ping?
>
> On Sat, Dec 22, 2018 at 08:08:45AM -0200, Marcos Paulo de Souza wrote:
>> bio_alloc_bioset return a bio pointer or NULL, so we can avoid storing
>> the returned data into a new variable.
>>
>> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>

Add Jens to cc list, anyway, Acked-by: Guoqing Jiang <gqjiang@suse.com>

Thanks,
Guoqing

>> ---
>>   drivers/md/md.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/md/md.c b/drivers/md/md.c
>> index fc488cb30a94..42e018f014cb 100644
>> --- a/drivers/md/md.c
>> +++ b/drivers/md/md.c
>> @@ -207,15 +207,10 @@ static bool create_on_open = true;
>>   struct bio *bio_alloc_mddev(gfp_t gfp_mask, int nr_iovecs,
>>   			    struct mddev *mddev)
>>   {
>> -	struct bio *b;
>> -
>>   	if (!mddev || !bioset_initialized(&mddev->bio_set))
>>   		return bio_alloc(gfp_mask, nr_iovecs);
>>   
>> -	b = bio_alloc_bioset(gfp_mask, nr_iovecs, &mddev->bio_set);
>> -	if (!b)
>> -		return NULL;
>> -	return b;
>> +	return bio_alloc_bioset(gfp_mask, nr_iovecs, &mddev->bio_set);
>>   }
>>   EXPORT_SYMBOL_GPL(bio_alloc_mddev);
>>   
>> -- 
>> 2.16.4
>>

