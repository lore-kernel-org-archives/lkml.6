Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA09C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4D921479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="bO/BDByU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfBSKIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:08:53 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:48270 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfBSKIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:08:53 -0500
X-IronPort-AV: E=Sophos;i="5.58,388,1544511600"; 
   d="scan'208";a="27948380"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Feb 2019 03:08:52 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 19 Feb 2019 03:08:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7aQUjOyrC8dM1a6K7cxBr9Zul+jbM3VEnn1PoSLlYc=;
 b=bO/BDByUXnlk5Hv7d28V2M3rggp66XX7QkxP/vRr7AFSRzC1V5tjulnYt6/0fRnc4MUGcZ0pAWKbzT12Wboh3dKoD6ObQmId8mpGhwODvuniTsskoa1qPp8rUbLbrgSqmrxCV0wITOimGXLkxJbxoao3fyAnH9Pyl8j4el4Yx5c=
Received: from CY4PR11MB1909.namprd11.prod.outlook.com (10.175.61.147) by
 CY4PR11MB1831.namprd11.prod.outlook.com (10.175.60.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Tue, 19 Feb 2019 10:08:50 +0000
Received: from CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1]) by CY4PR11MB1909.namprd11.prod.outlook.com
 ([fe80::1499:c19c:26f1:32f1%8]) with mapi id 15.20.1622.020; Tue, 19 Feb 2019
 10:08:50 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 0/4] add support for the new SAM9X60's PWM controller
