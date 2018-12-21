Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A6DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B6E21920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388221AbeLUQDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:03:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387895AbeLUQDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:03:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DFA713ABEF;
        Fri, 21 Dec 2018 16:03:31 +0000 (UTC)
Received: from [10.36.116.27] (ovpn-116-27.ams2.redhat.com [10.36.116.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEF3A69313;
        Fri, 21 Dec 2018 16:03:29 +0000 (UTC)
Subject: Re: [PATCH] mm: Refactor readahead defines in mm.h
To:     Nikolay Borisov <nborisov@suse.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20181221144053.24318-1-nborisov@suse.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <6153943c-6f47-f6ba-e62b-cb2a6c05c59f@redhat.com>
Date:   Fri, 21 Dec 2018 17:03:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181221144053.24318-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 21 Dec 2018 16:03:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.12.18 15:40, Nikolay Borisov wrote:
> All users of VM_MAX_READAHEAD actually convert it to kbytes and then to
> pages. Define the macro explicitly as (SZ_128K / PAGE_SIZE). This
> simplifies the expression in every filesystem. Also rename the macro to
> VM_READAHEAD_PAGES to properly convey its meaning. Finally remove unused
> VM_MIN_READAHEAD
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  block/blk-core.c   | 3 +--
>  fs/9p/vfs_super.c  | 2 +-
>  fs/afs/super.c     | 2 +-
>  fs/btrfs/disk-io.c | 2 +-
>  fs/fuse/inode.c    | 2 +-
>  include/linux/mm.h | 4 ++--
>  6 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index deb56932f8c4..d25c8564a117 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1031,8 +1031,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
>  	if (!q->stats)
>  		goto fail_stats;
>  
> -	q->backing_dev_info->ra_pages =
> -			(VM_MAX_READAHEAD * 1024) / PAGE_SIZE;
> +	q->backing_dev_info->ra_pages = VM_READAHEAD_PAGES;
>  	q->backing_dev_info->capabilities = BDI_CAP_CGROUP_WRITEBACK;
>  	q->backing_dev_info->name = "block";
>  	q->node = node_id;
> diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
> index 48ce50484e80..10d3bd3f534b 100644
> --- a/fs/9p/vfs_super.c
> +++ b/fs/9p/vfs_super.c
> @@ -92,7 +92,7 @@ v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses,
>  		return ret;
>  
>  	if (v9ses->cache)
> -		sb->s_bdi->ra_pages = (VM_MAX_READAHEAD * 1024)/PAGE_SIZE;
> +		sb->s_bdi->ra_pages = VM_READAHEAD_PAGES;
>  
>  	sb->s_flags |= SB_ACTIVE | SB_DIRSYNC;
>  	if (!v9ses->cache)
> diff --git a/fs/afs/super.c b/fs/afs/super.c
> index dcd07fe99871..e684f6769b15 100644
> --- a/fs/afs/super.c
> +++ b/fs/afs/super.c
> @@ -399,7 +399,7 @@ static int afs_fill_super(struct super_block *sb,
>  	ret = super_setup_bdi(sb);
>  	if (ret)
>  		return ret;
> -	sb->s_bdi->ra_pages	= VM_MAX_READAHEAD * 1024 / PAGE_SIZE;
> +	sb->s_bdi->ra_pages	= VM_READAHEAD_PAGES;
>  
>  	/* allocate the root inode and dentry */
>  	if (as->dyn_root) {
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 6d776717d8b3..ee47d8b5b50c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2900,7 +2900,7 @@ int open_ctree(struct super_block *sb,
>  	sb->s_bdi->congested_fn = btrfs_congested_fn;
>  	sb->s_bdi->congested_data = fs_info;
>  	sb->s_bdi->capabilities |= BDI_CAP_CGROUP_WRITEBACK;
> -	sb->s_bdi->ra_pages = VM_MAX_READAHEAD * SZ_1K / PAGE_SIZE;
> +	sb->s_bdi->ra_pages = VM_READAHEAD_PAGES;
>  	sb->s_bdi->ra_pages *= btrfs_super_num_devices(disk_super);
>  	sb->s_bdi->ra_pages = max(sb->s_bdi->ra_pages, SZ_4M / PAGE_SIZE);
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 568abed20eb2..d3eab53a29b7 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1009,7 +1009,7 @@ static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
>  	if (err)
>  		return err;
>  
> -	sb->s_bdi->ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_SIZE;
> +	sb->s_bdi->ra_pages = VM_READAHEAD_PAGES;
>  	/* fuse does it's own writeback accounting */
>  	sb->s_bdi->capabilities = BDI_CAP_NO_ACCT_WB | BDI_CAP_STRICTLIMIT;
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5411de93a363..1579082af177 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -26,6 +26,7 @@
>  #include <linux/page_ref.h>
>  #include <linux/memremap.h>
>  #include <linux/overflow.h>
> +#include <linux/sizes.h>
>  
>  struct mempolicy;
>  struct anon_vma;
> @@ -2396,8 +2397,7 @@ int __must_check write_one_page(struct page *page);
>  void task_dirty_inc(struct task_struct *tsk);
>  
>  /* readahead.c */
> -#define VM_MAX_READAHEAD	128	/* kbytes */
> -#define VM_MIN_READAHEAD	16	/* kbytes (includes current page) */
> +#define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
>  
>  int force_page_cache_readahead(struct address_space *mapping, struct file *filp,
>  			pgoff_t offset, unsigned long nr_to_read);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
