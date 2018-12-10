Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9450C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7529B2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="z4+VwWjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7529B2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbeLJSop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:44:45 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45138 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbeLJSoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:44:44 -0500
Received: by mail-qt1-f195.google.com with SMTP id e5so13454661qtr.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 10:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yM1ink51F8lReY2/3I78fpsqfV2Peb0cVLPyEjp35FA=;
        b=z4+VwWjVcah4zjd+ClUKFr08GJFmwhrZC4TgIeWRuJigw5GGrW1YGH+96UwHZCJ6Bp
         riijXlt+QsrQBuI734V0z5S9RGLo/bzLfr842yAh0tSKXtAjNXpA8e4iKkZ2AakzBJYS
         PP0CHXki8jWUSas3sCPDKDxsiYktiIxh5PPetZE3KcL63wtj/C0Iy/RVVzWko1urQ+Sb
         rZ32HpiX6kpRhuPTEMdjzaGJU74HkbAaLHgUObHUXELcYq2i5paFDOepGrT1xQeJpMGp
         bDDPAemSn5d2nghqlOS2aNxRU2ugIR33k7z5qfaTJXLIQvB/MFecBxe16BnP2Yx/aAn4
         XsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yM1ink51F8lReY2/3I78fpsqfV2Peb0cVLPyEjp35FA=;
        b=g0IK8433QGS5hlbiZP+HzODwEb51DbalZTD9bUBRI2KGqjcSEO+KMbINh99m7xJY4P
         n8inzeQybV5fY0/hncQ+0XmY+ZU2fI5g0zzXALfhNpSMN/2s+okzckNfEwG4x7g2DOmw
         jjiPhJI8+rrJgna9mp5hhiLjnWoTjxiLX14GW28sGGrQU4BlMybVPdS1/XmlyU3jOGtD
         FIqhlDZ0J7BivGzHHMFHMflWUl9QWYsYgyfjZKWFBvvyxVnOZsh2j+AiowRymPs9/H1n
         l9xnCYp4Z11CN7hPcZe0NxMQ+xbjfeVlCpi1gaMyJEehD3ezr2u7kMY9OjMO9RDB9nRx
         I5bw==
X-Gm-Message-State: AA+aEWbysCikQwQoSLLZdSZ6zAiFjIha0q7wzhFvHdfRLGrU3FLz2Nun
        kEPqAt/FwEtTMJRW3OXWwEmm2g==
X-Google-Smtp-Source: AFSGD/WBfCdOltsWeOWc0AFIzAcI3Ick4+LaQYwR+IkIEjUXvkpp4uVo+EIias7FpflGcxfqfC8ZMA==
X-Received: by 2002:aed:26a3:: with SMTP id q32mr13348245qtd.106.1544467481839;
        Mon, 10 Dec 2018 10:44:41 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:9260])
        by smtp.gmail.com with ESMTPSA id w12sm6330883qkb.3.2018.12.10.10.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 10:44:41 -0800 (PST)
Date:   Mon, 10 Dec 2018 13:44:39 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org, tj@kernel.org,
        david@fromorbit.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com
Subject: Re: [PATCH 3/4] filemap: drop the mmap_sem for all blocking
 operations
Message-ID: <20181210184438.va7mdwjgwndgri4s@macbook-pro-91.dhcp.thefacebook.com>
References: <20181130195812.19536-1-josef@toxicpanda.com>
 <20181130195812.19536-4-josef@toxicpanda.com>
 <20181207110138.GE13008@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207110138.GE13008@quack2.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 12:01:38PM +0100, Jan Kara wrote:
