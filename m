Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2D5C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1772C20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YraYmUGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1772C20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeKASBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:01:00 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36079 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeKASBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:01:00 -0400
Received: by mail-oi1-f196.google.com with SMTP id r127-v6so14270860oie.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 01:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bDskjtg1LduLuY8TgoQ2Ud64XRZNf0fpht8IrEsy8HY=;
        b=YraYmUGbVnz0dxxijk/pZoWUdsWKdoX4Mx+RcqLAw52JYqjGOtGda2AMVAEjJZL3HN
         u7uDDlwm3jX5UXCY0oz9RjnDj+diFAnEBj8G3oLd44buZK5uR14hyn6qtoxqFR0V1kkM
         ZZ/B6KNCb/ZQts/mFIwgX69HgyOevFrklFdKkvQJhm4SOmnFgZQXTM0PTZ33kS0JCQ0J
         klQn0rQKq8WolzKQLKrAltdEAQYo66wfpjWCndY71T8ZyoP0EZEX2NDLpMFfetmh2Qe8
         ueJpN8XqoMjPBIwar9N9CiX/aNsqNMRnGJcM+upCr0TIMMKBw30c40xpkYw+eKaUwv5R
         /bXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bDskjtg1LduLuY8TgoQ2Ud64XRZNf0fpht8IrEsy8HY=;
        b=jkkh5S0PTIGasabTTH1wTRVnjLmsshb2k5BfhANmBpJUr+hvJ/NuVWBHt0jChwhTqK
         E/HMVNyIe/3rmRtzgLn92ubzcPwBoOGQHR4ydaVDeIW7osOQeydhGRHSmSc7jYqjg0Bu
         6wdUlJNVAmTUGpauWFH5OM/pzP9iRydVwFgZa0lR+z2+NLupNXbahoRqnFbA0//V8Vlo
         nAdy3RkHTfG5iEPUPWsI62G08H3xqj1/pHgiYU+YmJ5arrjuzs9CFAAx+r8QFpF9POrV
         BfmJHTkGnPufY9Hz1GwK0ZOcEeYL3U9By1x5mt2DjTHIV1AGWl/nhriziqr/OEQbkLVO
         WBJw==
X-Gm-Message-State: AGRZ1gJMw9ypmN6YN4u7ITf//zixTpoYY9r1BuovssxYqHim5kAN9Erc
        /rIV2XaqRxKxnU/UmzP+Hj3EAf4f
X-Google-Smtp-Source: AJdET5d2ecvQLK7T+QhI4PUwYHseJ+7GRhc5/h07X4NBNMMgUlh7KWIEyOeV6i2dkp2cgIYs1c2Dig==
X-Received: by 2002:aca:c1d7:: with SMTP id r206-v6mr4025941oif.44.1541062734578;
        Thu, 01 Nov 2018 01:58:54 -0700 (PDT)
Received: from JosephdeMacBook-Pro.local ([47.89.83.53])
        by smtp.gmail.com with ESMTPSA id j33sm643985ota.32.2018.11.01.01.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 01:58:53 -0700 (PDT)
Subject: Re: [Ocfs2-devel] [PATCH V3] ocfs2: fix dead lock caused by
 ocfs2_defrag_extent
To:     Larry Chen <lchen@suse.com>, mark@fasheh.com, jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
References: <20181101071422.14470-1-lchen@suse.com>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <c07c65cb-8492-d866-6a1f-ffa64b293ea0@gmail.com>
Date:   Thu, 1 Nov 2018 16:58:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181101071422.14470-1-lchen@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry,

