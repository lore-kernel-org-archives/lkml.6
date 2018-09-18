Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A380ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D41A20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="WIHdshdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D41A20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbeISDUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:20:43 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39180 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbeISDUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:20:43 -0400
Received: by mail-yw1-f66.google.com with SMTP id m62-v6so1447439ywd.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 14:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+RP33ZleFYXo3AWcAPF88IVC4dSIdgmH2KQ8JOTa2Y0=;
        b=WIHdshdbLEk2WEmAosffotWn6hk7b4nvmT7Xj/S8HLZOceK5J4ACpsNfAx3UQmjcbj
         z5EvBYpYba5Uq/grCj5ikpWJw6CF2unFgcDJ6dfpoRluOYa59wDdbe0SCS1ACP0Z4mvD
         ls1PY+WP/VAOkWmfmF5hZnTqeoZfBisdSYaZMUz1A+a5ciOw6rPsGO1EXEM5YG1Iazad
         utU10IhC6rvGD4o0404KQ9V1KYAhFy1BRepyS45d4slX76h2+Rf4sSsQRP27xH9ASuYF
         2cJ97Q/q447pxFAY370zYTC+b8N1sDz+r1D3yWUIHqWPeL8jmZ1XoNAohwXk404stcrB
         sl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+RP33ZleFYXo3AWcAPF88IVC4dSIdgmH2KQ8JOTa2Y0=;
        b=H0cPVN05V7UVQct/3ZlUB/QRT08kNWE0Ls9qDBOMOCshh+zJwblrLZhKJsQOSoq1YZ
         4jddnvCov+aTo3WwY7hgzJyohpI1OnuQAShU6+f0ekhQrzAzu4c84C+fodcPN6n/qih6
         nCSZSepRvpy/8uNPkNCjSBUqfnS3gBFWcrK45jOY88WwyCb2wZJdK2NZG/fDYcKge3M2
         lhZpNwkzt8ZWzGpYU0/8DOLfJleimIHiQVIbu4FXdDWHQG7TY2uqNSH/EAsjPlWot1Zv
         Ctr74P8LEgv4S6erzbyRPCrSVouAu5d2jur8G+HvbhaidyLLE/uu1HJVdI4XenbSgcKO
         gD2g==
X-Gm-Message-State: APzg51AbkP7sjLZ8+NSDeBWh00jh8ZuyhChGnhc1qTNP2Bbe+qxuwkGm
        FobcUzwNp5BLxP1qyS1K34FPkSjuWD0=
X-Google-Smtp-Source: ANB0Vda+z4Ju2Znnc8LLhqi5RWPzc/8ChAGwQWJY5zGiYr/iXegVSnhpchQI4i9ueQy2x6p7wxTp2w==
X-Received: by 2002:a81:5fd4:: with SMTP id t203-v6mr9253062ywb.84.1537307169178;
        Tue, 18 Sep 2018 14:46:09 -0700 (PDT)
Received: from t480s.mkb.name (47-49-164-163.static.spbg.sc.charter.com. [47.49.164.163])
        by smtp.gmail.com with ESMTPSA id x184-v6sm4075722ywx.75.2018.09.18.14.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 14:46:08 -0700 (PDT)
Date:   Tue, 18 Sep 2018 17:46:06 -0400
From:   martin@omnibond.com
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        devel@lists.orangefs.org
Subject: Re: [PATCH 17/17] orangefs: implement writepages
Message-ID: <20180918214606.GA28882@t480s.mkb.name>
References: <20180917201054.3530-1-martin@omnibond.com>
 <20180917201054.3530-18-martin@omnibond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917201054.3530-18-martin@omnibond.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 08:10:54PM +0000, Martin Brandenburg wrote:
> Go through pages and look for a consecutive writable region.  After
> finding 128 consecutive writable pages or when finding a non-consecutive
> region, do the write.

128 was chosen arbitrarily.  I tested a number of higher counts, but saw
no appreciable improvement, and let 128 stand.

Mike tells me that there is an improvement when the count is such that
the length of the write would be equal to the maximum length of I/O with
the client-core (on a 4096 page size machine, this is 1024).

When I tested, struct orangefs_writepages was on the stack, and I
couldn't go that high without an overflow.

