Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859E0C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7B821736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngfPh64Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbfA1Hmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:42:55 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37648 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfA1Hmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:42:55 -0500
Received: by mail-vs1-f67.google.com with SMTP id n13so9210897vsk.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 23:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZbyE96CRCgdFPvGODiOIyvOer4HMQUmXNNaOYPHs80=;
        b=ngfPh64Yi5dQuPJKtsV6lh2UGg5on2SuwfissAZJqjBIGIjRlBswi/DVdq2b+S7ZdB
         A+CbwdG84QCJyF7zGiBX/PsLBdcfKsIIhDATBCwduH3k4kFa44p3In4qK9QSgkEZgYF3
         6KeeHikN55tAgQdkwltu4i0phbXGCjzvxLEs4FtD43unQFa6rpBTWq9Qh3L/XFZbbBkC
         wcHhrRyyQiwiaMqH0t5iL3ljYOLPj3RBlXqZgZiTbr74ZbtjWsqNGhA3/tiNcWihE/2M
         eLubdvIbwUSGE2cqLV1vPC0ajbtm8r42xzkciQUM7SEw1+fW1IySBSrhFc9DZpOCadA8
         wlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZbyE96CRCgdFPvGODiOIyvOer4HMQUmXNNaOYPHs80=;
        b=V5uJnow7G/k5O7E4mdqNruc6hDnnk60PRChwzimesmT/gmYIeuKtgmLIffh5/x/DIg
         MO+ixDgYaWiWi9VL6PWlK9y5QGCPj6EMvxcIsgNK/thGTgwdT2oaRCja9GSmsG/DMEql
         FEC2bMuY17x6LHZDUUJ6gwFwhs4gEPAL13Yo0mw58fg32sch3AhPvexLEIRJepg4AIRE
         /+n5QdC0K+OLiyp+PaWSXYWetvfaZ9zCbUmdBZfJ8lPvqo/nkkRLLDKU8ClrQmkn4pk8
         RD4FQI4DlpRUvqx/Kz9muwUipGsmCGJX2etsNp9vakADglz0TPnQsj9nDVIVgsjaTbAe
         ohkA==
X-Gm-Message-State: AJcUukf/lVUkjw96kLGLsVHr1p6VCDotI1cPU/ZzWx0EwCy4TDQNeNlf
        3+vcVZrwWj/BwsH7nS3ZINazhNSLsLBgLb2xkfWaJw==
X-Google-Smtp-Source: ALg8bN7y9dvKfqtShZ8lYl0u0GThhDEnp75T97BxEIT2YHaJkedpQFm07SkTfRx4JzRq6bFih4HK4rn3fe6Q0b7MQDQ=
X-Received: by 2002:a67:784e:: with SMTP id t75mr7767444vsc.236.1548661373622;
 Sun, 27 Jan 2019 23:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <20190123000057.31477-4-oded.gabbay@gmail.com>
 <20190123122817.GB4747@rapoport-lnx> <CAFCwf12KD2gynDF2GfXrLF9ivZnWN6QGwdAZryBPupr2=QB8Fw@mail.gmail.com>
 <20190127063914.GA16853@rapoport-lnx>
