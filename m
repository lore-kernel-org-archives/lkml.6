Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeFEH5o (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:57:44 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35459 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbeFEH5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:57:42 -0400
X-Google-Smtp-Source: ADUXVKKAcPFvLB8xX6bEV36W5W4WxdKvBT0YST69liAbO8uKw1hYNpHjxSJNbPLQiRiK+BB6hQIeRA==
From: Matti Vaittinen <mazziesaccount@gmail.com>
X-Google-Original-From: Matti Vaittinen <mvaittin@localhost.localdomain>
Date: Tue, 5 Jun 2018 10:57:29 +0300
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v5 1/4] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180605075729.GA20078@localhost.localdomain>
References: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <985ac760de3be503f9196eb6353a57eeb92c6dc0.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <985ac760de3be503f9196eb6353a57eeb92c6dc0.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 04:18:07PM +0300, Matti Vaittinen wrote:
> +static struct regmap_irq_chip bd71837_irq_chip = {
> +	.name = "bd71837-irq",
> +	.irqs = bd71837_irqs,
> +	.num_irqs = ARRAY_SIZE(bd71837_irqs),
> +	.num_regs = 1,
> +	.irq_reg_stride = 1,
> +	.status_base = BD71837_REG_IRQ,
> +	.mask_base = BD71837_REG_MIRQ,
> +	.init_ack_masked = true,
> +	.mask_invert = false,
> +};

.ack_base = BD71837_REG_IRQ, is missing. I'll send yet another version
with this fixed - unless Rob tells me to drop the whole irq handling
from the patch series.

Br,
	Matti Vaittinen
