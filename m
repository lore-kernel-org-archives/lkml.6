Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375C0C43441
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C141D2075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="rf8JUvIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C141D2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbeJJHC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 03:02:58 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43010 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeJJHC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 03:02:58 -0400
Received: by mail-yb1-f196.google.com with SMTP id w80-v6so1446495ybe.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 16:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sA6q2OjT4kT4VbjK5Dry3SrMDl7vXqh6x2G4XygXMqo=;
        b=rf8JUvISInb+Af1DHJrEDjpECckbjtUWbOdEHD3NeSyAA9Q2yMLOLKARtHUh7Ogbc7
         P6oCD9CvBiFB+6m3Mvsbe2Z5Ut7DZiMQF9k+SpJnOMoo8jqXqSeyPzxlO7ofUVizEkBh
         tXLt1zHB1tsV02JZq7jaeukeK7IIbBghTXDtVi1V/tqteoIo4WKnyiJaMZWZrJnd3zL0
         ujlm2JHWHOUeMyT+NdO9Cj49anDZ/UjlNxFUix9HgXyGv/UpQAnKFHCeHPbIff50xPe7
         At94mHvokKMGAyRZ7H5jPrmdQpJErk8Jc6gouWTEInmgACK5cmKwmcpBl5XwbwwDRx+t
         pg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sA6q2OjT4kT4VbjK5Dry3SrMDl7vXqh6x2G4XygXMqo=;
        b=aJLPQ5a/8J8ztkmAyBBY1xeXAlDen/30zPUJVytmPrli4aTjK5oLzC/R0SSJ9F4pkV
         bER7UZE+qLozckPwqZDpNW4o5koZTMH0owyNHfh1JuTNiHRGpAPA9t1s2Pw8WnowB7kF
         12SXn5f0NtyI9uVYJxpmDfrGswBT75P6cpmTi6GXtF4uYwkMGqt/Yv5RVh6CdAEd3bqP
         QO2TX24JW8YooTMfOkD/EjLfCztdet0gdYfzTIzLzu1ifTTNjf34AB1G/OGmJnDkDZMe
         pgQuoNTRUX2x+yRV4IJnpoG+kynoz66sbiYFxgTSTS+b0gcxiKLuNwNr8BEQ6QxIy0od
         JUiw==
X-Gm-Message-State: ABuFfoi4ABHuV0ltRvAwS0fjWu092k0aR2pRXzwkPJeM9zr2K3Rtbzhl
        /RFairCP9KnNXpsOot8FTd0eTyy0Pd4=
X-Google-Smtp-Source: ACcGV62EI6TUXQHvOG31emiRr9fAGTEVQ1AvX7SyfTJjvm6DenIb+y8HhW0qc0UAFY96Fj87uS6vhA==
X-Received: by 2002:a25:ef0d:: with SMTP id g13-v6mr13591569ybd.165.1539128615585;
        Tue, 09 Oct 2018 16:43:35 -0700 (PDT)
Received: from t480s.mkb.name (47-49-164-163.static.spbg.sc.charter.com. [47.49.164.163])
        by smtp.gmail.com with ESMTPSA id c142-v6sm10175453ywa.81.2018.10.09.16.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 16:43:34 -0700 (PDT)
Date:   Tue, 9 Oct 2018 19:43:32 -0400
From:   martin@omnibond.com
To:     devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hubcap@omnibond.com
Subject: invalidatepage questions (was Re: [PATCH 14/19] orangefs: write
 range tracking)
Message-ID: <20181009234332.GA52014@t480s.mkb.name>
References: <20181007232736.3780-1-martin@omnibond.com>
 <20181007232736.3780-15-martin@omnibond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181007232736.3780-15-martin@omnibond.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have some questions about my assumptions writing this code.  I
definitely have something wrong.

