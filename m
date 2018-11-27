Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2E6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F098208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F098208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeK0NOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:14:43 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:59724 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbeK0NOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:14:43 -0500
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Nov 2018 08:14:42 EST
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id AB70D130E18;
        Tue, 27 Nov 2018 11:08:59 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id wAR28wZD013065
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 27 Nov 2018 11:08:59 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id wAR28wbD013297
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 27 Nov 2018 11:08:58 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id wAR28vG5013296;
        Tue, 27 Nov 2018 11:08:57 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Carmeli Tamir <carmeli.tamir@gmail.com>, axboe@kernel.dk,
        sergey.senozhatsky@gmail.com, jthumshirn@suse.de,
        bvanassche@acm.org, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: Replaced 11 magic to MSDOS_NAME for volume label
References: <1543096879-82837-1-git-send-email-carmeli.tamir@gmail.com>
Date:   Tue, 27 Nov 2018 11:08:57 +0900
In-Reply-To: <1543096879-82837-1-git-send-email-carmeli.tamir@gmail.com>
        (Carmeli Tamir's message of "Sat, 24 Nov 2018 17:01:19 -0500")
Message-ID: <87efb79squ.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carmeli Tamir <carmeli.tamir@gmail.com> writes:

> The FAT file system volume label file stored in the root directory should
> match the volume label field in the FAT boot sector. As consequence, the
> max length of these fields ought to be the same. This patch replaces the
> magic '11' usef in the struct fat_boot_sector with MSDOS_NAME,
> which is used in struct msdos_dir_entry.
>
> Please check the following references:
> 1. Microsoft FAT specification 2005 
> (http://read.pudn.com/downloads77/ebook/294884/FAT32%20Spec%20%28SDA%20Contribution%29.pdf).
> Search for 'volume label'.
> 2. Microsoft Extensible Firmware Initiative, FAT32 File System Specification
> (https://staff.washington.edu/dittrich/misc/fatgen103.pdf). 
> Search for 'volume label'.
> 3. User space code that creates FAT filesystem 
> sometimes uses MSDOS_NAME for the label, sometimes not.
> Search for 'if (memcmp(label, NO_NAME, MSDOS_NAME))'. 
> I consider to make the same patch there as well.
> https://github.com/dosfstools/dosfstools/blob/master/src/mkfs.fat.c
>
> Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Looks good. Thanks.

> ---
>  include/uapi/linux/msdos_fs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/msdos_fs.h b/include/uapi/linux/msdos_fs.h
> index fde7537..1216e6c 100644
> --- a/include/uapi/linux/msdos_fs.h
> +++ b/include/uapi/linux/msdos_fs.h
> @@ -135,7 +135,7 @@ struct fat_boot_sector {
>  						   for mount state. */
>  			__u8	signature;  /* extended boot signature */
>  			__u8	vol_id[4];	/* volume ID */
> -			__u8	vol_label[11];	/* volume label */
> +			__u8	vol_label[MSDOS_NAME];	/* volume label */
>  			__u8	fs_type[8];		/* file system type */
>  			/* other fields are not added here */
>  		} fat16;
> @@ -158,7 +158,7 @@ struct fat_boot_sector {
>  						   for mount state. */
>  			__u8	signature;  /* extended boot signature */
>  			__u8	vol_id[4];	/* volume ID */
> -			__u8	vol_label[11];	/* volume label */
> +			__u8	vol_label[MSDOS_NAME];	/* volume label */
>  			__u8	fs_type[8];		/* file system type */
>  			/* other fields are not added here */
>  		} fat32;

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
