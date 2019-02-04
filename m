Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40C0C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A687A2083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="vm/ZXgMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfBDXyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:54:35 -0500
Received: from vern.gendns.com ([98.142.107.122]:52732 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfBDXyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jtuK9DdatMC/du0cYbdmv7oUNfIicdfV49My/zSXiQs=; b=vm/ZXgModCEAGMnPf6XftJTd5x
        AvPVbfsf8MExXv+dsDUGIrYYn89la7SOH/7dtHud2EceMN6nRwgz2GQJ+4aZ5NpCeCK0ZRcQpQ/aX
        0s5e76MQJ0hNmGDrYu6AtbF2/ooBTfD4ipTEry01L+ry/2p3otOVzNG/drbHufHaEd1bKELoJyiA6
        pjeSa4YZuio6z1nfjPFoP+cMN9qW5caa1G5UNdNqtf7StnABXu0IvuF1gFMx1YL7p9/+XxzHx6zsI
        uahnc6cvM65lnhVg5b7/PyuQqb3Hgh9nX8yzMJTXTYQPfAcZ8uQM4qxEHKEBXE8LuOrwqKw1C59ZC
        1sZ+45Bg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:59794 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gqo0w-0000A7-Ej; Mon, 04 Feb 2019 18:50:58 -0500
Subject: Re: [PATCH 21/35] ARM: davinci: cp-intc: add a new config structure
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-22-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <a92fcfc1-b8f6-eaa2-a2cc-e145291d36dc@lechnology.com>
Date:   Mon, 4 Feb 2019 17:54:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-22-brgl@bgdev.pl>
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

subject should probably be irqchip: rather than ARM:


On 1/31/19 7:39 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add a config structure that will be used by cp-intc-based platforms.
> It contains the register range resource and the number of interrupts.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   include/linux/irqchip/irq-davinci-cp-intc.h | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>   create mode 100644 include/linux/irqchip/irq-davinci-cp-intc.h
> 
> diff --git a/include/linux/irqchip/irq-davinci-cp-intc.h b/include/linux/irqchip/irq-davinci-cp-intc.h
> new file mode 100644
> index 000000000000..9b0c7d6189eb
> --- /dev/null
> +++ b/include/linux/irqchip/irq-davinci-cp-intc.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */

GPL-2.0-or-later ?

> +/*
> + * Copyright (C) 2019 Texas Instruments
> + */
> +
> +#ifndef _LINUX_IRQ_DAVINCI_CP_INTC_
> +#define _LINUX_IRQ_DAVINCI_CP_INTC_
> +
> +#include <linux/ioport.h>
> +
> +struct davinci_cp_intc_config {
> +	struct resource reg;
> +	unsigned int num_irqs;
> +};
> +
> +#endif /* _LINUX_IRQ_DAVINCI_CP_INTC_ */
> 

