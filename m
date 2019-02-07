Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BB4C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4CD20844
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="3zYKfebf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfBGJYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:24:47 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:8559 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGJYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:24:46 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="24330582"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Feb 2019 02:24:45 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 7 Feb 2019 02:24:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynta0psa+AKWg0L+MF6YBSwvutKA+OA+XlTc5mV0NeE=;
 b=3zYKfebfHPEpY3xhmJwi7WzMR/X/hYzfS0ZsBuITZc/A3T0QrLLOtngqBfXKBbKmpKhIT9567KgOsC9+Uz5OhIu2nY4vchbjfgXRwNJ+QCES2B1ZIemxii0FPRboKVYMnVSVJ295UyeQthIjTZHAemhUejMrBD8rHtlnKjtd+yU=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1757.namprd11.prod.outlook.com (10.175.53.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 09:24:42 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 7 Feb 2019
 09:24:42 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 0/7] add support for SAM9X60 pin controller
Thread-Topic: [PATCH v3 0/7] add support for SAM9X60 pin controller
Thread-Index: AQHUvsb14lJoLHRGlk65NLnVLpg+fw==
Date:   Thu, 7 Feb 2019 09:24:42 +0000
Message-ID: <1549531468-1676-1-git-send-email-claudiu.beznea@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1757;6:dTMBKAfk0gzuRmYpm24iV4kY+9Wl/nIJ6jnF026dW/eRkO2Xg+rIIs94LPgANaG65IQJA2sR9radmX/IcVp6/wnBO6QpRlgmpjfkrYbkzJ1GDYz95kxV/qEjH3h+tUzFua3IR+B94BAzJn+k99TWnCHEhZnHMR+jokuIOlrQxN0FI8tbv303Rhw4NyR5zSZHgzazA4V2EUmmXFOOumIzVejHmeq4MKOE8fhUMnmErruKUKzSRm0MZ9eUKXWQGkxAQjAXNB0U4mAN/muBstcQll6b2+sJVUd/VkAaf1qRDCQwEpSbJwNVQbSAp7VqR73v00ZaHWncIY+H8JmAwjrZr982GRAqWGqueXTHi5xMhmEa1fNKiHhkPF1BOEgh1vVt/juRCnGaylQvJSpUnOaNZdtVwd/1Jy9qDo4GeZPxxUDYvkkg1VoO66WnVdQiPtIR+YMBkkBT75niq4Ks7VcxBQ==;5:BywbDL/w6nrs4PtrKhbyYQeEUyJ1pACgejrHUbpCDkue7Bb4c1pMvwU5jYOcnBgrIEf/giYSQihqqBjk5YgBGCkuS2TVg1tbsJ6dyC8M2VPNaU/X/V5Xzr31kkHdL9rpzkSCWBNPkDJ2wYuAZLtLp7zQ/2KOCX9tZ8iSAvtwMP/BOpvn8cwb6d2nDlfk1ot+AJE6nu8CnknT08QI3SDEgw==;7:JwMj+H0xsy8Vfo03TGw29y4n/WyGKRfHhQWLeZZmk7Lz+RFvtEqMGJa0Z1p0t0w4r7ULSYknpj7oAp70v7SDXZLa2D9Ouxj+fjxWF9XpX46LAMZyaSUksMyd16JZYIBqpRaWJeB6VMOA3LTa3712Lg==
x-ms-office365-filtering-correlation-id: 74bb4825-59ba-44d1-e151-08d68cde1719
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1757;
x-ms-traffictypediagnostic: MWHPR11MB1757:
x-microsoft-antispam-prvs: <MWHPR11MB17572EFD0C39934B9EC0C33587680@MWHPR11MB1757.namprd11.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(53936002)(66066001)(72206003)(6486002)(256004)(71190400001)(14444005)(71200400001)(99286004)(26005)(102836004)(386003)(6506007)(4326008)(25786009)(478600001)(2906002)(186003)(52116002)(68736007)(316002)(14454004)(50226002)(97736004)(8676002)(8936002)(86362001)(6436002)(81166006)(81156014)(2501003)(2616005)(6512007)(107886003)(476003)(6116002)(486006)(305945005)(3846002)(6636002)(106356001)(54906003)(105586002)(110136005)(36756003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1757;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m3zevOaPQK6KEe1EPduE1vjI5ldwoNeXC7PfG9/eJWwKaoCgCRKWJN4leEqpTtrGEpoZAU+De6LhflLef3403J/Vc11MGjD6k/5eHZCvECnaYNTXrhmiUT8Iyu2GzmCv8WWCtHFe1u/+g9HB0mpXMICrf4ivT4UgaqLDHr6fsWopx5EFEX+kEiVxC6JA6acbSGExVVfsQ0Sld3aqldQ+o/HTiomDngBMdsWKE3Dan96EW63WOMLfIz2CKUvfZuG6wM18V4Jl5JSSLJ2Vm5HtwpwvCyTlU1oP88MqAwCGuAF5nKReWya+3Xw1hbD8PWm8P41Y5eDnN3Y29Mx0QVkJ7NKdeYM4nSWAed7x/L79sw+ksK45Ox5j+z4GnCi8V7NeM8xckaATaBUdEv5tXxyHNRv/jE+U/S13XgqF3JLHMU8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bb4825-59ba-44d1-e151-08d68cde1719
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 09:24:38.7129
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

This series adds drive strenght and slew rate support for SAMX60's pin
controller. For drive strenght we could have 2 values: low, high.
For slew rate we could have 2 values: enable, disabled.

Besides this I took the chance and adapt the documentation for at91 pinctrl
driver.

Changes in v3:
- fix checkpatch.pl warning on DBG_SHOW_FLAG_MASKED() macro in patch 1/7
- add Ack-by tag

Changes in v2:
- s/microchip,sam9x60-pictrl/microchip,sam9x60-pinctrl in patches 3/7, 5/7

Claudiu Beznea (7):
  pinctrl: at91: add option to use drive strength bits
  pinctrl: at91: add drive strength support for SAM9X60
  pinctrl: at91: add compatibles for SAM9X60 pin controller
  dt-bindings: add documentation for banks
  dt-bindings: add bindings for SAM9X60
  pinctrl: at91: add slewrate support for SAM9X60
  dt-bindings: add documentation for slew rate

 .../bindings/pinctrl/atmel,at91-pinctrl.txt        |  27 ++++-
 drivers/pinctrl/pinctrl-at91.c                     | 134 +++++++++++++++++=
++--
 drivers/pinctrl/pinctrl-at91.h                     |   3 +
 include/dt-bindings/pinctrl/at91.h                 |   4 +
 4 files changed, 155 insertions(+), 13 deletions(-)

--=20
2.7.4

