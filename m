Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3565CC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A9921904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NX93lTAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfBGNoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:44:07 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50928 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfBGNoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:44:07 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x17Dhn6m007453;
        Thu, 7 Feb 2019 07:43:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549547029;
        bh=h31aGMGZ/O3IAV76pMQeoWa/s2tCobM0/mcmHNc2kw0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NX93lTArgqXNl07AnU31uorIgPEs7IJ+EnAzpnYo5caI/2llG22WsO7tZT7oh5WoA
         t1CYvldGSE/J7KSlTkjooBq2Cq32/TA3ybK37mvc0fXXwI+TNXX5C3nFYA5yIV9aRG
         2lSK3lsbVNgaT4Jz7IOce8R26ExIupI/XkoZhaRo=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x17DhnLT024603
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Feb 2019 07:43:49 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 07:43:49 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 07:43:49 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x17Dhk8s002633;
        Thu, 7 Feb 2019 07:43:47 -0600
Subject: Re: [PATCH 23/35] ARM: davinci: cp-intc: use a common prefix for all
 symbols
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-24-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <d81883ee-1b87-7c55-e595-7c7c7551b824@ti.com>
Date:   Thu, 7 Feb 2019 19:13:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-24-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/19 7:09 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> In preparation for moving the driver to drivers/irqchip do some
> cleanup: use a common prefix for all symbols.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/cp_intc.c             | 143 ++++++++++----------
>  arch/arm/mach-davinci/da830.c               |   2 +-
>  arch/arm/mach-davinci/da850.c               |   2 +-
>  arch/arm/mach-davinci/include/mach/common.h |   2 +-
>  4 files changed, 77 insertions(+), 72 deletions(-)

>  /* Enable interrupt */
>  static void cp_intc_unmask_irq(struct irq_data *d)
>  {
> -	cp_intc_write(d->hwirq, CP_INTC_SYS_ENABLE_IDX_SET);
> +	davinci_cp_intc_write(d->hwirq, DAVINCI_CP_INTC_SYS_ENABLE_IDX_SET);
>  }

For consistency, can you please add davinci_ prefix to this function too?

Thanks,
Sekhar
