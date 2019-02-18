Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97688C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F5C217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="nBW1xAQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388734AbfBRQKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:10:43 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:57173 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730928AbfBRQKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:10:42 -0500
X-IronPort-AV: E=Sophos;i="5.58,385,1544511600"; 
   d="scan'208";a="27906383"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Feb 2019 09:10:41 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 18 Feb 2019 09:10:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ez82SpYZyAIQ5xL0qCMe79umRSp3574m5ZKRTm5DPk=;
 b=nBW1xAQ3Pc1bJxvTDeja+tMdONE/odlp2LyfX1tC4tk2M5hUwe9qfb7G3Jjhuzmv0X1zsrkeOjg+fbwk7UDKu0QdhQUIdnTN3SEBt+7sCOf6D0LXOHJz6Z7AeUnGi0YZ0/d/VAzz5D+Sert0mgvVSLksAEQ4YNq+S0nfB8leDqg=
Received: from CY4PR11MB1256.namprd11.prod.outlook.com (10.169.252.10) by
 CY4PR11MB1448.namprd11.prod.outlook.com (10.172.69.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Mon, 18 Feb 2019 16:10:32 +0000
Received: from CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3]) by CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3%7]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 16:10:32 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <lars@metafoo.de>, <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH 3/5] ASoC: codecs: ad193x: Fix frame polarity for DSP_A format
Thread-Topic: [PATCH 3/5] ASoC: codecs: ad193x: Fix frame polarity for DSP_A
 format
Thread-Index: AQHUx6R5fns+sZxD40mSbyebg3U5XQ==
Date:   Mon, 18 Feb 2019 16:10:32 +0000
Message-ID: <20190218160954.13929-4-codrin.ciubotariu@microchip.com>
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
x-ms-office365-filtering-correlation-id: 8290a2d5-538f-4403-6029-08d695bb9b83
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1448;
x-ms-traffictypediagnostic: CY4PR11MB1448:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;CY4PR11MB1448;23:lhzKQUJi6lLKWihKRtSSxi6B6pB1BI4ipbEsOQS?=
 =?iso-8859-1?Q?p5PeouybyVlp5+xl3/UVWSgPmiuK25mfzLeVm7jUfbkFkR7NS98fWbvQb3?=
 =?iso-8859-1?Q?7iKM8bSysSjztt7B66xv2xOLeIFg2MMGMVtu4gKLhPHkLkyQI/8rEXIDwq?=
 =?iso-8859-1?Q?RsPgQeNYhGwq6RgUZNpKDFWA/DG5j4gxopugXWIME7LO7nC1peapejQvuE?=
 =?iso-8859-1?Q?w80hp3+lwVLHHrSYo8ysUao4jGZzmYngg3BtyZIHWoiW6maJmnuKXZEZBx?=
 =?iso-8859-1?Q?svjX0bpRtdo5EU4Ki8MjmKuiLZUiG4DM6c31USFGmwBI1OLfzGS/1iZEkG?=
 =?iso-8859-1?Q?mPqXDlqi8u30MvgG4Dvc6OnvQXnCxEP3PgyK/A3RembkRuZXcUVJfL/QSG?=
 =?iso-8859-1?Q?ZSLFgCKep2fDl8P9WhqimyKo18b3YWSL6rOk87vanEkgfIKGDBNEkAkXlM?=
 =?iso-8859-1?Q?L0Y9RSw4q9SNOT4tS7GWhugholkhKWbKCAl3XgW+7KSj2DduOQM8cSPPB0?=
 =?iso-8859-1?Q?ROJGqjhHSpDDl5itxe/aaG0p2PE4htA+X7B9BlA1gSq5IuJpLdXWRMAaPh?=
 =?iso-8859-1?Q?GI+HJkBNUslNht/2T5t4ZIF6/Xn98ebNCFPNUmZ1w9vVHUSw2yzn8aYV+v?=
 =?iso-8859-1?Q?E9GLQwqwPdnd7GP5c1lXzsk9J9+TX8HqZWa2NpT8FwxayzNKHejxr7DIQC?=
 =?iso-8859-1?Q?MzH94BWlD6FOqfxV1x26Be3xTtOteS1mpFYtHq+U8NKjl4oDFiTX7yjyIn?=
 =?iso-8859-1?Q?lQgC6JtfIhjxXJ5KzXlq+sGn45fbRG+Q7cR++zRTYei734zshc92xJLYuk?=
 =?iso-8859-1?Q?HDXLlESN05Dw48MBx/kANb4MVLqJKdCYK7s16pY65ZXkNOV/TVcCX6y5Tr?=
 =?iso-8859-1?Q?bbcVlqEM9h+yXe13xBtTFhhcVX8r5LOE4uA+xH6X/9WJqUHswz7glE0bWO?=
 =?iso-8859-1?Q?gCWGgiDEVQ+YC3hUsVnkUJiHZZUq6jOG50+NbGl7NYbwSmRLyj9iAsdFHB?=
 =?iso-8859-1?Q?HLDv7zLM8Vo5n87N1Dy8aA/erkcX1ncexijPLkFQ00JCdCFXJRlC+7S/0j?=
 =?iso-8859-1?Q?ltWDrnqmvRqwPUfRe33LDdra2L/RtZqkCnSeMc0gqdhWjCzOZXfjfUo2Gk?=
 =?iso-8859-1?Q?BHs/hEjeYZSF6E+q7hzUCB4NU8gYwSII5PLN+5iLutYg2nKJv8sT2YQWB4?=
 =?iso-8859-1?Q?7vaMgHIG2J/k03cs39m3avfmcQ5W5is93vFdExhVk2ErbAtSP0noawX2B8?=
 =?iso-8859-1?Q?eCkyB6iScBLXK9Sq43Nx5MKv3/yXwAykdSTAKTZ5BjGKXMg59G6/WcPtaX?=
 =?iso-8859-1?Q?7az4cqIItSOjbGSwn25TzuE02ajrum/Gh11GE5LM5o4MKLFB9oA9T2HM6H?=
 =?iso-8859-1?Q?tCU3CTCs=3D?=
