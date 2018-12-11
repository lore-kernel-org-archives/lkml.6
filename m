Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13BFC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB702054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kD/dqX27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB702054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbeLKFCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:02:50 -0500
Received: from mail-eopbgr150080.outbound.protection.outlook.com ([40.107.15.80]:26304
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728682AbeLKFCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82DdLk1LJ+2WELvya2RVosHJGZsjHZ0Bi6ZL+Sf9Rdg=;
 b=kD/dqX270ZabeMSB3z1JRh9t+dB7uUs6mMcrESqNDPwwQgQTFpT7vqNICuqMtuUUjBNiBsvHkp0h6N8LYQ9aULgRs0L4y8QToNfjFamLyf+FVwqgHa3aORvPip7O6FXjlfn/mcfu7qdfiVatTQ3Hs5+k1M3Uja1bWFWvVDhzVm8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3898.eurprd04.prod.outlook.com (52.134.65.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Tue, 11 Dec 2018 05:02:44 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 05:02:44 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "preid@electromag.com.au" <preid@electromag.com.au>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 2/2] iio: light: isl29018: add optional vdd regulator
 operation support
Thread-Topic: [PATCH V5 2/2] iio: light: isl29018: add optional vdd regulator
 operation support
Thread-Index: AQHUkQ7AM002daa87UyyPcNub4GqeA==
Date:   Tue, 11 Dec 2018 05:02:44 +0000
Message-ID: <1544504196-30277-2-git-send-email-Anson.Huang@nxp.com>
References: <1544504196-30277-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544504196-30277-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0028.apcprd03.prod.outlook.com
 (2603:1096:203:2f::16) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3898;6:bIIzNZckBJwcM5spFveccsGZJTSQj86pd+5WR7QdClF8Jhw/VaLmwE2elK5U9tk30NuYP7P79ZhoMW1wx27lddx64u1OQsBtcIYVEH5I22bmPEct8/gzHm4PS6dZ0hPNNPZkZR3U892uZRv2j+bv6r61uNRJn8ySkS/k8lac1O8aCxch8yfXcwjrajoolhbXLq1nb+NpVkoMo2WQ5Ub/rJ55ypFgn9j5X8DdoxHDnIgOGSNr3j6C2C5mHjRKB5XrAu0J5islgwlPeP4nHfaZ1VoD6IUJCenoPRjIlFvjP6yIStB0Gs5+5TwMGkKkF/n6LD9AevT0NXznAl+GTmRFWfH8cxmEvtToXQ5lhK6QDRU+VMTHFPPAn23SjajEqdN3upaQO6FYnJdolPdRO/KBnevE9fKtI45wvSHbE5lOokMpZDcV1WlHw3iy1bnzxiEZ0nWwTNFJEWP4HFzq3CoUTw==;5:2tFxBuH1p9BEQ9juRW0V/UKp8zMZttzA3KmjWqYLSfis4g+z9dZTJL18PLp9M6JRGTD6dXVXwcF7lnthHpfMjVbZ2TJ8qGRocWbmf847eSBAh0LwBCuixmUixDz62Gj0Y/s8w5ObGJsx5dfi66m5QymuUktYTovkig48b0zHlCw=;7:OrDlv4RkV3qbk/agTezzzAImcuMP9jSqSe8uS9aQ/5DLlaleIC2Y0VKcnYHfBhL/DUXehCZ6sk8HnnJPioMb6x6MDbEK9ZyFf66eYGp5HJH9Y1QO2fiQR3hOaBulCKI1lcc9w2/tal+tjoE+b6Vjvw==
x-ms-office365-filtering-correlation-id: 9058c7a0-4f6b-4c48-25f1-08d65f25e2cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3898;
x-ms-traffictypediagnostic: DB3PR0402MB3898:
x-microsoft-antispam-prvs: <DB3PR0402MB3898030B4A6257E402005D21F5A60@DB3PR0402MB3898.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231472)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3898;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3898;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(54534003)(6486002)(71190400001)(186003)(36756003)(6436002)(68736007)(3846002)(7736002)(26005)(66066001)(99286004)(4326008)(50226002)(25786009)(105586002)(71200400001)(256004)(14444005)(478600001)(106356001)(7416002)(6512007)(476003)(110136005)(6506007)(386003)(2906002)(2616005)(14454004)(486006)(97736004)(316002)(102836004)(11346002)(2501003)(39060400002)(446003)(81156014)(76176011)(86362001)(8936002)(305945005)(5660300001)(2201001)(81166006)(53936002)(8676002)(6116002)(52116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3898;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NWR5atwYLOZCmmtjixo4NALyLWF7rY5gaTx2+7vtAWnPOcDs3Ss4vJYTN9YQmUxX7egEVIi4jjOIKM23jg3rXrSvAKHA+B8975B3EPZ8sCcCmHSzWNvkY4J9iXp24j6aDmCihEnXPdYgQn3zb/2qs8mVpWBRa5/LYoru+ZUsscJKmdLhtbldWU9sHQdy4y6n9eGZLYKZ0Bbs9heo3Wd0QelYeMvm7B0UT1+p9QwtubYiKhpeUiIKgZsVnFImsytyvKlCbPGDg0YvzJj/WA/o7EotAaSLt74D+23gPSOW8o/qllLde5hEqEN3LXGkEEPr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9058c7a0-4f6b-4c48-25f1-08d65f25e2cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 05:02:44.5239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3898
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The light sensor's power supply could be controlled by regulator
on some platforms, such as i.MX6Q-SABRESD board, the light sensor
isl29023's power supply is controlled by a GPIO fixed regulator,
need to make sure the regulator is enabled before any operation of
sensor, this patch adds optional vdd regulator operation support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
ChangeLog since V4:
	Since ONLY isl29018 has two power supplies and they are MUST shorted exter=
nally, so they can be
	treated as one power supply as well, using one regulator for driver.
---
 drivers/iio/light/isl29018.c | 47 ++++++++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index b45400f..5e3d1c1 100644
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
+	struct regulator	*vdd_reg;
 };
