Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D71CC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBEB21905
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jSFTrXf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeLWJGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 04:06:43 -0500
Received: from mail-eopbgr130084.outbound.protection.outlook.com ([40.107.13.84]:47373
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727008AbeLWJGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 04:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBPZC1sDTmOQkwEWxPbJNz7U5bg9csRAkDn21aUkV9c=;
 b=jSFTrXf/4xXUx78kQnCg0D89ygoXmXbP23IFf1A4n3x5qx4cXBeAeQSrtEdHzv89ODwbvD6zpENl9lyaet5C7Emltd1HPYHLCfUL/ZwwLdq/YkCNlc2s8FNUvDzX3cz4QD6Z6A8cROR/DKL6oUjm7wtxC122qB2F6469wk8QrQY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3772.eurprd04.prod.outlook.com (52.134.71.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Sun, 23 Dec 2018 09:02:32 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97%5]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 09:02:32 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "martink@posteo.de" <martink@posteo.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V6 2/2] iio: accell: mma8452: add vdd/vddio regulator
 operation support
Thread-Topic: [PATCH V6 2/2] iio: accell: mma8452: add vdd/vddio regulator
 operation support
Thread-Index: AQHUmp49C+XR7zFyD0yTrl16mKer/g==
Date:   Sun, 23 Dec 2018 09:02:32 +0000
Message-ID: <1545555462-16121-2-git-send-email-Anson.Huang@nxp.com>
References: <1545555462-16121-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1545555462-16121-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0145.apcprd02.prod.outlook.com
 (2603:1096:202:16::29) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3772;6:wUnAwJ0ZQcZwrXx29T+FGEmCP928BE1wnMsLHPousT14fXBMfjoK0jRr2XnA09bk6O7ZnuvtIqevtBjaMdUgnUvyUmAeIcZ9I+1i8ZjAxd7c4ETjCWoNRFa4zs+FTkkcNcRfp4xxLHAsZxz4OVuyy7ifcD42JhBd2Y6CzRP+mP81cdNkq/9skLkFTZU/+HUMv16SuWEZsSTRPDHLVbslTlaiPDM4efwrcFLGkqGgJKUFlIVTw8bHlICexlv+VlyPn6CWgDxN8q0a9t7huj5D3tnHRLF2X9CUWufprhly+Vod9oOMnJCY3RBll+XkvBcFK2pTRmAopleubZvve63YftJwwBMsZcuOlJxzrpEiLHP7HQAnXhjfLTqvBV8/A8eKOx9zwLPtGr9KDDTgwg+87eJA666lJoKkFqppBBXrGvVppxQoTTx2lM3fzVmRP/65hmk1fiPUZzJywzt6VO1VEg==;5:24hKqo9T5vJChI1VzKrIi92s5BwAUv4BSWeV+eyJvScCRTO1RbUrMtbY+9OOFPbdej2FodiQTGD/o1pT1d1xO6PBtDzWqXWfIoa8ore6jBrR98pqMuUrCr2wEQyY5PzeAAEF5C5GGiP9gZkzGTRo8PqWnNEKi9i8f5+nEQMBMxY=;7:GJlDybAgGmYO8pbg2W/M0ncT5cC4gJ56FovgXvBvsBrH7elCnXJqaddJ9bXywNWSbZiaiV+DOi7r+piVx6IugeV9Aw7QhqG+COww5cpuI3EVkxHCyXAT0bv2kipAexMJikhK4NRTWj4SJX9TGCZRUg==
