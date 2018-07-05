Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F722C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B204023F40
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QcsOWlzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B204023F40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753899AbeGELMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:12:44 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53590 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753755AbeGELMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:12:41 -0400
Received: by mail-it0-f65.google.com with SMTP id a195-v6so11437123itd.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 04:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vb7LWxzEbIiasBKo9S8np/tabHRsd8b5gwJ4G5c1yu8=;
        b=QcsOWlzhfXLw63OZSKuHyrzjqK+b2p3/J1y6u67O4LDRqKZx7Tdn5897+camCD3HTI
         lc7l6Hv7TEug6Is4yONXWQiCGNc3U7Z6Juia+lPqbuNsfQQhv+GN4/9zQwJL87+/39AI
         AcTplJXoHzIVh1hHLlIMYzEM8vH4LJ0JUftYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vb7LWxzEbIiasBKo9S8np/tabHRsd8b5gwJ4G5c1yu8=;
        b=KVURJQaW59khrn6i6fpawQiwLuxUko4RsMQpHyZCCWKpzmls+T6QQ1KncAz/LjeILM
         z8hg1GZpDyUBNhWPk5W/Cs283BBngkFDOJPFY1CDZIXtZpHG64uNDDcSbbyr6uZfMnVz
         JeiTlRbg+OLuA4bZGVngipKhO04/c0vqPgeICm5kiUUcXrkrrhd9OUAbnalar757UEgv
         Q3h324LTb+3IMoCmv0pPsbTZTfYuf5B/clzVkZ3Xg1+qareAu7eQkBPE+De4KVfIqvNw
         r4dBrGhkzDsOsgWGotzTPBgC23c6hILj09MBjYU5TDa9+u9DLsdMxN+vTJEupDzm1cty
         LloA==
X-Gm-Message-State: APt69E1xfI6vyXoX7J3h+/zx4wBhzS7AQEUsQL9w1lXTpQfhCaSPdrt/
        XFhVWAMYRdGuknQNBVd82CxVZ4H4owaC+lIhu0YOtw==
X-Google-Smtp-Source: AAOMgpe6B2v29wktNmy3X0BXEwnyMidpr2pzVI3Xny6PVgCGHaOkvrTUNPcme8CRDXtTXSp05eFjE8xYFPiwOWv/Axo=
X-Received: by 2002:a02:579a:: with SMTP id b26-v6mr4447954jad.107.1530789160740;
 Thu, 05 Jul 2018 04:12:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 04:12:40 -0700 (PDT)
In-Reply-To: <20180704212951.43c6a62a@why.wild-wind.fr.eu.org>
References: <1530685741-20604-1-git-send-email-stefan@olimex.com>
 <CAPDyKFo_fadfNbt8YMS3MMjaxjt1B54DtZJ+-LoH9y5JeRi5pQ@mail.gmail.com>
 <9b8f30fd-12aa-46ba-ced9-aed38ada0059@arm.com> <CAPDyKFp8Hrmr0XCGnhFYrC3Q79dZizYC5KfRE92AUNa0FRDS5A@mail.gmail.com>
 <20180704212951.43c6a62a@why.wild-wind.fr.eu.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Jul 2018 13:12:40 +0200
Message-ID: <CAPDyKFpmd5T249HfQfuovD+=ZrBZw=kV4OUhVAHAiywo7m=haA@mail.gmail.com>
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

