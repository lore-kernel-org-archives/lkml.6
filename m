Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23038C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED572087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wE3x32am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfAGHrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:47:55 -0500
Received: from mail-eopbgr50060.outbound.protection.outlook.com ([40.107.5.60]:27839
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726619AbfAGHrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PlCfiwqY2mjgDuCCddlo4NggNws7odbglC3IU+bzuM=;
 b=wE3x32amwizZiuIOohgMPijq3f3foVqRyD8hKNPI1i2FkeXOCJm5b04v4ZgeRZrlDiu+RnHsU1Uk0P13QvzDvFDLIsrd5K5jXJ/if9meBtKy1PUN6OsSxDsN5wqGQirTl1YASPrv85OoPHvk6UqScKwbU9BcDNgO5dkuoj06TkY=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB5831.eurprd04.prod.outlook.com (20.179.2.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 07:47:45 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::7c57:c2f3:1681:3fc4]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::7c57:c2f3:1681:3fc4%6]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 07:47:45 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 6/8] spi: lpspi: add the error info of transfer speed setting
Thread-Topic: [PATCH 6/8] spi: lpspi: add the error info of transfer speed
 setting
Thread-Index: AQHUpl1H2XfwqJFp00uhQnIkxOABiQ==
Date:   Mon, 7 Jan 2019 07:47:45 +0000
Message-ID: <20190107074639.6336-7-xiaoning.wang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5831;6:021Oro4UxHyIsrqKy1mgvg4wr//NAvNqY8BMaQtRvXoTCUvzHSeeu2ZhqZcRvXggx6aOsNyfuRxo3BnQXT5kpPH/H+Qq9zth+Dd5e5C0a+LmkXvyvxBDxJq5oA2yMUVcy7tNgB1otjfPGopGuRjwrPQK0Rwgt5arviQKzV1HTQvXcNhc9s7CTRa52QUcQGKNK7l0mL2PCT3C+7//+OdCI7UNiteeIvwnGqXYTgPJQNqkSWFjZ0yqZNb83/n6wn9oUHOalQpcqbEa9qNj4iLQBezYEOqtz7+7P7XhfTyRi+18E8gZInXjryoUiDc26neLT2Zx+M5k/WADu573CsF6wKbx7gsCagzRej7n8neTQfYV7LHxq490nudy/EuZLKeGnXc9fulWhoy8ISCvNaLKsX9Jvp2aT/TjB9Dy4H9eIOEDz7+U9f6MLJU+uoEmZQpW0NC7ojxwFJX8oTJvo0mxqA==;5:MfjdlUgeXE2MyJihdI3dY8625925IZw6uY25wm7aqfkPSis6Xnfim3Zt+BLsxqF8eZT61cM8LbZdLOmlZgxwcr+gph+dEP2OZlPzMFFkZB5s4cQKdPaQgezbWmf/vyePtd7PhOAV2ni2XCnJqSkA/qjYEFUtY94E7sP8et3dmRKFnaHBxWXeHpCKiIESKwOube5BzeDK6Js9QQwcssd++A==;7:YQZeIITVcJYLMPKr8eRhWhXJgP0/NcmYmi5+pn1O08RBXVOS2ya69c0hbqkgqWBvgMUZRXC41iQtnVGDZerr9P8dCzG7MqfLnyUYda1E46BbjQaM7U+Ad8MAFjs1qeAe9fMk7MhQECfijcVIQycK4w==
x-ms-office365-filtering-correlation-id: 18db8f6f-18f1-47b3-56d1-08d674746961
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5831;
x-ms-traffictypediagnostic: AM6PR04MB5831:
x-microsoft-antispam-prvs: <AM6PR04MB58316B3A7453079F48606547F3890@AM6PR04MB5831.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5831;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5831;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(366004)(346002)(199004)(189003)(256004)(8676002)(6436002)(97736004)(5640700003)(54906003)(6486002)(68736007)(316002)(6916009)(575784001)(86362001)(2351001)(105586002)(99286004)(66066001)(186003)(26005)(81166006)(2501003)(476003)(8936002)(446003)(36756003)(11346002)(50226002)(2616005)(7736002)(81156014)(106356001)(1730700003)(52116002)(305945005)(76176011)(6116002)(3846002)(102836004)(2906002)(386003)(6506007)(4326008)(1076003)(25786009)(71190400001)(71200400001)(14454004)(486006)(6512007)(478600001)(5660300001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5831;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MfGUsEj1BjD3eZCyeXBf5dVC7yu1vkQs01ZYJAbyzrRuCBKI5fadN9jlDH5woAA/2cwlDj/2lymcspqd6mjy6cOwYp9SbNF328DqaTLtR+KfDmicyNp7xK1EUVqEKyOns8+/kDkST5ts2OwuhFdOoFJvNgPTzHl5oaiaQ7S5reW21jUBmLaBGL84lP+Y4IaqlIKQSgpToM7AznBNDONgESbVcCt9GL2a43/P3hyJQq1O154JDgtKj/z0ze3Vd8mwtzdGjMGT7t9zShsO+NR5KrBoKla57Zfj1FeO/VBKCpNA/X4NkiSsyy6p7Ztus1eG
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18db8f6f-18f1-47b3-56d1-08d674746961
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 07:47:43.6358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5831
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a error info when set a speed which greater than half of per-clk of
spi module.

The minimum SCK period is 2 cycles(CCR[SCKDIV]). So the maximum transfer
speed is half of spi per-clk.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 84dcb9e176b8..69635cde0e22 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -255,6 +255,13 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data=
 *fsl_lpspi)
 	u8 prescale;
=20
 	perclk_rate =3D clk_get_rate(fsl_lpspi->clk_per);
+
+	if (config.speed_hz > perclk_rate / 2) {
+		dev_err(fsl_lpspi->dev,
+		      "per-clk should be at least two times of transfer speed");
+		return -EINVAL;
+	}
+
 	for (prescale =3D 0; prescale < 8; prescale++) {
 		scldiv =3D perclk_rate /
 			 (clkdivs[prescale] * config.speed_hz) - 2;
@@ -304,7 +311,7 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_=
lpspi)
 	return 0;
 }
=20
-static void fsl_lpspi_setup_transfer(struct spi_device *spi,
+static int fsl_lpspi_setup_transfer(struct spi_device *spi,
 				     struct spi_transfer *t)
 {
 	struct fsl_lpspi_data *fsl_lpspi =3D
@@ -337,7 +344,7 @@ static void fsl_lpspi_setup_transfer(struct spi_device =
*spi,
 	else
 		fsl_lpspi->watermark =3D fsl_lpspi->txfifosize;
=20
-	fsl_lpspi_config(fsl_lpspi);
+	return fsl_lpspi_config(fsl_lpspi);
 }
=20
 static int fsl_lpspi_slave_abort(struct spi_controller *controller)
@@ -429,7 +436,10 @@ static int fsl_lpspi_transfer_one_msg(struct spi_contr=
oller *controller,
 	msg->actual_length =3D 0;
=20
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		fsl_lpspi_setup_transfer(spi, xfer);
+		ret =3D fsl_lpspi_setup_transfer(spi, xfer);
+		if (ret < 0)
+			goto complete;
+
 		fsl_lpspi_set_cmd(fsl_lpspi, is_first_xfer);
=20
 		is_first_xfer =3D false;
--=20
2.17.1

