Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2701886-1523331173-2-7603399443030358069
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='windows-1252'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523331172; b=UtuB7YWM/dtJ+BApsdt1rqnD7TUdxQOZMiaoGSBfv2na8idhjq
    ObDFwVGJocTVCgmdZ1bofStCSd3m8SSycapYOtvNRdqKSqSgzw1zPlBGR80K2r28
    kMU33lyahZ6G8w/PQOly4gZ1FDVlc/uEb9tLnlRHYGSkYwdjn/UU8k3C+0ttMgMK
    aHWkSddieI5LzA/nj+ZD0ooY+TNvkNuxeERioQYLReFDicD5CeJZxf52yYgon5YD
    GVOhRwE0cY9XM8x17jlMDVqpcniwG6r6ipju7I91P5yxb4EVt6Me9oY++S11DbaZ
    0fyBq+I5JZMQbCH+VYYR3I04YC6P/W4GGlFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523331172;
    bh=9IXU64HIBMVSiT1k0SrAFKT7TKgdGE0bKyUaOery2+E=; b=ppKUcGTlTWkj
    btH3sVA5Iunx7pbNSDPB0qXgeCIuDT2wPiKfP98y/H2xInv6J2mbtRxqDVkDzpjD
    Yb/7uXsPYaDkCUfbTpPkQ0Bd1eUbm28hHw6pcjlfHYB3YyW/vEr3IPgOptEqVIOc
    jTOmIZ99aomxedeWBIpSseq6EPLbk0mG8qI94EcU7t7YxJ54hTdPB3FoGIp2F0lQ
    vqMuLHhHrxPiJE2SBosO4AYyXs5MUmgmYWfTVr4EZc88Xuzzo3zu3YuBUr/4MZA4
    xT3SHig2CTk1yWxvtL5NNh/wLrdYEWVWyGzaTikhUWAAHzf/9EwsY+E8/ie3JH7F
    KAl/RApWaA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJTbzhwuM/PABnMN3XXte6a/xi0Od50VPeHrv/vr9ajfkAdF7y1wQBr9MEJHWX/Z4VQAyfeRJ3lj94VpTcu1ZOQ1ETkRYKG7akKvPSoJhAxvs+mbmz1A
    kes5aI5eTovQ4SrumCh5zOYASYoJZUIItWT+d+QDk/ClgNp8TG/X8hf1Ih5D5KqsB2D7DtUpbRXRvm7DgCJ9oV2N7gVcN+QWBGo14JRucwzJDakUaBnsd2M9
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=XbGvyVyP7asA:10 a=N659UExz7-8A:10
    a=Kd1tUaAdevIA:10 a=i0EeH86SAAAA:8 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8
    a=2mO8I7_GvY_P-xUehrsA:9 a=T91K6tGh03UjAGYm:21 a=NSLshnKQYngmXurO:21
    a=pILNOxqGKmIA:10 a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbeDJDct (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 23:32:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751799AbeDJDct (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 9 Apr 2018 23:32:49 -0400
Subject: Re: [PATCH] f2fs: don't use GFP_ZERO for page caches
To: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC: <stable@vger.kernel.org>
References: <20180409190012.21552-1-jaegeuk@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <fc31dd88-5dbb-1c37-28fe-dfef09cc448c@huawei.com>
Date: Tue, 10 Apr 2018 11:32:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180409190012.21552-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018/4/10 3:00, Jaegeuk Kim wrote:
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

At a glance, should be memset(F2FS_NODE(ipage), 0, PAGE_SIZE);

Sorry about that.

Thanks,

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
> 
