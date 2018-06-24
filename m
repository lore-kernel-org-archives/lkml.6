Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D58C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 03:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB0A24DA2
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 03:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nj4fG1TW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB0A24DA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeFXDLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 23:11:50 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33114 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbeFXDLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 23:11:48 -0400
Received: by mail-qk0-f195.google.com with SMTP id c131-v6so5814820qkb.0;
        Sat, 23 Jun 2018 20:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WCYZjayHPeOo101RUDqUFOnd790ThRQM+zjP7051D3g=;
        b=Nj4fG1TW1Bm6YthljO9gnD8uIB8jlgaQQlF7KUtLhUrjGCVPAL46mm4wiEa5mDK76W
         l9iK2jyoX2KIBk5lSCBLyqkVD+gFSpjnhlTRU/+U/aeTE/40FpfxHbnL4Cn1U5Z1MrIQ
         Caxmes6TEAy+oaF8rg4lP3Oan/vJMODDYtJqFJKia8hEoxhUwykvQn6XoyXGOTFOa4tc
         RsvRqu0Dn7JYmXFjYSFKpHB5/oD0JqOL8tyNBEyX9AS91eyyybZO/ECFjBZtuEAmnd9M
         sTM3jLEjpqUbq6xPGX5DCeLHJf3Oa9a9fstQ8yeSNipwaaRXthTtudCieiKyXyjCTg+u
         lUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WCYZjayHPeOo101RUDqUFOnd790ThRQM+zjP7051D3g=;
        b=sJ4F56ueUrOref0aBja0RRNGVKw6Y9Wb2I/urGblhh5VJ/hn6glFMlu7hWT+X6iTUN
         odl7Vj7YtoB6lCppZcMMrQSZsIJxe6uap9gFP2mKjSbRd/74O5AbVPyRzmc32KRTozvR
         e/DRYXG76LZt9YnMjjjmn8H2onPU4ytNWvl/hsWKuz1Wc/UDZSUbPLkNKgSHhfD/VQLm
         eaDI3IIDqk6mEiqegvg65tj7QGPacAlOvd1z9uHIAn6WpcdVbXF/GZwEBfThjvq708KR
         +0RD2NdMLQzf2Puz9/oH8j9xSEq+FtesouyqCKImTe7yksyrHei1xILtsdBmxaYc7uYx
         wjig==
X-Gm-Message-State: APt69E05BGrzUfQdBVtDRWkxSO9naHHshN5MCMmJyI2oHaQzCN5YEubo
        1755ucysOYHyZjhnF8oIY9Q=
X-Google-Smtp-Source: AAOMgpcdMms5csGVxa5vkywtxCpQgzYBjzm/NY8cf+/lw2UGVp/2iNp7QdB+Jib84IUsrP4/C5sjUw==
X-Received: by 2002:a37:97c4:: with SMTP id z187-v6mr6410630qkd.196.1529809907773;
        Sat, 23 Jun 2018 20:11:47 -0700 (PDT)
Received: from eaf ([181.47.179.0])
        by smtp.gmail.com with ESMTPSA id s126-v6sm6873912qkd.24.2018.06.23.20.11.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Jun 2018 20:11:47 -0700 (PDT)
Date:   Sun, 24 Jun 2018 00:11:41 -0300
From:   Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        y2038@lists.linaro.org, Vyacheslav Dubeyko <slava@dubeyko.com>,
        Jan Kara <jack@suse.cz>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Jeff Layton <jlayton@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hfsplus: stop using timespec based interfaces
Message-ID: <20180624031140.wwvtcajxyxahqntp@eaf>
References: <20180619160223.4108556-1-arnd@arndb.de>
 <20180619160223.4108556-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180619160223.4108556-2-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 06:02:08PM +0200, Arnd Bergmann wrote:
> The native HFS+ timestamps overflow in year 2040, two years after the Unix
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
>  fs/hfsplus/hfsplus_fs.h |  7 ++++---
>  fs/hfsplus/inode.c      | 12 ++++++------
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index d9255abafb81..646c207be38d 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -530,13 +530,14 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector, void *buf,
>  		       void **data, int op, int op_flags);
>  int hfsplus_read_wrapper(struct super_block *sb);
>  
> -/* time macros */
> +/* time macros: convert between 1904-2040 and 1970-2106 range,
> + * pre-1970 timestamps are interpreted as post-2038 times after wrap-around
						  ^^^^
If we are talking about on-disk timestamps, this should be 2040.


Everything else looks fine, if it helps you can use:

Reviewed-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>

> */
>  #define __hfsp_mt2ut(t)		(be32_to_cpu(t) - 2082844800U)
>  #define __hfsp_ut2mt(t)		(cpu_to_be32(t + 2082844800U))
>  
>  /* compatibility */
> -#define hfsp_mt2ut(t)		(struct timespec){ .tv_sec = __hfsp_mt2ut(t) }
> +#define hfsp_mt2ut(t)		(struct timespec64){ .tv_sec = __hfsp_mt2ut(t) }
>  #define hfsp_ut2mt(t)		__hfsp_ut2mt((t).tv_sec)
> -#define hfsp_now2mt()		__hfsp_ut2mt(get_seconds())
> +#define hfsp_now2mt()		__hfsp_ut2mt(ktime_get_real_seconds())
>  
>  #endif
> diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> index c824f702feec..c0c8d433864f 100644
> --- a/fs/hfsplus/inode.c
> +++ b/fs/hfsplus/inode.c
> @@ -493,9 +493,9 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
>  		hfsplus_get_perms(inode, &folder->permissions, 1);
>  		set_nlink(inode, 1);
>  		inode->i_size = 2 + be32_to_cpu(folder->valence);
> -		inode->i_atime = timespec_to_timespec64(hfsp_mt2ut(folder->access_date));
> -		inode->i_mtime = timespec_to_timespec64(hfsp_mt2ut(folder->content_mod_date));
> -		inode->i_ctime = timespec_to_timespec64(hfsp_mt2ut(folder->attribute_mod_date));
> +		inode->i_atime = hfsp_mt2ut(folder->access_date);
> +		inode->i_mtime = hfsp_mt2ut(folder->content_mod_date);
> +		inode->i_ctime = hfsp_mt2ut(folder->attribute_mod_date);
>  		HFSPLUS_I(inode)->create_date = folder->create_date;
>  		HFSPLUS_I(inode)->fs_blocks = 0;
>  		if (folder->flags & cpu_to_be16(HFSPLUS_HAS_FOLDER_COUNT)) {
> @@ -531,9 +531,9 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
>  			init_special_inode(inode, inode->i_mode,
>  					   be32_to_cpu(file->permissions.dev));
>  		}
> -		inode->i_atime = timespec_to_timespec64(hfsp_mt2ut(file->access_date));
> -		inode->i_mtime = timespec_to_timespec64(hfsp_mt2ut(file->content_mod_date));
> -		inode->i_ctime = timespec_to_timespec64(hfsp_mt2ut(file->attribute_mod_date));
> +		inode->i_atime = hfsp_mt2ut(file->access_date);
> +		inode->i_mtime = hfsp_mt2ut(file->content_mod_date);
> +		inode->i_ctime = hfsp_mt2ut(file->attribute_mod_date);
>  		HFSPLUS_I(inode)->create_date = file->create_date;
>  	} else {
>  		pr_err("bad catalog entry used to create inode\n");
> -- 
> 2.9.0
> 
