Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F6EC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 08:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D82C2088E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 08:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ8xFKdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D82C2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbeG1KOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 06:14:48 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38551 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeG1KOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 06:14:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id p6-v6so6372919ljc.5;
        Sat, 28 Jul 2018 01:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ToOtSEawzuELzrjemXOuu2LMJQbrmbFv8R9berot09s=;
        b=kZ8xFKdUDomoT9rsHPECe3bqMu/8LaZaNPDP80DRR3z2JP4gsOYGhDdXmBDwfy6gSN
         uqEY2KD9zFGFCBOzrv5hApcrFMXvKQiOs8qLai9RiTuK77jY5W3mKfIJpxcS6QsWBnyl
         nDMKrfmk3c7pHruPP9LugJe5achBlUjIsh9paov06YhpJoqIOOEIpcGMfnJm9mmRBROn
         ungGZfmi1y2ky9UwbnLfdJ3D7YjcbEvnt9keq9t5cO0Z5MsEUvaDndA4DM3aY+478izS
         R8ViYgmleAI8cSIiXQFEM6KFUttRQe2ve/tUMAjFJH2O/CcwCwccC0r/cwZcQdAX4blk
         /azA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ToOtSEawzuELzrjemXOuu2LMJQbrmbFv8R9berot09s=;
        b=ZqN+9rUgLKi/viJlVK/ucCxECaeCtF7DSsaXezaCcXkA5nZgSCkpBKr9GFMK4qjsbg
         CSuswMsjGdqUe67JdOZbWMdP9uvrQVs4uAM9FP8v5BzN60QoQ8wUSPRLEGLtAC/Vezz/
         D2QJSdb4k7O685Chu4TDXCwy1mxUz4q+ZUkg9VRJwGcVJTd8VdV1p0VYHLeXABiVznQS
         hb81yMGH3uFGYUUDcGD7D1KoI5rt9o/up3WiXZv50NgkfNMPBXq4fP3ksK9JNjLmH4nY
         sfSwSwpbSkUHQwDhsy/2DdgjW8HNPsT5pgclC8X/KllKPebBakIE+bzmWfY+WcrpRcIN
         cqDA==
X-Gm-Message-State: AOUpUlF9t2KTwT1wPrAWbE/DMQgDqu4/JPcQ32C2Bix8YNwLU2YjhYIu
        fJxebfkuWujOWYXgNfLb1wv1etL+knbDKGifEu8=
X-Google-Smtp-Source: AAOMgpdMH1/bwJg5Vwe86j/6uDHCnySJ7YSeqZkyOoEf7BsP1N6ZnieVpOtjlrJr+0bPubodBwXtG1ivTRTL/dRcJ2g=
X-Received: by 2002:a2e:5617:: with SMTP id k23-v6mr7101334ljb.86.1532767741387;
 Sat, 28 Jul 2018 01:49:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Sat, 28 Jul 2018 01:49:00
 -0700 (PDT)
In-Reply-To: <20180728085000.GA9136@jordon-HP-15-Notebook-PC>
References: <20180728085000.GA9136@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 28 Jul 2018 14:19:00 +0530
Message-ID: <CAFqt6zbvRa+_Qi=UaRMSvOaguyJ9GHzcgsv3BOOksjZjCyUCcQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: Convert int to vm_fault_t type
To:     Matthew Wilcox <willy@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        "Darrick J. Wong" <darrick.wong@oracle.com>, axboe@kernel.dk,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com
Cc:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 2:20 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> Use new return type vm_fault_t for ext4_page_mkwrite
> handler and block_page_mkwrite_return.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

As part of commit 2fae376c0a16db42eb438 in linux-next tree,
this conversion was missed. Sorry about it.

