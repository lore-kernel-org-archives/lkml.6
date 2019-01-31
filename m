Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E375C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5B6218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="NqSK/ILr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732959AbfAaM3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:29:41 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:62229 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbfAaM3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:29:39 -0500
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; 
   d="scan'208";a="24062168"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 05:29:38 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 05:29:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOuAGL9BaiJknZEJq36gOOSa4pvqQRiuEsByjdI3VQY=;
 b=NqSK/ILrsyiKh6hdvau8WMcIJKcgH2DHoQp67Q2I9vBlbNr7KBVVRrmodcT1tWeRfdw6fAjWq6pm/kxck+QoPAr4HvDJtKcBx617cEI5MwaDN89BbKWg+yQnSTQexyavGdylWr0fn6l0bnSqm4UMcoE1WyGg8tTr1sGfiZ16Igk=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1454.namprd11.prod.outlook.com (10.172.53.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.19; Thu, 31 Jan 2019 12:29:36 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 31 Jan 2019
 12:29:36 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 4/7] dt-bindings: add documentation for banks
Thread-Topic: [PATCH 4/7] dt-bindings: add documentation for banks
Thread-Index: AQHUuWCguV+dQCb06kSLfW/IXmMF6A==
Date:   Thu, 31 Jan 2019 12:29:36 +0000
Message-ID: <1548937733-20189-5-git-send-email-claudiu.beznea@microchip.com>
References: <1548937733-20189-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1548937733-20189-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0036.eurprd07.prod.outlook.com
 (2603:10a6:800:90::22) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1454;6:9bF87pgFoUP0rbuC91GpKYgANWEmyjJtDE/X+eywyQu3aJKFTNbzUOyJtIW8hcCBmIza3SzKFVs8u1oIZrv/nlnQtqmaH8WgXxV+SzQciFVxqmMtOL1JupPbn7I9u19dgD3a8aESVYMkVqfkJEgipFJj2QPVfH0iBsNL7ZvWpnxjAkbqSO3BMItkNwrM0OvuWaqVA8o6NQh1RHg5qereKrC6tET4ygwDIRuODzsKYWszl6hKJ5/UdHYNxtjb8K0TGpZvWmerOiIcvZRt4WcKGcwNmTCU4DSDPoIncpe7gkWxI0nV+BHoci7L/tHHhaTCbvG+LDBw6UCOFI01bzYykB7G9Iw1aBxm7eXCYoo+vYIB/Zz7ht0Q7ERiJb/QzHql1fbuUtOGX3K3hqQJIEYYXY7xWSzqq8dTtACWjW4KuxHN+CYEAuhpDYmtuYvHXnJsraR9/etyhAI9sbuvKxZ0zQ==;5:0rwMdLs9jwk52GwV44xD1lECwsVCmnPvBLRZRDjzuvWCK4F/zr+vG4cruWITiOlhLnTHLXCYaT9PPHWcf/EOQPQaIRF6wP5NMVkQtiB5fJawdcfy4U+gdRs0/3Ctq+0SxGgzbd7r/HmhZs5gJsTXswbZ1LR5blEQNYi6bE0WEW7vwrgWSTmw2TF8J0CwSQ93jMQreq34pONL81U/jQhu0A==;7:0iBGx6dovW3jr3vjKuR7D+xD7Z0E3PMZhGWuso45jfbfrq9s60y/CoJPytEeUgedo/yBdbKcTM18vYVTeIntZaLQviaMbrY5aXe3NTS8vaYJ5tjCGdE2BXEjdBvFM0EasGZOuJcMRJnNQbTENB/4Sg==
x-ms-office365-filtering-correlation-id: 9f10e0e6-9757-4ed0-6ebf-08d68777c318
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1454;
x-ms-traffictypediagnostic: MWHPR11MB1454:
x-microsoft-antispam-prvs: <MWHPR11MB1454840D1C2CE05BD22FFACD87910@MWHPR11MB1454.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(2906002)(110136005)(186003)(8936002)(50226002)(4326008)(11346002)(25786009)(6116002)(2616005)(97736004)(476003)(305945005)(66066001)(3846002)(36756003)(8676002)(7736002)(14454004)(72206003)(81156014)(478600001)(68736007)(486006)(81166006)(107886003)(52116002)(99286004)(6436002)(316002)(6486002)(446003)(86362001)(54906003)(2501003)(256004)(105586002)(6636002)(76176011)(53936002)(106356001)(26005)(71190400001)(15650500001)(6506007)(386003)(71200400001)(102836004)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1454;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 72nxGo1CEeFwKrnfOoD+rSQihYsr7KKg1ZQRZ28ic+0XOs/49l9HQCAVCDNfOoGXZaUHNoNXrRH8wbKkruSMX9/dnarLdpQ44jyJdYc/wx/gjWDU5hevhOpYeR0d5yq+1wWTNnt0Z4xFSplRO+9gXjKagHfo1eEJeATrrGNJaXDzcQgF39Mitq0b0iTwJc+GGn2cuyKZxrG+5GjzjhSi/UEvjWg1ez0O+d12QDRmsH8KiDekw59NeRAeJHIk/ie/5cOD0gddFrJeTR4liCmosSx4oCMTfP99JhxoZhMh9o/Z9PKwy1kCTRQP/BrhZRbJxsYjU8xRGhEu1BM8ELPrkjobcp1N4IP9DAodpHyHOiBX3uf1SGJHaDK/fgU9aDqU/vEItb7khT1dNPSij/xJNRbyBVX+OA3PrmBte97J+f4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f10e0e6-9757-4ed0-6ebf-08d68777c318
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 12:29:33.4486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1454
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add documentation for at91 pin controller banks.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
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

