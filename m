Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86984C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5DE2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5DE2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeLKJxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:53:20 -0500
Received: from 8bytes.org ([81.169.241.247]:53056 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeLKJxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:53:20 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8DB833AF; Tue, 11 Dec 2018 10:53:18 +0100 (CET)
Date:   Tue, 11 Dec 2018 10:53:17 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/21] IOMMU: Tegra GART driver clean up and
 optimization
Message-ID: <20181211095317.tv43aaefnsezmic7@8bytes.org>
References: <20181209202950.31486-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 11:29:29PM +0300, Dmitry Osipenko wrote:
> Dmitry Osipenko (21):
>   iommu/tegra: gart: Remove pr_fmt and clean up includes
>   iommu/tegra: gart: Clean up driver probe errors handling
>   iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
>   iommu: Introduce iotlb_sync_map callback
>   iommu/tegra: gart: Optimize mapping / unmapping performance
>   dt-bindings: memory: tegra: Squash tegra20-gart into tegra20-mc
>   ARM: dts: tegra20: Update Memory Controller node to the new binding
>   memory: tegra: Don't invoke Tegra30+ specific memory timing setup on
>     Tegra20
>   memory: tegra: Adapt to Tegra20 device-tree binding changes
>   memory: tegra: Read client ID on GART page fault
>   memory: tegra: Use of_device_get_match_data()
>   memory: tegra: Use relaxed versions of readl/writel
>   iommu/tegra: gart: Integrate with Memory Controller driver
>   iommu/tegra: gart: Fix spinlock recursion
>   iommu/tegra: gart: Fix NULL pointer dereference
>   iommu/tegra: gart: Allow only one active domain at a time
>   iommu/tegra: gart: Don't use managed resources
>   iommu/tegra: gart: Prepend error/debug messages with "gart:"
>   iommu/tegra: gart: Don't detach devices from inactive domains
>   iommu/tegra: gart: Simplify clients-tracking code
>   iommu/tegra: gart: Perform code refactoring

This is making progress, but some parts have no Ack or Review yet, I'll
wait for Thierry before applying these patches into the iommu tree.

Regards,

	Joerg
