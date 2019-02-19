Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DB8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482622147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="EoAxEwk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfBSQXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:23:33 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:53649 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfBSQX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:23:28 -0500
X-IronPort-AV: E=Sophos;i="5.58,388,1544511600"; 
   d="scan'208";a="24900744"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Feb 2019 09:23:28 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 19 Feb 2019 09:15:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JY7GvmbuAaxNBLOEE7xZE1/vfiU3KrxExZBcGNXC7wY=;
 b=EoAxEwk076lks+3ECu0q4AHx48zXw9ixwqhUeB4jUG3lWQdKAVX/3roUwKH3s8yQZUS9Sn0hHT4n4UQp3/3wW9nX93GCX9N5kirHbNnL4bSXvf+q57en+rIpcNUW2PTm11BhGMBjl0IWY/Lb+HAO0G2Lr2Cs710fHav3EF8XD54=
Received: from CY4PR11MB1256.namprd11.prod.outlook.com (10.169.252.10) by
 CY4PR11MB1894.namprd11.prod.outlook.com (10.175.61.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Tue, 19 Feb 2019 16:15:45 +0000
Received: from CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3]) by CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3%8]) with mapi id 15.20.1643.014; Tue, 19 Feb 2019
 16:15:45 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <dannenberg@ti.com>, <m-stecklein@ti.com>, <afd@ti.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH 2/2] ASoC: codecs: pcm186x: Fix energysense SLEEP bit
