Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9A0C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BCB20684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD5IMmRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BCB20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeJDW6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:58:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45683 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbeJDW6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:58:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id q5-v6so10509241wrw.12;
        Thu, 04 Oct 2018 09:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+qnVS5rZWpoIDbGEx8hHC64AmAF7kGN+Fcxgm5I/sbQ=;
        b=MD5IMmRjdSwIbAU5P/2o86+ZpdeMy2/wxUcpO/brmw/MRP8tKQXNML6PFdrce/sRQU
         nygT09suQ8VVX1HJEn+tps3EQMO3NMyga0zhBCjrTlBZLPWabc/UYqMBGy9Gw4LGTxe2
         DdewHsZezgFGtDRyuAffYaRRmjwm+XKSdkyqUdIXwZFrxV3yW+MqFnI2WKK5BvG/2fbv
         l6B1FxSqD2HugUX2whOZxErpTmYjjW8PC24iNjWkqIXGqYR0WXpH+nNzpzWJgBmvYsrW
         kMmZTgB5XK2/FyDZQZkqmRTXnDTea5WAN3SUQE0dBra4/qmhBZCTn3Ykl1DtdILXWJWp
         gZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+qnVS5rZWpoIDbGEx8hHC64AmAF7kGN+Fcxgm5I/sbQ=;
        b=N3qiunw1tB88qGnEMH8PiDJi3H0o1yZMRfVefDyZGjrmDKBQtql+vspBa1iXSILqs9
         yAX8VPVKJxZ7LOFmW+w6LzPZhj5qLeC33Emgj41sCIvOObW0knYMzTC5ujWM60Nicj7f
         BjOsuxO/O/U2vty3N3d2kZP7FOEH9soFX1kZ0sdD3WIQUKB1yEsvSoGbI9i0PBPrkGUx
         HNLStSHIjr3oQz4Y7+WU4d75Js8FrS7Kwvap6hvnJmvNWOdF4GSsjTselIsoC/391NuN
         Ne0Zt7l6CJC3WQWiD8/UlmRBM3xkCr0OGJSRi8zaS8r/UHIB0ksDmG2Q2wwbHW1xV0ZN
         HMJA==
X-Gm-Message-State: ABuFfohgpIngFzKChxyaVOjAC8fxdF/Bgwa4GhxVtfgTPtNOG7nTwm5O
        5wObT7sxHge8Q6NjjErV/r9uZeF0IT0vIQ==
X-Google-Smtp-Source: ACcGV61gGCgL7B9TNJxo/LlGYJjrRvcnmYTGZrANDV/3gEc+a9tTTMu1of4IOKZe12B2F8EgTMFFFQ==
X-Received: by 2002:adf:fc0b:: with SMTP id i11-v6mr5752507wrr.9.1538669074405;
        Thu, 04 Oct 2018 09:04:34 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id k93-v6sm7313850wrc.89.2018.10.04.09.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 09:04:33 -0700 (PDT)
Date:   Thu, 4 Oct 2018 09:04:32 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        H Hartley Sweeten <hartleys@visionengravers.com>,
        Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH] spi: spi-ep93xx: Change dir type in
 ep93xx_spi_dma_{finish,prepare}
Message-ID: <20181004160432.GA7674@flashbox>
References: <20181004023926.15847-1-natechancellor@gmail.com>
 <20181004103247.GC6412@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004103247.GC6412@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 11:32:47AM +0100, Mark Brown wrote:
> On Wed, Oct 03, 2018 at 07:39:26PM -0700, Nathan Chancellor wrote:
> > Clang warns when one enumerated type is implicitly converted to another.
> > 
> > drivers/spi/spi-ep93xx.c:342:62: warning: implicit conversion from
> > enumeration type 'enum dma_transfer_direction' to different enumeration
> 
> Please remember to CC driver maintainers and authors on patch
> submissions so they can review things, copying in Hartley and Mika.
> 

Hi Mark,

Thank you for that, I usually just rely on get_maintainer.pl but I'll be
better about looking at git history for major patch authors as well.

$ ./scripts/get_maintainer.pl drivers/spi/spi-ep93xx.c
Mark Brown <broonie@kernel.org> (maintainer:SPI SUBSYSTEM)
linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

Nathan

> > type 'enum dma_data_direction' [-Wenum-conversion]
> >         nents = dma_map_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> >                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > ./include/linux/dma-mapping.h:428:58: note: expanded from macro
> > 'dma_map_sg'
> > \#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
> >                                ~~~~~~~~~~~~~~~~          ^
> > drivers/spi/spi-ep93xx.c:348:57: warning: implicit conversion from
> > enumeration type 'enum dma_transfer_direction' to different enumeration
> > type 'enum dma_data_direction' [-Wenum-conversion]
> >                 dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> >                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> > 'dma_unmap_sg'
> > \#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
> >                                  ~~~~~~~~~~~~~~~~~~          ^
> > drivers/spi/spi-ep93xx.c:377:56: warning: implicit conversion from
> > enumeration type 'enum dma_transfer_direction' to different enumeration
> > type 'enum dma_data_direction' [-Wenum-conversion]
> >         dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> >         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> > 'dma_unmap_sg'
> > \#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
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
> > -		       enum dma_transfer_direction dir)
> > +ep93xx_spi_dma_prepare(struct spi_master *master, int dir)
> >  {
> >  	struct ep93xx_spi *espi = spi_master_get_devdata(master);
> >  	struct spi_transfer *xfer = master->cur_msg->state;
> > @@ -359,8 +358,7 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
> >   * Function finishes with the DMA transfer. After this, the DMA buffer is
> >   * unmapped.
> >   */
> > -static void ep93xx_spi_dma_finish(struct spi_master *master,
> > -				  enum dma_transfer_direction dir)
> > +static void ep93xx_spi_dma_finish(struct spi_master *master, int dir)
> >  {
> >  	struct ep93xx_spi *espi = spi_master_get_devdata(master);
> >  	struct dma_chan *chan;
> > -- 
> > 2.19.0
> > 


