Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA998C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F54A20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DqW6ASRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfAOKFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:05:36 -0500
Received: from mail-eopbgr130044.outbound.protection.outlook.com ([40.107.13.44]:51840
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728408AbfAOKFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ktx1GRcHi1eYSge/SiHdvLAqiZpoEsriXHWfa3f58Mw=;
 b=DqW6ASRd74gV6eTHyQqLOiNzogWLVcw6FSf+LKyROhHEcOiNoUt4/3PP9La3YyrldP4Q4gfvsJUX5ssUZZlHFz0getWTCIv0E5mlYLeydIpgjYdCxb0XP/dsl8X9NsIXNi6zODRYaZlBjprpybNOe9g3vr5rvPywY1fxjM7tw9A=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5822.eurprd04.prod.outlook.com (20.178.204.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Tue, 15 Jan 2019 10:05:29 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 10:05:29 +0000
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
Subject: [PATCH v7 4/5] spi: nxp-fspi: add octal mode flag bit for octal
 support
Thread-Topic: [PATCH v7 4/5] spi: nxp-fspi: add octal mode flag bit for octal
 support
Thread-Index: AQHUrLnXO6XkhNwsbkOmcWHevEJc4A==
Date:   Tue, 15 Jan 2019 10:05:29 +0000
Message-ID: <1547546584-5254-5-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0123.apcprd06.prod.outlook.com
 (2603:1096:1:1d::25) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5822;6:0q1+Zvgcx8BLycQTLx8u8om9fFK6Ocmqh2G07b+cKcmKgywS65jADKvtKB8UxylmLBwfm2AvJDikf0aCFqDPG6szZ0eIwwQQR7UQeZpjSGtUkQew2uM512p4c9vNH7P4LRaW+Qzy7V+pl61gBZqZZnhY82PPRJuLj+waiSsvag3Ktr2URfqZ6y3fD0fbWvffmmqohye22sbm4BXmLM/S2Wf0EKEsZK7wNoiA/AsIndQttvCCwmyh+aKo/jC9Caa2gZ0iblnYxsZhB4GZbBzywnPACwDnXL1reWaurfQHUNxq8HKWr471UmbALP4e/9sftsenE2UzImHdw+USVxNz0RxpjGMGdGox8zVxkOWCjdBAQX/kBgapskYsuIn61V4eWz4cCMeOgFIoWfYeZ57diT2AjQArfL6DbMNisfA/jKEPB7rFC222NBCngW32dBmj9IZbTVcb6oAYyjgnfd4qfQ==;5:AkITVbbdEvUYQ7aX3In8IEF++wW7+OSZ06OE4rjcbrGcD0MAPyZK+s8WeZ1gklV6xYdrZi5FFxqKzv2bJWK2yzdsco9kIf7/85c5kFUOvIoppzaz1I8tUdo8AM4ytxQGSFYNszCBPoWO/xnP7cyNNBrqIrvBfeIscywDp2aocXFZUa1Fe4CfCffDe/RLL1wvIhngjkZHp3ViRxCoV/95jw==;7:M02TcNhv6qLLM5m8agZii6CV+0lmjQ9hN53OEZMbRZ69z8xAoV89RQeDAqYPFk4p0UKkU4sZ08FuRgbuop7Agt3YtbIo42xX4fEoyJTbrnN84/h4Kn+pLsxDvj/klgFTQX+PFadETFtRGeK88Oj9tw==
x-ms-office365-filtering-correlation-id: 3bc83343-de8f-4a30-52ae-08d67ad0fa2a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5822;
x-ms-traffictypediagnostic: VI1PR04MB5822:
x-microsoft-antispam-prvs: <VI1PR04MB58224F0DED219913A8949A9099810@VI1PR04MB5822.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39860400002)(136003)(376002)(189003)(199004)(36756003)(305945005)(14454004)(6512007)(81166006)(486006)(446003)(2201001)(81156014)(2501003)(4326008)(105586002)(8936002)(386003)(7736002)(86362001)(102836004)(2616005)(26005)(186003)(6506007)(54906003)(50226002)(97736004)(316002)(5660300001)(110136005)(2906002)(6116002)(8676002)(256004)(71190400001)(6486002)(7416002)(66066001)(3846002)(99286004)(6436002)(106356001)(478600001)(76176011)(55236004)(71200400001)(78486014)(11346002)(39060400002)(53936002)(52116002)(68736007)(476003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5822;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EATlUiWocJvqTUr2CzcKne6iyIcSipjF/4J/6wdjf6jF/5LWcenAWLgUe0rT/gE9NDkucgP0PlN3EPUWSZhvnn++LR9B2V90Nz8npplMqMyEgERGkgjvdhEtXOnWrplp8KM1IZloIVkuP/90YBljrV/UCHOS8Zw7Qi96gar30YRptHL622Gb6Xxb8218AW82ORKyeRqPIzFK/TXfaPOwC615URgRELYtxS/9GBFumHHDo8sqHe8NrBALiN9csAYvBvidoZf2Eb5OO4CP/6V5YjHyA66BxTLNhIXuJ7DgNJxSBIPIYl/3n5Fv4AwyB8EYhLCyQxupALQaEty1PV0P1aSbPhQCvS6B5m2tsS2yAw8gkiKjTcO3ihSnCeFP9pIfzVCvHE+jptmIehjFLkshifvzOMQjsugk7XB4d/neZpg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc83343-de8f-4a30-52ae-08d67ad0fa2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 10:05:23.3366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add octal mode flags for octal I/O data transfer support.
NXP FlexSPI controller supports 8 lines Rx/Tx data transfer.

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index e23ad9ef028e..adc3c0e14f38 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -952,8 +952,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	if (!ctlr)
 		return -ENOMEM;
=20
-	ctlr->mode_bits =3D SPI_RX_DUAL | SPI_RX_QUAD |
-			  SPI_TX_DUAL | SPI_TX_QUAD;
+	ctlr->mode_bits =3D SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL |
+			  SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL;
=20
 	f =3D spi_controller_get_devdata(ctlr);
 	f->dev =3D dev;
--=20
2.17.1

