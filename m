Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbeECOgH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:36:07 -0400
Received: from mail-db5eur01on0054.outbound.protection.outlook.com ([104.47.2.54]:12927
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751027AbeECOgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:36:03 -0400
From: Liming Sun <lsun@mellanox.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/3] mmc: dw_mmc-bluefield: Add driver extension
Thread-Topic: [PATCH v5 1/3] mmc: dw_mmc-bluefield: Add driver extension
Thread-Index: AQHT4XpUJVX32tueBkqffC2RbR2Y+KQbn2iAgADDW1CAAToDgIAAdzAg
Date: Thu, 3 May 2018 14:35:59 +0000
Message-ID: <DB4PR05MB076851D9F7AD93D88B2A0533A1870@DB4PR05MB0768.eurprd05.prod.outlook.com>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
 <1525198787-46403-1-git-send-email-lsun@mellanox.com>
 <c95b926f-2129-c6de-7112-728eea9c7a3a@rock-chips.com>
 <AM2PR05MB0753973D8C92F831D48DA19CA1800@AM2PR05MB0753.eurprd05.prod.outlook.com>
 <485d5c78-e16f-5034-9314-9e17e48d3570@rock-chips.com>
In-Reply-To: <485d5c78-e16f-5034-9314-9e17e48d3570@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com;
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB4PR05MB0909;7:25F76jkqvSpq+raJMHV79iLRfAT9K+IR9HG4NI3w8DuOferhqcLs7d1fEd4b5xNYHHCSrRmiR3kidlXg8MOGlaoHZN5bdW+sHiICqO27E90rP/wNIdIvNGeT9iKIOCrFPtK3aAU1YNjdu58hGyBzYIx98sd1TOBydyS789iF+JxjSYHiC/vkf8/FTlOm4LZ5VEzGpT+SqfyCLWL7hG5MK2Lz8RHNJaGjy80GwEb/EAZ9zgXVrdQdRAk4tBO0YZFH
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB4PR05MB0909;
x-ms-traffictypediagnostic: DB4PR05MB0909:
x-microsoft-antispam-prvs: <DB4PR05MB09096C0FB9023B30C55761E0A1870@DB4PR05MB0909.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DB4PR05MB0909;BCL:0;PCL:0;RULEID:;SRVR:DB4PR05MB0909;
x-forefront-prvs: 066153096A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(39380400002)(346002)(396003)(366004)(199004)(13464003)(189003)(54906003)(6436002)(86362001)(93886005)(1720100001)(476003)(7416002)(446003)(478600001)(11346002)(186003)(68736007)(486006)(3846002)(55016002)(25786009)(305945005)(3660700001)(110136005)(7736002)(105586002)(26005)(53936002)(5660300001)(76176011)(6506007)(74316002)(5250100002)(7696005)(59450400001)(3280700002)(102836004)(6116002)(53376002)(14454004)(229853002)(966005)(6306002)(33656002)(8936002)(6246003)(66066001)(2900100001)(81166006)(316002)(99286004)(8676002)(81156014)(9686003)(97736004)(106356001)(53546011)(2906002)(4326008)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB4PR05MB0909;H:DB4PR05MB0768.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: DXIgvz5D3NS2lvz3UxEZw3DUgJeGTvtYiqmSXzikRPO5yKyyCe7u23cDNt++NyW14R/hmRuwGCjMhyXAxMgAJNU+wLPqR73QRqYAiQNNglHHO4I8Q1PmyfHBW49kAbCYgOGxVgMO0/tu00Wky6D5fBcSx1rXDDOpthTzMFxy3/KivbZ0lghKxoxRYocmrM3N
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c8fc29f6-0044-4e36-8ea0-08d5b103302d
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fc29f6-0044-4e36-8ea0-08d5b103302d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 14:35:59.2228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR05MB0909
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w43EaCWo023513



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Shawn Lin
> Sent: Thursday, May 3, 2018 3:25 AM
> To: Liming Sun <lsun@mellanox.com>; Mark Rutland
> <mark.rutland@arm.com>; Jaehoon Chung <jh80.chung@samsung.com>;
> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon
> <will.deacon@arm.com>
> Cc: shawn.lin@rock-chips.com; Ulf Hansson <ulf.hansson@linaro.org>; Rob
> Herring <robh+dt@kernel.org>; linux-mmc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v5 1/3] mmc: dw_mmc-bluefield: Add driver extension
> 
> 
> On 2018/5/2 20:45, Liming Sun wrote:
> > Please see response inline.
> >
> > Thanks,
> > Liming
> >
> >> -----Original Message-----
> >> From: Shawn Lin [mailto:shawn.lin@rock-chips.com]
> >> Sent: Tuesday, May 1, 2018 9:02 PM
> >> To: Liming Sun <lsun@mellanox.com>; Mark Rutland
> >> <mark.rutland@arm.com>; Jaehoon Chung <jh80.chung@samsung.com>;
> >> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon
> >> <will.deacon@arm.com>
> >> Cc: Ulf Hansson <ulf.hansson@linaro.org>; Rob Herring
> >> <robh+dt@kernel.org>; shawn.lin@rock-chips.com; linux-
> >> mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> >> kernel@vger.kernel.org; stable@kernel.org
> >> Subject: Re: [PATCH v5 1/3] mmc: dw_mmc-bluefield: Add driver
> extension
> >>
> >> On 2018/5/2 2:19, Liming Sun wrote:
> >>> This commit adds extension to the dw_mmc driver for Mellanox
> BlueField
> >>> SoC. It updates the UHS_REG_EXT register to bring up the eMMC card
> on
> >>> this SoC.
> >>>
> >>> Cc: stable@kernel.org
> >>
> >> Why?
> >
> > [Liming] This is recommended value from HW team. Without this setting,
> the eMMC
> > controller and cards can be found in Linux, but not stable. Writing to it could
> caused
> > CRC error.
> 
> Well, I refered to the "Cc: stable@kernel.org" in the commit msg.

