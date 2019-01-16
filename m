Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CB2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C4D20651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pYiCftxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405324AbfAPRGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:06:48 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40558 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387948AbfAPRGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Uk3n/6r1p3G9K/Ov9sRkbm1dK7fbEvw/HmPfRRVzjHo=; b=pYiCftxgWW8rxaZP+rFU5K2jNE
        YMrEfjgNwT926c43eMukFQ1cq2XY8wxcJzHHGHoO2vKO5qHUxRYpj4Z9iBJikVtIlcbQa+R5BrgQX
        s4prH//A/yz1nVvfqE8gikFodqfEpk5mUTGkScdWtz+vxSJoC70W3+OVJAvRlW5kQGNvZ75wSAtKA
        iV0sjkuoB8GBOlArxHjLeyF5IEsTZlFYuJs+BL/flH0KpXuI8g2HovAmo0y0yLzi6j8yN3oiGB6FW
        kzltUTRRsViZ5PHe67bZAnO0Qd2Kw5QrSY2sMxaIuFJfqvKcmJ2Sdj/iNaQfXxsO7Go/4oF5x9cOA
        X56Hjzmg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjoeK-0002a3-Na; Wed, 16 Jan 2019 17:06:45 +0000
Subject: Re: [PATCH] irq: convert the code format to BIT()
To:     Yangtao Li <tiny.windzz@gmail.com>, tglx@linutronix.de,
        douliyangs@gmail.com, marc.zyngier@arm.com, palmer@sifive.com
Cc:     linux-kernel@vger.kernel.org
References: <20190116160305.20639-1-tiny.windzz@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6ebf07cf-fa1b-99ae-3ef4-3e660142f36b@infradead.org>
Date:   Wed, 16 Jan 2019 09:06:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190116160305.20639-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 8:03 AM, Yangtao Li wrote:
> Use BIT() to do some clean-up.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  include/linux/irq.h | 106 ++++++++++++++++++++++----------------------
>  1 file changed, 53 insertions(+), 53 deletions(-)
> 

Hi,

From Documentation/process/submit-checklist.rst, Rule #1:

1) If you use a facility then #include the file that defines/declares
   that facility.  Don't depend on other header files pulling in ones
   that you use.


> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index def2b2aac8b1..66c9801ce108 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -73,30 +73,30 @@ enum irqchip_irq_state;
>   * IRQ_DISABLE_UNLAZY		- Disable lazy irq disable
>   */
>  enum {
> -	IRQ_TYPE_NONE		= 0x00000000,
> -	IRQ_TYPE_EDGE_RISING	= 0x00000001,
> -	IRQ_TYPE_EDGE_FALLING	= 0x00000002,
> +	IRQ_TYPE_NONE		= 0,
> +	IRQ_TYPE_EDGE_RISING	= BIT(0),
> +	IRQ_TYPE_EDGE_FALLING	= BIT(1),
>  	IRQ_TYPE_EDGE_BOTH	= (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING),
> -	IRQ_TYPE_LEVEL_HIGH	= 0x00000004,
> -	IRQ_TYPE_LEVEL_LOW	= 0x00000008,
> +	IRQ_TYPE_LEVEL_HIGH	= BIT(2),
> +	IRQ_TYPE_LEVEL_LOW	= BIT(3),
>  	IRQ_TYPE_LEVEL_MASK	= (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH),
> -	IRQ_TYPE_SENSE_MASK	= 0x0000000f,
> +	IRQ_TYPE_SENSE_MASK	= GENMASK(3,0),
>  	IRQ_TYPE_DEFAULT	= IRQ_TYPE_SENSE_MASK,
>  
> -	IRQ_TYPE_PROBE		= 0x00000010,
> -
> -	IRQ_LEVEL		= (1 <<  8),
> -	IRQ_PER_CPU		= (1 <<  9),
> -	IRQ_NOPROBE		= (1 << 10),
> -	IRQ_NOREQUEST		= (1 << 11),
> -	IRQ_NOAUTOEN		= (1 << 12),
> -	IRQ_NO_BALANCING	= (1 << 13),
> -	IRQ_MOVE_PCNTXT		= (1 << 14),
> -	IRQ_NESTED_THREAD	= (1 << 15),
> -	IRQ_NOTHREAD		= (1 << 16),
> -	IRQ_PER_CPU_DEVID	= (1 << 17),
> -	IRQ_IS_POLLED		= (1 << 18),
> -	IRQ_DISABLE_UNLAZY	= (1 << 19),
> +	IRQ_TYPE_PROBE		= BIT(4),
> +
> +	IRQ_LEVEL		= BIT(8),
> +	IRQ_PER_CPU		= BIT(9),
> +	IRQ_NOPROBE		= BIT(10),
> +	IRQ_NOREQUEST		= BIT(11),
> +	IRQ_NOAUTOEN		= BIT(12),
> +	IRQ_NO_BALANCING	= BIT(13),
> +	IRQ_MOVE_PCNTXT		= BIT(14),
> +	IRQ_NESTED_THREAD	= BIT(15),
> +	IRQ_NOTHREAD		= BIT(16),
> +	IRQ_PER_CPU_DEVID	= BIT(17),
> +	IRQ_IS_POLLED		= BIT(18),
> +	IRQ_DISABLE_UNLAZY	= BIT(19),
>  };
>  
>  #define IRQF_MODIFY_MASK	\
> @@ -211,26 +211,26 @@ struct irq_data {
>   * IRQD_CAN_RESERVE		- Can use reservation mode
>   */
>  enum {
> -	IRQD_TRIGGER_MASK		= 0xf,
> -	IRQD_SETAFFINITY_PENDING	= (1 <<  8),
> -	IRQD_ACTIVATED			= (1 <<  9),
> -	IRQD_NO_BALANCING		= (1 << 10),
> -	IRQD_PER_CPU			= (1 << 11),
> -	IRQD_AFFINITY_SET		= (1 << 12),
> -	IRQD_LEVEL			= (1 << 13),
> -	IRQD_WAKEUP_STATE		= (1 << 14),
> -	IRQD_MOVE_PCNTXT		= (1 << 15),
> -	IRQD_IRQ_DISABLED		= (1 << 16),
> -	IRQD_IRQ_MASKED			= (1 << 17),
> -	IRQD_IRQ_INPROGRESS		= (1 << 18),
> -	IRQD_WAKEUP_ARMED		= (1 << 19),
> -	IRQD_FORWARDED_TO_VCPU		= (1 << 20),
> -	IRQD_AFFINITY_MANAGED		= (1 << 21),
> -	IRQD_IRQ_STARTED		= (1 << 22),
> -	IRQD_MANAGED_SHUTDOWN		= (1 << 23),
> -	IRQD_SINGLE_TARGET		= (1 << 24),
> -	IRQD_DEFAULT_TRIGGER_SET	= (1 << 25),
> -	IRQD_CAN_RESERVE		= (1 << 26),
> +	IRQD_TRIGGER_MASK		= GENMASK(3,0),
> +	IRQD_SETAFFINITY_PENDING	= BIT(8),
> +	IRQD_ACTIVATED			= BIT(9),
> +	IRQD_NO_BALANCING		= BIT(10),
> +	IRQD_PER_CPU			= BIT(11),
> +	IRQD_AFFINITY_SET		= BIT(12),
> +	IRQD_LEVEL			= BIT(13),
> +	IRQD_WAKEUP_STATE		= BIT(14),
> +	IRQD_MOVE_PCNTXT		= BIT(15),
> +	IRQD_IRQ_DISABLED		= BIT(16),
> +	IRQD_IRQ_MASKED			= BIT(17),
> +	IRQD_IRQ_INPROGRESS		= BIT(18),
> +	IRQD_WAKEUP_ARMED		= BIT(19),
> +	IRQD_FORWARDED_TO_VCPU		= BIT(20),
> +	IRQD_AFFINITY_MANAGED		= BIT(21),
> +	IRQD_IRQ_STARTED		= BIT(22),
> +	IRQD_MANAGED_SHUTDOWN		= BIT(23),
> +	IRQD_SINGLE_TARGET		= BIT(24),
> +	IRQD_DEFAULT_TRIGGER_SET	= BIT(25),
> +	IRQD_CAN_RESERVE		= BIT(26),
>  };
>  
>  #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
> @@ -507,14 +507,14 @@ struct irq_chip {
>   * IRQCHIP_SUPPORTS_LEVEL_MSI	Chip can provide two doorbells for Level MSIs
>   */
>  enum {
> -	IRQCHIP_SET_TYPE_MASKED		= (1 <<  0),
> -	IRQCHIP_EOI_IF_HANDLED		= (1 <<  1),
> -	IRQCHIP_MASK_ON_SUSPEND		= (1 <<  2),
> -	IRQCHIP_ONOFFLINE_ENABLED	= (1 <<  3),
> -	IRQCHIP_SKIP_SET_WAKE		= (1 <<  4),
> -	IRQCHIP_ONESHOT_SAFE		= (1 <<  5),
> -	IRQCHIP_EOI_THREADED		= (1 <<  6),
> -	IRQCHIP_SUPPORTS_LEVEL_MSI	= (1 <<  7),
> +	IRQCHIP_SET_TYPE_MASKED		= BIT(0),
> +	IRQCHIP_EOI_IF_HANDLED		= BIT(1),
> +	IRQCHIP_MASK_ON_SUSPEND		= BIT(2),
> +	IRQCHIP_ONOFFLINE_ENABLED	= BIT(3),
> +	IRQCHIP_SKIP_SET_WAKE		= BIT(4),
> +	IRQCHIP_ONESHOT_SAFE		= BIT(5),
> +	IRQCHIP_EOI_THREADED		= BIT(6),
> +	IRQCHIP_SUPPORTS_LEVEL_MSI	= BIT(7),
>  };
>  
>  #include <linux/irqdesc.h>
> @@ -1007,11 +1007,11 @@ struct irq_chip_generic {
>   * @IRQ_GC_BE_IO:		Use big-endian register accesses (default: LE)
>   */
>  enum irq_gc_flags {
> -	IRQ_GC_INIT_MASK_CACHE		= 1 << 0,
> -	IRQ_GC_INIT_NESTED_LOCK		= 1 << 1,
> -	IRQ_GC_MASK_CACHE_PER_TYPE	= 1 << 2,
> -	IRQ_GC_NO_MASK			= 1 << 3,
> -	IRQ_GC_BE_IO			= 1 << 4,
> +	IRQ_GC_INIT_MASK_CACHE		= BIT(0),
> +	IRQ_GC_INIT_NESTED_LOCK		= BIT(1),
> +	IRQ_GC_MASK_CACHE_PER_TYPE	= BIT(2),
> +	IRQ_GC_NO_MASK			= BIT(3),
> +	IRQ_GC_BE_IO			= BIT(4),
>  };
>  
>  /*
> 

thanks.
-- 
~Randy
