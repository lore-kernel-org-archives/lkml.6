Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6510C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6515D2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gKFXh/4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6515D2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbeLDFdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 00:33:44 -0500
Received: from mail-eopbgr70059.outbound.protection.outlook.com ([40.107.7.59]:20064
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbeLDFdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 00:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QacU72vCn6ShOE66bxN3DjECT7lbxrX6oNSAptS4ong=;
 b=gKFXh/4AiaRmRntaW2MEys+R0IfcV/yHCfWPJD103baT9n0dKPWylqpnYGQLC0oSwZIWdxHmoN7UguGo+KExy7bHho3P1J2qGi7qFo+fHD9SssD3XEvrTl1h3IALQr8uLhZBF844qzV85pNwxmt8ytfygQDyh+JCHQpkyuCpPXg=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4231.eurprd04.prod.outlook.com (52.135.168.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Tue, 4 Dec 2018 05:33:38 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3%5]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 05:33:38 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH] spi: lpspi: Add i.MX8 boards support for lpspi
Thread-Topic: [PATCH] spi: lpspi: Add i.MX8 boards support for lpspi
Thread-Index: AQHUi5LoGOvlM9BavUq7dLoa4LCo5A==
Date:   Tue, 4 Dec 2018 05:33:38 +0000
Message-ID: <20181204053247.27022-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:4:54::32) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4231;6:2zcGyBD5RvdnmZz/XhWhrS84w2pwNMStXtPgsbySeQTe6IXStC/IWpG3Jn0DWdc7QsufidHTXwfgFjqZqbDqruRNiBJCpNHzXicY9off94NGBMR+jpofHPBEnW88udOtx+dszmOIYuv5np1/mJE6FZDCzw1PPl7uK9WFmV4hBPSkdA0/YLDOqZsBJUbLPvpWIUzL1lPLVQ5+hMedjD7nOg7q75crmn0t7SE44eiT42ZMkkmHqSnF9aUcQj3yz4k4jLxJjZI9hQgqEsAh4kobzqKkL4TM4IYEowhhb4QIs1BtZgxkgUzKOffRExG67MBob38UQRcr0HM6YcCGr8RBfnbKIn1YTqBgmuVz7i+gx/K2N/XHLh9Jb0qtp/zhRVoR+iMueYLldkXsj+/GE7EFqEyfsHbqZ8giyovWAeqEJliJJllcjTjvIXReSHDT23Odk6Kk/on7lpv7NTlYh46yfg==;5:rvcmbxmYTowvbfIYX1aRP16LQHFQsvFGJdeTHiQYH9DMa/J3Xu5O2ibJoXdeAVsnnpeFdMFR677L/IWJtxMuZqjCrPUuGF0RLG7RMPp7zbrLbLloiWE20qI303wK6uFHWAHpTXNhBHL9G5syhmxvy5aMtoVmwDhb/iW/TIbHJUc=;7:EiLClc4M9q5Pp4P73rZogmiyyZGKpF7siwvtxW1CcvuyWNXOpe6qEGe4HJ3Sn2oV3ogZBOVCoaThOt387Fn+C08NKBJkpRiVcdqHvkajfV4TegDvYr96uZ9NgaVgtVgNRFfx2JyDEBfBZkaAESZBbA==
x-ms-office365-filtering-correlation-id: 1ac97fa7-7ff8-477c-3450-08d659aa0b09
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4231;
x-ms-traffictypediagnostic: AM6PR04MB4231:
x-microsoft-antispam-prvs: <AM6PR04MB4231787CEA6A07F7BE47DEECF3AF0@AM6PR04MB4231.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4231;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4231;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(366004)(376002)(346002)(189003)(199004)(53936002)(2616005)(476003)(25786009)(386003)(6512007)(2906002)(6506007)(2351001)(102836004)(5640700003)(68736007)(486006)(52116002)(106356001)(105586002)(4326008)(14454004)(7736002)(305945005)(8676002)(8936002)(81156014)(81166006)(6916009)(1730700003)(5660300001)(6486002)(186003)(6436002)(26005)(36756003)(575784001)(6116002)(66066001)(3846002)(97736004)(86362001)(99286004)(71190400001)(71200400001)(2501003)(256004)(1076002)(478600001)(316002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4231;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6jGPEZNz4ayfbqAsRplTpT0M74rbMcos2ZZmiaSc2d54Rj+0qikkKQr5K0+a81XJLCb9mgFuZQMH3J/4TxbCJvbRYEuJ4s1mgFZW/KF32YRUn8caZV3vcbRpIKnsV9zLQa3ChMIQXwHD3SX7OuLQ+5GeYL03DPKjKzw/YEOrEmmqGTcZGg6IDjAbeDw2vzLD5Hm+j5JRQbt8qhaj0kMcle0Uc/4pUdy5QHIK5DlLy3EWXFhxL363n1XfyTp2IlokmSJ7ILPAELqoIHhzlXuhaMsZDLrHK80VvyWmR3tGAEdAM/0n0DF/1qeakRnoJTJf8+cjxPshulM/HIsypq+Xp+UEWnDYZ/Jq+frEm29jrY8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac97fa7-7ff8-477c-3450-08d659aa0b09
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 05:33:38.8391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add both ipg and per clock for lpspi to support i.MX8QM/QXP boards.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 52 +++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 08dcc3c22e88..5802f188051b 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -80,7 +80,8 @@ struct lpspi_config {
 struct fsl_lpspi_data {
 	struct device *dev;
 	void __iomem *base;
-	struct clk *clk;
+	struct clk *clk_ipg;
+	struct clk *clk_per;
 	bool is_slave;
=20
 	void *rx_buf;
@@ -147,8 +148,19 @@ static int lpspi_prepare_xfer_hardware(struct spi_cont=
roller *controller)
 {
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(controller);
+	int ret;
+
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_ipg);
+	if (ret)
+		return ret;
+
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_per);
+	if (ret) {
+		clk_disable_unprepare(fsl_lpspi->clk_ipg);
+		return ret;
+	}
=20
-	return clk_prepare_enable(fsl_lpspi->clk);
+	return 0;
 }
=20
 static int lpspi_unprepare_xfer_hardware(struct spi_controller *controller=
)
@@ -156,7 +168,8 @@ static int lpspi_unprepare_xfer_hardware(struct spi_con=
troller *controller)
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(controller);
=20
-	clk_disable_unprepare(fsl_lpspi->clk);
+	clk_disable_unprepare(fsl_lpspi->clk_ipg);
+	clk_disable_unprepare(fsl_lpspi->clk_per);
=20
 	return 0;
 }
