Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29AEC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BCC24491
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cLP+I5up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BCC24491
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeGDNek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:34:40 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45883 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752684AbeGDNei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:34:38 -0400
Received: by mail-io0-f193.google.com with SMTP id l25-v6so4890577ioh.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 06:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HoC+yNI12ZqkrqTnfZKTp2pPw+jpWfs9AhvNov7g/EI=;
        b=cLP+I5uppubjV2wZrNVSAfYrCssQ7SCHQ83PcEk1CduR6KErp827u8BSKsPR6w9yLy
         ZcC0+/QFv4zVJZKp9mycJDJv+cw1iiOukySc48eqLplXY0uCK5XsjVcu1y1QNvotIhY8
         /SBGyL50R3KI8OJBaLOUuZTG0uRU/th5ISAgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HoC+yNI12ZqkrqTnfZKTp2pPw+jpWfs9AhvNov7g/EI=;
        b=Qp2Bb6RX1ifwCkglayHjummnK2ZQJKN+o805Mu/f31x649Wtbp+C+m3OnqZylWDg0Y
         70m9jOXfLcN0E1UuJ1/QuSo4cdNo8EeW+/5UnaLWGBGcoNWlggoGPxoGrm+iJKAGSgi5
         PyIuHHSE4M5m+7oo4wTj0O8R8D0J7zpA/t3Z1/YZDIxrmr6PcDWF+mzmx35U69azT3yp
         nKODkDA8KDx3EM72nRlWqzMeZ6GIxqKi8hgLnSyQo0ooLazeTweLyr7UxOCpVl5oDAmf
         JzKbsO0F0pNH4/8G2zm4MXc8t7MTcFyJtHrBY7RCQw59vwYD6M05lTeQp3UuY5eGa/+1
         rZew==
X-Gm-Message-State: AOUpUlG5HNa/DvVPTSEqIoLGYyxk89RbYCU6ZF7oOgfLJuyr5Us41X3n
        M/OdOMWbPypYajONEpPcUfadyHJiJT8L6J1oO4NhqQ==
X-Google-Smtp-Source: AAOMgpeoHD2nZ7iLa8R8doZiJoAMN2YIkdrGFDUKNXlUpV5FgeIinb6jOxvmL9os0RDp5urEpD0QPMnsVs6+zATRAp4=
X-Received: by 2002:a6b:144c:: with SMTP id 73-v6mr1579799iou.218.1530711277325;
 Wed, 04 Jul 2018 06:34:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 06:34:36 -0700 (PDT)
In-Reply-To: <9b8f30fd-12aa-46ba-ced9-aed38ada0059@arm.com>
References: <1530685741-20604-1-git-send-email-stefan@olimex.com>
 <CAPDyKFo_fadfNbt8YMS3MMjaxjt1B54DtZJ+-LoH9y5JeRi5pQ@mail.gmail.com> <9b8f30fd-12aa-46ba-ced9-aed38ada0059@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Jul 2018 15:34:36 +0200