=20
 static int isl29018_set_integration_time(struct isl29018_chip *chip,
@@ -735,6 +737,19 @@ static int isl29018_probe(struct i2c_client *client,
=20
 	mutex_init(&chip->lock);
=20
+	chip->vdd_reg =3D devm_regulator_get_optional(&client->dev, "vdd");
+	if (!IS_ERR(chip->vdd_reg)) {
+		err =3D regulator_enable(chip->vdd_reg);
+		if (err) {
+			dev_err(&client->dev, "failed to enable VDD regulator\n");
+			return err;
+		}
+	} else {
+		err =3D PTR_ERR(chip->vdd_reg);
+		if (err !=3D -ENODEV)
+			return err;
+	}
+
 	chip->type =3D dev_id;
 	chip->calibscale =3D 1;
 	chip->ucalibscale =3D 0;
@@ -747,12 +762,12 @@ static int isl29018_probe(struct i2c_client *client,
 	if (IS_ERR(chip->regmap)) {
 		err =3D PTR_ERR(chip->regmap);
 		dev_err(&client->dev, "regmap initialization fails: %d\n", err);
-		return err;
+		goto disable_regulator;
 	}
=20
 	err =3D isl29018_chip_init(chip);
 	if (err)
-		return err;
+		goto disable_regulator;
=20
 	indio_dev->info =3D isl29018_chip_info_tbl[dev_id].indio_info;
 	indio_dev->channels =3D isl29018_chip_info_tbl[dev_id].channels;
@@ -761,13 +776,22 @@ static int isl29018_probe(struct i2c_client *client,
 	indio_dev->dev.parent =3D &client->dev;
 	indio_dev->modes =3D INDIO_DIRECT_MODE;
=20
-	return devm_iio_device_register(&client->dev, indio_dev);
+	err =3D devm_iio_device_register(&client->dev, indio_dev);
+	if (!err)
+		return 0;
+
+disable_regulator:
+	if (!IS_ERR(chip->vdd_reg))
+		regulator_disable(chip->vdd_reg);
+
+	return err;
 }
=20
 #ifdef CONFIG_PM_SLEEP
 static int isl29018_suspend(struct device *dev)
 {
 	struct isl29018_chip *chip =3D iio_priv(dev_get_drvdata(dev));
+	int ret;
=20
 	mutex_lock(&chip->lock);
=20
@@ -777,6 +801,14 @@ static int isl29018_suspend(struct device *dev)
 	 * So we do not have much to do here.
 	 */
 	chip->suspended =3D true;
+	if (!IS_ERR(chip->vdd_reg)) {
+		ret =3D regulator_disable(chip->vdd_reg);
+		if (ret) {
+			dev_err(dev, "failed to disable VDD regulator\n");
+			mutex_unlock(&chip->lock);
+			return ret;
+		}
+	}
=20
 	mutex_unlock(&chip->lock);
=20
@@ -790,6 +822,15 @@ static int isl29018_resume(struct device *dev)
=20
 	mutex_lock(&chip->lock);
=20
+	if (!IS_ERR(chip->vdd_reg)) {
+		err =3D regulator_enable(chip->vdd_reg);
+		if (err) {
+			dev_err(dev, "failed to enable VDD regulator\n");
+			mutex_unlock(&chip->lock);
+			return err;
+		}
+	}
+
 	err =3D isl29018_chip_init(chip);
 	if (!err)
 		chip->suspended =3D false;
--=20
2.7.4

