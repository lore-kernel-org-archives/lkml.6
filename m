Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D310EC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A07B2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="bf23ISaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbfAaQSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:18:03 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:38453 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388143AbfAaQSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:18:03 -0500
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="23261716"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 09:18:02 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 31 Jan 2019 09:18:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFNU9hQrbzz7MnAddvvx938X9tBXjO1zBd6niod8Zlo=;
 b=bf23ISaSgbnnJKSeduOp6/T4x+9hM1LGz4AciDacJ2r+9PvwD++e7Mxb6BuOMqaEBCEjdNn+rd2cArMc7Y8/AOdkc2k9gmQOL96EHj/TeEQuoYYrkFw9XjuSUrw3sQN5gAQveJSlmIk0iBiKsFJZ4Kd/WbnU1wBhmgVxNNs37zo=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1823.namprd11.prod.outlook.com (10.175.53.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 31 Jan 2019 16:18:00 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1580.016; Thu, 31 Jan 2019
 16:18:00 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 0/7] add support for SAM9X60 pin controller
Thread-Topic: [PATCH v2 0/7] add support for SAM9X60 pin controller
Thread-Index: AQHUuYCIYmzCBuLbeE+gbwGCJdU00w==
Date:   Thu, 31 Jan 2019 16:18:00 +0000
Message-ID: <1548951466-26297-1-git-send-email-claudiu.beznea@microchip.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR11MB1823;6:AT67PYUNSVbBaNRDS49vrwU1reNfRhk9AphzAepjK2fSxOw89gyXn8q1ZQmkd6TJjGcWagDG+qbNQf2r2m5GJhQu+WOU1boiCuBvXykE2L6wJ138K9/vV1wC9tgmluhLpC5Ux0sNKV0m7BjkhhrXDsWRB/hG5tQrd75ZvhUTBr3ekzvWe6Hb47Iq9xYhtAHU1weULHO+AXjxux0qFeePPYSEod/ZQtn5SqMvwBrRJlLABXGIvc0Ou6ruESUvodJrfyCwwBSgucOkPbJmYs+k55+Ngy1yFNgTAgv6YSTC2r9Dhs2t/pzxCyNECu2UvddW76GieQ13SIqhI1CHi3/deZrQM2+MYSblY6OU0uQrTAaKgDPtLwBewuTHRCvXpdq6cnq3w3E4adjBKzBd/G+Mm3jeu+jgPXzY0Gc06u2YNswN3XeR/Q8kA7wtNxnEnPLBOVlzTvMm48soEaHeT74D0A==;5:oChDtB5CXO915i4ksr5iXIThEdBNx4bGGFwhhgn1qLV7c56BOQkJObkVNeQZ4CUxnEhm6WfNKIE9sT3L8iXpetMjlDmsEi2EJnwzslHZCDVoPH7z2QKTYEENVtPKNofKaW6/asm2sqNiZWltMoaeovrn3uchE0RCecI9oSGDrL7wY1GEBhmfmycTfczN8hFJWJOKoYJBhRNWjMqrFCtk8A==;7:baTlKAc4BUwVGHjCw6fQG+aFjdprgkoIl/NS1CQiuruqd8Sjy3kT9GTTUCmxiK3tQZcW9peoPa1qDiMSZMb/ACfY98Sf6kykiuzGl8yZZ/x98qe6BxR9gjUOznPYzFH5C4i+7eL/bjfc83j1xPrqlg==
x-ms-office365-filtering-correlation-id: 48874f41-44bf-445c-057b-08d68797ab14
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1823;
x-ms-traffictypediagnostic: MWHPR11MB1823:
x-microsoft-antispam-prvs: <MWHPR11MB18236B40ED7B1E52B4C1BCFB87910@MWHPR11MB1823.namprd11.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(8676002)(6512007)(14444005)(8936002)(7736002)(36756003)(305945005)(478600001)(6116002)(106356001)(71200400001)(71190400001)(86362001)(99286004)(72206003)(3846002)(486006)(52116002)(14454004)(256004)(6636002)(2501003)(2906002)(26005)(6506007)(25786009)(4326008)(68736007)(81166006)(316002)(6436002)(110136005)(53936002)(81156014)(186003)(105586002)(107886003)(6486002)(54906003)(386003)(2616005)(97736004)(66066001)(102836004)(50226002)(476003)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1823;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SLdy+hXFiaosAg16NzwLy5MCEwoqL8tvKZCxo1orMZJlMZcZRH0IoH7ha+5Ce9zwSQk6r9kGpBREj4B4NdSm9KPWMPnw/LAUpKXqaKXI+Bou5D+q0UTwLqzhntUJDS24QDxUvR1pN++NJJKuzi1lYNfIIEezvuj5HiqSvspUHy2331vtHOsgGKi1Ym0UNrQIFlyLVGCMqGmwNxMRZ8u7lMDCJufYjWU75mdvxtYpDy/E/UMYIh/H1ao2d3N7C3YNKFSqr2NeUXQX1bRjF8ZPbFRzJV3v9MQzoBmGi+0A4dAWf0X2mYcQMq0M6IRktu0lXkPsOJ5uEA8gKnoOtHCwlv+7fEO3gQItdxRpogbBs1VvKigL1kX9xiEJo1SnYrq/POS9CHdQjO8rYn2/SOJaDgQraJoTyFknueNCFxNHveE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 48874f41-44bf-445c-057b-08d68797ab14
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 16:17:55.9498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1823
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

