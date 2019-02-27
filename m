Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92C1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDF121850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Z893PtHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbfB0QYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:24:24 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:46743 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfB0QYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:24:21 -0500
X-IronPort-AV: E=Sophos;i="5.58,420,1544511600"; 
   d="scan'208";a="26973634"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Feb 2019 09:24:18 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 27 Feb 2019 09:24:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3zj3M+u0PYc87f+7WVtUTH+GEPyHpJqWczmXI6W7EA=;
 b=Z893PtHZJvfplerD6rSSCfl22irjO3f1d7QfJwxJYyWEsoa43Kl7YsN+Tt8x0dFwBpHszSR/40nAuSb5JcNtGPet4VBMxXse8THGWnIpA7JbWdvnEFaAFvtNEp+LCkCZXj0PyE0yNZa7NgP+gJeC9P+YnJfSOea0suTnB68KOsE=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1806.namprd11.prod.outlook.com (10.175.53.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Wed, 27 Feb 2019 16:24:16 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%8]) with mapi id 15.20.1643.022; Wed, 27 Feb 2019
 16:24:16 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-pwm@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 1/7] drm: atmel-hlcdc: add config option for clock selection
Thread-Topic: [PATCH 1/7] drm: atmel-hlcdc: add config option for clock
 selection
Thread-Index: AQHUzrjibzNyakqaO0avPILToqBAJA==
Date:   Wed, 27 Feb 2019 16:24:16 +0000
Message-ID: <1551284609-14594-2-git-send-email-claudiu.beznea@microchip.com>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0112.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::14) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88d2e4a2-3f73-41a9-4abf-08d69cd00495
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1806;
x-ms-traffictypediagnostic: MWHPR11MB1806:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1806;23:05GuIb1lOsGC3wtmuLRFctvyX4T+X2IgpkovrRL?=
 =?iso-8859-1?Q?x1GaA5Wq7F3c0pniKZ9TkM4K8Hvub/wkjPm+1GdeS8+DyG9uguis6GcYy4?=
 =?iso-8859-1?Q?WiQqtjhSSzWmPDb4JVHE+bZVRtGNNkkKg9t/iC3ytkStSk66ThWegZfX10?=
 =?iso-8859-1?Q?FJWIwA3fw+e5hlnG8RDryJMapQW6Orz4xM9hi+IjZkus/tZ+rnlAMwihE3?=
 =?iso-8859-1?Q?TL4Z2pUDMLMDs9oNIff6lkRLgeOg9awpm0PoVhVaW+6EMt5UK9zr4nNgFG?=
 =?iso-8859-1?Q?cUADBIl7fO7uoD84XyqH3HXhRNMEZnuMRrPNHaJAeyK9NNhUabIKWdGkef?=
 =?iso-8859-1?Q?CgAVox9glwxjupNeVin0IUmrQ753BQ4bFJT4a/B6HaULK5aWxBa1zzM44S?=
 =?iso-8859-1?Q?SVntiHwvLfX79XF5AEKpPPG7hKQFdq3SmIkDqyxtCIE7A+Op4qffWmn3T8?=
 =?iso-8859-1?Q?x3gAuJA2KZJIxVxOVEKjysPVJZkMdAQbItDfOvfpe40piMNUDnDSlMTn21?=
 =?iso-8859-1?Q?mPv3YRz0cZ7Bp5JBetMGouqFkCVSY7VQhOVY6BfRtincgGpduRxXkz4WMG?=
 =?iso-8859-1?Q?QotXU97HqtTAQ4Qf5Cr4d69pTGU56Q1gwvSHmWzdOGNnuwowuEzvEsou25?=
 =?iso-8859-1?Q?e0K/771fvIhMq87mWUzBJ5dmbe2AcmQXw9zPAFpq1jjdf/mscrSmuK9BsS?=
 =?iso-8859-1?Q?X56xObVFhXZFm51pR1OHe4U67C2SQv5uhzR9Thyohp7ZsfSadVp+XTuj0U?=
 =?iso-8859-1?Q?0IOsYu18fP+CDbSV5A1WcsAXmsqc+jfL/HtoIseV4chMU5+o3LqkuCAmlj?=
 =?iso-8859-1?Q?r/nMs717IXhABbbcs6+rLQzkHDHNjzK3cPCop96wQmZpwXXYWYRtIoSq/Z?=
 =?iso-8859-1?Q?mrgSIkvriY/buYFRudKW9iR5SvKCq48WPd09MqESkZcSnONwLVhUvZ8qdM?=
 =?iso-8859-1?Q?OCmv2lMlX4uTqbiCIgZsYLT29QbDsws5PbBy/RNzJn+0B+BclhTfCVYD9Q?=
 =?iso-8859-1?Q?pxPL5Dcv00JHHQ3jrfj9k8yxA+qJ7stQDzk5sYAr/1Xn5flgSzht+eATYJ?=
 =?iso-8859-1?Q?lsPGUTE8ymbKP4Tyn+WPiRvXMKSlKXxU5vHgCKuweGXa2sOAQOO89Eq1sD?=
 =?iso-8859-1?Q?VS9ljrU3F9qmXoWGZRyt+sAZvR/SkvARUdZpOtH+dX8nMzBW95h9n+yN/b?=
 =?iso-8859-1?Q?wB4E8Vb/h6V7DB2skAYz9Q0dCYrNeP4HQB3Yaw676PuMHopt3roKToI1gd?=
 =?iso-8859-1?Q?fbO2Ryr0UDhpCCsc+MNA9QreNYMKA6OGTzfNBQZqBOLJNBBmnDnYQmiBzk?=
 =?iso-8859-1?Q?gMmmIbScC2aUbknoSlTd85IBkihnF2bPrc6TF18bDURxOw9xbONWCDkLmP?=
 =?iso-8859-1?Q?ywYcJh5+KIAzW4bnVIJHG1Wq7YsN1?=
