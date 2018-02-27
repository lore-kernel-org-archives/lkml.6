Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeB0V1k (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:27:40 -0500
Received: from botnar.kaiser.cx ([176.28.20.183]:58336 "EHLO botnar.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751554AbeB0V1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:27:39 -0500
Date: Tue, 27 Feb 2018 22:25:17 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] ARM: imx: avic: set low-power interrupt mask for
 imx25
Message-ID: <20180227212517.GA5227@botnar.kaiser.cx>
References: <1518180203-9698-1-git-send-email-martin@kaiser.cx>
 <20180224073408.GE3217@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180224073408.GE3217@dragon>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shawn and all,

Thus wrote Shawn Guo (shawnguo@kernel.org):

> > +static void __iomem *avic_base, *mx25_ccm_base;

> Keep avic_base line untouched, and add a new one for mx25_ccm_base.

ok

> >  static struct irq_domain *domain;

> >  #ifdef CONFIG_FIQ
> > @@ -93,6 +97,11 @@ static void avic_irq_suspend(struct irq_data *d)

> >  	avic_saved_mask_reg[idx] = imx_readl(avic_base + ct->regs.mask);
> >  	imx_writel(gc->wake_active, avic_base + ct->regs.mask);

> Have a newline here.

ok

> >  static void avic_irq_resume(struct irq_data *d)
> > @@ -102,6 +111,11 @@ static void avic_irq_resume(struct irq_data *d)
> >  	int idx = d->hwirq >> 5;

> >  	imx_writel(avic_saved_mask_reg[idx], avic_base + ct->regs.mask);

> Ditto

ok

Please note that, as there were no fundamental doubts about my approach,
I submitted a "regular patch" based on this RFC patch a couple of days
later.

I'll update this regular patch and submit a v2.

Best regards,

   Martin
