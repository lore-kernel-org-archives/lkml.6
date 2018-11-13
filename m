Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC27C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E9922506
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E9922506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbeKMJ4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 04:56:20 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15088 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbeKMJ4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 04:56:20 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9B567CFCB531F;
        Tue, 13 Nov 2018 08:00:51 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 13 Nov
 2018 08:00:44 +0800
Subject: Re: [PATCH 3/3] staging: erofs: unzip_vle.c: Align parameter to the
 parentesis
To:     Cristian Sicilia <sicilia.cristian@gmail.com>
CC:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-erofs@lists.ozlabs.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
References: <1542055439-24444-1-git-send-email-sicilia.cristian@gmail.com>
 <1542055439-24444-4-git-send-email-sicilia.cristian@gmail.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <24c1755b-6a19-a1e3-60f2-30461ddca63e@huawei.com>
Date:   Tue, 13 Nov 2018 08:00:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1542055439-24444-4-git-send-email-sicilia.cristian@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/11/13 4:43, Cristian Sicilia wrote:
> Align parameters to the opened parentesis.
> 
> Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>

Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang

> ---
>  drivers/staging/erofs/unzip_vle.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
> index 35add4e..6a283f6 100644
> --- a/drivers/staging/erofs/unzip_vle.c
> +++ b/drivers/staging/erofs/unzip_vle.c
> @@ -35,9 +35,10 @@ static inline int init_unzip_workqueue(void)
>  	 * we don't need too many threads, limiting threads
>  	 * could improve scheduling performance.
>  	 */
> -	z_erofs_workqueue = alloc_workqueue("erofs_unzipd",
> -		WQ_UNBOUND | WQ_HIGHPRI | WQ_CPU_INTENSIVE,
> -		onlinecpus + onlinecpus / 4);
> +	z_erofs_workqueue =
> +		alloc_workqueue("erofs_unzipd",
> +				WQ_UNBOUND | WQ_HIGHPRI | WQ_CPU_INTENSIVE,
> +				onlinecpus + onlinecpus / 4);
>  
>  	return z_erofs_workqueue ? 0 : -ENOMEM;
>  }
> @@ -46,8 +47,8 @@ int __init z_erofs_init_zip_subsystem(void)
>  {
>  	z_erofs_workgroup_cachep =
>  		kmem_cache_create("erofs_compress",
> -		Z_EROFS_WORKGROUP_SIZE, 0,
> -		SLAB_RECLAIM_ACCOUNT, NULL);
> +				  Z_EROFS_WORKGROUP_SIZE, 0,
> +				  SLAB_RECLAIM_ACCOUNT, NULL);
>  
>  	if (z_erofs_workgroup_cachep) {
>  		if (!init_unzip_workqueue())
> 
