Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C0AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D85217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeLRNM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:12:27 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16598 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726403AbeLRNM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:12:27 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 91965FB4A2D39;
        Tue, 18 Dec 2018 21:12:22 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Tue, 18 Dec 2018
 21:12:21 +0800
Subject: Re: [PATCH -next] irqchip/irq-rda-intc: Fix return value check in
 rda8810_intc_init()
To:     Marc Zyngier <marc.zyngier@arm.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>
References: <20181218121542.15500-1-yuehaibing@huawei.com>
 <fcacb2b1-7b49-b6bc-f64a-29f6a21be7f9@arm.com>
CC:     <linux-kernel@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <a50b4691-2238-1eae-b36d-5e4d152787e2@huawei.com>
Date:   Tue, 18 Dec 2018 21:12:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <fcacb2b1-7b49-b6bc-f64a-29f6a21be7f9@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/18 20:58, Marc Zyngier wrote:
> On 18/12/2018 12:15, YueHaibing wrote:
>> In case of error, the function of_io_request_and_map() returns ERR_PTR()
>> and never returns NULL. The NULL test in the return value check should
>> be replaced with IS_ERR().
>>
>> Fixes: d852e62ad689 ("irqchip: Add RDA8810PL interrupt driver")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/irqchip/irq-rda-intc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-rda-intc.c b/drivers/irqchip/irq-rda-intc.c
>> index 1176291..f80c424 100644
>> --- a/drivers/irqchip/irq-rda-intc.c
>> +++ b/drivers/irqchip/irq-rda-intc.c
>> @@ -85,7 +85,7 @@ static int __init rda8810_intc_init(struct device_node *node,
>>  				    struct device_node *parent)
>>  {
>>  	rda_intc_base = of_io_request_and_map(node, 0, "rda-intc");
>> -	if (!rda_intc_base)
>> +	if (IS_ERR(rda_intc_base))
>>  		return -ENXIO;
>>  
>>  	/* Mask all interrupt sources */
>>
> 
> Already posted as
> https://lore.kernel.org/lkml/1545047898-153890-1-git-send-email-weiyongjun1@huawei.com/
> 
> You may want to synchronize with your colleagues running the same scripts.

Oh, I missed this. Thank you.

> 
> Thanks,
> 
> 	M.
> 

