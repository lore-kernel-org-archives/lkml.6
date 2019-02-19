Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D87BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B35520823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="fClR5lfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfBSQej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:34:39 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:7443 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbfBSQej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:34:39 -0500
X-IronPort-AV: E=Sophos;i="5.58,388,1544511600"; 
   d="scan'208";a="24901264"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Feb 2019 09:34:34 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 19 Feb 2019 09:30:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crtjtMQSrRaTjDy4m7C1xfz537DF4tJ32eUdO2pJXKI=;
 b=fClR5lfUlnYLRGRVXsIiLg4uehMZNufVtqLpqyy48W2PuZoOjgbO/PX8vKpSiy9B+B9AbRXBQmbjs8QOQ+heUUyK9YcfV0YA4dITPAlNdKMuQv9Na7yOBqiJJDEjJuF8OYrtRTv33VjctQJjL+LIyY4W7lG8BXIQWtA9aH91b94=
Received: from CY4PR11MB1256.namprd11.prod.outlook.com (10.169.252.10) by
 CY4PR11MB1749.namprd11.prod.outlook.com (10.175.61.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 19 Feb 2019 16:29:28 +0000
Received: from CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3]) by CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3%8]) with mapi id 15.20.1643.014; Tue, 19 Feb 2019
 16:29:28 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <dannenberg@ti.com>, <m-stecklein@ti.com>, <afd@ti.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH v2 2/2] ASoC: codecs: pcm186x: Fix energysense SLEEP bit
