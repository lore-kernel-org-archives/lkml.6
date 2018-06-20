Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC3BC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FE22083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FE22083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754453AbeFTPwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:52:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:36955 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754406AbeFTPwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:52:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5263EADD1;
        Wed, 20 Jun 2018 15:52:07 +0000 (UTC)
Subject: Re: [PATCH] bcache: stop using the deprecated get_seconds()
To:     Arnd Bergmann <arnd@arndb.de>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     y2038@lists.linaro.org, Jens Axboe <axboe@kernel.dk>,
        Michael Lyle <mlyle@lyle.org>,
        Tang Junhui <tang.junhui@zte.com.cn>,
        Hannes Reinecke <hare@suse.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180620095228.3686471-1-arnd@arndb.de>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=colyli@suse.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5ffd5433-6bb3-71a8-2b33-ceef50ddf6d7@suse.de>
Date:   Wed, 20 Jun 2018 23:51:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620095228.3686471-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/6/20 5:51 PM, Arnd Bergmann wrote:
> bcache uses get_seconds() to read the current system time and store it in
> the superblock as well as in uuid_entry structures that are user visible.
> 
> This changes over from the deprecated function to
> ktime_get_real_seconds(), which returns a 64-bit timestamp as it
> should. Unfortunately, the two structures are still limited to 32 bits,
> so this won't fix any real problems. Let's at least document that
> properly, in case we get an updated format in the future it can be
> fixed. Until then, we still have some time, and checking the tools
> at https://github.com/koverstreet/bcache-tools reveals no access to
> any of them.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi Arnd,

Firstly thanks to your patch, especially the detailed information in
patch log, it helps me to understand the problem more easier.

From the information, it seems the problem is current 32bit time stamp
will be overflow in 2106. So it will be 88 years later, which I have to
say I don't care.

Also for get_seconds() which works well for current code as many other
places call it, I would like to keep it.

But the code comments in bcache.h looks good, if you want to send a
single patch for the code comments for bcache.h, I would like to see it.

Thanks.

Coly Li

> ---
>  drivers/md/bcache/super.c   | 23 +++++++++++++++++------
>  include/uapi/linux/bcache.h |  4 ++--
>  2 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index fa4058e43202..aa9790ee5cb5 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -53,6 +53,17 @@ struct workqueue_struct *bcache_wq;
>  /* limitation of bcache devices number on single system */
>  #define BCACHE_DEVICE_IDX_MAX	((1U << MINORBITS)/BCACHE_MINORS)
>  
> +/*
> + * various timestamp fields in the superblock are unfortunately
> + * limited to 32 bits, which will lead to overflow in year 2106.
> + *
> + * If we ever get a new superblock format, that should be fixed.
> + */
> +static inline u32 bcache_get_realtime32(void)
> +{
> +	return (u32)ktime_get_real_seconds();
> +}
> +
>  /* Superblock */
>  
>  static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
> @@ -181,7 +192,7 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
>  		goto err;
>  	}
>  
> -	sb->last_mount = get_seconds();
> +	sb->last_mount = bcache_get_realtime32();
>  	err = NULL;
>  
>  	get_page(bh->b_page);
> @@ -701,7 +712,7 @@ static void bcache_device_detach(struct bcache_device *d)
>  
>  		SET_UUID_FLASH_ONLY(u, 0);
>  		memcpy(u->uuid, invalid_uuid, 16);
> -		u->invalidated = cpu_to_le32(get_seconds());
> +		u->invalidated = cpu_to_le32(bcache_get_realtime32());
>  		bch_uuid_write(d->c);
>  	}
>  
> @@ -1027,7 +1038,7 @@ void bch_cached_dev_detach(struct cached_dev *dc)
>  int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
>  			  uint8_t *set_uuid)
>  {
> -	uint32_t rtime = cpu_to_le32(get_seconds());
> +	uint32_t rtime = cpu_to_le32(bcache_get_realtime32());
>  	struct uuid_entry *u;
>  	struct cached_dev *exist_dc, *t;
>  
> @@ -1070,7 +1081,7 @@ int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
>  	    (BDEV_STATE(&dc->sb) == BDEV_STATE_STALE ||
>  	     BDEV_STATE(&dc->sb) == BDEV_STATE_NONE)) {
>  		memcpy(u->uuid, invalid_uuid, 16);
> -		u->invalidated = cpu_to_le32(get_seconds());
> +		u->invalidated = cpu_to_le32(bcache_get_realtime32());
>  		u = NULL;
>  	}
>  
> @@ -1390,7 +1401,7 @@ int bch_flash_dev_create(struct cache_set *c, uint64_t size)
>  
>  	get_random_bytes(u->uuid, 16);
>  	memset(u->label, 0, 32);
> -	u->first_reg = u->last_reg = cpu_to_le32(get_seconds());
> +	u->first_reg = u->last_reg = cpu_to_le32(bcache_get_realtime32());
>  
>  	SET_UUID_FLASH_ONLY(u, 1);
>  	u->sectors = size >> 9;
> @@ -1894,7 +1905,7 @@ static void run_cache_set(struct cache_set *c)
>  		goto err;
>  
>  	closure_sync(&cl);
> -	c->sb.last_mount = get_seconds();
> +	c->sb.last_mount = bcache_get_realtime32();
>  	bcache_write_super(c);
>  
>  	list_for_each_entry_safe(dc, t, &uncached_devices, list)
> diff --git a/include/uapi/linux/bcache.h b/include/uapi/linux/bcache.h
> index 821f71a2e48f..8d19e02d752a 100644
> --- a/include/uapi/linux/bcache.h
> +++ b/include/uapi/linux/bcache.h
> @@ -195,7 +195,7 @@ struct cache_sb {
>  	};
>  	};
>  
> -	__u32			last_mount;	/* time_t */
> +	__u32			last_mount;	/* time overflow in y2106 */
>  
>  	__u16			first_bucket;
>  	union {
> @@ -318,7 +318,7 @@ struct uuid_entry {
>  		struct {
>  			__u8	uuid[16];
>  			__u8	label[32];
> -			__u32	first_reg;
> +			__u32	first_reg; /* time overflow in y2106 */
>  			__u32	last_reg;
>  			__u32	invalidated;
>  
> 

