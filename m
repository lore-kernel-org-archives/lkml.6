Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E844C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D3D218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="tIk25BrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388641AbfBRQKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:10:34 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:57165 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731529AbfBRQKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:10:33 -0500
X-IronPort-AV: E=Sophos;i="5.58,385,1544511600"; 
   d="scan'208";a="27906366"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Feb 2019 09:10:30 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 18 Feb 2019 09:10:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgZGsr0wyVXcuf+ruQyQVw08DNH4i17utmx7bVVuKd4=;
 b=tIk25BrYqNl6Qc6vIVpRGp2QDFzVQrZ8xp8GVsgaHB8YlqhREDP47EUz9pYKlHUhHg5M3G9HkZM4uE7VAtrtP+mxcGIbfIODEW1D6egpGt83Od7xl7b6/a8yc6xzApTV3vCqBUYYK2w8FHMv0qX4buKQc5NdtLcRJcEW/qe6Igg=
Received: from CY4PR11MB1256.namprd11.prod.outlook.com (10.169.252.10) by
 CY4PR11MB1448.namprd11.prod.outlook.com (10.172.69.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Mon, 18 Feb 2019 16:10:28 +0000
Received: from CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3]) by CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3%7]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 16:10:28 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <lars@metafoo.de>, <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH 1/5] ASoC: codecs: ad193x: Remove capture support for codecs
 without ADC
Thread-Topic: [PATCH 1/5] ASoC: codecs: ad193x: Remove capture support for
 codecs without ADC
Thread-Index: AQHUx6R2TxqbrV0Takq7kytYHJYBBw==
Date:   Mon, 18 Feb 2019 16:10:28 +0000
Message-ID: <20190218160954.13929-2-codrin.ciubotariu@microchip.com>
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
x-ms-office365-filtering-correlation-id: 3b247116-e956-4b56-1ccb-08d695bb9923
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1448;
x-ms-traffictypediagnostic: CY4PR11MB1448:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;CY4PR11MB1448;23:X+Nk0DOXv6BlQUg5dsUhHW0aUNev0xYlykMybG9?=
 =?iso-8859-1?Q?VrQNWrO0hozbJJGHBNeWUP/QrQDLHBmOZYlaPslfklXah7MzDNAQIctx1P?=
 =?iso-8859-1?Q?1NiD8OvlvBOrjSljLZ6c4DHZXLFNGX8mrAbS0qQ9HapX53CT/BXxRTMoHF?=
 =?iso-8859-1?Q?lsz7lp9425NsxDoKRrdU6zX5VyBeF7kWRiLbC6IAG31Ek7RW/A/tgF3cPJ?=
 =?iso-8859-1?Q?Mh/b7qVkLstuzSPRPaAlW01SCoqTu6JqquY0/C+PWeC4TuGP9rtR9Sy39Y?=
 =?iso-8859-1?Q?2Oe05ENDMPxdW7zKoCLqoCuSvKyI3PhwbGtyEnArqojimrz4aT+oIFzCcu?=
 =?iso-8859-1?Q?+F7aICoKCf9cCStCG8yvWdi0NSR0Ab4O3R6/DmcsEj3sZ9V1QuS6xwZrHD?=
 =?iso-8859-1?Q?MMD5UCyFNvzGeAiH9Qq66xrx8g4eX+TL1Js38dCQvbJwca9kd6KRtW+PrL?=
 =?iso-8859-1?Q?wEzpeuLSqyeohahzS6Hcbf/qpkCb6O+78QSMq567Uu/BMOTPPW877bTCep?=
 =?iso-8859-1?Q?WUMLIp4RClZoR7KqyK+zJs5/c/4dmEPGOHhD9XUZwMZP8HoV6br5mk11Pg?=
 =?iso-8859-1?Q?OEZtXd37rRK43fCvc2/qGd9GKli2QrCAFdnon/gp+gqsy2NVyktFJS0Kyc?=
 =?iso-8859-1?Q?HLAkZ9MWn1ZwTrkgckoOE7lh5wGecmQ4ek6agIe05KezLS7VxCvfSBf5JO?=
 =?iso-8859-1?Q?xUQABFYVgwGEQIGxvdOh7ySg/GBMl20h4B9MUS5qMmM8QanEGtaz1btC/O?=
 =?iso-8859-1?Q?8Wk1Lcds+Ei36khY+oiUm9wXeZBhNCR7crW5YGjrO9emFjx4f8iGHL6GXB?=
 =?iso-8859-1?Q?FU/p80qT7aNM0hiUaVWZEkRWDffvcexLRfQ6qDtKCc33660vfXYNGd9w1n?=
 =?iso-8859-1?Q?E1KL8b9Vc8fssso7vA2cAQYJkJ43+PjLPhAqgMx5CVjNTeLnSQv7s5iodg?=
 =?iso-8859-1?Q?0pk4NwgqnXVJbAzvyt9FsOiBRcaYLiEkQKnsYNOiW6TWGz+JeWh4wiEcJf?=
 =?iso-8859-1?Q?Vu4O5O/paJ1mZOHz5B9OayLDVw5Q0aK3DPSNc6AR6rxltfXxx7hu5oFPEC?=
 =?iso-8859-1?Q?SD59XVMLegrQ7XP3qshs3DsgcEi2arRzJUjxX0TLAS5vU3ylK/TLeVZdC6?=
 =?iso-8859-1?Q?HW5qwyuXjQy94j2B4wZSFFaFlxOp5Cm/md340D00a9YmI2i0RhR0lDGh0n?=
 =?iso-8859-1?Q?2KUlgul48+5nxL+aITHIENBKUDXDBhEEHAtctQBN4jhn2XJNu5zs6NvC++?=
 =?iso-8859-1?Q?ubJPqSB2zhy70c2fDD3HrlEyBe3tC6qlfvmYPVUXZCGsJh2ZXrTpjLxD6e?=
 =?iso-8859-1?Q?ZQMC7jGv8f7mQ1gW5wlbnmL6TyLQ4tvOslIq+UxwaT452qF1FNea7Ymdl+?=
 =?iso-8859-1?Q?meHOrfa0=3D?=
