Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67906C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC0420658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GFCRqdEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC0420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbeJVStK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:49:10 -0400
Received: from mail-eopbgr690081.outbound.protection.outlook.com ([40.107.69.81]:31232
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727797AbeJVStJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PQgUJuRz6brHn4rYd2sYeUEvQpnGUcr0rhQ/nP/rvM=;
 b=GFCRqdEYCnXRwFoNorPTxUEKg2aibJ4phElnG5my47ByeQnqM9yAgnX3knjt0zrHP/1771iiERKZhHjjI0GxdALCig7CLfPAIkSEi7jMTnPV73p+L8ljDJE6ehUiqmZL23c5L8VjNir1OcI7+RYTzLHFHDpa1O5L3HaWdzY7PFE=
Received: from BYAPR02MB4710.namprd02.prod.outlook.com (52.135.232.23) by
 BYAPR02MB3925.namprd02.prod.outlook.com (20.176.248.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Mon, 22 Oct 2018 10:31:01 +0000
Received: from BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::8d0d:7d34:1d3:52d]) by BYAPR02MB4710.namprd02.prod.outlook.com
 ([fe80::8d0d:7d34:1d3:52d%4]) with mapi id 15.20.1250.028; Mon, 22 Oct 2018
 10:31:01 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Moritz Fischer <mdf@kernel.org>
CC:     Moritz Fischer <moritz.fischer@ettus.com>,
        Moritz Fischer <moritz.fischer.private@gmail.com>,
        Alan Tull <atull@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: RE: [PATCH 3/3] fpga manager: Adding FPGA Manager support for Xilinx
 zynqmp
Thread-Topic: [PATCH 3/3] fpga manager: Adding FPGA Manager support for Xilinx
 zynqmp
Thread-Index: AQHUZ4izEyYJo0F/yk269IKpDT/Ht6UnFPUAgABFVACAA7DPYIAACDqAgAABHjA=
Date:   Mon, 22 Oct 2018 10:31:01 +0000
Message-ID: <BYAPR02MB4710080A6C3947734D8FB21CC2F40@BYAPR02MB4710.namprd02.prod.outlook.com>
References: <20181020084805.29103-1-nava.manne@xilinx.com>
 <20181020084805.29103-4-nava.manne@xilinx.com>
 <CAJYdmePxnkG=3iJC5Lewq3n3zFGTKASJX7ceUEufBvOJogCfdA@mail.gmail.com>
 <CAAtXAHdP6z5NG+EAvW_N_RfcPv59e15hkd83AR-L3RDBrLMvcQ@mail.gmail.com>
 <BYAPR02MB47106D61C0CDB8268BAF4E44C2F40@BYAPR02MB4710.namprd02.prod.outlook.com>
 <20181022102255.GA1428@archbook>
