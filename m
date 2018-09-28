Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3363DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0C52156D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0C52156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbeI1RDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 13:03:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46838 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729008AbeI1RDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 13:03:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9ECE7A9;
        Fri, 28 Sep 2018 03:40:25 -0700 (PDT)
Received: from [10.4.13.85] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C6C63F5BD;
        Fri, 28 Sep 2018 03:40:23 -0700 (PDT)
Subject: Re: [PATCH] drivers: irqchip: pdc: setup all edge interrupts as
 rising edge at GIC
To:     Lina Iyer <ilina@codeaurora.org>, evgreen@chromium.org
Cc:     bjorn.andersson@linaro.org, rplsssn@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, andy.gross@linaro.org, sboyd@kernel.org,
        dianders@chromium.org
References: <20180927171810.22968-1-ilina@codeaurora.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <27d7df0d-4429-dcdd-f527-a33f9385b4e0@arm.com>
Date:   Fri, 28 Sep 2018 11:40:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927171810.22968-1-ilina@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/18 18:18, Lina Iyer wrote:
> The PDC irqchp can convert a falling edge or level low interrupt to a
> rising edge or level high interrupt at the GIC. We just need to setup
> the GIC correctly. Set up the interrupt type for the IRQ_TYPE_EDGE_BOTH
> as IRQ_TYPE_EDGE_RISING at the GIC.
> 
> Reported-by: Evan Green <evgreen@chromium.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>   drivers/irqchip/qcom-pdc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
> index b1b47a40a278..faa7d61b9d6c 100644
> --- a/drivers/irqchip/qcom-pdc.c
> +++ b/drivers/irqchip/qcom-pdc.c
> @@ -124,6 +124,7 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
>   		break;
>   	case IRQ_TYPE_EDGE_BOTH:
>   		pdc_type = PDC_EDGE_DUAL;
> +		type = IRQ_TYPE_EDGE_RISING;
>   		break;
>   	case IRQ_TYPE_LEVEL_HIGH:
>   		pdc_type = PDC_LEVEL_HIGH;
> 

Queued for 4.20, with

Fixes: f55c73aef890 ("irqchip/pdc: Add PDC interrupt controller for QCOM 
SoCs")

added. Please consider providing these tags in the future.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
