Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512E6C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DBD20875
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXX0ZU6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DBD20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754200AbeFTWqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:46:02 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34797 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753651AbeFTWqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:46:00 -0400
Received: by mail-qk0-f196.google.com with SMTP id q70-v6so744817qke.1;
        Wed, 20 Jun 2018 15:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ENMzouPXFPxc/mwmfEGBAa2xH+v0dRkuojp2f9YgbCg=;
        b=BXX0ZU6AmcWKIWslc4/Zt/s3t/RNYq5XWHj/7OhbBjwbNZe4tPJIkR5M3h1xwRsVA4
         Uc6WvEAl58IJ1Twq7pNkmQO4MyB6qrfptmzD9NdwirIJdZIshYAp3KLNqYw5JiIVLZpk
         cOnLypgJpZmRRpOPHi0QdRzrNuWGK7DDOIZePief2DvUdSkhuKfBxyyeAx173IIPG4Ad
         BrNKDV0M0rRyAEUtADWzwwSC74SJkbWydYiC5pV+TwUhspN8SnGUGiXSQOjtO9r/lTdy
         79YEuNaNJzoiZw6OceotfYEeluLiVU+GuVGjLXhnvwwKjjpiq91kQNj4xO4qWhlhSLDJ
         YgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ENMzouPXFPxc/mwmfEGBAa2xH+v0dRkuojp2f9YgbCg=;
        b=BviVJnTisabSvcOt9YacAi+YBvP9Nt3t5FEdDT2Qj2S//XIF+S89a4rkc6umbEDRhj
         VgI2wtzSwPA+n0f5wQtQRRxfsSr7PylBzm0iVQZWMw5T+p9cYLiZCMu6x7svWEav5Y+z
         2YPfUoymYQE6PXMAdtQ1LmKs/WwQjA09k/hQWWHx8a1OdHOWPvVFwPJRLsPDKumHLbTF
         qjo1GNMFb914pKI44Cep9dKM5KsUJdowI7w3NZUN5jzigWmIJsl+zaBdb+XKGX24Q9Od
         aSb/XUeS4LdbtRupXhzcP6il2FT5Lua8Kv55Y5vjkjXdtZCIKYFN7I4d498rGr5XD8Ea
         qfZw==
X-Gm-Message-State: APt69E3ijdUgLLyIvRMuhZCJKvFYdIzkPlz+hoaww24bxwpRxvXIVYNK
        2OheTu5UJ87+o6HOKKmnEP4=
X-Google-Smtp-Source: ADUXVKJRMuwk2JtrYzxlSeOF30UWtrd41D02UFGPFcK6Fc+/k0oHLZEnVoXQJ+NZVyGKLUxrz8G5kQ==
X-Received: by 2002:a37:5704:: with SMTP id l4-v6mr19348320qkb.53.1529534760040;
        Wed, 20 Jun 2018 15:46:00 -0700 (PDT)
Received: from eaf ([181.47.179.0])
        by smtp.gmail.com with ESMTPSA id w46-v6sm2967416qtw.55.2018.06.20.15.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 15:45:59 -0700 (PDT)
Date:   Wed, 20 Jun 2018 19:45:54 -0300
From:   Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        y2038@lists.linaro.org, Vyacheslav Dubeyko <slava@dubeyko.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ernesto A. Fernandez" <ernesto.mnd.fernandez@gmail.com>
Subject: Re: [PATCH 3/3] hfsplus: return inode birthtime for statx
Message-ID: <20180620224553.wfz6abuvvz4ul42d@eaf>
References: <20180619160223.4108556-1-arnd@arndb.de>
 <20180619160223.4108556-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619160223.4108556-3-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

On Tue, Jun 19, 2018 at 06:02:09PM +0200, Arnd Bergmann wrote:
> We have the data in the kernel, so we might just as well provide it to
> user space.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/hfsplus/dir.c        |  1 +
>  fs/hfsplus/hfsplus_fs.h |  2 ++
>  fs/hfsplus/inode.c      | 14 ++++++++++++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
> index b5254378f011..df14b6dd5b5a 100644
> --- a/fs/hfsplus/dir.c
> +++ b/fs/hfsplus/dir.c
> @@ -566,6 +566,7 @@ const struct inode_operations hfsplus_dir_inode_operations = {
>  	.symlink		= hfsplus_symlink,
>  	.mknod			= hfsplus_mknod,
>  	.rename			= hfsplus_rename,
> +	.getattr		= hfsplus_getattr,
>  	.listxattr		= hfsplus_listxattr,
>  #ifdef CONFIG_HFSPLUS_FS_POSIX_ACL
>  	.get_acl		= hfsplus_get_posix_acl,
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 646c207be38d..1a6b469f8d22 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -489,6 +489,8 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd);
>  int hfsplus_cat_write_inode(struct inode *inode);
>  int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
>  		       int datasync);
> +int hfsplus_getattr(const struct path *path, struct kstat *stat,
> +		    u32 request_mask, unsigned int query_flags);
>  
>  /* ioctl.c */
>  long hfsplus_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
> diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> index c0c8d433864f..f9bb568f9479 100644
> --- a/fs/hfsplus/inode.c
> +++ b/fs/hfsplus/inode.c
> @@ -276,6 +276,19 @@ static int hfsplus_setattr(struct dentry *dentry, struct iattr *attr)
>  	return 0;
>  }
>  
> +int hfsplus_getattr(const struct path *path, struct kstat *stat,
> +		     u32 request_mask, unsigned int query_flags)
> +{
> +	struct inode *inode = d_backing_inode(path->dentry);

I think d_inode() is better. They work the same, but "normal filesystems
should not use this", according to the d_backing_inode() documentation.

> +
> +	generic_fillattr(inode, stat);
> +
> +	stat->btime = hfsp_mt2ut(HFSPLUS_I(inode)->create_date);
> +	stat->result_mask |= STATX_BTIME;
> +
> +	return 0;
> +}
> +
>  int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
>  		       int datasync)
>  {
> @@ -335,6 +348,7 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
>  
>  static const struct inode_operations hfsplus_file_inode_operations = {
>  	.setattr	= hfsplus_setattr,
> +	.getattr	= hfsplus_getattr,
>  	.listxattr	= hfsplus_listxattr,
>  #ifdef CONFIG_HFSPLUS_FS_POSIX_ACL
>  	.get_acl	= hfsplus_get_posix_acl,
> -- 
> 2.9.0
> 

What about symlinks and special files?

Thanks,
Ernest
