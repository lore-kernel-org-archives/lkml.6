Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C02C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB9720894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOBS3eJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB9720894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389574AbeHAPrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:47:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45971 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389488AbeHAPrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:47:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id w16-v6so13381597ljh.12;
        Wed, 01 Aug 2018 07:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CiJWtCMV2zu8Cy7iskIQuerVdsTLdafqDZDa8yb5Kd8=;
        b=kOBS3eJ8hfrl2O0LHeJ2gm/J5ZlwbVFWuaJMg+ivZw9AaTELJcuwbUY1wkgm/iViub
         B3q3IQ28XyfggOKC8mSfS3NfQaxT6WNvl4hjrNz4CivmqcKTsjvj6m0OXn1JSfDtCThy
         zqZ+FsEoSL6sw/gYoUutL/EUop1VmH9T08grVstTajjcGoEXyaVbl6yPS5oLOgQsTRK1
         9LblKhkM85hZ1de7kDm9uMrFdoawd2vBiRI5Hk9Ey4xIhOB5NiGbJOyvk125f8H5NioQ
         doJn+jQFygLEB5jEZiMENgUHwaEEp+6tzdUY65Z1HaVWbn2d/r4oZ/lA4BZ7+3tEiw/3
         YdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CiJWtCMV2zu8Cy7iskIQuerVdsTLdafqDZDa8yb5Kd8=;
        b=stbTQB4/OQadfeDlK4TUuhmGYV9YXcwQ9+nr+PU4bhli8s3n6r8X/8eMcRLc8d72WU
         LrHOnSLhY/BW3FJOpjHJYjSzLY8owKDAvBUmZ5Y5li4O5IZ1l9DQp98jCAukhfI4sAsK
         367EeviHNa781GiXIjARp2Zt7vO6m0UGAbsfEgG8Qxe0oiHvKWSr7MCFm2+byCQo8SV1
         0EB5iWlkmoqgtjVnS6uDYWUk53eqvdd6LhYf1R1weqRiRhij74hNXpiofiANKlL1cS1w
         IZmT/YhDXijgJq+/W8vL80fnBwCy84oLR30A57E2Kc0E11BiJps5jbJ88Fl7yWGlt4ER
         Q5lA==
X-Gm-Message-State: AOUpUlGNkUrspoSUSSAbX0cHq1CWf5TwAxJs38KxAPkqTLxa9tq8p8o3
        tgO56yYm3ENoWMonQWJXV6Xdki5YlUgmsSqF28k=
X-Google-Smtp-Source: AAOMgpfAkPZFQOfAxYcGdRD8caVQmUeg5KLGG+bylr1nDTiOaPkTAVvFBFdlR6NmhLX5vcD7tgiFpBHzGhJFsfuMAN8=
X-Received: by 2002:a2e:5617:: with SMTP id k23-v6mr19142254ljb.86.1533132099558;
 Wed, 01 Aug 2018 07:01:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 07:01:38 -0700 (PDT)
In-Reply-To: <20180730150142.GA8414@jordon-HP-15-Notebook-PC>
References: <20180730150142.GA8414@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 1 Aug 2018 19:31:38 +0530
Message-ID: <CAFqt6zaGQf+y9xLqusNU7FaAKgN_EyzywnMnVc0sfimFeBJprw@mail.gmail.com>
Subject: Re: [PATCH v2] fs/buffer: Convert return type int to vm_fault_t
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 8:31 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> Return type of block_page_mkwrite() is converted to
> vm_fault_t type. The caller of block_page_mkwrite
> inside fs/nilfs2 nilfs_page_mkwrite converted accordingly.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
> v2: Address Jens's comment. Remove ret variable
>     from block_page_mkwrite().

I am dropping this for now. This will be merged with another
patch and I will resend it.

