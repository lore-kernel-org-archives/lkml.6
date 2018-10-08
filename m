Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D911BC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F37921479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nrKJm+xq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F37921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJIBdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:33:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33827 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbeJIBde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:33:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id g12-v6so8209870pgs.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 11:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sUaXvM0BYF5UabUY33mhU+Fm6ETp8H+pxGA3RIiNnwY=;
        b=nrKJm+xqOXiiLKTtVy9OqK1vcOQWHVSjBJ9fhKYTry5vHMlXu9MRmGxTV9+0cCWknF
         X6tXcCd8Efbj/6Cdl8OMygGNirIbeBPgCgUapKZN9Eq6z/eNxfIBcc3gGxcJg0oLthjs
         Z5UNwKrDpyhTr2koryiilRKS57ajo1cUHj5utkQdQM1x3YdhvOm2+U2QIoN6eZ84f5yt
         gAG1sdRLnqpJVkoTDFkupJLySF5puXprOUQkbMP7huU7qT47dbr9svPU44raIrS6hXW1
         zK6Lb50p4a97pm8FuwPj3Zpp8+5rEIBNQde8VdLXaIqv11GMHWEWFdgO1NtUKKaA8niV
         qYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sUaXvM0BYF5UabUY33mhU+Fm6ETp8H+pxGA3RIiNnwY=;
        b=Rs2MBirckTsvAorz72Eb2Rm3KcxXnFVAWeM4p1pcWqJRpSfkh61i3BrWI7JIQSk/Ue
         bm5DXfFpxvU3HGLKXiiyUdGewGG+V1VxBSvNgY27yTLxGKpX6/EsjuTbGExeyRWmDIyV
         Qn/jH8dAmIZQJsRV+4QZheRfYVKipNhn5CxfvmPWT6QBzic7AAooro9fzix9RMb3GH/+
         i6Z0zDVswUKYC1EkzROgP+EehUF36t6KCFuCprAn31UX3yWZPsJnT25kCdH+Ailby8w8
         /wefhSboihe9pmZ1Jr51cVYzJjvmKqtZ5mut1pCo5VxP6HCFxfJ8XYJ2MZXIfhTW4qq5
         S9ew==
X-Gm-Message-State: ABuFfojw0ECgCjzidOfI4DYrs2O/cI9DFgHh274FlsMu1D609N2pBzTj
        J9eGHDUJdjyRnjOuWD85til4T4gWQ/XN0qRtmk9EhA==
X-Google-Smtp-Source: ACcGV60tc9IuxauM6O59cmtruCZEhhyp3QIrtRsC0THf0CDwRlgc+P4x+hjplLPNPHMY9/ZgzKdsVoZgVCqyFQWjPfg=
X-Received: by 2002:a62:4b09:: with SMTP id y9-v6mr26239817pfa.93.1539022461260;
 Mon, 08 Oct 2018 11:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181005192508.18659-1-natechancellor@gmail.com> <20181008180846.14119-1-natechancellor@gmail.com>
In-Reply-To: <20181008180846.14119-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 8 Oct 2018 11:14:09 -0700
Message-ID: <CAKwvOd=in+R30Hi72ZoFjWurr_8kM_5krCBU0Emqq6JDxwrPNA@mail.gmail.com>
Subject: Re: [PATCH v4] spi: spi-ep93xx: Use dma_data_direction for ep93xx_spi_dma_{finish,prepare}
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     mika.westerberg@linux.intel.com, hartleys@visionengravers.com,
        broonie@kernel.org, linux-spi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 11:09 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when one enumerated type is implicitly converted to another.
