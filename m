Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB993C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595AE20854
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MnrzKI9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595AE20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeJEE2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:28:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45641 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJEE2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:28:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id y15-v6so5782810plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 14:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i4fSVfn4HcQRGpxJgOJtUVZ5Br2TMpkJCdYv/Vg+dtA=;
        b=MnrzKI9KQOWvMr9OWHf8TqeYXbj/wQ39G523qqeQL57sWIL905LJJwWj8Date/P8mL
         UVvRT1Huo6TNysvl4Wa++GzWyA2gjTaNg8AN398Wt1uzCiehlQ7nmNWIQgmhMcAlVFwh
         dY7ziufDXmt3rCZMrJo+A+HDPldAO8NNX16zemiLWW3MHsMBTP+/v3IxGVOYPVx64Ax8
         Qo2c6QpuRcdtbkZ8RDAacCzP+WhZtTzODzG2PttnRmRqp5QwnWhR5j3WfbmpCaaqTugT
         S1f0usO4s0ecRpxUNJ1xps8Ic/6Yl4ZugvjH3wHbnUH39mFvRAco5T6Lfzz5w/7h5QrT
         g5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4fSVfn4HcQRGpxJgOJtUVZ5Br2TMpkJCdYv/Vg+dtA=;
        b=jhPzXkwxqiC4Y3doxBjMQu6mUCL8jzEw12YRQ8+7D4sKxG6KdriAdl1XdeKVp1N1sd
         x+fwG4TXrLCeBb0xyFbv8anNwp6JE8U653i60e33gu8oGgfK188HRXlE9IO1hmxKoXZx
         RTJGzyVhI0ceJyN02KG3ybi8xI4slRdO0ddI7t5x13/sb+KqFB/Ocr3Y8IMDBHq21snd
         7D8jHA3BqdDQhCipUp/QQrD3zMxV77nq6hTuuWWxSydyqfnWMuKqUkPO1mZ4qWiJ2EV7
         gpcqOIhDLKJ9lGEpWKTZr6E2G9846tCObIKAnlqIxMEp7cdCAXBZivvqZatObkbUy2sP
         Lemg==
X-Gm-Message-State: ABuFfojxmzIg7QD8Od/+LPqU27CYRGWWwF3/tJoW/diHyk6y8YImVOiD
        QH+K2PY/ZRGUUTHxgbG/t7ztdEuXXV3WFqruI4VX4w==
X-Google-Smtp-Source: ACcGV6306kWMVPgrYA5o1MJ52emJRmDcsAsTgSx6eBN59b9OnXF7uIXuYwcdJRZ/sHynXWVs/rB/ramXjuRDS0NBVqw=
X-Received: by 2002:a17:902:b410:: with SMTP id x16-v6mr6843774plr.13.1538688779345;
 Thu, 04 Oct 2018 14:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181004023926.15847-1-natechancellor@gmail.com> <20181004024010.15986-1-natechancellor@gmail.com>
In-Reply-To: <20181004024010.15986-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 4 Oct 2018 14:32:48 -0700
Message-ID: <CAKwvOd=QdyNnTz19Vc6FSQfbKrFnvZ7VHYvhaMtfcNCKYm2Utg@mail.gmail.com>
Subject: Re: [PATCH v2] spi: spi-ep93xx: Change dir type in ep93xx_spi_dma_{finish,prepare}
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 7:41 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when one enumerated type is implicitly converted to another.
>
> drivers/spi/spi-ep93xx.c:342:62: warning: implicit conversion from
> enumeration type 'enum dma_transfer_direction' to different enumeration
> type 'enum dma_data_direction' [-Wenum-conversion]

I'm just trying to think what this change would look like if this
driver ONLY used `enum dma_data_direction`?  There's an additional
warning in the header that a return value is messed up there, too:

In file included from drivers/spi/spi-ep93xx.c:34:
./include/linux/platform_data/dma-ep93xx.h:88:10: warning: implicit
conversion from
      enumeration type 'enum dma_data_direction' to different
enumeration type 'enum
      dma_transfer_direction' [-Wenum-conversion]
                return DMA_NONE;
                ~~~~~~ ^~~~~~~~

>         nents = dma_map_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
>                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> ./include/linux/dma-mapping.h:428:58: note: expanded from macro
> 'dma_map_sg'
> #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
>                                ~~~~~~~~~~~~~~~~          ^
> drivers/spi/spi-ep93xx.c:348:57: warning: implicit conversion from
> enumeration type 'enum dma_transfer_direction' to different enumeration
> type 'enum dma_data_direction' [-Wenum-conversion]
>                 dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
>                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> 'dma_unmap_sg'
> #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
>                                  ~~~~~~~~~~~~~~~~~~          ^
> drivers/spi/spi-ep93xx.c:377:56: warning: implicit conversion from
> enumeration type 'enum dma_transfer_direction' to different enumeration
> type 'enum dma_data_direction' [-Wenum-conversion]
>         dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> 'dma_unmap_sg'
> #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
>                                  ~~~~~~~~~~~~~~~~~~          ^
> 3 warnings generated.
>
> dma_{,un}map_sg expects an enum of type dma_data_direction but this
> driver uses dma_transfer_direction for everything. Converting to
> dma_data_direction would be desirable but there are a few shared
> structures that expect dma_transfer_direction so it is just simpler to
> change the parameter here. dma_transfer_direction and dma_data_direction
> are different sizes but this driver only uses the 1 and 2 values which
> mean the same thing so this change is safe.
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:
>
> * Fix escaped hash symbols for '#define' lines
>
>  drivers/spi/spi-ep93xx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
> index f1526757aaf6..189fc2225b69 100644
> --- a/drivers/spi/spi-ep93xx.c
> +++ b/drivers/spi/spi-ep93xx.c
> @@ -256,8 +256,7 @@ static int ep93xx_spi_read_write(struct spi_master *master)
>   * in case of failure.
>   */
>  static struct dma_async_tx_descriptor *
> -ep93xx_spi_dma_prepare(struct spi_master *master,
> -                      enum dma_transfer_direction dir)
> +ep93xx_spi_dma_prepare(struct spi_master *master, int dir)
>  {
>         struct ep93xx_spi *espi = spi_master_get_devdata(master);
>         struct spi_transfer *xfer = master->cur_msg->state;
> @@ -359,8 +358,7 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
>   * Function finishes with the DMA transfer. After this, the DMA buffer is
>   * unmapped.
>   */
> -static void ep93xx_spi_dma_finish(struct spi_master *master,
> -                                 enum dma_transfer_direction dir)
> +static void ep93xx_spi_dma_finish(struct spi_master *master, int dir)
>  {
>         struct ep93xx_spi *espi = spi_master_get_devdata(master);
>         struct dma_chan *chan;
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