x-microsoft-antispam-prvs: <CY4PR11MB1448396142C6B2C623793CB0E7630@CY4PR11MB1448.namprd11.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(136003)(376002)(39860400002)(199004)(189003)(110136005)(256004)(11346002)(52116002)(446003)(76176011)(386003)(8936002)(99286004)(54906003)(1076003)(316002)(2616005)(14444005)(106356001)(305945005)(186003)(97736004)(105586002)(476003)(36756003)(26005)(486006)(53936002)(107886003)(66066001)(71200400001)(71190400001)(6506007)(81166006)(6436002)(81156014)(25786009)(8676002)(2201001)(478600001)(6512007)(4326008)(2501003)(14454004)(50226002)(2906002)(6116002)(3846002)(86362001)(68736007)(6486002)(7736002)(102836004)(72206003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1448;H:CY4PR11MB1256.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nDJwqf6G/UAW/rhMz8AsayTfXkdGPQ6HSBGCKXyZ4LvqPFKNdv0LmZVXMYbpzMkaY/5W03ZTWwQe6hEw8OddBSuqFjZcItqcCrSHvHZxwnxxe+J7bKIA2LuJENd3vvbowuSvpGnnWNlf1imDZVSxYLbO3k25HfyqKG3Tr8QZrBqKI2cgcKLI9ixkxRgTyOxOU/v3zY1jh0n0INBA+EXosFraZi2bZ/cmR1X63pThqR5cZVXSqeqfS9tTSmClhDiaWLyOfb6K9AjqE9gEh2RiibcCZzWHbtDXZ7soK+A/mecSd3YZbx6kOlslnCQZ3RCwep+j49yN9HXNNuoO+/1Admastdw30ROlv4MjDNRiHSquZjzR/wvDlJLoBN/BPiUqWjxkGIb7E1vxyfFs3wcApJquP38GTRIKT4ydDaEKs5g=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b247116-e956-4b56-1ccb-08d695bb9923
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 16:10:26.6120
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

Some ad193x codecs don't have ADCs, so they have no capture capabilities.
This way, we can use this driver in multicodec cards.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/codecs/ad193x.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 4b60ebee491d..21a38cc9e3da 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -351,6 +351,20 @@ static struct snd_soc_dai_driver ad193x_dai =3D {
 	.ops =3D &ad193x_dai_ops,
 };
=20
+/* codec DAI instance for DAC only */
+static struct snd_soc_dai_driver ad193x_no_adc_dai =3D {
+	.name =3D "ad193x-hifi",
+	.playback =3D {
+		.stream_name =3D "Playback",
+		.channels_min =3D 2,
+		.channels_max =3D 8,
+		.rates =3D SNDRV_PCM_RATE_48000,
+		.formats =3D SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+	.ops =3D &ad193x_dai_ops,
+};
+
 static int ad193x_component_probe(struct snd_soc_component *component)
 {
 	struct ad193x_priv *ad193x =3D snd_soc_component_get_drvdata(component);
@@ -444,8 +458,11 @@ int ad193x_probe(struct device *dev, struct regmap *re=
gmap,
=20
 	dev_set_drvdata(dev, ad193x);
=20
+	if (ad193x_has_adc(ad193x))
+		return devm_snd_soc_register_component(dev, &soc_component_dev_ad193x,
+						       &ad193x_dai, 1);
 	return devm_snd_soc_register_component(dev, &soc_component_dev_ad193x,
-		&ad193x_dai, 1);
+		&ad193x_no_adc_dai, 1);
 }
 EXPORT_SYMBOL_GPL(ad193x_probe);
=20
--=20
2.17.1

