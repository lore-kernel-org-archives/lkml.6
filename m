Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965507AbeCACpR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 21:45:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:46714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965468AbeCACpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 21:45:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DDE21795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
Date: Wed, 28 Feb 2018 18:45:15 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix to restore whint_mode in ->remount_fs
Message-ID: <20180301024515.GB18665@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180228140120.8758-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228140120.8758-1-chao@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> If we fail in ->remount_fs, it needs to restore old whint_mode as other
> mount options.
> 
> Fixes: e25afe01822f ("f2fs: support passing down write hints given by users to block layer")

Hi Chao,

It was not merged, so please allow me to integrate this into the original
patch.

Thanks,

> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 89abe4087e66..8a93f78efca2 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1512,6 +1512,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>  		sbi->s_qf_names[i] = s_qf_names[i];
>  	}
>  #endif
> +	sbi->whint_mode = old_whint_mode;
>  	sbi->mount_opt = org_mount_opt;
>  	sbi->active_logs = active_logs;
>  	sb->s_flags = old_sb_flags;
> -- 
> 2.14.1.145.gb3622a4ee
