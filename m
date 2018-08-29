Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25B2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98651204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98651204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeH2OzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:55:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:38522 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726858AbeH2OzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:55:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ADA96AEB1;
        Wed, 29 Aug 2018 10:58:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7465E1E0AAC; Wed, 29 Aug 2018 12:58:53 +0200 (CEST)
Date:   Wed, 29 Aug 2018 12:58:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Colin King <colin.king@canonical.com>
Cc:     Jan Kara <jack@suse.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: remove unused variables group_start and nr_groups
Message-ID: <20180829105853.GA5959@quack2.suse.cz>
References: <20180829101612.31824-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829101612.31824-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-08-18 11:16:12, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variables group_start and nr_groups are being assigned but are never used
> hence they are redundant and can be removed.
> 
> Cleans up clang warning:
> variable 'group_start' set but not used [-Wunused-but-set-variable]
> variable 'nr_groups' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks. Added to my tree.

								Honza

> ---
>  fs/udf/balloc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
> index fcda0fc97b90..501bc5ffb4ce 100644
> --- a/fs/udf/balloc.c
> +++ b/fs/udf/balloc.c
> @@ -175,8 +175,8 @@ static int udf_bitmap_prealloc_blocks(struct super_block *sb,
>  {
>  	struct udf_sb_info *sbi = UDF_SB(sb);
>  	int alloc_count = 0;
> -	int bit, block, block_group, group_start;
> -	int nr_groups, bitmap_nr;
> +	int bit, block, block_group;
> +	int bitmap_nr;
>  	struct buffer_head *bh;
>  	__u32 part_len;
>  
> @@ -189,10 +189,8 @@ static int udf_bitmap_prealloc_blocks(struct super_block *sb,
>  		block_count = part_len - first_block;
>  
>  	do {
> -		nr_groups = udf_compute_nr_groups(sb, partition);
>  		block = first_block + (sizeof(struct spaceBitmapDesc) << 3);
>  		block_group = block >> (sb->s_blocksize_bits + 3);
> -		group_start = block_group ? 0 : sizeof(struct spaceBitmapDesc);
>  
>  		bitmap_nr = load_block_bitmap(sb, bitmap, block_group);
>  		if (bitmap_nr < 0)
> -- 
> 2.17.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
