Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1D0C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0532B20645
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oc+eeRrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0532B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeJEGIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 02:08:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42342 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeJEGIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 02:08:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id f26-v6so3959554pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 16:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lNklN+D1ftmwaMGJnM6r/ubHKvTqXndPU5l9bnd5bnc=;
        b=oc+eeRrxVnJdWNKYRRgEBSH8Rcd15wlLcNMgLt8fl2flRKlJz4143sbo43TodEOpM7
         95ZMZJkJQ+x/zUcmnHHJjakBfJBeAVijC4cOUswg+BOalhaA6UNJ36s8zAgVePPIvsNd
         wazAgTkuywmj9CkvcDe28isQe3briRF6WMpWlL7jfQM2wCC1NFKbIRfomzvl27sfIdDA
         uDQ3UdiqJJLmBqfgD7JdDzo+964a8qwHAhonl+EMFlQhmKk4Hkmenomth9cFjQk6Q0J6
         wVkLPv50tqg849RGP6L2d/Gxn6z+uhsCCLfNhAJZvURLmGXmuILVaEDHlfqGbtBoAElW
         0ViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lNklN+D1ftmwaMGJnM6r/ubHKvTqXndPU5l9bnd5bnc=;
        b=AkwN+2SPpZYZ5LodoGwIiR+nAxLSyuU/niDw8eladRJjmPeXTOYP0wUEox8dmNtQte
         YzG0f8NcuFPpmCQZudwva0K7SWfITd3cPxIWuU7goC3miHYW1DtyQI2HXw8A/6H2ZaHz
         do2PP2kC3ssFADg5z2ZaSwZvF11uz0hClEVNx/rwIO/q8eJrBgxO1uxdc9hKm/8LsL1G
         5waP6mk5ysQsFz2FOa9GIth0OC5iqsnqEV3wu+2O4W5Fa/NJ5plciXHvxHh82TtZ10pX
         w4e+N9i7jMSvyvyzvEnZMScmzqSY49qYyPKI+bYIHEwGGYrhnOihdQcbbl0Xl+OKsoOr
         fmdw==
X-Gm-Message-State: ABuFfoib8uUiC9JcwP6dKSIP47UB4F3DvxUqSMrO+4U4Tz7p0GpABK4d
        uUMdAaDRiImoX3MCO1pjrvO0N1DtLX9fvkGMgyxTnQ==
X-Google-Smtp-Source: ACcGV61rZcV/sl16UHSzXGN1RY/zG0ZhML0NRmYQyx/uVwCLdF16Am1d6H4kcMV1B0nWSXm2T2EHCwfXFvQGsIsA814=
X-Received: by 2002:a62:1b45:: with SMTP id b66-v6mr8937084pfb.94.1538694748252;
 Thu, 04 Oct 2018 16:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181004023926.15847-1-natechancellor@gmail.com>
 <20181004024010.15986-1-natechancellor@gmail.com> <CAKwvOd=QdyNnTz19Vc6FSQfbKrFnvZ7VHYvhaMtfcNCKYm2Utg@mail.gmail.com>
 <20181004214713.GA7147@flashbox>
In-Reply-To: <20181004214713.GA7147@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 4 Oct 2018 16:12:17 -0700
Message-ID: <CAKwvOd=u=ysrQfEDEHgqHAEd8kATehoX56CJqp-LymCUv+hUtA@mail.gmail.com>
Subject: Re: [PATCH v2] spi: spi-ep93xx: Change dir type in ep93xx_spi_dma_{finish,prepare}
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 2:47 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Oct 04, 2018 at 02:32:48PM -0700, Nick Desaulniers wrote:
> > On Wed, Oct 3, 2018 at 7:41 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > Clang warns when one enumerated type is implicitly converted to another.
> > >
> > > drivers/spi/spi-ep93xx.c:342:62: warning: implicit conversion from
> > > enumeration type 'enum dma_transfer_direction' to different enumeration
> > > type 'enum dma_data_direction' [-Wenum-conversion]
> >
> > I'm just trying to think what this change would look like if this
> > driver ONLY used `enum dma_data_direction`?  There's an additional
>
> I can work up a proof of concept patch but it was kind of convoluted
> when I tried before this patch because dmaengine_prep_slave_sg and the
> direction member in struct dma_slave_config expect an enum of type
> dma_transfer_direction so there are two explicit casts needed and I
> thought there were one or two more places that it complained.

