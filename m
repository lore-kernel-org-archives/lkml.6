Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71215C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F7120873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F7120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933634AbeGIQvs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:51:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:13517 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933180AbeGIQvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:51:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2018 09:51:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,330,1526367600"; 
   d="scan'208";a="69857016"
Received: from precciox-mobl.amr.corp.intel.com (HELO [10.254.107.89]) ([10.254.107.89])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jul 2018 09:51:44 -0700
Subject: Re: [PATCH -mm -v4 03/21] mm, THP, swap: Support PMD swap mapping in
 swap_duplicate()
To:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180622035151.6676-1-ying.huang@intel.com>
 <20180622035151.6676-4-ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
From:   Dave Hansen <dave.hansen@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@linux.intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzShEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gPGRhdmVAc3I3MS5uZXQ+wsF7BBMBAgAlAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAUCTo3k0QIZAQAKCRBoNZUwcMmSsMO2D/421Xg8pimb9mPzM5N7khT0
 2MCnaGssU1T59YPE25kYdx2HntwdO0JA27Wn9xx5zYijOe6B21ufrvsyv42auCO85+oFJWfE
 K2R/IpLle09GDx5tcEmMAHX6KSxpHmGuJmUPibHVbfep2aCh9lKaDqQR07gXXWK5/yU1Dx0r
 VVFRaHTasp9fZ9AmY4K9/BSA3VkQ8v3OrxNty3OdsrmTTzO91YszpdbjjEFZK53zXy6tUD2d
 e1i0kBBS6NLAAsqEtneplz88T/v7MpLmpY30N9gQU3QyRC50jJ7LU9RazMjUQY1WohVsR56d
 ORqFxS8ChhyJs7BI34vQusYHDTp6PnZHUppb9WIzjeWlC7Jc8lSBDlEWodmqQQgp5+6AfhTD
 kDv1a+W5+ncq+Uo63WHRiCPuyt4di4/0zo28RVcjtzlGBZtmz2EIC3vUfmoZbO/Gn6EKbYAn
 rzz3iU/JWV8DwQ+sZSGu0HmvYMt6t5SmqWQo/hyHtA7uF5Wxtu1lCgolSQw4t49ZuOyOnQi5
 f8R3nE7lpVCSF1TT+h8kMvFPv3VG7KunyjHr3sEptYxQs4VRxqeirSuyBv1TyxT+LdTm6j4a
 mulOWf+YtFRAgIYyyN5YOepDEBv4LUM8Tz98lZiNMlFyRMNrsLV6Pv6SxhrMxbT6TNVS5D+6
 UorTLotDZKp5+M7BTQRUY85qARAAsgMW71BIXRgxjYNCYQ3Xs8k3TfAvQRbHccky50h99TUY
 sqdULbsb3KhmY29raw1bgmyM0a4DGS1YKN7qazCDsdQlxIJp9t2YYdBKXVRzPCCsfWe1dK/q
 66UVhRPP8EGZ4CmFYuPTxqGY+dGRInxCeap/xzbKdvmPm01Iw3YFjAE4PQ4hTMr/H76KoDbD
 cq62U50oKC83ca/PRRh2QqEqACvIH4BR7jueAZSPEDnzwxvVgzyeuhwqHY05QRK/wsKuhq7s
 UuYtmN92Fasbxbw2tbVLZfoidklikvZAmotg0dwcFTjSRGEg0Gr3p/xBzJWNavFZZ95Rj7Et
 db0lCt0HDSY5q4GMR+SrFbH+jzUY/ZqfGdZCBqo0cdPPp58krVgtIGR+ja2Mkva6ah94/oQN
 lnCOw3udS+Eb/aRcM6detZr7XOngvxsWolBrhwTQFT9D2NH6ryAuvKd6yyAFt3/e7r+HHtkU
 kOy27D7IpjngqP+b4EumELI/NxPgIqT69PQmo9IZaI/oRaKorYnDaZrMXViqDrFdD37XELwQ
 gmLoSm2VfbOYY7fap/AhPOgOYOSqg3/Nxcapv71yoBzRRxOc4FxmZ65mn+q3rEM27yRztBW9
 AnCKIc66T2i92HqXCw6AgoBJRjBkI3QnEkPgohQkZdAb8o9WGVKpfmZKbYBo4pEAEQEAAcLB
 XwQYAQIACQUCVGPOagIbDAAKCRBoNZUwcMmSsJeCEACCh7P/aaOLKWQxcnw47p4phIVR6pVL
 e4IEdR7Jf7ZL00s3vKSNT+nRqdl1ugJx9Ymsp8kXKMk9GSfmZpuMQB9c6io1qZc6nW/3TtvK
 pNGz7KPPtaDzvKA4S5tfrWPnDr7n15AU5vsIZvgMjU42gkbemkjJwP0B1RkifIK60yQqAAlT
 YZ14P0dIPdIPIlfEPiAWcg5BtLQU4Wg3cNQdpWrCJ1E3m/RIlXy/2Y3YOVVohfSy+4kvvYU3
 lXUdPb04UPw4VWwjcVZPg7cgR7Izion61bGHqVqURgSALt2yvHl7cr68NYoFkzbNsGsye9ft
 M9ozM23JSgMkRylPSXTeh5JIK9pz2+etco3AfLCKtaRVysjvpysukmWMTrx8QnI5Nn5MOlJj
 1Ov4/50JY9pXzgIDVSrgy6LYSMc4vKZ3QfCY7ipLRORyalFDF3j5AGCMRENJjHPD6O7bl3Xo
 4DzMID+8eucbXxKiNEbs21IqBZbbKdY1GkcEGTE7AnkA3Y6YB7I/j9mQ3hCgm5muJuhM/2Fr
 OPsw5tV/LmQ5GXH0JQ/TZXWygyRFyyI2FqNTx4WHqUn3yFj8rwTAU1tluRUYyeLy0ayUlKBH
 ybj0N71vWO936MqP6haFERzuPAIpxj2ezwu0xb1GjTk4ynna6h5GjnKgdfOWoRtoWndMZxbA
 z5cecg==
