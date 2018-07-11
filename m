Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04743C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50032087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50032087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbeGKIpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:45:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:51396 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbeGKIpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:45:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 01:42:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,337,1526367600"; 
   d="scan'208";a="56013491"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by orsmga008.jf.intel.com with ESMTP; 11 Jul 2018 01:42:16 -0700
Subject: Re: [PATCH v3 1/1] mmc: sdhci-pci-dwc-mshc: synopsys dwc mshc support
To:     Prabu Thangamuthu <prabu.t@synopsys.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Manjunath M B <Manjunath.MB@synopsys.com>,
        Prabu T <prabuchml@gmail.com>
References: <1531295777-9515-1-git-send-email-prabu.t@synopsys.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <fa16865b-9a23-d833-cad8-ce8ece660343@intel.com>
Date:   Wed, 11 Jul 2018 11:40:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <1531295777-9515-1-git-send-email-prabu.t@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/18 10:56, Prabu Thangamuthu wrote:
> Synopsys has DWC MSHC controller on HPAS-DX platform connected using PCIe
> interface with SD card slot and eMMC device slots. This patch is to
> enable SD cards connected on this platform. As Clock generation logic
> is implemented using MMCM module of HAPS-DX platform, we have separate
> functions to control the MMCM to generate required clocks with respect
> to speed mode.
> 
> Signed-off-by: Prabu Thangamuthu <prabu.t@synopsys.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> V3 - Updated License.
> Re-sending the patch using git send-email.
> V2 - Removed sdhci-pci-dwc-mshc.h and moved into sdhci-pci-dwc-mshc.c
> Fixed the coding style issue.
> Removed sdhci_snps_set_power and new approach to support eMMC device
> voltages will be submitted after completeing validations.
> V1 - Initial Patch.
> 
>  MAINTAINERS                           |  7 +++
>  drivers/mmc/host/Makefile             |  3 +-
>  drivers/mmc/host/sdhci-pci-core.c     |  1 +
>  drivers/mmc/host/sdhci-pci-dwc-mshc.c | 84 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-pci.h          |  3 ++
>  5 files changed, 97 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mmc/host/sdhci-pci-dwc-mshc.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a29d10f..d062f51 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12813,6 +12813,13 @@ S:	Maintained
>  F:	drivers/mmc/host/sdhci*
>  F:	include/linux/mmc/sdhci*
>  
> +SYNOPSYS SDHCI COMPLIANT DWC MSHC DRIVER
> +M:	Prabu Thangamuthu <prabu.t@synopsys.com>
> +M:	Manjunath M B <manjumb@synopsys.com>
> +L:	linux-mmc@vger.kernel.org
> +S:	Maintained
> +F:	drivers/mmc/host/sdhci-pci-dwc-mshc.c
> +
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) SAMSUNG DRIVER
>  M:	Ben Dooks <ben-linux@fluff.org>
>  M:	Jaehoon Chung <jh80.chung@samsung.com>
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index a18fbba..ce8398e 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -11,7 +11,8 @@ obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
>  obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
>  obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
> -sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o
> +sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
> +				   sdhci-pci-dwc-mshc.o
>  obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))	+= sdhci-pci-data.o
>  obj-$(CONFIG_MMC_SDHCI_ACPI)	+= sdhci-acpi.o
>  obj-$(CONFIG_MMC_SDHCI_PXAV3)	+= sdhci-pxav3.o
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 3d36761..7bfd366 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1513,6 +1513,7 @@ static int amd_probe(struct sdhci_pci_chip *chip)
>  	SDHCI_PCI_DEVICE(O2, SEABIRD0, o2),
>  	SDHCI_PCI_DEVICE(O2, SEABIRD1, o2),
>  	SDHCI_PCI_DEVICE(ARASAN, PHY_EMMC, arasan),
> +	SDHCI_PCI_DEVICE(SYNOPSYS, DWC_MSHC, snps),
>  	SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),
>  	/* Generic SD host controller */
>  	{PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
> diff --git a/drivers/mmc/host/sdhci-pci-dwc-mshc.c b/drivers/mmc/host/sdhci-pci-dwc-mshc.c
> new file mode 100644
> index 0000000..f78d654
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-pci-dwc-mshc.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SDHCI driver for Synopsys DWC_MSHC controller
> + *
> + * Copyright (C) 2018 Synopsys, Inc. (www.synopsys.com)
> + *
> + * Authors:
> + *	Prabu Thangamuthu <prabu.t@synopsys.com>
> + *	Manjunath M B <manjumb@synopsys.com>
> + */
> +
> +#include "sdhci.h"
> +#include "sdhci-pci.h"
> +
> +#define SDHCI_VENDOR_PTR_R	0xE8
> +
> +/* Synopsys vendor specific registers */
> +#define SDHC_GPIO_OUT		0x34
> +#define SDHC_AT_CTRL_R		0x40
> +#define SDHC_SW_TUNE_EN		0x00000010
> +
> +/* MMCM DRP */
> +#define SDHC_MMCM_DIV_REG	0x1020
> +#define DIV_REG_100_MHZ		0x1145
> +#define DIV_REG_200_MHZ		0x1083
> +#define SDHC_MMCM_CLKFBOUT	0x1024
> +#define CLKFBOUT_100_MHZ	0x0000
> +#define CLKFBOUT_200_MHZ	0x0080
> +#define SDHC_CCLK_MMCM_RST	0x00000001
> +
> +static void sdhci_snps_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	u16 clk;
> +	u32 reg, vendor_ptr;
> +
> +	vendor_ptr = sdhci_readw(host, SDHCI_VENDOR_PTR_R);
> +
> +	/* Disable software managed rx tuning */
> +	reg = sdhci_readl(host, (SDHC_AT_CTRL_R + vendor_ptr));
> +	reg &= ~SDHC_SW_TUNE_EN;
> +	sdhci_writel(host, reg, (SDHC_AT_CTRL_R + vendor_ptr));
> +
> +	if (clock <= 52000000) {
> +		sdhci_set_clock(host, clock);
> +	} else {
> +		/* Assert reset to MMCM */
> +		reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> +		reg |= SDHC_CCLK_MMCM_RST;
> +		sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> +
> +		/* Configure MMCM */
> +		if (clock == 100000000) {
> +			sdhci_writel(host, DIV_REG_100_MHZ, SDHC_MMCM_DIV_REG);
> +			sdhci_writel(host, CLKFBOUT_100_MHZ,
> +					SDHC_MMCM_CLKFBOUT);
> +		} else {
> +			sdhci_writel(host, DIV_REG_200_MHZ, SDHC_MMCM_DIV_REG);
> +			sdhci_writel(host, CLKFBOUT_200_MHZ,
> +					SDHC_MMCM_CLKFBOUT);
> +		}
> +
> +		/* De-assert reset to MMCM */
> +		reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> +		reg &= ~SDHC_CCLK_MMCM_RST;
> +		sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> +
> +		/* Enable clock */
> +		clk = SDHCI_PROG_CLOCK_MODE | SDHCI_CLOCK_INT_EN |
> +			SDHCI_CLOCK_CARD_EN;
> +		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +	}
> +}
> +
> +static const struct sdhci_ops sdhci_snps_ops = {
> +	.set_clock	= sdhci_snps_set_clock,
> +	.enable_dma	= sdhci_pci_enable_dma,
> +	.set_bus_width	= sdhci_set_bus_width,
> +	.reset		= sdhci_reset,
> +	.set_uhs_signaling = sdhci_set_uhs_signaling,
> +};
> +
> +const struct sdhci_pci_fixes sdhci_snps = {
> +	.ops		= &sdhci_snps_ops,
> +};
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 59af288..2ef0bdc 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -61,6 +61,8 @@
>  #define PCI_VENDOR_ID_ARASAN		0x16e6
>  #define PCI_DEVICE_ID_ARASAN_PHY_EMMC	0x0670
>  
> +#define PCI_DEVICE_ID_SYNOPSYS_DWC_MSHC 0xc202
> +
>  /*
>   * PCI device class and mask
>   */
> @@ -184,5 +186,6 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
>  #endif
>  
>  extern const struct sdhci_pci_fixes sdhci_arasan;
> +extern const struct sdhci_pci_fixes sdhci_snps;
>  
>  #endif /* __SDHCI_PCI_H */
> 

