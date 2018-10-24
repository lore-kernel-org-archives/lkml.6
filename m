Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769F0C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E29A2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOnDz+sN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E29A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeJXOnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 10:43:11 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39572 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeJXOnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 10:43:11 -0400
Received: by mail-yb1-f195.google.com with SMTP id j9-v6so1640375ybj.6;
        Tue, 23 Oct 2018 23:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cCoeWtZQEUrZJ3D9lPW3kEHG5VvHvK5ZQabu9zHqC9g=;
        b=oOnDz+sNFd8LBKnE8FlsGKu9aC2MFRhXB8EBvT4ZSW98zkYXywly9Mk+OTG45G8/i6
         ebRvv39roE6o3h/d+3htM8eXUXfUUeBTcZ+Ghbw+7NG+SLAAQC58fXD1cTluC24FXmR2
         QW9gJmyHt4ne5DNVyUhthj47HWTyYUeapntt+g3sws+fz8haya675zzIJHidcxRVi2VD
         HNCZJDIHUJd9rrymyoyMAUf1P4tVibf/uOh7LUTezCT6MgT3szR35xm0vR/MxMQuH8ac
         ednzLvnsD5ByS1m+kym6hx3JGcRMDeU7dyqBw6DiJhUTXObyq+QLdGQcztw58jICX5eL
         jTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cCoeWtZQEUrZJ3D9lPW3kEHG5VvHvK5ZQabu9zHqC9g=;
        b=oigdRZlr+L3DMuiVIf9jLXi9aIEwfRhPjLRDkyQ25zlHoIFm3HFtqbQ29l4FgpyZxi
         QBZ75CXsZOzs8o9TRUqFhNoSnD5ecj6Y5p7ZfblNwRAcvTLEM2IAAr9bpxByokFZ4+Wj
         7V8gq2MIBYpGVVNkwBOQnLIyuJYXUwRzpyO8mS6mPtoBxG+HwQ97D5JBx4FcuYYxPPnM
         j1EW3MjTmeRCxV+aoM76SIkvz4E9uCs9OlEzRPYTxIhmgBEh6BTVCzqfkrfAbZPRX6UR
         2uLj9GyE6sK8t/vrUhGYh66e+p4ag+ovHPIcHY7SbHtP7uxTHwbd7jtlFrxLJQQS3zd1
         a7Aw==
X-Gm-Message-State: AGRZ1gKywZS9EwsS7P6kV5TbvQj5CX06TIDClrZVtEwLvVY+2tH0vkHI
        WZt8dBmw8YGaOJksXgVOKikTtWmziH/7LJ/YchfzRF5s
X-Google-Smtp-Source: AJdET5dN15yVeiu5FOom1UuS1DKqduiWz/17mPjsuB7n4Gti4UJLTY00tjZUPs7KH6mTQa2TYNziQuKI/JHGzVtJFnI=
X-Received: by 2002:a25:6607:: with SMTP id a7-v6mr1059417ybc.507.1540361791512;
 Tue, 23 Oct 2018 23:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181023201953.GA15687@pathfinder>
In-Reply-To: <20181023201953.GA15687@pathfinder>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Oct 2018 09:16:20 +0300
Message-ID: <CAOQ4uxjfChxZyAUiYKQ-UiVjmxsosR+KG1ZSBu2TOeuAX3vJnA@mail.gmail.com>
Subject: Re: [RFC][PATCH v3 01/10] fs: common implementation of file type
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 11:19 PM Phillip Potter <phil@philpotter.co.uk> wrote:
>
> Many file systems use a copy&paste implementation
> of dirent to on-disk file type conversions.
>
> Create a common implementation to be used by file systems
> with some useful conversion helpers to reduce open coded
> file type conversions in file system code.
>
> Original patch written by Amir Goldstein.

Looks good.
I guess you used 'git apply' or just 'patch'
What you usually do when applying someone else mostly unchanged
patches is use 'git am -s -3' so you preserve the original author and
original commit message including the Signed-of-by line.
You can edit your patch by hand to change the From: line to change the
author and add
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
(you sign below me as you changed the patch last)

>
> v3:
> - Rebased against Linux 4.19 by Phillip Potter
> - Added SPDX tag to new include/linux/file_type.h
> - Added include/linux/file_type.h to MAINTAINERS
>

As you can see in my original posting, this part comes after the ---
line which means it will not be included in the commit message,
because the specific development history of this patch may be interesting
for reviewers but it is less interesting in the context of git log.

