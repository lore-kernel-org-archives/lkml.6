Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4381C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513B820671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hjXea2yO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513B820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeJWRTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:19:11 -0400
Received: from mail-eopbgr40061.outbound.protection.outlook.com ([40.107.4.61]:11392
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727730AbeJWRTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91bwexxDUR8qKzx2CsMo5kEtCb4exsM608r4fGxG2Gk=;
 b=hjXea2yOz8Lyfm7K1jkL//Z6s3Lx+EPOPUcAWCWNVm67XKE9tBA2wKI7G3uwvzgPGaQ0tMu4EJCkLDbRZzZf2ypKBHP7eFUAYgO9fAehmu/r7L3KXl+nnmtvRaYkyNcaxAfGZsh6pN3nDsRW/xZ/O3icbTeYUOG2+RV3FAcuQjc=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4367.eurprd04.prod.outlook.com (52.134.123.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 08:56:38 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Tue, 23 Oct 2018
 08:56:38 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH RESEND v4 0/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Topic: [PATCH RESEND v4 0/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUaq5PpI07d4lVwE6+QvWA3hbKoQ==
Date:   Tue, 23 Oct 2018 08:56:38 +0000
Message-ID: <1540284888-32307-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR0601CA0008.apcprd06.prod.outlook.com (2603:1096:3::18)
 To VI1PR04MB1038.eurprd04.prod.outlook.com (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4367;6:3pSQdknTSccUAngaPWOlGR8ojWsQeSDsdffdW9k+sU1d2u6il7cU8Oj7TDuH7nOxekezvbsrK7LULmV/tzXW/DD0tT3Q2iAxV78DwvpqZOXh5v2WnJNwiR6X2tf9t36VDd6iWLEUaMubDFGduWOLguqXb9ZoaegZ8eLg9LOc7Kl1QUC3ZyTjm7ys14KyDdZ9sjYLWWe3c2+f/InueKM4HjWnEjSUunERyQwrkWKbTEZgtzfoXacK1uUli+PivTIgh+gynzTgldmXJUwjVsPv1rWb5mpYkTqnRUuSFr5nC0+5KFC9omOWw7qr7gt+YIwcD9aCdMfCoB6G8xp25griFTtDamwPBhgFQqaLuN3I7ofTBFwSHIw7edlIEEFCx/sDXyDv5fYwXUxqlI5diIlMBZbCBA5xidKNot3vCarOQ3kPRBc/9EvKHH3UEiqLPV8zkGwvQ8zZbEZQx+hbI1ktsQ==;5:L7LxbZUGl0y2UeoMVFzPn1hKZxu4zFAp5egQhtw7jYohCFPUwPAEoQ+bCsHSpH15EBBqdSxxZBVU/ruO9iacTbar2LoElQGRRAkRjyVnmggK9mEbfe7RS8GO2shV96QCqpE+1H+wMvHG/0pNQSSMYzDPNXEKDfzFDugIKf3aYEI=;7:rV/+gxg3H8a5LusNxfKDZgDcEuGGBG5rfMRpkeoU/rPV6fRa6nMKy/CL6GTo/7ujbUWwAWpTZZGLv3Pe/9Xipz0dXIlrzlUb3rKaTgUG8g209CK17Jq969WMZ6HVcfonvNG6VhSqb9ZJcBRvoa2GyZVkSy/aITIbR00OAVasI/f/ciaUXevvshKoL1fCsC8u0Se/VV/BeBWTZQxh0/EGVYUVqbjzqp8+arhzUu+flEQCqli/mLcut4coRIwpFt4p
x-ms-office365-filtering-correlation-id: 111bcc81-5f43-49a3-9c2c-08d638c570f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4367;
x-ms-traffictypediagnostic: VI1PR04MB4367:
x-microsoft-antispam-prvs: <VI1PR04MB43675E7AC61BE7D402F47C9099F50@VI1PR04MB4367.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(264314650089876)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4367;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4367;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(396003)(346002)(189003)(199004)(5250100002)(6512007)(2900100001)(6306002)(486006)(97736004)(966005)(105586002)(476003)(2616005)(7416002)(25786009)(316002)(53936002)(4326008)(99286004)(26005)(106356001)(6506007)(2201001)(5660300001)(386003)(6436002)(256004)(86362001)(81156014)(478600001)(102836004)(36756003)(39060400002)(6486002)(8676002)(55236004)(81166006)(7736002)(71200400001)(71190400001)(66066001)(52116002)(2906002)(68736007)(8936002)(305945005)(186003)(3846002)(217873002)(54906003)(6116002)(110136005)(2501003)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4367;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pP93fq5rtFauV1hpWFrqoiWbPbqdhlVgvpJ3wdORj1UhYiXqnIpb6rGFk7DAWVPvzXWaZ9rdwWFAPGbPrvFwjGFvx2z2E1bnb9XGp0X0Pk2CI5P3nQVfMUgkSF14hecaIpek0V0I7etGjEDn1mtKAEJDBTSFzJCQ/J7QcD5w6srm4NmNh1c5oFd4Gx0dewHw5AzT3VrR/dDgNr4k9EJRWAU8yhYHUD1Z+oW/ZmTY+6BVFYeXiU3TQXGB7ontVv3KJIg9HNdBx/LReOEVeNfCIiieJBfWAIDm/zjzfLcIBAVdZTJCf6/EZIJ1x9JuFrYOEFiKho9wh0V2MdZuixOGFnYVkPC00uLhXJ6tqO19RYI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 111bcc81-5f43-49a3-9c2c-08d638c570f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 08:56:38.6862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4367
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add driver for NXP FlexSPI host controller

 FlexSPI is a flexsible SPI host controller [1], Chapter 30 page 1475,
 which supports two SPI channels and up to 4 external devices.
 Each channel supports Single/Dual/Quad/Octal mode data transfer (1/2/4/8 b=
idirectional data lines)
 i.e. FlexSPI acts as an interface to external devices, maximum 4, each wit=
h up to 8
 bidirectional data lines.

- Tested this driver with mtd_debug(Erase/Write/Read) utility and JFFS2
 filesystem mounting and booting on NXP LX2160ARDB[2] and LX2160AQDS target=
s.
 LX2160ARDB is having two NOR slave device connected on single bus A
 i.e. A0 and A1 (CS0 and CS1).
 LX2160AQDS is having two NOR slave device connected on separate buses
 one flash on A0 and second on B1 i.e. (CS0 and CS3).
 Verified this driver on following SPI NOR flashes:
   Micron, mt35xu512aba[3], [Read - 1 bit mode]
   Cypress, s25fl512s, [Read - 1/2/4 bit mode]

[1] https://www.nxp.com/docs/en/reference-manual/IMXRT1050RM.pdf
[2] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=3D26=
689
[3] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D70179

Yogesh Gaur (5):
  spi: spi-mem: Add driver for NXP FlexSPI controller
  dt-bindings: spi: add binding file for NXP FlexSPI controller
  arm64: dts: lx2160a: add FlexSPI node property
  arm64: defconfig: enable NXP FlexSPI driver
  MAINTAINERS: add maintainers for the NXP FlexSPI driver

Added Mark Brown as reviewer in to list, thus sending patches again.

Changes for v4:
- Incorporated review comments for
  patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
- Incorporated binding file review comments.
Changes for v3:
- Incorporated review comments for
  patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
Changes for v2:
- Incorporated Boris review comments and drop below patches as per the comm=
ents.
 - Patch 'spi: add slave device size in spi_device struct'
 - Patch 'spi: add flags for octal I/O data transfer'
- Incorporated DTS and Binding file review comments of Shawn Guo and Rob He=
rring.

 .../devicetree/bindings/spi/spi-nxp-fspi.txt       |   39 +
 MAINTAINERS                                        |    6 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts  |   22 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |   12 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/spi/Kconfig                                |   10 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-nxp-fspi.c                         | 1158 ++++++++++++++++=
++++
 8 files changed, 1249 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
 create mode 100644 drivers/spi/spi-nxp-fspi.c

--=20
2.7.4

