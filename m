Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0DBC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 06:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AFC217BD
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 06:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AFC217BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbeHRJWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 05:22:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47268 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725891AbeHRJWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 05:22:54 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C50A5CD675462;
        Sat, 18 Aug 2018 14:16:21 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Sat, 18 Aug 2018
 14:16:21 +0800
Message-ID: <5B77B9B1.9070203@huawei.com>
Date:   Sat, 18 Aug 2018 14:16:17 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <davem@davemloft.net>
CC:     <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide: Use NULL to compare with pointer-typed value rather
 than 0
References: <1534512227-39484-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1534512227-39484-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/17 21:23, zhong jiang wrote:
> We should use NULL to compare with pointer-typed value rather than
> 0. The issue is detected with the help of Coccinelle.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/ide/pmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
> index c5b902b..673734b 100644
> --- a/drivers/ide/pmac.c
> +++ b/drivers/ide/pmac.c
> @@ -1682,7 +1682,7 @@ static int pmac_ide_init_dma(ide_hwif_t *hwif, const struct ide_port_info *d)
>  	/* We won't need pci_dev if we switch to generic consistent
>  	 * DMA routines ...
>  	 */
> -	if (dev == NULL || pmif->dma_regs == 0)
> +	if (dev == NULL || pmif->dma_regs == NULL)
>  		return -ENODEV;
>  	/*
>  	 * Allocate space for the DBDMA commands.
 Maybe if (!dev || !pmif->dma_regs) is better,  Will repost in v2.

Thanks,
zhong jiang

