Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD0BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B7720859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbfAPLQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:16:05 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40185 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728612AbfAPLQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:16:04 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0GBBHkn016814;
        Wed, 16 Jan 2019 12:15:46 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2pyby1bkm1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 16 Jan 2019 12:15:46 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6BCAA31;
        Wed, 16 Jan 2019 11:15:44 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1938E2886;
        Wed, 16 Jan 2019 11:15:44 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 16 Jan
 2019 12:15:43 +0100
Subject: Re: [PATCH v2 1/1] irqchip: stm32-exti: add domain translate function
To:     Loic Pallardy <loic.pallardy@st.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>,
        <mcoquelin.stm32@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <1547229271-121399-1-git-send-email-loic.pallardy@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <419dbebe-c2eb-e5ef-c053-aebc38c865b3@st.com>
Date:   Wed, 16 Jan 2019 12:15:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1547229271-121399-1-git-send-email-loic.pallardy@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loic

On 1/11/19 6:54 PM, Loic Pallardy wrote:
> Domain translate function is needed to recover irq
> configuration parameters from DT node
> 
> Fixes: 927abfc4461e ("irqchip/stm32: Add stm32mp1 support with hierarchy domain")
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
> Changes from v2:
> - Use irq_domain_xlate_twocell helper
> - Add Fixes: tag in commit message
> ---
>   drivers/irqchip/irq-stm32-exti.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
> index 6edfd4bfa169..a93296b9b45d 100644
> --- a/drivers/irqchip/irq-stm32-exti.c
> +++ b/drivers/irqchip/irq-stm32-exti.c
> @@ -822,6 +822,7 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
>   static const struct irq_domain_ops stm32_exti_h_domain_ops = {
>   	.alloc	= stm32_exti_h_domain_alloc,
>   	.free	= irq_domain_free_irqs_common,
> +	.xlate = irq_domain_xlate_twocell,
>   };
>   
>   static int
> 

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>

regards
Alex