> On Fri 30-11-18 14:58:11, Josef Bacik wrote:
> > Currently we only drop the mmap_sem if there is contention on the page
> > lock.  The idea is that we issue readahead and then go to lock the page
> > while it is under IO and we want to not hold the mmap_sem during the IO.
> > 
> > The problem with this is the assumption that the readahead does
> > anything.  In the case that the box is under extreme memory or IO
> > pressure we may end up not reading anything at all for readahead, which
> > means we will end up reading in the page under the mmap_sem.
> > 
> > Instead rework filemap fault path to drop the mmap sem at any point that
> > we may do IO or block for an extended period of time.  This includes
> > while issuing readahead, locking the page, or needing to call ->readpage
> > because readahead did not occur.  Then once we have a fully uptodate
> > page we can return with VM_FAULT_RETRY and come back again to find our
> > nicely in-cache page that was gotten outside of the mmap_sem.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  mm/filemap.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 93 insertions(+), 20 deletions(-)
> > 
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index f068712c2525..5e76b24b2a0f 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -2304,28 +2304,44 @@ EXPORT_SYMBOL(generic_file_read_iter);
> >  
> >  #ifdef CONFIG_MMU
> >  #define MMAP_LOTSAMISS  (100)
> > +static struct file *maybe_unlock_mmap_for_io(struct file *fpin,
> > +					     struct vm_area_struct *vma,
> > +					     int flags)
> > +{
> > +	if (fpin)
> > +		return fpin;
> > +	if ((flags & (FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_RETRY_NOWAIT)) ==
> > +	    FAULT_FLAG_ALLOW_RETRY) {
> > +		fpin = get_file(vma->vm_file);
> > +		up_read(&vma->vm_mm->mmap_sem);
> > +	}
> > +	return fpin;
> > +}
> >  
> >  /*
> >   * Synchronous readahead happens when we don't even find
> >   * a page in the page cache at all.
> >   */
> > -static void do_sync_mmap_readahead(struct vm_area_struct *vma,
> > -				   struct file_ra_state *ra,
> > -				   struct file *file,
> > -				   pgoff_t offset)
> > +static struct file *do_sync_mmap_readahead(struct vm_area_struct *vma,
> > +					   struct file_ra_state *ra,
> > +					   struct file *file,
> > +					   pgoff_t offset,
> > +					   int flags)
> >  {
> 
> IMO it would be nicer to pass vmf here at this point. Everything this
> function needs is there and the number of arguments is already quite big.
> But I don't insist.
> 
> >  /*
> >   * Asynchronous readahead happens when we find the page and PG_readahead,
> >   * so we want to possibly extend the readahead further..
> >   */
> > -static void do_async_mmap_readahead(struct vm_area_struct *vma,
> > -				    struct file_ra_state *ra,
> > -				    struct file *file,
> > -				    struct page *page,
> > -				    pgoff_t offset)
> > +static struct file *do_async_mmap_readahead(struct vm_area_struct *vma,
> > +					    struct file_ra_state *ra,
> > +					    struct file *file,
> > +					    struct page *page,
> > +					    pgoff_t offset, int flags)
> >  {
> 
> The same here (except for 'page' which needs to be kept).
> 
> > @@ -2433,9 +2458,32 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
> >  			return vmf_error(-ENOMEM);
> >  	}
> >  
> > -	if (!lock_page_or_retry(page, vmf->vma->vm_mm, vmf->flags)) {
> > -		put_page(page);
> > -		return ret | VM_FAULT_RETRY;
> > +	/*
> > +	 * We are open-coding lock_page_or_retry here because we want to do the
> > +	 * readpage if necessary while the mmap_sem is dropped.  If there
> > +	 * happens to be a lock on the page but it wasn't being faulted in we'd
> > +	 * come back around without ALLOW_RETRY set and then have to do the IO
> > +	 * under the mmap_sem, which would be a bummer.
> > +	 */
> 
> Hum, lock_page_or_retry() has two callers and you've just killed one. I
> think it would be better to modify the function to suit both callers rather
> than opencoding? Maybe something like lock_page_maybe_drop_mmap() which
> would unconditionally acquire the lock and return whether it has dropped
> mmap sem or not? Callers can then decide what to do.
> 

I tried this, but it ends up being convoluted, since swap doesn't have a file to
pin we have to add extra cases for that, and then change the return value to
indicate wether we locked the page _and_ dropped the mmap sem, or just locked
the page, etc.  It didn't seem the extra complication, so I just broke the open
coding out into its own helper.

> BTW I'm not sure this complication is really worth it. The "drop mmap_sem
> for IO" is never going to be 100% thing if nothing else because only one
> retry is allowed in do_user_addr_fault(). So the second time we get to
> filemap_fault(), we will not have FAULT_FLAG_ALLOW_RETRY set and thus do
> blocking locking. So I think your code needs to catch common cases you
> observe in practice but not those super-rare corner cases...

I had counters in all of these paths because I was sure some things weren't
getting hit at all, but it turns out each of these cases gets hit with
surprisingly high regularity.  The lock_page_or_retry() case in particular gets
hit a lot with multi-threaded applications that got paged out because of heavy
memory pressure.  By no means is it as high as just the normal readpage or
readahead cases, but it's not 0, so I'd rather have the extra helper here to
make sure we're never getting screwed.  Thanks,

Josef
