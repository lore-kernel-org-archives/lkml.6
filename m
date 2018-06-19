Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E93C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639882083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hqFnsRqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639882083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937422AbeFSIbr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:31:47 -0400
Received: from mail-eopbgr10079.outbound.protection.outlook.com ([40.107.1.79]:18467
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S937236AbeFSIbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgdY1FVNSsX8UHpUxPkASKkZ94tfW1h1jAOPrmE5h40=;
 b=hqFnsRqvWU8vf2EuYImw+esiHJ/gIQW2Lmr649cnD2t0Hzj0ZqYBdSkPdJazoojj230cuSa0hhOu62EE2fkL60m8CK80atUrkF/mIgAfviH/z7GeYiD4sl1t23A185u4hI9pIB+QvoL3yTvYpQY7/osT9REBbApMKqwl3b87RZo=
Received: from DB6PR0402MB2838.eurprd04.prod.outlook.com (10.172.247.10) by
 DB6PR0402MB2837.eurprd04.prod.outlook.com (10.172.247.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Tue, 19 Jun 2018 08:31:25 +0000
Received: from DB6PR0402MB2838.eurprd04.prod.outlook.com
 ([fe80::49a5:1040:801d:2b97]) by DB6PR0402MB2838.eurprd04.prod.outlook.com
 ([fe80::49a5:1040:801d:2b97%2]) with mapi id 15.20.0863.016; Tue, 19 Jun 2018
 08:31:25 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        David Wolfe <david.wolfe@nxp.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "richard@nod.at" <richard@nod.at>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>
Subject: RE: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Topic: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Index: AQHT+BiB2hXNm2lXyUydyOG4FdlBjqRWHnBAgABANgCABEvZ8IAAFd0AgAAehWCAAAtnAIAAAPSwgAFUQ+CAAAoIAIAAGBOggAT9CYCAAATqYIAADVmAgASumwCAAGHGAIAAwy3AgAAJmwCAAAxekA==
Date:   Tue, 19 Jun 2018 08:31:25 +0000
Message-ID: <DB6PR0402MB2838FAF5CF0B0883EFAA3A9B99700@DB6PR0402MB2838.eurprd04.prod.outlook.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <DB6PR0402MB2838D514CF38AC5E6C004E8499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180611094616.5c8f82cf@bbrezillon>
        <DB6PR0402MB283825171DF93AD3C8590DD799780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180611121618.40f4b609@bbrezillon>
        <DB6PR0402MB28388D9DEB86629BB58DD5E499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <DB6PR0402MB2838563F1BA71A9A21ABBE01997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180612091328.67734adb@bbrezillon>
        <DB6PR0402MB28387FE79F2742C9BEBD4037997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180615145019.734f23a9@bbrezillon>
        <DB6PR0402MB28382767652782E0CC6C14A0997C0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180615155541.4f43e9bb@bbrezillon>
        <DB6PR0402MB2838C4F67D17337ADBC5D5F899710@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180618211536.0bf44f55@bbrezillon>
        <VI1PR0402MB2845767966A437E0D376219799700@VI1PR0402MB2845.eurprd04.prod.outlook.com>
 <20180619092832.3b6c8f22@bbrezillon>
In-Reply-To: <20180619092832.3b6c8f22@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0402MB2837;7:Fno3ASywvrRFkZrEPqlg4GYI0EynNfVaSNye8vl1Qn7Ac1+ZtAguh/HVf4N2dHqlondYXqrrkDozvy3lvi43KuG4PyJ874ydwqklUxzd8A4yiNuRCXoORaVMFzFrEvCPu//uRWQi+t4jD/Nk9Xand/jOSxKzJYq3DKinzlUjf/1L0e0lu7z4T/KqkfxiXspfqVMB1vvKpDdqduU7AVDD8+OWZRa/hmTny97T2uhs9xJXIGGIYO23UFRgtEpYaa+y
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1d75ef79-89b8-46b5-dbb9-08d5d5bf0bd4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0402MB2837;
x-ms-traffictypediagnostic: DB6PR0402MB2837:
x-microsoft-antispam-prvs: <DB6PR0402MB2837975192805ACE1BA1BDE399700@DB6PR0402MB2837.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0402MB2837;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0402MB2837;
x-forefront-prvs: 07083FF734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(376002)(396003)(346002)(366004)(189003)(199004)(13464003)(106356001)(5250100002)(39060400002)(55016002)(59450400001)(6436002)(2906002)(53936002)(105586002)(2501003)(316002)(86362001)(97736004)(25786009)(54906003)(6246003)(93886005)(229853002)(4326008)(81156014)(7696005)(110136005)(3280700002)(3660700001)(14454004)(81166006)(76176011)(74316002)(33656002)(68736007)(478600001)(7416002)(9686003)(486006)(55236004)(5660300001)(66066001)(7736002)(102836004)(8936002)(476003)(26005)(53546011)(6506007)(186003)(8676002)(3846002)(2900100001)(446003)(99286004)(11346002)(6116002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2837;H:DB6PR0402MB2838.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 82BvA70CnfGu2DmQWi3Jd6zaYE+6w0XLoDiphNLvPakH6ELGVCS0UIgSdpbB3rdVlloFdkq0KhypcME9Pgnq37RpxlaEY7RVrXb2nVANzxpPk9k7TlJPmt7gdBkrcocdrInvDKuhOyEaUgKt7XNA8rhqZScj/fjebjOU5Hy9Jh1h38dQf0+Xjk4gU2XLcgpoC5BNR3ue5D4LHY8ewzx8PH+OVEvFqpUrQ7EU0J89Bk5Gg1F2Svfj7d2LgOgfiTdIW9zEURWtaWUUK09D7S63ARwSIDHyXLccMJnaOw8SYeDrFGc+1+JIoqTOw3flob/+A1jMYCgq3mO+JhyEZn0qAg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d75ef79-89b8-46b5-dbb9-08d5d5bf0bd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2018 08:31:25.5668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Tuesday, June 19, 2018 12:59 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>;
> marek.vasut@gmail.com; Frieder Schrempf <frieder.schrempf@exceet.de>;
> broonie@kernel.org
> Cc: Fabio Estevam <fabio.estevam@nxp.com>; David Wolfe
> <david.wolfe@nxp.com>; dwmw2@infradead.org; richard@nod.at; Prabhakar
> Kushwaha <prabhakar.kushwaha@nxp.com>; Han Xu <han.xu@nxp.com>; linux-
> kernel@vger.kernel.org; linux-spi@vger.kernel.org; linux-
> mtd@lists.infradead.org; miquel.raynal@bootlin.com;
> computersforpeace@gmail.com
> Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSP=
I
> controller
>=20
> Hi Yogesh,
>=20
> Could you please use a mailer that is quoting things correctly. I have a =
hard time
> differentiating your replies from mine.

Sorry for this, have changed my mailer settings.

>=20
> On Tue, 19 Jun 2018 07:10:37 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Let us take below layout of memory address space map.
> > QuadSPI Controller can access range from 0x2000_0000 - 0x2FFF_FFFF i.e.=
 256
> MB address space reserved and it is having 4 slave devices connected.
> > These slave devices[of size 64MB, 64MB, 32MB and 64MB ] are connected
> > at below address 0x2000_0000, 0x2400_0000, 0x2A00_0000, 0x2C00_0000
> > i.e. there is gap of 32MB from 0x2800_0000 to 0x29FF_FFFF.
>=20
> Okay, I'm fine with pre-reserving 32MB per chip select.
>=20
> >
> > As per my understanding of the controller, flash XX top address, regist=
er should
> have below values:
> >   QUADSPI_SFA1AD - 0x0
> >   QUADSPI_SFA2AD - 0x400_0000
> >   QUADSPI_SFB1AD - 0xA00_0000
> >   QUADSPI_SFB2AD - 0xC00_0000
> > And Register QUADSPI_SFAR should point to the range for the flash in wh=
ich
> operation is happening.

My mistake values of these register would be for said case are:
QUADSPI_SFA1AD - 0x400_0000
QUADSPI_SFA2AD - 0x800_0000
QUADSPI_SFB1AD - 0xC00_0000
QUADSPI_SFB2AD - 0x1000_0000

i.e. as per controller each register is having the Top address for serial f=
lash connected at A1/A2/B1/B2 respectively.

>=20
> Wait, I thought it was supposed to be an absolute address, not one relati=
ve to
> the 0x20000000 offset.
>=20
> >
> > Please check Table10-32, page 1657, in [1] for more details on flash ad=
dress
> assignment.
>=20
> Yes, I still don't see where it says that having one of the range with a =
zero size is
> forbidden, or anything mentioning a required alignment.
>=20
> >
> > But say if I assign address to register QUADSPI_SFA2AD as "0 + 2 * -
> >ahb_buf_size" then this address value is not correct as per the value ra=
nge
> explained in above mentioned table.
>=20
> Why? If the SFA1AD is set to zero, that should not, right?
What this table says that for TOP_ADDR_MEMA1 defines the top address for fl=
ash connected at A1 and any address space between TOP_ADDR_MEMA1 and QSPI_A=
MBA_BASE will be routed to Serial Flash A1.
In my example case TOP_ADDR_MEMA1 is 0x400_0000
If assign value to SFAR register is "0 + 2 * ->ahb_buf_size", then this wou=
ld lie in access range of Serial Flash A1 and access happens to A1 flash wh=
ereas we want access to A2 flash.

For access of serial flash A2, any address space access between TOP_ADDR_ME=
MA2 and TOP_ADDR_MEMA1 would be routed to serial flash A2.
Thus to access A2 flash, SFAR would be in range from 0x400_0000 and 0x800_0=
000

--
Regards
Yogesh Gaur
