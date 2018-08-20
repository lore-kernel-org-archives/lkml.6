Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46819C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA39E20BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hE+ebYUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA39E20BF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbeHTOEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:04:54 -0400
Received: from mail-eopbgr720065.outbound.protection.outlook.com ([40.107.72.65]:59760
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbeHTOEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yHRZO6phRVilIJEAdXZ6D5nZVlNKBUfFSsGQxk+O6A=;
 b=hE+ebYUNHMIkS4lKMZUkHCMscEO2NXIbC8a1kbDURruzOseEXrQzP/mhZTgTIEMh0cjP9F3YSyLWgOIwDrfzpTmyENAqLsvLm6n4/w2hLIQFxvCn0ZGAAmMl8GGhJfTphRsxylag177tPMueLnpSmikC31ZfEqRLztnghmPVTqs=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB3198.namprd02.prod.outlook.com (10.164.133.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.21; Mon, 20 Aug 2018 10:49:39 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::71ad:f7bc:17b4:4d68]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::71ad:f7bc:17b4:4d68%2]) with mapi id 15.20.1059.023; Mon, 20 Aug 2018
 10:49:38 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "richard@nod.at" <richard@nod.at>,
        "absahu@codeaurora.org" <absahu@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "peterpandong@micron.com" <peterpandong@micron.com>
Subject: RE: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Topic: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Index: AQHUNiz7bKojXyawJ0eL/lrCUsemM6TEO52AgAC1gGCAA2kvgIAAHrEA
Date:   Mon, 20 Aug 2018 10:49:38 +0000
Message-ID: <MWHPR02MB2623218B2BD3D102B07AC862AF320@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1534511964-20342-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20180817195903.49963b25@bbrezillon>
        <MWHPR02MB2623D48B5DBAFCE2B5D03747AF3C0@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20180820105355.11bd50a8@bbrezillon>