On 4 July 2018 at 22:29, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Wed, 4 Jul 2018 15:34:36 +0200
> Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> On 4 July 2018 at 13:34, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> > On 04/07/18 11:50, Ulf Hansson wrote:
>> >> + Marc
>> >>
>> >> On 4 July 2018 at 08:28, Stefan Mavrodiev <stefan@olimex.com> wrote:
>> >>> When mmc host controller enters suspend state, the clocks are
>> >>> disabled, but irqs are not. For some reason the irqchip emits
>> >>> false interrupts, which causes system lock loop.
>> >>>
>> >>> Debug log is:
>> >>>   ...
>> >>>   sunxi-mmc 1c11000.mmc: setting clk to 52000000, rounded 51200000
>> >>>   sunxi-mmc 1c11000.mmc: enabling the clock
>> >>>   sunxi-mmc 1c11000.mmc: cmd 13(8000014d) arg 10000 ie 0x0000bbc6 len 0
>> >>>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
>> >>>   sunxi-mmc 1c11000.mmc: cmd 6(80000146) arg 3210101 ie 0x0000bbc6 len 0
>> >>>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
>> >>>   sunxi-mmc 1c11000.mmc: cmd 13(8000014d) arg 10000 ie 0x0000bbc6 len 0
>> >>>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
>> >>>   mmc1: new DDR MMC card at address 0001
>> >>>   mmcblk1: mmc1:0001 AGND3R 14.6 GiB
>> >>>   mmcblk1boot0: mmc1:0001 AGND3R partition 1 4.00 MiB
>> >>>   mmcblk1boot1: mmc1:0001 AGND3R partition 2 4.00 MiB
>> >>>   sunxi-mmc 1c11000.mmc: cmd 18(80003352) arg 0 ie 0x0000fbc2 len 409
>> >>>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00004000 idi 00000002
>> >>>    mmcblk1: p1
>> >>>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>> >>>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>> >>>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>> >>>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>> >>> and so on...
>> >>>
>> >>> This issue apears on eMMC cards, routed on MMC2 slot. The patch is
>> >>> tested with A20-OLinuXino-MICRO/LIME/LIME2 boards.
>> >>>
>> >>> Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
>> >>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>> >>> ---
>> >>>  Changes in v2:
>> >>>   - Add comment why disable_irq() is necessary
>> >>>
>> >>> ---
>> >>>  drivers/mmc/host/sunxi-mmc.c | 7 +++++++
>> >>>  1 file changed, 7 insertions(+)
>> >>>
>> >>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>> >>> index e747259..8e7f3e3 100644
>> >>> --- a/drivers/mmc/host/sunxi-mmc.c
>> >>> +++ b/drivers/mmc/host/sunxi-mmc.c
>> >>> @@ -1446,6 +1446,7 @@ static int sunxi_mmc_runtime_resume(struct device *dev)
>> >>>         sunxi_mmc_init_host(host);
>> >>>         sunxi_mmc_set_bus_width(host, mmc->ios.bus_width);
>> >>>         sunxi_mmc_set_clk(host, &mmc->ios);
>> >>> +       enable_irq(host->irq);
>> >>>
>> >>>         return 0;
>> >>>  }
>> >>> @@ -1455,6 +1456,12 @@ static int sunxi_mmc_runtime_suspend(struct device *dev)
>> >>>         struct mmc_host *mmc = dev_get_drvdata(dev);
>> >>>         struct sunxi_mmc_host *host = mmc_priv(mmc);
>> >>>
>> >>> +       /*
>> >>> +        * When clocks are off, it's possible receiving
>> >>> +        * fake interrupts, which will stall the system.
>> >>> +        * Disabling the irq  will prevent this.
>> >>> +        */
>> >>> +       disable_irq(host->irq);
>> >>
>> >> No, this doesn't work for shared IRQs.
>> >
>> > Well, in this case, it does work, because that interrupt line cannot be
>> > shared with anything else, if I understand how the SoC is wired: each
>> > MMC controller has a dedicated interrupt line to the GIC, and it isn't
>> > shared with anything (that's on the A20 though, and I don't know about
>> > other SoCs integrating the same IP).
>>
>> That's the problem. This may work on some SoCs but not on others.
>>
>> >
>> >>
>> >>>         sunxi_mmc_reset_host(host);
>> >>>         sunxi_mmc_disable(host);
>> >>>
>> >>> --
>> >>> 2.7.4
>> >>>
>> >>
>> >> The only option today is to use free_irq() in runtime suspend and then
>> >> re-request the irq to re-install the handler at runtime resume.
>> >>
>> >> That's not an optimal solution, which is pointed out in the below
>> >> discussion as well. Moreover, it has also turned out using free_irq()
>> >> is also problematic in cases threaded handlers are used.
>> >>
>> >> Here's the link to the discussion, it's not the only one I know of, so
>> >> this is common problem.
>> >> https://lkml.org/lkml/2016/1/28/213
>> >>
>> >> Care to have a hack on the "common" solution, which in principle means
>> >> adding APIs to genirq that can disable/enable handlers from being
>> >> called, rather than the entire IRQ line.
>> >
>> > That doesn't work. You still end-up with a screaming interrupt, and you
>> > will still spend 100% of your time in interrupt context for nothing.
>> >
>> > Eventually, the kernel will have enough (the /other/ shared handlers
>> > returning IRQ_NONE all the time), and will forcefully kill that
>> > particular interrupt interrupt line, meaning you end-up in the same
>> > situation of having the line disabled for all the users of that
>> > interrupt line. Except that now, it is disabled forever.
>>
>> Ahh, correct!
>>
>> Sounds like free_irq() is what we need. Only that it's bit heavy
>> weight as we need to re-install handlers.
>
> BTW, free_irq() doesn't help you either in the case of a shared
> handler. You'll end-up in the exact same scenario as above.

In regards to the spurious interrupt storm issue, yes, I fully agree.

On the other hand, in case of a shared IRQ, don't we want the genirq
core to deal with disabling the IRQ, rather than the driver?

Also, don't forget the other related issue, which is when the IRQ
handler gets invoked (not as a storm, but once is enough), either
because of a spurious IRQ or because of a shared IRQ - while the
device is in a low power state (runtime suspended with clock gated for
example). If that happens and the handler accesses a register the
handler may hang.

>
> The real solution to this is to prevent the device itself from
> generating interrupts (or to forbid interrupt sharing if it isn't
> possible).

I fully agree that the device should be configured to not deliver
interrupt, this is the first and most important step a driver should
take. For example it should mask its device's IRQ register bits.

However, this isn't sufficient, because of shared IRQs and buggy HWs
delivering spurious IRQs.

Kind regards
Uffe
