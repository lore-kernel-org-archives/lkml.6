Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4CAC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E27420821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q7wUPC8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E27420821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeLJEKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 23:10:54 -0500
Received: from mail-eopbgr40041.outbound.protection.outlook.com ([40.107.4.41]:23462
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbeLJEKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 23:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVb917QJ421eqGqalMUSYshHGI+tMy1pGRkQ0aFbBQA=;
 b=q7wUPC8TmV+B0NpoorxkCP+x+huPZlt8zOGCTBi9VC3//pcIGqF65fGaQR0ajX0pgfZDG3YTvBflvu0auuphfzauubndzFeorzIVIkkdDPMKLLcXuwF9R9MnnF8LC2c5e3E8s9ktMIs8QEuz40puc/oCdVBwrYetkg3CGu8rDes=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB3999.eurprd04.prod.outlook.com (10.171.182.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Mon, 10 Dec 2018 04:10:48 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 04:10:48 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
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
Subject: [RESEND PATCH v5 5/7] mtd: m25p80: add support of octal mode I/O
 transfer
Thread-Topic: [RESEND PATCH v5 5/7] mtd: m25p80: add support of octal mode I/O
 transfer
Thread-Index: AQHUkD5UftDKlfWJEUCGwj0wjo/Y/w==
Date:   Mon, 10 Dec 2018 04:10:48 +0000
Message-ID: <1544414934-5286-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3999;6:EGoNTgEjN0Ka7q7QU/OISkH/UUHd+ne3DtCV+dxG8dBKXN2uTWeIUolFm5CFFiKmszOa20XWaAVfZQEVTzdXVvBLmXjOEATTGzprsMA1BYrdKrQGKEmAraAyL3HmLS2rzesAOtsexZLcauY5/YeZXaM57wcSRIl1dZM3qi8m47IqBLMpLNuwakS6kiEUoAzv7X8he0RT673BjGKkobI8dtUPdvm21AeNG6mgnqOsyDc2ABGy9Qa48xNZlqueJ1VwSljBE7YEYKga7l2tpE2ych/1IH5COAyDQcU77fFwgvqg5Ni8R39Q6KdkFkKhsfezfNJj74y4bdsMTRD4CMigrm1ZxCKPP6oEth4M321fYwau7EuOi1h0zpgJmw5bz7kiz+IK5958Ua3tG4V9IFPaUGjYjMi8jHO+VcxkGZA/3hZHzYU0tnScuZVgYT3/Yp8jfIStJCUmhgTjqH9NByb69w==;5:UUvIPkMYw0UU7MwSkz/4a1JMyu0KWJp18aoNTjznG08guxbVno6n/fR7oRYFpMJrxgUbHBTUhOps9HQ52Kdu//jPYWO5exNYTtyZZOfRY+Z/4GvVhK10PZSkeqkc4nzk1I61P2r1ATmdgEENG6XBxb4X5ajJh9SgSedz/5E/5gc=;7:37gG0swd4izt+B7NA87TOlU8UL0Qs+Y3scYCrnbkeAXYsbvdwU1vXGHesIJN/NmhpsR+eDDYi+ai67G5xvOc0YIDXhs8pI+m99R2gIjkOVWg5r3OkUlujcPVXUel9PSHnxD3qrbb0vXdmdPtowJ+JQ==
x-ms-office365-filtering-correlation-id: 365f6573-4850-48b3-8a0e-08d65e5576b6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3999;
x-ms-traffictypediagnostic: VI1PR04MB3999:
x-microsoft-antispam-prvs: <VI1PR04MB3999D3A32B69EBD6AFA3FFD399A50@VI1PR04MB3999.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3999;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3999;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(366004)(376002)(396003)(189003)(199004)(6512007)(53936002)(386003)(6506007)(186003)(26005)(86362001)(2201001)(102836004)(7416002)(7736002)(55236004)(68736007)(305945005)(81156014)(81166006)(6486002)(8676002)(8936002)(6436002)(66066001)(52116002)(106356001)(105586002)(36756003)(99286004)(2906002)(478600001)(217873002)(6116002)(256004)(14444005)(97736004)(3846002)(78486014)(2501003)(54906003)(110136005)(25786009)(5660300001)(316002)(71200400001)(39060400002)(14454004)(71190400001)(486006)(476003)(2616005)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3999;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2NtFhZOu30nL/d8ve/sOKyBPsvmMBCPEscjWRR09sYQwCUQWGeL8MZh6okkFlFRBPyYJTtURy4AyK08j9OdNaTVYU7ohOjec0NY14BL8g2eHuEL3Sx/3q7md0I+RFdSdGIcN2Cm4RHWlVbuIIpSjaPxKJOPzZzkTermTfgqnNHLQjJ6Iojo7ZOD02NCwub84GamzIRSFabD0FGN/xQHYfOYmw0xWYrzVxg7+KTMJdGVdtlkhymwoW6XVcQTkkrwpmeZ4P8eKs/LEY5wz/T8Z2PfWRhDAfUh9pgEPZH3P0H7e2YIh4tUFdKcmfJMomdmO
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365f6573-4850-48b3-8a0e-08d65e5576b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 04:10:48.3434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3999
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for octal mode I/O data transfer based on the controller (spi)
mode.
Assign hw-capability mask bits for octal transfer.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
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

