Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2ACC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F27E20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="pIP8qEJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F27E20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389244AbeHAOlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:41:11 -0400
Received: from imap.thunk.org ([74.207.234.97]:51774 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389081AbeHAOlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IeReGwaeq+lqD3iUgh0ryeJiKud8EBxtFTtVNSFHEPw=; b=pIP8qEJ2OELHFR203s5AbP4uF9
        OqeGTZUmE/sAchxZ2jyUDns66hyqc7tjFjzHPKxhO9Ci3tJ0O5h0dvO7fTrs7ikHrdeU9VKbBrlI/
        24WUO9xW9MB3MfXx7AzXsj3qE/Hh3HbvNcbwxkJ7UdTqe5ttiwv862hxlQ8Mr4WppH/k=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fkqeo-0002Fe-7K; Wed, 01 Aug 2018 12:55:14 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 89BC17A614D; Wed,  1 Aug 2018 08:55:12 -0400 (EDT)
Date:   Wed, 1 Aug 2018 08:55:12 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     willy@infradead.org, adilger.kernel@dilger.ca,
        darrick.wong@oracle.com, axboe@kernel.dk, agruenba@redhat.com,
        ebiggers@google.com, gregkh@linuxfoundation.org,
        kemi.wang@intel.com, sabyasachi.linux@gmail.com,
        brajeswar.linux@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Convert int to vm_fault_t type
Message-ID: <20180801125512.GA10761@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Souptick Joarder <jrdr.linux@gmail.com>, willy@infradead.org,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com, axboe@kernel.dk,
        agruenba@redhat.com, ebiggers@google.com,
        gregkh@linuxfoundation.org, kemi.wang@intel.com,
        sabyasachi.linux@gmail.com, brajeswar.linux@gmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180728085000.GA9136@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180728085000.GA9136@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 02:20:00PM +0530, Souptick Joarder wrote:
> Use new return type vm_fault_t for ext4_page_mkwrite
> handler and block_page_mkwrite_return.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

FYI, this patch was very sloppy, and didn't do the right thing.  That's
because of how you messed with the changing how the return codes are
now handled.

> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -6108,27 +6108,27 @@ static int ext4_bh_unmapped(handle_t *handle, struct buffer_head *bh)
>  	return !buffer_mapped(bh);
>  }
>  
> -int ext4_page_mkwrite(struct vm_fault *vmf)
> +vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct page *page = vmf->page;
>  	loff_t size;
>  	unsigned long len;
> -	int ret;
> +	vm_fault_t ret;
>  	struct file *file = vma->vm_file;
>  	struct inode *inode = file_inode(file);
>  	struct address_space *mapping = inode->i_mapping;
>  	handle_t *handle;
>  	get_block_t *get_block;
> -	int retries = 0;
> +	int retries = 0, err;

OK, ret now is a vm_fault_t, and err is an error return....

> @@ -6138,9 +6138,9 @@ int ext4_page_mkwrite(struct vm_fault *vmf)
>  		do {
>  			ret = block_page_mkwrite(vma, vmf,
>  						   ext4_da_get_block_prep);

But block_page_mkwrite() still returns an int, not a vm_fault_t....

>  -		} while (ret == -ENOSPC &&
> +		} while (ret == VM_FAULT_SIGBUS &&
>  		       ext4_should_retry_alloc(inode->i_sb, &retries));

So this is Just wrong,  This needed to be:

  		do {
  			err = block_page_mkwrite(vma, vmf,
  						   ext4_da_get_block_prep);
		} while (err == -ENOSPC &&
  		         ext4_should_retry_alloc(inode->i_sb, &retries));
		goto out_ret;

That's because out_ret is what will translate the int error code to
the vm_fault_t via:

	ret = block_page_mkwrite_return(err);

The fact that ext4_page_mkwrite() returns a vm_fault_t, while
block_page_mkwrite() returns an int which then has to get translated
into a vm_fault_t via block_page_mkwrite_return() is I suspect going
to confuse an awful lot of callers.

I'll fix up the patch, but I just wanted to call your attention to
this pitfall in the patch which confused even you as the patch author....

(BTW, the buggy patch triggered a new failure, ext4/307, which is how
I noticed that the patch was all wrong.  If you had run any kind of
static code checker you would have noticed that block_page_mkwrite()
was returning an int and that was getting assigned into a variable of
type vm_fault_t.  The fact that you *didn't* notice makes me worry
that all of this code churn may, in the end, not actually help us as
much as we thought.  :-(

     	     	    	  		      - Ted
