Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DDEC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 06:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2BB217BD
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 06:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2BB217BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbeHRJXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 05:23:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50370 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725891AbeHRJXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 05:23:52 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 007EEA1B96E1F;
        Sat, 18 Aug 2018 14:17:19 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Sat, 18 Aug 2018
 14:17:18 +0800
Message-ID: <5B77B9EB.9000700@huawei.com>
Date:   Sat, 18 Aug 2018 14:17:15 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Use NULL to compare with pointer-typed value rather
 than 0
References: <1534512473-39710-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1534512473-39710-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/17 21:27, zhong jiang wrote:
> We should use NULL to compare with pointer-typed value rather than
> 0. The issue is detected with the help of Coccinelle.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/block/ataflop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
> index dfb2c26..cca93e3 100644
> --- a/drivers/block/ataflop.c
> +++ b/drivers/block/ataflop.c
> @@ -1355,7 +1355,7 @@ static int floppy_revalidate(struct gendisk *disk)
>  
>  	if (test_bit(drive, &changed_floppies) ||
>  	    test_bit(drive, &fake_change) ||
> -	    p->disktype == 0) {
> +	    p->disktype == NULL) {
>  		if (UD.flags & FTD_MSG)
>  			printk(KERN_ERR "floppy: clear format %p!\n", UDT);
>  		BufferDrive = -1;
 Maybe if  (!p->disktype) is better,  So will change it in v2.

Thanks,
zhong jiang

