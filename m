Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79753C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B182084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzTUhBqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B182084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbeJEEmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:42:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38746 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbeJEEmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:42:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id a13-v6so11467972wrt.5;
        Thu, 04 Oct 2018 14:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7eGmHukiXVvz5h3EG+o6JcJmcEB7DUv4NV9eJnlGjw8=;
        b=KzTUhBqoWTek0RyncsSjwGxRu/80PWiHDFp+d+yVD6tQjbh/ogrO/DlDBLPxkNt5Hh
         AoY2GUeVZEEE6JSe4fkLPCxVlXclSaubjhkciKqUTl/qlg8LoX4z8rUs+eNQMX50XaCs
         H9/RFApPOY01mdrcE1N6q90sfhvS/cKaWxibEVhyj0GMgB+b/nvPYdxNUbKvdEXrhgub
         kd9eeej1fp0jCO6nYdH3MIwrMgBgk4I9KJBD8/Fk/nkCVXTFeSCPKdTcEl64jjOGqGxZ
         gLkRs5lKekN2olD9p6v4ElCv5shC+7ggPs2/1AX9lXxPm9CKyv2o402Z7dcKh6N3NNui
         loMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7eGmHukiXVvz5h3EG+o6JcJmcEB7DUv4NV9eJnlGjw8=;
        b=WGnp8fwAM6D1joyF9GWmxuZ79qEPoyfqKl06P8N8eorqmBmB9jY3ZKfGThNJEiQ90X
         SgdNquj9BgwIyjCSUzonXw/GyhZ6Am5X5+oUwfToFL5saWR6zwhgptOE0DSxi+mHLO0K
         1iCeA7lfPWl+Zj3l9qlMmzAVl7Re4zcG7f17gY2sXHcMWh1v04a6RgC+Fz53D8qE9dsA
         A0pF/GTSmE3R3AVwLZXGKIELLEkdfOxBF9Ufgr7Jg2zAdRN4YLkCpBLtR9mlfi9jcUUw
         ERNoclJzInejK669jZALryvzIHz2EpmsB2cfntBYvXkfQ7keLfjwM8izeaQooiCgpH3C
         as5A==
X-Gm-Message-State: ABuFfoiGoLMjfKeTmCmNPaiQyV9Ehl5jflohJUCgdU3LOqJkIn+RlVnQ
        p99m2u1u0/YV55vkWmKwl9s=
X-Google-Smtp-Source: ACcGV61q3IhT5motxuesdS+HB3S6uirLnYlz4IwRqnpuHRdJbCrUAMSiIU5RNgVw4Vrcde7mvGmPuw==
X-Received: by 2002:adf:dd83:: with SMTP id x3-v6mr6082094wrl.212.1538689635910;
        Thu, 04 Oct 2018 14:47:15 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id x203-v6sm5316wmg.42.2018.10.04.14.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 14:47:15 -0700 (PDT)
Date:   Thu, 4 Oct 2018 14:47:13 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] spi: spi-ep93xx: Change dir type in
 ep93xx_spi_dma_{finish,prepare}
Message-ID: <20181004214713.GA7147@flashbox>
References: <20181004023926.15847-1-natechancellor@gmail.com>
 <20181004024010.15986-1-natechancellor@gmail.com>
 <CAKwvOd=QdyNnTz19Vc6FSQfbKrFnvZ7VHYvhaMtfcNCKYm2Utg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=QdyNnTz19Vc6FSQfbKrFnvZ7VHYvhaMtfcNCKYm2Utg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 02:32:48PM -0700, Nick Desaulniers wrote:
> On Wed, Oct 3, 2018 at 7:41 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns when one enumerated type is implicitly converted to another.
> >
> > drivers/spi/spi-ep93xx.c:342:62: warning: implicit conversion from
> > enumeration type 'enum dma_transfer_direction' to different enumeration
> > type 'enum dma_data_direction' [-Wenum-conversion]
> 
> I'm just trying to think what this change would look like if this
> driver ONLY used `enum dma_data_direction`?  There's an additional

I can work up a proof of concept patch but it was kind of convoluted
when I tried before this patch because dmaengine_prep_slave_sg and the
direction member in struct dma_slave_config expect an enum of type
dma_transfer_direction so there are two explicit casts needed and I
thought there were one or two more places that it complained.

This was the cleanest solution to me but I'm happy to rework it in any
way that I need to.

> warning in the header that a return value is messed up there, too:
> 
> In file included from drivers/spi/spi-ep93xx.c:34:
> ./include/linux/platform_data/dma-ep93xx.h:88:10: warning: implicit
> conversion from
>       enumeration type 'enum dma_data_direction' to different
> enumeration type 'enum
>       dma_transfer_direction' [-Wenum-conversion]
>                 return DMA_NONE;
>                 ~~~~~~ ^~~~~~~~
> 

This is fixed in the dma tree and that function isn't used in this file:
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git/commit/?id=9524d6b265f9b2b9a61fceb2ee2ce1c2a83e39ca

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
> > dma_{,un}map_sg expects an enum of type dma_data_direction but this
> > driver uses dma_transfer_direction for everything. Converting to
> > dma_data_direction would be desirable but there are a few shared
> > structures that expect dma_transfer_direction so it is just simpler to
> > change the parameter here. dma_transfer_direction and dma_data_direction
> > are different sizes but this driver only uses the 1 and 2 values which
> > mean the same thing so this change is safe.
> >
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >
> > v1 -> v2:
> >
> > * Fix escaped hash symbols for '#define' lines
> >
> >  drivers/spi/spi-ep93xx.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
> > index f1526757aaf6..189fc2225b69 100644
> > --- a/drivers/spi/spi-ep93xx.c
> > +++ b/drivers/spi/spi-ep93xx.c
> > @@ -256,8 +256,7 @@ static int ep93xx_spi_read_write(struct spi_master *master)
> >   * in case of failure.
> >   */
> >  static struct dma_async_tx_descriptor *
> > -ep93xx_spi_dma_prepare(struct spi_master *master,
> > -                      enum dma_transfer_direction dir)
> > +ep93xx_spi_dma_prepare(struct spi_master *master, int dir)
> >  {
> >         struct ep93xx_spi *espi = spi_master_get_devdata(master);
> >         struct spi_transfer *xfer = master->cur_msg->state;
> > @@ -359,8 +358,7 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
> >   * Function finishes with the DMA transfer. After this, the DMA buffer is
> >   * unmapped.
> >   */
> > -static void ep93xx_spi_dma_finish(struct spi_master *master,
> > -                                 enum dma_transfer_direction dir)
> > +static void ep93xx_spi_dma_finish(struct spi_master *master, int dir)
> >  {
> >         struct ep93xx_spi *espi = spi_master_get_devdata(master);
> >         struct dma_chan *chan;
> > --
> > 2.19.0
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