Thread-Topic: [PATCH 2/2] ASoC: codecs: pcm186x: Fix energysense SLEEP bit
Thread-Index: AQHUyG5eWxMaMcb2I023e1WqlUDrqQ==
Date:   Tue, 19 Feb 2019 16:15:45 +0000
Message-ID: <20190219161518.1331-2-codrin.ciubotariu@microchip.com>
References: <20190219161518.1331-1-codrin.ciubotariu@microchip.com>
In-Reply-To: <20190219161518.1331-1-codrin.ciubotariu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P194CA0054.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::43) To CY4PR11MB1256.namprd11.prod.outlook.com
 (2603:10b6:903:25::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Codrin.Ciubotariu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82fd4bd7-ecc1-4b70-df55-08d69685804c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1894;
x-ms-traffictypediagnostic: CY4PR11MB1894:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;CY4PR11MB1894;23:k1OfuaXAuEHisM/3fWO1YfLLsAUVzVFHySwC2IZ?=
 =?iso-8859-1?Q?KTf51qZ6jpORDBSo6ET06m6Ux4LmZFylSTZYBC5lMsJ7JcR59lm7pDiPp5?=
 =?iso-8859-1?Q?h0ak9wLdS/PkT8akuvE2md0Rl0w1EbkJxBTNTWoXkT8YRDgZCiXNTr/gpz?=
 =?iso-8859-1?Q?ChQChN+aMkzqNYQ9f4OMdaD5dAqyVHmk5lIcmEykEsglJlJc3vEl1JTjJX?=
 =?iso-8859-1?Q?GT2PDjK6SviEYYQElanRGn7uuIHq6jkFS1/Dkc+Q/QpK4PUw2fon/zDU0/?=
 =?iso-8859-1?Q?MRkoetJkET/CtiNhtP0hLnDqAbF63BOqYjSulEv/C2ZM/+gnVY5JOmrfVO?=
 =?iso-8859-1?Q?IP4try8Kj6t68ssmEXE25J1Z88Wn3XKzhm5+Ia2oRrgJpuX5cPUez/BuKr?=
 =?iso-8859-1?Q?xnYSmGJvDnu5l+0j23ulUWUmxuaDmh38uwrdXnSuwJIqnBFm4Bna1TFCn5?=
 =?iso-8859-1?Q?YopjckjIj8V7rACex09Usg/gRGd5RXq+RaF4tV5GMT+2lJ6KqQhyZFWvAe?=
 =?iso-8859-1?Q?0BAvTAidRPxIL/fqTVUmRRl21LWIqRRIDOjDCzknNTfcalSKk2klAE0K7N?=
 =?iso-8859-1?Q?vcfAesi1QdNyySwyvnjtouMZXPvF/w+w/IXobU1gLx9ooDXhlPHRFGQmr+?=
 =?iso-8859-1?Q?Vxxf1/IJRp+D4ppex7/K7g/3S/0VxsULIX9o/YqafjHuk1cjg2fCDFDNsq?=
 =?iso-8859-1?Q?+LgAtltlNBPl55fzhLwO+l0it4z3jf9xZjQXDNergzzyOnD/oSSlZMbbVS?=
 =?iso-8859-1?Q?gnj9MU4aq7PilvrXHQJCNxJcgbiVZHXtUUhdUUhsINdCM0ape6IhdfyKaq?=
 =?iso-8859-1?Q?3n0tkAPTSg5BlC1gmvGqacVaOTCdu9a88QcBJSRqWJQeF1onCx64CiIe5d?=
 =?iso-8859-1?Q?MfOWw7J1qSKuBxMc3KLctRbzw72JeN7JAPXL+FdPRanSy6zmssv0sFBowa?=
 =?iso-8859-1?Q?eiHsjD6SHU/l7yj9zqnKwrf1pSq3oseBC8onOFMEw7WnT9Dj1jZxLBNTJz?=
 =?iso-8859-1?Q?hKcr+R70CEXdlBD3lnr+bkl37BOO7GdSBx+uH24uLn9QmchxniEi5foFaS?=
 =?iso-8859-1?Q?/360nlv5ShLyImFDYgpMMzhJg9W2CapKZX5h3eN2sDi9gFv3UP5hSEH8qP?=
 =?iso-8859-1?Q?QNXgKZctJtoCRr9W/Rf2Cz13aK8lGNwpFpHCwzEkw3+V9wZNvj0eUce7mu?=
 =?iso-8859-1?Q?sIkiA2RMT4XAf2uSiz77pk192K/dAwQRz1yPQf3LJmTNStUtBuGOuLLiWK?=
 =?iso-8859-1?Q?dcYbrg00YmgOLmu3AOIh+28QSPXUdUmxYDRgPb2ziiFhmUX3+/mVfB24m6?=
 =?iso-8859-1?Q?zrNYtCh5thOaBgaHZpK6+rKyhESD9nTsu4Rak4Vf7+uwA=3D=3D?=
x-microsoft-antispam-prvs: <CY4PR11MB18942D91E47D3F173FF942FBE77C0@CY4PR11MB1894.namprd11.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(366004)(136003)(396003)(189003)(199004)(81156014)(81166006)(2906002)(71190400001)(256004)(86362001)(52116002)(66066001)(5660300002)(14454004)(6486002)(11346002)(97736004)(2501003)(71200400001)(107886003)(446003)(476003)(50226002)(72206003)(4326008)(105586002)(8936002)(8676002)(25786009)(2616005)(106356001)(99286004)(110136005)(76176011)(486006)(6116002)(3846002)(386003)(316002)(305945005)(478600001)(36756003)(26005)(54906003)(68736007)(53936002)(6506007)(1076003)(102836004)(6512007)(186003)(6436002)(7736002)(197533005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1894;H:CY4PR11MB1256.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ajKOrcxpfMye2EKO5iJosr0wF7MC8dlEUEgw1MC7GDNZcELQoiy7RUdnJU3i96tQeZBo7u+H5ExLnPbCluhokqvITzci9sSleIutfeqxz4AuZTPOcEpidn1Qpe2uD4tkj9i0pR3bgByrJrqCPuRy9vMwMB4VLRmNZRR7TEPa+A4qwvflPgq9XGoUdRuesfTJ6uLglURZr6LV7mzOWPZY6xwj6pKRt2KL/Skt0MCZD6uCERHKxJ/nppH8g9/xVf6FrXVrmYt2zqnD+MGY1fW2o7PLS583Fgzz6x9w5BpywAEuInbJLy4BgjNLxWqxO5dU5C68+3jjCaXR3HJ0dtvRlYpNQI6Ys4P0ByFaHGiR5brHkopL6BJRFDOzAJc4R7VST/J5xjnUX0G8YSoTBWsNEGdmboLWX0Xr8/4LNN4BLxQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fd4bd7-ecc1-4b70-df55-08d69685804c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 16:15:42.9020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1894
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

The ADCs are sleeping when the SLEEP bit is set and running when it's
cleared, so the bit should be inverted.
Tested on pcm1863.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/codecs/pcm186x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/pcm186x.c b/sound/soc/codecs/pcm186x.c
index 7947279243f9..4477d678797f 100644
--- a/sound/soc/codecs/pcm186x.c
+++ b/sound/soc/codecs/pcm186x.c
@@ -157,7 +157,7 @@ static const struct snd_soc_dapm_widget pcm1863_dapm_wi=
dgets[] =3D {
 	 * Put the codec into SLEEP mode when not in use, allowing the
 	 * Energysense mechanism to operate.
 	 */
-	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", PCM186X_POWER_CTRL, 1,  0),
+	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", PCM186X_POWER_CTRL, 1,  1),
 };
=20
 static const struct snd_soc_dapm_widget pcm1865_dapm_widgets[] =3D {
@@ -183,8 +183,8 @@ static const struct snd_soc_dapm_widget pcm1865_dapm_wi=
dgets[] =3D {
 	 * Put the codec into SLEEP mode when not in use, allowing the
 	 * Energysense mechanism to operate.
 	 */
-	SND_SOC_DAPM_ADC("ADC1", "HiFi Capture 1", PCM186X_POWER_CTRL, 1,  0),
-	SND_SOC_DAPM_ADC("ADC2", "HiFi Capture 2", PCM186X_POWER_CTRL, 1,  0),
+	SND_SOC_DAPM_ADC("ADC1", "HiFi Capture 1", PCM186X_POWER_CTRL, 1,  1),
+	SND_SOC_DAPM_ADC("ADC2", "HiFi Capture 2", PCM186X_POWER_CTRL, 1,  1),
 };
=20
 static const struct snd_soc_dapm_route pcm1863_dapm_routes[] =3D {
--=20
2.17.1

