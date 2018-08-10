Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C922EC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63799223D9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63799223D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeHJKKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:10:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:47840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727028AbeHJKKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:10:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7CE31AFBB;
        Fri, 10 Aug 2018 07:41:40 +0000 (UTC)
Subject: Re: [RFC PATCH 02/17] btrfs: Get zone information of zoned block
 devices
To:     Naohiro Aota <naota@elisp.net>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>
References: <20180809180450.5091-1-naota@elisp.net>
 <20180809180450.5091-3-naota@elisp.net>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3672fbf1-e0cc-e27b-f406-7f2dc76ce587@suse.com>
Date:   Fri, 10 Aug 2018 10:41:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180809180450.5091-3-naota@elisp.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On  9.08.2018 21:04, Naohiro Aota wrote:
> If a zoned block device is found, get its zone information (number of zones
> and zone size) using the new helper function btrfs_get_dev_zone().  To
> avoid costly run-time zone reports commands to test the device zones type
> during block allocation, attach the seqzones bitmap to the device structure
> to indicate if a zone is sequential or accept random writes.
> 
> This patch also introduces the helper function btrfs_dev_is_sequential() to
> test if the zone storing a block is a sequential write required zone.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Naohiro Aota <naota@elisp.net>
> ---
>  fs/btrfs/volumes.c | 146 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/volumes.h |  32 ++++++++++
>  2 files changed, 178 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index da86706123ff..35b3a2187653 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -677,6 +677,134 @@ static void btrfs_free_stale_devices(const char *path,
>  	}
>  }
>  
> +static int __btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
> +				 struct blk_zone **zones,
> +				 unsigned int *nr_zones, gfp_t gfp_mask)
> +{
> +	struct blk_zone *z = *zones;
> +	int ret;
> +
> +	if (!z) {
> +		z = kcalloc(*nr_zones, sizeof(struct blk_zone), GFP_KERNEL);
> +		if (!z)
> +			return -ENOMEM;
> +	}
> +
> +	ret = blkdev_report_zones(device->bdev, pos >> 9,
> +				  z, nr_zones, gfp_mask);
> +	if (ret != 0) {
> +		pr_err("BTRFS: Get zone at %llu failed %d\n",
> +		       pos, ret);

For errors please use btrfs_err, you have fs_info instance from the
passed btrfs_device struct.
> +		return ret;
> +	}
> +
> +	*zones = z;
> +
> +	return 0;
> +}
> +
> +static void btrfs_drop_dev_zonetypes(struct btrfs_device *device)

nit: I'd rather have this function named btrfs_destroy_dev_zonetypes but
have not strong preference either ways. It just seems to the wider
convention in the code.

> +{
> +	kfree(device->seq_zones);
> +	kfree(device->empty_zones);
> +	device->seq_zones = NULL;
> +	device->empty_zones = NULL;
> +	device->nr_zones = 0;
> +	device->zone_size = 0;
> +	device->zone_size_shift = 0;
> +}
> +
> +int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
> +		       struct blk_zone *zone, gfp_t gfp_mask)
> +{
> +	unsigned int nr_zones = 1;
> +	int ret;
> +
> +	ret = __btrfs_get_dev_zones(device, pos, &zone, &nr_zones, gfp_mask);
> +	if (ret != 0 || !nr_zones)
> +		return ret ? ret : -EIO;
> +
> +	return 0;
> +}

This helper seems unused, why not just merge it with __btrfs_get_dev_zones?

