Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98688C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E476218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p499q7Y0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbeLSKL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:11:57 -0500
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:31677
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728714AbeLSKLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSui6ivoM5C6JccmvtXmjCVSeKXWAV2JHslGhvYma9Y=;
 b=p499q7Y0I19iwbTar2bvsp2uSNKZy3msLz5TfqSBbzcsA/XYX/AiuBLcoBKYX8kSVO5lgdUvFT1XSbBmeBz38DLyPRt5NeaCp5f9R00iu382RjouoJDN3nYJw79wT8Jf8AQBtDLug1vOZc/kKoyO7RWiazQfOMf6bx39+cBzWQo=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB6096.eurprd04.prod.outlook.com (20.179.25.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Wed, 19 Dec 2018 10:11:49 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175%3]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 10:11:49 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v6 1/7] spi: add support for octal mode I/O data transfer
Thread-Topic: [PATCH v6 1/7] spi: add support for octal mode I/O data transfer
Thread-Index: AQHUl4NBIWyUgOasmESGX5g9nVbhyg==
Date:   Wed, 19 Dec 2018 10:11:49 +0000
Message-ID: <1545214186-16987-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:3:17::21) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB6096;6:NvN+5LIwQimBOwbjoWDe61pkDYX6S7JfVPVouRv/ouj7gjkgm2AouvhYXS7IUOnJfGrIc1QlrmcfDX3QbEGc0Q24siNIasd6Gwim19St50VHX2u2oMmMKDPamxTyrx39vYFaCnBccxKvzvGaD32E8XzvW4J9HBbBBmdZi6uBFsJ+HQ7KPTye8Szhmb0y11++Z/TQ/ALJegqwtK9FWEA09x+7ccqGipqXSO5voRn479tUKK1IYD95oY2Cnd924MselwCpXkXNJJ80YRv3sPLK+tp16DuN/sTygfkrioe58MHFhK9qVsQ4VA6lXtcNqL8hoY7a2+7xVF2bv1ncv1snBNkcghwx1u6JdNAdmpl90Efx9QzPBGBeUqxR+1rGKAmThhweOeu9ba8qjSW88MtdUGvEQcSd0w39K0uFfIH4qUHdrbFzXA/IDqckyiaDVnWI6bxD832jnobl0v/0KseNdA==;5:Tuq9y2Vd0wsgd/6qpux08vuMGcO+IAR7WbpJEv1fUyhLf2lyC2O/Z82edpTKf08f4g83gagqU7JNloXiWOe0jyZ1d3NlLdacSGNQDDexIUeYUpcF4oQuM2KSb8QbIzT9Kydh4uU8l2dXcT3i7b0EvIGDjYQ1eBvZoYbwiGjCYTI=;7:TY3f7L5SZGlMp9CzC+u4tUPfxiOQQzjak2VVc3aXMZ0bu4L/raeeImaS+rCUmwJ6RBWD0bBWgQKG0gBX/J8A75T7dcmFa3kcq6X8DEYSt/XMGGm2QvaE0q/k9A7S9hKPYGinM4mhEv6tztuQ9b2kcQ==
x-ms-office365-filtering-correlation-id: 6be46db4-8b3b-4e04-a209-08d6659a63b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6096;
x-ms-traffictypediagnostic: VI1PR04MB6096:
x-microsoft-antispam-prvs: <VI1PR04MB60968CD7404EDEE5D42725E799BE0@VI1PR04MB6096.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB6096;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB6096;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(136003)(346002)(366004)(189003)(199004)(52116002)(316002)(6116002)(2906002)(76176011)(5660300001)(256004)(53936002)(305945005)(68736007)(81166006)(6512007)(3846002)(66066001)(7416002)(446003)(2616005)(8676002)(81156014)(11346002)(99286004)(97736004)(476003)(486006)(478600001)(14454004)(8936002)(78486014)(25786009)(36756003)(2501003)(6436002)(2201001)(39060400002)(4326008)(54906003)(6486002)(575784001)(106356001)(86362001)(105586002)(102836004)(26005)(71190400001)(110136005)(6506007)(7736002)(186003)(386003)(71200400001)(55236004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6096;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: W6SndUAHIFsHx7PaO5u1fYyF2qOsU66QV/sks2U4O/5Q1z8eldjyy6hxRYE14hYb9xNYUatsjnWkn76C7C3sh45SDMRh92Uc7cxTZFsGNfTMyI+bEM+YMTqfSVFIxdgr59mme2Xe+nWazs+lRdhSofdGetr3s0d7SDi/WMXG4z8NLW8upbHfmdz8XulUAiE5BwqyD90vDqSM3Kas1twcVZIhOjNIPJMmVSrrSeBFDYBs8Jq4xkCrFZj92UfSJViL8sipDVAZkwX8rFvMXwmDIgx4ch5//ZJISj9dX1DS0UZWeH1bQFXasV0rFtjaBwqG
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be46db4-8b3b-4e04-a209-08d6659a63b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 10:11:49.6146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add flags for Octal mode I/O data transfer
Required for the SPI controller which can do the data transfer (TX/RX)
on 8 data lines e.g. NXP FlexSPI controller.
 SPI_TX_OCTAL: transmit with 8 wires
 SPI_RX_OCTAL: receive with 8 wires

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes for v6:
- Correct S-o-b tag with full author name as 'Yogesh Narayan Gaur'.
Changes for v5:
- Modified string 'octo' with 'octal'.
Changes for v4:
- Rebase on top of v4.20-rc2
Changes for v3:
- Modified string 'octal' with 'octo'.
- Add octo mode support in spi_setup().
Changes for v2:
- Incorporated review comments of Boris.

 drivers/spi/spi.c       | 12 ++++++++++--
 include/linux/spi/spi.h |  4 +++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6ca5940..95249b8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1617,6 +1617,9 @@ static int of_spi_parse_dt(struct spi_controller *ctl=
r, struct spi_device *spi,
 		case 4:
 			spi->mode |=3D SPI_TX_QUAD;
 			break;
+		case 8:
+			spi->mode |=3D SPI_TX_OCTAL;
+			break;
 		default:
 			dev_warn(&ctlr->dev,
 				"spi-tx-bus-width %d not supported\n",
@@ -1635,6 +1638,9 @@ static int of_spi_parse_dt(struct spi_controller *ctl=
r, struct spi_device *spi,
 		case 4:
 			spi->mode |=3D SPI_RX_QUAD;
 			break;
+		case 8:
+			spi->mode |=3D SPI_RX_OCTAL;
+			break;
 		default:
 			dev_warn(&ctlr->dev,
 				"spi-rx-bus-width %d not supported\n",
@@ -2823,7 +2829,8 @@ int spi_setup(struct spi_device *spi)
 	/* if it is SPI_3WIRE mode, DUAL and QUAD should be forbidden
 	 */
 	if ((spi->mode & SPI_3WIRE) && (spi->mode &
-		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD)))
+		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
+		 SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL)))
 		return -EINVAL;
 	/* help drivers fail *cleanly* when they need options
 	 * that aren't supported with their current controller
@@ -2832,7 +2839,8 @@ int spi_setup(struct spi_device *spi)
 	 */
 	bad_bits =3D spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD);
 	ugly_bits =3D bad_bits &
-		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD);
+		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
+		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL);
 	if (ugly_bits) {
 		dev_warn(&spi->dev,
 			 "setup: ignoring unsupported mode bits %x\n",
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 6be77fa..0c1ca5d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -154,7 +154,9 @@ struct spi_device {
 #define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
 #define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
 #define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
-#define SPI_CS_WORD	0x1000			/* toggle cs after each word */
+#define	SPI_CS_WORD	0x1000			/* toggle cs after each word */
+#define	SPI_TX_OCTAL	0x2000			/* transmit with 8 wires */
+#define	SPI_RX_OCTAL	0x4000			/* receive with 8 wires */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
--=20
2.7.4

