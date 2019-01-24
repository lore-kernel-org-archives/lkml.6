Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7B4C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E1C2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gzisN7eD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfAXPNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:13:14 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36618 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfAXPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:13:13 -0500
Received: by mail-ua1-f65.google.com with SMTP id j3so2098823uap.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 07:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ym6qO6uZueXvmCkE0mXt38C5WxL5x03DtgjZSQlDbNM=;
        b=gzisN7eDv22Wq9nnrKyXXGfZaGpsO3I2QW0N6xdiVHloOVXY0Gs3tIQGDEOXlQIt7Z
         /8Mic4w/XxZMvqfC6OA3pnJ0T6dYZXeK3WQJvvHb/k/AtGkRH7bH7rJ+v7iB+wulOy0t
         0qSMfWHri8G4RvfVC2YKfLY30xenTvGOF5pRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ym6qO6uZueXvmCkE0mXt38C5WxL5x03DtgjZSQlDbNM=;
        b=m4akbu/XLGBzbx8scFui8y6gcMMBJ96ZECNfzLW33b1pGADd95LCrB7tz/B7f8QPc4
         9Cgd17PLwnlVoHOh040apPgEcKS7uMW1HhQpd6DYizvSCNZnMW8ZE3+3MTnbI8vmFzSg
         EBQZL96iG9nuvYRiOHnicpH2ty3zneYjz3ibUkwLN3kKiCbePRM/CgVR+o9aD2IKEact
         M8gyC5CmxMrYYb9oByMdjeVsgV/y8q7Fb6IifUaX1QhiTF2TlHQ+XmZiGvE6pa6H2ocs
         TsivpUxryMpfU+troXOWyj7oqbD85nc1vfLsaDlrCyR7mlQJqDTLA7fkQB+tZU0wqPKz
         8zQA==
X-Gm-Message-State: AJcUukfvXI+lo3ea4drR9FL/FewONBdkAAU43zYn6gqU5a5qidhLyg++
        XKXDGhfjsCMmWID5g6drwFjhVZ9O05qCdojWQt3NDA==
X-Google-Smtp-Source: ALg8bN4Gg3UlAH9n6sfnwatXtrbbhEZjC25+kqGv35OcJFdTO1J9O5dPWTouEUu5p8TJe+Sd7B7jtvHCWvYTLsCSl0k=
X-Received: by 2002:ab0:b83:: with SMTP id c3mr2691467uak.77.1548342792275;
 Thu, 24 Jan 2019 07:13:12 -0800 (PST)
MIME-Version: 1.0
References: <1544109212-12621-1-git-send-email-ludovic.Barre@st.com>
 <1544109212-12621-2-git-send-email-ludovic.Barre@st.com> <CAPDyKFq7TZMKWMqmoDR0yfr2N2cf2nr4-BuEs5DPgJSGy-nvAA@mail.gmail.com>
 <35f22c1a-888d-5abd-7ffe-ecf47a74b69a@st.com> <9e22fd3d-f029-2a2a-18d1-af1987c94e4e@st.com>
 <ab4cae87-0a5a-fe22-08ab-7c7661be7c8c@st.com>
