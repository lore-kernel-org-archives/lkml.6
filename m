Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A538C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 22:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57D120855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 22:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="5k5q2NXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57D120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbeIKDIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 23:08:04 -0400
Received: from mail-eopbgr690058.outbound.protection.outlook.com ([40.107.69.58]:43936
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726207AbeIKDIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 23:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlH07s+rKzhZHIHLynrDkYUgI2wM0yNMDi4E/M0FT9Q=;
 b=5k5q2NXPbBQDkMdtS+1E8U8ofx4DsYlVipJiZ4YXpFHGB4Jd7laaqBRkHLiBTEmTdg8VxDQa/tmZlzQ+iFnki3/DgDnIEretKd300fUBq4djcXQdx/V5xJ9Bz4kjddaXnQPQIuMaEzPdu3XFk9Z4OvZzk45rppIKZVvxwj8oRW0=
Received: from CY1PR0201MB1018.namprd02.prod.outlook.com (10.161.211.148) by
 CY1PR0201MB1931.namprd02.prod.outlook.com (10.163.56.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Mon, 10 Sep 2018 22:09:46 +0000
Received: from CY1PR0201MB1018.namprd02.prod.outlook.com
 ([fe80::fda9:c57a:8f85:95d3]) by CY1PR0201MB1018.namprd02.prod.outlook.com
 ([fe80::fda9:c57a:8f85:95d3%5]) with mapi id 15.20.1122.019; Mon, 10 Sep 2018
 22:09:45 +0000
From:   Jiaying Liang <jliang@xilinx.com>
To:     Loic PALLARDY <loic.pallardy@st.com>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Michal Simek <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6/7] remoteproc: Add Xilinx ZynqMP R5 remoteproc
Thread-Topic: [PATCH 6/7] remoteproc: Add Xilinx ZynqMP R5 remoteproc
Thread-Index: AQHUNS/AHT3Atuq6Q0299/u1bVTGhaTqHkEAgAAHoyA=
Date:   Mon, 10 Sep 2018 22:09:44 +0000
Message-ID: <CY1PR0201MB1018E0107D89F85055AAC59DB0050@CY1PR0201MB1018.namprd02.prod.outlook.com>
References: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
 <1534403190-28523-7-git-send-email-jliang@xilinx.com>
 <0c0e49a9b3594799b572e539705f4f4b@SFHDAG7NODE2.st.com>
In-Reply-To: <0c0e49a9b3594799b572e539705f4f4b@SFHDAG7NODE2.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jliang@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0201MB1931;6:UakDUXGC9AKrliHl1cZmeSoe2jD0dqvUftGOiWG/tv9q1PBo/SDRSkZIHc1PePi3K5fcXsghJelD8wzO321AzW91F6NJEbU6nEmjGjUBnwPXgXAZe2VLJ3+ftowNwdfbyrFODeUvY8agRv/dO6v+sb44+439BO6CWQ1TkNp2E6LhCnYc+OYFbWyuHFrk/NllMMRHHaIxIS7no3rA9Sk8uSF5iwkzYQBjzxUDrQG5V1fTkGdhgMtIglU4gJrWil2SbvPMiaKM3K/g0M2XQBoAwekwIgj7u25sA6oPdYiMbkeZebHxMxLFPY4ZDTWhrIl0sZamPSljjFBLCSuD2TU4r0PsV+yF1tE0m6pAZW+NO5FmI3tHjfl7s+r7e1YjnJ42Wp8XCfg2HD8h2l4KkccMxRpaRyacuTxucYwEZp/zP+qVjvIiKReUy2tCqMsN+I3lYXFItiSn9RsKBa2e3n4VFw==;5:AMMre2wxXaIjqaSg3p6TKhUkkpDZ1bu1LNlX19mVrWYYgpzTvp04kqmIr0sZdruQHLsBnLCvU4bUdUMvCEoypI3R9/40bHygjht0Ql4YdXFMASFo9zf88EbFuNY3fJLKcUzmEoREG0IuEUj0qh2177mM/W6wJYwuGmmkEahWvqc=;7:FL/LhKgvn7xUc768JosFQGxDRId0vXSHacm01XfUvqyYa//GDvbvtkMiJEqPgJ4EuEGhsQF+97+lRBL5fqJR8I7sP+DAMVGWBAgb2HEZNWT4SdO9GmWdIwZz5ImI7BelpwY5uIbFMPwYK+9aAn7p+MOaoCimQbG4nci16XSbaOKvsrgz2tW2PLtB0Y2OkAgsVoQ1inDDgQ4WNXHW1Squ6Ts9k4EGW1LDqi26wgNWHVx+4t6R5LGGFf6TDyOJ/msF
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39860400002)(376002)(136003)(51234002)(189003)(199004)(13464003)(26005)(4326008)(8676002)(3846002)(74316002)(7736002)(305945005)(316002)(2906002)(25786009)(14444005)(256004)(476003)(446003)(6116002)(66066001)(102836004)(11346002)(6506007)(53546011)(81166006)(186003)(81156014)(486006)(6636002)(14454004)(53936002)(966005)(76176011)(5250100002)(97736004)(99286004)(68736007)(8936002)(2501003)(2201001)(86362001)(6246003)(33656002)(54906003)(110136005)(105586002)(6436002)(53946003)(55016002)(9686003)(106356001)(6306002)(575784001)(7696005)(478600001)(229853002)(5660300001)(2900100001)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB1931;H:CY1PR0201MB1018.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 0c57a135-75a4-472f-ee8d-08d6176a1dc4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR0201MB1931;
x-ms-traffictypediagnostic: CY1PR0201MB1931:
x-microsoft-antispam-prvs: <CY1PR0201MB19317156673A8E8EE3C03B52B0050@CY1PR0201MB1931.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(258649278758335)(192813158149592)(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:CY1PR0201MB1931;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB1931;
x-forefront-prvs: 07915F544A
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WVn7vYp8baEK2y91dQtWZOIFCWKScD+svIjjinFKoYxOTA0cUKdqOL2VdNyJemPFncdHtjgMfP8/YrsbKCwHaQaXqlN1GqT0orjf5xQOCW6hgVpEjYG/PqGxsplotFyxUy3qo1AOmFIjH1oQekR04H+mIABkOPAgvDgaeqOyyJ8C0nhIhUvlrPL+D/PifzFRI6UKKBhVGqfV2cHiKsp5CjBAckutk3L9CzLtcebb6mcNPVc70D+8yocL/XCivRRqC7U7DF59vCP0NJ/CPs/oy4i5tWaqqttFIMbASe5FfBL1SsBRarjhM/K+mfJh7vFY/qAyqp9NUqgsmYTArTKx6vfMn+hWQf7NdoN4doBYrj0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c57a135-75a4-472f-ee8d-08d6176a1dc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 22:09:45.0577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB1931
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Loic PALLARDY [mailto:loic.pallardy@st.com]
> Sent: Monday, September 10, 2018 1:25 PM
> To: Jiaying Liang <jliang@xilinx.com>; ohad@wizery.com;
> bjorn.andersson@linaro.org; Michal Simek <michals@xilinx.com>;
> robh+dt@kernel.org; mark.rutland@arm.com; Rajan Vaja
> <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>
> Cc: linux-remoteproc@vger.kernel.org; linux-arm-kernel@lists.infradead.or=
g;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Jiaying Liang
> <jliang@xilinx.com>
> Subject: RE: [PATCH 6/7] remoteproc: Add Xilinx ZynqMP R5 remoteproc
>=20
> Hi Wendy,
> Please find below few comments.
>=20
> > -----Original Message-----
> > From: linux-remoteproc-owner@vger.kernel.org <linux-remoteproc-
> > owner@vger.kernel.org> On Behalf Of Wendy Liang
> > Sent: Thursday, August 16, 2018 9:06 AM
> > To: ohad@wizery.com; bjorn.andersson@linaro.org;
> > michal.simek@xilinx.com; robh+dt@kernel.org; mark.rutland@arm.com;
> > rajan.vaja@xilinx.com; jollys@xilinx.com
> > Cc: linux-remoteproc@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Wendy Liang <jliang@xilinx.com>
> > Subject: [PATCH 6/7] remoteproc: Add Xilinx ZynqMP R5 remoteproc
> >
> > There are cortex-r5 processors in Xilinx Zynq UltraScale+ MPSoC
> > platforms. This remoteproc driver is to manage the
> > R5 processors.
> >
> > Signed-off-by: Wendy Liang <jliang@xilinx.com>
>=20
> Jason Wu' signed-off-by missing as he is mentioned as author of this driv=
er?
[Wendy] He was the one who wrote the init version of the driver.
But he left the company a few years ago. In this case, maybe I should remov=
e
Module author.
>=20
> > ---
> >  drivers/remoteproc/Kconfig                |   9 +
> >  drivers/remoteproc/Makefile               |   1 +
> >  drivers/remoteproc/zynqmp_r5_remoteproc.c | 692
> > ++++++++++++++++++++++++++++++
> >  3 files changed, 702 insertions(+)
> >  create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c
> >
> > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > index cd1c168..83aac63 100644
> > --- a/drivers/remoteproc/Kconfig
> > +++ b/drivers/remoteproc/Kconfig
> > @@ -158,6 +158,15 @@ config ST_REMOTEPROC  config
> ST_SLIM_REMOTEPROC
> >  	tristate
> >
> > +config ZYNQMP_R5_REMOTEPROC
> > +	tristate "ZynqMP_r5 remoteproc support"
> > +	depends on ARM64 && PM && ARCH_ZYNQMP
> > +	select RPMSG_VIRTIO
> > +	select ZYNQMP_FIRMWARE
> > +	help
> > +	  Say y here to support ZynqMP R5 remote processors via the remote
> > +	  processor framework.
> > +
> >  endif # REMOTEPROC
> >
> >  endmenu
> > diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> > index 02627ed..147923c 100644
> > --- a/drivers/remoteproc/Makefile
> > +++ b/drivers/remoteproc/Makefile
> > @@ -23,3 +23,4 @@ qcom_wcnss_pil-y			+=3D
> > qcom_wcnss.o
> >  qcom_wcnss_pil-y			+=3D qcom_wcnss_iris.o
> >  obj-$(CONFIG_ST_REMOTEPROC)		+=3D st_remoteproc.o
> >  obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+=3D st_slim_rproc.o
> > +obj-$(CONFIG_ZYNQMP_R5_REMOTEPROC)	+=3D zynqmp_r5_remoteproc.o
> > diff --git a/drivers/remoteproc/zynqmp_r5_remoteproc.c
> > b/drivers/remoteproc/zynqmp_r5_remoteproc.c
> > new file mode 100644
> > index 0000000..7fc3718
> > --- /dev/null
> > +++ b/drivers/remoteproc/zynqmp_r5_remoteproc.c
> > @@ -0,0 +1,692 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Zynq R5 Remote Processor driver
> > + *
> > + * Copyright (C) 2015 Xilinx, Inc.
> > + *
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/err.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/remoteproc.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/of_reserved_mem.h>
> > +#include <linux/slab.h>
> > +#include <linux/cpu.h>
> > +#include <linux/delay.h>
> > +#include <linux/list.h>
> > +#include <linux/genalloc.h>
> > +#include <linux/pfn.h>
> > +#include <linux/idr.h>
> > +#include <linux/firmware/xlnx-zynqmp.h>
>=20
> Includes to be classified in alphabetical order
[Wendy] Will do in the next version
>=20
> > +
> > +#include "remoteproc_internal.h"
> > +
> > +/* IPI reg offsets */
> > +#define TRIG_OFFSET		0x00000000
> > +#define OBS_OFFSET		0x00000004
> > +#define ISR_OFFSET		0x00000010
> > +#define IMR_OFFSET		0x00000014
> > +#define IER_OFFSET		0x00000018
> > +#define IDR_OFFSET		0x0000001C
> > +#define IPI_ALL_MASK		0x0F0F0301
> > +
> > +/* RPU IPI mask */
> > +#define RPU_IPI_INIT_MASK	0x00000100
> > +#define RPU_IPI_MASK(n)		(RPU_IPI_INIT_MASK << (n))
> > +#define RPU_0_IPI_MASK		RPU_IPI_MASK(0)
> > +#define RPU_1_IPI_MASK		RPU_IPI_MASK(1)
> > +
> > +/* PM proc states */
> > +#define PM_PROC_STATE_ACTIVE 1u
> > +
> > +/* Maximum TCM power nodes IDs */
> > +#define MAX_TCM_PNODES 4
> > +
> > +/* Register access macros */
> > +#define reg_read(base, reg) \
> > +	readl(((void __iomem *)(base)) + (reg)) #define reg_write(base, reg,
> > +val) \
> > +	writel((val), ((void __iomem *)(base)) + (reg))
> > +
> > +#define DEFAULT_FIRMWARE_NAME	"rproc-rpu-fw"
> > +
> > +static bool autoboot __read_mostly;
> > +
> > +struct zynqmp_r5_rproc_pdata;
>=20
> This definition is not needed as complete definition just below.
[Wendy] Will remove in the next version
> > +
> > +/**
> > + * struct zynqmp_r5_rproc_pdata - zynqmp rpu remote processor
> > +instance
> > state
> > + * @rproc: rproc handle
> > + * @workqueue: workqueue for the RPU remoteproc
> > + * @ipi_base: virt ptr to IPI channel address registers for APU
> > + * @rpu_mode: RPU core configuration
> > + * @rpu_id: RPU CPU id
> > + * @rpu_pnode_id: RPU CPU power domain id
> > + * @mem_pools: list of gen_pool for firmware mmio_sram memory and
> > their
> > + *             power domain IDs
> > + * @mems: list of rproc_mem_entries for firmware
> > + * @irq: IRQ number
> > + * @ipi_dest_mask: IPI destination mask for the IPI channel  */
> > +struct zynqmp_r5_rproc_pdata {
> > +	struct rproc *rproc;
> > +	struct work_struct workqueue;
> > +	void __iomem *ipi_base;
> > +	enum rpu_oper_mode rpu_mode;
> > +	struct list_head mems;
> > +	u32 ipi_dest_mask;
> > +	u32 rpu_id;
> > +	u32 rpu_pnode_id;
> > +	int irq;
> > +	u32 tcm_pnode_id[MAX_TCM_PNODES];
> > +};
> > +
> > +/**
> > + * r5_boot_addr_config - configure the boot address of R5
> > + * @pdata: platform data
> > + * @bootmem: boot from LOVEC or HIVEC
> > + *
> > + * This function will set the RPU boot address  */ static void
> > +r5_boot_addr_config(struct zynqmp_r5_rproc_pdata *pdata,
> > +				enum rpu_boot_mem bootmem)
> > +{
> > +	const struct zynqmp_eemi_ops *eemi =3D
> > zynqmp_pm_get_eemi_ops();
> > +
> > +	pr_debug("%s: R5 ID: %d, boot_dev %d\n",
> > +		 __func__, pdata->rpu_id, bootmem);
> > +
> > +	if (!eemi || !eemi->ioctl) {
> > +		pr_err("%s: no eemi ioctl operation.\n", __func__);
> > +		return;
> > +	}
> > +	eemi->ioctl(pdata->rpu_pnode_id,
> > IOCTL_RPU_BOOT_ADDR_CONFIG,
> > +		    bootmem, 0, NULL);
> > +}
> > +
> > +/**
> > + * r5_mode_config - configure R5 operation mode
> > + * @pdata: platform data
> > + *
> > + * configure R5 to split mode or lockstep mode
> > + * based on the platform data.
> > + */
> > +static void r5_mode_config(struct zynqmp_r5_rproc_pdata *pdata) {
> > +	const struct zynqmp_eemi_ops *eemi =3D
> > zynqmp_pm_get_eemi_ops();
> > +
> > +	pr_debug("%s: mode: %d\n", __func__, pdata->rpu_mode);
> > +
> > +	if (!eemi || !eemi->ioctl) {
> > +		pr_err("%s: no eemi ioctl operation.\n", __func__);
> > +		return;
> > +	}
> > +	eemi->ioctl(pdata->rpu_pnode_id, IOCTL_SET_RPU_OPER_MODE,
> > +		    pdata->rpu_mode, 0, NULL);
> > +}
> > +
> > +/**
> > + * r5_release_tcm() - release TCM
> > + * @pdata: platform data
> > + *
> > + * Release TCM
> > + */
> > +static void r5_release_tcm(struct zynqmp_r5_rproc_pdata *pdata) {
> > +	const struct zynqmp_eemi_ops *eemi =3D
> > zynqmp_pm_get_eemi_ops();
> > +	int i;
> > +
> > +	if (!eemi || !eemi->release_node) {
> > +		pr_err("Failed to release TCM\n");
> > +		return;
> > +	}
> > +
> > +	for (i =3D 0; i < MAX_TCM_PNODES; i++) {
> > +		if (pdata->tcm_pnode_id[i] !=3D 0)
> > +			eemi->release_node(pdata->tcm_pnode_id[i]);
> > +	}
> > +}
> > +
> > +/**
> > + * disable_ipi - disable IPI
> > + * @pdata: platform data=09
> > + *
> > + * Disable IPI interrupt
> > + */
> > +static inline void disable_ipi(struct zynqmp_r5_rproc_pdata *pdata) {
> > +	/* Disable R5 IPI interrupt */
> > +	if (pdata->ipi_base)
> > +		reg_write(pdata->ipi_base, IDR_OFFSET, pdata-
> > >ipi_dest_mask);
> > +}
>=20
> All IPI functions should go below mailbox framework as you use it as a
> doorbell.
[Wendy] There is another patch for IPI driver. There are discussions on how=
 the mailbox