>
>  fs/buffer.c                 | 16 ++++++++--------
>  fs/nilfs2/file.c            | 13 ++++++++-----
>  include/linux/buffer_head.h |  2 +-
>  3 files changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index cabc045..aeed99f 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2444,21 +2444,21 @@ int block_commit_write(struct page *page, unsigned from, unsigned to)
>   * Direct callers of this function should protect against filesystem freezing
>   * using sb_start_pagefault() - sb_end_pagefault() functions.
>   */
> -int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
> +vm_fault_t block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
>                          get_block_t get_block)
>  {
>         struct page *page = vmf->page;
>         struct inode *inode = file_inode(vma->vm_file);
>         unsigned long end;
>         loff_t size;
> -       int ret;
> +       int err;
>
>         lock_page(page);
>         size = i_size_read(inode);
>         if ((page->mapping != inode->i_mapping) ||
>             (page_offset(page) > size)) {
>                 /* We overload EFAULT to mean page got truncated */
> -               ret = -EFAULT;
> +               err = -EFAULT;
>                 goto out_unlock;
>         }
>
> @@ -2468,18 +2468,18 @@ int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
>         else
>                 end = PAGE_SIZE;
>
> -       ret = __block_write_begin(page, 0, end, get_block);
> -       if (!ret)
> -               ret = block_commit_write(page, 0, end);
> +       err = __block_write_begin(page, 0, end, get_block);
> +       if (!err)
> +               err = block_commit_write(page, 0, end);
>
> -       if (unlikely(ret < 0))
> +       if (unlikely(err < 0))
>                 goto out_unlock;
>         set_page_dirty(page);
>         wait_for_stable_page(page);
>         return 0;
>  out_unlock:
>         unlock_page(page);
> -       return ret;
> +       return block_page_mkwrite_return(err);
>  }
>  EXPORT_SYMBOL(block_page_mkwrite);
>
> diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
> index c5fa3de..da2759e 100644
> --- a/fs/nilfs2/file.c
> +++ b/fs/nilfs2/file.c
> @@ -57,7 +57,8 @@ static int nilfs_page_mkwrite(struct vm_fault *vmf)
>         struct page *page = vmf->page;
>         struct inode *inode = file_inode(vma->vm_file);
>         struct nilfs_transaction_info ti;
> -       int ret = 0;
> +       vm_fault_t ret = VM_FAULT_LOCKED;
> +       int err = 0;
>
>         if (unlikely(nilfs_near_disk_full(inode->i_sb->s_fs_info)))
>                 return VM_FAULT_SIGBUS; /* -ENOSPC */
> @@ -67,7 +68,7 @@ static int nilfs_page_mkwrite(struct vm_fault *vmf)
>         if (page->mapping != inode->i_mapping ||
>             page_offset(page) >= i_size_read(inode) || !PageUptodate(page)) {
>                 unlock_page(page);
> -               ret = -EFAULT;  /* make the VM retry the fault */
> +               ret = VM_FAULT_NOPAGE;  /* make the VM retry the fault */
>                 goto out;
>         }
>
> @@ -99,10 +100,12 @@ static int nilfs_page_mkwrite(struct vm_fault *vmf)
>         /*
>          * fill hole blocks
>          */
> -       ret = nilfs_transaction_begin(inode->i_sb, &ti, 1);
> +       err = nilfs_transaction_begin(inode->i_sb, &ti, 1);
>         /* never returns -ENOMEM, but may return -ENOSPC */
> -       if (unlikely(ret))
> +       if (unlikely(err)) {
> +               ret = block_page_mkwrite_return(err);
>                 goto out;
> +       }
>
>         file_update_time(vma->vm_file);
>         ret = block_page_mkwrite(vma, vmf, nilfs_get_block);
> @@ -117,7 +120,7 @@ static int nilfs_page_mkwrite(struct vm_fault *vmf)
>         wait_for_stable_page(page);
>   out:
>         sb_end_pagefault(inode->i_sb);
> -       return block_page_mkwrite_return(ret);
> +       return ret;
>  }
>
>  static const struct vm_operations_struct nilfs_file_vm_ops = {
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index ed7a81b..7184c6e 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -240,7 +240,7 @@ int cont_write_begin(struct file *, struct address_space *, loff_t,
>                         get_block_t *, loff_t *);
>  int generic_cont_expand_simple(struct inode *inode, loff_t size);
>  int block_commit_write(struct page *page, unsigned from, unsigned to);
> -int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
> +vm_fault_t block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
>                                 get_block_t get_block);
>  /* Convert errno to return value from ->page_mkwrite() call */
>  static inline vm_fault_t block_page_mkwrite_return(int err)
> --
> 1.9.1
>