(Given my comments in invalidatepage, it should be clear I'm not quite
confident that it's doing the right thing.)

I thought writpeage could not be called while PagePrivate is not set.
It is set during a write to reflect the changed data, then cleared in
writepage as the write is done.

It is also cleared in invalidatepage since the write is no longer
necessary.  However, I see writepage calls after an invalidatepage
causing a ClearPagePrivate.  These naturally hit the BUG().

Running xfstests generic/127 I see a page with a pending write from
2110 to 4096 (end of page) and then an invalidate on that page from 744
to 4096.  I ClearPagePrivate since there is no longer any data to write
from that page.  But the kernel doens't know that and calls writepage.

Should I ClearPageDirty too?

Should I just ClearPagePrivate and then use the fact that it's not set
as a hint not to do anything in writepage?

Something I'm not thinking of?

Martin

On Sun, Oct 07, 2018 at 11:27:31PM +0000, Martin Brandenburg wrote:
> This is necessary to ensure the uid/gid responsible for the write is
> communicated with the server.  Only one uid/gid may have outstanding
> changes at a time.  If another uid/gid writes while there are
> outstanding changes, the changes must be written out before the new
> data is put into the page.
> 
> Signed-off-by: Martin Brandenburg <martin@omnibond.com>
> ---
>  fs/orangefs/file.c            |  12 +-
>  fs/orangefs/inode.c           | 267 ++++++++++++++++++++++++++++++----
>  fs/orangefs/orangefs-kernel.h |  12 +-
>  3 files changed, 261 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
> index ba580a5c6fd2..5eda483263ae 100644
> --- a/fs/orangefs/file.c
> +++ b/fs/orangefs/file.c
> @@ -46,8 +46,8 @@ static int flush_racache(struct inode *inode)
>   * Post and wait for the I/O upcall to finish
>   */
>  ssize_t wait_for_direct_io(enum ORANGEFS_io_type type, struct inode *inode,
> -		loff_t *offset, struct iov_iter *iter,
> -		size_t total_size, loff_t readahead_size)
> +    loff_t *offset, struct iov_iter *iter, size_t total_size,
> +    loff_t readahead_size, struct orangefs_write_request *wr)
>  {
>  	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
>  	struct orangefs_khandle *handle = &orangefs_inode->refn.khandle;
> @@ -103,6 +103,10 @@ ssize_t wait_for_direct_io(enum ORANGEFS_io_type type, struct inode *inode,
>  			    __func__, (long)ret);
>  			goto out;
>  		}
> +		if (wr) {
> +			new_op->upcall.uid = from_kuid(&init_user_ns, wr->uid);
> +			new_op->upcall.gid = from_kgid(&init_user_ns, wr->gid);
> +		}
>  	}
>  
>  	gossip_debug(GOSSIP_FILE_DEBUG,
> @@ -292,7 +296,7 @@ ssize_t do_readv_writev(enum ORANGEFS_io_type type, struct file *file,
>  			     (int)*offset);
>  
>  		ret = wait_for_direct_io(type, inode, offset, iter,
> -				each_count, 0);
> +				each_count, 0, NULL);
>  		gossip_debug(GOSSIP_FILE_DEBUG,
>  			     "%s(%pU): return from wait_for_io:%d\n",
>  			     __func__,
> @@ -434,7 +438,7 @@ static vm_fault_t orangefs_fault(struct vm_fault *vmf)
>  static const struct vm_operations_struct orangefs_file_vm_ops = {
>  	.fault = orangefs_fault,
>  	.map_pages = filemap_map_pages,
> -	.page_mkwrite = filemap_page_mkwrite,
> +	.page_mkwrite = orangefs_page_mkwrite,
>  };
>  
>  /*
> diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
> index bd2ce18453f2..5c155b259b13 100644
> --- a/fs/orangefs/inode.c
> +++ b/fs/orangefs/inode.c
> @@ -15,9 +15,11 @@
>  #include "orangefs-kernel.h"
>  #include "orangefs-bufmap.h"
>  
> -static int orangefs_writepage(struct page *page, struct writeback_control *wbc)
> +static int orangefs_writepage_locked(struct page *page,
> +    struct writeback_control *wbc)
>  {
>  	struct inode *inode = page->mapping->host;
> +	struct orangefs_write_request *wr;
>  	struct iov_iter iter;
>  	struct bio_vec bv;
>  	size_t len, wlen;
> @@ -26,33 +28,175 @@ static int orangefs_writepage(struct page *page, struct writeback_control *wbc)
>  
>  	set_page_writeback(page);
>  
> -	off = page_offset(page);
> -	len = i_size_read(inode);
> -	if (off + PAGE_SIZE > len)
> -		wlen = len - off;
> -	else
> -		wlen = PAGE_SIZE;
> +	if (PagePrivate(page)) {
> +		wr = (struct orangefs_write_request *)page_private(page);
> +		BUG_ON(!wr);
> +		if (wr->mwrite) {
> +			off = page_offset(page);
> +			len = i_size_read(inode);
> +			if (off + PAGE_SIZE > len)
> +				wlen = len - off;
> +			else
> +				wlen = PAGE_SIZE;
> +		} else {
> +			off = wr->pos;
> +			wlen = wr->len;
> +			len = i_size_read(inode);
> +		}
> +	} else {
> +/*		BUG();*/
> +		/* It's not private so there's nothing to write, right? */
> +		printk("writepage not private!\n");
> +		end_page_writeback(page);
> +		return 0;
> +
> +	}
>  
>  	bv.bv_page = page;
>  	bv.bv_len = wlen;
>  	bv.bv_offset = off % PAGE_SIZE;
> -	if (wlen == 0)
> -		dump_stack();
>  	iov_iter_bvec(&iter, ITER_BVEC | WRITE, &bv, 1, wlen);
>  
>  	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, wlen,
> -	    len);
> +	    len, wr);
>  	if (ret < 0) {
>  		SetPageError(page);
>  		mapping_set_error(page->mapping, ret);
>  	} else {
>  		ret = 0;
> +		if (wr) {
> +			ClearPagePrivate(page);
> +			kfree(wr);
> +		}
>  	}
>  	end_page_writeback(page);
> -	unlock_page(page);
>  	return ret;
>  }
>  
> +static int do_writepage_if_necessary(struct page *page, loff_t pos,
> +    unsigned len)
> +{
> +	struct orangefs_write_request *wr;
> +	struct writeback_control wbc = {
> +		.sync_mode = WB_SYNC_ALL,
> +		.nr_to_write = 0,
> +	};
> +	int r;
> +	if (PagePrivate(page)) {
> +		wr = (struct orangefs_write_request *)page_private(page);
> +		BUG_ON(!wr);
> +		/*
> +		 * If the new request is not contiguous with the last one or if
> +		 * the uid or gid is different, the page must be written out
> +		 * before continuing.
> +		 */
> +		if (pos + len < wr->pos || wr->pos + wr->len < pos ||
> +		    !uid_eq(current_fsuid(), wr->uid) ||
> +		    !gid_eq(current_fsgid(), wr->gid)) {
> +			wbc.range_start = page_file_offset(page);
> +			wbc.range_end = wbc.range_start + PAGE_SIZE - 1;
> +			wait_on_page_writeback(page);
> +			if (clear_page_dirty_for_io(page)) {
> +				r = orangefs_writepage_locked(page, &wbc);
> +				if (r)
> +					return r;
> +			}
> +			BUG_ON(PagePrivate(page));
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int update_wr(struct page *page, loff_t pos, unsigned len, int mwrite)
> +{
> +	struct orangefs_write_request *wr;
> +	if (PagePrivate(page)) {
> +		wr = (struct orangefs_write_request *)page_private(page);
> +		BUG_ON(!wr);
> +		if (mwrite) {
> +			wr->mwrite = 1;
> +			return 0;
> +		}
> +		if (pos < wr->pos) {
> +			wr->len += wr->pos - pos;
> +			wr->pos = pos;
> +		}
> +		if (pos + len > wr->pos + wr->len)
> +			wr->len = pos + len - wr->pos;
> +		else
> +			wr->len = wr->pos + wr->len - wr->pos;
> +	} else {
> +		wr = kmalloc(sizeof *wr, GFP_KERNEL);
> +		if (wr) {
> +			wr->pos = pos;
> +			wr->len = len;
> +			wr->uid = current_fsuid();
> +			wr->gid = current_fsgid();
> +			wr->mwrite = mwrite;
> +			SetPagePrivate(page);
> +			set_page_private(page, (unsigned long)wr);
> +		} else {
> +			return -ENOMEM;
> +		}
> +	}
> +	return 0;
> +}
> +
> +int orangefs_page_mkwrite(struct vm_fault *vmf)
> +{
> +	struct page *page = vmf->page;
> +	struct inode *inode = file_inode(vmf->vma->vm_file);
> +	unsigned len;
> +	int r;
> +
> +	/* Do not write past the file size. */
> +	len = i_size_read(inode) - page_file_offset(page);
> +	if (len > PAGE_SIZE)
> +		len = PAGE_SIZE;
> +
> +	lock_page(page);
> +	r = do_writepage_if_necessary(page, page_file_offset(page),
> +	    len);
> +	if (r) {
> +		r = VM_FAULT_RETRY;
> +		unlock_page(vmf->page);
> +		return r;
> +	}
> +	r = update_wr(page, page_file_offset(page), len, 1);
> +	if (r) {
> +		r = VM_FAULT_RETRY;
> +		unlock_page(vmf->page);
> +		return r;
> +	}
> +
> +	r = VM_FAULT_LOCKED;
> +	sb_start_pagefault(inode->i_sb);
> +	file_update_time(vmf->vma->vm_file);
> +	if (page->mapping != inode->i_mapping) {
> +		unlock_page(page);
> +		r = VM_FAULT_NOPAGE;
> +		goto out;
> +	}
> +	/*
> +	 * We mark the page dirty already here so that when freeze is in
> +	 * progress, we are guaranteed that writeback during freezing will
> +	 * see the dirty page and writeprotect it again.
> +	 */
> +	set_page_dirty(page);
> +	wait_for_stable_page(page);
> +out:
> +	sb_end_pagefault(inode->i_sb);
> +	return r;
> +}
> +
> +static int orangefs_writepage(struct page *page, struct writeback_control *wbc)
> +{
> +	int r;
> +	r = orangefs_writepage_locked(page, wbc);
> +	unlock_page(page);
> +	return r;
> +}
> +
>  static int orangefs_readpage(struct file *file, struct page *page)
>  {
>  	struct inode *inode = page->mapping->host;
> @@ -68,7 +212,7 @@ static int orangefs_readpage(struct file *file, struct page *page)
>  	iov_iter_bvec(&iter, ITER_BVEC | READ, &bv, 1, PAGE_SIZE);
>  
>  	ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &off, &iter,
> -	    PAGE_SIZE, inode->i_size);
> +	    PAGE_SIZE, inode->i_size, NULL);
>  	/* this will only zero remaining unread portions of the page data */
>  	iov_iter_zero(~0U, &iter);
>  	/* takes care of potential aliasing */
> @@ -86,10 +230,26 @@ static int orangefs_readpage(struct file *file, struct page *page)
>  	return ret;
>  }
>  
> +static int orangefs_write_begin(struct file *file,
> +    struct address_space *mapping, loff_t pos, unsigned len, unsigned flags,
> +    struct page **pagep, void **fsdata)
> +{
> +	int r;
> +	r = simple_write_begin(file, mapping, pos, len, flags, pagep, fsdata);
> +	if (r)
> +		return r;
> +	r = do_writepage_if_necessary(*pagep, pos, len);
> +	if (r)
> +		unlock_page(*pagep);
> +	return r;
> +}
> +
>  int orangefs_write_end(struct file *file, struct address_space *mapping,
>      loff_t pos, unsigned len, unsigned copied, struct page *page, void *fsdata)
>  {
>  	int r;
> +	if (update_wr(page, pos, len, 0))
> +		return -ENOMEM;
>  	r = simple_write_end(file, mapping, pos, len, copied, page, fsdata);
>  	mark_inode_dirty_sync(file_inode(file));
>  	return r;
> @@ -99,24 +259,68 @@ static void orangefs_invalidatepage(struct page *page,
>  				 unsigned int offset,
>  				 unsigned int length)
>  {
> -	gossip_debug(GOSSIP_INODE_DEBUG,
> -		     "orangefs_invalidatepage called on page %p "
> -		     "(offset is %u)\n",
> -		     page,
> -		     offset);
> -
> -	ClearPageUptodate(page);
> -	ClearPageMappedToDisk(page);
> +	struct orangefs_write_request *wr;
> +	/* XXX move to releasepage and call + rebase */
> +	struct writeback_control wbc = {
> +		.sync_mode = WB_SYNC_ALL,
> +		.nr_to_write = 0,
> +	};
> +	int r;
> +	if (PagePrivate(page)) {
> +		wr = (struct orangefs_write_request *)page_private(page);
> +		BUG_ON(!wr);
> +/* XXX prove */
> +		if (offset == 0 && length == PAGE_SIZE) {
> +			ClearPagePrivate(page);
> +			kfree(wr);
> +		} else if (wr->pos - page_offset(page) < offset &&
> +		    wr->pos - page_offset(page) + wr->len > offset + length) {
> +			wbc.range_start = page_file_offset(page);
> +			wbc.range_end = wbc.range_start + PAGE_SIZE - 1;
> +			wait_on_page_writeback(page);
> +			if (clear_page_dirty_for_io(page)) {
> +				r = orangefs_writepage_locked(page, &wbc);
> +				if (r)
> +					return;
> +			} else {
> +				ClearPagePrivate(page);
> +				kfree(wr);
> +			}
> +		} else if (wr->pos - page_offset(page) < offset &&
> +		    wr->pos - page_offset(page) + wr->len <= offset + length) {
> +			wr->len = offset;
> +		} else if (wr->pos - page_offset(page) >= offset &&
> +		    wr->pos - page_offset(page) + wr->len > offset + length) {
> +			wr->pos += length - wr->pos + page_offset(page);
> +			wr->len -= length - wr->pos + page_offset(page);
> +		} else {
> +			/*
> +			 * Invalidate range is bigger than write range but
> +			 * entire write range is to be invalidated.
> +			 */
> +			ClearPagePrivate(page);
> +			kfree(wr);
> +		}
> +	}
>  	return;
>  
>  }
>  
>  static int orangefs_releasepage(struct page *page, gfp_t foo)
>  {
> -	gossip_debug(GOSSIP_INODE_DEBUG,
> -		     "orangefs_releasepage called on page %p\n",
> -		     page);
> -	return 0;
> +	/*
> +	 * Two cases are mentioned in vfs.txt.  Only one is relevant
> +	 * "VM finds a clean page with no active users and wants to make it a
> +	 * free page"  However this page will not be private.
> +	 * "request has been made to invalidate some or all pages in an
> +	 * address_space"  So we call orangefs_invalidatepage.
> +	 */
> +	if (PagePrivate(page)) {
> +		orangefs_invalidatepage(page, 0, PAGE_SIZE);
> +		return !PagePrivate(page);
> +	} else {
> +		return 1;
> +	}
>  }
>  
>  static ssize_t orangefs_direct_IO(struct kiocb *iocb,
> @@ -128,16 +332,29 @@ static ssize_t orangefs_direct_IO(struct kiocb *iocb,
>  	    ORANGEFS_IO_WRITE : ORANGEFS_IO_READ, file, &pos, iter);
>  }
>  
> +static int orangefs_launder_page(struct page *page)
> +{
> +	int r = 0;
> +	if (PagePrivate(page)) {
> +		if (clear_page_dirty_for_io(page))
> +			r = orangefs_writepage_locked(page, NULL);
> +		return r;
> +	} else {
> +		return 0;
> +	}
> +}
> +
>  /** ORANGEFS2 implementation of address space operations */
>  static const struct address_space_operations orangefs_address_operations = {
>  	.writepage = orangefs_writepage,
>  	.readpage = orangefs_readpage,
>  	.set_page_dirty = __set_page_dirty_nobuffers,
> -	.write_begin = simple_write_begin,
> +	.write_begin = orangefs_write_begin,
>  	.write_end = orangefs_write_end,
>  	.invalidatepage = orangefs_invalidatepage,
>  	.releasepage = orangefs_releasepage,
>  	.direct_IO = orangefs_direct_IO,
> +	.launder_page = orangefs_launder_page,
>  };
>  
>  static int orangefs_setattr_size(struct inode *inode, struct iattr *iattr)
> diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
> index e128500e33b4..2e9726d1de7d 100644
> --- a/fs/orangefs/orangefs-kernel.h
> +++ b/fs/orangefs/orangefs-kernel.h
> @@ -178,6 +178,14 @@ static inline void set_op_state_purged(struct orangefs_kernel_op_s *op)
>  	}
>  }
>  
> +struct orangefs_write_request {
> +	loff_t pos;
> +	unsigned len;
> +	kuid_t uid;
> +	kgid_t gid;
> +	int mwrite;
> +};
> +
>  /* per inode private orangefs info */
>  struct orangefs_inode_s {
>  	struct orangefs_object_kref refn;
> @@ -341,6 +349,8 @@ void fsid_key_table_finalize(void);
>  /*
>   * defined in inode.c
>   */
> +int orangefs_page_mkwrite(struct vm_fault *);
> +
>  struct inode *orangefs_new_inode(struct super_block *sb,
>  			      struct inode *dir,
>  			      int mode,
> @@ -382,7 +392,7 @@ bool __is_daemon_in_service(void);
>   * defined in file.c
>   */
>  ssize_t wait_for_direct_io(enum ORANGEFS_io_type, struct inode *, loff_t *,
> -    struct iov_iter *, size_t, loff_t);
> +    struct iov_iter *, size_t, loff_t, struct orangefs_write_request *);
>  ssize_t do_readv_writev(enum ORANGEFS_io_type, struct file *, loff_t *,
>      struct iov_iter *);
>  
> -- 
> 2.19.0
> 
