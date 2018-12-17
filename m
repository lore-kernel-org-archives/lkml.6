Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CC4C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AE7217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ll43saOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbeLQEry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 23:47:54 -0500
Received: from mail-eopbgr00086.outbound.protection.outlook.com ([40.107.0.86]:62722
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726318AbeLQErx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 23:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNm4RnV+zl/5wzKObQa9uQrxpz5i+W2tM/VRsNexTo8=;
 b=Ll43saOlG1Rn3crsEcYVNVtmFhEFh7nlMHYF+/XMpLJL4M3WhlSEDLFuDIHOeTheSDJqP/nCgyO/mpslnNc1M9kc7AfTJfIW6Jw8paAAElZQ7xqVYDhVzrTiy7+PqjPl01JqVXOoLFVH7ml5GO/s8SolKgVnj9QyiVrTwACwhZU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3721.eurprd04.prod.outlook.com (52.134.67.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 04:47:49 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 04:47:49 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "olivier.moysan@st.com" <olivier.moysan@st.com>,
        "masneyb@onstation.org" <masneyb@onstation.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "peda@axentia.se" <peda@axentia.se>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "preid@electromag.com.au" <preid@electromag.com.au>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 2/2] iio: magnetometer: mag3110: add vdd/vddio regulator
 operation support
Thread-Topic: [PATCH V5 2/2] iio: magnetometer: mag3110: add vdd/vddio
 regulator operation support
Thread-Index: AQHUlcOp9VjSnhNIRk+OC0KV2BawtQ==
Date:   Mon, 17 Dec 2018 04:47:49 +0000
Message-ID: <1545021679-4025-2-git-send-email-Anson.Huang@nxp.com>
References: <1545021679-4025-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1545021679-4025-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:202:2e::23) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3721;6:lxeNj9/56Yq6AQbt0OxCSSZoooxIAiUKz7AwTq9SjhmskXNwjgg0UDsem6b2pYtQm7Jqt4oTpaLcvmBVlOUkIJplFDOYaNM493haA0EUuF+6zdg62WyLtddY8ekNZMZLfao1+JTN0KSrUfXu9eJNy/hwa1FLyU0mydyWU1UFee+l/i5u6V1bcyALtbRYBHv8DkSHqIzDfXZKrqOLGwi1C4H8aNnZQK1RycpWJrQPW0RQLHEXjHwwuvSTYs8RqCVjaDMOiVD2hluLByNuJgns+rzLdDNZXRD5gCDNZzni6I661x+KgJ5RCgh3EaXpq3Ycwnw2kufC0nL4HJ5JxInoMORlF3UVILMjfYMrF16KfsUQAN/9fuJ4KCLEZrOYxMUlbKDi0U8TQ5duxEfsYPfMWx4SMKQJrbRL3upZd43l6G30f5lgxKHhz5JXJ+R4SkQjbQEYmD+wCBRJt2vdAPm7uA==;5:xFeq5XNU0Hkm9kDYouxW+MoVFaooieh8lw9Cssq2Nnw3Zund/sKZexlEyrotfrx1q7gpz8eSqE7uC1lqQHTxPcbbq+C8cg/26GTK2wJF4aXkrR4sq68OBAumTYKlPNxsJfO17vsT3a/4RXDgMhngJFGlQFOUbSyat7R8JFJIDt8=;7:En6eq6QDWded7U2Iz4cjD2BZ3oZzp4hYqSx4jk1yAsO1gb6UjDro3Hud2g9ulCfBu4k7SPn5jFxDl7R8w2bJ2DjshKsdPgxc3wm5Kzl0IUp9ua3rYUJsVrKIYb/uawhS74KPGVP3+5n46k5dkL5QDw==
x-ms-office365-filtering-correlation-id: 2db0ae84-9b20-467d-40df-08d663dacb89
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3721;
x-ms-traffictypediagnostic: DB3PR0402MB3721:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-prvs: <DB3PR0402MB3721E6D70FF534DC05AFB31FF5BC0@DB3PR0402MB3721.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3721;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3721;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(39860400002)(396003)(54534003)(189003)(199004)(97736004)(256004)(8676002)(39060400002)(81156014)(4326008)(6512007)(105586002)(53936002)(305945005)(7416002)(486006)(2501003)(476003)(106356001)(2616005)(478600001)(5660300001)(66066001)(71200400001)(11346002)(446003)(71190400001)(36756003)(76176011)(6116002)(3846002)(386003)(6506007)(7736002)(2906002)(50226002)(8936002)(25786009)(6436002)(52116002)(316002)(86362001)(6486002)(99286004)(68736007)(186003)(102836004)(14454004)(81166006)(26005)(14444005)(2201001)(110136005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3721;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ie5GHKnQpJ5rvegT8+C/BgfUfCnxq/rdBpfc24HOhkcC4oZqteN8830f2eDX+9Iudc74Pxl8O+sG01Ao51IC/qAcBgzhW+BSelLG2seyUodkzm4FERIMQYZyt3XAl/zEv/iidOQh+92nuERj3K4P6VDyzmr+fXyTRlWwv5jSZl/XX0+05MCf0Q0/QMkS8ALm+0Y7SrisORKaa06lpDjro4DgYRNzUnzQzF6a48njK5hcwxG5PNWUCZKwVNVW/UGGbLxHwZEm1ljxQnoiDsr5Ku9BWJ+3kcxKuAuOWM5tFAjQSMucnBFRB4/wX7zfmhw4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db0ae84-9b20-467d-40df-08d663dacb89
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 04:47:49.3818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3721
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
ChangeLog since V4:
    -  using devm_regulator_get() instead of devm_regulator_get_optional() =
since the regulator is
       there always, if dtb does NOT specify one, regulator framework will =
assign dummy regulator for it
---
 drivers/iio/magnetometer/mag3110.c | 92 ++++++++++++++++++++++++++++++++++=
----
 1 file changed, 84 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/=
mag3110.c
index f063355..32660ce 100644
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
@@ -469,17 +472,48 @@ static int mag3110_probe(struct i2c_client *client,
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
+	if (IS_ERR(data->vdd_reg)) {
+		ret =3D PTR_ERR(data->vdd_reg);
+		if (ret !=3D -EPROBE_DEFER)
+			dev_err(&client->dev, "failed to get VDD regulator!\n");
+		return ret;
+	}
+
+	ret =3D regulator_enable(data->vdd_reg);
+	if (ret) {
+		dev_err(&client->dev, "failed to enable VDD regulator!\n");
+		return ret;
+	}
+
+	data->vddio_reg =3D devm_regulator_get(&client->dev, "vddio");
+	if (IS_ERR(data->vddio_reg)) {
+		ret =3D PTR_ERR(data->vddio_reg);
+		if (ret !=3D -EPROBE_DEFER)
+			dev_err(&client->dev, "failed to get VDDIO regulator!\n");
+		goto disable_regulator_vdd;
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
@@ -499,7 +533,7 @@ static int mag3110_probe(struct i2c_client *client,
=20
 	ret =3D mag3110_change_config(data, MAG3110_CTRL_REG1, data->ctrl_reg1);
 	if (ret < 0)
-		return ret;
+		goto disable_regulators;
=20
 	ret =3D i2c_smbus_write_byte_data(client, MAG3110_CTRL_REG2,
 		MAG3110_CTRL_AUTO_MRST_EN);
@@ -520,16 +554,24 @@ static int mag3110_probe(struct i2c_client *client,
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
@@ -537,14 +579,48 @@ static int mag3110_remove(struct i2c_client *client)
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

