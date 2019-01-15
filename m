Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA9EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3982120657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xijY1Qfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfAOMA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:00:29 -0500
Received: from mail-eopbgr130042.outbound.protection.outlook.com ([40.107.13.42]:23552
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727376AbfAOMA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsMpye81EQDYNr7SNgdrP7g4O1sA/znwFtwHK9s4I+0=;
 b=xijY1QfppXem/F/Ju4cxqrMK3UyLaJPDXJPCyfWmJ0RnJ/dIC6W97cOXWLw5fd8ga0vyHu5BKL7aH0L54yRb78CTlykgP4nxaGuaZhKbK8J2/iPcbtYyPisgqIfSMjI1haentleXj0OWKux+3G36NV3ANRkncxFKNPcfG37432A=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4301.eurprd04.prod.outlook.com (52.134.31.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Tue, 15 Jan 2019 12:00:09 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 12:00:09 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
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
Subject: [PATCH v8 0/5] spi: spi-mem: Add driver for NXP FlexSPI controller
Thread-Topic: [PATCH v8 0/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUrMncVq7zVfaZGE2Ch++A8i98Tg==
Date:   Tue, 15 Jan 2019 12:00:09 +0000
Message-ID: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0096.apcprd06.prod.outlook.com
 (2603:1096:3:14::22) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4301;6:7wi+dVryj+OkPxmkNbWJG5xxP54jBVfmbxMmH/NuYeyINqk4uVJeBIKg/QBeL1PwRc4+u/RKVg9sgxGrZvrrHd0sn9IfjFUj9xL75r03zI03E9qqj3PTPcdjpAyA3n/IAZieoXL4aSYIagQIe5RLeYLJzJZcDoi3lw6/cx129e6zgwQD7bYN4azCKMo50Tyv/mZ3Wkb7V444JNt7RDoA6KMPdsyTABEE33S41+0KYLnWf2QUIAA2Cyj4i9bDgy9p+/JUOSJdekLquGyXH3EBVDx5jql4DWptcr75keLPSul7jX4clbnBXbETcMChODqlpGMPBxwQOKing1km4Lp1JloHxR4kDp/7ieoJV4BnP4FJosKntJkA3bY8s2hmC1gWrXXSmY26G6CMcB8j4Vr4CGT2vV0/B5+4HL19njQ+nKUuyuXycEnB2ftL7p16P+iwNfyYiFI0iRSz8GfzXqUQ8g==;5:qls8jM+KFfdJ/0HrgkySuAP88U6xamYcGsKp5ZBnYl8AHa4W4frJUXkUzq8msr2BaTaHdzV9+GmrvGLzV7/snQlQZzLiYEv4iqceAeJmgJXIPdllbo/raAc/aSOIKSZXYAeThHETkFo0fYZ6rDINmycrhCMtFDiaTxwDfXr8Yeb2bxSRZfJMuW/2XwnK6zQFSdNHaJXBGlDC4yDypSLhJg==;7:IsxEuYOF9nOVKpxxrlKnAue0hKTT/M6eSk/y2jh5uke4m60s6l5BkH0oTBw1LMNu5Ym/zE2EOlCOAcqDh+HcYxbtz/P8aj4Al3LbcViI0xIqSaJxV3WsJIX9AAjk9gHH0VHpP/R8Y5CijtPMMdPU0g==
x-ms-office365-filtering-correlation-id: 91d92e43-f021-452e-6405-08d67ae0ff1b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4301;
x-ms-traffictypediagnostic: VI1PR04MB4301:
x-microsoft-antispam-prvs: <VI1PR04MB43017E1C6160C0D6B81A78A699810@VI1PR04MB4301.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39860400002)(189003)(199004)(26005)(102836004)(6512007)(25786009)(6306002)(4326008)(105586002)(2201001)(86362001)(478600001)(186003)(52116002)(966005)(6436002)(53936002)(476003)(14454004)(106356001)(50226002)(8676002)(81156014)(81166006)(8936002)(7736002)(305945005)(486006)(316002)(68736007)(36756003)(7416002)(110136005)(54906003)(3846002)(6116002)(97736004)(78486014)(2906002)(6486002)(256004)(14444005)(6506007)(386003)(39060400002)(2616005)(2501003)(5660300001)(55236004)(66066001)(71200400001)(71190400001)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4301;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MCJJ/1H2oyFi7+6Fpxxz29xdQ4f43Br7P1erceY9GQKwqOpV4xuo1WJdY9Gr4Tl0HJn/eUcZRiG5ToATRO3iS0ZcwJNCnSBe4sORoWNOzmKD1cG9Ab+Z/DYD7/fecchFkwixL59n5QuQTDnxaESyasn9JMKmmrRwpdlqAQYLDxaijEOrTCYag8gMrg2KcK6TdXT4KfiQnPgK6BEXtYuholnDpVtJtG936BAjWPNv1ZE0Yg4S7HGPEA4pxNJxs3s/prMjmwx3Qx5oNSlhYdfYJYmkDy2MLZEuCzz5CR8E70+9X83INExD7ED/vQtlRYjG+jBHdGRgQ7trOKaYcWhwEwrFeRbqT1Uns+NqyqxwnCpTfWCZzsGXSiO4WggxtW50E1AbKXnG4dBWoncLWJxwN0DPycnEYlutN+WmjyxnSxE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d92e43-f021-452e-6405-08d67ae0ff1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 12:00:04.2469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4301
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

Changes for v8:
- Incorporated review comments for
  patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'
- Update MAINTAINERS file
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
 MAINTAINERS                                   |    8 +
 .../boot/dts/freescale/fsl-lx2160a-rdb.dts    |   22 +
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |   13 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/spi/Kconfig                           |   10 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-nxp-fspi.c                    | 1105 +++++++++++++++++
 8 files changed, 1199 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
 create mode 100644 drivers/spi/spi-nxp-fspi.c

--=20
2.17.1

