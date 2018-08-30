Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57004C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE88720833
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiTeg2F3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE88720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeH3MNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:13:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45582 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbeH3MNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:13:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id 20-v6so7150170wrb.12;
        Thu, 30 Aug 2018 01:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=3VNLdh7QXtTrgJyjONcX0dBm0Z+fMHI5cOfsralCGPY=;
        b=HiTeg2F3XZlXQG9aR7y36X9atXlowWvgg0cVIKdwalJU6TS///uFrbUphO1n7wiUwd
         9gJx+bJM31nqpVWctRAjuieP8lZx3U9wegl/XFJRB26SxepPedpQo2HBKwnheWLEx7TI
         tE5TIxAu3MfvaeJJDGNKLqS232KEFqOe2OjRW2tqJPr+xkK5mtd8PTJxNPKg12Wsy3i+
         SDcx6Wq4a/S3udS2VX6zmKJhTlCNdl4XZbC1yhNkRsnza9RDvjn63hLh7T2tcYiKGkhb
         YgaABBf+pUXyJSGbcpuB6vnEykvSSEymv5uhJB16tZ0kAQV4/B60nna3/hn8rNOeBcLL
         7/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=3VNLdh7QXtTrgJyjONcX0dBm0Z+fMHI5cOfsralCGPY=;
        b=IPGZBcd+vwoPg2/C627ccHoi2hl++0DOuTs/9YoOH4YianJfRUCwNF/KoHlrI6MLya
         0KYqRBotSrDtq7a2zN+xwNn+QXaMNBvmmqhWo27VfJQjQ6fP6iDud0iJWfISSxiLYj2q
         nHPpUKy8yrFe0FvaJ+NtaqMILshWVWGMg267RM0J3m2BEDQeVkM6kXYbL+Af7v372rBU
         0ohjS87qGTscFsxyr4c0XzY4QUrAGPTvvR40VeBTkYJEuqtjPQP+5zkX3c+DfoGSImtD
         rolQdg3gq0sENb+HX3GiaEvzbGvImT9Ce0+7cAlGLud7tQA4SQZO+jxHRty5dds1bt8H
         5ZJQ==
X-Gm-Message-State: APzg51BC/ydjM1B3Nq2D/oiCpvpnZ1ZuPNhZgbnBYdcY+rp588IL57d6
        IdrI05Pk1REEBMYJchMlJN/UVoN3sjG6O9VvXOc=
X-Google-Smtp-Source: ANB0Vdayc1imTOZPyeb/lL359ZBDh3mSwQOU2icS6Ig+BVDnJ4lU0AugVKh0d+9nNU6KolhM6laGd2ZLEsT8+1OsimQ=
X-Received: by 2002:adf:db11:: with SMTP id s17-v6mr7075094wri.221.1535616726816;
 Thu, 30 Aug 2018 01:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180802141012.19970-1-andrea.merello@gmail.com>
 <20180802141012.19970-2-andrea.merello@gmail.com> <20180827053002.GT2388@vkoul-mobl>
 <CAN8YU5MOdz_sW06B8yc_kewjsxP0DP5pgB2bSu=vkNG-ezvMpQ@mail.gmail.com>
In-Reply-To: <CAN8YU5MOdz_sW06B8yc_kewjsxP0DP5pgB2bSu=vkNG-ezvMpQ@mail.gmail.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Thu, 30 Aug 2018 10:11:53 +0200
Message-ID: <CAN8YU5M0tJmsU4Xp+0xDwQYtqeB8tPP_4FyBC_ctUOSV=HZNmA@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] dmaengine: xilinx_dma: in axidma slave_sg and
 dma_cylic mode align split descriptors
To:     Vinod <vkoul@kernel.org>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
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

