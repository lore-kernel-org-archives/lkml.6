Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E49C43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E172146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV8JjroV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E172146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390711AbeGKWxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 18:53:05 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39506 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389532AbeGKWxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 18:53:04 -0400
Received: by mail-qk0-f196.google.com with SMTP id b5-v6so12540190qkg.6;
        Wed, 11 Jul 2018 15:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9ovVSN8g+dAMIdmcFbeLQHGI+jDdENVw8OatRbv0edI=;
        b=kV8JjroVpSS1OGGEATEVgj6HZmd9jI5tx9eGHZ5Z9pQeyWFpd702goki8Jwz4UXJ5l
         4oh5EgYNyNuHAQ5tZ1xgJd7jB3Uoils4z13qLHgbUu3jILeT9Su9DLyKFKZ5wllToU7G
         Jp7Uilj8drxwBsONjg6Uur0+xaoDKRXY91gOxoCJJmuRyQcuAJLIYZ6wLiIaafw4zGPl
         3T9DQaJSHKWZGL+7ZATLRhl+yr5Jwpj/kqD5rENpq1aAt6SoJHwqezlRWBJMvdXoabsu
         Nw0Wp5bjWkL54pD78m6OX6MUeyxP/IbPuO6zSqiYGr1lnshaOfIYaZ0YizOVjtTjvA1S
         XVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ovVSN8g+dAMIdmcFbeLQHGI+jDdENVw8OatRbv0edI=;
        b=sKeuNuM9Xpj+TdFtYKzdE8YrSR2WE3rEsOXw0ym9BNlqdLMElUkgknOm7pvjnRbK5I
         dHIeUfTSCBF7PcrjL1k0tBSNm5RNYjwnNmzCqf5zrFaLQ46zX487UrAPVGaT/ZqjIjcu
         3AYYEepYiHp5M1oi7iC61roBP/DUj6aujmwyLK9FdcTDwiUoJkA19iPOeQRlaevmgh6k
         YTP8MfeEjqo2aiJLO6GfSQfbjtNIAq2QNGn+Ut5U9tRyPfLAgwB/rScn8Y7If9OqZcUO
         fEtPo3nyqSs6QibsURHcG+AzyoqF+6GUja1ljyIoZfHGu9liP7rSJZ/fkafSvJ/gviD4
         XKnQ==
X-Gm-Message-State: AOUpUlFAwsdd4TgVHB6DuPjdqmLLxxqenSwJDtpzkFL8L8OUhgGgUGlO
        f5RPwQola0gCFH6sHupbVF8=
X-Google-Smtp-Source: AAOMgpcfH4mY2SFQsSLFMY10mBAuHGRMlh8R3+At0dCcel9bD4ElQV5z+ZFgI5CnjDO7JrmVXBjBow==
X-Received: by 2002:a37:c44d:: with SMTP id h13-v6mr455606qkm.422.1531349191825;
        Wed, 11 Jul 2018 15:46:31 -0700 (PDT)
Received: from eaf ([181.47.179.0])
        by smtp.gmail.com with ESMTPSA id w43-v6sm12797504qth.58.2018.07.11.15.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 15:46:31 -0700 (PDT)
Date:   Wed, 11 Jul 2018 19:46:26 -0300
From:   Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, y2038@lists.linaro.org,
        Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Vyacheslav Dubeyko <slava@dubeyko.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [v2] hfs/hfsplus: follow MacOS time behavior
Message-ID: <20180711224625.airwna6gzyatoowe@eaf>
References: <20180710214131.4106527-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710214131.4106527-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

