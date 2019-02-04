Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BC1C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6AB20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="qH+R5RrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfBDWCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:02:16 -0500
Received: from vern.gendns.com ([98.142.107.122]:57402 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfBDWCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4Xs/8xOFCwQw3o1S1GTK/7iPoWC/lB97bZzgmas8FgE=; b=qH+R5RrZxfUIsKHnig1mvBnSwu
        yTOi5N7uMa9LpoAxgUNH4GDR/8kf5g5bBFX2+Em7fwD/t1xuzDa3JQE3aFHOlyc/KGcAjZwsBx/x5
        E1+FLFPX8dzFXplx4Y4RF3BCHx7kKgzWZ3KxbgmmWnuHN/pSwMkNU0SfRJyBzc9KY6m+Rdgm3oju2
        1Y0OobgQfQPd7I8QrwNft+iQe9Uakmg1nVSuYUijvJQS2H89RsTMUultinu2kTfY7IADwFIhfID3J
        bOOgkzSYZ4Aqj1lUMwf/hRtAYsS5CARKz3bRAPRS54JV/nHKanYdQ08lDZeWRtjIqPZEUqmBiOoGH
        aIDNclKw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:57548 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gqmGD-0001cM-W6; Mon, 04 Feb 2019 16:58:38 -0500
Subject: Re: [PATCH 02/35] ARM: davinci: select GENERIC_IRQ_MULTI_HANDLER
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-3-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <848a116f-2f1b-e764-fea2-7816640c6dc4@lechnology.com>
Date:   Mon, 4 Feb 2019 16:02:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-3-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/19 7:38 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> In order to support SPARSE_IRQ we first need to make davinci use the
> generic irq handler for ARM. Translate the legacy assembly to C and
> put the irq handlers into their respective drivers (aintc and cp-intc).
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

...

> diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c

...

> @@ -97,6 +98,16 @@ static struct irq_chip cp_intc_irq_chip = {
>   
>   static struct irq_domain *cp_intc_domain;
>   
> +static asmlinkage void __exception_irq_entry
> +cp_intc_handle_irq(struct pt_regs *regs)
> +{
> +	int irqnr = cp_intc_read(CP_INTC_PRIO_IDX);
> +
> +	irqnr &= 0xff;

What does applying the 0xff mask do? (perhaps needs a code
comment if it is important and not obvious).

> +
> +	handle_domain_irq(cp_intc_domain, irqnr, regs);
> +}
> +
>   static int cp_intc_host_map(struct irq_domain *h, unsigned int virq,
>   			  irq_hw_number_t hw)
>   {

...

> diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c

...

> @@ -69,6 +76,19 @@ davinci_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
>   			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
>   }
>   
> +static asmlinkage void __exception_irq_entry
> +davinci_handle_irq(struct pt_regs *regs)
> +{
> +	int irqnr = davinci_irq_readl(IRQ_IRQENTRY_OFFSET);
> +	struct pt_regs *old_regs = set_irq_regs(regs);
> +
> +	irqnr >>= 2;
> +	irqnr -= 1;

Same here. It is not obvious to me what sort of conversion
is going on here.

> +
> +	generic_handle_irq(irqnr);
> +	set_irq_regs(old_regs);
> +}
> +
>   /* ARM Interrupt Controller Initialization */
>   void __init davinci_irq_init(void)
>   {
