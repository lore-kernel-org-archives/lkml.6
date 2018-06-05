Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbeFEIYG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:24:06 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43592 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbeFEIYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:24:04 -0400
X-Google-Smtp-Source: ADUXVKI6B7cngazmI5lpwiRQzrg0RmxIIJjOw2rBkSCxeD4kSj8nFLoH2HjaopT4ItKxqrQ5Mw+yAA==
Date: Tue, 5 Jun 2018 09:24:00 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Vasut <marek.vasut@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v3 07/10] mfd: da9063: Add custom IRQ map for DA9063L
Message-ID: <20180605082400.GQ21163@dell>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-7-marek.vasut+renesas@gmail.com>
 <20180605074727.GL21163@dell>
 <CAMuHMdU3ctFuSXsGAxHJyxPkFEeqm+WrWj7HrKFCKs32asWcYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdU3ctFuSXsGAxHJyxPkFEeqm+WrWj7HrKFCKs32asWcYw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jun 2018, Geert Uytterhoeven wrote:

> Hi Lee,
> 
> On Tue, Jun 5, 2018 at 9:47 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Sat, 02 Jun 2018, Marek Vasut wrote:
> >> While the datasheet for DA9063L (2v1, 23-Mar-2017) lists the RTC register
> >> block, the DA9063L does not have an RTC. Add custom IRQ map for DA9063L to
> >> ignore the Alarm and Tick IRQs from the PMIC.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> >> --- a/drivers/mfd/da9063-irq.c
> >> +++ b/drivers/mfd/da9063-irq.c
> >> @@ -74,8 +74,55 @@ static const struct regmap_irq_chip da9063_irq_chip = {
> >>       .init_ack_masked = true,
> >>  };
> >>
> >> +static const struct regmap_irq da9063l_irqs[] = {
> >> +     /* DA9063 event A register */
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_ONKEY, DA9063_REG_EVENT_A_OFFSET, DA9063_M_ONKEY),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_ADC_RDY, DA9063_REG_EVENT_A_OFFSET, DA9063_M_ADC_RDY),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_SEQ_RDY, DA9063_REG_EVENT_A_OFFSET, DA9063_M_SEQ_RDY),
> >> +     /* DA9063 event B register */
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_WAKE, DA9063_REG_EVENT_B_OFFSET, DA9063_M_WAKE),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_TEMP, DA9063_REG_EVENT_B_OFFSET, DA9063_M_TEMP),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_COMP_1V2, DA9063_REG_EVENT_B_OFFSET, DA9063_M_COMP_1V2),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_LDO_LIM, DA9063_REG_EVENT_B_OFFSET, DA9063_M_LDO_LIM),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_REG_UVOV, DA9063_REG_EVENT_B_OFFSET, DA9063_M_UVOV),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_DVC_RDY, DA9063_REG_EVENT_B_OFFSET, DA9063_M_DVC_RDY),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_VDD_MON, DA9063_REG_EVENT_B_OFFSET, DA9063_M_VDD_MON),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_WARN, DA9063_REG_EVENT_B_OFFSET, DA9063_M_VDD_WARN),
> >> +     /* DA9063 event C register */
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_GPI0, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI0),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_GPI1, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI1),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_GPI2, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI2),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_GPI3, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI3),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_GPI4, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI4),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_GPI5, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI5),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_GPI6, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI6),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_GPI7, DA9063_REG_EVENT_C_OFFSET, DA9063_M_GPI7),
> >> +     /* DA9063 event D register */
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_GPI8, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI8),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_GPI9, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI9),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_GPI10, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI10),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_GPI11, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI11),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_GPI12, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI12),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_GPI13, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI13),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_GPI14, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI14),
> >> +     REGMAP_IRQ_REG(DA9063_IRQ_GPI15, DA9063_REG_EVENT_D_OFFSET, DA9063_M_GPI15),
> >> +};
> >
> > Same here.  Please make checkpatch.pl happen, even if it makes the
> > code slightly less readable.
> 
> I beg to disagree: source code should be optimized for reading.
> Checkpatch is a hinting tool, not an absolute check.

I agree with you to some degree, but as per the Coding Standards we
are to use max 80-chars unless it *significantly* reduces
readability.

Breaking lines into two on a natural break only *slightly* reduces
readability, if at all to be frank.

We have MACROS which encompass many arguments and we have to draw the
line somewhere.  I choose 80-chars.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
