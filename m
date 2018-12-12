Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96993C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5332086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="j2Mk9YQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5332086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeLLHmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:42:02 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:28483 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLHmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 02:42:01 -0500
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="21407620"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Dec 2018 00:42:00 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 12 Dec 2018 00:42:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2WT2Y6MOPzv7bSWibuURCsBjZWFetD+B/mcDfgDJbw=;
 b=j2Mk9YQMrpP3/gCHJi8D+bhulVsxSsU8RZkrzsLa6PTuOGDvqtTe3zVpHC0bAOaQom7JNTZ1dsfg/j1tytkqf92aALgNA3DJ0UA5OK7ehGzL58s2noG6xmex4ZzvwA0GX13IJGtcrozrpv1SN9dbn/HeIXadR8TctKfgbGoVRRQ=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2321.namprd11.prod.outlook.com (10.173.198.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 12 Dec 2018 07:41:59 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838%3]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 07:41:59 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>
CC:     <Cristian.Birsan@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Andrei.Stefanescu@microchip.com>
Subject: [PATCH v4 0/3] add support for MCP16502 PMIC
Thread-Topic: [PATCH v4 0/3] add support for MCP16502 PMIC
Thread-Index: AQHUke4p79Y5sL3L2Eyp6Y3oq3+a8w==
Date:   Wed, 12 Dec 2018 07:41:58 +0000
Message-ID: <1544600485-17586-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0267.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::40) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2321;6:d5IjlS0e8gEq7Yd3o2KX6BUmQu1A6LF/fA69YWE3pk/cqpS0TN5rS5ZMDjiGDc8G1ALSAOx0tUkXTz91TjDUwz/j/7n3jEiMTa8Jqa5RuOsuOyFVWP4bgbQrK7JZv0ZDeB0Zz1wLfbYI4M6dF66DK86b28cRvWo204ZBFVwlUujZVBr26Ci+o403LCJdzNJO5NuECjbRiC+zrddLESRrcGaCpCpv8i/nVmes4hiwQ0WCA4CIGw1jLYFnPGBJW9ttrHzCFJmVcruQe0t8lllkEh65jhsmFpDdfV7lRPQsKAULKWjPxeBLtdl4aUtU+kuI27QLWuoOYPnuHW/cmbwuV+l/2VVV/atXqHJsMEpv7vyYYF+bRBPmA061I6FWWaEI06rOEeiYFsl/iDHsLCGUCkt772XPujDAfkWXgYXonv7gnun+Iq9YnOzWpA45vRpaca2XLyq5AWWXLYUyhIknFg==;5:VuJB53wbS/mzS/diJd/MYnw5sQNay+J3mUZXHTOIkXdnjNeWDAOcUiZzGkcQbAT81YJB/kYQ2AG5gDiYPf1NcdWWIJO2ecA/e+ouZkEO86LMFMkngWtK4tKZbg7NInECwVADnD1ceKIE4clhx9vXKfTAiM8EqRCkfAfTZgZh1ro=;7:h4pMshLpStygtoq/OWjAmHbgEJISfx1zwzYzIJN/jzj969lnC17iJpSQ0mMS5bKuR6X8Vp8nQuZzkYuhUS91I9wW4bDVRsmQInu55sfa9n6Mp3I3uLZHCa+GWAnthm4lvA5PZUsRjTxltstGPJeieQ==
x-ms-office365-filtering-correlation-id: 316e7473-dace-4482-1503-08d660054bb3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2321;
x-ms-traffictypediagnostic: BN6PR1101MB2321:
x-microsoft-antispam-prvs: <BN6PR1101MB232162F061BA8A0BB5AD39D4EDA70@BN6PR1101MB2321.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231455)(999002)(944501520)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2321;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2321;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(346002)(136003)(189003)(199004)(2501003)(107886003)(53936002)(110136005)(54906003)(316002)(2906002)(486006)(97736004)(5660300001)(68736007)(7736002)(305945005)(72206003)(25786009)(4326008)(478600001)(66066001)(6512007)(39060400002)(36756003)(3846002)(6116002)(2201001)(81156014)(106356001)(105586002)(6436002)(14454004)(71200400001)(52116002)(2616005)(6506007)(71190400001)(476003)(26005)(81166006)(256004)(386003)(186003)(6486002)(14444005)(86362001)(8936002)(102836004)(8676002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2321;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: O7Wo5+AIW/aPSFoBTJv9SNCUKFAHqzu1rSflOLD5TAqsR92+Z5n0IHzFzILMQOvU0ENgpWKJ+6tdl8G+qg939ctABYEHBMt8LGfN8CEtYzGuY6jHEaLhvTeFVXqPdxHGRIHLbzBcovfRxCh9A9/EYoeU4SfpGQ0Ex2Njv8GnYj2ty148XKpUW9Vexk7PAv6H6jYYmD9jtPHm7SPQV0Dx5TC9p8PplNSSm+rb7p1MJT5/RH0r8/5EPGJQ9W9kYxtdYMerPQtft347f5AbTVkeSdvFwB02961h+Uvp733fR/SwzyaH51xCQ4xVygNAmvXj
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 316e7473-dace-4482-1503-08d660054bb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 07:41:58.9371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2321
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCP16502 is a Power Management IC from Microchip.
It has 4 Buck outputs and 2 LDOs. The buck regulators
can be used in two modes: normal(FPWM) and low-power(Auto PFM).

This patch series adds support for the MCP16502 PMIC.

v4:
- make entire intial comment a C++ comment

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
 drivers/regulator/mcp16502.c                       | 553 +++++++++++++++++=
++++
 5 files changed, 713 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mcp16502-re=
gulator.txt
 create mode 100644 drivers/regulator/mcp16502.c

--=20
2.7.4

