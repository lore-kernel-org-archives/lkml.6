Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D70C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 06:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2152C24B44
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 06:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+7dGwUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2152C24B44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbeFWGBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 02:01:02 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35812 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbeFWGBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 02:01:00 -0400
Received: by mail-qt0-f196.google.com with SMTP id z6-v6so7874956qti.2;
        Fri, 22 Jun 2018 23:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aKphA+fxwIz6Y0NsqqjFkJV0IPA06dhSl69IxqmVqRw=;
        b=o+7dGwUlhUEwHvO2x/nzFBQsODR1vlMBqOFkzG3SiIkwsR25PUyMPvh/FWEWU/llXg
         WS2LwAeilBPC1hnfK19Eb9uu5ozd/qb9KPm8UmRComr/7OYhm5ctfGA/teQjjQqnOxx8
         i0VXmC3h5q0OALjEsgfHe3U8TJS739YrGM+RFW8I+874NBJNBPoq20fViI/Iygucj5Qn
         jxe1AHth6FHwTXFIoJOc4qswm5kwTswuTm5er5K0K9fYZln3rgAN7MVccEutPzwz0Mrz
         jGLutu81L+Vj0GYjO6MfQJNEm6viLQTOmHwYJYkdzP8yflUEUYxcvetVvDdcs0pkzy6T
         Qbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aKphA+fxwIz6Y0NsqqjFkJV0IPA06dhSl69IxqmVqRw=;
        b=sMj0ub1DnXLsE86gnHQBuJ4X6t2irD+eSElp1nfWiYYZcwwU3Ah1LYwMVeXnyQmRBV
         uf0FIX3wVzLfOpL1sw/NnfW8byAbsewj9zTdKuMhgv9f3xJS5RHT6OMXjDURRtwML14H
         zdH1pXnKMZ5TOav73XCaXmP4++zekh7EtWaxhV2Ot7/mnlmOYvUiZLqMKx13nq5ZdOIJ
         cVDfsaDvqzKvVezvCSLzDkNKxvlOcF5BU2N7rwjz6KMSGbql7lAGe2gUBgM9GlD2N7Z1
         KOdL8QBL0/OAPStTTEeIdBiV1dEuKroetKL3Gh1beSvWL+garpnNFOd9d3o6ijrt04jW
         3V1g==
X-Gm-Message-State: APt69E0OwLJwcpgjfe9BDzch8iy3dwDAEqLc++dity98Bk400LDh5Djd
        CVuERKYso7cadoEHxH7/PR0=
X-Google-Smtp-Source: AAOMgpdGwEQ2A9PMRq8Nm8PE56bWvFU16BPYIlTb2LQ1wGPObz7XkQ9hzdtjUmroJz729ZwPvFcqgg==
X-Received: by 2002:a0c:985a:: with SMTP id e26-v6mr4060783qvd.44.1529733659065;
        Fri, 22 Jun 2018 23:00:59 -0700 (PDT)
Received: from eaf ([181.47.179.0])
        by smtp.gmail.com with ESMTPSA id a1-v6sm8027491qte.73.2018.06.22.23.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 23:00:58 -0700 (PDT)
Date:   Sat, 23 Jun 2018 03:00:54 -0300
From:   Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vyacheslav Dubeyko <slava@dubeyko.com>, y2038@lists.linaro.org,
        stable@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hfs/hfsplus: use documented official timestamp range
Message-ID: <20180623060052.ufrlbybeys2xxt5l@eaf>
References: <20180622141758.229589-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622141758.229589-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 04:17:32PM +0200, Arnd Bergmann wrote:
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
> The same behavior is used in Darwin and presumaby all versions of MacOS X,
> as seen in the to_hfs_time() function in [2]. It is unclear whether this
> is a bug in the file system code, or intentional but undocumented behavior.

But the to_bsd_time() function considers wrapped timestamps as invalid,
doesn't it? So it seems they simply don't care about the post-2040 (or
pre-1970) case?

> 
> This changes Linux over to the traditional MacOS (pre MacOS X)
> behavior. This means all files that are created on MacOS X or Linux
> with future timestamps between 2040 and 2106 will now show up as past
> dates. Timestamps between 2038 and 2040 will still be represented
> incorrectly on 32-bit architectures as times between 1902 and 1904,
> but that will be fixed once we have user space with 64-bit time_t.
> 
> Cc: stable@vger.kernel.org
> Link: [1] https://developer.apple.com/library/archive/technotes/tn/tn1150.html
> Link: [2] https://opensource.apple.com/source/xnu/xnu-344/bsd/hfs/MacOSStubs.c
> Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Note: This is the patch that Viacheslav asked for, but given how
> MacOS X behaves, I'm increasingly thinking this is a bad idea.

I agree that it made more sense before.

> ---
>  fs/hfs/hfs_fs.h         | 2 +-
>  fs/hfsplus/hfsplus_fs.h | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index 6d0783e2e276..39c1f3a43ed8 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -247,7 +247,7 @@ extern void hfs_mark_mdb_dirty(struct super_block *sb);
>   *
>   */
>  #define __hfs_u_to_mtime(sec)	cpu_to_be32(sec + 2082844800U - sys_tz.tz_minuteswest * 60)
> -#define __hfs_m_to_utime(sec)	(be32_to_cpu(sec) - 2082844800U  + sys_tz.tz_minuteswest * 60)
> +#define __hfs_m_to_utime(sec)	((time64_t)be32_to_cpu(sec) - 2082844800U  + sys_tz.tz_minuteswest * 60)
>  
>  #define HFS_I(inode)	(container_of(inode, struct hfs_inode_info, vfs_inode))
>  #define HFS_SB(sb)	((struct hfs_sb_info *)(sb)->s_fs_info)
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index d9255abafb81..57838ef4dcdc 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -530,8 +530,9 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector, void *buf,
>  		       void **data, int op, int op_flags);
>  int hfsplus_read_wrapper(struct super_block *sb);
>  
> -/* time macros */
> -#define __hfsp_mt2ut(t)		(be32_to_cpu(t) - 2082844800U)
> +/* time macros: convert between 1904-2040 and 1970-2106 range,
> + * pre-1970 timestamps are interpreted as post-2038 times after wrap-around */

This comment seems to be from the original series, maybe you forgot to
change it?

> +#define __hfsp_mt2ut(t)		((time64_t)be32_to_cpu(t) - 2082844800U)
>  #define __hfsp_ut2mt(t)		(cpu_to_be32(t + 2082844800U))
>  
>  /* compatibility */
> -- 
> 2.9.0
> 
