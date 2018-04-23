Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755594AbeDWPR4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:17:56 -0400
Received: from mail-db5eur01on0046.outbound.protection.outlook.com ([104.47.2.46]:26134
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755339AbeDWPRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:17:53 -0400
From: Liming Sun <lsun@mellanox.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] mmc: dw_mmc-bluefield: Add driver extension
Thread-Topic: [PATCH 1/2] mmc: dw_mmc-bluefield: Add driver extension
Thread-Index: AQHT2M3XW1qtrhPU4UuDbX+CnoW+n6QOGjWAgABgNCA=
Date: Mon, 23 Apr 2018 15:17:49 +0000
Message-ID: <AM2PR05MB0753660AB3586955631CA28CA1890@AM2PR05MB0753.eurprd05.prod.outlook.com>
References: <1524245538-34137-1-git-send-email-lsun@mellanox.com>
 <CAPDyKFoPgMeCmAC9JeC4hzW4OBDqCq5cdjPoRd0AfYpq=FErwg@mail.gmail.com>
In-Reply-To: <CAPDyKFoPgMeCmAC9JeC4hzW4OBDqCq5cdjPoRd0AfYpq=FErwg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=mellanox.com;
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM2PR05MB0868;7:9t8mHOQazpmncK3W75bXdoaVK4NfV9zdgS1AfzPTH4GXZggXerSW5URWRIOPL0OEqPzBd2rQfNL+X/eVUNxG7GeKy/KxLxDX4jHYNBVizi9CN4Zya7h5GGkRa93K2Qr3c2CIMsIcgBTsUIaXuICO6xCxqiNNiL3guEX40vCRI4ffBGZ75JYL5axTJ75TNC7sP9Z1MOuEW3BK0sJIsM67MLm3TFIPSSAv182kEMzbiRxFUHe58KYSdH3MUTjjcG4I
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM2PR05MB0868;
x-ms-traffictypediagnostic: AM2PR05MB0868:
x-microsoft-antispam-prvs: <AM2PR05MB086837556E285AB94A14C972A1890@AM2PR05MB0868.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:AM2PR05MB0868;BCL:0;PCL:0;RULEID:;SRVR:AM2PR05MB0868;
x-forefront-prvs: 06515DA04B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39380400002)(39860400002)(13464003)(59450400001)(7736002)(3660700001)(11346002)(6506007)(575784001)(86362001)(74316002)(26005)(446003)(55016002)(6436002)(102836004)(5660300001)(53546011)(229853002)(3280700002)(305945005)(6916009)(5250100002)(476003)(66066001)(76176011)(25786009)(3846002)(8936002)(186003)(81166006)(7696005)(8676002)(9686003)(316002)(2906002)(6116002)(33656002)(2900100001)(53936002)(54906003)(6246003)(478600001)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR05MB0868;H:AM2PR05MB0753.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: lq4UTaDs8APDy3qO7OsBfaMXAghRAB8C4ltk4Dp4Jyp3nB3GsBFnaofFw5AyieCbNUwTaaWpdkYRSjiIUXJZ2hRFbTFwseOiy7SGksYO1FoXzPGRoXCmmaLLL5qU4L4jQQMX5ryhVlDXRyXV26g5jkvkMccXEpjZmJfnYA0oq5qVPsHM7Kj1KlZLX7ToeBnQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8f10b1cc-54e7-4cdf-45e6-08d5a92d606e
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f10b1cc-54e7-4cdf-45e6-08d5a92d606e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2018 15:17:49.8574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR05MB0868
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3NFI3ro016901

Thanks Uffe. I'll submit patch 2 as suggested.

Best regards,
Liming

> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> Sent: Monday, April 23, 2018 5:32 AM
> To: Liming Sun <lsun@mellanox.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Jaehoon Chung <jh80.chung@samsung.com>;
> Catalin Marinas <catalin.marinas@arm.com>; Will Deacon
> <will.deacon@arm.com>; linux-mmc@vger.kernel.org;
> devicetree@vger.kernel.org; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>
> Subject: Re: [PATCH 1/2] mmc: dw_mmc-bluefield: Add driver extension
> 
> On 20 April 2018 at 19:32, Liming Sun <lsun@mellanox.com> wrote:
> > This commit adds extension to the dw_mmc driver for Mellanox BlueField
> > SoC. It updates the UHS_REG_EXT register to bring up the eMMC card on
> > this SoC.
> >
> > Signed-off-by: Liming Sun <lsun@mellanox.com>
> > ---
> >  .../devicetree/bindings/mmc/bluefield-dw-mshc.txt  | 29 +++++++++
> 
> Please move changes to DT docs into a separate patch.
> 
> Otherwise this looks good to me.
> 
> Kind regards
> Uffe
> 
> >  drivers/mmc/host/Kconfig                           |  9 +++
> >  drivers/mmc/host/Makefile                          |  1 +
> >  drivers/mmc/host/dw_mmc-bluefield.c                | 72
> ++++++++++++++++++++++
> >  4 files changed, 111 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/bluefield-
> dw-mshc.txt
> >  create mode 100644 drivers/mmc/host/dw_mmc-bluefield.c
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/bluefield-dw-
> mshc.txt b/Documentation/devicetree/bindings/mmc/bluefield-dw-
> mshc.txt
> > new file mode 100644
> > index 0000000..ee0dd61
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt
> > @@ -0,0 +1,29 @@
> > +* Mellanox Bluefield SoC specific extensions to the Synopsys Designware
> > +  Mobile Storage Host Controller
> > +
> > +Read synopsys-dw-mshc.txt for more details
> > +
> > +The Synopsys designware mobile storage host controller is used to
> interface
> > +a SoC with storage medium such as eMMC or SD/MMC cards. This file
> documents
> > +differences between the core Synopsys dw mshc controller properties
> described
> > +by synopsys-dw-mshc.txt and the properties used by the Mellanox
> Bluefield SoC
> > +specific extensions to the Synopsys Designware Mobile Storage Host
> Controller.
> > +
> > +Required Properties:
> > +
> > +* compatible: should be one of the following.
> > +  - "mellanox,bluefield-dw-mshc": for controllers with Mellanox Bluefield
> SoC
> > +    specific extensions.
> > +
> > +Example:
> > +
> > +       /* Mellanox Bluefield SoC MMC */
> > +       dwmmc0@4,0 {
> > +               compatible = "mellanox,bluefield-dw-mshc";
> > +               reg = <4 0x8000 0x400>;
> > +               interrupts = <32>;
> > +               fifo-depth = <0x100>;
> > +               clock-frequency = <24000000>;
> > +               bus-width = <8>;
> > +               cap-mmc-highspeed;
> > +       };
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 9589f9c..26ac6b5 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -717,6 +717,15 @@ config MMC_DW_K3
> >           Synopsys DesignWare Memory Card Interface driver. Select this
> option
> >           for platforms based on Hisilicon K3 SoC's.
> >
> > +config MMC_DW_BLUEFIELD
> > +       tristate "BlueField specific extensions for Synopsys DW Memory Card
> Interface"
> > +       depends on MMC_DW
> > +       select MMC_DW_PLTFM
> > +       help
> > +         This selects support for Mellanox BlueField SoC specific extensions to
> > +         the Synopsys DesignWare Memory Card Interface driver. Select this
> > +         option for platforms based on Mellanox BlueField SoC's.
> > +
> >  config MMC_DW_PCI
> >         tristate "Synopsys Designware MCI support on PCI bus"
> >         depends on MMC_DW && PCI
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index 6aead24..267b3f1 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -55,6 +55,7 @@ obj-$(CONFIG_MMC_DW_K3)               += dw_mmc-
> k3.o
> >  obj-$(CONFIG_MMC_DW_PCI)       += dw_mmc-pci.o
> >  obj-$(CONFIG_MMC_DW_ROCKCHIP)  += dw_mmc-rockchip.o
> >  obj-$(CONFIG_MMC_DW_ZX)                += dw_mmc-zx.o
> > +obj-$(CONFIG_MMC_DW_BLUEFIELD) += dw_mmc-bluefield.o
> >  obj-$(CONFIG_MMC_SH_MMCIF)     += sh_mmcif.o
> >  obj-$(CONFIG_MMC_JZ4740)       += jz4740_mmc.o
> >  obj-$(CONFIG_MMC_VUB300)       += vub300.o
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
> > +       u32 regs;
> > +
> > +       /* Set drive=4 (bit 29:23) and sample=2 (bit 22:16) in UHS_REG_EXT. */
> > +       regs = mci_readl(host, UHS_REG_EXT);
> > +       regs = (regs & ~0x3F100000 & ~0x7F0000) | (4 << 23) | (2 << 16);
> > +       mci_writel(host, UHS_REG_EXT, regs);
> > +}
> > +
> > +static const struct dw_mci_drv_data bluefield_drv_data = {
> > +       .set_ios                = dw_mci_bluefield_set_ios
> > +};
> > +
> > +static const struct of_device_id dw_mci_bluefield_match[] = {
> > +       { .compatible = "mellanox,bluefield-dw-mshc",
> > +               .data = &bluefield_drv_data },
> > +       {},
> > +};
> > +MODULE_DEVICE_TABLE(of, dw_mci_bluefield_match);
> > +
> > +static int dw_mci_bluefield_probe(struct platform_device *pdev)
> > +{
> > +       const struct dw_mci_drv_data *drv_data = NULL;
> > +       const struct of_device_id *match;
> > +
> > +       if (pdev->dev.of_node) {
> > +               match = of_match_node(dw_mci_bluefield_match,
> > +                                     pdev->dev.of_node);
> > +               drv_data = match->data;
> > +       }
> > +
> > +       return dw_mci_pltfm_register(pdev, drv_data);
> > +}
> > +
> > +static struct platform_driver dw_mci_bluefield_pltfm_driver = {
> > +       .probe          = dw_mci_bluefield_probe,
> > +       .remove         = dw_mci_pltfm_remove,
> > +       .driver         = {
> > +               .name           = "dwmmc_bluefield",
> > +               .of_match_table = dw_mci_bluefield_match,
> > +               .pm             = &dw_mci_pltfm_pmops,
> > +       },
> > +};
> > +
> > +module_platform_driver(dw_mci_bluefield_pltfm_driver);
> > +
> > +MODULE_DESCRIPTION("BlueField DW Multimedia Card driver");
> > +MODULE_AUTHOR("Mellanox Technologies");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 1.8.3.1
> >
