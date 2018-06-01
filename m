Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753235AbeFAPc4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:32:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:53232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752989AbeFAPcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:32:53 -0400
Date: Fri, 1 Jun 2018 17:32:51 +0200
From: Jan Kara <jack@suse.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: Re: linux-next: manual merge of the vfs tree with the ext3 tree
Message-ID: <20180601153251.nqvshww6x3x7dkzz@quack2.suse.cz>
References: <20180601115619.73a8f966@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601115619.73a8f966@canb.auug.org.au>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri 01-06-18 11:56:19, Stephen Rothwell wrote:
> Today's linux-next merge of the vfs tree got a conflict in:
> 
>   include/linux/fs.h
> 
> between commit:
> 
>   29aca8b3f7cd ("fsnotify: introduce prototype struct fsnotify_obj")
> 
> from the ext3 tree and commit:
> 
>   d9a08a9e616b ("fs: Add aio iopriority support")
> 
> from the vfs tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks, the resolution looks good to me.

								Honza

> diff --cc include/linux/fs.h
> index d1f3d572349f,482563fe549c..000000000000
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@@ -36,7 -36,7 +36,8 @@@
>   #include <linux/delayed_call.h>
>   #include <linux/uuid.h>
>   #include <linux/errseq.h>
>  +#include <linux/fsnotify_obj.h>
> + #include <linux/ioprio.h>
>   
>   #include <asm/byteorder.h>
>   #include <uapi/linux/fs.h>
> @@@ -1717,9 -1713,10 +1719,11 @@@ struct file_operations 
>   	int (*iterate) (struct file *, struct dir_context *);
>   	int (*iterate_shared) (struct file *, struct dir_context *);
>   	__poll_t (*poll) (struct file *, struct poll_table_struct *);
> + 	struct wait_queue_head * (*get_poll_head)(struct file *, __poll_t);
> + 	__poll_t (*poll_mask) (struct file *, __poll_t);
>   	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
>   	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
>  +	int (*pre_mmap) (struct file *, unsigned long, unsigned long);
>   	int (*mmap) (struct file *, struct vm_area_struct *);
>   	unsigned long mmap_supported_flags;
>   	int (*open) (struct inode *, struct file *);


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
