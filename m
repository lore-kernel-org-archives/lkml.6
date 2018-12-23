Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7E3C43444
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 06:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5039321903
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 06:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F1TvG2ZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeLWGMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 01:12:39 -0500
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:59283
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbeLWGMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 01:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AKiVi+/SR3wpH+azjYaokET+zcjBXquNlZVuvQJSe0=;
 b=F1TvG2ZWPbaB0iXUcFMKXZK8WURrMUOn/IRwPtG0MfzZKMGAFWMeHBlgsHQ1TQgqJdWv9kOZ0WOnwx9oWZdbEtY8vNL7VC0PqrHuWvCyBeR3H6I0IHJpzg9jks0ETNtA55ZErTvGm429g7WHJ2m2jj6r2zzLlv7ky9AsYyMACRA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3804.eurprd04.prod.outlook.com (52.134.73.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Sun, 23 Dec 2018 06:12:30 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97%5]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 06:12:30 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V6] iio: magnetometer: mag3110: add vdd/vddio regulator
 operation support
Thread-Topic: [PATCH V6] iio: magnetometer: mag3110: add vdd/vddio regulator
 operation support
Thread-Index: AQHUmoZ8ihE2Fil8TkuuElxHBF09WA==
Date:   Sun, 23 Dec 2018 06:12:30 +0000
Message-ID: <1545545266-6741-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0051.apcprd04.prod.outlook.com
 (2603:1096:202:14::19) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3804;6:dfcCANC+OudodIq7PKhoFt9o8g+iQb9oJ6bVJWeXD6CEPTsoKfSXsLcApO1wKTHmMCjoGynPJ//HDPYTI1GpjOIkC2As2Bb7Q6WY48T0tD+3RFsxS2GzEkd9Hysqee1OhLCRiMtOWVq7WNHmE9C/k2fqHHkNz/AR/8uGXrJEu/M/UW/ICGPg0GlH+KXraJUN7F65Vjt5dIgx9EEIttLOUNmxghTllnl1uW3xgxBKnrhisOOWlTNhsbwprFgNN2bWbl2YuMKEag0KifLE4Y3D9ioOwkvOTiNvQANP3yOZdX5dF1QC6/xRP36mhkCpulQIE7D9oUzAuc8/9P5YYGnDW5Hef9j+r4lXmgQsgsKDvgeGfvN5PfvzsIBj/QK5NOtf142VcUQhHzA9ziaFywQUW5dA/sB7EwwS+1CJhrO1ywmzn/AtVBQZprmfUc+vXjEfecyPa2WjpnPxeijon1t0vQ==;5:KE37gd0te0Mi3GupKT8U7WNPrWPORct2ltxP0cS5vwndB15V+LHdrgzQMOTw/oN4OiBqE7njaWFf55LMDw4YtwhY5JcPMBqmQO64w1y5gCmyXl7Pkxvf4X9S62BrvwrSqIImJFDQELcyoLYbHIhJfrPvmVI5R67uz3qt/9jKlC0=;7:SiKjQVGrlpRCxKugNukQPABBeDaERhnRYiDz7AtyIZBPJfgDpx1mzYfKckwvqZqUZS8WYerZNG3XH99NvAEYPVCalTtEUYhEcG99fHYlNwv341lGjlALLFEkDZrqCLpfEk4NGR5ctxtuZpJyp31Gfw==
x-ms-office365-filtering-correlation-id: 650c36ea-13ec-47f5-9251-08d6689d9e53
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3804;
x-ms-traffictypediagnostic: DB3PR0402MB3804:
x-microsoft-antispam-prvs: <DB3PR0402MB3804F73D690D7458797F47B0F5BA0@DB3PR0402MB3804.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3804;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3804;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(199004)(189003)(54534003)(50226002)(386003)(106356001)(102836004)(97736004)(105586002)(6506007)(5660300001)(52116002)(14454004)(66066001)(110136005)(316002)(71200400001)(53936002)(14444005)(2906002)(6486002)(186003)(86362001)(2201001)(36756003)(256004)(99286004)(71190400001)(2501003)(81166006)(81156014)(8676002)(476003)(25786009)(7736002)(3846002)(68736007)(8936002)(486006)(2616005)(305945005)(6116002)(478600001)(26005)(6512007)(4326008)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3804;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rC9C/8COQ6fSYepKb+jTDFSaghdxybc2WGyp8E3M2eT8qtCoU/Tv5VC03VbXSEaomC1xhSVWxuaHlw6NDaMe3mU909NVJcEDwPk+o1Z5cZqAdzpTnfo5diKP3ItS3tvVBt2zhYIYg+M5M5RJYSOS29QrJAQ51pnTZjIIdvDOiRMeeaIAZgntZOrzi6yJY0pk1rL9lMM6SFrDfV77IsQ1sZwPkn9xt+mjZDdbR821vb6TpFIoWnykbOdI/b/NIbonQL4N2dwwAIfzYN2505nPHo3ontJeFGXNDfnfd/fKZX2o+/yQuOK6TLgKiuFwPleM
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650c36ea-13ec-47f5-9251-08d6689d9e53
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 06:12:30.3685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3804
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The magnetometer's power supplies could be controllable on some platforms,
such as i.MX6Q-SABRESD board, the mag3110's power supplies are controlled
by a GPIO fixed regulator, need to make sure the regulators are enabled
before any communication with mag3110, this patch adds vdd/vddio regulator
operation support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
ChangeLog since V5:
    Make sure both vdd and vddio regulators are aquired before enabling any=
 one of them.
