Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB723ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A531D2086E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="alsgJUoj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A531D2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbeJURkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 13:40:09 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:38520 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbeJURkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 13:40:09 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 98678C8;
        Sun, 21 Oct 2018 11:26:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1540113986;
        bh=pzckZtQ+fpIHv+KOoQJZKI3hPrSMe+9hicMuF3mEJRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=alsgJUojHNwE2gh7agQNEvjqfiMq3q3VP/T/dBQ5gkjfZNPH+UphnJ3CCWlqhuuGc
         AC2tbVqXKbqWAyPzB4l+fVcDM1liXilmk6yqzQXKv83sgvJ8DmzEbGz2mF9tRHy6fM
         B3ctVY7oNK5InP7LwXMhYQENeLwdFbLdCtGgZiag=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com, Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin =?utf-8?B?KOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        Andrew-CT Chen =?utf-8?B?KOmZs+aZuui/qik=?= 
        <andrew-ct.chen@mediatek.com>, todor.tomov@linaro.org,
        nicolas@ndufresne.ca,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH 1/2] media: docs-rst: Document memory-to-memory video decoder interface
Date:   Sun, 21 Oct 2018 12:26:26 +0300
Message-ID: <2087236.RgOn5EXAKT@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CAAFQd5D=Lj2XzUMK1LpOXbK3nTdNCFKRkfj3yfpV9mguDkcvdw@mail.gmail.com>
References: <20180724140621.59624-1-tfiga@chromium.org> <CAAFQd5Bb2v0iU6GAwOKtc-4kv1V+P_4Co7=OUYg77wfmKQQ=kA@mail.gmail.com> <CAAFQd5D=Lj2XzUMK1LpOXbK3nTdNCFKRkfj3yfpV9mguDkcvdw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On Saturday, 20 October 2018 13:24:20 EEST Tomasz Figa wrote:
> On Thu, Oct 18, 2018 at 7:03 PM Tomasz Figa wrote:
> > On Wed, Oct 17, 2018 at 10:34 PM Laurent Pinchart wrote:
> >> Hi Tomasz,
> >> 
> >> Thank you for the patch.
> > 
> > Thanks for your comments! Please see my replies inline.
> > 
> >> On Tuesday, 24 July 2018 17:06:20 EEST Tomasz Figa wrote:
> 
> [snip]
> 
> >>> +4. At this point, decoding is paused and the driver will accept, but
> >>> not
> >>> +   process any newly queued ``OUTPUT`` buffers until the client
> >>> issues
> >>> +   ``V4L2_DEC_CMD_START`` or restarts streaming on any queue.
> >>> +
> >>> +* Once the drain sequence is initiated, the client needs to drive it
> >>> to
> >>> +  completion, as described by the above steps, unless it aborts the
> >>> process
> >>> +  by issuing :c:func:`VIDIOC_STREAMOFF` on ``OUTPUT`` queue. The client
> >>> +  is not allowed to issue ``V4L2_DEC_CMD_START`` or
> >>> ``V4L2_DEC_CMD_STOP``
> >>> +  again while the drain sequence is in progress and they will fail with
> >>> +  -EBUSY error code if attempted.
> >> 
> >> While this seems OK to me, I think drivers will need help to implement
> >> all the corner cases correctly without race conditions.
> > 
> > We went through the possible list of corner cases and concluded that
> > there is no use in handling them, especially considering how much they
> > would complicate both the userspace and the drivers. Not even
> > mentioning some hardware, like s5p-mfc, which actually has a dedicated
> > flush operation, that needs to complete before the decoder can switch
> > back to normal mode.
> 
> Actually I misread your comment.
> 
> Agreed that the decoder commands are a bit tricky to implement
> properly. That's one of the reasons I decided to make the return
> -EBUSY while an existing drain is in progress.
> 
> Do you have any particular simplification in mind that could avoid
> some corner cases?

Not really on the spec side. I think we'll have to implement helper functions 
for drivers to use if we want to ensure a consistent and bug-free behaviour.

-- 
Regards,

Laurent Pinchart



