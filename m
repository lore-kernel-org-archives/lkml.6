Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7202FC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3874620854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3874620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbeIMSyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:54:31 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:39159 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbeIMSya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:54:30 -0400
Received: by mail-vk1-f194.google.com with SMTP id e139-v6so805334vkf.6;
        Thu, 13 Sep 2018 06:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kdkJD5mXCNLNAOELXVShrVGyk1NM9hcWPCU/wRGLePE=;
        b=OMZmy8WwPuPkwYcnqLpHvSfbUcKImGRJQw/2ULivPyHVjmRlk4rKM8qFomZht97pY8
         +xrNj774MzHjfL3oJcoWQdj6AyMKCpwP3QjlaRDzNLLjq352iRvm7FFmb5PdoB8uUdO0
         cTlvrGtosj6aLZq4PDSXempWFY6lkakC1SuwmQ36PqJWgT/Xx4Xpk3kWvKn/krNKOCGK
         BFi+mtkkV/2lYTIVHYv9ZqBp39pJ3pnrSaf0EKPXWhkL6PGeJxxss/wLg9ut6IF4M7x5
         XKMzjPRbeAR1QOyEohedL7XFI68HIvQe2KSbgDR9W8hXp1QwWWR1nwBmo5Mo8MdGUCCF
         vBGw==
X-Gm-Message-State: APzg51BQy+dVEMLhDgQXYIjdxXGNeqzREmEGtrr2ZMu2o4DVQFWFJNan
        wdTnch2I71IGMldzKJpDGoWATMGhmTQDSFceyaU=
X-Google-Smtp-Source: ANB0VdZw2GNaoiuNTiq5wSr2KY/w1K3UShCyNiPCrFb/kgaBwyqoIsT3pWZPffkn+lWMwos+W5GnJOKee3cGD9gJbE8=
X-Received: by 2002:a1f:2ad6:: with SMTP id q205-v6mr1639438vkq.83.1536846297226;
 Thu, 13 Sep 2018 06:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180913003920.30600-1-david@lechnology.com> <20180913003920.30600-5-david@lechnology.com>
In-Reply-To: <20180913003920.30600-5-david@lechnology.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Sep 2018 15:44:43 +0200
Message-ID: <CAMuHMdUb=sXBBRLhKNxsWT_Z4PCoLcM16NajvmPVHWsvgoL7_w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] spi: spi-davinci: Add support for SPI_CS_WORD
To:     David Lechner <david@lechnology.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, Sep 13, 2018 at 2:40 AM David Lechner <david@lechnology.com> wrote:
> This adds support for the SPI_CS_WORD flag to the TI DaVinci SPI
> driver. This mode can be used as long as we are using the hardware
> chip select and not a GPIO chip select.
>
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  drivers/spi/spi-davinci.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
> index d502cf504deb..8f7dcbc53c57 100644
> --- a/drivers/spi/spi-davinci.c
> +++ b/drivers/spi/spi-davinci.c
> @@ -230,7 +230,8 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
>                                 !(spi->mode & SPI_CS_HIGH));
>         } else {
>                 if (value == BITBANG_CS_ACTIVE) {
> -                       spidat1 |= SPIDAT1_CSHOLD_MASK;
> +                       if (!(spi->mode & SPI_CS_WORD))
> +                               spidat1 |= SPIDAT1_CSHOLD_MASK;
>                         spidat1 &= ~(0x1 << chip_sel);
>                 }
>         }
> @@ -440,8 +441,12 @@ static int davinci_spi_setup(struct spi_device *spi)
>                         return retval;
>                 }
>
> -               if (internal_cs)
> +               if (internal_cs) {
>                         set_io_bits(dspi->base + SPIPC0, 1 << spi->chip_select);
> +               } else if (spi->mode & SPI_CS_WORD) {
> +                       dev_err(&spi->dev, "SPI_CS_WORD can't be use with GPIO CS\n");
> +                       return -EINVAL;

Does the SPI core fall back to splitting the transfer in this case?

> +               }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
