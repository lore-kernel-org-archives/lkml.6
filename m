Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E460C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278E821473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AXAC1zcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278E821473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeHTPgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:36:41 -0400
Received: from mail-eopbgr690070.outbound.protection.outlook.com ([40.107.69.70]:61376
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbeHTPgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTGZKNDoEZMTXVHMI9jxRS9rVpazF8nCI1h+o7L4mWc=;
 b=AXAC1zcOJbcjlqXj6pr4KwQ/gpzlhu0g2m0FTsVmAFIu+fjGvydxWLOWQ3l0fhXY995Z/C//+xibaJ9avcysIQURr773zvbVEAR62Nu8IITc6E2VX83BDRxUEVf9ioYEsBJwXQDIlGGY3pxopMYp+RPUOVTWKB8s9DuYXW+B+jQ=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2496.namprd02.prod.outlook.com (10.168.205.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.21; Mon, 20 Aug 2018 12:21:13 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::71ad:f7bc:17b4:4d68]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::71ad:f7bc:17b4:4d68%2]) with mapi id 15.20.1059.023; Mon, 20 Aug 2018
 12:21:12 +0000
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
Thread-Index: AQHUNiz7bKojXyawJ0eL/lrCUsemM6TEO52AgAC1gGCAA2kvgIAAHrEAgAAYNwCAAALJ0A==
Date:   Mon, 20 Aug 2018 12:21:12 +0000
Message-ID: <MWHPR02MB2623C6F80AC8DB81A9791EA4AF320@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1534511964-20342-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20180817195903.49963b25@bbrezillon>
        <MWHPR02MB2623D48B5DBAFCE2B5D03747AF3C0@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20180820105355.11bd50a8@bbrezillon>
        <MWHPR02MB2623218B2BD3D102B07AC862AF320@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20180820141026.0e7208ae@bbrezillon>
In-Reply-To: <20180820141026.0e7208ae@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB2496;6:BmPYiyk8PLG8tMWpNsVREOlYaLwUM5QN+QaaxZyJiHCNkDpO5KYxjP2gpCnaDXuo2HzgWemADTcu65jAK3v8G2FkfNIqHvwxmwu3ab8NQxyaUQbYD4Vg0GCeKtpQmYAb3lC9J8j0Sg8yls3wWdk7Sj+dCM7BL18S51dI3icyOcNe8E0+hMQwr9eN9OdLItw7BWUWAkcFv40DWEA1+qWCNpCC/1ds2SC/zHdkpkZtgaCs0RbkvWTzSKMHMKfyg8UCM0HVq5Ui9S53z9YaZ3MtjlltJY6knMn4Ylphz4HjTs9UcI/2V3/ma0PMwnqIa9dUEPeCIiz0hohEHRsucUkbCGbhXkuSm2zQ/FlM2lAHKQOmuRGtatH1H1SZVzPv7fIeoERbhl1HYz+NlxI1SRCcuim94uGxY3R8012+aWlDBmJI9090+UjirCS4ypYuyeY0LXEORnX/vRIisMYtT7sjtA==;5:NZXws8LiLCO81g/HZ8ong4o8ZOPD4DixELtj+QKy2h5ro9/SYGtnqE1uSRDRIu2Tj7Ph+SQnzEXalXBCmz0OQWmGINFGSTGZ8mzpzDil7PfFOpH5WnqA2MOIH7/dhnw47xJ0hHNErPFFNAoxuizIBUM+Mc/D5xeuMpYi9fBxA4k=;7:AzbjAMjDY8NSWF+MU6WK+xd5hYJAbRkLScj4zTETqNUVL8IlojFC8m/LVb3jjaJzl8ph+8m1w8tu8oISzAssLlxD5/x+VrGkIqa6+7EDpcnLcVNvuyABMSACAQ/ert4gUgWnSWbBGnFaBhenXuIslhgu37tlZ/3oR8KCy4UIvI+YMgGz1MvEgtxn3+8NAtLIMBDw6304+uwaHuHKVmQ/SrRlFds3gUHRv9tFNrj45jJI59aKZL+2cymBTP/D12KZ
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(366004)(136003)(346002)(199004)(189003)(13464003)(7696005)(55016002)(76176011)(9686003)(99286004)(229853002)(2906002)(6436002)(2900100001)(26005)(33656002)(3846002)(6116002)(186003)(53546011)(6506007)(66066001)(102836004)(8936002)(14454004)(6916009)(5660300001)(478600001)(68736007)(305945005)(316002)(8676002)(81156014)(81166006)(7736002)(53936002)(6246003)(39060400002)(97736004)(25786009)(4326008)(93886005)(54906003)(5250100002)(106356001)(105586002)(7416002)(74316002)(217873002)(86362001)(446003)(11346002)(14444005)(256004)(486006)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2496;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 327ec5e1-1f01-4489-617f-08d606976b38
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2496;
x-ms-traffictypediagnostic: MWHPR02MB2496:
x-microsoft-antispam-prvs: <MWHPR02MB249639D190E27AA0211FC5CEAF320@MWHPR02MB2496.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(192813158149592)(34377916053724)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:MWHPR02MB2496;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2496;
x-forefront-prvs: 0770F75EA9
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kUqEhTJ+il3uSt+s/FFbi1PBHoDZ/6MTgUdfD2wepzb8qkhIl9RDUhw1D+Lo2e5Jw+lfMo18EoS43Pg5lykIzoPyw+dLUBW4kluCFszvCCecJszgpBGkDbEV7oZH41jAFKyKDu6r/eLbrIKb9vrlyJz+KILBsUYfBfMR2oLDOGcMFvTinWROw+9cqmAZ+jBo4CGJuJ1jZcCDb7HsHTXm3n/wJdy8r1SLuh6SB8+nKnPxny71jgoUOKsca+IzaTohlULiQOWKu+7+DelVrj7s5Zof/mMK6WEgu//suUNtL+ZkDx/zeqmj0aGSDeDEIRevxIhQsFpXGjXJ95SOa7BC5ObWUqh7OP2VyfTE6Msby04=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327ec5e1-1f01-4489-617f-08d606976b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2018 12:21:12.7338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2496
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, August 20, 2018 5:40 PM
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
> On Mon, 20 Aug 2018 10:49:38 +0000
> Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:
>=20
> >
> > Thanks for your suggestion and are you saying something like Marvell pa=
rser patterns for
> nfcv1 as below?
> >
> > static const struct nand_op_parser marvell_nfcv1_op_parser =3D NAND_OP_=
PARSER(
> > 	/* Naked commands not supported, use a function for each pattern */
> > 	NAND_OP_PARSER_PATTERN(
> > 		marvell_nfc_read_id_type_exec,
> > 		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > 		NAND_OP_PARSER_PAT_ADDR_ELEM(false,
> MAX_ADDRESS_CYC_NFCV1),
> > 		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 8)),
> > 	NAND_OP_PARSER_PATTERN(
> > 		marvell_nfc_erase_cmd_type_exec,
> > 		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > 		NAND_OP_PARSER_PAT_ADDR_ELEM(false,
> MAX_ADDRESS_CYC_NFCV1),
> > 		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > 		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
> > 	);
> > That means, a separate hook for each pattern, is that you are suggestin=
g?
>=20
> Yes.

Ok, I will update the driver and will send next version.

Thanks,
Naga Sureshkumar Relli.
