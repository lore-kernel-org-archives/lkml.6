Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB58AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7211218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+yrXIXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfAYLx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:53:27 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41366 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfAYLx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:53:27 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15-v6so8116940ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 03:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k/2XQCv/HLZQJZ1Uo2lI9ZNEWlkaDjnYl83uo8TfY5k=;
        b=L+yrXIXAyjfoA4ZjuE4bmEXn5YVefzgjnR4MnDSDI6kwYNhPXZNHt7trNW6qM3f/ZG
         Og49oia1DfgXfpsixcRTH1gTFMxCoKWqVzLLhKQWX1zF57kDca4vLXP6ERR+b7Fhh5Tq
         3BpBXahzBzdKsWeRK3pMMdBQBb/wmvTEqoEE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/2XQCv/HLZQJZ1Uo2lI9ZNEWlkaDjnYl83uo8TfY5k=;
        b=B0EBRXNEB5D1+6W/3uefnpHHIUxrT4FuUUqEkoFUiBu8C4rURxpFD5vCsnwio64E5L
         igLtgesa6FNsIcjJpSTHYf6GVatG4EIY/lIP7uuU8VksHm+xlgoKs8Fa2XccqLZLk/hM
         80rx/oyX6xzRaZs8Fz4SwilgXVCQU9No698GkkoCa8g1zu6kxdWAMyfHu4LJjV25zMNz
         283Zo63ppiVIyjt0IcVURIk7QxLEpzJUFIzRp8fxtJVGXCiaM3kRUGHpUQq4SDzw5QV3
         6nzEMEQnBAS07tEfqsHZfIIs/R+tix3F3+FkWUggspNqH47p1Lj97S7H9Pjjmd9RXnap
         DYlQ==
X-Gm-Message-State: AJcUukf+iv6ivMFNUx4nF/9xN+gPRFp2/7YFOzuYM2SXcPOpi2anpQHV
        5lE1kllcYg8SqvZN0KQCcjDjLpEvdx2LjWi28YHmhEBYLKsL6g==
X-Google-Smtp-Source: ALg8bN7i2X+WT1mu881aynrH16yqbfVGzFfSdofg8hqc71u5SBNnqZxBYw4+sj6zIg2TGY/lEiH3p8qvsqmoRNd/VVs=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr8745729ljj.9.1548417204982;
 Fri, 25 Jan 2019 03:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20190125114429.20066-1-jonas@norrbonn.se> <20190125114429.20066-2-jonas@norrbonn.se>
In-Reply-To: <20190125114429.20066-2-jonas@norrbonn.se>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 25 Jan 2019 19:53:13 +0800
Message-ID: <CAMz4ku+sqzK19994BpdSfaDjNdXW_-gnCutr_fYQiv5ynxOq2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: support inter-word delay requirement for devices
To:     Jonas Bonn <jonas@norrbonn.se>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, 25 Jan 2019 at 19:44, Jonas Bonn <jonas@norrbonn.se> wrote:
>
> Some devices are slow and cannot keep up with the SPI bus and therefore
> require a short delay between words of the SPI transfer.
>
> The example of this that I'm looking at is a SAMA5D2 with a minimum SPI
> clock of 400kHz talking to an AVR-based SPI slave.  The AVR cannot put
> bytes on the bus fast enough to keep up with the SoC's SPI controller
> even at the lowest bus speed.
>
> This patch introduces the ability to specify a required inter-word
> delay for SPI devices.  It is up to the controller driver to configure
> itself accordingly in order to introduce the requested delay.

Can we configure it at runtime by the device rather than at DT time by
the controller? If yes, we already have a patch for this, please
check:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eeaceb8b7d1fb64b6030249ca0dd1d902ef3069e

>
> Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
> CC: Mark Brown <broonie@kernel.org>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: linux-spi@vger.kernel.org
> CC: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/spi/spi-bus.txt | 1 +
>  drivers/spi/spi.c                                 | 4 ++++
>  include/linux/spi/spi.h                           | 1 +
>  3 files changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
> index 1f6e86f787ef..a5f20060676d 100644
> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
> @@ -77,6 +77,7 @@ All slave nodes can contain the following optional properties:
>                     Defaults to 1 if not present.
>  - spi-rx-delay-us - Microsecond delay after a read transfer.
>  - spi-tx-delay-us - Microsecond delay after a write transfer.
> +- spi-word-delay-us - Microsecond delay between individual words of a transfer
>
>  Some SPI controllers and devices support Dual and Quad SPI transfer mode.
>  It allows data in the SPI system to be transferred using 2 wires (DUAL) or 4
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 9a7def7c3237..cd4d4065eca2 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1692,6 +1692,10 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>         }
>         spi->max_speed_hz = value;
>
> +       if (!of_property_read_u32(nc, "spi-word-delay-us", &value)) {
> +               spi->word_delay = value;
> +       }
> +
>         return 0;
>  }
>
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 314d922ca607..e5200dd9d750 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -164,6 +164,7 @@ struct spi_device {
>         char                    modalias[SPI_NAME_SIZE];
>         const char              *driver_override;
>         int                     cs_gpio;        /* chip select gpio */
> +       uint16_t                word_delay;     /* inter-word delay (us) */
>
>         /* the statistics */
>         struct spi_statistics   statistics;
> --
> 2.19.1
>


-- 
Baolin Wang
Best Regards
