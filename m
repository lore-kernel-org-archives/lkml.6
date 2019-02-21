Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018C9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC0F2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfBUOfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:35:44 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38270 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbfBUOfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:35:44 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8AD26E3B38525745CAED;
        Thu, 21 Feb 2019 22:35:40 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 21 Feb
 2019 22:35:34 +0800
Subject: Re: [PATCH] staging/erofs: fix sparse's warnings on undeclared
 symbols in erofs
To:     Bo YU <tsu.yubo@gmail.com>
CC:     <yuchao0@huawei.com>, <gregkh@linuxfoundation.org>,
        <yuzibode@126.com>, <linux-erofs@lists.ozlabs.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>,
        "fangwei (I)" <fangwei1@huawei.com>
References: <20190221142845.13604-1-tsu.yubo@gmail.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <05254fc6-6bd7-7c30-cfcc-2ddff4ac13b6@huawei.com>
Date:   Thu, 21 Feb 2019 22:35:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190221142845.13604-1-tsu.yubo@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bo,

On 2019/2/21 22:28, Bo YU wrote:
> From: Bo Yu <tsu.yubo@gmail.com>
> 
> Fix sparse warnings:
> 
> drivers/staging/erofs/utils.c:134:6: warning: symbol
> 'erofs_try_to_release_workgroup' was not declared. Should it be static?
> 
> Fixes: 51232df5e4b26("staging: erofs: fix race when the managed cache is enabled")
> Cc: Gao Xiang <gaoxiang25@huawei.com>
> Cc: Chao Yu <yuchao0@huawei.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
> ---
>  drivers/staging/erofs/utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
> index b535898ca753..33cd5ad55cb8 100644
> --- a/drivers/staging/erofs/utils.c
> +++ b/drivers/staging/erofs/utils.c
> @@ -131,7 +131,7 @@ static void erofs_workgroup_unfreeze_final(struct erofs_workgroup *grp)
>  	__erofs_workgroup_free(grp);
>  }
>  
> -bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
> +static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
>  				    struct erofs_workgroup *grp,
>  				    bool cleanup)
>  {
> 

Have you looked the latest kernel code?
It seems erofs_try_to_release_workgroup is already be claimed as static...

See:
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/drivers/staging/erofs/utils.c?h=staging-next#n148

Thanks,
Gao Xiang

