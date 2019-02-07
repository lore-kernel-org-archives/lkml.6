Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B06C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DB121900
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="OWPMMwB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbfBGJY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:24:58 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:52906 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGJY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:24:56 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="26410860"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Feb 2019 02:24:55 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 7 Feb 2019 02:24:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1behtaKxCg0m81in3g/HDF2mBd1HLEugmpIuWg2IkSc=;
 b=OWPMMwB9rIRXWwMllHHCI1maK56U9+Q4fZplqjrXnZ+ZncRV7GA9c8u5sMTOxauEhMxcTGjRf4BElIUQFS2P3loH0TBXJAK5XxOCEAeQ45Zy73fG00MmcEa7GJSy5S32bpYLokuUoTUnaSRRqrvc3sYD1CU/N17whVLO5/C01Ys=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1757.namprd11.prod.outlook.com (10.175.53.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 09:24:53 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 7 Feb 2019
 09:24:53 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 3/7] pinctrl: at91: add compatibles for SAM9X60 pin
 controller
Thread-Topic: [PATCH v3 3/7] pinctrl: at91: add compatibles for SAM9X60 pin
 controller
Thread-Index: AQHUvsb7V/4QIMwqHUaeWejdySg3Lg==
Date:   Thu, 7 Feb 2019 09:24:53 +0000
Message-ID: <1549531468-1676-4-git-send-email-claudiu.beznea@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1757;6:2bXW6px+EsAvMRsv0WLbuR99qvn0yzvPhbsLQrouhtyPMtXpEXq6cbytGlEBERAYWkKaBw/2UYhHhVAqfb5wWEwoT8tqqSZncSe9pJ2cKMi+Et6nMXzqKGCgaIeGMFVgmVxPJjK7+Fp81WqJ5fbmp0v8jOE4rtANoGTBzfuN3jlHgjdi0j3/gELZl4puIhXtQ1GvZGQJl79EG1iOe3WmATQ/f9hql/XCAXopvusLRHY3nLI8wZf65+SKIW1It0U2OiVkRZAewQUvvDdwFvoD8o4O6FKyLWdd2JPqZqLAjs1BKGmXaqk0VA7kbH0B++5G+0byqprFKhfWtEW+u3iF2WfRZMoD6j4NsxKkl65JZ362OYXbrlHMKmNspA+rB+G8C6vzHkletpjSATvrXnZgIBSpSlliYCdJI3KhVN1xh1OfRmO9APTTyAYbLerab7s2/1LRc6nulTyUEJ3DaZZ+fA==;5:DSMihR8DcRX95SywSyRNQDaMCvhAWZlxHjAVlgRRwEbzWDNm8uMJfQK2yk3Do0pVj38PX4a5/iEE0uS6x1QtogMPFTEmGgp2prRKvYN9d23aP+i9zzedgWp/y4Foqx/R9Sst0VoQJ8XslPYZrABV80LFtfEu6iRsGxfl9U3GMYkLZUW77FzzPi4nZLFZu0MJICp29SCpy5AO+y2M4ZfnoA==;7:qYrCgUxyyQZN4A+n3T6D9lG1D7iLEUfxe7afYeHEjvdJ9uY7IZ2BEaQ5UIgfaa5wf2ZiVzVUoTffKga0pnDdsESuHoEgrKFZ9CP0LD3QbIWbexW3KrvdDsX660zST5ZypOfHBhWQ44dfAyIDA1UGRQ==
x-ms-office365-filtering-correlation-id: e6ab6708-fec0-4762-7d6c-08d68cde1dd0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1757;
x-ms-traffictypediagnostic: MWHPR11MB1757:
x-microsoft-antispam-prvs: <MWHPR11MB1757546D2D1E0B278300876387680@MWHPR11MB1757.namprd11.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(53936002)(66066001)(72206003)(6486002)(256004)(71190400001)(71200400001)(99286004)(26005)(102836004)(386003)(6506007)(4326008)(25786009)(478600001)(2906002)(76176011)(186003)(52116002)(68736007)(316002)(14454004)(50226002)(97736004)(8676002)(8936002)(86362001)(6436002)(81166006)(81156014)(2501003)(2616005)(6512007)(107886003)(446003)(11346002)(476003)(6116002)(486006)(305945005)(3846002)(6636002)(106356001)(54906003)(105586002)(110136005)(36756003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1757;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6EHvCMm8S0ibppWj2bAhuIeUcTDpTjKHxp4CH6UjgtHYgb1H7FAG1Dn75O70+ymuZLBBOGiCxQrGNfN5dHc4YE8lQSxuy5eXMcP3lH9MqLvmaf1PpdXmIMCO8aG6d6ljPhwyYM9vCpVBQG6OhTtT1zOcEmG/+hFfAHzZW2XpEb60YuLUytc5hEoPd2LB5rtycm586n0zG1PuOhZbhvdlflNZEruaPtQOcxAmuS5YSI6hUOwyEMmIcUmXWiNqNU2aKD4qTIwIHeMdUMFHB4E2fZeU12d9PvPwJiGvs06n255Z80QjhrUrm4a+0Mm9zOeoIiJl3rR7MNMo0UP3aQhruwLkU9skt9t4OpR+bmdv6ezTQgM5/7q8qWhY/ppmDJFopP6KEMEb0yhXKYf3xi+NZ2+PyHT/c+Z5baOipk2YZ+8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ab6708-fec0-4762-7d6c-08d68cde1dd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 09:24:50.2782
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

Add compatibles for SAM9X60 pin controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
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

