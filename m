Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D3AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1457F2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jidP+sI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1457F2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389670AbeKPV0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:26:08 -0500
Received: from mail-eopbgr50048.outbound.protection.outlook.com ([40.107.5.48]:12395
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727757AbeKPV0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZdOQdwySV3xEidFILOAK4TydRJDxbFrL0iPyGXZa1A=;
 b=jidP+sI3qqgeeU//Zt27SinoEdGJOWgchtPljPw9z3gThASZnkYcfoF8XyIlInbW22dlNboWcwr7hKsDY/Ath8AzOoxPFRIlktYgYvDm91iPfH/71WgwbaPsaQMR01OcmU4YaJ6Un/CadXa/eTu+Z1AcIgmP5ZO1P4dOZBs8XyE=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB3294.eurprd04.prod.outlook.com (10.170.231.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Fri, 16 Nov 2018 11:14:09 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::297b:bb50:9b83:48e1]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::297b:bb50:9b83:48e1%4]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 11:14:09 +0000
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
Subject: [PATCH v5 4/5] arm64: defconfig: enable NXP FlexSPI driver
Thread-Topic: [PATCH v5 4/5] arm64: defconfig: enable NXP FlexSPI driver
Thread-Index: AQHUfZ1+VsEhqMth3kuSs7HU0jP17w==
Date:   Fri, 16 Nov 2018 11:14:09 +0000
Message-ID: <1542366701-16065-5-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0149.apcprd04.prod.outlook.com
 (2603:1096:3:16::33) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3294;6:4rL638gzYXBSBzwhAKHWNcYRP9hPIqi8gxgCz6/yBLvhhIsmX0pewkquixC2QZN2UaMo5c0JfxyclT1uSzo5emHo0eaTGODvJEUVv6vMod1yV7sXH3RI7CnI8SUyffVkqSCV2g99dAoArXy/30yOZ0GjrXFmA998N/nFMDRnxtg7c6jvgJc+R7PXFLh5OPTmGq6gONfkVjed4OLnt0Am1/qTRtOxi3sbIn4ozAKzU8dBjuwV8S0huk8XNs/JQ8bTudf33OtBA6CDOTMY4L9SUMLO9gw5ybnXm2iwNQJhUt+UM5B5hnc6+YOmRk2FGt7DAwWbkbDGhRiNXW4ktIuyi3ew/PyaauVBrmntUtNMRAV122oq+Pj6XmUVEf4JHSTbipDf6Q6lVgkKDSmjpUyCmSIh03U7/O/L9PQ84xYTLUSa1zrRkLZAusvMYr1AWGruO4a5aFNjVVNJHsJ8x/YhOA==;5:+fIhRQ5rSYdtku5dNkjg72nEmIc/dZc+N18fs8et0bVWE1WcsB7Q5m/DqRcD1ntmvMYVsUDQ5PPUKzsMj9Spv0cXTrjOQhT1yQA2iLhMM2EMShsQRiPICPgmHJuS7vAGXqwdX/kZSpW1kMtuOda6wFJAcd+t3UVCmmpRgdr0sro=;7:g9JCMI1ZU8ugr2CYHDeq8o7fOMFEVlzZ/6NvF55iBNA7FuibPVyfiGhtaC51QwUrn8V4rw0pmliyLGkuzsflvcrbrSh1gzj1g9ArdQfJAZe3JBAdue7DiFq+fcPeqMR7AenelsT25DLmjGS4aIZ8HA==
x-ms-office365-filtering-correlation-id: dc4da819-08e3-41e9-b012-08d64bb4a116
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3294;
x-ms-traffictypediagnostic: VI1PR04MB3294:
x-microsoft-antispam-prvs: <VI1PR04MB3294ABE9663E0AA74BA35A3599DD0@VI1PR04MB3294.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231415)(944501410)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3294;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3294;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(396003)(39860400002)(376002)(199004)(189003)(2906002)(81166006)(8676002)(6436002)(106356001)(81156014)(6486002)(102836004)(25786009)(53936002)(4326008)(316002)(478600001)(8936002)(7416002)(6506007)(55236004)(6512007)(386003)(26005)(105586002)(186003)(54906003)(110136005)(68736007)(14454004)(99286004)(52116002)(2501003)(2900100001)(2201001)(76176011)(3846002)(6116002)(97736004)(476003)(2616005)(36756003)(78486014)(305945005)(486006)(7736002)(446003)(66066001)(256004)(71190400001)(86362001)(71200400001)(39060400002)(11346002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3294;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mLFAbgdxEA6NZnr2mDopWZoIQtJFyiaVEDhRXJJ0NW/5nPzMaWXknvQAnWM1DKjkh+VqNLhpsWNtzMIUmV2QdmMc/Q99B8JNE13jdMwd6O7O0Ze88uYeL1/Ve9fu5a8bFvBdVShUVGpX0fxf75Ai8cgqNEA9WtmE0M1vgNcTUPb8wz0xWDYDfeewThU1EItixOj+2BPSUMD7B272NTUwSm15XNdMKguKNbnSoArRkfdAD2QVApE8fmU7ca2STMU88CfmpXbeT8BtY4JaHdvr/PWqwzBbv/xUSxSokI/jhpOjqlEj+xfvRKAEP6lVuSbzHO668r6wIpVfC2fhDb+7O4ZqO211/kjESboMyD5Xn8Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4da819-08e3-41e9-b012-08d64bb4a116
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 11:14:09.2231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable driver support of NXP FlexSPI controller.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v5:
- None
Changes for v4:
- None
Changes for v3:
- None
Changes for v2:
- None
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9a57d1..3d81e25 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -341,6 +341,7 @@ CONFIG_SPI_ROCKCHIP=3Dy
 CONFIG_SPI_QUP=3Dy
 CONFIG_SPI_S3C64XX=3Dy
 CONFIG_SPI_SPIDEV=3Dm
+CONFIG_SPI_NXP_FLEXSPI=3Dy
 CONFIG_SPMI=3Dy
 CONFIG_PINCTRL_SINGLE=3Dy
 CONFIG_PINCTRL_MAX77620=3Dy
--=20
2.7.4