Message-ID: <CAPDyKFp8Hrmr0XCGnhFYrC3Q79dZizYC5KfRE92AUNa0FRDS5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mmc: sunxi: Disable irq during pm_suspend
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Stefan Mavrodiev <stefan@olimex.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 July 2018 at 13:34, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 04/07/18 11:50, Ulf Hansson wrote:
>> + Marc
>>
>> On 4 July 2018 at 08:28, Stefan Mavrodiev <stefan@olimex.com> wrote:
>>> When mmc host controller enters suspend state, the clocks are
>>> disabled, but irqs are not. For some reason the irqchip emits
>>> false interrupts, which causes system lock loop.
>>>
>>> Debug log is:
>>>   ...
>>>   sunxi-mmc 1c11000.mmc: setting clk to 52000000, rounded 51200000
>>>   sunxi-mmc 1c11000.mmc: enabling the clock
>>>   sunxi-mmc 1c11000.mmc: cmd 13(8000014d) arg 10000 ie 0x0000bbc6 len 0
>>>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
>>>   sunxi-mmc 1c11000.mmc: cmd 6(80000146) arg 3210101 ie 0x0000bbc6 len 0
>>>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
>>>   sunxi-mmc 1c11000.mmc: cmd 13(8000014d) arg 10000 ie 0x0000bbc6 len 0
>>>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
>>>   mmc1: new DDR MMC card at address 0001
>>>   mmcblk1: mmc1:0001 AGND3R 14.6 GiB
>>>   mmcblk1boot0: mmc1:0001 AGND3R partition 1 4.00 MiB
>>>   mmcblk1boot1: mmc1:0001 AGND3R partition 2 4.00 MiB
>>>   sunxi-mmc 1c11000.mmc: cmd 18(80003352) arg 0 ie 0x0000fbc2 len 409
>>>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00004000 idi 00000002
>>>    mmcblk1: p1
>>>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>>>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>>>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>>>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>>> and so on...
>>>
>>> This issue apears on eMMC cards, routed on MMC2 slot. The patch is
>>> tested with A20-OLinuXino-MICRO/LIME/LIME2 boards.
>>>
>>> Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
>>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>>> ---
>>>  Changes in v2:
>>>   - Add comment why disable_irq() is necessary
>>>
>>> ---
>>>  drivers/mmc/host/sunxi-mmc.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>>> index e747259..8e7f3e3 100644
>>> --- a/drivers/mmc/host/sunxi-mmc.c
>>> +++ b/drivers/mmc/host/sunxi-mmc.c
>>> @@ -1446,6 +1446,7 @@ static int sunxi_mmc_runtime_resume(struct device *dev)
>>>         sunxi_mmc_init_host(host);
>>>         sunxi_mmc_set_bus_width(host, mmc->ios.bus_width);
>>>         sunxi_mmc_set_clk(host, &mmc->ios);
>>> +       enable_irq(host->irq);
>>>
>>>         return 0;
>>>  }
>>> @@ -1455,6 +1456,12 @@ static int sunxi_mmc_runtime_suspend(struct device *dev)
>>>         struct mmc_host *mmc = dev_get_drvdata(dev);
>>>         struct sunxi_mmc_host *host = mmc_priv(mmc);
>>>
>>> +       /*
>>> +        * When clocks are off, it's possible receiving
>>> +        * fake interrupts, which will stall the system.
>>> +        * Disabling the irq  will prevent this.
>>> +        */
>>> +       disable_irq(host->irq);
>>
>> No, this doesn't work for shared IRQs.
>
> Well, in this case, it does work, because that interrupt line cannot be
> shared with anything else, if I understand how the SoC is wired: each
> MMC controller has a dedicated interrupt line to the GIC, and it isn't
> shared with anything (that's on the A20 though, and I don't know about
> other SoCs integrating the same IP).

That's the problem. This may work on some SoCs but not on others.

>
>>
>>>         sunxi_mmc_reset_host(host);
>>>         sunxi_mmc_disable(host);
>>>
>>> --
>>> 2.7.4
>>>
>>
>> The only option today is to use free_irq() in runtime suspend and then
>> re-request the irq to re-install the handler at runtime resume.
>>
>> That's not an optimal solution, which is pointed out in the below
>> discussion as well. Moreover, it has also turned out using free_irq()
>> is also problematic in cases threaded handlers are used.
>>
>> Here's the link to the discussion, it's not the only one I know of, so
>> this is common problem.
>> https://lkml.org/lkml/2016/1/28/213
>>
>> Care to have a hack on the "common" solution, which in principle means
>> adding APIs to genirq that can disable/enable handlers from being
>> called, rather than the entire IRQ line.
>
> That doesn't work. You still end-up with a screaming interrupt, and you
> will still spend 100% of your time in interrupt context for nothing.
>
> Eventually, the kernel will have enough (the /other/ shared handlers
> returning IRQ_NONE all the time), and will forcefully kill that
> particular interrupt interrupt line, meaning you end-up in the same
> situation of having the line disabled for all the users of that
> interrupt line. Except that now, it is disabled forever.

Ahh, correct!

Sounds like free_irq() is what we need. Only that it's bit heavy
weight as we need to re-install handlers.

>
> A better fix would be to kill the interrupt generation at the source
> (the MMC controller in this particular case) when suspending.

Right. But using disable_irq() doesn't work a general solution, so
something else is needed.

An option is to allow us to use disable|enable_irq() for this
particular case as a simple fix, then work on a long term solution.

Kind regards
Uffe
