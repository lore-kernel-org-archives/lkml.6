Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C3BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA71214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfBLNRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:17:36 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52908 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727312AbfBLNRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:17:35 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 56F399D614730395FFD3;
        Tue, 12 Feb 2019 21:17:32 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Tue, 12 Feb 2019
 21:17:25 +0800
Subject: Re: [PATCH] irqchip/gic-v3-its: Avoid parsing _indirect_ twice for
 Device table
To:     <marc.zyngier@arm.com>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <shankerd@codeaurora.org>, <wanghaibin.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1549776250-4464-1-git-send-email-yuzenghui@huawei.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <18c972e9-5230-4a0c-3fbf-e3c6c224d6fc@huawei.com>
Date:   Tue, 12 Feb 2019 21:17:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <1549776250-4464-1-git-send-email-yuzenghui@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2019/2/10 13:24, Zenghui Yu wrote:
> In current logic, its_parse_indirect_baser() will be invoked twice
> when allocating Device tables. Add a *break* to omit the unnecessary
> and annoying (might be ...) invoking.
> 

Forgot to add:

Fixes: 32bd44dc19de ("irqchip/gic-v3-its: Fix the incorrect parsing of 
VCPU table size")

> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>   drivers/irqchip/irq-gic-v3-its.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index db20e99..9f529a6 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1946,6 +1946,8 @@ static int its_alloc_tables(struct its_node *its)
>   			indirect = its_parse_indirect_baser(its, baser,
>   							    psz, &order,
>   							    its->device_ids);
> +			break;
> +
>   		case GITS_BASER_TYPE_VCPU:
>   			indirect = its_parse_indirect_baser(its, baser,
>   							    psz, &order,
> 

Thanks,
Zenghui

