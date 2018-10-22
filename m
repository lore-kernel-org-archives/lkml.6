Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA137C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88D420779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88D420779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeJVRcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:32:39 -0400
Received: from verein.lst.de ([213.95.11.211]:35178 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbeJVRcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:32:39 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D7B4768BE1; Mon, 22 Oct 2018 11:14:57 +0200 (CEST)
Date:   Mon, 22 Oct 2018 11:14:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] skd: fix unchecked return values
Message-ID: <20181022091457.GA19279@lst.de>
References: <20181019184417.GA21154@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019184417.GA21154@embeddedor.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 08:44:17PM +0200, Gustavo A. R. Silva wrote:
> Check return values of dma_set_mask_and_coherent().
> 
> Otherwise, if dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> fails, the following piece of code will be executed even when the call
> to dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)); returns 0:
> 
> dev_err(&pdev->dev, "DMA mask error %d\n", rc);
> goto err_out_regions;
> 
> Addresses-Coverity-ID: 1474553 ("Unchecked return value")
> Fixes: 138126214868 ("skd: switch to the generic DMA API")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks, looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