In-Reply-To: <20180820105355.11bd50a8@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB3198;6:tvkVWtS1/7uIAYLcGBVn1XmE8KTaQj9sVWEWdROYw9tPpIe7R+mUydKHlEk/bPXdqL1fpdTjWRARUbAX++Ow3xVIvmv0Nn9nfC32qnPmr41jGFcGdQYMLVBkzEQ6550w5a67r/ZabocYYG/mMTyR9qqZDpoW4B8K5pGypUt5Q8ipxzsjuvBB5sTNLU/pFS6tgqzvYKCek0XSW7f7dOFj3a0q/f36+oh+3thbbbyM4bP0TE5CbUizE2y7H5IukYDXm8R0kEP9y0SAV4ZPZcCCr4RwJfnDSAXG4T8XnLWCUC/SJbHcZ8n3MX0Mb6wxTe65frW8hvNrgoX1+UVSHQxPbBYh2moYzB1SfWcCZzQlxR2Ud2zpFYRhIZ5hj7JLd/qmQBJV1Ow/grlp2QiD39ySYMeW3745e0fVyRXX9FLw+kEQkz0Oem1sk53QpiT37ZU6l1g9xDfQYYNdVVB2ZZ2qaQ==;5:Gg93Zr/0jMxDNGBpJSE73u0jjyqWGri7weOmsdrnkpdHeMjOykky+nt/5CP3Nm0Bt9sAuDd/UMveF3m5SNMFK04pqZtVLbwb8gFWwRKa0/4yZ6jH1quKg7IUEtYR5Mh+nrdFtGK41JnWsLcwAEoZdmXFJfDDcex/w8d44dODG3o=;7:S5KUrQD1VkLGlpZvPnt6Np1kWvnELw6gxPvEZ/telKQSLVPzyM9+4dhsUU8QCbO+E/gGALNpCaHSdcaGAZQsN4qTyJnCdjliPZVWvRhziNfpKWC2Lfzo1qndFtzyfJa4OoJHOgGTednHIsm3CudXhNQX9OBvl3xTy1jup75sWBAiLbvD4L+jIKm+SKi9hg4iHaW/m1FEB78k9+AVCLCPxNqovmClVZuZ0AHsolJhi+YvgQ7TVyDbXQChDa/71zEu
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(39860400002)(376002)(13464003)(51914003)(199004)(189003)(7416002)(6306002)(9686003)(105586002)(5250100002)(53936002)(106356001)(6436002)(11346002)(68736007)(256004)(14444005)(6916009)(966005)(99286004)(6246003)(478600001)(39060400002)(446003)(476003)(217873002)(25786009)(14454004)(55016002)(2906002)(4326008)(7736002)(33656002)(81156014)(81166006)(93886005)(26005)(186003)(74316002)(8936002)(3846002)(6116002)(54906003)(305945005)(5660300001)(53546011)(76176011)(7696005)(486006)(229853002)(86362001)(575784001)(97736004)(2900100001)(6506007)(102836004)(8676002)(316002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3198;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 945c3c71-f2cc-4298-32a1-08d6068aa092
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB3198;
x-ms-traffictypediagnostic: MWHPR02MB3198:
x-microsoft-antispam-prvs: <MWHPR02MB319838B508DCCE4FB5D0B58BAF320@MWHPR02MB3198.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(192813158149592)(34377916053724)(7411616537696)(189271028609987);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:MWHPR02MB3198;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB3198;
x-forefront-prvs: 0770F75EA9
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 11A25hboJA5mXpcPpbFxjrVSvVaY4AjcQwMVlSe82b73Q0XQWETcphKLRcng9hvVYixhHtM+ko6RI8NNnC9y0Djxms1F+rTP7m6zkScdIialfuEa3mMfzLLUtmC/sBe1pUtW2nEL1A7HLiw1O6R6Ov8EXTPHj6j32+noI2AXJnEvhvdZ3B+4HmQYYCvHx9VFI5WAD3qCqC5HFsUQFNbiphrquWESGSnVJo6xQhHobtzxo9QRN0ExTg5B9lofZhx1xnwapx151KJJ5Q8lRYLfCsBpVKOQQ331EeZfQukyRDnICwACE3/1WUrevb0VFHCJdd4AnyWmpFs6i+59cZWHeDKC8NQD7zR/WmVvKQOn9wg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945c3c71-f2cc-4298-32a1-08d6068aa092
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 10:49:38.7922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, August 20, 2018 2:24 PM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: richard@nod.at; absahu@codeaurora.org; linux-kernel@vger.kernel.org;
> marek.vasut@gmail.com; kyungmin.park@samsung.com; frieder.schrempf@exceet=
.de; linux-
> mtd@lists.infradead.org; miquel.raynal@bootlin.com; nagasureshkumarrelli@=
gmail.com;
> Michal Simek <michals@xilinx.com>; computersforpeace@gmail.com; dwmw2@inf=
radead.org;
> peterpandong@micron.com
> Subject: Re: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for =
Arasan
> NAND Flash Controller
>=20
> On Sat, 18 Aug 2018 05:49:32 +0000
> Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:
>=20
> > Hi Boris,
> >
> > Thanks for the review.
> >
> > > -----Original Message-----
> > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > Sent: Friday, August 17, 2018 11:29 PM
> > > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > > Cc: miquel.raynal@bootlin.com; richard@nod.at; dwmw2@infradead.org;
> > > computersforpeace@gmail.com; marek.vasut@gmail.com;
> > > kyungmin.park@samsung.com; absahu@codeaurora.org;
> > > peterpandong@micron.com; frieder.schrempf@exceet.de; linux-
> > > mtd@lists.infradead.org; linux-kernel@vger.kernel.org; Michal Simek
> > > <michals@xilinx.com>; nagasureshkumarrelli@gmail.com
> > > Subject: Re: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support
> > > for Arasan NAND Flash Controller
> > >
> > > Hi Naga,
> > >
> > > On Fri, 17 Aug 2018 18:49:24 +0530
> > > Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
> > >
> > > > +static int anfc_exec_op_cmd(struct nand_chip *chip,
> > > > +				   const struct nand_subop *subop) {
> > > > +	const struct nand_op_instr *instr;
> > > > +	struct anfc_op nfc_op =3D {};
> > > > +	struct anfc_nand_chip *achip =3D to_anfc_nand(chip);
> > > > +	struct anfc_nand_controller *nfc =3D to_anfc(chip->controller);
> > > > +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> > > > +	u32 addrcycles;
> > > > +	unsigned int op_id, len =3D 0;
> > > > +	bool reading;
> > > > +
> > > > +	anfc_parse_instructions(chip, subop, &nfc_op);
> > > > +	instr =3D nfc_op.data_instr;
> > > > +	op_id =3D nfc_op.data_instr_idx;
> > > > +	if (nfc_op.data_instr)
> > > > +		len =3D nand_subop_get_data_len(subop, op_id);
> > > > +
> > > > +	/*
> > > > +	 * The switch case is to prepare a command and to set page/column
> > > > +	 * address. Arasan NAND controller has program register(Off: 0x10=
)),
> > > > +	 * which needs to be set for every command.
> > > > +	 * Ex: When NAND_CMD_RESET is issued, then we need to set reset b=
it
> > > > +	 * in program_register. etc..
> > > > +	 */
> > > > +	switch (nfc_op.cmnds[0]) {
> > > > +	case NAND_CMD_SEQIN:
> > > > +		addrcycles =3D achip->raddr_cycles + achip->caddr_cycles;
> > > > +
> > > > +		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], NAND_CMD_PAGEPROG,
> 1,
> > > > +				 mtd->writesize, addrcycles);
> > > > +		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> > > > +		break;
> > > > +	case NAND_CMD_READOOB:
> > > > +		nfc_op.col +=3D mtd->writesize;
> > > > +	case NAND_CMD_READ0:
> > > > +	case NAND_CMD_READ1:
> > > > +		addrcycles =3D achip->raddr_cycles + achip->caddr_cycles;
> > > > +		anfc_prepare_cmd(nfc, NAND_CMD_READ0,
> NAND_CMD_READSTART,
> > > 1,
> > > > +				 mtd->writesize, addrcycles);
> > > > +		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> > > > +		if (!nfc_op.data_instr)
> > > > +			return 0;
> > > > +
> > > > +		anfc_read_data_op(mtd, instr->ctx.data.buf.in, len);
> > > > +		break;
> > > > +	case NAND_CMD_RNDOUT:
> > > > +		anfc_prepare_cmd(nfc, nfc_op.cmnds[0],
> NAND_CMD_RNDOUTSTART, 1,
> > > > +				 mtd->writesize, 2);
> > > > +		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> > > > +		nfc->prog =3D PROG_PGRD;
> > > > +		break;
> > > > +	case NAND_CMD_PARAM:
> > > > +		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], 0, 0, 0, 1);
> > > > +		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> > > > +		nfc->prog =3D PROG_RDPARAM;
> > > > +		break;
> > > > +	case NAND_CMD_READID:
> > > > +		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], 0, 0, 0, 1);
> > > > +		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> > > > +		nfc->prog =3D PROG_RDID;
> > > > +		break;
> > > > +	case NAND_CMD_GET_FEATURES:
> > > > +		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], 0, 0, 0, 1);
> > > > +		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> > > > +		nfc->prog =3D PROG_GET_FEATURE;
> > > > +		break;
> > > > +	case NAND_CMD_SET_FEATURES:
> > > > +		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], 0, 0, 0, 1);
> > > > +		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> > > > +		nfc->prog =3D PROG_SET_FEATURE;
> > > > +		break;
> > > > +	case NAND_CMD_ERASE1:
> > > > +		anfc_erase_function(chip, nfc_op);
> > > > +		break;
> > > > +	default:
> > > > +		break;
> > > > +	}
> > >
> > > Looks like you have one of these smart controllers where everything
> > > is hardcoded and new commands (like vendor specific commands) can't
> > > be supported, and we're back to abusing -
> > > >exec_op(), just like ->cmdfunc() was abused.
> > Actually hardcoding commands with ->exec_op() interface in the driver i=
s really looking
> weird.
> > I agree with that.
> > But as per the spec, for every command, we need to set respective bit
> > in PROG_REG and because Of this, we need to track the commands for each=
 exec_op() call.