x-microsoft-antispam-prvs: <MWHPR11MB18061A2E2DB09BE1DDA5EBA387740@MWHPR11MB1806.namprd11.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(366004)(136003)(376002)(189003)(199004)(11346002)(105586002)(25786009)(6436002)(8936002)(36756003)(4326008)(66066001)(6486002)(486006)(476003)(76176011)(50226002)(52116002)(186003)(107886003)(72206003)(99286004)(478600001)(2616005)(7416002)(68736007)(110136005)(14454004)(2201001)(71190400001)(6116002)(6506007)(86362001)(446003)(71200400001)(386003)(97736004)(8676002)(3846002)(53936002)(81156014)(54906003)(14444005)(81166006)(256004)(2501003)(316002)(305945005)(6512007)(7736002)(26005)(102836004)(2906002)(106356001)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1806;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ny8Na9bfpLUL+m144LrVYFDXuvOyfAajQ5OVhsx57/BXJLm4ae+28MlNYJmP9z+lTa4/0ytJwazpGCNHKWW1nOYIy6MHXWzODPYT0tVx3tJpf2bzwirvGoOfPHsIP2pEhuh8CFM41r2zvG7O/obbcTQKkzj2anm4msZdK1ukaalT/JrFinlCoy70JtYmbMckXCPQ8FhQ1wwJGYj6vbaRTA/BHh3kr63X/AnslMGniYgvb7Amuhk30yB13q43iIYUfc3DDrxP2cDkXv1J2KJ9yV/UCfc/hwyL8v8ZmP7AkCoiAMEcKgcV2dwZRSYVVkkZRibcDx6zc33dsaHq8D6eExPHP1rpIdWU90clhcIzpOwjatrE+YUumZ/6MqlWH+C3cSf3cO+ROiVwUolEtQ617WRjvinfBwonVI0tGdtYNwU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d2e4a2-3f73-41a9-4abf-08d69cd00495
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 16:24:11.4596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1806
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

SAM9x60 LCD Controller has no option to select clock source as previous
controllers have. To be able to use the same driver even for this LCD
controller add a config option to know if controller supports this.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 12 +++++++-----
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h   |  2 ++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/d=
rm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 8070a558d7b1..17a7a18f6a07 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -78,7 +78,8 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crt=
c *c)
 	unsigned long mode_rate;
 	struct videomode vm;
 	unsigned long prate;
-	unsigned int cfg;
+	unsigned int mask =3D ATMEL_HLCDC_CLKDIV_MASK | ATMEL_HLCDC_CLKPOL;
+	unsigned int cfg =3D 0;
 	int div;
=20
 	vm.vfront_porch =3D adj->crtc_vsync_start - adj->crtc_vdisplay;
@@ -101,7 +102,10 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_=
crtc *c)
 		     (adj->crtc_hdisplay - 1) |
 		     ((adj->crtc_vdisplay - 1) << 16));
=20
-	cfg =3D ATMEL_HLCDC_CLKSEL;
+	if (!crtc->dc->desc->fixed_clksrc) {
+		cfg =3D ATMEL_HLCDC_CLKSEL;
+		mask |=3D ATMEL_HLCDC_CLKSEL;
+	}
=20
 	prate =3D 2 * clk_get_rate(crtc->dc->hlcdc->sys_clk);
 	mode_rate =3D adj->crtc_clock * 1000;
@@ -132,9 +136,7 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_c=
rtc *c)
=20
 	cfg |=3D ATMEL_HLCDC_CLKDIV(div);
=20
-	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(0),
-			   ATMEL_HLCDC_CLKSEL | ATMEL_HLCDC_CLKDIV_MASK |
-			   ATMEL_HLCDC_CLKPOL, cfg);
+	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(0), mask, cfg);
=20
 	cfg =3D 0;
=20
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm=
/atmel-hlcdc/atmel_hlcdc_dc.h
index 70bd540d644e..0155efb9c443 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
@@ -328,6 +328,7 @@ atmel_hlcdc_layer_to_plane(struct atmel_hlcdc_layer *la=
yer)
  * @max_hpw: maximum horizontal back/front porch width
  * @conflicting_output_formats: true if RGBXXX output formats conflict wit=
h
  *				each other.
+ * @fixed_clksrc: true if clock source is fixed
  * @layers: a layer description table describing available layers
  * @nlayers: layer description table size
  */
@@ -340,6 +341,7 @@ struct atmel_hlcdc_dc_desc {
 	int max_vpw;
 	int max_hpw;
 	bool conflicting_output_formats;
+	bool fixed_clksrc;
 	const struct atmel_hlcdc_layer_desc *layers;
 	int nlayers;
 };
--=20
2.7.4

