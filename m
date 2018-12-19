Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED70C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EFA21850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GBAqZSRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbeLSKMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:12:20 -0500
Received: from mail-eopbgr130081.outbound.protection.outlook.com ([40.107.13.81]:47264
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729015AbeLSKMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:12:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aol7gB3+Oyy9LNBz2VxiO2zMlgu6xs1Sy7T8jk+Wxx4=;
 b=GBAqZSRZzIuPj8aUnen5N6/F5V4TtACj5ACaBIibT8BFZ6GMWMYdhbGWJ/uHjdfhG7ybnElNNLN0nupLO9EgbR1Y9k3Aox6+THVQkLO17gs4kT+pyNTTEGR3Te+HyHVJuZEuUwSbTXvs/jdY5ni/MYFobOGvPvCyGX16sJZyGc4=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB6141.eurprd04.prod.outlook.com (20.179.27.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Wed, 19 Dec 2018 10:12:14 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175%3]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 10:12:14 +0000
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
Subject: [PATCH v6 5/7] mtd: m25p80: add support of octal mode I/O transfer
Thread-Topic: [PATCH v6 5/7] mtd: m25p80: add support of octal mode I/O
 transfer
Thread-Index: AQHUl4NQVBxRVI8JBkuWnpcxNol4GA==
Date:   Wed, 19 Dec 2018 10:12:14 +0000
Message-ID: <1545214186-16987-6-git-send-email-yogeshnarayan.gaur@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB6141;6:M6rd/mPjTRTvJQQBNUdHHpficT4/5TqHdrsHi8L0FrwSTro9GqY4jijTrPYlmOSFMVVSa2AGcaoPYn0M7IK0OniPE42H/pJLqaLCeIYOaIC6+JRLLS8vMwI7t5JB3jDz0mQ1NDGOAM6hDOTPiE5JjdybGb1mJ+o+Q7ook7a6gQmtjHejOxcPHZtDm27bMcl6kwg2TIJvYMIOedlxXdk6thsw8qcpfui62XLOdf4NFjXKnRUFY5lU/fSSknNAsWjd7DEekmA27HDsbzIkXn9cxB2z54MjdGgZRED56UTJxJdnJuceSHy+qyhM/nTnV3dwBSv86XM8HQ6QRBRSGsuFpqxZc7pmHg9KwwfxkOkNMR1aqFVR/3hcKpQB2h0g0w+bWO9t30qBFUm1PWYskS/3Jok+eFKZFbHHpsmh3udkIKnSsXFVT4RWuUe6KyIu93oavVzr4pisqprb1RQdOOVyNw==;5:y/HHE3BaRw7YS9tuUuDDB1aJJCW3R7m3joQBR9kmDxGCnkmpZrhbGmXWHacijyezVmM31VtVkksP51WyWmNyolSejkUn0Q9Ny3RKhJnH5VEvTpBz/ZdJxd/NyefB8YCUnfxR9MeFCqHvuIfYh109kUeW+BxgoxdeqecS/Bg8Sp8=;7:XEi/PkEd2nTxFpiqf1l2Psk8eAWtDG/Tj6Ubmgg0WGD9eNS+e6BceF8XGLuuJOTuVBFQimWDGaEKkQ1Fmj0CI//45pq2kMpzQajU1akr7vhqpAySYe5cuRYn2apcb+oAqHSpZkgGtUHrg0D9bT0sPA==
x-ms-office365-filtering-correlation-id: 8a388976-7149-470c-53b3-08d6659a7266
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6141;
x-ms-traffictypediagnostic: VI1PR04MB6141:
x-microsoft-antispam-prvs: <VI1PR04MB6141FDD3149B6763BF23945199BE0@VI1PR04MB6141.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB6141;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB6141;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(366004)(136003)(376002)(189003)(199004)(6506007)(39060400002)(78486014)(386003)(6512007)(6486002)(53936002)(3846002)(97736004)(2201001)(7736002)(6116002)(8676002)(55236004)(4326008)(2501003)(2906002)(66066001)(25786009)(14444005)(76176011)(52116002)(256004)(486006)(6436002)(102836004)(7416002)(105586002)(106356001)(36756003)(81156014)(476003)(8936002)(186003)(446003)(86362001)(478600001)(26005)(54906003)(2616005)(11346002)(71200400001)(71190400001)(110136005)(81166006)(68736007)(14454004)(5660300001)(305945005)(316002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6141;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HNYHqfTgw+Mq4JLGsk1FhnN3HHvmwMeKNRBHTzXE8M6TMkdWeMKOBtppX/hmKnJVlIqH8I6mgmrnS0b6tQfVtK9d3prZ8jQjUGEQR3ywMX/BeRlqCQLAGmNvplJcl90gDQ1DFeMfqErAcPAcC51E+z6NMWaXPCnUGTXD7CTyrYpIv1OAGom9vhZZX03Y0HSK7ABnpdrTvBk4e0e5QK9LLc/UR9tIm2ZVIbdYmdjJo0Zm3fB1NjQ1kRNMiPgqBNPbvDWOZcRYb8ragC4TAc9+p6MZKhyIVBUwamNpHMnytM3z6bxfqJ43/J7AD+jDieVg
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a388976-7149-470c-53b3-08d6659a7266
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 10:12:14.2712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for octal mode I/O data transfer based on the controller (spi)
mode.
Assign hw-capability mask bits for octal transfer.

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v6:
- Correct S-o-b tag with full author name as 'Yogesh Narayan Gaur'.
Changes for v5:
- Modified string 'octo' with 'octal'.
Changes for v4:
- None
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- Incorporated review comments of Boris.

 drivers/mtd/devices/m25p80.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index c4a1d04..651bab6 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -195,7 +195,14 @@ static int m25p_probe(struct spi_mem *spimem)
 	spi_mem_set_drvdata(spimem, flash);
 	flash->spimem =3D spimem;
=20
-	if (spi->mode & SPI_RX_QUAD) {
+	if (spi->mode & SPI_RX_OCTAL) {
+		hwcaps.mask |=3D SNOR_HWCAPS_READ_1_1_8;
+
+		if (spi->mode & SPI_TX_OCTAL)
+			hwcaps.mask |=3D (SNOR_HWCAPS_READ_1_8_8 |
+					SNOR_HWCAPS_PP_1_1_8 |
+					SNOR_HWCAPS_PP_1_8_8);
+	} else if (spi->mode & SPI_RX_QUAD) {
 		hwcaps.mask |=3D SNOR_HWCAPS_READ_1_1_4;
=20
 		if (spi->mode & SPI_TX_QUAD)
--=20
2.7.4