x-microsoft-antispam-prvs: <CY4PR11MB144805049F5ECF3CC0AC38B0E7630@CY4PR11MB1448.namprd11.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(136003)(376002)(39860400002)(199004)(189003)(110136005)(256004)(11346002)(52116002)(446003)(76176011)(386003)(8936002)(99286004)(54906003)(1076003)(316002)(2616005)(106356001)(305945005)(186003)(97736004)(105586002)(476003)(36756003)(26005)(486006)(53936002)(107886003)(66066001)(71200400001)(71190400001)(6506007)(81166006)(6436002)(81156014)(25786009)(8676002)(2201001)(478600001)(6512007)(4326008)(2501003)(14454004)(50226002)(2906002)(6116002)(3846002)(86362001)(68736007)(6486002)(7736002)(4744005)(102836004)(72206003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1448;H:CY4PR11MB1256.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e8wmC1igKJ9cJX1Pd1eOmfRUu9c3QPCqjh+IqA5Bah/DYKpP4m1dkRScn5VCE0stXZH9DX3zglytvHJYaZy5XqxVQDj48vmhlaDZMbUy98Cgi2I6siLt+bk8w1Cs3epUvjD01p07y/a4cRhPiU/GDAAkidqX4fWhCjvpvvKH+3vrqlO6pO6I12vo+UTVyF7bMT8Ni5vQ5WVLTxCwkPkDvVDw/BDX0YL+deKzjRD0ME/b5iSSWyLneILfZcTBFIcNeOYZXjOnW1PyXDbhnN+cI9yWyp4sp4SFggOrEIVZ8XOtMy6FTIIGAybaNOp0cr9CA+hZ1bnLDZcGIYsbEYCo9l7oYdL2D/HFmo17PVyx/5Hg64a0WOBCjuSqXOVVxJgwK+hWyjswV4cfyY4qlgAyvc8lnVTnefYegDMOJJLqTWk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8290a2d5-538f-4403-6029-08d695bb9b83
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 16:10:30.6003
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

By default, the codec starts to interpret the left (first) channel on
the falling edge (low polarity) of LRCLK. However, for DSP_A, the left
channel needs to start on the rising edge of LRCLK. This patch fixes
this channel swap by toggling the bit which selects the LRCLK polarity.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/codecs/ad193x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index c16c9969d1a0..315ec9775118 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -228,6 +228,12 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *code=
c_dai,
 		return -EINVAL;
 	}
=20
+	/* For DSP_*, LRCLK's polarity must be inverted */
+	if (fmt & SND_SOC_DAIFMT_DSP_A) {
+		change_bit(ffs(AD193X_DAC_LEFT_HIGH) - 1,
+			   (unsigned long *)&dac_fmt);
+	}
+
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM: /* codec clk & frm master */
 		adc_fmt |=3D AD193X_ADC_LCR_MASTER;
--=20
2.17.1

