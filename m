Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176E8C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06892085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="SeqTyQfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388425AbfAaQS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:18:26 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:55808 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731284AbfAaQSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:18:25 -0500
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="25990854"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 09:18:16 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:18:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7SiW3SCTYNkk0jtPDSLj3jDQJoXRh3t/ModQ4pN26A=;
 b=SeqTyQfQRaZLI8y8goTeblWBnrHg6eGIZhDkNEB6UMlh4qcKMx9aH1QqQlf+UkuCrrBlG5oDkfW6isSBNXeK7nprsqH/33yCqk3ZwN+18Z1TJvrngpychWicqoS4MIAgvMFPf+7BD32QvXzJJIMPnYW9rg0ngWO7MJ+l3uf2F4k=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1424.namprd11.prod.outlook.com (10.169.234.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 31 Jan 2019 16:18:11 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 31 Jan 2019
 16:18:11 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 3/7] pinctrl: at91: add compatibles for SAM9X60 pin
 controller
Thread-Topic: [PATCH v2 3/7] pinctrl: at91: add compatibles for SAM9X60 pin
 controller
Thread-Index: AQHUuYCPg1+5AEh47EGxBbyJWbbR5w==
Date:   Thu, 31 Jan 2019 16:18:11 +0000
Message-ID: <1548951466-26297-4-git-send-email-claudiu.beznea@microchip.com>
References: <1548951466-26297-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1548951466-26297-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0116.eurprd09.prod.outlook.com
 (2603:10a6:803:78::39) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1424;6:LgS/6f1I1xVr+Ci7ahFDJYBYQVZx4sWDR7nKVe5Su0BXwhVPJitvqGg+nqqFhC9dYc4V14NWyHfLH/CR4NiOpx12dHPEpacmitZLlXr/9XjvO65Y/69Cc95B6bq+nk/0TqgdxBtSRXoFeeNht+tILqCIjRIHl4oaKP8iBnFbX29D5QO481fyrvTmwnsgIG7cXWiSjgYMh+LVAYiQwSDTe7CupyQLQxcUoSsbEJywYaoz0nLAnKUjKDRTpVfnhSWsCm6X72cRNjsjfCWnmtVZQiuq0H1B4A296eS6wxenVnJUd9k6VV+G7NM3ee8C+9C2WQ8MbHv/1/dbFY07MokVwP3+EmJBy54TGo5JYVpG96o5GeP9PxT4uLWUzkbtxoHSanOZeWOCT5BUKg1scTrAt2o30mMDK1KyE17mCd6A1xZUijhbT5KSha3e4noR23txV4PK6sAdyseBFDr3HQnMWw==;5:rjhp9We//mvDbca0FomCbwpnHTedbqZB2mDQu8t5YVpjOa233AE3tBsrh0VE7YRApWeCIvcuVUSVX9YG4jd3LMgAhAbMRcKiqAnfYDA3+JC2sdIegqTCDXxGxAk7dTAVXQqGVxXjdGcaP9DwUbEcXZW+OllDiHdtZG7W+q5e+OdFljKYV6+mtbrK02J1UjMaS54Ro5eUb3lQZyIME3SQpg==;7:+yU7uWulmLUafZnVkzLzpj34Ub4rcf7Gr/6cd/AsljvmuNxkTqWumZVy4+ryBK3yzdXulF/ocKftrgZR8MFdbYrWJdjDijMTEwINQDxQZDYSFF3nb6PrPGfeFyU/SCQUPedAL/khc6Ysjxlt3awWHg==
x-ms-office365-filtering-correlation-id: 35ff8300-1dab-4cd9-02bc-08d68797b199
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1424;
x-ms-traffictypediagnostic: MWHPR11MB1424:
x-microsoft-antispam-prvs: <MWHPR11MB1424B34B5F4DC7634387C49C87910@MWHPR11MB1424.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(189003)(199004)(71190400001)(186003)(6116002)(81156014)(107886003)(99286004)(86362001)(446003)(8936002)(2906002)(53936002)(66066001)(305945005)(110136005)(72206003)(8676002)(68736007)(81166006)(3846002)(478600001)(25786009)(50226002)(54906003)(97736004)(4326008)(36756003)(14454004)(7736002)(316002)(52116002)(102836004)(256004)(386003)(71200400001)(26005)(6512007)(6436002)(76176011)(6486002)(2501003)(2616005)(6506007)(476003)(11346002)(105586002)(6636002)(486006)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1424;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4lymNMjsG6xP6i4w2HPZOJdCLay+iuBhIXr4eDHj86z4/Pu91tU1CZvyIDwzXlgolRP2ao/zZG+pRzBLn2vMflpQjUtLiuY30GUntsR9oazU3X7BUdAVRjJTOplmCMxs6dFX918ZPs8xrAz9e3lbRlBuaoNJNTHwgawjpIF5doMfMe2eglhwWuQjRA5yIbTwOcUHBq868zYrTOdmLzqWEYD9Xr3stEb4xT6Hgx6KKajHxf5jOAN8gAHeceCi1RFgWcvFXkYk5/goZY4c7kqHYJbo8AUe7ZdWNViu+iEZffRyoIoYOkUeuv5a6GxPKN+zwaSL7nTVHZwFuhfGLJstQzxNUv/6VUYJyW2PB5F/xUnwdqI6IQy2a/EH7bOPhIR+SBHjU3c/zlsYrz/WCcWXXlB+qgslZF8yE7b5FLpLwP4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ff8300-1dab-4cd9-02bc-08d68797b199
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:18:08.0397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1424
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
+	{ .compatible =3D "microchip,sam9x60-pinctrl", .data =3D &sam9x60_ops },
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

