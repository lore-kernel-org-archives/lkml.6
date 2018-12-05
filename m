Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7F7C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B46206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="D5il5Yne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B46206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeLEKUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:20:22 -0500
Received: from mail-eopbgr10051.outbound.protection.outlook.com ([40.107.1.51]:60424
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726909AbeLEKUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuPiKBnI/8Q/KApuo5mF1IzRYVFUKEXJkkSI8HYXsis=;
 b=D5il5YnegEjYPYaoV7ouS5aMiytvw2YUIf+4AfYio2cIwKbTaeEtclcXV3HTFevNsZDtlg7vXRBuBH6BPlZNISz2aUqRnxJ5sp1rE7J/3lRhj+mLHuvgvKJDwP9VO9rAP2fFlcyv+jcHffUeWhug9ZcHY2dSbHZBD0jp8zMUXIY=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0644.eurprd08.prod.outlook.com (10.163.188.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 5 Dec 2018 10:20:13 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::38d5:d5ee:b90c:901c]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::38d5:d5ee:b90c:901c%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 10:20:13 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        nd <nd@arm.com>, Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v1 9/9] MAINTAINERS: Add maintainer for arm komeda driver
Thread-Topic: [PATCH v1 9/9] MAINTAINERS: Add maintainer for arm komeda driver
Thread-Index: AQHUjIQbKMr93tXBlkCa4E/cbgjDyg==
Date:   Wed, 5 Dec 2018 10:20:13 +0000
Message-ID: <20181205101635.7696-10-james.qian.wang@arm.com>
References: <20181205101635.7696-1-james.qian.wang@arm.com>
In-Reply-To: <20181205101635.7696-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYCPR01CA0014.ausprd01.prod.outlook.com
 (2603:10c6:10:31::26) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0644;6:XPMSe6C69YlCt9AQyABMVdspOzKm7L6nFYEBGAIGg0TT4zmYHmNJMNnRdbiII9EfpCMNLpR/eOB2baOvib5grVobhIKHGdTA5d/sQHrR0RwtTH/w2/owJWAW89cWJr54QyK1xq8vrf9H0p1YeGEexysfZqpamlrjlb3G7eKTTUCANvs2tpJMdPHC1rXt4+OuXBAR9WlJ7wD2eLZ+gETKwsHT83uuL3YgRakCYYBVz3JeJRsCovKUrl8HZIed/qL2lhTTtEmIVie0Z2LmsJlsGg64p1bOWY2FX3GYkaHGLWfSyjd88ytD5UjUSY021+DNa2+Sngk1hLNpV/btBKT+wQpC2EcMQZ74dDxnye7sHAeL9DrT75bEFVTAj6Ru5Ec0X2aqhcBW6WrcERdZq1NZKRB1d2KRtZblLW40UjCHagw6+HhQMiAJvg/w7v8qip/jIsfw9tuzO0BPxNXX862XYA==;5:aX2kAZONQhs4vD3fHGElujZ1qLkkOqqS+YxwMzeXlYk3iRSdSaVmbvd1zur2ac0A3XWLpJN4jW3kSKmFQv5pQRrOx9VnRiiXvP51uqwh/aPdUF6PzaOGGFu3Uh4WNLesqNXvcfxJEHEObwaR1Nv9wZ5s1LSmvJV7HPAxH1w3rXs=;7:oosycfY2oY7pCwi0BmW9xeydClRh8E9ZAeIhTMlKRw3YqfYD54FaGvyEF+220YlAvnZh5jNnz5MAjKiCSNvV+5WfSDIS2QknbrTTt3gtgiTRfi5htlMXrO/lVe/BCkqvR+Nqi4kLqhe/sNbQ8TUr9Q==
x-ms-office365-filtering-correlation-id: 95f53ba0-b7dc-498e-0837-08d65a9b3e00
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0644;
x-ms-traffictypediagnostic: AM3PR08MB0644:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB0644287D2BFDE9EAEE1BDD86B3A80@AM3PR08MB0644.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0644;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0644;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(189003)(199004)(305945005)(6506007)(55236004)(8676002)(2906002)(6636002)(5660300001)(68736007)(102836004)(86362001)(71200400001)(71190400001)(66066001)(386003)(36756003)(1076002)(3846002)(6116002)(26005)(256004)(186003)(14454004)(99286004)(486006)(11346002)(6436002)(476003)(446003)(6486002)(6862004)(4326008)(6512007)(53936002)(76176011)(478600001)(103116003)(52116002)(37006003)(8936002)(105586002)(106356001)(54906003)(2616005)(97736004)(25786009)(316002)(81156014)(81166006)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0644;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zGfQtiewGJgmWe2nC3HJW1D5pYlM6JcPI011ibQLiptz4dUbLFNrQM+gykp7ZAJw+fstytLV3IWhM5j1s25B7CIpNfPL7paEriuMxeNuyULqfQfEHGtBqcn5G07EV9IQCm1JUJd519ooe69fm1+ppRVXIjLzoDS3R+xcwvr22XRr+SQPri+iBDqxyrQU4iGKLJg4yW4xo+dOWSS0yRvJIseNXEa4EJ3gIEmCelniEu0C7EZcFWMPBLtl3qCVIKNenUEBcP1UGwEJjzoR6eOFFl6l5darXtA5akhIqB/rpv/mPrhdPIic6wQpR2QEzM0gjabC5p7HaTM4W9fPSAk48hIPe3JwYWXGxchD8nrM5U4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f53ba0-b7dc-498e-0837-08d65a9b3e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 10:20:13.1058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0644
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 254b7b267731..9e44c2c2e234 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1132,6 +1132,14 @@ S:	Supported
 F:	drivers/gpu/drm/arm/
 F:	Documentation/devicetree/bindings/display/arm,malidp.txt
=20
+ARM KOMEDA DRM-KMS DRIVER
+M:	James (Qian) Wang <james.qian.wang@arm.com>
+M:	Mali DP Maintainers <malidp@foss.arm.com>
+S:	Supported
+F:	drivers/gpu/drm/arm/display/komeda
+F:	Documentation/devicetree/bindings/display/arm/arm,komeda.txt
+F:	Documentation/gpu/komeda-kms.rst
+
 ARM MFM AND FLOPPY DRIVERS
 M:	Ian Molton <spyro@f2s.com>
 S:	Maintained
--=20
2.17.1