---
 drivers/iio/magnetometer/mag3110.c | 88 ++++++++++++++++++++++++++++++++++=
----
 1 file changed, 80 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/=
mag3110.c
index f063355..f56a99a 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -20,6 +20,7 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/delay.h>
+#include <linux/regulator/consumer.h>
=20
 #define MAG3110_STATUS 0x00
 #define MAG3110_OUT_X 0x01 /* MSB first */
@@ -56,6 +57,8 @@ struct mag3110_data {
 	struct mutex lock;
 	u8 ctrl_reg1;
 	int sleep_val;
+	struct regulator *vdd_reg;
+	struct regulator *vddio_reg;
 };
=20
 static int mag3110_request(struct mag3110_data *data)
@@ -469,17 +472,44 @@ static int mag3110_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int ret;
=20
-	ret =3D i2c_smbus_read_byte_data(client, MAG3110_WHO_AM_I);
-	if (ret < 0)
-		return ret;
-	if (ret !=3D MAG3110_DEVICE_ID)
-		return -ENODEV;
-
 	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
=20
 	data =3D iio_priv(indio_dev);
+
+	data->vdd_reg =3D devm_regulator_get(&client->dev, "vdd");
+	data->vddio_reg =3D devm_regulator_get(&client->dev, "vddio");
+	if (IS_ERR(data->vdd_reg) || IS_ERR(data->vddio_reg)) {
+		if (PTR_ERR(data->vdd_reg) =3D=3D -EPROBE_DEFER ||
+			PTR_ERR(data->vddio_reg) =3D=3D -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		dev_err(&client->dev, "failed to get VDD/VDDIO regulator!\n");
+		return IS_ERR(data->vdd_reg) ?
+		       PTR_ERR(data->vdd_reg) : PTR_ERR(data->vddio_reg);
+	}
+
+	ret =3D regulator_enable(data->vdd_reg);
+	if (ret) {
+		dev_err(&client->dev, "failed to enable VDD regulator!\n");
+		return ret;
+	}
+
+	ret =3D regulator_enable(data->vddio_reg);
+	if (ret) {
+		dev_err(&client->dev, "failed to enable VDDIO regulator!\n");
+		goto disable_regulator_vdd;
+	}
+
+	ret =3D i2c_smbus_read_byte_data(client, MAG3110_WHO_AM_I);
+	if (ret < 0)
+		goto disable_regulators;
+	if (ret !=3D MAG3110_DEVICE_ID) {
+		ret =3D -ENODEV;
+		goto disable_regulators;
+	}
+
 	data->client =3D client;
 	mutex_init(&data->lock);
=20
@@ -499,7 +529,7 @@ static int mag3110_probe(struct i2c_client *client,
=20
 	ret =3D mag3110_change_config(data, MAG3110_CTRL_REG1, data->ctrl_reg1);
 	if (ret < 0)
-		return ret;
+		goto disable_regulators;
=20
 	ret =3D i2c_smbus_write_byte_data(client, MAG3110_CTRL_REG2,
 		MAG3110_CTRL_AUTO_MRST_EN);
@@ -520,16 +550,24 @@ static int mag3110_probe(struct i2c_client *client,
 	iio_triggered_buffer_cleanup(indio_dev);
 standby_on_error:
 	mag3110_standby(iio_priv(indio_dev));
+disable_regulators:
+	regulator_disable(data->vddio_reg);
+disable_regulator_vdd:
+	regulator_disable(data->vdd_reg);
+
 	return ret;
 }
=20
 static int mag3110_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
+	struct mag3110_data *data =3D iio_priv(indio_dev);
=20
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 	mag3110_standby(iio_priv(indio_dev));
+	regulator_disable(data->vddio_reg);
+	regulator_disable(data->vdd_reg);
=20
 	return 0;
 }
@@ -537,14 +575,48 @@ static int mag3110_remove(struct i2c_client *client)
 #ifdef CONFIG_PM_SLEEP
 static int mag3110_suspend(struct device *dev)
 {
-	return mag3110_standby(iio_priv(i2c_get_clientdata(
+	struct mag3110_data *data =3D iio_priv(i2c_get_clientdata(
+		to_i2c_client(dev)));
+	int ret;
+
+	ret =3D mag3110_standby(iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev))));
+	if (ret)
+		return ret;
+
+	ret =3D regulator_disable(data->vddio_reg);
+	if (ret) {
+		dev_err(dev, "failed to disable VDDIO regulator\n");
+		return ret;
+	}
+
+	ret =3D regulator_disable(data->vdd_reg);
+	if (ret) {
+		dev_err(dev, "failed to disable VDD regulator\n");
+		return ret;
+	}
+
+	return 0;
 }
=20
 static int mag3110_resume(struct device *dev)
 {
 	struct mag3110_data *data =3D iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
+	int ret;
+
+	ret =3D regulator_enable(data->vdd_reg);
+	if (ret) {
+		dev_err(dev, "failed to enable VDD regulator\n");
+		return ret;
+	}
+
+	ret =3D regulator_enable(data->vddio_reg);
+	if (ret) {
+		dev_err(dev, "failed to enable VDDIO regulator\n");
+		regulator_disable(data->vdd_reg);
+		return ret;
+	}
=20
 	return i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
 		data->ctrl_reg1);
--=20
2.7.4

