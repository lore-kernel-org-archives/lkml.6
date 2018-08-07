Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9594C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8187821885
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8187821885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390090AbeHGSLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:11:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:44542 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388481AbeHGSLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:11:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82B71AE78;
        Tue,  7 Aug 2018 15:56:39 +0000 (UTC)
Subject: Re: [PATCH 2/4] xen/blkfront: cleanup stale persistent grants
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, konrad.wilk@oracle.com,
        axboe@kernel.dk, boris.ostrovsky@oracle.com
References: <20180806113403.24728-1-jgross@suse.com>
 <20180806113403.24728-4-jgross@suse.com>
 <20180806161638.nmjamflckekeuyzb@mac>
 <e28d3e77-2c6b-fc30-37e6-646ee1cfbdab@suse.com>
 <20180807141404.lzsqtdd2seqgwtgx@mac>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bba40203-ff97-aba6-cbb6-d3e57387778a@suse.com>
Date:   Tue, 7 Aug 2018 17:56:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180807141404.lzsqtdd2seqgwtgx@mac>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/18 16:14, Roger Pau Monné wrote:
> On Tue, Aug 07, 2018 at 08:31:31AM +0200, Juergen Gross wrote:
>> On 06/08/18 18:16, Roger Pau Monné wrote:
>>> On Mon, Aug 06, 2018 at 01:34:01PM +0200, Juergen Gross wrote:
>>>> Add a periodic cleanup function to remove old persistent grants which
>>>> are no longer in use on the backend side. This avoids starvation in
>>>> case there are lots of persistent grants for a device which no longer
>>>> is involved in I/O business.
>>>>
>>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>>> ---
>>>>  drivers/block/xen-blkfront.c | 99 ++++++++++++++++++++++++++++++++++++++++++--
>>>>  1 file changed, 95 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
>>>> index b5cedccb5d7d..19feb8835fc4 100644
>>>> --- a/drivers/block/xen-blkfront.c
>>>> +++ b/drivers/block/xen-blkfront.c
>>>> @@ -46,6 +46,7 @@
>>>>  #include <linux/scatterlist.h>
>>>>  #include <linux/bitmap.h>
>>>>  #include <linux/list.h>
>>>> +#include <linux/workqueue.h>
>>>>  
>>>>  #include <xen/xen.h>
>>>>  #include <xen/xenbus.h>
>>>> @@ -121,6 +122,9 @@ static inline struct blkif_req *blkif_req(struct request *rq)
>>>>  
>>>>  static DEFINE_MUTEX(blkfront_mutex);
>>>>  static const struct block_device_operations xlvbd_block_fops;
>>>> +static struct delayed_work blkfront_work;
>>>> +static LIST_HEAD(info_list);
>>>> +static bool blkfront_work_active;
>>>>  
>>>>  /*
>>>>   * Maximum number of segments in indirect requests, the actual value used by
>>>> @@ -216,6 +220,7 @@ struct blkfront_info
>>>>  	/* Save uncomplete reqs and bios for migration. */
>>>>  	struct list_head requests;
>>>>  	struct bio_list bio_list;
>>>> +	struct list_head info_list;
>>>>  };
>>>>  
>>>>  static unsigned int nr_minors;
>>>> @@ -1764,6 +1769,12 @@ static int write_per_ring_nodes(struct xenbus_transaction xbt,
>>>>  	return err;
>>>>  }
>>>>  
>>>> +static void free_info(struct blkfront_info *info)
>>>> +{
>>>> +	list_del(&info->info_list);
>>>> +	kfree(info);
>>>> +}
>>>> +
>>>>  /* Common code used when first setting up, and when resuming. */
>>>>  static int talk_to_blkback(struct xenbus_device *dev,
>>>>  			   struct blkfront_info *info)
>>>> @@ -1885,7 +1896,10 @@ static int talk_to_blkback(struct xenbus_device *dev,
>>>>   destroy_blkring:
>>>>  	blkif_free(info, 0);
>>>>  
>>>> -	kfree(info);
>>>> +	mutex_lock(&blkfront_mutex);
>>>> +	free_info(info);
>>>> +	mutex_unlock(&blkfront_mutex);
>>>> +
>>>>  	dev_set_drvdata(&dev->dev, NULL);
>>>>  
>>>>  	return err;
>>>> @@ -1996,6 +2010,10 @@ static int blkfront_probe(struct xenbus_device *dev,
>>>>  	info->handle = simple_strtoul(strrchr(dev->nodename, '/')+1, NULL, 0);
>>>>  	dev_set_drvdata(&dev->dev, info);
>>>>  
>>>> +	mutex_lock(&blkfront_mutex);
>>>> +	list_add(&info->info_list, &info_list);
>>>> +	mutex_unlock(&blkfront_mutex);
>>>> +
>>>>  	return 0;
>>>>  }
>>>>  
>>>> @@ -2306,6 +2324,15 @@ static void blkfront_gather_backend_features(struct blkfront_info *info)
>>>>  	if (indirect_segments <= BLKIF_MAX_SEGMENTS_PER_REQUEST)
>>>>  		indirect_segments = 0;
>>>>  	info->max_indirect_segments = indirect_segments;
>>>> +
>>>> +	if (info->feature_persistent) {
>>>> +		mutex_lock(&blkfront_mutex);
>>>> +		if (!blkfront_work_active) {
>>>> +			blkfront_work_active = true;
>>>> +			schedule_delayed_work(&blkfront_work, HZ * 10);
>>>
>>> Does it make sense to provide a module parameter to rune the schedule
>>> of the cleanup routine?
>>
>> I don't think this is something anyone would like to tune.
>>
>> In case you think it should be tunable I can add a parameter, of course.
> 
> We can always add it later if required. I'm fine as-is now.
> 
>>>
>>>> +		}
>>>> +		mutex_unlock(&blkfront_mutex);
>>>
>>> Is it really necessary to have the blkfront_work_active boolean? What
>>> happens if you queue the same delayed work more than once?
>>
>> In case there is already work queued later calls of
>> schedule_delayed_work() will be ignored.
>>
>> So yes, I can drop the global boolean (I still need a local flag in
>> blkfront_delay_work() for controlling the need to call
>> schedule_delayed_work() again).
> 
> Can't you just call schedule_delayed_work if info->feature_persistent
> is set, even if that means calling it multiple times if multiple
> blkfront instances are using persistent grants?

I don't like that. With mq we have a high chance for multiple instances
to use persistent grants and a local bool is much cheaper than unneeded
calls of schedule_delayed_work().


Juergen
