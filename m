Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26E4ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B636208A5
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyYsXcmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B636208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733205AbeGODLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 23:11:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732004AbeGODLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 23:11:40 -0400
Received: from localhost (unknown [104.132.152.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EEE0208A5;
        Sun, 15 Jul 2018 02:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531623025;
        bh=E83lF3tc7BtkhSRKapAxX7bsE31Ynnaq3QiYsgH/MhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oyYsXcmDk/OKLmfVZwVMh3n+HxNgbOYrwHBmMg2bPu3igMCPllGEwhnb0wy6ekC2Y
         2djkwiL7nByscsZV6U2mrAiLb6hh9LEFXZeEbAZAZ+Oh1ZAmQlIAU/4LhReoQetKgR
         LhWOSBF3chVVR7o7MwKom9cif25RD79RpgiSMau0=
Date:   Sun, 15 Jul 2018 11:50:21 +0900
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     youngjun yoo <youngjun.willow@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] fs: f2fs: Insert a space
Message-ID: <20180715025021.GE11571@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180714103852.GA28458@willow72.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180714103852.GA28458@willow72.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Youngjun,

Look like you sent several patches to fix checkpatch error.
Could you please write single patch saying "f2fs: clean up coding style", which
contains all the changes that you want to fix?

Thanks,

On 07/14, youngjun yoo wrote:
> clean up checkpatch error:
> ERROR:
> space required before the open parenthesis (
> space required around that :
> Signed-off-by: willow72 <youngjun.willow@gmail.com>
> ---
>  fs/f2fs/node.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 51388cf..14ed45c 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1225,7 +1225,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
>  		goto out_err;
>  	}
>  page_hit:
> -	if(unlikely(nid != nid_of_node(page))) {
> +	if (unlikely (nid != nid_of_node (page))) {
>  		f2fs_msg(sbi->sb, KERN_WARNING, "inconsistent node block, "
>  			"nid:%lu, node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
>  			nid, nid_of_node(page), ino_of_node(page),
> @@ -1589,7 +1589,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>  out:
>  	if (last_idx != ULONG_MAX)
>  		f2fs_submit_merged_write_cond(sbi, NULL, ino, last_idx, NODE);
> -	return ret ? -EIO: 0;
> +	return ret ? -EIO : 0;
>  }
>  
>  int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
> -- 
> 2.7.4
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
