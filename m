Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E4AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8804E2156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EDd9OT8J";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PYEJUQ5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8804E2156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeI0N57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:57:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46638 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbeI0N57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:57:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0129D60B7A; Thu, 27 Sep 2018 07:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538034065;
        bh=CY9ylhcQfbZiIT+bSs0phs4NOWYvA+tjqs6H9fpd9og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EDd9OT8JWDEpNP6+41DlcomqroegPOwYRgyjqcldhTqBacnXa735NpkgGDbgGvOT1
         ZdKnCLoo2DuEy5eMBCoMr06avWNnLGw6bbV+16tyGugfJal3fdZlEpMtIEtJI88Ie5
         7cI5nbPzhqrLNQO4o1m42vs5t7pi+aJqesV3vrMM=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CA3BC609A8;
        Thu, 27 Sep 2018 07:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538034063;
        bh=CY9ylhcQfbZiIT+bSs0phs4NOWYvA+tjqs6H9fpd9og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYEJUQ5EBa3NS5U1utjIwM0OhjOp+WaAlmk34UZcahnUbpnASOUcfTwtacAL8dfcp
         OW4AeG07ZmO2JADCujxwBuvfSY7DllE6yo0X2Ckq68EVyuaf54oMoXu4W2YPkwlG6b
         z0YDJa1beO3w3ck57jC8/voe44SdyDDnX1S4VNWc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA3BC609A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Thu, 27 Sep 2018 13:10:58 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH RESEND v2] Revert: "f2fs: check last page
 index in cached bio to decide submission"