> +
> +static int btrfs_get_dev_zonetypes(struct btrfs_device *device)
> +{
> +	struct block_device *bdev = device->bdev;
> +	sector_t nr_sectors = bdev->bd_part->nr_sects;
> +	sector_t sector = 0;
> +	struct blk_zone *zones = NULL;
> +	unsigned int i, n = 0, nr_zones;
> +	int ret;
> +
> +	device->zone_size = 0;
> +	device->zone_size_shift = 0;
> +	device->nr_zones = 0;
> +	device->seq_zones = NULL;
> +	device->empty_zones = NULL;
> +
> +	if (!bdev_is_zoned(bdev))
> +		return 0;
> +

Calling this function is already predicated on the above check being
true so this seems a bit redundant. So either leave this check here and
remove it from the 2 call sites (in btrfs_init_new_device and
btrfs_open_one_device) or do the opposite.

> +	device->zone_size = (u64)bdev_zone_sectors(bdev) << 9;
> +	device->zone_size_shift = ilog2(device->zone_size);
> +	device->nr_zones = nr_sectors >> ilog2(bdev_zone_sectors(bdev));
> +	if (nr_sectors & (bdev_zone_sectors(bdev) - 1))
> +		device->nr_zones++;
> +
> +	device->seq_zones = kcalloc(BITS_TO_LONGS(device->nr_zones),
> +				    sizeof(*device->seq_zones), GFP_KERNEL);
> +	if (!device->seq_zones)
> +		return -ENOMEM;
> +
> +	device->empty_zones = kcalloc(BITS_TO_LONGS(device->nr_zones),
> +				      sizeof(*device->empty_zones), GFP_KERNEL);
> +	if (!device->empty_zones)
> +		return -ENOMEM;
> +
> +#define BTRFS_REPORT_NR_ZONES   4096
> +
> +	/* Get zones type */
> +	while (sector < nr_sectors) {
> +		nr_zones = BTRFS_REPORT_NR_ZONES;
> +		ret = __btrfs_get_dev_zones(device, sector << 9,

blkdev_report_zones' (which is called from __btrfs_get_dev_zones) second
argument is a sector number, yet you first convert the sector to a byte
and then do again the opposite shift to prepare the argument for the
function. Just pass straight the sector and if you need the byte pos for
printing the error do the necessary shift in the btrfs_error statement.


Furthermore, wouldn't the code be more obvious if you just factor out
the allocation of the zones buffer from __btrfs_get_dev_zones above this
loop, afterwards __btrfs_get_dev_zones can be open coded as a single
call to blkdev_report_zones and everything will be obvious just from the
body of this loop.

> +					    &zones, &nr_zones, GFP_KERNEL);
> +		if (ret != 0 || !nr_zones) {
> +			if (!ret)
> +				ret = -EIO;
> +			goto out;
> +		}
> +
> +		for (i = 0; i < nr_zones; i++) {
> +			if (zones[i].type == BLK_ZONE_TYPE_SEQWRITE_REQ)
> +				set_bit(n, device->seq_zones);
> +			if (zones[i].cond == BLK_ZONE_COND_EMPTY)
> +				set_bit(n, device->empty_zones);
> +			sector = zones[i].start + zones[i].len;
> +			n++;
> +		}
> +	}
> +
> +	if (n != device->nr_zones) {
> +		pr_err("BTRFS: Inconsistent number of zones (%u / %u)\n",
> +		       n, device->nr_zones);

btrfs_err
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	pr_info("BTRFS: host-%s zoned block device, %u zones of %llu sectors\n",
> +		bdev_zoned_model(bdev) == BLK_ZONED_HM ? "managed" : "aware",
> +		device->nr_zones, device->zone_size >> 9);
> +
btrfs_info

> +out:
> +	kfree(zones);
> +
> +	if (ret)
> +		btrfs_drop_dev_zonetypes(device);
> +
> +	return ret;
> +}
> +
> +
>  static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  			struct btrfs_device *device, fmode_t flags,
>  			void *holder)
> @@ -726,6 +854,13 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>  	device->mode = flags;
>  
> +	/* Get zone type information of zoned block devices */
> +	if (bdev_is_zoned(bdev)) {
> +		ret = btrfs_get_dev_zonetypes(device);
> +		if (ret != 0)
> +			goto error_brelse;
> +	}
> +
>  	fs_devices->open_devices++;
>  	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
>  	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
> @@ -1012,6 +1147,7 @@ static void btrfs_close_bdev(struct btrfs_device *device)
>  	}
>  
>  	blkdev_put(device->bdev, device->mode);
> +	btrfs_drop_dev_zonetypes(device);
>  }
>  
>  static void btrfs_close_one_device(struct btrfs_device *device)
> @@ -2439,6 +2575,15 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	mutex_unlock(&fs_info->chunk_mutex);
>  	mutex_unlock(&fs_devices->device_list_mutex);
>  
> +	/* Get zone type information of zoned block devices */
> +	if (bdev_is_zoned(bdev)) {
> +		ret = btrfs_get_dev_zonetypes(device);
> +		if (ret) {
> +			btrfs_abort_transaction(trans, ret);
> +			goto error_sysfs;
> +		}
> +	}
> +
>  	if (seeding_dev) {
>  		mutex_lock(&fs_info->chunk_mutex);
>  		ret = init_first_rw_device(trans, fs_info);
> @@ -2504,6 +2649,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>  	return ret;
>  
>  error_sysfs:
> +	btrfs_drop_dev_zonetypes(device);
>  	btrfs_sysfs_rm_device_link(fs_devices, device);
>  	mutex_lock(&fs_info->fs_devices->device_list_mutex);
>  	mutex_lock(&fs_info->chunk_mutex);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 23e9285d88de..13d59bff204f 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -61,6 +61,16 @@ struct btrfs_device {
>  
>  	struct block_device *bdev;
>  
> +	/*
> +	 * Number of zones, zone size and types of zones if bdev is a
> +	 * zoned block device.
> +	 */
> +	u64 zone_size;
> +	u8  zone_size_shift;
> +	u32 nr_zones;
> +	unsigned long *seq_zones;
> +	unsigned long *empty_zones;
> +
>  	/* the mode sent to blkdev_get */
>  	fmode_t mode;
>  
> @@ -404,6 +414,8 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
>  			   int mirror_num, int async_submit);
>  int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>  		       fmode_t flags, void *holder);
> +int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
> +		       struct blk_zone *zone, gfp_t gfp_mask);
>  struct btrfs_device *btrfs_scan_one_device(const char *path,
>  					   fmode_t flags, void *holder);
>  int btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
> @@ -466,6 +478,26 @@ int btrfs_finish_chunk_alloc(struct btrfs_trans_handle *trans,
>  			     u64 chunk_offset, u64 chunk_size);
>  int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset);
>  
> +static inline int btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
> +{
> +	unsigned int zno = pos >> device->zone_size_shift;
> +
> +	if (!device->seq_zones)
> +		return 1;
> +
> +	return test_bit(zno, device->seq_zones);
> +}
> +
> +static inline int btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
> +{
> +	unsigned int zno = pos >> device->zone_size_shift;
> +
> +	if (!device->empty_zones)
> +		return 0;
> +
> +	return test_bit(zno, device->empty_zones);
> +}
> +
>  static inline void btrfs_dev_stat_inc(struct btrfs_device *dev,
>  				      int index)
>  {
> 
