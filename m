Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84787C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485D9204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ibeM0I+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfAGHrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:47:40 -0500
Received: from mail-eopbgr10075.outbound.protection.outlook.com ([40.107.1.75]:33397
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726495AbfAGHrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QacU72vCn6ShOE66bxN3DjECT7lbxrX6oNSAptS4ong=;
 b=ibeM0I+ERy1wPXTGEGLiALTv/iuTEimiZwfd7ws2bEWjEl5k4jREhGYXG5G1ej2o1bBw+IA+NZo4VW1HobYb2UajyvUEO2TS606ot+3HbB2fDjouYupO4dGPiDXnCDTzWWeShvkJ0TJqEMpDwbVSeDUhDMBpg70hHlvOFoQahPE=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB5333.eurprd04.prod.outlook.com (52.135.169.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 07:47:34 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::7c57:c2f3:1681:3fc4]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::7c57:c2f3:1681:3fc4%6]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 07:47:34 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 1/8] spi: lpspi: Add i.MX8 boards support for lpspi
Thread-Topic: [PATCH 1/8] spi: lpspi: Add i.MX8 boards support for lpspi
Thread-Index: AQHUpl1ABVcA3+uvmkWuri05SPedqQ==
Date:   Mon, 7 Jan 2019 07:47:34 +0000
Message-ID: <20190107074639.6336-2-xiaoning.wang@nxp.com>
References: <20190107074639.6336-1-xiaoning.wang@nxp.com>
In-Reply-To: <20190107074639.6336-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0087.apcprd02.prod.outlook.com
 (2603:1096:4:90::27) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5333;6:T3CH7ygZJh6GnMJMwv9jGlr8RoSSPC1E+t9DTThCq7ov8sK+ugYDeWIHQ57m0x9jdFP0xJYWer4nNQQkYsN4sk2UWbltqyDOLL612rezMAlGbPJ9AnyRe3RHGTtfRjbD4KDFM2zJyqI7gdEKOxzkuc2a7AUEI0fO24sW9RG1HEInPUWBakKdMNR7+L3yFvOJZnfBQS1J0rrGJ5AWNgiPlSUatbm6ydW1bYoAm6uN8xKy00fTU1wwK1f6VgsTgv7APholuZPl3T9OYx7Zy3ZEctQBrwlMsYP+gRgZbe0Xr5berUxIPRq/wXzDN3NVMHQZaSPUdcS0cV+JCIRSzMLRSw0wBJHl9oB5CbZjkO54Nhh0fqTqQkroor3YQUQAD/BEIzY3hQwr1Zm0R+CZMfoOanXVyE/fQ2XuZuKuhhbtA2Q6SrgUwvZQzVA7gpxcr/lamRgSULmioTY+MTdgNbLeFA==;5:3tJlD9HK7FxA6pkyCcMOkwQWX8i6cUYChbMMU61LYM5sEplzBQUUGmjvRPxliVDdzdP+EypdLP6P70p+PgsFpqD18hZ0w2IGVGGIlVhqUhD3qrpaVM1jwbQkJMerlonOoPs+C12JePEw77V0LFW/dJIQxYeVhh9BVFzz8honPtfcE6duK55IBz33VLfQCKIdcwnJx/VaBP6dOAUucNrtfw==;7:LCx5vrSYwOhGW0zS/xfWOJTBQojxAi3k0fZHsBoc42cYV0mru/AR/Sngq7yIg80Ml/tW0C4KaxWdi9IMuTNXI+5FV8MiYhecvgh23lEnxFqmxdR5QOwD98YVVyRzPW6Ls1y36w80WlcroDROCMa/RQ==
x-ms-office365-filtering-correlation-id: fc2247f2-c52d-4504-0490-08d6747462c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5333;
x-ms-traffictypediagnostic: AM6PR04MB5333:
x-microsoft-antispam-prvs: <AM6PR04MB5333C7B38A6ADDA6190E9786F3890@AM6PR04MB5333.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5333;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5333;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(6116002)(3846002)(97736004)(76176011)(53936002)(6486002)(2501003)(1076003)(4326008)(68736007)(25786009)(66066001)(575784001)(86362001)(71190400001)(6916009)(6436002)(2906002)(256004)(5660300001)(186003)(99286004)(2616005)(486006)(446003)(478600001)(11346002)(305945005)(81156014)(476003)(7736002)(14454004)(71200400001)(5640700003)(81166006)(1730700003)(8676002)(8936002)(50226002)(6512007)(36756003)(2351001)(26005)(316002)(54906003)(386003)(6506007)(106356001)(105586002)(52116002)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5333;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fAHIXKnReT8y+/oi1DBQmSX1VkXnppKs86OAigWMUyASFv1H4eIdWBht9j6kSfvloWtlnZlLcWmyNVfRKkRF/DUwDjnp5eij5VXZTU5XzP9ZRQ+NSNXAU8BPvXDQj06SIKY7lwjYl4rKqAkp/9OQFOhR5qJbfILBTaSSNsBrlWSKMZvN8PzOlBiHeIscpY0RhlBT64wqGeMDd4fTCUVkGCJqjjkAzO/aqRbts834EtOeM4PdbusA4cc/VbMRhXMSRnFSVLqq64TtCTMlsBhdgBjS2qGZIpEPzFINZRHOaKxuYmgDv/TpnEj48SgypzKH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2247f2-c52d-4504-0490-08d6747462c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 07:47:32.5263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5333
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

