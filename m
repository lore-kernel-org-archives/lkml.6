Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE1CC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53164216FA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCfKeKo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53164216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbeI1Nd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:33:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52694 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeI1Ndz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:33:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so796246wmw.2;
        Fri, 28 Sep 2018 00:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=qQ8TbzZiFZ7lvQBm0XTQUB+HtYV4NxETXRNqnH6EQCg=;
        b=XCfKeKo7KdL0vfZ5Yu0E1xOJqsP1dBchuyHQ0KSmnWRAwEt8mnNeCQCu5cuXusLgIe
         qBEOG2S3432fHm4Aek1OxXP4z1LjUsAFsTDwVWKPyq7GV7xtoupMhXubu+KOZ5rbyk29
         QgPkmqohZnVzr03WYn6fnk5St3agScuB47rwwAtGE6162jtOESyHqWT1Hnx9oTyhWVRm
         WXpVVBhUF2VLXEYPFEfpw7f869JhyTd2maWSoq5c+j+ghQnLkueIMXQbUoISSZ1hAbQy
         Zg+EgCqABUz04byIGdi5frhzOn8p/ve3w3quOIMSX6fkkMUBEinf+dOI8dkAg++/UtpX
         ordw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=qQ8TbzZiFZ7lvQBm0XTQUB+HtYV4NxETXRNqnH6EQCg=;
        b=mu2tjWpaTAEVH3JcR7zDmIPVB7LK0XHLsShN/G4mhk5SQ4NjgOS1TQ0vjb1GHYnuRh
         IGNaijvyg6fwS+qVAugpn8e4l+lOScrk4aQSyqdfB1CbgaBE4WhmCIdbriPGYC/XVzGR
         aGPpaaa/J1oFwc9DfAOaQ1VMUjZyy9ROxFjqdcH1JQrn8fGFb2fDo02gl2lHP2K4JtvY
         Len7dcocWDkCmeFbFrTlFbl1QWQNmcZdkQLHpv47pUqAzt9Z7U6fwXI2/A0Fj/ZddCzI
         Bh9rlFV9Yi82YpE42VeHDUzymRZGMqHHlyKVAEda3AsuYjkHWrkRH9ked4o61eIEPO6M
         gQFQ==
X-Gm-Message-State: ABuFfoh7/Iz1fSHOkZ3NGgT66EIT118ppC+TJO+bs6nfqnpke1yTVvk7
        +TbzgHc39OpfET2Ri8gpCnY+gN9IbkPxBPaeUj0=
X-Google-Smtp-Source: ACcGV61B2FxprzY0ytjMHv44lsZiHBN8xvAbO+9A4x1rSkUwV9d+CVgBjxvgHOH8l7jsSBk1f6CN79Pf1A9YJxBR1TM=
X-Received: by 2002:a1c:1f50:: with SMTP id f77-v6mr757189wmf.52.1538118693062;
 Fri, 28 Sep 2018 00:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180907062502.8241-1-andrea.merello@gmail.com>
 <20180907062502.8241-2-andrea.merello@gmail.com> <20180918162105.GC2613@vkoul-mobl>
In-Reply-To: <20180918162105.GC2613@vkoul-mobl>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Fri, 28 Sep 2018 09:11:19 +0200
Message-ID: <CAN8YU5PWB0sRskcirCcYnY5vG5A_W6pcOMpgyOD3faWfMeu5Rg@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] dmaengine: xilinx_dma: in axidma slave_sg and
 dma_cyclic mode align split descriptors
To:     Vinod <vkoul@kernel.org>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 6:21 PM Vinod <vkoul@kernel.org> wrote:
>
> On 07-09-18, 08:24, Andrea Merello wrote:
> > Whenever a single or cyclic transaction is prepared, the driver
> > could eventually split it over several SG descriptors in order
> > to deal with the HW maximum transfer length.
> >
> > This could end up in DMA operations starting from a misaligned
> > address. This seems fatal for the HW if DRE (Data Realignment Engine)
> > is not enabled.
> >
> > This patch eventually adjusts the transfer size in order to make sure
> > all operations start from an aligned address.
> >
> > Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> > Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > ---
> > Changes in v2:
> >         - don't introduce copy_mask field, rather rely on already-esistent
> >           copy_align field. Suggested by Radhey Shyam Pandey
> >         - reword title
> > Changes in v3:
> >       - fix bug introduced in v2: wrong copy size when DRE is enabled
> >       - use implementation suggested by Radhey Shyam Pandey
> > Changes in v4:
> >       - rework on the top of 1/6
> > Changes in v5:
> >       - fix typo in commit title
> >       - add hint about "DRE" meaning in commit message
> > ---
> >  drivers/dma/xilinx/xilinx_dma.c | 22 ++++++++++++++++++----
> >  1 file changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> > index a3aaa0e34cc7..aaa6de8a70e4 100644
> > --- a/drivers/dma/xilinx/xilinx_dma.c
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -954,15 +954,28 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
> >
> >  /**
> >   * xilinx_dma_calc_copysize - Calculate the amount of data to copy
> > + * @chan: Driver specific DMA channel
> >   * @size: Total data that needs to be copied
> >   * @done: Amount of data that has been already copied
> >   *
> >   * Return: Amount of data that has to be copied
> >   */
> > -static int xilinx_dma_calc_copysize(int size, int done)
> > +static int xilinx_dma_calc_copysize(struct xilinx_dma_chan *chan,
> > +                                 int size, int done)
>
> align to preceeding line opening brace please

After applying, I'm seeing it already aligned as you requested; 4 tabs
+ 4 spaces so the 2nd line starts right under the "s" near the opened
brace..
Patch sent using git, so it should pass through without being ruined;
don't know why you see it misaligned :(

> >  {
> > -     return min_t(size_t, size - done,
> > +     size_t copy = min_t(size_t, size - done,
> >                    XILINX_DMA_MAX_TRANS_LEN);
>
> so we can do this way in patch 1:
>
>         size t copy;
>
>         copy =  min_t(size_t, size - done,
>                       XILINX_DMA_MAX_TRANS_LEN);
>
>         return copy;
>
> and then add these here, feels like we are redoing change introduced in
> patch 1..

OK, this sounds good :)

>
> > +     if ((copy + done < size) &&
> > +         chan->xdev->common.copy_align) {
> > +             /*
> > +              * If this is not the last descriptor, make sure
> > +              * the next one will be properly aligned
> > +              */
> > +             copy = rounddown(copy,
> > +                              (1 << chan->xdev->common.copy_align));
> > +     }
> > +     return copy;
> >  }
> >
> >  /**
> > @@ -1804,7 +1817,7 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
> >                        * Calculate the maximum number of bytes to transfer,
> >                        * making sure it is less than the hw limit
> >                        */
> > -                     copy = xilinx_dma_calc_copysize(sg_dma_len(sg),
> > +                     copy = xilinx_dma_calc_copysize(chan, sg_dma_len(sg),
>
> why not keep chan in patch 1 and add only handling in patch 2, seems
> less churn to me..

Indeed this was something I was unsure about.. I ended up in feeling
better not to add introduce a function that takes an unused (yet)
argument, but I can change this of course :)

> --
> ~Vinod