x-ms-office365-filtering-correlation-id: 0e75eefb-7537-49fa-83f8-08d668b55fb2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600098)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3772;
x-ms-traffictypediagnostic: DB3PR0402MB3772:
x-microsoft-antispam-prvs: <DB3PR0402MB3772DDEEFCE24FEA599BE4C4F5BA0@DB3PR0402MB3772.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220043)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3772;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3772;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(346002)(366004)(54534003)(189003)(199004)(7736002)(106356001)(305945005)(102836004)(36756003)(486006)(53936002)(2906002)(76176011)(14444005)(446003)(256004)(66066001)(6116002)(3846002)(476003)(11346002)(71190400001)(2616005)(71200400001)(52116002)(6512007)(2201001)(99286004)(575784001)(110136005)(6506007)(386003)(50226002)(316002)(81156014)(81166006)(86362001)(8936002)(97736004)(8676002)(5660300001)(186003)(14454004)(6486002)(68736007)(4326008)(7416002)(25786009)(6436002)(2501003)(105586002)(26005)(478600001)(6346003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3772;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c0C5ZB+IfIvTAcu6L8ZpflvKID62N9XMvyoiuVdxyTvTz+cBc2IyrQ3EuZ4IUIldTreWdD/HQNEnBwIWzOh92F2BQK7aU2w1b2MoT4FRypYun/II1RCVghbBWrhO7c2bv3Hs4jvk/W21YIlD5Bjk5RLkaeaiVZSi/iurKR0HbwT6qzrv/k2q2HVdpF3lgN8ckXyovygQjNxediRacQDzBFQ6IEvxtWVIZFdX2KWVI1gqaOFtmHVzlQ426rc7Qn4H0oh5Qfq9GAg5G24I+Js8BAtsYpwbVdUWrev7dEjj2U9nt5QEbbF+qqcL1/VzITF3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e75eefb-7537-49fa-83f8-08d668b55fb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 09:02:32.6220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The accelerometer's power supply could be controllable on some
platforms, such as i.MX6Q-SABRESD board, the mma8451's power supplies
are controlled by a GPIO fixed regulator, need to make sure the
regulators are enabled before any communication with mma8451, this
patch adds vdd/vddio regulator operation support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Martin Kepplinger <martink@posteo.de>
---
ChangeLog since V5:
    - ONLY enable vdd/vddio regulators after both of them are aquired;
    - Since the suspend/resume operations are same as runtime suspend/resum=
e, so just use the
      pm_runtime_force_suspend/resume for suspend/resuem callback to simply=
 the code.
---
 drivers/iio/accel/mma8452.c | 99 +++++++++++++++++++++++++++++++++++------=
----
 1 file changed, 77 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 421a0a8..7519ed5 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -31,6 +31,7 @@
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
=20
 #define MMA8452_STATUS				0x00
 #define  MMA8452_STATUS_DRDY			(BIT(2) | BIT(1) | BIT(0))
@@ -107,6 +108,8 @@ struct mma8452_data {
 	u8 data_cfg;
 	const struct mma_chip_info *chip_info;
 	int sleep_val;
+	struct regulator *vdd_reg;
+	struct regulator *vddio_reg;
 };
=20
  /**
@@ -1534,9 +1537,33 @@ static int mma8452_probe(struct i2c_client *client,
 	mutex_init(&data->lock);
 	data->chip_info =3D match->data;
=20
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
 	ret =3D i2c_smbus_read_byte_data(client, MMA8452_WHO_AM_I);
 	if (ret < 0)
-		return ret;
+		goto disable_regulators;
=20
 	switch (ret) {
 	case MMA8451_DEVICE_ID:
@@ -1549,7 +1576,8 @@ static int mma8452_probe(struct i2c_client *client,
 			break;
 		/* else: fall through */
 	default:
-		return -ENODEV;
+		ret =3D -ENODEV;
+		goto disable_regulators;
 	}
=20
 	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
