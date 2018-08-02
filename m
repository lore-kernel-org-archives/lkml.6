Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C1DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A42F2150D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fQIYwZvw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CWQWKCnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A42F2150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbeHBOtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:49:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58718 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732267AbeHBOtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:49:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 22CCF60B1E; Thu,  2 Aug 2018 12:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533214709;
        bh=WAsKDfsBlOdJAwSInHo48tckSb6q0dfL/wYoLwUcIaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQIYwZvwmYHEeSXMR0CsVw9ogbJC9DqRXMtcO1ceEpuPTgJtferXsnKLmugWub57f
         oJ7+9U9vSlLccFlmfGwUyq/S6ZRm4x3MXWtDlNbE3/8BZJ/FVd3PBTCPTaE3lc7Nb5
         O/SJJGYnUCg0YjyOmr8XJaxJ/J0X2cPwVIOoLkR8=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11EFB60AD9;
        Thu,  2 Aug 2018 12:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533214708;
        bh=WAsKDfsBlOdJAwSInHo48tckSb6q0dfL/wYoLwUcIaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CWQWKCnO8sfbf4kRAZrH2IcVYcok90MCfvs8Uhv5acpSlgAgC5+bmtnTGp3boE9Mp
         KBn5NL5hZP7paI1XH1DK5EG52vMqTQWLqNXrE3dJxqsm3A1AtEkwyRmG+QK4RaVYZb
         HvGWc1hSFH5LeiGQG7XuvmeSunSTRB/5fRQCvah8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11EFB60AD9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 2 Aug 2018 06:58:27 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     swboyd@chromium.org, evgreen@chromium.org,
        linus.walleij@linaro.org, bjorn.andersson@linaro.org,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND RFC 1/4] drivers: pinctrl: qcom: add wakeup
 capability to GPIO
Message-ID: <20180802125827.GB27850@codeaurora.org>
References: <20180801020021.9782-1-ilina@codeaurora.org>
 <20180801020021.9782-2-ilina@codeaurora.org>
 <86600uy4vh.wl-marc.zyngier@arm.com>
 <20180801194538.GA6422@codeaurora.org>
 <86wot9wb9u.wl-marc.zyngier@arm.com>
 <20180802065104.GA27850@codeaurora.org>
 <86sh3xw7m9.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <86sh3xw7m9.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02 2018 at 01:27 -0600, Marc Zyngier wrote:
>On Thu, 02 Aug 2018 07:51:04 +0100,
>Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> On Thu, Aug 02 2018 at 00:08 -0600, Marc Zyngier wrote:
>> > Hi Lina,
>> >
>> > On Wed, 01 Aug 2018 20:45:38 +0100,
>> > Lina Iyer <ilina@codeaurora.org> wrote:
>> >>
>> >> Thanks for the feedback, Marc.
>> >>
>> >> On Wed, Aug 01 2018 at 00:31 -0600, Marc Zyngier wrote:
>> >> > On Wed, 01 Aug 2018 03:00:18 +0100,
>> >> > Lina Iyer <ilina@codeaurora.org> wrote:
>> >> >>
>> >> >> +static irqreturn_t wake_irq_gpio_handler(int irq, void *data)
>> >> >> +{
>> >> >> +	struct irq_data *irqd = data;
>> >> >> +	struct irq_desc *desc = irq_data_to_desc(irqd);
>> >> >> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>> >> >> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
>> >> >> +	int irq_pin = irq_find_mapping(gc->irq.domain, irqd->hwirq);
>> >> >> +
>> >> >> +	chained_irq_enter(chip, desc);
>> >> >> +	generic_handle_irq(irq_pin);
>> >> >> +	chained_irq_exit(chip, desc);
>> >> >
>> >> > That's crazy. I'm not even commenting on the irq handler vs chained
>> >> > irqchip thing, but directly calling into a completely different part
>> >> > of the irq hierarchy makes me feel nauseous,
>> >> >
>> >> I know the sentiment; I am not too happy about it myself. Explanation
>> >> below.
>> >>
>> >> > Why isn't the interrupt still pending at the pinctrl level? Looking at
>> >> > the diagram in the cover letter, I'd have hoped that the signal routed
>> >> > to the PDC would wakeup the GIC, but that by virtue of being *also*
>> >> > wired to the TLMM, the interrupt would be handled via the normal path.
>> >> >
>> >> The short answer: TLMM is not active to sense a wakeup interrupt.
>> >
>> > I get that bit. See below for the bit I don't get.
>> >
>> >> When we enter system sleep mode, the TLMM and the GIC are powered off
>> >> and the PDC is the only powered-on interrupt controller. The IRQs
>> >> configured at the PDC are the only ones capable of waking the system.
>> >> Upon sensing the interrupt, the PDC intiates a system wakeup and replays
>> >> the interrupt to the GIC. The GIC relays that to AP. Unfortunately, the
>> >> interrupts from the GPIO do not trigger the TLMM summary line. Therefore
>> >> this handler needs to figure out what GPIO caused the wakeup and notify
>> >> the corresponding driver.
>> >
>> > That's most bizarre. What causes the TLMM output line not to reflect
>> > the fact that an input is asserted?
>> There is a parallel line that is directed from the PIN directly to the
>> PDC in addition to the TLMM. This line does not go through the TLMM.
>
>I got that from the cover letter.
>
>>
>> Active path						_____
>>                 /-------------- > [ TLMM ] --------> |     |
>>            [ Device GPIO ]	   	     summary   | GIC | ==>
>> 		\				       |     |
>> 		  ----------------> [ PDC ] ---------> |_____|
>> Wakeup path	     GPIO as IRQ		IRQ
>>
>> > I understand that it has been
>> > turned off, but surely the PDC wakes it up at the same time as the
>> > GIC, and it should realise that there is something pending...
>> >
>> PDC is always-on and when it detects any interrupt, will wakeup the GIC
>> and then replay the interrupt line to the GIC. This interrupt line is
>> not the summary line, but a separate line from GPIO/PIN to the PDC.
>>
>> Since the TLMM was also in low power mode, when the GIC was powered
>> down, the TLMM never sees the IRQ and therefore will not send the
>> summary line to GIC. The wakeup path is GPIO -> PDC -> GIC.
>
>Sure. But once woken up (GIC *and* TLMM), the gpio line (which I
>assume is level) is still high at the TLMM input. So why isn't it
>registering that state once it has been woken up?
>
>I can understand that it would be missing an edge. But that doesn't
>hold for level signalling.
>
Sure, yes. Sorry for not registering your point in my response.
Once woken up we should see the level interrupt in TLMM.

-- Lina

>>
>> >> > Why isn't that the case? And if that's because the HW is broken and
>> >> > doesn't buffer edge interrupts, why can't you use the resend mechanism
>> >> > instead?
>> >> >
>> >> The PDC hardware can replay the interrupts accurately. However, it will
>> >> replay only the pin and its not the TLMM summary IRQ. The handler here,
>> >> needs to notify the driver that the wakeup interrupt happened and needs
>> >> to take action. If I could trip the summary IRQ in this handler that
>> >> would work too. Can it be done?
>> >
>> > So the TLMM has indeed noticed the interrupt and you can read the TLMM
>> > status registers to find out what fired?
>> I think that's where it is probably confusing. The TLMM will not see the
>> interrupt because it was in low power mode.
>
>See above. I can buy that for edge, but not level.
>
>Thanks,
>
>	M.
>
>--
>Jazz is not dead, it just smell funny.
