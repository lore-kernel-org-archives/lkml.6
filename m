Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598F6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF0D217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="FZNYkEXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732558AbfBRQKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:10:51 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:57173 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730928AbfBRQKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:10:44 -0500
X-IronPort-AV: E=Sophos;i="5.58,385,1544511600"; 
   d="scan'208";a="27906386"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Feb 2019 09:10:43 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 18 Feb 2019 09:10:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/wBRKgxMNitjhuf2T+HLSlxvjyfOy2D8diFHrndBxw=;
 b=FZNYkEXAO+oWUIaRRuq3NIjW89T3icf+7y5uGcUsdZhR4XtFEVa4je4uqv90Rc0uSKPTvAxMrkdGwpGV5A6ATd6xabQrxxzCHRz+hv5OQsOdRdA7bqxGNp7n0LMUQR/uB2qExnmT8oNTxzMtBTLhfwgSouAEc2u/Z2BtL3TXk+4=
Received: from CY4PR11MB1256.namprd11.prod.outlook.com (10.169.252.10) by
 CY4PR11MB1448.namprd11.prod.outlook.com (10.172.69.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Mon, 18 Feb 2019 16:10:36 +0000
Received: from CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3]) by CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3%7]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 16:10:36 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <lars@metafoo.de>, <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH 5/5] ASoC: codecs: ad193x: Add support to disable on-chip PLL
Thread-Topic: [PATCH 5/5] ASoC: codecs: ad193x: Add support to disable on-chip
 PLL
