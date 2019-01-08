Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF3AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6F42089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qjk/LIp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfAHJQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:16:22 -0500
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:45332
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727295AbfAHJQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEaliXq+ePEV3d1CuyrZmksqPwvbDim50A+3Hj+DCe8=;
 b=qjk/LIp1VNtGtUSE7sF/N1bcOoZoJR/k3qzQdNj9tuuHG4xt1ePeqIy50odyEHR2n22j9PNrIlZql2lYGVvVvBj9rKqK4OaFWRm+PWwwKA3Ik9vIziiFxodRDSAiVeQ2VE77APYZb1Mk7z4r5GuutW4O0DI68Ps4YqF7ZLLNCI0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3834.eurprd04.prod.outlook.com (52.134.71.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Tue, 8 Jan 2019 09:14:07 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97%6]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 09:14:07 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V7 2/2] iio: accell: mma8452: add vdd/vddio regulator
 operation support
Thread-Topic: [PATCH V7 2/2] iio: accell: mma8452: add vdd/vddio regulator
 operation support
Thread-Index: AQHUpzKBbJ60rFCTZESZwo8trBif4A==
Date:   Tue, 8 Jan 2019 09:14:06 +0000
Message-ID: <1546938556-26969-2-git-send-email-Anson.Huang@nxp.com>
References: <1546938556-26969-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1546938556-26969-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0018.apcprd03.prod.outlook.com
 (2603:1096:203:2e::30) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3834;6:oALCE3dzhjpg+PARlhthar6GO2WnblyLkdoozQsHpDyrR9f9FvUTrTnl6n7Ess8qPyeHkjlzQZsR6eVLAiSZmj0GxMMYr+sFkm1CS/xATdXpGgjovMdh7G0STjiMFuQTpp0iwTd4PPt6NC09FOxK9xZBQHUfoFvf61X7kNoKPdlxP2Hmz6xb1UWqouug3i+mTRsx3/paQvPAIreGhV1Eoe8W8iSTAGpnKkj3HfNzmXMjCpFLepLHGZN+7mk1a6nK0bMLN/kodaqERINpF23agh052K4S1vyVmVthxpv9dx+HSEGb44rCuBY0Igp71QSUQT8F7wkj7Nv980ObsOy1Wp+Ojxe1yHo2Pip/cTAwzJZQNp+FSFyQHpWA5wfPfc/KwZ6rA1h30yhS0Bhxy3ftLCyfRPrOqOKzauQXTWA3JQpUlAVIheAGNQj/vC1eDanZdzl/TPPDDTXFJmXo3DwCHg==;5:KdpsuyVAJNdVS4eK0Pws72Nt0eAYQuZifJALZxyRku4rjCm6RJ6IIEXC7VqPlxJcpXJg3ZJnO2uldEhQgJTPsrsvzu/yeglVB1QjbQbX+ioQbaGMvs1ZXbpjSq35XsaZcw+04LyVj/FzbvJhHCFXaCFroGwCd5k1eESF7+voSrojRw9mDjSuXwgKhGQGS50ZRbH5hzDLEaqYTbUqihoOfw==;7:nYDCIc0XW+OcJUhJrxupKpvJgQUQz2UGIZyto7fHeQE7o2Xj2dgh1Hp50NxOpvCu2u+RSLTqkDEMmZ5HcHhJN8SrCxGoxeqUnzJBF5pjYn1NOFkNTsh4Q/F0dRhgvCF2Foxk2AO4gFYfGWy3MOYASw==
