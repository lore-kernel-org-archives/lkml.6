Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE0FC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 03:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B972B217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 03:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A1dAGTqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbeLQDZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 22:25:24 -0500
Received: from mail-eopbgr40083.outbound.protection.outlook.com ([40.107.4.83]:11587
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726267AbeLQDZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 22:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRADkM+JTsQwiSMAy8JruNmHI8jNZoO2jb0bkJMAVZ4=;
 b=A1dAGTqEqB0b9NDCipAco0kyJ+HZvS1etTAfPR/3/eAPMvkmxxxZTzeaoWutAulNpjV2yqs6/pyU47FGt1BSzIiuvVv5TYuQ77471rpOLEF6VDsr08Xl4QgL01y1KTLXrKZOo8fa+SQvGRaoKGJh78xDPiQp2qFMI3m6MR4ZL60=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Mon, 17 Dec 2018 03:25:17 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 03:25:17 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "preid@electromag.com.au" <preid@electromag.com.au>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V7] iio: light: isl29018: add vcc regulator operation support
Thread-Topic: [PATCH V7] iio: light: isl29018: add vcc regulator operation
 support
Thread-Index: AQHUlbghL8UoJu3CiUOnqyrpi++urw==
Date:   Mon, 17 Dec 2018 03:25:17 +0000
Message-ID: <1545016752-9865-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::18) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3658;6:Qah2zcJmZT5nx8PV4wpOsrl9/GhLlQyXY/OF/6GN71/xtXi2+yuvuIovspl0bbuUDbE4YMDTVbGk28gDKml1BHts/SHSoAOZo1maCMdsK7el/TrMP0QLg+uvdE/470BwUlu8P7lBxqGQGyTG98uQB8N/0G24lxpwqX5FEgHGjUr37W2IUhSdD2hJQp2iW30SmrIroQU9PFRdMdf8cZ0WidiiOIgIqqbclpL07PNth2+l9SqnrDTWwj/G5RIzxX14T546FgkUir7x3wqcm2tdAY2Aev0Y1J1v0zpcHoYVTrm8eABHu2e+DutJpgpt2n17/TaJn4eeBPaGcJulkafiqDrlIB+ri3gYpdBawTD7GrOT3Pj1kOwFwxuZxHYNz+qrFmztgtr4bnUxsq4eFDy0b/dE/9/IAvNU2Agrh3SgkOoPX0faQkkNlinS8mkL+9W4jHZRtLQy+F14sukYuluKfw==;5:qCFF9WUkWwmWXO8EFWo8TbtPmIhK5Rgl5JbXuZzPC2FJhPqYbXLVp/dAgKL6OUqMh7kwpxvK7puWMqN+0WjJGACQdDK6ftoIjfURjU7/ga3ru9vvGwQMUrHEWf66YtApCFQIXPJQvuPNqH0jvHF1oubxwihOWx/JK1qZFSY50UY=;7:gI4UoEXrOSOYPuAVEevxd088tu5TgUx9fRAUUQBP8p7Ewq40MVn4Ptc4Xk7KI8tiNzRagflTGtUB1335wdu/EJe7yLbiYWPc8unvEp3RRnJWNzwZcH0n1kv8V8yHIlO+Wu7AayCtfVRQttJbqhLrZw==
x-ms-office365-filtering-correlation-id: 02912b1d-7287-4fec-0895-08d663cf440d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3658;
x-ms-traffictypediagnostic: DB3PR0402MB3658:
x-microsoft-antispam-prvs: <DB3PR0402MB3658405AED4EAFFB74334D22F5BC0@DB3PR0402MB3658.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3658;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3658;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(346002)(376002)(39860400002)(54534003)(189003)(199004)(52314003)(6436002)(7736002)(25786009)(106356001)(97736004)(105586002)(68736007)(305945005)(6486002)(36756003)(99286004)(4326008)(39060400002)(6512007)(5660300001)(52116002)(14444005)(256004)(53936002)(316002)(110136005)(386003)(102836004)(81156014)(6506007)(2616005)(486006)(2906002)(86362001)(476003)(50226002)(2201001)(66066001)(2501003)(6116002)(478600001)(71190400001)(71200400001)(8936002)(3846002)(186003)(81166006)(14454004)(26005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3658;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BrNTzDa3gdE3dP8WDZPm8CIlYAmgyV+NQPF25eyhumfub93Q4mlKQeCQQK7NXIEyCf6ak5o1VYYEWDbHbTlOeRDSE1cTTpnB+tM/KwOPOtcF0YvIA6nOIC9kp1ZIzMKV/bjkQHYZsTna3+EbznxenHXf5lZhVOwNI2Ct+N/pM1gF3oier6oD4D4NQBfRRDsTe0VY7xuxcCVVapybcgrOK5tGu+gJTalZ8fzuvC9/8iYaV7gK0xmO2SF9141jpe/WIZDHaKQmMjviT5wLRd1JKeBcmsBRB+e6Kdw6FvFJ9fonCxc/PoZ2Si+yPqLqEsZz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02912b1d-7287-4fec-0895-08d663cf440d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 03:25:17.5572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3658
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The light sensor's power supply could be controllable by regulator
on some platforms, such as i.MX6Q-SABRESD board, the light sensor
isl29023's power supply is controlled by a GPIO fixed regulator,
need to make sure the regulator is enabled before any operation of
sensor, this patch adds vcc regulator operation support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
ChangeLog since V6
    - using devm_regulator_get() instead of devm_regulator_get_optional() s=
ince the regulator is
      there anyway, if dtb does NOT specify one, regulator framework will a=
ssign dummy regulator for it;
    - Setup devm action for cleaning up regulator resource for error handli=
ng.
---
 drivers/iio/light/isl29018.c | 58 ++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index b45400f..63f7b9d 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -23,6 +23,7 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -95,6 +96,7 @@ struct isl29018_chip {
 	struct isl29018_scale	scale;
 	int			prox_scheme;
 	bool			suspended;
+	struct regulator	*vcc_reg;
 };
=20
 static int isl29018_set_integration_time(struct isl29018_chip *chip,
@@ -708,6 +710,17 @@ static const char *isl29018_match_acpi_device(struct d=
evice *dev, int *data)
 	return dev_name(dev);
 }
=20
+static void isl29018_disable_regulator_action(void *_data)
+{
+	struct isl29018_chip *chip =3D _data;
+	int err;
+
+	err =3D regulator_disable(chip->vcc_reg);
+	if (err)
+		dev_err(regmap_get_device(chip->regmap),
+			"failed to disable VCC regulator!\n");
+}
+
 static int isl29018_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
@@ -742,6 +755,37 @@ static int isl29018_probe(struct i2c_client *client,
 	chip->scale =3D isl29018_scales[chip->int_time][0];
 	chip->suspended =3D false;
=20
+	chip->vcc_reg =3D devm_regulator_get(&client->dev, "vcc");
+	if (IS_ERR(chip->vcc_reg)) {
+		err =3D PTR_ERR(chip->vcc_reg);
+		if (err !=3D -EPROBE_DEFER)
+			dev_err(&client->dev, "failed to get VCC regulator!\n");
+		return err;
+	}
+
+	err =3D regulator_enable(chip->vcc_reg);
+	if (err) {
+		dev_err(&client->dev, "failed to enable VCC regulator!\n");
+		return err;
+	}
+
+	chip->regmap =3D devm_regmap_init_i2c(client,
+				isl29018_chip_info_tbl[dev_id].regmap_cfg);
+	if (IS_ERR(chip->regmap)) {
+		err =3D PTR_ERR(chip->regmap);
+		dev_err(&client->dev, "regmap initialization fails: %d\n", err);
+		regulator_disable(chip->vcc_reg);
+		return err;
+	}
+
+	err =3D devm_add_action(&client->dev, isl29018_disable_regulator_action,
+				 chip);
+	if (err) {
+		isl29018_disable_regulator_action(chip);
+		dev_err(&client->dev, "failed to setup regulator cleanup action!\n");
+		return err;
+	}
+
 	chip->regmap =3D devm_regmap_init_i2c(client,
 				isl29018_chip_info_tbl[dev_id].regmap_cfg);
 	if (IS_ERR(chip->regmap)) {
@@ -768,6 +812,7 @@ static int isl29018_probe(struct i2c_client *client,
 static int isl29018_suspend(struct device *dev)
 {
 	struct isl29018_chip *chip =3D iio_priv(dev_get_drvdata(dev));
+	int ret;
=20
 	mutex_lock(&chip->lock);
=20
@@ -777,6 +822,12 @@ static int isl29018_suspend(struct device *dev)
 	 * So we do not have much to do here.
 	 */
 	chip->suspended =3D true;
+	ret =3D regulator_disable(chip->vcc_reg);
+	if (ret) {
+		dev_err(dev, "failed to disable VCC regulator\n");
+		mutex_unlock(&chip->lock);
+		return ret;
+	}
=20
 	mutex_unlock(&chip->lock);
=20
@@ -790,6 +841,13 @@ static int isl29018_resume(struct device *dev)
=20
 	mutex_lock(&chip->lock);
=20
+	err =3D regulator_enable(chip->vcc_reg);
+	if (err) {
+		dev_err(dev, "failed to enable VCC regulator\n");
+		mutex_unlock(&chip->lock);
+		return err;
+	}
+
 	err =3D isl29018_chip_init(chip);
 	if (!err)
 		chip->suspended =3D false;
--=20
2.7.4