Driver should be implemented. I directly access the IPI here is to see if I=
 can upstream this
Remoteproc driver independent to the mailbox driver. I can update this driv=
er after the
Mailbox driver is upstreamed.
>=20
> > +
> > +/**
> > + * enable_ipi - enable IPI
> > + * @pdata: platform data
> > + *
> > + * Enable IPI interrupt
> > + */
> > +static inline void enable_ipi(struct zynqmp_r5_rproc_pdata *pdata) {
> > +	/* Enable R5 IPI interrupt */
> > +	if (pdata->ipi_base)
> > +		reg_write(pdata->ipi_base, IER_OFFSET, pdata-
> > >ipi_dest_mask);
> > +}
> > +
> > +/**
> > + * event_notified_idr_cb - event notified idr callback
> > + * @id: idr id
> > + * @ptr: pointer to idr private data
> > + * @data: data passed to idr_for_each callback
> > + *
> > + * Pass notification to remoteproc virtio
> > + *
> > + * @return: 0. having return is to satisfy the idr_for_each() function
> > + *          pointer input argument requirement.
> > + */
> > +static int event_notified_idr_cb(int id, void *ptr, void *data) {
> > +	struct rproc *rproc =3D data;
> > +
> > +	(void)rproc_vq_interrupt(rproc, id);
> > +	return 0;
> > +}
> > +
> > +static void handle_event_notified(struct work_struct *work) {
> > +	struct rproc *rproc;
> > +	struct zynqmp_r5_rproc_pdata *local;
> > +
> > +	local =3D container_of(work, struct zynqmp_r5_rproc_pdata,
> > workqueue);
> > +	rproc =3D local->rproc;
> > +	idr_for_each(&rproc->notifyids, event_notified_idr_cb, rproc); }
> > +
> > +static int zynqmp_r5_rproc_start(struct rproc *rproc) {
> > +	struct device *dev =3D rproc->dev.parent;
> > +	struct zynqmp_r5_rproc_pdata *local =3D rproc->priv;
> > +	enum rpu_boot_mem bootmem;
> > +	const struct zynqmp_eemi_ops *eemi =3D
> > zynqmp_pm_get_eemi_ops();
> > +
> > +	dev_dbg(dev, "%s\n", __func__);
> > +
> > +	if (!eemi || !eemi->force_powerdown ||
> > +	    !eemi->request_wakeup) {
> > +		pr_err("Failed to start R5\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	/* Set up R5 */
> > +	if ((rproc->bootaddr & 0xF0000000) =3D=3D 0xF0000000)
> > +		bootmem =3D PM_RPU_BOOTMEM_HIVEC;
> > +	else
> > +		bootmem =3D PM_RPU_BOOTMEM_LOVEC;
> > +	dev_info(dev, "RPU boot from %s.",
> > +		 bootmem =3D=3D PM_RPU_BOOTMEM_HIVEC ? "OCM" :
> > "TCM");
> > +
> > +	r5_mode_config(local);
> > +	eemi->force_powerdown(local->rpu_pnode_id,
> > +			      ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > +	r5_boot_addr_config(local, bootmem);
>=20
> Add some blank line to ease code reading. Some parts of the code are too
> compacted.
Will do in the next version.
>=20
> > +	/* Add delay before release from halt and reset */
> > +	usleep_range(400, 500);
> > +	eemi->request_wakeup(local->rpu_pnode_id,
> > +			     1, bootmem,
> > +			     ZYNQMP_PM_REQUEST_ACK_NO);
> > +
> > +	/* Make sure IPI is enabled */
> > +	enable_ipi(local);
> > +
> > +	return 0;
> > +}
> > +
> > +/* kick a firmware */
> > +static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid) {
> > +	struct device *dev =3D rproc->dev.parent;
> > +	struct zynqmp_r5_rproc_pdata *local =3D rproc->priv;
> > +
> > +	dev_dbg(dev, "KICK Firmware to start send messages vqid %d\n",
> > vqid);
> > +
> > +	/*
> > +	 * send irq to R5 firmware
> > +	 * Currently vqid is not used because we only got one.
> > +	 */
> > +	if (local->ipi_base)
> > +		reg_write(local->ipi_base, TRIG_OFFSET, local-
> > >ipi_dest_mask);
> > +}
> > +
> > +/* power off the remote processor */
> > +static int zynqmp_r5_rproc_stop(struct rproc *rproc) {
> > +	struct device *dev =3D rproc->dev.parent;
> > +	struct zynqmp_r5_rproc_pdata *local =3D rproc->priv;
> > +	struct rproc_mem_entry *mem, *nmem;
> > +	const struct zynqmp_eemi_ops *eemi =3D
> > zynqmp_pm_get_eemi_ops();
>=20
> Is it pointer on secure interface to control coprocessor?
> As it is used in most of functions, maybe ops could be recovered and
> checked only once at probe time?
I will do the checking at probe time. And fails probing if it is not there.
>=20
> > +
> > +	dev_dbg(dev, "%s\n", __func__);
> > +
> > +	if (!eemi || !eemi->force_powerdown) {
> > +		pr_err("Failed to stop R5\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	disable_ipi(local);
> > +	eemi->force_powerdown(local->rpu_pnode_id,
> > +			      ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > +
> > +	return 0;
> > +}
> > +
> > +static void *zynqmp_r5_rproc_da_to_va(struct rproc *rproc, u64 da,
> > +int len) {
> > +	struct rproc_mem_entry *mem;
> > +	void *va =3D NULL;
> > +	struct zynqmp_r5_rproc_pdata *local =3D rproc->priv;
> > +
> > +	list_for_each_entry(mem, &local->mems, node) {
> > +		int offset =3D da - mem->da;
> > +
> > +		/* try next carveout if da is too small */
> > +		if (offset < 0)
> > +			continue;
> > +
> > +		/* try next carveout if da is too large */
> > +		if (offset + len > mem->len)
> > +			continue;
> > +
> > +		va =3D mem->va + offset;
> > +
> > +		break;
> > +	}
> > +	return va;
> > +}
> > +
> > +static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct
> > +firmware
> > *fw)
> > +{
> > +	int ret;
> > +
> > +	ret =3D rproc_elf_load_rsc_table(rproc, fw);
> > +	if (ret =3D=3D -EINVAL)
> > +		/* No resource table */
> > +		return 0;
> > +	else
> > +		return ret;
> > +}
> > +
> > +static struct rproc_ops zynqmp_r5_rproc_ops =3D {
> > +	.start		=3D zynqmp_r5_rproc_start,
> > +	.stop		=3D zynqmp_r5_rproc_stop,
> > +	.kick		=3D zynqmp_r5_rproc_kick,
> > +	.da_to_va       =3D zynqmp_r5_rproc_da_to_va,
> > +};
> > +
> > +/* Release R5 from reset and make it halted.
> > + * In case the firmware uses TCM, in order to load firmware to TCM,
> > + * will need to release R5 from reset and stay in halted state.
> > + */
> > +static int zynqmp_r5_rproc_init(struct rproc *rproc) {
> > +	struct device *dev =3D rproc->dev.parent;
> > +	struct zynqmp_r5_rproc_pdata *local =3D rproc->priv;
> > +
> > +	dev_dbg(dev, "%s\n", __func__);
> > +	enable_ipi(local);
> > +	return 0;
> > +}
>=20
> Comment not aligned with function content. Only IPI enable here.
Will fix the comments in the next version.
> > +
> > +static irqreturn_t r5_remoteproc_interrupt(int irq, void *dev_id) {
> > +	struct device *dev =3D dev_id;
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	struct rproc *rproc =3D platform_get_drvdata(pdev);
> > +	struct zynqmp_r5_rproc_pdata *local =3D rproc->priv;
> > +	u32 ipi_reg;
> > +
> > +	/* Check if there is a kick from R5 */
> > +	ipi_reg =3D reg_read(local->ipi_base, ISR_OFFSET);
> > +	if (!(ipi_reg & local->ipi_dest_mask))
> > +		return IRQ_NONE;
> > +
> > +	dev_dbg(dev, "KICK Linux because of pending message(irq%d)\n",
> > irq);
> > +	reg_write(local->ipi_base, ISR_OFFSET, local->ipi_dest_mask);
> > +	schedule_work(&local->workqueue);
> > +
> > +	return IRQ_HANDLED;
> > +}
>=20
> Should be part of IPI mailbox driver.
[Wendy] the IPI mailbox driver patches are under discussion. I am trying to=
 upstream
this driver independent to the mailbox driver. I can update this driver aft=
er the
Mailbox driver is upstreamed.

>=20
> > +
> > +/* zynqmp_r5_get_tcm_memories() - get tcm memories
> > + * @pdev: pointer to the platform device
> > + * @pdata: pointer to the remoteproc private data
> > + *
> > + * Function to create remoteproc memory entries for TCM memories.
> > + */
> > +static int zynqmp_r5_get_tcms(struct platform_device *pdev,
> > +			      struct zynqmp_r5_rproc_pdata *pdata) {
> > +	static const char * const mem_names[] =3D {"tcm_a", "tcm_b"};
> > +	struct device *dev =3D &pdev->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	int num_mems =3D 0;
> > +	int i, ret;
> > +	struct property *prop;
> > +	const __be32 *cur;
> > +	u32 val;
> > +	const struct zynqmp_eemi_ops *eemi =3D
> > zynqmp_pm_get_eemi_ops();
> > +
> > +	/* Get TCM power node ids */
> > +	i =3D 0;
> > +	of_property_for_each_u32(np, "tcm-pnode-id", prop, cur, val)
> > +		pdata->tcm_pnode_id[i++] =3D val;
> > +
> > +	/* Request TCMs */
> > +	for (i =3D 0; i < MAX_TCM_PNODES; i++) {
> > +		if (pdata->tcm_pnode_id[i] !=3D 0) {
> > +			ret =3D eemi->request_node(pdata->tcm_pnode_id[i],
> > +
> > ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > +
> > ZYNQMP_PM_REQUEST_ACK_BLOCKING
> > +						);
> > +			if (ret < 0) {
> > +				dev_err(dev, "failed to request TCM: %u\n",
> > +					pdata->tcm_pnode_id[i]);
> > +				return ret;
> > +			}
> > +			dev_dbg(dev, "request tcm pnode: %u\n",
> > +				pdata->tcm_pnode_id[i]);
> > +		} else {
> > +			break;
> > +		}
> > +	}
> > +	/* Create remoteproc memories entries for TCM memories */
> > +	num_mems =3D ARRAY_SIZE(mem_names);
> > +	for (i =3D 0; i < num_mems; i++) {
> > +		struct resource *res;
> > +		struct rproc_mem_entry *mem;
> > +		dma_addr_t dma;
> > +		resource_size_t size;
> > +
> > +		res =3D platform_get_resource_byname(pdev,
> > IORESOURCE_MEM,
> > +						   mem_names[i]);
> > +		mem  =3D devm_kzalloc(dev, sizeof(struct rproc_mem_entry),
> > +				    GFP_KERNEL);
> > +		if (!mem)
> > +			return -ENOMEM;
> > +		/* Map it as normal memory */
> > +		size =3D resource_size(res);
> > +		mem->va =3D devm_ioremap_wc(dev, res->start, size);
> > +		mem->len =3D size;
> > +		dma =3D (dma_addr_t)res->start;
> > +		mem->dma =3D dma;
> > +		/* TCM memory:
> > +		 *   TCM_0: da 0 <-> global addr 0xFFE00000
> > +		 *   TCM_1: da 0 <-> global addr 0xFFE90000
> > +		 */
> > +		if ((dma & 0xFFF00000) =3D=3D 0xFFE00000) {
> > +			if ((dma & 0xFFF80000) =3D=3D 0xFFE80000)
> > +				mem->da -=3D 0x90000;
> > +			else
> > +				mem->da =3D (dma & 0x000FFFFF);
> > +		}
> > +		dev_dbg(dev, "%s: va =3D %p, da =3D 0x%x dma =3D 0x%llx\n",
> > +			__func__, mem->va, mem->da, mem->dma);
> > +		list_add_tail(&mem->node, &pdata->mems);
>=20
> Looks like carevout patch series [1]. Did you try it? I think it is bette=
r to
> communalize code instead of duplicated it in each platform driver.
> [1] https://lkml.org/lkml/2018/7/27/612
I was aware that you have defined rproc_mem_entry_init() and rproc_add_carv=
eout()
Functions, just those patches are not in upstream yet. I didn't use them in=
 this patch.
I can change to use those functions in the next version.
>=20
> > +	}
> > +	return 0;
> > +}
> > +
> > +/* zynqmp_r5_get_reserved_mems() - get reserved memories
> > + * @pdev: pointer to the platform device
> > + * @pdata: pointer to the remoteproc private data
> > + *
> > + * Function to create remoteproc memory entries from memory-region
> > + * property.
> > + */
> > +static int zynqmp_r5_get_reserved_mems(struct platform_device *pdev,
> > +				       struct zynqmp_r5_rproc_pdata *pdata) {
> > +	struct device *dev =3D &pdev->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	int num_mems;
> > +	int i;
> > +
> > +	num_mems =3D of_count_phandle_with_args(np, "memory-region",
> > NULL);
> > +	if (num_mems <=3D 0)
> > +		return 0;
> > +	for (i =3D 0; i < num_mems; i++) {
> > +		struct device_node *node;
> > +		struct resource res;
> > +		resource_size_t size;
> > +		struct rproc_mem_entry *mem;
> > +		int ret;
> > +
> > +		node =3D of_parse_phandle(np, "memory-region", i);
> > +		ret =3D of_device_is_compatible(node, "rproc-prog-memory");
> > +		if (!ret) {
> > +			/* it is DMA memory. */
> > +			dev_info(dev, "%s, dma memory %d\n", __func__,
> > i);
> > +			ret =3D of_reserved_mem_device_init_by_idx(dev,
> > +								 np, i);
> > +			if (ret) {
> > +				dev_err(dev, "unable to reserve DMA
> > mem.\n");
> > +				return ret;
> > +			}
> > +			continue;
> > +		}
> > +		ret =3D of_address_to_resource(node, 0, &res);
> > +		if (ret) {
> > +			dev_err(dev, "unable to resolve memory region.\n");
> > +			return ret;
> > +		}
> > +		mem  =3D devm_kzalloc(dev, sizeof(struct rproc_mem_entry),
> > +				    GFP_KERNEL);
> > +		if (!mem)
> > +			return -ENOMEM;
> > +		/* Map it as normal memory */
> > +		size =3D resource_size(&res);
> > +		mem->va =3D devm_ioremap_wc(dev, res.start, size);
> > +		mem->len =3D size;
> > +		mem->dma =3D (dma_addr_t)res.start;
> > +		mem->da =3D (u32)res.start;
> > +		dev_dbg(dev, "%s: va =3D %p, da =3D 0x%x dma =3D 0x%llx\n",
> > +			__func__, mem->va, mem->da, mem->dma);
> > +		list_add_tail(&mem->node, &pdata->mems);
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev) {
> > +	const unsigned char *prop;
> > +	struct resource *res;
> > +	int ret =3D 0;
> > +	struct zynqmp_r5_rproc_pdata *local;
> > +	struct rproc *rproc;
> > +
> > +	rproc =3D rproc_alloc(&pdev->dev, dev_name(&pdev->dev),
> > +			    &zynqmp_r5_rproc_ops, NULL,
> > +		sizeof(struct zynqmp_r5_rproc_pdata));
> > +	if (!rproc) {
> > +		dev_err(&pdev->dev, "rproc allocation failed\n");
> > +		return -ENOMEM;
> > +	}
> > +	local =3D rproc->priv;
> > +	local->rproc =3D rproc;
> > +
> > +	platform_set_drvdata(pdev, rproc);
> > +
> > +	/* Override parse_fw op to allow no resource table firmware */
> > +	rproc->ops->parse_fw =3D zynqmp_r5_parse_fw;
> > +
> > +	ret =3D dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "dma_set_coherent_mask: %d\n",
> > ret);
> > +		goto rproc_fault;
> > +	}
> > +
> > +	/* Get the RPU power domain id */
> > +	ret =3D of_property_read_u32(pdev->dev.of_node, "rpu-pnode-id",
> > +				   &local->rpu_pnode_id);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "No RPU power node ID is
> > specified.\n");
> > +		ret =3D -EINVAL;
> > +		goto rproc_fault;
> > +	}
> > +	dev_dbg(&pdev->dev, "RPU[%d] pnode_id =3D %d.\n",
> > +		local->rpu_id, local->rpu_pnode_id);
> > +
> > +	prop =3D of_get_property(pdev->dev.of_node, "core_conf", NULL);
> > +	if (!prop) {
> > +		dev_warn(&pdev->dev, "default core_conf used: lock-
> > step\n");
> > +		prop =3D "lock-step";
> > +	}
> > +
> > +	dev_info(&pdev->dev, "RPU core_conf: %s\n", prop);
> > +	if (!strcmp(prop, "split0")) {
> > +		local->rpu_mode =3D PM_RPU_MODE_SPLIT;
> > +		local->rpu_id =3D 0;
> > +		local->ipi_dest_mask =3D RPU_0_IPI_MASK;
> > +	} else if (!strcmp(prop, "split1")) {
> > +		local->rpu_mode =3D PM_RPU_MODE_SPLIT;
> > +		local->rpu_id =3D 1;
> > +		local->ipi_dest_mask =3D RPU_1_IPI_MASK;
> > +	} else if (!strcmp(prop, "lock-step")) {
> > +		local->rpu_mode =3D PM_RPU_MODE_LOCKSTEP;
> > +		local->rpu_id =3D 0;
> > +		local->ipi_dest_mask =3D RPU_0_IPI_MASK;
> > +	} else {
> > +		dev_err(&pdev->dev, "Invalid core_conf mode provided - %s
> > , %d\n",
> > +			prop, local->rpu_mode);
> > +		ret =3D -EINVAL;
> > +		goto rproc_fault;
> > +	}
> > +
> > +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > "ipi");
> > +	if (res) {
> > +		local->ipi_base =3D devm_ioremap(&pdev->dev, res->start,
> > +					       resource_size(res));
> > +		if (IS_ERR(local->ipi_base)) {
> > +			pr_err("%s: Unable to map IPI\n", __func__);
> > +			ret =3D PTR_ERR(local->ipi_base);
> > +			goto rproc_fault;
> > +		}
> > +	} else {
> > +		dev_info(&pdev->dev, "IPI resource is not specified.\n");
> > +	}
> > +	dev_dbg(&pdev->dev, "got ipi base address\n");
> > +
> > +	INIT_LIST_HEAD(&local->mems);
> > +	/* Get TCM memories */
> > +	ret =3D zynqmp_r5_get_tcms(pdev, local);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "failed to get TCM memories.\n");
> > +		goto rproc_fault;
> > +	}
> > +	dev_dbg(&pdev->dev, "got TCM memories\n");
> > +	/* Get reserved memory regions for firmware */
> > +	ret =3D zynqmp_r5_get_reserved_mems(pdev, local);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "failed to get reserved memories.\n");
> > +		goto rproc_fault;
> > +	}
> > +	dev_dbg(&pdev->dev, "got reserved memories.\n");
> > +
> > +	/* Disable IPI before requesting IPI IRQ */
> > +	disable_ipi(local);
> > +	INIT_WORK(&local->workqueue, handle_event_notified);
> > +
> > +	/* IPI IRQ */
> > +	if (local->ipi_base) {
> > +		ret =3D platform_get_irq(pdev, 0);
> > +		if (ret < 0) {
> > +			dev_err(&pdev->dev, "unable to find IPI IRQ\n");
> > +			goto rproc_fault;
> > +		}
> > +		local->irq =3D ret;
> > +		ret =3D devm_request_irq(&pdev->dev, local->irq,
> > +				       r5_remoteproc_interrupt, IRQF_SHARED,
> > +				       dev_name(&pdev->dev), &pdev->dev);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "IRQ %d already allocated\n",
> > +				local->irq);
> > +			goto rproc_fault;
> > +		}
> > +		dev_dbg(&pdev->dev, "notification irq: %d\n", local->irq);
> > +	}
> > +
> > +	ret =3D zynqmp_r5_rproc_init(local->rproc);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "failed to init ZynqMP R5 rproc\n");
> > +		goto rproc_fault;
> > +	}
> > +
> > +	rproc->auto_boot =3D autoboot;
> > +
> > +	ret =3D rproc_add(local->rproc);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "rproc registration failed\n");
> > +		goto rproc_fault;
> > +	}
> > +
> > +	return ret;
> > +
> > +rproc_fault:
> > +	rproc_free(local->rproc);
> > +
> > +	return ret;
> > +}
> > +
> > +static int zynqmp_r5_remoteproc_remove(struct platform_device *pdev)
> > +{
> > +	struct rproc *rproc =3D platform_get_drvdata(pdev);
> > +	struct zynqmp_r5_rproc_pdata *local =3D rproc->priv;
> > +	struct rproc_mem_entry *mem;
> > +
> > +	dev_info(&pdev->dev, "%s\n", __func__);
> > +
> > +	rproc_del(rproc);
> > +
> > +	list_for_each_entry(mem, &local->mems, node) {
> > +		if (mem->priv)
> > +			gen_pool_free((struct gen_pool *)mem->priv,
> > +				      (unsigned long)mem->va, mem->len);
> > +	}
> > +
> > +	r5_release_tcm(local);
> > +	of_reserved_mem_device_release(&pdev->dev);
> > +	rproc_free(rproc);
> > +
> > +	return 0;
> > +}
> > +
> > +/* Match table for OF platform binding */ static const struct
> > +of_device_id zynqmp_r5_remoteproc_match[] =3D {
> > +	{ .compatible =3D "xlnx,zynqmp-r5-remoteproc-1.0", },
> > +	{ /* end of list */ },
> > +};
> > +MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
> > +
> > +static struct platform_driver zynqmp_r5_remoteproc_driver =3D {
> > +	.probe =3D zynqmp_r5_remoteproc_probe,
> > +	.remove =3D zynqmp_r5_remoteproc_remove,
> > +	.driver =3D {
> > +		.name =3D "zynqmp_r5_remoteproc",
> > +		.of_match_table =3D zynqmp_r5_remoteproc_match,
> > +	},
> > +};
> > +module_platform_driver(zynqmp_r5_remoteproc_driver);
> > +
> > +module_param_named(autoboot,  autoboot, bool, 0444);
> > +MODULE_PARM_DESC(autoboot,
> > +		 "enable | disable autoboot. (default: true)");
> > +
> > +MODULE_AUTHOR("Jason Wu <j.wu@xilinx.com>");
> MODULE_LICENSE("GPL
> > +v2"); MODULE_DESCRIPTION("ZynqMP R5 remote processor control
> > +driver");
> > --
> > 2.7.4

