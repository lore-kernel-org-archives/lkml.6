Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02831C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1AA21850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="xg18Czqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfB0QYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:24:14 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:2243 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfB0QYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:24:14 -0500
X-IronPort-AV: E=Sophos;i="5.58,420,1544511600"; 
   d="scan'208";a="28407990"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Feb 2019 09:24:12 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 27 Feb 2019 09:24:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aik52S8z2Jzn0ktL0wsiJ7olpKFLB9bnHCWYztHnlNk=;
 b=xg18CzqvGDNiyefZ3JJ65L3r/nmFklcIkIzIKvYL/AMOEwoub8N/QiTyltFdQGAXyp1PRtxwZs31PHspQbLUSs5sST//H94IUi9tdY29r/8oWWnmK7e6JorryUn88zwIYx9jhAsrGy0OTqdKITgmo4hIhOwavxGXoKJcR/dNcIc=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1806.namprd11.prod.outlook.com (10.175.53.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Wed, 27 Feb 2019 16:24:11 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%8]) with mapi id 15.20.1643.022; Wed, 27 Feb 2019
 16:24:11 +0000
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
Subject: [PATCH 0/7] add LCD support for SAM9X60
Thread-Topic: [PATCH 0/7] add LCD support for SAM9X60
Thread-Index: AQHUzrje9T8RC8FLgkilJXdcaQrjRw==
Date:   Wed, 27 Feb 2019 16:24:11 +0000
Message-ID: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: 68b262fd-0041-4b4b-2e48-08d69cd0013b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1806;
x-ms-traffictypediagnostic: MWHPR11MB1806:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1806;23:kb5DrRFMwzR/A24Vye28K3RF3Pj2sHO/44g8nAf?=
 =?iso-8859-1?Q?puMNncYhrK9f0XIe7beZBsIRPj3ftVSL2oDxyI+o+h34eNuhmkBzaDbTRh?=
 =?iso-8859-1?Q?jrz1SA5ym7ywf8yrzmSDpdAg+Vc7dVb7dWuNvdmnb+gVDIF1aSqmH5p3mD?=
 =?iso-8859-1?Q?umf4A0P6/m/x+JcmmjWCQmVK2BqQnzTdTn+UciE8P62dr8fxoCFxJsh6Et?=
 =?iso-8859-1?Q?EGtntE5CvMD0CRoVacom+DQlzfkQ7lEOilvP9A5IFdAMkt8jlaX3tJcMs3?=
 =?iso-8859-1?Q?hRgswIu/zDMfEjdzy+6KcmJKVjrhlfkrmes6oIGvM/jYXhE7N+VDFRzs2L?=
 =?iso-8859-1?Q?hbNVWKDTRnWDBf/4qa5ciU5xz+3H9j58DaS6ble2y/gmoXyzb4v1pI4Ph7?=
 =?iso-8859-1?Q?AwLcFCM73/o+Z7teQc0vhA+uHWq2c2Z8HG8J0++7BJSE6d5jvNeU16qWh9?=
 =?iso-8859-1?Q?uG9b58HranBcExIzTMkT1dblHNQCSzrfopKUEENeEdmdxIHpaokuniWnqj?=
 =?iso-8859-1?Q?pdSjaUwS0am51oj03DX4VxgpRuMc50XHh/SYG5K5qAgYO4uZvqhLGdN8KM?=
 =?iso-8859-1?Q?dLLFBVA4oW5zOO5962DOFdSWvKmS7LBdPlI8iSzXCdzvi5LvKhG2urPrcF?=
 =?iso-8859-1?Q?0jpgwWyRvxv7SDpFYKIwKTRT5jE/JY7aA55xJ+e3wQJMn3L+p1QbJDscU1?=
 =?iso-8859-1?Q?XW1+nYof6PWMQEZ1g94m5TVtFK5pYOFsp4guduASxD5DmQafx4szWoXqzQ?=
 =?iso-8859-1?Q?GmYguPJRoZ5ymqMKBfCplqpMVKGEeWdn3I59cGVkAVrQejov41PisUb/Pj?=
 =?iso-8859-1?Q?IDTqDD9Yk05N8tOZ25f5TNN9KM6yu+mKQwe+vDD7Z8MhMprZfP+4qt0hdY?=
 =?iso-8859-1?Q?JZqTPbpBE/F00Im/pf/O++DvPomhRsKyX0lTway+dQcdjh4g5A9aj1/JaN?=
 =?iso-8859-1?Q?YBKOTvQerwi+BAcXjckDbVnH9l2CzSpjN+UDfJw/nmJJ9yQUqWpF/CMI0N?=
 =?iso-8859-1?Q?/Usn17A9ZBygCl/aEEmb4FY1ChCm8S4wP5dzpbJpJDMErwiQDpJhv+J1UC?=
 =?iso-8859-1?Q?55xcqFtfBkyeSvpSbdwUqsihWCPDfxIRCx3JjadMaclnOsptXG5jHD6may?=
 =?iso-8859-1?Q?AWrm1cuCVBWXdSYKJDI6URNsP6g1hD+Wzf4/Q5jTQDwhBlEi2f7RJ5OE51?=
 =?iso-8859-1?Q?+IBa2fSiws7PiwRMsqnULQ/0bBv7nb2c1UIEDCljIJsMsk58Jx98iucy2c?=
 =?iso-8859-1?Q?OCSBlnYqw5ilElj704blaHWdPtHb4Bkpb6Zdf2QlvTV/vDqODSlGlVaxl+?=
 =?iso-8859-1?Q?hBKmicOFPUlKYl1kwFuFDTeO++yNEKXuopDLMWcyaak3g=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB180603B120F2337F436B88A787740@MWHPR11MB1806.namprd11.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(366004)(136003)(376002)(189003)(199004)(105586002)(25786009)(6436002)(8936002)(36756003)(4326008)(66066001)(6486002)(486006)(476003)(50226002)(52116002)(186003)(107886003)(72206003)(99286004)(478600001)(2616005)(7416002)(68736007)(110136005)(14454004)(2201001)(71190400001)(6116002)(6506007)(86362001)(71200400001)(386003)(97736004)(8676002)(3846002)(53936002)(81156014)(54906003)(14444005)(81166006)(256004)(2501003)(316002)(305945005)(6512007)(7736002)(26005)(102836004)(2906002)(106356001)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1806;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /VTeVdppBTjOa8YH9iByk3fIzqkOU3er/opbhx48k3SfbxXlKo7ILpYv+aC0iFklZdyV8NCjV72JmY5r27VxbUX+chlJhYqVUcuRTe1hGZirY/Qm1JECeLpL7sq+iFeVcRFXMsEckQV9jKZ3pEmtTGZ52yxRQvVHv0bLpBBr78Z4qC6+JLXTCicUrfNuXNYMUU99sDvH5eYV2w0gwppq/0yhiiXZ7Zyx/PA+V+hmQSuxzP+hLyvQxfW1WWY/3veoyt8IZJ4OIb4EOVVfsHq2aAKezdAzBTuXPiZ+QvGCT6KnwR7lAnZuk31WmIfVcvi6HPsEurw7+M9AbZk0a9250dMK6MrcRP2uMqqwILYFnw1HUUMRniZ+PHocnWF6WGzbqy7qAyiI2TqFkqXycGULihvHwia5ET4d/JpUy98x5rs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b262fd-0041-4b4b-2e48-08d69cd0013b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 16:24:05.6067
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

