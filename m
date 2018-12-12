Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8610C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DD32087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7Y1rMiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DD32087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbeLLCEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:04:42 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44486 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLLCEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:04:42 -0500
Received: by mail-io1-f68.google.com with SMTP id r200so13525638iod.11;
        Tue, 11 Dec 2018 18:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IYDjAh2fffOPQ6dIhZwOJp5LyUcdcAg+jzmXYOjIbPk=;
        b=W7Y1rMiIO3PXxBvGJXZ/UzWm8Y4s74E1uly8iVy3QW94nxNUxWbhePY9rMIQa/J87q
         7BSYIN8QVKpXDDhwU76FSCLxNB5nUwvvzkqDJTslOJkC6YQXcLrgTDedIi5Ho7rHV97p
         7CqACRSg3BF8/Zfldy7RUcYjutwtDmnAt/MJltco7s5ebUEQPU3NYzASGHejH5oeZqQP
         9wK+ss27XpxEjuGMP4NksGw00dGZY2rKkV/IQP9kP63PneR7940TWBiOR/O1UjYWsSV8
         S1mPxyQJDR+ScMGvhSRtwt23Mv0xGazVWHYkx2r2pJp3/zg7ZTBzhlHv9XBc48n4Wnxj
         R6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IYDjAh2fffOPQ6dIhZwOJp5LyUcdcAg+jzmXYOjIbPk=;
        b=XPHsf8M3xZEVvlgHcBt7fWkEgurv0+hBeXXN/iP9F9cm9wWB+ND94xzf08upL9a/C0
         lE2OjagDTzBOA0FR/ZL70MvV4M/KyDeMLkOQfHTmKBa0/WyZEt/LviJ/rc9OwEpZskoG
         GTgV9if+PUsUwtO4oQzBo1w7bAsLePdNj8IprDRNQDhvSfAMck/i6+95qm/ZoK5mwSRy
         AEmV5PZDVnr/MljS0X1iOnlfOXxMEMGKFnkGsC9R7sc8qlVwfmzP8k+UGM4jnUDWSBLP
         aKkx72IoTwyHTEhc4uXlvIELtUhwJuakp36Uqm5V35rjCwyvFUJb/ddYy42milSLQPzw
         DBLQ==
X-Gm-Message-State: AA+aEWZeGAQnxsMf9sKb9WIE6IcLFBmxe+I/RqZBfTJJZYKlf7Iy+2eu
        AOwIcHZ+m29ME9gOzOd4bZZNCEDd1gL8IEpLaSE=
X-Google-Smtp-Source: AFSGD/VyEYiXiaH1SyFWXzxphUi2pxvnpl3B024W+Fn3EpnVNg6Srg+/hEfNL5OWSpC2VHedUdMjDIpZad6eIini5QI=
X-Received: by 2002:a5d:8989:: with SMTP id m9mr15667867iol.216.1544580280915;
 Tue, 11 Dec 2018 18:04:40 -0800 (PST)
MIME-Version: 1.0
References: <1544445555-17325-1-git-send-email-pawell@cadence.com>
 <1544445555-17325-3-git-send-email-pawell@cadence.com> <87h8fkmfar.fsf@linux.intel.com>
 <BYAPR07MB47095110AF28CC11B4C9E144DDA60@BYAPR07MB4709.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB47095110AF28CC11B4C9E144DDA60@BYAPR07MB4709.namprd07.prod.outlook.com>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Wed, 12 Dec 2018 10:04:25 +0800
Message-ID: <CAL411-ryK2LLZVg5_sLkCYOuhwdHLVm5XavSyC9nbEXZah_43w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] usb:cdns3 Add Cadence USB3 DRD Driver
To:     pawell@cadence.com
Cc:     balbi@kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, rogerq@ti.com,
        lkml <linux-kernel@vger.kernel.org>, adouglas@cadence.com,
        jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com, sureshp@cadence.com,
        peter.chen@nxp.com, pjez@cadence.com, kurahul@cadence.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +            tmode = le16_to_cpu(ctrl->wIndex);
> >> +
> >> +            if (!set || (tmode & 0xff) != 0)
> >> +                    return -EINVAL;
> >> +
> >> +            switch (tmode >> 8) {
> >> +            case TEST_J:
> >> +            case TEST_K:
> >> +            case TEST_SE0_NAK:
> >> +            case TEST_PACKET:
> >> +                    cdns3_set_register_bit(&priv_dev->regs->usb_cmd,
> >> +                                           USB_CMD_STMODE |
> >> +                                           USB_STS_TMODE_SEL(tmode - 1));
> >
> >I'm 90% sure this won't work. There's a reason why we only enter the
> >requested test mode from status stage. How have you tested this?
>

What's the reason?
It can work although the code is a little different with above, I
tested it using USBxHSETT tool at Windows.

> From USB spec:
> "The transition to test mode must be complete no later than 3 ms after the completion of the status stage of the
> request."
> But I don't remember any issues with this test on other ours drivers. Maybe status stage
> is armed in this case by controller. I have to confirm how it works with hardware team.
> Driver doesn't know when status stage was completed. We don't have
> any event on status stage completion.  I haven't checked it yet with tester on this driver.
>

> >> +    irqreturn_t ret = IRQ_NONE;
> >> +    unsigned long flags;
> >> +    u32 reg;
> >> +
> >> +    priv_dev = cdns->gadget_dev;
> >> +    spin_lock_irqsave(&priv_dev->lock, flags);
> >
> >you're already running in hardirq context. Why do you need this lock at
> >all? I would be better to use the hardirq handler to mask your
> >interrupts, so they don't fire again, then used the top-half (softirq)
> >handler to actually handle the interrupts.
>

This controller may be ran at SMP environment, register and flag access
needs to be protected among CPUs running.

> Yes, spin_lock_irqsave is not necessary here.
>
> Do you mean replacing devm_request_irq with a request_threaded_irq ?
> I have single interrupt line shared between  Host, Driver, DRD/OTG.
> I'm not sure if it will work more efficiently.
>
> >
> >> +    /* check USB device interrupt */
> >> +    reg = readl(&priv_dev->regs->usb_ists);
> >> +    writel(reg, &priv_dev->regs->usb_ists);
> >> +
> >> +    if (reg) {
> >> +            dev_dbg(priv_dev->dev, "IRQ: usb_ists: %08X\n", reg);
> >
> >I strongly advise against using dev_dbg() for debugging. Even more so
> >inside your IRQ handler.

Felipe, I use Dynamic Debug for debugging, and show debug messages with
"dmesg" after testing/debugging. I see dwc3 using trace,  any benefits
for switching
to trace?

> Ok, It's not necessary in this place, especially, that there is invoked trace point
> inside cdns3_check_usb_interrupt_proceed which makes the same.
>

Peter