On 18/11/1 15:14, Larry Chen wrote:
> ocfs2_defrag_extent may fall into deadlock.
> 
> ocfs2_ioctl_move_extents
>     ocfs2_ioctl_move_extents
>       ocfs2_move_extents
>         ocfs2_defrag_extent
>           ocfs2_lock_allocators_move_extents
> 
>             ocfs2_reserve_clusters
>               inode_lock GLOBAL_BITMAP_SYSTEM_INODE
> 
> 	  __ocfs2_flush_truncate_log
>               inode_lock GLOBAL_BITMAP_SYSTEM_INODE
> 
> As backtrace shows above, ocfs2_reserve_clusters() will call inode_lock
> against the global bitmap if local allocator has not sufficient cluters.
> Once global bitmap could meet the demand, ocfs2_reserve_cluster will
> return success with global bitmap locked.
> 
> After ocfs2_reserve_cluster(), if truncate log is full,
> __ocfs2_flush_truncate_log() will definitely fall into deadlock because it
> needs to inode_lock global bitmap, which has already been locked.
> 
> To fix this bug, we could remove from ocfs2_lock_allocators_move_extents()
> the code which intends to lock global allocator, and put the removed code
> after __ocfs2_flush_truncate_log().
> 
> ocfs2_lock_allocators_move_extents() is referred by 2 places, one is here,
> the other does not need the data allocator context, which means this patch
> does not affect the caller so far.
> 
> Change log:
> 1. Correct the function comment.
> 2. Remove unused argument from ocfs2_lock_meta_allocator_move_extents.
> 
> Signed-off-by: Larry Chen <lchen@suse.com>
> ---
>  fs/ocfs2/move_extents.c | 47 ++++++++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
> index 7eb3b0a6347e..f55f82ca3425 100644
> --- a/fs/ocfs2/move_extents.c
> +++ b/fs/ocfs2/move_extents.c
> @@ -156,18 +156,14 @@ static int __ocfs2_move_extent(handle_t *handle,
>  }
>  
>  /*
> - * lock allocators, and reserving appropriate number of bits for
> - * meta blocks and data clusters.
> - *
> - * in some cases, we don't need to reserve clusters, just let data_ac
> - * be NULL.
> + * lock allocator, and reserve appropriate number of bits for
> + * meta blocks.
>   */
> -static int ocfs2_lock_allocators_move_extents(struct inode *inode,
> +static int ocfs2_lock_meta_allocator_move_extents(struct inode *inode,
>  					struct ocfs2_extent_tree *et,
>  					u32 clusters_to_move,

IMO, here clusters_to_move is only for data_ac, since we change this
function to only handle meta_ac, I'm afraid clusters_to_move related
logic has to been changed correspondingly.

Thanks,
Joseph
>  					u32 extents_to_split,
>  					struct ocfs2_alloc_context **meta_ac,
> -					struct ocfs2_alloc_context **data_ac,
>  					int extra_blocks,
>  					int *credits)
>  {
> @@ -192,13 +188,6 @@ static int ocfs2_lock_allocators_move_extents(struct inode *inode,
>  		goto out;
>  	}
>  
> -	if (data_ac) {
> -		ret = ocfs2_reserve_clusters(osb, clusters_to_move, data_ac);
> -		if (ret) {
> -			mlog_errno(ret);
> -			goto out;
> -		}
> -	}
>  
>  	*credits += ocfs2_calc_extend_credits(osb->sb, et->et_root_el);
>  
> @@ -257,10 +246,10 @@ static int ocfs2_defrag_extent(struct ocfs2_move_extents_context *context,
>  		}
>  	}
>  
> -	ret = ocfs2_lock_allocators_move_extents(inode, &context->et, *len, 1,
> -						 &context->meta_ac,
> -						 &context->data_ac,
> -						 extra_blocks, &credits);
> +	ret = ocfs2_lock_meta_allocator_move_extents(inode, &context->et,
> +						*len, 1,
> +						&context->meta_ac,
> +						extra_blocks, &credits);
>  	if (ret) {
>  		mlog_errno(ret);
>  		goto out;
> @@ -283,6 +272,21 @@ static int ocfs2_defrag_extent(struct ocfs2_move_extents_context *context,
>  		}
>  	}
>  
> +	/*
> +	 * Make sure ocfs2_reserve_cluster is called after
> +	 * __ocfs2_flush_truncate_log, otherwise, dead lock may happen.
> +	 *
> +	 * If ocfs2_reserve_cluster is called
> +	 * before __ocfs2_flush_truncate_log, dead lock on global bitmap
> +	 * may happen.
> +	 *
> +	 */
> +	ret = ocfs2_reserve_clusters(osb, *len, &context->data_ac);
> +	if (ret) {
> +		mlog_errno(ret);
> +		goto out_unlock_mutex;
> +	}
> +
>  	handle = ocfs2_start_trans(osb, credits);
>  	if (IS_ERR(handle)) {
>  		ret = PTR_ERR(handle);
> @@ -600,9 +604,10 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
>  		}
>  	}
>  
> -	ret = ocfs2_lock_allocators_move_extents(inode, &context->et, len, 1,
> -						 &context->meta_ac,
> -						 NULL, extra_blocks, &credits);
> +	ret = ocfs2_lock_meta_allocator_move_extents(inode, &context->et,
> +						len, 1,
> +						&context->meta_ac,
> +						extra_blocks, &credits);
>  	if (ret) {
>  		mlog_errno(ret);
>  		goto out;
> 