He asked me, and I don't know the answer, so I repeat it here, whether
"Would changing out the kalloc [really kcalloc] in
orangefs_writepages_work to be based on kmem_cache_alloc pre-allocations
be a good thing?"

I wonder the same thing about the kzalloc in orangefs_writepages.  I will
change struct orangefs_writepages to include the struct bio_vec in
orangefs_writepages_work so we don't have to do two memory allocations.

> 
> Signed-off-by: Martin Brandenburg <martin@omnibond.com>
> ---
>  fs/orangefs/inode.c           | 135 +++++++++++++++++++++++++++++++++-
>  fs/orangefs/orangefs-kernel.h |   1 +
>  fs/orangefs/super.c           |   1 +
>  3 files changed, 135 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> index 178734920e45..34b98d2ed377 100644
> --- a/fs/orangefs/inode.c
> +++ b/fs/orangefs/inode.c
> @@ -15,6 +15,8 @@
>  #include "orangefs-kernel.h"
>  #include "orangefs-bufmap.h"
>  
> +#define ORANGEFS_WRITEPAGES_COUNT 128
> +
>  static int orangefs_writepage_locked(struct page *page,
>      struct writeback_control *wbc)
>  {
> @@ -44,10 +46,10 @@ static int orangefs_writepage_locked(struct page *page,
>  			len = i_size_read(inode);
>  		}
>  	} else {
> -/*		BUG();*/
> +		end_page_writeback(page);
>  		/* It's not private so there's nothing to write, right? */
>  		printk("writepage not private!\n");
> -		end_page_writeback(page);
> +		BUG();
>  		return 0;
>  
>  	}
> @@ -230,6 +232,134 @@ static int orangefs_readpage(struct file *file, struct page *page)
>  	return ret;
>  }
>  
> +struct orangefs_writepages {
> +	loff_t off;
> +	size_t len;
> +	struct page *pages[ORANGEFS_WRITEPAGES_COUNT];
> +	int npages;
> +};
> +
> +static int orangefs_writepages_work(struct orangefs_writepages *ow,
> +    struct writeback_control *wbc)
> +{
> +	struct inode *inode = ow->pages[0]->mapping->host;
> +	struct orangefs_write_request *wr;
> +	struct iov_iter iter;
> +	struct bio_vec *bv;
> +	ssize_t ret;
> +	loff_t off;
> +	int i;
> +
> +	bv = kcalloc(ORANGEFS_WRITEPAGES_COUNT, sizeof(struct bio_vec),
> +	    GFP_KERNEL);
> +	if (!bv)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < ow->npages; i++) {
> +		set_page_writeback(ow->pages[i]);
> +		bv[i].bv_page = ow->pages[i];
> +		/* uh except the last one maybe... */
> +		if (i == ow->npages - 1 && ow->len % PAGE_SIZE)
> +			bv[i].bv_len = ow->len % PAGE_SIZE;
> +		else
> +			bv[i].bv_len = PAGE_SIZE;
> +		bv[i].bv_offset = 0;
> +	}
> +	iov_iter_bvec(&iter, ITER_BVEC | WRITE, bv, ow->npages, ow->len);
> +
> +	off = ow->off;
> +	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, ow->len,
> +	    0, NULL);
> +	if (ret < 0) {
> +		for (i = 0; i < ow->npages; i++) {
> +			SetPageError(ow->pages[i]);
> +			mapping_set_error(ow->pages[i]->mapping, ret);
> +			end_page_writeback(ow->pages[i]);
> +			unlock_page(ow->pages[i]);
> +		}
> +	} else {
> +		for (i = 0; i < ow->npages; i++) {
> +			if (PagePrivate(ow->pages[i])) {
> +				wr = (struct orangefs_write_request *)
> +				    page_private(ow->pages[i]);
> +				ClearPagePrivate(ow->pages[i]);
> +				wr_release(wr);
> +			}
> +			end_page_writeback(ow->pages[i]);
> +			unlock_page(ow->pages[i]);
> +		}
> +	}
> +	kfree(bv);
> +	return ret;
> +}
> +
> +static int orangefs_writepages_callback(struct page *page,
> +    struct writeback_control *wbc, void *data)
> +{
> +	struct orangefs_writepages *ow = data;
> +	struct orangefs_write_request *wr;
> +	int ret;
> +
> +	if (!PagePrivate(page)) {
> +		unlock_page(page);
> +		/* It's not private so there's nothing to write, right? */
> +		printk("writepages_callback not private!\n");
> +		BUG();
> +		return 0;
> +	}
> +	wr = (struct orangefs_write_request *)page_private(page);
> +
> +	if (wr->len != PAGE_SIZE) {
> +		ret = orangefs_writepage_locked(page, wbc);
> +		mapping_set_error(page->mapping, ret);
> +		unlock_page(page);
> +	} else {
> +		ret = -1;
> +		if (ow->npages == 0) {
> +			ow->off = wr->pos;
> +			ow->len = wr->len;
> +			ow->pages[ow->npages++] = page;
> +			ret = 0;
> +		}
> +		if (ow->off + ow->len == wr->pos) {
> +			ow->len += wr->len;
> +			ow->pages[ow->npages++] = page;
> +			ret = 0;
> +		}
> +		if (ret == -1) {
> +			ret = orangefs_writepage_locked(page, wbc);
> +			mapping_set_error(page->mapping, ret);
> +			unlock_page(page);
> +		} else {
> +			if (ow->npages == ORANGEFS_WRITEPAGES_COUNT) {
> +				orangefs_writepages_work(ow, wbc);
> +				memset(ow, 0, sizeof *ow);
> +			}
> +		}
> +	}
> +	return ret;
> +}
> +
> +static int orangefs_writepages(struct address_space *mapping,
> +    struct writeback_control *wbc)
> +{
> +	struct orangefs_writepages *ow;
> +	struct blk_plug plug;
> +	int ret;
> +	ow = kzalloc(sizeof(struct orangefs_writepages), GFP_KERNEL);
> +	if (!ow)
> +		return -ENOMEM;
> +	mutex_lock(&ORANGEFS_SB(mapping->host->i_sb)->writepages_mutex);
> +	blk_start_plug(&plug);
> +	ret = write_cache_pages(mapping, wbc, orangefs_writepages_callback, ow);
> +	if (ow->npages)
> +		ret = orangefs_writepages_work(ow, wbc);
> +	blk_finish_plug(&plug);
> +	mutex_unlock(&ORANGEFS_SB(mapping->host->i_sb)->writepages_mutex);
> +	kfree(ow);
> +	return ret;
> +}
> +
>  static int orangefs_write_begin(struct file *file,
>      struct address_space *mapping, loff_t pos, unsigned len, unsigned flags,
>      struct page **pagep, void **fsdata)
> @@ -325,6 +455,7 @@ static ssize_t orangefs_direct_IO(struct kiocb *iocb,
>  static const struct address_space_operations orangefs_address_operations = {
>  	.writepage = orangefs_writepage,
>  	.readpage = orangefs_readpage,
> +	.writepages = orangefs_writepages,
>  	.set_page_dirty = __set_page_dirty_nobuffers,
>  	.write_begin = orangefs_write_begin,
>  	.write_end = orangefs_write_end,
> diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
> index 256851bab7a5..9e23f97fb5cc 100644
> --- a/fs/orangefs/orangefs-kernel.h
> +++ b/fs/orangefs/orangefs-kernel.h
> @@ -220,6 +220,7 @@ struct orangefs_sb_info_s {
>  	int mount_pending;
>  	int no_list;
>  	struct list_head list;
> +	struct mutex writepages_mutex;
>  };
>  
>  struct orangefs_stats {
> diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
> index 83abe5ec2d11..204e1ac7f228 100644
> --- a/fs/orangefs/super.c
> +++ b/fs/orangefs/super.c
> @@ -467,6 +467,7 @@ static int orangefs_fill_sb(struct super_block *sb,
>  
>  	sb->s_export_op = &orangefs_export_ops;
>  	sb->s_root = root_dentry;
> +	mutex_init(&ORANGEFS_SB(sb)->writepages_mutex);
>  	return 0;
>  }
>  
> -- 
> 2.19.0
> 
