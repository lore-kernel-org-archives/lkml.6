Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rERWGCtvHlu5YAAAmS7hNA
	; Mon, 11 Jun 2018 12:46:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 47AA760792; Mon, 11 Jun 2018 12:46:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="fXqr2h0l"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 83AF560351;
	Mon, 11 Jun 2018 12:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83AF560351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932898AbeFKMqc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 08:46:32 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:36962 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbeFKMq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:46:29 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D7BA35C0109;
        Mon, 11 Jun 2018 14:46:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1528721187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2l4IJEfEiwlbvwevmTGNE97K6HLQwewqousD8Rf4KsY=;
        b=fXqr2h0lR6/QRy/28zLiKbXxeUZ7Q7b+rofsuP410MmKV6gyFLcf8cM9Ts4IAzLEkzlDEu
        dXUO2ooRNUTFjaFM+ANqXYlg2Mz6SUQwpODhuhZhFgmZPwgPptzXicHiZhAobvzWQ359q+
        4aN4GqnWqSKKnfqi62B0GmVttcYGuMM=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Mon, 11 Jun 2018 14:46:27 +0200
From: Stefan Agner <stefan@agner.ch>
To: =?UTF-8?Q?Cl=C3=A9ment_P=C3=A9ron?= <peron.clem@gmail.com>
Cc: Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?UTF-8?Q?Cl=C3=A9ment_Peron?= <clement.peron@devialet.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [PATCH v6 4/5] clocksource: add driver for i.MX EPIT timer
In-Reply-To: <CAJiuCcdHKpfCkLhV=rZcLHx2k9BAh7bnDQMWDkquXJOYiQoTeA@mail.gmail.com>
References: <20180607140544.22268-1-peron.clem@gmail.com>
 <20180607140544.22268-5-peron.clem@gmail.com>
 <5df13d8f6422d9099c1692dd2091d9ca@agner.ch>
 <CAJiuCcdHKpfCkLhV=rZcLHx2k9BAh7bnDQMWDkquXJOYiQoTeA@mail.gmail.com>
