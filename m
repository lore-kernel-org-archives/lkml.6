Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeEBMpQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:45:16 -0400
Received: from mail-eopbgr00078.outbound.protection.outlook.com ([40.107.0.78]:37943
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751101AbeEBMpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:45:13 -0400
From: Liming Sun <lsun@mellanox.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH v5 1/3] mmc: dw_mmc-bluefield: Add driver extension
Thread-Topic: [PATCH v5 1/3] mmc: dw_mmc-bluefield: Add driver extension
Thread-Index: AQHT4XpUJVX32tueBkqffC2RbR2Y+KQbn2iAgADDW1A=
Date: Wed, 2 May 2018 12:45:09 +0000
Message-ID: <AM2PR05MB0753973D8C92F831D48DA19CA1800@AM2PR05MB0753.eurprd05.prod.outlook.com>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
 <1525198787-46403-1-git-send-email-lsun@mellanox.com>
 <c95b926f-2129-c6de-7112-728eea9c7a3a@rock-chips.com>
In-Reply-To: <c95b926f-2129-c6de-7112-728eea9c7a3a@rock-chips.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM2PR05MB1105;7:jZFa6e9L491JtwVwjEcebCMG18VE8aNBdXS1jmp+c9M7ViiNoqfEFiSIgm/6PgoEVq+nnFTNNs+Y8+kzo5f2f5/iMZdxciBliQzzBDctShn9P7D4QajJB2vGjWDKzmfvwoJPLlyv3xS5KoiAQHq6ueePi1xBKFijDDNvlUKxZ5hZ9KUIYreMCM7+hhkK07jJoXPidJQpc6+IN4u3hpB03u44gky/Uz3PIWFu9cqA0ybiIDfdvT6lTJicDn2B15KT
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM2PR05MB1105;
x-ms-traffictypediagnostic: AM2PR05MB1105:
x-microsoft-antispam-prvs: <AM2PR05MB11054A847B9732E61A025B23A1800@AM2PR05MB1105.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM2PR05MB1105;BCL:0;PCL:0;RULEID:;SRVR:AM2PR05MB1105;
x-forefront-prvs: 06607E485E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(39860400002)(376002)(39380400002)(13464003)(189003)(199004)(53376002)(305945005)(81166006)(6246003)(53936002)(110136005)(53546011)(446003)(54906003)(2900100001)(68736007)(106356001)(102836004)(6346003)(476003)(486006)(55016002)(99286004)(966005)(76176011)(105586002)(6506007)(186003)(316002)(11346002)(26005)(7696005)(5250100002)(7736002)(3660700001)(86362001)(4326008)(25786009)(33656002)(9686003)(6306002)(1720100001)(478600001)(6116002)(229853002)(3846002)(6436002)(3280700002)(8676002)(5660300001)(8936002)(81156014)(2906002)(66066001)(7416002)(97736004)(14454004)(74316002)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR05MB1105;H:AM2PR05MB0753.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com;
x-microsoft-antispam-message-info: 9iA8ZC/s4JOeWlpT9M1uCjWD573soFFLB3MEZd3ERp0jC3arjfjHxkuWfsZzZb+9YaBCYXMpIn3nQAji0zyuFiwZqcnOHX//OiGOAPl/gNscHH7jGP/VdMvVYbApTcc1MaFbN+0G/T4Ugjei5sXnoUSuct56a6M7nFTG5VKhzlqF5BbR7zXqa2BeF22VbloJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 86a7819a-3bbf-44ab-3eaa-08d5b02a8a6c
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a7819a-3bbf-44ab-3eaa-08d5b02a8a6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2018 12:45:09.9632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR05MB1105
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w42CjMIv014232

Please see response inline.

Thanks,
Liming

> -----Original Message-----
> From: Shawn Lin [mailto:shawn.lin@rock-chips.com]
> Sent: Tuesday, May 1, 2018 9:02 PM
> To: Liming Sun <lsun@mellanox.com>; Mark Rutland
> <mark.rutland@arm.com>; Jaehoon Chung <jh80.chung@samsung.com>;
> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon
> <will.deacon@arm.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>; Rob Herring
> <robh+dt@kernel.org>; shawn.lin@rock-chips.com; linux-
> mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; stable@kernel.org
> Subject: Re: [PATCH v5 1/3] mmc: dw_mmc-bluefield: Add driver extension
> 
> On 2018/5/2 2:19, Liming Sun wrote:
> > This commit adds extension to the dw_mmc driver for Mellanox BlueField
> > SoC. It updates the UHS_REG_EXT register to bring up the eMMC card on
> > this SoC.
> >
> > Cc: stable@kernel.org
> 
> Why?

[Liming] This is recommended value from HW team. Without this setting, the eMMC 
controller and cards can be found in Linux, but not stable. Writing to it could caused
CRC error.

> 
> > Signed-off-by: Liming Sun <lsun@mellanox.com>
> > Reviewed-by: David Woods <dwoods@mellanox.com>
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
> 
> And did you have feedback of my comment in V2？
> http://lists-archives.com/linux-kernel/29104830-mmc-dw_mmc-bluefield-
> add-driver-extension.html
> 
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
