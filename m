Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932096AbeEHNGe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 09:06:34 -0400
Received: from mail-db5eur01on0053.outbound.protection.outlook.com ([104.47.2.53]:12544
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754544AbeEHNGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 09:06:32 -0400
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
Thread-Index: AQHT2xiL63vDCLVeoEGtWUEBJkeAXqQPHBoAgBbH5lA=
Date: Tue, 8 May 2018 13:06:28 +0000
Message-ID: <AM2PR05MB07537DA4728DE85B21482BC9A19A0@AM2PR05MB0753.eurprd05.prod.outlook.com>
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
x-microsoft-exchange-diagnostics: 1;AM2PR05MB0964;7:0F8fIDmxN8vEKjYhCK69QBIy5tZeqoo5z6SY1cp2m8xWRsbhqdhAWcTh0AHif3yisdhbb55Eg7h6kPIBNcqCu+8TDI4gJy10GsMGioVuDkK4aMlzHxKsuGpgZI+PI5TG2JYJmoG87WzRz4uzAwP4avhpqZ+13tXxB131K7rm3HsD4d2X2VQiFY229m0xrcXrInIzM9l1lhSpkbvq5hbg5UFuQftDLj32yyI5CVXg+JMXRsqDmjI1YMBnm2SrUNfM
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM2PR05MB0964;
x-ms-traffictypediagnostic: AM2PR05MB0964:
x-microsoft-antispam-prvs: <AM2PR05MB0964B46FFC1C56ED317F1305A19A0@AM2PR05MB0964.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM2PR05MB0964;BCL:0;PCL:0;RULEID:;SRVR:AM2PR05MB0964;
x-forefront-prvs: 0666E15D35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(376002)(346002)(39860400002)(396003)(13464003)(189003)(199004)(7416002)(68736007)(3280700002)(11346002)(305945005)(5250100002)(106356001)(229853002)(86362001)(3660700001)(25786009)(14454004)(105586002)(316002)(476003)(5660300001)(446003)(66066001)(97736004)(486006)(2906002)(2900100001)(59450400001)(53546011)(6506007)(74316002)(53936002)(26005)(102836004)(186003)(33656002)(6916009)(55016002)(81156014)(7696005)(7736002)(54906003)(81166006)(478600001)(3846002)(99286004)(6116002)(8936002)(76176011)(6246003)(6436002)(9686003)(4326008)(8676002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR05MB0964;H:AM2PR05MB0753.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: zgHittpsi52b6Jci5PUx1G1y9VoPxqNG1GAuPvSpMpcVMT8twSFcGQ5x1C74wqUrTPIsgkoYbRCVdZfDcXvgV7D95cyt92ySG3+l9HDtpz3GDpc2CybYWLcrXKPO6k/0SKHX3WcuGM2ChI0WW2uU0xbjhOO2+xyQ3IcZtkqJpsxvSSGDCKkw+OQbCZmELkCs
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7d9b6f6c-6117-42fc-284d-08d5b4e48318
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9b6f6c-6117-42fc-284d-08d5b4e48318
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 13:06:28.6485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR05MB0964
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w48D6geQ015557

Sorry Shawn, somehow I missed this comment... 
Will update it in v7 soon.

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
