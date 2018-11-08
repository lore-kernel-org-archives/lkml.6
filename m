Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87BFECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551D02081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyRYguc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551D02081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeKHXBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:01:10 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36769 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeKHXBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:01:09 -0500
Received: by mail-yw1-f65.google.com with SMTP id h21-v6so7979596ywa.3;
        Thu, 08 Nov 2018 05:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5H6dz1CqC+LXWjKXWuACZAxeRBHJe1OqgPcSJb5PlYA=;
        b=IyRYguc0+5RAUvHFVCVx3vxaePOyrY6MRZXPCwX24FnxtN03UbNrm2/wuCrctJQ9Wi
         rDtsdapAX4QUbtVwd7DmhAH76lkounHKSRV68T26gbqKbmKm/OQWBVBKj2N04Fu21JW+
         lFVsfbNYNrgEDrOdit76Ah3u+bzyANtc1ujrXbedLmU9kmpeIxJHAniEByfxWfkUlOTf
         wmcrd8WYlkQ855eoXs7clvi3q4+s/yp4cxO0O2lK/ClAPCh1c9puryc1kpjW+rq1efkH
         dMshvgx1E15EkPOtRgc7kC51Q7cqvOzORSJO8bfi3kWhUhuU3xc4rvZS5KeDJ5OQxXxY
         MLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5H6dz1CqC+LXWjKXWuACZAxeRBHJe1OqgPcSJb5PlYA=;
        b=fRZf4ED8XYygHEUfdqalwW7wixLLgDc7pC0WMZoJ8sdfRbTGKJ3nh2+/6gcH9B1ZYc
         2+8aGePELSpPnQHH3z23eBSEqn0ZwWUg1llF43GIMfhDsvJgOamo8FdmHMza7ETqH89s
         ajvNNp6qfSKERt1Fxkc5CmyLDSbFNP3EZ0ANFPBdLATYV26E3WpxEFgrtxHQKgQsQmIF
         OwPNU8SU/ssgLyqFJvQlHN40AfGAWWm+A5iTcrUCQ1VtEMFxZujXzwVv6oEfFrzsoWw1
         BKAcT6kPbrBpmeC8/AbvfJXJ8sWY0fWTPWq9QLspOqyPP0mnG1L0aiG65sfn3Cpig7O6
         Zm5Q==
X-Gm-Message-State: AGRZ1gIVEu/p7D6Ar/vA3tY5xKOrwam37K6JQxiYdYbX/u055BWVJioh
        XLCm84q7ThkBFdrTwP29qj0IK9E5Lfh4+dl8UU4=
X-Google-Smtp-Source: AJdET5cgcXyFP0UD0GsjxD1qZnndh6jiuFjE1aYk9FcNC6W1FYUtLNkBRGhrNE2AupNy0M102/PWQuQYJ+CmFMLsYcU=
X-Received: by 2002:a81:9f8b:: with SMTP id w133-v6mr4159843ywg.163.1541683539513;
 Thu, 08 Nov 2018 05:25:39 -0800 (PST)
MIME-Version: 1.0
References: <20180611155001.3506-1-peron.clem@gmail.com> <20180611155001.3506-5-peron.clem@gmail.com>
 <27e8d6f0-b415-f31e-ae89-0b35397d0cf2@linaro.org> <CAJiuCcftA0EmmXueNw60ScLZMuxJVUSaZji0KFfSWAdgnR2OXw@mail.gmail.com>
 <9aa2d430-077f-a97f-438a-41237375c2b8@linaro.org>