Hi,

These patches adds support for SAM9X60's LCD controller.

First patches add option to specify if controller clock source is fixed.
Second patch avoid a variable initialization in atmel_hlcdc_crtc_mode_set_n=
ofb().
The 3rd one adds specific bindings for SAM9X60 LCD controller.
The 4th and 5th add compatibles in the driver.
The 6th patch enables sys_clk in probe since SAM9X60 needs this.
Specific support was added also in suspend/resume hooks.
The work in the 6th patch was done based on support added in 1st patch.
The 7th patch adds SAM9X60's LCD configuration and enabled it.=20

I kept a big series including PWM, MFD, LCD changes due to shared DT
bindings. If you prefer, I'm available to send them separately. Please let
me know.

Thank you,
Claudiu Beznea

Claudiu Beznea (5):
  drm: atmel-hlcdc: add config option for clock selection
  drm: atmel-hlcdc: avoid initializing cfg with zero
  dt-bindings: mfd: add bindings for SAM9X60 HLCD controller
  mfd: atmel-hlcdc: add compatible for SAM9X60 HLCD controller
  pwm: atmel-hlcdc: add compatible for SAM9X60 HLCDC's PWM

Sandeep Sheriker Mallikarjun (2):
  drm: atmel-hlcdc: enable sys_clk during initalization.
  drm: atmel-hlcdc: add sam9x60 LCD controller

 .../devicetree/bindings/mfd/atmel-hlcdc.txt        |   1 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |  17 ++-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       | 120 +++++++++++++++++=
+++-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |   2 +
 drivers/mfd/atmel-hlcdc.c                          |   1 +
 drivers/pwm/pwm-atmel-hlcdc.c                      |   3 +
 6 files changed, 134 insertions(+), 10 deletions(-)

--=20
2.7.4

