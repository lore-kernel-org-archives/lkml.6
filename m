Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B66C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF122086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaW/Xtkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF122086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeH2MIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:08:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52371 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbeH2MIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:08:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id y139-v6so4283653wmc.2;
        Wed, 29 Aug 2018 01:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=+X4vZrOUG9VHHivnmMqXxW5mUMhb8mSo6pBXuDSjZU4=;
        b=HaW/XtkpgB2lcl4YDhc7adJ88Ff/MF+5VsWo7ZKb7q+4LO72Mmc2woRaDMfgRLLCHU
         GuVejlKLl02eZuRRQ6nXIcuaNxojApw2dqQsRue+pNafNCJxC4WfScXkwISBDIqN03NA
         lkb9jer7Ft5SnAdTXpBAVjbEISe3Aw6EA87Lf4indVD6tSBPjV23FvbJFvyetFvaaDKu
         vIsraXAPwNA7p5Y2X6mMSRvHQ5PEnDKQEZCraNddX30v5Z5MCAnvpTuDk79DZyPvFpQu
         CO4n5fxKrcCPW9mJfdLwx9q3ySZhXTAoOLoh8KKJHl8F7etNp0GCk7GKn563SjrNjpnf
         n28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=+X4vZrOUG9VHHivnmMqXxW5mUMhb8mSo6pBXuDSjZU4=;
        b=CUHNlsH4pHzQjfct96cMT+13hhp+jvoRaGndXpbX9DBkrigTRkZvl+BShwA8QkwgkB
         T3R9/ZU7DW3+0HQg+Q4h14MhgURFV/xt3MRrbuXiJ/38YEwnFD6/zlEYblc1EQOHCxOs
         9w8L2rZJSOAMh3z1vaeZZahhkG0VR4r5FScmQSHepTk9Bhq//kvFPLh6BYqCf2nrUaX8
         TduoKo3VfmplnJURr8mqI9zbMAMyBrgW7f4YUve74u1QeDG3IRfLl9V15vbfVvelihXI
         zj/qVp+OrZ943PRllMY1mndBw4pbD/wl6UOtP0TgmPXHswTdacUVoK4r4NePmr4MU/H7
         mqAA==
X-Gm-Message-State: APzg51DuiIKXbExK+f2gxrohgcVZOASZ4mlzrNL5dgdxXA1v5/jHsvel
        7pscFTNxe8zc5v/A7Gx1dGDOtI0+jwNC1i5Qju8=
X-Google-Smtp-Source: ANB0VdbC+FHA3IlMevZ+1WhLxeI0h6+XpTKthsxKl0wKhW3OWEigw0GQ9ppUb+3qh2ml8GqNa2r/ZRhb7KagEM+8FSE=
X-Received: by 2002:a1c:4c0e:: with SMTP id z14-v6mr3729433wmf.89.1535530339092;
 Wed, 29 Aug 2018 01:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180802141012.19970-1-andrea.merello@gmail.com>
 <20180802141012.19970-2-andrea.merello@gmail.com> <20180827053002.GT2388@vkoul-mobl>
In-Reply-To: <20180827053002.GT2388@vkoul-mobl>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Wed, 29 Aug 2018 10:12:06 +0200
Message-ID: <CAN8YU5MOdz_sW06B8yc_kewjsxP0DP5pgB2bSu=vkNG-ezvMpQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] dmaengine: xilinx_dma: in axidma slave_sg and
 dma_cylic mode align split descriptors
To:     Vinod <vkoul@kernel.org>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        v4-000linux-arm-kernel@lists.infradead.org,
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

On Mon, Aug 27, 2018 at 7:30 AM Vinod <vkoul@kernel.org> wrote:
>
> On 02-08-18, 16:10, Andrea Merello wrote:
>
> s/cylic/cyclic in patch title

OK

> > Whenever a single or cyclic transaction is prepared, the driver
> > could eventually split it over several SG descriptors in order
> > to deal with the HW maximum transfer length.
> >
> > This could end up in DMA operations starting from a misaligned
> > address. This seems fatal for the HW if DRE is not enabled.
>
> DRE?

Stands for "Data Realignment Engine". I will add this string nearby
the acronym..

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
> please align with opening brace

OK

> >  {
> > -     return min_t(size_t, size - done,
> > +     size_t copy = min_t(size_t, size - done,
> >                    XILINX_DMA_MAX_TRANS_LEN);
> > +
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
> >                                                       sg_used);
> >                       hw = &segment->hw;
> >
> > @@ -1909,7 +1922,8 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
> >                        * Calculate the maximum number of bytes to transfer,
> >                        * making sure it is less than the hw limit
> >                        */
> > -                     copy = xilinx_dma_calc_copysize(period_len, sg_used);
> > +                     copy = xilinx_dma_calc_copysize(chan,
> > +                                                     period_len, sg_used);
> >                       hw = &segment->hw;
> >                       xilinx_axidma_buf(chan, hw, buf_addr, sg_used,
> >                                         period_len * i);
> > --
> > 2.17.1
>
> --
> ~Vinod
