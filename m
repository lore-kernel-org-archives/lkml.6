Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186CBC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17632083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibsS2N/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17632083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbeJBVkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:40:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728496AbeJBVko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:40:44 -0400
Received: from localhost (unknown [171.76.113.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D175720666;
        Tue,  2 Oct 2018 14:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538492216;
        bh=MFu6dk0r5t5LaADtsaTSV40Hhb8llHUyK8pCixr4KmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ibsS2N/KjyTpICVbOXewi/KSSxk2+BAtvC8aHAlrNBjUYdEaa1elj5N/1QgRg/Njx
         IO9xLd5lqVz8EKjUKGvxKyOjEOttibriTXvbB4qwiYK2zfYrVyKDdRS3/IB2sSdOBV
         YfmokvyYYgjXLbCv5u8yqf+BuV/fJpWIXKSD2vxk=
Date:   Tue, 2 Oct 2018 20:26:47 +0530
From:   Vinod <vkoul@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: Re: [PATCH v5 4/7] dmaengine: xilinx_dma: program hardware supported
 buffer length
Message-ID: <20181002145647.GG19792@vkoul-mobl>
References: <20180907062502.8241-1-andrea.merello@gmail.com>
 <20180907062502.8241-4-andrea.merello@gmail.com>
 <20180918162508.GD2613@vkoul-mobl>
 <CAN8YU5OySuzAyQ=Buad=Jidhes28koV52Gi-QJ-qOiG5TFBO=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN8YU5OySuzAyQ=Buad=Jidhes28koV52Gi-QJ-qOiG5TFBO=Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-09-18, 08:53, Andrea Merello wrote:
> On Tue, Sep 18, 2018 at 6:25 PM Vinod <vkoul@kernel.org> wrote:

> > > @@ -964,7 +968,7 @@ static int xilinx_dma_calc_copysize(struct xilinx_dma_chan *chan,
> > >                                   int size, int done)
> > >  {
> > >       size_t copy = min_t(size_t, size - done,
> > > -                  XILINX_DMA_MAX_TRANS_LEN);
> > > +                         chan->xdev->max_buffer_len);
> >
> > hmm why not add max_buffer_len in patch 1 again, and then use default
> > len as XILINX_DMA_MAX_TRANS_LEN and add multiple lengths here :)
> 
> Sorry, I'm not getting your point. Could you please elaborate the "add
> multiple lengths here" thing ?

IIRC (sorry been travelling and vacation), add
chan->xdev->max_buffer_len in patch 1 and initialize it to
XILINX_DMA_MAX_TRANS_LEN. Then in subsequent patches update the length.

-- 
~Vinod
