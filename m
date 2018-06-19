Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E24C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07E820652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20150623.gappssmtp.com header.i=@dubeyko-com.20150623.gappssmtp.com header.b="ZaSPlTgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07E820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030266AbeFSRDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:03:35 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35558 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966775AbeFSRDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:03:31 -0400
Received: by mail-pg0-f68.google.com with SMTP id 15-v6so153094pge.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RqxTRsQqX/Q5LghG+a6ognQu3YrlW4v9njWDPa68XuI=;
        b=ZaSPlTgU1kl0BDlR1SOdIa/+Fxv3Hq1M/1ohQYAEqu8K+EUcYN9ZbvOC+G0eoZeC2M
         7S8bPwCfO+7Fw+7U//ZD5WYXf4sSiTuzT66QhkrfqGH//B5cr09/OErKgMtajj8oua4y
         LQNb6e64gjlxLjqxceUvvFRITrukH6hUuWN+349kkU7w4UcFSDoN2Vv57CJ8J1AJUkyv
         tdIRyafuhAAVFWH5SK/OmH2RhGa6Ktfek9ddn1b8mtSwz6yJD5+gbIUw7F8gWvx6Zpu3
         8Qu/WwTQfamm/uuPkeEuA5vZsQHZkEUufk09PlHpWd3emyr5dvT/YhDbZ3LhVKRR0JsB
         BWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RqxTRsQqX/Q5LghG+a6ognQu3YrlW4v9njWDPa68XuI=;
        b=WWxKIPjO8tkpsIYCb7EeojLE9NpVKC6k/rjEkYYiOoXt03Wojqq9AkVfx9Zw72LZUJ
         WkcQVsjenAgzzxNRPVA998VRQ5NnKYEKkR+PfHaeft42Cgg6X1ZxHQtQCpwoqREDDg+8
         tdEa3JaXyflF6ulvk8vY9X/j+BOkePqZJWzvq7QlCdkgk5oaRYISyUQZuEv4KHFThr6Z
         Qjp2SQJJpY8ksWS72KDyJ3+dgYB4E1xz3DTVmSBK5XOXrEvCAQjojxWRNHJHAxB74q2N
         LiBcmmSNajqDH2QmaUWWfFl8F8ltFZfhh6YWKazLOAQOgAzMrIOu+5LOrn4Au2vY+7T9
         5yww==
X-Gm-Message-State: APt69E2qD4gYCxg2xWY2on3GG/5cZcTYbuZ6e4YdxILKIKWcoTCqFnr7
        j/aQ3PNmsxRrGvWB2Ey+aN2uVA==
X-Google-Smtp-Source: ADUXVKJUILExQtOPH6EDdt8yBhG4U24O9RBjiuDFg8+x+nihxVocCqQtccoofuy0q0f0wdzKxilXag==
X-Received: by 2002:a62:c4dd:: with SMTP id h90-v6mr19222852pfk.86.1529427811210;
        Tue, 19 Jun 2018 10:03:31 -0700 (PDT)
Received: from ubuntu-16 (c-24-130-14-162.hsd1.ca.comcast.net. [24.130.14.162])
        by smtp.gmail.com with ESMTPSA id z12-v6sm149599pgu.57.2018.06.19.10.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 10:03:30 -0700 (PDT)
Message-ID: <1529427809.2624.16.camel@dubeyko.com>
Subject: Re: [PATCH 1/3] hfs: stop using timespec based interfaces
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     y2038@lists.linaro.org, Jeff Layton <jlayton@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Jun 2018 10:03:29 -0700
In-Reply-To: <20180619160223.4108556-1-arnd@arndb.de>
References: <20180619160223.4108556-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-19 at 18:02 +0200, Arnd Bergmann wrote:
> The native HFS timestamps overflow in year 2040, two years after the
> Unix
> y2038 overflow. However, the way that the conversion between on-disk
> timestamps and in-kernel timestamps was implemented, 64-bit machines
> actually ended up converting negative UTC timestamps (1902 through
> 1969)
> into times between 2038 and 2106.
> 
> Rather than making all machines faithfully represent timestamps in
> the
> ancient past but break after 2040, this changes the file system to
> always use the unsigned UTC interpretation, reading back times
> between
> 1970 and 2106.
> 

