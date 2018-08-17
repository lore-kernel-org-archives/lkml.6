Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD64C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7870A20C0E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCW4yBwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7870A20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeHQOUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 10:20:14 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35092 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbeHQOUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 10:20:14 -0400
Received: by mail-qk0-f195.google.com with SMTP id 89-v6so611916qkp.2;
        Fri, 17 Aug 2018 04:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fu0H0nzOVW++GdVdSZCokVruqXNFu3H5WUTj/x5kJa4=;
        b=TCW4yBwfB/ileETCGYKrM/69VpXIVyAJw1d15uozp6ONHsU4pJodd1lwy8z3rhgCeB
         SwZC4mA9tV9C9uQ4weYoux0s2DxVgLp9hi58eo0FxKk305bZDPr5pXxeUI1hOG3CPos+
         U6qQaVCAbgbzfxPGdZ4bPOMQIT4Limcb2kfVTHy8DdRGwwrz3azIrPBodSbANo5SAcJG
         901sVUSA9W4aQQdgWUzsQt35/q3NqgK+dvveYtpYS46bykOaEr1Yl7O8qk4rJ0pdqgHs
         dJQrdbIJgKpR4rS0kumk7cPLIBWjO0X840406k5HSnl+mmy3KcOM04HL9PG77N/IXU7r
         wnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fu0H0nzOVW++GdVdSZCokVruqXNFu3H5WUTj/x5kJa4=;
        b=FpSpA8r+u5jH73bc47k7OjqxE08+yEi+thy6+HqghYt72eNs91dp2ovZfktpVpKesr
         wwG+Tp2EwRQMoSYEjhoHtbX704EljQABFpoU8Cqeccc+foAKEA8HNlqKVlfh0tOBAXDv
         VUoDRj63OQRlqT9627hJBoB0c+Z0/UdQ0bAT27HACb9qWwLz6qJUUjKVCFFtJCpR8tYe
         GGHPIZSMqJhasBecPbP08h1ecBrqL2nW2YT0FL1q1DsDyCWM5OBRQnl8b1AP48dSC5qX
         ztW9eIe6WXHc6PtjSMkI6uZMpzljC5JJGITflKdAd/VKZme9WN3rhCL/Qi+klwTXfkLq
         G4qA==
X-Gm-Message-State: AOUpUlHq/EMBFIiHtkHYhxg+qqUeTMB5xy+Tm0jMnlUpvLaz2kuqmFfM
        93a7pJTyyLbcHIMcOAlpWscKV7pm93HrZaauqB6LI6Jo
X-Google-Smtp-Source: AA+uWPyyajKhwQJF2t+b8sahu7EO6j+h/8L7rGakiU5Bru0/PcvGszC+d2UdfPk6uSd2aL/WP9eC6wiXdt8VQzeuVv0=
X-Received: by 2002:a37:5c44:: with SMTP id q65-v6mr30210934qkb.97.1534504629438;
 Fri, 17 Aug 2018 04:17:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9c4a:0:0:0:0:0 with HTTP; Fri, 17 Aug 2018 04:17:08
 -0700 (PDT)
In-Reply-To: <20180817070105.1725-1-simon.k.r.goldschmidt@gmail.com>
References: <20180808071421.32707-1-simon.k.r.goldschmidt@gmail.com> <20180817070105.1725-1-simon.k.r.goldschmidt@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Aug 2018 14:17:08 +0300
Message-ID: <CAHp75Vc5bJEeX3tB8EbzWMf1GdFaSFgk+3u3CdZ2SVy3dWfVkA@mail.gmail.com>
Subject: Re: [PATCH v2] spi: dw: support 4-16 bits per word
To:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 10:01 AM, Simon Goldschmidt
<simon.k.r.goldschmidt@gmail.com> wrote:
> The spi-dw driver currently only supports 8 or 16 bits per word.
>
> Since the hardware supports 4-16 bits per word, adapt the driver
> to also support this.
>
> Tested on socfpga cyclone5 with a 9-bit SPI display.
>

LGTM,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> ---
>
> Changes in v2:
> - use DIV_ROUND_UP to calculate number of bytes per word instead of
>   if/else range checks
>
>  drivers/spi/spi-dw.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index f693bfe95ab9..58a7caf31d59 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -307,15 +307,13 @@ static int dw_spi_transfer_one(struct spi_controller *master,
>                 dws->current_freq = transfer->speed_hz;
>                 spi_set_clk(dws, chip->clk_div);
>         }
> -       if (transfer->bits_per_word == 8) {
> -               dws->n_bytes = 1;
> -               dws->dma_width = 1;
> -       } else if (transfer->bits_per_word == 16) {
> -               dws->n_bytes = 2;
> -               dws->dma_width = 2;
> -       } else {
> +
> +       if ((transfer->bits_per_word < 4) || (transfer->bits_per_word > 16))
>                 return -EINVAL;
> -       }
> +
> +       dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
> +       dws->dma_width = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
> +
>         /* Default SPI mode is SCPOL = 0, SCPH = 0 */
>         cr0 = (transfer->bits_per_word - 1)
>                 | (chip->type << SPI_FRF_OFFSET)
> @@ -493,7 +491,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>         }
>
>         master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
> -       master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
> +       master->bits_per_word_mask =  SPI_BPW_RANGE_MASK(4, 16);
>         master->bus_num = dws->bus_num;
>         master->num_chipselect = dws->num_cs;
>         master->setup = dw_spi_setup;
> --
> 2.17.1
>



-- 
With Best Regards,
Andy Shevchenko
