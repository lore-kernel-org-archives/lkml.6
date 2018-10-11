Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F52DC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E2B20835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bqGMcXu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E2B20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbeJKS1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:27:54 -0400
Received: from mail-db5eur01on0054.outbound.protection.outlook.com ([104.47.2.54]:50555
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727526AbeJKS1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5KSkY84ggVaMG/jYunKVhoIhaRgPz+GgkbenPApoLI=;
 b=bqGMcXu9tUEgDl4Ip5wtQu06KY8B63Rcsrp7PxV3i9gC0BwuvYW34rCf7WQ9aXCM1b/JGiEddM32Iw7vCC0bHqqdevgVp9x+G0/9ILb/HlejkRzQOY1cLDI2eNj9Asa+46/vj4zNqyvsym3NZbMyQcBlVHmlekhfUKDz5gRqUVk=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1024.eurprd04.prod.outlook.com (10.161.109.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.27; Thu, 11 Oct 2018 11:00:26 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1207.024; Thu, 11 Oct 2018
 11:00:26 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
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
Subject: [PATCH v4 0/5] spi: spi-mem: Add driver for NXP FlexSPI controller
Thread-Topic: [PATCH v4 0/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUYVGd5DVkmoaJwk6a/YXF+Itp3g==
Date:   Thu, 11 Oct 2018 11:00:26 +0000
Message-ID: <1539255519-1408-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0173.apcprd06.prod.outlook.com
 (2603:1096:1:1e::27) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1024;6:PWPK7NqjdCKWvOhxWRagvZiYFUKtC6NAuHrCay43rinc+Mcp+MFRzITTkS6o0WcjxxyyhThO1hxILkMJunwa2f9zOsQUOzZGKCY/VkGrdihKM81/LA66wp2Kx+JEKOSKK5SJiDdtPRw2dL8goJkoGscRd0WqBs0Im8XZJlB2OTazHRDkyFEGBqQy7Nhb6qesHOTBXlLmoFlrp8XDvuaZBi4/+WJh+RoqMa3eHsjVeVZu56PZBbQ9eSePBmkukGDK/Nop+de9XC73kp196kjsUR2/l/qlYB0qodklBFTv9dK57dQQqUPq2Ehsvm3aimGecOuOj1o9gwBzPdRjHO0bxMHrEIvvahhR2UBacZgdlDZJhoqSoShOk/ivTmEsY9V3OuHiMqsT4GDTjdMJESShDm8wWHhMnvvbyQxJJ1YT+JeE1QTAqRHC1KR8LFkj+rrixJIkp6kpqTCJgbMjtFMCMiktgeuRjGsS5AmDj9WPlns=;5:1o6a4H3UQeNReiM2+Ma42b86P3YtfPfBSadOR7iyBiAQC5CC/3eshuDs6IwSj2cCRR06cwpCVY16JGm9kE9/M4lGdeU4bAt/f8qWhL7LNTD8zhSts9S9pGS1p7lU9LUeIImefiHCtpAz6r0QvKIMOsVQLSeqK8n6d6p0doqnxGM=;7:Nhv+TbHyCKlzZa5HL7WJrl70e1+6jljhIij89URslWWX0shcu1hIvQvLvDU9i0zu4M9TqIViG3kRBoPXZttDG9xnjb3HQ73yNfGO2WzGeKdp2mnexP+nOpJvnmUHgBglnuCs9PT/mCN5VMLXHwVE5VLsNrtO4gscW1Fpw6cNUlK4ed9b3NqTNiNdpPjEfzhqnxebiutXd0k8RoHVccvdvoxQS6cLjlO22AlmbSQ0u0H1o0zX6yr1VysKkAyYlRxB
x-ms-office365-filtering-correlation-id: d91f9073-fc67-455b-c760-08d62f68bf5b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1024;
x-ms-traffictypediagnostic: VI1PR04MB1024:
x-microsoft-antispam-prvs: <VI1PR04MB10248A3F0880823AE614451099E10@VI1PR04MB1024.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(264314650089876)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991055);SRVR:VI1PR04MB1024;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1024;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(366004)(189003)(199004)(478600001)(39060400002)(4326008)(54906003)(66066001)(25786009)(8676002)(2201001)(53936002)(68736007)(486006)(476003)(7416002)(6512007)(7736002)(3846002)(6116002)(86362001)(305945005)(6306002)(8936002)(2616005)(81166006)(81156014)(256004)(105586002)(106356001)(6436002)(186003)(71190400001)(71200400001)(110136005)(2906002)(966005)(55236004)(6506007)(386003)(5250100002)(99286004)(2501003)(97736004)(26005)(52116002)(6486002)(316002)(5660300001)(102836004)(36756003)(14454004)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1024;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iaIkbDEzhu5EtB9Q/ASREzyHOW0+4pxtYj2GVHjrQutAk9ZKwvr6C+JYi9OQRPxe8D/kl5frYgn41lmccrYAyQpxt02tDnzunoKzu+qoLYDjtqtPEb8b5dtuo32SKOEL6Rm5mZWB8lXujP3sKQ5qMtNPytm3aRLQYmS2ptlGYOUTjNfhnX7vMSKtSuxV2nPdWcjiM+zqyK6wr+vRFwDSRwECsG+xWURdy1wCQohOlmZdqk5ZRDqOrhWmWotADBOytXvTHgDH4vIN9QojS1dKkETe4FZAq/oavyPOiQWerwxZujXwDCb05IJxxMzNugGk3NLGhPK6m5Rrt5XB7DMBrymruwkKpQI/aL0sUhQ4r8k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91f9073-fc67-455b-c760-08d62f68bf5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 11:00:26.6508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1024
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

