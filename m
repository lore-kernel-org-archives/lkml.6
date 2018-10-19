Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88F7ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EB521476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Nzk+uFyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EB521476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeJSRxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:53:05 -0400
Received: from mail-eopbgr710079.outbound.protection.outlook.com ([40.107.71.79]:2337
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726867AbeJSRxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRKKsDeLkC0ZfvGGmRJ66hHudN6ZBuGK2qtgiSwPXLY=;
 b=Nzk+uFyOzDhGHA1eMkaHYT6fdynt9HsFxk4cbBOK0yjUJhXtzZCJ/Tszz5iJXXlxwhX7DpkAZp0aQT3JKefHQvIt0KtL0JPR2ie2SfNSG3DLPSnMXp7C8jgqbpv0AOaZLZMJessiAs6ppK6ZkT+wqz2Mghwd9QiNezJdS4Kts6Y=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2271.namprd02.prod.outlook.com (10.168.243.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Fri, 19 Oct 2018 09:47:02 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::60b4:7078:5a80:52c7]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::60b4:7078:5a80:52c7%5]) with mapi id 15.20.1228.035; Fri, 19 Oct 2018
 09:47:01 +0000
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
Thread-Index: AQHUVMpHbGhmDQn4EkyBZ4iql6zzXqUN+f6AgBh9K1A=
Date:   Fri, 19 Oct 2018 09:47:01 +0000
Message-ID: <MWHPR02MB262333376A88320A52F06331AFF90@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1537878031-22253-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1537878031-22253-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20181003214633.54e93c00@bbrezillon>
In-Reply-To: <20181003214633.54e93c00@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2271;6:qx+MIw5h6r81c1MKao/2QOtCLcVxC9BHyXE+VAwi/k0jEMbIwiU1KNNEJ72liERZxmIc56Nu8o91PoU0lRL6cKcMk+96u0fQQg4Ro+yzGfXcGt4A2uSdK++IJctlQT1+S2wtRJCV/p1KbmtQWlIDic799e6RNi/WejCiKGYWiQ7RH6j4yZzhnc9KZMzEA7UOUKzUW54pcIMVZKK+yi23f6MfKbjAlQGufNKcDBvrCXbqtNYPVIdH2+dIfzmj8TKdK0J3SdP+MqKSjA4oVuu6vEOqOefLiUjonm4Y0TljlptCOFA8N9EqIhIcntArCZFsg+ybXiqN+iNe9Z6WDqxdySf335vo/rK5mfBc1vLfJsDPi3d0gapoGTcYA7AjDBgWAHrJwuQfs3CJAXL0y24WfsPW3AM0DY7aaOOzB0VsFW2u/UfIBfccmJ1h95y+BhlXR7zB9lJe/u1CbRtx16z06A==;5:oNKtk2ARzajYT525Sz3iH10SYokUquEc3SaHvASPGNzB8fYpdiYR7g9pglHOpXW/fICJNgIeZLrlenP19Z5SGVq4fyb8yO6drTdDZUNXQ5SltMWBSvqSV41B5gdV/+DgJzGhEdOfUDybSzqprqay7Q/7kEBGey21+1xo7WoX18M=;7:eGeF5uaubZ14ar9huyI/8ENymFvBsM4LJKDj/C+1fzkuuGfSOLOZvIWkvlIkynlnPiEb0pdtRZFgPWbnf79qnvnVdHojzAV2PSctg4NGWBKynLWfZl2pBtuLaCVw/p5SXFmX1qKmDR0XaFMqPyA23lHUCwIvy+zA6oDoPSWapaJWs1y71FD8rf7RNMRw3o3ea5wujF/tmB6rwY+aBAp24KHX37ke37pMpxllqod6+ULZukAkFWPxyqpChr2ChWRY
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(979002)(39860400002)(396003)(346002)(136003)(366004)(376002)(189003)(199004)(13464003)(256004)(66066001)(106356001)(8936002)(39060400002)(2906002)(7736002)(105586002)(68736007)(9686003)(55016002)(6246003)(305945005)(102836004)(26005)(5250100002)(86362001)(7696005)(53546011)(71190400001)(6506007)(217873002)(316002)(99286004)(76176011)(5660300001)(54906003)(2900100001)(476003)(81166006)(486006)(6436002)(8676002)(33656002)(74316002)(81156014)(229853002)(3846002)(97736004)(186003)(25786009)(446003)(4326008)(53936002)(478600001)(14454004)(6116002)(6916009)(71200400001)(11346002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2271;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: ef59e32e-0a75-4a4b-eaf8-08d635a7d1ed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2271;
x-ms-traffictypediagnostic: MWHPR02MB2271:
x-microsoft-antispam-prvs: <MWHPR02MB22710B872E9FB1DA19DF8652AFF90@MWHPR02MB2271.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(258649278758335)(9452136761055)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR02MB2271;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2271;
x-forefront-prvs: 0830866D19
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: r47HHUg5K0o7SdIvPOEHDEjy4Q86kqlOTe6MSmBu89/xvX1dAWQqegYR2rVevi9BhX4Eof9rNmKAVe4YzziVItMQj6tJIhT3AtwyvmJYu2TX3K5jgsShf5KukV08esKxuR/4XtZwKfPHW8zueWW4vMCJJrekfFKIxi2xHM5KE8chrlyQvoiogiU3sAssTnZRUqXLkbwSkeRonsuXSBJ3V7WxsEBKEyzGrOGQunfh8CZ8qBLBPKmBb7wDjCeEP3H+s3v9CW7hzvllmF32DiD3F63MZrwt/5He9enNUx96UR0SXiURYN80rMYIXKd5XIju5w3uTc+rdPbjqK2OEPRDHnAfLvIUM3IeF/VIL2x83BI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef59e32e-0a75-4a4b-eaf8-08d635a7d1ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2018 09:47:01.5613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Thursday, October 4, 2018 1:17 AM
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
> On Tue, 25 Sep 2018 17:50:31 +0530
> Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
>=20
> > +static int anfc_zero_len_page_write_type_exec(struct nand_chip *chip,
> > +					      const struct nand_subop *subop) {
> > +	const struct nand_op_instr *instr;
> > +	struct anfc_nand_chip *achip =3D to_anfc_nand(chip);
> > +	struct anfc_nand_controller *nfc =3D to_anfc(chip->controller);
> > +	unsigned int op_id;
> > +	struct anfc_op nfc_op =3D {};
> > +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> > +	u32 addrcycles;
> > +
> > +	anfc_parse_instructions(chip, subop, &nfc_op);
> > +	nfc->prog =3D PROG_PGRD;
> > +	instr =3D nfc_op.data_instr;
> > +	op_id =3D nfc_op.data_instr_idx;
> > +
> > +	addrcycles =3D achip->raddr_cycles + achip->caddr_cycles;
> > +
> > +	anfc_prepare_cmd(nfc, nfc_op.cmds[0], NAND_CMD_PAGEPROG, 1,
>=20
> Why are the second opcode and the number of address cycles hardcoded.
> That's simply not future-proof, and I don't want that. Also, I don't unde=
rstand why you do
> that, you have all the information you need in subop and you keep guessin=
g some parameters.
Ok, I will remove all these hard coding commands from the driver, instead I=
 will use nfc_op.cmds[0], nfc_op.cmds[1].

Thanks,
Naga Sureshkumar Relli
>=20
> > +			 mtd->writesize, addrcycles);
> > +	anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> > +
> > +	return 0;
> > +}