>
> drivers/spi/spi-ep93xx.c:342:62: warning: implicit conversion from
> enumeration type 'enum dma_transfer_direction' to different enumeration
> type 'enum dma_data_direction' [-Wenum-conversion]
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
> dma_{,un}map_sg expect an enum of type dma_data_direction but this
> driver uses dma_transfer_direction for everything. Convert the driver to
> use dma_data_direction for these two functions.
>
> There are two places that strictly require an enum of type
> dma_transfer_direction: the direction member in struct dma_slave_config
> and the direction parameter in dmaengine_prep_slave_sg. To avoid using
> an explicit cast, add a simple function, ep93xx_dma_data_to_trans_dir,
> to safely map between the two types because they are not 1 to 1 in
> meaning.
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:
>
> * Fix escaped hash symbols for '#define' lines (\# -> #).
>
> v2 -> v3:
>
> * Instead of changing the dir parameter in the prepare and finish
>   functions, convert the driver to use dma_data_direction for everywhere
>   that makes sense, thanks to review from Mika. Add a helper function to
>   convert between the two types as there is still a couple of locations
>   that need a transfer enum (and no such function exists).
>
> v3 -> v4:
>
> * Use 'conf.direction' in dmaengine_prep_slave_sg instead of the new
>   function since the value was already set earlier in the function and
>   never changed, thanks to review from Nick.

Thanks Nathan!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>  drivers/spi/spi-ep93xx.c | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
> index f1526757aaf6..79fc3940245a 100644
> --- a/drivers/spi/spi-ep93xx.c
> +++ b/drivers/spi/spi-ep93xx.c
> @@ -246,6 +246,19 @@ static int ep93xx_spi_read_write(struct spi_master *master)
>         return -EINPROGRESS;
>  }
>
> +static enum dma_transfer_direction
> +ep93xx_dma_data_to_trans_dir(enum dma_data_direction dir)
> +{
> +       switch (dir) {
> +       case DMA_TO_DEVICE:
> +               return DMA_MEM_TO_DEV;
> +       case DMA_FROM_DEVICE:
> +               return DMA_DEV_TO_MEM;
> +       default:
> +               return DMA_TRANS_NONE;
> +       }
> +}
> +
>  /**
>   * ep93xx_spi_dma_prepare() - prepares a DMA transfer
>   * @master: SPI master
> @@ -257,7 +270,7 @@ static int ep93xx_spi_read_write(struct spi_master *master)
>   */
>  static struct dma_async_tx_descriptor *
>  ep93xx_spi_dma_prepare(struct spi_master *master,
> -                      enum dma_transfer_direction dir)
> +                      enum dma_data_direction dir)
>  {
>         struct ep93xx_spi *espi = spi_master_get_devdata(master);
>         struct spi_transfer *xfer = master->cur_msg->state;
> @@ -277,9 +290,9 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
>                 buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
>
>         memset(&conf, 0, sizeof(conf));
> -       conf.direction = dir;
> +       conf.direction = ep93xx_dma_data_to_trans_dir(dir);
>
> -       if (dir == DMA_DEV_TO_MEM) {
> +       if (dir == DMA_FROM_DEVICE) {
>                 chan = espi->dma_rx;
>                 buf = xfer->rx_buf;
>                 sgt = &espi->rx_sgt;
> @@ -343,7 +356,8 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
>         if (!nents)
>                 return ERR_PTR(-ENOMEM);
>
> -       txd = dmaengine_prep_slave_sg(chan, sgt->sgl, nents, dir, DMA_CTRL_ACK);
> +       txd = dmaengine_prep_slave_sg(chan, sgt->sgl, nents, conf.direction,
> +                                     DMA_CTRL_ACK);
>         if (!txd) {
>                 dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
>                 return ERR_PTR(-ENOMEM);
> @@ -360,13 +374,13 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
>   * unmapped.
>   */
>  static void ep93xx_spi_dma_finish(struct spi_master *master,
> -                                 enum dma_transfer_direction dir)
> +                                 enum dma_data_direction dir)
>  {
>         struct ep93xx_spi *espi = spi_master_get_devdata(master);
>         struct dma_chan *chan;
>         struct sg_table *sgt;
>
> -       if (dir == DMA_DEV_TO_MEM) {
> +       if (dir == DMA_FROM_DEVICE) {
>                 chan = espi->dma_rx;
>                 sgt = &espi->rx_sgt;
>         } else {
> @@ -381,8 +395,8 @@ static void ep93xx_spi_dma_callback(void *callback_param)
>  {
>         struct spi_master *master = callback_param;
>
> -       ep93xx_spi_dma_finish(master, DMA_MEM_TO_DEV);
> -       ep93xx_spi_dma_finish(master, DMA_DEV_TO_MEM);
> +       ep93xx_spi_dma_finish(master, DMA_TO_DEVICE);
> +       ep93xx_spi_dma_finish(master, DMA_FROM_DEVICE);
>
>         spi_finalize_current_transfer(master);
>  }
> @@ -392,15 +406,15 @@ static int ep93xx_spi_dma_transfer(struct spi_master *master)
>         struct ep93xx_spi *espi = spi_master_get_devdata(master);
>         struct dma_async_tx_descriptor *rxd, *txd;
>
> -       rxd = ep93xx_spi_dma_prepare(master, DMA_DEV_TO_MEM);
> +       rxd = ep93xx_spi_dma_prepare(master, DMA_FROM_DEVICE);
>         if (IS_ERR(rxd)) {
>                 dev_err(&master->dev, "DMA RX failed: %ld\n", PTR_ERR(rxd));
>                 return PTR_ERR(rxd);
>         }
>
> -       txd = ep93xx_spi_dma_prepare(master, DMA_MEM_TO_DEV);
> +       txd = ep93xx_spi_dma_prepare(master, DMA_TO_DEVICE);
>         if (IS_ERR(txd)) {
> -               ep93xx_spi_dma_finish(master, DMA_DEV_TO_MEM);
> +               ep93xx_spi_dma_finish(master, DMA_FROM_DEVICE);
>                 dev_err(&master->dev, "DMA TX failed: %ld\n", PTR_ERR(txd));
>                 return PTR_ERR(txd);
>         }
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
