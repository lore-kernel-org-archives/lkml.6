Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43068C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A08204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A08204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeIJHPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:15:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46167 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbeIJHPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:15:02 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 91A5E4428A8BF;
        Mon, 10 Sep 2018 10:08:11 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Mon, 10 Sep 2018
 10:08:11 +0800
Subject: Re: [PATCH net-next] ieee802154: ca8210: Use kmemdup instead of
 duplicating it in ca8210_test_int_driver_write
To:     <davem@davemloft.net>, <h.morris@cascoda.com>,
        <alex.aring@gmail.com>, <stefan@datenfreihafen.org>
References: <20180906034228.7660-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-wpan@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <bb6d1de2-cb0c-73cb-e09a-a1a4c2357fb0@huawei.com>
Date:   Mon, 10 Sep 2018 10:08:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180906034228.7660-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry, Pls ignore this duplicated patch.

On 2018/9/6 11:42, YueHaibing wrote:
> Replace calls to kmalloc followed by a memcpy with a direct call tokmemdup.
> 
> Patch found using coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ieee802154/ca8210.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
> index 58299fb..e21279d 100644
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -634,10 +634,9 @@ static int ca8210_test_int_driver_write(
>  	for (i = 0; i < len; i++)
>  		dev_dbg(&priv->spi->dev, "%#03x\n", buf[i]);
>  
> -	fifo_buffer = kmalloc(len, GFP_KERNEL);
> +	fifo_buffer = kmemdup(buf, len, GFP_KERNEL);
>  	if (!fifo_buffer)
>  		return -ENOMEM;
> -	memcpy(fifo_buffer, buf, len);
>  	kfifo_in(&test->up_fifo, &fifo_buffer, 4);
>  	wake_up_interruptible(&priv->test.readq);
>  
> 