On Tue, Jul 10, 2018 at 11:40:50PM +0200, Arnd Bergmann wrote:
> According to the official documentation for HFS+ [1], inode timestamps
> are supposed to cover the time range from 1904 to 2040 as originally
> used in classic MacOS.
> 
> The traditional Linux usage is to convert the timestamps into an unsigned
> 32-bit number based on the Unix epoch and from there to a time_t. On
> 32-bit systems, that wraps the time from 2038 to 1902, so the last
> two years of the valid time range become garbled. On 64-bit systems,
> all times before 1970 get turned into timestamps between 2038 and 2106,
> which is more convenient but also different from the documented behavior.
> 
> Looking at the Darwin sources [2], it seems that MacOS is inconsistent in
> yet another way: all timestamps are wrapped around to a 32-bit unsigned
> number when written to the disk, but when read back, all numeric values
> lower than 2082844800U are assumed to be invalid, so we cannot represent
> the times before 1970 or the times after 2040.
> 
> While all implementations seem to agree on the interpretation of values
> between 1970 and 2038, they often differ on the exact range they support
> when reading back values outside of the common range:
> 
> MacOS (traditional):		1904-2040
> Apple Documentation:		1904-2040
> MacOS X source comments:	1970-2040
> MacOS X source code:		1970-2038
> 32-bit Linux:			1902-2038
> 64-bit Linux:			1970-2106
> hfsfuse:			1970-2040
> hfsutils (32 bit, old libc)	1902-2038
> hfsutils (32 bit, new libc)	1970-2106
> hfsutils (64 bit)		1904-2040
> hfsplus-utils			1904-2040
> hfsexplorer			1904-2040
> 7-zip				1904-2040
> 
> This changes Linux over to mostly the same behavior as described in the
> code comment in MacOS X, disallowing all times before 1970 and after
> 2040, while still allowing times between 2038 and 2040 like most other
> implementations do. Most importantly, it means we can have the same
> behavior on 32-bit and 64-bit.
> 
> Cc: stable@vger.kernel.org
> Link: [1] https://developer.apple.com/library/archive/technotes/tn/tn1150.html
> Link: [2] https://opensource.apple.com/source/hfs/hfs-407.30.1/core/MacOSStubs.c.auto.html
> Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: treat pre-1970 dates as invalid following MacOS X behavior,
>     reword and expand changelog text
> ---
>  fs/hfs/hfs_fs.h         | 29 +++++++++++++++++++++++++----
>  fs/hfsplus/hfsplus_fs.h | 26 +++++++++++++++++++++++---
>  2 files changed, 48 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index 6d0783e2e276..1af998fb522e 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -246,14 +246,35 @@ extern void hfs_mark_mdb_dirty(struct super_block *sb);
>   *	mac:	unsigned big-endian since 00:00 GMT, Jan. 1, 1904
>   *
>   */
> -#define __hfs_u_to_mtime(sec)	cpu_to_be32(sec + 2082844800U - sys_tz.tz_minuteswest * 60)
> -#define __hfs_m_to_utime(sec)	(be32_to_cpu(sec) - 2082844800U  + sys_tz.tz_minuteswest * 60)
> +static inline time64_t __hfs_m_to_utime(__be32 mt)
> +{
> +	time64_t ut = (u32)(be32_to_cpu(mt) - 2082844800U);
> +
> +	/*
> +	 * Times past 2040-02-06 06:28 are assumed to be invalid,
> +	 * matching the MacOS behavior.
> +	 */
> +	if (ut > 2082844800U + UINT_MAX)

I'm not sure what you were going for here, but this isn't right. Times
as early as 2036 will be considered invalid.

> +		ut = 0;
> +
> +	return ut + sys_tz.tz_minuteswest * 60;
> +}
>  
> +static inline __be32 __hfs_u_to_mtime(time64_t ut)
> +{
> +	ut -= - sys_tz.tz_minuteswest * 60;
	   ^^^^^
	An extra minus.

> +
> +	/*
> +	 * MacOS wraps "invalid" times after 2040 when writing back, so
> +	 * let's do the same here.
> +	 */
> +	return cpu_to_be32(lower_32_bits(ut + 2082844800U));
> +}
>  #define HFS_I(inode)	(container_of(inode, struct hfs_inode_info, vfs_inode))
>  #define HFS_SB(sb)	((struct hfs_sb_info *)(sb)->s_fs_info)
>  
> -#define hfs_m_to_utime(time)	(struct timespec){ .tv_sec = __hfs_m_to_utime(time) }
> -#define hfs_u_to_mtime(time)	__hfs_u_to_mtime((time).tv_sec)
> +#define hfs_m_to_utime(time)   (struct timespec){ .tv_sec = __hfs_m_to_utime(time) }
> +#define hfs_u_to_mtime(time)   __hfs_u_to_mtime((time).tv_sec)

Are the new spaces intentional?

>  #define hfs_mtime()		__hfs_u_to_mtime(get_seconds())
>  
>  static inline const char *hfs_mdb_name(struct super_block *sb)
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index d9255abafb81..7f0943e540a0 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -530,9 +530,29 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector, void *buf,
>  		       void **data, int op, int op_flags);
>  int hfsplus_read_wrapper(struct super_block *sb);
>  
> -/* time macros */
> -#define __hfsp_mt2ut(t)		(be32_to_cpu(t) - 2082844800U)
> -#define __hfsp_ut2mt(t)		(cpu_to_be32(t + 2082844800U))
> +/* time helpers */
> +static inline time64_t __hfsp_mt2ut(__be32 mt)
> +{
> +	time64_t ut = (u32)(be32_to_cpu(mt) - 2082844800U);
> +
> +	/*
> +	 * Times past 2040-02-06 06:28 are assumed to be invalid,
> +	 * matching the MacOS behavior.
> +	 */
> +	if (ut > 2082844800U + UINT_MAX)

Same as before, 2036-2040 will be invalid.


For the record, your original solution (supporting the 1970-2106 range)
still makes more sense to me. It seems Apple is not using the 1904-1970
range for anything; if they are still supporting hfsplus by the 2030s I
assume they will deal with this in a similar way.

Thanks,
Ernest

> +		ut = 0;
> +
> +	return ut;
> +}
> +
> +static inline __be32 __hfsp_ut2mt(time64_t ut)
> +{
> +	/*
> +	 * MacOS wraps "invalid" times after 2040 when writing back, so
> +	 * let's do the same here.
> +	 */
> +	return cpu_to_be32(lower_32_bits(ut + 2082844800U));
> +}
>  
>  /* compatibility */
>  #define hfsp_mt2ut(t)		(struct timespec){ .tv_sec = __hfsp_mt2ut(t) }
> -- 
> 2.9.0
> 
