Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B13C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D4720849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D4720849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeLKOmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:42:01 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48712 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbeLKOmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:42:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB9CA1596;
        Tue, 11 Dec 2018 06:41:59 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DB133F575;
        Tue, 11 Dec 2018 06:41:58 -0800 (PST)
Subject: Re: [PATCH] irq/irq_sim: store multiple interrupt offsets in a bitmap
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181109172132.30939-1-brgl@bgdev.pl>
 <CAMRc=MeY_CbdQDF7UOai5MW3OLF1u+a04AAyq5bsux8_Fv5DVQ@mail.gmail.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <204b38d9-7658-f21d-3153-e1d9db749550@arm.com>
Date:   Tue, 11 Dec 2018 14:41:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=MeY_CbdQDF7UOai5MW3OLF1u+a04AAyq5bsux8_Fv5DVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2018 14:02, Bartosz Golaszewski wrote:
> pt., 9 lis 2018 o 18:21 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
>>
>> Two threads can try to fire the irq_sim with different offsets and will
>> end up fighting for the irq_work asignment. Thomas Gleixner suggested a
>> solution based on a bitfield where we set a bit for every offset
>> associated with an interrupt that should be fired and then iterate over
>> all set bits in the interrupt handler.
>>
>> This is a slightly modified solution using a bitmap so that we don't
>> impose a limit on the number of interrupts one can allocate with
>> irq_sim.
>>
>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>> ---
>>  include/linux/irq_sim.h |  2 +-
>>  kernel/irq/irq_sim.c    | 23 +++++++++++++++++++++--
>>  2 files changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
>> index 630a57e55db6..4500d453a63e 100644
>> --- a/include/linux/irq_sim.h
>> +++ b/include/linux/irq_sim.h
>> @@ -16,7 +16,7 @@
>>
>>  struct irq_sim_work_ctx {
>>         struct irq_work         work;
>> -       int                     irq;
>> +       unsigned long           *pending;
>>  };
>>
>>  struct irq_sim_irq_ctx {
>> diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
>> index dd20d0d528d4..98a20e1594ce 100644
>> --- a/kernel/irq/irq_sim.c
>> +++ b/kernel/irq/irq_sim.c
>> @@ -34,9 +34,20 @@ static struct irq_chip irq_sim_irqchip = {
>>  static void irq_sim_handle_irq(struct irq_work *work)
>>  {
>>         struct irq_sim_work_ctx *work_ctx;
>> +       unsigned int offset = 0;
>> +       struct irq_sim *sim;
>> +       int irqnum;
>>
>>         work_ctx = container_of(work, struct irq_sim_work_ctx, work);
>> -       handle_simple_irq(irq_to_desc(work_ctx->irq));
>> +       sim = container_of(work_ctx, struct irq_sim, work_ctx);
>> +
>> +       while (!bitmap_empty(work_ctx->pending, sim->irq_count)) {
>> +               offset = find_next_bit(work_ctx->pending,
>> +                                      sim->irq_count, offset);
>> +               clear_bit(offset, work_ctx->pending);
>> +               irqnum = irq_sim_irqnum(sim, offset);
>> +               handle_simple_irq(irq_to_desc(irqnum));
>> +       }
>>  }
>>
>>  /**
>> @@ -63,6 +74,13 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
>>                 return sim->irq_base;
>>         }
>>
>> +       sim->work_ctx.pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
>> +       if (!sim->work_ctx.pending) {
>> +               kfree(sim->irqs);
>> +               irq_free_descs(sim->irq_base, num_irqs);
>> +               return -ENOMEM;
>> +       }
>> +
>>         for (i = 0; i < num_irqs; i++) {
>>                 sim->irqs[i].irqnum = sim->irq_base + i;
>>                 sim->irqs[i].enabled = false;
>> @@ -89,6 +107,7 @@ EXPORT_SYMBOL_GPL(irq_sim_init);
>>  void irq_sim_fini(struct irq_sim *sim)
>>  {
>>         irq_work_sync(&sim->work_ctx.work);
>> +       bitmap_free(sim->work_ctx.pending);
>>         irq_free_descs(sim->irq_base, sim->irq_count);
>>         kfree(sim->irqs);
>>  }
>> @@ -143,7 +162,7 @@ EXPORT_SYMBOL_GPL(devm_irq_sim_init);
>>  void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
>>  {
>>         if (sim->irqs[offset].enabled) {
>> -               sim->work_ctx.irq = irq_sim_irqnum(sim, offset);
>> +               set_bit(offset, sim->work_ctx.pending);
>>                 irq_work_queue(&sim->work_ctx.work);
>>         }
>>  }
>> --
>> 2.19.1
>>
> 
> Ping and Cc'ing Marc Zyngier. Any chance of getting this in for 4.21?

Bizarrely, I can't find any trace of this patch in my Inbox. I've now
cherry-picked from https://lore.kernel.org/patchwork/patch/1009297/ .

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
