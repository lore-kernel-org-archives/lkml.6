Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD524C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D83F20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D83F20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbeKUChf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:37:35 -0500
Received: from verein.lst.de ([213.95.11.211]:46073 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbeKUChe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:37:34 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3009B68B03; Tue, 20 Nov 2018 17:07:42 +0100 (CET)
Date:   Tue, 20 Nov 2018 17:07:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, konrad.wilk@oracle.com, m.szyprowski@samsung.com,
        john.stultz@linaro.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] swiotlb: Make DIRECT_MAPPING_ERROR viable
Message-ID: <20181120160742.GA2492@lst.de>
References: <cover.1542722463.git.robin.murphy@arm.com> <e90da5fbab881c502ac3412fb05c44b26c99f73a.1542722463.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e90da5fbab881c502ac3412fb05c44b26c99f73a.1542722463.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject line should say dma-direct.  This isn't really swiotlb
specific.

> +#define DIRECT_MAPPING_ERROR		~(dma_addr_t)0

Please add braces around the value like the other *MAPPING_ERROR
defintions so that it can be safely used in any context.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