Message-ID: <92b86ab6-6f51-97b0-337c-b7e98a30b6cb@linux.intel.com>
Date:   Mon, 9 Jul 2018 09:51:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622035151.6676-4-ying.huang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static inline bool thp_swap_supported(void)
> +{
> +	return IS_ENABLED(CONFIG_THP_SWAP);
> +}

This seems like rather useless abstraction.  Why do we need it?

...
> -static inline int swap_duplicate(swp_entry_t swp)
> +static inline int swap_duplicate(swp_entry_t *swp, bool cluster)
>  {
>  	return 0;
>  }

FWIW, I despise true/false function arguments like this.  When I see
this in code:

	swap_duplicate(&entry, false);

I have no idea what false does.  I'd much rather see:

enum do_swap_cluster {
	SWP_DO_CLUSTER,
	SWP_NO_CLUSTER
};

So you see:

	swap_duplicate(&entry, SWP_NO_CLUSTER);

vs.

	swap_duplicate(&entry, SWP_DO_CLUSTER);


> diff --git a/mm/memory.c b/mm/memory.c
> index e9cac1c4fa69..f3900282e3da 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -951,7 +951,7 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  		swp_entry_t entry = pte_to_swp_entry(pte);
>  
>  		if (likely(!non_swap_entry(entry))) {
> -			if (swap_duplicate(entry) < 0)
> +			if (swap_duplicate(&entry, false) < 0)
>  				return entry.val;
>  
>  			/* make sure dst_mm is on swapoff's mmlist. */

I'll also point out that in a multi-hundred-line patch, adding arguments
to a existing function would not be something I'd try to include in the
patch.  I'd break it out separately unless absolutely necessary.

> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index f42b1b0cdc58..48e2c54385ee 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -49,6 +49,9 @@ static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
>  				 unsigned char);
>  static void free_swap_count_continuations(struct swap_info_struct *);
>  static sector_t map_swap_entry(swp_entry_t, struct block_device**);
> +static int add_swap_count_continuation_locked(struct swap_info_struct *si,
> +					      unsigned long offset,
> +					      struct page *page);
>  
>  DEFINE_SPINLOCK(swap_lock);
>  static unsigned int nr_swapfiles;
> @@ -319,6 +322,11 @@ static inline void unlock_cluster_or_swap_info(struct swap_info_struct *si,
>  		spin_unlock(&si->lock);
>  }
>  
> +static inline bool is_cluster_offset(unsigned long offset)
> +{
> +	return !(offset % SWAPFILE_CLUSTER);
> +}
> +
>  static inline bool cluster_list_empty(struct swap_cluster_list *list)
>  {
>  	return cluster_is_null(&list->head);
> @@ -1166,16 +1174,14 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
>  	return NULL;
>  }
>  
> -static unsigned char __swap_entry_free(struct swap_info_struct *p,
> -				       swp_entry_t entry, unsigned char usage)
> +static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
> +					      struct swap_cluster_info *ci,
> +					      unsigned long offset,
> +					      unsigned char usage)
>  {
> -	struct swap_cluster_info *ci;
> -	unsigned long offset = swp_offset(entry);
>  	unsigned char count;
>  	unsigned char has_cache;
>  
> -	ci = lock_cluster_or_swap_info(p, offset);
> -
>  	count = p->swap_map[offset];
>  
>  	has_cache = count & SWAP_HAS_CACHE;
> @@ -1203,6 +1209,17 @@ static unsigned char __swap_entry_free(struct swap_info_struct *p,
>  	usage = count | has_cache;
>  	p->swap_map[offset] = usage ? : SWAP_HAS_CACHE;
>  
> +	return usage;
> +}
> +
> +static unsigned char __swap_entry_free(struct swap_info_struct *p,
> +				       swp_entry_t entry, unsigned char usage)
> +{
> +	struct swap_cluster_info *ci;
> +	unsigned long offset = swp_offset(entry);
> +
> +	ci = lock_cluster_or_swap_info(p, offset);
> +	usage = __swap_entry_free_locked(p, ci, offset, usage);
>  	unlock_cluster_or_swap_info(p, ci);
>  
>  	return usage;
> @@ -3450,32 +3467,12 @@ void si_swapinfo(struct sysinfo *val)
>  	spin_unlock(&swap_lock);
>  }
>  
> -/*
> - * Verify that a swap entry is valid and increment its swap map count.
> - *
> - * Returns error code in following case.
> - * - success -> 0
> - * - swp_entry is invalid -> EINVAL
> - * - swp_entry is migration entry -> EINVAL
> - * - swap-cache reference is requested but there is already one. -> EEXIST
> - * - swap-cache reference is requested but the entry is not used. -> ENOENT
> - * - swap-mapped reference requested but needs continued swap count. -> ENOMEM
> - */
> -static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
> +static int __swap_duplicate_locked(struct swap_info_struct *p,
> +				   unsigned long offset, unsigned char usage)
>  {
> -	struct swap_info_struct *p;
> -	struct swap_cluster_info *ci;
> -	unsigned long offset;
>  	unsigned char count;
>  	unsigned char has_cache;
> -	int err = -EINVAL;
> -
> -	p = get_swap_device(entry);
> -	if (!p)
> -		goto out;
> -
> -	offset = swp_offset(entry);
> -	ci = lock_cluster_or_swap_info(p, offset);
> +	int err = 0;
>  
>  	count = p->swap_map[offset];
>  
> @@ -3485,12 +3482,11 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
>  	 */
>  	if (unlikely(swap_count(count) == SWAP_MAP_BAD)) {
>  		err = -ENOENT;
> -		goto unlock_out;
> +		goto out;
>  	}
>  
>  	has_cache = count & SWAP_HAS_CACHE;
>  	count &= ~SWAP_HAS_CACHE;
> -	err = 0;
>  
>  	if (usage == SWAP_HAS_CACHE) {
>  
> @@ -3517,11 +3513,39 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
>  
>  	p->swap_map[offset] = count | has_cache;
>  
> -unlock_out:
> +out:
> +	return err;
> +}

... and that all looks like refactoring, not actively implementing PMD
swap support.  That's unfortunate.

> +/*
> + * Verify that a swap entry is valid and increment its swap map count.
> + *
> + * Returns error code in following case.
> + * - success -> 0
> + * - swp_entry is invalid -> EINVAL
> + * - swp_entry is migration entry -> EINVAL
> + * - swap-cache reference is requested but there is already one. -> EEXIST
> + * - swap-cache reference is requested but the entry is not used. -> ENOENT
> + * - swap-mapped reference requested but needs continued swap count. -> ENOMEM
> + */
> +static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
> +{
> +	struct swap_info_struct *p;
> +	struct swap_cluster_info *ci;
> +	unsigned long offset;
> +	int err = -EINVAL;
> +
> +	p = get_swap_device(entry);
> +	if (!p)
> +		goto out;

Is this an error, or just for running into something like a migration
entry?  Comments please.

> +	offset = swp_offset(entry);
> +	ci = lock_cluster_or_swap_info(p, offset);
> +	err = __swap_duplicate_locked(p, offset, usage);
>  	unlock_cluster_or_swap_info(p, ci);
> +
> +	put_swap_device(p);
>  out:
> -	if (p)
> -		put_swap_device(p);
>  	return err;
>  }

Not a comment on this patch, but lock_cluster_or_swap_info() is woefully
uncommented.

> @@ -3534,6 +3558,81 @@ void swap_shmem_alloc(swp_entry_t entry)
>  	__swap_duplicate(entry, SWAP_MAP_SHMEM);
>  }
>  
> +#ifdef CONFIG_THP_SWAP
> +static int __swap_duplicate_cluster(swp_entry_t *entry, unsigned char usage)
> +{
> +	struct swap_info_struct *si;
> +	struct swap_cluster_info *ci;
> +	unsigned long offset;
> +	unsigned char *map;
> +	int i, err = 0;

Instead of an #ifdef, is there a reason we can't just do:

	if (!IS_ENABLED(THP_SWAP))
		return 0;

?

> +	si = get_swap_device(*entry);
> +	if (!si) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +	offset = swp_offset(*entry);
> +	ci = lock_cluster(si, offset);

Could you explain a bit why we do lock_cluster() and not
lock_cluster_or_swap_info() here?

> +	if (cluster_is_free(ci)) {
> +		err = -ENOENT;
> +		goto unlock;
> +	}

Needs comments on how this could happen.  We just took the lock, so I
assume this is some kind of race, but can you elaborate?

> +	if (!cluster_is_huge(ci)) {
> +		err = -ENOTDIR;
> +		goto unlock;
> +	}

Yikes!  This function is the core of the new functionality and its
comment count is exactly 0.  There was quite a long patch description,
which will be surely lost to the ages, but nothing in the code that
folks _will_ be looking at for decades to come.

Can we fix that?

> +	VM_BUG_ON(!is_cluster_offset(offset));
> +	VM_BUG_ON(cluster_count(ci) < SWAPFILE_CLUSTER);

So, by this point, we know we are looking at (or supposed to be looking
at) a cluster on the device?

> +	map = si->swap_map + offset;
> +	if (usage == SWAP_HAS_CACHE) {
> +		if (map[0] & SWAP_HAS_CACHE) {
> +			err = -EEXIST;
> +			goto unlock;
> +		}
> +		for (i = 0; i < SWAPFILE_CLUSTER; i++) {
> +			VM_BUG_ON(map[i] & SWAP_HAS_CACHE);
> +			map[i] |= SWAP_HAS_CACHE;
> +		}

So, it's OK to race with the first entry, but after that it's a bug
because the tail pages should agree with the head page's state?

> +	} else {
> +		for (i = 0; i < SWAPFILE_CLUSTER; i++) {
> +retry:
> +			err = __swap_duplicate_locked(si, offset + i, usage);
> +			if (err == -ENOMEM) {
> +				struct page *page;
> +
> +				page = alloc_page(GFP_ATOMIC | __GFP_HIGHMEM);

I noticed that the non-clustering analog of this function takes a GFP
mask.  Why not this one?

> +				err = add_swap_count_continuation_locked(
> +					si, offset + i, page);
> +				if (err) {
> +					*entry = swp_entry(si->type, offset+i);
> +					goto undup;
> +				}
> +				goto retry;
> +			} else if (err)
> +				goto undup;
> +		}
> +		cluster_set_count(ci, cluster_count(ci) + usage);
> +	}
> +unlock:
> +	unlock_cluster(ci);
> +	put_swap_device(si);
> +out:
> +	return err;
> +undup:
> +	for (i--; i >= 0; i--)
> +		__swap_entry_free_locked(
> +			si, ci, offset + i, usage);
> +	goto unlock;
> +}

So, we've basically created a fork of the __swap_duplicate() code for
huge pages, along with a presumably new set of bugs and a second code
path to update.  Was this unavoidable?  Can we unify this any more with
the small pages path?

>  /*
>   * Increase reference count of swap entry by 1.
>   * Returns 0 for success, or -ENOMEM if a swap_count_continuation is required
> @@ -3541,12 +3640,15 @@ void swap_shmem_alloc(swp_entry_t entry)
>   * if __swap_duplicate() fails for another reason (-EINVAL or -ENOENT), which
>   * might occur if a page table entry has got corrupted.
>   */
> -int swap_duplicate(swp_entry_t entry)
> +int swap_duplicate(swp_entry_t *entry, bool cluster)
>  {
>  	int err = 0;
>  
> -	while (!err && __swap_duplicate(entry, 1) == -ENOMEM)
> -		err = add_swap_count_continuation(entry, GFP_ATOMIC);
> +	if (thp_swap_supported() && cluster)
> +		return __swap_duplicate_cluster(entry, 1);
> +
> +	while (!err && __swap_duplicate(*entry, 1) == -ENOMEM)
> +		err = add_swap_count_continuation(*entry, GFP_ATOMIC);
>  	return err;
>  }

Reading this, I wonder whether this has been refactored as much as
possible.  Both add_swap_count_continuation() and
__swap_duplciate_cluster() start off with the same get_swap_device() dance.

> @@ -3558,9 +3660,12 @@ int swap_duplicate(swp_entry_t entry)
>   * -EBUSY means there is a swap cache.
>   * Note: return code is different from swap_duplicate().
>   */
> -int swapcache_prepare(swp_entry_t entry)
> +int swapcache_prepare(swp_entry_t entry, bool cluster)
>  {
> -	return __swap_duplicate(entry, SWAP_HAS_CACHE);
> +	if (thp_swap_supported() && cluster)
> +		return __swap_duplicate_cluster(&entry, SWAP_HAS_CACHE);
> +	else
> +		return __swap_duplicate(entry, SWAP_HAS_CACHE);
>  }
>  
>  struct swap_info_struct *swp_swap_info(swp_entry_t entry)
> @@ -3590,51 +3695,13 @@ pgoff_t __page_file_index(struct page *page)
>  }
>  EXPORT_SYMBOL_GPL(__page_file_index);
>  
> -/*
> - * add_swap_count_continuation - called when a swap count is duplicated
> - * beyond SWAP_MAP_MAX, it allocates a new page and links that to the entry's
> - * page of the original vmalloc'ed swap_map, to hold the continuation count
> - * (for that entry and for its neighbouring PAGE_SIZE swap entries).  Called
> - * again when count is duplicated beyond SWAP_MAP_MAX * SWAP_CONT_MAX, etc.

This closes out with a lot of refactoring noise.  Any chance that can be
isolated into another patch?