Message-ID: <20180927074058.GK22939@codeaurora.org>
References: <20180926144456.3167-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926144456.3167-1-chao@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 10:44:56PM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> There is one case that we can leave bio in f2fs, result in hanging
> page writeback waiter.
> 
> Thread A				Thread B
> - f2fs_write_cache_pages
>  - f2fs_submit_page_write
>  page #0 cached in bio #0 of cold log
>  - f2fs_submit_page_write
>  page #1 cached in bio #1 of warm log
> 					- f2fs_write_cache_pages
> 					 - f2fs_submit_page_write
> 					 bio is full, submit bio #1 contain page #1
>  - f2fs_submit_merged_write_cond(, page #1)
>  fail to submit bio #0 due to page #1 is not in any cached bios.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2:
> - rebase to dev-test
>  fs/f2fs/checkpoint.c |  2 +-
>  fs/f2fs/data.c       | 38 +++++++++++++++++++-------------------
>  fs/f2fs/f2fs.h       |  4 ++--
>  fs/f2fs/node.c       | 12 ++++++------
>  fs/f2fs/segment.c    | 11 +++++------
>  5 files changed, 33 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index d624d7983197..2f63b362ce63 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -280,7 +280,7 @@ static int __f2fs_write_meta_page(struct page *page,
>  
>  	if (wbc->for_reclaim)
>  		f2fs_submit_merged_write_cond(sbi, page->mapping->host,
> -						0, page->index, META);
> +							page, 0, META);
>  
>  	unlock_page(page);
>  
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index be69b6ac6870..b03f9d163175 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -322,8 +322,8 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
>  	io->bio = NULL;
>  }
>  
> -static bool __has_merged_page(struct f2fs_bio_info *io,
> -				struct inode *inode, nid_t ino, pgoff_t idx)
> +static bool __has_merged_page(struct f2fs_bio_info *io, struct inode *inode,
> +						struct page *page, nid_t ino)
>  {
>  	struct bio_vec *bvec;
>  	struct page *target;
> @@ -332,7 +332,7 @@ static bool __has_merged_page(struct f2fs_bio_info *io,
>  	if (!io->bio)
>  		return false;
>  
> -	if (!inode && !ino)
> +	if (!inode && !page && !ino)
>  		return true;
>  
>  	bio_for_each_segment_all(bvec, io->bio, i) {
> @@ -342,11 +342,10 @@ static bool __has_merged_page(struct f2fs_bio_info *io,
>  		else
>  			target = fscrypt_control_page(bvec->bv_page);
>  
> -		if (idx != target->index)
> -			continue;
> -
>  		if (inode && inode == target->mapping->host)
>  			return true;
> +		if (page && page == target)
> +			return true;

If both inode and page are passed, then I think it we should check for page first
followed by inode checks. What do you think?

>  		if (ino && ino == ino_of_node(target))
>  			return true;
>  	}
> @@ -355,7 +354,8 @@ static bool __has_merged_page(struct f2fs_bio_info *io,
>  }
>  
>  static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
> -				nid_t ino, pgoff_t idx, enum page_type type)
> +						struct page *page, nid_t ino,
> +						enum page_type type)
>  {
>  	enum page_type btype = PAGE_TYPE_OF_BIO(type);
>  	enum temp_type temp;
> @@ -366,7 +366,7 @@ static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
>  		io = sbi->write_io[btype] + temp;
>  
>  		down_read(&io->io_rwsem);
> -		ret = __has_merged_page(io, inode, ino, idx);
> +		ret = __has_merged_page(io, inode, page, ino);
>  		up_read(&io->io_rwsem);
>  
>  		/* TODO: use HOT temp only for meta pages now. */
> @@ -397,12 +397,12 @@ static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
>  }
>  
>  static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
> -				struct inode *inode, nid_t ino, pgoff_t idx,
> -				enum page_type type, bool force)
> +				struct inode *inode, struct page *page,
> +				nid_t ino, enum page_type type, bool force)
>  {
>  	enum temp_type temp;
>  
> -	if (!force && !has_merged_page(sbi, inode, ino, idx, type))
> +	if (!force && !has_merged_page(sbi, inode, page, ino, type))
>  		return;
>  
>  	for (temp = HOT; temp < NR_TEMP_TYPE; temp++) {
> @@ -421,10 +421,10 @@ void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type)
>  }
>  
>  void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
> -				struct inode *inode, nid_t ino, pgoff_t idx,
> -				enum page_type type)
> +				struct inode *inode, struct page *page,
> +				nid_t ino, enum page_type type)
>  {
> -	__submit_merged_write_cond(sbi, inode, ino, idx, type, false);
> +	__submit_merged_write_cond(sbi, inode, page, ino, type, false);
>  }
>  
>  void f2fs_flush_merged_writes(struct f2fs_sb_info *sbi)
> @@ -1962,7 +1962,7 @@ static int __write_data_page(struct page *page, bool *submitted,
>  		ClearPageUptodate(page);
>  
>  	if (wbc->for_reclaim) {
> -		f2fs_submit_merged_write_cond(sbi, inode, 0, page->index, DATA);
> +		f2fs_submit_merged_write_cond(sbi, inode, page, 0, DATA);
>  		clear_inode_flag(inode, FI_HOT_DATA);
>  		f2fs_remove_dirty_inode(inode);
>  		submitted = NULL;
> @@ -2020,10 +2020,10 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  	pgoff_t index;
>  	pgoff_t end;		/* Inclusive */
>  	pgoff_t done_index;
> -	pgoff_t last_idx = ULONG_MAX;
>  	int cycled;
>  	int range_whole = 0;
>  	int tag;
> +	int nwritten = 0;
>  
>  	pagevec_init(&pvec);
>  
> @@ -2126,7 +2126,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  				done = 1;
>  				break;
>  			} else if (submitted) {
> -				last_idx = page->index;
> +				nwritten++;
>  			}
>  
>  			if (--wbc->nr_to_write <= 0 &&
> @@ -2148,9 +2148,9 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
>  		mapping->writeback_index = done_index;
>  
> -	if (last_idx != ULONG_MAX)
> +	if (nwritten)
>  		f2fs_submit_merged_write_cond(F2FS_M_SB(mapping), mapping->host,
> -						0, last_idx, DATA);
> +								NULL, 0, DATA);
>  
>  	return ret;
>  }
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index dc9306e87a51..464545e40729 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3049,8 +3049,8 @@ int f2fs_init_post_read_processing(void);
>  void f2fs_destroy_post_read_processing(void);
>  void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type);
>  void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
> -				struct inode *inode, nid_t ino, pgoff_t idx,
> -				enum page_type type);
> +				struct inode *inode, struct page *page,
> +				nid_t ino, enum page_type type);
>  void f2fs_flush_merged_writes(struct f2fs_sb_info *sbi);
>  int f2fs_submit_page_bio(struct f2fs_io_info *fio);
>  void f2fs_submit_page_write(struct f2fs_io_info *fio);
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index ea151e07790f..c47ca807e245 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1561,8 +1561,8 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>  	up_read(&sbi->node_write);
>  
>  	if (wbc->for_reclaim) {
> -		f2fs_submit_merged_write_cond(sbi, page->mapping->host, 0,
> -						page->index, NODE);
> +		f2fs_submit_merged_write_cond(sbi, page->mapping->host,
> +						page, 0, NODE);
>  		submitted = NULL;
>  	}
>  
> @@ -1634,13 +1634,13 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>  			unsigned int *seq_id)
>  {
>  	pgoff_t index;
> -	pgoff_t last_idx = ULONG_MAX;
>  	struct pagevec pvec;
>  	int ret = 0;
>  	struct page *last_page = NULL;
>  	bool marked = false;
>  	nid_t ino = inode->i_ino;
>  	int nr_pages;
> +	int nwritten = 0;
>  
>  	if (atomic) {
>  		last_page = last_fsync_dnode(sbi, ino);
> @@ -1718,7 +1718,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>  				f2fs_put_page(last_page, 0);
>  				break;
>  			} else if (submitted) {
> -				last_idx = page->index;
> +				nwritten++;
>  			}
>  
>  			if (page == last_page) {
> @@ -1744,8 +1744,8 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>  		goto retry;
>  	}
>  out:
> -	if (last_idx != ULONG_MAX)
> -		f2fs_submit_merged_write_cond(sbi, NULL, ino, last_idx, NODE);
> +	if (nwritten)
> +		f2fs_submit_merged_write_cond(sbi, NULL, NULL, ino, NODE);
>  	return ret ? -EIO: 0;
>  }
>  
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 97a4fae75651..965ef524e2a2 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -371,7 +371,7 @@ static int __f2fs_commit_inmem_pages(struct inode *inode)
>  		.io_type = FS_DATA_IO,
>  	};
>  	struct list_head revoke_list;
> -	pgoff_t last_idx = ULONG_MAX;
> +	bool submit_bio = false;
>  	int err = 0;
>  
>  	INIT_LIST_HEAD(&revoke_list);
> @@ -406,14 +406,14 @@ static int __f2fs_commit_inmem_pages(struct inode *inode)
>  			}
>  			/* record old blkaddr for revoking */
>  			cur->old_addr = fio.old_blkaddr;
> -			last_idx = page->index;
> +			submit_bio = true;
>  		}
>  		unlock_page(page);
>  		list_move_tail(&cur->list, &revoke_list);
>  	}
>  
> -	if (last_idx != ULONG_MAX)
> -		f2fs_submit_merged_write_cond(sbi, inode, 0, last_idx, DATA);
> +	if (submit_bio)
> +		f2fs_submit_merged_write_cond(sbi, inode, NULL, 0, DATA);
>  
>  	if (err) {
>  		/*
> @@ -3179,8 +3179,7 @@ void f2fs_wait_on_page_writeback(struct page *page,
>  	if (PageWriteback(page)) {
>  		struct f2fs_sb_info *sbi = F2FS_P_SB(page);
>  
> -		f2fs_submit_merged_write_cond(sbi, page->mapping->host,
> -						0, page->index, type);
> +		f2fs_submit_merged_write_cond(sbi, NULL, page, 0, type);
>  		if (ordered)
>  			wait_on_page_writeback(page);
>  		else
> -- 
> 2.18.0
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
