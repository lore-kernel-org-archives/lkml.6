Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F52C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 05:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68DA2075E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 05:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68DA2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbeHRJGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 05:06:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45014 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726071AbeHRJGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 05:06:05 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 25426EF516E2C;
        Sat, 18 Aug 2018 13:59:35 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Sat, 18 Aug 2018
 13:59:34 +0800
Message-ID: <5B77B5C3.8060908@huawei.com>
Date:   Sat, 18 Aug 2018 13:59:31 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Vladimir Zapolskiy <vz@mleia.com>
CC:     <davem@davemloft.net>, <slemieux.tyco@gmail.com>,
        <keescook@chromium.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ethernet: lpc_eth: Use NULL to compare with pointer-typed
 value rather than 0
References: <1534511933-39236-1-git-send-email-zhongjiang@huawei.com> <1534511933-39236-3-git-send-email-zhongjiang@huawei.com> <edc2f14f-8694-3160-47b1-ccb5be8a3484@mleia.com>
In-Reply-To: <edc2f14f-8694-3160-47b1-ccb5be8a3484@mleia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/17 23:29, Vladimir Zapolskiy wrote:
> Hi zhong jiang,
>
> On 08/17/2018 04:18 PM, zhong jiang wrote:
>> We should use NULL to compare with pointer-typed value rather than 0.
>> The issue is detected with the help of Coccinelle.
>> ---
>>  drivers/net/ethernet/nxp/lpc_eth.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
>> index 08381ef..04d9e62 100644
>> --- a/drivers/net/ethernet/nxp/lpc_eth.c
>> +++ b/drivers/net/ethernet/nxp/lpc_eth.c
>> @@ -1350,7 +1350,7 @@ static int lpc_eth_drv_probe(struct platform_device *pdev)
>>  				"IRAM not big enough for net buffers, using SDRAM instead.\n");
>>  	}
>>  
>> -	if (pldat->dma_buff_base_v == 0) {
>> +	if (pldat->dma_buff_base_v == NULL) {
> That's a valid finding, but please use a common 0 and NULL comparison in form of
>
> 	if (!pldat->dma_buff_base_v)
>
> To the change above please feel free to add my
>
> Acked-by: Vladimir Zapolskiy <vz@mleia.com>
 Thanks, Will do in v2
>>  		ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>>  		if (ret)
>>  			goto err_out_free_irq;
>>
>
> .
>


