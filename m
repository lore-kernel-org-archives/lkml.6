Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C0BC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A0C2563E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3vu5QjNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A0C2563E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754686AbeFYI4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:56:49 -0400
Received: from mail-eopbgr720064.outbound.protection.outlook.com ([40.107.72.64]:45449
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752620AbeFYI4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6X29Am6xShs0OWJ4X8/lkH9O/50sqzttY3PKtAP+2h4=;
 b=3vu5QjNCIsHYNq87y/mrk07HnfcpM8VFnQODbPKyI1KdnMXFNysZqymYpAfMXkKgd2Mw+CGNz6jje9YRln2ldg7ObRotxJzJojhl2o9seYjS7uZjPDWQNfRkAqhdh6kNdcC3660dvD822JgcYhBKomZ8O/SHNxMyuQ3J7XGlOJ0=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB3215.namprd02.prod.outlook.com (10.164.133.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.20; Mon, 25 Jun 2018 08:56:42 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::fcca:2142:386d:ec1b]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::fcca:2142:386d:ec1b%8]) with mapi id 15.20.0884.024; Mon, 25 Jun 2018
 08:56:41 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "mmayer@broadcom.com" <mmayer@broadcom.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "ladis@linux-mips.org" <ladis@linux-mips.org>,
        "ada@thorsis.com" <ada@thorsis.com>,
        "honghui.zhang@mediatek.com" <honghui.zhang@mediatek.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [[LINUX PATCH v10] 3/4] Documentation: nand: pl353: Add
 documentation for controller and driver
Thread-Topic: [[LINUX PATCH v10] 3/4] Documentation: nand: pl353: Add
 documentation for controller and driver
