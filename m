Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6ADC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFFE2089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C8rGXqiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfAHJYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:24:41 -0500
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:60416
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727367AbfAHJYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJUf69BoIjxK8j1z12PddxfzdSwezDy90cXjJUf5cSA=;
 b=C8rGXqiXEJuBHUz4Yr8sxa3BMbDmfiGZH71NkbG6TSi+Ka7oENA7GERmEoFAexcRnOYL0ZQAc8mCox+Nybh7JWAKvOBMgPNRTpdI+gT8z9idGejnuJik69zQmKScuXUsrgFtNHSuvE1JjhYvSHqknjnFjZncdHwP2lbNW6a5tMk=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB3261.eurprd04.prod.outlook.com (10.170.231.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Tue, 8 Jan 2019 09:24:35 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175%3]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 09:24:35 +0000
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
Subject: [PATCH v6 0/5] spi: spi-mem: Add driver for NXP FlexSPI controller
Thread-Topic: [PATCH v6 0/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUpzP4PV9+XjynmUWrRoOqEAtjTg==
Date:   Tue, 8 Jan 2019 09:24:35 +0000
Message-ID: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3261;6:AQ2LeZWcBSprcIVMF6+/OaqubtcdehWQXl8Y2BLQ7P21ToXNLKZJuuvVn8OQW4ea+hvRmv7K57uE6BSCXMPMsERJhD9pO5wi1Af/t4ZZ5brV+TPx1+hmGzvIGRB3R8/Wg86CvHswx9POaH/V4QjFIZcuvhCHAvnR2ZGJF2idPNsmYhJP1yvcBX8U4CNy0lkStTD4einED3grFMlZs8wa/oCJZr7djm2WwEYy/XRKGTaioKgZLeLEOSRsBzprfaecf9ysPfABbYKw+udrZ6M6YskgqUNvr+e20j4Pl2hrDuYCdPAWqRcOR+VvzYVgS3TEU7iqRcNu3C+HNI9u9lU5+D41AxfKHGHckRmyZ9L/PmI11Ob3EZEOkgIAs8gQg1E6To46RRKgVhb+HH7R66ulq6BhSWsBGajXDqsuPd7HZcEgdcI08N3KfLAD2tr7TKCwpRzkUJwLzj7wwCkzW2IpYw==;5:MtRS8zYIhPLLSzZYvMEsFEipMSQk9M6Q0VMSW0y/4n7wwfuWAdK0mdBvNkdI+UywU4Cc8iHi1C1mrQtl3WEdXev4CQMq+tIth9XEPBOtO7jcB7QmR4yGGtfk+U/PD+HK+DPPkATH0gti8AKfS6OjRrGgGXgzbSxwuXTUcrz6JyTtKzKEtzx2p3e0gjotndoXKWf2jIlgoPNWV8rN/fAiZA==;7:neyAls31LwnW2EygLHXtNtmbulzmnml0VM00V9vS1tdS4o2oLh0tPx+AQRVDASITJTBKNPeA+rotQOqOiTlM379naZ+WUsds3LEFU7Ii3k/EqO6CcS4Re6LxjFH6GAORABtgfqq/XyH38a5QZhacgA==
x-ms-office365-filtering-correlation-id: 019269fb-bcb5-4374-5afe-08d6754b1a9f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3261;
x-ms-traffictypediagnostic: VI1PR04MB3261:
x-microsoft-antispam-prvs: <VI1PR04MB3261C8A2B2EACE395DE6BACF998A0@VI1PR04MB3261.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3261;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3261;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(136003)(199004)(189003)(52116002)(6436002)(50226002)(54906003)(8936002)(316002)(6306002)(110136005)(81156014)(81166006)(7416002)(6512007)(478600001)(8676002)(6116002)(78486014)(4326008)(97736004)(5660300001)(6486002)(966005)(14454004)(2616005)(2501003)(2906002)(476003)(105586002)(106356001)(3846002)(36756003)(66066001)(71190400001)(53936002)(386003)(2201001)(102836004)(71200400001)(55236004)(39060400002)(25786009)(26005)(305945005)(68736007)(86362001)(6506007)(486006)(186003)(256004)(99286004)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3261;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pMZ31ZhHSOj6SARTpSxPERHwVIWOEpFLTO/WFJcomwlVLeoY41P2/fnry6Y/qEnMjhg/X6gMqyIbttCtfHg7HdKXBxCghAiEZ+tm3LPcFplInu9Eg1J8SO6aCP4q8c5T5yGqdCkxYXKFb84Ej6VL9d5OgKKZrQ3PgC6Iiu1BMUX0RUpwbxNPNewAUWsweTfHvbfhNqTay4dEXFYjU9WKWtjunppnoalqNoeL/A/KaO/JWEvHpBdObeRGmMUn/RAeoDsA5VkLMzirC7B43/Nl8zc6GED8bpeb5ZM0GrSwB8/SSQG6SXzr853SAMOdkTvc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019269fb-bcb5-4374-5afe-08d6754b1a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 09:24:29.3302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3261
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
 drivers/spi/spi-nxp-fspi.c                    | 1095 +++++++++++++++++
 8 files changed, 1188 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
 create mode 100644 drivers/spi/spi-nxp-fspi.c

--=20
2.17.1