In-Reply-To: <20181022102255.GA1428@archbook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR02MB3925;6:EutyCtvS1BMMaOGTBLPu+cotdt3atZNyfwYfcVrCCVY1j4yK4cxsEnxjsnHprBcg9qSftm0D7zLQoP5gSrHVPn++6FYkhmkISP2q0qINfsrdKibijUAb3TJqwqcjzL1pwZSVdaDnud0ejALeli2QlhMC7M8CgV9K9Gal8kF7t7vD8dbXEgDYq9I5NFfatT9IzTKLiBqbafFdQIKQNTFBzb8qEs+g2gPYhdUZjglhd+/GbfotaxnwTRvblbl3IMlC+ZEkbmQzYeUbkTDkZmnyq3LvE9Gfy7or2Ky+UjsRwUiqOk7QVqpVVr69cB/0Sp90YujSVyKMbd1KaCDT6BeTSbUBLi3TuNJ88dD06lFch44vufECCtBW3cmpMcIJmtI4qyXSfErNGUixb1F5GYd4odE8UE0XIKK6qxQKMhZ4WDU3Q8C955H8obgoiqnqD8ZYEn2AK69qoHCYGZiBIRYuCA==;5:C0Bo+wXrfEygTDt0ZJkmhjaYRmYEalNnpOsClAFBXiQ5YarfzyQzhaeV5otrzR+8kv4DfvaFWBeckzVtGJGmoE/D+kIP2t7wJAWTFKQCYUdNAwXoGn7WdHTp6U6zeUyxmm2T5aNZcWnsbsxxnTYDIcBCOwjgZZmY3CJ/VD9FrnE=;7:hRPSE39v+RRjP3b4WZCM8OYKaJZl+MrYYj5SoISKKsrd0oBrZJ5LXVyghOCmvJLh3yeo7YIQc3XtjdV7n4rdQsK9/5sGWVL8jmRxT9Z37yWXmGfTDYpbPczLJAhcqEdRMciZozcQKqvcuCuGQNiVfrZItNlloItjX1tIyF+g3gaaloofONmLL1xfId6Fs/q+vaxz8eiaHxNmw9fE6hC8Ei2812Kvwo3sICVDgeS1LtH5HGmh5jp/mMj57t6AzwUO
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: a9363fb7-ed18-46ed-ad7d-08d6380976c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB3925;
x-ms-traffictypediagnostic: BYAPR02MB3925:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB3925D600241E98D41E6ACF2BC2F40@BYAPR02MB3925.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(85827821059158)(17755550239193)(192813158149592)(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB3925;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB3925;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(366004)(136003)(39860400002)(346002)(396003)(51914003)(13464003)(189003)(199004)(74316002)(316002)(478600001)(7696005)(2900100001)(9686003)(14454004)(76176011)(39060400002)(2906002)(256004)(4326008)(97736004)(8936002)(6506007)(54906003)(106356001)(6436002)(81166006)(81156014)(8676002)(66066001)(305945005)(55016002)(186003)(25786009)(102836004)(6116002)(3846002)(33656002)(105586002)(7736002)(229853002)(11346002)(99286004)(71200400001)(71190400001)(476003)(486006)(53936002)(26005)(446003)(5660300001)(53546011)(6246003)(7416002)(68736007)(5250100002)(6916009)(93886005)(86362001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB3925;H:BYAPR02MB4710.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iHlzN+8U9sBglM+JwgB1/Af7HxC1rrq4LPlQrPHcMlXhI/5T2iRdGu6uuP7rtuW53ma6HAULyT5V9SyPc1oeVkqS+tFVOMT57Ypzzh8KZNmZsxG93RPiqY/W8433Zp2MVo24LZbhfOSObcv7fp4jJC2wICcTffJV9YppcpxDHK9LlemT0AqqhkKzB+fWx6JijII8I3REXUqD7wV2kVJVis29EcyUHFsHSmWmjsH2RvoZsamwxCbDOZuNOKNfs8x9zVTUfu17OcC7C0Ux1f5eVv1IiSsAV8xc1JHGh6cT7TM0R0PzXMXCP1nXB58HQYkK9DZFOmYZYpH2AE6fVlxLGYxyPzbXNzdiXS2ojgd06/E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9363fb7-ed18-46ed-ad7d-08d6380976c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 10:31:01.6403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB3925
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Moritz,

Thanks for the quick response..
Please find my response inline.

> -----Original Message-----
> From: Moritz Fischer [mailto:mdf@kernel.org]
> Sent: Monday, October 22, 2018 3:53 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: Moritz Fischer <moritz.fischer@ettus.com>; Moritz Fischer
> <moritz.fischer.private@gmail.com>; Alan Tull <atull@kernel.org>; Rob Her=
ring
> <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>; Michal Simek
> <michals@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah
> <JOLLYS@xilinx.com>; linux-fpga@vger.kernel.org; Devicetree List
> <devicetree@vger.kernel.org>; linux-arm-kernel <linux-arm-
> kernel@lists.infradead.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; chinnikishore369@gmail.com
> Subject: Re: [PATCH 3/3] fpga manager: Adding FPGA Manager support for
> Xilinx zynqmp
>=20
> On Mon, Oct 22, 2018 at 10:03:55AM +0000, Nava kishore Manne wrote:
> > Hi Mortiz,
> >
> > Thanks for the quick response....
> > Please find my response inline.
> >
> > > -----Original Message-----
> > > From: Moritz Fischer [mailto:moritz.fischer@ettus.com]
> > > Sent: Saturday, October 20, 2018 7:02 AM
> > > To: Moritz Fischer <moritz.fischer.private@gmail.com>
> > > Cc: Nava kishore Manne <navam@xilinx.com>; Alan Tull
> > > <atull@kernel.org>; Rob Herring <robh+dt@kernel.org>; Mark Rutland
> > > <mark.rutland@arm.com>; Michal Simek <michals@xilinx.com>; Rajan
> > > Vaja <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>;
> > > linux-fpga@vger.kernel.org; Devicetree List
> > > <devicetree@vger.kernel.org>; linux-arm-kernel <linux-arm-
> > > kernel@lists.infradead.org>; Linux Kernel Mailing List <linux-
> > > kernel@vger.kernel.org>; chinnikishore369@gmail.com
> > > Subject: Re: [PATCH 3/3] fpga manager: Adding FPGA Manager support
> > > for Xilinx zynqmp
> > >
> > > On Fri, Oct 19, 2018 at 2:33 PM Moritz Fischer
> > > <moritz.fischer.private@gmail.com> wrote:
> > > >
> > > > Hi Nava,
> > > >
> > > > Looks good to me, a couple of nits inline below.
> > > >
> > > > On Fri, Oct 19, 2018 at 1:50 AM Nava kishore Manne
> > > > <nava.manne@xilinx.com> wrote:
> > > > >
> > > > > This patch adds FPGA Manager support for the Xilinx ZynqMp chip.
> > > >
> > > > Isn't it ZynqMP ?
> > > > >
> > > > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > > > ---
> > > > > Changes for v1:
> > > > >                 -None.
> > > > >
> > > > > Changes for RFC-V2:
> > > > >                 -Updated the Fpga Mgr registrations call's
> > > > >                  to 4.18
> > > > >
> > > > >  drivers/fpga/Kconfig       |   9 +++
> > > > >  drivers/fpga/Makefile      |   1 +
> > > > >  drivers/fpga/zynqmp-fpga.c | 159
> > > > > +++++++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 169 insertions(+)  create mode 100644
> > > > > drivers/fpga/zynqmp-fpga.c
> > > > >
> > > > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
> > > > > 1ebcef4bab5b..26ebbcf3d3a3 100644
> > > > > --- a/drivers/fpga/Kconfig
> > > > > +++ b/drivers/fpga/Kconfig
> > > > > @@ -56,6 +56,15 @@ config FPGA_MGR_ZYNQ_FPGA
> > > > >         help
> > > > >           FPGA manager driver support for Xilinx Zynq FPGAs.
> > > > >
> > > > > +config FPGA_MGR_ZYNQMP_FPGA
> > > > > +       tristate "Xilinx Zynqmp FPGA"
> > > > > +       depends on ARCH_ZYNQMP || COMPILE_TEST
> > > > > +       help
> > > > > +         FPGA manager driver support for Xilinx ZynqMP FPGAs.
> > > > > +         This driver uses processor configuration port(PCAP)
> > > > This driver uses *the* processor configuration port.
> > > >
> > > > > +         to configure the programmable logic(PL) through PS
> > > > > +         on ZynqMP SoC.
> > > > > +
> > > > >  config FPGA_MGR_XILINX_SPI
> > > > >         tristate "Xilinx Configuration over Slave Serial (SPI)"
> > > > >         depends on SPI
> > > > > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile index
> > > > > 7a2d73ba7122..3488ebbaee46 100644
> > > > > --- a/drivers/fpga/Makefile
> > > > > +++ b/drivers/fpga/Makefile
> > > > > @@ -16,6 +16,7 @@ obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)    +=3D
> > > socfpga-a10.o
> > > > >  obj-$(CONFIG_FPGA_MGR_TS73XX)          +=3D ts73xx-fpga.o
> > > > >  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)      +=3D xilinx-spi.o
> > > > >  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)       +=3D zynq-fpga.o
> > > > > +obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)     +=3D zynqmp-fpga.o
> > > > >  obj-$(CONFIG_ALTERA_PR_IP_CORE)         +=3D altera-pr-ip-core.o
> > > > >  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    +=3D altera-pr-ip-core-p=
lat.o
> > > > >
> > > > > diff --git a/drivers/fpga/zynqmp-fpga.c
> > > > > b/drivers/fpga/zynqmp-fpga.c new file mode 100644 index
> > > > > 000000000000..2760d7e3872a
> > > > > --- /dev/null
> > > > > +++ b/drivers/fpga/zynqmp-fpga.c
> > > > > @@ -0,0 +1,159 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > +/*
> > > > > + * Copyright (C) 2018 Xilinx, Inc.
> > > > > + */
> > > > > +
> > > > > +#include <linux/dma-mapping.h>
> > > > > +#include <linux/fpga/fpga-mgr.h> #include <linux/io.h> #include
> > > > > +<linux/kernel.h> #include <linux/module.h> #include
> > > > > +<linux/of_address.h> #include <linux/string.h> #include
> > > > > +<linux/firmware/xlnx-zynqmp.h>
> > > > > +
> > > > > +/* Constant Definitions */
> > > > > +#define IXR_FPGA_DONE_MASK     0X00000008U
> > > > > +
> > > > > +/**
> > > > > + * struct zynqmp_fpga_priv - Private data structure
> > > > > + * @dev:       Device data structure
> > > > > + * @flags:     flags which is used to identify the bitfile type
> > > > > + */
> > > > > +struct zynqmp_fpga_priv {
> > > > > +       struct device *dev;
> > > > > +       u32 flags;
> > > > > +};
> > > > > +
> > > > > +static int zynqmp_fpga_ops_write_init(struct fpga_manager *mgr,
> > > > > +                                     struct fpga_image_info *inf=
o,
> > > > > +                                     const char *buf, size_t
> > > > > +size) {
> > > > > +       struct zynqmp_fpga_priv *priv;
> > > > > +
> > > > > +       priv =3D mgr->priv;
> > > > > +       priv->flags =3D info->flags;
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
> > > > > +                                const char *buf, size_t size) {
> > > > > +       struct zynqmp_fpga_priv *priv;
> > > > > +       char *kbuf;
> > > > > +       dma_addr_t dma_addr;
> > > > > +       int ret;
> > > > > +       const struct zynqmp_eemi_ops *eemi_ops =3D
> > > > > +zynqmp_pm_get_eemi_ops();
> > > >
> > > > Reverse xmas-tree please, i.e. long lines first.
> > > >
> > > > > +
> > > > > +       if (!eemi_ops || !eemi_ops->fpga_load)
> > > > > +               return -ENXIO;
> > > > > +
> > > > > +       priv =3D mgr->priv;
> > > > > +
> > > > > +       kbuf =3D dma_alloc_coherent(priv->dev, size, &dma_addr,
> > > GFP_KERNEL);
> > > > > +       if (!kbuf)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       memcpy(kbuf, buf, size);
> > > > > +
> > > > > +       wmb(); /* ensure all writes are done before initiate FW
> > > > > + call */
> > > > > +
> > > > > +       ret =3D eemi_ops->fpga_load(dma_addr, size, priv->flags);
> > >
> > > Don't you have to do anything with the flags? Is it really just a
> > > pass-through of FPGA manager flags to eemi calls?
> > >
> > > Don't you want to make partial bitstreams e.g. use a flags value
> > > that you export in your firmware header (xlnx-zynqmp.h) and set
> > > those based on what flags get passed in, i.e. explicitely translate F=
PGA
> Manager flags to your firmware flags?
> >
> > At this point of time the firmware use Flag 0 for full Bitstream and 1 =
for partial
> bitstream loading.
> > So I have not doing any explicit translate FPGA Manager flags inside th=
e
> driver.
> > Will document the flags info in xlnx-zynqmp.h
>=20
> I think you should explicitely translate them, the fact that they happen =
to line
> up in the current implementation is somewhat of coincidence, and in futur=
e
> might break (since it's not really easy to to spot the dependency when
> refactoring).
>=20
> Why don't you do something like:
>=20
> #include <linux/firmware/xilinx-zynqmp.h>
>=20
> [...]
>=20
> eemi_flags =3D 0;
>=20
> if (flags & FPGA_MGR_PARTIAL_RECONFIG)
> 	eemi_flags |=3D XILINX_ZYNQMP_PM_FPGA_PARTIAL;
>=20
> eemi_ops->fpga_load(...., eemi_flags);
>=20

Yes, I agree with you and it's sound good. Will fix in the next version.

Regards,
Navakishore.
