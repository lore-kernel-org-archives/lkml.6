Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDB2C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E822220821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="3W4TnFRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfBERdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:33:42 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:36250 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbfBERdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:33:36 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="27308229"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Feb 2019 10:33:35 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Feb 2019 10:33:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmIVqyhHBWdy7c6OdpYPwojel4/8XGfRyij7OI6jUPM=;
 b=3W4TnFRqhWU8udWqJDbaR2h/eRkWjCAgUqS5bOsgtrvKPgUZ1jOSRtSmKAFQAU3SFIR+cHmaVtoXwVjLQwvLXHknzwXryQtg0kY+73/Ou3wKFa1A1qRLka5R8w7J1OkDDyRiKZ3C1WifTuO8Mvb8XeRrtm9v0wuBra9UPZZHSn8=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1681.namprd11.prod.outlook.com (10.173.26.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Tue, 5 Feb 2019 17:33:33 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 17:33:33 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v6 11/13] spi: atmel-quadspi: add support for named peripheral
 clock
Thread-Topic: [PATCH v6 11/13] spi: atmel-quadspi: add support for named
 peripheral clock
Thread-Index: AQHUvXjqJ3E9SQTUFkazPzVgYVrsSQ==
Date:   Tue, 5 Feb 2019 17:33:33 +0000
Message-ID: <20190205173254.16388-12-tudor.ambarus@microchip.com>
References: <20190205173254.16388-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190205173254.16388-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0128.eurprd07.prod.outlook.com
 (2603:10a6:802:16::15) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1681;6:ob4WjecegswXDMuGwuGzKtDUjZ/UfIPL2TTc1SDv5VS4gAG8QIC9nXcd3j2urnzGOOQdaxqUZdL1/e2l3BS6Wj+xqrt/xOS/uXNJIQ1ARtVS/BT/95hedyl0mgUE3KFuqdntpM9IbeLWTzq3CchKLnSiJPBljlFuN61woqE+9Hj2N7UcvMEbCJdx0Az28s5x4yX+RIRCcXpxqzwMtHF66uFZuFqXBUJUrdxt1jhZ7dV7VaOBMsPIQuqkTIUM1x1FkolipcdNdIrvV4NLNUABei06MDYymAZPqmHcfpJtxA5Wqa2AvosfZinvUrQbUpkyOPJYMM1+bGwftEv+NH1OGvFnxJXnivfnP6Up7UvQ8B4ISAcyx1dKA5+X4FaLJjCqvOLkcvywJCzSN/0/YvwcJ6j/nLMUrl/LtAtSxRRGDoKSeRGYCtItwg4NKsnsWx0oO77ZQuQTKbKM6QC4Iz/cOA==;5:hyHc1zAhgVu13Q9eaHqbqdqDv8yzQMLP4RYvjvXnwOG8GSPsj+XKgRHkBNS3nlbDIkkxfa8wL1m8bMDkAfe08r7XWKWrrFkHilwLhErNcHFsiEAHQQK0bsF0HkeS9swXNpP3zO9J+0j9HoaTO71h637VV9oHuqJVIzUcNIjSHbL5ZH+S1vbeqoctpm6Yds9h9zPTXoV5dGJMEWanu5+Qqw==;7:8VazuvPvI1TNePBZ4F9gqillH4xywGGp47h3wCWVkcCB81Kku9JwByH26opSN0ktusrY/oXTSGEbKdCDUAtav1THLauYFT9082QI16BLRyAAzy8/Z94iY134naMJcN6B/YrJc3kiNGNu57E2JUtVKQ==
