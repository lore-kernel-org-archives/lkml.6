Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2684BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC8A20823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="CdS1DmCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfBEAfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 19:35:47 -0500
Received: from vern.gendns.com ([98.142.107.122]:34430 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbfBEAfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 19:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zKSJ0jyVZjjqzc7GBEjuxXuEvTyouXi90e4Hbbr1TYQ=; b=CdS1DmCi0EtjXrnc9ltsRx16l9
        36FlTR668K9qhzFp3kMtwbtW7oGxHl98vEafmhGAKCcx+TS+OPLDzbEdSYtDdXgjvZkYcY7cKvXbQ
        bEvDjLxJHtJwIgcO4FXAFx9dvXyYdvdtR4bGUBf/WssovgZT/EMQAkllZs1Dm70GuM0MnfJRfHTt/
        RZkmw0ir+gQ/Fy9MegopzNv5EXcEaGGVDO5pDQYYUX1mxLTdqfum9nO3HiWZXbhFEr9nT8ub/8IJn
        P1dHWP+zF3NPd8Uf9yNvRfRmVAtv5gGXLcGjSBgyP6kMNQtJkLt4rivNjIZOEn9vvRurc7JBAMYjk
        6/Vm0PLQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:60600 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gqoen-0003FR-Hd; Mon, 04 Feb 2019 19:32:09 -0500
Subject: Re: [PATCH 26/35] ARM: davinci: cp-intc: improve coding style
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-27-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <8202be1d-d5c6-8702-da3c-7c80e80fa209@lechnology.com>
Date:   Mon, 4 Feb 2019 18:35:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-27-brgl@bgdev.pl>
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

On 1/31/19 7:39 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Drop tabs from variable initialization. Arrange variables in reverse
> christmas-tree order.

I'm not sure this description is correct.


> Add a newline before a return.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/mach-davinci/cp_intc.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
> index 2ce0b7653c88..4cd515b507f4 100644
> --- a/arch/arm/mach-davinci/cp_intc.c
> +++ b/arch/arm/mach-davinci/cp_intc.c
> @@ -76,12 +76,12 @@ static void cp_intc_unmask_irq(struct irq_data *d)
>   static int davinci_cp_intc_set_irq_type(struct irq_data *d,
>   					unsigned int flow_type)
>   {
> -	unsigned reg		= BIT_WORD(d->hwirq);
> -	unsigned mask		= BIT_MASK(d->hwirq);
> -	unsigned polarity	= davinci_cp_intc_read(
> -					DAVINCI_CP_INTC_SYS_POLARITY(reg));
> -	unsigned type		= davinci_cp_intc_read(
> -					DAVINCI_CP_INTC_SYS_TYPE(reg));
> +	unsigned int reg, mask, polarity, type;
> +
> +	reg = BIT_WORD(d->hwirq);
> +	mask = BIT_MASK(d->hwirq);
> +	polarity = davinci_cp_intc_read(DAVINCI_CP_INTC_SYS_POLARITY(reg));
> +	type = davinci_cp_intc_read(DAVINCI_CP_INTC_SYS_TYPE(reg));
>   
>   	switch (flow_type) {
>   	case IRQ_TYPE_EDGE_RISING:
> @@ -137,6 +137,7 @@ static int davinci_cp_intc_host_map(struct irq_domain *h, unsigned int virq,
>   	irq_set_chip(virq, &davinci_cp_intc_irq_chip);
>   	irq_set_probe(virq);
>   	irq_set_handler(virq, handle_edge_irq);
> +
>   	return 0;
>   }
>   
> 