In-Reply-To: <9aa2d430-077f-a97f-438a-41237375c2b8@linaro.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 8 Nov 2018 14:25:28 +0100
Message-ID: <CAJiuCcdR8GBn=AEZzRQRzAb00x6i=Zi3+MeJNKSvkcWa8R_jaw@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] clocksource: add driver for i.MX EPIT timer
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, 5 Nov 2018 at 12:48, Daniel Lezcano <daniel.lezcano@linaro.org> wro=
te:
>
>
> Hi Cl=C3=A9ment,
>
> On 04/11/2018 17:07, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Daniel,
> >
> > Thanks for the review and sorry for the delay.
>
> no problem.
>
> > On Tue, 10 Jul 2018 at 18:20, Daniel Lezcano <daniel.lezcano@linaro.org=
> wrote:
> >>
> >> On 11/06/2018 17:50, Cl=C3=A9ment P=C3=A9ron wrote:
> >>> From: Colin Didier <colin.didier@devialet.com>
> >>>
> >>> Add driver for NXP's EPIT timer used in i.MX SoC.
> >>
> >> Give a description on how works this timer.
> > Ok,
> >
> >>
> >>
> >>> Signed-off-by: Colin Didier <colin.didier@devialet.com>
> >>> Signed-off-by: Cl=C3=A9ment Peron <clement.peron@devialet.com>
> >>> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
> >>> Tested-by: Vladimir Zapolskiy <vz@mleia.com>
> >>> ---
> >>>  drivers/clocksource/Kconfig          |  11 ++
> >>>  drivers/clocksource/Makefile         |   1 +
> >>>  drivers/clocksource/timer-imx-epit.c | 265 +++++++++++++++++++++++++=
++
> >>>  3 files changed, 277 insertions(+)
> >>>  create mode 100644 drivers/clocksource/timer-imx-epit.c
> >>>
> >>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfi=
g
> >>> index 8e8a09755d10..790478afd02c 100644
> >>> --- a/drivers/clocksource/Kconfig
> >>> +++ b/drivers/clocksource/Kconfig
> >>> @@ -576,6 +576,17 @@ config H8300_TPU
> >>>         This enables the clocksource for the H8300 platform with the
> >>>         H8S2678 cpu.
> >>>
> >>> +config CLKSRC_IMX_EPIT
> >>> +     bool "Clocksource using i.MX EPIT"
> >>> +     depends on CLKDEV_LOOKUP && (ARCH_MXC || COMPILE_TEST)
> >>> +     select CLKSRC_MMIO
> >>> +     help
> >>> +       This enables EPIT support available on some i.MX platforms.
> >>> +       Normally you don't have a reason to do so as the EPIT has
> >>> +       the same features and uses the same clocks as the GPT.
> >>> +       Anyway, on some systems the GPT may be in use for other
> >>> +       purposes.
> >>> +
> >>>  config CLKSRC_IMX_GPT
> >>>       bool "Clocksource using i.MX GPT" if COMPILE_TEST
> >>>       depends on ARM && CLKDEV_LOOKUP
> >>> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makef=
ile
> >>> index 00caf37e52f9..d9426f69ec69 100644
> >>> --- a/drivers/clocksource/Makefile
> >>> +++ b/drivers/clocksource/Makefile
> >>> @@ -69,6 +69,7 @@ obj-$(CONFIG_INTEGRATOR_AP_TIMER)   +=3D timer-inte=
grator-ap.o
> >>>  obj-$(CONFIG_CLKSRC_VERSATILE)               +=3D versatile.o
> >>>  obj-$(CONFIG_CLKSRC_MIPS_GIC)                +=3D mips-gic-timer.o
> >>>  obj-$(CONFIG_CLKSRC_TANGO_XTAL)              +=3D tango_xtal.o
> >>> +obj-$(CONFIG_CLKSRC_IMX_EPIT)                +=3D timer-imx-epit.o
> >>>  obj-$(CONFIG_CLKSRC_IMX_GPT)         +=3D timer-imx-gpt.o
> >>>  obj-$(CONFIG_CLKSRC_IMX_TPM)         +=3D timer-imx-tpm.o
> >>>  obj-$(CONFIG_ASM9260_TIMER)          +=3D asm9260_timer.o
> >>> diff --git a/drivers/clocksource/timer-imx-epit.c b/drivers/clocksour=
ce/timer-imx-epit.c
> >>> new file mode 100644
> >>> index 000000000000..7f1c8e2e00aa
> >>> --- /dev/null
> >>> +++ b/drivers/clocksource/timer-imx-epit.c
> >>> @@ -0,0 +1,265 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * i.MX EPIT Timer
> >>> + *
> >>> + * Copyright (C) 2010 Sascha Hauer <s.hauer@pengutronix.de>
> >>> + * Copyright (C) 2018 Colin Didier <colin.didier@devialet.com>
> >>> + * Copyright (C) 2018 Cl=C3=A9ment P=C3=A9ron <clement.peron@deviale=
t.com>
> >>> + */
> >>> +
> >>> +#include <linux/clk.h>
> >>> +#include <linux/clockchips.h>
> >>> +#include <linux/interrupt.h>
> >>> +#include <linux/of_address.h>
> >>> +#include <linux/of_irq.h>
> >>> +#include <linux/sched_clock.h>
> >>> +#include <linux/slab.h>
> >>> +
> >>> +#define EPITCR                               0x00
> >>> +#define EPITSR                               0x04
> >>> +#define EPITLR                               0x08
> >>> +#define EPITCMPR                     0x0c
> >>> +#define EPITCNR                              0x10
> >>> +
> >>> +#define EPITCR_EN                    BIT(0)
> >>> +#define EPITCR_ENMOD                 BIT(1)
> >>> +#define EPITCR_OCIEN                 BIT(2)
> >>> +#define EPITCR_RLD                   BIT(3)
> >>> +#define EPITCR_PRESC(x)                      (((x) & 0xfff) << 4)
> >>> +#define EPITCR_SWR                   BIT(16)
> >>> +#define EPITCR_IOVW                  BIT(17)
> >>> +#define EPITCR_DBGEN                 BIT(18)
> >>> +#define EPITCR_WAITEN                        BIT(19)
> >>> +#define EPITCR_RES                   BIT(20)
> >>> +#define EPITCR_STOPEN                        BIT(21)
> >>> +#define EPITCR_OM_DISCON             (0 << 22)
> >>> +#define EPITCR_OM_TOGGLE             (1 << 22)
> >>> +#define EPITCR_OM_CLEAR                      (2 << 22)
> >>> +#define EPITCR_OM_SET                        (3 << 22)
> >>> +#define EPITCR_CLKSRC_OFF            (0 << 24)
> >>> +#define EPITCR_CLKSRC_PERIPHERAL     (1 << 24)
> >>> +#define EPITCR_CLKSRC_REF_HIGH               (2 << 24)
> >>> +#define EPITCR_CLKSRC_REF_LOW                (3 << 24)
> >>> +
> >>> +#define EPITSR_OCIF                  BIT(0)
> >>> +
> >>> +struct epit_timer {
> >>> +     void __iomem *base;
> >>> +     int irq;
> >>> +     struct clk *clk;
> >>> +     struct clock_event_device ced;
> >>> +     struct irqaction act;
> >>> +};
> >>> +
> >>> +static void __iomem *sched_clock_reg;
> >>> +
> >>> +static inline struct epit_timer *to_epit_timer(struct clock_event_de=
vice *ced)
> >>> +{
> >>> +     return container_of(ced, struct epit_timer, ced);
> >>> +}
> >>> +
> >>> +static inline void epit_irq_disable(struct epit_timer *epittm)
> >>> +{
> >>> +     u32 val;
> >>> +
> >>> +     val =3D readl_relaxed(epittm->base + EPITCR);
> >>> +     writel_relaxed(val & ~EPITCR_OCIEN, epittm->base + EPITCR);
> >>> +}
> >>> +
> >>> +static inline void epit_irq_enable(struct epit_timer *epittm)
> >>> +{
> >>> +     u32 val;
> >>> +
> >>> +     val =3D readl_relaxed(epittm->base + EPITCR);
> >>> +     writel_relaxed(val | EPITCR_OCIEN, epittm->base + EPITCR);
> >>> +}
> >>> +
> >>> +static void epit_irq_acknowledge(struct epit_timer *epittm)
> >>> +{
> >>> +     writel_relaxed(EPITSR_OCIF, epittm->base + EPITSR);
> >>> +}
> >>> +
> >>> +static u64 notrace epit_read_sched_clock(void)
> >>> +{
> >>> +     return ~readl_relaxed(sched_clock_reg);
> >>> +}
> >>> +
> >>> +static int epit_set_next_event(unsigned long cycles,
> >>> +                            struct clock_event_device *ced)
> >>> +{
> >>> +     struct epit_timer *epittm =3D to_epit_timer(ced);
> >>> +     unsigned long tcmp;
> >>> +
> >>> +     tcmp =3D readl_relaxed(epittm->base + EPITCNR) - cycles;
> >>> +     writel_relaxed(tcmp, epittm->base + EPITCMPR);
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +/* Left event sources disabled, no more interrupts appear */
> >>> +static int epit_shutdown(struct clock_event_device *ced)
> >>> +{
> >>> +     struct epit_timer *epittm =3D to_epit_timer(ced);
> >>> +     unsigned long flags;
> >>> +
> >>> +     /*
> >>> +      * The timer interrupt generation is disabled at least
> >>> +      * for enough time to call epit_set_next_event()
> >>> +      */
> >>> +     local_irq_save(flags);
> >>
> >> This is not necessary. This function is called with interrupt disabled=
.
> >
> > I took this from the i.MX GPT Timer :
> > https://elixir.bootlin.com/linux/latest/source/drivers/clocksource/time=
r-imx-gpt.c#L208
> >
> > Do you think i should also fix on the imx gpt timer ?
>
> Yes, the pointed code is 10 years old, so if you are willing to do the
> changes in a separate patchset, that would be nice.
>
> >>> +     /* Disable interrupt in EPIT module */
> >>> +     epit_irq_disable(epittm);
> >>> +
> >>> +     /* Clear pending interrupt */
> >>> +     epit_irq_acknowledge(epittm);
> >>
> >> No irq ack is needed here. Neither disabling the interrupt.
> > Is it done by the framework ?
> >
> > I took also this from the IMX GPT driver
>
> If we reach this point of code with a pending timer interrupt, that
> means it should be processed after the clockevent shutdown path is
> finished. Otherwise it is like we cancel the timer on the back of the
> system.

Thanks for pointing out that. This is actually the first timer driver
that I touch.
I found all this a bit crappy and I have lazily copy/paste from imx-gpt dri=
ver.
for me it should more propre to have something like the
"timer-npcm7xx.c" driver.
I'm looking to understand a bit more the framework before cleaning
this. Could you point me any documentation about the framework,
Specially what should set_state_**,  and tick_resume should do. I'm
septic about this "ced->tick_resume =3D epit_shutdown;"

Also do you have some test that i could run to confirm the driver works fin=
e ?

Thanks,
Clement

>
> >> Why not just stop the counter ?
> > I will check the datasheet.
> >>> +     local_irq_restore(flags);
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int epit_set_oneshot(struct clock_event_device *ced)
> >>> +{
> >>> +     struct epit_timer *epittm =3D to_epit_timer(ced);
> >>> +     unsigned long flags;
> >>> +
> >>> +     /*
> >>> +      * The timer interrupt generation is disabled at least
> >>> +      * for enough time to call epit_set_next_event()
> >>> +      */
> >>> +     local_irq_save(flags);
> >>
> >> This is not necessary. This function is called with interrupt disabled=
.
> >>
> >>> +     /* Disable interrupt in EPIT module */
> >>> +     epit_irq_disable(epittm);
> >>> +
> >>> +     /* Clear pending interrupt, only while switching mode */
> >>> +     if (!clockevent_state_oneshot(ced))
> >>> +             epit_irq_acknowledge(epittm);
> >>
> >> Why do you need to ack the interrupt here ?
> >>
> >>> +     /*
> >>> +      * Do not put overhead of interrupt enable/disable into
> >>> +      * epit_set_next_event(), the core has about 4 minutes
> >>> +      * to call epit_set_next_event() or shutdown clock after
> >>> +      * mode switching
> >>> +      */
> >>> +     epit_irq_enable(epittm);
> >>> +     local_irq_restore(flags);
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static irqreturn_t epit_timer_interrupt(int irq, void *dev_id)
> >>> +{
> >>> +     struct clock_event_device *ced =3D dev_id;
> >>> +     struct epit_timer *epittm =3D to_epit_timer(ced);
> >>> +
> >>> +     epit_irq_acknowledge(epittm);
> >>> +
> >>> +     ced->event_handler(ced);
> >>> +
> >>> +     return IRQ_HANDLED;
> >>> +}
> >>> +
> >>> +static int __init epit_clocksource_init(struct epit_timer *epittm)
> >>> +{
> >>> +     unsigned int c =3D clk_get_rate(epittm->clk);
> >>> +
> >>> +     sched_clock_reg =3D epittm->base + EPITCNR;
> >>> +     sched_clock_register(epit_read_sched_clock, 32, c);
> >>> +
> >>> +     return clocksource_mmio_init(epittm->base + EPITCNR, "epit", c,=
 200, 32,
> >>> +                                  clocksource_mmio_readl_down);
> >>> +}
> >>> +
> >>> +static int __init epit_clockevent_init(struct epit_timer *epittm)
> >>> +{
> >>> +     struct clock_event_device *ced =3D &epittm->ced;
> >>> +     struct irqaction *act =3D &epittm->act;
> >>> +
> >>> +     ced->name =3D "epit";
> >>> +     ced->features =3D CLOCK_set_state_shutdownEVT_FEAT_ONESHOT | CL=
OCK_EVT_FEAT_DYNIRQ;
> >>> +     ced->set_state_shutdown =3D epit_shutdown;
> >>> +     ced->tick_resume =3D epit_shutdown;
> >>> +     ced->set_state_oneshot =3D epit_set_oneshot;
> >>> +     ced->set_next_event =3D epit_set_next_event;
> >>> +     ced->rating =3D 200;
> >>> +     ced->cpumask =3D cpumask_of(0);
> >>> +     ced->irq =3D epittm->irq;
> >>> +     clockevents_config_and_register(ced, clk_get_rate(epittm->clk),
> >>> +                                     0xff, 0xfffffffe);
> >>> +
> >>> +     act->name =3D "i.MX EPIT Timer Tick",
> >>> +     act->flags =3D IRQF_TIMER | IRQF_IRQPOLL;
> >>> +     act->handler =3D epit_timer_interrupt;
> >>> +     act->dev_id =3D ced;
> >>> +
> >>> +     /* Make irqs happen */
> >>> +     return setup_irq(epittm->irq, act);
> >>> +}
> >>> +
> >>> +static int __init epit_timer_init(struct device_node *np)
> >>> +{
> >>> +     struct epit_timer *epittm;
> >>> +     int ret;
> >>> +
> >>> +     epittm =3D kzalloc(sizeof(*epittm), GFP_KERNEL);
> >>> +     if (!epittm)
> >>> +             return -ENOMEM;
> >>> +
> >>> +     epittm->base =3D of_iomap(np, 0);
> >>> +     if (!epittm->base) {
> >>> +             ret =3D -ENXIO;
> >>> +             goto out_kfree;
> >>> +     }
> >>> +
> >>> +     epittm->irq =3D irq_of_parse_and_map(np, 0);
> >>> +     if (!epittm->irq) {
> >>> +             ret =3D -EINVAL;
> >>> +             goto out_iounmap;
> >>> +     }
> >>> +
> >>> +     /* Get EPIT clock */
> >>> +     epittm->clk =3D of_clk_get(np, 0);
> >>> +     if (IS_ERR(epittm->clk)) {
> >>> +             pr_err("i.MX EPIT: unable to get clk\n");
> >>> +             ret =3D PTR_ERR(epittm->clk);
> >>> +             goto out_iounmap;
> >>> +     }
> >>> +
> >>> +     ret =3D clk_prepare_enable(epittm->clk);
> >>> +     if (ret) {
> >>> +             pr_err("i.MX EPIT: unable to prepare+enable clk\n");
> >>> +             goto out_iounmap;
> >>> +     }
> >>
> >> Please replace all the above with the timer-of API as:
> > Ok I will,
> >
> > Thanks
> > Clement
> >
> >>
> >> https://patchwork.kernel.org/patch/10510443/
> >>
> >>
> >>> +     /* Initialise to a known state (all timers off, and timing rese=
t) */
> >>> +     writel_relaxed(0x0, epittm->base + EPITCR);
> >>> +     writel_relaxed(0xffffffff, epittm->base + EPITLR);
> >>> +     writel_relaxed(EPITCR_EN | EPITCR_CLKSRC_REF_HIGH | EPITCR_WAIT=
EN,
> >>> +                    epittm->base + EPITCR);
> >>> +
> >>> +     ret =3D epit_clocksource_init(epittm);
> >>> +     if (ret) {
> >>> +             pr_err("i.MX EPIT: failed to init clocksource\n");
> >>> +             goto out_clk_disable;
> >>> +     }
> >>> +
> >>> +     ret =3D epit_clockevent_init(epittm);
> >>> +     if (ret) {
> >>> +             pr_err("i.MX EPIT: failed to init clockevent\n");
> >>> +             goto out_clk_disable;
> >>> +     }
> >>> +
> >>> +     return 0;
> >>> +
> >>> +out_clk_disable:
> >>> +     clk_disable_unprepare(epittm->clk);
> >>> +out_iounmap:
> >>> +     iounmap(epittm->base);
> >>> +out_kfree:
> >>> +     kfree(epittm);
> >>> +
> >>> +     return ret;
> >>> +}
> >>> +TIMER_OF_DECLARE(epit_timer, "fsl,imx31-epit", epit_timer_init);
> >>>
> >>
> >>
> >> --
> >>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs
> >>
> >> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> >> <http://twitter.com/#!/linaroorg> Twitter |
> >> <http://www.linaro.org/linaro-blog/> Blog
> >>
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
