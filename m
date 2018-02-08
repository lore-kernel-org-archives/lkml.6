Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeBHJyn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:54:43 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:42488 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbeBHJyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:54:40 -0500
X-Google-Smtp-Source: AH8x225A5Jzox3tgWwSIS6Sgmc92cRt8/D57yB7VJH4EcPImBiUwAvmZVbZltzdkyGEDc8jrxKIz0gNXEx2TRi5KIm4=
MIME-Version: 1.0
In-Reply-To: <20180207160002.GA9292@embeddedgus>
References: <20180207160002.GA9292@embeddedgus>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 8 Feb 2018 09:54:38 +0000
Message-ID: <CAKv+Gu9hmxLSS0ekr8av-ADt3OQjBV=Bt-hRq_-SzWaGODs4SQ@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm2835aux: use 64-bit arithmetic instead of 32-bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 February 2018 at 16:00, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
> Add suffix ULL to constant 9 in order to give the compiler complete
> information about the proper arithmetic to use. Notice that this
> constant is used in a context that expects an expression of type
> unsigned long long (64 bits, unsigned).
>
> The expression tfr->len * 9 * 1000000 is currently being evaluated
> using 32-bit arithmetic.
>
> Addresses-Coverity-ID: 1339619

What does this number mean? If it is an index into some internal
database, please remove it.

> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/spi/spi-bcm2835aux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
> index 7428091..a768c23 100644
> --- a/drivers/spi/spi-bcm2835aux.c
> +++ b/drivers/spi/spi-bcm2835aux.c
> @@ -363,7 +363,7 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
>          * chunk getting transferred - in our case the chunk size
>          * is 3 bytes, so we approximate this by 9 bits/byte
>          */
> -       xfer_time_us = tfr->len * 9 * 1000000;
> +       xfer_time_us = tfr->len * 9ULL * 1000000;
>         do_div(xfer_time_us, spi_used_hz);
>
>         /* run in polling mode for short transfers */
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