x-ms-office365-filtering-correlation-id: 74fc2498-71f9-426f-f887-08d68b900d21
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1681;
x-ms-traffictypediagnostic: BN6PR11MB1681:
x-microsoft-antispam-prvs: <BN6PR11MB1681D61BC64D98D865BFEEB5F06E0@BN6PR11MB1681.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(376002)(366004)(189003)(199004)(4326008)(186003)(1076003)(36756003)(26005)(110136005)(25786009)(6512007)(316002)(476003)(11346002)(7416002)(54906003)(486006)(2616005)(446003)(86362001)(6486002)(6436002)(66066001)(478600001)(71200400001)(7736002)(97736004)(14454004)(71190400001)(76176011)(14444005)(256004)(52116002)(3846002)(2501003)(305945005)(99286004)(6116002)(53936002)(72206003)(386003)(107886003)(8936002)(106356001)(81156014)(81166006)(105586002)(102836004)(50226002)(68736007)(6506007)(2906002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1681;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SOQNVigxNgRMEWkYOUBobYXbN+aSDuBVYtpv7LHv6KojgGkGI3wimrG66Ly6Bs9OBNjINOzs47LfWR14xCcQtDM2vNw6oEgb5iuzeQHhNSRNCq5AFSVgbkWmD6Xg1EwZLoCUPPGOqjb/+215lrc51MswBO5GhRQNx2bsfgZ+56iVLo7yrCVz9EF+V4zGfG1175vc61ZAgsEqbAyc4l5eHpQAAhZyHBHKLcsy8LJqZNmGs+L8yGf/o83PaosfYXRkVemZm1r7uuxHmEc8Sv3l2T43IL4UTFsD/Iz/9BvSH7xclErtPQ8/xKDMltwXLqtNHegEQxXZANAFEax4jrTmp8h5RGsChsvh9FrVpxYTVfkEwAPs9ZnkJu/eFbCJHHmYS80lBPa2Ajdk27Z8egR9p0wWGZFmnEenxz+MmpBOBKU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fc2498-71f9-426f-f887-08d68b900d21
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 17:33:30.9526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1681
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Naming clocks is a good practice. Keep supporting unnamed
peripheral clock, to be backward compatible with old DTs.
While here, rename clk to pclk, to indicate that it is a
peripheral clock.

Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v6: no change
v5: no change
v4: collect R-b
v3: new patch

 drivers/spi/atmel-quadspi.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 19a3980775ad..336501d962e5 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -137,7 +137,7 @@
 struct atmel_qspi {
 	void __iomem		*regs;
 	void __iomem		*mem;
-	struct clk		*clk;
+	struct clk		*pclk;
 	struct platform_device	*pdev;
 	u32			pending;
 	u32			mr;
@@ -341,7 +341,7 @@ static int atmel_qspi_setup(struct spi_device *spi)
 	if (!spi->max_speed_hz)
 		return -EINVAL;
=20
-	src_rate =3D clk_get_rate(aq->clk);
+	src_rate =3D clk_get_rate(aq->pclk);
 	if (!src_rate)
 		return -EINVAL;
=20
@@ -433,15 +433,18 @@ static int atmel_qspi_probe(struct platform_device *p=
dev)
 	}
=20
 	/* Get the peripheral clock */
-	aq->clk =3D devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(aq->clk)) {
+	aq->pclk =3D devm_clk_get(&pdev->dev, "pclk");
+	if (IS_ERR(aq->pclk))
+		aq->pclk =3D devm_clk_get(&pdev->dev, NULL);
+
+	if (IS_ERR(aq->pclk)) {
 		dev_err(&pdev->dev, "missing peripheral clock\n");
-		err =3D PTR_ERR(aq->clk);
+		err =3D PTR_ERR(aq->pclk);
 		goto exit;
 	}
=20
 	/* Enable the peripheral clock */
-	err =3D clk_prepare_enable(aq->clk);
+	err =3D clk_prepare_enable(aq->pclk);
 	if (err) {
 		dev_err(&pdev->dev, "failed to enable the peripheral clock\n");
 		goto exit;
@@ -452,25 +455,25 @@ static int atmel_qspi_probe(struct platform_device *p=
dev)
 	if (irq < 0) {
 		dev_err(&pdev->dev, "missing IRQ\n");
 		err =3D irq;
-		goto disable_clk;
+		goto disable_pclk;
 	}
 	err =3D devm_request_irq(&pdev->dev, irq, atmel_qspi_interrupt,
 			       0, dev_name(&pdev->dev), aq);
 	if (err)
-		goto disable_clk;
+		goto disable_pclk;
=20
 	err =3D atmel_qspi_init(aq);
 	if (err)
-		goto disable_clk;
+		goto disable_pclk;
=20
 	err =3D spi_register_controller(ctrl);
 	if (err)
-		goto disable_clk;
+		goto disable_pclk;
=20
 	return 0;
=20
-disable_clk:
-	clk_disable_unprepare(aq->clk);
+disable_pclk:
+	clk_disable_unprepare(aq->pclk);
 exit:
 	spi_controller_put(ctrl);
=20
@@ -484,7 +487,7 @@ static int atmel_qspi_remove(struct platform_device *pd=
ev)
=20
 	spi_unregister_controller(ctrl);
 	writel_relaxed(QSPI_CR_QSPIDIS, aq->regs + QSPI_CR);
-	clk_disable_unprepare(aq->clk);
+	clk_disable_unprepare(aq->pclk);
 	return 0;
 }
=20
@@ -492,7 +495,7 @@ static int __maybe_unused atmel_qspi_suspend(struct dev=
ice *dev)
 {
 	struct atmel_qspi *aq =3D dev_get_drvdata(dev);
=20
-	clk_disable_unprepare(aq->clk);
+	clk_disable_unprepare(aq->pclk);
=20
 	return 0;
 }
@@ -501,7 +504,7 @@ static int __maybe_unused atmel_qspi_resume(struct devi=
ce *dev)
 {
 	struct atmel_qspi *aq =3D dev_get_drvdata(dev);
=20
-	clk_prepare_enable(aq->clk);
+	clk_prepare_enable(aq->pclk);
=20
 	return atmel_qspi_init(aq);
 }
--=20
2.9.5

