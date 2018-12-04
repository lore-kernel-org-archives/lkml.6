Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD9EC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6A42087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8MTAYGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6A42087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbeLDDBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 22:01:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45169 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeLDDBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 22:01:42 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so13417199ljd.12;
        Mon, 03 Dec 2018 19:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zr/mHqIm12UKaPWNmKyizjPws3ucuCEHgZimdvgZ7Hw=;
        b=h8MTAYGj8SZtfo9TEB87xqoWtwKxHTlYV4HjhqmbnFcXS1d74FX/QEnpZHAaGo3Z7p
         nKKvOl92CGn7JqKQ0ozQsnXE35Ov/D3o/ls4+iDqmvo01miyC3hWhDGHSwH5fhbw6USJ
         9AIwhC9WthzZNYFLIhNO8cTFsULQH04LjS+CuMSK3K7261H28W3/PgIfNk3WnlI7yCuR
         Vngk+0ArDvOHzhmdxhQggboyEVFTetIL0l5CWC05Nv6LFsbCcH1raUO6FEh/FDBl6Mce
         lY2fj8jOqyPREYoIs40UhzuEqVjzVKAlfP7ptQoUpe3+U1hDlufU5amuue04TzV/lOSL
         vdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zr/mHqIm12UKaPWNmKyizjPws3ucuCEHgZimdvgZ7Hw=;
        b=pIgOqJtjHmsMBb1wGxO24LQmROVtPA8ZR7KplTqpteIBpyUNmNakpblgVKCXY/5vN1
         rdX61/CQhEWPXpZDs7g7aMnz4IXCu0fkNkgac5XRK/ZBdi/kAyi6A8viSkadtXwNq2Fh
         0CdQTP6P0YA6ZrTlTPf1TaBDOGN2GcKp2uw9W6JbiEQYGZ+Zqh6gC5FX43WQUX7p/BS3
         gq9hZpGhBpk28aD8clfulZh9gXh8TE+3soisFypUR8PHhZNVP36PxTshAiKU3yKNXGN7
         EYfIkA1DvFXhs4qxNae87mDMHs7gl4MPNqDxNZjju3iZN41gaZ+AjQSM18M4sktbvKq3
         2e2A==
X-Gm-Message-State: AA+aEWYkV9jANAQxXtWj6RBdAdrKy7Gc4WrDoaWBxt2K/Jlw1NZ3td9n
        TxlDogb+n+TCNRn7a+iRaB2gMD1c3CS72k878Xg=
X-Google-Smtp-Source: AFSGD/UQTjKIpsvHn0ZYBvKm/IUHJwfOA4Q2dG4482tUWARF6l7LFd23sK59EnEpstb9+nbERv24MlPFBZ8lOdkQLp0=
X-Received: by 2002:a2e:21a9:: with SMTP id h41-v6mr11366456lji.103.1543892499831;
 Mon, 03 Dec 2018 19:01:39 -0800 (PST)
MIME-Version: 1.0
References: <1542007566-9449-1-git-send-email-zhang.chunyan@linaro.org>
 <1542007566-9449-3-git-send-email-zhang.chunyan@linaro.org> <8c54a77e-564d-40fc-32fe-eb4cee0181f1@ti.com>
In-Reply-To: <8c54a77e-564d-40fc-32fe-eb4cee0181f1@ti.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 4 Dec 2018 11:01:03 +0800
Message-ID: <CAAfSe-vAprG+L7hyrytPYJtqf7Q0zR9-v+=fdCy6XXgCLzPNGQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: sdhci-omap: Add using external dma
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

Hi Faiz,

Thanks for the review and test!

On Mon, 3 Dec 2018 at 21:47, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Chunyan,
>
> On 12/11/18 12:56 PM, Chunyan Zhang wrote:
> > sdhci-omap can support both external dma controller via dmaengine framework
> > as well as ADMA which standard SD host controller provides.
> >
> > Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> > ---
> >  drivers/mmc/host/sdhci-omap.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> > index 88347ce..ccc79f2 100644
> > --- a/drivers/mmc/host/sdhci-omap.c
> > +++ b/drivers/mmc/host/sdhci-omap.c
> > @@ -896,6 +896,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
> >       const struct of_device_id *match;
> >       struct sdhci_omap_data *data;
> >       const struct soc_device_attribute *soc;
> > +     struct resource *regs;
> >
> >       match = of_match_device(omap_sdhci_match, dev);
> >       if (!match)
> > @@ -908,6 +909,10 @@ static int sdhci_omap_probe(struct platform_device *pdev)
> >       }
> >       offset = data->offset;
> >
> > +     regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (!regs)
> > +             return -ENXIO;
> > +
> >       host = sdhci_pltfm_init(pdev, &sdhci_omap_pdata,
> >                               sizeof(*omap_host));
> >       if (IS_ERR(host)) {
> > @@ -924,6 +929,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
> >       omap_host->timing = MMC_TIMING_LEGACY;
> >       omap_host->flags = data->flags;
> >       host->ioaddr += offset;
> > +     host->mapbase = regs->start;
> >
> >       mmc = host->mmc;
> >       sdhci_get_of_property(pdev);
> > @@ -991,6 +997,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
> >       host->mmc_host_ops.execute_tuning = sdhci_omap_execute_tuning;
> >       host->mmc_host_ops.enable_sdio_irq = sdhci_omap_enable_sdio_irq;
> >
> > +     sdhci_switch_external_dma(host, true);
>
> You should give the user a choice based on a dt property whether to use
> ADMA or use external DMA. We might still want to use external DMA for
> some platforms and ADMA for other platforms.

With the current patchset, if users want to use external DMA, they
need to add 'dmas' in device tree, like patch 3 shows:
+ dmas = <&sdma 61 &sdma 62>;
+ dma-names = "tx", "rx";
Otherwise, sdhci.c will switch back to use the DMA/PIO integrated in
standard SDHCI.

But I think your suggestion makes sense, will add the below graph in
next version:

+ /* Switch to external DMA only if there is the "dmas" property */
+ if (of_find_property(dev->of_node, "dmas", NULL))
+         sdhci_switch_external_dma(host, true);

Thanks,
Chunyan