Thread-Index: AQHUCSsiBBSirPZfYkmY2lWGh+TOWKRv6L2AgADFW5A=
Date:   Mon, 25 Jun 2018 08:56:41 +0000
Message-ID: <MWHPR02MB26234FD1B68C2B5ECC6B87F6AF4A0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1529563351-2241-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20180624225427.67c4d9c3@bbrezillon>
In-Reply-To: <20180624225427.67c4d9c3@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB3215;7:toYWeXOg938OvwhnaGdSAlzptO90pBIbJuR545Wq7uZmNB/CXcFrW750Er+GhI0tmXM/wnrrdXw4dYU++bhuIlvSNUBiqOxY2/d0/upYAJN66603rCf10Z/l8QgQxnVKlApVGXu1WFzA2Qcic0kj901ZBmupCAPmCNWKJ+tHAPs/2pn5Jw4EkvRgbGaMqF37SybAcrNFDQsDOE7JKcdD8moS4fnbPHbe2jTNBzzvPmWFkSwtqx90civVpyTfxobW
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(39380400002)(396003)(366004)(346002)(39860400002)(13464003)(189003)(199004)(186003)(53546011)(106356001)(229853002)(25786009)(68736007)(5660300001)(81156014)(81166006)(53936002)(6436002)(105586002)(6306002)(8676002)(3280700002)(5250100002)(74316002)(476003)(4326008)(11346002)(6246003)(2906002)(486006)(3660700001)(9686003)(55016002)(478600001)(39060400002)(7736002)(26005)(102836004)(6506007)(8936002)(3846002)(55236004)(33656002)(2900100001)(6116002)(446003)(99286004)(7696005)(59450400001)(86362001)(305945005)(66066001)(7416002)(14454004)(6916009)(54906003)(316002)(76176011)(97736004)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3215;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: ad4e3245-3119-415b-fafa-08d5da7991a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB3215;
x-ms-traffictypediagnostic: MWHPR02MB3215:
x-microsoft-antispam-prvs: <MWHPR02MB32155C81843E00DA65CC58FBAF4A0@MWHPR02MB3215.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(31051911155226)(9452136761055)(85827821059158)(258649278758335)(192813158149592)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB3215;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB3215;
x-forefront-prvs: 0714841678
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8xoasJu6JfZMySzcrIXGZvVOQUS/X6bdI0xxmsizMSdeHf/6zDPVPYIsQfjBp3gg5eTyMnhKCVM9pxZoDsVVJnHCByMfnd/ncEiJcH8jvkFWnum27CDGBMWU2c17xAat7I6ALs3UgXEEsvRF0f/rlgT3Pnpk2ycJ6cB0qAs7ranYzmFOwfC2MhH8IK3cJxMaVOH4Q+yMVqHvjHjxgLGO6p+Usj8w/p9u0nvGPb7TQvQ+4sgFU8YYE6M5cz5W8bcw4BDPcXb97zhiebiwkT+PtIVj8CZ7sdBrIWEyt2vqwFQqMg9p1/xyLPL33K4grA9LcOTegU4BMOZrsd37w4AHYbP7E/lD6YBIkcaHtL16vIE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4e3245-3119-415b-fafa-08d5da7991a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 08:56:41.1234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, June 25, 2018 2:24 AM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: richard@nod.at; dwmw2@infradead.org; computersforpeace@gmail.com;
> marek.vasut@gmail.com; f.fainelli@gmail.com; mmayer@broadcom.com; rogerq@=
ti.com;
> ladis@linux-mips.org; ada@thorsis.com; honghui.zhang@mediatek.com;
> miquel.raynal@bootlin.com; nagasureshkumarrelli@gmail.com; Michal Simek
> <michals@xilinx.com>; linux-mtd@lists.infradead.org; linux-kernel@vger.ke=
rnel.org
> Subject: Re: [[LINUX PATCH v10] 3/4] Documentation: nand: pl353: Add docu=
mentation
> for controller and driver
>=20
> On Thu, 21 Jun 2018 12:12:30 +0530
> Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
>=20
> > Added notes about the controller and driver.
> >
> > Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.co=
m>
> > ---
> > Changes in v10:
> >  - None
> > Changes in v9:
> >  - Addressed the comments given by Miquel and Randy
> > Changes in v8
> >  - None
> > Changes in v7:
> > - None
> > Changes in v6:
> > - None
> > Changes in v5:
> > - Fixed the review comments
> > Changes in v4:
> > - None
> > ---
> >  Documentation/mtd/nand/pl353-nand.txt | 99
> +++++++++++++++++++++++++++++++++++
> >  1 file changed, 99 insertions(+)
> >  create mode 100644 Documentation/mtd/nand/pl353-nand.txt
>=20
> Can we put these information directly in the driver instead of having
> yet another place where we have things partially documented? I just
> discovered a doc for the pxa NAND controller in this directory because
> of this patch, which kind of proves my point :-).
Ok, but could you please explain where to put in driver?
Do you mean, as comments inside drivers/mtd/raw/pl353-nand.c?

