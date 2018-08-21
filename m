Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB839C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA1B2172D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="0VUf7s9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA1B2172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeHUKAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:00:35 -0400
Received: from mail-eopbgr710088.outbound.protection.outlook.com ([40.107.71.88]:25520
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbeHUKAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVIPqELViz2a+LNMlIlUYetbVZDDcBtHfK6UBL0oRfs=;
 b=0VUf7s9OuU51gPCNOXCbjB0DckTAIEz4LwBLNJu6tuI/p3hUiatCUFhuLK92x5Qcr5Yq+IbylLl4YhQ5lPXGVRwzUjpOzfelOrNXwscS1EnB/E1i3MsbUzva4Weqx4d4zBCoBaqfCrixDZte5RVb73DW1sLkWGXFiqbu88PlpGw=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2862.namprd02.prod.outlook.com (10.175.50.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.20; Tue, 21 Aug 2018 06:40:59 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::71ad:f7bc:17b4:4d68]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::71ad:f7bc:17b4:4d68%2]) with mapi id 15.20.1059.023; Tue, 21 Aug 2018
 06:40:58 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        "absahu@codeaurora.org" <absahu@codeaurora.org>,
        "peterpandong@micron.com" <peterpandong@micron.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>
Subject: RE: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Topic: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Index: AQHUNiz7bKojXyawJ0eL/lrCUsemM6TI3JSAgADcA+A=
Date:   Tue, 21 Aug 2018 06:40:58 +0000
Message-ID: <MWHPR02MB26235AF18211E3FB39076396AF310@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1534511964-20342-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20180820184013.57fd7b5c@bbrezillon>
In-Reply-To: <20180820184013.57fd7b5c@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2862;6:0SXKhRVyyWuuoSH1iKLnrmTg7vB1CIRciMdhrltFB3zwimlnAFsrjiVPdMObqnUna0AeEjRNDlBFZRkWMISPmPAbfcYxfAaOTLm8Nq43lP1G0mIrZGPP/Q+lijCyO2bDu3gYvEBLo1/ZwYTaLmWezamjzkya8kJ2n/Sl7WJwwnqIXq/ZCp6K4m7yoa2Zk7hcbD7ROHP2PrXQ8rf29zQHHla10u2IvjG8bcJf/gadw9H+NIYWW8ZU8PvZAXTiQvuWLoFXzFB/2bBxbd3ugFH5XJgoJfm0YQSMvQvO+xtf1l4OcKvu4t2n0218jEZgcO+ysL0sRjOkjNwjGSF2rHzJQkEA8tDnGTfqp8F64EwBLTp2H5vctTM0iyf0OPOjnVo3FLEOE0vYjZEkD8f6whf2Butff90vzd5yo7QCaoTWpj2IYlHLta0AGtHsvJV0xl9WRkgM9DCk1xA2lmbv+W4jgw==;5:s7v0AxpYHfhvk6ItyZfqjTfCwl3mXad5w5jeRSzDVO4egX1tfUKGw47LCWemhfILnO9m7wxmxHAeILWc30OW/IgHk5NHcm4r2kU6buYP/7x/xAomAyuh267UpzcnUlafKRbDnaPm4RPk+PePJ5Ksz2FmCJ7cHIkNQuDnk0XbRgY=;7:kXqXVdmEtJfmv/rjXqobdMi1QewAGOls2E+bZjK8LDm4tF83kcYHO5NnGXU9NWbJbhLWG+ZsciN/NuX+PtEYr3JYhosMZaJUq5+2mUl44RMEtjKUVs+INKcLTBGLF+RTc4I9F7bmMh3Xf2EUEuCDZawHTNm9HS3Y8D7uT0UvrIk99GxLvGgHvQt4BGkjgT+FTYYQi6k/yHOwLWlJGTNLhdAwcBWU3zYnA6thQaAwrzjMtW8Ig+vh337kIDQypX2G
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(136003)(396003)(346002)(52314003)(13464003)(199004)(189003)(51914003)(11346002)(229853002)(55016002)(478600001)(256004)(476003)(53946003)(14444005)(8936002)(53936002)(39060400002)(9686003)(446003)(6436002)(102836004)(106356001)(26005)(14454004)(6506007)(33656002)(105586002)(6246003)(53546011)(86362001)(575784001)(186003)(486006)(54906003)(3846002)(7416002)(6116002)(217873002)(8676002)(7736002)(5250100002)(81166006)(25786009)(7696005)(2900100001)(76176011)(316002)(2906002)(97736004)(4326008)(74316002)(5660300001)(81156014)(6916009)(99286004)(68736007)(66066001)(305945005)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2862;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 5b2495ca-a4ec-496e-a617-08d607310dbc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2862;
x-ms-traffictypediagnostic: MWHPR02MB2862:
x-microsoft-antispam-prvs: <MWHPR02MB2862235DA5593E0D05F77A6CAF310@MWHPR02MB2862.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(192813158149592)(34377916053724)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:MWHPR02MB2862;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2862;
x-forefront-prvs: 0771670921
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IJmqFkgsnucuXOwxyihoiQ3N7zvrjYXnelgcEySS1dDsPsoqdcvvhhvduwcsUDdBAeDj61BxojyhjAKRnYdZ5Zgt33FJy/IN5x2TEY73OUPHDSxbb7CsfnEp0JEBb38KeIeGGaFc6AT584frpJ5HWMFrBCRSa2xqJtATxcPzE7n0k0jBqSs+qBOMkFcj1rcTl8ayYZZr+2YqT6U8IWDKPbLoYu6nKPwRTSSSAwzjzsiCwbvfgSXpo3FTfuTfxGnJeB5ROQPeLGv6V8j+0RBsIw1DWXKXqiOK9WbuNghZjQys0k2GaJgzw6i6oEsENPfD1TBYuwuo6pALRrkjjT1ALmlJt7BXuwp2aZyGIFsVDlI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2495ca-a4ec-496e-a617-08d607310dbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2018 06:40:58.3982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2862
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Thanks for the review.

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, August 20, 2018 10:10 PM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: miquel.raynal@bootlin.com; richard@nod.at; dwmw2@infradead.org;
> computersforpeace@gmail.com; marek.vasut@gmail.com; kyungmin.park@samsung=
.com;
> absahu@codeaurora.org; peterpandong@micron.com; frieder.schrempf@exceet.d=
e; linux-
> mtd@lists.infradead.org; linux-kernel@vger.kernel.org; Michal Simek <mich=
als@xilinx.com>;
> nagasureshkumarrelli@gmail.com
> Subject: Re: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for =
Arasan
> NAND Flash Controller
>=20
> Hi Naga,
>=20
> On Fri, 17 Aug 2018 18:49:24 +0530
> Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
>=20
> >
> > +config MTD_NAND_ARASAN
> > +	tristate "Support for Arasan Nand Flash controller"
> > +	depends on HAS_IOMEM
> > +	depends on HAS_DMA
>=20
> Just nitpicking, but you can place them on the same line:
Ok, I will update it next version.
>=20
> 	depends on HAS_IOMEM && HAS_DMA
>=20
> > +	help
> > +	  Enables the driver for the Arasan Nand Flash controller on
> > +	  Zynq Ultrascale+ MPSoC.
> > +
> >  endif # MTD_NAND
> > diff --git a/drivers/mtd/nand/raw/Makefile
> > b/drivers/mtd/nand/raw/Makefile index d5a5f98..ccb8d56 100644
> > --- a/drivers/mtd/nand/raw/Makefile
> > +++ b/drivers/mtd/nand/raw/Makefile
> > @@ -57,6 +57,7 @@ obj-$(CONFIG_MTD_NAND_BRCMNAND)		+=3D
> brcmnand/
> >  obj-$(CONFIG_MTD_NAND_QCOM)		+=3D qcom_nandc.o
> >  obj-$(CONFIG_MTD_NAND_MTK)		+=3D mtk_ecc.o mtk_nand.o
> >  obj-$(CONFIG_MTD_NAND_TEGRA)		+=3D tegra_nand.o
> > +obj-$(CONFIG_MTD_NAND_ARASAN)		+=3D arasan_nand.o
> >
> >  nand-objs :=3D nand_base.o nand_bbt.o nand_timings.o nand_ids.o
> > nand-objs +=3D nand_amd.o diff --git
> > a/drivers/mtd/nand/raw/arasan_nand.c
> > b/drivers/mtd/nand/raw/arasan_nand.c
> > new file mode 100644
> > index 0000000..e4f1f80
> > --- /dev/null
> > +++ b/drivers/mtd/nand/raw/arasan_nand.c
> > @@ -0,0 +1,1350 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Arasan NAND Flash Controller Driver
> > + *
> > + * Copyright (C) 2014 - 2017 Xilinx, Inc.
> > + * Author: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
> > + * Author: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > + *
> > + */
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io-64-nonatomic-lo-hi.h> #include <linux/module.h>
> > +#include <linux/mtd/mtd.h> #include <linux/mtd/rawnand.h> #include
> > +<linux/mtd/partitions.h> #include <linux/of.h> #include
> > +<linux/platform_device.h> #include <linux/slab.h>
>=20
> Blank line missing here.
Ok, I will update it next version.
>=20
> > +#define DRIVER_NAME			"arasan_nand"
>=20
> Please define drop this definition and pass the string directly to
> driver->name. The driver is for a nand controller, so make it clear,
> also, it's just a detail but I prefer '-' to '_', so, how about "arasan-n=
and-controller"?
Yes, it looks good.=20
I will update it next version.
>=20
> > +#define EVNT_TIMEOUT_MSEC		1000
>=20
> It's unusual to have EVNT, it's usually EVT or EVENT.
Ok, I will update it in next version.
>=20
> > +#define STATUS_TIMEOUT			2000
>=20
> Is it in milliseconds? Please add the proper _<UNIT> prefix here.
Yes, it is in milliseconds.
Ok I will add.
>=20
> > +
> > +#define PKT_OFST			0x00
> > +#define MEM_ADDR1_OFST			0x04
> > +#define MEM_ADDR2_OFST			0x08
> > +#define CMD_OFST			0x0C
> > +#define PROG_OFST			0x10
> > +#define INTR_STS_EN_OFST		0x14
> > +#define INTR_SIG_EN_OFST		0x18
> > +#define INTR_STS_OFST			0x1C
> > +#define READY_STS_OFST			0x20
> > +#define DMA_ADDR1_OFST			0x24
> > +#define FLASH_STS_OFST			0x28
> > +#define DATA_PORT_OFST			0x30
> > +#define ECC_OFST			0x34
> > +#define ECC_ERR_CNT_OFST		0x38
> > +#define ECC_SPR_CMD_OFST		0x3C
> > +#define ECC_ERR_CNT_1BIT_OFST		0x40
> > +#define ECC_ERR_CNT_2BIT_OFST		0x44
> > +#define DMA_ADDR0_OFST			0x50
> > +#define DATA_INTERFACE_OFST		0x6C
> > +
> > +#define PKT_CNT_SHIFT			12
> > +
> > +#define ECC_ENABLE			BIT(31)
> > +#define DMA_EN_MASK			GENMASK(27, 26)
> > +#define DMA_ENABLE			0x2
> > +#define DMA_EN_SHIFT			26
> > +#define REG_PAGE_SIZE_SHIFT		23
> > +#define REG_PAGE_SIZE_512		0
> > +#define REG_PAGE_SIZE_1K		5
> > +#define REG_PAGE_SIZE_2K		1
> > +#define REG_PAGE_SIZE_4K		2
> > +#define REG_PAGE_SIZE_8K		3
> > +#define REG_PAGE_SIZE_16K		4
> > +#define CMD2_SHIFT			8
> > +#define ADDR_CYCLES_SHIFT		28
> > +
> > +#define XFER_COMPLETE			BIT(2)
> > +#define READ_READY			BIT(1)
> > +#define WRITE_READY			BIT(0)
> > +#define MBIT_ERROR			BIT(3)
> > +
> > +#define PROG_PGRD			BIT(0)
> > +#define PROG_ERASE			BIT(2)
> > +#define PROG_STATUS			BIT(3)
> > +#define PROG_PGPROG			BIT(4)
> > +#define PROG_RDID			BIT(6)
> > +#define PROG_RDPARAM			BIT(7)
> > +#define PROG_RST			BIT(8)
> > +#define PROG_GET_FEATURE		BIT(9)
> > +#define PROG_SET_FEATURE		BIT(10)
> > +
> > +#define PG_ADDR_SHIFT			16
> > +#define BCH_MODE_SHIFT			25
> > +#define BCH_EN_SHIFT			27
> > +#define ECC_SIZE_SHIFT			16
> > +
> > +#define MEM_ADDR_MASK			GENMASK(7, 0)
> > +#define BCH_MODE_MASK			GENMASK(27, 25)
> > +
> > +#define CS_MASK				GENMASK(31, 30)
> > +#define CS_SHIFT			30
> > +
> > +#define PAGE_ERR_CNT_MASK		GENMASK(16, 8)
> > +#define PKT_ERR_CNT_MASK		GENMASK(7, 0)
> > +
> > +#define NVDDR_MODE			BIT(9)
> > +#define NVDDR_TIMING_MODE_SHIFT		3
> > +
> > +#define ONFI_ID_LEN			8
> > +#define TEMP_BUF_SIZE			1024
> > +#define NVDDR_MODE_PACKET_SIZE		8
> > +#define SDR_MODE_PACKET_SIZE		4
> > +
> > +#define ONFI_DATA_INTERFACE_NVDDR      BIT(4)
> > +#define EVENT_MASK	(XFER_COMPLETE | READ_READY | WRITE_READY |
> MBIT_ERROR)
> > +
> > +#define SDR_MODE_DEFLT_FREQ		80000000
> > +#define COL_ROW_ADDR(pos, val)			(((val) & 0xFF) << (8 * (pos)))
>=20
> Can you try to group registers offsets with their fields?
Ok, I will update.
>=20
> > +
> > +struct anfc_op {
> > +	s32 cmnds[4];
>=20
> 	    ^ cmds?
Ok, I will correct it.
>=20
> And why is it an s32 and not a u32?
To monitor NAND_CMD_STATUS.
Sometimes core will just send status command without reading back the statu=
s data and later
It will try to read one byte using ->exec_op().
So Arasan has FLASH_STS register and whenever we initiate a status command,=
 the controller
Will update this register with the value returned by the flash device.
So we need to return this value when core is asking about 1 byte status val=
ue without issuing the command.
And in driver we are using memset(nfc_op, 0, sizeof(struct anfc_op)), this =
will make cmnds[4] to zeros but 0x0 is also
NAND_CMD_READ0, so inorder to differentiate whether to give status data or =
not, I just assigned=20
	nfc_op->cmnds[0] =3D NAND_CMD_NONE;

May be this case we can now eliminate as per your suggestion(defining a sep=
arate hook for each pattern) and thanks for that.
>=20
> > +	u32 type;
> > +	u32 len;
> > +	u32 naddrs;
> > +	u32 col;
> > +	u32 row;
> > +	unsigned int data_instr_idx;
> > +	unsigned int rdy_timeout_ms;
> > +	unsigned int rdy_delay_ns;
> > +	const struct nand_op_instr *data_instr; };
>=20
> Please make sure you actually need to redefine all these fields. Looks li=
ke some them could be
> extracted directly from the nand_op_instr objects.
Ok, all these values are getting updated in anfc_parse_instructions()
>=20
> > +
> > +/**
> > + * struct anfc_nand_chip - Defines the nand chip related information
> > + * @node:		used to store NAND chips into a list.
> > + * @chip:		NAND chip information structure.
> > + * @bch:		Bch / Hamming mode enable/disable.
> > + * @bchmode:		Bch mode.
>=20
> What's the difference between bch and bchmode?
@bch -> to select error correction method(either BCH or Hamming)
@bchmode -> to select ECC correctability (4/8/12/24 bit ECC)
>=20
> > + * @eccval:		Ecc config value.
> > + * @raddr_cycles:	Row address cycle information.
> > + * @caddr_cycles:	Column address cycle information.
> > + * @pktsize:		Packet size for read / write operation.
> > + * @csnum:		chipselect number to be used.
>=20
> So that means you only support chips with a single CS, right?
Yes
>=20
> > + * @spktsize:		Packet size in ddr mode for status operation.
> > + * @inftimeval:		Data interface and timing mode information
> > + */
> > +struct anfc_nand_chip {
> > +	struct list_head node;
> > +	struct nand_chip chip;
> > +	bool bch;
> > +	u32 bchmode;
> > +	u32 eccval;
> > +	u16 raddr_cycles;
> > +	u16 caddr_cycles;
> > +	u32 pktsize;
> > +	int csnum;
> > +	u32 spktsize;
> > +	u32 inftimeval;
> > +};
> > +
>=20
> [...]
>=20
> > +
> > +static void anfc_rw_dma_op(struct mtd_info *mtd, uint8_t *buf, int len=
,
> > +			    bool do_read, u32 prog)
> > +{
> > +	dma_addr_t paddr;
> > +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> > +	struct anfc_nand_controller *nfc =3D to_anfc(chip->controller);
> > +	struct anfc_nand_chip *achip =3D to_anfc_nand(chip);
> > +	u32 eccintr =3D 0, dir;
> > +	u32 pktsize =3D len, pktcount =3D 1;
> > +
> > +	if (((nfc->curr_cmd =3D=3D NAND_CMD_READ0)) ||
> > +	    (nfc->curr_cmd =3D=3D NAND_CMD_SEQIN && !nfc->iswriteoob)) {
>=20
> No, really, this looks wrong. If you need special handling for the
> read_page() case, implement it in the chip->ecc.read_page[_raw]() hooks.
Let me check this.
>=20
> > +		pktsize =3D achip->pktsize;
> > +		pktcount =3D DIV_ROUND_UP(mtd->writesize, pktsize);
> > +	}
> > +	anfc_setpktszcnt(nfc, pktsize, pktcount);
> > +
> > +	if (!achip->bch && nfc->curr_cmd =3D=3D NAND_CMD_READ0)
> > +		eccintr =3D MBIT_ERROR;
>=20
> Again, this should go in chip->ecc.read_page().
Let me try this approach, implementing ecc.read_page().
>=20
> > +
> > +	if (do_read)
> > +		dir =3D DMA_FROM_DEVICE;
> > +	else
> > +		dir =3D DMA_TO_DEVICE;
> > +
> > +	paddr =3D dma_map_single(nfc->dev, buf, len, dir);
> > +	if (dma_mapping_error(nfc->dev, paddr)) {
> > +		dev_err(nfc->dev, "Read buffer mapping error");
> > +		return;
> > +	}
> > +	writel(paddr, nfc->base + DMA_ADDR0_OFST);
> > +	writel((paddr >> 32), nfc->base + DMA_ADDR1_OFST);
> > +	anfc_enable_intrs(nfc, (XFER_COMPLETE | eccintr));
> > +	writel(prog, nfc->base + PROG_OFST);
> > +	anfc_wait_for_event(nfc);
> > +	dma_unmap_single(nfc->dev, paddr, len, dir); }
> > +
> > +static void anfc_rw_pio_op(struct mtd_info *mtd, uint8_t *buf, int len=
,
> > +			    bool do_read, int prog)
> > +{
> > +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> > +	struct anfc_nand_controller *nfc =3D to_anfc(chip->controller);
> > +	struct anfc_nand_chip *achip =3D to_anfc_nand(chip);
> > +	u32 *bufptr =3D (u32 *)buf;
> > +	u32 cnt =3D 0, intr =3D 0;
> > +	u32 pktsize =3D len, pktcount =3D 1;
> > +
> > +	anfc_config_dma(nfc, 0);
> > +
> > +	if (((nfc->curr_cmd =3D=3D NAND_CMD_READ0)) ||
> > +	    (nfc->curr_cmd =3D=3D NAND_CMD_SEQIN && !nfc->iswriteoob)) {
> > +		pktsize =3D achip->pktsize;
> > +		pktcount =3D DIV_ROUND_UP(mtd->writesize, pktsize);
> > +	}
> > +	anfc_setpktszcnt(nfc, pktsize, pktcount);
> > +
> > +	if (!achip->bch && nfc->curr_cmd =3D=3D NAND_CMD_READ0)
> > +		intr =3D MBIT_ERROR;
> > +
> > +	if (do_read)
> > +		intr |=3D READ_READY;
> > +	else
> > +		intr |=3D WRITE_READY;
> > +
> > +	anfc_enable_intrs(nfc, intr);
> > +	writel(prog, nfc->base + PROG_OFST);
> > +	while (cnt < pktcount) {
> > +
> > +		anfc_wait_for_event(nfc);
> > +		cnt++;
> > +		if (cnt =3D=3D pktcount)
> > +			anfc_enable_intrs(nfc, XFER_COMPLETE);
> > +		if (do_read)
> > +			ioread32_rep(nfc->base + DATA_PORT_OFST, bufptr,
> > +				     pktsize / 4);
> > +		else
> > +			iowrite32_rep(nfc->base + DATA_PORT_OFST, bufptr,
> > +				      pktsize / 4);
> > +		bufptr +=3D (pktsize / 4);
> > +		if (cnt < pktcount)
> > +			anfc_enable_intrs(nfc, intr);
> > +	}
> > +	anfc_wait_for_event(nfc);
> > +}
> > +
> > +static void anfc_read_data_op(struct mtd_info *mtd, uint8_t *buf, int
> > +len)
>=20
> Pass a nand_chip object directly and use u8 instead of uint8_t. This appl=
ies to all other
> internal functions you define.
Ok, i will do that.
>=20
> > +{
> > +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> > +	struct anfc_nand_controller *nfc =3D to_anfc(chip->controller);
> > +
> > +	if (nfc->dma && !is_vmalloc_addr(buf))
>=20
> You should use virt_is_valid() not is_vmalloc_addr(). Alternatively, you =
can just set the
> NAND_USE_BOUNCE_BUFFER flag in chip->options, and you'll be guaranteed to=
 have a
> DMA-able buffer passed to the
> chip->ecc.read/write_page_[raw]() hooks.
Sure, I will update it.
>=20
> > +		anfc_rw_dma_op(mtd, buf, len, 1, PROG_PGRD);
> > +	else
> > +		anfc_rw_pio_op(mtd, buf, len, 1, PROG_PGRD); }
> > +
> > +static void anfc_write_data_op(struct mtd_info *mtd, const uint8_t *bu=
f,
> > +			       int len)
> > +{
> > +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> > +	struct anfc_nand_controller *nfc =3D to_anfc(chip->controller);
> > +
> > +	if (nfc->dma && !is_vmalloc_addr(buf))
> > +		anfc_rw_dma_op(mtd, (char *)buf, len, 0, PROG_PGPROG);
> > +	else
> > +		anfc_rw_pio_op(mtd, (char *)buf, len, 0, PROG_PGPROG); }
> > +
> > +static int anfc_prep_nand_instr(struct mtd_info *mtd, int cmd,
> > +				struct nand_chip *chip,  int col, int page) {
> > +	u8 addrs[5];
> > +
> > +	struct nand_op_instr instrs[] =3D {
> > +		NAND_OP_CMD(cmd, PSEC_TO_NSEC(1)),
>=20
> Where do you get that delay from? Please don't use random delays.
As per your suggestion I will use core helpers, and I will remove these ran=
dom delays.
>=20
> > +		NAND_OP_ADDR(3, addrs, 0),
> > +	};
> > +	struct nand_operation op =3D NAND_OPERATION(instrs);
> > +
> > +	if (mtd->writesize <=3D 512) {
> > +		addrs[0] =3D col;
> > +		if (page !=3D -1) {
> > +			addrs[1] =3D page;
> > +			addrs[2] =3D page >> 8;
> > +			instrs[1].ctx.addr.naddrs =3D 3;
> > +			if (chip->options & NAND_ROW_ADDR_3) {
> > +				addrs[3] =3D page >> 16;
> > +				instrs[1].ctx.addr.naddrs +=3D 1;
> > +			}
> > +		} else {
> > +			instrs[1].ctx.addr.naddrs =3D 1;
> > +		}
> > +	} else {
> > +		addrs[0] =3D col;
> > +		addrs[1] =3D col >> 8;
> > +		if (page !=3D -1) {
> > +			addrs[2] =3D page;
> > +			addrs[3] =3D page >> 8;
> > +			instrs[1].ctx.addr.naddrs =3D 4;
> > +			if (chip->options & NAND_ROW_ADDR_3) {
> > +				addrs[4] =3D page >> 16;
> > +				instrs[1].ctx.addr.naddrs +=3D 1;
> > +			}
> > +		} else {
> > +			instrs[1].ctx.addr.naddrs =3D 2;
> > +		}
> > +	}
>=20
> Hm, why do you need to do that? The core already provide appropriate help=
ers abstracting
> that for you. What's missing?
I didn't find any helper API that will do this command and page framing or =
maybe I am wrong.
The issue here is, I have to update command and address fields. I found one=
 helper nand_fill_column_cycles(),
But it is static.
And also I just referred the driver drivers/mtd/nand/raw/nand_hynix.c, wher=
e hynix_nand_reg_write_op() is
Doing similar stuff, updating addr value.
And let me try as per your suggestion(use directly chip->oob_poi) if that w=
orks, I will remove all this code.

>=20
> > +
> > +	return nand_exec_op(chip, &op);
> > +}
> > +
> > +static int anfc_nand_wait(struct mtd_info *mtd, struct nand_chip
> > +*chip) {
> > +	u8 status;
> > +	int ret;
> > +	unsigned long timeo;
> > +
> > +	/*
> > +	 * Apply this short delay always to ensure that we do wait tWB in any
> > +	 * case on any machine.
> > +	 */
> > +	ndelay(100);
> > +	timeo =3D jiffies + msecs_to_jiffies(STATUS_TIMEOUT);
> > +	do {
> > +		ret =3D nand_status_op(chip, &status);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (status & NAND_STATUS_READY)
> > +			break;
> > +		cond_resched();
> > +	} while (time_before(jiffies, timeo));
>=20
> We have an helper doing that for you. Plus, ->waitfunc() should not be im=
plemented when -
> >exec_op() is implemented.
Ok, got it, I will change it.
>=20
> > +
> > +
> > +	return status;
> > +}
> > +
> > +static int anfc_write_oob(struct mtd_info *mtd, struct nand_chip *chip=
,
> > +			  int page)
> > +{
> > +	struct anfc_nand_controller *nfc =3D to_anfc(chip->controller);
> > +
> > +	nfc->iswriteoob =3D true;
> > +	anfc_prep_nand_instr(mtd, NAND_CMD_SEQIN, chip, mtd->writesize, page)=
;
> > +	anfc_write_data_op(mtd, chip->oob_poi, mtd->oobsize);
> > +	nfc->iswriteoob =3D false;
>=20
> I'm really not a big fan of this ->iswriteoob var. Not sure why it's used=
 for.
This is to differentiate whether the current operation is an OOB read or Pa=
ge read.
Anyway, as you pointed, I will use chip->ecc.read/write_page_[raw]() hooks,=
 which will eliminate these also.
>=20
> > +
> > +	return 0;
> > +}
>=20
>=20
> > +static int anfc_write_page_hwecc(struct mtd_info *mtd,
> > +				 struct nand_chip *chip, const uint8_t *buf,
> > +				 int oob_required, int page)
> > +{
> > +	int ret;
> > +	struct anfc_nand_controller *nfc =3D to_anfc(chip->controller);
> > +	struct anfc_nand_chip *achip =3D to_anfc_nand(chip);
> > +	u8 status;
> > +	u8 *ecc_calc =3D chip->ecc.calc_buf;
> > +
> > +	ret =3D nand_prog_page_begin_op(chip, page, 0, NULL, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	anfc_set_eccsparecmd(nfc, achip, NAND_CMD_RNDIN, 0);
> > +	anfc_config_ecc(nfc, true);
> > +	anfc_write_data_op(mtd, buf, mtd->writesize);
> > +
> > +	if (oob_required) {
> > +		status =3D anfc_nand_wait(mtd, chip);
> > +		if (status & NAND_STATUS_FAIL)
> > +			return -EIO;
> > +
> > +		anfc_prep_nand_instr(mtd, NAND_CMD_READOOB, chip, 0, page);
> > +		anfc_read_data_op(mtd, ecc_calc, mtd->oobsize);
> > +		ret =3D mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi,
> > +						 0, chip->ecc.total);
> > +		if (ret)
> > +			return ret;
>=20
> No, that's not how we do. Just take the OOB bytes placed in
> chip->oob_poi.
Ok, let me check this.
>=20
> > +
> > +		chip->ecc.write_oob(mtd, chip, page);
> > +	}
> > +	status =3D anfc_nand_wait(mtd, chip);
> > +	if (status & NAND_STATUS_FAIL)
> > +		return -EIO;
> > +
> > +	anfc_config_ecc(nfc, false);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * anfc_get_mode_frm_timings - Converts sdr timing values to
> > +respective modes
> > + * @sdr: SDR NAND chip timings structure
> > + * Arasan NAND controller has Data Interface Register (0x6C)
> > + * which has timing mode configurations and need to program only the
> > +modes but
> > + * not timings. So this function returns SDR timing mode from SDR
> > +timing values
> > + *
> > + * Return: 	SDR timing mode on success, a negative error code otherwis=
e.
> > + */
> > +static int anfc_get_mode_frm_timings(const struct nand_sdr_timings
> > +*sdr) {
> > +	if (sdr->tRC_min <=3D 20000)
> > +		return 5;
> > +	else if (sdr->tRC_min <=3D 25000)
> > +		return 4;
> > +	else if (sdr->tRC_min <=3D 30000)
> > +		return 3;
> > +	else if (sdr->tRC_min <=3D 35000)
> > +		return 2;
> > +	else if (sdr->tRC_min <=3D 50000)
> > +		return 1;
> > +	else if (sdr->tRC_min <=3D 100000)
> > +		return 0;
> > +	else
> > +		return -1;
> > +}
>=20
> I'm sure we can add an onfi_timing_mode field in nand_sdr_timings so that=
 you don't have to
> guess it based on ->tRC.
Ok, then its fine.
>=20
> > +static int anfc_erase_function(struct nand_chip *chip,
> > +				   struct anfc_op nfc_op)
> > +{
> > +
> > +	struct anfc_nand_chip *achip =3D to_anfc_nand(chip);
> > +	struct anfc_nand_controller *nfc =3D to_anfc(chip->controller);
> > +
> > +	nfc->prog =3D PROG_ERASE;
> > +	anfc_prepare_cmd(nfc, nfc_op.cmnds[0], NAND_CMD_ERASE2, 0, 0,
>=20
> Please don't guess the opcodes. The pattern descriptors are just here to =
describe a sequence of
> CMD, ADDR and DATA cycles, nothing more. The CMD opcodes can be tweaked i=
f needed as
> long as the sequence is the same.
Ok, sure I will just use the pattern commands.
>=20
> > +			 achip->raddr_cycles);
> > +	nfc_op.col =3D nfc_op.row & 0xffff;
> > +	nfc_op.row =3D (nfc_op.row >> PG_ADDR_SHIFT) & 0xffff;
> > +	anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> > +
> > +	anfc_enable_intrs(nfc, XFER_COMPLETE);
> > +	writel(nfc->prog, nfc->base + PROG_OFST);
> > +	anfc_wait_for_event(nfc);
> > +
> > +	return 0;
> > +}
>=20
> > +static int anfc_reset_type_exec(struct nand_chip *chip,
> > +				   const struct nand_subop *subop) {
> > +	struct anfc_op nfc_op =3D {};
> > +	struct anfc_nand_controller *nfc =3D to_anfc(chip->controller);
> > +
> > +	anfc_parse_instructions(chip, subop, &nfc_op);
> > +	anfc_prepare_cmd(nfc, nfc_op.cmnds[0], 0, 0, 0, 0);
> > +	nfc->prog =3D PROG_RST;
> > +	anfc_enable_intrs(nfc, XFER_COMPLETE);
> > +	writel(nfc->prog, nfc->base + PROG_OFST);
> > +	anfc_wait_for_event(nfc);
> > +
> > +	return 0;
> > +}
>=20
> This one looks correct.
Thanks and I will implement separate hooks for each pattern.
>=20
> > +
> > +static const struct nand_op_parser anfc_op_parser =3D NAND_OP_PARSER
> > +	(NAND_OP_PARSER_PATTERN
> > +		(anfc_exec_op_cmd,
> > +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 7),
> > +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false),
> > +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, 2048)),
> > +	NAND_OP_PARSER_PATTERN
> > +		(anfc_exec_op_cmd,
> > +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, 2048)),
> > +	NAND_OP_PARSER_PATTERN
> > +		(anfc_exec_op_cmd,
> > +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 7),
> > +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false),
> > +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, 2048)),
> > +	NAND_OP_PARSER_PATTERN
> > +		(anfc_exec_op_cmd,
> > +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 8),
> > +		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, 2048),
> > +		//NAND_OP_PARSER_PAT_CMD_ELEM(true),
> > +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
> > +	NAND_OP_PARSER_PATTERN
> > +		(anfc_exec_op_cmd,
> > +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 8),
> > +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> > +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, 2048)),
> > +	NAND_OP_PARSER_PATTERN
> > +		(anfc_reset_type_exec,
> > +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
>=20
> And the reset pattern desc looks correct too.
>=20
> > +	NAND_OP_PARSER_PATTERN
> > +		(anfc_status_type_exec,
> > +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, 1)),
> > +	);
> > +
>=20
> > +
> > +static void anfc_select_chip(struct mtd_info *mtd, int num) {
> > +
> > +	u32 val;
> > +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> > +	struct anfc_nand_chip *achip =3D to_anfc_nand(chip);
> > +	struct anfc_nand_controller *nfc =3D to_anfc(chip->controller);
> > +
> > +	if (num =3D=3D -1)
> > +		return;
>=20
> You only support one CS per chip, so maybe you should check that num < 1.
Ok, I will update it.
>=20
> > +
> > +	val =3D readl(nfc->base + MEM_ADDR2_OFST);
> > +	val &=3D (val & ~(CS_MASK | BCH_MODE_MASK));
> > +	val |=3D (achip->csnum << CS_SHIFT) | (achip->bchmode << BCH_MODE_SHI=
FT);
> > +	writel(val, nfc->base + MEM_ADDR2_OFST);
> > +	nfc->csnum =3D achip->csnum;
> > +	writel(achip->eccval, nfc->base + ECC_OFST);
> > +	writel(achip->inftimeval, nfc->base + DATA_INTERFACE_OFST); }
> > +
> > +static irqreturn_t anfc_irq_handler(int irq, void *ptr) {
> > +	struct anfc_nand_controller *nfc =3D ptr;
> > +	u32 status;
> > +
> > +	status =3D readl(nfc->base + INTR_STS_OFST);
> > +	if (status & EVENT_MASK) {
> > +		complete(&nfc->event);
> > +		writel((status & EVENT_MASK), nfc->base + INTR_STS_OFST);
>=20
> 			^ parens uneeded here
>=20
> > +		writel(0, nfc->base + INTR_STS_EN_OFST);
> > +		writel(0, nfc->base + INTR_SIG_EN_OFST);
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	return IRQ_NONE;
> > +}
>=20
> I haven't finished reviewing the driver but there are still a bunch of th=
ings that look strange,
> for instance, your ->read/write_page() implementation looks suspicious. L=
et's discuss that
> before you send a new version.
Ok, I will wait for it.
>=20
> Also, please run checkpatch --strict and fix all errors and warnings (unl=
ess you have a good
> reason not to).
Sure, I will do that and thanks for your time.

Thanks,
Naga Sureshkumar Relli
>=20
> Thanks,
>=20
> Boris
