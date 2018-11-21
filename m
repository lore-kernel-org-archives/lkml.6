Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74384C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13ABE214C1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="gVqjp1oA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13ABE214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbeKVCil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:38:41 -0500
Received: from mail-eopbgr60123.outbound.protection.outlook.com ([40.107.6.123]:9504
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730072AbeKVCil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hCbkP0OU33tpnx81lbICyxZ/Z0LNdO6oF4PUDRmUvU=;
 b=gVqjp1oAnMipEJi6Z72qoaJUAWv2u8MKRllQX7nKmjxM0YcDdGSEucTOH6DaKnSctSrmBPBHeeACoXIccCp7GBNFUY6O66oQIPHyWRSeJQ67tskEmo3UFUSVVhvdplJD1/jgp5fsfZQkhTS4N5VWzQrJX27BxBm3T8oqsZczsdg=
Received: from AM5PR0201MB2451.eurprd02.prod.outlook.com (10.169.244.8) by
 AM5PR0201MB2275.eurprd02.prod.outlook.com (10.169.242.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Wed, 21 Nov 2018 16:03:35 +0000
Received: from AM5PR0201MB2451.eurprd02.prod.outlook.com
 ([fe80::7d9b:e9c1:14e6:b72a]) by AM5PR0201MB2451.eurprd02.prod.outlook.com
 ([fe80::7d9b:e9c1:14e6:b72a%3]) with mapi id 15.20.1294.048; Wed, 21 Nov 2018
 16:03:35 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: [PATCH 0/2] hwmon: (ntc_thermistor) sort thermistors
Thread-Topic: [PATCH 0/2] hwmon: (ntc_thermistor) sort thermistors
Thread-Index: AQHUgbPBWIPJBM4h6kesNnT6GCV0vA==
Date:   Wed, 21 Nov 2018 16:03:35 +0000
Message-ID: <20181121160327.16772-1-peda@axentia.se>
References: <b732b7e0-0076-9cb3-a146-4d0cd80d2658@roeck-us.net>
In-Reply-To: <b732b7e0-0076-9cb3-a146-4d0cd80d2658@roeck-us.net>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0402CA0042.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::31) To AM5PR0201MB2451.eurprd02.prod.outlook.com
 (2603:10a6:203:35::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0201MB2275;6:2iHMpVaofNvGd/HJPbiotQzGu+zsN2Ae0IFO8zOTCft0JbQQP9/OuER2HgrjQUgcqFHCVK+Z+8zja25E77bSVHJpvaZxpsYkaqwoddGeFcAi2yBQIZnAwZlw3MtE/wD6Fwm5TA06LSbMiQFqWrx7a4OeH1bhiEwdfxKblITO+ehwlNBIJBy/b/MORXyqvnV1Y8Dfs/sxR8Tf9fSdBWBsey4pFz5GdWmsPvfscgWJHoWIY7qyjf20SaGh546MkROGLeL6UvXMANiUtTHPK9K6q1P0kcooEL2D+g5dVB11n+UbfRbmRh45eW/H808q61jriUcVTRp7GNYbtPtTfou/d3UwvBkodpgjVrCfgZe8zXQoMC5fGGc+ewBUXBPKUJYxKHS2LVMVyppQaPOr5ZIiID2xhuixN65sDTdQq4dCfvaDUL2F061+jooG8qFIb6hm9rHpPtTdCsBusw8lGa7UHA==;5:PEahkBBegkS9BgR0bAnf3mxjUzELPKc12zaXK4cKnYjvYY24jrIyFbO4y2AvwACCfmhZHa9jHCwnmZE9Loo+7PachpgPk4n3KwUz82ElhZSentcFGWvYvtpb+CQ2MHrB1EryzYV45+kF8WC+1uQboeBh+IdV1oDPNk1bvO1L84U=;7:cd5wHfvqimzM61tGKgNkQvW7AFsuazi51KBCas2cuZw5A0MbNG/CBiPeOZHcU5IUmlumIzFVPdPTY1Mfb4RrtOCTezOXJJCo/Ypgm7TxQZZC0yNk9EE06jbbI/5fMEPvoreSDCAIPvZ9mMoLEAx5aA==
x-ms-office365-filtering-correlation-id: 1474c33b-3de8-46c0-9390-08d64fcae3e7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2275;
x-ms-traffictypediagnostic: AM5PR0201MB2275:
x-microsoft-antispam-prvs: <AM5PR0201MB2275C622FA023EBABBFD328EBCDA0@AM5PR0201MB2275.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231442)(944501410)(52105112)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM5PR0201MB2275;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2275;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39830400003)(396003)(366004)(376002)(136003)(189003)(199004)(99286004)(14454004)(52116002)(76176011)(8676002)(81156014)(2900100001)(5640700003)(2501003)(81166006)(68736007)(53936002)(2351001)(106356001)(86362001)(11346002)(2616005)(476003)(256004)(6512007)(4326008)(316002)(6306002)(6916009)(6486002)(1076002)(508600001)(3846002)(6116002)(74482002)(71200400001)(54906003)(50226002)(66066001)(71190400001)(2906002)(305945005)(36756003)(102836004)(6506007)(7736002)(97736004)(446003)(486006)(8936002)(6436002)(105586002)(25786009)(386003)(966005)(26005)(186003)(5660300001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2275;H:AM5PR0201MB2451.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EgSNUXjJThgLJb8Fat49CeoRCyRM5S+QbX/HYcqYKYv5whFIm7IWy7wNOc54iYLi/cSyAs+S8KIWmhvaperIDzTa5MVoBcpHzJXwMWvSWTrFbELrb/Ao12wwqAC0W2eOBVjYBi/r1DFlhhniGM8WYTWl2IKXt9wPvOqdgoYMJtcIhAJGbFhTqa2aOJwYJ5Ku5K6xAovIfOQKfx8u8ivTNdBFDIL0HQdT7hT6RZis1KETobMvJeGkA+301zKQFOlCz+2M4nsuMTsOVYdtSWjT33W31lW2EZ4ssDZSNkEd/4N4KBFI3zB0TVrDIa+QFPzjmDnoff4d5USXaIo04N+dA8IOeEK+LA/T2h3GzwojKSM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 1474c33b-3de8-46c0-9390-08d64fcae3e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 16:03:35.3483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2275
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

These patches are on top of https://patchwork.kernel.org/patch/10687455/
("hwmon: (ntc_thermistor): add support for B57891S0103 from Epcos")

I suspect the bots will be confused since that patch is not applied yet.

Also, patch 2 of this series has a false positive check-patch issue [1].
At least with my copy of check-patch. I suspect check-patch warns about
the macro in case it is ever used to something other than to initialize
an array, but I fail to see how that would be possible and am therefore
ignoring the issue.

Further, check-patch warns about patch 1 since I appear to add DT
compatibles that are not documented. But of course, I'm not adding them,
I'm just moving them about, so I'm ignoring that too.

Cheers,
Peter

[1] check-patch output is as below

CHECK: Macro argument reuse 'compensation' - possible side-effects?
#28: FILE: drivers/hwmon/ntc_thermistor.c:323:
+#define NTC_TYPE(ntc, compensation) \
+[(ntc)] =3D { .comp =3D (compensation), .n_comp =3D ARRAY_SIZE(compensatio=
n) }


Peter Rosin (2):
  hwmon: (ntc_thermistor) sort thermistor id lists alphabetically
  hwmon: (ntc_thermistor) use a table to lookup the thermistor type

 drivers/hwmon/ntc_thermistor.c               | 129 +++++++++++++++--------=
----
 include/linux/platform_data/ntc_thermistor.h |   6 +-
 2 files changed, 73 insertions(+), 62 deletions(-)

--=20
2.11.0

