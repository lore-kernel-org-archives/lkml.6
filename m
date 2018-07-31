Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914ADC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 23:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3426E2083F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 23:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7c7wakC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3426E2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732815AbeHABUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 21:20:45 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36682 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732751AbeHABUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 21:20:45 -0400
Received: by mail-qt0-f196.google.com with SMTP id t5-v6so17976694qtn.3;
        Tue, 31 Jul 2018 16:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0Mh6CzglfwR9+/6ax2kdCjDaeu56JDjGrKGB4irqV6M=;
        b=s7c7wakCq7O75IR+xLzyHiMrNoLM3giBKXU0YrwHmHJDf1FjpLVVrZjN2lD/BYY7rm
         ElklEQY5v64m+5+VM0Fxa0AC+0RAVADnwrj+5PIrhXWao9pkBwpzsdPw0hUHsB1s1ovR
         43Wxt/20iHkES613MPPtNhjOJ3RzZv7crR6G71+Xr5+KyKjkqFU7Fa1r6uy+0ZmCrgXj
         VYF+QHKUeSmV2XfRUPwvLk4zoT95Khieu/i7vcj4alZnaxY27/Ef9J5hp1ot14gSyvF1
         ouFiSkxUh6LPrKTMKsO5sjO57Mud0qPirENYqF2JTjFZ7cZyt++m7VLvfEGnYDQeaVtg
         oO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0Mh6CzglfwR9+/6ax2kdCjDaeu56JDjGrKGB4irqV6M=;
        b=YpCg8owwiLDvc/6uzISCZPj6BQJx5TSWRgmt1TUPvDl0oRwvNfl6oxwm0TtNn0uL9c
         ceeZLcF+7vgLw6ug+t5r1aY4aELaN/N5Dnzcm5mLL4ev8W70PCC7l9QLRfWx+pvsWkX0
         OPbGD5vK7u6GViJ9yKGC+afTlXuTmE9XuDlpyWxFvsA/nSEuByT5Cf1sMidO4uNyXie1
         kFIgbyhzaq8jq3dpKUPm+Keyk5vcn8Oc0dt9ozw+LCtCXDOuHoKS97RiQUlzg0AQQAPw
         T2ofDg/RhCykZh5d8e8ukonolh4cEkIqTBw9IZAjF4UphGLetyCeWc2KUy6J/XzpHM+K
         obkQ==
X-Gm-Message-State: AOUpUlGbenP/Jl16l+K99RwovpRAyqhqiUacbsE0dd8t7nCoooM19+gC
        bQ42wHq86bxcoNZ2LM5cq6o=
X-Google-Smtp-Source: AAOMgpcVXzBohmvsmgQ0gOSll+ZGiyoEI4y1FBnHGaxWlSPwFxUKbaPq2Ddw9sPK6JMu7QCF7xCS9A==
X-Received: by 2002:aed:3f5d:: with SMTP id q29-v6mr22181190qtf.403.1533080282979;
        Tue, 31 Jul 2018 16:38:02 -0700 (PDT)
Received: from eaf ([181.47.179.0])
        by smtp.gmail.com with ESMTPSA id k3-v6sm12706451qkl.95.2018.07.31.16.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 16:38:02 -0700 (PDT)
Date:   Tue, 31 Jul 2018 20:37:57 -0300
From:   Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        y2038@lists.linaro.org, Jeff Layton <jlayton@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hfs: stop using timespec based interfaces
Message-ID: <20180731233756.24555xk6dvs5hfjb@eaf>
References: <20180619160223.4108556-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180619160223.4108556-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you decide to go with this series after all:

On Tue, Jun 19, 2018 at 06:02:07PM +0200, Arnd Bergmann wrote:
> The native HFS timestamps overflow in year 2040, two years after the Unix
> y2038 overflow. However, the way that the conversion between on-disk
> timestamps and in-kernel timestamps was implemented, 64-bit machines
> actually ended up converting negative UTC timestamps (1902 through 1969)
> into times between 2038 and 2106.
> 
> Rather than making all machines faithfully represent timestamps in the
> ancient past but break after 2040, this changes the file system to
> always use the unsigned UTC interpretation, reading back times between
> 1970 and 2106.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/hfs/hfs_fs.h | 6 ++++--
>  fs/hfs/inode.c  | 4 ++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index 6d0783e2e276..ff432931a5b1 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -245,6 +245,8 @@ extern void hfs_mark_mdb_dirty(struct super_block *sb);
>   *	Unix:	unsigned lil-endian since 00:00 GMT, Jan. 1, 1970
>   *	mac:	unsigned big-endian since 00:00 GMT, Jan. 1, 1904
>   *
> + * We treat all timestamps before 1970 as times after 2038, so this
							 ^^^^
Same as the hfsplus patch, I find this confusing. I think it should say 2040.


Everything else looks good.

Reviewed-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>

> + * actually works until year 2106
>   */
>  #define __hfs_u_to_mtime(sec)	cpu_to_be32(sec + 2082844800U - sys_tz.tz_minuteswest * 60)
>  #define __hfs_m_to_utime(sec)	(be32_to_cpu(sec) - 2082844800U  + sys_tz.tz_minuteswest * 60)
> @@ -252,9 +254,9 @@ extern void hfs_mark_mdb_dirty(struct super_block *sb);
>  #define HFS_I(inode)	(container_of(inode, struct hfs_inode_info, vfs_inode))
>  #define HFS_SB(sb)	((struct hfs_sb_info *)(sb)->s_fs_info)
>  
> -#define hfs_m_to_utime(time)	(struct timespec){ .tv_sec = __hfs_m_to_utime(time) }
> +#define hfs_m_to_utime(time)	(struct timespec64){ .tv_sec = __hfs_m_to_utime(time) }
>  #define hfs_u_to_mtime(time)	__hfs_u_to_mtime((time).tv_sec)
> -#define hfs_mtime()		__hfs_u_to_mtime(get_seconds())
> +#define hfs_mtime()		__hfs_u_to_mtime(ktime_get_real_seconds())
>  
>  static inline const char *hfs_mdb_name(struct super_block *sb)
>  {
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 2a16111d312f..b3309b83371a 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -351,7 +351,7 @@ static int hfs_read_inode(struct inode *inode, void *data)
>  		inode->i_mode &= ~hsb->s_file_umask;
>  		inode->i_mode |= S_IFREG;
>  		inode->i_ctime = inode->i_atime = inode->i_mtime =
> -				timespec_to_timespec64(hfs_m_to_utime(rec->file.MdDat));
> +				hfs_m_to_utime(rec->file.MdDat);
>  		inode->i_op = &hfs_file_inode_operations;
>  		inode->i_fop = &hfs_file_operations;
>  		inode->i_mapping->a_ops = &hfs_aops;
> @@ -362,7 +362,7 @@ static int hfs_read_inode(struct inode *inode, void *data)
>  		HFS_I(inode)->fs_blocks = 0;
>  		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
>  		inode->i_ctime = inode->i_atime = inode->i_mtime =
> -				timespec_to_timespec64(hfs_m_to_utime(rec->dir.MdDat));
> +				hfs_m_to_utime(rec->dir.MdDat);
>  		inode->i_op = &hfs_dir_inode_operations;
>  		inode->i_fop = &hfs_dir_operations;
>  		break;
> -- 
> 2.9.0
> 
