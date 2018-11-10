Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A020C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333D62086C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xloec8G2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333D62086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbeKJST0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 13:19:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47352 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeKJST0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 13:19:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y6ERtTbNw/zuK0tBDc/mafY+bzP3AZKVclh7yF5ntTQ=; b=Xloec8G2MpvpoAIs22CxXWWHK
        Whom8nXwwxWo/b7A1PaGCR8d+D6AavkcqohCcXpQcXUGIMMols9kVpxt4gMmhXiXliDvcM/adkph1
        minZOwE246C4SEcxG936dS+BFclUD8zfPNz6zSxr3qFpFWG2G1mQKvA77Bc4FWa8ub/E9gr7Y7Z9p
        tOz0FYIGqb1DuTV0bQ/DzWV1nFPe6TPZgpR6H5GBLH787ZIUwdKpC7BI/jCpuVFFOf7yIV5k3ClVa
        LYyv2kXPRc3ohtCMMQqLscaR2/lHmnQxhnMixUzIY12p+KTt/htHsIJKmwKr9WNEtXrkYKt9/yNXQ
        cXH7FAt1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLOjS-0008QO-Ky; Sat, 10 Nov 2018 08:35:06 +0000
Date:   Sat, 10 Nov 2018 00:35:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: Re: [PATCH 1/1] iommu/vtd: Cleanup dma_remapping.h header
Message-ID: <20181110083506.GB28614@infradead.org>
References: <20181110070844.28353-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110070844.28353-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 03:08:44PM +0800, Lu Baolu wrote:
> Commit e61d98d8dad00 ("x64, x2apic/intr-remap: Intel vt-d, IOMMU
> code reorganization") moved dma_remapping.h from drivers/pci/ to
> current place. It is entirely VT-d specific, but uses a generic
> name. This merges dma_remapping.h with include/linux/intel-iommu.h
> and removes dma_remapping.h as the result.

This looks fine to me, thanks for doing the work.

Reviewed-by: Christoph Hellwig <hch@lst.de>

> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -34,7 +34,7 @@
>  #include <drm/ttm/ttm_placement.h>
>  #include <drm/ttm/ttm_bo_driver.h>
>  #include <drm/ttm/ttm_module.h>
> -#include <linux/dma_remapping.h>
> +#include <linux/intel-iommu.h>

Btw, I don't think this driver has any business looking at Intel
IOMMU driver internals, and the code doing so is more than gross.

Not really your job, but vmw_dma_select_mode really needs a rewrite with
someone that has at least half a clue, and some taste.

Eventually we should also drop the intel_iommu_enabled export.
