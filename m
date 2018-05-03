Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeECPw5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 11:52:57 -0400
Received: from mail-he1eur01on0048.outbound.protection.outlook.com ([104.47.0.48]:4947
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751075AbeECPwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 11:52:55 -0400
From: Liming Sun <lsun@mellanox.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will.deacon@arm.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/3] mmc: dw_mmc-bluefield: Add driver extension
Thread-Topic: [PATCH v5 1/3] mmc: dw_mmc-bluefield: Add driver extension
Thread-Index: AQHT4XpUJVX32tueBkqffC2RbR2Y+KQcGOiAgAIQmYA=
Date: Thu, 3 May 2018 15:52:01 +0000
Message-ID: <DB4PR05MB07687C762D336E619147F359A1870@DB4PR05MB0768.eurprd05.prod.outlook.com>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
        <CGME20180501182919epcas2p368101c944e8e4bcdb19a1863fc8d469d@epcas2p3.samsung.com>
        <1525198787-46403-1-git-send-email-lsun@mellanox.com>
 <90076dd0-1e6a-3678-5357-98f84a03a46a@samsung.com>
In-Reply-To: <90076dd0-1e6a-3678-5357-98f84a03a46a@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com;
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB4PR05MB0958;7:FEgNrkXFYKEqlNctwm50xGZWrAy30TJApoTnGbtGZVOGwQWJlvQO7S6qiAaoTLHi20oA5ZIm8oVkdIbfQx7/6+DfTaXd111COc4wiDJDh3SqSNJdPlJxkfx9SqkFavIxRImy2w4ZVgV0tkTPn9jc5wZU9xkFhSOdX91u+LwQXU8J47FCsb+3zN+ULsFCW7V3fo6e+eoh+Uzv23M3aEH+3zodGfu8CqDeOfMib15pdmFujK7xweLz8L7Se1kAnf1C
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB4PR05MB0958;
x-ms-traffictypediagnostic: DB4PR05MB0958:
x-microsoft-antispam-prvs: <DB4PR05MB0958E2613389824F2F5B03FEA1870@DB4PR05MB0958.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DB4PR05MB0958;BCL:0;PCL:0;RULEID:;SRVR:DB4PR05MB0958;
x-forefront-prvs: 066153096A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(396003)(376002)(39380400002)(366004)(346002)(199004)(189003)(13464003)(476003)(86362001)(2900100001)(25786009)(6436002)(81156014)(8936002)(5250100002)(74316002)(4326008)(14454004)(97736004)(2906002)(316002)(54906003)(81166006)(446003)(305945005)(68736007)(8676002)(93886005)(33656002)(55016002)(486006)(110136005)(11346002)(102836004)(3280700002)(7736002)(53546011)(6116002)(9686003)(6506007)(6246003)(186003)(66066001)(229853002)(3846002)(26005)(5660300001)(99286004)(76176011)(478600001)(106356001)(105586002)(3660700001)(53936002)(7696005)(2004002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB4PR05MB0958;H:DB4PR05MB0768.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 9XVgmFvotP+TeZmNJUyQa8q23NxAH/+4hmqgoFnBPvAT+XnUE8kdiRw0DWo9VXkS/hJ91NX4ZhwHq8LiVE+VLvqzPgVKLL26BCZcC6PRj5qtVEuxh3j/9cz3YO4tF268RWchssVRGfTEpIM/QG8zM7GIeSgMpkzKpg01VJ+uyNjRyoE8vvdJvMGdfM2kc3r2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 854fad86-c230-46b4-b6e6-08d5b10dcfc2
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854fad86-c230-46b4-b6e6-08d5b10dcfc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 15:52:02.0660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR05MB0958
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w43Fr3PP030863

Thanks. Updated in v6. Removed the "Cc: stable@kernel.org" which is a typo. Will do it later for stable branch. Also addressed the comment to use MACROs in patch 1/3.

> -----Original Message-----
> From: Jaehoon Chung [mailto:jh80.chung@samsung.com]
> Sent: Wednesday, May 2, 2018 4:17 AM
> To: Liming Sun <lsun@mellanox.com>; Ulf Hansson
> <ulf.hansson@linaro.org>; Rob Herring <robh+dt@kernel.org>; Mark
> Rutland <mark.rutland@arm.com>; Catalin Marinas
> <catalin.marinas@arm.com>; Will Deacon <will.deacon@arm.com>
> Cc: linux-mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; stable@kernel.org
> Subject: Re: [PATCH v5 1/3] mmc: dw_mmc-bluefield: Add driver extension
> 
> Hi,
> 
> On 05/02/2018 03:19 AM, Liming Sun wrote:
> > This commit adds extension to the dw_mmc driver for Mellanox BlueField
> > SoC. It updates the UHS_REG_EXT register to bring up the eMMC card on
> > this SoC.
> 
> Could you heck Shawn's comments? And add the minor comment.
> 
> >
> > Cc: stable@kernel.org
> > Signed-off-by: Liming Sun <lsun@mellanox.com>
> > Reviewed-by: David Woods <dwoods@mellanox.com>
> > ---
> >  drivers/mmc/host/Kconfig            |  9 +++++
> >  drivers/mmc/host/Makefile           |  1 +
> >  drivers/mmc/host/dw_mmc-bluefield.c | 72
> +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 82 insertions(+)
> >  create mode 100644 drivers/mmc/host/dw_mmc-bluefield.c
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 9589f9c..26ac6b5 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -717,6 +717,15 @@ config MMC_DW_K3
> >  	  Synopsys DesignWare Memory Card Interface driver. Select this
> option
> >  	  for platforms based on Hisilicon K3 SoC's.
> >
> > +config MMC_DW_BLUEFIELD
> > +	tristate "BlueField specific extensions for Synopsys DW Memory Card
> Interface"
> > +	depends on MMC_DW
> > +	select MMC_DW_PLTFM
> > +	help
> > +	  This selects support for Mellanox BlueField SoC specific extensions
> to
> > +	  the Synopsys DesignWare Memory Card Interface driver. Select this
> > +	  option for platforms based on Mellanox BlueField SoC's.
> > +
> >  config MMC_DW_PCI
> >  	tristate "Synopsys Designware MCI support on PCI bus"
> >  	depends on MMC_DW && PCI
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index 6aead24..267b3f1 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -55,6 +55,7 @@ obj-$(CONFIG_MMC_DW_K3)		+= dw_mmc-
> k3.o
> >  obj-$(CONFIG_MMC_DW_PCI)	+= dw_mmc-pci.o
> >  obj-$(CONFIG_MMC_DW_ROCKCHIP)	+= dw_mmc-rockchip.o
> >  obj-$(CONFIG_MMC_DW_ZX)		+= dw_mmc-zx.o
> > +obj-$(CONFIG_MMC_DW_BLUEFIELD)	+= dw_mmc-bluefield.o
> >  obj-$(CONFIG_MMC_SH_MMCIF)	+= sh_mmcif.o
> >  obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
> >  obj-$(CONFIG_MMC_VUB300)	+= vub300.o
> > diff --git a/drivers/mmc/host/dw_mmc-bluefield.c
> b/drivers/mmc/host/dw_mmc-bluefield.c
> > new file mode 100644
> > index 0000000..12067b1
> > --- /dev/null
> > +++ b/drivers/mmc/host/dw_mmc-bluefield.c
> > @@ -0,0 +1,72 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2018 Mellanox Technologies.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/io.h>
> > +#include <linux/irq.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/mmc/host.h>
> > +#include <linux/mmc/mmc.h>
> > +#include <linux/of.h>
> > +
> > +#include "dw_mmc.h"
> > +#include "dw_mmc-pltfm.h"
> > +
> > +static void dw_mci_bluefield_set_ios(struct dw_mci *host, struct
> mmc_ios *ios)
> > +{
> > +	u32 regs;
> > +
> > +	/* Set drive=4 (bit 29:23) and sample=2 (bit 22:16) in UHS_REG_EXT.
> */
> > +	regs = mci_readl(host, UHS_REG_EXT);
> > +	regs = (regs & ~0x3F100000 & ~0x7F0000) | (4 << 23) | (2 << 16);
> 
> I want to use the macro. Not (4 << 23)..
> 
> > +	mci_writel(host, UHS_REG_EXT, regs);
> > +}
> > +
> > +static const struct dw_mci_drv_data bluefield_drv_data = {
> > +	.set_ios		= dw_mci_bluefield_set_ios
> > +};
> > +
> > +static const struct of_device_id dw_mci_bluefield_match[] = {
> > +	{ .compatible = "mellanox,bluefield-dw-mshc",
> > +		.data = &bluefield_drv_data },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, dw_mci_bluefield_match);
> > +
> > +static int dw_mci_bluefield_probe(struct platform_device *pdev)
> > +{
> > +	const struct dw_mci_drv_data *drv_data = NULL;
> > +	const struct of_device_id *match;
> > +
> > +	if (pdev->dev.of_node) {
> > +		match = of_match_node(dw_mci_bluefield_match,
> > +				      pdev->dev.of_node);
> > +		drv_data = match->data;
> > +	}
> > +
> > +	return dw_mci_pltfm_register(pdev, drv_data);
> > +}
> > +
> > +static struct platform_driver dw_mci_bluefield_pltfm_driver = {
> > +	.probe		= dw_mci_bluefield_probe,
> > +	.remove		= dw_mci_pltfm_remove,
> > +	.driver		= {
> > +		.name		= "dwmmc_bluefield",
> > +		.of_match_table	= dw_mci_bluefield_match,
> > +		.pm		= &dw_mci_pltfm_pmops,
> > +	},
> > +};
> > +
> > +module_platform_driver(dw_mci_bluefield_pltfm_driver);
> > +
> > +MODULE_DESCRIPTION("BlueField DW Multimedia Card driver");
> > +MODULE_AUTHOR("Mellanox Technologies");
> > +MODULE_LICENSE("GPL v2");
> >
