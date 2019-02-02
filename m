Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87E2C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F752083B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfBBRVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 12:21:24 -0500
Received: from verein.lst.de ([213.95.11.211]:40557 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfBBRVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 12:21:23 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4785368CEB; Sat,  2 Feb 2019 18:21:21 +0100 (CET)
Date:   Sat, 2 Feb 2019 18:21:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, John Crispin <john@phrozen.org>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 02/18] dmaengine: imx-sdma: pass struct device to DMA
 API functions
Message-ID: <20190202172121.GA3739@lst.de>
References: <20190201084801.10983-1-hch@lst.de> <20190201084801.10983-3-hch@lst.de> <20190202101121.GE4296@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190202101121.GE4296@vkoul-mobl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 03:41:21PM +0530, Vinod Koul wrote:
> On 01-02-19, 09:47, Christoph Hellwig wrote:
> > The DMA API generally relies on a struct device to work properly, and
> > only barely works without one for legacy reasons.  Pass the easily
> > available struct device from the platform_device to remedy this.
> 
> This looks good to me but fails to apply. Can you please base it on
> dmaengine-next or linux-next please and resend

commit ceaf52265148d3a5ca24237fd1c709caa5f46184
Author: Andy Duan <fugang.duan@nxp.com>
Date:   Fri Jan 11 14:29:49 2019 +0000

    dmaengine: imx-sdma: pass ->dev to dma_alloc_coherent() API

in linux-next actually is equivalent to this patch, so we can drop
this one.

> 
> Thanks
> -- 
> ~Vinod
---end quoted text---