In-Reply-To: <20190127063914.GA16853@rapoport-lnx>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 28 Jan 2019 09:44:25 +0200
Message-ID: <CAFCwf122HnnhymBB55LK_zOxDwPe4jKMiMw9gGznsMG2N=U5OA@mail.gmail.com>
Subject: Re: [PATCH 03/15] habanalabs: add basic Goya support
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 8:39 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Fri, Jan 25, 2019 at 10:32:55PM +0200, Oded Gabbay wrote:
> > On Wed, Jan 23, 2019 at 2:28 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >
> > > On Wed, Jan 23, 2019 at 02:00:45AM +0200, Oded Gabbay wrote:
> > > > This patch adds a basic support for the Goya device. The code initializes
> > > > the device's PCI controller and PCI bars. It also initializes various S/W
> > > > structures and adds some basic helper functions.
> > > >
> > > > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > > > ---
> > > >  drivers/misc/habanalabs/Makefile            |   5 +-
> > > >  drivers/misc/habanalabs/device.c            |  71 +++
> > > >  drivers/misc/habanalabs/goya/Makefile       |   3 +
> > > >  drivers/misc/habanalabs/goya/goya.c         | 633 ++++++++++++++++++++
> > > >  drivers/misc/habanalabs/goya/goyaP.h        | 125 ++++
> > > >  drivers/misc/habanalabs/habanalabs.h        | 131 ++++
> > > >  drivers/misc/habanalabs/habanalabs_drv.c    |   3 +
> > > >  drivers/misc/habanalabs/include/goya/goya.h | 115 ++++
> > > >  8 files changed, 1085 insertions(+), 1 deletion(-)
> > > >  create mode 100644 drivers/misc/habanalabs/goya/Makefile
> > > >  create mode 100644 drivers/misc/habanalabs/goya/goya.c
> > > >  create mode 100644 drivers/misc/habanalabs/goya/goyaP.h
> > > >  create mode 100644 drivers/misc/habanalabs/include/goya/goya.h
>
> [ ... ]
>
> > > > +
> > > > +/**
> > > > + * goya_sw_init - Goya software initialization code
> > > > + *
> > > > + * @hdev: pointer to hl_device structure
> > > > + *
> > > > + */
> > > > +static int goya_sw_init(struct hl_device *hdev)
> > > > +{
> > > > +     struct goya_device *goya;
> > > > +     int rc;
> > > > +
> > > > +     /* Allocate device structure */
> > > > +     goya = kzalloc(sizeof(*goya), GFP_KERNEL);
> > >
> > > Consider using devm_k[mz]alloc() for memory allocations throughout the
> > > driver. I didn't check all the spots where it can be applicable.
> > I honestly wasn't aware of that. We never used that in AMD drivers
> > (which where I spent most of my kernel time).
> > I'll look into that offline but for now I don't really want to change
> > into it blindly in all locations, unless there is some hard kernel
> > rule for using that in drivers.
>
> AFAIK, there's no such rule. It's just supposed to make driver
> developer/maintainer life easier ;-)
>
> > >
> > > > +     if (!goya)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     /* according to goya_init_iatu */
> > > > +     goya->ddr_bar_cur_addr = DRAM_PHYS_BASE;
> > > > +     hdev->asic_specific = goya;
> > > > +
> > > > +     /* Create DMA pool for small allocations */
> > > > +     hdev->dma_pool = dma_pool_create(dev_name(hdev->dev),
> > > > +                     &hdev->pdev->dev, GOYA_DMA_POOL_BLK_SIZE, 8, 0);
> > > > +     if (!hdev->dma_pool) {
> > > > +             dev_err(hdev->dev, "failed to create DMA pool\n");
> > > > +             rc = -ENOMEM;
> > > > +             goto free_goya_device;
> > > > +     }
> > > > +
>
> [ ... ]
>
> > > > +
> > > > +static const struct hl_asic_funcs goya_funcs = {
> > > > +     .early_init = goya_early_init,
> > > > +     .early_fini = goya_early_fini,
> > > > +     .sw_init = goya_sw_init,
> > > > +     .sw_fini = goya_sw_fini,
> > > > +     .suspend = goya_suspend,
> > > > +     .resume = goya_resume,
> > > > +     .dma_alloc_coherent = goya_dma_alloc_coherent,
> > > > +     .dma_free_coherent = goya_dma_free_coherent,
> > >
> > > Is there any additional functionality that is planned in goya or gaudi in
> > > these two functions?
> > > It seems like they are not really needed, at least at the moment and for
> > > sure that don't need to be part of ASIC ops.
> >
> > So this relates to the simulator support, because there the
> > implementation of these two functions is totally different as I don't
> > have pci device.
>
> Can you please add a comment about it here?
Of course, done.
Thanks,
Oded

>
> --
> Sincerely yours,
> Mike.
>