x-ms-office365-filtering-correlation-id: dbd95805-50c1-4380-3b51-08d67549a42d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3834;
x-ms-traffictypediagnostic: DB3PR0402MB3834:
x-microsoft-antispam-prvs: <DB3PR0402MB38347AE1B6B82B9301A78355F58A0@DB3PR0402MB3834.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3834;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3834;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(136003)(39860400002)(54534003)(189003)(199004)(6486002)(68736007)(6436002)(2906002)(3846002)(50226002)(86362001)(6506007)(386003)(102836004)(6512007)(6116002)(186003)(53936002)(26005)(8936002)(71200400001)(76176011)(52116002)(99286004)(2201001)(8676002)(110136005)(305945005)(4326008)(316002)(25786009)(7736002)(486006)(81156014)(14444005)(36756003)(478600001)(66066001)(575784001)(2501003)(14454004)(256004)(81166006)(97736004)(105586002)(106356001)(11346002)(5660300001)(446003)(2616005)(476003)(71190400001)(7416002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3834;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mD3XjyncHQhaMjMstOOtxcUrN+W9c9rhbAr0Ox1W2R1xVc/52EI2vaomAJjm5rVgpnaVHWsWvWJLgNqbH2ciRW7xK3cmTGpFueGGmLEA+fDHEnrcW9h41KScqGjW4bUfXnl5JuDRPQciKF4spR3XEbBLq6eIWK15WLNcp+Lv56wpGtuJXzyc0meon1vQ6wmrLRPu01z+8k2wnO1MUNxkoTCR8YjWjQr5hE2Eb2Igrr/CDmeYFAwan/jqCQ36G62to83G7t7jyE3FziacV1lS6aoT16Y7ZVmMnn58vQeESl7csPvLWIGjtaP7lBLMePTb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd95805-50c1-4380-3b51-08d67549a42d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 09:14:01.8860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3834
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
ChangeLog Since V6:
  - separate the error handling of regulators get to make code easy to read=
.
---
 drivers/iio/accel/mma8452.c | 105 ++++++++++++++++++++++++++++++++++------=
----
 1 file changed, 83 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 421a0a8..3027811 100644
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
@@ -1534,9 +1537,39 @@ static int mma8452_probe(struct i2c_client *client,
 	mutex_init(&data->lock);
 	data->chip_info =3D match->data;
=20
+	data->vdd_reg =3D devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(data->vdd_reg)) {
+		if (PTR_ERR(data->vdd_reg) =3D=3D -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		dev_err(&client->dev, "failed to get VDD regulator!\n");
+		return PTR_ERR(data->vdd_reg);
+	}
+
+	data->vddio_reg =3D devm_regulator_get(&client->dev, "vddio");
+	if (IS_ERR(data->vddio_reg)) {
+		if (PTR_ERR(data->vddio_reg) =3D=3D -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		dev_err(&client->dev, "failed to get VDDIO regulator!\n");
+		return PTR_ERR(data->vddio_reg);
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
@@ -1549,7 +1582,8 @@ static int mma8452_probe(struct i2c_client *client,
 			break;
 		/* else: fall through */
 	default:
-		return -ENODEV;
+		ret =3D -ENODEV;
+		goto disable_regulators;
 	}
=20
 	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
@@ -1566,13 +1600,13 @@ static int mma8452_probe(struct i2c_client *client,
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
@@ -1581,7 +1615,7 @@ static int mma8452_probe(struct i2c_client *client,
 	ret =3D i2c_smbus_write_byte_data(client, MMA8452_TRANSIENT_THS,
 					MMA8452_TRANSIENT_THS_MASK);
 	if (ret < 0)
-		return ret;
+		goto disable_regulators;
=20
 	if (client->irq) {
 		int irq2;
@@ -1595,7 +1629,7 @@ static int mma8452_probe(struct i2c_client *client,
 						MMA8452_CTRL_REG5,
 						data->chip_info->all_events);
 			if (ret < 0)
-				return ret;
+				goto disable_regulators;
=20
 			dev_dbg(&client->dev, "using interrupt line INT1\n");
 		}
@@ -1604,11 +1638,11 @@ static int mma8452_probe(struct i2c_client *client,
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
@@ -1661,12 +1695,19 @@ static int mma8452_probe(struct i2c_client *client,
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
@@ -1678,6 +1719,9 @@ static int mma8452_remove(struct i2c_client *client)
 	mma8452_trigger_cleanup(indio_dev);
 	mma8452_standby(iio_priv(indio_dev));
=20
+	regulator_disable(data->vddio_reg);
+	regulator_disable(data->vdd_reg);
+
 	return 0;
 }
=20
@@ -1696,6 +1740,18 @@ static int mma8452_runtime_suspend(struct device *de=
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
@@ -1705,9 +1761,22 @@ static int mma8452_runtime_resume(struct device *dev=
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
@@ -1717,25 +1786,17 @@ static int mma8452_runtime_resume(struct device *de=
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

