Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632C5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2844520C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QB4wes+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfB0QY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:24:28 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:15221 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfB0QYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:24:25 -0500
X-IronPort-AV: E=Sophos;i="5.58,420,1544511600"; 
   d="scan'208";a="24548744"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Feb 2019 09:24:23 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 27 Feb 2019 09:24:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mikEp8t9F/rV98FOPkgICa9sMMqDyCpZWXTJFO9iwQ=;
 b=QB4wes+cWIfsVyRr5pnf4G4j7y4o8asKRkH4LOcvBBwGY8ogCu1YSrcq7kN1L7JrsyAVdABEe6M21SIWoY2YNf0DWhd1gOFmkkCAx3Dl4pqtUvGFKDFuNPHGlN2ORZY0Cxmsfpr61ntXXa/B4miFqC1u/ZWxyCzYLEEkFN1TmdA=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1806.namprd11.prod.outlook.com (10.175.53.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Wed, 27 Feb 2019 16:24:21 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%8]) with mapi id 15.20.1643.022; Wed, 27 Feb 2019
 16:24:21 +0000
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
Subject: [PATCH 2/7] drm: atmel-hlcdc: avoid initializing cfg with zero
Thread-Topic: [PATCH 2/7] drm: atmel-hlcdc: avoid initializing cfg with zero
Thread-Index: AQHUzrjlaSK8QrtZ1k2uOQ9e88LNGA==
Date:   Wed, 27 Feb 2019 16:24:21 +0000
Message-ID: <1551284609-14594-3-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: b771145b-145b-4edf-5d0f-08d69cd00763
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1806;
x-ms-traffictypediagnostic: MWHPR11MB1806:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1806;23:nIfsFMia9rh3c9qyYIaAiTgYunqfCKMFxwOThlA?=
 =?iso-8859-1?Q?q8bmtVERx50IXzzV8GRylkWn/PyNr8DoEJrWH5aEk1Tnh9K0kaA+fy4INo?=
 =?iso-8859-1?Q?j9FiEg/IeB/Rwpn+C8ANfaN9z3191N3euukNHNXUzBsQH+51dQjmHzhoKk?=
 =?iso-8859-1?Q?HQOkDv8i6YY6MTB3c3YDrvreo5DK2hpRqi0Rh4I2mDu0vgsLLQ3KT80No9?=
 =?iso-8859-1?Q?NZ2+cgt77g/jA/jKmVVGw4wH42OvreCvSBjBbu0GCmRsZTy+rwEP0EifFY?=
 =?iso-8859-1?Q?GSJ993BhAUkUbdsZ7CoKR2nw9xUJ3oIaxPiyOZ8ew4WrZmozScJ6Zd4HGM?=
 =?iso-8859-1?Q?9qDFLdvoxKfV6/hM8ywnfFSDgIbDlKXNLOKj9Vnmz1vLASAtylQosLObLt?=
 =?iso-8859-1?Q?d/EX/NHW2Tzzqnp9g00jouE1JT2rQwSavC/3bRtbLZxX9z4h5np/tgz4r9?=
 =?iso-8859-1?Q?iTbdtcJsy9k7s0yXRg8YokyidBcZyoxZzTAr7IM0ikzfFB2ocpJxII1b6j?=
 =?iso-8859-1?Q?e2+bN1P/F00HLpknR+q48mcuv62WbEn4kEvEu8+x0g5melGhdou2aO+LqI?=
 =?iso-8859-1?Q?WUOTkS1jgJ71w26OMXImYBGotZFMtw3F6hHG3KwE1h2gEJEzGucdMA3vJa?=
 =?iso-8859-1?Q?Tijoy0RfncEm/CAzPV80wjkN15obV1zFYF/og843oFVtQB5BAj+wn0n12l?=
 =?iso-8859-1?Q?pkvNZaCWBOund59RDz/KQ0jXUJsPhZQr8ckNnOM6OFls/kBjmjRtrZX9gP?=
 =?iso-8859-1?Q?WUs1yIsMEsIc0i97h2xt6DxqU2eYgYY34eSoTOEIFgXLUSCL8mZDvMOGw+?=
 =?iso-8859-1?Q?FOxSKoe1d8GEfVcKdkUkzEoTiFPnRfZ2f1c88bKaRxtmtKbJYGhKAGHIaX?=
 =?iso-8859-1?Q?WlZ7u/WSfe19n4FvF6338HxwE+ke5Zm7uDpZfjdKKa7DYgaIfPmoh8wNt8?=
 =?iso-8859-1?Q?xwaGkSQmbDnumdxgm4a9IiuPLaFyntPs26ha3jsOrhZEfGkhbp9h+7iuR3?=
 =?iso-8859-1?Q?NadOl9hHEGb1kP6A9RAREkva6SND+95KyAZrcmtBg+KZbL4K2nXSZ0OUqD?=
 =?iso-8859-1?Q?HGwZbU/iqkyw1PyeOtf4ID3/w5jVcLFWTgPNPhSSzWOyDMnNwvyNRe48YS?=
 =?iso-8859-1?Q?+9Gvom6anaxnK5DIJXbQeSspKOf8gS6ZJZaWODFTVM8tGK5U8kU1qC87i4?=
 =?iso-8859-1?Q?LApHZJWEH8rQRCzbpt5rs18C9qjohNJ8y2cSS+SaYDmGm/6T6jWxnI53a0?=
 =?iso-8859-1?Q?XkFfNu+r1hwwRKmBL5+bUAZvRrOTmtW37bf0A/jHcO5KSBjCm/SQnkZXn8?=
 =?iso-8859-1?Q?3/Bjq6GUj1hFsbkCSypoCNpbi8yEZSGiTLETeJvJa49yCMGMXa/V8cjSWq?=
 =?iso-8859-1?Q?fe2199TKv3VcgEC3ku6mV4VJ0z2Ng?=
