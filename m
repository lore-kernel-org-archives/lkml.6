Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A4DAFC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5ED208B7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5ED208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935681AbeFMNyZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:54:25 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42440 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934527AbeFMNyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:54:23 -0400
Received: by mail-oi0-f67.google.com with SMTP id k190-v6so2371633oib.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 06:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uelHfknlphIlGGcVNbbm/LY1qECZzAieLVIyZ2sLWQg=;
        b=TR8HcmpHKd5uy2D06F29R8lD3ygpUKJL1FrvWa51dd0g1EdIa8vqAiwut5PZAlFru8
         M8CealmRoefUMpmWSamijCau/bJRKJvymh1yahPIWi06yBCVg9vgq2ExwYhovs/04JVT
         4ucubrIyJhCoQcs2jXI8jc0mLMkUFuFo9BzEvC5DY2VhnWHPJeX+5i7XaxeIjfCq71/7
         3eaoI+kgxRK0aFAGkiwLtXoJRlmh3AdITm2MSvuL5Kqh98+Ih9Kk7T1VVa1TZeBDIAgP
         Xa/J4W8LglDGRCRbDiY2QOs+D/YtkdsgB2q1bf24Le0V/Hf9EY8JI96gFkqwaLUEyLMG
         +KUQ==
X-Gm-Message-State: APt69E2io61BFhVg6lUfQBXdxYLOEhpci2mks2XXWWMQhIDq5nnaHJEe
        bO4SXmopTwvtZ7t9Deit/sGh/g==
X-Google-Smtp-Source: ADUXVKKn3Tuv9Fuj/iOHSZpfOH1JheK97Ii3+cBh8OToxTvgjsZEoESbg/vMD2MhUovAHebKTwCrjQ==
X-Received: by 2002:aca:d956:: with SMTP id q83-v6mr4218092oig.349.1528898063093;
        Wed, 13 Jun 2018 06:54:23 -0700 (PDT)
Received: from localhost ([130.164.62.61])
        by smtp.gmail.com with ESMTPSA id w19-v6sm1173808oiw.15.2018.06.13.06.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 06:54:21 -0700 (PDT)
Date:   Wed, 13 Jun 2018 06:54:20 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luwei.kang@intel.com, yi.z.zhang@intel.com,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: Re: [PATCH v6 12/29] fpga: add FPGA DFL PCIe device driver
Message-ID: <20180613135420.GB3866@archbook>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
 <1528798243-2029-13-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528798243-2029-13-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 06:10:26PM +0800, Wu Hao wrote:
> From: Zhang Yi <yi.z.zhang@intel.com>
> 
> This patch implements the basic framework of the driver for FPGA PCIe
> device which implements the Device Feature List (DFL) in its MMIO space.
> This driver is verified on Intel(R) PCIe based FPGA DFL devices, including
> both integrated (e.g Intel Server Platform with In-package FPGA) and
> discrete (e.g Intel FPGA PCIe Acceleration Cards) solutions.
> 
> Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
> Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
> Signed-off-by: Shiva Rao <shiva.rao@intel.com>
> Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
> Signed-off-by: Zhang Yi <yi.z.zhang@intel.com>
> Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Alan Tull <atull@kernel.org>
> Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v2: move the code to drivers/fpga folder as suggested by Alan Tull.
>     switch to GPLv2 license.
>     fix comments from Moritz Fischer.
> v3: switch to pci_set_dma_mask/consistent_dma_mask() function.
>     remove pci_save_state() in probe function.
>     rename driver to INTEL_FPGA_DFL_PCI and intel-dfl-pci.c to indicate
>     this driver supports Intel FPGA PCI devices which implement DFL.
>     improve Kconfig description for INTEL_FPGA_DFL_PCI
> v4: rename to FPGA_DFL_PCI (dfl-pci.c) for better reuse.
>     fix SPDX license issue.
> v5: use module_pci_driver() instead.
>     add Acked-by from Alan and Moritz.
> v6: rebase and unify naming in Kconfig
> ---
>  drivers/fpga/Kconfig   |  15 +++++++
>  drivers/fpga/Makefile  |   3 ++
>  drivers/fpga/dfl-pci.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 132 insertions(+)
>  create mode 100644 drivers/fpga/dfl-pci.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 4052532..5faab48 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -146,4 +146,19 @@ config FPGA_DFL
>  	  Gate Array (FPGA) solutions which implement Device Feature List.
>  	  It provides enumeration APIs, and feature device infrastructure.
>  
> +config FPGA_DFL_PCI
> +	tristate "FPGA DFL PCIe Device Driver"
> +	depends on PCI && FPGA_DFL
> +	help
> +	  Select this option to enable PCIe driver for PCIe based
> +	  Field-Programmable Gate Array (FPGA) solutions which implemented
> +	  the Device Feature List (DFL). This driver provides interfaces
> +	  for userspace applications to configure, enumerate, open and access
> +	  FPGA accelerators on the FPGA DFL devices, enables system level
> +	  management functions such as FPGA partial reconfiguration, power
> +	  management, and virtualization with DFL framework and DFL feature
> +	  device drivers.
> +
> +	  To compile this as a module, choose M here.
> +
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 7a7a117..02e0253 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -31,3 +31,6 @@ obj-$(CONFIG_OF_FPGA_REGION)		+= of-fpga-region.o
>  
>  # FPGA Device Feature List Support
>  obj-$(CONFIG_FPGA_DFL)			+= dfl.o
> +
> +# Drivers for FPGAs which implement DFL
> +obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> new file mode 100644
> index 0000000..5824c5e
> --- /dev/null
> +++ b/drivers/fpga/dfl-pci.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for FPGA Device Feature List (DFL) PCIe device
> + *
> + * Copyright (C) 2017-2018 Intel Corporation, Inc.
> + *
> + * Authors:
> + *   Zhang Yi <Yi.Z.Zhang@intel.com>
> + *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
> + *   Joseph Grecco <joe.grecco@intel.com>
> + *   Enno Luebbers <enno.luebbers@intel.com>
> + *   Tim Whisonant <tim.whisonant@intel.com>
> + *   Ananda Ravuri <ananda.ravuri@intel.com>
> + *   Henry Mitchel <henry.mitchel@intel.com>
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/stddef.h>
> +#include <linux/errno.h>
> +#include <linux/aer.h>
> +
> +#define DRV_VERSION	"0.8"
> +#define DRV_NAME	"dfl-pci"
> +
> +/* PCI Device ID */
> +#define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
> +#define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
> +#define PCIE_DEVICE_ID_PF_DSC_1_X	0x09C4
> +/* VF Device */
> +#define PCIE_DEVICE_ID_VF_INT_5_X	0xBCBF
> +#define PCIE_DEVICE_ID_VF_INT_6_X	0xBCC1
> +#define PCIE_DEVICE_ID_VF_DSC_1_X	0x09C5
> +
> +static struct pci_device_id cci_pcie_id_tbl[] = {
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_INT_5_X),},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_VF_INT_5_X),},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_INT_6_X),},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_VF_INT_6_X),},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_DSC_1_X),},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_VF_DSC_1_X),},
> +	{0,}
> +};
> +MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
> +
> +static
> +int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
> +{
> +	int ret;
> +
> +	ret = pci_enable_device(pcidev);

Any reason we cannot use pcim_enable_device() here?
> +	if (ret < 0) {
> +		dev_err(&pcidev->dev, "Failed to enable device %d.\n", ret);
> +		return ret;
> +	}
> +
> +	ret = pci_enable_pcie_error_reporting(pcidev);
> +	if (ret && ret != -EINVAL)
> +		dev_info(&pcidev->dev, "PCIE AER unavailable %d.\n", ret);
> +
> +	ret = pci_request_regions(pcidev, DRV_NAME);
> +	if (ret) {
> +		dev_err(&pcidev->dev, "Failed to request regions.\n");
> +		goto disable_error_report_exit;
> +	}
> +
> +	pci_set_master(pcidev);
> +
> +	if (!pci_set_dma_mask(pcidev, DMA_BIT_MASK(64))) {
> +		ret = pci_set_consistent_dma_mask(pcidev, DMA_BIT_MASK(64));
> +		if (ret)
> +			goto release_region_exit;
> +	} else if (!pci_set_dma_mask(pcidev, DMA_BIT_MASK(32))) {
> +		ret = pci_set_consistent_dma_mask(pcidev, DMA_BIT_MASK(32));
> +		if (ret)
> +			goto release_region_exit;
> +	} else {
> +		ret = -EIO;
> +		dev_err(&pcidev->dev, "No suitable DMA support available.\n");
> +		goto release_region_exit;
> +	}
> +
> +	/* TODO: create and add the platform device per feature list */
> +	return 0;
> +
> +release_region_exit:
> +	pci_release_regions(pcidev);
> +disable_error_report_exit:
> +	pci_disable_pcie_error_reporting(pcidev);
> +	pci_disable_device(pcidev);
> +	return ret;
> +}
> +
> +static void cci_pci_remove(struct pci_dev *pcidev)
> +{
> +	pci_release_regions(pcidev);
> +	pci_disable_pcie_error_reporting(pcidev);
> +	pci_disable_device(pcidev);
> +}
> +
> +static struct pci_driver cci_pci_driver = {
> +	.name = DRV_NAME,
> +	.id_table = cci_pcie_id_tbl,
> +	.probe = cci_pci_probe,
> +	.remove = cci_pci_remove,
> +};
> +
> +module_pci_driver(cci_pci_driver);
> +
> +MODULE_DESCRIPTION("FPGA DFL PCIe Device Driver");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.8.3.1
> 

Cheers,
Moritz
