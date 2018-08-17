Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82015C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF8C2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF8C2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbeHQG46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 02:56:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11128 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725833AbeHQG46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 02:56:58 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1456DDDA987ED;
        Fri, 17 Aug 2018 11:55:10 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Fri, 17 Aug 2018
 11:55:11 +0800
Message-ID: <5B76471D.1070504@huawei.com>
Date:   Fri, 17 Aug 2018 11:55:09 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <cpw@sgi.com>, <robinmholt@gmail.com>
CC:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] misc: remove meanless null check before kfree
References: <1534476285-13097-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1534476285-13097-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/17 11:24, zhong jiang wrote:
> kfree has taken null pointer into account. so check the null pointer
> before kfree is meanless.
 meanless/meaningless.  will repost. please ignore the patch, thanks.
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/misc/sgi-xp/xpc_partition.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/misc/sgi-xp/xpc_partition.c b/drivers/misc/sgi-xp/xpc_partition.c
> index 0c3ef6f..3eba1c4 100644
> --- a/drivers/misc/sgi-xp/xpc_partition.c
> +++ b/drivers/misc/sgi-xp/xpc_partition.c
> @@ -98,8 +98,7 @@
>  			len = L1_CACHE_ALIGN(len);
>  
>  		if (len > buf_len) {
> -			if (buf_base != NULL)
> -				kfree(buf_base);
> +			kfree(buf_base);
>  			buf_len = L1_CACHE_ALIGN(len);
>  			buf = xpc_kmalloc_cacheline_aligned(buf_len, GFP_KERNEL,
>  							    &buf_base);


