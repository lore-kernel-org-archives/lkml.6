Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C73EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBFA2152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBFA2152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbeHWPLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:11:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56411 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729022AbeHWPLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:11:24 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9A2C526509E43;
        Thu, 23 Aug 2018 19:42:00 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Thu, 23 Aug 2018
 19:41:59 +0800
Message-ID: <5B7E9D86.20209@huawei.com>
Date:   Thu, 23 Aug 2018 19:41:58 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <shawnguo@kernel.org>, <airlied@linux.ie>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: do not double put device node in zx_drm_probe
References: <1534472646-10368-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1534472646-10368-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping,  Anyone has any objections a about the patch?

Best wishes,
zhong jiang
On 2018/8/17 10:24, zhong jiang wrote:
> for_each_available_child_of_node will get and put the node properly,
> the following of_node_put will lead to the double put. So just
> remove it.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/gpu/drm/zte/zx_drm_drv.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/zte/zx_drm_drv.c b/drivers/gpu/drm/zte/zx_drm_drv.c
> index 6f4205e8..d7b9870 100644
> --- a/drivers/gpu/drm/zte/zx_drm_drv.c
> +++ b/drivers/gpu/drm/zte/zx_drm_drv.c
> @@ -161,10 +161,8 @@ static int zx_drm_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	for_each_available_child_of_node(parent, child) {
> +	for_each_available_child_of_node(parent, child)
>  		component_match_add(dev, &match, compare_of, child);
> -		of_node_put(child);
> -	}
>  
>  	return component_master_add_with_match(dev, &zx_drm_master_ops, match);
>  }


