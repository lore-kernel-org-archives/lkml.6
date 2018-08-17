Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E509C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC8F2187B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC8F2187B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeHQQtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 12:49:18 -0400
Received: from foss.arm.com ([217.140.101.70]:47500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbeHQQtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 12:49:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6005E80D;
        Fri, 17 Aug 2018 06:45:51 -0700 (PDT)
Received: from [10.4.13.119] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E7453F5BC;
        Fri, 17 Aug 2018 06:45:50 -0700 (PDT)
Subject: Re: [PATCH resend] irqchip/tango: Set irq handler and data in one go
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1532282533-26507-1-git-send-email-martin@kaiser.cx>
 <1534507827-7230-1-git-send-email-martin@kaiser.cx>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <9ad15cc2-2a53-fc42-1643-3c91c4190709@arm.com>
Date:   Fri, 17 Aug 2018 14:45:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534507827-7230-1-git-send-email-martin@kaiser.cx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/18 13:10, Martin Kaiser wrote:
> Replace the two separate calls for setting the irq handler and data with
> a single irq_set_chained_handler_and_data() call.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> Resending this, it seems this got lost along the way. Not a major change,
> of course. But should also be simple to review.
> 
> Thanks & Best regards,
> Martin
> 
>  drivers/irqchip/irq-tango.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
> index 0c085303a583..580e2d72b9ba 100644
> --- a/drivers/irqchip/irq-tango.c
> +++ b/drivers/irqchip/irq-tango.c
> @@ -205,8 +205,7 @@ static int __init tangox_irq_init(void __iomem *base, struct resource *baseres,
>  
>  	tangox_irq_domain_init(dom);
>  
> -	irq_set_chained_handler(irq, tangox_irq_handler);
> -	irq_set_handler_data(irq, dom);
> +	irq_set_chained_handler_and_data(irq, tangox_irq_handler, dom);
>  
>  	return 0;
>  }
> 

Queued, thanks.

	M.
-- 
Jazz is not dead. It just smells funny...
