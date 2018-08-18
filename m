Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB9CC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 05:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5DA20BF2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 05:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="gVUAy+78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5DA20BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbeHRI4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 04:56:12 -0400
Received: from mail-eopbgr730074.outbound.protection.outlook.com ([40.107.73.74]:19520
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbeHRI4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 04:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VV4sLqpXw3JsPbP3IqaPMB/EjOlt449Pd5+BvtNXQ/A=;
 b=gVUAy+781J6mc0VgVGfT8chSXMD53GeYWoRgjyezIrH+OqeFMEInzi0MJU+0Ehi4vOgG2QgVMD4094NuV9pv1nI8wcYxT3kIz7U/S3TZs0exmqYuKgYNmA+CeXv/n/mFAlIXbmgNFmeOa5WLxs/IQnFBk7mU0O9mqXKvXDPhcis=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB3375.namprd02.prod.outlook.com (10.164.187.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.19; Sat, 18 Aug 2018 05:49:33 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::71ad:f7bc:17b4:4d68]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::71ad:f7bc:17b4:4d68%2]) with mapi id 15.20.1038.026; Sat, 18 Aug 2018
 05:49:32 +0000
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
Thread-Index: AQHUNiz7bKojXyawJ0eL/lrCUsemM6TEO52AgAC1gGA=
Date:   Sat, 18 Aug 2018 05:49:32 +0000
Message-ID: <MWHPR02MB2623D48B5DBAFCE2B5D03747AF3C0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1534511964-20342-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20180817195903.49963b25@bbrezillon>
In-Reply-To: <20180817195903.49963b25@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB3375;6:/we/k2TiO73MKT9koBcptLc6lsB3p8gSJprk/Wg/PpC7iYXc8bdAYGI1GcDWCn/G9uPhAHkdipp5v9dXzykdb5TciUgD1BHX2w8Al7xoiD3WUevnlnsqP9FK3jAhWkALu78ddxwx5dNQhGzti6buAqSuVhQkaxyqUlm2IfcHP4WjEUutK4lT500mJkjPAfH0UIzOYHtBDYxWzs0E6nGMt0w9vej0O2r4eZEeLq9kMmt2FlD/tKjXPiHqd0iUKD5N4Pvce+kDsDhy63UT/eht8FR0QF3WBCE35vQLUeCG0nCvX6qW+n52pjqqZeMah2bY+hkAGbeZ3aFl+xME2R+ZfjLK67BAfMLOjkeoYROdmLXseKg1nYbY8rn5X+VAWlpgqK+5Xubcg3nqc6cUolCasIITjCWGoUF7O18qNs6qL5azB9XHBFpsYbWjCpI2wUR2jaXvtNHBPG77ygTr4yLTZw==;5:4gnRqtgEa1r0dF9R1VBv9rSL5n5qWCvfRbaFM1Gxo/8qe067yOKk0wsOP72/ZYyh6mRw0Phwb2aXwMi4TQRxpZHWeosbhM9H0EU5NW8RAcUZ/H8QjFlj+LmUezjdeN74GgXdWHDA2I1oSvkjTnBZqEyugw5dqaeh7o5xUpOMi00=;7:Zt73ynSa/zcmKAvtx66f7GHTE84sKvbuOj7nkKQuGQfjP4GhyGKIbpLEVow2M85qdkChxPk2LZQNvpho6d/Ac+CT76nzASBuBP/ZyzOvotmmrd0rUwyQzF7lJ2GGttRE8cKyfTsFQPCVi7I0zImN+rlRd94bSY9PLWj6A6pIjLAZGXu5NFCD8OHA4Ynxw3XZd2zRrZ8PRF3J+NVkI+vCQAPjD9N9+kgxrmEPOKG2KHYB19rtnMl6vwCvVcelILLs
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(366004)(51914003)(13464003)(199004)(189003)(33656002)(68736007)(2906002)(229853002)(14454004)(4326008)(39060400002)(25786009)(105586002)(6916009)(106356001)(54906003)(6246003)(74316002)(8936002)(2900100001)(305945005)(97736004)(7736002)(76176011)(3846002)(6116002)(6436002)(217873002)(8676002)(53936002)(66066001)(55016002)(5250100002)(9686003)(81156014)(81166006)(575784001)(256004)(7696005)(6306002)(966005)(26005)(86362001)(99286004)(186003)(53546011)(6506007)(316002)(5660300001)(102836004)(478600001)(7416002)(486006)(11346002)(446003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3375;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: f8426fe3-6d27-4f62-4737-08d604ce5ef2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB3375;
x-ms-traffictypediagnostic: MWHPR02MB3375:
x-microsoft-antispam-prvs: <MWHPR02MB33755296FD7C1C7ACA98B237AF3C0@MWHPR02MB3375.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(192813158149592)(34377916053724)(7411616537696)(189271028609987);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301072)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:MWHPR02MB3375;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB3375;
x-forefront-prvs: 076804FE30
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xOOgHhSIdIOAuv0ArBiZ7tvttSeLrMpB8wmkWHOkUT1utvw0AmJOyeDUVcyqMN6issBWqqxJ4IX3qZvxBUfMuxtVTwj+6GrNV6iq+rHsWjIFuX8s/OC4Vt8lZtV9TV8of6txsZyps2AVgSwnaT8eFk1KNMcEBpW5yk/rLy4cqijdvktVUCURRSB9yBVwYff6gNlSiJ6IWVPucJOHW9+puFYVJJOQ8fIq8afYNWbDSH1qpWbf1omsh4CHdu25sP0I4YyqKZiT09/p1KfxQTWSRyxCFAqW80oxIhH308jWs0Bxp0jxMgjLJgXdUGuiWuRyNKdNt7W0aXFM07EVGs4oqIhPQo3Tfcfl0qO+tRpwGQI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8426fe3-6d27-4f62-4737-08d604ce5ef2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2018 05:49:32.0182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3375
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Thanks for the review.

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Friday, August 17, 2018 11:29 PM
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
> > +static int anfc_exec_op_cmd(struct nand_chip *chip,
> > +				   const struct nand_subop *subop) {
> > +	const struct nand_op_instr *instr;
> > +	struct anfc_op nfc_op =3D {};
> > +	struct anfc_nand_chip *achip =3D to_anfc_nand(chip);
> > +	struct anfc_nand_controller *nfc =3D to_anfc(chip->controller);
> > +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> > +	u32 addrcycles;
> > +	unsigned int op_id, len =3D 0;
> > +	bool reading;
> > +
> > +	anfc_parse_instructions(chip, subop, &nfc_op);
> > +	instr =3D nfc_op.data_instr;
> > +	op_id =3D nfc_op.data_instr_idx;
> > +	if (nfc_op.data_instr)
> > +		len =3D nand_subop_get_data_len(subop, op_id);
> > +
> > +	/*
> > +	 * The switch case is to prepare a command and to set page/column
> > +	 * address. Arasan NAND controller has program register(Off: 0x10)),
> > +	 * which needs to be set for every command.
> > +	 * Ex: When NAND_CMD_RESET is issued, then we need to set reset bit
> > +	 * in program_register. etc..
> > +	 */
> > +	switch (nfc_op.cmnds[0]) {
> > +	case NAND_CMD_SEQIN:
> > +		addrcycles =3D achip->raddr_cycles + achip->caddr_cycles;
> > +
> > +		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], NAND_CMD_PAGEPROG, 1,
> > +				 mtd->writesize, addrcycles);
> > +		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> > +		break;
> > +	case NAND_CMD_READOOB:
> > +		nfc_op.col +=3D mtd->writesize;
> > +	case NAND_CMD_READ0:
> > +	case NAND_CMD_READ1:
> > +		addrcycles =3D achip->raddr_cycles + achip->caddr_cycles;
> > +		anfc_prepare_cmd(nfc, NAND_CMD_READ0, NAND_CMD_READSTART,
> 1,
> > +				 mtd->writesize, addrcycles);
> > +		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> > +		if (!nfc_op.data_instr)
> > +			return 0;
> > +
> > +		anfc_read_data_op(mtd, instr->ctx.data.buf.in, len);
> > +		break;
> > +	case NAND_CMD_RNDOUT:
> > +		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], NAND_CMD_RNDOUTSTART, 1,
> > +				 mtd->writesize, 2);
> > +		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> > +		nfc->prog =3D PROG_PGRD;
> > +		break;
> > +	case NAND_CMD_PARAM:
> > +		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], 0, 0, 0, 1);
> > +		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> > +		nfc->prog =3D PROG_RDPARAM;
> > +		break;
> > +	case NAND_CMD_READID:
> > +		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], 0, 0, 0, 1);
> > +		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> > +		nfc->prog =3D PROG_RDID;
> > +		break;
> > +	case NAND_CMD_GET_FEATURES:
> > +		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], 0, 0, 0, 1);
> > +		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> > +		nfc->prog =3D PROG_GET_FEATURE;
> > +		break;
> > +	case NAND_CMD_SET_FEATURES:
> > +		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], 0, 0, 0, 1);
> > +		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> > +		nfc->prog =3D PROG_SET_FEATURE;
> > +		break;
> > +	case NAND_CMD_ERASE1:
> > +		anfc_erase_function(chip, nfc_op);
> > +		break;
> > +	default:
> > +		break;
> > +	}
>=20
> Looks like you have one of these smart controllers where everything is ha=
rdcoded and new
> commands (like vendor specific commands) can't be supported, and we're ba=
ck to abusing -
> >exec_op(), just like ->cmdfunc() was abused.
Actually hardcoding commands with ->exec_op() interface in the driver is re=
ally looking weird.
I agree with that.
But as per the spec, for every command, we need to set respective bit in PR=
OG_REG and because
Of this, we need to track the commands for each exec_op() call.
>=20
> Don't you have a way to send raw CMD/ADDR/DATA cycles? If not, then we'll=
 have to
> consider other options, because I don't want to go back to the situation =
we are in with -
> >cmdfunc().
As I said above, for each command we need to set a bit in PROG_REG, to init=
iate the operation.
The only conflicting thing is that, setting a respective bit in PROG_REG ba=
sed on the command
Needs command tracking.=20
>=20
> Maybe I already asked, but is there a public spec for this IP?
I didn't find any public spec for this IP, but you can find the register da=
ta base at below link
https://www.xilinx.com/html_docs/registers/ug1087/ug1087-zynq-ultrascale-re=
gisters.html
and click on NAND.
There we have Command Reg(Off: 0x0C) and Program Reg(Off: 0x10), which desc=
ribes the usage.

Also not in depth but at least something is documented in TRM
https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultras=
cale-trm.pdf
we can find the programming model in chapter 25.
Please let me know if I missed anything.

Thanks,
Naga Sureshkumar Relli.
>=20
> Thanks,
>=20
> Boris
