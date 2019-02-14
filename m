Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3023C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA63D222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437263AbfBNH1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:27:00 -0500
Received: from verein.lst.de ([213.95.11.211]:48425 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391612AbfBNH07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:26:59 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 37F4868CEB; Thu, 14 Feb 2019 08:26:58 +0100 (CET)
Date:   Thu, 14 Feb 2019 08:26:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] swiotlb: drop pointless static qualifier in
 swiotlb_dma_supported()
Message-ID: <20190214072658.GA10416@lst.de>
References: <20190214014147.108653-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214014147.108653-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 01:41:47AM +0000, YueHaibing wrote:
> There is no need to have the 'struct dentry *d_swiotlb_usage' variable
> static since new value always be assigned before use it.

FYI, this is in swiotlb_create_debugfs, not swiotlb_dma_supported.
