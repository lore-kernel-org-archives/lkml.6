Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5A2C3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5D420861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FUnuiG1o";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oSwNsU8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfAUWMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:12:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56862 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfAUWMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:12:33 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4EFD36063A; Mon, 21 Jan 2019 22:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548108752;
        bh=NAIthNYTrubivV9Xd1HIoiRMgrs4Ib8BXbA3NZrc6X4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=FUnuiG1oBmzDwRghU3tZLySo/MDl/g9P2utGYXygd4dJjLF57zU5222nkRWNqO6Jv
         bNkjK+4pcrzvnqfW50c49DGgvqeXUniKNiBdLjiahQeYN4tUJd1Sd2oRpWxwl3aG7g
         epaJnTC9Q+4U2j+0FPtTS5Qub1/mi+Yr78dWxsB4=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1BE96063A;
        Mon, 21 Jan 2019 22:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548108751;
        bh=NAIthNYTrubivV9Xd1HIoiRMgrs4Ib8BXbA3NZrc6X4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=oSwNsU8cHexjHly7YvusMqhFBEbTwBT0AhZnnSXrwmEh8LSqfG/us6WgpcW527EC+
         MU6UJLLTdLtGXU+h0gC17+Z1A09rd0Gci252+c1GvbU8z2LHQxfJSALPrO9nBB+LNU
         qUMKP7Kw2GrgQgKhEDF1n7HsAx8IJt+jsep/o9ag=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1BE96063A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Mon, 21 Jan 2019 14:12:30 -0800 (PST)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     Christoph Hellwig <hch@infradead.org>
cc:     Laura Abbott <labbott@redhat.com>, sumit.semwal@linaro.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        afd@ti.com, john.stultz@linaro.org
Subject: Re: [PATCH 3/4] dma-buf: add support for mapping with dma mapping
 attributes
In-Reply-To: <20190121212947.GA28620@infradead.org>
Message-ID: <alpine.DEB.2.10.1901211357140.11004@lmark-linux.qualcomm.com>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org> <1547836667-13695-4-git-send-email-lmark@codeaurora.org> <20190119102527.GA17723@infradead.org> <7ae73c39-9049-bcf6-775f-b0817ba0ec5f@redhat.com> <20190121083046.GD12420@infradead.org>
 <alpine.DEB.2.10.1901211142560.9631@lmark-linux.qualcomm.com> <20190121212947.GA28620@infradead.org>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019, Christoph Hellwig wrote:

> On Mon, Jan 21, 2019 at 11:44:10AM -0800, Liam Mark wrote:
> > The main use case is for allowing clients to pass in 
> > DMA_ATTR_SKIP_CPU_SYNC in order to skip the default cache maintenance 
> > which happens in dma_buf_map_attachment and dma_buf_unmap_attachment. In 
> > ION the buffers aren't usually accessed from the CPU so this allows 
> > clients to often avoid doing unnecessary cache maintenance.
> 
> This can't work.  The cpu can still easily speculate into this area.

Can you provide more detail on your concern here.
The use case I am thinking about here is a cached buffer which is accessed 
by a non IO-coherent device (quite a common use case for ION).

Guessing on your concern:
The speculative access can be an issue if you are going to access the 
buffer from the CPU after the device has written to it, however if you 
know you aren't going to do any CPU access before the buffer is again 
returned to the device then I don't think the speculative access is a 
concern.

> Moreover in general these operations should be cheap if the addresses
> aren't cached.
> 

I am thinking of use cases with cached buffers here, so CMO isn't cheap.


Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