If you made the attempt already and found this to be a better
solution, I trust your judgement.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> This was the cleanest solution to me but I'm happy to rework it in any
> way that I need to.
>
> > warning in the header that a return value is messed up there, too:
> >
> > In file included from drivers/spi/spi-ep93xx.c:34:
> > ./include/linux/platform_data/dma-ep93xx.h:88:10: warning: implicit
> > conversion from
> >       enumeration type 'enum dma_data_direction' to different
> > enumeration type 'enum
> >       dma_transfer_direction' [-Wenum-conversion]
> >                 return DMA_NONE;
> >                 ~~~~~~ ^~~~~~~~
> >
>
> This is fixed in the dma tree and that function isn't used in this file:
> https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git/commit/?id=9524d6b265f9b2b9a61fceb2ee2ce1c2a83e39ca

Heh, I should have remembered!

>
> > >         nents = dma_map_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> > >                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > > ./include/linux/dma-mapping.h:428:58: note: expanded from macro
> > > 'dma_map_sg'
> > > #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
> > >                                ~~~~~~~~~~~~~~~~          ^
> > > drivers/spi/spi-ep93xx.c:348:57: warning: implicit conversion from
> > > enumeration type 'enum dma_transfer_direction' to different enumeration
> > > type 'enum dma_data_direction' [-Wenum-conversion]
> > >                 dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> > >                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > > ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> > > 'dma_unmap_sg'
> > > #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
> > >                                  ~~~~~~~~~~~~~~~~~~          ^
> > > drivers/spi/spi-ep93xx.c:377:56: warning: implicit conversion from
> > > enumeration type 'enum dma_transfer_direction' to different enumeration
> > > type 'enum dma_data_direction' [-Wenum-conversion]
> > >         dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> > >         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > > ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> > > 'dma_unmap_sg'
> > > #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
> > >                                  ~~~~~~~~~~~~~~~~~~          ^
> > > 3 warnings generated.
> > >
> > > dma_{,un}map_sg expects an enum of type dma_data_direction but this
> > > driver uses dma_transfer_direction for everything. Converting to
> > > dma_data_direction would be desirable but there are a few shared
> > > structures that expect dma_transfer_direction so it is just simpler to
> > > change the parameter here. dma_transfer_direction and dma_data_direction
> > > are different sizes but this driver only uses the 1 and 2 values which
> > > mean the same thing so this change is safe.
> > >
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >
> > > v1 -> v2:
> > >
> > > * Fix escaped hash symbols for '#define' lines
> > >
> > >  drivers/spi/spi-ep93xx.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
> > > index f1526757aaf6..189fc2225b69 100644
> > > --- a/drivers/spi/spi-ep93xx.c
> > > +++ b/drivers/spi/spi-ep93xx.c
> > > @@ -256,8 +256,7 @@ static int ep93xx_spi_read_write(struct spi_master *master)
> > >   * in case of failure.
> > >   */
> > >  static struct dma_async_tx_descriptor *
> > > -ep93xx_spi_dma_prepare(struct spi_master *master,
> > > -                      enum dma_transfer_direction dir)
> > > +ep93xx_spi_dma_prepare(struct spi_master *master, int dir)
> > >  {
> > >         struct ep93xx_spi *espi = spi_master_get_devdata(master);
> > >         struct spi_transfer *xfer = master->cur_msg->state;
> > > @@ -359,8 +358,7 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
> > >   * Function finishes with the DMA transfer. After this, the DMA buffer is
> > >   * unmapped.
> > >   */
> > > -static void ep93xx_spi_dma_finish(struct spi_master *master,
> > > -                                 enum dma_transfer_direction dir)
> > > +static void ep93xx_spi_dma_finish(struct spi_master *master, int dir)
> > >  {
> > >         struct ep93xx_spi *espi = spi_master_get_devdata(master);
> > >         struct dma_chan *chan;
> > > --
> > > 2.19.0
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
