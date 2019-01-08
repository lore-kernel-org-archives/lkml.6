Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6DEC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1902087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="x98T8jwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfAHKYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:24:49 -0500
Received: from mail-eopbgr710069.outbound.protection.outlook.com ([40.107.71.69]:15816
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727001AbfAHKYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWDJdgiiFlouGhFCP7wyhyatjmFRdCISTnrnU8WfbTQ=;
 b=x98T8jwxdIiLW+U2HUi+RKDvJKSbM1S/fWX5HpuUExDbffmZV11Ap1FLzRSy/i14j6lJUJJEkWFz145yHXXgJww43qbLapXlkp4q3wF67VJ8ZY4N4zkh1VXuyRt3S/yiSMIbUzXXg3bTSiHcWKxluZYih1hdNqzMsg6WKm9GuOM=
Received: from MN2PR12MB3088.namprd12.prod.outlook.com (20.178.241.29) by
 MN2PR12MB2960.namprd12.prod.outlook.com (20.179.81.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Tue, 8 Jan 2019 10:24:40 +0000
Received: from MN2PR12MB3088.namprd12.prod.outlook.com
 ([fe80::84f:52f7:9e06:56]) by MN2PR12MB3088.namprd12.prod.outlook.com
 ([fe80::84f:52f7:9e06:56%3]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 10:24:40 +0000
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
CC:     "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:ANALOG DEVICES INC ASOC CODEC DRIVERS" 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: ADAU7002: Add optional delay before start of capture
Thread-Topic: [PATCH] ASoC: ADAU7002: Add optional delay before start of
 capture
Thread-Index: AQHUpzxdxawngT0/rEmKoCNuVGH2XA==
Date:   Tue, 8 Jan 2019 10:24:40 +0000
Message-ID: <1546942924-9428-1-git-send-email-akshu.agrawal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::31) To MN2PR12MB3088.namprd12.prod.outlook.com
 (2603:10b6:208:c4::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB2960;20:FcmfQdp3LTvIKUOSrBavNedoTy3N14/ldWDFM0LJQeCuluo2ddJ5FSF554t23MFqJ2h0WpaglF7b4enBFbSyI7vL6HpII8ype63FwnpclcF3sbSjHfzLzYxGo68fQfNU2fbmw73up29+CeLjEfPxKYxSUqzhiVpulwtPZIQFuBOT5CMRjTPbE0zm987AAa/nT0dcfTezbwtlAz1uujlgfX/nWv3/uOz+fXQ+ooohEFQLtv93p56EfVJYtfdhi1w+
x-ms-office365-filtering-correlation-id: c54a1c2c-2e95-4c39-b164-08d675537f34
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB2960;
x-ms-traffictypediagnostic: MN2PR12MB2960:
x-microsoft-antispam-prvs: <MN2PR12MB2960B6A04A7C21076B483640F88A0@MN2PR12MB2960.namprd12.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(366004)(346002)(376002)(189003)(199004)(186003)(99286004)(102836004)(6506007)(386003)(26005)(86362001)(486006)(97736004)(305945005)(7736002)(71200400001)(66066001)(59246006)(71190400001)(68736007)(52116002)(5660300001)(6116002)(3846002)(4326008)(316002)(8936002)(81166006)(8676002)(476003)(2616005)(36756003)(1671002)(478600001)(109986005)(54906003)(39060400002)(81156014)(25786009)(6512007)(6436002)(105586002)(14454004)(106356001)(53936002)(72206003)(6486002)(2906002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2960;H:MN2PR12MB3088.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uYR0VynKpkJJaXig942hrIAor88XeLOfnivVJTVrc7gmxJObhYdW5sx9/xSirYBAy18KmmkLrLJTrx8skgTN6qU4BAwuG/RVBnh0YspGuR4JHuUAbECMP/i4twDU5Pwy5DcU1gXcTUOafFohfRcscGKimS7/34KLz5B0/JtGwVCzJf/MnO+rZixrxE0P+k0kJsBRM0reGMfPPtPGHN97espI5ykU+sEzSshG4bKR+NUsPL5l7nSIvxcbnqzkhVhSqKYZ+wLXMd2YemqKCIHefNCGZtIyGhXyPBRD8P26qUsVaYGuAHPCLZnxnYFxoOwS
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c54a1c2c-2e95-4c39-b164-08d675537f34
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 10:24:40.3894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2960
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On capture through some of dmic we observe a glitch at the
start of record. This is because we start capturing even before
dmic is ready to send out data.
The optional delay will be applied after enabling the mic.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/codecs/adau7002.c | 45 +++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 45 insertions(+)

diff --git a/sound/soc/codecs/adau7002.c b/sound/soc/codecs/adau7002.c
index fdff868..a8deb37 100644
--- a/sound/soc/codecs/adau7002.c
+++ b/sound/soc/codecs/adau7002.c
@@ -8,6 +8,7 @@
  */
=20
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -15,12 +16,55 @@
=20
 #include <sound/soc.h>
=20
+struct adau7002_priv {
+	int wakeup_delay;
+};
+
+static int adau7002_aif_event(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =3D
+			snd_soc_dapm_to_component(w->dapm);
+	struct adau7002_priv *adau7002 =3D
+			snd_soc_component_get_drvdata(component);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		if (adau7002->wakeup_delay)
+			msleep(adau7002->wakeup_delay);
+		break;
+	}
+
+	return 0;
+}
+
+static int adau7002_component_probe(struct snd_soc_component *component)
+{
+	struct adau7002_priv *adau7002;
+
+	adau7002 =3D devm_kzalloc(component->dev, sizeof(*adau7002),
+				GFP_KERNEL);
+	if (!adau7002)
+		return -ENOMEM;
+
+	device_property_read_u32(component->dev, "wakeup-delay-ms",
+				 &adau7002->wakeup_delay);
+
+	snd_soc_component_set_drvdata(component, adau7002);
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget adau7002_widgets[] =3D {
+	SND_SOC_DAPM_AIF_OUT_E("ADAU AIF", "Capture", 0,
+			       SND_SOC_NOPM, 0, 0, adau7002_aif_event,
+			       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_INPUT("PDM_DAT"),
 	SND_SOC_DAPM_REGULATOR_SUPPLY("IOVDD", 0, 0),
 };
=20
 static const struct snd_soc_dapm_route adau7002_routes[] =3D {
+	{ "ADAU AIF", NULL, "PDM_DAT"},
 	{ "Capture", NULL, "PDM_DAT" },
 	{ "Capture", NULL, "IOVDD" },
 };
@@ -40,6 +84,7 @@
 };
=20
 static const struct snd_soc_component_driver adau7002_component_driver =3D=
 {
+	.probe			=3D adau7002_component_probe,
 	.dapm_widgets		=3D adau7002_widgets,
 	.num_dapm_widgets	=3D ARRAY_SIZE(adau7002_widgets),
 	.dapm_routes		=3D adau7002_routes,
--=20
1.9.1

