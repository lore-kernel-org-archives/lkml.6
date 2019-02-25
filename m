Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA35C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA14E20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="SCEzPj5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfBYQra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:47:30 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:21605 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbfBYQra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:47:30 -0500
X-IronPort-AV: E=Sophos;i="5.58,411,1544511600"; 
   d="scan'208";a="26850587"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Feb 2019 09:47:28 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 25 Feb 2019 09:45:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6ochFX7flCn9qq72iMCW1n9LmXC2ha4ff8K+FuiYAY=;
 b=SCEzPj5kIGLxE2bwyhBHB7Pkw6Pc23LD4VM59MD7UaCrQywbuvfDRHJ/OGU60lw14YTXuQCfTh4dIGwt/fweWhMXNdIB5OcOFizIl+4r+nrvuTYSwyBKtnYtWck1szKaxi388CbHIOtN26d09PCxff7oAtuRDGnhaLdk9GYWhF8=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Mon, 25 Feb 2019 16:44:41 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::dcd3:5ebd:191c:549e%6]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 16:44:41 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 3/5] pwm: atmel: rename objects of type atmel_pwm_data
Thread-Topic: [PATCH v3 3/5] pwm: atmel: rename objects of type atmel_pwm_data
Thread-Index: AQHUzSlnij8mTV3JT0iVEpA081MnUw==
Date:   Mon, 25 Feb 2019 16:44:41 +0000
Message-ID: <1551113039-937-4-git-send-email-claudiu.beznea@microchip.com>
References: <1551113039-937-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1551113039-937-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::30) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b8ba344-2c46-41d6-cea6-08d69b4089a6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1662;
x-ms-traffictypediagnostic: MWHPR11MB1662:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1662;23:i+dok/MNsVG6fULP/g0yxHqk+Ax33UHQuorbrA7?=
 =?iso-8859-1?Q?fw1yLGuqHsw59DP10e7GPUWBD5FWenOayKgIOwLhUeBFgPKwCKdO4Wcisr?=
 =?iso-8859-1?Q?vL5blKcDpUYbRjR5ypHxGJ47CIVsGmDRXmKPf/OVpZATFXJCpLjzGHqYL1?=
 =?iso-8859-1?Q?VT42Ug8ZJN7d5LuIZrgQ6b0fUtqgs3DH8u2HCo0EOmgrPVhRdsS9kQBFeN?=
 =?iso-8859-1?Q?ls81eAA8WInhxiKeYMMICX3WhjHCA0NoBoNXLjDfaBkkGsN1nDIaUWLcKZ?=
 =?iso-8859-1?Q?os/YZSwyeg5hHGsB082V64VJE+c5q9uQYsCfEwPU1Ix4RDJH0fPuMUGtMY?=
 =?iso-8859-1?Q?NMey7el5nSdQTIN4Nez9I0Gn3Y7PpJtihdImYpJpmFTIKPx+z8/2hwscPm?=
 =?iso-8859-1?Q?dDxunkSgn/0OYqYZWXsxt/RNFEoX3bgpWiPlVUWgElQvH0R6jlDuNlxDsV?=
 =?iso-8859-1?Q?Xc3AmSWvN6vSFdxStpxTwjqNCbhMJO8OINR9T49Jlr6waFj7R/Ht/De6R1?=
 =?iso-8859-1?Q?czeDR+uapc/0ACU7kL6drwbstW0uOhwZeAklZ6MSPnWC2Yu+61R4zMw9DO?=
 =?iso-8859-1?Q?IQExQ05wvrFJazywffpS8uI+8g9Bx5lC4EiTbmE4TXEIjaY0hGLyySwVv4?=
 =?iso-8859-1?Q?OkNJFhbWIJYe9o56mB2q0209MEB+/diGZk1s2+1MhKCgjZJ4+qSEn1ok+p?=
 =?iso-8859-1?Q?KvZIi2oX0Ti9GsMHn3Mbyygo2ADaOqhtZfmXMZpsblP8OavbvgcMEsLK3h?=
 =?iso-8859-1?Q?95zODS7wN+OTo0NKL0hVaq2y/lJ6gzYof21cRI5pQCBqirYRJ0Kyk8MJKX?=
 =?iso-8859-1?Q?tsOuHvNRQkj6Y6oqTqsRsd3La0IYGgIuGd3Ak8sv1fUO/8PrDN+8UlxpOQ?=
 =?iso-8859-1?Q?6Y7rHXCFs4GvZjfIfX/BbRIERjMdWETwltU1Onk07xVp3zMcZA096OOQAK?=
 =?iso-8859-1?Q?srX+tdLyT3hLThBJRpyCQW1KYfr6qjse5PX0vylGDG2sCBNVuDbsJjlFKx?=
 =?iso-8859-1?Q?Q5EzeveuQEQHFUxsd0PFe8o0mZd/gph+0blCRJK3TX31Jp78wniWsR8ibV?=
 =?iso-8859-1?Q?3hnLjm50Wr/pgfoWhZlCyKBzj1kPQHQnGWH+X9CWyRnXqoKnznhLIeS/r6?=
 =?iso-8859-1?Q?YXRMxgTl7Mo6Ux7IWqUU5EZ+Xg7tQu1Mx6F1daYiUjqcqyaltyORZGm+us?=
 =?iso-8859-1?Q?PR69d0cSwnU3OtM6TUTuEPukrc8t6ZTlH71GpOzZvVeVDeZQQL+8R+zY//?=
 =?iso-8859-1?Q?kexCwXt1reLk3ajRdDo+3s89vfUCiM+JS08py+Nps6qiXbQbEA6ngombsU?=
 =?iso-8859-1?Q?UgjAlHkTwVpSY092sNFmvMS?=
