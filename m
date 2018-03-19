Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755291AbeCSHJI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 03:09:08 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:43714 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754531AbeCSHJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 03:09:07 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.03135664|-1;CH=blue;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03305;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.BMabT1I_1521443339;
Date: Mon, 19 Mar 2018 15:08:59 +0800
From: Guo Ren <ren_guo@c-sky.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net,
        arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
Subject: Re: [PATCH 19/19] irqchip: add irq-nationalchip.c and irq-csky.c
Message-ID: <20180319070859.GC21923@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <62e687d3eb67505aa6f4d4d01ce268fd432bf58e.1521399976.git.ren_guo@c-sky.com>
 <20180319042535.fzssdiu4ot7nyhwe@salmiak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319042535.fzssdiu4ot7nyhwe@salmiak>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 04:26:00AM +0000, Mark Rutland wrote:
> On Mon, Mar 19, 2018 at 03:51:41AM +0800, Guo Ren wrote:
> > +static unsigned int intc_reg;
> 
> This should be a void __iomem *ptr;
>
OK

> > +#define CK_VA_INTC_ICR		(void *)(intc_reg + 0x00)	/* Interrupt control register(High 16bits) */
> > +#define CK_VA_INTC_ISR		(void *)(intc_reg + 0x00)	/* Interrupt status register(Low 16bits) */
> > +#define CK_VA_INTC_NEN31_00	(void *)(intc_reg + 0x10)	/* Normal interrupt enable register Low */
> > +#define	CK_VA_INTC_NEN63_32	(void *)(intc_reg + 0x28)	/* Normal interrupt enable register High */
> > +#define CK_VA_INTC_IFR31_00	(void *)(intc_reg + 0x08)	/* Normal interrupt force register Low */
> > +#define CK_VA_INTC_IFR63_32	(void *)(intc_reg + 0x20)	/* Normal interrupt force register High */
> > +#define	CK_VA_INTC_SOURCE	(void *)(intc_reg + 0x40)	/* Proiority Level Select Registers 0 */
> 
> Please use mnemonics for the offsets, and add the base address in the IO
> accessors.
> 
OK

> > +		temp = __raw_readl(CK_VA_INTC_NEN31_00);
> 
> Please use readl_relaxed() rather than __raw_readl().
>
OK

> > +		__raw_writel(temp, CK_VA_INTC_NEN31_00);
> 
> Likewise, please use writel_relaxed() rather than __raw_writel().
>
OK
 
> These need devicetree bindings. Please see
> Documentation/devicetree/bindings/submitting-patches.txt.
>
OK

> Please avoid assembly in generic driver code. Here you cna use __ffs64() after
> combining the two halves into a 64-bit quantity, or you could use ffs() on each
> half.
>
OK

> > +IRQCHIP_DECLARE(nationalchip_intc_v1_ave, "nationalchip,intc-v1,ave", intc_init);
> 
> This needs a devicetree binding document.
OK
Best Regards
 Guo Ren
