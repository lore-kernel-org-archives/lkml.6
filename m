Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D601C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAE52087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="WQsKKfw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732943AbfAaM3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:29:37 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:3208 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbfAaM3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:29:36 -0500
X-IronPort-AV: E=Sophos;i="5.56,544,1539673200"; 
   d="scan'208";a="25981390"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 05:29:35 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 05:29:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbLrbOt6+Bcb9YYxkB0kkjLn8iVxj1hXo2Nyy3ZAoJg=;
 b=WQsKKfw//J8zkn5lXlXwVDZABwsiABcAv7X8AmXGzVkHn1dEAeYlWs8a2VEup8sGLsJXBAOD6kVoPFTi4ieHqJDQt2vScHz9TAJppNGiNfcm/0Zmrn6C5qi/zmJlJBfuI5hZGudxfcCRa/QF7d9o7H/tKBNy3JTpQs3kEcl14tg=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1454.namprd11.prod.outlook.com (10.172.53.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.19; Thu, 31 Jan 2019 12:29:33 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 31 Jan 2019
 12:29:33 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 3/7] pinctrl: at91: add compatibles for SAM9X60 pin controller
Thread-Topic: [PATCH 3/7] pinctrl: at91: add compatibles for SAM9X60 pin
 controller
Thread-Index: AQHUuWCeSP4bG3gsKk+RqaWqwuohGA==
Date:   Thu, 31 Jan 2019 12:29:33 +0000
Message-ID: <1548937733-20189-4-git-send-email-claudiu.beznea@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1454;6:vOksYcFodv7aynoXeKQB+vvhCTLTJTgLq3u5DzQn+ca+ZjWZK8uKCnArA4lwXEBz5cymij+WxhEuKh2kErtA0Hd7DMiss2W+kq9WcM0ZoX7rAi1UV8YpYJeMI02GN7jdpJS+jNQaxtjUVrfc3HdERobb253TkGnW2xQYmCFe+9jemZow0H7dPKKwx1p5YSk91TVxbcFeSkEqpwOmyQiNEJetvr0s34q11MlYArpAiedR0le2xmr/iksJfW67P2Z1UArO9iNsTRHaYJNcygVl9J113MNMgk3Q1uEW0huATRGQX7esKoosEpTjBqCeO2cLk9yzBCJ/PJn/iUZ6esQ2mt2hcYttcNwbd0PofKpqXSlhiIy5ZBD2eicODa13QawDMX0F9HrLBX6XG3ajyfGrLiFIVsudmzQI+EYSJ7THD5F4h7/SMHh5EhmX5fIbxyON/6PwfV7pFhlhcMFIZ8Ao1A==;5:YwLXMGf0CJypJx9u9lem634yeqisNhlTI4Q/YcAtoTjkED6z8b0kAIJi/LPgKnTJBQ/u+R1kLObgwcXLUm56+2LRbgWyPmKh2dZ34iozeGMywjMyecPOC3ianVnndJ3pP036rvALGJD+o1aSZSlPCnavAt+YZlGNXLPHGcm7Z+UfpKf1Qmo0DkWPJjIU8pXpQbN3t+LhWKm1atq9vzFQpw==;7:LpkuVrop84uQLR888YGzH01vDnSNu3dhRdsUmp+STZOiUBMkDTy0fxKMgRQYceHE64i8wYcrafRkkUj8gdZ+sRjqSJcnjlHQHPuZITMf7kne9eD9NDwcPdzdNHUYNmZ47gaoszmeNUJXPeHdbjn7xw==
x-ms-office365-filtering-correlation-id: 78f9ad3f-1cee-49a6-cb30-08d68777c0f6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1454;
x-ms-traffictypediagnostic: MWHPR11MB1454:
x-microsoft-antispam-prvs: <MWHPR11MB145412DAB5A1F140485CCD6E87910@MWHPR11MB1454.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(2906002)(110136005)(186003)(8936002)(50226002)(4326008)(11346002)(25786009)(6116002)(2616005)(97736004)(476003)(305945005)(66066001)(3846002)(36756003)(8676002)(7736002)(14454004)(72206003)(81156014)(478600001)(68736007)(486006)(81166006)(107886003)(52116002)(99286004)(6436002)(316002)(6486002)(446003)(86362001)(54906003)(2501003)(256004)(105586002)(6636002)(76176011)(53936002)(106356001)(26005)(71190400001)(6506007)(386003)(71200400001)(102836004)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1454;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XkFPmvCsGC3IV9/Linehc22wCtAHlyzcUObgJ2z61kjh3AM+1+2h7c73ebvODjC2NhPiIgyO1pcvua1Ocr5aYu5BfkJy9bzJciEQk91xAL7pRjqVkWkaZ2djW4IgrCEAl76WTHbWBso/kxfgfm+WcHUZd0hJiBb1DBWW58jiaT403H4mPauvvSzLFV6tlOIur6vaw5W5C00GuMG+pT63XRrTg5B9FcmIT/vKPNGDzXNFGSzjI0Wejz5w0WPtdx1hOBnxDUQM7y8z0csflry37/WoZRAW8SnKEqLHcbfTcM7o5LQEqEhhoffAijWMWIUjxOjgz1KJd+QVgUmJdg6UvbMBgxyjT+ofE4azAv4d5l1gj1bA4l8iBg18vO3reo/FSrpz8tUkTPNtIrXJkedj0hPe8vCkCknVd59zp8P+jrM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f9ad3f-1cee-49a6-cb30-08d68777c0f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 12:29:29.7866
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

Add compatibles for SAM9X60 pin controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pinctrl/pinctrl-at91.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.=
c
index 46443b97d811..5456a2692b8c 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1215,6 +1215,7 @@ static const struct of_device_id at91_pinctrl_of_matc=
h[] =3D {
 	{ .compatible =3D "atmel,sama5d3-pinctrl", .data =3D &sama5d3_ops },
 	{ .compatible =3D "atmel,at91sam9x5-pinctrl", .data =3D &at91sam9x5_ops }=
,
 	{ .compatible =3D "atmel,at91rm9200-pinctrl", .data =3D &at91rm9200_ops }=
,
+	{ .compatible =3D "microchip,sam9x60-pictrl", .data =3D &sam9x60_ops },
 	{ /* sentinel */ }
 };
=20
@@ -1757,6 +1758,7 @@ static const struct gpio_chip at91_gpio_template =3D =
{
 static const struct of_device_id at91_gpio_of_match[] =3D {
 	{ .compatible =3D "atmel,at91sam9x5-gpio", .data =3D &at91sam9x5_ops, },
 	{ .compatible =3D "atmel,at91rm9200-gpio", .data =3D &at91rm9200_ops },
+	{ .compatible =3D "microchip,sam9x60-gpio", .data =3D &sam9x60_ops },
 	{ /* sentinel */ }
 };
=20
--=20
2.7.4

