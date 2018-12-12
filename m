Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4861FC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5702086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5702086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbeLLMLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:11:40 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16559 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbeLLMLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:11:40 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F266BB3A62AEB;
        Wed, 12 Dec 2018 20:11:36 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 12 Dec
 2018 20:11:29 +0800
Subject: Re: [PATCH v2] staging:erofs: Fix alignment issues
To:     Aaron Strahlberger <aaron.strahlberger@posteo.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <linux-kernel@i4.cs.fau.de>,
        Julius Wiedmann <julius.wiedmann@fau.de>,
        Dominik Huber <domi250@gmx.de>, Miao Xie <miaoxie@huawei.com>
References: <0ed9f3e7-9081-4a8a-06b0-e5ad14e2c872@huawei.com>
 <20181212120053.16002-1-aaron.strahlberger@posteo.de>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <16a019d6-ccf0-b7a8-8d28-e2af9d0a76ef@huawei.com>
Date:   Wed, 12 Dec 2018 20:11:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181212120053.16002-1-aaron.strahlberger@posteo.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

On 2018/12/12 20:00, Aaron Strahlberger wrote:
> Fix of `CHECK: Alignment should match open parenthesis` issues, reported by
> checkpatch.pl
> 
> Signed-off-by: Aaron Strahlberger <aaron.strahlberger@posteo.de>
> Signed-off-by: Julius Wiedmann <julius.wiedmann@fau.de>
> Signed-off-by: Dominik Huber <domi250@gmx.de>
> ---
>  drivers/staging/erofs/dir.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/erofs/dir.c b/drivers/staging/erofs/dir.c
> index e44ca93dcdc6..e1955703ab8f 100644
> --- a/drivers/staging/erofs/dir.c
> +++ b/drivers/staging/erofs/dir.c
> @@ -24,8 +24,8 @@ static const unsigned char erofs_filetype_table[EROFS_FT_MAX] = {
>  };
>  
>  static int erofs_fill_dentries(struct dir_context *ctx,
> -	void *dentry_blk, unsigned int *ofs,
> -	unsigned int nameoff, unsigned int maxsize)
> +			       void *dentry_blk, unsigned int *ofs,
> +			       unsigned int nameoff, unsigned int maxsize)
>  {
>  	struct erofs_dirent *de = dentry_blk;
>  	const struct erofs_dirent *end = dentry_blk + nameoff;
> @@ -69,8 +69,8 @@ static int erofs_fill_dentries(struct dir_context *ctx,
>  #endif
>  
>  		if (!dir_emit(ctx, de_name, de_namelen,
> -					le64_to_cpu(de->nid), d_type))
> -			/* stoped by some reason */
> +			      le64_to_cpu(de->nid), d_type))
> +			/* stopped by some reason */

It seems Greg has merged part of your previous patch,
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/drivers/staging/erofs?h=staging-testing&id=019ec6c14fbdfaeb361c84f68158fb9097f41004

Anyway, I can locally apply it by 3-way merge, and it looks good to me apart from that

Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang

>  			return 1;
>  		++de;
>  		*ofs += sizeof(struct erofs_dirent);
> @@ -104,9 +104,9 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>  		nameoff = le16_to_cpu(de->nameoff);
>  
>  		if (unlikely(nameoff < sizeof(struct erofs_dirent) ||
> -			nameoff >= PAGE_SIZE)) {
> +			     nameoff >= PAGE_SIZE)) {
>  			errln("%s, invalid de[0].nameoff %u",
> -				__func__, nameoff);
> +			      __func__, nameoff);
>  
>  			err = -EIO;
>  			goto skip_this;
> 