Thread-Topic: [PATCH v2 2/2] ASoC: codecs: pcm186x: Fix energysense SLEEP bit
Thread-Index: AQHUyHBItzr+dNeZQEqfT8mjpFYo1g==
Date:   Tue, 19 Feb 2019 16:29:28 +0000
Message-ID: <20190219162840.7244-2-codrin.ciubotariu@microchip.com>
References: <20190219162840.7244-1-codrin.ciubotariu@microchip.com>
In-Reply-To: <20190219162840.7244-1-codrin.ciubotariu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0033.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::22) To CY4PR11MB1256.namprd11.prod.outlook.com
 (2603:10b6:903:25::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Codrin.Ciubotariu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83ebb59b-2226-4077-6b46-08d696876af8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1749;
x-ms-traffictypediagnostic: CY4PR11MB1749:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;CY4PR11MB1749;23:3SOtkEQ2Z2V53mwqQPzWkFNfBFGMGS+kuX4KZLA?=
 =?iso-8859-1?Q?gfIILaJTB97k9ny6G0/j7WnEJID6CjY2gq/vxhbFKSIfkIPyBjSWsEVma/?=
 =?iso-8859-1?Q?HI9g4gMuF1wW7nJE6RPUEMa52wBmVhtfdb7Hr8Z2hoHqCLP5SDLgrqsi+1?=
 =?iso-8859-1?Q?m+p36G8NYEn9VOSSHd0I8CmQ1oHNRMj81+n33KGR2cw+otuLpuYiflLw49?=
 =?iso-8859-1?Q?GC9yWiDWcZ/SykIbRGO6AlEsBG6Z11bJIc2Yvusmddd7s21RJV4B7guW+1?=
 =?iso-8859-1?Q?F37lo/QEkPSUlYunUm43kYw04tIjQp36vVoqeby5cRDta1PNwMsqJWuvvZ?=
 =?iso-8859-1?Q?s86s401AphNXnLFGMpkYgY/La1+He5LiQNdwXV2zWf4m4DBAJVPvInf+S6?=
 =?iso-8859-1?Q?gFb1djhv32hk/6KW1GWVdKt8Es3zdYJGPzLVIcnIrIItM1ylIJcOeuinAL?=
 =?iso-8859-1?Q?UJNo4FuXX+Rj3PwyolGYvR6qn7mgo3WIhYtk6YRM9nGkfz8zeIvUOy3EpM?=
 =?iso-8859-1?Q?9cdGnVZrSbNYBeyVMURw/GHyTLxPgQGyJQbOTGYYg34rOJx2+3XhM3p1Sg?=
 =?iso-8859-1?Q?Es2KrB0y7/cBSLAQb+Hji0wGeTEsY7t7qCF4oXli1TGqD5e1Im5HMrnN5x?=
 =?iso-8859-1?Q?yzPEmEJI6bBEfAifa8E6NgiJncd6OdWdnRgX/UntXWo9eF3rEBsQre3ojC?=
 =?iso-8859-1?Q?T8lsii1KxUic/tb+cT+oJTytjwrimCaWBv+ZWlp8umy6JXlDo3DAoB8MLo?=
 =?iso-8859-1?Q?0KNrwOtWJfSCSjLtZjNOk0eGUMlSnyTWKI3bDYkYlpXeYzIjuLBfqrFkaA?=
 =?iso-8859-1?Q?lb5p6sJ3EpMV32NWKGTZvE9ZEwYwxtl3ZeLUhR6wqsG4EcKfaPrM89VS+8?=
 =?iso-8859-1?Q?0DBPrWsw9BT0657a9UxuakzHuUEnlQSOIDhTLAN8vHH09l+SaFnscmJJ4d?=
 =?iso-8859-1?Q?ooShgrZblx6PSYUQW6sJXz+NmCqbJ//eBP3zYJFFQORwdTTXSoenY1MqYw?=
 =?iso-8859-1?Q?cKHSK3OCZZveLQKRFQmXK2Z7LTVAimgHPU+Jm9aneciSA04xMdgtx3WASK?=
 =?iso-8859-1?Q?Pr962JJUu3pcSIo+zuT5V1K2Ud8CsV+zbH5n9QNnj5aLSUi/S5wtcwGKrY?=
 =?iso-8859-1?Q?4xxkhLHbqfaS2/Ti9c3AzQ2XrXhOKII0J7FibM3rvHzon4EnKb/05qtyEX?=
 =?iso-8859-1?Q?IID3s5uMzdoNAf/rpMJrUpx94LmIZRzAFqyUxTDyFq/rVdZBA7BnsXrYFQ?=
 =?iso-8859-1?Q?GtelefrtBAdKTiicVXYUVOr5urPBabC6/nJmkVgTO16DzuJh51y3PXcuV6?=
 =?iso-8859-1?Q?uQ4wiEj9STFLY6FeWTc99e5zu4CbTEVnLyThKfXkCqg/w=3D=3D?=
x-microsoft-antispam-prvs: <CY4PR11MB174967D741404B3863C61C0BE77C0@CY4PR11MB1749.namprd11.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(136003)(39860400002)(189003)(199004)(8676002)(3846002)(6506007)(8936002)(81166006)(81156014)(386003)(36756003)(50226002)(6436002)(71190400001)(71200400001)(478600001)(6116002)(53936002)(72206003)(1076003)(102836004)(5660300002)(305945005)(6512007)(7736002)(66066001)(6486002)(68736007)(2616005)(476003)(25786009)(76176011)(486006)(106356001)(4326008)(105586002)(52116002)(97736004)(86362001)(14454004)(26005)(256004)(186003)(2501003)(107886003)(2906002)(316002)(54906003)(110136005)(446003)(99286004)(11346002)(197533005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1749;H:CY4PR11MB1256.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xEnY8F7U2S1ultVzx29XJGYrlihn8GIg7DTw21IG4j/BQFQb3dIq4nmH86UOQVUeK1dE4VWzgErQHKR7WoAUpAf0o6WqzUwx/dPKDepOfNXuiO6FjuU0HNbBY0py1kV+Wk7wZkbWw9XVjxNszntzJRPpWehA9NtvSNpZcn4W2VDiUvMKOxmZKXhXPZ5OF4GzEVeu6JfU+GyYWDF2icv4ryWcVZnkBUMVp0pbs5IXSaDYVM2LsorDLMa0UPjtRmMah+msJMCNVJ9gShLxnexSkjbLf/ilV0Dw0efBPlAs9zddobfBG5DQRbVGHn742M1GuGe+KZn87ySeijaU2I679ciXMXsipBWbwowDwuj+CYQX6cei8er3h0XmbCHb9BWTAqNliw5p2AP4Xk78kjLkD384sH/HvYagYC4pR8LTP4w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ebb59b-2226-4077-6b46-08d696876af8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 16:29:26.1206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1749
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

Changes in v2:
 - none;

 sound/soc/codecs/pcm186x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/pcm186x.c b/sound/soc/codecs/pcm186x.c
index c36a391fec8a..c5fcc632f670 100644
--- a/sound/soc/codecs/pcm186x.c
+++ b/sound/soc/codecs/pcm186x.c
@@ -158,7 +158,7 @@ static const struct snd_soc_dapm_widget pcm1863_dapm_wi=
dgets[] =3D {
 	 * Put the codec into SLEEP mode when not in use, allowing the
 	 * Energysense mechanism to operate.
 	 */
-	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", PCM186X_POWER_CTRL, 1,  0),
+	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", PCM186X_POWER_CTRL, 1,  1),
 };
=20
 static const struct snd_soc_dapm_widget pcm1865_dapm_widgets[] =3D {
@@ -184,8 +184,8 @@ static const struct snd_soc_dapm_widget pcm1865_dapm_wi=
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

