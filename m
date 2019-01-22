Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57062C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD0320879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfAVNDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:03:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:37118 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728343AbfAVNDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:03:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5829AFF2;
        Tue, 22 Jan 2019 13:03:52 +0000 (UTC)
Date:   Tue, 22 Jan 2019 14:03:51 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH] iommu/intel-iommu: fix memory leak in
 intel_iommu_put_resv_regions()
Message-ID: <20190122130351.qflz37jyqyrpulgt@suse.de>
References: <20190116191144.15652-1-gerald.schaefer@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116191144.15652-1-gerald.schaefer@de.ibm.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 08:11:44PM +0100, Gerald Schaefer wrote:
> Commit 9d3a4de4cb8d ("iommu: Disambiguate MSI region types") changed
> the reserved region type in intel_iommu_get_resv_regions() from
> IOMMU_RESV_RESERVED to IOMMU_RESV_MSI, but it forgot to also change
> the type in intel_iommu_put_resv_regions().
> 
> This leads to a memory leak, because now the check in
> intel_iommu_put_resv_regions() for IOMMU_RESV_RESERVED will never
> be true, and no allocated regions will be freed.
> 
> Fix this by changing the region type in intel_iommu_put_resv_regions()
> to IOMMU_RESV_MSI, matching the type of the allocated regions.
> 
> Fixes: 9d3a4de4cb8d ("iommu: Disambiguate MSI region types")
> Cc: <stable@vger.kernel.org> # v4.11+
> Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> ---
>  drivers/iommu/intel-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

