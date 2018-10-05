Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C4EC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC1520652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIa7jaZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC1520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbeJFDqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:46:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45620 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeJFDqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:46:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5-v6so14777640wrw.12;
        Fri, 05 Oct 2018 13:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2fd0NIda3NuGibPZHV5xy+BrQM8UN0fuIj67tawPeLM=;
        b=iIa7jaZlpblMbVPWgiwheJcug5mFiMbyVxRuAbeLg38AMPptjcw20g/J0JMdJ4SJTb
         DazUpkGoPYaUC4iIp4nqFjPtFa71TYYnUCjphkQwIFsgZ9kkejEWxGztijH4WqMYe7Nf
         Fj6qsII3fuUiHQmqU5aH87FDdn2Cjzk2kjdWfqWxlNdQ6QwIq2dWKyDnyEd+uBbKwhoW
         adiYD2Eqdyf5B6eVuwdcpt4jiMhWRienAe117wFSlelWU6fo1QcuBBhYTzgBbHYRkRSQ
         GbyBdtUDappd8HO6kw5ZycFrQy1If07WPXHJTrh2y0OAvRW2XttHP/Q+oqjghwLdLps0
         KrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2fd0NIda3NuGibPZHV5xy+BrQM8UN0fuIj67tawPeLM=;
        b=b3bWWhkd0Pjyw7GzivuvtM8zfis+S9BxRBHRa8LPCa8igJ9H/8lxdIYa6jK6NZ/7PD
         IsuxpwIegz5JGwPWgY521k/KgpnIkqLIBXKwUZLSozmzCIwCf40/8ucO/XWuyqxi/mSj
         LeTS/YudzYND8o86trtBFe/bOhzQFrOC//1KBdl5/oHy9oe5rR1QQ3/4oyL9t3LzKucZ
         RVndjXxeQMjbRFh6j9Ixyyr91PEbbqd9Z8ge8II/+PiThcBbjJubRpCtTs590uq86q7n
         6o9ZV3Q0CJFnsmfbqkT5N6LRQLGT0zqjwCRjjzIGXPeP9X2LHDgYxVaiRWb/LwXGfLNG
         /H9Q==
X-Gm-Message-State: ABuFfohAksZppS0EjzWKyyfNtrNvN61X4szwxquXEunRm14D1Zp6GoGx
        sgHY0zf+4sx9wTt1SZvkYak=
X-Google-Smtp-Source: ACcGV60CZhIyPxKXj7kCfgyaBdKKPOuz3JufFjq8HrSbhDvU3AVSZYWG/S8JQXCn1dIbM0V8397aFg==
X-Received: by 2002:adf:c187:: with SMTP id x7-v6mr9269512wre.233.1538772382559;
        Fri, 05 Oct 2018 13:46:22 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id h82-v6sm2078155wmf.14.2018.10.05.13.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 13:46:21 -0700 (PDT)
Date:   Fri, 5 Oct 2018 13:46:19 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     mika.westerberg@linux.intel.com, hartleys@visionengravers.com,
        broonie@kernel.org, linux-spi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] spi: spi-ep93xx: Use dma_data_direction for
 ep93xx_spi_dma_{finish,prepare}
Message-ID: <20181005204619.GA19733@flashbox>
References: <20181004024010.15986-1-natechancellor@gmail.com>
 <20181005192508.18659-1-natechancellor@gmail.com>
 <CAKwvOd=yJoQNuVjz3=iDOcaDzwqfPO2qKjZw9OS7CL9nU9oD7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=yJoQNuVjz3=iDOcaDzwqfPO2qKjZw9OS7CL9nU9oD7g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 01:41:19PM -0700, Nick Desaulniers wrote:
> Nathan,
> Thanks for your patience and continued support working towards an
> optimal solution to fix this warning. Some thoughts below.
> 
> On Fri, Oct 5, 2018 at 12:29 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns when one enumerated type is implicitly converted to another.
> >
> > drivers/spi/spi-ep93xx.c:342:62: warning: implicit conversion from
> > enumeration type 'enum dma_transfer_direction' to different enumeration
> > type 'enum dma_data_direction' [-Wenum-conversion]
> >         nents = dma_map_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> >                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > ./include/linux/dma-mapping.h:428:58: note: expanded from macro
> > 'dma_map_sg'
> > #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
> >                                ~~~~~~~~~~~~~~~~          ^
> > drivers/spi/spi-ep93xx.c:348:57: warning: implicit conversion from
> > enumeration type 'enum dma_transfer_direction' to different enumeration
> > type 'enum dma_data_direction' [-Wenum-conversion]
> >                 dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> >                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> > 'dma_unmap_sg'
> > #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
> >                                  ~~~~~~~~~~~~~~~~~~          ^
> > drivers/spi/spi-ep93xx.c:377:56: warning: implicit conversion from
> > enumeration type 'enum dma_transfer_direction' to different enumeration
> > type 'enum dma_data_direction' [-Wenum-conversion]
> >         dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> >         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> > 'dma_unmap_sg'
> > #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
> >                                  ~~~~~~~~~~~~~~~~~~          ^
> > 3 warnings generated.
> >
> > dma_{,un}map_sg expect an enum of type dma_data_direction but this
> > driver uses dma_transfer_direction for everything. Convert the driver to
> > use dma_data_direction for these two functions.
> >
> > There are two places that strictly require an enum of type
> > dma_transfer_direction: the direction member in struct dma_slave_config
> > and the direction parameter in dmaengine_prep_slave_sg. To avoid using
> > an explicit cast, add a simple function, ep93xx_dma_data_to_trans_dir,
> > to safely map between the two types because they are not 1 to 1 in
> > meaning.
> >
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >
> > v1 -> v2:
> >
> > * Fix escaped hash symbols for '#define' lines (\# -> #)
> >
> > v2 -> v3:
> >
> > * Instead of changing the dir parameter in the prepare and finish
> >   functions, convert the driver to use dma_data_direction for everywhere
> >   that makes sense. Add a helper function to convert between the two
> >   types as there is still a couple of locations that need a transfer
> >   enum (and no such function exists). Alternatively, the function could
> >   just convert from transfer -> data and be used in dma_{,un}map_sg and
> >   the rest of the driver be left alone. Hopefully I understood what Mika
> >   wanted!
> >
> >  drivers/spi/spi-ep93xx.c | 37 ++++++++++++++++++++++++++-----------
> >  1 file changed, 26 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
> > index f1526757aaf6..667da7964d63 100644
> > --- a/drivers/spi/spi-ep93xx.c
> > +++ b/drivers/spi/spi-ep93xx.c
> > @@ -246,6 +246,19 @@ static int ep93xx_spi_read_write(struct spi_master *master)
> >         return -EINPROGRESS;
> >  }
> >
> > +static enum dma_transfer_direction
> > +ep93xx_dma_data_to_trans_dir(enum dma_data_direction dir)
> > +{
> > +       switch (dir) {
> > +       case DMA_TO_DEVICE:
> > +               return DMA_MEM_TO_DEV;
> > +       case DMA_FROM_DEVICE:
> > +               return DMA_DEV_TO_MEM;
> > +       default:
> > +               return DMA_TRANS_NONE;
> > +       }
> > +}
> > +
> >  /**
> >   * ep93xx_spi_dma_prepare() - prepares a DMA transfer
> >   * @master: SPI master
> > @@ -257,7 +270,7 @@ static int ep93xx_spi_read_write(struct spi_master *master)
> >   */
> >  static struct dma_async_tx_descriptor *
> >  ep93xx_spi_dma_prepare(struct spi_master *master,
> > -                      enum dma_transfer_direction dir)
> > +                      enum dma_data_direction dir)
> >  {
> >         struct ep93xx_spi *espi = spi_master_get_devdata(master);
> >         struct spi_transfer *xfer = master->cur_msg->state;
> > @@ -277,9 +290,9 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
> >                 buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
> >
> >         memset(&conf, 0, sizeof(conf));
> > -       conf.direction = dir;
> > +       conf.direction = ep93xx_dma_data_to_trans_dir(dir);
> >
> > -       if (dir == DMA_DEV_TO_MEM) {
> > +       if (dir == DMA_FROM_DEVICE) {
> >                 chan = espi->dma_rx;
> >                 buf = xfer->rx_buf;
> >                 sgt = &espi->rx_sgt;
> > @@ -343,7 +356,9 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
> >         if (!nents)
> >                 return ERR_PTR(-ENOMEM);
> >
> > -       txd = dmaengine_prep_slave_sg(chan, sgt->sgl, nents, dir, DMA_CTRL_ACK);
> > +       txd = dmaengine_prep_slave_sg(chan, sgt->sgl, nents,
> > +                                     ep93xx_dma_data_to_trans_dir(dir),
> 
> So we've already calculated this once already in this function, and
> the value of `dir` hasn't changed since.  While the compiler might be
> able to optimize out this common sub expression (CSE or GVN I think
> are the compiler passes that could optimize this out), I think it
> would be better to guarantee that this precalculated value is always
> used by replacing the rematerialization of the value
> (`ep93xx_dma_data_to_trans_dir(dir)`) with `conf.direction`.
> 

Hi Nick,

That's a good point, I will change that for v4 (I'll wait for Mika and
Hartley to chime in before sending it out).

Thanks for the review,
Nathan

> > +                                     DMA_CTRL_ACK);
> >         if (!txd) {
> >                 dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> >                 return ERR_PTR(-ENOMEM);
> > @@ -360,13 +375,13 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
> >   * unmapped.
> >   */
> >  static void ep93xx_spi_dma_finish(struct spi_master *master,
> > -                                 enum dma_transfer_direction dir)
> > +                                 enum dma_data_direction dir)
> >  {
> >         struct ep93xx_spi *espi = spi_master_get_devdata(master);
> >         struct dma_chan *chan;
> >         struct sg_table *sgt;
> >
> > -       if (dir == DMA_DEV_TO_MEM) {
> > +       if (dir == DMA_FROM_DEVICE) {
> >                 chan = espi->dma_rx;
> >                 sgt = &espi->rx_sgt;
> >         } else {
> > @@ -381,8 +396,8 @@ static void ep93xx_spi_dma_callback(void *callback_param)
> >  {
> >         struct spi_master *master = callback_param;
> >
> > -       ep93xx_spi_dma_finish(master, DMA_MEM_TO_DEV);
> > -       ep93xx_spi_dma_finish(master, DMA_DEV_TO_MEM);
> > +       ep93xx_spi_dma_finish(master, DMA_TO_DEVICE);
> > +       ep93xx_spi_dma_finish(master, DMA_FROM_DEVICE);
> >
> >         spi_finalize_current_transfer(master);
> >  }
> > @@ -392,15 +407,15 @@ static int ep93xx_spi_dma_transfer(struct spi_master *master)
> >         struct ep93xx_spi *espi = spi_master_get_devdata(master);
> >         struct dma_async_tx_descriptor *rxd, *txd;
> >
> > -       rxd = ep93xx_spi_dma_prepare(master, DMA_DEV_TO_MEM);
> > +       rxd = ep93xx_spi_dma_prepare(master, DMA_FROM_DEVICE);
> >         if (IS_ERR(rxd)) {
> >                 dev_err(&master->dev, "DMA RX failed: %ld\n", PTR_ERR(rxd));
> >                 return PTR_ERR(rxd);
> >         }
> >
> > -       txd = ep93xx_spi_dma_prepare(master, DMA_MEM_TO_DEV);
> > +       txd = ep93xx_spi_dma_prepare(master, DMA_TO_DEVICE);
> >         if (IS_ERR(txd)) {
> > -               ep93xx_spi_dma_finish(master, DMA_DEV_TO_MEM);
> > +               ep93xx_spi_dma_finish(master, DMA_FROM_DEVICE);
> >                 dev_err(&master->dev, "DMA TX failed: %ld\n", PTR_ERR(txd));
> >                 return PTR_ERR(txd);
> >         }
> > --
> > 2.19.0
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
