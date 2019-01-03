Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B3EC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED9B206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Uf3+UjKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbfACLmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:42:12 -0500
Received: from mail-eopbgr10058.outbound.protection.outlook.com ([40.107.1.58]:1155
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726170AbfACLmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iA5sGs6XmSLHmNu7BLQErLDjwbrJrPRKrF8JdsgpVs=;
 b=Uf3+UjKFCJIvPHcvPZMQ7QyFcIwcvOlFTbZawMOyDHTpqqe3SDWA+GrFw9uIibWE9cn+5shZAehQgvthhDwItnKWOLXKy9PBDvPHCdDAcgmC+ZqFP40BD4WWwItlixa6z6Ri20DK8L09e9Yz5030majZ1NQbEG3SNbVSSdAXB7I=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0181.eurprd08.prod.outlook.com (10.161.35.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 11:42:05 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 11:42:05 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
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
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v4 9/9] MAINTAINERS: Add maintainer for Arm komeda driver
Thread-Topic: [PATCH v4 9/9] MAINTAINERS: Add maintainer for Arm komeda driver
Thread-Index: AQHUo1lZaveXT81rrU6N19+HR0vp1Q==
Date:   Thu, 3 Jan 2019 11:42:05 +0000
Message-ID: <20190103113841.15403-10-james.qian.wang@arm.com>
References: <20190103113841.15403-1-james.qian.wang@arm.com>
In-Reply-To: <20190103113841.15403-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SY2PR01CA0046.ausprd01.prod.outlook.com
 (2603:10c6:1:15::34) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0181;6:0IpefxeJySJnNN0Fwqi0vArbByaAPcW+0xsmWRU3kzzsTDBp4njVRNlkjO8vuu1R7oLlkk4yxZ0S1h176EjPztveuNKL3/mwPdPXF29NdZ6owQvdpnRVL16vpE4YmU5JFN51db3B0M4a5TmpADN9XxA7TRWzTa+ini88qdbGC+xvFvuHB/7v7Pp/9PKPE8wVqFm7Dtj9QnWs4Uapxj6r54+ivMwVTzaFN3ywNwUaoaCkM684DH1HPjvk263UI3qxTfw/dbKsQt8MXCCvhhTnR3oyVVn8ehkgcXq/g5AvUTp8BBcJ+woNz+QQjuzQPBjFmn3KYNCutgl74vGPewkSw9O9e3lHnZRrAF0+UBz4v58izhIz4zcfSLMcNUeYucsj6urWfEGj2mJNIk1fEz5i3hOQxFEpIWxtCrgg0WZxA3ntgsoF0WM/Qov3fXFvBxmCWhTK94d20fYjc0gu/ab9kg==;5:HrdqR7lzBsgr4F3bYipY1+FR97j9mTZVeccEXQacQ+NpNGyd1Eo8pIL5GJFcxojWNNNWWwtR7yRZ8Rf7+zBmvAK7/opMSw4MMyUuK9CroURXdEMOMvn/JozQvBMmusftavaKrvHTsuXLvzONXDK3rDt6mDUcm6+QsLYVuCVyb/1DYMIyyW468Qazyi4DxH7TKlljx6Q4HjoUPUmqXVKXiA==;7:UBjoOAZoUSCqCacpv5gKpxeMbyTsWWnHar5B4GyEH0gMzJlxNdH09D3Uv4Q/lUVNl/8nJYzSGVDEQ0NDnXDQy8arLZQgCtMSG2PnGUWSdsXKY41qzdmuwxvDXZWam2GzLn/MJPUiYeNTlSQ+59vhcA==
x-ms-office365-filtering-correlation-id: c5a4907e-b5a4-4421-4b15-08d671707bfc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0181;
x-ms-traffictypediagnostic: AM3PR08MB0181:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB01812817E1B95D49C2C9F87BB38D0@AM3PR08MB0181.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0181;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0181;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(396003)(136003)(199004)(189003)(6436002)(6486002)(1076003)(68736007)(2501003)(66066001)(6512007)(103116003)(36756003)(106356001)(105586002)(11346002)(478600001)(97736004)(14454004)(486006)(476003)(4326008)(2616005)(14444005)(256004)(386003)(86362001)(6506007)(7736002)(102836004)(316002)(446003)(2201001)(8936002)(26005)(7416002)(3846002)(81156014)(99286004)(2906002)(6116002)(81166006)(71200400001)(186003)(71190400001)(52116002)(76176011)(25786009)(5660300001)(8676002)(305945005)(54906003)(110136005)(53936002)(55236004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0181;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TBduZjMkCgiFCZFQWt2KLvSMdplgJeC3Usi6rys8J9dAP4yJ4sI4U5QqqSUFAvdujapvlzYGLfJhMXT2onXhezgQvWrgezZ1ynZVF65vXFqn44tKlwKqjfFIGyuuacYDvQnGU/7eg2vN14lOHkY4Ialwnjispw9VV/p6TmQANUhjyq8T6w77HSXdXqi4lhxqixyABYOPKwa0ZTo2BkX6ph+CelnpIzkgCEYt0OT60+V0IX0+tSTmGB/PFeNJPAifUjxoCKj9x725drM7FUE2f8u6vRcuKV53lGuGcBfW2dVxBdti77uFavcnxkuFIDl3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a4907e-b5a4-4421-4b15-08d671707bfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 11:42:05.5926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

v4: Added git tree [Daniel Vetter]
v2: Adjusted the position of KOMEDA by alphabetical order

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 254b7b267731..87c7a6972279 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1124,6 +1124,16 @@ S:	Supported
 F:	drivers/gpu/drm/arm/hdlcd_*
 F:	Documentation/devicetree/bindings/display/arm,hdlcd.txt
=20
+ARM KOMEDA DRM-KMS DRIVER
+M:	James (Qian) Wang <james.qian.wang@arm.com>
+M:	Mali DP Maintainers <malidp@foss.arm.com>
+S:	Supported
+T:	git git://linux-arm.org/linux-ld.git for-upstream/mali-dp
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

