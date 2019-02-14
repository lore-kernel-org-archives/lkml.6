Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1B3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0456B21901
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="21n71Q8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394423AbfBNMOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:14:41 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:57592 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbfBNMOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:14:40 -0500
X-IronPort-AV: E=Sophos;i="5.58,368,1544511600"; 
   d="scan'208";a="24661006"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Feb 2019 05:14:40 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Feb 2019 05:14:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBKYXA9Zq9WHBTqKQgllKqJwIxlqOnzS7RDZ5q5yr04=;
 b=21n71Q8/hcE1XFZakfyDv03T8VkGwmwszMVKK+yoHCgBMV/dV7zvIAUqlYjzol05HCEspdtIp7IMCMm6Uqqpfz9cEL260AfrqzlVnFBzpeVOD7drehAbkVGgGW3iWW6EmBV9+vlgzcJEyiocSHV7YD41QleBNAelD4G0kxbnktA=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1518.namprd11.prod.outlook.com (10.172.54.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 14 Feb 2019 12:14:37 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 12:14:37 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 3/3] dt-bindings: clk: at91: add bindings for SAM9X60's
 slow clock controller
Thread-Topic: [PATCH v2 3/3] dt-bindings: clk: at91: add bindings for
 SAM9X60's slow clock controller
Thread-Index: AQHUxF7aka4Iy5CZLEquUoPeXmWCYw==
Date:   Thu, 14 Feb 2019 12:14:36 +0000
Message-ID: <1550146447-1441-4-git-send-email-claudiu.beznea@microchip.com>
References: <1550146447-1441-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1550146447-1441-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0024.eurprd05.prod.outlook.com
 (2603:10a6:803:1::37) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [213.233.85.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37cf1c81-8757-40e3-f769-08d69275fc7e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1518;
x-ms-traffictypediagnostic: MWHPR11MB1518:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1518;23:wmrYNR/0Ax2pl3cea4CsUOtcDsomTvNVqkM3WNV?=
 =?iso-8859-1?Q?W9CU3N1sEGorbtwpZ2yCn9iRpL3VDKW3a+M5u3GzrE91UHS/1loOz0ESVg?=
 =?iso-8859-1?Q?0OKugMbRP9H+nDb0ahif5qBLUUTLhxxhuYo2LOdbc2ni7Vui5DO+nGwmIY?=
 =?iso-8859-1?Q?ygMfVMEFI1vmwBozLue7Uciq2mj6DENxuz3E3W7e1fy5FL/kLnK8EpbvOZ?=
 =?iso-8859-1?Q?qpC8PovIqy8sOmc/ublEot50hI/wsZTtNwbXGjDXL7O67h+yeeVVZgXDYS?=
 =?iso-8859-1?Q?xyJsAxR/hCif/1c3IcZJxtEvKEl5ciSV3orYaKof1N2oQpKESy99iURPTN?=
 =?iso-8859-1?Q?cIJWICHE+0DNrf/lZntQ56qlPSJL2UuM2vs+BLVYchSuj4pAvNgv8UkorS?=
 =?iso-8859-1?Q?AGOlEMVHCr7u0O84pfkI8mx3Bs1H8CmbmS4tURe6MpunGkici7zglrTqNn?=
 =?iso-8859-1?Q?VyPrmPwZgMmcu0okoWldhTeWx43uI6jRDkU4bk00/BitKoa1XNuJG3MIe3?=
 =?iso-8859-1?Q?7unrAEs+1nJr4O7cAYvhLXZzt/ES9gZ3kCihDJbmf7QZEih5ENkjv5Low4?=
 =?iso-8859-1?Q?SBiBVkrR4avUteF7vhZl+B+5WEBAyrYQAUYGPu3Aj8Jcy2oJHLycHcK6mG?=
 =?iso-8859-1?Q?uS7oflAhAIzbcqFaxWLR8rAZ7O4/V25Pl4VN0r0sqvHXxo73qm51N8ntTu?=
 =?iso-8859-1?Q?Etiw/lZFDVDhlfqd+is2K7m4xMADr90PqFWSA7h9YMpuBlZOHDDmrH3SKu?=
 =?iso-8859-1?Q?GC3isqoMu4KhfgJI/u/u09j0rL5KK+4IAy/y3eOE7lU+eS5BDML3tZUpNj?=
 =?iso-8859-1?Q?3lwGzDGRltfJ/wtvCfDs6cdV4a+su+OZg2dhxGA7UcAq0jGc/UaVt5UMy7?=
 =?iso-8859-1?Q?BMTIwO7gctNkJ0qpBNHxWHRmKGINr+GNiXmS55x8AlvNYUq+/ZKUKhlwEn?=
 =?iso-8859-1?Q?2PmtPsB9rHyH/rnPYUkOfszn7OS0c1qjgEn2DRa0JyDEo18CIawm7cMezl?=
 =?iso-8859-1?Q?jlg6TzpPYxGPKCcpGi65rj5DX6JKMYel97cXIItMD+52V+bfGXKHMp8J6c?=
 =?iso-8859-1?Q?frq3ZN+fExqsQunH11vOyki+VibL+kzDBQ92GxeBFmrqpkJ0ZDEZRPFmyM?=
 =?iso-8859-1?Q?dSGtHHSPbKCQ/9YJ7ZN8lem9S9U6AAeorM1h2ZAVO5HbCEmChu/HxND7C1?=
 =?iso-8859-1?Q?FOSB4npS/s9NppAg8VqQPRQyDrO7tDgqylxr+3uaEf4sq24VrEKB+18J8a?=
 =?iso-8859-1?Q?cuCTnL/1Jeq4XQq2EfqwdGhWuUuc/R1ukBss7gO3Wnio5p0+v9qJDlxdrN?=
 =?iso-8859-1?Q?TeWCl+G4yV7wbtJP5stdnhu?=
x-microsoft-antispam-prvs: <MWHPR11MB15185067C7D2669F263F18E787670@MWHPR11MB1518.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(366004)(346002)(376002)(199004)(189003)(72206003)(11346002)(107886003)(476003)(25786009)(4326008)(52116002)(486006)(6512007)(14454004)(6636002)(478600001)(4744005)(446003)(36756003)(3846002)(2616005)(6116002)(97736004)(8936002)(76176011)(50226002)(54906003)(110136005)(99286004)(7736002)(256004)(186003)(14444005)(71200400001)(2501003)(316002)(71190400001)(106356001)(68736007)(26005)(81166006)(105586002)(81156014)(2906002)(305945005)(66066001)(6486002)(53936002)(86362001)(6436002)(386003)(102836004)(6506007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1518;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YYB/h5gK12tcULkQ2ysc3QxL5YxBClPJuFCWActjpaded3Nu2UWJMflKb/j25sCHNruGxMtTW9vm7/q6hBI+069qRMcbmCBDwYZBsgHPTpYANKa8hY2vMFQ77aoBD2Y7Ni4ANtc3FZIpEG+EUhvWaQ2NrjbO6IN2vp1vwIAOXR7h9Ba/iyXlPWNNZPRKB/6e2WwnU7sArqrFsUH9R8AnPGPU3IAzkCbRHWQpFJV3+sJwVuQWYsbXlikTbdZSN1Apv60LGdqaPzvcdlAgd14rZvklkyiCVDZOE14EBl5vsWkeHZEr9LixgERvJAnuT9KtQnpHYqb1fRWWZpuYhApewhdiD7Fu/LpTQwxyJb2N01uSlGsycGaoLP+8ybtc8bFN2pgkl1Q7FcUu6YvsNd8ZAshktckCx8xg0jZWTvTDdqs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cf1c81-8757-40e3-f769-08d69275fc7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 12:14:32.9603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1518
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add bindings for SAM9X60's slow clock controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/clock/at91-clock.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Docum=
entation/devicetree/bindings/clock/at91-clock.txt
index e9f70fcdfe80..ce1d21102428 100644
--- a/Documentation/devicetree/bindings/clock/at91-clock.txt
+++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
@@ -9,7 +9,8 @@ Slow Clock controller:
 Required properties:
 - compatible : shall be one of the following:
 	"atmel,at91sam9x5-sckc" or
-	"atmel,sama5d4-sckc":
+	"atmel,sama5d4-sckc" or
+	"microchip,sam9x60-sckc":
 		at91 SCKC (Slow Clock Controller)
 		This node contains the slow clock definitions.
=20
--=20
2.7.4

