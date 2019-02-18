Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B1AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAB921736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="jZ6mIc93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388788AbfBRQKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:10:45 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:49934 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388712AbfBRQKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:10:43 -0500
X-IronPort-AV: E=Sophos;i="5.58,385,1544511600"; 
   d="scan'208";a="26476886"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Feb 2019 09:10:42 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 18 Feb 2019 09:10:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3vACndhHznrL0TehhaEpBgute3q4UvGqaVmr38xUM0=;
 b=jZ6mIc93R6itx2ESbLZc49LWVCPsO0CoqXiGBTN/imLdOVIrxD0bBWz6cqtZtNoio6rNsibi+5FtAab+CxupPTFIGoc7R7UnpJ0Zj68gF9LYCa4ZXuPabgrSr6pvQvESQuA8Fg+mC1VCHnHQQjCgvmDUpo+oWNoclx/ptnPAYPc=
Received: from CY4PR11MB1256.namprd11.prod.outlook.com (10.169.252.10) by
 CY4PR11MB1448.namprd11.prod.outlook.com (10.172.69.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Mon, 18 Feb 2019 16:10:34 +0000
Received: from CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3]) by CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3%7]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 16:10:34 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <lars@metafoo.de>, <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH 4/5] ASoC: codecs: ad193x: Add runtime support for DSP_A and
 I2S modes
Thread-Topic: [PATCH 4/5] ASoC: codecs: ad193x: Add runtime support for DSP_A
 and I2S modes
Thread-Index: AQHUx6R64TVvlpVi4U2qyYqN379Pew==
Date:   Mon, 18 Feb 2019 16:10:34 +0000
Message-ID: <20190218160954.13929-5-codrin.ciubotariu@microchip.com>
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
x-ms-office365-filtering-correlation-id: 109e64c2-a0bc-4c40-5310-08d695bb9ceb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1448;
x-ms-traffictypediagnostic: CY4PR11MB1448:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;CY4PR11MB1448;23:MZb6FE7TEQEqskLXroH4mUMThapeAk3zVibVP/H?=
 =?iso-8859-1?Q?ymthO/wLAa3HO7cSU5ewi+XaBfqzRG8+VzbNFMa+M3b8GRPETkg85bA2/M?=
 =?iso-8859-1?Q?8TKRffs87J4crTxMpJfRqwlJdWG62ZlyTvudqvyvhCjjtM/U6ZcSbK5Ool?=
 =?iso-8859-1?Q?WS8A3OWj7TAq3estBOyIJ/mRt8bgJRv3nAVOg0c8fGsuheAU6zw2qWnV5m?=
 =?iso-8859-1?Q?vSeAyoNVwdOvGtcA+5ropDbs0qQKnKmq5gwqBUcNuG82eGEO4G4BVlENgF?=
 =?iso-8859-1?Q?+VU2tBYkTkuXyvf8F26hbOjo7bvODS8j2qkzp+b7p4x85F2Ag4Fz0CF8nW?=
 =?iso-8859-1?Q?AFxc2A1ZSSmoq9/urTYhA+z6SKIBQQpnfmqMwueBaOUTjmBV+wH02m5LAx?=
 =?iso-8859-1?Q?wiQjYVW6kJ9p/lBAzXWY6+3Ml46NObqDBcwSWkwiVenWSbdeBns2yJaj50?=
 =?iso-8859-1?Q?oxtDtJ1muHuEhuDCKEbv4a8V0uQFJHh/VDjZ8xrytbNVFLwfYPI/jC3Z1y?=
 =?iso-8859-1?Q?qeCoa4ls6BeRQT/yV6nBqK8IOOIKUecNR3o04TZvTAktQTYi+vWLk26hzU?=
 =?iso-8859-1?Q?b7bDiVr0t4H4v16Ain4TyEDC4htBzv3xbLPCYYoxivDqDD+OHo8a0knsnM?=
 =?iso-8859-1?Q?1biZTAdzxIyySbPJOxEyqPRqGEdjkfi1ixz+Qf8EH4hvcP8BAWUiEzeFSu?=
 =?iso-8859-1?Q?yynb1tBHKeerteiskEnmoBNXP1OKZJg9rWIsSoK4M94ziW+BaXWNi9J/Fy?=
 =?iso-8859-1?Q?ASROUdUrWycalVSbrJbejvSb7HiI20wxwQlN0lMsbckAmwEsbadEQ86NkT?=
 =?iso-8859-1?Q?Jax0hnPPsZoFWURSmTNt39KAcWlv24P/QQ8nJUVC/8507lMF2r4P1u/fbR?=
 =?iso-8859-1?Q?rci+KlzNALQCTi5L7l9xb1pIRvWZveAO4e9WL0pgXdZoFG6QnWt86L6JCQ?=
 =?iso-8859-1?Q?/+cU0+XhC3PBlFBDt7rmaMewZP+ympsAlw/FrkOpzeT4QSXSJStL43pahN?=
 =?iso-8859-1?Q?tPqE45tFUpiwNso5/e0Z+BX6W9B69TIEV5p7l/XGsKt2xTlzDLctGGvB0i?=
 =?iso-8859-1?Q?+YHcjEGuBfIP9jJwg5+Z1NTz1DmFbGrvplPCLG1nGHbwBPq7aXyRW2zJsl?=
 =?iso-8859-1?Q?w7TAQZZNLy5Ae6mxQvMyvRJCntsbTP3ytXC8OaFm9cTC/zQhE1Q6BAzJGB?=
 =?iso-8859-1?Q?blE3s3X+lZs9T/f9cfN54kZCybQX8Fdnh/fNViCCJr/EV1NvvZv5vw1CiG?=
 =?iso-8859-1?Q?Ey6M+kHlBO5iVHQ/wLoQqiEcWHcFnzL7K+qEfW/NXtzjgVK+yHgGzF0iVh?=
 =?iso-8859-1?Q?CG/sRD+01JKDp0c1DhYZR53/o4cHy2UufT8APlQhAEvthzDI8Xdt+rxc1S?=
 =?iso-8859-1?Q?oLt5glv8=3D?=
