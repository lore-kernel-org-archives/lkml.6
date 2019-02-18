Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAB8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5035C21736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="JTALc9kw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388932AbfBRQK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:10:58 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:49934 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731529AbfBRQKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:10:42 -0500
X-IronPort-AV: E=Sophos;i="5.58,385,1544511600"; 
   d="scan'208";a="26476881"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Feb 2019 09:10:41 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 18 Feb 2019 09:10:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9ZaDRCEoYFfX+kcNM+XYkG2iwAk6Swvbp+2RXTN38I=;
 b=JTALc9kwHwid/WGi9UUYOZn8FjKq8kIJIpwYz5FoY3aNzNAfoTT4b+SjwzE7But47RKANkY1mOKl5wTLmwOzyy9RnaXbB6tBUjc6loIC8HcBXIY09bbfVu2XOL1YKpH2usJVYaSfkf1IeoU3FXUzBoLgsLmBcvWx/SQ7rxEHeX4=
Received: from CY4PR11MB1256.namprd11.prod.outlook.com (10.169.252.10) by
 CY4PR11MB1448.namprd11.prod.outlook.com (10.172.69.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Mon, 18 Feb 2019 16:10:30 +0000
Received: from CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3]) by CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3%7]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 16:10:30 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <lars@metafoo.de>, <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH 2/5] ASoC: codecs: ad193x: Set constraint to always have 32
 sample bits
Thread-Topic: [PATCH 2/5] ASoC: codecs: ad193x: Set constraint to always have
 32 sample bits
Thread-Index: AQHUx6R42/w2rhtso0esi+FU0VrYpA==
Date:   Mon, 18 Feb 2019 16:10:30 +0000
Message-ID: <20190218160954.13929-3-codrin.ciubotariu@microchip.com>
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
x-ms-office365-filtering-correlation-id: f580ef44-8e74-4f99-689d-08d695bb9a47
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1448;
x-ms-traffictypediagnostic: CY4PR11MB1448:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;CY4PR11MB1448;23:mLpCz3nCOH+ST4chE9bYqC4+uziXVenDxxzVRlt?=
 =?iso-8859-1?Q?lXIxgOKS6LIdDL3i2QMhd86L5jeIXFHQEarO5r2PYDVWFIAe2mksIusQ3w?=
 =?iso-8859-1?Q?rRqI3dss0taoTwAx0F/TK/y89JL3YqAE+nNm5ip9BCPypwHAPlrRyFt6Q/?=
 =?iso-8859-1?Q?prIEfTOz1HPhkh/HdTjGHMvhSVg8vEsCjKTftukQyQPqZsVmZrLUT1/JSO?=
 =?iso-8859-1?Q?+RW/HjEC1d2H9fwQyrK35r561kX65T81XkuipNX8OYMz+mtTAMzG8eynV6?=
 =?iso-8859-1?Q?JDhj5Icn4WVR1tqpxgmrMXIQUHByakz3oYdJgo717xPmFb0xGRYLpuAK0x?=
 =?iso-8859-1?Q?P80uS3F0n+vKgU1LujZeFCiH4C1Zmz8ObCaW5+vVC4pl3M2iM9CYj50HKv?=
 =?iso-8859-1?Q?76DuukWa8wPDlWaUcGoMSRCUQ1Lps5lj8tNdWLHe9h5eYNjQpYYbkrEUPo?=
 =?iso-8859-1?Q?sdMTubl2UptJYvcN00ti8Yelr2nrL2o2TvMP+MZu1vufZzuyJRh4LDQzRZ?=
 =?iso-8859-1?Q?oXC1Zat1IS+RQlhi8iGymBer4zWJFitSQT2u/FzTKMsIc7gxTkr6C7kbIz?=
 =?iso-8859-1?Q?Np0zFeiuileaE2lpHjNNJ1lOD1Vm2fpa0s6XA/xlOKpS2FBTXzeNPEa3+q?=
 =?iso-8859-1?Q?dHhqMIqaO7IdBqt8DEYeJ2Ge75BnZk+75yvCe19wao/v3BtKsUW/v1RAqu?=
 =?iso-8859-1?Q?Br4sey0nAaI5paX+XSolV6s9hR91hoq0q3U1j8P9MZAbrWVNV7nJMPncgi?=
 =?iso-8859-1?Q?AyX5z+D44ARFHRnjiPW7Yp3aXqAd0ln/W8CuVGVD3janVBiirIkdg7u4Nh?=
 =?iso-8859-1?Q?uX4bnwG972ZOPeM8lap/6V5WUtrpbl6rJRKaf1ViFI3NEwKOhBRPbPKGT+?=
 =?iso-8859-1?Q?VOl2b8FniKei2bth7WyqfmA0P4G6881l25xWsusrz5E+369zegVyQv/72I?=
 =?iso-8859-1?Q?bfZ/Zp6P3cSNph5urr3nS9LZSva3mBqG1rIj4JS1e9CJuVG8is2Hf6TwT7?=
 =?iso-8859-1?Q?cFrLcWYQ/32Yb9+USKQuTiFwLiBjAem2iDZPlKbuEz4c+JkG4lhD2XUTc9?=
 =?iso-8859-1?Q?K8qIBSvpKyGL3VPnoX/U/2y1PNHG5wyeyG41dq1mG4ZVmexUAXDnCe6CRY?=
 =?iso-8859-1?Q?fOR1EqW1Kar3qYT33Ockj5hTEJDWNYGge+hfEkVE7QsMQFiYcDJN0kcG7j?=
 =?iso-8859-1?Q?cAplQTzloBg7rXD2NbYgZACC2p3/YsitrEepPHaMNs0g3C7MxAnLw/5Oqh?=
 =?iso-8859-1?Q?ruGHG1z7EgsuQ33qXTReZfm+/dGsfw/TG/qo8GhIFZn5EZkvvGLIQptPJY?=
 =?iso-8859-1?Q?XfRf9kEQPBMYnUCBOA9OsR7Wjjv/2VX3bH1jYYhIJR/0Q=3D=3D?=
