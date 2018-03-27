Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbeC0PjO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:39:14 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:35024 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752590AbeC0PjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:39:10 -0400
X-IronPort-AV: E=Sophos;i="5.48,367,1517846400";
   d="scan'208";a="74483667"
Subject: Re: linux-next: build failure after merge of the device-mapper tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Alasdair G Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Denis Semakin <d.semakin@omprussia.ru>
References: <20180327133923.53b8954d@canb.auug.org.au>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <9c4b1f71-157b-ffc9-a245-b1a967cc8bac@wdc.com>
Date: Tue, 27 Mar 2018 08:39:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327133923.53b8954d@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/18 19:39, Stephen Rothwell wrote:
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index d5db9df7ea4b..0589a4da12bb 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1896,7 +1896,7 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
>   		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
>   
>   	if (dm_table_supports_secure_erase(t))
> -		queue_flag_set_unlocked(QUEUE_FLAG_SECERASE, q);
> +		blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
>   
>   	if (dm_table_supports_flush(t, (1UL << QUEUE_FLAG_WC))) {
>   		wc = true;
> 

The above patch looks fine to me. Thank you Stephen for having resolved 
this merge conflict.

Bart.
