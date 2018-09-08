Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB695C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6207520844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6207520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeIHOYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 10:24:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11653 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726413AbeIHOYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 10:24:39 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E0D6B10EA3A3B;
        Sat,  8 Sep 2018 17:39:28 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Sat, 8 Sep 2018
 17:39:28 +0800
Message-ID: <5B9398CD.1060500@huawei.com>
Date:   Sat, 8 Sep 2018 17:39:25 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <tglx@linutronix.de>, <longman@redhat.com>
CC:     <arnd@arndb.de>, <yang.shi@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib/sg_pool: remove unnecessary null check when free
 the object
References: <1533054107-35657-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1533054107-35657-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  Thomas

Can you pick up the patch?

Thanks
zhong jiang
On 2018/8/1 0:21, zhong jiang wrote:
> kmem_cache_destroy/mempool_destroy has taken null check into account.
> so remove the redundant check.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  lib/sg_pool.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/lib/sg_pool.c b/lib/sg_pool.c
> index 6dd3061..d1c1e63 100644
> --- a/lib/sg_pool.c
> +++ b/lib/sg_pool.c
> @@ -148,10 +148,9 @@ static __init int sg_pool_init(void)
>  cleanup_sdb:
>  	for (i = 0; i < SG_MEMPOOL_NR; i++) {
>  		struct sg_pool *sgp = sg_pools + i;
> -		if (sgp->pool)
> -			mempool_destroy(sgp->pool);
> -		if (sgp->slab)
> -			kmem_cache_destroy(sgp->slab);
> +
> +		mempool_destroy(sgp->pool);
> +		kmem_cache_destroy(sgp->slab);
>  	}
>  
>  	return -ENOMEM;


