Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1413EECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC754205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O/iKKZzN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WborTFV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC754205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbeJYFPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 01:15:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39294 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeJYFPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 01:15:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5AF7F60C1B; Wed, 24 Oct 2018 20:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540413946;
        bh=CWAVh2E9+zvI5WSnAzJLij6F1gk+JJeob0PevFlt5/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O/iKKZzNCJjSqA/J6hb56BvyXG58JBWuIqG1balZ2/21JEyT0LHYBkJ61I3sr9gG4
         HQxNi/ZgsDf6JYutUus000Qih8Tdc+yPJduy//Afsug6z/UvhlCFXS1pUm9SnDtk2H
         SgfgcEozYBpwXBD6RjPa6rXr46CjiYd7GFuzrH4s=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 27878601CF;
        Wed, 24 Oct 2018 20:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540413945;
        bh=CWAVh2E9+zvI5WSnAzJLij6F1gk+JJeob0PevFlt5/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WborTFV5Y/P3GdrNPGQRgwuGfSNnXstp2e/j/0UMryZ7PL9eZ5oTxxPOiePpPmDlc
         WKqXE2Qw6bmYE3CVdG9U+LthIr+gwgSdXdC01DbN+8ndnwYa8cXgxIaSDP7kT8B8Yo
         UNNa7OItOYSCYd+lO072rNQTuhYSwT3qwHTiZRZI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27878601CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 24 Oct 2018 14:45:44 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     sboyd@kernel.org, evgreen@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/1] drivers: pinctrl: qcom: add wakeup capability to
 GPIO
Message-ID: <20181024204544.GH17444@codeaurora.org>
References: <20181011002958.2597-1-ilina@codeaurora.org>
 <20181011002958.2597-2-ilina@codeaurora.org>
 <20181019153222.GA17444@codeaurora.org>
 <ad6e314b-2d68-2a77-b77c-54cade0fe0b2@arm.com>
 <20181019194712.GB17444@codeaurora.org>
 <86a7n6tjqa.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <86a7n6tjqa.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22 2018 at 03:27 -0600, Marc Zyngier wrote:
>On Fri, 19 Oct 2018 20:47:12 +0100,
>Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> On Fri, Oct 19 2018 at 09:53 -0600, Marc Zyngier wrote:
>> > Hi Lina,
>> >
>> > On 19/10/18 16:32, Lina Iyer wrote:
>> >> Hi folks,
>> >>
>> >> On Wed, Oct 10 2018 at 18:30 -0600, Lina Iyer wrote:
>>
>> [...]
>>
>> >>> +static irqreturn_t wake_irq_gpio_handler(int irq, void *data)
>> >>> +{
>> >>> +	struct irq_data *irqd = data;
>> >>> +	struct irq_desc *desc = irq_to_desc(irqd->irq);
>> >>> +
>> >>> +	desc->handle_irq(desc);
>> >> Do we see any problem calling handle_irq()?
>> >
>> > Good timing, I was just looking at this.
>> >
>> :) Thanks for your time.
>>
>> > One thing I can see is that you will end-up calling the EOI callback on
>> > the root interrupt controller (the GIC), thus writing to ICC_EOIR1_EL1.
>> >
>> > But you've never acked this interrupt the first place by reading
>> > ICC_IAR1_EL1, and that puts you violently out of spec, according to the
>> > GICv3 spec (8.2.10), which reads:
>> >
>> > "A write to this register must correspond to the most recent valid read
>> > by this PE from an Interrupt Acknowledge Register, and must correspond
>> > to the INTID that was read from ICC_IAR1_EL1, otherwise the system
>> > behavior is UNPREDICTABLE."
>> >
>> > Here, you definitely risk the sanity of the CPU interface state machine.
>> >
>> Oh, thanks Marc. Will look into it. The problem is because I call
>> handle_irq() directly for the GPIO IRQ which is not triggered but we end
>> up mask, eoi etc.
>>
>> How about calling handle_simple_irq(), which doesn't seem to the IRQ
>> registers?
>
>The problem is that you cannot decide to use another flow handler, as
>this handler is a constraint imposed by the root interrupt
>controller. You can overload it, but you then need to make sure that
>the interrupt will *never* fire at the GIC level, ever.
>
>Can you actually enforce this?
>
Yes. With this appraoch in msm_gpio_irq_set_type(), we skip writing to
the GPIO's IRQ registers and it will not trigger an interrupt.

>Assuming you can, this could work. But then the subsequent question
>is: Why do you have the interrupt at the TLMM level at all? Overall,
>I'm a bit worried of this "now you see me, now you don't" kind of
>game behind the kernel back. Is there a way we can stop playing that
>game and stick to one single path for interrupt delivery?
>
The TLMM summary line will be triggered for other GPIOs that are not
wakeup capable and therefore will not have a parallel PDC interrupt.

>> > So stepping back a bit: At some point, you had a version that just
>> > relied on regenerating edge interrupts by writing to some register
>> > (knowing that level interrupts are safe by definition). Why isn't that
>> > the right solution? It'd avoid the above minefield by just letting the
>> > HW do its thing...
>> >
>> There are some unnecessary complexity with the approach that we are
>> trying to avoid.
>>
>> The TLMM may or not may not be powered off (depending on the SoC state)
>> and Linux has no control on it. The PDC will remain powered on but we
>> don't want the PDC interrupt enabled always, since we will receive to
>> interrupts (one from TLMM and one from PDC) for every event. So we have
>> to keep the PDC interrupt configured as wakeup interrupt but operate on
>> the fact that when we go into suspend or cpuidle we will have to switch
>> to enabling the PDC interrupt and disabling the GPIO IRQ and swap back
>> when we resume. This dance is harder with cpuidle (notifying the TLMM
>> driver, when all the CPUs are in idle) than suspend/resume which has
>> nice callbacks and is what we are trying to avoid but using the PDC
>> interrupt always.
>
>It looks to me that the way this logic is split across two drivers is
>a major cause of headache. My advise is that either you have one
>single point of interrupt handling for such interrupt, or you force a
>TLMM wake-up on such an event, forcing it to handle the interrupt the
>"normal way"...
>
The PDC irqchip's registers are the same ones used over here as well to
configure the wakeup interrupt. So locking acrossing the pinctrl and
irqchip would be annoying, but doable. Would like to avoid it if
possible.

Thanks,
Lina

