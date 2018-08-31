Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBD9C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3CF20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3CF20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeHaPsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:48:25 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:42562 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeHaPsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:48:25 -0400
Received: by mail-vk0-f65.google.com with SMTP id t4-v6so5347572vke.9;
        Fri, 31 Aug 2018 04:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eawye49+/LFlCFtFN5QW5gL2jZLvJR/D4lhmVK6hCQ0=;
        b=KWwmKi+n2zZlxx5B0oSayPeaTjX6qXr754ro4T5fqRvckT8lu8MmDopTbxBKkqUAPx
         dvX0akT168c+/ETWl4M9olUkj3C8wBsD5nsZlXvGBUOVv+EwbMXV5Nrs1cP8X1DF4azg
         DF075mh7TN8UDFajotp0LtDrvM14OYz4DyngqZ5yyT8MGDjlSGNcGwXBBaG6AlJX6EqA
         s17odRUPxl3/ZH42aq1KItfblbdbozX1VhrtX6Vv+fadzggeMcP3YHgkGK2EpBKpMexY
         xJoZPW2V65XpAHh6OSEe4ZifPEd2vDg/adl3pgLAtkIGehHCmMhEugUPk9uqF88WzXul
         owLA==
X-Gm-Message-State: APzg51BlDNGgEFBtvJyDoHxSXHxRCEmmRrRBFDoLTuVuvmSpH+aRJQJF
        LyFdVFRxT0cl6NmZzwFzYs2Ap035tpgg+6ONlh9mjA==
X-Google-Smtp-Source: ANB0VdaDd+5hyKrSSI0u1dtNBq86q/2garSBsJhD6tEYedyrxAu30ebCY6VAib6rjm0bCGHqNOxFHbSQcboPlyvJalQ=
X-Received: by 2002:a1f:9cc4:: with SMTP id f187-v6mr8649471vke.87.1535715678679;
 Fri, 31 Aug 2018 04:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com> <1535711404-29528-2-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1535711404-29528-2-git-send-email-yogeshnarayan.gaur@nxp.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 31 Aug 2018 13:41:06 +0200
Message-ID: <CAMuHMdWbqEkARvSuMxSRusCj0yi7GUYTyQouRhOi+iYJq9R-Kg@mail.gmail.com>
Subject: Re: [PATCH 1/7] spi: add slave device size in spi_device struct
To:     Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     MTD Maling List <linux-mtd@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Brian Norris <computersforpeace@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

Thanks for your patch!

On Fri, Aug 31, 2018 at 12:33 PM Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> Add 'size' data variable in spi_device struct.
> This is to save the size of the connected slave device.

What is the "size" of an SPI slave device?

> After slave device scan, spi_nor_scan, size being assigned to this
> from MTD layer.

Ah, this is MTD specific?

> SFDP read is being requested before completion of spi_nor_scan()
> routine, thus populate device size before making read request
> to the SPI controller.
>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -127,6 +127,7 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
>   *     for driver coldplugging, and in uevents used for hotplugging
>   * @cs_gpio: gpio number of the chipselect line (optional, -ENOENT when
>   *     not using a GPIO line)
> + * @size: size of the connected slave device

Please document what is the meaning of "size".

>   *
>   * @statistics: statistics for the spi_device
>   *
> @@ -168,6 +169,7 @@ struct spi_device {
>         void                    *controller_data;
>         char                    modalias[SPI_NAME_SIZE];
>         int                     cs_gpio;        /* chip select gpio */
> +       u32                     size;           /* size of slave device */
>
>         /* the statistics */
>         struct spi_statistics   statistics;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