> > >
> > > Don't you have a way to send raw CMD/ADDR/DATA cycles? If not, then
> > > we'll have to consider other options, because I don't want to go
> > > back to the situation we are in with -
> > > >cmdfunc().
> > As I said above, for each command we need to set a bit in PROG_REG, to =
initiate the
> operation.
> > The only conflicting thing is that, setting a respective bit in
> > PROG_REG based on the command Needs command tracking.
> > >
> > > Maybe I already asked, but is there a public spec for this IP?
> > I didn't find any public spec for this IP, but you can find the
> > register data base at below link
> > https://www.xilinx.com/html_docs/registers/ug1087/ug1087-zynq-ultrasca
> > le-registers.html
> > and click on NAND.
> > There we have Command Reg(Off: 0x0C) and Program Reg(Off: 0x10), which =
describes the
> usage.
> >
> > Also not in depth but at least something is documented in TRM
> > https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-u
> > ltrascale-trm.pdf we can find the programming model in chapter 25.
> > Please let me know if I missed anything.
>=20
> I had a closer look at those documents (which I remember reading a while =
back BTW), and the
> PROG bits are indeed not described in detail.
>=20
> Still, I think it's close to what we have on Marvell SoC, where those 'mo=
des' actually encode a
> specific sequence of timing that is used for well-known commands (like ER=
ASE, RESET,
> READID) but could be used the same way with other opcodes assuming the se=
quence is the
> same.
>=20
> So, you should use the pattern approach, but not like you do: you should =
have a dedicated hook
> for each pattern which would set PROG bit, and then a generic helper to f=
ill all other
> information (opcode, address cycles, ...).

Thanks for your suggestion and are you saying something like Marvell parser=
 patterns for nfcv1 as below?

static const struct nand_op_parser marvell_nfcv1_op_parser =3D NAND_OP_PARS=
ER(
	/* Naked commands not supported, use a function for each pattern */
	NAND_OP_PARSER_PATTERN(
		marvell_nfc_read_id_type_exec,
		NAND_OP_PARSER_PAT_CMD_ELEM(false),
		NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYC_NFCV1),
		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 8)),
	NAND_OP_PARSER_PATTERN(
		marvell_nfc_erase_cmd_type_exec,
		NAND_OP_PARSER_PAT_CMD_ELEM(false),
		NAND_OP_PARSER_PAT_ADDR_ELEM(false, MAX_ADDRESS_CYC_NFCV1),
		NAND_OP_PARSER_PAT_CMD_ELEM(false),
		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
	);
That means, a separate hook for each pattern, is that you are suggesting?

Thanks,
Naga Sureshkumar Relli.