Thread-Index: AQHUx6R7m5808glWEUW45gyS4DZmHQ==
Date:   Mon, 18 Feb 2019 16:10:36 +0000
Message-ID: <20190218160954.13929-6-codrin.ciubotariu@microchip.com>
References: <20190218160954.13929-1-codrin.ciubotariu@microchip.com>
In-Reply-To: <20190218160954.13929-1-codrin.ciubotariu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::32) To CY4PR11MB1256.namprd11.prod.outlook.com
 (2603:10b6:903:25::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Codrin.Ciubotariu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecbad4ae-85e7-4217-2ebe-08d695bb9e21
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1448;
x-ms-traffictypediagnostic: CY4PR11MB1448:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;CY4PR11MB1448;23:9okqPwV6Yi1Xsr9vYK0tMbvHSRVudMJIi0fnJv2?=
 =?iso-8859-1?Q?rqlwyqfs/g8nSgS2c0SnxZ5ygGCL9b61Kk9uJoAf3b5AJtYMTgY59n0N6k?=
 =?iso-8859-1?Q?objitap3u6z240vK3Q0GNFq7EplMVbEDbdtKjbo/YL+VwqacPwFUOSwpt5?=
 =?iso-8859-1?Q?MHCPnJnb2OIBL8/1p6IRempb9vbRH8fFZB1rHCdYRyf8x2ffTU+YTYNEP5?=
 =?iso-8859-1?Q?QyRXR6xq3uV2EnEjFP8kd7qpH908pAh8baWvMLKNPb7728y9qZHRR/KjYf?=
 =?iso-8859-1?Q?aXsnu4unLstZpHnUo6iWhZXHkELZ0fu3EjCyzQdmm397NQPjZji8COAjm7?=
 =?iso-8859-1?Q?aww3n5SfbeVPn26SigENUGdKIJEUb0FC2loYRAs5tli+B53oyh8VuTpDHy?=
 =?iso-8859-1?Q?UHwo6Wqh1VZSgxktXwuimre9xPJ5GIiVB5H3peAK8waELPqk2pIU83gEdp?=
 =?iso-8859-1?Q?1wSoaH1qYOmgLljpr9WsyYkM68JfYvZz51o/ntYLwpzxQlWJItzlSAhrvL?=
 =?iso-8859-1?Q?BS//ipp530LntqxqnYChoBzkLkP/+bOc0FCCccPP1Bbct3Ka/6xEsL9SUT?=
 =?iso-8859-1?Q?7XNvguKxxvCJbav8PyaLdsdtk8FBlI7rFv7UvFuRaOILVGrITq6g0Vn/MK?=
 =?iso-8859-1?Q?mJ2u1tyo6Nm5hibVyY48kN8XJg2A1fOxB9PCzLcrpmLyIwdWmtRe/7WjZ3?=
 =?iso-8859-1?Q?ItM91lTvCJ2eSm8oEjFXAUxvNL0v6L3ll80d9gkOyVtT36derunuZdc5Rs?=
 =?iso-8859-1?Q?DmlpkzBjdhrl4/xnhkOi5XijPekJ/HZIk6aZtvyVUApBKEg7UJmAvHj3Kf?=
 =?iso-8859-1?Q?sDrJebTZOXrasKocUR3LHLaONRwmDQM5UeUD6IcBkUz5ZfHDMUN/G59TJT?=
 =?iso-8859-1?Q?F4UmW4/ekUJd0K/hiBs5lj0dcSWh11EYV0OYtf+tyalYnJknC8rhgopAFJ?=
 =?iso-8859-1?Q?hguYjCyVfm2N4eLybAUM9vJY3noU3vYHyGCWLtMp5kN7RPHkVst15M3i87?=
 =?iso-8859-1?Q?lEeq+M3U7H0csLzXH2G8WY267r/N9U+aCbwPPciIrz8+NTLoAncEUd7Jib?=
 =?iso-8859-1?Q?X2o03g17ua3zLAjypAReHKf0AB2XB1kaswjCHK73xK3NqMERDqL98rNmRe?=
 =?iso-8859-1?Q?FR4ChsFieKUxiagnpgVAFSKyoD4pbt5Hq8rsFRtWZRc7pohjxFp24/vTtI?=
 =?iso-8859-1?Q?bo8F3PD+wSokmchsFL4x+xn0cA5bp1sNmSgIwJjzGhVE/uFDWbKSURTKMb?=
 =?iso-8859-1?Q?FFaMt8aX60DUG8S2QM6DTy5+z84MZKnCK3yhL/vL1AL/+RG421QTsWRoE8?=
 =?iso-8859-1?Q?B6EJipsT1ryfMzrN9DqF83TZGyPshGN5WUx543zuF8kIOY3b7IZb0ZuNd8?=
 =?iso-8859-1?Q?82uWPypK8Ifje+++6pHxy2jawyDfE?=
x-microsoft-antispam-prvs: <CY4PR11MB1448B159F0B689415411E09EE7630@CY4PR11MB1448.namprd11.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(136003)(376002)(39860400002)(199004)(189003)(110136005)(256004)(11346002)(52116002)(446003)(76176011)(386003)(8936002)(99286004)(54906003)(1076003)(316002)(2616005)(14444005)(106356001)(305945005)(186003)(97736004)(105586002)(476003)(36756003)(26005)(486006)(53936002)(107886003)(66066001)(71200400001)(71190400001)(6506007)(81166006)(6436002)(81156014)(25786009)(8676002)(2201001)(478600001)(6512007)(4326008)(2501003)(14454004)(50226002)(2906002)(6116002)(3846002)(86362001)(68736007)(6486002)(7736002)(102836004)(72206003)(5660300002)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1448;H:CY4PR11MB1256.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HIdHRw7e5vxcwsxgEObO2GThtq8xMUL6VEcYpbHpLtHQSAFQ0FKVJH/EwYmsk5JqE0B0gaISAaApY74pDARLbKqUIaRJjxT9/GjvFcHnGMsq/BCJT8ix1DfDcz9uV6+BBXP0MjiQRYDYQXjbR0IJgShh2H/PFwgXqjhWKdhC6gil7GV9lCr7GGilRpGrZrAE8aNcxyzgSQu5nHIOeDCB10GTgUwxqsu1553VLM+Am6OBoMv5w5oxp0v00Z4k5Hq1HBtdhyxX0weK8CjWOkfaUdYiziuz+LJ1rw6EmNGuLq3TPkYSTBqoFfC3m3fSdsVTKk5QgcpMWTOe7Hqj2XRHVHZ5PsXyrYacC1NNBOz5fk3OjfgurjeOU8azZF3YV/J+ccDqqI/NbiKwalw69yGK3sFwCkHLQpI3uCRKE44A5x8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbad4ae-85e7-4217-2ebe-08d695bb9e21
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 16:10:35.0010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1448
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

The on-chip PLL can be disabled if on the MCLKI pin we have an external
clock at 512 x fs. This clock can be used as direct internal clock for
ADCs or DACs.
To support this, we add an extra clock id that can be configured
using the set_sysclk() callback.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/codecs/ad193x.c | 26 +++++++++++++++++++++++++-
 sound/soc/codecs/ad193x.h |  8 ++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index f8cf182518a3..96d7cb2e4a56 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -100,6 +100,15 @@ static const struct snd_soc_dapm_widget ad193x_adc_wid=
gets[] =3D {
 	SND_SOC_DAPM_INPUT("ADC2IN"),
 };
=20
+static int ad193x_check_pll(struct snd_soc_dapm_widget *source,
+			    struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_component *component =3D snd_soc_dapm_to_component(source-=
>dapm);
+	struct ad193x_priv *ad193x =3D snd_soc_component_get_drvdata(component);
+
+	return !!ad193x->sysclk;
+}
+
 static const struct snd_soc_dapm_route audio_paths[] =3D {
 	{ "DAC", NULL, "SYSCLK" },
 	{ "DAC Output", NULL, "DAC" },
@@ -108,7 +117,7 @@ static const struct snd_soc_dapm_route audio_paths[] =
=3D {
 	{ "DAC2OUT", NULL, "DAC Output" },
 	{ "DAC3OUT", NULL, "DAC Output" },
 	{ "DAC4OUT", NULL, "DAC Output" },
-	{ "SYSCLK", NULL, "PLL_PWR" },
+	{ "SYSCLK", NULL, "PLL_PWR", &ad193x_check_pll },
 };
=20
 static const struct snd_soc_dapm_route ad193x_adc_audio_paths[] =3D {
@@ -276,7 +285,22 @@ static int ad193x_set_dai_sysclk(struct snd_soc_dai *c=
odec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_component *component =3D codec_dai->component;
+	struct snd_soc_dapm_context *dapm =3D snd_soc_component_get_dapm(componen=
t);
 	struct ad193x_priv *ad193x =3D snd_soc_component_get_drvdata(component);
+
+	if (clk_id =3D=3D AD193X_SYSCLK_MCLK) {
+		/* MCLK must be 512 x fs */
+		if (dir =3D=3D SND_SOC_CLOCK_OUT || freq !=3D 24576000)
+			return -EINVAL;
+
+		regmap_update_bits(ad193x->regmap, AD193X_PLL_CLK_CTRL1,
+				   AD193X_PLL_SRC_MASK,
+				   AD193X_PLL_DAC_SRC_MCLK |
+				   AD193X_PLL_CLK_SRC_MCLK);
+
+		snd_soc_dapm_sync(dapm);
+		return 0;
+	}
 	switch (freq) {
 	case 12288000:
 	case 18432000:
diff --git a/sound/soc/codecs/ad193x.h b/sound/soc/codecs/ad193x.h
index 8b1e65f928d2..27d6afbd7dfb 100644
--- a/sound/soc/codecs/ad193x.h
+++ b/sound/soc/codecs/ad193x.h
@@ -31,6 +31,11 @@ int ad193x_probe(struct device *dev, struct regmap *regm=
ap,
 #define AD193X_PLL_INPUT_512    (2 << 1)
 #define AD193X_PLL_INPUT_768    (3 << 1)
 #define AD193X_PLL_CLK_CTRL1    0x01
+#define AD193X_PLL_SRC_MASK	0x03
+#define AD193X_PLL_DAC_SRC_PLL  0
+#define AD193X_PLL_DAC_SRC_MCLK 1
+#define AD193X_PLL_CLK_SRC_PLL  (0 << 1)
+#define AD193X_PLL_CLK_SRC_MCLK	(1 << 1)
 #define AD193X_DAC_CTRL0        0x02
 #define AD193X_DAC_POWERDOWN           0x01
 #define AD193X_DAC_SERFMT_MASK		0xC0
@@ -96,4 +101,7 @@ int ad193x_probe(struct device *dev, struct regmap *regm=
ap,
=20
 #define AD193X_NUM_REGS          17
=20
+#define AD193X_SYSCLK_PLL	0
+#define AD193X_SYSCLK_MCLK	1
+
 #endif
--=20
2.17.1