> v2:
> - s/DT_MASK/S_DT_MASK to fix redefinition in drivers/scsi/qla2xxx/qla_def.h
> - Explicit initialization of fs_dtype_by_ftype[] using [FT_*] = DT_*
>
> v1:
> - Initial implementation
>
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  MAINTAINERS               |   1 +
>  include/linux/file_type.h | 108 ++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h        |  17 +-----
>  3 files changed, 110 insertions(+), 16 deletions(-)
>  create mode 100644 include/linux/file_type.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b2f710eee67a..8e5b029886e6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5689,6 +5689,7 @@ L:        linux-fsdevel@vger.kernel.org
>  S:     Maintained
>  F:     fs/*
>  F:     include/linux/fs.h
> +F:     include/linux/file_type.h
>  F:     include/uapi/linux/fs.h
>
>  FINTEK F75375S HARDWARE MONITOR AND FAN CONTROLLER DRIVER
> diff --git a/include/linux/file_type.h b/include/linux/file_type.h
> new file mode 100644
> index 000000000000..f015c41ca90c
> --- /dev/null
> +++ b/include/linux/file_type.h
> @@ -0,0 +1,108 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_FILE_TYPE_H
> +#define _LINUX_FILE_TYPE_H
> +
> +/*
> + * This is a common implementation of dirent to fs on-disk
> + * file type conversion.  Although the fs on-disk bits are
> + * specific to every file system, in practice, many file systems
> + * use the exact same on-disk format to describe the lower 3
> + * file type bits that represent the 7 POSIX file types.
> + * All those file systems can use this generic code for the
> + * conversions:
> + *  i_mode -> fs on-disk file type (ftype)
> + *  fs on-disk file type (ftype) -> dirent file type (dtype)
> + *  i_mode -> dirent file type (dtype)
> + */
> +
> +/*
> + * struct dirent file types
> + * exposed to user via getdents(2), readdir(3)
> + *
> + * These match bits 12..15 of stat.st_mode
> + * (ie "(i_mode >> 12) & 15").
> + */
> +#define S_DT_SHIFT     12
> +#define S_DT(mode)     (((mode) & S_IFMT) >> S_DT_SHIFT)
> +#define S_DT_MASK      (S_IFMT >> S_DT_SHIFT)
> +
> +#define DT_UNKNOWN     0
> +#define DT_FIFO                S_DT(S_IFIFO) /* 1 */
> +#define DT_CHR         S_DT(S_IFCHR) /* 2 */
> +#define DT_DIR         S_DT(S_IFDIR) /* 4 */
> +#define DT_BLK         S_DT(S_IFBLK) /* 6 */
> +#define DT_REG         S_DT(S_IFREG) /* 8 */
> +#define DT_LNK         S_DT(S_IFLNK) /* 10 */
> +#define DT_SOCK                S_DT(S_IFSOCK) /* 12 */
> +#define DT_WHT         14
> +
> +#define DT_MAX         (S_DT_MASK + 1) /* 16 */
> +
> +/*
> + * fs on-disk file types.
> + * Only the low 3 bits are used for the POSIX file types.
> + * Other bits are reserved for fs private use.
> + *
> + * Note that no fs currently stores the whiteout type on-disk,
> + * so whiteout dirents are exposed to user as DT_CHR.
> + */
> +#define FT_UNKNOWN     0
> +#define FT_REG_FILE    1
> +#define FT_DIR         2
> +#define FT_CHRDEV      3
> +#define FT_BLKDEV      4
> +#define FT_FIFO                5
> +#define FT_SOCK                6
> +#define FT_SYMLINK     7
> +
> +#define FT_MAX         8
> +
> +/*
> + * fs on-disk file type to dirent file type conversion
> + */
> +static unsigned char fs_dtype_by_ftype[FT_MAX] = {
> +       [FT_UNKNOWN]    = DT_UNKNOWN,
> +       [FT_REG_FILE]   = DT_REG,
> +       [FT_DIR]        = DT_DIR,
> +       [FT_CHRDEV]     = DT_CHR,
> +       [FT_BLKDEV]     = DT_BLK,
> +       [FT_FIFO]       = DT_FIFO,
> +       [FT_SOCK]       = DT_SOCK,
> +       [FT_SYMLINK]    = DT_LNK
> +};
> +
> +static inline unsigned char fs_dtype(int filetype)
> +{
> +       if (filetype >= FT_MAX)
> +               return DT_UNKNOWN;
> +
> +       return fs_dtype_by_ftype[filetype];
> +}
> +
> +/*
> + * dirent file type to fs on-disk file type conversion
> + * Values not initialized explicitly are FT_UNKNOWN (0).
> + */
> +static unsigned char fs_ftype_by_dtype[DT_MAX] = {
> +       [DT_REG]        = FT_REG_FILE,
> +       [DT_DIR]        = FT_DIR,
> +       [DT_LNK]        = FT_SYMLINK,
> +       [DT_CHR]        = FT_CHRDEV,
> +       [DT_BLK]        = FT_BLKDEV,
> +       [DT_FIFO]       = FT_FIFO,
> +       [DT_SOCK]       = FT_SOCK,
> +};
> +
> +/* st_mode to fs on-disk file type conversion */
> +static inline unsigned char fs_umode_to_ftype(umode_t mode)
> +{
> +       return fs_ftype_by_dtype[S_DT(mode)];
> +}
> +
> +/* st_mode to dirent file type conversion */
> +static inline unsigned char fs_umode_to_dtype(umode_t mode)
> +{
> +       return fs_dtype(fs_umode_to_ftype(mode));
> +}
> +
> +#endif
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 897eae8faee1..b42f04acf06e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -37,6 +37,7 @@
>  #include <linux/uuid.h>
>  #include <linux/errseq.h>
>  #include <linux/ioprio.h>
> +#include <linux/file_type.h>
>
>  #include <asm/byteorder.h>
>  #include <uapi/linux/fs.h>
> @@ -1663,22 +1664,6 @@ int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
>                             u64 phys, u64 len, u32 flags);
>  int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags);
>
> -/*
> - * File types
> - *
> - * NOTE! These match bits 12..15 of stat.st_mode
> - * (ie "(i_mode >> 12) & 15").
> - */
> -#define DT_UNKNOWN     0
> -#define DT_FIFO                1
> -#define DT_CHR         2
> -#define DT_DIR         4
> -#define DT_BLK         6
> -#define DT_REG         8
> -#define DT_LNK         10
> -#define DT_SOCK                12
> -#define DT_WHT         14
> -
>  /*
>   * This is the "filldir" function type, used by readdir() to let
>   * the kernel specify what kind of dirent layout it wants to have.
> --
> 2.17.2
>
