Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE29BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6EC2184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="LEt6jBn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbeLSMfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:35:12 -0500
Received: from mail-eopbgr10081.outbound.protection.outlook.com ([40.107.1.81]:32874
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729668AbeLSMfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJWRgTF4g2QQ6s9jrcWi1CBJPLpMXxgxCCvhb6MzZoA=;
 b=LEt6jBn+o0W8KYs9JF5SWv0qLEGayqse3jD2DFe4lgTJ/gyJGdpJhKm3VsmUNhoJIFA5tspogT6m9S4rHAlJaUp267JvErNTfCeGlO8+YklmtggN1pdFr2fbBm7mmrXvdgPTszN4VGVgYbXTjhFOyQjsLp+pLxDeJsy+FHgWiiU=
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com (20.179.35.149) by
 AM0PR08MB3924.eurprd08.prod.outlook.com (20.178.118.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 19 Dec 2018 12:35:06 +0000
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db]) by AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db%5]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 12:35:06 +0000
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
Subject: [PATCH v2 9/9] MAINTAINERS: Add maintainer for arm komeda driver
Thread-Topic: [PATCH v2 9/9] MAINTAINERS: Add maintainer for arm komeda driver
Thread-Index: AQHUl5dFEZUdiiZ+CUC5gvYOlorXuQ==
Date:   Wed, 19 Dec 2018 12:35:06 +0000
Message-ID: <20181219123147.16090-10-james.qian.wang@arm.com>
References: <20181219123147.16090-1-james.qian.wang@arm.com>
In-Reply-To: <20181219123147.16090-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYBPR01CA0132.ausprd01.prod.outlook.com
 (2603:10c6:10:5::24) To AM0PR08MB4483.eurprd08.prod.outlook.com
 (2603:10a6:208:145::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3924;6:36qgeKcFBHUTGyHQE+DscnIRk0tZGc3Xinxd1CBEtFb/+5lfbqCURsOrzD+FUXBZsC5s/52zFg/gJd+4Ncjwd9Xus/Edw3kjPXxxrUT0/5PnFjDQSNA7P6ls+8yNRz5tBpQGN8ebDBnZw03awnFNhlz7uJ75lUzuqf0kiE+qxjoNZd9ZEVIwPM8M09oDwSKIF/v0hroK6bT/mKsgj23X3O94CyGI9J9tD+XAsHIBj/5P18FLFkkNHZpxyN35e+zrjx40s3xIO948wepsbMV8e74SHN8mh+Qx3XPCFdOiKXFUAbikLwFV5Ss0uPm9YSEG2cSRdT1KoIdFOQCQ48h4j29DBJxW45V2RTmmWwjyMOKST6YyFN9IeJ7/JpoL3zbnZwBWmSsf2H708UOsitEy1uWyNKk1qL+fBg4HI3vE5JN+v1M8mzVmeGem1bmxbO844hx/cOweAUaF1fWEzoTJOg==;5:GQqAzYwjbhHYSd+t9M5LeNQhuZ2lgLeyb5vYQ/RV/ffR6MlXPqn9FiRZUtZuZmRzx5ZXJV1jGYPc8MyRbmwypjOvbTauW9kVcdJFnuHymfRSI1ow9RaWFjjHZfkqoFtEDPaieEEuP3coGvbxuN1y4g+jrewcrpgTDOQFbRATiAY=;7:GTpbXywrUfYjfF9q2LlffzhmM6FOIFIroDOjdvyPBQU1gEA19bPC4DxUIX0PW5z8I6GgGfkXnz4DAOFWblC9Eu57NlH+RnwLWi9exU5/ZGlJyeduFh0nrqeAS1o5K8uYjd5sWDygWZb+Mh4fvmRUzg==
x-ms-office365-filtering-correlation-id: 274287e4-5f2f-43a3-7c1d-08d665ae67d3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3924;
x-ms-traffictypediagnostic: AM0PR08MB3924:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB39241CDBE5F0FC0680B3E2ACB3BE0@AM0PR08MB3924.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3924;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3924;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(366004)(376002)(199004)(189003)(316002)(8936002)(103116003)(37006003)(1076003)(71190400001)(81166006)(81156014)(11346002)(446003)(97736004)(36756003)(54906003)(256004)(2616005)(486006)(6636002)(99286004)(71200400001)(476003)(86362001)(14444005)(8676002)(106356001)(105586002)(5660300001)(3846002)(7416002)(6116002)(14454004)(68736007)(6512007)(2906002)(4326008)(25786009)(6486002)(76176011)(52116002)(53936002)(186003)(55236004)(102836004)(26005)(6862004)(6436002)(305945005)(478600001)(6506007)(66066001)(386003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3924;H:AM0PR08MB4483.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: R2ZhF+8fjoPNqoWczzymZAK5xAbxtOCAAfPwpCXch3TzEZofMhxsdz32zvfdh66cSSJV++6MTsynQedu9XngwMztZFqX47AeIX9LTEdBBvHBPl/whi8rDVYynmgTIp3WRiNk7qJuI+CTk0mZ3dnjsHhw+wKl2gvgyOrbvVv92cI91uc+QGOHLBzicCvwCABLjvg04CpPWzNJYphAuZnFpjjVo7FZYWjAKolSzzoOrMv10lVgeFvBebpGPi7ZvasVdO8TSgigGahnbSLi2IfIRFGaEwbk1tDPd3/WAakY29R4gXkj9v88vTMPx4oAIq6V
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274287e4-5f2f-43a3-7c1d-08d665ae67d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 12:35:06.5525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3924
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

