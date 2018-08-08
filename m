Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E56C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4277B21725
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="MFcN4X5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4277B21725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeHHMLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 08:11:25 -0400
Received: from 8bytes.org ([81.169.241.247]:33040 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbeHHMLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 08:11:25 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2EFF42EA; Wed,  8 Aug 2018 11:52:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1533721948; bh=hX1ZEh0C5EEcQZfr1NQZhjEEY9mKSGEJeFhfzduasy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MFcN4X5cZ4KlRG1X7f+75Fe3JAhFcFwjy1van3PKoC/Tv+HoPAtURx+o3PzWjpCbu
         QshiyMWCSRhGBjBlLo2L0ZbNVNog3cNvAcaGmwqANdFm/Veu9Cl0GAwKS8Hfx/0FGJ
         7X6niHLd4kdw9+ddnPk8/gN2TBbmBxBtoYyJ3PsmBBB3lJb5UJKBvplYzUUG+EHqZO
         6RlDEELFZzh0kR+CjKvgbVH1dozuG9pUDcLmKoJpK4VCriHsONjU6R2saifpa1AjOe
         NxXweQSV1cVRdev5CQLe8zIhISX1WHJmsoHMIq/+j3PiTDfbIrbsTDhdYPHGb8VTTE
         IE0DJFUu4/hOg==
Date:   Wed, 8 Aug 2018 11:52:27 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Tegra GART driver clean up and optimization
Message-ID: <20180808095227.ll723ibwtyclih32@8bytes.org>
References: <20180804143003.15817-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180804143003.15817-1-digetx@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Thierry,

On Sat, Aug 04, 2018 at 05:29:55PM +0300, Dmitry Osipenko wrote:
> Dmitry Osipenko (8):
>   memory: tegra: Provide facility for integration with the GART driver
>   iommu/tegra: gart: Provide access to Memory Controller driver
>   iommu/tegra: gart: Clean up drivers module code
>   iommu/tegra: gart: Remove pr_fmt and clean up includes
>   iommu/tegra: gart: Clean up driver probe errors handling
>   iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
>   iommu: Introduce iotlb_sync_map callback
>   iommu/tegra: gart: Optimize mapping / unmapping performance
> 
>  drivers/iommu/iommu.c      |  8 ++-
>  drivers/iommu/tegra-gart.c | 99 +++++++++++++++++++++++---------------
>  drivers/memory/tegra/mc.c  | 26 ++++++++--
>  include/linux/iommu.h      |  1 +
>  include/soc/tegra/mc.h     | 13 +++++
>  5 files changed, 103 insertions(+), 44 deletions(-)

Can you have a look please whether this is safe to go upstream?

Thanks,

	Joerg