@@ -1566,13 +1594,13 @@ static int mma8452_probe(struct i2c_client *client,
=20
 	ret =3D mma8452_reset(client);
 	if (ret < 0)
-		return ret;
+		goto disable_regulators;
=20
 	data->data_cfg =3D MMA8452_DATA_CFG_FS_2G;
 	ret =3D i2c_smbus_write_byte_data(client, MMA8452_DATA_CFG,
 					data->data_cfg);
 	if (ret < 0)
-		return ret;
+		goto disable_regulators;
=20
 	/*
 	 * By default set transient threshold to max to avoid events if
@@ -1581,7 +1609,7 @@ static int mma8452_probe(struct i2c_client *client,
 	ret =3D i2c_smbus_write_byte_data(client, MMA8452_TRANSIENT_THS,
 					MMA8452_TRANSIENT_THS_MASK);
 	if (ret < 0)
-		return ret;
+		goto disable_regulators;
=20
 	if (client->irq) {
 		int irq2;
@@ -1595,7 +1623,7 @@ static int mma8452_probe(struct i2c_client *client,
 						MMA8452_CTRL_REG5,
 						data->chip_info->all_events);
 			if (ret < 0)
-				return ret;
+				goto disable_regulators;
=20
 			dev_dbg(&client->dev, "using interrupt line INT1\n");
 		}
@@ -1604,11 +1632,11 @@ static int mma8452_probe(struct i2c_client *client,
 					MMA8452_CTRL_REG4,
 					data->chip_info->enabled_events);
 		if (ret < 0)
-			return ret;
+			goto disable_regulators;
=20
 		ret =3D mma8452_trigger_setup(indio_dev);
 		if (ret < 0)
-			return ret;
+			goto disable_regulators;
 	}
=20
 	data->ctrl_reg1 =3D MMA8452_CTRL_ACTIVE |
@@ -1661,12 +1689,19 @@ static int mma8452_probe(struct i2c_client *client,
 trigger_cleanup:
 	mma8452_trigger_cleanup(indio_dev);
=20
+disable_regulators:
+	regulator_disable(data->vddio_reg);
+
+disable_regulator_vdd:
+	regulator_disable(data->vdd_reg);
+
 	return ret;
 }
=20
 static int mma8452_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
+	struct mma8452_data *data =3D iio_priv(indio_dev);
=20
 	iio_device_unregister(indio_dev);
=20
@@ -1678,6 +1713,9 @@ static int mma8452_remove(struct i2c_client *client)
 	mma8452_trigger_cleanup(indio_dev);
 	mma8452_standby(iio_priv(indio_dev));
=20
+	regulator_disable(data->vddio_reg);
+	regulator_disable(data->vdd_reg);
+
 	return 0;
 }
=20
@@ -1696,6 +1734,18 @@ static int mma8452_runtime_suspend(struct device *de=
v)
 		return -EAGAIN;
 	}
=20
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
 	return 0;
 }
=20
@@ -1705,9 +1755,22 @@ static int mma8452_runtime_resume(struct device *dev=
)
 	struct mma8452_data *data =3D iio_priv(indio_dev);
 	int ret, sleep_val;
=20
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
+
 	ret =3D mma8452_active(data);
 	if (ret < 0)
-		return ret;
+		goto runtime_resume_failed;
=20
 	ret =3D mma8452_get_odr_index(data);
 	sleep_val =3D 1000 / mma8452_samp_freq[ret][0];
@@ -1717,25 +1780,17 @@ static int mma8452_runtime_resume(struct device *de=
v)
 		msleep_interruptible(sleep_val);
=20
 	return 0;
-}
-#endif
=20
-#ifdef CONFIG_PM_SLEEP
-static int mma8452_suspend(struct device *dev)
-{
-	return mma8452_standby(iio_priv(i2c_get_clientdata(
-		to_i2c_client(dev))));
-}
+runtime_resume_failed:
+	regulator_disable(data->vddio_reg);
+	regulator_disable(data->vdd_reg);
=20
-static int mma8452_resume(struct device *dev)
-{
-	return mma8452_active(iio_priv(i2c_get_clientdata(
-		to_i2c_client(dev))));
+	return ret;
 }
 #endif
=20
 static const struct dev_pm_ops mma8452_pm_ops =3D {
-	SET_SYSTEM_SLEEP_PM_OPS(mma8452_suspend, mma8452_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume=
)
 	SET_RUNTIME_PM_OPS(mma8452_runtime_suspend,
 			   mma8452_runtime_resume, NULL)
 };
--=20
2.7.4

