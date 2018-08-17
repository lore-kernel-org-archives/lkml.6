Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24A4C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF9D2185D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF9D2185D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbeHQGxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 02:53:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40308 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725833AbeHQGxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 02:53:42 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B6CF0A4FE694E;
        Fri, 17 Aug 2018 11:51:53 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Fri, 17 Aug 2018
 11:51:50 +0800
Message-ID: <5B764655.7000803@huawei.com>
Date:   Fri, 17 Aug 2018 11:51:49 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <dvhart@infradead.org>, <andy@infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drviers: intel_ips: remove the unneeded null pointer
 check before debugfs_remove_recursive
References: <1534476719-13480-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1534476719-13480-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

subect:  drviers/drivers   will repost, please ingore the patch. Thanks
On 2018/8/17 11:31, zhong jiang wrote:
> debugfs_remove_recursive has taken the null pointer into account.
> just remove the null check before debugfs_remove_recursive.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/platform/x86/intel_ips.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
> index c5ece7e..1c3127c 100644
> --- a/drivers/platform/x86/intel_ips.c
> +++ b/drivers/platform/x86/intel_ips.c
> @@ -1311,8 +1311,7 @@ static int ips_debugfs_open(struct inode *inode, struct file *file)
>  
>  static void ips_debugfs_cleanup(struct ips_driver *ips)
>  {
> -	if (ips->debug_root)
> -		debugfs_remove_recursive(ips->debug_root);
> +	debugfs_remove_recursive(ips->debug_root);
>  	return;
>  }
>  


