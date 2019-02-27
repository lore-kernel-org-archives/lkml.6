Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A026C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B5021850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Z1TMDnrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbfB0QYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:24:40 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:2266 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfB0QYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:24:38 -0500
X-IronPort-AV: E=Sophos;i="5.58,420,1544511600"; 
   d="scan'208";a="28408015"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Feb 2019 09:24:36 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 27 Feb 2019 09:24:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PY6KLL2lQD8AXavZmB/8KCTs0a6Hnew1USXezHrjE+I=;
 b=Z1TMDnrXnqRVx6A98o7tvlpMv5S09ag3ta9ig20m6+jCPWnZvYsE8b9duq9p47q+fiAHJgva6G6cEFJhLOU9J7ZqIzr1Ckf9xNqmtQ61Yld7kzrpPFgF0f5E/GaPsOv0xK8qQcT8bk3s6uqo1NM2OcnX/a/sCCWqwrjIes5zL+U=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1806.namprd11.prod.outlook.com (10.175.53.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Wed, 27 Feb 2019 16:24:35 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%8]) with mapi id 15.20.1643.022; Wed, 27 Feb 2019
 16:24:35 +0000
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
Subject: [PATCH 5/7] pwm: atmel-hlcdc: add compatible for SAM9X60 HLCDC's PWM
Thread-Topic: [PATCH 5/7] pwm: atmel-hlcdc: add compatible for SAM9X60 HLCDC's
 PWM
Thread-Index: AQHUzrjtad9bMy2FtEaY0XuYzaFWWw==
Date:   Wed, 27 Feb 2019 16:24:35 +0000
Message-ID: <1551284609-14594-6-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: b16ed66d-379d-4deb-40e9-08d69cd00f91
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1806;
x-ms-traffictypediagnostic: MWHPR11MB1806:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1806;23:qt1CkgTNHiZSkE32LkdQZWkAyWMVSLNlEJQK+G2?=
 =?iso-8859-1?Q?BMCvbb/OMT/Iw1LXjULlob99fXWDN3hlPjr+0qGqIEBlCojae6PnhzthOk?=
 =?iso-8859-1?Q?f+iP3hF+WK7AgoB3N4n+WgFpn4sNlWkTxD9wQfWr2I/TunIoIglozBKodv?=
 =?iso-8859-1?Q?RcqjuVMHHyatuHrypuAri7ytRb7uEVYdyJlIeZuPmXsnBY13dSe0yhCF8k?=
 =?iso-8859-1?Q?GRvzMM79dVVPDT2q5jOeBeeJYP2heeOz/OBOozbbWf4Q3nbqyFKqdk/cYu?=
 =?iso-8859-1?Q?FaVlY/a8TAgtB/Dj1MKbGMIGaBnw7/FjhNpdnZbJ953bjOI6ZvB0K33/6e?=
 =?iso-8859-1?Q?C706M4uL/nV7WAE2/8aQ+jB+n56EqG7yZMCYLYnQeJqCfm3X21RgFATKWY?=
 =?iso-8859-1?Q?dE12w2aYuZqGo72803MxaUop+2SVrU9iN+ZyxzDEC5UpG6vj6GzhwWETcQ?=
 =?iso-8859-1?Q?51pzDO2ZxloaWQxL8bW9yIsUmBOhJ4pvtIllZdRwMY9efNNtVleebukDLn?=
 =?iso-8859-1?Q?VTP5SsXntLTs7KNmVAQbRQKt998aUzgaOZ0jIw1szKjCBoHorHJCSuXF6J?=
 =?iso-8859-1?Q?zG6vsg1FRTwnbh35zZRoen9V2F6CLIP0HucpSwoGrIqk4gU5INYGsH+5lq?=
 =?iso-8859-1?Q?94GMc1gdfYBkgDut3QLQMfMGAmwHjqJ7PTRtvtNTtCBRhgR1gofUN5ccOu?=
 =?iso-8859-1?Q?fLZk/hlVArYcvJPZxqJcbEsXK/YraQW4RpIW4RkPce4WY4OkHH414LVVKv?=
 =?iso-8859-1?Q?Z46eknzOxwdZYbGtuil5S/g9Uv+0rkHQH9XShhNxKIcnFgDoA8vLHjx/2H?=
 =?iso-8859-1?Q?ts3D07V13/ReuuLuTfukllHlU4hBgIyRGn2PSCI1IdWC2xw9JMexn+w7I1?=
 =?iso-8859-1?Q?lv2hv1qxGScDcSU9Ck6YCOGWTc8nteIyXCLk1E8OuJ8Dshc9yNsLV1uLIF?=
 =?iso-8859-1?Q?pR6NW8exNmlSUlunJMlQnU+umP6hK5aY7St/jGfz7L9PoIyLsT3cPgQdeZ?=
 =?iso-8859-1?Q?KG/utNY2dkSbi/mtuMlLMufyxInTA0J0jyx6jZ0NEVwKTVnogWiAWYSaRm?=
 =?iso-8859-1?Q?yvcnnNEI26qxYRDGqwyy75VjE3bfc2rELbn7b/eoKkuwBUpS9JF3y3vnrb?=
 =?iso-8859-1?Q?UbonXKhZysN5iKelCKSngRudSL7q7anc1cCLWGZOre5kt/FHBi9Z8OaJN5?=
 =?iso-8859-1?Q?HTKSgjtKbI9sZdyAqmpMdI2PLQOiRCJd8b219z7BKrsZbwCvg6Y8/Mqd84?=
 =?iso-8859-1?Q?B3n0xkNxL3d41j04CWz/phvyKEtrXfcCjd9So0OIuutGhhHPBltsEc9C1C?=
 =?iso-8859-1?Q?Mq3DvUAie5hoN/C9GY55uQfiWWfrLNJPOhfuYN0/rvBdJ9lBjX07iNzQGi?=
 =?iso-8859-1?Q?HeYagRAke8X+Gd2av6Zbe2HUSU7Eu?=
