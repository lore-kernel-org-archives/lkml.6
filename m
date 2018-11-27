Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E050C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388E22133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Rh5D4yp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388E22133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbeK1DYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:24:06 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:40213 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbeK1DYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:24:06 -0500
X-IronPort-AV: E=Sophos;i="5.56,287,1539673200"; 
   d="scan'208";a="20832781"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 27 Nov 2018 09:25:40 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 27 Nov 2018 09:25:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vit53saacFIY0dFCsHloNHja4rxZ+UsOfhFMeB+r8Z0=;
 b=Rh5D4yp0q+15wHUNOTDBZxN5TnRs9UxERa63Min3Q7L/1JmUm0wyESJtZvCCOrIkrpSoMMswsSREyWxfmc7GELhqU6jTupDNx0X+VY7RhXjUeKtCHOPiD5k7K6H9E9oJSr5DqElZ4tBYZTSPZ75zHB7V1UorUOJHhiDsYC3G3Ao=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2161.namprd11.prod.outlook.com (10.174.112.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.18; Tue, 27 Nov 2018 16:25:37 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1%5]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 16:25:37 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>, <Cristian.Birsan@microchip.com>,
        <Claudiu.Beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Andrei.Stefanescu@microchip.com>
Subject: [PATCH v2 0/3] add support for MCP16502 PMIC
Thread-Topic: [PATCH v2 0/3] add support for MCP16502 PMIC
Thread-Index: AQHUhm3UcqQPhDCrt0WHDnm5KDquZQ==
Date:   Tue, 27 Nov 2018 16:25:37 +0000
Message-ID: <1543335937-12689-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0080.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::48) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2161;6:OMtlvC14UVLgHGPM03wTZVHAIUm/AK1M0PnNTVeUwgCvJT5EDWS+e/WGMaNMywIFzj9arYsSbzJI4gvbG9w1uy7Xhr12DVfQZI3bT2tjytuj7R3+XS9dj5BF2ON7OfZu75zFq/LS7sJjB47W0cDZB0J/3iTXKGzjQ6NUuAcdv47ObtYErYENXk2rfEFMVFN8t0jaoDI2Vla/52TUE2ZZc5I83xsRG/axG94WMslCTB+27xCqCFaCVStR6BXk9MJa7Nepsl5hC3DmgvWhAxyF45L4DDnqAlPkj2VaSz3cZq6nME9tUAXSDk7sl5BlsJMCInlyB0N10Id+DAOPkJZ0LAdmMHog5n+8Ht7jZhsJADLhGFUKQ8uckPWX68yEWzAcwlTAPIvzH6JhZYG/x0YVCo1yKRuXQbTfUlU8DFAUBOf7JNDe2Z7d1xZDUiA4btdxDcO+nZctiWDwPcLp9/4HKw==;5:Adjgyrbh6D4aP5Cn4ji3qoolfoHlS7hp5zsBKChyxZJdHezl01mthD/wE//njmVJAyruDkqARfKTOApqTYCkMsIKC6AhsurOWpwlOEIh2rzg01k2BSQ6krib0MsktBG7YlVgUXg6gk6EYmVMUDpB2qYWI/PACDkQXoCIF0oJqUM=;7:eEQcsXGyW6LaVC0uYq/4GBs38GECnhW0B68Yd2uIYi0e5gJXYTn+8Qy/UnkcP/xu2ZJdpy7CMGWaIk58FFm7himeSkodr0mJ6kflssU2qHcqQcbHHM2+IGj5QOUfO5/7y7WXTp/y2kE5oSIXxQXz+w==
x-ms-office365-filtering-correlation-id: c6deb205-26a1-4e7e-7057-08d65484f614
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2161;
x-ms-traffictypediagnostic: BN6PR1101MB2161:
x-microsoft-antispam-prvs: <BN6PR1101MB21613CE9449368D602F98FACEDD00@BN6PR1101MB2161.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231443)(944501410)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2161;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2161;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(366004)(39860400002)(199004)(189003)(106356001)(36756003)(8676002)(81166006)(81156014)(3846002)(105586002)(4326008)(478600001)(52116002)(66066001)(8936002)(2906002)(14454004)(107886003)(39060400002)(6116002)(68736007)(97736004)(6486002)(2501003)(316002)(6636002)(53936002)(6436002)(6512007)(7736002)(54906003)(72206003)(305945005)(110136005)(86362001)(6506007)(102836004)(5660300001)(2616005)(26005)(99286004)(186003)(386003)(25786009)(476003)(256004)(14444005)(486006)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2161;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uKQ+KM87DmUlX+1zYLdK/dilkGllzS4ZLCiHrlvvWuNn43HVKcHyc0YENgP3aRWiuyd6PWMhnjvTtxpJZKv3CwW2OLPmF+OO7QPgDkAEsCpQzRxuGyYRv6MkhkXQZDSIuhEJ8bPf/b+tvRm/5n0yqkmQaYeJW3JItIaC2nbQRmWSg/ni3M+IITKs/mRixIeDtdRhF26HEXMClNlcj1n5oScLhLvhHNxWC45J3h4lTXjmuYFtBj5lqhDrc+MndjfT3N7MeIBU/TGs61WjPAM7HVakMjm7IlPh8nC4rLVciCJXucW7h5Njg/TVU/Ueltq8ps78c4G2BFjJmS/yH7LBgbejzkI5evt9qca60QuRG9s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c6deb205-26a1-4e7e-7057-08d65484f614
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 16:25:37.2223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2161
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCP16502 is a Power Management IC from Microchip.
It has 4 Buck outputs and 2 LDOs. The buck regulators
can be used in two modes: normal(FPWM) and low-power(Auto PFM).

This patch series adds support for the MCP16502 PMIC.

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
 drivers/regulator/mcp16502.c                       | 542 +++++++++++++++++=
++++
 5 files changed, 702 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mcp16502-re=
gulator.txt
 create mode 100644 drivers/regulator/mcp16502.c

--=20
2.7.4