x-microsoft-antispam-prvs: <MWHPR11MB180673A7037FAAF005E6134B87740@MWHPR11MB1806.namprd11.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(366004)(136003)(376002)(189003)(199004)(11346002)(105586002)(25786009)(6436002)(8936002)(36756003)(4326008)(66066001)(6486002)(486006)(476003)(76176011)(50226002)(52116002)(186003)(107886003)(72206003)(99286004)(478600001)(2616005)(7416002)(68736007)(110136005)(14454004)(2201001)(71190400001)(6116002)(6506007)(86362001)(446003)(71200400001)(386003)(97736004)(8676002)(3846002)(53936002)(81156014)(54906003)(14444005)(81166006)(256004)(2501003)(316002)(305945005)(6512007)(7736002)(26005)(102836004)(2906002)(106356001)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1806;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6R4cmc5wUBnaTN3d0igSG60yDfMYnhnFGQpXeT77Z2YzDQp+svR5ocq6plfaqNvMMVHbbDYXICbpBw0GsnK6Aed9P6nEJwoQPQ4MxiSI4kXLtqKyKHhwWw2G8pF8ZrMl0sLqMwg9XGxGn7QRh20uEuyPf8W6dkftxDe4r+9mIsfNPZOUCBA3ViUbIrlCyHKnu/O97XgIwVuMBU6yUHJ8H9zwR9lO1NbsM7ik6W/ym4dDcS8BGb0lXwb513Dl+3xYC9KTSwSKXB/NQhE0WpYgBOteUcK/y7wUJOYboNsiolvapC1JaBqU2fptAyht0dL2VeD8MYX95g5xCDcPoSP+LclOT2StiNS48BWhyzqZ8LgPjFP33Qs67W4KpkiztjArVo8VPNgEY0UB7KmwJYhegQEuBGzt/MRPD+EMWYSScLE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b771145b-145b-4edf-5d0f-08d69cd00763
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 16:24:16.8701
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

Remove cfg initialization with zero and read state with
drm_crtc_state_to_atmel_hlcdc_crtc_state() so that cfg to be initialized
with state's output_mode.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/d=
rm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 17a7a18f6a07..7b0c6683a690 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -138,7 +138,8 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_c=
rtc *c)
=20
 	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(0), mask, cfg);
=20
-	cfg =3D 0;
+	state =3D drm_crtc_state_to_atmel_hlcdc_crtc_state(c->state);
+	cfg =3D state->output_mode << 8;
=20
 	if (adj->flags & DRM_MODE_FLAG_NVSYNC)
 		cfg |=3D ATMEL_HLCDC_VSPOL;
@@ -146,9 +147,6 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_c=
rtc *c)
 	if (adj->flags & DRM_MODE_FLAG_NHSYNC)
 		cfg |=3D ATMEL_HLCDC_HSPOL;
=20
-	state =3D drm_crtc_state_to_atmel_hlcdc_crtc_state(c->state);
-	cfg |=3D state->output_mode << 8;
-
 	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(5),
 			   ATMEL_HLCDC_HSPOL | ATMEL_HLCDC_VSPOL |
 			   ATMEL_HLCDC_VSPDLYS | ATMEL_HLCDC_VSPDLYE |
--=20
2.7.4

