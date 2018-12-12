Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE82C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F89C2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="KqZzk2KY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F89C2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbeLLSbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:31:17 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:29684 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbeLLSbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:31:17 -0500
X-IronPort-AV: E=Sophos;i="5.56,345,1539673200"; 
   d="scan'208";a="22193059"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Dec 2018 11:31:09 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 12 Dec 2018 11:31:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vh1ZHTjstOOBEOqvB2IBLmxlDJLGKvh/B31jcTDwSm4=;
 b=KqZzk2KYvgMn+JAAT8lZd7Ouytgq0H4yaHQo7ncMt/tiWFaoVVoIuI4IkNQ2oXMQic7Z0cw51yTsNe4by2zX2yH0BITEq/bFmmzC6fhTtBUrDkEqt2daqs4SLT7LGSZhMSX0SK9y7kQ14nRuYC36DF/Ld5Nd68shn+NGxPd6P60=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2098.namprd11.prod.outlook.com (10.174.112.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 12 Dec 2018 18:31:04 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838%3]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 18:31:04 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>
CC:     <Cristian.Birsan@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <andr3i.stefanescu@gmail.com>, <Andrei.Stefanescu@microchip.com>
Subject: [PATCH v5 0/3] add support for MCP16502 PMIC
Thread-Topic: [PATCH v5 0/3] add support for MCP16502 PMIC
Thread-Index: AQHUkkjWJuJcndQMSE2+olo9y8d16g==
Date:   Wed, 12 Dec 2018 18:31:04 +0000
Message-ID: <1544639447-17392-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0012.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::24)
 To BN6PR1101MB2243.namprd11.prod.outlook.com (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [213.233.110.155]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2098;6:zdsXaoIxYzLOtHiBfCsbJ87uzglfbbX8IBxis9FxUJI5PU214wTs+7GMsOF0fw6S/qou8MDRqU2Uz5LDwv3SW4XdYyil5zBXnHkFBU6uUHwAR5FEpexFWqK/L/Jk6ZZhTPSo5kFfIiaTo0BOPvdYO06hqK/kw2kz5Q64vfGoaX7zewhaFczcI6FWWGvXyfc81jw3XytMJJU7qhWkuS7y5WllkbG10XxDi5SnF88sqn8jSOWI6iXNGhCKfnEMEaf2m6yzsNmR/UEmlVzqiuI+8mQtyqzymoaJnTbDRyGeoZ19jyiFVMOqpsCgp9oLJ5DFnuGMoXy2JDrhekmvhK9H5Q8Lv7qLpTISK9k8EB+aqfXrxT+pRisV7uqTaIBcWPw1e+IQJx+A4KpkcnzpskI1Pj3sGEuiwN9uBXrplkXNbRByqzT0546fZ7o+A3LgqumyxCPsc8Af8a3d1beamrNYFQ==;5:lEgn9IFYEh+UFcvJ++AzD2zAW6GY4KUjsp4Xt+y0sRzgIeM8xZabz+IgN8GeGD6Epam31ze7rdoUL/nrh38iEwR9Yaz0A6BwNkqBHLOz6bw/SrexeSZNmjae2oZHJCT9QPhxhOrJnScieu7RdfRJgigYCSZze/n/sNrptRVNMJc=;7:zIHR8Tl0lUg2JPOhHY4/P4BWF2+Us3+C/bLay58mDX6WVcbWTqkjYofnyxdF74gGz19GeX1dl1NLaiNsXHMUjBp5h47wi9S2en/wM7oYbDGkb15gjbGvvH1EgE7SrmfYLOHk5qRNC4NDS2pDpeoKig==
x-ms-office365-filtering-correlation-id: 5d92f650-8af5-41b4-aea7-08d6605ff8eb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2098;
x-ms-traffictypediagnostic: BN6PR1101MB2098:
x-microsoft-antispam-prvs: <BN6PR1101MB2098371B557F5508B393A5ACEDA70@BN6PR1101MB2098.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(3231472)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2098;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2098;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(52116002)(186003)(305945005)(4326008)(110136005)(25786009)(71200400001)(72206003)(8676002)(71190400001)(6512007)(5660300001)(53936002)(6506007)(7736002)(36756003)(14454004)(81166006)(386003)(81156014)(99286004)(39060400002)(54906003)(107886003)(316002)(478600001)(14444005)(86362001)(476003)(68736007)(106356001)(6436002)(256004)(2616005)(6116002)(3846002)(8936002)(2201001)(6486002)(66066001)(97736004)(486006)(2906002)(26005)(105586002)(102836004)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2098;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YD4Xnde/iSq7eEgb5cHS2w75BRjFa27uib1gVk9KjSuUEskEyTMgIsVBOUPR0T0UM0uXUUCsJG2dbMI0D6lCHzPgZorV6Wfm+f/orJxNS+5zz3nMiiD+8sBqGGhQK+OYjXfhXk7OBUWvFB+Jw1KdOA2Iv5NqrxeGj2mn73FOcX1SQGV9ckvu8paRbThXP84YZwbdKKajvfKcN4+UCO2rLeWlosaQMcSavu77fO20ACz0k/sv+zq11nWCV23E48C345NfNppCGSlJI/H/wGyaM2WpR6pvzi7d4WfcRuVs79DaexSEuUGPiqKEUcognLO3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d92f650-8af5-41b4-aea7-08d6605ff8eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 18:31:04.1670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2098
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCP16502 is a Power Management IC from Microchip.
It has 4 Buck outputs and 2 LDOs. The buck regulators
can be used in two modes: normal(FPWM) and low-power(Auto PFM).

This patch series adds support for the MCP16502 PMIC.

v5:
- split the driver patch in two patches, this one is the initial implementa=
tion
  without the support for suspend/resume
=20
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
 drivers/regulator/mcp16502.c                       | 520 +++++++++++++++++=
++++
 5 files changed, 680 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mcp16502-re=
gulator.txt
 create mode 100644 drivers/regulator/mcp16502.c

--=20
2.7.4