Message-ID: <a010621ceec0bf748e4393a3db322a28@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-2.70 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[14];
         TAGGED_RCPT(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         URL_IN_SUBJECT(0.40)[i.mx];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.06.2018 14:42, Clément Péron wrote:
> Hi Stefan,
> 
> 
>> > +
>> > +#define EPITCR                               0x00
>> > +#define EPITSR                               0x04
>> > +#define EPITLR                               0x08
>> > +#define EPITCMPR                     0x0c
>> > +#define EPITCNR                              0x10
>> > +
>> > +#define EPITCR_EN                    BIT(0)
>> > +#define EPITCR_ENMOD                 BIT(1)
>> > +#define EPITCR_OCIEN                 BIT(2)
>> > +#define EPITCR_RLD                   BIT(3)
>> > +#define EPITCR_PRESC(x)                      (((x) & 0xfff) << 4)
>> > +#define EPITCR_SWR                   BIT(16)
>> > +#define EPITCR_IOVW                  BIT(17)
>> > +#define EPITCR_DBGEN                 BIT(18)
>> > +#define EPITCR_WAITEN                        BIT(19)
>> > +#define EPITCR_RES                   BIT(20)
>> > +#define EPITCR_STOPEN                        BIT(21)
>> > +#define EPITCR_OM_DISCON             (0 << 22)
>> > +#define EPITCR_OM_TOGGLE             (1 << 22)
>> > +#define EPITCR_OM_CLEAR                      (2 << 22)
>> > +#define EPITCR_OM_SET                        (3 << 22)
>> > +#define EPITCR_CLKSRC_OFF            (0 << 24)
>> > +#define EPITCR_CLKSRC_PERIPHERAL     (1 << 24)
>> > +#define EPITCR_CLKSRC_REF_HIGH               (2 << 24)
>> > +#define EPITCR_CLKSRC_REF_LOW                (3 << 24)
>> > +
>> > +#define EPITSR_OCIF                  BIT(0)
>> > +
>> > +struct epit_timer {
>> > +     void __iomem *base;
>> > +     int irq;
>> > +     struct clk *clk;
>> > +     struct clock_event_device ced;
>> > +     struct irqaction act;
>> > +};
>> > +
>> > +static void __iomem *sched_clock_reg;
>> > +
>> > +static inline struct epit_timer *to_epit_timer(struct clock_event_device *ced)
>> > +{
>> > +     return container_of(ced, struct epit_timer, ced);
>> > +}
>> > +
>> > +static inline void epit_irq_disable(struct epit_timer *epittm)
>> > +{
>> > +     u32 val;
>> > +
>> > +     val = readl_relaxed(epittm->base + EPITCR);
>> > +     writel_relaxed(val & ~EPITCR_OCIEN, epittm->base + EPITCR);
>> > +}
>> > +
>> > +static inline void epit_irq_enable(struct epit_timer *epittm)
>> > +{
>> > +     u32 val;
>> > +
>> > +     val = readl_relaxed(epittm->base + EPITCR);
>> > +     writel_relaxed(val | EPITCR_OCIEN, epittm->base + EPITCR);
>> > +}
>> > +
>> > +static void epit_irq_acknowledge(struct epit_timer *epittm)
>> > +{
>> > +     writel_relaxed(EPITSR_OCIF, epittm->base + EPITSR);
>> > +}
>> > +
>> > +static u64 notrace epit_read_sched_clock(void)
>> > +{
>> > +     return ~readl_relaxed(sched_clock_reg);
>> > +}
>> > +
>> > +static int epit_set_next_event(unsigned long cycles,
>> > +                            struct clock_event_device *ced)
>> > +{
>> > +     struct epit_timer *epittm = to_epit_timer(ced);
>> > +     unsigned long tcmp;
>> > +
>> > +     tcmp = readl_relaxed(epittm->base + EPITCNR) - cycles;
>> > +     writel_relaxed(tcmp, epittm->base + EPITCMPR);
>> > +
>> > +     return 0;
>> > +}
>> > +
>> > +/* Left event sources disabled, no more interrupts appear */
>> > +static int epit_shutdown(struct clock_event_device *ced)
>> > +{
>> > +     struct epit_timer *epittm = to_epit_timer(ced);
>> > +     unsigned long flags;
>> > +
>> > +     /*
>> > +      * The timer interrupt generation is disabled at least
>> > +      * for enough time to call epit_set_next_event()
>> > +      */
>> > +     local_irq_save(flags);
>> > +
>> > +     /* Disable interrupt in EPIT module */
>> > +     epit_irq_disable(epittm);
>> > +
>> > +     /* Clear pending interrupt */
>> > +     epit_irq_acknowledge(epittm);
>> > +
>> > +     local_irq_restore(flags);
>> > +
>> > +     return 0;
>> > +}
>> > +
>> > +static int epit_set_oneshot(struct clock_event_device *ced)
>> > +{
>> > +     struct epit_timer *epittm = to_epit_timer(ced);
>> > +     unsigned long flags;
>> > +
>> > +     /*
>> > +      * The timer interrupt generation is disabled at least
>> > +      * for enough time to call epit_set_next_event()
>> > +      */
>> > +     local_irq_save(flags);
>> > +
>> > +     /* Disable interrupt in EPIT module */
>> > +     epit_irq_disable(epittm);
>> > +
>> > +     /* Clear pending interrupt, only while switching mode */
>> > +     if (!clockevent_state_oneshot(ced))
>> > +             epit_irq_acknowledge(epittm);
>> > +
>> > +     /*
>> > +      * Do not put overhead of interrupt enable/disable into
>> > +      * epit_set_next_event(), the core has about 4 minutes
>> > +      * to call epit_set_next_event() or shutdown clock after
>> > +      * mode switching
>> > +      */
>> > +     epit_irq_enable(epittm);
>> > +     local_irq_restore(flags);
>> > +
>> > +     return 0;
>> > +}
>> > +
>> > +static irqreturn_t epit_timer_interrupt(int irq, void *dev_id)
>> > +{
>> > +     struct clock_event_device *ced = dev_id;
>> > +     struct epit_timer *epittm = to_epit_timer(ced);
>> > +
>> > +     epit_irq_acknowledge(epittm);
>> > +
>> > +     ced->event_handler(ced);
>> > +
>> > +     return IRQ_HANDLED;
>> > +}
>> > +
>> > +static int __init epit_clocksource_init(struct epit_timer *epittm)
>> > +{
>> > +     unsigned int c = clk_get_rate(epittm->clk);
>> > +
>> > +     sched_clock_reg = epittm->base + EPITCNR;
>> > +     sched_clock_register(epit_read_sched_clock, 32, c);
>> > +
>> > +     return clocksource_mmio_init(epittm->base + EPITCNR, "epit", c, 200, 32,
>> > +                                  clocksource_mmio_readl_down);
>> > +}
>> > +
>> > +static int __init epit_clockevent_init(struct epit_timer *epittm)
>> > +{
>> > +     struct clock_event_device *ced = &epittm->ced;
>> > +     struct irqaction *act = &epittm->act;
>> > +
>> > +     ced->name = "epit";
>> > +     ced->features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_DYNIRQ;
>> > +     ced->set_state_shutdown = epit_shutdown;
>> > +     ced->tick_resume = epit_shutdown;
>> > +     ced->set_state_oneshot = epit_set_oneshot;
>> > +     ced->set_next_event = epit_set_next_event;
>> > +     ced->rating = 200;
>> > +     ced->cpumask = cpumask_of(0);
>> > +     ced->irq = epittm->irq;
>> > +     clockevents_config_and_register(ced, clk_get_rate(epittm->clk),
>> > +                                     0xff, 0xfffffffe);
>> > +
>> > +     act->name = "i.MX EPIT Timer Tick",
>> > +     act->flags = IRQF_TIMER | IRQF_IRQPOLL;
>> > +     act->handler = epit_timer_interrupt;
>> > +     act->dev_id = ced;
>> > +
>> > +     /* Make irqs happen */
>> > +     return setup_irq(epittm->irq, act);
>> > +}
>> > +
>> > +static int __init epit_timer_init(struct device_node *np)
>> > +{
>> > +     struct epit_timer *epittm;
>> > +     int ret;
>> > +
>> > +     epittm = kzalloc(sizeof(*epittm), GFP_KERNEL);
>> > +     if (!epittm)
>> > +             return -ENOMEM;
>> > +
>> > +     epittm->base = of_iomap(np, 0);
>> > +     if (!epittm->base) {
>> > +             ret = -ENXIO;
>> > +             goto out_kfree;
>> > +     }
>> > +
>> > +     epittm->irq = irq_of_parse_and_map(np, 0);
>> > +     if (!epittm->irq) {
>> > +             ret = -EINVAL;
>> > +             goto out_iounmap;
>> > +     }
>> > +
>> > +        /* Get EPIT clock */
>> > +        epittm->clk = of_clk_get(np, 0);
>> > +        if (IS_ERR(epittm->clk)) {
>> > +             pr_err("i.MX EPIT: unable to get clk\n");
>> > +             ret = PTR_ERR(epittm->clk);
>> > +             goto out_iounmap;
>> > +        }
>>
>> There is something off with indent here.
> Thanks for pointing out that, I will fix it.
> 
>>
>> There is a helper library in drivers/clocksource/timer-of.c which might
>> be useful for this driver.
> Indeed, but will require a bit of rewrite.

That is fine for me ;-) Afaict, if should be simplify code a quite a
bit, and doable with reasonable amount of work.

It is typically the expectation for new drivers to make use of such
libraries. In the end it is up to the clocksource maintainer(s) to
decide whether they make it as an requirement for this driver.

--
Stefan

> 
> Clement
> 
>>
>> --
>> Stefan
>>
>> > +
>> > +     ret = clk_prepare_enable(epittm->clk);
>> > +     if (ret) {
>> > +             pr_err("i.MX EPIT: unable to prepare+enable clk\n");
>> > +             goto out_iounmap;
>> > +     }
>> > +
>> > +     /* Initialise to a known state (all timers off, and timing reset) */
>> > +     writel_relaxed(0x0, epittm->base + EPITCR);
>> > +     writel_relaxed(0xffffffff, epittm->base + EPITLR);
>> > +     writel_relaxed(EPITCR_EN | EPITCR_CLKSRC_REF_HIGH | EPITCR_WAITEN,
>> > +                    epittm->base + EPITCR);
>> > +
>> > +     ret = epit_clocksource_init(epittm);
>> > +     if (ret) {
>> > +             pr_err("i.MX EPIT: failed to init clocksource\n");
>> > +             goto out_clk_disable;
>> > +     }
>> > +
>> > +     ret = epit_clockevent_init(epittm);
>> > +     if (ret) {
>> > +             pr_err("i.MX EPIT: failed to init clockevent\n");
>> > +             goto out_clk_disable;
>> > +     }
>> > +
>> > +     return 0;
>> > +
>> > +out_clk_disable:
>> > +     clk_disable_unprepare(epittm->clk);
>> > +out_iounmap:
>> > +     iounmap(epittm->base);
>> > +out_kfree:
>> > +     kfree(epittm);
>> > +
>> > +     return ret;
>> > +}
>> > +TIMER_OF_DECLARE(epit_timer, "fsl,imx31-epit", epit_timer_init);
