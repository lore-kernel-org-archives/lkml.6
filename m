Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FA5C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6048520821
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="jHKJUJRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfBDWqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:46:20 -0500
Received: from vern.gendns.com ([98.142.107.122]:36738 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728191AbfBDWqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0rreqikSxvX4jbkgmsJTEM6tWhqXPdbYa0fKLDAYgYU=; b=jHKJUJRSik5YaJi5DM9P3MGSoa
        ZKKISgoJ6kZ8xml50Rx68BenYxJaFXPyPBBmXUWsCEjd3kP2VHmlSnMapghpaI5C97TD3lR7gyzW4
        6UvOHDxnzYHM4Md6ZlM4q2bu79sPghDxpObkghXYaDEFez6ulhyDd+qHspELwuAJ9YltsMTkjcIgv
        9sm/GH/2hMgLAvu7tJOQuZB2OZlftHMJe8vT7eRVrJxUvZgTLqazqOOGX84hfN2P2Vu12vyH/QFd8
        qPSoV+YPwIuqr4av3n57IUIB2X+tbvkc6JVEDo/nN+ubp/LiOqbPgJYq3kONDg7y0ePXeIFY+ClAe
        e+gMNsqw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:58506 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gqmwt-0005xI-6O; Mon, 04 Feb 2019 17:42:43 -0500
Subject: Re: [PATCH 08/35] ARM: davinci: select SPARSE_IRQ
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-9-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <b79af9d6-dc2a-3188-0872-4cbcea66644d@lechnology.com>
Date:   Mon, 4 Feb 2019 16:46:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-9-brgl@bgdev.pl>
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
> Everything is in place now for SPARSE_IRQ. Select it and set
> DAVINCI_INTC_START to NR_IRQS.
> 
> We now need to include mach/irqs.h in a couple places as it is no
> longer indirectly included after selecting SPARSE_IRQ.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>

...

> diff --git a/arch/arm/mach-davinci/include/mach/irqs.h b/arch/arm/mach-davinci/include/mach/irqs.h
> index 14fa668d4e8d..317cbc42e5cd 100644
> --- a/arch/arm/mach-davinci/include/mach/irqs.h
> +++ b/arch/arm/mach-davinci/include/mach/irqs.h
> @@ -27,10 +27,12 @@
>   #ifndef __ASM_ARCH_IRQS_H
>   #define __ASM_ARCH_IRQS_H
>   
> +#include <asm/irq.h>
> +
>   /* Base address */
>   #define DAVINCI_ARM_INTC_BASE 0x01C48000
>   
> -#define DAVINCI_INTC_START		0
> +#define DAVINCI_INTC_START		NR_IRQS
>   #define DAVINCI_INTC_IRQ(_irqnum)	(DAVINCI_INTC_START + (_irqnum))
>   
>   /* Interrupt lines */
> @@ -404,6 +406,5 @@
>   /* da850 currently has the most gpio pins (144) */
>   #define DAVINCI_N_GPIO			144
>   /* da850 currently has the most irqs so use DA850_N_CP_INTC_IRQ */

It would make sense to delete this comment in this patch as well
(although it gets deleted later anyway).

> -#define NR_IRQS				(DA850_N_CP_INTC_IRQ + DAVINCI_N_GPIO)
>   
>   #endif /* __ASM_ARCH_IRQS_H */
