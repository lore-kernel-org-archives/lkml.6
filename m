Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC10C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06CE2183F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="cqWgiMud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfBSQX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:23:28 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:53649 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfBSQX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:23:28 -0500
X-IronPort-AV: E=Sophos;i="5.58,388,1544511600"; 
   d="scan'208";a="24900743"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Feb 2019 09:23:28 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 19 Feb 2019 09:15:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2ALYGuUtMAD5CLQ0EeOIvbCgyLbfb0kQAVgZnmJH8E=;
 b=cqWgiMudzHc5JD/hplbjtKZG1b4ehbUf2fj7eMfoovUOGdnebTlFOsHYUiNmimZr/xnMgzg0qmlfaN4b1lcuowC59KJmMiYfB1ne0fA2tod/mNiyz6UlTw78F43VrOpj57ogU7woWcQ//JJXM+nqwwMq9LG2fAokfJlmHNswNtY=
Received: from CY4PR11MB1256.namprd11.prod.outlook.com (10.169.252.10) by
 CY4PR11MB1814.namprd11.prod.outlook.com (10.175.60.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 19 Feb 2019 16:15:42 +0000
Received: from CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3]) by CY4PR11MB1256.namprd11.prod.outlook.com
 ([fe80::d9cc:7741:4930:cda3%8]) with mapi id 15.20.1643.014; Tue, 19 Feb 2019
 16:15:42 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <dannenberg@ti.com>, <m-stecklein@ti.com>, <afd@ti.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH 1/2] ASoC: codecs: pcm186x: fix wrong usage of
 DECLARE_TLV_DB_LINEAR()
Thread-Topic: [PATCH 1/2] ASoC: codecs: pcm186x: fix wrong usage of
 DECLARE_TLV_DB_LINEAR()
Thread-Index: AQHUyG5ckbI47UgWGkCR6aNSYU4cPA==
Date:   Tue, 19 Feb 2019 16:15:42 +0000
Message-ID: <20190219161518.1331-1-codrin.ciubotariu@microchip.com>
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
x-ms-office365-filtering-correlation-id: c59cdd9b-ec49-42dc-7080-08d696857eda
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1814;
x-ms-traffictypediagnostic: CY4PR11MB1814:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;CY4PR11MB1814;23:h+BhzaFJiKq3FgYzXA1cA0RwnHkMPIYkAtKkmNf?=
 =?iso-8859-1?Q?FyceOXkH+83WgQe+R+mDmNWVYZBqCUxGpBn+/HjIRZ64B2WEmXEcG300XS?=
 =?iso-8859-1?Q?PWdbI3UDhFoCQmW6xlgB5Ik0BQ8X+cSxmHqr2+pDWOPijJhb9nqflNVOxT?=
 =?iso-8859-1?Q?50c1eP2EjCIXPfcR+gBRIiyrK2PK9rIaceQDd59eROGK3Gsq1H9fP80RgH?=
 =?iso-8859-1?Q?hOs0cSUJ3w6cY7qQANTsooKjnLvE7jpIF/kLj2DEyQaGSzR29dt+fOoxOX?=
 =?iso-8859-1?Q?4dMK3M17E6njaYUVL0nDKy8tN9YUUmmuoBb5pEfBBFQS5KMHhJWUoRXYiR?=
 =?iso-8859-1?Q?C9czZqeA5guKlHv4QKS9DQCr6UaC8vWpqG87VN2Da2HW0CA9O3TFqnd8It?=
 =?iso-8859-1?Q?DYnyiOKSQI7fE7M994U1Jg/VaDWBsa8RHRk3w31q39FKH8kbG2sPKfJ7gD?=
 =?iso-8859-1?Q?0dguWlzOlr16UOwL2yWg1k5LxEaX6IuneDN040lwlc/V0CYwPwg8RXlGcv?=
 =?iso-8859-1?Q?GrqrZpj52AeGDvYsIP10/G3mA/ANnbrtcQoB2vo1K/MEucVEu7bHdZNGkt?=
 =?iso-8859-1?Q?Rg0Pzu9qGnQudV1Knt46ikVHDJxh+jMQZ+yfLf7xyJ+9dZTgqUq8SnEPpG?=
 =?iso-8859-1?Q?3gXUv+7iQLYykgoVvJsaCbNFb55i89qtpGcqe7ncMSl97fsky09lVNx/kj?=
 =?iso-8859-1?Q?LKRYOOMuMxclx9tj8hqHyfUu2FLZNN2Q8aTmdkaDaugeq1bNXRaKZ52Ilm?=
 =?iso-8859-1?Q?rtiUnHgSVo9pYu1Nws3Kp1GpP2F2+75cWgk6kKylMQxiU6rLDDS3akIKCY?=
 =?iso-8859-1?Q?uQwfJ1HL69rnD7fRF4nDAGiPNp4JqCuw33OWB+GQQ9PLtkzGyKFs6uk2IC?=
 =?iso-8859-1?Q?ssxUJbsJVUaEsJsQRNh1wUapPGa5k/mbPca5e4yw3SIoZUym51AravTdsJ?=
 =?iso-8859-1?Q?8a11OToE7FNSf4spGjBoA5IUyY3D9JDcXVOwmDESm3g5WU+JWMZ/CQBULr?=
 =?iso-8859-1?Q?6RQ+z1HIY/Chki3ZTefzNnv/VkbnZtYrPR2wrZkWTlAn/2PwBpL9NERnz/?=
 =?iso-8859-1?Q?sJO+vjQqsVdqjjoKwXcj4fdmctKExPhLFMK/AQiO96PZUFwY7MK+7e9v3k?=
 =?iso-8859-1?Q?4fbNqlAZ5vxx18j8yhLlejqb/JHI6X6T19qONPpdU2zoKmT8Gqm1WP66y5?=
 =?iso-8859-1?Q?HErnI09Fsf24r1lNNPWhxFN4KEmh10MbZSxu68XVFOuoi1tJkzJbBlKUl4?=
 =?iso-8859-1?Q?+55xXNbp7OaV+tLQIhyCrFeYLxY2z+k1YXKp7rA=3D=3D?=
