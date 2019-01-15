Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8254FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3B820657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i2DpVS3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfAOJu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:50:27 -0500
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]:26761
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727334AbfAOJu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dj3WJ/y+KGbO/+d/kY0MMXbeP/syb6+0qj+xWXvCLAM=;
 b=i2DpVS3aip3OfO/GiORnWYXEXNGfkTGaKJYyuhieWdO1wEP0xDz/FsDIoimQckHhQI0u6xBQowMaOyX4/ABcrtGK57AntvcZYXXCPwcxZZUAqcUVrSyyDeedjMHJ5e4Y3FeoH/KBlFa08ZdjF9PR/d+qISaEv3qL5LUzb06yIP0=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4989.eurprd04.prod.outlook.com (20.177.49.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Tue, 15 Jan 2019 09:50:20 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 09:50:20 +0000
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
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v7 0/5] spi: spi-mem: Add driver for NXP FlexSPI controller
Thread-Topic: [PATCH v7 0/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUrLe6o9ac6oGIZUGT4/42C+3RlQ==
Date:   Tue, 15 Jan 2019 09:50:20 +0000
Message-ID: <1547545697-4042-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:3:2::25) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4989;6:e9Mh+fVLkLDmgMN9N2N3SmDenokwt1a0i70We7wCPnTvWc/xxOznI36P74dRusmWG90zYsB7MK1Eg7QTK9KWqyY6K3kDXpqNFTI5F2/qXSzNh0r+Iu5LoWRAhEdBwLqOzAtAiYmJhW2uGKLbU9bzxZy9EJslgim0a8a5y5tIBGSkOwlEmSeBEV6T6mpgzPgrlCyD+7ejc6rJ61362pBr8on+bu1cNNk0Gx0h5wlCuDZFScnO1Vrbwui5xFu+sdcZQeFpYx4LqaGk9ApV5fTofDin4MicPnEgV8YB7f56gyfxOrswLT5mhS3TOhCLf+qZhxJWTqoGD/iWOne+bOEscacXOPmNm2jOPkURLeN3jwH50Akd6OujGqzZEGUGMAAqruQpor37KYJc2LXTl9lu2X3COjK721EFjLGL69IhI4VIJzkydPXHad/g8UFMNEtSWDJPb3P0JkiZwacZaccS7Q==;5:u0KGr/wDOQVvpzR1eJ7HHTRAPojNXYs4SaMPEJXXrRrjUlTSajxNWfbqKl/tj95OEO5NPbtB1fkVscbbAngm9DiAwrMm8FRnFvb8gljL6HX/fItKCoLUzcSWIRg2WQKqHPNh4GKse6czkSTOhmbT0Wbh8Gat8S3LmxnzSjmeyyd1LdAFel9Lu2AWSD3lW9us009Y17nqqvFzLkbhGOWvUA==;7:GJNv8X/PvSAEHEiM2VuykhvAT9MqfzBngQtWwVdK38dmdboeMANmVUeuHoEh8V3iP5T4Jg3hpp2CKFMc1BFAQ/xfHwp7rx0bHU4KSQurM5p9ExUxVykl3aPIhnyswgQENUxO4UVB783um4tZ+dRbeg==
x-ms-office365-filtering-correlation-id: 9792d78a-6e01-4bfe-e789-08d67acedc4a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4989;
x-ms-traffictypediagnostic: VI1PR04MB4989:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-microsoft-antispam-prvs: <VI1PR04MB49899FC6E156313E5E8B62FF99810@VI1PR04MB4989.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(199004)(189003)(71200400001)(5660300001)(486006)(52116002)(71190400001)(86362001)(2201001)(106356001)(55236004)(14454004)(966005)(498600001)(7416002)(305945005)(105586002)(476003)(8936002)(7736002)(6306002)(102836004)(50226002)(97736004)(6486002)(256004)(68736007)(6436002)(6512007)(2616005)(386003)(110136005)(53936002)(6506007)(36756003)(8676002)(81166006)(81156014)(39060400002)(25786009)(66066001)(78486014)(2906002)(3846002)(99286004)(6116002)(4326008)(2501003)(54906003)(26005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4989;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bk7rj11uG6RgO57JwzNodincXDP45DU6Cq8aXbQ5S8YHnD4ebpJM6uQ1rwYR7SVjUmW2jEivyFtLRaqdbTsr1FlC3uRI+2o/pKI3Aokryn6LeeJCFHYPA080O2dQviV57fl8EFsXizp8GXwUpYEpO846ueAaXF+Es3GbZkUTqW5UonkMnhXWy4ShoHx8kHQqfCKBpfdsY+6i1XbCIBLjSS5M88iL1+yIHlFff9DUARTi+H/5CAzPbgJ8j2YfECknp0coGSlNzQwMWCdRT4abi8od4WHtHaYapy+Idh4nr4cc5QcjYeCIYVmhnKQ0iUaI+PM3FotqrzorFP18uaXQk2ODkFX0su0aC3nGcSjaBNtbBEl50SZWJDROvdwuyczSc4R2048wUjdLz1dpfjxktl6Idhvvm6FeuS9g8QostOo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9792d78a-6e01-4bfe-e789-08d67acedc4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 09:50:13.9281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4989
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
   Micron, mt35xu512aba, [Read - 1 bit mode]
   Cypress, s25fl512s, [Read - 1/2/4 bit mode]

[1] https://www.nxp.com/docs/en/reference-manual/IMXRT1050RM.pdf
[2] https://patchwork.kernel.org/project/linux-arm-kernel/list/?submitter=
=3D182097

Yogesh Narayan Gaur (5):
  spi: spi-mem: Add driver for NXP FlexSPI controller
  dt-bindings: spi: add binding file for NXP FlexSPI controller
  arm64: dts: lx2160a: add FlexSPI node property
  arm64: defconfig: enable NXP FlexSPI driver
  MAINTAINERS: add maintainers for the NXP FlexSPI driver

Changes for v7:
- Rebase on top of SPI tree
  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/
  branch: for-next
- Incorporated review comments for
  patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
Changes for v6:
- Rebase on top of v5.0-rc1.
- Incorporated review comments for
  patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
- Updated s-b tag in all patches.
Changes for v5:
- Rebase on top of v4.20-rc2
- Incorporated review comments for
  patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
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


 .../devicetree/bindings/spi/spi-nxp-fspi.txt  |   39 +
 MAINTAINERS                                   |    7 +
 .../boot/dts/freescale/fsl-lx2160a-rdb.dts    |   22 +
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |   13 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/spi/Kconfig                           |   10 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-nxp-fspi.c                    | 1105 +++++++++++++++++
 8 files changed, 1198 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
 create mode 100644 drivers/spi/spi-nxp-fspi.c

--=20
2.17.1

