Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A78FC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EB3205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QkvzSERL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EB3205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbeLKP4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:56:39 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:8836 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730577AbeLKP4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:56:35 -0500
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; 
   d="scan'208";a="24082961"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Dec 2018 08:56:34 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 11 Dec 2018 08:56:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DV47vp1tjnqueMb3+EllqaOGAW3pX5/QbwcGwTxWHyc=;
 b=QkvzSERLq2aHaHgZDOSV/dvbi5xZSDQnyv400EIQhymk0cb9KfkHPo7c/Ol4Gz8zJJzyKZFo3N0r9DjQXOFOPu40EcBefr7NMSz1igD80mVgaK6mFxu5GaEhAbwOgMN8XcIweXVib2TG06uA7gQkzNizlKuiJKwZ0WMWa8NUlfY=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0792.namprd11.prod.outlook.com (10.163.112.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Tue, 11 Dec 2018 15:56:31 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 15:56:31 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 0/5] add PM functionality for act8945a PMIC
Thread-Topic: [PATCH v3 0/5] add PM functionality for act8945a PMIC
Thread-Index: AQHUkWoV0VCxjvOsEk2Y/ilFL0/wzg==
Date:   Tue, 11 Dec 2018 15:56:31 +0000
Message-ID: <1544543768-2066-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0902CA0050.eurprd09.prod.outlook.com
 (2603:10a6:802:1::39) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0792;6:/ymUVXI5tjuSLrCr8/YqnPv3TpjcGK5dXQIUoVYnY2N3ppBkYcXbsRD75wNr2reqZExU3RLP5sjkCTq66zAnwlTFrsiB9BCFet0ZAunnw1LmuCvJ9A+neOjOae9raqWaeMM6ShUYn4eaOzJPjGv+anj41TMo/CXk9W2n1wrd7B1cR8VvfsDFLIsyRxjE61/RVd1vORkXV+2dD6rjM2K5Q98RqbEswXWsYILpM/kFT3Q5dswlJHT/Xkw60NK66XE8hHWJBAGxW0/tXxNyq+R72akvPAOoHP4cJ+lRzUHm0qgZYbDAfxE0GP1uwAn0ZpgWE+FwHbkH6/UmfBB8Ztv7FFRLM/G7GuLeTfb9ARivLv0X/ywv6LXLnr+irXsEZSZGxw3mjgM33Kf7neFq9jdk3ofk87VATnWiDYyqCBtX8g7gijeV9DF23ok9b0Y1NHeTp6Zf8Sm0ObI9HS8Lu8D7fA==;5:9JIO91/B6ppJ/5XghvivwCDprtFmIBMHcllt1h99G3S2soZj/vk7E5WUT/KSpajTS4MG94iDihs3bZV6CxdKOH64gccQDAGuZinNetbWHxNn47ihcPT2R6lxicma6+ZXsQC9+2T1kcswOpcsFg9blHCMD8kgVH5PtmwLawpaAbw=;7:tVIYP6HCxcP8/rI+Ctle3QZmdD8tCYfPeBugIzj9+LaJQKnZxGJNTm473Bgl2oqxXR6WrR9wbCLExrtmOPLHLXMF+gLkLCpeeWMWYxAF8CdseQEG99WfLTkIdtlEu9xjnZ9nODO0UZ2WwOpnRhlw9g==
x-ms-office365-filtering-correlation-id: 028619ce-311b-4e8d-63a2-08d65f8137ee
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0792;
x-ms-traffictypediagnostic: BY2PR11MB0792:
x-microsoft-antispam-prvs: <BY2PR11MB079266D8F74DF89EAE16076A87A60@BY2PR11MB0792.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0792;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0792;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(136003)(366004)(346002)(396003)(39860400002)(199004)(189003)(54906003)(36756003)(476003)(14454004)(39060400002)(68736007)(53936002)(72206003)(478600001)(316002)(106356001)(110136005)(305945005)(86362001)(107886003)(7736002)(2906002)(4326008)(102836004)(486006)(81166006)(99286004)(8936002)(25786009)(186003)(3846002)(66066001)(26005)(8676002)(71190400001)(71200400001)(6506007)(52116002)(386003)(6116002)(2501003)(81156014)(6512007)(5660300001)(97736004)(2616005)(6486002)(6436002)(14444005)(105586002)(256004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0792;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XuwcaAxereoQHpsFQeOA7nQ3OsbuhZPahUaeDmScW58HD2a6KQ0BI5Mbn8L4A2kSBc7zzaYLqoDF3ucdTkkyBbKPQ4VrcKihJvZ4/VDnCFJcC0tJVRzxBJNuktktu2U36VDhuKpV+mREt9GSKHpOhQoqzMcZ9Lu3KgKXO8F2fzRk8QU7HFiDDwUY5mTjfoT10XpCGbVWIWJeWVVOJG2125R1EXcW87lifZP7HC2OcZSd2RdtyGXcx4+vc3eEX3TM79h9392MlmSQbv2ufFlwGyYTLxzRgXVVIOtNMfPME7JObSlFUWOotvABzFnZTpqe
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 028619ce-311b-4e8d-63a2-08d65f8137ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 15:56:31.7517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0792
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

This series implements PM functionality for act8945a PMIC and use that supp=
ort
on SAMA5D2 Xplained board.

Changes in v3:
- add patch "unlock expert registers"; it was wrongly missed in previous ve=
rsion

Changes in v2:
- split patch 1/1 from previous series in 3 patches: one adding regmap,
  one adding pm functionality, one adding shutdown functionality
- use dev_pm_ops suspend function to set register specific to PWRHLD line: =
this
  is specific to PMIC itself and not to regulators
- add mode support for LDOs
- add constants for mode in dt-bindings/regulator/active-semi,8945a-regulat=
or.h
- document modes and regulator suspend states
- remove rdevs from struct act8945a_pmic since were not used anywhere
- add op_mode field in struct act8945a_pmic, update it when setting mode an=
d
  return it when reading mode (avoiding one extra register read while
  reading mode)
- add a patch to fix a checkpatch.pl warning
- in shutdown function use directly act8945a->regmap instead of an intermed=
iary
  struct regmap variable

Boris Brezillon (2):
  regulator: act8945a-regulator: Implement PM functionalities
  ARM: dts: at91: sama5d2_xplained: Add proper regulator states for
    suspend-to-mem

Claudiu Beznea (3):
  regulator: act8945a-regulator: fix line over 80 chars warning
  regulator: act8945a-regulator: add shutdown function
  regulator: add documentation for regulator modes and suspend states

 .../bindings/regulator/act8945a-regulator.txt      |  34 ++++
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  54 ++++++
 drivers/regulator/act8945a-regulator.c             | 200 +++++++++++++++++=
+++-
 .../regulator/active-semi,8945a-regulator.h        |  30 ++++
 4 files changed, 312 insertions(+), 6 deletions(-)
 create mode 100644 include/dt-bindings/regulator/active-semi,8945a-regulat=
or.h

--=20
2.7.4

