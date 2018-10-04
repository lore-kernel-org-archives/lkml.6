Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376A4C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59E621486
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fS66JJ99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59E621486
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeJDXfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:35:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46740 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbeJDXfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:35:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id a5-v6so3390366pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 09:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cG+8K4AcGWPOGFlBSxi/jeixC5gtDYnznDZQgwJAq94=;
        b=fS66JJ99JMmSF04SETwWLmxiial6tC8fPRA2mMae2V3GGkls0vxDEKw6422Br1gybN
         KMFmBR6dD5CCSURMGz9jF+wdKe42vYlcR3ZhkNjpGuiyQS3v8DGwoJP+mj3NvkPt5nNv
         iiqyPEcBr55mumAvklAaiLIMa3ztoDrEK9jPZLVMg688xP7lJYSyxZMWDh615l9FZBBH
         Bk+b5vMQX4RyLRNsfcNi1rlMOZmfKMlWsZYgzFvJgvkMHuRljjl8lld61nR3SPEONeMo
         oHTPIQFJsjA5VXpgAOAbzXWPhZrvNoWYE2DZmuCTmx8yBNaMv3QCDmyGvMjmqaNHunq2
         tuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cG+8K4AcGWPOGFlBSxi/jeixC5gtDYnznDZQgwJAq94=;
        b=BLbodl556YIISbQuvWTEAC6v/S8O5PqCgXNIXl72qaiMPId7qSSSe9XOdVVsmrPNaJ
         xP3s4vl6dgboZbzNQOQOs6zxte7Db8BAr1Umv3dIMvQE+PQRWpJdHThsmItY3Zo9qm8+
         GH5Oap8K1/sAK51FW5nPqDXJwO8630MTZ1keOpAs3aCtXHVCGXbbWgakreIFX8ep6hcT
         I6JoJhelRxlxOeXsfAu8d0rgz4owB5mDqGVwHvtsLT3GEq3usoMUg/Ak+dLPrynwbbsz
         AyDROYbhctQqDhpE9feRjE5MWeFw0m/jviTBJvX/QFfnYjCb/VeKSJnnt0M7Tygs58BT
         twSg==
X-Gm-Message-State: ABuFfoghi8wYLmJYPj84vwhj/dgBbbCNrhEae4OgqrtRrvHvoLdcKsDY
        SoV6qBozCsaWsSBYMjAK2p348GUd+TuzIzNPblOfYQ==
X-Google-Smtp-Source: ACcGV63KZECTWlovLRxkiEboOphc+2JpbAmWpJIAOWjbDrQkcjeRuq0ChqLwPn1JgY7IsND6ZwVEhgbIrrXzZm+uxKM=
X-Received: by 2002:a63:9e02:: with SMTP id s2-v6mr1957700pgd.302.1538671291737;
 Thu, 04 Oct 2018 09:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181004023926.15847-1-natechancellor@gmail.com>
 <20181004103247.GC6412@sirena.org.uk> <20181004160432.GA7674@flashbox>
In-Reply-To: <20181004160432.GA7674@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 4 Oct 2018 09:41:20 -0700
Message-ID: <CAKwvOd=bZWsgggLMODN0OPSu=c=pQZsREvTtNcUn+arEEVJQjQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-ep93xx: Change dir type in ep93xx_spi_dma_{finish,prepare}
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        hartleys@visionengravers.com, mika.westerberg@iki.fi,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 9:04 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Oct 04, 2018 at 11:32:47AM +0100, Mark Brown wrote:
> > On Wed, Oct 03, 2018 at 07:39:26PM -0700, Nathan Chancellor wrote:
> > > Clang warns when one enumerated type is implicitly converted to another.
> > >
> > > drivers/spi/spi-ep93xx.c:342:62: warning: implicit conversion from
> > > enumeration type 'enum dma_transfer_direction' to different enumeration
> >
> > Please remember to CC driver maintainers and authors on patch
> > submissions so they can review things, copying in Hartley and Mika.
> >
>
> Hi Mark,
>
> Thank you for that, I usually just rely on get_maintainer.pl but I'll be

If get_maintainer.pl doesn't cc the right person, does that signal
that the MAINTAINERS file has some omissions?

> better about looking at git history for major patch authors as well.
>
> $ ./scripts/get_maintainer.pl drivers/spi/spi-ep93xx.c
> Mark Brown <broonie@kernel.org> (maintainer:SPI SUBSYSTEM)
> linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM)
> linux-kernel@vger.kernel.org (open list)
>
> Nathan
>
> > > type 'enum dma_data_direction' [-Wenum-conversion]
> > >         nents = dma_map_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> > >                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > > ./include/linux/dma-mapping.h:428:58: note: expanded from macro
> > > 'dma_map_sg'
> > > \#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
> > >                                ~~~~~~~~~~~~~~~~          ^
> > > drivers/spi/spi-ep93xx.c:348:57: warning: implicit conversion from
> > > enumeration type 'enum dma_transfer_direction' to different enumeration
> > > type 'enum dma_data_direction' [-Wenum-conversion]
> > >                 dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> > >                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > > ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> > > 'dma_unmap_sg'
> > > \#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
> > >                                  ~~~~~~~~~~~~~~~~~~          ^
> > > drivers/spi/spi-ep93xx.c:377:56: warning: implicit conversion from
> > > enumeration type 'enum dma_transfer_direction' to different enumeration
> > > type 'enum dma_data_direction' [-Wenum-conversion]
> > >         dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> > >         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > > ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> > > 'dma_unmap_sg'
> > > \#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
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
> > > -                  enum dma_transfer_direction dir)
> > > +ep93xx_spi_dma_prepare(struct spi_master *master, int dir)
> > >  {
> > >     struct ep93xx_spi *espi = spi_master_get_devdata(master);
> > >     struct spi_transfer *xfer = master->cur_msg->state;
> > > @@ -359,8 +358,7 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
> > >   * Function finishes with the DMA transfer. After this, the DMA buffer is
> > >   * unmapped.
> > >   */
> > > -static void ep93xx_spi_dma_finish(struct spi_master *master,
> > > -                             enum dma_transfer_direction dir)
> > > +static void ep93xx_spi_dma_finish(struct spi_master *master, int dir)
> > >  {
> > >     struct ep93xx_spi *espi = spi_master_get_devdata(master);
> > >     struct dma_chan *chan;
> > > --
> > > 2.19.0
> > >
>
>


-- 
Thanks,
~Nick Desaulniers
