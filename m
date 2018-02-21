Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964914AbeBURsw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:48:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:36910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937824AbeBURsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:48:47 -0500
Subject: Re: [PATCH] direct-io: Minor cleanups in do_blockdev_direct_IO
To: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1501657852-12603-1-git-send-email-nborisov@suse.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <d5094e88-76ca-4bb2-c2ba-ec9b56ed9b73@suse.com>
Date: Wed, 21 Feb 2018 19:48:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1501657852-12603-1-git-send-email-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On  2.08.2017 10:10, Nikolay Borisov wrote:
> We already get the block counts and the calculate the end block at the
> beginning of the function. Let's use the local variables for consistency and
> readability. No functional changes
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/direct-io.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 08cf27811e5a..987bc17a5f5e 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -1139,7 +1139,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  	}
>  
>  	/* watch out for a 0 len io from a tricksy fs */
> -	if (iov_iter_rw(iter) == READ && !iov_iter_count(iter))
> +	if (iov_iter_rw(iter) == READ && !count)
>  		return 0;
>  
>  	dio = kmem_cache_alloc(dio_cache, GFP_KERNEL);
> @@ -1248,8 +1248,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  
>  	dio->should_dirty = (iter->type == ITER_IOVEC);
>  	sdio.iter = iter;
> -	sdio.final_block_in_request =
> -		(offset + iov_iter_count(iter)) >> blkbits;
> +	sdio.final_block_in_request = end >> blkbits;
>  
>  	/*
>  	 * In case of non-aligned buffers, we may need 2 more
> 


Ping on that forgotten one :)