On Wed, Aug 29, 2018 at 10:12 AM Andrea Merello
<andrea.merello@gmail.com> wrote:
>
> On Mon, Aug 27, 2018 at 7:30 AM Vinod <vkoul@kernel.org> wrote:
> >
> > On 02-08-18, 16:10, Andrea Merello wrote:
> >
> > s/cylic/cyclic in patch title
>
> OK
>
> > > Whenever a single or cyclic transaction is prepared, the driver
> > > could eventually split it over several SG descriptors in order
> > > to deal with the HW maximum transfer length.
> > >
> > > This could end up in DMA operations starting from a misaligned
> > > address. This seems fatal for the HW if DRE is not enabled.
> >
> > DRE?
>
> Stands for "Data Realignment Engine". I will add this string nearby
> the acronym..
>
> > >
> > > This patch eventually adjusts the transfer size in order to make sure
> > > all operations start from an aligned address.
> > >
> > > Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > > Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> > > Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > > ---
> > > Changes in v2:
> > >         - don't introduce copy_mask field, rather rely on already-esistent
> > >           copy_align field. Suggested by Radhey Shyam Pandey
> > >         - reword title
> > > Changes in v3:
> > >       - fix bug introduced in v2: wrong copy size when DRE is enabled
> > >       - use implementation suggested by Radhey Shyam Pandey
> > > Changes in v4:
> > >       - rework on the top of 1/6
> > > ---
> > >  drivers/dma/xilinx/xilinx_dma.c | 22 ++++++++++++++++++----
> > >  1 file changed, 18 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> > > index a3aaa0e34cc7..aaa6de8a70e4 100644
> > > --- a/drivers/dma/xilinx/xilinx_dma.c
> > > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > > @@ -954,15 +954,28 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
> > >
> > >  /**
> > >   * xilinx_dma_calc_copysize - Calculate the amount of data to copy
> > > + * @chan: Driver specific DMA channel
> > >   * @size: Total data that needs to be copied
> > >   * @done: Amount of data that has been already copied
> > >   *
> > >   * Return: Amount of data that has to be copied
> > >   */
> > > -static int xilinx_dma_calc_copysize(int size, int done)
> > > +static int xilinx_dma_calc_copysize(struct xilinx_dma_chan *chan,
> > > +                                 int size, int done)
> >
> > please align with opening brace
>
> OK

Sorry for getting back on this.
I've checked it, but it seems already aligned with opening brace in
the original e-mail text I've sent. (4 tabs + 4 spaces).


> > >  {
> > > -     return min_t(size_t, size - done,
> > > +     size_t copy = min_t(size_t, size - done,
> > >                    XILINX_DMA_MAX_TRANS_LEN);
> > > +
> > > +     if ((copy + done < size) &&
> > > +         chan->xdev->common.copy_align) {
> > > +             /*
> > > +              * If this is not the last descriptor, make sure
> > > +              * the next one will be properly aligned
> > > +              */
> > > +             copy = rounddown(copy,
> > > +                              (1 << chan->xdev->common.copy_align));
> > > +     }
> > > +     return copy;
> > >  }
> > >
> > >  /**
> > > @@ -1804,7 +1817,7 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
> > >                        * Calculate the maximum number of bytes to transfer,
> > >                        * making sure it is less than the hw limit
> > >                        */
> > > -                     copy = xilinx_dma_calc_copysize(sg_dma_len(sg),
> > > +                     copy = xilinx_dma_calc_copysize(chan, sg_dma_len(sg),
> > >                                                       sg_used);
> > >                       hw = &segment->hw;
> > >
> > > @@ -1909,7 +1922,8 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
> > >                        * Calculate the maximum number of bytes to transfer,
> > >                        * making sure it is less than the hw limit
> > >                        */
> > > -                     copy = xilinx_dma_calc_copysize(period_len, sg_used);
> > > +                     copy = xilinx_dma_calc_copysize(chan,
> > > +                                                     period_len, sg_used);
> > >                       hw = &segment->hw;
> > >                       xilinx_axidma_buf(chan, hw, buf_addr, sg_used,
> > >                                         period_len * i);
> > > --
> > > 2.17.1
> >
> > --
> > ~Vinod