x-microsoft-antispam-prvs: <CY4PR11MB14487AF354BB772F77F03723E7630@CY4PR11MB1448.namprd11.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(136003)(376002)(39860400002)(199004)(189003)(110136005)(256004)(11346002)(52116002)(446003)(76176011)(386003)(8936002)(99286004)(54906003)(1076003)(316002)(2616005)(14444005)(106356001)(305945005)(186003)(97736004)(105586002)(476003)(36756003)(26005)(486006)(53936002)(107886003)(66066001)(71200400001)(71190400001)(6506007)(81166006)(6436002)(81156014)(25786009)(8676002)(2201001)(478600001)(6512007)(4326008)(2501003)(14454004)(50226002)(2906002)(6116002)(3846002)(86362001)(68736007)(6486002)(7736002)(102836004)(72206003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1448;H:CY4PR11MB1256.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TDEUE6BnMxVsHn1K80eItr+Xmr8KVl4LKJ3FA0Ndwaxrvh8m67XVayB1wy0G6vFOvRLjGtve+bDHSh/TPi7IazH3zujSMKF2V1Z69lfehoOycuLcCJhsr6V9f4KcQ2v/iB3HE/NeWDEXIZR81650PGKYV6hblcOyHN6Urd6BzxdRyCHCA6vFkRBNMSmp9fNrwTZV596BkRHj8VYLEJeGd7Np1xWfvCpk59WgEv9amvXkxE0lFK4V9nLeOAyjIqI4c6epVQGvuBDll4JRmww8eUX7ctUkGJJLuC0ZufGG8p9M9dyJCNT9Q9FHWkBkB0G1N3BD2uYnHG1oXHa2TN+1Gl87DWIgXJFmIzJ38BTGLEsLiqpSEHKIvF/4afx0x4bZCLhNoKVTEVHe445z9cxh1WnJlZsqS6YJpLaJXBCj6A0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 109e64c2-a0bc-4c40-5310-08d695bb9ceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 16:10:32.7681
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

The driver only supports DPS_A for DAC, which is configured at probe.
This patch adds support for DSP_A and I2S modes by using the set_fmt()
callback.

A trivial break is also removed from a case's default branch.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/codecs/ad193x.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 315ec9775118..f8cf182518a3 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -188,23 +188,26 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *cod=
ec_dai,
 {
 	struct ad193x_priv *ad193x =3D snd_soc_component_get_drvdata(codec_dai->c=
omponent);
 	unsigned int adc_serfmt =3D 0;
+	unsigned int dac_serfmt =3D 0;
 	unsigned int adc_fmt =3D 0;
 	unsigned int dac_fmt =3D 0;
=20
 	/* At present, the driver only support AUX ADC mode(SND_SOC_DAIFMT_I2S
-	 * with TDM) and ADC&DAC TDM mode(SND_SOC_DAIFMT_DSP_A)
+	 * with TDM), ADC&DAC TDM mode(SND_SOC_DAIFMT_DSP_A) and DAC I2S mode
+	 * (SND_SOC_DAIFMT_I2S)
 	 */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		adc_serfmt |=3D AD193X_ADC_SERFMT_TDM;
+		dac_serfmt |=3D AD193X_DAC_SERFMT_STEREO;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		adc_serfmt |=3D AD193X_ADC_SERFMT_AUX;
+		dac_serfmt |=3D AD193X_DAC_SERFMT_TDM;
 		break;
 	default:
 		if (ad193x_has_adc(ad193x))
 			return -EINVAL;
-		break;
 	}
=20
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -261,6 +264,8 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *codec=
_dai,
 		regmap_update_bits(ad193x->regmap, AD193X_ADC_CTRL2,
 				   AD193X_ADC_FMT_MASK, adc_fmt);
 	}
+	regmap_update_bits(ad193x->regmap, AD193X_DAC_CTRL0,
+			   AD193X_DAC_SERFMT_MASK, dac_serfmt);
 	regmap_update_bits(ad193x->regmap, AD193X_DAC_CTRL1,
 		AD193X_DAC_FMT_MASK, dac_fmt);
=20
--=20
2.17.1