x-microsoft-antispam-prvs: <CY4PR11MB1448B3B4E2AAF2F72F012AF9E7630@CY4PR11MB1448.namprd11.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(136003)(376002)(39860400002)(199004)(189003)(110136005)(256004)(11346002)(52116002)(446003)(76176011)(386003)(8936002)(99286004)(54906003)(1076003)(316002)(2616005)(106356001)(305945005)(186003)(97736004)(105586002)(476003)(36756003)(26005)(486006)(53936002)(107886003)(66066001)(71200400001)(71190400001)(6506007)(81166006)(6436002)(81156014)(25786009)(8676002)(2201001)(478600001)(6512007)(4326008)(2501003)(14454004)(50226002)(2906002)(6116002)(3846002)(86362001)(68736007)(6486002)(7736002)(102836004)(72206003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1448;H:CY4PR11MB1256.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SoqFsN+PefEPY3jpOMTCa7SNFxft/8n5tBtPwCVDCQHk3p7QOA2lGo2NJwjgzWJ5TNcSLvXA/szMpnLWQurvvrS6H7yQU6m6egBLpQsCcObBGwiJOyQAZtjF7cxy3m7tjNLZgs3kV2ToCaGidi7Q9BYHpBupNo1jmul96ApWxW6a7wrlkFtUUc6rIGlPUUuR++AthXkd8TA5kzWAfsKC9Vllm9+zGpY/09R/pR6/Zjo+qhyJ+q0tpIJScuOXUJDFR53tm1is2SKGqonSMKF8fzcoQ27xtLsAEMjT57/1rkP1elgLWPT0zqB4UaXT78iQmyFZpk4M3rCpz6QBte1GHowc8KS7WcvcEW2tX7FYcyc1pMN0HCR3rCIaBll3ARYEWEImrr7FbeWVz8OMIdnY1AojMS2tKJHvpVxvN0p7N8c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f580ef44-8e74-4f99-689d-08d695bb9a47
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 16:10:28.5516
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

DACs and ADCs on ad193x codecs require a 32 bit slot size. We should
assure that no other size is used.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/codecs/ad193x.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 21a38cc9e3da..c16c9969d1a0 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -37,6 +37,13 @@ static SOC_ENUM_SINGLE_DECL(ad193x_deemp_enum, AD193X_DA=
C_CTRL2, 1,
=20
 static const DECLARE_TLV_DB_MINMAX(adau193x_tlv, -9563, 0);
=20
+static const unsigned int ad193x_sb[] =3D {32};
+
+static struct snd_pcm_hw_constraint_list constr =3D {
+	.list =3D ad193x_sb,
+	.count =3D ARRAY_SIZE(ad193x_sb),
+};
+
 static const struct snd_kcontrol_new ad193x_snd_controls[] =3D {
 	/* DAC volume control */
 	SOC_DOUBLE_R_TLV("DAC1 Volume", AD193X_DAC_L1_VOL,
@@ -321,7 +328,16 @@ static int ad193x_hw_params(struct snd_pcm_substream *=
substream,
 	return 0;
 }
=20
+static int ad193x_startup(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+				   &constr);
+}
+
 static const struct snd_soc_dai_ops ad193x_dai_ops =3D {
+	.startup =3D ad193x_startup,
 	.hw_params =3D ad193x_hw_params,
 	.digital_mute =3D ad193x_mute,
 	.set_tdm_slot =3D ad193x_set_tdm_slot,
--=20
2.17.1