The trouble with HFS and HFS+ that the specification [1] declares this:

"HFS Plus stores dates in several data structures, including the volume
header and catalog records. These dates are stored in unsigned 32-bit
integers (UInt32) containing the number of seconds since midnight,
January 1, 1904, GMT. This is slightly different from HFS, where the
value represents local time. The maximum representable date is February
6, 2040 at 06:28:15 GMT."

So, I am not sure that we are able to support later dates because such
timestamps cannot be stored on HFS/HFS+ volumes and will be
incompatible with Mac OS X. Also, I am not sure that anybody will use
HFS/HFS+ after 2040.

Thanks,
Vyacheslav Dubeyko.

[1] https://developer.apple.com/library/archive/technotes/tn/tn1150.html


> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/hfs/hfs_fs.h | 6 ++++--
>  fs/hfs/inode.c  | 4 ++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index 6d0783e2e276..ff432931a5b1 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -245,6 +245,8 @@ extern void hfs_mark_mdb_dirty(struct super_block
> *sb);
>   *	Unix:	unsigned lil-endian since 00:00 GMT, Jan. 1,
> 1970
>   *	mac:	unsigned big-endian since 00:00 GMT, Jan. 1,
> 1904
>   *
> + * We treat all timestamps before 1970 as times after 2038, so this
> + * actually works until year 2106
>   */
>  #define __hfs_u_to_mtime(sec)	cpu_to_be32(sec + 2082844800U -
> sys_tz.tz_minuteswest * 60)
>  #define __hfs_m_to_utime(sec)	(be32_to_cpu(sec) -
> 2082844800U  + sys_tz.tz_minuteswest * 60)
> @@ -252,9 +254,9 @@ extern void hfs_mark_mdb_dirty(struct super_block
> *sb);
>  #define HFS_I(inode)	(container_of(inode, struct
> hfs_inode_info, vfs_inode))
>  #define HFS_SB(sb)	((struct hfs_sb_info *)(sb)->s_fs_info)
>  
> -#define hfs_m_to_utime(time)	(struct timespec){ .tv_sec =
> __hfs_m_to_utime(time) }
> +#define hfs_m_to_utime(time)	(struct timespec64){ .tv_sec =
> __hfs_m_to_utime(time) }
>  #define hfs_u_to_mtime(time)	__hfs_u_to_mtime((time).tv_sec)
> -#define hfs_mtime()		__hfs_u_to_mtime(get_seconds())
> +#define hfs_mtime()		__hfs_u_to_mtime(ktime_get_real_s
> econds())
>  
>  static inline const char *hfs_mdb_name(struct super_block *sb)
>  {
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 2a16111d312f..b3309b83371a 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -351,7 +351,7 @@ static int hfs_read_inode(struct inode *inode,
> void *data)
>  		inode->i_mode &= ~hsb->s_file_umask;
>  		inode->i_mode |= S_IFREG;
>  		inode->i_ctime = inode->i_atime = inode->i_mtime =
> -				timespec_to_timespec64(hfs_m_to_utim
> e(rec->file.MdDat));
> +				hfs_m_to_utime(rec->file.MdDat);
>  		inode->i_op = &hfs_file_inode_operations;
>  		inode->i_fop = &hfs_file_operations;
>  		inode->i_mapping->a_ops = &hfs_aops;
> @@ -362,7 +362,7 @@ static int hfs_read_inode(struct inode *inode,
> void *data)
>  		HFS_I(inode)->fs_blocks = 0;
>  		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb-
> >s_dir_umask);
>  		inode->i_ctime = inode->i_atime = inode->i_mtime =
> -				timespec_to_timespec64(hfs_m_to_utim
> e(rec->dir.MdDat));
> +				hfs_m_to_utime(rec->dir.MdDat);
>  		inode->i_op = &hfs_dir_inode_operations;
>  		inode->i_fop = &hfs_dir_operations;
>  		break;
