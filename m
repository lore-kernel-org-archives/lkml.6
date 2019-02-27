Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8409AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BDC20661
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Tmtf+qdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbfB0OEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:04:33 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5367 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbfB0OEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:04:32 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7698eb0000>; Wed, 27 Feb 2019 06:04:27 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 27 Feb 2019 06:04:31 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 27 Feb 2019 06:04:31 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Feb
 2019 14:04:28 +0000
Subject: Re: [PATCH] Revert "dma-contiguous: do not allocate a single page
 from CMA area"
To:     Nicolin Chen <nicoleotsuka@gmail.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <tony@atomide.com>
CC:     <vdumpa@nvidia.com>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <tomi.valkeinen@ti.com>,
        <laurent.pinchart@ideasonboard.com>, <sre@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20190226202327.5349-1-nicoleotsuka@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a3ebd508-04a3-6ad2-5cd4-332282f21a8a@nvidia.com>
Date:   Wed, 27 Feb 2019 14:04:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190226202327.5349-1-nicoleotsuka@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551276267; bh=gdJ8RMK9ENcJHzVUsV3yX4Fpjhmb5e41IiZKYpgS1Ik=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Tmtf+qdR3hUmQpM7q7v/5ufTkVCgFo8FHRtlMSf1Bw+T7+f8kNa0PFRhQ47MOnKUc
         vW8wDscIPlX0FDFCoQNKWzrD6Wqp4NS4c8FiOfeyMVDHbhE/MdoTRkLJ62AcBMFLIC
         7JSP/tO/gxarxJswfztjN4gqdpAzS4VlqObE9ipkYMoAIa5nz4MpQwlIUwKFWt4Z0V
         QppdXfeQZUUY97ULT5R0AmHCBPMlM5A9H4bbqkUikb9+kv/R+Ty75XRqztar22bGZ8
         XPy+p/RkJNV9vBicKEUuiC4HgG2G9vIlw8HLEZGSgDeLCBwT0tE7nAZoUwAHd3JOq9
         hU16KeQBs29aQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/02/2019 20:23, Nicolin Chen wrote:
> This reverts commit d222e42e88168fd67e6d131984b86477af1fc256.
> 
> The original change breaks omap dss:
>     omapdss_dispc 58001000.dispc:
>         dispc_errata_i734_wa_init: dma_alloc_writecombine failed
> 
> Let's revert it first and then find a safer solution instead.
> 
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Tony,
> 	
> Would you please test and verify? Thanks!

This also fixes various memory allocation failures we have seen on
32-bit Tegra as well.

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
