Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D5BC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8408E20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfSmHWA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8408E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbeLFGS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 01:18:58 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43263 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbeLFGS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 01:18:58 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so16585546lff.10;
        Wed, 05 Dec 2018 22:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65mM+T+rnA1q6Wh/SL02hsm8FZ1etQIroWtCfBARTII=;
        b=hfSmHWA31gz8FsdbbRSyRWAiNMEHrCexK9tkyV35zvbz8c6l7SPFcrgkWp1/eeASd6
         1Ymb6aC6n16BS4zn7Yy0JJP7WoyGEdIcsLxdEr6qSsZcBHXfwZVjV/0kgRq92FOs+6EW
         ZZKruBK0yug8Sq59dOGUl6m54AJEwN7gTa6GtvTNi2wtsraKvU0Zaqfc9iGZj94SiUPs
         Wq1e85tf/B5kvby+1C1sGBZUtE9/83YPRMPZKI8i2dyexDmSb+MdJQL+FrBXbWwO8Tdc
         4lli+1nYF3ldubqPBw6fkoOkUpSCeynIfoIaxZn61HzCq6pCGvyP2iMi+2UiW4L4itrI
         gu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65mM+T+rnA1q6Wh/SL02hsm8FZ1etQIroWtCfBARTII=;
        b=hRcyic0m/BdZ/4jRHnIPKKw2A9F4bX48F3aLC2O4Jb3dwVDp31Ox9WPFXEqo1Nx97l
         czlEqBaWUAvFoEzHWb/HVY2+CH9qvutIKy76vuB9iu4+LLcmbGZg3EFCOesRMN/nh0+2
         9DjNfjizIzlP/No73yTuHk2WqU4ppaqIrx1lDE6HlTE/HblN9DTMeqNNizwXEe/qOza8
         3h09AzorF+IYZoGwRRxnoJzeE2UqF3NH5vrWHRKuly4XICM6cuI1yR0cO9Hf73M0Ja5G
         dxW/nE0L+TRqjIlUd86OKD+5ENC5oiAydOUTampLJ4TKhVTIltlto9V3AtVUi+FrwBZe
         zfag==
X-Gm-Message-State: AA+aEWZnTmV2TagL3lnNKwXQfOgexFmaQ/VbyZ+QiVy+8hp5+0xY783K
        Ptrb1G90sxRH+rv9geK8Pdq/Qz/+67+xCjV+K/Q=
X-Google-Smtp-Source: AFSGD/UWLne2fUdP0q2m0zKt6HPUIfkbrp8OdViJDwZGiQZQz7jE3bdU/gLVcDVbx0oVjiyCsASH/wt9cUl1phssuAM=
X-Received: by 2002:a19:8096:: with SMTP id b144mr16963948lfd.8.1544077135801;
 Wed, 05 Dec 2018 22:18:55 -0800 (PST)
MIME-Version: 1.0
References: <1543908270-13953-1-git-send-email-zhang.chunyan@linaro.org>
 <1543908270-13953-2-git-send-email-zhang.chunyan@linaro.org> <5167ffb5-77f8-ab66-2eca-602df5f4e3e8@ti.com>
In-Reply-To: <5167ffb5-77f8-ab66-2eca-602df5f4e3e8@ti.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 6 Dec 2018 14:18:19 +0800
Message-ID: <CAAfSe-vnwOG+CjGdU-2jauv=XXy3Ao+u3GRww11dEbukggpwWA@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] mmc: sdhci: add support for using external DMA devices
To:     faiz_abbas@ti.com
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        kishon@ti.com, nsekhar@ti.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 at 18:38, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Hi,
>
> On 04/12/18 12:54 PM, Chunyan Zhang wrote:
> > Some standard SD host controllers can support both external dma
> > controllers as well as ADMA/SDMA in which the SD host controller
> > acts as DMA master. TI's omap controller is the case as an example.
> >
> > Currently the generic SDHCI code supports ADMA/SDMA integrated in
> > the host controller but does not have any support for external DMA
> > controllers implemented using dmaengine, meaning that custom code is
> > needed for any systems that use an external DMA controller with SDHCI.
> >
> ...
>
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index b001cf4..8e50a97 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -475,6 +475,7 @@ struct sdhci_host {
> >
> >       int irq;                /* Device IRQ */
> >       void __iomem *ioaddr;   /* Mapped address */
> > +     phys_addr_t mapbase;    /* physical address base */
> >       char *bounce_buffer;    /* For packing SDMA reads/writes */
> >       dma_addr_t bounce_addr;
> >       unsigned int bounce_buffer_size;
> > @@ -524,6 +525,7 @@ struct sdhci_host {
> >       bool pending_reset;     /* Cmd/data reset is pending */
> >       bool irq_wake_enabled;  /* IRQ wakeup is enabled */
> >       bool v4_mode;           /* Host Version 4 Enable */
> > +     bool use_external_dma;
> >
> >       struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];  /* Requests done */
> >       struct mmc_command *cmd;        /* Current command */
> > @@ -552,6 +554,11 @@ struct sdhci_host {
> >       struct timer_list timer;        /* Timer for timeouts */
> >       struct timer_list data_timer;   /* Timer for data timeouts */
> >
> > +#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
> > +     struct dma_chan *rx_chan;
> > +     struct dma_chan *tx_chan;
> > +#endif
> > +
> >       u32 caps;               /* CAPABILITY_0 */
> >       u32 caps1;              /* CAPABILITY_1 */
> >       bool read_caps;         /* Capability flags have been read */
> > @@ -785,5 +792,6 @@ void sdhci_start_tuning(struct sdhci_host *host);
> >  void sdhci_end_tuning(struct sdhci_host *host);
> >  void sdhci_reset_tuning(struct sdhci_host *host);
> >  void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
> > +void sdhci_switch_external_dma(struct sdhci_host *host, bool en);
> >
>
> Can you also add a new attribute in sdhci_host->flags for external dma
> in this file? The log still shows
>
> [    3.675028] mmc2: SDHCI controller on 4809c000.mmc [4809c000.mmc]
> using ADMA

Ok, will try to add.

Thanks for your test and review.

Chunyan

>
> when using external dma.
>
> Thanks,
> Faiz
