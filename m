Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207E7C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E0220675
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RWFP7wCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfADQ1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:27:14 -0500
Received: from mail-eopbgr40088.outbound.protection.outlook.com ([40.107.4.88]:14624
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbfADQ1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xU2keuVbRepnlqONl4BC/FjdNPS6KA9ykIiMPZO6myw=;
 b=RWFP7wCOaqJPpHy8jkbLb2oQb7hhcN3F9w1X3OqwtL6U8vf+3+qMff/+0fR1YnEvdC3OaRp+LELaXulsEJwMzMUqZQPjtT5QXdvwuV0WNZTt92e2fCnpCB1wVsBOTAqe5jZ1ip0wx5eDG58rl+LW3zjdxndxDDfOqQD/vMiyk+s=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3759.eurprd04.prod.outlook.com (52.134.15.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Fri, 4 Jan 2019 16:27:04 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::a8aa:5f09:1d1c:7b57]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::a8aa:5f09:1d1c:7b57%3]) with mapi id 15.20.1495.005; Fri, 4 Jan 2019
 16:27:04 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     Cosmin Samoila <cosmin.samoila@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>
Subject: [PATCH 1/2] ASoC: ak4458: Add support for AK4497
Thread-Topic: [PATCH 1/2] ASoC: ak4458: Add support for AK4497
Thread-Index: AQHUpEpTrS0B0qRj30+CRXisIwxMlA==
Date:   Fri, 4 Jan 2019 16:27:03 +0000
Message-ID: <20190104162649.13103-2-daniel.baluta@nxp.com>
References: <20190104162649.13103-1-daniel.baluta@nxp.com>
In-Reply-To: <20190104162649.13103-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0085.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::38) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3759;6:YlUgib/ytbHjcUnHV/UmoOA1xE20yJixuvHPzoDPcN6IJ5L3eNk02EYqDpfKJsyQmelE+NTuTDRT7aEkdeGAOD30rJlm5oPvMgvv1w17dZJmbLGN9riulscogc9n3oDk81ewHk4themoHty4dWwK2J4izoQ2npfTh0/A2S2gHIXFCA0OeE01dHRedFudwDQ+NiBP+X6P/Sav/xSlNtqdMvooOJNf10LGs+VuCKb8TEX2BqmCE+Ie3bKXu85IiXDpg5LjkLKdrNvQHaYvxRCHr4uOc4+lVmN41nFdfW1MMjbAnpr5nXiIGCHZL5j4DjpxEMeVXy6YyVtrAhmZCNqYvZI5QF0dKLmMkB0drRLWW4H8GAaa5SmeJdmTpQztkcC+r3nbiiQBUiNX/YTYonAbLaZrnjRp5NWJNzE/5ThtGjdVGysDAqrkWaR4sS9Qxv3gB2yg+2IlnhpT08lH6DOkeA==;5:W3qgItjeP4BfK37k9pH1fDQcbi14Ghzwk7yX/+4lQKM/HxLJBC4eY6oGIF/rKROZjsS/BS3PrNKrNt63gy/zStahFg7gwb3AryhFS1/un8sH79C+XYII7PELpB48hU+wypa0RZV5IKeAfPBs2ggBi5Izje2TVUVQmElxY7wLngs=;7:MXMqQCCrJgDSVOwri83lxh/jBDSX2K/moKpXW+6Xa91kiLeal5RO3YpEPaC0yV5wI22uvWBtsDRsLVza9QwG5dKtmmt0SimegtwmRVfj5RMcoQ97siYFCERTJDE6MAJtJShEWKWP9j8VI0PlmqKIOw==
x-ms-office365-filtering-correlation-id: db722064-6d8c-4b80-558a-08d67261760a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3759;
x-ms-traffictypediagnostic: VI1PR0402MB3759:
x-microsoft-antispam-prvs: <VI1PR0402MB375922F2877930A3D3D084ABF98E0@VI1PR0402MB3759.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3759;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3759;
x-forefront-prvs: 0907F58A24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(39860400002)(136003)(346002)(189003)(199004)(8676002)(4326008)(54906003)(316002)(44832011)(76176011)(305945005)(8936002)(99286004)(81156014)(2906002)(486006)(81166006)(53936002)(446003)(1076003)(25786009)(110136005)(105586002)(2501003)(36756003)(7736002)(52116002)(476003)(39060400002)(2616005)(11346002)(71200400001)(71190400001)(256004)(6116002)(3846002)(68736007)(106356001)(6512007)(6306002)(966005)(14444005)(14454004)(6436002)(86362001)(6506007)(478600001)(186003)(50226002)(386003)(5660300001)(66066001)(6486002)(102836004)(26005)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3759;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hFSz6H5L1yCxAIhp1y5e66LEno8dn6s/i36Jkf4Zu89js8FlVjWKA/kSu48eyLWSOElbyn6TBoKvl4lADFe1I29QgwsRz1mgSCW24PSPNyxM15+WPHHkALAr42xqZaxKfAZt1M6jfzCBZ/dTZPnXAN+b7OKa5JC1MXrsgHxLQMFwYvAIlJXuaOQlHvRG7dHZSpO6Ev+b+7TnJBezZ05Tu1thuwc9xiaMk7ywS100LJulrBb+jK8vc6nY1uRNaUvI94S5KEbEOM5Tx5qJ8Uf/3nfiZ3JIKIM5jjn/yCymY12Zek81plGOUhdHlB2us4tb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db722064-6d8c-4b80-558a-08d67261760a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 16:27:03.2593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AK4497 is a 32-bit 2ch DAC and has the same register
map as AK4458 with few exceptions:

* AK4497 has one more register at the end of register space
  DFS_READ which is a read only register that allows users
  to read FS Auto Detection mode. We currently do not use
  this register so we use the same regmap structure as for ak4458.

* Because AK4458 is an 8ch DAC there are some fields that are
  only used by AK4458 and marked as reserved for AK4497, so for
  this reason we need to have a distinct set of controls, widgets
  and routes.

Datasheet for AK4497 is at:
https://www.akm.com/akm/en/file/ev-board-manual/AK4497EQ.pdf

Datasheet for AK4458 is at:
https://www.akm.com/akm/en/file/datasheet/AK4458VN.pdf

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/codecs/ak4458.c | 79 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 70d4c89bd6fc..eab7c76cfcd9 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -21,6 +21,11 @@
=20
 #include "ak4458.h"
=20
+struct ak4458_drvdata {
+	struct snd_soc_dai_driver *dai_drv;
+	const struct snd_soc_component_driver *comp_drv;
+};
+
 /* AK4458 Codec Private Data */
 struct ak4458_priv {
 	struct device *dev;
@@ -258,6 +263,33 @@ static const struct snd_soc_dapm_route ak4458_intercon=
[] =3D {
 	{"AK4458 AOUTD",	NULL,	"AK4458 DAC4"},
 };
=20
+/* ak4497 controls */
+static const struct snd_kcontrol_new ak4497_snd_controls[] =3D {
+	SOC_DOUBLE_R_TLV("DAC Playback Volume", AK4458_03_LCHATT,
+			 AK4458_04_RCHATT, 0, 0xFF, 0, dac_tlv),
+	SOC_ENUM("AK4497 De-emphasis Response DAC", ak4458_dac1_dem_enum),
+	SOC_ENUM_EXT("AK4497 Digital Filter Setting", ak4458_digfil_enum,
+		     get_digfil, set_digfil),
+	SOC_ENUM("AK4497 Inverting Enable of DZFB", ak4458_dzfb_enum),
+	SOC_ENUM("AK4497 Sound Mode", ak4458_sm_enum),
+	SOC_ENUM("AK4497 Attenuation transition Time Setting",
+		 ak4458_ats_enum),
+};
+
+/* ak4497 dapm widgets */
+static const struct snd_soc_dapm_widget ak4497_dapm_widgets[] =3D {
+	SND_SOC_DAPM_DAC("AK4497 DAC", NULL, AK4458_0A_CONTROL6, 2, 0),
+	SND_SOC_DAPM_AIF_IN("AK4497 SDTI", "Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_OUTPUT("AK4497 AOUT"),
+};
+
+/* ak4497 dapm routes */
+static const struct snd_soc_dapm_route ak4497_intercon[] =3D {
+	{"AK4497 DAC",		NULL,	"AK4497 SDTI"},
+	{"AK4497 AOUT",		NULL,	"AK4497 DAC"},
+
+};
+
 static int ak4458_rstn_control(struct snd_soc_component *component, int bi=
t)
 {
 	int ret;
@@ -476,6 +508,18 @@ static struct snd_soc_dai_driver ak4458_dai =3D {
 	.ops =3D &ak4458_dai_ops,
 };
=20
+static struct snd_soc_dai_driver ak4497_dai =3D {
+	.name =3D "ak4497-aif",
+	.playback =3D {
+		.stream_name =3D "Playback",
+		.channels_min =3D 1,
+		.channels_max =3D 2,
+		.rates =3D SNDRV_PCM_RATE_KNOT,
+		.formats =3D AK4458_FORMATS,
+	},
+	.ops =3D &ak4458_dai_ops,
+};
+
 static void ak4458_power_off(struct ak4458_priv *ak4458)
 {
 	if (ak4458->reset_gpiod) {
@@ -573,6 +617,21 @@ static const struct snd_soc_component_driver soc_codec=
_dev_ak4458 =3D {
 	.non_legacy_dai_naming	=3D 1,
 };
=20
+static const struct snd_soc_component_driver soc_codec_dev_ak4497 =3D {
+	.probe			=3D ak4458_probe,
+	.remove			=3D ak4458_remove,
+	.controls		=3D ak4497_snd_controls,
+	.num_controls		=3D ARRAY_SIZE(ak4497_snd_controls),
+	.dapm_widgets		=3D ak4497_dapm_widgets,
+	.num_dapm_widgets	=3D ARRAY_SIZE(ak4497_dapm_widgets),
+	.dapm_routes		=3D ak4497_intercon,
+	.num_dapm_routes	=3D ARRAY_SIZE(ak4497_intercon),
+	.idle_bias_on		=3D 1,
+	.use_pmdown_time	=3D 1,
+	.endianness		=3D 1,
+	.non_legacy_dai_naming	=3D 1,
+};
+
 static const struct regmap_config ak4458_regmap =3D {
 	.reg_bits =3D 8,
 	.val_bits =3D 8,
@@ -583,6 +642,16 @@ static const struct regmap_config ak4458_regmap =3D {
 	.cache_type =3D REGCACHE_RBTREE,
 };
=20
+static const struct ak4458_drvdata ak4458_drvdata =3D {
+	.dai_drv =3D &ak4458_dai,
+	.comp_drv =3D &soc_codec_dev_ak4458,
+};
+
+static const struct ak4458_drvdata ak4497_drvdata =3D {
+	.dai_drv =3D &ak4497_dai,
+	.comp_drv =3D &soc_codec_dev_ak4497,
+};
+
 static const struct dev_pm_ops ak4458_pm =3D {
 	SET_RUNTIME_PM_OPS(ak4458_runtime_suspend, ak4458_runtime_resume, NULL)
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
@@ -592,6 +661,7 @@ static const struct dev_pm_ops ak4458_pm =3D {
 static int ak4458_i2c_probe(struct i2c_client *i2c)
 {
 	struct ak4458_priv *ak4458;
+	const struct ak4458_drvdata *drvdata;
 	int ret;
=20
 	ak4458 =3D devm_kzalloc(&i2c->dev, sizeof(*ak4458), GFP_KERNEL);
@@ -605,6 +675,8 @@ static int ak4458_i2c_probe(struct i2c_client *i2c)
 	i2c_set_clientdata(i2c, ak4458);
 	ak4458->dev =3D &i2c->dev;
=20
+	drvdata =3D of_device_get_match_data(&i2c->dev);
+
 	ak4458->reset_gpiod =3D devm_gpiod_get_optional(ak4458->dev, "reset",
 						      GPIOD_OUT_LOW);
 	if (IS_ERR(ak4458->reset_gpiod))
@@ -615,8 +687,8 @@ static int ak4458_i2c_probe(struct i2c_client *i2c)
 	if (IS_ERR(ak4458->mute_gpiod))
 		return PTR_ERR(ak4458->mute_gpiod);
=20
-	ret =3D devm_snd_soc_register_component(ak4458->dev, &soc_codec_dev_ak445=
8,
-				     &ak4458_dai, 1);
+	ret =3D devm_snd_soc_register_component(ak4458->dev, drvdata->comp_drv,
+					      drvdata->dai_drv, 1);
 	if (ret < 0) {
 		dev_err(ak4458->dev, "Failed to register CODEC: %d\n", ret);
 		return ret;
@@ -635,7 +707,8 @@ static int ak4458_i2c_remove(struct i2c_client *i2c)
 }
=20
 static const struct of_device_id ak4458_of_match[] =3D {
-	{ .compatible =3D "asahi-kasei,ak4458", },
+	{ .compatible =3D "asahi-kasei,ak4458", .data =3D &ak4458_drvdata},
+	{ .compatible =3D "asahi-kasei,ak4497", .data =3D &ak4497_drvdata},
 	{ },
 };
=20
--=20
2.17.1

