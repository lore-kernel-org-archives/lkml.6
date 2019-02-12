Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F9BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940D421B1C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfBLK16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:27:58 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34622 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbfBLK16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:27:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60F6080D;
        Tue, 12 Feb 2019 02:27:57 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B7273F557;
        Tue, 12 Feb 2019 02:27:56 -0800 (PST)
Subject: Re: [PATCH v2 3/9] irq/irq_sim: provide irq_sim_fire_type()
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190129084411.30495-1-brgl@bgdev.pl>
 <20190129084411.30495-4-brgl@bgdev.pl>
 <656763ec-41b9-cdee-22bd-1f32d74473a0@arm.com>
 <CAMpxmJXdyiSLyx7O5G41GzfJQktOS1JeuRUoHejVB3ZOmCFMLQ@mail.gmail.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <c562c67d-d6e3-15c3-b10b-315e8fb181a5@arm.com>
Date:   Tue, 12 Feb 2019 10:27:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAMpxmJXdyiSLyx7O5G41GzfJQktOS1JeuRUoHejVB3ZOmCFMLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2019 09:19, Bartosz Golaszewski wrote:
> wt., 12 lut 2019 o 10:10 Marc Zyngier <marc.zyngier@arm.com> napisał(a):
>>
>> On 29/01/2019 08:44, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> Provide a more specialized variant of irq_sim_fire() that allows to
>>> specify the type of the fired interrupt. The type is stored in the
>>> dummy irq context struct via the set_type callback.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> ---
>>>  include/linux/irq_sim.h |  9 ++++++++-
>>>  kernel/irq/irq_sim.c    | 26 ++++++++++++++++++++++----
>>>  2 files changed, 30 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
>>> index b96c2f752320..647a6c8ffb31 100644
>>> --- a/include/linux/irq_sim.h
>>> +++ b/include/linux/irq_sim.h
>>> @@ -23,6 +23,7 @@ struct irq_sim_work_ctx {
>>>
>>>  struct irq_sim_irq_ctx {
>>>       bool                    enabled;
>>> +     unsigned int            type;
>>>  };
>>>
>>>  struct irq_sim {
>>> @@ -37,7 +38,13 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs);
>>>  int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
>>>                     unsigned int num_irqs);
>>>  void irq_sim_fini(struct irq_sim *sim);
>>> -void irq_sim_fire(struct irq_sim *sim, unsigned int offset);
>>> +void irq_sim_fire_type(struct irq_sim *sim,
>>> +                    unsigned int offset, unsigned int type);
>>>  int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset);
>>>
>>> +static inline void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
>>> +{
>>> +     irq_sim_fire_type(sim, offset, IRQ_TYPE_DEFAULT);
>>> +}
>>> +
>>>  #endif /* _LINUX_IRQ_SIM_H */
>>> diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
>>> index 2bcdbab1bc5a..e3160b5e59b8 100644
>>> --- a/kernel/irq/irq_sim.c
>>> +++ b/kernel/irq/irq_sim.c
>>> @@ -25,6 +25,15 @@ static void irq_sim_irqunmask(struct irq_data *data)
>>>       irq_ctx->enabled = true;
>>>  }
>>>
>>> +static int irq_sim_set_type(struct irq_data *data, unsigned int type)
>>> +{
>>> +     struct irq_sim_irq_ctx *irq_ctx = irq_data_get_irq_chip_data(data);
>>> +
>>> +     irq_ctx->type = type;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>>  static void irq_sim_handle_irq(struct irq_work *work)
>>>  {
>>>       struct irq_sim_work_ctx *work_ctx;
>>> @@ -107,6 +116,7 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
>>>       sim->chip.name = "irq_sim";
>>>       sim->chip.irq_mask = irq_sim_irqmask;
>>>       sim->chip.irq_unmask = irq_sim_irqunmask;
>>> +     sim->chip.irq_set_type = irq_sim_set_type;
>>>
>>>       sim->work_ctx.pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
>>>       if (!sim->work_ctx.pending) {
>>> @@ -192,21 +202,29 @@ irq_sim_get_ctx(struct irq_sim *sim, unsigned int offset)
>>>  }
>>>
>>>  /**
>>> - * irq_sim_fire - Enqueue an interrupt.
>>> + * irq_sim_fire_type - Enqueue an interrupt.
>>>   *
>>>   * @sim:        The interrupt simulator object.
>>>   * @offset:     Offset of the simulated interrupt which should be fired.
>>> + * @type:    Type of the fired interrupt. Must be one of the following:
>>> + *           IRQ_TYPE_EDGE_RISING, IRQ_TYPE_EDGE_FALLING,
>>> + *           IRQ_TYPE_EDGE_BOTH, IRQ_TYPE_LEVEL_HIGH,
>>> + *           IRQ_TYPE_LEVEL_LOW, IRQ_TYPE_DEFAULT
>>>   */
>>> -void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
>>> +void irq_sim_fire_type(struct irq_sim *sim,
>>> +                    unsigned int offset, unsigned int type)
>>>  {
>>>       struct irq_sim_irq_ctx *ctx = irq_sim_get_ctx(sim, offset);
>>>
>>> -     if (ctx->enabled) {
>>> +     /* Only care about relevant flags. */
>>> +     type &= IRQ_TYPE_SENSE_MASK;
>>> +
>>> +     if (ctx->enabled && (ctx->type & type)) {
>>
>> I wonder how realistic this is, given that you do not track the release
>> of a level. In short, mo matter what the type is, you treat everything
>> as edge.
>>
>> What is the point of this?
>>
> 
> When userspace wants to monitor GPIO line interrupts, the GPIO
> framework requests a threaded interrupt with IRQF_TRIGGER_FALLING,
> IRQF_TRIGGER_RISING or both. The testing module tries to act like real
> hardware and so if we pass only one of the *_TRIGGER_* flags, we want
> the simulated interrupt of corresponding type to be fired.

Well, that's not how HW works.

> 
> Another solution - if you don't like this one -  would be to have more
> specialized functions: irq_sim_fire_rising() and
> irq_sim_fire_falling(). How about that?

I think you're missing the point. So far, your API has been "an
interrupt has fired", no matter what the trigger is, and that's fine.
That's just modeling the output of an abstract interrupt controller into
whatever the irqsim is simulating.

Now, what you're exposing is "this is how the line changed". Which is an
entirely different business, as you're now exposing the device output
line. Yes, you can model it with raising/falling, but you need at least
resampling for level interrupts, and actual edge detection (raising
followed by raising only generates a single interrupt, while
raising-falling-raising generates two).

At the moment, I don't see any of that so I seriously doubt the validity
of the approach.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
