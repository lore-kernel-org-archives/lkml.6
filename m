Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5324DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E776217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AiyM74ur";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SrzkgsKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfAVWhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:37:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41600 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAVWht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:37:49 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9D25F60854; Tue, 22 Jan 2019 22:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548196668;
        bh=xwYtfqjkBfRR7nWvdB2nh7tmiLap/5Zq0bfhp5+WLUA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=AiyM74urr5Irra1D/3vRBSCMHRXYW0FaBYowvjk5YHkTUva1gvchcGs4U0OzkKZQS
         OXjxi313CeMD3FCvq4kU/7yVKx8BYXVMFmeOGbidKRO4M/8kT8RVztiVJgdOvPoyAq
         lY15p3a6f7NnoERb1gvxFPay4Bchzsb/9unFvM8w=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA9316058E;
        Tue, 22 Jan 2019 22:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548196667;
        bh=xwYtfqjkBfRR7nWvdB2nh7tmiLap/5Zq0bfhp5+WLUA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=SrzkgsKRF0clISLLIbLOZyAJpPBZ2ZwEnlP/aU8srO4JsMRAJeZxNgFU+UU/4LfOD
         mK/vwmqE0Fgn+bBZz8dV8x92Y22qk8iFcrZYmiwz3xlaWlW7NRw7ez5+eu8zsjia7s
         KiokQKJQsjjB4RvvETfo6GmyDvxm0ILz0pVusOsw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA9316058E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Tue, 22 Jan 2019 14:37:46 -0800 (PST)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     Brian Starkey <Brian.Starkey@arm.com>
cc:     "labbott@redhat.com" <labbott@redhat.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "tkjos@android.com" <tkjos@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "afd@ti.com" <afd@ti.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "arve@android.com" <arve@android.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "maco@android.com" <maco@android.com>,
        "christian@brauner.io" <christian@brauner.io>, nd <nd@arm.com>
Subject: Re: [PATCH 4/4] staging: android: ion: Support for mapping with dma
 mapping attributes
In-Reply-To: <20190121121907.f3dxhpdavklgb46c@DESKTOP-E1NTVVP.localdomain>
Message-ID: <alpine.DEB.2.10.1901221433240.23328@lmark-linux.qualcomm.com>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org> <1547836667-13695-5-git-send-email-lmark@codeaurora.org> <20190121121907.f3dxhpdavklgb46c@DESKTOP-E1NTVVP.localdomain>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019, Brian Starkey wrote:

> Hi Liam,
> 
> On Fri, Jan 18, 2019 at 10:37:47AM -0800, Liam Mark wrote:
> > Add support for configuring dma mapping attributes when mapping
> > and unmapping memory through dma_buf_map_attachment and
> > dma_buf_unmap_attachment.
> > 
> > For example this will allow ION clients to skip cache maintenance, by
> > using DMA_ATTR_SKIP_CPU_SYNC, for buffers which are clean and haven't been
> > accessed by the CPU.
> 
> How can a client know that the buffer won't be accessed by the CPU in
> the future though?
> 
Yes, for use cases where you don't if it will be accessed in the future 
then you would only use it to optimize the dma map path, but as I 
mentioned in the other thread there are cases (such as in our Camera) 
where we have complete ownership of buffers and do know if it will be 
accessed in the future.

> I don't think we can push this decision to clients, because they are
> lacking information about what else is going on with the buffer. It
> needs to be done by the exporter, IMO.
> 

I do agree it would be better to handle in the exporter, but in a 
pipelining use case where there might not be any devices attached that 
doesn't seem very doable.

> Thanks,
> -Brian
> 
> > 
> > Signed-off-by: Liam Mark <lmark@codeaurora.org>
> > ---
> >  drivers/staging/android/ion/ion.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> > index 1fe633a7fdba..0aae845b20ba 100644
> > --- a/drivers/staging/android/ion/ion.c
> > +++ b/drivers/staging/android/ion/ion.c
> > @@ -268,8 +268,8 @@ static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
> >  	table = a->table;
> >  
> >  	mutex_lock(&buffer->lock);
> > -	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
> > -			direction)) {
> > +	if (!dma_map_sg_attrs(attachment->dev, table->sgl, table->nents,
> > +			      direction, attachment->dma_map_attrs)) {
> >  		mutex_unlock(&buffer->lock);
> >  		return ERR_PTR(-ENOMEM);
> >  	}
> > @@ -287,7 +287,8 @@ static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
> >  	struct ion_buffer *buffer = attachment->dmabuf->priv;
> >  
> >  	mutex_lock(&buffer->lock);
> > -	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
> > +	dma_unmap_sg_attrs(attachment->dev, table->sgl, table->nents, direction,
> > +			   attachment->dma_map_attrs);
> >  	a->dma_mapped = false;
> >  	mutex_unlock(&buffer->lock);
> >  }
> > -- 
> > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
> > a Linux Foundation Collaborative Project
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
