Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352E5C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 07:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08B120858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 07:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="asbaYdtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08B120858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeGVIDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 04:03:38 -0400
Received: from mail-by2nam01on0048.outbound.protection.outlook.com ([104.47.34.48]:19774
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727853AbeGVIDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 04:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+h/Eru+xtSX7KhnvqzDJhSA8QTMViuhhUfhd60BoLI=;
 b=asbaYdtMbBqcUmHOahHilUregI9vDh5wlavGGwDEArTN0gphj5nk9pkO8eKjgcV/KVuJQMIKJRm44tbElwwN7T9hnJ4UOKwNr/2DKLAOHLxQ370uI/5v3xBBszynY+Rr9HcrusPoxNCN7unZRJwmXL/eOIuM2bDrrsI/SH2k300=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2301.namprd02.prod.outlook.com (10.168.243.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Sun, 22 Jul 2018 07:04:44 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::3cbb:410c:be52:450]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::3cbb:410c:be52:450%5]) with mapi id 15.20.0973.018; Sun, 22 Jul 2018
 07:04:41 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "mmayer@broadcom.com" <mmayer@broadcom.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "ada@thorsis.co" <ada@thorsis.co>,
        "honghui.zhang@mediatek.com" <honghui.zhang@mediatek.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [LINUX PATCH v11 3/3] mtd: rawnand: pl353: Add basic driver for
 arm pl353 smc nand interface
Thread-Topic: [LINUX PATCH v11 3/3] mtd: rawnand: pl353: Add basic driver for
 arm pl353 smc nand interface
Thread-Index: AQHUGOoLniN+aTtuWkq5HvPOVPEQk6SZO2Pw
Date:   Sun, 22 Jul 2018 07:04:41 +0000
Message-ID: <MWHPR02MB2623DFB0D13FF25DECC16027AF570@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1531294612-29526-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1531294612-29526-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
In-Reply-To: <1531294612-29526-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-originating-ip: [183.83.194.18]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2301;6:QlaF28cL9DSYVdVifAfJh+AThE4OAEiUudq36pg/29WWvoODBD8XXjCbHjAf9DuT4mqkdn6fvzZw2KsWd/fvcI28Dl9UTujRgWd80ZSLGHZ66D2UEjjftS6krQ30+Ciz4iRqsoCxTA8beQywtGxaEpjg2CVEb3WohczwKy0TAcoitOpFcuj64dg4icFSa48c6UpIeg8kCGGXehPHf3V3zs/eRUP/p5sa81J7fJMSqd1ZNNov8GsGzqwRgJms4PQJGZa8bHCD4uwNkHDE1GjrGXbiOEjv3W1xJDpd9p3D35EbwI3/qFCc5NEWWltOVRIEi8UYl0GwJEyJkbgr7tk9PER+c3zgzARh/be38I+4SuETIRJbyDePEpvKBnN7uIYmUOWeiV2uRc2NdVFxlSJUEioXNsvRU6Byb7585hBXwDL2Qjgb2cYMQZFKuZIAZDtPSrkcko3KEXHmiP0Xbd+b+g==;5:gIdU7l49ZOawlOAHzFW7t6Nq9FHk9dOq+taoQOqlg3F1bmpmqUzyXICUZQtM9s/x60WrHOHAfUqevXTakEzw5X1HdKRdvkesQWWwiGFY1TEylysqBECevhhsqaNUiiTTDSxPNg5duNtzWfpzsRiQfhnn5/1lLO6ECvjFpTdaGGA=;7:H+NKw1KznuPMyi64NEd64zklQDC/rXzrFqmOteVPCZilRhFTJW3GyYm754BpErZW4B2rXW/yE4mYJ0OIeMK4Ji56yviAvXeeFPNOIEVTqM/BmGS99igbAgwky+5ErsB9vncm0ZzUGIHJMLPaFKqGrHJWKvpdkXW3/CsMIoWduDAJmG/ALBwZjb/LyCBNkb6Pmz8/SkGSsu9InC64VF87v1JmYnKnnS8vBN5LYeeZElj2yz7XaoYlgDjXgpvDqpez
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(136003)(39860400002)(396003)(13464003)(189003)(199004)(305945005)(26005)(6436002)(2501003)(53546011)(6506007)(53946003)(478600001)(39060400002)(76176011)(7696005)(16200700003)(25786009)(2201001)(446003)(53936002)(55016002)(256004)(97736004)(9686003)(99286004)(14444005)(11346002)(486006)(229853002)(5250100002)(102836004)(476003)(66066001)(81156014)(81166006)(316002)(4326008)(33656002)(110136005)(2906002)(14454004)(8676002)(7416002)(2900100001)(106356001)(575784001)(86362001)(105586002)(54906003)(217873002)(5660300001)(74316002)(6246003)(107886003)(7736002)(3846002)(6116002)(68736007)(8936002)(921003)(1121003)(559001)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2301;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: b7ea71f6-c762-4a41-f0bc-08d5efa16575
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2301;
x-ms-traffictypediagnostic: MWHPR02MB2301:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-microsoft-antispam-prvs: <MWHPR02MB230178DDE7D664E006ABBAB4AF570@MWHPR02MB2301.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(208715162771679)(31051911155226)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2301;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2301;
x-forefront-prvs: 0741C77572
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jBe4pi6VDgTPTJT1Q8BoToCk8z6gld6fLkHZyD7gMeHaFoJJ6i9zfRiWpfY2lNeUoWEG0Yckli5aEku+OmXsUCCfDdPwQpuw8uPvcQikhcuIaFAT/sbpTj5tNaShBwbpOLJE6CZOcOC3RA3sFaGBip+FC6tCh3KTrC1eFp4K27JQyzd6ASuB1NBNGIk76g8Ed1/5U7u2j4me6pT56KkB6iwDiXdmR5EiyKAsQgxLOAM/SqrUa0v5jY/O+CFWOD9vRuYdFSZuXr1sDunFtxgpQ8JBA0IkzTn7bYk8w2ivDaesMbfXkSIhIrWOr/BpiichdiSYOR9VKsM38Rxl/KdFfakg340sbyspcgvL2Ypu/M0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ea71f6-c762-4a41-f0bc-08d5efa16575
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2018 07:04:41.2673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

Could you please provide your review comments?
I will address if any.

Thanks,
Naga Sureshkumar Relli.

> -----Original Message-----
> From: Naga Sureshkumar Relli [mailto:naga.sureshkumar.relli@xilinx.com]
> Sent: Wednesday, July 11, 2018 1:07 PM
> To: boris.brezillon@bootlin.com; richard@nod.at; dwmw2@infradead.org;
> computersforpeace@gmail.com; marek.vasut@gmail.com; f.fainelli@gmail.com;
> mmayer@broadcom.com; rogerq@ti.com; ladis@linux-mips.org; ada@thorsis.co;
> honghui.zhang@mediatek.com; miquel.raynal@bootlin.com; linus.walleij@lina=
ro.org
> Cc: linux-mtd@lists.infradead.org; linux-kernel@vger.kernel.org;
> nagasureshkumarrelli@gmail.com; Michal Simek <michals@xilinx.com>; Naga S=
ureshkumar
> Relli <nagasure@xilinx.com>
> Subject: [LINUX PATCH v11 3/3] mtd: rawnand: pl353: Add basic driver for =
arm pl353 smc
> nand interface
>=20
> Add driver for arm pl353 static memory controller nand interface with HW =
ECC support. This
> controller is used in Xilinx Zynq SoC for interfacing the NAND flash memo=
ry.
>=20
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> ---
> Changes in v11:
>  - Removed Documentation patch and added the required info in driver as
>    per Boris comments.
>  - Removed unwanted variables from pl353_nand_info as per Miquel comments
>  - Removed IO_ADDR_R/W.
>  - Replaced onhot() with hweight32()
>  - Defined macros for static values in function pl353_nand_correct_data()
>  - Removed all unnecessary delays
>  - Used nand_wait_ready() where ever is required
>  - Modifed the pl353_setup_data_interface() logic as per Miquel comments.
>  - Taken array instead of 7 values in pl353_setup_data_interface() and pa=
ss
>    it to smc driver.
>  - Added check to collect the return value of mtd_device_register().
> Changes in 10:
>  - Typos correction like nand to NAND and soc to SOC etc..
>  - Defined macros for the values in pl353_nand_calculate_hwecc()
>  - Modifed ecc_status from int to char in pl353_nand_calculate_hwecc()
>  - Changed the return type form int to bool to the function
>    onehot()
>  - Removed udelay(1000) in pl353_cmd_function, as it is not required
>  - Dropped ecc->hwctl =3D NULL in pl353_ecc_init()
>  - Added an error message in pl353_ecc_init(), when there is no matching
>    oobsize
>  - Changed the variable from xnand to xnfc
>  - Added logic to get mtd->name from DT, if it is specified in DT Changes=
 in v9:
