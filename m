Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14374C04EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97FD2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ERwzL9Km"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97FD2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbeK0Wyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:54:50 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:22924 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbeK0Wyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 17:54:49 -0500
X-IronPort-AV: E=Sophos;i="5.56,286,1539673200"; 
   d="scan'208";a="21574162"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Nov 2018 04:57:10 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 27 Nov 2018 04:57:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRUbBBfCQ/fkyqdOzd7jdCDsqJVS2kGzmCrvhx1ivb0=;
 b=ERwzL9KmcnA28RrqIm5pECkaBPDS7VLkgYHnaUNlo360UoRt0MO//UuQAOUHTCAQBNHSUqTplYzh+9tK8QuTPEgTD+VMpZfxUDeebILqHRxprcWHO5b85HpLWGsgb3Ie1ruBfQYmANgNa8+OHkef52zekqbHizNl3CkfkFsGjzA=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0582.namprd11.prod.outlook.com (10.163.159.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Tue, 27 Nov 2018 11:57:06 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 11:57:06 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 0/5] add PM functionality for act8945a PMIC
Thread-Topic: [PATCH v2 0/5] add PM functionality for act8945a PMIC
Thread-Index: AQHUhkhRfKZT6zRBI0ySJSjDzGiIew==
Date:   Tue, 27 Nov 2018 11:57:06 +0000
Message-ID: <1543319801-19100-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0173.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::17) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0582;6:PybpIWuVP+c1UCAsyW0XQFSQwFU0wq18ZUVEWz3aDDBodyrFETWmocSddHNlPSDUxc+KorTStiz5alOeI63aVo0YGo35zV7NCXEyBW6Z22Xc/Md5yMnQeyAbHNMZUa+Y9yhxki6fgE0mRchjmi3uhwzHT/q5wE5k5C2Og7FCUEqrBfHnxxAESDSooLxj8uUf8ktQxDFl+R5zKXKtRSDsfU+DZS9NuQkACE6jCYjEnexCyFeq14cdebKZlgc/2cNlRY21nboNp7LH6Vbe3OWptiRPCCeqVJaaKaRM214Z+D2ZnokPbDr6EAVG14hXnQzfZMVfxsYO3ubFY1uYSCzBBUuYDBrq+tbrouQoRlqtSaUTIC/gbfXg+a8garafGTTA1TRNam4nJmMo5qvEMcei3d3MvUfPHbGK7/aRHBYMq57owbar4NrYs4WFv3TUOVlAaCSiBcrSbmrFZGRLdmnb812nQ0wMTazG0crL2tDIx/8=;5:/4t9GFN15Wx9nssC9oagMXSmvBZiH0BNQDiD81OlRcu0j5h3ozcFlS/M237xkYFfUWPeVjOKypItGU1t3IwTcvfqpAb2rQ2N6z8sUkZEtdqb/OtncG4d+TtSUokmDpH4Me0m3djgn3k4Tv66eM9taWFuhSV2vtlTqgfH+R/r+Ag=;7:aexPkdf1EJvnBe/p6CFqGJhVGgdfDg0AuZUzRdMPy+XygK0EmkCfhLYG0XxhYTjgWO8nWGiaaGDEflGphOiQnRtb5MC31/N1lxViJDmK7xMfIsC9PXrdGHMNy6ED9EXbxB+ztIKbYb0AOZiNZryQZA==
x-ms-office365-filtering-correlation-id: bae45e42-1020-4260-7ec1-08d6545f7388
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0582;
x-ms-traffictypediagnostic: BY2PR11MB0582:
x-microsoft-antispam-prvs: <BY2PR11MB0582B7B2B01460304F2A301087D00@BY2PR11MB0582.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231443)(944501410)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0582;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0582;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(366004)(189003)(199004)(4326008)(66066001)(106356001)(86362001)(5660300001)(97736004)(186003)(39060400002)(99286004)(6486002)(52116002)(26005)(105586002)(478600001)(36756003)(256004)(14444005)(2501003)(110136005)(54906003)(386003)(6506007)(107886003)(72206003)(7736002)(102836004)(305945005)(6116002)(3846002)(71200400001)(68736007)(14454004)(71190400001)(6636002)(2906002)(476003)(2616005)(6436002)(25786009)(53936002)(316002)(8936002)(8676002)(486006)(81156014)(6512007)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0582;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 43OSGIs4zF3bwUpKpadptIpd8WpM/oTeJwpTGc7Nse3fg0cY+QzUnMFF+S+h6/q6KyeraaF5+zIdl1OAYTkUlcaycGAyMOwVQY9Zq9FMxNF4iCO39PT6wzZ8TsodyCIsDzNpOS3ohsoOsTImX6ostjQcniXoUZwe4PuTSzSHr6XI0jGWBkPRvFNKpzWwo2e5bUqpwq2HFqMhp9evbwUYSnxJw/+pmQzzhC7CbR9IGBJhqSVkDtLrYROxiW9cI8IXe3iCxlhFDfIpV39LXMwABSBTIT4Yi+vZirB3PCW7J99f2LnoeZd7/SFcApvGieqWbMLqmdP5CO7sNUBvVCKm32KOlJLFBXJCyrfd146Bs7g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bae45e42-1020-4260-7ec1-08d6545f7388
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 11:57:06.1269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0582
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

This series implements PM functionality for act8945a PMIC and use that supp=
ort
on SAMA5D2 Xplained board.

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