x-microsoft-antispam-prvs: <MWHPR11MB16629AE90AEB9C67FFFB40CD877A0@MWHPR11MB1662.namprd11.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(366004)(199004)(189003)(68736007)(2501003)(97736004)(5660300002)(105586002)(106356001)(36756003)(256004)(110136005)(54906003)(316002)(86362001)(99286004)(6636002)(52116002)(76176011)(66066001)(446003)(2616005)(476003)(72206003)(6512007)(6506007)(11346002)(386003)(6116002)(3846002)(50226002)(14454004)(478600001)(8676002)(81166006)(81156014)(486006)(8936002)(53936002)(6486002)(107886003)(305945005)(71190400001)(71200400001)(6436002)(102836004)(186003)(4326008)(25786009)(26005)(7736002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1662;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KgR3GqyG3keBl9hE7kyOaeh7ovXxyUJ5niXpHQz80YgOBPh2nFxA7GK1BrjEtRALOBCGoV2/2fmVhTruXY5IC+63oTxnLO6Ra70RboFNjL2mYCDKTeiZZ8gxn9F/VmU7EmlYKn6KHuEi5d4Tg6b7onyNWAId230iuWCWjoVtxoJmsYHreM1R3inUyOEQFP8MOshNIUAxyihorVksIKBIOmOOtx5GntScURvn1cAjTp+Xdu7Y30Ax095UG369lTZMkdtV9LVPT7M+920A2feQcJ+1uUmklb0XUbGbnynQnPvfWRD5RIpUaSKdOTg9LDPMjryLMLMElREF3Mbo7Z0yZIuvoQ8+rHPQIXfjg6pZGI+2Ks/FcvzSqEX7fnO165TBaVEgMtgfJWQuMgWuJBhgfAzII9pqvTT1SozqrsJh+B4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8ba344-2c46-41d6-cea6-08d69b4089a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 16:44:38.2194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1662
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Rename objects of type atmel_pwm_data to contain chip name instead of
version number.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 647d063562db..4ac899d8008c 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -283,7 +283,7 @@ static const struct pwm_ops atmel_pwm_ops =3D {
 	.owner =3D THIS_MODULE,
 };
=20
-static const struct atmel_pwm_data atmel_pwm_data_v1 =3D {
+static const struct atmel_pwm_data atmel_sam9rl_pwm_data =3D {
 	.regs =3D {
 		.period		=3D PWMV1_CPRD,
 		.period_upd	=3D PWMV1_CUPD,
@@ -297,7 +297,7 @@ static const struct atmel_pwm_data atmel_pwm_data_v1 =
=3D {
 	},
 };
=20
-static const struct atmel_pwm_data atmel_pwm_data_v2 =3D {
+static const struct atmel_pwm_data atmel_sama5_pwm_data =3D {
 	.regs =3D {
 		.period		=3D PWMV2_CPRD,
 		.period_upd	=3D PWMV2_CPRDUPD,
@@ -314,10 +314,10 @@ static const struct atmel_pwm_data atmel_pwm_data_v2 =
=3D {
 static const struct platform_device_id atmel_pwm_devtypes[] =3D {
 	{
 		.name =3D "at91sam9rl-pwm",
-		.driver_data =3D (kernel_ulong_t)&atmel_pwm_data_v1,
+		.driver_data =3D (kernel_ulong_t)&atmel_sam9rl_pwm_data,
 	}, {
 		.name =3D "sama5d3-pwm",
-		.driver_data =3D (kernel_ulong_t)&atmel_pwm_data_v2,
+		.driver_data =3D (kernel_ulong_t)&atmel_sama5_pwm_data,
 	}, {
 		/* sentinel */
 	},
@@ -327,13 +327,13 @@ MODULE_DEVICE_TABLE(platform, atmel_pwm_devtypes);
 static const struct of_device_id atmel_pwm_dt_ids[] =3D {
 	{
 		.compatible =3D "atmel,at91sam9rl-pwm",
-		.data =3D &atmel_pwm_data_v1,
+		.data =3D &atmel_sam9rl_pwm_data,
 	}, {
 		.compatible =3D "atmel,sama5d3-pwm",
-		.data =3D &atmel_pwm_data_v2,
+		.data =3D &atmel_sama5_pwm_data,
 	}, {
 		.compatible =3D "atmel,sama5d2-pwm",
-		.data =3D &atmel_pwm_data_v2,
+		.data =3D &atmel_sama5_pwm_data,
 	}, {
 		/* sentinel */
 	},
--=20
2.7.4

