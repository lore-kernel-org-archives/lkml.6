Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BFCC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761D120882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cc5tXPHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbfA3JVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:21:11 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42542 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfA3JVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:21:11 -0500
Received: by mail-vs1-f65.google.com with SMTP id b74so13797303vsd.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5q2By4zDCEQ19WGtdM+IRxh5BPqAQYmO+RXSEca+nD0=;
        b=Cc5tXPHaEjkJ8is4qaHQKQUIRsJLCXh7Vuzsuo17FzSAc65cHiEdJyNHFX9xlMK0y+
         UxffHHHvcWa0H+J0Uze+vh0tUvUX5JW7uqcQnKRpR26W3z+DqpNJLBJD8pvHH7z0TTcN
         a3CrewZcStgSUt+ra0iBH/gPjPyTMbXmMhtYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5q2By4zDCEQ19WGtdM+IRxh5BPqAQYmO+RXSEca+nD0=;
        b=pHsht4nweS67QbcbaC6Xpcl4DKPr1RR1KmhH688Nbrmv5cWvd7n11myrwZC2zTZ6R+
         6UmkWy41HYi3AWcwlzrHSn12ti5sQzR/n51TAotouvT7ovaCSjTeCsD9OOoAvvZnKc2e
         TcnzCANiZifHpoyJzbYG7c6k3mXHTi+08z1r9c7oePLRTiOW7VIBxJVLHtxzPUWhED6Y
         LV01ljY9WohJUwkK6wn+1dQTXMT0VV7JJYGBdoa2I2IjYKDuZ/ADGVst63NmeGmErlfW
         ECZWSnT3cf3g33p86k3atASVcE8yt3ZMCTV7y4/upD8LnVE7p1qCO3FrlBDE8EH4ranK
         7tvQ==
X-Gm-Message-State: AJcUukejaN7Aoc5fkljclKv4UdYIipHyspPvpM0rVP4H1DJeknI9edFl
        yf32e2frYTbsYSeS7Rzu0mu2bbUjpCCshwcUYIqhPg==
X-Google-Smtp-Source: ALg8bN4J35Hii93cBd4NWmhlx9nwks5erLZ56doFhQC1g6SVvZp2XJ5FjNpR5RqJGsuQYhdlbgbr1ncfdjFMy6/2Kyo=
X-Received: by 2002:a67:74c2:: with SMTP id p185mr8785047vsc.34.1548840070176;
 Wed, 30 Jan 2019 01:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20190129164950.31052-1-nicolas.ferre@microchip.com>
In-Reply-To: <20190129164950.31052-1-nicolas.ferre@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Jan 2019 10:20:34 +0100
Message-ID: <CAPDyKFrknwcbTDKQsGTSo9oZWX3B=fq39Ea=YkoFt_8LoEj5AQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: enable 8 bits buswidth support
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 at 17:50, Nicolas Ferre <nicolas.ferre@microchip.com> wrote:
>
> This patch adds support for 8-bit buswidth.
> Relevant SDCR value modified.
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/atmel-mci.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 47189f9ed4e2..735aa5871358 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1410,6 +1410,9 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         case MMC_BUS_WIDTH_4:
>                 slot->sdc_reg |= ATMCI_SDCBUS_4BIT;
>                 break;
> +       case MMC_BUS_WIDTH_8:
> +               slot->sdc_reg |= ATMCI_SDCBUS_8BIT;
> +               break;
>         }
>
>         if (ios->clock) {
> @@ -2275,8 +2278,11 @@ static int atmci_init_slot(struct atmel_mci *host,
>          * use only one bit for data to prevent fifo underruns and overruns
>          * which will corrupt data.
>          */
> -       if ((slot_data->bus_width >= 4) && host->caps.has_rwproof)
> +       if ((slot_data->bus_width >= 4) && host->caps.has_rwproof) {
>                 mmc->caps |= MMC_CAP_4_BIT_DATA;
> +               if (slot_data->bus_width >= 8)
> +                       mmc->caps |= MMC_CAP_8_BIT_DATA;
> +       }
>
>         if (atmci_get_version(host) < 0x200) {
>                 mmc->max_segs = 256;
> --
> 2.17.1
>