x-microsoft-antispam-prvs: <MWHPR11MB1806F65814B3730079AB7DA087740@MWHPR11MB1806.namprd11.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(366004)(136003)(376002)(189003)(199004)(11346002)(105586002)(4744005)(25786009)(6436002)(8936002)(36756003)(4326008)(66066001)(6486002)(486006)(476003)(76176011)(50226002)(52116002)(186003)(107886003)(72206003)(99286004)(478600001)(2616005)(7416002)(68736007)(110136005)(14454004)(2201001)(71190400001)(6116002)(6506007)(86362001)(446003)(71200400001)(386003)(97736004)(8676002)(3846002)(53936002)(81156014)(54906003)(81166006)(256004)(2501003)(316002)(305945005)(6512007)(7736002)(26005)(102836004)(2906002)(106356001)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1806;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u1eWcd3aBIaIX3iAtRtnuAPbaKouE1ZUsdDeNaatzpBYRw6FbsOtZE5duVG34tuZfLgzN+uPakNz3iEVZu5eyJoPzHUgxEupOKPD/33lxLMsBN/Kv1QHW6WYajGnCQ8fu8051lEsPD2j4vOxJs6ISRutbMVbvfkd79JMOA7lbZCOQ4Uvylo7gc2/mTQVPKfdceVN18lLPNcmcRu719lQTKB07h53raH36wT/cw7MvcgcIk7RBVIh2vAJRZuP1Vq/lqKD/R0tThl3q5th7oOtWpgNxaXFiHMkJtn7/I51m4zrsNQb8VYRgmJTv89syUrwWeqPPe8r7Sd84itm4UVym0oPJkTwTBwX/XsOtCr0v1lX9Ko+zPPXu2Co8oLck3qvcRO8Huye4ADE/jZEHPiydr5pP/WhULnvIRtYLy4MhC4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b16ed66d-379d-4deb-40e9-08d69cd00f91
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 16:24:30.6577
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

Add compatible string for SAM9X60 HLCDC's PWM.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 54c6633d9b5d..331ca0233d9e 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -246,6 +246,9 @@ static const struct of_device_id atmel_hlcdc_dt_ids[] =
=3D {
 		.compatible =3D "atmel,sama5d4-hlcdc",
 		.data =3D &atmel_hlcdc_pwm_sama5d3_errata,
 	},
+	{
+		.compatible =3D "microchip,sam9x60-hlcdc",
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, atmel_hlcdc_dt_ids);
--=20
2.7.4