@@ -249,7 +262,7 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data =
*fsl_lpspi)
 	unsigned int perclk_rate, scldiv;
 	u8 prescale;
=20
-	perclk_rate =3D clk_get_rate(fsl_lpspi->clk);
+	perclk_rate =3D clk_get_rate(fsl_lpspi->clk_per);
 	for (prescale =3D 0; prescale < 8; prescale++) {
 		scldiv =3D perclk_rate /
 			 (clkdivs[prescale] * config.speed_hz) - 2;
@@ -522,15 +535,30 @@ static int fsl_lpspi_probe(struct platform_device *pd=
ev)
 		goto out_controller_put;
 	}
=20
-	fsl_lpspi->clk =3D devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(fsl_lpspi->clk)) {
-		ret =3D PTR_ERR(fsl_lpspi->clk);
+	fsl_lpspi->clk_per =3D devm_clk_get(&pdev->dev, "per");
+	if (IS_ERR(fsl_lpspi->clk_per)) {
+		ret =3D PTR_ERR(fsl_lpspi->clk_per);
+		goto out_controller_put;
+	}
+
+	fsl_lpspi->clk_ipg =3D devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(fsl_lpspi->clk_ipg)) {
+		ret =3D PTR_ERR(fsl_lpspi->clk_ipg);
+		goto out_controller_put;
+	}
+
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_ipg);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"can't enable lpspi ipg clock, ret=3D%d\n", ret);
 		goto out_controller_put;
 	}
=20
-	ret =3D clk_prepare_enable(fsl_lpspi->clk);
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_per);
 	if (ret) {
-		dev_err(&pdev->dev, "can't enable lpspi clock, ret=3D%d\n", ret);
+		dev_err(&pdev->dev,
+			"can't enable lpspi per clock, ret=3D%d\n", ret);
+		clk_disable_unprepare(fsl_lpspi->clk_ipg);
 		goto out_controller_put;
 	}
=20
@@ -538,7 +566,8 @@ static int fsl_lpspi_probe(struct platform_device *pdev=
)
 	fsl_lpspi->txfifosize =3D 1 << (temp & 0x0f);
 	fsl_lpspi->rxfifosize =3D 1 << ((temp >> 8) & 0x0f);
=20
-	clk_disable_unprepare(fsl_lpspi->clk);
+	clk_disable_unprepare(fsl_lpspi->clk_per);
+	clk_disable_unprepare(fsl_lpspi->clk_ipg);
=20
 	ret =3D devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
@@ -560,7 +589,8 @@ static int fsl_lpspi_remove(struct platform_device *pde=
v)
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(controller);
=20
-	clk_disable_unprepare(fsl_lpspi->clk);
+	clk_disable_unprepare(fsl_lpspi->clk_per);
+	clk_disable_unprepare(fsl_lpspi->clk_ipg);
=20
 	return 0;
 }
--=20
2.17.1