> ---
>  fs/ext4/ext4.h              |  2 +-
>  fs/ext4/inode.c             | 20 ++++++++++----------
>  include/linux/buffer_head.h |  3 ++-
>  3 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index aec0010..1183773 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2469,7 +2469,7 @@ int do_journal_get_write_access(handle_t *handle,
>  extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
>  extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
>                              loff_t lstart, loff_t lend);
> -extern int ext4_page_mkwrite(struct vm_fault *vmf);
> +extern vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf);
>  extern vm_fault_t ext4_filemap_fault(struct vm_fault *vmf);
>  extern qsize_t *ext4_get_reserved_space(struct inode *inode);
>  extern int ext4_get_projid(struct inode *inode, kprojid_t *projid);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 03ac322..b491fdb 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -6108,27 +6108,27 @@ static int ext4_bh_unmapped(handle_t *handle, struct buffer_head *bh)
>         return !buffer_mapped(bh);
>  }
>
> -int ext4_page_mkwrite(struct vm_fault *vmf)
> +vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
>  {
>         struct vm_area_struct *vma = vmf->vma;
>         struct page *page = vmf->page;
>         loff_t size;
>         unsigned long len;
> -       int ret;
> +       vm_fault_t ret;
>         struct file *file = vma->vm_file;
>         struct inode *inode = file_inode(file);
>         struct address_space *mapping = inode->i_mapping;
>         handle_t *handle;
>         get_block_t *get_block;
> -       int retries = 0;
> +       int retries = 0, err;
>
>         sb_start_pagefault(inode->i_sb);
>         file_update_time(vma->vm_file);
>
>         down_read(&EXT4_I(inode)->i_mmap_sem);
>
> -       ret = ext4_convert_inline_data(inode);
> -       if (ret)
> +       err = ext4_convert_inline_data(inode);
> +       if (err)
>                 goto out_ret;
>
>         /* Delalloc case is easy... */
> @@ -6138,9 +6138,9 @@ int ext4_page_mkwrite(struct vm_fault *vmf)
>                 do {
>                         ret = block_page_mkwrite(vma, vmf,
>                                                    ext4_da_get_block_prep);
> -               } while (ret == -ENOSPC &&
> +               } while (ret == VM_FAULT_SIGBUS &&
>                        ext4_should_retry_alloc(inode->i_sb, &retries));
> -               goto out_ret;
> +               goto out;
>         }
>
>         lock_page(page);
> @@ -6188,17 +6188,17 @@ int ext4_page_mkwrite(struct vm_fault *vmf)
>                 if (ext4_walk_page_buffers(handle, page_buffers(page), 0,
>                           PAGE_SIZE, NULL, do_journal_get_write_access)) {
>                         unlock_page(page);
> -                       ret = VM_FAULT_SIGBUS;
>                         ext4_journal_stop(handle);
>                         goto out;
>                 }
>                 ext4_set_inode_state(inode, EXT4_STATE_JDATA);
>         }
>         ext4_journal_stop(handle);
> -       if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
> +       if (ret == VM_FAULT_SIGBUS &&
> +               ext4_should_retry_alloc(inode->i_sb, &retries))
>                 goto retry_alloc;
>  out_ret:
> -       ret = block_page_mkwrite_return(ret);
> +       ret = block_page_mkwrite_return(err);
>  out:
>         up_read(&EXT4_I(inode)->i_mmap_sem);
>         sb_end_pagefault(inode->i_sb);
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 96225a7..ed7a81b 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -14,6 +14,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/wait.h>
>  #include <linux/atomic.h>
> +#include <linux/mm_types.h>
>
>  #ifdef CONFIG_BLOCK
>
> @@ -242,7 +243,7 @@ int cont_write_begin(struct file *, struct address_space *, loff_t,
>  int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
>                                 get_block_t get_block);
>  /* Convert errno to return value from ->page_mkwrite() call */
> -static inline int block_page_mkwrite_return(int err)
> +static inline vm_fault_t block_page_mkwrite_return(int err)
>  {
>         if (err == 0)
>                 return VM_FAULT_LOCKED;
> --
> 1.9.1
>
