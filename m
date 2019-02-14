Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA58C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F04222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="RV14xD0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502226AbfBNPyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:54:35 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:17430 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388300AbfBNPye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:54:34 -0500
X-IronPort-AV: E=Sophos;i="5.58,369,1544511600"; 
   d="scan'208";a="23863278"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Feb 2019 08:54:32 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Feb 2019 08:54:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d95mOk1j6LMbgm+EPd8+znB0w+LCV8bZSczgHZWH8GE=;
 b=RV14xD0X4d/0fg1F/TDM/bISZ4y6lFlr0xcvdIZHrcoknVfmgfZ1t7uhlpmE6/msszvs9bF21lz7Qd/2cM8bXvClY2fzvDGLk9F+YQC7HRkYFJKxtm6rV76PI3kf3DARaQ7zfBXNSi2QoAbuNrwQwwAuZQfL2O7YKm/HFHJjv7c=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB2031.namprd11.prod.outlook.com (10.169.236.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Thu, 14 Feb 2019 15:54:26 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 15:54:26 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux@armlinux.org.uk>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH 0/8] add power management support for SAM9X60
Thread-Topic: [PATCH 0/8] add power management support for SAM9X60
Thread-Index: AQHUxH2QlSt3vlRFOkWncuIKOkMb2w==
Date:   Thu, 14 Feb 2019 15:54:26 +0000
Message-ID: <1550159642-26878-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0901CA0098.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::24) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [213.233.85.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9373ca34-e1c1-496e-693e-08d69294b23c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB2031;
x-ms-traffictypediagnostic: MWHPR11MB2031:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB2031;23:K2sz5YGCTN54aZCSc2DQMKxG1FydCS7g1Lc6Ter?=
 =?iso-8859-1?Q?blfompnHJYpCuBvwecudUu4r0WNiutK7EuC2EhYSCspNB8YwHVHCuLxZIg?=
 =?iso-8859-1?Q?7pY0Q5DdjO7yc82DgjCBSPb2y09dV26Yiz+P2DeyUJ7JL9JGoT7inqorA2?=
 =?iso-8859-1?Q?HefHb/aDqxkfGeHbpyeOFs60IV1YBgZKf9uibtN0BdKRZ39lPgPOIFynpK?=
 =?iso-8859-1?Q?ONW8zg1dBaUoheRAeTjSgHy02DxrKBDj6IhKfqqtCO0HU4iMRB+h6nSPQn?=
 =?iso-8859-1?Q?mkh2rCHIa8TZRSo1drtR2z3VZSKwvBRJYHaIK7EWGsZnzVp1cNWDaaIeS9?=
 =?iso-8859-1?Q?RLmzPNdGR8Qv/N5Nr6J9EzNDYfq5yFiW2ZSbqMS/VGHm69PPkQVfbqFjp+?=
 =?iso-8859-1?Q?OutK0sjHEdfjI5+VK3kkEoFix8SggcVCoAnsVxKO9aRdRVYbKix6qc9GMz?=
 =?iso-8859-1?Q?87URuAJRfvCybTuAJJy3F7/d//cxNQXoK4nFUz9t85zdFsf4ysqvtpes7C?=
 =?iso-8859-1?Q?X0iohavLH/ogfNayE+mT83MomM4esMga5TT/KqqpHTJ8AOBgMiCbIfoi6b?=
 =?iso-8859-1?Q?aFcaK+AwQ9Zhop2k2O/7hWyjH6AFvFZmFlGNWqIFiAJBBd4b7dgC+deBPg?=
 =?iso-8859-1?Q?E3FFyUEPcVAMQFbF87YvaUoK63JS+ahC5gx29vAhd4Frb2ytNYXh2d1ekt?=
 =?iso-8859-1?Q?7jEZTu+AnupVubHCsj1RGviu/fxN3/VT8ZOC6nW5GJFJELzAGHX7FzeFTT?=
 =?iso-8859-1?Q?5WRMY7FTOiQ7sNxkog7maQLk+436byUlZezErRf5a6gMJ3NMh0xZMz648Y?=
 =?iso-8859-1?Q?49htus39cG3cbBgui82uTQUNYEgC+UlXu2RFAwP1Qletew2JxvLvRCDZJY?=
 =?iso-8859-1?Q?dKewQRgSBpcz+G1/OjnYWug5rLVvNe4kMpgJkLkPkrc8wUaRJU1a5f8A37?=
 =?iso-8859-1?Q?D7AQU0OUxeE6o5bM/Bd/lVMHgsKiGXwwS8s+qYkXQ7gZhBgoH/KV5CjKBM?=
 =?iso-8859-1?Q?+FMiy0tjdYd1S+zkkuIZx6b+E7E6IuiFXcJoixk/UFRHDJC+J29hzj8y0G?=
 =?iso-8859-1?Q?/iJg18vcbIiT7YVX4gkqQVaxfNA2Vp4k9PkE6KnrZnusn8xbYQkAjmKMut?=
 =?iso-8859-1?Q?hy8HrxT41HJWuM8Cf94DEB+zmbb/V0wuKMYLD0q2GNn2MBdIzcrVBkzOGa?=
 =?iso-8859-1?Q?UD6oIkQYxCSADJU9gWWof0caZVnydxxipxo9N63IKLSMfW3ani+LxEEvUp?=
 =?iso-8859-1?Q?rMABlWV20FHpkX1o3L2zy6Y25x/lEHAkH6iXpa9hxzFRX/7/gMcbuQOTdw?=
 =?iso-8859-1?Q?JI=3D?=
x-microsoft-antispam-prvs: <MWHPR11MB2031BED10638A42188FC637087670@MWHPR11MB2031.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(376002)(366004)(189003)(199004)(97736004)(6486002)(4744005)(2906002)(72206003)(14454004)(478600001)(81156014)(36756003)(2501003)(71190400001)(71200400001)(316002)(81166006)(7416002)(110136005)(54906003)(6436002)(66066001)(50226002)(14444005)(256004)(6512007)(106356001)(8936002)(68736007)(52116002)(2201001)(26005)(186003)(53936002)(6116002)(7736002)(3846002)(25786009)(107886003)(4326008)(305945005)(99286004)(8676002)(105586002)(486006)(86362001)(386003)(476003)(6506007)(102836004)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB2031;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Wqqvut5G5RKzWc54IQ7pKGwYR1xQnOvXBjkDGHwI7eYG0BmLg5B+tPZpSq7beqVAzj/P0JtAvZ0i2q88qUCTjfdeDGFF5dcME8mRJ98RbVFVMCCmDn/XbcGD9vzftq2boeiuFrLH1A0MIB0LsnDt0Ut5xMxBCkiCwhwb8gXcUbOkHeGq2QAUvOZSizUQPWe2iuK+dE9WZnm0FXg1N8u9T5UIGJ/6AoJsgYEqadoht2x8JcWAaDEXUO2ur2d6xtXWQ/4VaOnMFwGurFhB2OQhbsjh8THjK1DzEi9SCKHxyXTE86sl1q9eEDHaMmxNUPvpVgwFxLeW5ra1R6DEpI6XCfMKMQJCw57R3RRPgDNiHrWyvFBqx1k16+3vKQldJlf2yiPil6qSiE5dKv8gmEXj/r5At1q6bOJtFXp9h0csh0Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9373ca34-e1c1-496e-693e-08d69294b23c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 15:54:22.2670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2031
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Hi,

This series add power management support for SAM9X60. The following
platform specific power management modes were enabled for it:
Idle, ULP0 and ULP1.

Thank you,
Claudiu Beznea

Claudiu Beznea (8):
  ARM: at91: pm: introduce at91_soc_pm structure
  dt-bindings: arm: atmel: add binding for SAM9X60 SoC
  ARM: at91: pm: initial PM support for SAM9X60
  ARM: at91: pm: keep at91_pm_backup_init() only for SAMA5D2 SoCs
  ARM: at91: pm: add support for per SoC wakeup source configuration
  ARM: at91: pm: add ULP1 support for SAM9X60
  ARM: at91: pm: disable RC oscillator in ULP0
  ARM: at91: pm: do not disable/enable PLLA for ULP modes

 .../devicetree/bindings/arm/atmel-at91.txt         |   1 +
 arch/arm/mach-at91/at91sam9.c                      |  18 ++
 arch/arm/mach-at91/generic.h                       |   2 +
 arch/arm/mach-at91/pm.c                            | 193 ++++++++++++++---=
----
 arch/arm/mach-at91/pm_suspend.S                    | 111 ++++++++----
 include/linux/clk/at91_pmc.h                       |   1 +
 6 files changed, 232 insertions(+), 94 deletions(-)

--=20
2.7.4

