Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 77585C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7E2208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qeiis6Y6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B7E2208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965701AbeFONmR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:42:17 -0400
Received: from mail-ve1eur01on0051.outbound.protection.outlook.com ([104.47.1.51]:58496
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936144AbeFONmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRx7A7tPXCt7rjHmUY5gRA9qdSLSYZd1T/rmu9n/NW4=;
 b=Qeiis6Y6zEXWZllvYDHolHPNFcAYwx/RrUTHcVIkpxsdb9L8QPgv+0Ag5hD7h7drbsybXoD56KaTTZxa0ccJVN9YCckWX5oCalRN7AX4wsgIwCdamS0H3xPIODlRg2YtK98lWvbq0dzE1Jpi4XxJEnkMU5ifC38YBayoHzNOKN4=
Received: from DB6PR0402MB2838.eurprd04.prod.outlook.com (10.172.247.10) by
 DB6PR0402MB2805.eurprd04.prod.outlook.com (10.172.246.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Fri, 15 Jun 2018 13:42:12 +0000
Received: from DB6PR0402MB2838.eurprd04.prod.outlook.com
 ([fe80::49a5:1040:801d:2b97]) by DB6PR0402MB2838.eurprd04.prod.outlook.com
 ([fe80::49a5:1040:801d:2b97%2]) with mapi id 15.20.0863.016; Fri, 15 Jun 2018
 13:42:12 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "richard@nod.at" <richard@nod.at>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Wolfe <david.wolfe@nxp.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: RE: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Topic: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Index: AQHT+BiB2hXNm2lXyUydyOG4FdlBjqRWHnBAgABANgCABEvZ8IAAFd0AgAAehWCAAAtnAIAAAPSwgAFUQ+CAAAoIAIAAGBOggAT9CYCAAATqYA==
Date:   Fri, 15 Jun 2018 13:42:12 +0000
Message-ID: <DB6PR0402MB28382767652782E0CC6C14A0997C0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
        <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180608145130.09f979f9@bbrezillon>
        <DB6PR0402MB2838D514CF38AC5E6C004E8499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180611094616.5c8f82cf@bbrezillon>
        <DB6PR0402MB283825171DF93AD3C8590DD799780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180611121618.40f4b609@bbrezillon>
        <DB6PR0402MB28388D9DEB86629BB58DD5E499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <DB6PR0402MB2838563F1BA71A9A21ABBE01997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180612091328.67734adb@bbrezillon>
        <DB6PR0402MB28387FE79F2742C9BEBD4037997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <20180615145019.734f23a9@bbrezillon>
In-Reply-To: <20180615145019.734f23a9@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0402MB2805;7:8jgFo/HqSg4YJBYQ386fTggEeG6g9fMv2FqhHHeU6alXXhf0pGup1S3F8xhRIsyFYvS5QzIvdsdZiAppXv/B175DJCWo/NtVKsP58FNsQ38mFxLPd1uzCBv3ZYFjywjf2UmqqTbiItqLh15qls3YuORMiXNw3Pp4+SQA1ffVQgn37f1CSTxxfouMYIUHW09nU8HeEJEkGNurxs2Sfc5kmdZ5VmiEbR9s5pfiqTwRhsyCXOETFYS+xtYpfP2VlJnL
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 801e234d-77e5-429b-d60e-08d5d2c5cc9c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0402MB2805;
x-ms-traffictypediagnostic: DB6PR0402MB2805:
x-microsoft-antispam-prvs: <DB6PR0402MB280590E421197CBDA005FF37997C0@DB6PR0402MB2805.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0402MB2805;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0402MB2805;
x-forefront-prvs: 0704670F76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39380400002)(366004)(39860400002)(13464003)(189003)(199004)(81166006)(8676002)(81156014)(8936002)(102836004)(14454004)(9686003)(2900100001)(55236004)(74316002)(53546011)(6506007)(476003)(25786009)(53936002)(39060400002)(2906002)(305945005)(5250100002)(486006)(7736002)(7416002)(105586002)(106356001)(55016002)(186003)(6246003)(478600001)(6116002)(3846002)(229853002)(6916009)(6436002)(26005)(5660300001)(68736007)(3660700001)(33656002)(7696005)(86362001)(97736004)(4326008)(76176011)(11346002)(66066001)(93886005)(446003)(99286004)(54906003)(3280700002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2805;H:DB6PR0402MB2838.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eKO2098O8SCvhrH5eJYqtMqKpIBNBMcwqFk5FABNArsO8Ept6rdhLvRfdjIBvvYcz+waEdt/TDR3aiPOc4ThgGBx3Ph6hTRsM9JMjIw+9y2erNkemrF0DNcoJsiptxRcUamk4sL9xv5ULSvwBIuJgGUlw97vOwDjCckFDyk27rj3fqmW+jxe7i8oQ1DLPmFG
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801e234d-77e5-429b-d60e-08d5d2c5cc9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2018 13:42:12.4763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2805
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

I am still debugging the issue.
With some analysis, able to check that proper values are not being written =
for QUADSPI_SFA2AD/ QUADSPI_SFB1AD/ QUADSPI_SFB2AD register.

In current code, value of map_addr are being assigned to these register.
             map_addr =3D q->memmap_phy +
                        2 * q->devtype_data->ahb_buf_size;

     qspi_writel(q, map_addr, q->iobase + QUADSPI_SFA1AD + (i * 4));

But instead of "q->devtype_data->ahb_buf_size" it should be flash size.=20
For my case flash size is 0x4000000 and with this hard coded value I am abl=
e to perform Write and Erase operation.
One more change, I have to do is adding the flash_size when writing the bas=
e_address in SFAR register for case when "mem->spi->chip_select =3D=3D 1"
	qspi_writel(q, q->memmap_phy + 0x4000000, base + QUADSPI_SFAR);

Thus, there should be mechanism or the entry in structure where we can have=
 the information of the size of the connected slave device.

With both of above hardcoded changes, I am able to perform Write and Erase =
operation on my second flash device but still facing issue in Read operatio=
n, debugging in progress for that.

--
Regards
Yogesh Gaur


-----Original Message-----
From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]=20
Sent: Friday, June 15, 2018 6:20 PM
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc: richard@nod.at; Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>; Han Xu=
 <han.xu@nxp.com>; linux-kernel@vger.kernel.org; linux-spi@vger.kernel.org;=
 marek.vasut@gmail.com; Frieder Schrempf <frieder.schrempf@exceet.de>; broo=
nie@kernel.org; linux-mtd@lists.infradead.org; miquel.raynal@bootlin.com; F=
abio Estevam <fabio.estevam@nxp.com>; David Wolfe <david.wolfe@nxp.com>; co=
mputersforpeace@gmail.com; dwmw2@infradead.org
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI =
controller

On Tue, 12 Jun 2018 08:51:25 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

>=20
> I am working on lsxxx platform. With further debugging, I found that my e=
rase operation for second flash device is not working properly.
> Need to have debugging for this in Frieder Patch.

Did you find the problem? Could it be a wrong "reg =3D <>" definition in yo=
ur DT (Frieder changed the CS numbering scheme in the new driver)?
