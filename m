Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91D4C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D936208EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MrDzMezJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MrDzMezJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D936208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeHQTD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:03:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48342 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbeHQTD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:03:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9C787625EF; Fri, 17 Aug 2018 16:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534521603;
        bh=iSjImKyPVi9pPwPoyujt09XMtiPU9ScKghiTzZD8HLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MrDzMezJ9xOUjLf6HXJAlspbbLt4LK96sdLZxm2nzrb9kI27A/SA6D5O74VGNK1Ir
         eGbwNtNDmat7NNxSRWyuColIT1gP+V6KKZ5wz0dMr+/tD4U+iagsZn2KS2dnGcETQI
         3OFyEGx0/Qdg3DIh41CvOOilirda5EXyP45i8a80=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CCC1F625E1;
        Fri, 17 Aug 2018 16:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534521603;
        bh=iSjImKyPVi9pPwPoyujt09XMtiPU9ScKghiTzZD8HLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MrDzMezJ9xOUjLf6HXJAlspbbLt4LK96sdLZxm2nzrb9kI27A/SA6D5O74VGNK1Ir
         eGbwNtNDmat7NNxSRWyuColIT1gP+V6KKZ5wz0dMr+/tD4U+iagsZn2KS2dnGcETQI
         3OFyEGx0/Qdg3DIh41CvOOilirda5EXyP45i8a80=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCC1F625E1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Fri, 17 Aug 2018 10:00:02 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] irqchip/gic-v3: Allow interrupt to be configured as
 wake-up sources
Message-ID: <20180817160002.GP5081@codeaurora.org>
References: <20180817091804.993-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180817091804.993-1-marc.zyngier@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17 2018 at 03:18 -0600, Marc Zyngier wrote:
>Although GICv3 doesn't directly offers support for wake-up interrupts
>and relies on external HW for this, it shouldn't prevent the driver
>for such HW from doing it work.
>
>Let's set the required flags on the irq_chip structures.
>
>Reported-by: Lina Iyer <ilina@codeaurora.org>
>Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>---
>Lina, please let me know how this goes. If that fixes your issues,
>I'll queue it as a fix for the current cycle.
>
Thanks for the quick turn around, Marc.

Tested-by: Lina Iyer <ilina@codeaurora.org>

> drivers/irqchip/irq-gic-v3.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>index 76ea56d779a1..2d71c79bc698 100644
>--- a/drivers/irqchip/irq-gic-v3.c
>+++ b/drivers/irqchip/irq-gic-v3.c
>@@ -861,7 +861,9 @@ static struct irq_chip gic_chip = {
> 	.irq_set_affinity	= gic_set_affinity,
> 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
> 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
>-	.flags			= IRQCHIP_SET_TYPE_MASKED,
>+	.flags			= IRQCHIP_SET_TYPE_MASKED |
>+				  IRQCHIP_SKIP_SET_WAKE |
>+				  IRQCHIP_MASK_ON_SUSPEND,
> };
>
> static struct irq_chip gic_eoimode1_chip = {
>@@ -874,7 +876,9 @@ static struct irq_chip gic_eoimode1_chip = {
> 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
> 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
> 	.irq_set_vcpu_affinity	= gic_irq_set_vcpu_affinity,
>-	.flags			= IRQCHIP_SET_TYPE_MASKED,
>+	.flags			= IRQCHIP_SET_TYPE_MASKED |
>+				  IRQCHIP_SKIP_SET_WAKE |
>+				  IRQCHIP_MASK_ON_SUSPEND,
> };
>
> #define GIC_ID_NR		(1U << gic_data.rdists.id_bits)
>--
>2.18.0
>
