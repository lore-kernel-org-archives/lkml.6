Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E993FC282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79AE20844
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="hL4qyjlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfBGJZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:25:32 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:29540 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfBGJZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:25:00 -0500
X-IronPort-AV: E=Sophos;i="5.58,342,1544511600"; 
   d="scan'208";a="23535629"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 07 Feb 2019 02:24:59 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 7 Feb 2019 02:24:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlUsA/wD8ToN7/UR3246X/TwBw3N7gsqgXbbrWr1iOg=;
 b=hL4qyjlKo/YjXknU8PAlrV3jurjoUtCIhChabRE+ib/ueSqY3Yduo7YA0i9fmZuIZC6Wio+6O/WmSp9KYhXjQuj7P93h4BQmxDyyUxacyHDjScIDGn1mzND1gnEVeffYFywhmOfEVxTUikLFeXttfu1EdIoOEQWHtuCWsov/ne8=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1757.namprd11.prod.outlook.com (10.175.53.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 09:24:57 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 7 Feb 2019
 09:24:57 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 4/7] dt-bindings: add documentation for banks
Thread-Topic: [PATCH v3 4/7] dt-bindings: add documentation for banks
Thread-Index: AQHUvsb9IFl2jeGVHEmCJ2ljPSVfhQ==
Date:   Thu, 7 Feb 2019 09:24:57 +0000
Message-ID: <1549531468-1676-5-git-send-email-claudiu.beznea@microchip.com>
References: <1549531468-1676-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1549531468-1676-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0350.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5a::26) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1757;6:imuhh6jjFZ2sCwjmdRfY6STllOY0cPiu9MlGoOqkdLP7lgC26HI15FluD3sH7lXtsjfu8XkmbvWFDQZr5dZau2pNXXMtUALCnTtoVUeaF80xoLVVgTqt/y98Nw1T1X8JjPWPMEoOnyMjwNCJpaf9tRbaX1EMu7JnpX3nctq51PE1X7pfHx2RY4KKHICPoE/EjkFG+Pg3NMutZHLyq4Xx/+O1ABJ83AGp+U4WVgV2q53KZCG6ocCSte3evZ7v0wOgZ2bQvYoSqtlOK1rnyN+JP+7GalDMBIhJirLPoqqzxQG8Ip2jgY7qLYf2axVH2kEYRNehfYf21eU09OoKMG5bH4mMNYTrfaUwjDBtsqCnd6eIq9oM9frL9wEUFgRfLnWKwmIWOlbg67MfaFhgx7TL1qd/BinVRvUlXnRhvBM7/LL4gExPvmoZGhGw+rSVadlK/T32sbh5ZADqQz1aAi+RxA==;5:OmXGifu/BFGJK4ApdoHVM+xaEL+19UBHTVwa5HX9xpANdHVwlXx3iE4m7z4paUskuSXkNe8yVDCeFjOKFkNnb33qWJk7/R4xM7Zk7fNMaaiMvEKCXKRTshtB9vTXZii87oWxh1bGz76af9B0rS+qGFCxwkkSOPn6s7+YGYvYPun0rwikWpePNu3jSAO1j6dLvJtQNH81xCHxVHbBDQ6vDg==;7:nxhlkQIfzA5mMhp1Y9wkLZqQr8ep6UQ2tA4sll7H+Se20GBPZhmJQmt1Y3UjBV+k8i44KNqgnLOmQIH+mvLLfBSCAKq8M1Uxvfc+BP7TJNIA47tLnqwdfBbZYZF7OVEmKbO/fDJalqgsgv0tacKlbg==
x-ms-office365-filtering-correlation-id: d63a2b07-b5f7-48e1-3ff5-08d68cde2015
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1757;
x-ms-traffictypediagnostic: MWHPR11MB1757:
x-microsoft-antispam-prvs: <MWHPR11MB1757B961629EC33A9F47494C87680@MWHPR11MB1757.namprd11.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(53936002)(66066001)(72206003)(6486002)(256004)(71190400001)(71200400001)(99286004)(26005)(102836004)(386003)(6506007)(4326008)(25786009)(478600001)(2906002)(76176011)(186003)(52116002)(68736007)(316002)(14454004)(50226002)(97736004)(8676002)(8936002)(86362001)(6436002)(81166006)(81156014)(2501003)(2616005)(6512007)(107886003)(446003)(11346002)(476003)(6116002)(486006)(15650500001)(305945005)(3846002)(6636002)(106356001)(54906003)(105586002)(110136005)(36756003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1757;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r+DK4KYD1V+yAXRcbBx8bxscUvCKKExw4xqg7Cwk3HkjjRLHYkQLJJa6AMXSpYFD7x4zJAa0ap5WMbifsoFg2vaiVFH0H3C39Ss/fq9WRPnXLMPrvDHez7daH4qwggSPIPICEcA3HtS8kjyXCCywJwEfwLNs4t4ZZo6wFk9MUB8mTmNaBSnDydMlFho0Bw72J8KOPc3c4KNKfL4eE2sKs2zlNuPwskqZrskp6/YKAoFWcqamis+p29r5GEuGxmtNo6dhpCoQjx6sk2GF3jmbNJ4Nwv4VzUKBibPzDeMZEvXumlrg9tX8CNPTOywINep9bGIWYdm6a0ZC/IIdDePGcuCnuNv+jXcl84PUeQur3U7UdRGH8htZOZJksVIu+yyzk2ukGtG0hul3erZFX3a6up6zCFjLJChD7Tmcmj3ClLg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d63a2b07-b5f7-48e1-3ff5-08d68cde2015
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 09:24:54.0673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1757
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add documentation for at91 pin controller banks.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 .../bindings/pinctrl/atmel,at91-pinctrl.txt        | 23 ++++++++++++++++++=
++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.t=
xt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
index 3e23fece99da..40e33dfc36fd 100644
--- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
@@ -116,6 +116,18 @@ Some requirements for using atmel,at91rm9200-pinctrl b=
inding:
    configurations by referring to the phandle of that pin configuration no=
de.
 4. The gpio controller must be describe in the pinctrl simple-bus.
=20
+For each bank the required properties are:
+- compatible: "atmel,at91sam9x5-gpio" or "atmel,at91rm9200-gpio"
+- reg: physical base address and length of the controller's registers
+- interrupts: interrupt outputs from the controller
+- interrupt-controller: marks the device node as an interrupt controller
+- #interrupt-cells: should be 2; refer to ../interrupt-controller/interrup=
ts.txt
+  for more details.
+- gpio-controller
+- #gpio-cells: should be 2; the first cell is the GPIO number and the seco=
nd
+  cell specifies GPIO flags as defined in <dt-bindings/gpio/gpio.h>.
+- clocks: bank clock
+
 Examples:
=20
 pinctrl@fffff400 {
@@ -125,6 +137,17 @@ pinctrl@fffff400 {
 	compatible =3D "atmel,at91rm9200-pinctrl", "simple-bus";
 	reg =3D <0xfffff400 0x600>;
=20
+	pioA: gpio@fffff400 {
+		compatible =3D "atmel,at91sam9x5-gpio";
+		reg =3D <0xfffff400 0x200>;
+		interrupts =3D <2 IRQ_TYPE_LEVEL_HIGH 1>;
+		#gpio-cells =3D <2>;
+		gpio-controller;
+		interrupt-controller;
+		#interrupt-cells =3D <2>;
+		clocks =3D <&pmc PMC_TYPE_PERIPHERAL 2>;
+	};
+
 	atmel,mux-mask =3D <
 	      /*    A         B     */
 	       0xffffffff 0xffc00c3b  /* pioA */
--=20
2.7.4

