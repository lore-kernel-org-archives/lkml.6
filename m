Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA975C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C064320815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfBCNFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:05:41 -0500
Received: from foss.arm.com ([217.140.101.70]:46398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbfBCNFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:05:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 706A780D;
        Sun,  3 Feb 2019 05:05:40 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B37F73F59C;
        Sun,  3 Feb 2019 05:05:37 -0800 (PST)
Date:   Sun, 3 Feb 2019 13:05:33 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Brian Masney <masneyb@onstation.org>
Cc:     linus.walleij@linaro.org, tglx@linutronix.de,
        andy.gross@linaro.org, sboyd@kernel.org,
        kernel-build-reports@lists.linaro.org,
        linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 1/2] genirq: export irq_chip_set_wake_parent
 symbol
Message-ID: <20190203130533.072b235e@why.wild-wind.fr.eu.org>
In-Reply-To: <20190203123131.28323-1-masneyb@onstation.org>
References: <20190203123131.28323-1-masneyb@onstation.org>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  3 Feb 2019 07:31:30 -0500
Brian Masney <masneyb@onstation.org> wrote:

Hi Brian,

> Export the irq_chip_set_wake_parent symbol so that drivers with
> hierarchical IRQ chips can be built as a module.
> 
> This fixes a build failure in linux-next's spmi-gpio when using
> allmodconfig.

I don't think the mention of linux-next helps in the commit message. It
would have been better together with the note below.

> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Reported-by: Mark Brown <broonie@kernel.org>

Otherwise:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.

> ---
> See https://www.spinics.net/lists/linux-next/msg46362.html for Mark's
> message.
> 
>  kernel/irq/chip.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 34e969069488..086d5a34b5a0 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -1381,6 +1381,7 @@ int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on)
>  
>  	return -ENOSYS;
>  }
> +EXPORT_SYMBOL_GPL(irq_chip_set_wake_parent);
>  #endif
>  
>  /**



-- 
Without deviation from the norm, progress is not possible.
