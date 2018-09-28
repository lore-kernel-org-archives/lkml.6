Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464A8C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3A82173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTrfGVQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3A82173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbeI1NPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:15:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38397 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbeI1NPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:15:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id z16-v6so1030175wmi.3;
        Thu, 27 Sep 2018 23:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=G24O8/iVoiurdwsx3tCMQSoGwc+c9qa/sgdkgEZrNVU=;
        b=tTrfGVQZFd64wwG7/qRE8kqB/m44KpP8641p43EXmqx0N3egn3B0LiEuAgM2Ss4V83
         A8NLm8Q2goHJc9w9e6nvcuI5cWnHzn/0YdIPme5HAjbyqdbZzH6nkxIQJBeJUhu67oPq
         wLF/stX5XTR8KKFoKvjZ+1vPdJ7gV1AHFsurQGwP7pOJHbCLxyUWxd9ICcrB+IFw8hBR
         i+6zuzq8b1YH886/hHqWilSpKCwikU4XJeOoBclRUu6RWGPMmGPRPwpbXy2Yc8LmqilD
         13VhKdgv4TG3540h3qsnY2rJS5MyX3V9Pw6zEBxRdcKQ8YlhxmGw4A+0FDxoEk4IjRCi
         6wTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=G24O8/iVoiurdwsx3tCMQSoGwc+c9qa/sgdkgEZrNVU=;
        b=FCfn8weBmJVpssOvOH0AK04Fj046kXiUFD3i6fuz2ttWlqtsjQIZAn1+C9t6sjH9cz
         tHceZLJwMwFixv21Nza/HrETJKe2T4flJjiwVNvrg7h9mO29G1Qx0h55BqLWlxTsjTLq
         AsJw0uVAYcTGvhpw/0o6NpRDl+5Olxs4kCL5cBkrmAOrHoNcT8bvfwBHNECJmURJ6rfO
         FQvwFDxsX7twRw2Y37L2e3NDClDMgAKwMkCAoz9ibQNSukeFrvC8lHRpZiMSbk+fzl53
         736C3Ce2fd5DdB/b1byKuHOErm/R+09DkZG3rD7FEqYbWoyG2YU2f3UrAFawCRQ2GeuF
         wsCA==
X-Gm-Message-State: ABuFfohR73IjxXkloJShQ3TpZFQeJsZYdkpklghiGKDWSIHGJ9UeSXHM
        Nq2W8EhMOC0JPRyDCz1JMlyz8Rs6NWm3n759d6s=
X-Google-Smtp-Source: ACcGV63/r5iflykzOTIJ0ORQBw4djzVGVpTp6kzCm5rtxEvmLnheDO3C1eB94qmk0lecJitYkX4vJtEo0RhDsR115wA=
X-Received: by 2002:a1c:a90:: with SMTP id 138-v6mr683576wmk.49.1538117603884;
 Thu, 27 Sep 2018 23:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180907062502.8241-1-andrea.merello@gmail.com>
 <20180907062502.8241-4-andrea.merello@gmail.com> <20180918162508.GD2613@vkoul-mobl>
In-Reply-To: <20180918162508.GD2613@vkoul-mobl>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Fri, 28 Sep 2018 08:53:11 +0200
Message-ID: <CAN8YU5OySuzAyQ=Buad=Jidhes28koV52Gi-QJ-qOiG5TFBO=Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] dmaengine: xilinx_dma: program hardware supported
 buffer length
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

On Tue, Sep 18, 2018 at 6:25 PM Vinod <vkoul@kernel.org> wrote:
>
> On 07-09-18, 08:24, Andrea Merello wrote:
> > From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> >
> > AXI-DMA IP supports configurable (c_sg_length_width) buffer length
> > register width, hence read buffer length (xlnx,sg-length-width) DT
> > property and ensure that driver doesn't program buffer length
> > exceeding the supported limit. For VDMA and CDMA there is no change.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > Signed-off-by: Andrea Merello <andrea.merello@gmail.com> [rebase, reword]
> > ---
> > Changes in v2:
> >         - drop original patch and replace with the one in Xilinx tree
> > Changes in v3:
> >       - cc DT maintainers/ML
> > Changes in v4:
> >       - upper bound for the property should be 26, not 23
> >       - add warn for width > 23 as per xilinx original patch
> >       - rework due to changes introduced in 1/6
> > Changes in v5:
> >       None
> > ---
> >  drivers/dma/xilinx/xilinx_dma.c | 36 +++++++++++++++++++++++++--------
> >  1 file changed, 28 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> > index aaa6de8a70e4..b17f24e4ec35 100644
> > --- a/drivers/dma/xilinx/xilinx_dma.c
> > +++ b/drivers/dma/xilinx/xilinx_dma.c
> > @@ -158,7 +158,9 @@
> >  #define XILINX_DMA_REG_BTT           0x28
> >
> >  /* AXI DMA Specific Masks/Bit fields */
> > -#define XILINX_DMA_MAX_TRANS_LEN     GENMASK(22, 0)
> > +#define XILINX_DMA_MAX_TRANS_LEN_MIN 8
> > +#define XILINX_DMA_MAX_TRANS_LEN_MAX 23
> > +#define XILINX_DMA_V2_MAX_TRANS_LEN_MAX      26
> >  #define XILINX_DMA_CR_COALESCE_MAX   GENMASK(23, 16)
> >  #define XILINX_DMA_CR_CYCLIC_BD_EN_MASK      BIT(4)
> >  #define XILINX_DMA_CR_COALESCE_SHIFT 16
> > @@ -418,6 +420,7 @@ struct xilinx_dma_config {
> >   * @rxs_clk: DMA s2mm stream clock
> >   * @nr_channels: Number of channels DMA device supports
> >   * @chan_id: DMA channel identifier
> > + * @max_buffer_len: Max buffer length
> >   */
> >  struct xilinx_dma_device {
> >       void __iomem *regs;
> > @@ -437,6 +440,7 @@ struct xilinx_dma_device {
> >       struct clk *rxs_clk;
> >       u32 nr_channels;
> >       u32 chan_id;
> > +     u32 max_buffer_len;
> >  };
> >
> >  /* Macros */
> > @@ -964,7 +968,7 @@ static int xilinx_dma_calc_copysize(struct xilinx_dma_chan *chan,
> >                                   int size, int done)
> >  {
> >       size_t copy = min_t(size_t, size - done,
> > -                  XILINX_DMA_MAX_TRANS_LEN);
> > +                         chan->xdev->max_buffer_len);
>
> hmm why not add max_buffer_len in patch 1 again, and then use default
> len as XILINX_DMA_MAX_TRANS_LEN and add multiple lengths here :)

Sorry, I'm not getting your point. Could you please elaborate the "add
multiple lengths here" thing ?

> -
> ~Vinod
