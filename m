Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D3FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85276218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfBGFhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 00:37:45 -0500
Received: from verein.lst.de ([213.95.11.211]:34881 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfBGFho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 00:37:44 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A45AB6FA81; Thu,  7 Feb 2019 06:37:43 +0100 (CET)
Date:   Thu, 7 Feb 2019 06:37:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        robin.murphy@arm.com, vdumpa@nvidia.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma-direct: do not allocate a single page from CMA
 area
Message-ID: <20190207053743.GA14373@lst.de>
References: <20190115215140.1545-1-nicoleotsuka@gmail.com> <20190204082307.GA5916@lst.de> <20190205230514.GA21515@Asurada-Nvidia.nvidia.com> <20190206070726.GE23392@lst.de> <20190207022848.GA5581@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207022848.GA5581@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 06:28:49PM -0800, Nicolin Chen wrote:
> So we will keep allocating single pages in dev->cma_area if it's
> present, in order to address your previous concern?

Yes.
