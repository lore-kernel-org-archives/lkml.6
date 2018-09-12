Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C994CC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF8320880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF8320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeILWDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:03:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36094 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbeILWDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:03:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D598F7A9;
        Wed, 12 Sep 2018 09:58:28 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A5E0F3F557;
        Wed, 12 Sep 2018 09:58:28 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 91CCE1AE3231; Wed, 12 Sep 2018 17:58:45 +0100 (BST)
Date:   Wed, 12 Sep 2018 17:58:45 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Nipun Gupta <nipun.gupta@nxp.com>
Cc:     joro@8bytes.org, robin.murphy@arm.com, robh+dt@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
        bhelgaas@google.com, hch@lst.de, m.szyprowski@samsung.com,
        shawnguo@kernel.org, frowand.list@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com
Subject: Re: [PATCH 0/7 v7] Support for fsl-mc bus and its devices in SMMU
Message-ID: <20180912165845.GD16071@arm.com>
References: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nipun,

On Mon, Sep 10, 2018 at 07:19:14PM +0530, Nipun Gupta wrote:
> This patchset defines IOMMU DT binding for fsl-mc bus and adds
> support in SMMU for fsl-mc bus.
> 
> These patches
>   - Define property 'iommu-map' for fsl-mc bus (patch 1)
>   - Integrates the fsl-mc bus with the SMMU using this
>     IOMMU binding (patch 2,3,4)
>   - Adds the dma configuration support for fsl-mc bus (patch 5, 6)
>   - Updates the fsl-mc device node with iommu/dma related changes (patch 7)

It looks like you have all the Acks in place for this series now, so I
assume it's going to go via Joerg directly. Is that right?

Will

> Changes in v2:
>   - use iommu-map property for fsl-mc bus
>   - rebase over patchset https://patchwork.kernel.org/patch/10317337/
>     and make corresponding changes for dma configuration of devices on
>     fsl-mc bus
> 
> Changes in v3:
>   - move of_map_rid in drivers/of/address.c
> 
> Changes in v4:
>   - move of_map_rid in drivers/of/base.c
> 
> Changes in v5:
>   - break patch 5 in two separate patches (now patch 5/7 and patch 6/7)
>   - add changelog text in patch 3/7 and patch 5/7
>   - typo fix
> 
> Changes in v6:
>   - Updated fsl_mc_device_group() API to be more rational
>   - Added dma-coherent property in the LS2 smmu device node
>   - Minor fixes in the device-tree documentation
> 
> Changes in v7:
>   - Rebased over linux 4.19
> 
> Nipun Gupta (7):
>   Documentation: fsl-mc: add iommu-map device-tree binding for fsl-mc
>     bus
>   iommu/of: make of_pci_map_rid() available for other devices too
>   iommu/of: support iommu configuration for fsl-mc devices
>   iommu/arm-smmu: Add support for the fsl-mc bus
>   bus: fsl-mc: support dma configure for devices on fsl-mc bus
>   bus: fsl-mc: set coherent dma mask for devices on fsl-mc bus
>   arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc
> 
>  .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |  39 ++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   7 +-
>  drivers/bus/fsl-mc/fsl-mc-bus.c                    |  16 +++-
>  drivers/iommu/arm-smmu.c                           |   7 ++
>  drivers/iommu/iommu.c                              |  13 +++
>  drivers/iommu/of_iommu.c                           |  25 ++++-
>  drivers/of/base.c                                  | 102 +++++++++++++++++++++
>  drivers/of/irq.c                                   |   5 +-
>  drivers/pci/of.c                                   | 101 --------------------
>  include/linux/fsl/mc.h                             |   8 ++
>  include/linux/iommu.h                              |   2 +
>  include/linux/of.h                                 |  11 +++
>  include/linux/of_pci.h                             |  10 --
>  13 files changed, 224 insertions(+), 122 deletions(-)
> 
> -- 
> 1.9.1
> 
