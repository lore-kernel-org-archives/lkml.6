Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1764040-1523300630-2-6279159920501977020
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523300629; b=NiDVi8GVrq98rlibpeavvbrQzh8+N9/7VOWser+wrpnqqJzQX4
    4b5ANmg0LdZ5eNNKhTQJEjQaDW2qzH32QkF71LIs4XShgCfuJK+wjfSsb3kN0oGX
    K8ZLtNeYxE/JV4s6eo9DaGWcgEhzEg20epJa7RMUxHlZXBajrDcMXftCc7rKjJai
    yvyyXuZT8AhJwhYdwK7pOd1e4e0kzqqySg5+Py529qzZqwuAi14xnvQ9BySPPLrw
    +B8fMdoMBCZkTXsqt5o8hkDpBZ2chbAM7QkPx+1avgv/rgWkj3mSgDBdf/GC24DW
    t7vzbdb1F18cnsCcVR+MZNDXftxKFgvbaTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523300629; bh=K8Sw1tetvPsE2BMD2VGn8DPyMln+3D
    KSsLDJlj/CnQc=; b=v7oMbBTHJHMYFI8SJV2wZc2nK16JlOQ9PXw07nBPtXhdCF
    Dmmy1C/lDzCdPsOLrGTef3HbrK2hFOM4sR1uxtJjZ0cqIv8IUpeamBLL/m41Ls5t
    K5tX5E7bhJrTjwFV5zGYoeQKRZ+1t4LisrI1n0mNh8TABeYTsuzN/4WiBxwMBj9Q
    suq/8+AdZwDyydX1uytrO5M2514bI/8nXSy0pU8lLN46+hQMVER5vw6dN6l2CTAw
    XNNTaiysnC6qwvz3kxqA/GHzXayU1pjvsoYf5UnorzDCDsAmygC7a1h1zLg7STXf
    bqZHOa+7Xdo54YPZ6FmWO/Gz4aVHDyGtLqLoNbHQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHtUGFA8EYX+IpzUDRm1WllNCeBlXcclNyCcp+o3nbaHte53dtA4LYYHzsWrdw8qW/AjBGzLymQKC/k11DW7Uaq/oPk032VuNvRS74TrP537PN05/Wsw
    qHeMNQ2ppVTx45KTf8joOjQM+Yk4v0497IfD9yr78DopxADtQVp7S3eXhmdA7GJ9hhIxYAwSAicTxPRELivFAUx/HtBJKWjmLGNuO6FbBOTOjIXpcn8Ymwu/
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=i0EeH86SAAAA:8 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=2mO8I7_GvY_P-xUehrsA:9
    a=cMhCALYKa6D0n4qB:21 a=WvAYZXLmZ3M2ye4o:21 a=CjuIK1q_8ugA:10
    a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753526AbeDITDr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 15:03:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753480AbeDITDq (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 9 Apr 2018 15:03:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A6D20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
Date: Mon, 9 Apr 2018 12:03:45 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc: Chao Yu <yuchao0@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH] f2fs: don't use GFP_ZERO for page caches
Message-ID: <20180409190345.GA21689@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180409190012.21552-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409190012.21552-1-jaegeuk@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Chao,

I have to test this for a while. Meanwhile, could you take a look at this?

On 04/09, Jaegeuk Kim wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> Related to https://lkml.org/lkml/2018/4/8/661
> 
> Sometimes, we need to write meta data to new allocated block address,
> then we will allocate a zeroed page in inner inode's address space, and
> fill partial data in it, and leave other place with zero value which means
> some fields are initial status.
> 
> There are two inner inodes (meta inode and node inode) setting __GFP_ZERO,
> I have just checked them, for both of them, we can avoid using __GFP_ZERO,
> and do initialization by ourselves to avoid unneeded/redundant zeroing
> from mm.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/inode.c    | 4 ++--
>  fs/f2fs/node.c     | 6 ++++--
>  fs/f2fs/node.h     | 7 ++-----
>  fs/f2fs/recovery.c | 3 +--
>  4 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 417c9dcd0269..87535bf63421 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -320,10 +320,10 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
>  make_now:
>  	if (ino == F2FS_NODE_INO(sbi)) {
>  		inode->i_mapping->a_ops = &f2fs_node_aops;
> -		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
> +		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
>  	} else if (ino == F2FS_META_INO(sbi)) {
>  		inode->i_mapping->a_ops = &f2fs_meta_aops;
> -		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
> +		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
>  	} else if (S_ISREG(inode->i_mode)) {
>  		inode->i_op = &f2fs_file_inode_operations;
>  		inode->i_fop = &f2fs_file_operations;
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 9a99243054ba..6fc3311820ec 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1096,7 +1096,8 @@ struct page *new_node_page(struct dnode_of_data *dn, unsigned int ofs)
>  	set_node_addr(sbi, &new_ni, NEW_ADDR, false);
>  
>  	f2fs_wait_on_page_writeback(page, NODE, true);
> -	fill_node_footer(page, dn->nid, dn->inode->i_ino, ofs, true);
> +	memset(F2FS_NODE(page), 0, PAGE_SIZE);
> +	fill_node_footer(page, dn->nid, dn->inode->i_ino, ofs);
>  	set_cold_node(page, S_ISDIR(dn->inode->i_mode));
>  	if (!PageUptodate(page))
>  		SetPageUptodate(page);
> @@ -2311,7 +2312,8 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
>  
>  	if (!PageUptodate(ipage))
>  		SetPageUptodate(ipage);
> -	fill_node_footer(ipage, ino, ino, 0, true);
> +	memset(F2FS_NODE(page), 0, PAGE_SIZE);
> +	fill_node_footer(ipage, ino, ino, 0);
>  	set_cold_node(page, false);
>  
>  	src = F2FS_INODE(page);
> diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> index b95e49e4a928..42cd081114ab 100644
> --- a/fs/f2fs/node.h
> +++ b/fs/f2fs/node.h
> @@ -263,15 +263,12 @@ static inline block_t next_blkaddr_of_node(struct page *node_page)
>  }
>  
>  static inline void fill_node_footer(struct page *page, nid_t nid,
> -				nid_t ino, unsigned int ofs, bool reset)
> +				nid_t ino, unsigned int ofs)
>  {
>  	struct f2fs_node *rn = F2FS_NODE(page);
>  	unsigned int old_flag = 0;
>  
> -	if (reset)
> -		memset(rn, 0, sizeof(*rn));
> -	else
> -		old_flag = le32_to_cpu(rn->footer.flag);
> +	old_flag = le32_to_cpu(rn->footer.flag);
>  
>  	rn->footer.nid = cpu_to_le32(nid);
>  	rn->footer.ino = cpu_to_le32(ino);
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index 1b23d3febe4c..de24f3247aa5 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -540,8 +540,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
>  	}
>  
>  	copy_node_footer(dn.node_page, page);
> -	fill_node_footer(dn.node_page, dn.nid, ni.ino,
> -					ofs_of_node(page), false);
> +	fill_node_footer(dn.node_page, dn.nid, ni.ino, ofs_of_node(page));
>  	set_page_dirty(dn.node_page);
>  err:
>  	f2fs_put_dnode(&dn);
> -- 
> 2.15.0.531.g2ccb3012c9-goog
