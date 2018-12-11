Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6780EC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206A220849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="aU4ZDEXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206A220849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbeLKKJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:09:01 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:18328 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbeLKKJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:09:00 -0500
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; 
   d="scan'208";a="21364628"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Dec 2018 03:08:59 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 11 Dec 2018 03:08:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wAyda3fTIPtmmqFZlF/WapNeGE+JuxFE6Q2+XI9cHU=;
 b=aU4ZDEXM+DDBv/68g6MEFfCfpd1HBl6fbFj3vvTlfBfJPshC5Rhz9jL93a4NyH4/2FskZj20FOfUYksjZbjaTi7+GUbBOkMcM++abgxvwOqTB1ppRWHU/tlZdGQoGdCDSZkLC/ZYumKmQZGDUkfZH/wJQ+LsjZmc5jEJarzJBiw=
Received: from DM5PR1101MB2249.namprd11.prod.outlook.com (10.174.105.17) by
 DM5PR1101MB2123.namprd11.prod.outlook.com (10.174.104.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 10:08:58 +0000
Received: from DM5PR1101MB2249.namprd11.prod.outlook.com
 ([fe80::3439:ab82:a10e:6bb]) by DM5PR1101MB2249.namprd11.prod.outlook.com
 ([fe80::3439:ab82:a10e:6bb%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 10:08:58 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>
CC:     <Cristian.Birsan@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Andrei.Stefanescu@microchip.com>
Subject: [RESEND PATCH v3 0/3] add support for MCP16502 PMIC
Thread-Topic: [RESEND PATCH v3 0/3] add support for MCP16502 PMIC
Thread-Index: AQHUkTmHMXCVH6BNEESnUHg5rFzGYg==
Date:   Tue, 11 Dec 2018 10:08:57 +0000
Message-ID: <1544522876-15967-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0205.eurprd08.prod.outlook.com
 (2603:10a6:802:15::14) To DM5PR1101MB2249.namprd11.prod.outlook.com
 (2603:10b6:4:52::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR1101MB2123;6:qywS/trVFK0HqDOT4P1fFMF16u9vDGoNjp0162RomhhwmEhUVinFwHfIJFuNVf+dnlXNwGDoPnkgBcnRy//yOcaPUdIf3oi81K3zDWHvUFWkFvnv10FEk1ahFbcnicEStm2ZQVMN/h8JtQl056NUpQcrmRBxo0JJU/gYHiqc+Y6rxEFBAm437qB6l0hmGizcDNxV4H3P4xu7EsD6QLjYXZma9LoS3+fU2ACxXMHO/zxGHwPG1FEwJrpY0B3FOsJf4q4fwS3q8P8OQFMP1NBdn7yTrFbtAxMP99HUVv86qi5/4U4nJBSdiJBu/XNqtqmj5xlTah0ORM4BYGV0GS114vl3G82v3zkmPwnCDeRuZ06fRO/rohApcfeEbrYPffOIcV7Zh0CDHQDoH/zRI8nZ/AzYSZs9lI/SxI0iZ3ro/OP4AmAejqB64FVa5D23uqsAL8RLfQImfDvOllTOquMwGA==;5:jQ+U988hjqA9ltAkTfrp7+ZyuVHwSpQgS72PddMfZBPqrVXIOGNXMV8mIsSa4zBo0be5tS5Tq41CUQrromKZFzTe0IN9rUB4CzEoKHsQGMv5+ehCLKp2QRTOQOgo/fx0Dkb/n/mbipMGO0BVKlNwiiN5XtP2DmS+c2f9c/AFzbM=;7:LknWanMX326lUI06TirYyThX8QzAOIMjfcVe708GHvh09tPBQhdE4HS9ocbhf66FruAm/vfCsuIW4cReBZV12L1kGgUvHWbdFcGZ6mOjsVdGG3nNVSGgyxr5aMQtIDZrAgRuUJpkOR8IRaXtpUNgFQ==
x-ms-office365-filtering-correlation-id: 6653d6af-0a0f-47f5-150e-08d65f50aa1c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR1101MB2123;
x-ms-traffictypediagnostic: DM5PR1101MB2123:
x-microsoft-antispam-prvs: <DM5PR1101MB212313AC680A0B086261FF94EDA60@DM5PR1101MB2123.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231455)(999002)(944501520)(52105112)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR1101MB2123;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1101MB2123;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(346002)(136003)(39860400002)(189003)(199004)(256004)(14444005)(217873002)(486006)(97736004)(2906002)(81166006)(2501003)(8676002)(81156014)(8936002)(71200400001)(71190400001)(86362001)(68736007)(72206003)(25786009)(36756003)(6512007)(2201001)(7736002)(53936002)(478600001)(6486002)(14454004)(316002)(54906003)(3846002)(110136005)(66066001)(107886003)(106356001)(105586002)(305945005)(39060400002)(99286004)(2616005)(476003)(102836004)(5660300001)(386003)(6116002)(6436002)(186003)(6506007)(4326008)(52116002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1101MB2123;H:DM5PR1101MB2249.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Cw3q0RjgdN4UvYdOovPfCVc4jPxRsuA0fgy+6jsWcyQs6xbyDvFCbQuFQOvULJ/xMGgu/5Ck4YAUD/sGXlowH/KnIalBBu8jn6pRcQD+jSd/ArAVR1ZFr605+8rRAvTdSClXD8ykHOwmMK+9vEKHWBDRYj7NBwQ114KnOZzDSBKbOOkX/XP1mbAKU2YHg1rl5xC3wKhO8rjt6ESS8eVs3/7JMLW3Pt2e/QvJjXdCOrG/pK+8OoLoNG/LOKRj9MjaHjD/dLLHHxcPzTTPZ37e/gDdEMokiQsmFN+gdeOkPPBnmin309DI60vh+f9GB8By
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6653d6af-0a0f-47f5-150e-08d65f50aa1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 10:08:58.0227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2123
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resend is because I forgot to add Mark.

MCP16502 is a Power Management IC from Microchip.
It has 4 Buck outputs and 2 LDOs. The buck regulators
can be used in two modes: normal(FPWM) and low-power(Auto PFM).

This patch series adds support for the MCP16502 PMIC.

v3:
- use CONFIG_SUSPEND and CONFIG_PM to fix compile errors for some configs

v2:
- use lpm-gpios instead of lpm-gpio in devicetree bindings documentation
- describe the regulators present on the PMIC in the devicetree bindings
  documentation
- add SPDX license inside a C++ comment
- prefix macro
- remove mcp16502_update_regulator and mcp16502_read
- replace ?: with if-else
- change some if-else with switch statements for legibility
- use regmap helpers for regultor settings during runtime
- make mcp16502_get_status read the status from the PMIC STS registers
- use module_i2c_driver
- use the PMIC's Hibernate registers for suspend-to-mem, the PMIC's
  Low-power registers for standby and the PMIC's Active registers for
  normal runtime

Note about mcp16502_suspend:
- mcp16502_gpio_set_mode(mcp, MCP16502_OPMODE_HIB) has now been changed to
  mcp16502_gpio_set_mode(mcp, MCP16502_OPMODE_LPM) for legibility.

Note that the function call only sets the LPM pin of the PMIC to high.
This puts the PMIC in Low-power operating mode. Hibernate operating mode
is reached when the MPU sets the PWRHLD line to zero (typically when
entering suspend-to-ram).

Andrei Stefanescu (3):
  regulator: dt-bindings: add MCP16502 regulator bindings
  MAINTAINERS: add maintainer for MCP16502 PMIC driver
  regulator: mcp16502: add regulator driver for MCP16502

 .../bindings/regulator/mcp16502-regulator.txt      | 143 ++++++
 MAINTAINERS                                        |   7 +
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/mcp16502.c                       | 555 +++++++++++++++++=
++++
 5 files changed, 715 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mcp16502-re=
gulator.txt
 create mode 100644 drivers/regulator/mcp16502.c

--=20
2.7.4