Thread-Topic: [PATCH v2 0/4] add support for the new SAM9X60's PWM controller
Thread-Index: AQHUyDscosDqnY0tu0a5kDn0fcaiKw==
Date:   Tue, 19 Feb 2019 10:08:50 +0000
Message-ID: <1550570914-26391-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0090.eurprd09.prod.outlook.com
 (2603:10a6:802:29::34) To CY4PR11MB1909.namprd11.prod.outlook.com
 (2603:10b6:903:11f::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e8a0ccb-3325-4e6b-5460-08d696523e4a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR11MB1831;
x-ms-traffictypediagnostic: CY4PR11MB1831:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;CY4PR11MB1831;23:kq4G/ACZoedpz60N0lYKNXRiFqAI0ut4Et8Kh8C?=
 =?iso-8859-1?Q?qJmk/Hrsp/KUgXNyjBWOIt84Lpc1pIebJgkxpfwlaHNEm57iTvejc1Ybeh?=
 =?iso-8859-1?Q?Mc6Sh2vToNrGxsQ2ag8rtaU80AIxjnO8dli79iprcg/x1mO/AK/u3G+IHR?=
 =?iso-8859-1?Q?soXXQljq+LgML0DtqjuJD2X8pj0gYLF9mx2CrujGHcToqSCMet5DMuVSL7?=
 =?iso-8859-1?Q?U6l21AKktV2jguQhFKhTEHUwgpVaGzaT2Ng+dj4hEM9iBCQPJJL17JqWPx?=
 =?iso-8859-1?Q?j3IxbNHkU5iXk6hG6ucMcJdt5wdGWneEazqT/Qm8Pb0cayiQaVFIoAVxvq?=
 =?iso-8859-1?Q?Cbw7pBHGQOtFy8sTyXX6fBtGFUsY0m91yjRN3ECnJIg5Ploak+co5MczpE?=
 =?iso-8859-1?Q?CaiG1uUIsDx6rBMEQ8Lx/8wxRPfX6Ifs3LQHniV88WpQrcVuAxcbO5mYe5?=
 =?iso-8859-1?Q?StzxSfbMP1HZM4bYUsbUGNXLbJ2dlN3HPPJIKLKIGeVuP/WCOCVRP3HN/T?=
 =?iso-8859-1?Q?ui99wg3B6RYc+m0vVpqyXklB7gYlXUjDGib8+72CcmEuA+lVOcAwYxD/aF?=
 =?iso-8859-1?Q?iSkKwUUP4RmJVySiZHkT6GJ4Jlqs3o4xuWFQHLfQLITAzQoDMFqAGNqjJS?=
 =?iso-8859-1?Q?YKrdivXI5gzMP1/4o8P4MsuuJQZoJ+wZKHu+49gkjQrjsw8H3vIDQU9g48?=
 =?iso-8859-1?Q?TTSSS++KLEpaNvjbfG9xTgg2R0iTzKW+FX+sdPavSEUe6GVzb7FkihZuy8?=
 =?iso-8859-1?Q?wNYTLGKIl/1yfswBM8k6YfxAJcIg6mJFRYk/ZHV8qHivsanZt2Qulwkjbl?=
 =?iso-8859-1?Q?tyohuzNh06cgT2DCe2dAsdu25guLBf0GFuq+28PYk9F3nLO6INJZ5pMLi8?=
 =?iso-8859-1?Q?fhSouERw7phX3Y8p4kOaM/E3qgP5kW1lfRpKgG8ETA248mlAmQwJfWm/vx?=
 =?iso-8859-1?Q?xGKapVm583cMmSPgEv14nKgu83xBC4Brtje2VqlH2m24gMrefeXCOjua5f?=
 =?iso-8859-1?Q?VkUNeV4s6hiOiSWm4YrajFtQfKbtD6XJOiav7uf2+QBj1ZEK5Ty166K3/i?=
 =?iso-8859-1?Q?JT0Z4I/mJogSgjrpxOGXElaDQjdFabCFrUjk06Iw68JX6FXBsstPArfd8W?=
 =?iso-8859-1?Q?xiZcKmxFLGU50QL6ClwxL2q9bBM/iBp4GJMjjM0NHWKg8gGdVwRv6Um3PV?=
 =?iso-8859-1?Q?iMvB+Ee++sKHUc6yONYfYJDlwyytblhA6/4j5h/3siALQhoB8CWKTTDW0M?=
 =?iso-8859-1?Q?mKcdRLDBc5A4D8dE1iV9ESahF7Pm7bWbPIJxMKai9Wzj5f3USDeNLFnKGg?=
 =?iso-8859-1?Q?XI=3D?=
x-microsoft-antispam-prvs: <CY4PR11MB1831E92975B0A5B9F7852A2F877C0@CY4PR11MB1831.namprd11.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(366004)(396003)(346002)(199004)(189003)(6486002)(53936002)(2616005)(26005)(486006)(97736004)(4326008)(14454004)(6436002)(186003)(25786009)(2501003)(6116002)(99286004)(4744005)(6506007)(476003)(102836004)(386003)(3846002)(6512007)(52116002)(107886003)(5660300002)(71200400001)(71190400001)(305945005)(8676002)(81166006)(81156014)(36756003)(7736002)(66066001)(8936002)(106356001)(478600001)(110136005)(50226002)(54906003)(2906002)(14444005)(256004)(68736007)(6636002)(105586002)(72206003)(86362001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1831;H:CY4PR11MB1909.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xljgmtsHUJU7mkYiB7WCpPcgw0pvCcmJjVUxxt29skVmcXfhbLdGLFX38Dio6XUMROLnxj5o33gZstoCohC8imoFOiVST848vzeP+pue2kRLX8rGG8G+93oYnQ9haJQTsGDV4YvmejDZ03NGwtgHxoDsVN3RjdjaWRTu+w+GGFLMmVMhAdJovnJ3RaSs/afqRCewcopPerhOSBuDGU8+7Aii/A5hWXtJIA0ac0wkoM80c5+8oRTUYW9pKcFxwuz9Vyk6AfXTh73euHUVaCsO37i1o3HmOJnJzs4f7IwcEDh/CSSUsoDg12cXeuEnG13Q6Rzxyh3UmIRIeCmUWtlmB4MO1VhgYX8WQ7ZlA+eEIRF5Tn0aCUkVviRrnkIGjPkgE/+OiJbwFdyvvvekek6BBWJJbL4O6Ksi50kPT38tYuI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8a0ccb-3325-4e6b-5460-08d696523e4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 10:08:45.6995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1831
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

This series adds support for PWM controller of the new SAM9X60. The differe=
nce
b/w this one and the provious AT91SAM9X5 is the counter size (32 bits compa=
red
with 16 bits on the previous version) thus, allowing to generate signals wi=
th
bigger periods and duty cycles. This series, modifies the driver to take in=
to
account per IP counter size by embedding this information into driver's dat=
a.

Changes in v2:
- add reviewed-by tag to DT inding patch
- move PWM_MAXV2_PRD from patch 2/4 in patch 3/4
- change commit description for patch 3/4

Claudiu Beznea (4):
  pwm: atmel: add struct atmel_pwm_data
  pwm: atmel: add support for controllers with 32 bit counters
  pwm: atmel: add support for SAM9X60's PWM controller
  pwm: atmel: add PWM binding for SAM9X60

 .../devicetree/bindings/pwm/atmel-pwm.txt          |   1 +
 drivers/pwm/pwm-atmel.c                            | 119 ++++++++++++++---=
----
 2 files changed, 81 insertions(+), 39 deletions(-)

--=20
2.7.4

