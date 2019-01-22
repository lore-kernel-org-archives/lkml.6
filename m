Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7758DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA2C2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfAVKiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:38:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:44152 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbfAVKip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:38:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75EAEAF09;
        Tue, 22 Jan 2019 10:38:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 691AA1E3E1E; Tue, 22 Jan 2019 11:38:43 +0100 (CET)
Date:   Tue, 22 Jan 2019 11:38:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Liu Xiang <liu.xiang6@zte.com.cn>
Cc:     linux-ext4@vger.kernel.org, jack@suse.com,
        linux-kernel@vger.kernel.org, liuxiang_1999@126.com
Subject: Re: [PATCH] ext2: Remove redundant check on s_inode_size
Message-ID: <20190122103843.GC13149@quack2.suse.cz>
References: <1547561443-3411-1-git-send-email-liu.xiang6@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547561443-3411-1-git-send-email-liu.xiang6@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-01-19 22:10:43, Liu Xiang wrote:
> The case of (EXT2_INODE_SIZE(sb) == 0) is included in
> (sbi->s_inode_size < EXT2_GOOD_OLD_INODE_SIZE).
> So there is no need to check again.
> 
> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>

Thanks for the cleanup. I have added it to my tree.

								Honza

> ---
>  fs/ext2/super.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 73b2d52..c71c2e3 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -1024,8 +1024,6 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  	sbi->s_frags_per_group = le32_to_cpu(es->s_frags_per_group);
>  	sbi->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
>  
> -	if (EXT2_INODE_SIZE(sb) == 0)
> -		goto cantfind_ext2;
>  	sbi->s_inodes_per_block = sb->s_blocksize / EXT2_INODE_SIZE(sb);
>  	if (sbi->s_inodes_per_block == 0 || sbi->s_inodes_per_group == 0)
>  		goto cantfind_ext2;
> -- 
> 1.9.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