In-Reply-To: <ab4cae87-0a5a-fe22-08ab-7c7661be7c8c@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Jan 2019 16:12:35 +0100
Message-ID: <CAPDyKFp+3E35KXVCACO3-6JcRyqdsNGJ-5mAEKmUK0nggGs9nQ@mail.gmail.com>
Subject: Re: [Linux-stm32] [PATCH V3 1/2] mmc: mmci: add variant property to
 set command stop bit
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 at 16:03, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> hi Ulf
>
> I don't think you've seen my previous mail :-(
> what is your feeling about "mmc: mmci: send stop command to clear the dpsm"

Apologize for the delay. I wanted to check this in detail so I applied
your patch locally and started to play/test it.

However, a couple of other regressions was reported for v5.0 rcs, so I
got sidetracked.

Back on track by now, so I will have look asap. Thanks for pinging me!

Kind regards
Uffe

>
> Regards
> Ludo
>
> On 1/3/19 11:35 AM, Ludovic BARRE wrote:
> > hi Ulf
> >
> > happy new years.
> >
> > Just a gentleman ping about patch2 of this series
> > "mmc: mmci: send stop command to clear the dpsm."
> >
> > Regards
> > Ludo
> >
> > On 12/11/18 10:53 AM, Ludovic BARRE wrote:
> >>
> >>
> >> On 12/11/18 10:47 AM, Ulf Hansson wrote:
> >>> On Thu, 6 Dec 2018 at 16:13, Ludovic Barre <ludovic.Barre@st.com> wrote:
> >>>>
> >>>> From: Ludovic Barre <ludovic.barre@st.com>
> >>>>
> >>>> On cmd12 (STOP_TRANSMISSION), STM32 sdmmc variant needs to set
> >>>> cmdstop bit in command register. The CPSM ("Command Path State
> >>>> Machine")
> >>>> treats the command as a Stop Transmission command and signals
> >>>> abort to the DPSM ("Data Path State Machine").
> >>>>
> >>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> >>>
> >>> Applied for next, thanks!
> >>
> >> thanks
> >>
> >>>
> >>> Withholding patch2 for a while, as I need some more time to review it.
> >>
> >> No problem,
> >>
> >> Regards
> >> Ludo
> >>
> >>>
> >>> Kind regards
> >>> Uffe
> >>>
> >>>> ---
> >>>>   drivers/mmc/host/mmci.c | 6 ++++++
> >>>>   drivers/mmc/host/mmci.h | 2 ++
> >>>>   2 files changed, 8 insertions(+)
> >>>>
> >>>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> >>>> index 13fa640..e352f5a 100644
> >>>> --- a/drivers/mmc/host/mmci.c
> >>>> +++ b/drivers/mmc/host/mmci.c
> >>>> @@ -21,6 +21,7 @@
> >>>>   #include <linux/err.h>
> >>>>   #include <linux/highmem.h>
> >>>>   #include <linux/log2.h>
> >>>> +#include <linux/mmc/mmc.h>
> >>>>   #include <linux/mmc/pm.h>
> >>>>   #include <linux/mmc/host.h>
> >>>>   #include <linux/mmc/card.h>
> >>>> @@ -274,6 +275,7 @@ static struct variant_data variant_stm32_sdmmc = {
> >>>>          .cmdreg_lrsp_crc        = MCI_CPSM_STM32_LRSP_CRC,
> >>>>          .cmdreg_srsp_crc        = MCI_CPSM_STM32_SRSP_CRC,
> >>>>          .cmdreg_srsp            = MCI_CPSM_STM32_SRSP,
> >>>> +       .cmdreg_stop            = MCI_CPSM_STM32_CMDSTOP,
> >>>>          .data_cmd_enable        = MCI_CPSM_STM32_CMDTRANS,
> >>>>          .irq_pio_mask           = MCI_IRQ_PIO_STM32_MASK,
> >>>>          .datactrl_first         = true,
> >>>> @@ -1100,6 +1102,10 @@ mmci_start_command(struct mmci_host *host,
> >>>> struct mmc_command *cmd, u32 c)
> >>>>                  mmci_reg_delay(host);
> >>>>          }
> >>>>
> >>>> +       if (host->variant->cmdreg_stop &&
> >>>> +           cmd->opcode == MMC_STOP_TRANSMISSION)
> >>>> +               c |= host->variant->cmdreg_stop;
> >>>> +
> >>>>          c |= cmd->opcode | host->variant->cmdreg_cpsm_enable;
> >>>>          if (cmd->flags & MMC_RSP_PRESENT) {
> >>>>                  if (cmd->flags & MMC_RSP_136)
> >>>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> >>>> index 550dd39..2422909 100644
> >>>> --- a/drivers/mmc/host/mmci.h
> >>>> +++ b/drivers/mmc/host/mmci.h
> >>>> @@ -264,6 +264,7 @@ struct mmci_host;
> >>>>    * @cmdreg_lrsp_crc: enable value for long response with crc
> >>>>    * @cmdreg_srsp_crc: enable value for short response with crc
> >>>>    * @cmdreg_srsp: enable value for short response without crc
> >>>> + * @cmdreg_stop: enable value for stop and abort transmission
> >>>>    * @datalength_bits: number of bits in the MMCIDATALENGTH register
> >>>>    * @fifosize: number of bytes that can be written when
> >>>> MMCI_TXFIFOEMPTY
> >>>>    *           is asserted (likewise for RX)
> >>>> @@ -316,6 +317,7 @@ struct variant_data {
> >>>>          unsigned int            cmdreg_lrsp_crc;
> >>>>          unsigned int            cmdreg_srsp_crc;
> >>>>          unsigned int            cmdreg_srsp;
> >>>> +       unsigned int            cmdreg_stop;
> >>>>          unsigned int            datalength_bits;
> >>>>          unsigned int            fifosize;
> >>>>          unsigned int            fifohalfsize;
> >>>> --
> >>>> 2.7.4
> >>>>
> > _______________________________________________
> > Linux-stm32 mailing list
> > Linux-stm32@st-md-mailman.stormreply.com
> > https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32
