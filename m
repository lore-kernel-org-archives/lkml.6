Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2ACECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B999E2150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B999E2150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389955AbeIUUCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:02:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13096 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728149AbeIUUCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:02:18 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 434F3C3FF006D;
        Fri, 21 Sep 2018 22:13:10 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 22:13:10 +0800
Message-ID: <5BA4FC75.7040902@huawei.com>
Date:   Fri, 21 Sep 2018 22:13:09 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <airlied@linux.ie>, <alexander.deucher@amd.com>
CC:     <oded.gabbay@gmail.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        "Harry Wentland" <harry.wentland@amd.com>
Subject: Re: [PATCH] drm: amd: Use kmemdup instead of duplicating its function
References: <1537284932-62278-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1537284932-62278-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc  amd-gfx@lists.freedesktop.org

Thanks,
zhong jiang

On 2018/9/18 23:35, zhong jiang wrote:
> kmemdup has implemented the function that kmalloc() + memcpy().
> We prefer to kmemdup rather than code opened implementation.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index ee49960..8ddd585 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -747,12 +747,10 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
>  		return -ENODATA;
>  	}
>  
> -	pcrat_image = kmalloc(crat_table->length, GFP_KERNEL);
> +	pcrat_image = kmemdup(crat_table, crat_table->length, GFP_KERNEL);
>  	if (!pcrat_image)
>  		return -ENOMEM;
>  
> -	memcpy(pcrat_image, crat_table, crat_table->length);
> -
>  	*crat_image = pcrat_image;
>  	*size = crat_table->length;
>  


