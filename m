Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338B8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC182081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RTBeT98G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC182081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeK1U6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:58:25 -0500
Received: from mail-eopbgr50053.outbound.protection.outlook.com ([40.107.5.53]:34804
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727382AbeK1U6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKjfdlfTufn/6WM5DbBbvEtt1I5sJDVpyJNBXPNoL+w=;
 b=RTBeT98GL7AnJdmYt2GBbUEmw/FJVEfumuxb9+eaeMTqof2cqq5eVhlBuIhfHxzE2oZl2d6WVgOOiHT/CojXTtt0SN7W5UhG96viI2GNAiNeimlMGqh7DQysqdNgV8RPjzN4yl3WbhRepcS5VEwfXrX9opHq3F7TJrW6Q3GhUXk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3690.eurprd04.prod.outlook.com (52.134.70.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 09:57:15 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 09:57:15 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V3 0/4] Add i.MX system controller RTC driver
Thread-Topic: [PATCH V3 0/4] Add i.MX system controller RTC driver
Thread-Index: AQHUhwC9cP4MHtZB/0i2IZa9G9jAdg==
Date:   Wed, 28 Nov 2018 09:57:15 +0000
Message-ID: <1543398696-3140-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0024.apcprd04.prod.outlook.com
 (2603:1096:203:36::36) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3690;6:zEBAbJHh5fuD3WMXBqe+Ml+EzAJya2EaHG88bd/GrQiHGcoJR/loQvODF0XHFZWwNiLjZb26GAsGMWpPRmeDcIGxNG4P8g3hk6aWgAYE2+caex6BP6+zexVh9/jOAkygQ/2OJfaKTtknljUSXnSBbwgUbHbmCh6uXYcIexnial+dTA8BZEoLPhDN9IbTlSQM3nYCCXN0OyVQ7GD0wd1P6tNvQkMvvJ6ZvafA9j+O57P8bAEGrkuSor8Zr3AP4q9Bvtdacjj2FV2AQ0PVXY8Hkhr8bFRwj+LGlfm8lapSYalR2jHP/kUjaTRz5CC3Mr/57MbmbyGRjd500wg6BjuL+bEhsiDfDBUJZJp3HXO7gp1/cgk8HWo14SJ+vZ4VNYY46J/Wj/Ub2kBl7D2EIqOcYToHU/AF3h4Sby98m3nkjrT6WDf+/2G7B8TWbVXt3csMRPu8peLMe46rFVKf29WAug==;5:H0aJhSyhKFRE8YtlA7Rh+wuLtZ6EG4RUiXV7oPOJdq0Ruuf+SO03fryAtBo3ab1IIqTer7F4skglNgkFOmy9eunxhRiNH3lrtl3E7GPm/GRcoP/JAKzfGZfWw0PPitZkL7KYaxLXm4qt2v5jeOs4pDV8FN3Dj4eN+/u3WlZTlPU=;7:xV2drh76jXbJTDcGYCdG8kGaAtDJR4QkbCHbTSmwIoUrXyrhoAQgfWFGLCJuazbOrryYaW9pVaJ7H4C3uhXjOdmI0E2Oa7LOse9ATXceIcxf5+7QZZpzrT9oO09dKL4s4TybWbeIdph53HSnKmVAjg==
x-ms-office365-filtering-correlation-id: cb102ab9-894c-437a-972e-08d65517dfbd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3690;
x-ms-traffictypediagnostic: DB3PR0402MB3690:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3690BCEDB74DB07BF89FF70FF5D10@DB3PR0402MB3690.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231443)(999002)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3690;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3690;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(189003)(199004)(8936002)(50226002)(106356001)(256004)(8676002)(105586002)(305945005)(6306002)(81156014)(7416002)(81166006)(71200400001)(53936002)(6512007)(25786009)(6116002)(3846002)(71190400001)(486006)(476003)(2616005)(6486002)(2906002)(86362001)(2201001)(36756003)(186003)(110136005)(97736004)(99286004)(52116002)(7736002)(2501003)(14454004)(66066001)(68736007)(26005)(6436002)(386003)(478600001)(966005)(6506007)(316002)(5660300001)(4326008)(102836004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3690;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: d9a5liRfTOwZGVAUVPeK50v+02/Thpys5wZ+enPJ1VJw5mUyYsULCT/YEK6uSPkjsUQRjy6lyfdISb9VDGt2V6EKsOx7JZOCIxpQukFv9oZn7HEQyfL1dkMKuvUj94bMSKeAjflyBuTFFLeNGE8Rr2nOnJmVhXZruw1tZQgGfBORtVAIrXE/+lg63Ua9QG2LLFSluO6epDROBW+lUU0wxRN38WtgbEP9OALvnn07grArGaGxzgi7K8aJwlsYWiGskuGDk7/9yg72tqc0hfVhKHmX8Mg9AxWR3JYJWGADiVTun2UJgHPRLDsGfwvetLbnNKoLyVv2phkbL8CtHdjmiX0ckHBFtH2Jvz3zp2q2Wts=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb102ab9-894c-437a-972e-08d65517dfbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 09:57:15.1013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3690
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
system controller, the system controller is in charge of system
power, clock and secure RTC etc. management, Linux kernel
has to communicate with system controller via MU (message unit)
IPC to do RTC operation.

Since the RTC set time MUST to be done in secure EL3 mode (required
by system controller firmware) and ALARM functions needs to be done
with general MU IRQ handle, these are NOT ready NOW, so this patch
ONLY supports RTC read time for now.

Note that this patch set is based on [V4,5/5] defconfig: arm64: add imx8qxp=
 support,
https://patchwork.kernel.org/patch/10677315/

Anson Huang (4):
  rtc: add i.MX system controller RTC support
  dt-bindings: rtc: add binding doc for i.MX system controller RTC
    driver
  defconfig: arm64: add i.MX system controller RTC support
  ARM64: dts: imx: add i.MX8QXP system controller RTC support

 .../devicetree/bindings/rtc/rtc-imx-sc.txt         |  10 ++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   4 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/rtc/Kconfig                                |   6 ++
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-imx-sc.c                           | 104 +++++++++++++++++=
++++
 6 files changed, 126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt
 create mode 100644 drivers/rtc/rtc-imx-sc.c

--=20
2.7.4