[Liming] Sorry, a typo.  I meant "stable@vger.kernel.org". Will update it in v6. Thanks!

> 
> >
> >>
> >>> Signed-off-by: Liming Sun <lsun@mellanox.com>
> >>> Reviewed-by: David Woods <dwoods@mellanox.com>
> >>> ---
> >>>    drivers/mmc/host/Kconfig            |  9 +++++
> >>>    drivers/mmc/host/Makefile           |  1 +
> >>>    drivers/mmc/host/dw_mmc-bluefield.c | 72
> >> +++++++++++++++++++++++++++++++++++++
> >>>    3 files changed, 82 insertions(+)
> >>>    create mode 100644 drivers/mmc/host/dw_mmc-bluefield.c
> >>>
> >>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> >>> index 9589f9c..26ac6b5 100644
> >>> --- a/drivers/mmc/host/Kconfig
> >>> +++ b/drivers/mmc/host/Kconfig
> >>> @@ -717,6 +717,15 @@ config MMC_DW_K3
> >>>    	  Synopsys DesignWare Memory Card Interface driver. Select this
> >> option
> >>>    	  for platforms based on Hisilicon K3 SoC's.
> >>>
> >>> +config MMC_DW_BLUEFIELD
> >>
> >> And did you have feedback of my comment in V2？
> >> http://lists-archives.com/linux-kernel/29104830-mmc-dw_mmc-
> bluefield-
> >> add-driver-extension.html
> >>
> >>> +	tristate "BlueField specific extensions for Synopsys DW Memory Card
> >> Interface"
> >>> +	depends on MMC_DW
> >>> +	select MMC_DW_PLTFM
> >>> +	help
> >>> +	  This selects support for Mellanox BlueField SoC specific extensions
> >> to
> >>> +	  the Synopsys DesignWare Memory Card Interface driver. Select this
> >>> +	  option for platforms based on Mellanox BlueField SoC's.
> >>> +
> >>>    config MMC_DW_PCI
> >>>    	tristate "Synopsys Designware MCI support on PCI bus"
> >>>    	depends on MMC_DW && PCI
> >>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> >>> index 6aead24..267b3f1 100644
> >>> --- a/drivers/mmc/host/Makefile
> >>> +++ b/drivers/mmc/host/Makefile
> >>> @@ -55,6 +55,7 @@ obj-$(CONFIG_MMC_DW_K3)		+=
> dw_mmc-
> >> k3.o
> >>>    obj-$(CONFIG_MMC_DW_PCI)	+= dw_mmc-pci.o
> >>>    obj-$(CONFIG_MMC_DW_ROCKCHIP)	+= dw_mmc-rockchip.o
> >>>    obj-$(CONFIG_MMC_DW_ZX)		+= dw_mmc-zx.o
> >>> +obj-$(CONFIG_MMC_DW_BLUEFIELD)	+= dw_mmc-bluefield.o
> >>>    obj-$(CONFIG_MMC_SH_MMCIF)	+= sh_mmcif.o
> >>>    obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
> >>>    obj-$(CONFIG_MMC_VUB300)	+= vub300.o
> >>> diff --git a/drivers/mmc/host/dw_mmc-bluefield.c
> >> b/drivers/mmc/host/dw_mmc-bluefield.c
> >>> new file mode 100644
> >>> index 0000000..12067b1
> >>> --- /dev/null
> >>> +++ b/drivers/mmc/host/dw_mmc-bluefield.c
> >>> @@ -0,0 +1,72 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * Copyright (C) 2018 Mellanox Technologies.
> >>> + *
> >>> + * This program is free software; you can redistribute it and/or modify
> >>> + * it under the terms of the GNU General Public License as published by
> >>> + * the Free Software Foundation; either version 2 of the License, or
> >>> + * (at your option) any later version.
> >>> + */
> >>> +
> >>> +#include <linux/module.h>
> >>> +#include <linux/io.h>
> >>> +#include <linux/irq.h>
> >>> +#include <linux/platform_device.h>
> >>> +#include <linux/pm_runtime.h>
> >>> +#include <linux/mmc/host.h>
> >>> +#include <linux/mmc/mmc.h>
> >>> +#include <linux/of.h>
> >>> +
> >>> +#include "dw_mmc.h"
> >>> +#include "dw_mmc-pltfm.h"
> >>> +
> >>> +static void dw_mci_bluefield_set_ios(struct dw_mci *host, struct
> >> mmc_ios *ios)
> >>> +{
> >>> +	u32 regs;
> >>> +
> >>> +	/* Set drive=4 (bit 29:23) and sample=2 (bit 22:16) in UHS_REG_EXT.
> >> */
> >>> +	regs = mci_readl(host, UHS_REG_EXT);
> >>> +	regs = (regs & ~0x3F100000 & ~0x7F0000) | (4 << 23) | (2 << 16);
> >>> +	mci_writel(host, UHS_REG_EXT, regs);
> >>> +}
> >>> +
> >>> +static const struct dw_mci_drv_data bluefield_drv_data = {
> >>> +	.set_ios		= dw_mci_bluefield_set_ios
> >>> +};
> >>> +
> >>> +static const struct of_device_id dw_mci_bluefield_match[] = {
> >>> +	{ .compatible = "mellanox,bluefield-dw-mshc",
> >>> +		.data = &bluefield_drv_data },
> >>> +	{},
> >>> +};
> >>> +MODULE_DEVICE_TABLE(of, dw_mci_bluefield_match);
> >>> +
> >>> +static int dw_mci_bluefield_probe(struct platform_device *pdev)
> >>> +{
> >>> +	const struct dw_mci_drv_data *drv_data = NULL;
> >>> +	const struct of_device_id *match;
> >>> +
> >>> +	if (pdev->dev.of_node) {
> >>> +		match = of_match_node(dw_mci_bluefield_match,
> >>> +				      pdev->dev.of_node);
> >>> +		drv_data = match->data;
> >>> +	}
> >>> +
> >>> +	return dw_mci_pltfm_register(pdev, drv_data);
> >>> +}
> >>> +
> >>> +static struct platform_driver dw_mci_bluefield_pltfm_driver = {
> >>> +	.probe		= dw_mci_bluefield_probe,
> >>> +	.remove		= dw_mci_pltfm_remove,
> >>> +	.driver		= {
> >>> +		.name		= "dwmmc_bluefield",
> >>> +		.of_match_table	= dw_mci_bluefield_match,
> >>> +		.pm		= &dw_mci_pltfm_pmops,
> >>> +	},
> >>> +};
> >>> +
> >>> +module_platform_driver(dw_mci_bluefield_pltfm_driver);
> >>> +
> >>> +MODULE_DESCRIPTION("BlueField DW Multimedia Card driver");
> >>> +MODULE_AUTHOR("Mellanox Technologies");
> >>> +MODULE_LICENSE("GPL v2");
> >>>
> >
> >
> >
> >
