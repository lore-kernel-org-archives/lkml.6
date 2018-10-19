Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FC3ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE07421479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lDDDld77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE07421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeJSRuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:50:16 -0400
Received: from mail-bl2nam02on0057.outbound.protection.outlook.com ([104.47.38.57]:45568
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbeJSRuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjGAUZyE5LIT+sKfRJy76a2KPzpDskCCFMmwAlINGxE=;
 b=lDDDld77+Ycrbseyp147p1BTQE0DeeUVnwzx9ROCNieGSUP1a4NJ+GQUdBVW4qbWf73etsQAcnMTyHX0L8qePGrF8W/6wiLxWvgDozc0Jy7kVA2UztaFrqjNx1+FHGFT+KaCuX0VfbODrgDGB6P3yktfXY+MKooRkllDfm5XReQ=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2271.namprd02.prod.outlook.com (10.168.243.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Fri, 19 Oct 2018 09:44:53 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::60b4:7078:5a80:52c7]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::60b4:7078:5a80:52c7%5]) with mapi id 15.20.1228.035; Fri, 19 Oct 2018
 09:44:42 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>
Subject: RE: [LINUX PATCH v11 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Topic: [LINUX PATCH v11 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Thread-Index: AQHUVMpHbGhmDQn4EkyBZ4iql6zzXqUN988AgBh98oA=
Date:   Fri, 19 Oct 2018 09:44:41 +0000
Message-ID: <MWHPR02MB26235FB2ECB9073CFC38594DAFF90@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1537878031-22253-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1537878031-22253-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20181003213844.14d4095e@bbrezillon>
In-Reply-To: <20181003213844.14d4095e@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2271;6:KpwbJOE7+95s7uFVlBaQpI3keKkD+yqC4dC/lflU/1IrdWpHaYDsRsrtc2N22YfRau/7jQPceVtmMh38QqZ0g+2hS7qVxfQVRjf/YRoApV7BRwA4YhQ/H241/+ywpNu4kmrjvn5N3TSbgadZrK1DED++RtEp7E/upFgWRGHaCeMJHw5jQkTztsV7fDN6JJyjoWySWgiE3h8reEN6PFywNykYsCBLoJRgnY+GvTCrfUzng4/NKeNhS8lkrlZj0hm+wbOmOjiEmUSdsu8yYKjQdwI6/BRR/XNsw0O/edi9d05pXztsryKlNFY8K8xfX8qc08B9ZH0aTI4H2q8etkyp3zSSk/hWd4JnAunaGcwDkQ7EzTTvR5IaXdSHZNtV7rdEtvUIM3fx86mahRJIxKbJYY66Ey4pE63HjJDXf1dcXaJDXvC+EZfX7CwJWwlr+4um17ax3/9LAzl73mG1v+dP5w==;5:kHvR1uzjtkWMHxloEyPTly16elhhbN5Kz+azaaUSbC89uPN+fmJWfwmIeV1H4StgrwqtO/JBVfXn78ffYMsC12eCaBHtlRMJi9g6m14iDHHgfh5ZFUQdgTyQ7cCGd90C2vl11gighCWohYXCnR+V8vjoSycISLYzbx4qT4zQu1w=;7:vNdvD1YGYnU3Jflz9PgNLgdzS/qrtNH4MYQd/TrQuYmQT7f9H8goPd7RJLtKgK20bp2VKWg//BFJBabqqMofrAlThnRXNwyNiTd7JHjiATRgGlKUqO4EbdwYF8miuXPALMU6gVv+nzIX+3gvRGkMlth3DQmEIWbL+J/ZcNIWRG+RQlKxXzY+u+4+2xpIk+iDhmWYVAIoSHuBcRpWCO5XJoslvBg/oVFpPOwovyHDZjbKYfFgxZu6h/O2vLrqx6AC
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(366004)(376002)(189003)(199004)(13464003)(256004)(66066001)(106356001)(8936002)(39060400002)(2906002)(7736002)(105586002)(68736007)(9686003)(55016002)(6246003)(305945005)(102836004)(26005)(5250100002)(86362001)(14444005)(7696005)(53546011)(71190400001)(6506007)(217873002)(316002)(99286004)(76176011)(5660300001)(54906003)(2900100001)(476003)(81166006)(486006)(6436002)(8676002)(33656002)(74316002)(81156014)(229853002)(3846002)(97736004)(186003)(25786009)(446003)(4326008)(53936002)(478600001)(14454004)(6116002)(6916009)(71200400001)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2271;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: ea772a7d-731c-4894-8adb-08d635a77ebb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2271;
x-ms-traffictypediagnostic: MWHPR02MB2271:
x-microsoft-antispam-prvs: <MWHPR02MB2271223657FF8C2CED2F98C0AFF90@MWHPR02MB2271.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(258649278758335)(9452136761055)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR02MB2271;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2271;
x-forefront-prvs: 0830866D19
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ok2zPWa1HRO2xvHBmDfRpYX8heTjXLP2JxvqiiUlrME1LN20ekCED5UzOZkZPadQjxEevmTTxapGnC2sced5wHRI3gP5sCoZern12qvjSkctB/J74pTU0CQK3PoAhW2d4wSpCFjd3+bMqDoilkxMoEQaPLebEG+ajy96W+HTgq0IAuF8AKV5ZCblNjyBt8N/ojlD/WqSSU+dl3kgLIgrI1t8X6tsaRRDebLIwUT49VW8mg1XdxdRPa8zfv13+ULcsyTDvMo+e4PIWCtiMbbxhAZ7utWEdsa9L/vlOT1VOHLmbf7ThHL8neB5z9uXlNhDRnk5YuC+VQKzCG9axLcxXD8DpBZ2/p7ue0/gwdYTQUk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea772a7d-731c-4894-8adb-08d635a77ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2018 09:44:41.7471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Sorry for the late reply.
I am busy with some other work.

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Thursday, October 4, 2018 1:09 AM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: miquel.raynal@bootlin.com; richard@nod.at; dwmw2@infradead.org;
> computersforpeace@gmail.com; marek.vasut@gmail.com; Michal Simek
> <michals@xilinx.com>; linux-mtd@lists.infradead.org; linux-kernel@vger.ke=
rnel.org;
> nagasuresh12@gmail.com
> Subject: Re: [LINUX PATCH v11 3/3] mtd: rawnand: arasan: Add support for =
Arasan
> NAND Flash Controller
>=20
> Hi Naga,
>=20
> On Tue, 25 Sep 2018 17:50:31 +0530
> Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
>=20
> > +static int anfc_read_param_get_feature_sp_read_type_exec(struct nand_c=
hip *chip,
> > +							 const struct nand_subop
> > +							 *subop)
> > +{
> > +	const struct nand_op_instr *instr;
> > +	struct anfc_nand_controller *nfc =3D to_anfc(chip->controller);
> > +	unsigned int op_id, len;
> > +	struct anfc_op nfc_op =3D {};
> > +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> > +	struct anfc_nand_chip *achip =3D to_anfc_nand(chip);
> > +	u32 dma_mode, addrcycles, write_size;
> > +
> > +	anfc_parse_instructions(chip, subop, &nfc_op);
> > +	instr =3D nfc_op.data_instr;
> > +	op_id =3D nfc_op.data_instr_idx;
> > +
> > +	if (nfc_op.cmds[0] =3D=3D NAND_CMD_PARAM) {
> > +		nfc->prog =3D PROG_RDPARAM;
> > +		dma_mode =3D 0;
> > +		addrcycles =3D 1;
> > +		write_size =3D 0;
> > +	}
> > +	if (nfc_op.cmds[0] =3D=3D NAND_CMD_GET_FEATURES) {
> > +		nfc->prog =3D PROG_GET_FEATURE;
> > +		dma_mode =3D 0;
> > +		addrcycles =3D 1;
> > +		write_size =3D 0;
> > +	}
> > +	if (nfc_op.cmds[0] =3D=3D NAND_CMD_READ0) {
> > +		nfc->prog =3D PROG_PGRD;
> > +		addrcycles =3D achip->raddr_cycles + achip->caddr_cycles;
> > +		write_size =3D mtd->writesize;
> > +		dma_mode =3D 1;
> > +	}
> > +
>=20
> Sorry, but I still don't understand why nfc->prog is different. Did you t=
ry using
> PROG_PGRD for all these ops? I mean, the sequence is the same, and you ke=
ep passing the
> opcode and the number of address cycles to the engine using other reg fie=
lds.
Yes, I tried it now with PROG_PGRD and I don't see any issues.
I will update the same in next version of patch.
Thanks for your suggestion.

>=20
> Also, you're not using the addrcycles info provided by the the address in=
struction and instead
> deduce it based on the opcode, which is wrong.
> To make it clearer, I'd like to avoid those nfc_op.cmds[0] =3D=3D NAND_OP=
CODE tests,
> because it's exactly the kind of things we were trying to get rid off by =
introducing the -
> >exec_op() interface.
Ok. I understand, I will remove hardcoding the commands in the driver.
And I will change the driver to read addrcycles info from address instructi=
on.

Thanks,
Naga Sureshkumar Relli
>=20
> > +	anfc_prepare_cmd(nfc, nfc_op.cmds[0], 0, dma_mode, write_size,
> > +			 addrcycles);
> > +	anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> > +
> > +	if (!nfc_op.data_instr)
> > +		return 0;
> > +
> > +	len =3D nand_subop_get_data_len(subop, op_id);
> > +	anfc_rw_pio_op(mtd, nfc->buf, roundup(len, 4), 1, nfc->prog, 1, 0);
> > +	memcpy(instr->ctx.data.buf.in,  nfc->buf, len);
> > +
> > +	return 0;
> > +}