x-microsoft-antispam-prvs: <CY4PR11MB1814EB9F20AA2F612CF0E935E77C0@CY4PR11MB1814.namprd11.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(136003)(396003)(346002)(199004)(189003)(6486002)(107886003)(476003)(6436002)(72206003)(26005)(2616005)(4744005)(25786009)(106356001)(1076003)(53936002)(486006)(97736004)(105586002)(5660300002)(186003)(2501003)(6512007)(4326008)(81166006)(81156014)(8676002)(71190400001)(68736007)(316002)(478600001)(110136005)(86362001)(71200400001)(66066001)(52116002)(256004)(6506007)(386003)(305945005)(7736002)(102836004)(50226002)(14454004)(99286004)(8936002)(3846002)(6116002)(36756003)(2906002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1814;H:CY4PR11MB1256.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ztBvgqLzhJjl782V/UmBt7v44y6KZVwzpRmegX8D7w3YWnUdrD4tPVtBw5ijqNRTf5FrsdsiEd0xDGFXNog/sdYfTiCVXPX6hB9q+YwTN3FKogaCO5JroJ3tiVAyRdr6PoOCqqPswzuMeVjFwL3s4LlotXsdwaaOCFgW1hi8x+gJxgsQEpk7wSBNzYkJOhtW2HLCQEZ6dwGWyljKnZtpj8/9pC3B+T961ENqdHeWjuLYIiRAo3u2QL2YpAVbRGAxtJ7EtMnA8m6Me2bYXu4A0uhg1HATD4M9xQhNoFK85HO2m7A9EKc5B0elkMOaUhfN6mruc0oGaH8+894sjvDBLESbetOJhx2DBbN11sBhGia9N65gsR+5tuFdFtmrP8nXJoZzfUcDpOlnungQEdnPX4/+OLS5Ny6GUzvGPBU4YpU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c59cdd9b-ec49-42dc-7080-08d696857eda
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 16:15:40.4880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1814
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

According to DS, the gain is between -12 dB and 40 dB, with a 0.5 dB step.
Tested on pcm1863.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/codecs/pcm186x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm186x.c b/sound/soc/codecs/pcm186x.c
index 809b7e9f03ca..7947279243f9 100644
--- a/sound/soc/codecs/pcm186x.c
+++ b/sound/soc/codecs/pcm186x.c
@@ -6,7 +6,6 @@
  *	Andreas Dannenberg <dannenberg@ti.com>
  *	Andrew F. Davis <afd@ti.com>
  */
-
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -42,7 +41,7 @@ struct pcm186x_priv {
 	bool is_master_mode;
 };
=20
-static const DECLARE_TLV_DB_SCALE(pcm186x_pga_tlv, -1200, 4000, 50);
+static const DECLARE_TLV_DB_SCALE(pcm186x_pga_tlv, -1200, 50, 0);
=20
 static const struct snd_kcontrol_new pcm1863_snd_controls[] =3D {
 	SOC_DOUBLE_R_S_TLV("ADC Capture Volume", PCM186X_PGA_VAL_CH1_L,
--=20
2.17.1

