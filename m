Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AFAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A6621909
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="R6FWu2+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389356AbeLUKBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:01:14 -0500
Received: from mail-eopbgr10088.outbound.protection.outlook.com ([40.107.1.88]:51475
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731031AbeLUKBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJWRgTF4g2QQ6s9jrcWi1CBJPLpMXxgxCCvhb6MzZoA=;
 b=R6FWu2+T57itZE4vENdm3PLVxv9gMWtXmW9HdeN3l0z77CO/B1oDT3cKDUkKz14CYON2huRSDn79lU9tgGzc861SU4++8D/INUVnLPi2ClxGofl3ZXUfFr7IGT4/ihzXOa5FfqL38h5TBwmSJZ3XB8DYUtiK5jXzUQddLnmDB94=
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com (20.179.35.149) by
 AM0PR08MB3058.eurprd08.prod.outlook.com (52.134.93.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Fri, 21 Dec 2018 10:01:06 +0000
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db]) by AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db%5]) with mapi id 15.20.1446.020; Fri, 21 Dec 2018
 10:01:06 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v3 9/9] MAINTAINERS: Add maintainer for arm komeda driver
Thread-Topic: [PATCH v3 9/9] MAINTAINERS: Add maintainer for arm komeda driver
Thread-Index: AQHUmRQWeovHOOq9j0aufyIPqdEpbA==
Date:   Fri, 21 Dec 2018 10:01:06 +0000
Message-ID: <20181221095757.15510-10-james.qian.wang@arm.com>
References: <20181221095757.15510-1-james.qian.wang@arm.com>
In-Reply-To: <20181221095757.15510-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SY3PR01CA0099.ausprd01.prod.outlook.com
 (2603:10c6:0:19::32) To AM0PR08MB4483.eurprd08.prod.outlook.com
 (2603:10a6:208:145::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3058;6:UPRvTBGoaQwThxYNSeZIywK2rFBaJ0V8uepOBgmMDevXTpBuQKfuvWNYJzw1hKWVcva14gZzPviDxq/+54ho5wpurhQvoaL2SoXNxZVWhrweaUSb7lCvqfDItLuLyOWWQYYWLnpm0Z0bnUp7gcKzLFPF6vo8Im+zJtrWGZcyo56lqVTAKtXhbaT29nCgesylw+EG+84KEoUDvDJNC+0Odd18vWJ3m+4AAsD8ra8K2TPxHEgIv3bELSybaufQBR1gypMkHmFjdV3CkW7d+fpzxIZ6/xsvAvFzBqXb9W7aTt+Oe3W9fgMyX9HUjEAUcFUZAWWkPpEbYUntdXZ3PL655yCm/c4VYsX6Wj1vP6Tu8Jw/zNRCuO6nuhruB1NTl4twqVWwM+nufJoTGXA8UIJQ1VD1W6Ny00qRvQYPOuL1+uNx5guUGXyzwbC1KGx56Gf6ZfKzFZXuGN9yyAIl9FyyHg==;5:2TISLkKKZZo2kCsXTPHOYmQsGisaCeHCC2ioY/UjAe0VAOv5o7Ir+iHmhBp40G6jQ5kRnntfdTSjb5mZK3sa0+F3lqJf9fnF8UPzyHtP22iZMt70uvu0BQ2OnPT61kel3tXOUH0cKIlGzy7Umatgzxh66gB5a522e7TCB07a9oA=;7:hAuN8kQDqif7ER3Dt2KG3cvXDuo6wryLGlXhxANI+lKmp9u2NG1xBGlr2mctQViXDqS4ACrlugxOcZHnZ6WNasDYfGmCgHDwpV/Wo5OHRdX/BZEceksHOT+L3jj2oKPlEp0q0vwifKwLOhpB5OR52w==
x-ms-office365-filtering-correlation-id: c922a986-7756-4737-fdbc-08d6672b3905
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3058;
x-ms-traffictypediagnostic: AM0PR08MB3058:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB305880B5089F8BFCB7266FCBB3B80@AM0PR08MB3058.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(8220043)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3058;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3058;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(396003)(39860400002)(376002)(189003)(199004)(54906003)(25786009)(478600001)(99286004)(103116003)(476003)(11346002)(2616005)(53936002)(66066001)(8936002)(36756003)(81156014)(81166006)(446003)(71200400001)(71190400001)(14454004)(6512007)(6346003)(316002)(186003)(6636002)(6862004)(26005)(37006003)(486006)(256004)(86362001)(14444005)(3846002)(52116002)(55236004)(6506007)(4326008)(386003)(102836004)(2906002)(76176011)(6486002)(7736002)(6436002)(7416002)(68736007)(105586002)(5660300001)(97736004)(8676002)(305945005)(106356001)(1076003)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3058;H:AM0PR08MB4483.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-microsoft-antispam-message-info: BgXntodmd/AdvDoc2QEOjTmsFvUGuZQdVhU+2AV2M0ZX1yvgMR36Onz7DG+dSDfbOboSLspKdRiAWBl7D4AvdRweye3mGbtTCZ5N7+j6CdVmEaHsWZpcJ1Aq/QSIZoxelwalaUGqOAqC9ZwIuhpULGvID6VIWMzvYWt8jjUYVli6p2oL0mBELAFdp3mXMOsBZaYS9Cngw8HPxbsg0T3h+rXYv2lpUPLKTUtEaUnDHjfujhoWqlJv7YHjsTI5YrujmhHQH55Nx06/Tz1XOzur3uleODVZcKbCHREbt/4Swb7ThSQY5NgtupLd6uDfdUaz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c922a986-7756-4737-fdbc-08d6672b3905
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 10:01:06.2235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: Adjusted the position of KOMEDA by alphabetical order

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 254b7b267731..e48c2e5fd29f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1124,6 +1124,15 @@ S:	Supported
 F:	drivers/gpu/drm/arm/hdlcd_*
 F:	Documentation/devicetree/bindings/display/arm,hdlcd.txt
=20
+ARM KOMEDA DRM-KMS DRIVER
+M:	James (Qian) Wang <james.qian.wang@arm.com>
+M:	Mali DP Maintainers <malidp@foss.arm.com>
+S:	Supported
+F:	drivers/gpu/drm/arm/display/include/
+F:	drivers/gpu/drm/arm/display/komeda/
+F:	Documentation/devicetree/bindings/display/arm/arm,komeda.txt
+F:	Documentation/gpu/komeda-kms.rst
+
 ARM MALI-DP DRM DRIVER
 M:	Liviu Dudau <liviu.dudau@arm.com>
 M:	Brian Starkey <brian.starkey@arm.com>
--=20
2.17.1