>=20
> >
> > diff --git a/Documentation/mtd/nand/pl353-nand.txt b/Documentation/mtd/=
nand/pl353-
> nand.txt
> > new file mode 100644
> > index 0000000..c352c87
> > --- /dev/null
> > +++ b/Documentation/mtd/nand/pl353-nand.txt
> > @@ -0,0 +1,99 @@
> > +This document provides some notes about the ARM pl353 SMC controller u=
sed in
> > +Zynq SOC and confined to NAND specific details.
> > +
> > +Overview of the controller
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > +	The SMC (PL353) supports two memory interfaces:
> > +	Interface 0 type SRAM.
> > +	Interface 1 type NAND.
> > +	This configuration supports the following configurable options:
> > +	   . 32-bit or 64-bit AXI data width
> > +	   . 8-bit, 16-bit, or 32-bit memory data width for interface 0
> > +	   . 8-bit, or 16-bit memory data width for interface 1
> > +	   . 1-4 chip selects on each interface
> > +	   . SLC ECC block for interface 1
> > +
> > +For more information, refer the below link for TRM
> >
> +http://infocenter.arm.com/help/topic/com.arm.doc.ddi0380g/DDI0380G_smc_p=
l350_series
> _r2p1_trm.pdf
> > +
> > +NAND memory accesses
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +	. Two phase NAND accesses
> > +	. NAND command phase transfers
> > +	. NAND data phase transfers
> > +
> > +Two phase NAND accesses
> > +	The SMC defines two phases of commands when transferring data to or f=
rom
> > +NAND flash.
> > +
> > +Command phase
> > +	Commands and optional address information are written to the NAND fla=
sh.
> > +The command and address can be associated with either a data phase ope=
ration to
> > +write to or read from the array, or a status/ID register transfer.
> > +
> > +Data phase
> > + Data is either written to or read from the NAND flash. This data can =
be either
> > +data transferred to or from the array, or status/ID register informati=
on.
> > +
> > +NAND AXI address setup
> > +       AXI address      Command phase      Data phase
> > +	[31:24]         Chip address       Chip address
> > +	[23]            NoOfAddCycles_2    Reserved
> > +	[22]            NoOfAddCycles_1    Reserved
> > +	[21]            NoOfAddCycles_0    ClearCS
> > +	[20]            End command valid  End command valid
> > +	[19]            0                  1
> > +	[18:11]         End command        End command
> > +	[10:3]          Start command      [10] ECC Last
> > +					   [9:3] Reserved
> > +	[2:0]           Reserved           Reserved
> > +
> > +ECC
> > +=3D=3D=3D
> > +    It operates on a number of 512 byte blocks of NAND memory and can =
be
> > +programmed to store the ECC codes after the data in memory. For writes=
,
> > +the ECC is written to the spare area of the page. For reads, the resul=
t of
> > +a block ECC check are made available to the device driver.
> > +
> > +----------------------------------------------------------------------=
--
> > +|               n * 512 blocks                  | extra  | ecc    |   =
  |
> > +|                                               | block  | codes  |   =
  |
> > +----------------------------------------------------------------------=
--
> > +
> > +The ECC calculation uses a simple Hamming code, using 1-bit correction=
 2-bit
> > +detection. It starts when a valid read or write command with a 512 byt=
e aligned
> > +address is detected on the memory interface.
> > +
> > +Driver details
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +	The NAND driver has dependency with the pl353_smc memory controller
> > +driver for initializing the NAND timing parameters, bus width, ECC mod=
es,
> > +control and status information.
> > +
> > +Since the controller expects that the chip select bit would be cleared=
 for the
> > +last data transfer i.e last 4 data bytes, the existing nand page
> > +read/write routines for soft ECC and ECC none modes will not work. So,=
 in order
> > +to make this driver work, it always updates the ECC mode as HW ECC and
> > +implements the page read/write functions for supporting the SW ECC.
> > +i.e. There is a limitation in SMC controller, that we must set ECC LAS=
T on
> > +last data phase access, to tell ECC block not to expect any data furth=
er.
> > +Ex:  When number of ECC STEPS are 4, then till 3 we will write to flas=
h
> > +using SMC with HW ECC enabled. And for the last ECC STEP, we will subt=
ract
> > +4bytes from page size, and will initiate a transfer. And the remaining=
 4 as
> > +one more transfer with ECC_LAST bit set in NAND data phase register to=
 notify
> > +ECC block not to expect any more data. The last block should be align =
with end
> > +of 512 byte block. Because of this limitation, we are not using core r=
outines.
> > +
> > +HW ECC mode:
> > +	Up to 2K page size is supported and beyond that it returns
> > +-ENOTSUPPORT error. If the flash has on-die ECC controller then the
> > +priority is given to the on-die ECC controller. Also the current
> > +implementation has support for up to 64 bytes of OOB data.
> > +
> > +SW ECC mode:
> > +	It supports all the page sizes. But since, Zynq SOC bootrom uses
> > +HW ECC for the devices that have page <=3D 2K. so, When the kernel is =
not
> > +aware of the ECC mode, it uses HW ECC by default.
> > +
> > +For devicetree binding information please refer to the below dt bindin=
g file
> > +Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt.

Thanks,
Naga Sureshkumar Relli.
