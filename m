Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003DDC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A184021A0D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A184021A0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbeHGIrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 04:47:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:56394 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733217AbeHGIrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 04:47:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7C255ACEF;
        Tue,  7 Aug 2018 06:34:44 +0000 (UTC)
Subject: Re: [PATCH 1/4] xen/blkback: don't keep persistent grants too long
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, konrad.wilk@oracle.com,
        axboe@kernel.dk, boris.ostrovsky@oracle.com
References: <20180806113403.24728-1-jgross@suse.com>
 <20180806113403.24728-2-jgross@suse.com>
 <20180806155852.7jvudjpzzq6fdp33@mac>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <efbe9e36-5d56-c3d5-5260-7ffda9d00ab2@suse.com>
Date:   Tue, 7 Aug 2018 08:34:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806155852.7jvudjpzzq6fdp33@mac>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/18 17:58, Roger Pau Monné wrote:
> On Mon, Aug 06, 2018 at 01:33:59PM +0200, Juergen Gross wrote:
>> Persistent grants are allocated until a threshold per ring is being
>> reached. Those grants won't be freed until the ring is being destroyed
>> meaning there will be resources kept busy which might no longer be
>> used.
>>
>> Instead of freeing only persistent grants until the threshold is
>> reached add a timestamp and remove all persistent grants not having
>> been in use for a minute.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>  drivers/block/xen-blkback/blkback.c | 77 +++++++++++++++++++++++--------------
>>  drivers/block/xen-blkback/common.h  |  1 +
>>  2 files changed, 50 insertions(+), 28 deletions(-)
> 
> You should document this new parameter in
> Documentation/ABI/testing/sysfs-driver-xen-blkback.

Yes.

> 
>>
>> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
>> index b55b245e8052..485e3ecab144 100644
>> --- a/drivers/block/xen-blkback/blkback.c
>> +++ b/drivers/block/xen-blkback/blkback.c
>> @@ -84,6 +84,18 @@ MODULE_PARM_DESC(max_persistent_grants,
>>                   "Maximum number of grants to map persistently");
>>  
>>  /*
>> + * How long a persistent grant is allowed to remain allocated without being in
>> + * use. The time is in seconds, 0 means indefinitely long.
>> + */
>> +
>> +unsigned int xen_blkif_pgrant_timeout = 60;
>> +module_param_named(persistent_grant_unused_seconds, xen_blkif_pgrant_timeout,
>> +		   uint, 0644);
>> +MODULE_PARM_DESC(persistent_grant_unused_seconds,
>> +		 "Time in seconds an unused persistent grant is allowed to "
>> +		 "remain allocated. Default is 60, 0 means unlimited.");
>> +
>> +/*
>>   * Maximum number of rings/queues blkback supports, allow as many queues as there
>>   * are CPUs if user has not specified a value.
>>   */
>> @@ -123,6 +135,13 @@ module_param(log_stats, int, 0644);
>>  /* Number of free pages to remove on each call to gnttab_free_pages */
>>  #define NUM_BATCH_FREE_PAGES 10
>>  
>> +static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
>> +{
>> +	return xen_blkif_pgrant_timeout &&
>> +	       (jiffies - persistent_gnt->last_used >=
>> +		HZ * xen_blkif_pgrant_timeout);
>> +}
>> +
>>  static inline int get_free_page(struct xen_blkif_ring *ring, struct page **page)
>>  {
>>  	unsigned long flags;
>> @@ -278,6 +297,7 @@ static void put_persistent_gnt(struct xen_blkif_ring *ring,
>>  {
>>  	if(!test_bit(PERSISTENT_GNT_ACTIVE, persistent_gnt->flags))
>>  		pr_alert_ratelimited("freeing a grant already unused\n");
>> +	persistent_gnt->last_used = jiffies;
>>  	set_bit(PERSISTENT_GNT_WAS_ACTIVE, persistent_gnt->flags);
>>  	clear_bit(PERSISTENT_GNT_ACTIVE, persistent_gnt->flags);
>>  	atomic_dec(&ring->persistent_gnt_in_use);
>> @@ -374,23 +394,23 @@ static void purge_persistent_gnt(struct xen_blkif_ring *ring)
>>  	bool scan_used = false, clean_used = false;
>>  	struct rb_root *root;
>>  
>> -	if (ring->persistent_gnt_c < xen_blkif_max_pgrants ||
>> -	    (ring->persistent_gnt_c == xen_blkif_max_pgrants &&
>> -	    !ring->blkif->vbd.overflow_max_grants)) {
>> -		goto out;
>> -	}
>> -
>>  	if (work_busy(&ring->persistent_purge_work)) {
>>  		pr_alert_ratelimited("Scheduled work from previous purge is still busy, cannot purge list\n");
>>  		goto out;
>>  	}
>>  
>> -	num_clean = (xen_blkif_max_pgrants / 100) * LRU_PERCENT_CLEAN;
>> -	num_clean = ring->persistent_gnt_c - xen_blkif_max_pgrants + num_clean;
>> -	num_clean = min(ring->persistent_gnt_c, num_clean);
>> -	if ((num_clean == 0) ||
>> -	    (num_clean > (ring->persistent_gnt_c - atomic_read(&ring->persistent_gnt_in_use))))
>> -		goto out;
>> +	if (ring->persistent_gnt_c < xen_blkif_max_pgrants ||
>> +	    (ring->persistent_gnt_c == xen_blkif_max_pgrants &&
>> +	    !ring->blkif->vbd.overflow_max_grants)) {
>> +		num_clean = 0;
>> +	} else {
>> +		num_clean = (xen_blkif_max_pgrants / 100) * LRU_PERCENT_CLEAN;
>> +		num_clean = ring->persistent_gnt_c - xen_blkif_max_pgrants +
>> +			    num_clean;
>> +		num_clean = min(ring->persistent_gnt_c, num_clean);
>> +		pr_debug("Going to purge at least %u persistent grants\n",
>> +			 num_clean);
>> +	}
>>  
>>  	/*
>>  	 * At this point, we can assure that there will be no calls
>> @@ -401,9 +421,7 @@ static void purge_persistent_gnt(struct xen_blkif_ring *ring)
>>           * number of grants.
>>  	 */
>>  
>> -	total = num_clean;
>> -
>> -	pr_debug("Going to purge %u persistent grants\n", num_clean);
>> +	total = 0;
>>  
>>  	BUG_ON(!list_empty(&ring->persistent_purge_list));
>>  	root = &ring->persistent_gnts;
>> @@ -419,39 +437,42 @@ static void purge_persistent_gnt(struct xen_blkif_ring *ring)
>>  
>>  		if (test_bit(PERSISTENT_GNT_ACTIVE, persistent_gnt->flags))
>>  			continue;
>> -		if (!scan_used &&
>> +		if (!scan_used && !persistent_gnt_timeout(persistent_gnt) &&
>>  		    (test_bit(PERSISTENT_GNT_WAS_ACTIVE, persistent_gnt->flags)))
> 
> If you store the jiffies of the time when the grant was last used it
> seems like we could get rid of the PERSISTENT_GNT_WAS_ACTIVE flag and
> instead use the per-grant jiffies and the jiffies from the last scan
> in order to decide which grants to remove?

True. This might make the control flow a little bit easier to
understand.


Juergen
