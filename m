Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38BDC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18B02077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18B02077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeJKOyx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:54:53 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43722 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeJKOyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:54:53 -0400
Received: by mail-vs1-f67.google.com with SMTP id w85so7578748vsa.10;
        Thu, 11 Oct 2018 00:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QAAroYkfcBIcMCAVUykvNxgkUAGX2wNg9Gn3/7/+U6k=;
        b=uVwGdxSdF/HvxYqqY3UuxB+T0d/i1Yi9SskS/ZghAjZi5U+izw1MUk3EvMN3RMb8WC
         ZseQZiU/Nn+hs/NpeXg15pFUyoyrk7pmduR+2zgWEL3zfHJWdsNWQhGV2rnW5D8NfppD
         RekPddYu4bRPkVqUDfK92n7R/ZaJlGNoD5Gu/a6Ejy4wMnsSj/quzP8dSgFWJNd+Swyo
         H26Aa+Ykw1zcR8WFmjfvT8qqDafnZgwTT7h/36bnnd1tln4VTXEmxzEBMwjwCm03m/3t
         Eun3sCvwKT6NYajW8Twhwt+yOZnRBgo76cU0LZNzKx/xracsZbb4uP0T6/0j3LHq1qvB
         bldw==
X-Gm-Message-State: ABuFfojNOoLbmSq/hNA18/7gt/d8jIn9+7qTk2fCVHDobY5AVlyjLtZv
        rLOQmHBnkeY0fKpdCpbmUP0YekZM6kwJw2CKcNo=
X-Google-Smtp-Source: ACcGV617PLfvQ45PnAZvXO6eutvd70bKIn/sPTehde68iIvH0Z4GdZ3j9hbr1xzE+PLotSoHSMLxqPTuQ+pALDcEt2M=
X-Received: by 2002:ab0:6093:: with SMTP id i19mr172725ual.75.1539242932301;
 Thu, 11 Oct 2018 00:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181010170936.316862-1-lkundrak@v3.sk> <20181010170936.316862-11-lkundrak@v3.sk>
In-Reply-To: <20181010170936.316862-11-lkundrak@v3.sk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Oct 2018 09:28:39 +0200
Message-ID: <CAMuHMdXmsw3jjp8wFuuK_Vz8kwCP4=L59sc4kZafXzrb=hKv7g@mail.gmail.com>
Subject: Re: [PATCH 10/11] spi: pxa2xx: Add ready signal
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>, quozl@laptop.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lubomir,

On Wed, Oct 10, 2018 at 7:10 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> Strobe a GPIO line when the slave TX FIFO is filled. This is how the
> Embedded Controller on an OLPC XO-1.75 machine, that happens to be a SPI
> master, learns that it can initiate a transaction.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Thanks for your patch!

I'm repeating my comments on the RFC below:

> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1079,6 +1079,9 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
>         if (spi_controller_is_slave(master)) {
>                 while (drv_data->write(drv_data))
>                         ;
> +               gpiod_set_value(drv_data->gpiod_ready, 1);
> +               udelay(1);
> +               gpiod_set_value(drv_data->gpiod_ready, 0);

While gpiod_set_value() handles the case of no GPIO fine, I think it's
better to explicitly check for that, so you can avoid spinning for 1 µs if
the GPIO is not present.

>         }
>
>         /*
> @@ -1784,6 +1787,15 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
>                 }
>         }
>
> +       if (platform_info->is_slave) {
> +               drv_data->gpiod_ready = devm_gpiod_get_optional(dev,
> +                                               "ready", GPIOD_OUT_LOW);
> +               if (IS_ERR(drv_data->gpiod_ready)) {
> +                       status = (int)PTR_ERR(drv_data->gpiod_ready);

The cast to int is not needed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
