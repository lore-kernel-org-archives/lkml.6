Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C016EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611B520877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3jhZwnr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611B520877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbeIYNk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:40:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43687 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeIYNk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:40:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id z14-v6so4671704wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 00:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SYzaivaxN5WQlVQnqeMeza2jx3DbfWpiFmaeIlU+Ne4=;
        b=J3jhZwnrZ9AzCpJPkyYtyHcSPTs+Wr/O3YT9fU6EoJhpG+vAZxsNq/PrQDUdMgfXY9
         Zy1KCJVdCYy29hPzdIkQFO49yWItZYupHLdwzvLCvOGwMDdFBODVaXlOWqPF83WxDbUo
         cC9CZFu9Bjg6DUbFQ6A5ztfDc5hVQJgGI/m3HVBZ+lUr3VTzq6IN3m3l0jPXdmQ6Yo+r
         LSnlPTDuKOfVjloDUbFyZihoA4ly19OhrCbOJ8zQauNSOV/pOdTvXN60v9KijDDCtkMq
         kjtrxadpFAqEinT0KejugT4Z2Tn2A/QojvrV1BeofkkTYAGPYJp49Y6opxv3y2Q1FgcR
         iJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SYzaivaxN5WQlVQnqeMeza2jx3DbfWpiFmaeIlU+Ne4=;
        b=hojuOHmToJp0cVaDQ1pR1thGBaQgLncuWn+ctyUUiZxWz/O1NqqButQOrvtFfudoHe
         vNm3u9usRzJF2rqOSzzQEum7sPWkwlwLMC1EdcgDQgR/46d9sy52NI1RWlqrvJxeiyt4
         yfw/TlyQw9Iq6L2ZnbmZ9tYJSIWwB9RJdJv91la3HSt4bmGLstaLl6sXTNJqIfsiMIe4
         wpu37w45/NW3L1omOHWFR56h20NE9e71272WVbJGXdh5TujG9H5xgAEGGVhQtRbIhYuP
         LqdBrzL/OPEqXwf+OwS+6RCyLCLH0SEgctVbLQSk/JiUCB/uFdovKeA3OkupI/BSHs37
         HhCA==
X-Gm-Message-State: ABuFfoihnJT8HiaTn6uDOtADofYf+1Swd//R6BgPmH+EBw5geKuakVb/
        Pw3xMdIzBZgHKdL2Df34wvE=
X-Google-Smtp-Source: ACcGV60r5jZpmvT0NW+ZstzU/bkjW6HrM3tPg0qVMZkbc6c7RNggEFhxRBXHzyy7oQYjsQ8duM9UNg==
X-Received: by 2002:adf:fa0f:: with SMTP id m15-v6mr1781544wrr.155.1537860881155;
        Tue, 25 Sep 2018 00:34:41 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id x132-v6sm435996wmg.3.2018.09.25.00.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 00:34:40 -0700 (PDT)
Date:   Tue, 25 Sep 2018 00:34:38 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: cadence-quadspi: Use proper enum for
 dma_unmap_single
Message-ID: <20180925073438.GA24068@flashbox>
References: <20180921102944.27968-1-natechancellor@gmail.com>
 <5e1d2e30-764f-f3a9-d0c1-7a6c81f296b7@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e1d2e30-764f-f3a9-d0c1-7a6c81f296b7@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 10:24:04AM +0300, Tudor Ambarus wrote:
> Hi, Nathan,
> 
> On 09/21/2018 01:29 PM, Nathan Chancellor wrote:
> > Clang warns when one enumerated type is converted implicitly to another.
> > 
> > drivers/mtd/spi-nor/cadence-quadspi.c:962:47: warning: implicit
> > conversion from enumeration type 'enum dma_transfer_direction' to
> > different enumeration type 'enum dma_data_direction' [-Wenum-conversion]
> >         dma_dst = dma_map_single(nor->dev, buf, len, DMA_DEV_TO_MEM);
> >                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
> > ./include/linux/dma-mapping.h:428:66: note: expanded from macro
> > 'dma_map_single'
> > #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
> >                                    ~~~~~~~~~~~~~~~~~~~~          ^
> > drivers/mtd/spi-nor/cadence-quadspi.c:997:43: warning: implicit
> > conversion from enumeration type 'enum dma_transfer_direction' to
> > different enumeration type 'enum dma_data_direction' [-Wenum-conversion]
> >         dma_unmap_single(nor->dev, dma_dst, len, DMA_DEV_TO_MEM);
> >         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
> > ./include/linux/dma-mapping.h:429:70: note: expanded from macro
> > 'dma_unmap_single'
> > #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
> >                                      ~~~~~~~~~~~~~~~~~~~~~~          ^
> > 2 warnings generated.
> > 
> > Use the proper enums from dma_data_direction to satisfy Clang.
> > 
> > DMA_TO_DEVICE = DMA_MEM_TO_DEV = 1
> > DMA_FROM_DEVICE = DMA_DEV_TO_MEM = 2
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/108
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/mtd/spi-nor/cadence-quadspi.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> > index 8e714fbfa521..d0e57ac81098 100644
> > --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> > +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> > @@ -959,7 +959,7 @@ static int cqspi_direct_read_execute(struct spi_nor *nor, u_char *buf,
> >  		return 0;
> >  	}
> >  
> > -	dma_dst = dma_map_single(nor->dev, buf, len, DMA_DEV_TO_MEM);
> > +	dma_dst = dma_map_single(nor->dev, buf, len, DMA_FROM_DEVICE);
> >  	if (dma_mapping_error(nor->dev, dma_dst)) {
> >  		dev_err(nor->dev, "dma mapping failed\n");
> >  		return -ENOMEM;
> > @@ -994,7 +994,7 @@ static int cqspi_direct_read_execute(struct spi_nor *nor, u_char *buf,
> >  	}
> >  
> >  err_unmap:
> > -	dma_unmap_single(nor->dev, dma_dst, len, DMA_DEV_TO_MEM);
> > +	dma_unmap_single(nor->dev, dma_dst, len, DMA_TO_DEVICE);
> 
> Should have used DMA_FROM_DEVICE, as you did above. Otherwise looks good.
> 
> Cheers,
> ta

Thank you very much for catching this, did several of these conversions
back to back and didn't look closely at this. I just sent a v2, I
appreciate the review!

Nathan