>  - Addressed the below comments given by Miquel
>  - instead of using pl353_nand_write32, use directly writel_relaxed
>  - Fixed check patch warnings
>  - Renamed write_buf/read_buf to write_data_op/read_data_op
>  - use BIT macro instead of 1 << nr
>  - Use NAND_ROW_ADDR_3 flag
>  - Use nand_wait_ready()
>  - Removed swecc functions
>  - Use address cycles as per size, instead of reading it from Parameter p=
age
>  - Instead of writing too many patterns, use optional property Changes in=
 v8:
>  - Added exec_op() implementation
>  - Fixed the below v7 review comments
>  - removed mtd_info from pl353_nand_info struct
>  - Corrected ecc layout offsets
>  - Added on-die ecc support
> Changes in v7:
>  - Currently not implemented the memclk rate adjustments. I will
>    look into this later and once the basic driver is accepted.
>  - Fixed GPL licence ident
> Changes in v6:
>  - Fixed the checkpatch.pl reported warnings
>  - Using the address cycles information from the onfi param page
>    earlier it is hardcoded to 5 in driver Changes in v5:
>  - Configure the nand timing parameters as per the onfi spec Changes in v=
4:
>  - Updated the driver to sync with pl353_smc driver APIs Changes in v3:
>  - implemented the proper error codes
>  - further breakdown this patch to multiple sets
>  - added the controller and driver details to Documentation section
>  - updated the licenece to GPLv2
>  - reorganized the pl353_nand_ecc_init function Changes in v2:
>  - use "depends on" rather than "select" option in kconfig
>  - remove unused variable parts
> ---
>  drivers/mtd/nand/raw/Kconfig      |    7 +
>  drivers/mtd/nand/raw/Makefile     |    1 +
>  drivers/mtd/nand/raw/pl353_nand.c | 1314
> +++++++++++++++++++++++++++++++++++++
>  3 files changed, 1322 insertions(+)
>  create mode 100644 drivers/mtd/nand/raw/pl353_nand.c
>=20
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig =
index
> 6871ff0..1c5d528 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -530,4 +530,11 @@ config MTD_NAND_MTK
>  	  Enables support for NAND controller on MTK SoCs.
>  	  This controller is found on mt27xx, mt81xx, mt65xx SoCs.
>=20
> +config MTD_NAND_PL353
> +	tristate "ARM Pl353 NAND flash driver"
> +	depends on MTD_NAND && ARM
> +	depends on PL353_SMC
> +	help
> +	  Enables support for PrimeCell Static Memory Controller PL353.
> +
>  endif # MTD_NAND
> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefil=
e index
> 165b7ef..1c702e1 100644
> --- a/drivers/mtd/nand/raw/Makefile
> +++ b/drivers/mtd/nand/raw/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_MTD_NAND_HISI504)	        +=3D hisi504_nan=
d.o
>  obj-$(CONFIG_MTD_NAND_BRCMNAND)		+=3D brcmnand/
>  obj-$(CONFIG_MTD_NAND_QCOM)		+=3D qcom_nandc.o
>  obj-$(CONFIG_MTD_NAND_MTK)		+=3D mtk_ecc.o mtk_nand.o
> +obj-$(CONFIG_MTD_NAND_PL353)		+=3D pl353_nand.o
>=20
>  nand-objs :=3D nand_base.o nand_bbt.o nand_timings.o nand_ids.o  nand-ob=
js +=3D nand_amd.o
> diff --git a/drivers/mtd/nand/raw/pl353_nand.c b/drivers/mtd/nand/raw/pl3=
53_nand.c
> new file mode 100644
> index 0000000..3fa9ba07
> --- /dev/null
> +++ b/drivers/mtd/nand/raw/pl353_nand.c
> @@ -0,0 +1,1314 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ARM PL353 NAND flash controller driver
> + *
> + * Copyright (C) 2017 Xilinx, Inc
> + * Author: Punnaiah chowdary kalluri <punnaiah@xilinx.com>
> + * Author: Naga Sureshkumar Relli <nagasure@xilinx.com>
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/rawnand.h>
> +#include <linux/mtd/nand_ecc.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/pl353-smc.h>
> +#include <linux/clk.h>
> +
> +#define PL353_NAND_DRIVER_NAME "pl353-nand"
> +
> +/* NAND flash driver defines */
> +#define PL353_NAND_CMD_PHASE	1	/* End command valid in command
> phase */
> +#define PL353_NAND_DATA_PHASE	2	/* End command valid in data phase */
> +#define PL353_NAND_ECC_SIZE	512	/* Size of data for ECC operation */
> +
> +/* Flash memory controller operating parameters */
> +
> +#define PL353_NAND_ECC_CONFIG	(BIT(4)  |	/* ECC read at end of page */
> \
> +				 (0 << 5))	/* No Jumping */
> +
> +/* AXI Address definitions */
> +#define START_CMD_SHIFT		3
> +#define END_CMD_SHIFT		11
> +#define END_CMD_VALID_SHIFT	20
> +#define ADDR_CYCLES_SHIFT	21
> +#define CLEAR_CS_SHIFT		21
> +#define ECC_LAST_SHIFT		10
> +#define COMMAND_PHASE		(0 << 19)
> +#define DATA_PHASE		BIT(19)
> +
> +#define PL353_NAND_ECC_LAST	BIT(ECC_LAST_SHIFT)	/* Set ECC_Last */
> +#define PL353_NAND_CLEAR_CS	BIT(CLEAR_CS_SHIFT)	/* Clear chip select */
> +
> +#define ONDIE_ECC_FEATURE_ADDR	0x90
> +#define PL353_NAND_ECC_BUSY_TIMEOUT	(1 * HZ)
> +#define PL353_NAND_DEV_BUSY_TIMEOUT	(1 * HZ)
> +#define PL353_NAND_LAST_TRANSFER_LENGTH	4
> +#define PL353_NAND_ECC_VALID_SHIFT	24
> +#define PL353_NAND_ECC_VALID_MASK	0x40
> +#define PL353_ECC_BITS_BYTEOFF_MASK	0x1FF
> +#define PL353_ECC_BITS_BITOFF_MASK	0x7
> +#define PL353_ECC_BIT_MASK		0xFFF
> +#define PL353_TREA_MAX_VALUE		1
> +
> +struct pl353_nfc_op {
> +	u32 cmnds[4];
> +	u32 thirdrow;
> +	u32 type;
> +	u32 end_cmd;
> +	u32 addrs;
> +	u32 len;
> +	u32 naddrs;
> +	u32 addr5;
> +	u32 addr6;
> +	unsigned int data_instr_idx;
> +	unsigned int rdy_timeout_ms;
> +	unsigned int rdy_delay_ns;
> +	unsigned int cle_ale_delay_ns;
> +	const struct nand_op_instr *data_instr; };
> +
> +/**
> + * struct pl353_nand_info - Defines the NAND flash driver instance
> + * @chip:		NAND chip information structure
> + * @dev:		Parent device (used to print error messages)
> + * @nand_base:		Virtual address of the NAND flash device
> + * @nandaddr:		Virtual address of the NAND flash device for
> + *			data read/writes
> + * @addr_cycles:	Address cycles
> + * @mclk:		Memory controller clock
> + */
> +struct pl353_nand_info {
> +	struct nand_chip chip;
> +	struct device *dev;
> +	void __iomem *nand_base;
> +	void __iomem *nandaddr;
> +	u8 addr_cycles;
> +	struct clk *mclk;
> +};
> +
> +static int pl353_ecc_ooblayout16_ecc(struct mtd_info *mtd, int section,
> +				     struct mtd_oob_region *oobregion) {
> +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> +
> +	if (section >=3D chip->ecc.steps)
> +		return -ERANGE;
> +
> +	oobregion->offset =3D (section * chip->ecc.bytes);
> +	oobregion->length =3D chip->ecc.bytes;
> +
> +	return 0;
> +}
> +
> +static int pl353_ecc_ooblayout16_free(struct mtd_info *mtd, int section,
> +				      struct mtd_oob_region *oobregion) {
> +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> +
> +	if (section >=3D chip->ecc.steps)
> +		return -ERANGE;
> +
> +	oobregion->offset =3D (section * chip->ecc.bytes) + 8;
> +	oobregion->length =3D 8;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops pl353_ecc_ooblayout16_ops =3D {
> +	.ecc =3D pl353_ecc_ooblayout16_ecc,
> +	.free =3D pl353_ecc_ooblayout16_free,
> +};
> +
> +static int pl353_ecc_ooblayout64_ecc(struct mtd_info *mtd, int section,
> +				     struct mtd_oob_region *oobregion) {
> +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> +
> +	if (section >=3D chip->ecc.steps)
> +		return -ERANGE;
> +
> +	oobregion->offset =3D (section * chip->ecc.bytes) + 52;
> +	oobregion->length =3D chip->ecc.bytes;
> +
> +	return 0;
> +}
> +
> +static int pl353_ecc_ooblayout64_free(struct mtd_info *mtd, int section,
> +				      struct mtd_oob_region *oobregion) {
> +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> +
> +	if (section)
> +		return -ERANGE;
> +
> +	if (section >=3D chip->ecc.steps)
> +		return -ERANGE;
> +
> +	oobregion->offset =3D (section * chip->ecc.bytes) + 2;
> +	oobregion->length =3D 50;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops pl353_ecc_ooblayout64_ops =3D {
> +	.ecc =3D pl353_ecc_ooblayout64_ecc,
> +	.free =3D pl353_ecc_ooblayout64_free,
> +};
> +
> +/* Generic flash bbt decriptors */
> +static u8 bbt_pattern[] =3D { 'B', 'b', 't', '0' }; static u8
> +mirror_pattern[] =3D { '1', 't', 'b', 'B' };
> +
> +static struct nand_bbt_descr bbt_main_descr =3D {
> +	.options =3D NAND_BBT_LASTBLOCK | NAND_BBT_CREATE |
> NAND_BBT_WRITE
> +		| NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP,
> +	.offs =3D 4,
> +	.len =3D 4,
> +	.veroffs =3D 20,
> +	.maxblocks =3D 4,
> +	.pattern =3D bbt_pattern
> +};
> +
> +static struct nand_bbt_descr bbt_mirror_descr =3D {
> +	.options =3D NAND_BBT_LASTBLOCK | NAND_BBT_CREATE |
> NAND_BBT_WRITE
> +		| NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP,
> +	.offs =3D 4,
> +	.len =3D 4,
> +	.veroffs =3D 20,
> +	.maxblocks =3D 4,
> +	.pattern =3D mirror_pattern
> +};
> +
> +/**
> + * pl353_nand_read_data_op - read chip data into buffer
> + * @chip:	Pointer to the NAND chip info structure
> + * @in:		Pointer to the buffer to store read data
> + * @len:	Number of bytes to read
> + * Return:	Always return zero
> + */
> +static int pl353_nand_read_data_op(struct nand_chip *chip,
> +				   u8 *in,
> +				   unsigned int len)
> +{
> +	int i;
> +	struct pl353_nand_info *xnfc =3D
> +		container_of(chip, struct pl353_nand_info, chip);
> +
> +	if (IS_ALIGNED((uint32_t)in, sizeof(uint32_t)) &&
> +	    IS_ALIGNED(len, sizeof(uint32_t))) {
> +		u32 *ptr =3D (u32 *)in;
> +
> +		len /=3D 4;
> +		for (i =3D 0; i < len; i++)
> +			ptr[i] =3D readl(xnfc->nandaddr);
> +	} else {
> +		for (i =3D 0; i < len; i++)
> +			in[i] =3D readb(xnfc->nandaddr);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_write_buf - write buffer to chip
> + * @mtd:	Pointer to the mtd info structure
> + * @buf:	Pointer to the buffer to store write data
> + * @len:	Number of bytes to write
> + */
> +static void pl353_nand_write_data_op(struct mtd_info *mtd, const u8 *buf=
,
> +				     int len)
> +{
> +	int i;
> +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> +	struct pl353_nand_info *xnfc =3D
> +		container_of(chip, struct pl353_nand_info, chip);
> +
> +	if (IS_ALIGNED((uint32_t)buf, sizeof(uint32_t)) &&
> +	    IS_ALIGNED(len, sizeof(uint32_t))) {
> +		u32 *ptr =3D (u32 *)buf;
> +
> +		len /=3D 4;
> +		for (i =3D 0; i < len; i++)
> +			writel(ptr[i], xnfc->nandaddr);
> +	} else {
> +		for (i =3D 0; i < len; i++)
> +			writeb(buf[i], xnfc->nandaddr);
> +	}
> +}
> +
> +/**
> + * pl353_nand_calculate_hwecc - Calculate Hardware ECC
> + * @mtd:	Pointer to the mtd_info structure
> + * @data:	Pointer to the page data
> + * @ecc:	Pointer to the ECC buffer where ECC data needs to be stored
> + *
> + * This function retrieves the Hardware ECC data from the controller
> +and returns
> + * ECC data back to the MTD subsystem.
> + * It operates on a number of 512 byte blocks of NAND memory and can be
> + * programmed to store the ECC codes after the data in memory. For
> +writes,
> + * the ECC is written to the spare area of the page. For reads, the
> +result of
> + * a block ECC check are made available to the device driver.
> + *
> + * ---------------------------------------------------------------------=
---
> + * |               n * 512 blocks                  | extra  | ecc    |  =
   |
> + * |                                               | block  | codes  |  =
   |
> + *
> +-----------------------------------------------------------------------
> +-
> + *
> + * The ECC calculation uses a simple Hamming code, using 1-bit
> +correction 2-bit
> + * detection. It starts when a valid read or write command with a 512
> +byte
> + * aligned address is detected on the memory interface.
> + *
> + * Return:	0 on success or error value on failure
> + */
> +static int pl353_nand_calculate_hwecc(struct mtd_info *mtd,
> +				      const u8 *data, u8 *ecc)
> +{
> +	u32 ecc_value;
> +	u8 ecc_reg, ecc_byte, ecc_status;
> +	unsigned long timeout =3D jiffies + PL353_NAND_ECC_BUSY_TIMEOUT;
> +
> +	/* Wait till the ECC operation is complete or timeout */
> +	do {
> +		if (pl353_smc_ecc_is_busy())
> +			cpu_relax();
> +		else
> +			break;
> +	} while (!time_after_eq(jiffies, timeout));
> +
> +	if (time_after_eq(jiffies, timeout)) {
> +		pr_err("%s timed out\n", __func__);
> +		return -ETIMEDOUT;
> +	}
> +
> +	for (ecc_reg =3D 0; ecc_reg < 4; ecc_reg++) {
> +		/* Read ECC value for each block */
> +		ecc_value =3D pl353_smc_get_ecc_val(ecc_reg);
> +		ecc_status =3D (ecc_value >> PL353_NAND_ECC_VALID_SHIFT);
> +		/* ECC value valid */
> +		if (ecc_status & PL353_NAND_ECC_VALID_MASK) {
> +			for (ecc_byte =3D 0; ecc_byte < 3; ecc_byte++) {
> +				/* Copy ECC bytes to MTD buffer */
> +				*ecc =3D ~ecc_value & 0xFF;
> +				ecc_value =3D ecc_value >> 8;
> +				ecc++;
> +			}
> +		} else {
> +			pr_warn("%s status failed\n", __func__);
> +			return -1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_correct_data - ECC correction function
> + * @mtd:	Pointer to the mtd_info structure
> + * @buf:	Pointer to the page data
> + * @read_ecc:	Pointer to the ECC value read from spare data area
> + * @calc_ecc:	Pointer to the calculated ECC value
> + *
> + * This function corrects the ECC single bit errors & detects 2-bit erro=
rs.
> + *
> + * Return:	0 if no ECC errors found
> + *		1 if single bit error found and corrected.
> + *		-1 if multiple uncorrectable ECC errors found.
> + */
> +static int pl353_nand_correct_data(struct mtd_info *mtd, unsigned char *=
buf,
> +				   unsigned char *read_ecc,
> +				   unsigned char *calc_ecc)
> +{
> +	unsigned char bit_addr;
> +	unsigned int byte_addr;
> +	unsigned short ecc_odd, ecc_even, read_ecc_lower, read_ecc_upper;
> +	unsigned short calc_ecc_lower, calc_ecc_upper;
> +
> +	read_ecc_lower =3D (read_ecc[0] | (read_ecc[1] << 8)) &
> +			  PL353_ECC_BIT_MASK;
> +	read_ecc_upper =3D ((read_ecc[1] >> 4) | (read_ecc[2] << 4)) &
> +			  PL353_ECC_BIT_MASK;
> +
> +	calc_ecc_lower =3D (calc_ecc[0] | (calc_ecc[1] << 8)) &
> +			  PL353_ECC_BIT_MASK;
> +	calc_ecc_upper =3D ((calc_ecc[1] >> 4) | (calc_ecc[2] << 4)) &
> +			  PL353_ECC_BIT_MASK;
> +
> +	ecc_odd =3D read_ecc_lower ^ calc_ecc_lower;
> +	ecc_even =3D read_ecc_upper ^ calc_ecc_upper;
> +
> +	/* no error */
> +	if (!ecc_odd && !ecc_even)
> +		return 0;
> +
> +	if (ecc_odd =3D=3D (~ecc_even & PL353_ECC_BIT_MASK)) {
> +		/* bits [11:3] of error code is byte offset */
> +		byte_addr =3D (ecc_odd >> 3) & PL353_ECC_BITS_BYTEOFF_MASK;
> +		/* bits [2:0] of error code is bit offset */
> +		bit_addr =3D ecc_odd & PL353_ECC_BITS_BITOFF_MASK;
> +		/* Toggling error bit */
> +		buf[byte_addr] ^=3D (BIT(bit_addr));
> +		return 1;
> +	}
> +
> +	/* one error in parity */
> +	if (hweight32(ecc_odd | ecc_even) =3D=3D 1)
> +		return 1;
> +
> +	/* Uncorrectable error */
> +	return -1;
> +}
> +
> +static void pl353_prepare_cmd(struct mtd_info *mtd, struct nand_chip *ch=
ip,
> +			      int page, int column, int start_cmd, int end_cmd,
> +			      bool read)
> +{
> +	unsigned long data_phase_addr;
> +	u32 end_cmd_valid =3D 0;
> +	unsigned long cmd_phase_addr =3D 0, cmd_data =3D 0;
> +
> +	struct pl353_nand_info *xnfc =3D
> +		container_of(chip, struct pl353_nand_info, chip);
> +
> +	end_cmd_valid =3D read ? 1 : 0;
> +
> +	cmd_phase_addr =3D (unsigned long __force)xnfc->nand_base +
> +			 ((xnfc->addr_cycles
> +			 << ADDR_CYCLES_SHIFT) |
> +			 (end_cmd_valid << END_CMD_VALID_SHIFT) |
> +			 (COMMAND_PHASE) |
> +			 (end_cmd << END_CMD_SHIFT) |
> +			 (start_cmd << START_CMD_SHIFT));
> +
> +	/* Get the data phase address */
> +	data_phase_addr =3D (unsigned long __force)xnfc->nand_base +
> +			  ((0x0 << CLEAR_CS_SHIFT) |
> +			  (0 << END_CMD_VALID_SHIFT) |
> +			  (DATA_PHASE) |
> +			  (end_cmd << END_CMD_SHIFT) |
> +			  (0x0 << ECC_LAST_SHIFT));
> +
> +	xnfc->nandaddr =3D (void __iomem * __force)data_phase_addr;
> +
> +	if (chip->options & NAND_BUSWIDTH_16)
> +		column /=3D 2;
> +	cmd_data =3D column;
> +	if (mtd->writesize > PL353_NAND_ECC_SIZE) {
> +		cmd_data |=3D page << 16;
> +		/* Another address cycle for devices > 128MiB */
> +		if (chip->options & NAND_ROW_ADDR_3) {
> +			writel_relaxed(cmd_data,
> +				       (void __iomem * __force)cmd_phase_addr);
> +			cmd_data =3D (page >> 16);
> +		}
> +	} else {
> +		cmd_data |=3D page << 8;
> +	}
> +
> +	writel_relaxed(cmd_data, (void __iomem * __force)cmd_phase_addr); }
> +
> +/**
> + * pl353_nand_read_oob - [REPLACEABLE] the most common OOB data read fun=
ction
> + * @mtd:	Pointer to the mtd info structure
> + * @chip:	Pointer to the NAND chip info structure
> + * @page:	Page number to read
> + *
> + * Return:	Always return zero
> + */
> +static int pl353_nand_read_oob(struct mtd_info *mtd, struct nand_chip *c=
hip,
> +			       int page)
> +{
> +	unsigned long data_phase_addr;
> +	u8 *p;
> +	struct pl353_nand_info *xnfc =3D
> +		container_of(chip, struct pl353_nand_info, chip);
> +	unsigned long nand_offset =3D (unsigned long __force)xnfc->nand_base;
> +
> +	chip->pagebuf =3D -1;
> +	if (mtd->writesize < PL353_NAND_ECC_SIZE)
> +		return 0;
> +
> +	pl353_prepare_cmd(mtd, chip, page, mtd->writesize, NAND_CMD_READ0,
> +			  NAND_CMD_READSTART, 1);
> +
> +	nand_wait_ready(mtd);
> +
> +	p =3D chip->oob_poi;
> +	pl353_nand_read_data_op(chip, p,
> +				(mtd->oobsize -
> +				PL353_NAND_LAST_TRANSFER_LENGTH));
> +	p +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +	data_phase_addr =3D (unsigned long __force)xnfc->nandaddr;
> +	data_phase_addr -=3D nand_offset;
> +	data_phase_addr |=3D PL353_NAND_CLEAR_CS;
> +	data_phase_addr +=3D nand_offset;
> +	xnfc->nandaddr =3D (void __iomem * __force)data_phase_addr;
> +	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_write_oob - [REPLACEABLE] the most common OOB data write f=
unction
> + * @mtd:	Pointer to the mtd info structure
> + * @chip:	Pointer to the NAND chip info structure
> + * @page:	Page number to write
> + *
> + * Return:	Zero on success and EIO on failure
> + */
> +static int pl353_nand_write_oob(struct mtd_info *mtd, struct nand_chip *=
chip,
> +				int page)
> +{
> +	const u8 *buf =3D chip->oob_poi;
> +	unsigned long data_phase_addr;
> +	struct pl353_nand_info *xnfc =3D
> +		container_of(chip, struct pl353_nand_info, chip);
> +	unsigned long nand_offset =3D (unsigned long __force)xnfc->nand_base;
> +	u32 addrcycles =3D 0;
> +
> +	chip->pagebuf =3D -1;
> +	addrcycles =3D xnfc->addr_cycles;
> +	pl353_prepare_cmd(mtd, chip, page, mtd->writesize, NAND_CMD_SEQIN,
> +			  NAND_CMD_PAGEPROG, 0);
> +
> +	pl353_nand_write_data_op(mtd, buf,
> +				 (mtd->oobsize -
> +				 PL353_NAND_LAST_TRANSFER_LENGTH));
> +	buf +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	data_phase_addr =3D (unsigned long __force)xnfc->nandaddr;
> +	data_phase_addr -=3D nand_offset;
> +	data_phase_addr |=3D PL353_NAND_CLEAR_CS;
> +	data_phase_addr |=3D (1 << END_CMD_VALID_SHIFT);
> +	data_phase_addr +=3D nand_offset;
> +	xnfc->nandaddr =3D (void __iomem * __force)data_phase_addr;
> +	pl353_nand_write_data_op(mtd, buf, PL353_NAND_LAST_TRANSFER_LENGTH);
> +	nand_wait_ready(mtd);
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_read_page_raw - [Intern] read raw page data without ecc
> + * @mtd:		Pointer to the mtd info structure
> + * @chip:		Pointer to the NAND chip info structure
> + * @buf:		Pointer to the data buffer
> + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> + * @page:		Page number to read
> + *
> + * Return:	Always return zero
> + */
> +static int pl353_nand_read_page_raw(struct mtd_info *mtd,
> +				    struct nand_chip *chip,
> +				    u8 *buf, int oob_required, int page) {
> +	unsigned long data_phase_addr;
> +	u8 *p;
> +	struct pl353_nand_info *xnfc =3D
> +		container_of(chip, struct pl353_nand_info, chip);
> +	unsigned long nand_offset =3D (unsigned long __force)xnfc->nand_base;
> +
> +	pl353_nand_read_data_op(chip, buf, mtd->writesize);
> +	p =3D chip->oob_poi;
> +	pl353_nand_read_data_op(chip, p,
> +				(mtd->oobsize -
> +				PL353_NAND_LAST_TRANSFER_LENGTH));
> +	p +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	data_phase_addr =3D (unsigned long __force)xnfc->nandaddr;
> +	data_phase_addr -=3D nand_offset;
> +	data_phase_addr |=3D PL353_NAND_CLEAR_CS;
> +	data_phase_addr +=3D nand_offset;
> +	xnfc->nandaddr =3D (void __iomem * __force)data_phase_addr;
> +
> +	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_write_page_raw - [Intern] raw page write function
> + * @mtd:		Pointer to the mtd info structure
> + * @chip:		Pointer to the NAND chip info structure
> + * @buf:		Pointer to the data buffer
> + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> + * @page:		Page number to write
> + *
> + * Return:	Always return zero
> + */
> +static int pl353_nand_write_page_raw(struct mtd_info *mtd,
> +				     struct nand_chip *chip,
> +				     const u8 *buf, int oob_required,
> +				     int page)
> +{
> +	unsigned long data_phase_addr;
> +	u8 *p;
> +
> +	struct pl353_nand_info *xnfc =3D
> +		container_of(chip, struct pl353_nand_info, chip);
> +	unsigned long nand_offset =3D (unsigned long __force)xnfc->nand_base;
> +
> +	pl353_nand_write_data_op(mtd, buf, mtd->writesize);
> +	p =3D chip->oob_poi;
> +	pl353_nand_write_data_op(mtd, p,
> +				 (mtd->oobsize -
> +				 PL353_NAND_LAST_TRANSFER_LENGTH));
> +	p +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	data_phase_addr =3D (unsigned long __force)xnfc->nandaddr;
> +	data_phase_addr -=3D nand_offset;
> +	data_phase_addr |=3D PL353_NAND_CLEAR_CS;
> +	data_phase_addr |=3D (1 << END_CMD_VALID_SHIFT);
> +	data_phase_addr +=3D nand_offset;
> +	xnfc->nandaddr =3D (void __iomem * __force)data_phase_addr;
> +	pl353_nand_write_data_op(mtd, p, PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	return 0;
> +}
> +
> +/**
> + * nand_write_page_hwecc - Hardware ECC based page write function
> + * @mtd:		Pointer to the mtd info structure
> + * @chip:		Pointer to the NAND chip info structure
> + * @buf:		Pointer to the data buffer
> + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> + * @page:		Page number to write
> + *
> + * This functions writes data and hardware generated ECC values in to th=
e page.
> + *
> + * Return:	Always return zero
> + */
> +static int pl353_nand_write_page_hwecc(struct mtd_info *mtd,
> +				       struct nand_chip *chip,
> +				       const u8 *buf, int oob_required,
> +				       int page)
> +{
> +	int eccsize =3D chip->ecc.size;
> +	int eccsteps =3D chip->ecc.steps;
> +	u8 *ecc_calc =3D chip->ecc.calc_buf;
> +	u8 *oob_ptr;
> +	const u8 *p =3D buf;
> +	u32 ret;
> +	unsigned long data_phase_addr;
> +	struct pl353_nand_info *xnfc =3D
> +		container_of(chip, struct pl353_nand_info, chip);
> +	unsigned long nand_offset =3D (unsigned long __force)xnfc->nand_base;
> +
> +	pl353_prepare_cmd(mtd, chip, page, 0, NAND_CMD_SEQIN,
> +			  NAND_CMD_PAGEPROG, 0);
> +
> +	for ( ; (eccsteps - 1); eccsteps--) {
> +		pl353_nand_write_data_op(mtd, p, eccsize);
> +		p +=3D eccsize;
> +	}
> +	pl353_nand_write_data_op(mtd, p,
> +				 (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH));
> +	p +=3D (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	/* Set ECC Last bit to 1 */
> +	data_phase_addr =3D (unsigned long __force)xnfc->nandaddr;
> +	data_phase_addr -=3D nand_offset;
> +	data_phase_addr |=3D PL353_NAND_ECC_LAST;
> +	data_phase_addr +=3D nand_offset;
> +	xnfc->nandaddr =3D (void __iomem * __force)data_phase_addr;
> +	pl353_nand_write_data_op(mtd, p, PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	p =3D buf;
> +	chip->ecc.calculate(mtd, p, &ecc_calc[0]);
> +
> +	/* Wait for ECC to be calculated and read the error values */
> +	ret =3D mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi,
> +					 0, chip->ecc.total);
> +	if (ret)
> +		return ret;
> +	/* Clear ECC last bit */
> +	data_phase_addr =3D (unsigned long __force)xnfc->nandaddr;
> +	data_phase_addr -=3D nand_offset;
> +	data_phase_addr &=3D ~PL353_NAND_ECC_LAST;
> +	data_phase_addr +=3D nand_offset;
> +	xnfc->nandaddr =3D (void __iomem * __force)data_phase_addr;
> +
> +	/* Write the spare area with ECC bytes */
> +	oob_ptr =3D chip->oob_poi;
> +	pl353_nand_write_data_op(mtd, oob_ptr,
> +				 (mtd->oobsize -
> +				 PL353_NAND_LAST_TRANSFER_LENGTH));
> +
> +	data_phase_addr =3D (unsigned long __force)xnfc->nandaddr;
> +	data_phase_addr -=3D nand_offset;
> +	data_phase_addr |=3D PL353_NAND_CLEAR_CS;
> +	data_phase_addr |=3D (1 << END_CMD_VALID_SHIFT);
> +	data_phase_addr +=3D nand_offset;
> +	xnfc->nandaddr =3D (void __iomem * __force)data_phase_addr;
> +	oob_ptr +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +	pl353_nand_write_data_op(mtd, oob_ptr,
> PL353_NAND_LAST_TRANSFER_LENGTH);
> +	nand_wait_ready(mtd);
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_read_page_hwecc - Hardware ECC based page read function
> + * @mtd:		Pointer to the mtd info structure
> + * @chip:		Pointer to the NAND chip info structure
> + * @buf:		Pointer to the buffer to store read data
> + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> + * @page:		Page number to read
> + *
> + * This functions reads data and checks the data integrity by comparing
> + * hardware generated ECC values and read ECC values from spare area.
> + * There is a limitation in SMC controller, that we must set ECC LAST
> +on
> + * last data phase access, to tell ECC block not to expect any data furt=
her.
> + * Ex:  When number of ECC STEPS are 4, then till 3 we will write to
> +flash
> + * using SMC with HW ECC enabled. And for the last ECC STEP, we will
> +subtract
> + * 4bytes from page size, and will initiate a transfer. And the
> +remaining 4 as
> + * one more transfer with ECC_LAST bit set in NAND data phase register
> +to
> + * notify ECC block not to expect any more data. The last block should
> +be align
> + * with end of 512 byte block. Because of this limitation, we are not
> +using
> + * core routines.
> + *
> + * Return:	0 always and updates ECC operation status in to MTD structure
> + */
> +static int pl353_nand_read_page_hwecc(struct mtd_info *mtd,
> +				      struct nand_chip *chip,
> +				      u8 *buf, int oob_required, int page) {
> +	int i, stat, eccsize =3D chip->ecc.size;
> +	int eccbytes =3D chip->ecc.bytes;
> +	int eccsteps =3D chip->ecc.steps;
> +	u8 *p =3D buf;
> +	u8 *ecc_calc =3D chip->ecc.calc_buf;
> +	u8 *ecc =3D chip->ecc.code_buf;
> +	unsigned int max_bitflips =3D 0;
> +	u8 *oob_ptr;
> +	u32 ret;
> +	unsigned long data_phase_addr;
> +	struct pl353_nand_info *xnfc =3D
> +		container_of(chip, struct pl353_nand_info, chip);
> +	unsigned long nand_offset =3D (unsigned long __force)xnfc->nand_base;
> +
> +	pl353_prepare_cmd(mtd, chip, page, 0, NAND_CMD_READ0,
> +			  NAND_CMD_READSTART, 1);
> +	nand_wait_ready(mtd);
> +
> +	for ( ; (eccsteps - 1); eccsteps--) {
> +		pl353_nand_read_data_op(chip, p, eccsize);
> +		p +=3D eccsize;
> +	}
> +	pl353_nand_read_data_op(chip, p,
> +				(eccsize - PL353_NAND_LAST_TRANSFER_LENGTH));
> +	p +=3D (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	/* Set ECC Last bit to 1 */
> +	data_phase_addr =3D (unsigned long __force)xnfc->nandaddr;
> +	data_phase_addr -=3D nand_offset;
> +	data_phase_addr |=3D PL353_NAND_ECC_LAST;
> +	data_phase_addr +=3D nand_offset;
> +	xnfc->nandaddr =3D (void __iomem * __force)data_phase_addr;
> +	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	/* Read the calculated ECC value */
> +	p =3D buf;
> +	chip->ecc.calculate(mtd, p, &ecc_calc[0]);
> +
> +	/* Clear ECC last bit */
> +	data_phase_addr =3D (unsigned long __force)xnfc->nandaddr;
> +	data_phase_addr -=3D nand_offset;
> +	data_phase_addr &=3D ~PL353_NAND_ECC_LAST;
> +	data_phase_addr +=3D nand_offset;
> +	xnfc->nandaddr =3D (void __iomem * __force)data_phase_addr;
> +
> +	/* Read the stored ECC value */
> +	oob_ptr =3D chip->oob_poi;
> +	pl353_nand_read_data_op(chip, oob_ptr,
> +				(mtd->oobsize -
> +				PL353_NAND_LAST_TRANSFER_LENGTH));
> +
> +	/* de-assert chip select */
> +	data_phase_addr =3D (unsigned long __force)xnfc->nandaddr;
> +	data_phase_addr -=3D nand_offset;
> +	data_phase_addr |=3D PL353_NAND_CLEAR_CS;
> +	data_phase_addr +=3D nand_offset;
> +	xnfc->nandaddr =3D (void __iomem * __force)data_phase_addr;
> +
> +	oob_ptr +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +	pl353_nand_read_data_op(chip, oob_ptr,
> +PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	ret =3D mtd_ooblayout_get_eccbytes(mtd, ecc, chip->oob_poi, 0,
> +					 chip->ecc.total);
> +	if (ret)
> +		return ret;
> +
> +	eccsteps =3D chip->ecc.steps;
> +	p =3D buf;
> +
> +	/* Check ECC error for all blocks and correct if it is correctable */
> +	for (i =3D 0 ; eccsteps; eccsteps--, i +=3D eccbytes, p +=3D eccsize) {
> +		stat =3D chip->ecc.correct(mtd, p, &ecc[i], &ecc_calc[i]);
> +		if (stat < 0) {
> +			mtd->ecc_stats.failed++;
> +		} else {
> +			mtd->ecc_stats.corrected +=3D stat;
> +			max_bitflips =3D max_t(unsigned int, max_bitflips, stat);
> +		}
> +	}
> +
> +	return max_bitflips;
> +}
> +
> +/**
> + * pl353_nand_select_chip - Select the flash device
> + * @mtd:	Pointer to the mtd info structure
> + * @chip:	Pointer to the NAND chip info structure
> + *
> + * This function is empty as the NAND controller handles chip select
> +line
> + * internally based on the chip address passed in command and data phase=
.
> + */
> +static void pl353_nand_select_chip(struct mtd_info *mtd, int chip) { }
> +
> +/* NAND framework ->exec_op() hooks and related helpers */ static void
> +pl353_nfc_parse_instructions(struct nand_chip *chip,
> +					 const struct nand_subop *subop,
> +					 struct pl353_nfc_op *nfc_op)
> +{
> +	const struct nand_op_instr *instr =3D NULL;
> +	unsigned int op_id, offset, naddrs;
> +	int i, len;
> +	const u8 *addrs;
> +
> +	memset(nfc_op, 0, sizeof(struct pl353_nfc_op));
> +	for (op_id =3D 0; op_id < subop->ninstrs; op_id++) {
> +		nfc_op->len =3D nand_subop_get_data_len(subop, op_id);
> +		len =3D nand_subop_get_data_len(subop, op_id);
> +		instr =3D &subop->instrs[op_id];
> +
> +		switch (instr->type) {
> +		case NAND_OP_CMD_INSTR:
> +			nfc_op->type =3D NAND_OP_CMD_INSTR;
> +			if (op_id)
> +				nfc_op->cmnds[1] =3D instr->ctx.cmd.opcode;
> +			else
> +				nfc_op->cmnds[0] =3D instr->ctx.cmd.opcode;
> +			nfc_op->cle_ale_delay_ns =3D instr->delay_ns;
> +			break;
> +
> +		case NAND_OP_ADDR_INSTR:
> +			offset =3D nand_subop_get_addr_start_off(subop, op_id);
> +			naddrs =3D nand_subop_get_num_addr_cyc(subop, op_id);
> +			addrs =3D &instr->ctx.addr.addrs[offset];
> +			nfc_op->addrs =3D instr->ctx.addr.addrs[offset];
> +			for (i =3D 0; i < min_t(unsigned int, 4, naddrs); i++) {
> +				nfc_op->addrs |=3D instr->ctx.addr.addrs[i] <<
> +						 (8 * i);
> +			}
> +
> +			if (naddrs >=3D 5)
> +				nfc_op->addr5 =3D addrs[4];
> +			if (naddrs >=3D 6)
> +				nfc_op->addr6 =3D addrs[5];
> +			nfc_op->naddrs =3D nand_subop_get_num_addr_cyc(subop,
> +								     op_id);
> +			nfc_op->cle_ale_delay_ns =3D instr->delay_ns;
> +			break;
> +
> +		case NAND_OP_DATA_IN_INSTR:
> +			nfc_op->data_instr =3D instr;
> +			nfc_op->type =3D NAND_OP_DATA_IN_INSTR;
> +			nfc_op->data_instr_idx =3D op_id;
> +			break;
> +
> +		case NAND_OP_DATA_OUT_INSTR:
> +			nfc_op->data_instr =3D instr;
> +			nfc_op->type =3D NAND_OP_DATA_IN_INSTR;
> +			nfc_op->data_instr_idx =3D op_id;
> +			break;
> +
> +		case NAND_OP_WAITRDY_INSTR:
> +			nfc_op->rdy_timeout_ms =3D instr->ctx.waitrdy.timeout_ms;
> +			nfc_op->rdy_delay_ns =3D instr->delay_ns;
> +			break;
> +		}
> +	}
> +}
> +
> +static void cond_delay(unsigned int ns) {
> +	if (!ns)
> +		return;
> +
> +	if (ns < 10000)
> +		ndelay(ns);
> +	else
> +		udelay(DIV_ROUND_UP(ns, 1000));
> +}
> +
> +/**
> + * pl353_nand_cmd_function - Send command to NAND device
> + * @chip:	Pointer to the NAND chip info structure
> + * @subop:	Pointer to array of instructions
> + * Return:	Always return zero
> + */
> +static int pl353_nand_cmd_function(struct nand_chip *chip,
> +				   const struct nand_subop *subop)
> +{
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	const struct nand_op_instr *instr;
> +	struct pl353_nfc_op nfc_op =3D {};
> +	struct pl353_nand_info *xnfc =3D
> +		container_of(chip, struct pl353_nand_info, chip);
> +	unsigned long cmd_data =3D 0, end_cmd_valid =3D 0;
> +	unsigned long cmd_phase_addr, data_phase_addr, end_cmd;
> +	unsigned int op_id, len, offset;
> +	bool reading;
> +
> +	pl353_nfc_parse_instructions(chip, subop, &nfc_op);
> +	instr =3D nfc_op.data_instr;
> +	op_id =3D nfc_op.data_instr_idx;
> +	len =3D nand_subop_get_data_len(subop, op_id);
> +	offset =3D nand_subop_get_data_start_off(subop, op_id);
> +
> +	pl353_smc_clr_nand_int();
> +	/* Get the command phase address */
> +	if (nfc_op.cmnds[1] !=3D 0) {
> +		if (nfc_op.cmnds[0] =3D=3D NAND_CMD_SEQIN)
> +			end_cmd_valid =3D 0;
> +		else
> +			end_cmd_valid =3D 1;
> +		end_cmd =3D nfc_op.cmnds[1];
> +	}  else {
> +		end_cmd =3D 0x0;
> +	}
> +
> +	/*
> +	 * The SMC defines two phases of commands when transferring data to or
> +	 * from NAND flash.
> +	 * Command phase: Commands and optional address information are written
> +	 * to the NAND flash.The command and address can be associated with
> +	 * either a data phase operation to write to or read from the array,
> +	 * or a status/ID register transfer.
> +	 * Data phase: Data is either written to or read from the NAND flash.
> +	 * This data can be either data transferred to or from the array,
> +	 * or status/ID register information.
> +	 */
> +	cmd_phase_addr =3D (unsigned long __force)xnfc->nand_base +
> +			 ((nfc_op.naddrs << ADDR_CYCLES_SHIFT) |
> +			 (end_cmd_valid << END_CMD_VALID_SHIFT) |
> +			 (COMMAND_PHASE) |
> +			 (end_cmd << END_CMD_SHIFT) |
> +			 (nfc_op.cmnds[0] << START_CMD_SHIFT));
> +
> +	/* Get the data phase address */
> +	end_cmd_valid =3D 0;
> +
> +	data_phase_addr =3D (unsigned long __force)xnfc->nand_base +
> +			  ((0x0 << CLEAR_CS_SHIFT) |
> +			  (end_cmd_valid << END_CMD_VALID_SHIFT) |
> +			  (DATA_PHASE) |
> +			  (end_cmd << END_CMD_SHIFT) |
> +			  (0x0 << ECC_LAST_SHIFT));
> +	xnfc->nandaddr =3D (void __iomem * __force)data_phase_addr;
> +
> +	/* Command phase AXI Read & Write */
> +	if (nfc_op.naddrs >=3D 5) {
> +		if (mtd->writesize > PL353_NAND_ECC_SIZE) {
> +			cmd_data =3D nfc_op.addrs;
> +			/* Another address cycle for devices > 128MiB */
> +			if (chip->options & NAND_ROW_ADDR_3) {
> +				writel_relaxed(cmd_data,
> +					       (void __iomem * __force)
> +					       cmd_phase_addr);
> +				cmd_data =3D nfc_op.addr5;
> +				if (nfc_op.naddrs >=3D 6)
> +					cmd_data |=3D (nfc_op.addr6 << 8);
> +			}
> +		}
> +	}  else {
> +		if (nfc_op.addrs !=3D -1) {
> +			int column =3D nfc_op.addrs;
> +			/*
> +			 * Change read/write column, read id etc
> +			 * Adjust columns for 16 bit bus width
> +			 */
> +			if ((chip->options & NAND_BUSWIDTH_16) &&
> +			    (nfc_op.cmnds[0] =3D=3D NAND_CMD_READ0 ||
> +				nfc_op.cmnds[0] =3D=3D NAND_CMD_SEQIN ||
> +				nfc_op.cmnds[0] =3D=3D NAND_CMD_RNDOUT ||
> +				nfc_op.cmnds[0] =3D=3D NAND_CMD_RNDIN)) {
> +				column >>=3D 1;
> +			}
> +			cmd_data =3D column;
> +		}
> +	}
> +	writel_relaxed(cmd_data, (void __iomem * __force)cmd_phase_addr);
> +
> +	if (!nfc_op.data_instr) {
> +		if (nfc_op.rdy_timeout_ms)
> +			nand_wait_ready(mtd);
> +		return 0;
> +	}
> +
> +	reading =3D (nfc_op.data_instr->type =3D=3D NAND_OP_DATA_IN_INSTR);
> +	if (!reading) {
> +		if (nfc_op.cmnds[0] =3D=3D NAND_CMD_SEQIN &&
> +		    nfc_op.cmnds[1] =3D=3D NAND_CMD_PAGEPROG) {
> +			pl353_nand_write_page_raw(mtd, chip,
> +						  instr->ctx.data.buf.out, 0,
> +						  nfc_op.addrs);
> +
> +		} else {
> +			pl353_nand_write_data_op(mtd, instr->ctx.data.buf.out,
> +						 len);
> +		}
> +		if (nfc_op.rdy_timeout_ms)
> +			nand_wait_ready(mtd);
> +		cond_delay(nfc_op.rdy_delay_ns);
> +	}
> +	if (reading) {
> +		cond_delay(nfc_op.rdy_delay_ns);
> +		if (nfc_op.rdy_timeout_ms)
> +			nand_wait_ready(mtd);
> +		pl353_nand_read_data_op(chip, instr->ctx.data.buf.in, len);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct nand_op_parser pl353_nfc_op_parser =3D NAND_OP_PARSE=
R
> +	(NAND_OP_PARSER_PATTERN
> +		(pl353_nand_cmd_function,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
> +	NAND_OP_PARSER_PATTERN
> +		(pl353_nand_cmd_function,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 7),
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false),
> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
> +	NAND_OP_PARSER_PATTERN
> +		(pl353_nand_cmd_function,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
> +	NAND_OP_PARSER_PATTERN
> +		(pl353_nand_cmd_function,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 8),
> +		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, 2048),
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
> +	NAND_OP_PARSER_PATTERN
> +		(pl353_nand_cmd_function,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false)),
> +	);
> +
> +static int pl353_nfc_exec_op(struct nand_chip *chip,
> +			     const struct nand_operation *op,
> +			     bool check_only)
> +{
> +	return nand_op_parser_exec_op(chip, &pl353_nfc_op_parser,
> +					      op, check_only);
> +}
> +
> +/**
> + * pl353_nand_device_ready - Check device ready/busy line
> + * @mtd:	Pointer to the mtd_info structure
> + *
> + * Return:	0 on busy or 1 on ready state
> + */
> +static int pl353_nand_device_ready(struct mtd_info *mtd) {
> +	if (pl353_smc_get_nand_int_status_raw()) {
> +		pl353_smc_clr_nand_int();
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_ecc_init - Initialize the ecc information as per the ecc m=
ode
> + * @mtd:	Pointer to the mtd_info structure
> + * @ecc:	Pointer to ECC control structure
> + * @ecc_mode:	ondie ecc status
> + *
> + * This function initializes the ecc block and functional pointers as
> +per the
> + * ecc mode
> + *
> + * Return:	0 on success or negative errno.
> + */
> +static int pl353_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctr=
l *ecc,
> +				int ecc_mode)
> +{
> +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> +	struct pl353_nand_info *xnfc =3D
> +		container_of(chip, struct pl353_nand_info, chip);
> +	int err =3D 0;
> +
> +	if (ecc_mode =3D=3D NAND_ECC_ON_DIE) {
> +		pl353_smc_set_ecc_mode(PL353_SMC_ECCMODE_BYPASS);
> +		/*
> +		 * On-Die ECC spare bytes offset 8 is used for ECC codes
> +		 * Use the BBT pattern descriptors
> +		 */
> +		chip->bbt_td =3D &bbt_main_descr;
> +		chip->bbt_md =3D &bbt_mirror_descr;
> +		bitmap_set(chip->parameters.get_feature_list,
> +			   ONFI_FEATURE_ON_DIE_ECC,
> ONFI_FEATURE_ON_DIE_ECC_EN);
> +		bitmap_set(chip->parameters.set_feature_list,
> +			   ONFI_FEATURE_ON_DIE_ECC,
> ONFI_FEATURE_ON_DIE_ECC_EN);
> +	} else {
> +		ecc->read_oob =3D pl353_nand_read_oob;
> +		ecc->write_oob =3D pl353_nand_write_oob;
> +
> +		ecc->mode =3D NAND_ECC_HW;
> +		/* Hardware ECC generates 3 bytes ECC code for each 512 bytes */
> +		ecc->bytes =3D 3;
> +		ecc->strength =3D 1;
> +		ecc->calculate =3D pl353_nand_calculate_hwecc;
> +		ecc->correct =3D pl353_nand_correct_data;
> +		ecc->read_page =3D pl353_nand_read_page_hwecc;
> +		ecc->size =3D PL353_NAND_ECC_SIZE;
> +		ecc->write_page =3D pl353_nand_write_page_hwecc;
> +		pl353_smc_set_ecc_pg_size(mtd->writesize);
> +		switch (mtd->writesize) {
> +		case SZ_512:
> +		case SZ_1K:
> +		case SZ_2K:
> +			pl353_smc_set_ecc_mode(PL353_SMC_ECCMODE_APB);
> +			break;
> +		default:
> +			ecc->calculate =3D nand_calculate_ecc;
> +			ecc->correct =3D nand_correct_data;
> +			ecc->size =3D 256;
> +			break;
> +		}
> +		if (mtd->writesize <=3D SZ_512)
> +			xnfc->addr_cycles =3D 1;
> +		else
> +			xnfc->addr_cycles =3D 2;
> +
> +		if (chip->options & NAND_ROW_ADDR_3)
> +			xnfc->addr_cycles +=3D 3;
> +		else
> +			xnfc->addr_cycles +=3D 2;
> +
> +		if (mtd->oobsize =3D=3D 16) {
> +			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout16_ops);
> +		} else if (mtd->oobsize =3D=3D 64) {
> +			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout64_ops);
> +		} else {
> +			err =3D -ENXIO;
> +			dev_err(xnfc->dev, "Unsupported oob Layout\n");
> +		}
> +	}
> +	return err;
> +}
> +
> +static int pl353_setup_data_interface(struct mtd_info *mtd, int csline,
> +				       const struct nand_data_interface *conf) {
> +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> +	struct pl353_nand_info *xnfc =3D
> +		container_of(chip, struct pl353_nand_info, chip);
> +	const struct nand_sdr_timings *sdr;
> +	u32 timings[7], mckperiodps;
> +
> +	sdr =3D nand_get_sdr_timings(conf);
> +	if (IS_ERR(sdr))
> +		return PTR_ERR(sdr);
> +
> +	/*
> +	 * SDR timings are given in pico-seconds while NFC timings must be
> +	 * expressed in NAND controller clock cycles.
> +	 */
> +	mckperiodps =3D NSEC_PER_SEC / clk_get_rate(xnfc->mclk);
> +	mckperiodps *=3D 1000;
> +	if (sdr->tRC_min <=3D 20000)
> +		/*
> +		 * PL353 SMC needs one extra read cycle in SDR Mode 5
> +		 * This is not written anywhere in the datasheet but
> +		 * the results observed during testing.
> +		 */
> +		timings[0] =3D DIV_ROUND_UP(sdr->tRC_min, mckperiodps) + 1;
> +	else
> +		timings[0] =3D DIV_ROUND_UP(sdr->tRC_min, mckperiodps);
> +
> +	timings[1] =3D DIV_ROUND_UP(sdr->tWC_min, mckperiodps);
> +	/*
> +	 * For all SDR modes, PL353 SMC needs tREA max value as 1
> +	 * These results observed during testing.
> +	 */
> +	timings[2] =3D PL353_TREA_MAX_VALUE;
> +	timings[3] =3D DIV_ROUND_UP(sdr->tWP_min, mckperiodps);
> +	timings[4] =3D DIV_ROUND_UP(sdr->tCLR_min, mckperiodps);
> +	timings[5] =3D DIV_ROUND_UP(sdr->tAR_min, mckperiodps);
> +	timings[6] =3D DIV_ROUND_UP(sdr->tRR_min, mckperiodps);
> +
> +	if (csline =3D=3D NAND_DATA_IFACE_CHECK_ONLY)
> +		return 0;
> +
> +	pl353_smc_set_cycles(timings);
> +
> +	return 0;
> +}
> +/**
> + * pl353_nand_probe - Probe method for the NAND driver
> + * @pdev:	Pointer to the platform_device structure
> + *
> + * This function initializes the driver data structures and the hardware=
.
> + * The NAND driver has dependency with the pl353_smc memory controller
> + * driver for initializing the NAND timing parameters, bus width, ECC
> +modes,
> + * control and status information.
> + *
> + * Return:	0 on success or error value on failure
> + */
> +static int pl353_nand_probe(struct platform_device *pdev) {
> +	struct pl353_nand_info *xnfc;
> +	struct mtd_info *mtd;
> +	struct nand_chip *chip;
> +	struct resource *res;
> +	struct device_node *np;
> +	u32 ret;
> +
> +	xnfc =3D devm_kzalloc(&pdev->dev, sizeof(*xnfc), GFP_KERNEL);
> +	if (!xnfc)
> +		return -ENOMEM;
> +	xnfc->dev =3D &pdev->dev;
> +	/* Map physical address of NAND flash */
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	xnfc->nand_base =3D devm_ioremap_resource(xnfc->dev, res);
> +	if (IS_ERR(xnfc->nand_base))
> +		return PTR_ERR(xnfc->nand_base);
> +
> +	chip =3D &xnfc->chip;
> +	mtd =3D nand_to_mtd(chip);
> +	chip->exec_op =3D pl353_nfc_exec_op;
> +	nand_set_controller_data(chip, xnfc);
> +	mtd->priv =3D chip;
> +	mtd->owner =3D THIS_MODULE;
> +	if (!mtd->name) {
> +		/*
> +		 * If the new bindings are used and the bootloader has not been
> +		 * updated to pass a new mtdparts parameter on the cmdline, you
> +		 * should define the following property in your NAND node, ie:
> +		 *
> +		 *	label =3D "pl353-nand";
> +		 *
> +		 * This way, mtd->name will be set by the core when
> +		 * nand_set_flash_node() is called.
> +		 */
> +		mtd->name =3D devm_kasprintf(xnfc->dev, GFP_KERNEL,
> +					   "%s", PL353_NAND_DRIVER_NAME);
> +		if (!mtd->name) {
> +			dev_err(xnfc->dev, "Failed to allocate mtd->name\n");
> +			return -ENOMEM;
> +		}
> +	}
> +	nand_set_flash_node(chip, xnfc->dev->of_node);
> +
> +	/* Set the driver entry points for MTD */
> +	chip->dev_ready =3D pl353_nand_device_ready;
> +	chip->select_chip =3D pl353_nand_select_chip;
> +	/* If we don't set this delay driver sets 20us by default */
> +	np =3D of_get_next_parent(xnfc->dev->of_node);
> +	xnfc->mclk =3D of_clk_get(np, 0);
> +	if (IS_ERR(xnfc->mclk)) {
> +		dev_err(xnfc->dev, "Failed to retrieve MCK clk\n");
> +		return PTR_ERR(xnfc->mclk);
> +	}
> +	chip->chip_delay =3D 30;
> +	/* Set the device option and flash width */
> +	chip->options =3D NAND_BUSWIDTH_AUTO;
> +	chip->bbt_options =3D NAND_BBT_USE_FLASH;
> +	platform_set_drvdata(pdev, xnfc);
> +	chip->setup_data_interface =3D pl353_setup_data_interface;
> +	/* first scan to find the device and get the page size */
> +	if (nand_scan_ident(mtd, 1, NULL)) {
> +		dev_err(xnfc->dev, "nand_scan_ident for NAND failed\n");
> +		return -ENXIO;
> +	}
> +	ret =3D pl353_nand_ecc_init(mtd, &chip->ecc, chip->ecc.mode);
> +	if (chip->options & NAND_BUSWIDTH_16)
> +		pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_16);
> +	/* second phase scan */
> +	if (nand_scan_tail(mtd)) {
> +		dev_err(xnfc->dev, "nand_scan_tail for NAND failed\n");
> +		return -ENXIO;
> +	}
> +
> +	ret =3D mtd_device_register(mtd, NULL, 0);
> +	if (ret) {
> +		dev_err(xnfc->dev, "Failed to register mtd device: %d\n", ret);
> +		nand_cleanup(chip);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_remove - Remove method for the NAND driver
> + * @pdev:	Pointer to the platform_device structure
> + *
> + * This function is called if the driver module is being unloaded. It
> +frees all
> + * resources allocated to the device.
> + *
> + * Return:	0 on success or error value on failure
> + */
> +static int pl353_nand_remove(struct platform_device *pdev) {
> +	struct pl353_nand_info *xnfc =3D platform_get_drvdata(pdev);
> +	struct mtd_info *mtd =3D nand_to_mtd(&xnfc->chip);
> +
> +	/* Release resources, unregister device */
> +	nand_release(mtd);
> +
> +	return 0;
> +}
> +
> +/* Match table for device tree binding */ static const struct
> +of_device_id pl353_nand_of_match[] =3D {
> +	{ .compatible =3D "arm,pl353-nand-r2p1" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, pl353_nand_of_match);
> +
> +/*
> + * pl353_nand_driver - This structure defines the NAND subsystem
> +platform driver  */ static struct platform_driver pl353_nand_driver =3D =
{
> +	.probe		=3D pl353_nand_probe,
> +	.remove		=3D pl353_nand_remove,
> +	.driver		=3D {
> +		.name	=3D PL353_NAND_DRIVER_NAME,
> +		.of_match_table =3D pl353_nand_of_match,
> +	},
> +};
> +
> +module_platform_driver(pl353_nand_driver);
> +
> +MODULE_AUTHOR("Xilinx, Inc.");
> +MODULE_ALIAS("platform:" PL353_NAND_DRIVER_NAME);
> +MODULE_DESCRIPTION("ARM PL353 NAND Flash Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.7.4

