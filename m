Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbeEHSzR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:55:17 -0400
Received: from mail-eopbgr40053.outbound.protection.outlook.com ([40.107.4.53]:36032
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750937AbeEHSzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:55:14 -0400
From: Liming Sun <lsun@mellanox.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] mmc: dw_mmc-bluefield: Add driver extension
Thread-Topic: [PATCH v2 1/3] mmc: dw_mmc-bluefield: Add driver extension
Thread-Index: AQHT2xiL63vDCLVeoEGtWUEBJkeAXqQPHBoAgBcoTmA=
Date: Tue, 8 May 2018 18:55:08 +0000
Message-ID: <DB4PR05MB0768969F61B828B1B19A31DDA19A0@DB4PR05MB0768.eurprd05.prod.outlook.com>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
 <a59e321a-2498-d9c1-4a22-296ffa13417a@rock-chips.com>
In-Reply-To: <a59e321a-2498-d9c1-4a22-296ffa13417a@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com;
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB4PR05MB464;7:YdD4RZqlWJY0fawkzty4+GlnUyVMcpZg8ogLZPKXGyfqYzfChPxmo6CyoKBcMwFZ5NKYuRhk2toZRDbeK8aZvmrFzoony47C9JGihLvAU9jHUcx/vjHranYEqiyM8oamjP/CfpIUXRUDGbr3SxKg5PYurgYRmwqPnoW5VTKs6a+WT1MrKtYXkGqqP+ASnJBpUudfy9f8bHHNsbk99Q2BOyK6TuPVfSBejiiKUPkk46RiAB5If7EajXZjsKvh/XE2
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB4PR05MB464;
x-ms-traffictypediagnostic: DB4PR05MB464:
x-microsoft-antispam-prvs: <DB4PR05MB4648321ECBCF10A520D5E3CA19A0@DB4PR05MB464.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB4PR05MB464;BCL:0;PCL:0;RULEID:;SRVR:DB4PR05MB464;
x-forefront-prvs: 0666E15D35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(39380400002)(396003)(346002)(376002)(189003)(199004)(13464003)(14454004)(2900100001)(316002)(7416002)(5660300001)(86362001)(106356001)(33656002)(229853002)(6916009)(6436002)(5250100002)(54906003)(3846002)(6116002)(53936002)(9686003)(97736004)(55016002)(68736007)(4326008)(66066001)(105586002)(6246003)(478600001)(476003)(74316002)(102836004)(6506007)(26005)(53546011)(11346002)(3280700002)(2906002)(81166006)(8936002)(305945005)(25786009)(486006)(81156014)(186003)(99286004)(446003)(59450400001)(8676002)(7696005)(76176011)(3660700001)(7736002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB4PR05MB464;H:DB4PR05MB0768.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
x-microsoft-antispam-message-info: yIpXfAG5g5RDUCLjoEEokW4KbqMweAIFrGyarT4FjdSWB3VAI7QQSOTgaO94+5nq18Gx4hZ/bAgxmRLryEw4d4VqU/YZdEcurQQy7azHs8YwUbVh4Yo0Mr0anTtfcDGWiu6ngaxoZDusSVPzS/9pdQV9Kxm91Pycu2KGP/DYvwKfeHZ1ExMjpluNez+AvqdN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1e5347b4-eebe-4637-cb04-08d5b515389a
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5347b4-eebe-4637-cb04-08d5b515389a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 18:55:08.9996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR05MB464
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w48ItPJL006194

Thanks Shawn. Patch v7 has been sent out to address these comments.

> -----Original Message-----
> From: Shawn Lin [mailto:shawn.lin@rock-chips.com]
> Sent: Monday, April 23, 2018 9:11 PM
> To: Liming Sun <lsun@mellanox.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>; Rob Herring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Jaehoon
> Chung <jh80.chung@samsung.com>; Catalin Marinas
> <catalin.marinas@arm.com>; Will Deacon <will.deacon@arm.com>;
> shawn.lin@rock-chips.com; linux-mmc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 1/3] mmc: dw_mmc-bluefield: Add driver extension
> 
> Hi Liming,
> 
> On 2018/4/23 23:32, Liming Sun wrote:
> > This commit adds extension to the dw_mmc driver for Mellanox BlueField
> > SoC. It updates the UHS_REG_EXT register to bring up the eMMC card on
> > this SoC.
> >
> > Signed-off-by: Liming Sun <lsun@mellanox.com>
> > ---
> >   drivers/mmc/host/Kconfig            |  9 +++++
> >   drivers/mmc/host/Makefile           |  1 +
> >   drivers/mmc/host/dw_mmc-bluefield.c | 72
> +++++++++++++++++++++++++++++++++++++
> >   3 files changed, 82 insertions(+)
> >   create mode 100644 drivers/mmc/host/dw_mmc-bluefield.c
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 9589f9c..26ac6b5 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -717,6 +717,15 @@ config MMC_DW_K3
> >   	  Synopsys DesignWare Memory Card Interface driver. Select this
> option
> >   	  for platforms based on Hisilicon K3 SoC's.
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
> 
> It'd better to keep the order, so you could place it before
> MMC_DW_EXYNOS.

Updated in v7 1/3.

> 
> >   config MMC_DW_PCI
> >   	tristate "Synopsys Designware MCI support on PCI bus"
> >   	depends on MMC_DW && PCI
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index 6aead24..267b3f1 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -55,6 +55,7 @@ obj-$(CONFIG_MMC_DW_K3)		+= dw_mmc-
> k3.o
> >   obj-$(CONFIG_MMC_DW_PCI)	+= dw_mmc-pci.o
> >   obj-$(CONFIG_MMC_DW_ROCKCHIP)	+= dw_mmc-rockchip.o
> >   obj-$(CONFIG_MMC_DW_ZX)		+= dw_mmc-zx.o
> > +obj-$(CONFIG_MMC_DW_BLUEFIELD)	+= dw_mmc-bluefield.o
> 
> Ditto.

Updated in v7 1/3.

> 
> >   obj-$(CONFIG_MMC_SH_MMCIF)	+= sh_mmcif.o
> >   obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
> >   obj-$(CONFIG_MMC_VUB300)	+= vub300.o
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
> 
> Ditto.

Updated in v7 1/3.

> 
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
> GENMASK woule be more readable IMHO.

Updated in v7 1/3.

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
> 
> Keep the indent.

Updated in v7 1/3, assuming this comment is to let the ".data" aligned with the ".compatible".

> 
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
